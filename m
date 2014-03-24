From: "Woodhouse, David" <david.woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 34/33] iommu/vt-d: Fix RCU annotations on device scope lists
Date: Mon, 24 Mar 2014 13:52:10 +0000
Message-ID: <1395669129.4880.224.camel@i7.infradead.org>
References: <1395422354-19762-1-git-send-email-David.Woodhouse@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6679737842548295845=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1395422354-19762-1-git-send-email-David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Cc: "Wu, Fengguang" <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============6679737842548295845==
Content-Language: en-US
Content-Type: multipart/signed; micalg=sha-1;
	protocol="application/x-pkcs7-signature"; boundary="=-+D7KA01C1K4/iOH0KQnh"

--=-+D7KA01C1K4/iOH0KQnh
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

In commit d78e0ac577 ("iommu/vt-d: Change scope lists to struct device,
bus, devfn") I converted the 'struct device *' arrays into an array of
'struct dmar_dev_scope', where:

struct dmar_dev_scope {
       struct device *dev;
       u8 bus;
       u8 devfn;
};

That commit contained changes such as this:

-extern void dmar_free_dev_scope(struct pci_dev __rcu ***devices, int *cnt)=
;
+extern void dmar_free_dev_scope(struct dmar_dev_scope __rcu **devices, int=
 *cnt);

This was wrong; it is the device pointer which needs to be protected
with RCU, and the above-cited change was moving the __rcu annotation so
that it actually referred to the enclosing structure, not the device
pointer itself.

Reported by the Intel 0-day build testing infrastructure. Thanks, Fengguang=
.

Signed-off-by: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/dmar.c        |  8 ++++----
 drivers/iommu/intel-iommu.c |  4 ++--
 include/linux/dmar.h        | 10 +++++-----
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index cd05a4b..56e1c79 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -100,7 +100,7 @@ void *dmar_alloc_dev_scope(void *start, void *end, int =
*cnt)
 	return kcalloc(*cnt, sizeof(struct dmar_dev_scope), GFP_KERNEL);
 }
=20
-void dmar_free_dev_scope(struct dmar_dev_scope __rcu **devices, int *cnt)
+void dmar_free_dev_scope(struct dmar_dev_scope **devices, int *cnt)
 {
 	int i;
 	struct device *tmp_dev;
@@ -191,7 +191,7 @@ static bool dmar_match_pci_path(struct dmar_pci_notify_=
info *info, int bus,
 /* Return: > 0 if match found, 0 if no match found, < 0 if error happens *=
/
 int dmar_insert_dev_scope(struct dmar_pci_notify_info *info,
 			  void *start, void*end, u16 segment,
-			  struct dmar_dev_scope __rcu *devices,
+			  struct dmar_dev_scope *devices,
 			  int devices_cnt)
 {
 	int i, level;
@@ -235,7 +235,7 @@ int dmar_insert_dev_scope(struct dmar_pci_notify_info *=
info,
 }
=20
 int dmar_remove_dev_scope(struct dmar_pci_notify_info *info, u16 segment,
-			  struct dmar_dev_scope __rcu *devices, int count)
+			  struct dmar_dev_scope *devices, int count)
 {
 	int index;
 	struct device *tmp;
@@ -565,7 +565,7 @@ parse_dmar_table(void)
 	return ret;
 }
=20
-static int dmar_pci_device_match(struct dmar_dev_scope __rcu devices[],
+static int dmar_pci_device_match(struct dmar_dev_scope devices[],
 				 int cnt, struct pci_dev *dev)
 {
 	int index;
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 53996d9..6fbce01 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -381,14 +381,14 @@ struct dmar_rmrr_unit {
 	struct acpi_dmar_header *hdr;	/* ACPI header		*/
 	u64	base_address;		/* reserved base address*/
 	u64	end_address;		/* reserved end address */
-	struct dmar_dev_scope __rcu *devices;	/* target devices */
+	struct dmar_dev_scope *devices;	/* target devices */
 	int	devices_cnt;		/* target device count */
 };
=20
 struct dmar_atsr_unit {
 	struct list_head list;		/* list of ATSR units */
 	struct acpi_dmar_header *hdr;	/* ACPI header */
-	struct dmar_dev_scope __rcu *devices;	/* target devices */
+	struct dmar_dev_scope *devices;	/* target devices */
 	int devices_cnt;		/* target device count */
 	u8 include_all:1;		/* include all ports */
 };
diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index 4c2caab..23c8db1 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -37,7 +37,7 @@ struct acpi_dmar_header;
 struct intel_iommu;
=20
 struct dmar_dev_scope {
-	struct device *dev;
+	struct device __rcu *dev;
 	u8 bus;
 	u8 devfn;
 };
@@ -48,7 +48,7 @@ struct dmar_drhd_unit {
 	struct list_head list;		/* list of drhd units	*/
 	struct  acpi_dmar_header *hdr;	/* ACPI header		*/
 	u64	reg_base_addr;		/* register base address*/
-	struct	dmar_dev_scope __rcu *devices;/* target device array	*/
+	struct	dmar_dev_scope *devices;/* target device array	*/
 	int	devices_cnt;		/* target device count	*/
 	u16	segment;		/* PCI domain		*/
 	u8	ignored:1; 		/* ignore drhd		*/
@@ -103,13 +103,13 @@ extern int dmar_dev_scope_init(void);
 extern int dmar_parse_dev_scope(void *start, void *end, int *cnt,
 				struct dmar_dev_scope **devices, u16 segment);
 extern void *dmar_alloc_dev_scope(void *start, void *end, int *cnt);
-extern void dmar_free_dev_scope(struct dmar_dev_scope __rcu **devices, int=
 *cnt);
+extern void dmar_free_dev_scope(struct dmar_dev_scope **devices, int *cnt)=
;
 extern int dmar_insert_dev_scope(struct dmar_pci_notify_info *info,
 				 void *start, void*end, u16 segment,
-				 struct dmar_dev_scope __rcu *devices,
+				 struct dmar_dev_scope *devices,
 				 int devices_cnt);
 extern int dmar_remove_dev_scope(struct dmar_pci_notify_info *info,
-				 u16 segment, struct dmar_dev_scope __rcu *devices,
+				 u16 segment, struct dmar_dev_scope *devices,
 				 int count);
 /* Intel IOMMU detection */
 extern int detect_intel_iommu(void);
--=20
1.8.5.3


--=20
David Woodhouse                            Open Source Technology Centre
David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org                              Intel Corporation

--=-+D7KA01C1K4/iOH0KQnh
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIVTDCCAz0w
ggKmoAMCAQICAwWw/zANBgkqhkiG9w0BAQUFADBOMQswCQYDVQQGEwJVUzEQMA4GA1UEChMHRXF1
aWZheDEtMCsGA1UECxMkRXF1aWZheCBTZWN1cmUgQ2VydGlmaWNhdGUgQXV0aG9yaXR5MB4XDTA2
MDIxNjE4MDEzMFoXDTE2MDIxOTE4MDEzMFowUjELMAkGA1UEBhMCVVMxGjAYBgNVBAoTEUludGVs
IENvcnBvcmF0aW9uMScwJQYDVQQDEx5JbnRlbCBFeHRlcm5hbCBCYXNpYyBQb2xpY3kgQ0EwggEi
MA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDBpd/XOb9QVqEZ8mQ1042TdOIq3ATDIsV2xDyt
30yLyMR5Wjtus0bn3B+he89BiNO/LP6+rFzEwlD55PlX+HLGIKeNNG97dqyc30FElEUjZzTZFq2N
4e3kVJ/XAEEgANzV8v9qp7qWwxugPgfc3z9BkYot+CifozexHLb/hEZj+yISCU61kRZvuSQ0E11y
YL4dRgcglJeaHo3oX57rvIckaLsYV5/1Aj+R8DM1Ppk965XQAKsHfnyT7C4S50T4lVn4lz36wOdN
Zn/zegG1zp41lnoTFfT4KuKVJH5x7YD1p6KbgJCKLovnujGuohquBNfdXKpZkvz6pGv+iC1HawJd
AgMBAAGjgaAwgZ0wDgYDVR0PAQH/BAQDAgEGMB0GA1UdDgQWBBQaxgxKxEdvqNutK/D0Vgaj7TdU
DDA6BgNVHR8EMzAxMC+gLaArhilodHRwOi8vY3JsLmdlb3RydXN0LmNvbS9jcmxzL3NlY3VyZWNh
LmNybDAfBgNVHSMEGDAWgBRI5mj5K9KylddH2CMgEE8zmJCf1DAPBgNVHRMBAf8EBTADAQH/MA0G
CSqGSIb3DQEBBQUAA4GBABMQOK2kVKVIlUWwLTdywJ+e2O+PC/uQltK2F3lRyrPfBn69tOkIP4Sg
DJOfsxyobIrPLe75kBLw+Dom13OBDp/EMZJZ1CglQfVV8co9mT3aZMjSGGQiMgkJLR3jMfr900fX
ZKj5XeqCJ+JP0mEhJGEdVCY+FFlksJjV86fDrq1QMIIFijCCBHKgAwIBAgIKYR6AtwAAAAAABzAN
BgkqhkiG9w0BAQUFADBSMQswCQYDVQQGEwJVUzEaMBgGA1UEChMRSW50ZWwgQ29ycG9yYXRpb24x
JzAlBgNVBAMTHkludGVsIEV4dGVybmFsIEJhc2ljIFBvbGljeSBDQTAeFw0wOTA1MTUxOTI1MTNa
Fw0xNTA1MTUxOTM1MTNaMFYxCzAJBgNVBAYTAlVTMRowGAYDVQQKExFJbnRlbCBDb3Jwb3JhdGlv
bjErMCkGA1UEAxMiSW50ZWwgRXh0ZXJuYWwgQmFzaWMgSXNzdWluZyBDQSAzQTCCASIwDQYJKoZI
hvcNAQEBBQADggEPADCCAQoCggEBAMGPgGLnOO5IOzlHRfr1XfCVb97V4BR2QVpPZ7CrcIQ+FGa2
KHD/6dPjwxOIrtFTdfW4BYikdFmxUZVBWRWZ5Vye2cCdGzFWqIEOE1e17nNx1jM8Z6GZEqbDUS+v
BuPlBFHKQoVm5BaNIHpyn2XZxqwjV9j5/crIfPrCGstk+2ztUhVS8OHEgzO784PgD9pOgBnnAbZH
mEM1FYYmQ6ibS+gVCHzobDYG+YReRiHpFKWBxpUuP+X0WYFw/Ja1JW7N8pELAFDw0UFBWFgiv1QI
usdLvSy8mcsLJ5wy050OVcxShqoUxhw/wvyuuoQxvmEPjhRa1C2oSCmGN0003GMhQWMCAwEAAaOC
AlwwggJYMA8GA1UdEwEB/wQFMAMBAf8wHQYDVR0OBBYEFKoWZq+3PVZTYK4Nwu3z7gfLUWB+MAsG
A1UdDwQEAwIBhjASBgkrBgEEAYI3FQEEBQIDAQABMCMGCSsGAQQBgjcVAgQWBBTCKwhTx+hdMsKC
gOmWwLgjQsAV+TAZBgkrBgEEAYI3FAIEDB4KAFMAdQBiAEMAQTAfBgNVHSMEGDAWgBQaxgxKxEdv
qNutK/D0Vgaj7TdUDDCBvQYDVR0fBIG1MIGyMIGvoIGsoIGphk5odHRwOi8vd3d3LmludGVsLmNv
bS9yZXBvc2l0b3J5L0NSTC9JbnRlbCUyMEV4dGVybmFsJTIwQmFzaWMlMjBQb2xpY3klMjBDQS5j
cmyGV2h0dHA6Ly9jZXJ0aWZpY2F0ZXMuaW50ZWwuY29tL3JlcG9zaXRvcnkvQ1JML0ludGVsJTIw
RXh0ZXJuYWwlMjBCYXNpYyUyMFBvbGljeSUyMENBLmNybDCB4wYIKwYBBQUHAQEEgdYwgdMwYwYI
KwYBBQUHMAKGV2h0dHA6Ly93d3cuaW50ZWwuY29tL3JlcG9zaXRvcnkvY2VydGlmaWNhdGVzL0lu
dGVsJTIwRXh0ZXJuYWwlMjBCYXNpYyUyMFBvbGljeSUyMENBLmNydDBsBggrBgEFBQcwAoZgaHR0
cDovL2NlcnRpZmljYXRlcy5pbnRlbC5jb20vcmVwb3NpdG9yeS9jZXJ0aWZpY2F0ZXMvSW50ZWwl
MjBFeHRlcm5hbCUyMEJhc2ljJTIwUG9saWN5JTIwQ0EuY3J0MA0GCSqGSIb3DQEBBQUAA4IBAQCU
Y/1d0MS6VPTlIcOho1XWh193PD5kJDJSPdphLHQdM1oKA+whMdIBoY1VzTDDK+C+Ey4Jcyna7fpC
8uVmn/Rz/i9MZtyc7qezPtZTn9UyORvJmddH+Ox/RycGwe3ags8jUdspECorYOkJyZksnDIlTVUv
bR7wyY+gGJYqxWXqrcVFEiMsWu8/OIlf7F2gAYMBw1kZ55dn4lWBIM0WqvReWpPvhYeN7Y+3MKEd
SMkQ7TZiNbfdZ5D/8KfWNMTJ4VHltOgCL1lA5tx/F4R1920skpL5eu3Sj650RUe3rOXsaV5NyJzB
wB31+1zsmleVdFD0k/Fw9HxXbAQE35ucN/7CMIIGFzCCBP+gAwIBAgIKEIhPUAABAABfaTANBgkq
hkiG9w0BAQUFADBWMQswCQYDVQQGEwJVUzEaMBgGA1UEChMRSW50ZWwgQ29ycG9yYXRpb24xKzAp
BgNVBAMTIkludGVsIEV4dGVybmFsIEJhc2ljIElzc3VpbmcgQ0EgM0EwHhcNMTEwNDEyMTIzMzQx
WhcNMTQwMzI3MTIzMzQxWjBFMRkwFwYDVQQDExBXb29kaG91c2UsIERhdmlkMSgwJgYJKoZIhvcN
AQkBFhlkYXZpZC53b29kaG91c2VAaW50ZWwuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIB
CgKCAQEAvxW1JMLaZUeM6Cg2OVV1nfsZOt9x/CjVJ7SBlapefSjUoNT48n58zLK+Q00YxPkIxnwl
m57dAxSUf/Dqg+C6DOdLknVQILrGeWNSZdC8GQ8HlHz+D5ldgTDY9L1vDM65p1wbXW4R5QfMbooZ
IQKlyUivGkggwBUpTeeXDOfz5f4m2UW5aCnyG8yhiBUHISAQyXLwQg+iVhBpTqsVvvojybQY8lGF
Z7U+kgbgBY0HCqOuEmT7Iz/tm4W3dpfh8mFluZUn1fMBvCaC+cdKVV/1lpeUdtMNREH+jKUU49lt
BblH1qXmEViOvMT4itbfkUSWeWgeI9umMOK4eL31LLepCQIDAQABo4IC9jCCAvIwCwYDVR0PBAQD
AgeAMDwGCSsGAQQBgjcVBwQvMC0GJSsGAQQBgjcVCIbDjHWEmeVRg/2BKIWOn1OCkcAJZ4HevTmV
8EMCAWQCAQgwHQYDVR0OBBYEFMcuq9ocKJ7EbWcVlAWTYVXwOsrHMB8GA1UdIwQYMBaAFKoWZq+3
PVZTYK4Nwu3z7gfLUWB+MIHPBgNVHR8EgccwgcQwgcGggb6ggbuGV2h0dHA6Ly93d3cuaW50ZWwu
Y29tL3JlcG9zaXRvcnkvQ1JML0ludGVsJTIwRXh0ZXJuYWwlMjBCYXNpYyUyMElzc3VpbmclMjBD
QSUyMDNBKDEpLmNybIZgaHR0cDovL2NlcnRpZmljYXRlcy5pbnRlbC5jb20vcmVwb3NpdG9yeS9D
UkwvSW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIwSXNzdWluZyUyMENBJTIwM0EoMSkuY3JsMIH1
BggrBgEFBQcBAQSB6DCB5TBsBggrBgEFBQcwAoZgaHR0cDovL3d3dy5pbnRlbC5jb20vcmVwb3Np
dG9yeS9jZXJ0aWZpY2F0ZXMvSW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIwSXNzdWluZyUyMENB
JTIwM0EoMSkuY3J0MHUGCCsGAQUFBzAChmlodHRwOi8vY2VydGlmaWNhdGVzLmludGVsLmNvbS9y
ZXBvc2l0b3J5L2NlcnRpZmljYXRlcy9JbnRlbCUyMEV4dGVybmFsJTIwQmFzaWMlMjBJc3N1aW5n
JTIwQ0ElMjAzQSgxKS5jcnQwHwYDVR0lBBgwFgYIKwYBBQUHAwQGCisGAQQBgjcKAwwwKQYJKwYB
BAGCNxUKBBwwGjAKBggrBgEFBQcDBDAMBgorBgEEAYI3CgMMME8GA1UdEQRIMEagKQYKKwYBBAGC
NxQCA6AbDBlkYXZpZC53b29kaG91c2VAaW50ZWwuY29tgRlkYXZpZC53b29kaG91c2VAaW50ZWwu
Y29tMA0GCSqGSIb3DQEBBQUAA4IBAQBxLiiAAGnWEDYYtUaje48WjSbMx8O+TsKX2x1sgi/ilnUR
evhznvvFGx9hRrTtQ4Sz+hU7nWvoxbSLDVx6vDQ7+wyGo6SzE0MYqwB3EzwO/P8MnpgZTlEmgDeP
GjYX2IFzp5fG7NNvc6byf8pLjXgn+2wqRLUqrh2PZZ5KKIiicVNT+UOlRIbB2T1WuSVHBMQxhQBr
rzwwYuyoawJCHHo+eKUE51cSSzkT95K+m0Q6XYGC8tQ3i94nBIaLMIg/GM6K2cYKH3vdu/otvGPl
j9/HEKo+mktp2A2S5sIwCKlw8nYOaYKe1dpmYtXKfVoOIIZ/LaVEB/XEIEC1x/oPbrH/MIIGXjCC
BUagAwIBAgIKEI638AABAABfajANBgkqhkiG9w0BAQUFADBWMQswCQYDVQQGEwJVUzEaMBgGA1UE
ChMRSW50ZWwgQ29ycG9yYXRpb24xKzApBgNVBAMTIkludGVsIEV4dGVybmFsIEJhc2ljIElzc3Vp
bmcgQ0EgM0EwHhcNMTEwNDEyMTI0MDM5WhcNMTQwMzI3MTI0MDM5WjBFMRkwFwYDVQQDExBXb29k
aG91c2UsIERhdmlkMSgwJgYJKoZIhvcNAQkBFhlkYXZpZC53b29kaG91c2VAaW50ZWwuY29tMIIB
IjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAsm0RhbzQLRYFSlgFDKSsMvzFctyPQbT8P55g
gj3ZQuklaFo8CLXd3rODycyKauFT/IxEq8udUyanZXLSWdWQuuhrkG9bMnkDy1+KQSaEqgKPHMUT
1sYMyGFoDr4YDnmGLfpQWrBHUT+hwFuBUAqQRndQZbZK8TaOAX55hjNJEVWzXzaJNFb0ZFiaJ8Tl
SY+RA7NS0jv7gsCvV2LamrDZJ0Ht0YZLOenhDzVjph4dUY/2XFv2ceGZSUOyrMiVdkC7hpira+4e
CY5BKboFZluzg+URRnRd/EH08ilHzGxEaKheC99QVCgVl6qI0GguHnTReIU+QBN6D6Aj3kTbUZSw
ywIDAQABo4IDPTCCAzkwCwYDVR0PBAQDAgQwMD0GCSsGAQQBgjcVBwQwMC4GJisGAQQBgjcVCIbD
jHWEmeVRg/2BKIWOn1OCkcAJZ4S52UGHhP9OAgFkAgEMMEQGCSqGSIb3DQEJDwQ3MDUwDgYIKoZI
hvcNAwICAgCAMA4GCCqGSIb3DQMEAgIAgDAHBgUrDgMCBzAKBggqhkiG9w0DBzAdBgNVHQ4EFgQU
anqVzAq92pn3diJlPhvbx6wENA0wHwYDVR0jBBgwFoAUqhZmr7c9VlNgrg3C7fPuB8tRYH4wgc8G
A1UdHwSBxzCBxDCBwaCBvqCBu4ZXaHR0cDovL3d3dy5pbnRlbC5jb20vcmVwb3NpdG9yeS9DUkwv
SW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIwSXNzdWluZyUyMENBJTIwM0EoMSkuY3JshmBodHRw
Oi8vY2VydGlmaWNhdGVzLmludGVsLmNvbS9yZXBvc2l0b3J5L0NSTC9JbnRlbCUyMEV4dGVybmFs
JTIwQmFzaWMlMjBJc3N1aW5nJTIwQ0ElMjAzQSgxKS5jcmwwgfUGCCsGAQUFBwEBBIHoMIHlMGwG
CCsGAQUFBzAChmBodHRwOi8vd3d3LmludGVsLmNvbS9yZXBvc2l0b3J5L2NlcnRpZmljYXRlcy9J
bnRlbCUyMEV4dGVybmFsJTIwQmFzaWMlMjBJc3N1aW5nJTIwQ0ElMjAzQSgxKS5jcnQwdQYIKwYB
BQUHMAKGaWh0dHA6Ly9jZXJ0aWZpY2F0ZXMuaW50ZWwuY29tL3JlcG9zaXRvcnkvY2VydGlmaWNh
dGVzL0ludGVsJTIwRXh0ZXJuYWwlMjBCYXNpYyUyMElzc3VpbmclMjBDQSUyMDNBKDEpLmNydDAf
BgNVHSUEGDAWBggrBgEFBQcDBAYKKwYBBAGCNwoDBDApBgkrBgEEAYI3FQoEHDAaMAoGCCsGAQUF
BwMEMAwGCisGAQQBgjcKAwQwTwYDVR0RBEgwRqApBgorBgEEAYI3FAIDoBsMGWRhdmlkLndvb2Ro
b3VzZUBpbnRlbC5jb22BGWRhdmlkLndvb2Rob3VzZUBpbnRlbC5jb20wDQYJKoZIhvcNAQEFBQAD
ggEBAIPoSUpUKiFzHvdhFZZAOQkn8UkNJu7E2TWKvlry/gpFf9Ra257sBA4s15nUGuS59M3bmnCe
n9C36IDHuQS3PQeY/DQ2lq26ZVZIiQScz/5hREJ1ZgvSlBJqwwdWEiy6BCKRInFpLfE7fMo3PmML
UcRaFDmYby1BcigEZP14fwa5kGZMOEJGicqeG76jftkAN03RXy0fQaTe2AdvSR/oAYbuY4hn6w8V
3XBcAxUHN9DIzgawtAnj5X5Lal9nOoq3jgAYGGL0upc5dEMNvygjFwzVVFnow1qaT8os8+UP/hla
Y33P2418t7KgL8M0AjtGOE1kUKZmGaV3ppkHI4ms9s4xggLYMIIC1AIBATBkMFYxCzAJBgNVBAYT
AlVTMRowGAYDVQQKExFJbnRlbCBDb3Jwb3JhdGlvbjErMCkGA1UEAxMiSW50ZWwgRXh0ZXJuYWwg
QmFzaWMgSXNzdWluZyBDQSAzQQIKEIhPUAABAABfaTAJBgUrDgMCGgUAoIIBSTAYBgkqhkiG9w0B
CQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xNDAzMjQxMzUyMDlaMCMGCSqGSIb3DQEJ
BDEWBBRMA4Em7OivRgdBF0W80qyUCNjOKzBzBgkrBgEEAYI3EAQxZjBkMFYxCzAJBgNVBAYTAlVT
MRowGAYDVQQKExFJbnRlbCBDb3Jwb3JhdGlvbjErMCkGA1UEAxMiSW50ZWwgRXh0ZXJuYWwgQmFz
aWMgSXNzdWluZyBDQSAzQQIKEI638AABAABfajB1BgsqhkiG9w0BCRACCzFmoGQwVjELMAkGA1UE
BhMCVVMxGjAYBgNVBAoTEUludGVsIENvcnBvcmF0aW9uMSswKQYDVQQDEyJJbnRlbCBFeHRlcm5h
bCBCYXNpYyBJc3N1aW5nIENBIDNBAgoQjrfwAAEAAF9qMA0GCSqGSIb3DQEBAQUABIIBACXo6tjY
NFzRWF6UL7bCzKDEvys1Oa8Tgqeasp3ymBH3TbcdoLYLhHedUX9ccBjbyIiYBgBHKc6taFV2T3da
8TsKTcaan4lyDP04LWQKYLLakqn0aCL+X3KgmEWae/3HO2dYYtPksDsQt8Mz++hja77uHg5c1UEf
2QFuO8TtsLeD6nVSnk0f4Uz/Q8UaMEmuiSACBrUHMQqyHni6Y80yqHMZHXBs/RD0LZIv0Crd8aab
rcfPO/3K/MUnlXzkeUZjeZo7tCNAixEUE/Wt6fLGw4tyfsYl00nvQm5qksiMoMS7QEgs8MlKANt2
8x780wlh9wORoRO6VwyP9VS9+VaU+UEAAAAAAAA=


--=-+D7KA01C1K4/iOH0KQnh--

--===============6679737842548295845==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6679737842548295845==--
