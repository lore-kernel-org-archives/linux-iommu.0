From: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: [PATCH v2 09/10] iommu/vt-d: Implement page request handling
Date: Tue, 13 Oct 2015 22:35:35 +0100
Message-ID: <1444772135.125804.67.camel@infradead.org>
References: <1444771787.125804.50.camel@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8058882837357788032=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1444771787.125804.50.camel-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, intel-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Jesse Barnes <jesse.barnes-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============8058882837357788032==
Content-Type: multipart/signed; micalg="sha-1"; protocol="application/x-pkcs7-signature";
	boundary="=-fKa141+ZBBO1Vnu9iq+J"


--=-fKa141+ZBBO1Vnu9iq+J
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Largely based on the driver-mode implementation by Jesse Barnes.

Signed-off-by: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/intel-iommu.c |  22 +++++-
 drivers/iommu/intel-svm.c   | 173 ++++++++++++++++++++++++++++++++++++++++=
++++
 include/linux/intel-iommu.h |  26 +++++++
 3 files changed, 220 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 787cd6e..548f6e5 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1726,8 +1726,11 @@ static void free_dmar_iommu(struct intel_iommu *iomm=
u)
 	free_context_table(iommu);
=20
 #ifdef CONFIG_INTEL_IOMMU_SVM
-	if (pasid_enabled(iommu))
+	if (pasid_enabled(iommu)) {
+		if (ecap_prs(iommu->ecap))
+			intel_svm_finish_prq(iommu);
 		intel_svm_free_pasid_tables(iommu);
+	}
 #endif
 }
=20
@@ -3250,6 +3253,13 @@ domains_done:
=20
 		iommu_flush_write_buffer(iommu);
=20
+#ifdef CONFIG_INTEL_IOMMU_SVM
+		if (pasid_enabled(iommu) && ecap_prs(iommu->ecap)) {
+			ret =3D intel_svm_enable_prq(iommu);
+			if (ret)
+				goto free_iommu;
+		}
+#endif
 		ret =3D dmar_set_interrupt(iommu);
 		if (ret)
 			goto free_iommu;
@@ -4194,6 +4204,14 @@ static int intel_iommu_add(struct dmar_drhd_unit *dm=
aru)
=20
 	intel_iommu_init_qi(iommu);
 	iommu_flush_write_buffer(iommu);
+
+#ifdef CONFIG_INTEL_IOMMU_SVM
+	if (pasid_enabled(iommu) && ecap_prs(iommu->ecap)) {
+		ret =3D intel_svm_enable_prq(iommu);
+		if (ret)
+			goto disable_iommu;
+	}
+#endif
 	ret =3D dmar_set_interrupt(iommu);
 	if (ret)
 		goto disable_iommu;
@@ -4995,6 +5013,8 @@ int intel_iommu_enable_pasid(struct intel_iommu *iomm=
u, struct intel_svm_dev *sd
 		ctx_lo |=3D CONTEXT_PASIDE;
 		if (iommu->pasid_state_table)
 			ctx_lo |=3D CONTEXT_DINVE;
+		if (info->pri_supported)
+			ctx_lo |=3D CONTEXT_PRS;
 		context[0].lo =3D ctx_lo;
 		wmb();
 		iommu->flush.flush_context(iommu, sdev->did,
diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index a64720b..0e86542 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -21,6 +21,10 @@
 #include <linux/rculist.h>
 #include <linux/pci.h>
 #include <linux/pci-ats.h>
+#include <linux/dmar.h>
+#include <linux/interrupt.h>
+
+static irqreturn_t prq_event_thread(int irq, void *d);
=20
 struct pasid_entry {
 	u64 val;
@@ -82,6 +86,66 @@ int intel_svm_free_pasid_tables(struct intel_iommu *iomm=
u)
 	return 0;
 }
=20
+#define PRQ_ORDER 0
+
+int intel_svm_enable_prq(struct intel_iommu *iommu)
+{
+	struct page *pages;
+	int irq, ret;
+
+	pages =3D alloc_pages(GFP_KERNEL | __GFP_ZERO, PRQ_ORDER);
+	if (!pages) {
+		pr_warn("IOMMU: %s: Failed to allocate page request queue\n",
+			iommu->name);
+		return -ENOMEM;
+	}
+	iommu->prq =3D page_address(pages);
+
+	irq =3D dmar_alloc_hwirq(DMAR_UNITS_SUPPORTED + iommu->seq_id, iommu->nod=
e, iommu);
+	if (irq <=3D 0) {
+		pr_err("IOMMU: %s: Failed to create IRQ vector for page request queue\n"=
,
+		       iommu->name);
+		ret =3D -EINVAL;
+	err:
+		free_pages((unsigned long)iommu->prq, PRQ_ORDER);
+		iommu->prq =3D NULL;
+		return ret;
+	}
+	iommu->pr_irq =3D irq;
+
+	snprintf(iommu->prq_name, sizeof(iommu->prq_name), "dmar%d-prq", iommu->s=
eq_id);
+
+	ret =3D request_threaded_irq(irq, NULL, prq_event_thread, IRQF_ONESHOT,
+				   iommu->prq_name, iommu);
+	if (ret) {
+		pr_err("IOMMU: %s: Failed to request IRQ for page request queue\n",
+		       iommu->name);
+		dmar_free_hwirq(irq);
+		goto err;
+	}
+	dmar_writeq(iommu->reg + DMAR_PQH_REG, 0ULL);
+	dmar_writeq(iommu->reg + DMAR_PQT_REG, 0ULL);
+	dmar_writeq(iommu->reg + DMAR_PQA_REG, virt_to_phys(iommu->prq) | PRQ_ORD=
ER);
+
+	return 0;
+}
+
+int intel_svm_finish_prq(struct intel_iommu *iommu)
+{
+	dmar_writeq(iommu->reg + DMAR_PQH_REG, 0ULL);
+	dmar_writeq(iommu->reg + DMAR_PQT_REG, 0ULL);
+	dmar_writeq(iommu->reg + DMAR_PQA_REG, 0ULL);
+
+	free_irq(iommu->pr_irq, iommu);
+	dmar_free_hwirq(iommu->pr_irq);
+	iommu->pr_irq =3D 0;
+
+	free_pages((unsigned long)iommu->prq, PRQ_ORDER);
+	iommu->prq =3D NULL;
+
+	return 0;
+}
+
 static void intel_flush_svm_range_dev (struct intel_svm *svm, struct intel=
_svm_dev *sdev,
 				       unsigned long address, int pages, int ih)
 {
@@ -363,3 +427,112 @@ int intel_svm_unbind_mm(struct device *dev, int pasid=
)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(intel_svm_unbind_mm);
+
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
+
+#define PRQ_RING_MASK ((0x1000 << PRQ_ORDER) - 0x10)
+static irqreturn_t prq_event_thread(int irq, void *d)
+{
+	struct intel_iommu *iommu =3D d;
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
+		result =3D QI_RESP_FAILURE;
+		address =3D req->addr << PAGE_SHIFT;
+		if (!req->pasid_present) {
+			pr_err("%s: Page request without PASID: %08llx %08llx\n",
+			       iommu->name, ((unsigned long long *)req)[0],
+			       ((unsigned long long *)req)[1]);
+			goto bad_req;
+		}
+
+		if (!svm || svm->pasid !=3D req->pasid) {
+			rcu_read_lock();
+			svm =3D idr_find(&iommu->pasid_idr, req->pasid);
+			/* It *can't* go away, because the driver is not permitted
+			 * to unbind the mm while any page faults are outstanding.
+			 * So we only need RCU to protect the internal idr code. */
+			rcu_read_unlock();
+
+			if (!svm) {
+				pr_err("%s: Page request for invalid PASID %d: %08llx %08llx\n",
+				       iommu->name, req->pasid, ((unsigned long long *)req)[0],
+				       ((unsigned long long *)req)[1]);
+				goto bad_req;
+			}
+		}
+
+		result =3D QI_RESP_INVALID;
+		down_read(&svm->mm->mmap_sem);
+		vma =3D find_extend_vma(svm->mm, address);
+		if (!vma || address < vma->vm_start)
+			goto invalid;
+
+		ret =3D handle_mm_fault(svm->mm, vma, address,
+				      req->wr_req ? FAULT_FLAG_WRITE : 0);
+		if (ret & VM_FAULT_ERROR)
+			goto invalid;
+
+		result =3D QI_RESP_SUCCESS;
+	invalid:
+		up_read(&svm->mm->mmap_sem);
+	bad_req:
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
+	dmar_writeq(iommu->reg + DMAR_PQH_REG, tail);
+
+	return IRQ_RETVAL(handled);
+}
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index f16a2b9..e5b80d3 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -265,6 +265,8 @@ enum {
 #define QI_EIOTLB_TYPE		0x6
 #define QI_PC_TYPE		0x7
 #define QI_DEIOTLB_TYPE		0x8
+#define QI_PGRP_RESP_TYPE	0x9
+#define QI_PSTRM_RESP_TYPE	0xa
=20
 #define QI_IEC_SELECTIVE	(((u64)1) << 4)
 #define QI_IEC_IIDEX(idx)	(((u64)(idx & 0xffff) << 32))
@@ -315,6 +317,25 @@ enum {
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
@@ -369,6 +390,7 @@ enum {
=20
 struct pasid_entry;
 struct pasid_state_entry;
+struct page_req_dsc;
=20
 struct intel_iommu {
 	void __iomem	*reg; /* Pointer to hardware regs, virtual addr */
@@ -401,6 +423,8 @@ struct intel_iommu {
 	 * told to. But while it's all driver-arbitrated, we're fine. */
 	struct pasid_entry *pasid_table;
 	struct pasid_state_entry *pasid_state_table;
+	struct page_req_dsc *prq;
+	unsigned char prq_name[16];    /* Name for PRQ interrupt */
 	struct idr pasid_idr;
 #endif
 	struct q_inval  *qi;            /* Queued invalidation info */
@@ -445,6 +469,8 @@ extern int dmar_ir_support(void);
 #ifdef CONFIG_INTEL_IOMMU_SVM
 extern int intel_svm_alloc_pasid_tables(struct intel_iommu *iommu);
 extern int intel_svm_free_pasid_tables(struct intel_iommu *iommu);
+extern int intel_svm_enable_prq(struct intel_iommu *iommu);
+extern int intel_svm_finish_prq(struct intel_iommu *iommu);
=20
 struct intel_svm_dev {
 	struct list_head list;
--=20
2.4.3

--=20
David Woodhouse                            Open Source Technology Centre
David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org                              Intel Corporation

--=-fKa141+ZBBO1Vnu9iq+J
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
CQUxDxcNMTUxMDEzMjEzNTM1WjAjBgkqhkiG9w0BCQQxFgQUtU3RzuqHnnb1QuetU8GMlSonMVQw
gaUGCSsGAQQBgjcQBDGBlzCBlDCBjDELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0YXJ0Q29tIEx0
ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRlIFNpZ25pbmcxODA2BgNVBAMT
L1N0YXJ0Q29tIENsYXNzIDEgUHJpbWFyeSBJbnRlcm1lZGlhdGUgQ2xpZW50IENBAgMN7zcwgacG
CyqGSIb3DQEJEAILMYGXoIGUMIGMMQswCQYDVQQGEwJJTDEWMBQGA1UEChMNU3RhcnRDb20gTHRk
LjErMCkGA1UECxMiU2VjdXJlIERpZ2l0YWwgQ2VydGlmaWNhdGUgU2lnbmluZzE4MDYGA1UEAxMv
U3RhcnRDb20gQ2xhc3MgMSBQcmltYXJ5IEludGVybWVkaWF0ZSBDbGllbnQgQ0ECAw3vNzANBgkq
hkiG9w0BAQEFAASCAQCc9bijlWWj5Ic08suDj/nc8XDlgdoGcPmcMgoCzclPSOCgJ1JcgbGu/UiA
0ajaE1+UQFsPRMHmYx12ilgYQoMB6bD9lvgTVOqyKPmz1+hGC5j4Q8FSqyzcuq//gGKZqICavh4h
SpCX81ZBOiC06N3rHb+j2gcYb6pTynn/Fxa2py9Gvb7kmw4Gf/rMNq7tAr8TGbRSXpQvIn5bskZu
fnGYuJbcNvzTRl9XYf3lKwrSCDT9CAoZXqyajejIh+56sst8VcsPd05d6S+wXNraSV0TKmX9eWtl
FG/8nGxLRjmmnQg3OfxbQwJYysHIOGdfjAZAwWES4yq6oxJyZxj1yBMaAAAAAAAA


--=-fKa141+ZBBO1Vnu9iq+J--


--===============8058882837357788032==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8058882837357788032==--
