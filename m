From: "Woodhouse, David via iommu" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: [PATCH v2] iommu/vt-d: Don't be too aggressive when clearing one
	context entry
Date: Thu, 31 Aug 2017 10:21:33 +0000
Message-ID: <1504174892.3408.28.camel@amazon.co.uk>
References: <1503929789-26698-1-git-send-email-sironi@amazon.de>
	<1504169891-9480-1-git-send-email-sironi@amazon.de>
Reply-To: "Woodhouse, David" <dwmw-vV1OtcyAfmbQXOPxS62xeg@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0348213845080529455=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1504169891-9480-1-git-send-email-sironi-ebkRAfMGSJGzQB+pC5nmwQ@public.gmane.org>
MIME-Version: 1.0
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Sironi,
	Filippo" <sironi-ebkRAfMGSJGzQB+pC5nmwQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============0348213845080529455==
Content-Language: en-US
Content-Type: multipart/signed; micalg=sha-256;
	protocol="application/x-pkcs7-signature"; boundary="=-/RKE5UqMvgQ6MpBDOWz4"

--=-/RKE5UqMvgQ6MpBDOWz4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2017-08-31 at 10:58 +0200, Filippo Sironi wrote:
> Previously, we were invalidating context cache and IOTLB globally when
> clearing one context entry.=C2=A0=C2=A0This is a tad too aggressive.
> Invalidate the context cache and IOTLB for the interested device only.
>=20
> Signed-off-by: Filippo Sironi <sironi-ebkRAfMGSJGzQB+pC5nmwQ@public.gmane.org>
> Cc: David Woodhouse <dwmw-vV1OtcyAfmbQXOPxS62xeg@public.gmane.org>
> Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
> Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
> Cc: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Acked-by: David Woodhouse <dwmw-vV1OtcyAfmbQXOPxS62xeg@public.gmane.org>

I'd actually quite like to see us tidy this up some more. If there are
aliases, we're doing the flush multiple times. It might be nicer to do
no flushing in domain_contact_clear_one(), which is invoked for each
alias, and just to update a (u16 *)did. If *did was empty, set it. If
it was set (i.e. if there are aliases), then set it to a magic value
like 0xFFFF.=C2=A0

Then we can do the actual flush =E2=80=94 either device-specific, or global=
 =E2=80=94
just once in domain_context_clear().

We'd probably just move domain_context_clear_one() into its only caller
domain_context_clear_one_cb() while we're at it.

But in the meantime I'm more than happy with this patch which turns
multiple global flushes into multiple domain-specific flushes, and does
the right thing in the common case.

> ---

v2: Changed subject, killed clear_context_table(). Anything else?

> =C2=A0drivers/iommu/intel-iommu.c | 42 ++++++++++++++++++++++++----------=
--------
> =C2=A01 file changed, 24 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 3e8636f1220e..1aa4ad7974b9 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -974,20 +974,6 @@ static int device_context_mapped(struct intel_iommu =
*iommu, u8 bus, u8 devfn)
> =C2=A0	return ret;
> =C2=A0}
> =C2=A0
> -static void clear_context_table(struct intel_iommu *iommu, u8 bus, u8 de=
vfn)
> -{
> -	struct context_entry *context;
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&iommu->lock, flags);
> -	context =3D iommu_context_addr(iommu, bus, devfn, 0);
> -	if (context) {
> -		context_clear_entry(context);
> -		__iommu_flush_cache(iommu, context, sizeof(*context));
> -	}
> -	spin_unlock_irqrestore(&iommu->lock, flags);
> -}
> -
> =C2=A0static void free_context_table(struct intel_iommu *iommu)
> =C2=A0{
> =C2=A0	int i;
> @@ -2351,13 +2337,33 @@ static inline int domain_pfn_mapping(struct dmar_=
domain *domain, unsigned long i
> =C2=A0
> =C2=A0static void domain_context_clear_one(struct intel_iommu *iommu, u8 =
bus, u8 devfn)
> =C2=A0{
> +	unsigned long flags;
> +	struct context_entry *context;
> +	u16 did_old;
> +
> =C2=A0	if (!iommu)
> =C2=A0		return;
> =C2=A0
> -	clear_context_table(iommu, bus, devfn);
> -	iommu->flush.flush_context(iommu, 0, 0, 0,
> -					=C2=A0=C2=A0=C2=A0DMA_CCMD_GLOBAL_INVL);
> -	iommu->flush.flush_iotlb(iommu, 0, 0, 0, DMA_TLB_GLOBAL_FLUSH);
> +	spin_lock_irqsave(&iommu->lock, flags);
> +	context =3D iommu_context_addr(iommu, bus, devfn, 0);
> +	if (!context) {
> +		spin_unlock_irqrestore(&iommu->lock, flags);
> +		return;
> +	}
> +	did_old =3D context_domain_id(context);
> +	context_clear_entry(context);
> +	__iommu_flush_cache(iommu, context, sizeof(*context));
> +	spin_unlock_irqrestore(&iommu->lock, flags);
> +	iommu->flush.flush_context(iommu,
> +				=C2=A0=C2=A0=C2=A0did_old,
> +				=C2=A0=C2=A0=C2=A0(((u16)bus) << 8) | devfn,

Arguably we ought to be PCI_DEVID() there, but I feel bad pointing that
out when you're adding about the fifth instance of open-coding it... :)

--=C2=A0
dwmw2
--=-/RKE5UqMvgQ6MpBDOWz4
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCDugw
ggSvMIIDl6ADAgECAhEA4CPLFRKDU4mtYW56VGdrITANBgkqhkiG9w0BAQsFADBvMQswCQYDVQQG
EwJTRTEUMBIGA1UEChMLQWRkVHJ1c3QgQUIxJjAkBgNVBAsTHUFkZFRydXN0IEV4dGVybmFsIFRU
UCBOZXR3b3JrMSIwIAYDVQQDExlBZGRUcnVzdCBFeHRlcm5hbCBDQSBSb290MB4XDTE0MTIyMjAw
MDAwMFoXDTIwMDUzMDEwNDgzOFowgZsxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1h
bmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMUEw
PwYDVQQDEzhDT01PRE8gU0hBLTI1NiBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBF
bWFpbCBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAImxDdp6UxlOcFIdvFamBia3
uEngludRq/HwWhNJFaO0jBtgvHpRQqd5jKQi3xdhTpHVdiMKFNNKAn+2HQmAbqUEPdm6uxb+oYep
LkNSQxZ8rzJQyKZPWukI2M+TJZx7iOgwZOak+FaA/SokFDMXmaxE5WmLo0YGS8Iz1OlAnwawsayT
QLm1CJM6nCpToxDbPSBhPFUDjtlOdiUCISn6o3xxdk/u4V+B6ftUgNvDezVSt4TeIj0sMC0xf1m9
UjewM2ktQ+v61qXxl3dnUYzZ7ifrvKUHOHaMpKk4/9+M9QOsSb7K93OZOg8yq5yVOhM9DkY6V3Rh
UL7GQD/L5OKfoiECAwEAAaOCARcwggETMB8GA1UdIwQYMBaAFK29mHo0tCb3+sQmVO8DveAky1Qa
MB0GA1UdDgQWBBSSYWuC4aKgqk/sZ/HCo/e0gADB7DAOBgNVHQ8BAf8EBAMCAYYwEgYDVR0TAQH/
BAgwBgEB/wIBADAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwEQYDVR0gBAowCDAGBgRV
HSAAMEQGA1UdHwQ9MDswOaA3oDWGM2h0dHA6Ly9jcmwudXNlcnRydXN0LmNvbS9BZGRUcnVzdEV4
dGVybmFsQ0FSb290LmNybDA1BggrBgEFBQcBAQQpMCcwJQYIKwYBBQUHMAGGGWh0dHA6Ly9vY3Nw
LnVzZXJ0cnVzdC5jb20wDQYJKoZIhvcNAQELBQADggEBABsqbqxVwTqriMXY7c1V86prYSvACRAj
mQ/FZmpvsfW0tXdeDwJhAN99Bf4Ss6SAgAD8+x1banICCkG8BbrBWNUmwurVTYT7/oKYz1gb4yJj
nFL4uwU2q31Ypd6rO2Pl2tVz7+zg+3vio//wQiOcyraNTT7kSxgDsqgt1Ni7QkuQaYUQ26Y3NOh7
4AEQpZzKOsefT4g0bopl0BqKu6ncyso20fT8wmQpNa/WsadxEdIDQ7GPPprsnjJT9HaSyoY0B7ks
yuYcStiZDcGG4pCS+1pCaiMhEOllx/XVu37qjIUgAmLq0ToHLFnFmTPyOInltukWeh95FPZKEBom
+nyK+5swggT0MIID3KADAgECAhBBWw5mHOaCGZOPHTpNxMYTMA0GCSqGSIb3DQEBCwUAMHUxCzAJ
BgNVBAYTAklMMRYwFAYDVQQKEw1TdGFydENvbSBMdGQuMSkwJwYDVQQLEyBTdGFydENvbSBDZXJ0
aWZpY2F0aW9uIEF1dGhvcml0eTEjMCEGA1UEAxMaU3RhcnRDb20gQ2xhc3MgMSBDbGllbnQgQ0Ew
HhcNMTYxMjIwMTM1MDA1WhcNMTkxMjIwMTM1MDA1WjA+MRowGAYDVQQDDBFkd213QGFtYXpvbi5j
by51azEgMB4GCSqGSIb3DQEJARYRZHdtd0BhbWF6b24uY28udWswggEiMA0GCSqGSIb3DQEBAQUA
A4IBDwAwggEKAoIBAQDVnCv7xNxTFtjVBSrUu29LmF4M+rjMQbk1IYn0qHTCnAviJqOCpquuT0/g
FwluSOpeKwtx9UXiDUZAar4zzJuRMjlvbsDbO4bwTxxfF062AvHX+qMzHmNxLUF+dM5cCadEsmMZ
5UgwHB9sblngM9Wp+EVuPYuPl4sBPBO7iURgbUY4ESfQe0Ccg8GE2txMV8Z8MCl7m+wnHfn9SVuZ
0Fc8usyT85Pgd6BgydvzT2kePcqsX4qYLFe55FLYt2nZE32CGPwtmY7UXU02LG06CUF9dWwOjwo8
kh2oZ7nkVnn2YnHvjJboOSL0+KsIMANtSamETJC7HY/PkBoK5+S0WuBFAgMBAAGjggG1MIIBsTAO
BgNVHQ8BAf8EBAMCBLAwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMAkGA1UdEwQCMAAw
HQYDVR0OBBYEFJSzc3MZbuJ2o8/UTrYfhDPMj9q/MB8GA1UdIwQYMBaAFCSBbDlhvkkPj7cbRivJ
KLUnSG1oMG8GCCsGAQUFBwEBBGMwYTAkBggrBgEFBQcwAYYYaHR0cDovL29jc3Auc3RhcnRzc2wu
Y29tMDkGCCsGAQUFBzAChi1odHRwOi8vYWlhLnN0YXJ0c3NsLmNvbS9jZXJ0cy9zY2EuY2xpZW50
MS5jcnQwOAYDVR0fBDEwLzAtoCugKYYnaHR0cDovL2NybC5zdGFydHNzbC5jb20vc2NhLWNsaWVu
dDEuY3JsMBwGA1UdEQQVMBOBEWR3bXdAYW1hem9uLmNvLnVrMCMGA1UdEgQcMBqGGGh0dHA6Ly93
d3cuc3RhcnRzc2wuY29tLzBHBgNVHSAEQDA+MDwGCysGAQQBgbU3AQIFMC0wKwYIKwYBBQUHAgEW
H2h0dHBzOi8vd3d3LnN0YXJ0c3NsLmNvbS9wb2xpY3kwDQYJKoZIhvcNAQELBQADggEBAFoA3cOX
fo3qnX/Vd0FuWU9Tu0HXeDYwKuC/g/+aolF2DELSQn66gwvXxBCwMxvhy3fsCD0Uz5n6Ntb34kMN
QKZG1VzkcrpBMVm79n9mCSIwDyRPZPEzLLTOWfqngzdlN4qkw8IXUJdWtTsMPmCPlIazmuK0Gt8V
EPnnUxLceiojTHY6ZLZcgMnv0txLHeJydf25l9pjTUU8Agxe1CG2yV6DO9MLQNzP1YBLhzvMbUho
eEbIIs+amb0/MvwhmDZ7T0hHfB/OX5UKduw+Xymn7z/AV0iM0mbWEoaYFxhEiSpgFhclpJawxVy4
/MUBzfyZ+jh/5TvaLECztzVy6USKMMkwggU5MIIEIaADAgECAhAo98UbXYqOECqxwUMahDUnMA0G
CSqGSIb3DQEBCwUAMIGbMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVy
MRAwDgYDVQQHEwdTYWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDFBMD8GA1UEAxM4
Q09NT0RPIFNIQS0yNTYgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0Ew
HhcNMTYxMjIwMDAwMDAwWhcNMTcxMjIwMjM1OTU5WjAiMSAwHgYJKoZIhvcNAQkBFhFkd213QGFt
YXpvbi5jby51azCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALhk5yqj2pyEzhSlQDHk
Ill/b+Ld3NLkvYvca9r7V+4d23zTPFoWPT7Ax5VlWGuixiCJOcNX8i00itaWDp9QIKak/guObzWK
GlA6Vnnzxgr10B8YXhFp6CEVLR2xCGmf0uHdzU3nvd1npIu1VfZV+/XVQpn/yDxdHTWtyuHl1EkX
NnR/0q1DU7fGyUvzqLBn96inYkNBs4D5EpJPCple8iscgm9+xE97+akHO/ky87n/E2Ye5tqHtnLw
SUJD3RIeN1fg5naDrFnbuZKNOxBq4Ri+groS8ukSitzITZijdXpBUkllvfHFTLhqDEtZ2C0wvicz
q3usoMl3doOWIjJY3+sCAwEAAaOCAe8wggHrMB8GA1UdIwQYMBaAFJJha4LhoqCqT+xn8cKj97SA
AMHsMB0GA1UdDgQWBBTxYEIraYbllEkfxak9SSXcnthJ+zAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0T
AQH/BAIwADAgBgNVHSUEGTAXBggrBgEFBQcDBAYLKwYBBAGyMQEDBQIwEQYJYIZIAYb4QgEBBAQD
AgUgMEYGA1UdIAQ/MD0wOwYMKwYBBAGyMQECAQEBMCswKQYIKwYBBQUHAgEWHWh0dHBzOi8vc2Vj
dXJlLmNvbW9kby5uZXQvQ1BTMF0GA1UdHwRWMFQwUqBQoE6GTGh0dHA6Ly9jcmwuY29tb2RvY2Eu
Y29tL0NPTU9ET1NIQTI1NkNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcmww
gZAGCCsGAQUFBwEBBIGDMIGAMFgGCCsGAQUFBzAChkxodHRwOi8vY3J0LmNvbW9kb2NhLmNvbS9D
T01PRE9TSEEyNTZDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWlsQ0EuY3J0MCQGCCsG
AQUFBzABhhhodHRwOi8vb2NzcC5jb21vZG9jYS5jb20wHAYDVR0RBBUwE4ERZHdtd0BhbWF6b24u
Y28udWswDQYJKoZIhvcNAQELBQADggEBAFjz5aY7nsbocrZaYkcHh/nreUnu9uvX9CvOAWT+Wixi
Sn8iJ0Bl3yXm0csEGhIRgqQV6wqYdEVicELowXV9z8syDswttycBw7MmJorA0Ukl8vjBw6Kmj5UO
YTHVReF+Y8glZXqahIUHxL8mqqXtFPQZOBDqMSZA6zgQ53fT+nlOr5DMvnJ0kwz2G6juYLoDgX9w
juEsLu88o+3tRcQHzLsGoN7ZEAM51xydHkoUnFhgBnHzhs9UApg+cRxvfOo0c+advhok7GikOZ2n
GmZwVRD7xUSlmUtibaZt6cGxLDbI7HYmfWt1QnLII7Vdb+gflRJO/UO3nsIMD6Y2txuh6O8xggOF
MIIDgQIBATCBsDCBmzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQ
MA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxQTA/BgNVBAMTOENP
TU9ETyBTSEEtMjU2IENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhAo
98UbXYqOECqxwUMahDUnMA0GCWCGSAFlAwQCAQUAoIIBpTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcN
AQcBMBwGCSqGSIb3DQEJBTEPFw0xNzA4MzExMDIxMzNaMC8GCSqGSIb3DQEJBDEiBCBzEhBYG+NC
UrIl14fa2+kLEmU9FbbEb2bFtyeuPJA8zzCBmgYJKwYBBAGCNxAEMYGMMIGJMHUxCzAJBgNVBAYT
AklMMRYwFAYDVQQKEw1TdGFydENvbSBMdGQuMSkwJwYDVQQLEyBTdGFydENvbSBDZXJ0aWZpY2F0
aW9uIEF1dGhvcml0eTEjMCEGA1UEAxMaU3RhcnRDb20gQ2xhc3MgMSBDbGllbnQgQ0ECEEFbDmYc
5oIZk48dOk3ExhMwgZwGCyqGSIb3DQEJEAILMYGMoIGJMHUxCzAJBgNVBAYTAklMMRYwFAYDVQQK
Ew1TdGFydENvbSBMdGQuMSkwJwYDVQQLEyBTdGFydENvbSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0
eTEjMCEGA1UEAxMaU3RhcnRDb20gQ2xhc3MgMSBDbGllbnQgQ0ECEEFbDmYc5oIZk48dOk3ExhMw
DQYJKoZIhvcNAQEBBQAEggEAfLnk4nHD3EjXBnXmvTRNzdoz1e4sOJ78JUd5GH70cqv52CFnp85i
JqW3ijebnL4vxO6DJUZyWCJUfmnL8rHIHouWitGM7iQhQPmiEeNnOTF0dlY4k/ySaZY5yFQbCS++
j1nT1BmSVodWcSz7hICSoVJPKmMxluxt5QKpoYqL/NyQ1duZ6gfxCUEl22W0tl8qykXXQkM48udU
6TGKM6gFktilLSRI0C0wBfZik0WNg2WEzBvwvIpHy01sfOVDq4rIR8W0qTvu1QWWdytFlhb3CKUW
QFha93rs4zagN8wLnTUXUWoTzzjqyTbYtTI9QpcTeb6Y2Dnh4kvvf3PaC7KsjAAAAAAAAA==


--=-/RKE5UqMvgQ6MpBDOWz4--

--===============0348213845080529455==
Content-Type: multipart/alternative; boundary="===============7400220917392499534=="
MIME-Version: 1.0
Content-Disposition: inline

--===============7400220917392499534==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable




Amazon Web Services UK Limited. Registered in England and Wales with regist=
ration number 08650665 and which has its registered office at 60 Holborn Vi=
aduct, London EC1A 2FD, United Kingdom.

--===============7400220917392499534==
Content-Type: text/html; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable




Amazon Web Services UK Limited. Registered in England and Wales with regist=
ration number 08650665 and which has its registered office at 60 Holborn Vi=
aduct, London EC1A 2FD, United Kingdom.

--===============7400220917392499534==--

--===============0348213845080529455==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0348213845080529455==--
