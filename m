From: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [RFC PATCH] x86: Allow IOMMU drivers to Hook arch_setup_dma_ops()
Date: Mon, 31 Oct 2016 08:34:51 -0600
Message-ID: <1477924491.14501.16.camel@infradead.org>
References: <1477854889.14501.6.camel@woodhou.se>
	<a95e5fb2-3f5d-5334-c62d-e4b99a52adcb@arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7005254187100769310=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <a95e5fb2-3f5d-5334-c62d-e4b99a52adcb-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============7005254187100769310==
Content-Type: multipart/signed; micalg="sha-256";
	protocol="application/x-pkcs7-signature";
	boundary="=-lTM33zJzciafCfw03qsT"


--=-lTM33zJzciafCfw03qsT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2016-10-31 at 11:45 +0000, Robin Murphy wrote:
> Hi David,
>=20
> On 30/10/16 19:14, David Woodhouse wrote:
> >=20
> > The Intel IOMMU code registers a notifier and plays nasty tricks to fil=
l
> > device pointers in with its DMAR scope tables when devices are detected=
,
> > then later compares the device pointers in those tables when it needs t=
o
> > find the IOMMU unit for a given device.
> >=20
> > If we let it use arch_setup_dma_ops() to match the device to an IOMMU
> > unit at device_register() time, this gets a whole lot saner.
>
> I like the sound of this, but do beware that there are plans afoot to
> move the arch_setup_dma_ops() call later, to driver probe time[1],=20

That's OK. I only need the arch_setup_dma_ops() call to happen *after*
the initial parsing of the DMAR tables (which is really early), and
*before* anyone actually tries to set up DMA for a given device.

There's a special case for RMRRs where we have to set up the 1:1
mapping before we enable the IOMMU, but that needs work anyway =E2=80=94 it
currently doesn't cope with non-existent devices (the HP horridness
where a device is doing DMA and we don't even know it *exists*).

So I want to fix the RMRR thing to be entirely decoupled from the
actual *devices* anyway.

> FWIW, arm64 is probably the nicer example. The arch side of the DMA ops
> is purely cache maintenance, and the rest is just funnelled through the
> generic dma-iommu.c glue layer.

Right, that's exactly what we're looking for.

So dma_ops can go back to being a platform-wide thing; it's only the
IOMMU ops which are different per device.

> > And IOMMU ops should be per-device of course, not per-bus. But this is
> > a start...
> As it happens, that was one of the additional motivations for
> introducing the new iommu_fwspec - see [3] for my take on the matter.

Right... in my case I don't actually need iommu_ops to change. We have
multiple IOMMUs of the same type, and we don't have a *separate* ops
structure for each of them.

What we *do* need to change is the iommu-private data pointer, which
indicates specifically which DMAR unit is being used.

That's currently kept in dev->archdata but with assumptions that the
device->IOMMU mapping is only done when the domain is first set up, so
it needs to be redone either with a new field in dev->archdata or some
additional complexity.

Rather than a new field in archdata.... should we make this a generic
iommu_priv pointer living next to iommu_ops in the device structure?

Could you use that?

--=C2=A0
dwmw2


--=-lTM33zJzciafCfw03qsT
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
MTYxMDMxMTQzNDUxWjAvBgkqhkiG9w0BCQQxIgQgcuyoVrUfu+5SgjPAb3DxFiMNBIVTEQF8J0D2
wZvfKCYwgZoGCSsGAQQBgjcQBDGBjDCBiTB1MQswCQYDVQQGEwJJTDEWMBQGA1UEChMNU3RhcnRD
b20gTHRkLjEpMCcGA1UECxMgU3RhcnRDb20gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkxIzAhBgNV
BAMTGlN0YXJ0Q29tIENsYXNzIDEgQ2xpZW50IENBAhBpGO6V6hWC3Rew8BQHK94kMIGcBgsqhkiG
9w0BCRACCzGBjKCBiTB1MQswCQYDVQQGEwJJTDEWMBQGA1UEChMNU3RhcnRDb20gTHRkLjEpMCcG
A1UECxMgU3RhcnRDb20gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkxIzAhBgNVBAMTGlN0YXJ0Q29t
IENsYXNzIDEgQ2xpZW50IENBAhBpGO6V6hWC3Rew8BQHK94kMA0GCSqGSIb3DQEBAQUABIICAFzV
kAnXBetaVQX1zFq/A1EMO0QlIMvpCh1K9b/h5JBQfCDm09ipkk4nmDDLowpclnSbmn1M9FBKnsOF
3j1NaHOZ9gRRkhlNgZHwCqvKHBmULRX7eosTfUEAX6vL2uV0w5iKK2jOyxPnxqMNo5UVNCaiDt26
G1YOQCbQC5CMbLUP39GNXol3Ehk/mfhP65ILWwK/06A9GuYNyaBb3r22U9s9kDGOk86CcQmn3peN
h1YORPa17NpBNB5aot6LMOLdnsAfjKrDwZYX0cKrDCmpvntw+axBAI6NqLx43inURruMvll6Xqmw
R1EjGfMfB3jiQbGIUlat9ksNV5747eUSMY1Sv7UBUBnD9+/mHdYwOQitnm4HFwoER4MQqrqjH7cM
p8NbaRjyi2kiAFj/Qr+ATBfTvAaVX80RHmT9ooIb+WD53DMJ2ZU9lmw6UF12UWqQVqvEB7hzafpH
RSVNQjeRugaCKHUyUyxepQPN1ITmrOXgNwBjjBbu/yWQ9wYIK9+7f+hx0MYs8Gq895hRZ+gFhga3
OjPO8+EsUXFX39oaqeKwIgpIYOpVf2sd+zA/p+Z1aSvC1wKotkJ2ItbBXCywysDTlE8I3dlJ5VPZ
Sa+xfq1hrhn0NCZg9N9r+p7SDw2FwjQ+1zHgqeLpDtgB44j6/R7qUGlxbvgEuEdvm8YhoY+BAAAA
AAAA


--=-lTM33zJzciafCfw03qsT--


--===============7005254187100769310==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7005254187100769310==--
