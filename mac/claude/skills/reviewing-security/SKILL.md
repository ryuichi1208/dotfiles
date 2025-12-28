---
name: reviewing-security
description: "OWASP API Security Top 10 (2023) と Rust セキュリティベストプラクティス。脆弱性検出。Use when: セキュリティ、脆弱性、OWASP、認証、認可、監査を依頼された時。"
---

# セキュリティレビュー

OWASP API Security Top 10 (2023) と Rust セキュリティベストプラクティスに基づくレビュースキル。

## OWASP チェック項目

| ID | リスク | チェック内容 |
|----|-------|-------------|
| API1 | BOLA | tenant_id 検証、file_id との組み合わせ検証 |
| API2 | Broken Auth | gRPC メタデータ認証 |
| API3 | Property | レスポンスの不要情報 |
| API4 | Resource | ファイルサイズ制限、ページネーション |

## Rust セキュリティ

| 項目 | 検索パターン |
|-----|-------------|
| 依存関係脆弱性 | `cargo audit` |
| unsafe コード | `grep -rn "unsafe {" src/` |
| ハードコード認証情報 | `grep -rn "(password\|secret\|api_key)" src/` |
