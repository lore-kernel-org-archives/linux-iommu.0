From: David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH 7/7] iommu/vt-d: Implement page request handling
Date: Fri, 09 Oct 2015 00:54:07 +0100
Message-ID: <1444348447.92154.35.camel@infradead.org>
References: <1444348223.92154.22.camel@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0054167925=="
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <1444348223.92154.22.camel@infradead.org>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: iommu@lists.linux-foundation.org, intel-gfx@lists.freedesktop.org, jesse.barnes@intel.com
List-Id: iommu@lists.linux-foundation.org


--===============0054167925==
Content-Type: multipart/signed; micalg="sha-1"; protocol="application/x-pkcs7-signature";
	boundary="=-1I1XYc84ivNUmmPJAub1"


--=-1I1XYc84ivNUmmPJAub1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Signed-off-by: David Woodhouse <David.Woodhouse@intel.com>
---
 drivers/iommu/intel-svm.c   | 115 ++++++++++++++++++++++++++++++++++++++++=
+++-
 include/linux/intel-iommu.h |  21 ++++++++
 2 files changed, 134 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 1260e87..ace1e32 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -356,10 +356,121 @@ int intel_svm_unbind_mm(struct device *dev, int pasi=
d)
 }
 EXPORT_SYMBOL_GPL(intel_svm_unbind_mm);
=20
+/* Page request queue descriptor */
+struct page_req_dsc {
+	u64 srr:1;
+	u64 bof:1;
+	u64 pasid_present:1;
+	u64 lpig:1;
+	u64 pasid:20;
+	u64 bus:8;
+	u64 private:23;
+	u64 prg_index:9;
+	u64 rd_req:1;
+	u64 wr_req:1;
+	u64 exe_req:1;
+	u64 priv_req:1;
+	u64 devfn:8;
+	u64 addr:52;
+};
=20
+#define PRQ_RING_MASK ((0x1000 << PRQ_ORDER) - 0x10)
 static irqreturn_t prq_event_thread(int irq, void *d)
 {
 	struct intel_iommu *iommu =3D d;
-	printk("PRQ event on %s\n", iommu->name);
-	return IRQ_HANDLED;
+	struct intel_svm *svm =3D NULL;
+	int head, tail, handled =3D 0;
+
+	tail =3D dmar_readq(iommu->reg + DMAR_PQT_REG) & PRQ_RING_MASK;
+	head =3D dmar_readq(iommu->reg + DMAR_PQH_REG) & PRQ_RING_MASK;
+	while (head !=3D tail) {
+		struct vm_area_struct *vma;
+		struct page_req_dsc *req;
+		struct qi_desc resp;
+		int ret, result;
+		u64 address;
+
+		handled =3D 1;
+
+		req =3D &iommu->prq[head / sizeof(*req)];
+
+		result =3D QI_RESP_INVALID;
+		address =3D req->addr << PAGE_SHIFT;
+		if (!req->pasid_present) {
+			pr_err("%s: Page request without PASID: %08llx %08llx\n",
+			       iommu->name, ((unsigned long long *)req)[0],
+			       ((unsigned long long *)req)[1]);
+			goto inval_req;
+		}
+
+		if (!svm || svm->pasid !=3D req->pasid) {
+			mutex_lock(&pasid_mutex);
+			if (svm)
+				kref_put(&svm->kref, &intel_mm_free);
+
+			svm =3D idr_find(&iommu->pasid_idr, req->pasid);
+			if (!svm) {
+				pr_err("%s: Page request for invalid PASID %d: %08llx %08llx\n",
+				       iommu->name, req->pasid, ((unsigned long long *)req)[0],
+				       ((unsigned long long *)req)[1]);
+				mutex_unlock(&pasid_mutex);
+				goto inval_req;
+			}
+			/* Strictly speaking, we shouldn't need this. It is forbidden
+			   to unbind the PASID while there may still be requests in
+			   flight. But let's do it anyway. */
+			kref_get(&svm->kref);
+			mutex_unlock(&pasid_mutex);
+		}
+
+		result =3D QI_RESP_FAILURE;
+		down_read(&svm->mm->mmap_sem);
+		vma =3D find_extend_vma(svm->mm, address);
+		if (!vma || address < vma->vm_start)
+			goto hard_fault;
+
+		ret =3D handle_mm_fault(svm->mm, vma, address,
+				      req->wr_req ? FAULT_FLAG_WRITE : 0);
+		if (ret & VM_FAULT_ERROR)
+			goto hard_fault;
+
+		result =3D QI_RESP_SUCCESS;
+	hard_fault:
+		up_read(&svm->mm->mmap_sem);
+	inval_req:
+		/* Accounting for major/minor faults? */
+
+		if (req->lpig) {
+			/* Page Group Response */
+			resp.low =3D QI_PGRP_PASID(req->pasid) |
+				QI_PGRP_DID((req->bus << 8) | req->devfn) |
+				QI_PGRP_PASID_P(req->pasid_present) |
+				QI_PGRP_RESP_TYPE;
+			resp.high =3D QI_PGRP_IDX(req->prg_index) |
+				QI_PGRP_PRIV(req->private) | QI_PGRP_RESP_CODE(result);
+
+			qi_submit_sync(&resp, svm->iommu);
+		} else if (req->srr) {
+			/* Page Stream Response */
+			resp.low =3D QI_PSTRM_IDX(req->prg_index) |
+				QI_PSTRM_PRIV(req->private) | QI_PSTRM_BUS(req->bus) |
+				QI_PSTRM_PASID(req->pasid) | QI_PSTRM_RESP_TYPE;
+			resp.high =3D QI_PSTRM_ADDR(address) | QI_PSTRM_DEVFN(req->devfn) |
+				QI_PSTRM_RESP_CODE(result);
+
+			qi_submit_sync(&resp, svm->iommu);
+		}
+
+		head =3D (head + sizeof(*req)) & PRQ_RING_MASK;
+	}
+
+	if (svm) {
+		mutex_lock(&pasid_mutex);
+		kref_put(&svm->kref, &intel_mm_free);
+		mutex_unlock(&pasid_mutex);
+	}
+
+	dmar_writeq(iommu->reg + DMAR_PQH_REG, tail);
+
+	return IRQ_RETVAL(handled);
 }
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index bf034b0..aa7e02d 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -266,6 +266,8 @@ enum {
 #define QI_EIOTLB_TYPE		0x6
 #define QI_PC_TYPE		0x7
 #define QI_DEIOTLB_TYPE		0x8
+#define QI_PGRP_RESP_TYPE	0x9
+#define QI_PSTRM_RESP_TYPE	0xa
=20
 #define QI_IEC_SELECTIVE	(((u64)1) << 4)
 #define QI_IEC_IIDEX(idx)	(((u64)(idx & 0xffff) << 32))
@@ -316,6 +318,25 @@ enum {
 #define QI_DEV_EIOTLB_QDEP(qd)	(((qd) & 0x1f) << 16)
 #define QI_DEV_EIOTLB_MAX_INVS	32
=20
+#define QI_PGRP_IDX(idx)	(((u64)(idx)) << 55)
+#define QI_PGRP_PRIV(priv)	(((u64)(priv)) << 32)
+#define QI_PGRP_RESP_CODE(res)	((u64)(res))
+#define QI_PGRP_PASID(pasid)	(((u64)(pasid)) << 32)
+#define QI_PGRP_DID(did)	(((u64)(did)) << 16)
+#define QI_PGRP_PASID_P(p)	(((u64)(p)) << 4)
+
+#define QI_PSTRM_ADDR(addr)	(((u64)(addr)) & VTD_PAGE_MASK)
+#define QI_PSTRM_DEVFN(devfn)	(((u64)(devfn)) << 4)
+#define QI_PSTRM_RESP_CODE(res)	((u64)(res))
+#define QI_PSTRM_IDX(idx)	(((u64)(idx)) << 55)
+#define QI_PSTRM_PRIV(priv)	(((u64)(priv)) << 32)
+#define QI_PSTRM_BUS(bus)	(((u64)(bus)) << 24)
+#define QI_PSTRM_PASID(pasid)	(((u64)(pasid)) << 4)
+
+#define QI_RESP_SUCCESS		0x0
+#define QI_RESP_INVALID		0x1
+#define QI_RESP_FAILURE		0xf
+
 #define QI_GRAN_ALL_ALL			0
 #define QI_GRAN_NONG_ALL		1
 #define QI_GRAN_NONG_PASID		2
--=20
2.4.3

--=20
David Woodhouse                            Open Source Technology Centre
David.Woodhouse@intel.com                              Intel Corporation

--=-1I1XYc84ivNUmmPJAub1
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIISjjCCBicw
ggUPoAMCAQICAw3vNzANBgkqhkiG9w0BAQUFADCBjDELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0
YXJ0Q29tIEx0ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRlIFNpZ25pbmcx
ODA2BgNVBAMTL1N0YXJ0Q29tIENsYXNzIDEgUHJpbWFyeSBJbnRlcm1lZGlhdGUgQ2xpZW50IENB
MB4XDTE1MDUwNTA5NDM0MVoXDTE2MDUwNTA5NTMzNlowQjEcMBoGA1UEAwwTZHdtdzJAaW5mcmFk
ZWFkLm9yZzEiMCAGCSqGSIb3DQEJARYTZHdtdzJAaW5mcmFkZWFkLm9yZzCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBAMkbm9kPbx1j/X4RVyf/pPKSYwelcco69TvnQQbKM8m8xkWjXJI1
jpJ1jMaGUZGFToINMSZi7lZawUozudWbXSKy1SikENSTJHffsdRAIlsp+hR8vWvjsKUry6sEdqPG
doa5RY7+N4WRusWZDYW/RRWE6i9EL9qV86CVPYqw22UBOUw4/j/HVGCV6TSB8yE5iEwhk/hUuzRr
FZm1MJMR7mCS7BCR8Lr5jFY61lWpBiXNXIxLZCvDc26KR5L5tYX43iUVO3fzES1GRVoYnxxk2tmz
fcsZG5vK+Trc9L8OZJfkYrEHH3+Iw41MQ0w/djVtYr1+HYldx0QmYXAtnhIj+UMCAwEAAaOCAtkw
ggLVMAkGA1UdEwQCMAAwCwYDVR0PBAQDAgSwMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcD
BDAdBgNVHQ4EFgQUszC96C3w5/2+d+atSr0IpT26YI4wHwYDVR0jBBgwFoAUU3Ltkpzg2ssBXHx+
ljVO8tS4UYIwHgYDVR0RBBcwFYETZHdtdzJAaW5mcmFkZWFkLm9yZzCCAUwGA1UdIASCAUMwggE/
MIIBOwYLKwYBBAGBtTcBAgMwggEqMC4GCCsGAQUFBwIBFiJodHRwOi8vd3d3LnN0YXJ0c3NsLmNv
bS9wb2xpY3kucGRmMIH3BggrBgEFBQcCAjCB6jAnFiBTdGFydENvbSBDZXJ0aWZpY2F0aW9uIEF1
dGhvcml0eTADAgEBGoG+VGhpcyBjZXJ0aWZpY2F0ZSB3YXMgaXNzdWVkIGFjY29yZGluZyB0byB0
aGUgQ2xhc3MgMSBWYWxpZGF0aW9uIHJlcXVpcmVtZW50cyBvZiB0aGUgU3RhcnRDb20gQ0EgcG9s
aWN5LCByZWxpYW5jZSBvbmx5IGZvciB0aGUgaW50ZW5kZWQgcHVycG9zZSBpbiBjb21wbGlhbmNl
IG9mIHRoZSByZWx5aW5nIHBhcnR5IG9ibGlnYXRpb25zLjA2BgNVHR8ELzAtMCugKaAnhiVodHRw
Oi8vY3JsLnN0YXJ0c3NsLmNvbS9jcnR1MS1jcmwuY3JsMIGOBggrBgEFBQcBAQSBgTB/MDkGCCsG
AQUFBzABhi1odHRwOi8vb2NzcC5zdGFydHNzbC5jb20vc3ViL2NsYXNzMS9jbGllbnQvY2EwQgYI
KwYBBQUHMAKGNmh0dHA6Ly9haWEuc3RhcnRzc2wuY29tL2NlcnRzL3N1Yi5jbGFzczEuY2xpZW50
LmNhLmNydDAjBgNVHRIEHDAahhhodHRwOi8vd3d3LnN0YXJ0c3NsLmNvbS8wDQYJKoZIhvcNAQEF
BQADggEBAHMQmxHHodpS85X8HRyxhvfkys7r+taCNOaNU9cxQu/cZ/6k5nS2qGNMzZ6jb7ueY/V7
7p+4DW/9ZWODDTf4Fz00mh5SSVc20Bz7t+hhxwHd62PZgENh5i76Qq2tw48U8AsYo5damHby1epf
neZafLpUkLLO7AGBJIiRVTevdvyXQ0qnixOmKMWyvrhSNGuVIKVdeqLP+102Dwf+dpFyw+j1hz28
jEEKpHa+NR1b2kXuSPi/rMGhexwlJOh4tK8KQ6Ryr0rIN//NSbOgbyYZrzc/ZUWX9V5OA84ChFb2
vkFl0OcYrttp/rhDBLITwffPxSZeoBh9H7zYzkbCXKL3BUIwggYnMIIFD6ADAgECAgMN7zcwDQYJ
KoZIhvcNAQEFBQAwgYwxCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1TdGFydENvbSBMdGQuMSswKQYD
VQQLEyJTZWN1cmUgRGlnaXRhbCBDZXJ0aWZpY2F0ZSBTaWduaW5nMTgwNgYDVQQDEy9TdGFydENv
bSBDbGFzcyAxIFByaW1hcnkgSW50ZXJtZWRpYXRlIENsaWVudCBDQTAeFw0xNTA1MDUwOTQzNDFa
Fw0xNjA1MDUwOTUzMzZaMEIxHDAaBgNVBAMME2R3bXcyQGluZnJhZGVhZC5vcmcxIjAgBgkqhkiG
9w0BCQEWE2R3bXcyQGluZnJhZGVhZC5vcmcwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB
AQDJG5vZD28dY/1+EVcn/6TykmMHpXHKOvU750EGyjPJvMZFo1ySNY6SdYzGhlGRhU6CDTEmYu5W
WsFKM7nVm10istUopBDUkyR337HUQCJbKfoUfL1r47ClK8urBHajxnaGuUWO/jeFkbrFmQ2Fv0UV
hOovRC/alfOglT2KsNtlATlMOP4/x1Rglek0gfMhOYhMIZP4VLs0axWZtTCTEe5gkuwQkfC6+YxW
OtZVqQYlzVyMS2Qrw3NuikeS+bWF+N4lFTt38xEtRkVaGJ8cZNrZs33LGRubyvk63PS/DmSX5GKx
Bx9/iMONTENMP3Y1bWK9fh2JXcdEJmFwLZ4SI/lDAgMBAAGjggLZMIIC1TAJBgNVHRMEAjAAMAsG
A1UdDwQEAwIEsDAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwHQYDVR0OBBYEFLMwvegt
8Of9vnfmrUq9CKU9umCOMB8GA1UdIwQYMBaAFFNy7ZKc4NrLAVx8fpY1TvLUuFGCMB4GA1UdEQQX
MBWBE2R3bXcyQGluZnJhZGVhZC5vcmcwggFMBgNVHSAEggFDMIIBPzCCATsGCysGAQQBgbU3AQID
MIIBKjAuBggrBgEFBQcCARYiaHR0cDovL3d3dy5zdGFydHNzbC5jb20vcG9saWN5LnBkZjCB9wYI
KwYBBQUHAgIwgeowJxYgU3RhcnRDb20gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkwAwIBARqBvlRo
aXMgY2VydGlmaWNhdGUgd2FzIGlzc3VlZCBhY2NvcmRpbmcgdG8gdGhlIENsYXNzIDEgVmFsaWRh
dGlvbiByZXF1aXJlbWVudHMgb2YgdGhlIFN0YXJ0Q29tIENBIHBvbGljeSwgcmVsaWFuY2Ugb25s
eSBmb3IgdGhlIGludGVuZGVkIHB1cnBvc2UgaW4gY29tcGxpYW5jZSBvZiB0aGUgcmVseWluZyBw
YXJ0eSBvYmxpZ2F0aW9ucy4wNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5zdGFydHNzbC5j
b20vY3J0dTEtY3JsLmNybDCBjgYIKwYBBQUHAQEEgYEwfzA5BggrBgEFBQcwAYYtaHR0cDovL29j
c3Auc3RhcnRzc2wuY29tL3N1Yi9jbGFzczEvY2xpZW50L2NhMEIGCCsGAQUFBzAChjZodHRwOi8v
YWlhLnN0YXJ0c3NsLmNvbS9jZXJ0cy9zdWIuY2xhc3MxLmNsaWVudC5jYS5jcnQwIwYDVR0SBBww
GoYYaHR0cDovL3d3dy5zdGFydHNzbC5jb20vMA0GCSqGSIb3DQEBBQUAA4IBAQBzEJsRx6HaUvOV
/B0csYb35MrO6/rWgjTmjVPXMULv3Gf+pOZ0tqhjTM2eo2+7nmP1e+6fuA1v/WVjgw03+Bc9NJoe
UklXNtAc+7foYccB3etj2YBDYeYu+kKtrcOPFPALGKOXWph28tXqX53mWny6VJCyzuwBgSSIkVU3
r3b8l0NKp4sTpijFsr64UjRrlSClXXqiz/tdNg8H/naRcsPo9Yc9vIxBCqR2vjUdW9pF7kj4v6zB
oXscJSToeLSvCkOkcq9KyDf/zUmzoG8mGa83P2VFl/VeTgPOAoRW9r5BZdDnGK7baf64QwSyE8H3
z8UmXqAYfR+82M5Gwlyi9wVCMIIGNDCCBBygAwIBAgIBHjANBgkqhkiG9w0BAQUFADB9MQswCQYD
VQQGEwJJTDEWMBQGA1UEChMNU3RhcnRDb20gTHRkLjErMCkGA1UECxMiU2VjdXJlIERpZ2l0YWwg
Q2VydGlmaWNhdGUgU2lnbmluZzEpMCcGA1UEAxMgU3RhcnRDb20gQ2VydGlmaWNhdGlvbiBBdXRo
b3JpdHkwHhcNMDcxMDI0MjEwMTU1WhcNMTcxMDI0MjEwMTU1WjCBjDELMAkGA1UEBhMCSUwxFjAU
BgNVBAoTDVN0YXJ0Q29tIEx0ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRl
IFNpZ25pbmcxODA2BgNVBAMTL1N0YXJ0Q29tIENsYXNzIDEgUHJpbWFyeSBJbnRlcm1lZGlhdGUg
Q2xpZW50IENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxwmDzM4t2BqxKaQuE6uW
vooyg4ymiEGWVUet1G8SD+rqvyNH4QrvnEIaFHxOhESip7vMz39ScLpNLbL1QpOlPW/tFIzNHS3q
d2XRNYG5Sv9RcGE+T4qbLtsjjJbi6sL7Ls/f/X9ftTyhxvxWkf8KW37iKrueKsxw2HqolH7GM6FX
5UfNAwAu4ZifkpmZzU1slBhyWwaQPEPPZRsWoTb7q8hmgv6Nv3Hg9rmA1/VPBIOQ6SKRkHXG0Hhm
q1dOFoAFI411+a/9nWm5rcVjGcIWZ2v/43Yksq60jExipA4l5uv9/+Hm33mbgmCszdj/Dthf13tg
Av2O83hLJ0exTqfrlwIDAQABo4IBrTCCAakwDwYDVR0TAQH/BAUwAwEB/zAOBgNVHQ8BAf8EBAMC
AQYwHQYDVR0OBBYEFFNy7ZKc4NrLAVx8fpY1TvLUuFGCMB8GA1UdIwQYMBaAFE4L7xqkQFulF2mH
MMo0aEPQQa7yMGYGCCsGAQUFBwEBBFowWDAnBggrBgEFBQcwAYYbaHR0cDovL29jc3Auc3RhcnRz
c2wuY29tL2NhMC0GCCsGAQUFBzAChiFodHRwOi8vd3d3LnN0YXJ0c3NsLmNvbS9zZnNjYS5jcnQw
WwYDVR0fBFQwUjAnoCWgI4YhaHR0cDovL3d3dy5zdGFydHNzbC5jb20vc2ZzY2EuY3JsMCegJaAj
hiFodHRwOi8vY3JsLnN0YXJ0c3NsLmNvbS9zZnNjYS5jcmwwgYAGA1UdIAR5MHcwdQYLKwYBBAGB
tTcBAgEwZjAuBggrBgEFBQcCARYiaHR0cDovL3d3dy5zdGFydHNzbC5jb20vcG9saWN5LnBkZjA0
BggrBgEFBQcCARYoaHR0cDovL3d3dy5zdGFydHNzbC5jb20vaW50ZXJtZWRpYXRlLnBkZjANBgkq
hkiG9w0BAQUFAAOCAgEACoMIfXirLAZcuGOMXq4cuSN3TaFx2H2GvD5VSy/6rV55BYHbWNaPeQn3
oBSU8KgQZn/Kck1JxbLpAxVCNtsxeW1R87ifhsYZ0qjdrA9anrW2MAWCtosmAOT4OxK9QPoSjCMx
M3HbkZCDJgnlE8jMopH21BbyAYr7b5EfGRQJNtgWcvqSXwKHnTutR08+Kkn0KAkXCzeQNLeA5LlY
UzFyM7kPAp8pIRMQ+seHunmyG642S2+y/qHEdMuGIwpfz3eDF1PdctL04qYK/zu+Qg1Bw0RwgigV
Zs/0c5HP2/e9DBHh7eSwtzYlk4AUr6yxLlcwSjOfOmKEQ/Q8tzh0IFiNu9IPuTGAPBn4CPxD0+Ru
8T2wg8/s43R/PT3kd1OEqOJUl7q+h+r6fpvU0Fzxd2tC8Ga6fDEPme+1Nbi+03pVjuZQKbGwKJ66
gEn06WqaxVZC+J8hh/jR0k9mST1iAZPNYulcNJ8tKmVtjYsv0L1TSm2+NwON58tO+pIVzu3DWwSE
XSf+qkDavQam+QtEOZxLBXI++aMUEapSn+k3Lxm48ZCYfAWLb/Xj7F5JQMbZvCexglAbYR0kIHqW
5DnsYSdMD/IplJMojx0NBrxJ3fN9dvX2Y6BIXRsF1du4qESm4/3CKuyUV7p9DW3mPlHTGLvYxnyK
Qy7VFBkoLINszBrOUeIxggNvMIIDawIBATCBlDCBjDELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0
YXJ0Q29tIEx0ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRlIFNpZ25pbmcx
ODA2BgNVBAMTL1N0YXJ0Q29tIENsYXNzIDEgUHJpbWFyeSBJbnRlcm1lZGlhdGUgQ2xpZW50IENB
AgMN7zcwCQYFKw4DAhoFAKCCAa8wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
CQUxDxcNMTUxMDA4MjM1NDA3WjAjBgkqhkiG9w0BCQQxFgQUpso/NBw9J41O+03GK4EKRPQfwPsw
gaUGCSsGAQQBgjcQBDGBlzCBlDCBjDELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0YXJ0Q29tIEx0
ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRlIFNpZ25pbmcxODA2BgNVBAMT
L1N0YXJ0Q29tIENsYXNzIDEgUHJpbWFyeSBJbnRlcm1lZGlhdGUgQ2xpZW50IENBAgMN7zcwgacG
CyqGSIb3DQEJEAILMYGXoIGUMIGMMQswCQYDVQQGEwJJTDEWMBQGA1UEChMNU3RhcnRDb20gTHRk
LjErMCkGA1UECxMiU2VjdXJlIERpZ2l0YWwgQ2VydGlmaWNhdGUgU2lnbmluZzE4MDYGA1UEAxMv
U3RhcnRDb20gQ2xhc3MgMSBQcmltYXJ5IEludGVybWVkaWF0ZSBDbGllbnQgQ0ECAw3vNzANBgkq
hkiG9w0BAQEFAASCAQBx6d1ZPyQytAITcWVA+b3l8A+lX1DU6pNpaPvSF5S1o35wzMkiY88SF9XW
aqRXD9NuPwcjdvyfKxLex2oRiKURaMA73ZI3Eyk13yvCT5NStoyoGgTZNZekb9mriv6xV5LhFmav
sNuRF3Eabc+ynNYfT8U1n+pCLZs993ymBs5Wm8wyzwV7DHupghDSB78kqZklSp7mHsQBirhT6JT/
pPm9rD8mhY14dszo5MhT77+DlyC31ZBDwIOV2hD0sI8Uz9bH8QIOdUPNOk6K3sCEetr/aagL99aq
whgRPCoZs18L8S76gZ0nmdAnSuGrmbgRTOnwrzkTVtL7F8eRzPGlLViLAAAAAAAA


--=-1I1XYc84ivNUmmPJAub1--


--===============0054167925==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4
IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHA6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9pbnRlbC1nZngK

--===============0054167925==--
