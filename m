From: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: [RFC PATCH] x86: Allow IOMMU drivers to Hook arch_setup_dma_ops()
Date: Sun, 30 Oct 2016 13:14:49 -0600
Message-ID: <1477854889.14501.6.camel@woodhou.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6831259329490499903=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============6831259329490499903==
Content-Type: multipart/signed; micalg="sha-256";
	protocol="application/x-pkcs7-signature";
	boundary="=-KaCeZz8J1jjDxw2acaaO"


--=-KaCeZz8J1jjDxw2acaaO
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The Intel IOMMU code registers a notifier and plays nasty tricks to fill
device pointers in with its DMAR scope tables when devices are detected,
then later compares the device pointers in those tables when it needs to
find the IOMMU unit for a given device.

If we let it use arch_setup_dma_ops() to match the device to an IOMMU
unit at device_register() time, this gets a whole lot saner.

Signed-off-by: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
---
Of course it's still not actually *sane*. We have per-device DMA ops,
but per-bus IOMMU ops. What we actually want to do is ditch the DMA ops
entirely and simply do it all through the IOMMU ops, like ARM does in
its arch/arm/mm/dma-mapping.c. I think we can do an iova-dma-mapping.c
with just an additional flag in the IOMMU domain which says that it can
do lazy unmaps.=C2=A0

And IOMMU ops should be per-device of course, not per-bus. But this is
a start...

=C2=A0arch/x86/include/asm/dma-mapping.h | 2 ++
=C2=A0arch/x86/include/asm/x86_init.h=C2=A0=C2=A0=C2=A0=C2=A0| 3 +++
=C2=A0arch/x86/kernel/x86_init.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0| 3 +++
=C2=A03 files changed, 8 insertions(+)

diff --git a/arch/x86/include/asm/dma-mapping.h b/arch/x86/include/asm/dma-=
mapping.h
index 4446162..b3888a0 100644
--- a/arch/x86/include/asm/dma-mapping.h
+++ b/arch/x86/include/asm/dma-mapping.h
@@ -42,6 +42,8 @@ static inline struct dma_map_ops *get_dma_ops(struct devi=
ce *dev)
=C2=A0bool arch_dma_alloc_attrs(struct device **dev, gfp_t *gfp);
=C2=A0#define arch_dma_alloc_attrs arch_dma_alloc_attrs
=C2=A0
+#define arch_setup_dma_ops x86_platform.iommu_setup_dma_ops
+
=C2=A0#define HAVE_ARCH_DMA_SUPPORTED 1
=C2=A0extern int dma_supported(struct device *hwdev, u64 mask);
=C2=A0
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_ini=
t.h
index 6ba7931..6872dcc 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -7,6 +7,7 @@ struct mpc_bus;
=C2=A0struct mpc_cpu;
=C2=A0struct mpc_table;
=C2=A0struct cpuinfo_x86;
+struct iommu_ops;
=C2=A0
=C2=A0/**
=C2=A0 * struct x86_init_mpparse - platform specific mpparse ops
@@ -207,6 +208,8 @@ struct x86_platform_ops {
=C2=A0	void (*get_wallclock)(struct timespec *ts);
=C2=A0	int (*set_wallclock)(const struct timespec *ts);
=C2=A0	void (*iommu_shutdown)(void);
+	void (*iommu_setup_dma_ops)(struct device *dev, u64 dma_base, u64 size,
+				=C2=A0=C2=A0=C2=A0=C2=A0const struct iommu_ops *iommu, bool coherent);
=C2=A0	bool (*is_untracked_pat_range)(u64 start, u64 end);
=C2=A0	void (*nmi_init)(void);
=C2=A0	unsigned char (*get_nmi_reason)(void);
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index 0bd9f12..5e54a72 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -28,6 +28,8 @@ void x86_init_noop(void) { }
=C2=A0void __init x86_init_uint_noop(unsigned int unused) { }
=C2=A0int __init iommu_init_noop(void) { return 0; }
=C2=A0void iommu_shutdown_noop(void) { }
+void iommu_setup_dma_ops_noop(struct device *dev, u64 dma_base, u64 size,
+			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const struct iommu_ops *iommu, bool=
 coherent) { }
=C2=A0
=C2=A0/*
=C2=A0 * The platform setup functions are preset with the default functions
@@ -97,6 +99,7 @@ struct x86_platform_ops x86_platform __ro_after_init =3D =
{
=C2=A0	.get_wallclock			=3D mach_get_cmos_time,
=C2=A0	.set_wallclock			=3D mach_set_rtc_mmss,
=C2=A0	.iommu_shutdown			=3D iommu_shutdown_noop,
+	.iommu_setup_dma_ops		=3D iommu_setup_dma_ops_noop,
=C2=A0	.is_untracked_pat_range		=3D is_ISA_range,
=C2=A0	.nmi_init			=3D default_nmi_init,
=C2=A0	.get_nmi_reason			=3D default_get_nmi_reason,
--=C2=A0
2.5.5

--=-KaCeZz8J1jjDxw2acaaO
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCEuYw
ggY0MIIEHKADAgECAgEgMA0GCSqGSIb3DQEBBQUAMH0xCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1T
dGFydENvbSBMdGQuMSswKQYDVQQLEyJTZWN1cmUgRGlnaXRhbCBDZXJ0aWZpY2F0ZSBTaWduaW5n
MSkwJwYDVQQDEyBTdGFydENvbSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTAeFw0wNzEwMjQyMTAy
NTVaFw0xNzEwMjQyMTAyNTVaMIGMMQswCQYDVQQGEwJJTDEWMBQGA1UEChMNU3RhcnRDb20gTHRk
LjErMCkGA1UECxMiU2VjdXJlIERpZ2l0YWwgQ2VydGlmaWNhdGUgU2lnbmluZzE4MDYGA1UEAxMv
U3RhcnRDb20gQ2xhc3MgMiBQcmltYXJ5IEludGVybWVkaWF0ZSBDbGllbnQgQ0EwggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDLKIVFnAEs+xnyq6UzjCqgDcvQVe1dIoFnRsQPCFO+y92k
8RK0Pn3MbQ2Gd+mehh9GBZ+36uUQA7Xj9AGM6wgPhEE34vKtfpAN5tJ8LcFxveDObCKrL7O5UT9W
snAZHv7OYPYSR68mdmnEnJ83M4wQgKO19b+Rt8sPDAz9ptkQsntCn4GeJzg3q2SVc4QJTg/WHo7w
F2ah5LMOeh8xJVSKGEmd6uPkSbj113yKMm8vmNptRPmM1+YgmVwcdOYJOjCgFtb2sOP79jji8uhW
R91xx7TpM1K3hv/wrBZwffrmmEpUeuXHRs07JqCCvFh9coKF4UQZvfEg+x3/69xRCzb1AgMBAAGj
ggGtMIIBqTAPBgNVHRMBAf8EBTADAQH/MA4GA1UdDwEB/wQEAwIBBjAdBgNVHQ4EFgQUrlWDb+wx
yrn3HfqvazHzyB3jrLswHwYDVR0jBBgwFoAUTgvvGqRAW6UXaYcwyjRoQ9BBrvIwZgYIKwYBBQUH
AQEEWjBYMCcGCCsGAQUFBzABhhtodHRwOi8vb2NzcC5zdGFydHNzbC5jb20vY2EwLQYIKwYBBQUH
MAKGIWh0dHA6Ly93d3cuc3RhcnRzc2wuY29tL3Nmc2NhLmNydDBbBgNVHR8EVDBSMCegJaAjhiFo
dHRwOi8vd3d3LnN0YXJ0c3NsLmNvbS9zZnNjYS5jcmwwJ6AloCOGIWh0dHA6Ly9jcmwuc3RhcnRz
c2wuY29tL3Nmc2NhLmNybDCBgAYDVR0gBHkwdzB1BgsrBgEEAYG1NwECATBmMC4GCCsGAQUFBwIB
FiJodHRwOi8vd3d3LnN0YXJ0c3NsLmNvbS9wb2xpY3kucGRmMDQGCCsGAQUFBwIBFihodHRwOi8v
d3d3LnN0YXJ0c3NsLmNvbS9pbnRlcm1lZGlhdGUucGRmMA0GCSqGSIb3DQEBBQUAA4ICAQA6qScN
yNO0FpHvaZTQacVMXH33O51KyEKSRw3IvdQxRu31YR0ZDGdSfgSoOVDVMSBSdmfQfdDInHPzV3LO
5DwUXZ+lxjv7z3PO2OkfnFkvTXPfn6dxJ5rJveDsTsCPcJ/Kp6/+qN5g+J6D/SaYcFD018B6L42r
0Z4VEBy36P4tjRtF14Ex10tl5tJFVKM16qWKQHbpjIgf73s49UB0CQ5lHT2DHKfq3oPfdNc5Mk93
w1v4ryVb+qVrZIej8NsrWU+5r4O2IV91edDb/OtHFddZqHFFXKgS79IHE/hwQ2LW7r3sTX7cDUCg
+dfdwO8zeLxuwk2JF8crUoyrl66RGrRIhT8VoG/OJ1Y9uUlOav69V4cG8upi4ZG2l7JZFbcBFk91
Wp+Payo5SuF61CmGFrZ386umkmpObtFacXda2O/bVoQ9xHQrzoTc/0KZTWvlZCLK3Ke/vGYT9ZdW
9lOjGsSFbXrlTA919L84iMK+48WGnvRWY28ZaVHpql43AtEGhXze6iNCbEDACy+4hkQYOytAqDgc
xAnQ937mYpeZFPyz/XK9QSt9VNFMuudWxZwDDDJKoQAoSG59Hou9lZ26UrK60nRdAQBmEPL8h2nu
WgoPh++XVQld9yuhbsWa39Pck8/lcfz5HUVGJF5mc/zk38iV7FDlF68puiryNq2KXHEpOTCCBlMw
ggU7oAMCAQICAmWZMA0GCSqGSIb3DQEBCwUAMIGMMQswCQYDVQQGEwJJTDEWMBQGA1UEChMNU3Rh
cnRDb20gTHRkLjErMCkGA1UECxMiU2VjdXJlIERpZ2l0YWwgQ2VydGlmaWNhdGUgU2lnbmluZzE4
MDYGA1UEAxMvU3RhcnRDb20gQ2xhc3MgMiBQcmltYXJ5IEludGVybWVkaWF0ZSBDbGllbnQgQ0Ew
HhcNMTUwNTA0MTcwMjUxWhcNMTcwNTA0MjIyOTI0WjByMQswCQYDVQQGEwJHQjEOMAwGA1UECBMF
RXNzZXgxGDAWBgNVBAcTD0dyZWF0IEJhcmRmaWVsZDEYMBYGA1UEAxMPRGF2aWQgV29vZGhvdXNl
MR8wHQYJKoZIhvcNAQkBFhBkYXZpZEB3b29kaG91LnNlMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8A
MIIBCgKCAQEAsxgGIxIgXED6NrBUrJa9egyMCSZ3OAaxqQvhzlR3pxPF4N1pgnQoPsB+WCR6QLXy
Uh5Nm5H3C5H1QPevcqXOzH7nA4GvNlSG+9miQUpQCA0ij8YQVI5zITBgGwzw7DWT4QxRw5Ci2t+T
vk5cW7QXRxbgC/X6iR8vbog18D3e42X6b+LH8w4jLkTxb9rg8IGwWeJ7/iZBzX0vj0GDiEUtIztv
xxb5aIp/dBU/XJmysWMU3PfrLpms68+3fi5ufCMVYEZ2tH16cUYjd+phafc+iJ0HTIsD3tKsKYee
QbY5O4FZkk0bU1YypU+f34dMPmmIk5kBQOt/Ib2Nh8KYsW0ubQIDAQABo4IC1jCCAtIwCQYDVR0T
BAIwADALBgNVHQ8EBAMCBLAwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMB0GA1UdDgQW
BBSlidWOd/dYH3io9fatJpxNnMCZ+jAfBgNVHSMEGDAWgBSuVYNv7DHKufcd+q9rMfPIHeOsuzAb
BgNVHREEFDASgRBkYXZpZEB3b29kaG91LnNlMIIBTAYDVR0gBIIBQzCCAT8wggE7BgsrBgEEAYG1
NwECAzCCASowLgYIKwYBBQUHAgEWImh0dHA6Ly93d3cuc3RhcnRzc2wuY29tL3BvbGljeS5wZGYw
gfcGCCsGAQUFBwICMIHqMCcWIFN0YXJ0Q29tIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MAMCAQEa
gb5UaGlzIGNlcnRpZmljYXRlIHdhcyBpc3N1ZWQgYWNjb3JkaW5nIHRvIHRoZSBDbGFzcyAyIFZh
bGlkYXRpb24gcmVxdWlyZW1lbnRzIG9mIHRoZSBTdGFydENvbSBDQSBwb2xpY3ksIHJlbGlhbmNl
IG9ubHkgZm9yIHRoZSBpbnRlbmRlZCBwdXJwb3NlIGluIGNvbXBsaWFuY2Ugb2YgdGhlIHJlbHlp
bmcgcGFydHkgb2JsaWdhdGlvbnMuMDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuc3RhcnRz
c2wuY29tL2NydHUyLWNybC5jcmwwgY4GCCsGAQUFBwEBBIGBMH8wOQYIKwYBBQUHMAGGLWh0dHA6
Ly9vY3NwLnN0YXJ0c3NsLmNvbS9zdWIvY2xhc3MyL2NsaWVudC9jYTBCBggrBgEFBQcwAoY2aHR0
cDovL2FpYS5zdGFydHNzbC5jb20vY2VydHMvc3ViLmNsYXNzMi5jbGllbnQuY2EuY3J0MCMGA1Ud
EgQcMBqGGGh0dHA6Ly93d3cuc3RhcnRzc2wuY29tLzANBgkqhkiG9w0BAQsFAAOCAQEAlNTKPu9O
xEmqgP/2fCb/v2JN/quxT0VFJGB/E+pTdSLTf3HJaUHdqMrjvmFsmQkw1E3TOPEp3jarDxv0G1XF
9wR5KRjNq2N/13GV4c8BPdj0Jlsmr+xr/eNpVngxxvzAjV+7A8s9fMpm61Tns3bH8oJTAUkqRRb/
8e8htNxcAtFwEBs3ZfzH91Az/5uPF0EmFoSL8gz719e1u+ajBKrA2kUt9qLvkRvQY6u1FGuD6Gma
1/gP4flhbO0OHUYaRBX0pN2EvniYKWYItPFI8ilJruRiA3f5cg+fLM8x/7zVVv+bIATDv2RJgcvJ
ZOmpDT9hmwXjkJs7XE62Ze+KpVVChDCCBlMwggU7oAMCAQICAmWZMA0GCSqGSIb3DQEBCwUAMIGM
MQswCQYDVQQGEwJJTDEWMBQGA1UEChMNU3RhcnRDb20gTHRkLjErMCkGA1UECxMiU2VjdXJlIERp
Z2l0YWwgQ2VydGlmaWNhdGUgU2lnbmluZzE4MDYGA1UEAxMvU3RhcnRDb20gQ2xhc3MgMiBQcmlt
YXJ5IEludGVybWVkaWF0ZSBDbGllbnQgQ0EwHhcNMTUwNTA0MTcwMjUxWhcNMTcwNTA0MjIyOTI0
WjByMQswCQYDVQQGEwJHQjEOMAwGA1UECBMFRXNzZXgxGDAWBgNVBAcTD0dyZWF0IEJhcmRmaWVs
ZDEYMBYGA1UEAxMPRGF2aWQgV29vZGhvdXNlMR8wHQYJKoZIhvcNAQkBFhBkYXZpZEB3b29kaG91
LnNlMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAsxgGIxIgXED6NrBUrJa9egyMCSZ3
OAaxqQvhzlR3pxPF4N1pgnQoPsB+WCR6QLXyUh5Nm5H3C5H1QPevcqXOzH7nA4GvNlSG+9miQUpQ
CA0ij8YQVI5zITBgGwzw7DWT4QxRw5Ci2t+Tvk5cW7QXRxbgC/X6iR8vbog18D3e42X6b+LH8w4j
LkTxb9rg8IGwWeJ7/iZBzX0vj0GDiEUtIztvxxb5aIp/dBU/XJmysWMU3PfrLpms68+3fi5ufCMV
YEZ2tH16cUYjd+phafc+iJ0HTIsD3tKsKYeeQbY5O4FZkk0bU1YypU+f34dMPmmIk5kBQOt/Ib2N
h8KYsW0ubQIDAQABo4IC1jCCAtIwCQYDVR0TBAIwADALBgNVHQ8EBAMCBLAwHQYDVR0lBBYwFAYI
KwYBBQUHAwIGCCsGAQUFBwMEMB0GA1UdDgQWBBSlidWOd/dYH3io9fatJpxNnMCZ+jAfBgNVHSME
GDAWgBSuVYNv7DHKufcd+q9rMfPIHeOsuzAbBgNVHREEFDASgRBkYXZpZEB3b29kaG91LnNlMIIB
TAYDVR0gBIIBQzCCAT8wggE7BgsrBgEEAYG1NwECAzCCASowLgYIKwYBBQUHAgEWImh0dHA6Ly93
d3cuc3RhcnRzc2wuY29tL3BvbGljeS5wZGYwgfcGCCsGAQUFBwICMIHqMCcWIFN0YXJ0Q29tIENl
cnRpZmljYXRpb24gQXV0aG9yaXR5MAMCAQEagb5UaGlzIGNlcnRpZmljYXRlIHdhcyBpc3N1ZWQg
YWNjb3JkaW5nIHRvIHRoZSBDbGFzcyAyIFZhbGlkYXRpb24gcmVxdWlyZW1lbnRzIG9mIHRoZSBT
dGFydENvbSBDQSBwb2xpY3ksIHJlbGlhbmNlIG9ubHkgZm9yIHRoZSBpbnRlbmRlZCBwdXJwb3Nl
IGluIGNvbXBsaWFuY2Ugb2YgdGhlIHJlbHlpbmcgcGFydHkgb2JsaWdhdGlvbnMuMDYGA1UdHwQv
MC0wK6ApoCeGJWh0dHA6Ly9jcmwuc3RhcnRzc2wuY29tL2NydHUyLWNybC5jcmwwgY4GCCsGAQUF
BwEBBIGBMH8wOQYIKwYBBQUHMAGGLWh0dHA6Ly9vY3NwLnN0YXJ0c3NsLmNvbS9zdWIvY2xhc3My
L2NsaWVudC9jYTBCBggrBgEFBQcwAoY2aHR0cDovL2FpYS5zdGFydHNzbC5jb20vY2VydHMvc3Vi
LmNsYXNzMi5jbGllbnQuY2EuY3J0MCMGA1UdEgQcMBqGGGh0dHA6Ly93d3cuc3RhcnRzc2wuY29t
LzANBgkqhkiG9w0BAQsFAAOCAQEAlNTKPu9OxEmqgP/2fCb/v2JN/quxT0VFJGB/E+pTdSLTf3HJ
aUHdqMrjvmFsmQkw1E3TOPEp3jarDxv0G1XF9wR5KRjNq2N/13GV4c8BPdj0Jlsmr+xr/eNpVngx
xvzAjV+7A8s9fMpm61Tns3bH8oJTAUkqRRb/8e8htNxcAtFwEBs3ZfzH91Az/5uPF0EmFoSL8gz7
19e1u+ajBKrA2kUt9qLvkRvQY6u1FGuD6Gma1/gP4flhbO0OHUYaRBX0pN2EvniYKWYItPFI8ilJ
ruRiA3f5cg+fLM8x/7zVVv+bIATDv2RJgcvJZOmpDT9hmwXjkJs7XE62Ze+KpVVChDGCA3wwggN4
AgEBMIGTMIGMMQswCQYDVQQGEwJJTDEWMBQGA1UEChMNU3RhcnRDb20gTHRkLjErMCkGA1UECxMi
U2VjdXJlIERpZ2l0YWwgQ2VydGlmaWNhdGUgU2lnbmluZzE4MDYGA1UEAxMvU3RhcnRDb20gQ2xh
c3MgMiBQcmltYXJ5IEludGVybWVkaWF0ZSBDbGllbnQgQ0ECAmWZMA0GCWCGSAFlAwQCAQUAoIIB
uTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xNjEwMzAxOTE0NDla
MC8GCSqGSIb3DQEJBDEiBCBRBAumMtn1CRf1n0wVchqNLZLZASegDTFAebZGi7lBtTCBpAYJKwYB
BAGCNxAEMYGWMIGTMIGMMQswCQYDVQQGEwJJTDEWMBQGA1UEChMNU3RhcnRDb20gTHRkLjErMCkG
A1UECxMiU2VjdXJlIERpZ2l0YWwgQ2VydGlmaWNhdGUgU2lnbmluZzE4MDYGA1UEAxMvU3RhcnRD
b20gQ2xhc3MgMiBQcmltYXJ5IEludGVybWVkaWF0ZSBDbGllbnQgQ0ECAmWZMIGmBgsqhkiG9w0B
CRACCzGBlqCBkzCBjDELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0YXJ0Q29tIEx0ZC4xKzApBgNV
BAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRlIFNpZ25pbmcxODA2BgNVBAMTL1N0YXJ0Q29t
IENsYXNzIDIgUHJpbWFyeSBJbnRlcm1lZGlhdGUgQ2xpZW50IENBAgJlmTANBgkqhkiG9w0BAQEF
AASCAQCm3ulDakjU8Bpur9glkukii92jWHOU/5v4oTajFgcaNuKI8GdaScCQdpKn1TNkZoIp/feJ
M7ibJcl0W/Py+qLniBjScGjKQzoOhENdjd9WKwy79BOZvDra8ZXYAj90Cquq0NaJ3GYmvhEWw8ih
fH+BNoOGw38Zbalq7kPZip2BHjMP+NsRhs4wWns3YNP854JOLjNNaV88UKou4gitYRND0kFYJk5t
rmgCjxNRViLlXKmKWE1NIif+ppEvXL4PepR+PbTcUUyh25SzAxy7PN9qtyBtnI/kOHYS7vYfaqoT
FT126Qo2/oI5VOg/CK34OMGXCBboLkZdw86f7lGEouVnAAAAAAAA


--=-KaCeZz8J1jjDxw2acaaO--


--===============6831259329490499903==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6831259329490499903==--
