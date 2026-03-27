local M = {}

function M.make()
	local caps = vim.lsp.protocol.make_client_capabilities()

	caps.textDocument = caps.textDocument or {}
	caps.textDocument.codeAction = caps.textDocument.codeAction or {}
	caps.textDocument.codeAction.dynamicRegistration = false
	caps.textDocument.codeAction.isPreferredSupport = true
	caps.textDocument.codeAction.disabledSupport = true
	caps.textDocument.codeAction.dataSupport = true
	caps.textDocument.codeAction.honorsChangeAnnotations = false
	caps.textDocument.codeAction.resolveSupport = caps.textDocument.codeAction.resolveSupport or {}
	caps.textDocument.codeAction.resolveSupport.properties = { "edit", "command", "data" }
	caps.textDocument.codeAction.codeActionLiteralSupport = caps.textDocument.codeAction.codeActionLiteralSupport or {}
	caps.textDocument.codeAction.codeActionLiteralSupport.codeActionKind = caps.textDocument.codeAction.codeActionLiteralSupport.codeActionKind
		or {}
	caps.textDocument.codeAction.codeActionLiteralSupport.codeActionKind.valueSet = {
		"", -- any
		"quickfix",
		"refactor",
		"refactor.extract",
		"refactor.inline",
		"refactor.rewrite",
		"source",
		"source.organizeImports",
		"source.fixAll",
	}
	caps.textDocument.completion = caps.textDocument.completion or {}
	caps.textDocument.completion.dynamicRegistration = false
	caps.textDocument.completion.completionItem = caps.textDocument.completion.completionItem or {}
	caps.textDocument.completion.completionItem.snippetSupport = true
	caps.textDocument.completion.completionItem.commitCharactersSupport = true
	caps.textDocument.completion.completionItem.deprecatedSupport = true
	caps.textDocument.completion.completionItem.preselectSupport = true
	caps.textDocument.completion.contextSupport = true
	caps.textDocument.completion.insertTextMode = 1
	caps.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
	caps.textDocument.completion.completionItem.tagSupport = caps.textDocument.completion.completionItem.tagSupport or {}
	caps.textDocument.completion.completionItem.tagSupport.valueSet = {
		1, -- Deprecated
	}
	caps.textDocument.completion.completionItem.insertReplaceSupport = true
	caps.textDocument.completion.completionItem.resolveSupport = caps.textDocument.completion.completionItem.resolveSupport or {}
	caps.textDocument.completion.completionItem.resolveSupport.properties = {
			"documentation",
			"additionalTextEdits",
			"insertTextFormat",
			"insertTextMode",
			"command",
	}
	caps.textDocument.completion.completionItem.insertTextModeSupport = caps.textDocument.completion.completionItem.insertTextModeSupport or {}
	caps.textDocument.completion.completionItem.insertTextModeSupport.valueSet = {
		1, -- asIs
		2, -- adjustIndentation
	}
	caps.textDocument.completion.completionItem.labelDetailsSupport = true
	caps.textDocument.completion.completionList = caps.textDocument.completion.completionList or {}
	caps.textDocument.completion.completionList.itemDefaults = caps.textDocument.completion.completionList.itemDefaults or {}
	caps.textDocument.completion.completionList.itemDefaults = {
		"commitCharacters",
		"editRange",
		"insertTextFormat",
		"insertTextMode",
		"data",
	}
	caps.textDocument.hover = caps.textDocument.hover or {}
	caps.textDocument.hover.contentFormat = { "markdown", "plaintext" }
	caps.textDocument.signatureHelp = caps.textDocument.signatureHelp or {}
	caps.textDocument.signatureHelp.signatureInformation = caps.textDocument.signatureHelp.signatureInformation or {}
	caps.textDocument.signatureHelp.signatureInformation.documentationFormat = { "markdown", "plaintext" }

	caps.textDocument.foldingRange = caps.textDocument.foldingRange or {}
	caps.textDocument.foldingRange.dynamicRegistration = false
	caps.textDocument.foldingRange.lineFoldingOnly = true

	caps.general = caps.general or {}
	caps.general.positionEncodings = { "utf-16" }

	return caps
end

return M
