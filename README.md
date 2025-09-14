# 📚 Sistema de Gerenciamento de Livros

Este é um sistema desenvolvido em **Ruby on Rails** com foco em autenticação e autorização.  
O projeto utiliza as gems **Devise** (para login e cadastro de usuários) e **Pundit** (para controle de permissões), garantindo segurança e organização nas regras de acesso.

---

## 🚀 Tecnologias utilizadas
- Ruby on Rails
- Devise (autenticação)
- Pundit (autorização por roles)
- SQLite 

---

## 🔑 Funcionalidades

### Autenticação (Devise)
- Cadastro de usuários
- Login e logout
- Recuperação e edição de senha
- Sessão persistente

### Autorização (Pundit)
- **Usuário comum**
  - Visualizar livros disponíveis
  - Consultar seus empréstimos
  - Editar sua própria conta
- **Administrador**
  - Criar, editar e excluir livros
  - Gerenciar todos os livros cadastrados
  - Acompanhar empréstimos de todos os usuários
  - Editar sua conta

---

## 🖥️ Interface

- Menu lateral dinâmico de acordo com o tipo de usuário:
  - **Usuário comum:** Meus Livros | Meus Empréstimos | Editar Conta
  - **Administrador:** Novo Livro | Gerenciar Livros | Empréstimos | Editar Conta
- Mensagem de boas-vindas exibindo o e-mail logado
- Botão de sair no canto superior direito

