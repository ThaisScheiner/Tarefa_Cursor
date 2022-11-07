create database bd_cpf
use bd_cpf

create table envio 
(
CPF varchar(20),
NR_LINHA_ARQUIV	int,
CD_FILIAL int,
DT_ENVIO datetime,
NR_DDD int,
NR_TELEFONE	varchar(10),
NR_RAMAL varchar(10),
DT_PROCESSAMENT	datetime,
NM_ENDERECO varchar(200),
NR_ENDERECO int,
NM_COMPLEMENTO	varchar(50),
NM_BAIRRO varchar(100),
NR_CEP varchar(10),
NM_CIDADE varchar(100),
NM_UF varchar(2)
)

create table endereço
(
CPF varchar(20),
CEP	varchar(10),
PORTA	int,
ENDEREÇO	varchar(200),
COMPLEMENTO	varchar(100),
BAIRRO	varchar(100),
CIDADE	varchar(100),
UF Varchar(2)
)

create procedure sp_inserir_endereco(@cpf int)
as
	declare @linha int,
			@dt_envio datetime,
			@endereco varchar(100), --tabela endereco
			@porta int

	declare cur cursor for
		select nr_linha_arquiv, dt_envio from envio where cpf = @cpf
	open cur
	fetch next from cur into @linha, @dt_envio 
	while @@fetch_status = 0 
	begin
	

		declare cur2 cursor for
			select distinct porta, endereço from endereço where porta = @linha
		open cur2
		fetch next from cur2 into @porta, @endereco
		while @@fetch_status = 0
		begin
		
			update envio
			set nm_endereco = @endereco
			where cpf = @cpf
				  and nr_linha_arquiv = @porta
		fetch next from cur2 into @porta, @endereco
		end
		close cur2
		deallocate cur2


		fetch next from cur into @linha, @dt_envio
	end
	close cur
	deallocate cur
	
	
end