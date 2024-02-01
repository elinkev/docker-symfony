<?php

$finder = (new PhpCsFixer\Finder())
    ->in(__DIR__.'/app')
;

return (new PhpCsFixer\Config())
    ->setRules([
        '@PSR12' => true,
        'array_syntax' => ['syntax' => 'short'],
        'cast_spaces' => true,
        'no_blank_lines_after_class_opening' => true,
        'trailing_comma_in_multiline' => true,
        'binary_operator_spaces' => true,
        'concat_space' => ['spacing' => 'none'],
        'blank_line_before_statement' => true,
        'ordered_class_elements' => true,
        'function_typehint_space' => true,
        'no_unused_imports' => true,
        'single_quote' => true,
    ])
    ->setFinder($finder)
;
