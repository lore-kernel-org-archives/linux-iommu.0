From: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [PATCH] iommu/vt-d: Fix the size calculation of pasid table
Date: Sun, 30 Oct 2016 06:18:22 -0600
Message-ID: <1477829902.4154.9.camel@infradead.org>
References: <1473648551-10025-1-git-send-email-xlpang@redhat.com>
	<20160919121827.GB3541@8bytes.org>
	<1476274674.16627.173.camel@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1548842522557317088=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1476274674.16627.173.camel-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Xunlei Pang <xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Mika Kuoppala <mika.kuoppala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============1548842522557317088==
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/x-pkcs7-signature"; boundary="=-hk3xPC5NOX2HHRSOpyvU"


--=-hk3xPC5NOX2HHRSOpyvU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2016-10-12 at 13:17 +0100, David Woodhouse wrote:
> Yes, that looks correct. I think we may also need to limit it, because
> full 20-bit PASID support means we'll attempt an order 11 allocation.
> But that's certainly correct for now

Actually, not quite correct. You fixed the allocation but not the free.
And Mika had reported that even the *correct* allocation was failing
because it was too large. So I've done it differently (untested)...

-----
Subject: [PATCH] iommu/vt-d: Fix PASID table allocation

Somehow I ended up with an off-by-three error in calculating the size of
the PASID and PASID State tables, which triggers allocations failures as
those tables unfortunately have to be physically contiguous.

In fact, even the *correct* maximum size of 8MiB is problematic and is
wont to lead to allocation failures. Since I have extracted a promise
that this *will* be fixed in hardware, I'm happy to limit it on the
current hardware to a maximum of 0x20000 PASIDs, which gives us 1MiB
tables =E2=80=94 still not ideal, but better than before.

Reported by Mika Kuoppala <mika.kuoppala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> and also by
Xunlei Pang <xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> who submitted a simpler patch to fix
only the allocation (and not the free) to the "correct" limit... which
was still problematic.

Signed-off-by: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
---
=C2=A0drivers/iommu/intel-svm.c=C2=A0=C2=A0=C2=A0| 28 +++++++++++++++++----=
-------
=C2=A0include/linux/intel-iommu.h |=C2=A0=C2=A01 +
=C2=A02 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 8ebb353..cb72e00 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -39,10 +39,18 @@ int intel_svm_alloc_pasid_tables(struct intel_iommu *io=
mmu)
=C2=A0	struct page *pages;
=C2=A0	int order;
=C2=A0
-	order =3D ecap_pss(iommu->ecap) + 7 - PAGE_SHIFT;
-	if (order < 0)
-		order =3D 0;
-
+	/* Start at 2 because it's defined as 1^(1+PSS) */
+	iommu->pasid_max =3D 2 << ecap_pss(iommu->ecap);
+
+	/* Eventually I'm promised we will get a multi-level PASID table
+	=C2=A0* and it won't have to be physically contiguous. Until then,
+	=C2=A0* limit the size because 8MiB contiguous allocations can be hard
+	=C2=A0* to come by. The limit of 0x20000, which is 1MiB for each of
+	=C2=A0* the PASID and PASID-state tables, is somewhat arbitrary. */
+	if (iommu->pasid_max > 0x20000)
+		iommu->pasid_max =3D 0x20000;
+
+	order =3D get_order(sizeof(struct pasid_entry) * iommu->pasid_max);
=C2=A0	pages =3D alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
=C2=A0	if (!pages) {
=C2=A0		pr_warn("IOMMU: %s: Failed to allocate PASID table\n",
@@ -53,6 +61,8 @@ int intel_svm_alloc_pasid_tables(struct intel_iommu *iomm=
u)
=C2=A0	pr_info("%s: Allocated order %d PASID table.\n", iommu->name, order)=
;
=C2=A0
=C2=A0	if (ecap_dis(iommu->ecap)) {
+		/* Just making it explicit... */
+		BUILD_BUG_ON(sizeof(struct pasid_entry) !=3D sizeof(struct pasid_state_e=
ntry));
=C2=A0		pages =3D alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
=C2=A0		if (pages)
=C2=A0			iommu->pasid_state_table =3D page_address(pages);
@@ -68,11 +78,7 @@ int intel_svm_alloc_pasid_tables(struct intel_iommu *iom=
mu)
=C2=A0
=C2=A0int intel_svm_free_pasid_tables(struct intel_iommu *iommu)
=C2=A0{
-	int order;
-
-	order =3D ecap_pss(iommu->ecap) + 7 - PAGE_SHIFT;
-	if (order < 0)
-		order =3D 0;
+	int order =3D get_order(sizeof(struct pasid_entry) * iommu->pasid_max);
=C2=A0
=C2=A0	if (iommu->pasid_table) {
=C2=A0		free_pages((unsigned long)iommu->pasid_table, order);
@@ -371,8 +377,8 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, i=
nt flags, struct svm_dev_
=C2=A0		}
=C2=A0		svm->iommu =3D iommu;
=C2=A0
-		if (pasid_max > 2 << ecap_pss(iommu->ecap))
-			pasid_max =3D 2 << ecap_pss(iommu->ecap);
+		if (pasid_max > iommu->pasid_max)
+			pasid_max =3D iommu->pasid_max;
=C2=A0
=C2=A0		/* Do not use PASID 0 in caching mode (virtualised IOMMU) */
=C2=A0		ret =3D idr_alloc(&iommu->pasid_idr, svm,
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 2d9b6500..d49e26c 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -429,6 +429,7 @@ struct intel_iommu {
=C2=A0	struct page_req_dsc *prq;
=C2=A0	unsigned char prq_name[16];=C2=A0=C2=A0=C2=A0=C2=A0/* Name for PRQ i=
nterrupt */
=C2=A0	struct idr pasid_idr;
+	u32 pasid_max;
=C2=A0#endif
=C2=A0	struct q_inval=C2=A0=C2=A0*qi;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Queued invalidation info */
=C2=A0	u32 *iommu_state; /* Store iommu states between suspend and resume.*=
/
--=C2=A0
2.5.5

--=20
dwmw2



--=-hk3xPC5NOX2HHRSOpyvU
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCEeAw
ggXiMIIDyqADAgECAhBrp4p9CteI1lEK+Vnk57ThMA0GCSqGSIb3DQEBCwUAMH0xCzAJBgNVBAYT
AklMMRYwFAYDVQQKEw1TdGFydENvbSBMdGQuMSswKQYDVQQLEyJTZWN1cmUgRGlnaXRhbCBDZXJ0
aWZpY2F0ZSBTaWduaW5nMSkwJwYDVQQDEyBTdGFydENvbSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0
eTAeFw0xNTEyMTYwMTAwMDVaFw0zMDEyMTYwMTAwMDVaMHUxCzAJBgNVBAYTAklMMRYwFAYDVQQK
Ew1TdGFydENvbSBMdGQuMSkwJwYDVQQLEyBTdGFydENvbSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0
eTEjMCEGA1UEAxMaU3RhcnRDb20gQ2xhc3MgMSBDbGllbnQgQ0EwggEiMA0GCSqGSIb3DQEBAQUA
A4IBDwAwggEKAoIBAQC9fdr3w6J9g/Zbgv3bW1+uHht1wLUZr5gkrLtXedg17AkefMyUGwrQdvwO
bhajcVmnKVxhrUwkZPXRAwZZosRHfEIi5FH7x6SV/8Sp5lZEuiMnvMFG2MzLA84J6Ws5T4NfXZ0q
n4TPgnr3X2vPVS51M7Ua9nIJgn8jvTra4eyyQzxvuA/GZwKg7VQfDCmCS+kICslYYWgXOMt2xlsS
slxLce0CGWRsT8EpMyt1iDflSjXZIsE7m1uTyHaKZspMLyIyz6mySu8j8BWWHpChNNeTrFuhVfrO
AyDPFJVUvKZCLKBhibTLloyy+LatoWELrjdI4a8StZY8+dIR9t4APXGzAgMBAAGjggFkMIIBYDAO
BgNVHQ8BAf8EBAMCAQYwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQI
MAYBAf8CAQAwMgYDVR0fBCswKTAnoCWgI4YhaHR0cDovL2NybC5zdGFydHNzbC5jb20vc2ZzY2Eu
Y3JsMGYGCCsGAQUFBwEBBFowWDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3Auc3RhcnRzc2wuY29t
MDAGCCsGAQUFBzAChiRodHRwOi8vYWlhLnN0YXJ0c3NsLmNvbS9jZXJ0cy9jYS5jcnQwHQYDVR0O
BBYEFCSBbDlhvkkPj7cbRivJKLUnSG1oMB8GA1UdIwQYMBaAFE4L7xqkQFulF2mHMMo0aEPQQa7y
MD8GA1UdIAQ4MDYwNAYEVR0gADAsMCoGCCsGAQUFBwIBFh5odHRwOi8vd3d3LnN0YXJ0c3NsLmNv
bS9wb2xpY3kwDQYJKoZIhvcNAQELBQADggIBAIvj94fsAYuErQ8BAluc4SMnIwS9NPBwAm5SH9uh
2NCXTq7im61g7F1LIiNI/+wq37fUuaMbz4g7VarKQTgf8ubs0p7NZWcIe7Bvem2AWaXBsxsaRTYw
5kG3DN8pd1hSEUuFoTa7DmNeFe8tiK1BrL3rbA/m48jp4AiFXgvxprJrW7izsyetOrRHPbkW4Y07
v29MdhaPv3u1JELyszXqOzjIYo4sWlC8iDQXwgSW/ntvWy2n4LuiaozlCfXl149tKeqvwlvrla2Y
klue/quWp9j9ou4T/OY0CXMuY+B8wNK0ohd2D4ShgFlMSjzAFRoHGKF81snTr2d1A7Ew02oF6UQy
CkC2aNNsK5cWOojBar5c7HplX9aHYUCZouxIeU28SONJAxnATgR4cJ2jrpmYSz/kliUJ46S6UpVD
o/ebn9c6PaM/XtDYCCaM/7XX6wc3s++sbQ7CtCn1Ax7df6ufQbwyO0V+oFa9H0KAsjHMzcwk3EV2
B2NLatidKE/m7G+rB9m+FlVgIiSp0mGlg43QO9Kh1+JqvTCIzv2bJJkmPMLQJNuKKwHNL8F4GGp6
jbAV+WL+LDeGfVcq8DHS3LrD+xyYEXQBiqZEdiPVOMxLDSUCXsDO0uCWpaNQ8j6y6S9p0xE/Ga0p
eVLadVHhqf9nXqKaxnr358VgfrxzUIrvOaOjMIIF+TCCBOGgAwIBAgIQaRjuleoVgt0XsPAUByve
JDANBgkqhkiG9w0BAQsFADB1MQswCQYDVQQGEwJJTDEWMBQGA1UEChMNU3RhcnRDb20gTHRkLjEp
MCcGA1UECxMgU3RhcnRDb20gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkxIzAhBgNVBAMTGlN0YXJ0
Q29tIENsYXNzIDEgQ2xpZW50IENBMB4XDTE2MDMxMjE2MjEyNVoXDTE3MDMxMjE2MjEyNVowQjEc
MBoGA1UEAwwTZHdtdzJAaW5mcmFkZWFkLm9yZzEiMCAGCSqGSIb3DQEJARYTZHdtdzJAaW5mcmFk
ZWFkLm9yZzCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBANBDAiGnoeOIQJ/Aolutct4z
x6Yt3dOUI5d0YnydAMNOiyVLXzHuuuVjUpk/6nRxg1FN3e0i3TWe5MjSTD98760qWoAuF2g5BGU+
tN/GUsyws26ZWOt82w7xhn4dcI8EhmASUtwDTZs5ZXPQzSkuNs6uX5SY0eKPlBNHkAtMf39hNc4m
liy6WRDKApZxA1vCbiHsJQZdNEBYO35022bu8PZBe6LSAFKoncoGMHl1xNEkN6kfOJFYnLqBYeXO
2mDA8KZ4h15EnQyyHGSghN92OUTc9stAWEt9a+q6TCtyW5zNgYTaaOtE41t5x2xDAgsnNU7sVM8f
wSR3tYeW9IqTgU6eDUllb1a9FK7es3+j9UDg7OxNv9rnXIda6TdXlGWYfFltujF7FMwTofq3UG7t
w68Ugk0MMfpZadhPhjYLI/qXiEDgQi8Xr+eWSo5P0ygaLvAz8OPcWAt8RG5Y8Id9hpb5neW1HTAR
Q+k8lbpkx2wDPHZEft0ITROOupf76f9CNF4jYcyCKZNnjSsKeJv69VX1TsVaeqT1LJUEudXLa/BK
FSb7x5M1KF4z46yImJrnagI19Nk/ufWn1usBXqXh8pY8cVN/I7C+TDPBY5SqIceTq7DaHZp19JQU
IIWlyRsm2d4UoVcgIdTjX57Odap4Pjzrfp2RmC6hvkW2hQ5EreIPAgMBAAGjggG2MIIBsjAOBgNV
HQ8BAf8EBAMCBLAwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMAkGA1UdEwQCMAAwHQYD
VR0OBBYEFBDmK2IjZJ7MKmBK0A7J/tKaSIdoMB8GA1UdIwQYMBaAFCSBbDlhvkkPj7cbRivJKLUn
SG1oMG8GCCsGAQUFBwEBBGMwYTAkBggrBgEFBQcwAYYYaHR0cDovL29jc3Auc3RhcnRzc2wuY29t
MDkGCCsGAQUFBzAChi1odHRwOi8vYWlhLnN0YXJ0c3NsLmNvbS9jZXJ0cy9zY2EuY2xpZW50MS5j
cnQwOAYDVR0fBDEwLzAtoCugKYYnaHR0cDovL2NybC5zdGFydHNzbC5jb20vc2NhLWNsaWVudDEu
Y3JsMB4GA1UdEQQXMBWBE2R3bXcyQGluZnJhZGVhZC5vcmcwIwYDVR0SBBwwGoYYaHR0cDovL3d3
dy5zdGFydHNzbC5jb20vMEYGA1UdIAQ/MD0wOwYLKwYBBAGBtTcBAgQwLDAqBggrBgEFBQcCARYe
aHR0cDovL3d3dy5zdGFydHNzbC5jb20vcG9saWN5MA0GCSqGSIb3DQEBCwUAA4IBAQAn5wvdgC0V
kS226sFKAbqPnmVhc9jgrbsiXUcpdtYEzv6EZonARIeRC1UlIzK7jzZFRe95W5y4/qlcPQDoAeZL
cSsbpW3AYPFFWdRgVp/eIR3iy9C5KEcAbkJES2lRUZWyRqAceW1Gur9kfvjM5H0kM6BBwJfCtoqo
WragTXfsIXGNsF0F+60mUYYsKFPZzPmyz9J0Dr0xx9Lcp4fbD6UckDWCNJt2AJAiEPt/vPiiBzU8
edaRzkYhzxd9f3pZAzhlzIf2CgTrGtKSL2X1bS/b3siREjQLhVrlGw4qxqllqER3APrDzyijLFuc
CWpS8hxjTmYcNZSibv+3Oy6uU+wqMIIF+TCCBOGgAwIBAgIQaRjuleoVgt0XsPAUByveJDANBgkq
hkiG9w0BAQsFADB1MQswCQYDVQQGEwJJTDEWMBQGA1UEChMNU3RhcnRDb20gTHRkLjEpMCcGA1UE
CxMgU3RhcnRDb20gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkxIzAhBgNVBAMTGlN0YXJ0Q29tIENs
YXNzIDEgQ2xpZW50IENBMB4XDTE2MDMxMjE2MjEyNVoXDTE3MDMxMjE2MjEyNVowQjEcMBoGA1UE
AwwTZHdtdzJAaW5mcmFkZWFkLm9yZzEiMCAGCSqGSIb3DQEJARYTZHdtdzJAaW5mcmFkZWFkLm9y
ZzCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBANBDAiGnoeOIQJ/Aolutct4zx6Yt3dOU
I5d0YnydAMNOiyVLXzHuuuVjUpk/6nRxg1FN3e0i3TWe5MjSTD98760qWoAuF2g5BGU+tN/GUsyw
s26ZWOt82w7xhn4dcI8EhmASUtwDTZs5ZXPQzSkuNs6uX5SY0eKPlBNHkAtMf39hNc4mliy6WRDK
ApZxA1vCbiHsJQZdNEBYO35022bu8PZBe6LSAFKoncoGMHl1xNEkN6kfOJFYnLqBYeXO2mDA8KZ4
h15EnQyyHGSghN92OUTc9stAWEt9a+q6TCtyW5zNgYTaaOtE41t5x2xDAgsnNU7sVM8fwSR3tYeW
9IqTgU6eDUllb1a9FK7es3+j9UDg7OxNv9rnXIda6TdXlGWYfFltujF7FMwTofq3UG7tw68Ugk0M
MfpZadhPhjYLI/qXiEDgQi8Xr+eWSo5P0ygaLvAz8OPcWAt8RG5Y8Id9hpb5neW1HTARQ+k8lbpk
x2wDPHZEft0ITROOupf76f9CNF4jYcyCKZNnjSsKeJv69VX1TsVaeqT1LJUEudXLa/BKFSb7x5M1
KF4z46yImJrnagI19Nk/ufWn1usBXqXh8pY8cVN/I7C+TDPBY5SqIceTq7DaHZp19JQUIIWlyRsm
2d4UoVcgIdTjX57Odap4Pjzrfp2RmC6hvkW2hQ5EreIPAgMBAAGjggG2MIIBsjAOBgNVHQ8BAf8E
BAMCBLAwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMAkGA1UdEwQCMAAwHQYDVR0OBBYE
FBDmK2IjZJ7MKmBK0A7J/tKaSIdoMB8GA1UdIwQYMBaAFCSBbDlhvkkPj7cbRivJKLUnSG1oMG8G
CCsGAQUFBwEBBGMwYTAkBggrBgEFBQcwAYYYaHR0cDovL29jc3Auc3RhcnRzc2wuY29tMDkGCCsG
AQUFBzAChi1odHRwOi8vYWlhLnN0YXJ0c3NsLmNvbS9jZXJ0cy9zY2EuY2xpZW50MS5jcnQwOAYD
VR0fBDEwLzAtoCugKYYnaHR0cDovL2NybC5zdGFydHNzbC5jb20vc2NhLWNsaWVudDEuY3JsMB4G
A1UdEQQXMBWBE2R3bXcyQGluZnJhZGVhZC5vcmcwIwYDVR0SBBwwGoYYaHR0cDovL3d3dy5zdGFy
dHNzbC5jb20vMEYGA1UdIAQ/MD0wOwYLKwYBBAGBtTcBAgQwLDAqBggrBgEFBQcCARYeaHR0cDov
L3d3dy5zdGFydHNzbC5jb20vcG9saWN5MA0GCSqGSIb3DQEBCwUAA4IBAQAn5wvdgC0VkS226sFK
AbqPnmVhc9jgrbsiXUcpdtYEzv6EZonARIeRC1UlIzK7jzZFRe95W5y4/qlcPQDoAeZLcSsbpW3A
YPFFWdRgVp/eIR3iy9C5KEcAbkJES2lRUZWyRqAceW1Gur9kfvjM5H0kM6BBwJfCtoqoWragTXfs
IXGNsF0F+60mUYYsKFPZzPmyz9J0Dr0xx9Lcp4fbD6UckDWCNJt2AJAiEPt/vPiiBzU8edaRzkYh
zxd9f3pZAzhlzIf2CgTrGtKSL2X1bS/b3siREjQLhVrlGw4qxqllqER3APrDzyijLFucCWpS8hxj
TmYcNZSibv+3Oy6uU+wqMYIEXjCCBFoCAQEwgYkwdTELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0
YXJ0Q29tIEx0ZC4xKTAnBgNVBAsTIFN0YXJ0Q29tIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MSMw
IQYDVQQDExpTdGFydENvbSBDbGFzcyAxIENsaWVudCBDQQIQaRjuleoVgt0XsPAUByveJDANBglg
hkgBZQMEAgEFAKCCAaUwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcN
MTYxMDMwMTIxODIyWjAvBgkqhkiG9w0BCQQxIgQgw8IpQLkdPJIBIotO13cvKh6nN16w96ENuXZH
rsoW5/0wgZoGCSsGAQQBgjcQBDGBjDCBiTB1MQswCQYDVQQGEwJJTDEWMBQGA1UEChMNU3RhcnRD
b20gTHRkLjEpMCcGA1UECxMgU3RhcnRDb20gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkxIzAhBgNV
BAMTGlN0YXJ0Q29tIENsYXNzIDEgQ2xpZW50IENBAhBpGO6V6hWC3Rew8BQHK94kMIGcBgsqhkiG
9w0BCRACCzGBjKCBiTB1MQswCQYDVQQGEwJJTDEWMBQGA1UEChMNU3RhcnRDb20gTHRkLjEpMCcG
A1UECxMgU3RhcnRDb20gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkxIzAhBgNVBAMTGlN0YXJ0Q29t
IENsYXNzIDEgQ2xpZW50IENBAhBpGO6V6hWC3Rew8BQHK94kMA0GCSqGSIb3DQEBAQUABIICACBf
1W/mIUXlQYl6o+YZ7N2pVg9asVfTgGb2vwmFxEUe+uZGP3QehfzaIKEytC+PVinKGYUnFAX9RUfC
vlYLgM7/bPnXhBzWIcFJfJcFCrz2J9Mtzia9HoukTICIM3qwkxehnauqugAJ5AAZ7+HhHNFZN0sD
msjtb5bS+8GjMQsZekiZj8F6FYdDqgDjPGqzjLRnItBcIDAz3G/Qx0CvfNmtnN4hI+T8p4L/CfiJ
ibNYQk3T7t0xXEeqrUlGvDSsM/hr/KTo4Jnbua8mkrLXZUvwtE7jqKysFkfo7zJclN7io9cgtsE/
2cIeaJoh0Y4Aw0kCc/uGa1VRzeJdjPfUuvc4IPAz8Ljm9oWZ+NgwYAC8RI0Nv99gGwFcVMxwtfnY
X7eqY52LXIS2x6she92tkVn3Ef7PgTLE5Ubgz1uymV6GrVikCm4GkSINP2A6XqPM1DZqOqx7vFyt
wLtlzbdiigtRJINiP95g2GcoyUVGPdJWEfVRIJ8IGXg6ACZ/QXSO3ghsUaDMdX/5PRDBLBDaKxgF
H4Oop8W+i5I5e6txPSTeh2Ft6yr6vfGOFHPO/aHaPKMvnKOUBDTZ0yzPzl3H6Tvv0R7P0Zq6QCC9
dWffwiMyXxMkYXQ+CZDlGBD+/ubFsvIBKMI7errN+2pELq0nUDZ8l+qCC53AfyC8AZJsesSZAAAA
AAAA


--=-hk3xPC5NOX2HHRSOpyvU--


--===============1548842522557317088==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1548842522557317088==--
