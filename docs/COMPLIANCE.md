# DeelMarkt — Trust, Security & Legal Compliance

> Everything related to trust, safety, security, and regulatory compliance in one place.

---

## Trust Architecture

Trust is not a feature — it is the product.

### Progressive KYC

| Level | Trigger | Requirement | Access |
|:------|:--------|:------------|:-------|
| 0 (Basic) | Registration | Email + phone verification | Browse, save favourites |
| 1 (Buyer) | First message | — | Message sellers, make offers |
| 2 (Seller) | First listing | iDIN or itsme bank-based identity | Create listings, receive payments |
| 3 (Escrow) | First escrow tx | Onfido selfie + document | Full escrow functionality |
| 4 (Business) | €2,500+/month | KVK number + KYBC | Business tools, bulk listing |

### Escrow Payment Flow

```
Buyer pays → Mollie Connect holds funds → seller ships (QR label)
→ carrier scans → tracking confirms delivery
→ buyer has 48 hours to flag issues
→ auto-release to seller (minus 2.5% commission + shipping)
```

### Dispute Resolution

1. Buyer flags issue within 48 hours → escrow extended
2. Both parties submit evidence (photos, screenshots) — 24-hour deadline
3. AI pre-screens → resolves ~60% automatically
4. Human agent reviews contested cases → binding decision within 72 hours
5. Refund/release with correct split
6. Fraudulent patterns → account suspended

### Customer Support Tiers

| Tier | Handles | SLA | Language |
|:-----|:--------|:----|:---------|
| 1 — AI Chatbot | FAQs, tracking | < 60 seconds | NL + EN |
| 2 — Human Agent | Fraud, disputes, payments | 4-hour response | NL + EN |
| 3 — Senior | High-value, appeals | 72-hour decision | NL + EN |

---

## Security

### OWASP Top 10

| Risk | Mitigation |
|:-----|:-----------|
| Broken Access Control | Supabase RLS on all tables; JWT 15min + refresh |
| Cryptographic Failures | AES-256 PII; TLS 1.3; HSTS; cert pinning (mobile) |
| Injection | Parameterised queries (Supabase SDK); Zod validation |
| Insecure Design | Threat modeling per feature; 4-eyes on escrow |
| Security Misconfiguration | RLS enabled on all tables; Cloudflare WAF |
| Vulnerable Components | osv-scanner in CI (blocker); Dependabot |
| Auth Failures | iDIN MFA; rate-limited logins; bcrypt cost 12 |
| Data Integrity | Signed storage URLs; HMAC-SHA256 webhooks; Redis idempotency |
| Logging Failures | Structured logging; PII masking mandatory |
| SSRF | Allowlist outbound HTTP; metadata blocking |

### Security Processes

- **Penetration Test:** Pre-launch (external firm) + annual
- **SAST:** SonarQube in CI (merge blocker)
- **DAST:** OWASP ZAP weekly automated scan on staging
- **Secret Scanning:** GitHub secret scanning + GitGuardian (real-time alerts)
- **WAF:** Cloudflare free tier
- **Cyber Insurance:** €1M+ pre-launch

### Image Pipeline

```
Upload → Supabase Storage → Edge Function: resize + EXIF strip + ClamAV
→ Cloudinary: WebP/AVIF conversion + CDN delivery
```

Max 15 MB/image, 12 images/listing. EXIF stripping is GDPR-mandatory (GPS = personal data).

---

## Regulatory Requirements

| Regulation | Key Action |
|:-----------|:-----------|
| **GDPR** | Privacy-by-design; DPO contract; Didomi CMP (IAB TCF 2.2); EXIF stripping; 72hr breach notification; right-to-erasure via Edge Function |
| **DSA** | Notice-and-action (24hr SLA); KYBC for business sellers; non-personalised feed option; annual transparency report |
| **EAA** | WCAG 2.2 Level AA from MVP — retrofitting is 3–5x more expensive |
| **PSD2** | Mollie (licensed PSP) handles SCA; double-entry ledger for audit trail |
| **Dutch Consumer Protection** | 14-day cooling-off (B2C only); full price transparency; KVK + VAT display |
| **AML / Wwft** | Transaction monitoring via Mollie Connect compliance tools |

### GDPR Implementation

| Requirement | Implementation |
|:------------|:---------------|
| Consent | Didomi CMP (IAB TCF 2.2) |
| Data access (DSR) | 30-day automated export via Edge Function |
| Right to erasure | Async PII deletion; 30 days; audit log preserved |
| Breach notification | PagerDuty → team → Autoriteit Persoonsgegevens (72 hours) |
| Data classification | PII-Critical (BSN/IBAN): AES-256 + Vault; Standard PII: TLS at-rest |

---

## Business Entity

**Holding BV + Operations BV** — setup ~€3K–€5K. Must be done before Series A.

- **Holding BV:** Owns IP (brand, domain, code); collects royalties
- **Operations BV:** Employs staff; runs marketplace

Budget **€20–50K** for Dutch tech/privacy legal counsel before launch.

---

## Ethical Design Commitments

- No intrusive ads intercepting swipe events
- No roach motel cancellation flows
- No hidden fees — all costs shown before buy button
- No deceptive urgency mechanics
- BTW (VAT) on every price view
- Non-personalised feed option (DSA requirement)
