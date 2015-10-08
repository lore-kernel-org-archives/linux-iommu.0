From: David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH 3/7] iommu/vt-d: Add intel_svm_{un,
	}bind_mm() functions
Date: Fri, 09 Oct 2015 00:52:56 +0100
Message-ID: <1444348376.92154.31.camel@infradead.org>
References: <1444348223.92154.22.camel@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0233914305=="
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


--===============0233914305==
Content-Type: multipart/signed; micalg="sha-1"; protocol="application/x-pkcs7-signature";
	boundary="=-qcRDw8A4mb6iavaiolCi"


--=-qcRDw8A4mb6iavaiolCi
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This provides basic PASID support for endpoint devices, tested with a
version of the i915 driver.

A given process can bind to only one device per IOMMU for now. Making
that more generic isn't particularly difficult but isn't needed yet, and
can come later once the basic functionality is stable.

Eventually we'll also want the PASID space to be system-wide, not just
per-IOMMU. But when we have that requirement we'll also have a way to
achieve it.

Signed-off-by: David Woodhouse <David.Woodhouse@intel.com>
---
 drivers/iommu/intel-iommu.c   | 100 ++++++++++++++++++
 drivers/iommu/intel-svm.c     | 229 ++++++++++++++++++++++++++++++++++++++=
++++
 include/linux/dma_remapping.h |   7 ++
 include/linux/intel-iommu.h   |  59 ++++++++++-
 include/linux/intel-svm.h     |  68 +++++++++++++
 5 files changed, 458 insertions(+), 5 deletions(-)
 create mode 100644 include/linux/intel-svm.h

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 1f89064..a6fd639 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4882,6 +4882,106 @@ static void intel_iommu_remove_device(struct device=
 *dev)
 	iommu_device_unlink(iommu->iommu_dev, dev);
 }
=20
+#ifdef CONFIG_INTEL_IOMMU_SVM
+int intel_iommu_enable_pasid(struct intel_svm *svm)
+{
+	struct device_domain_info *info =3D NULL;
+	struct context_entry *context;
+	struct dmar_domain *domain;
+	unsigned long flags;
+	u8 bus, devfn;
+	u64 ctx_lo;
+
+	if (iommu_dummy(svm->dev)) {
+		dev_warn(svm->dev,
+			 "No IOMMU translation for device; cannot enable SVM\n");
+		return -EINVAL;
+	}
+
+	domain =3D get_valid_domain_for_dev(svm->dev);
+	if (!domain) {
+		dev_warn(svm->dev, "Cannot get IOMMU domain to enable SVM\n");
+		return -EINVAL;
+	}
+
+	svm->iommu =3D device_to_iommu(svm->dev, &bus, &devfn);
+	if (!ecs_enabled(svm->iommu)) {
+		dev_dbg(svm->dev, "No ECS support on IOMMU; cannot enable SVM\n");
+		return -EINVAL;
+	}
+	svm->did =3D domain->iommu_did[svm->iommu->seq_id];
+
+	spin_lock_irqsave(&device_domain_lock, flags);
+	spin_lock(&svm->iommu->lock);
+	context =3D iommu_context_addr(svm->iommu, bus, devfn, 0);
+	if (WARN_ON(!context)) {
+		spin_unlock(&svm->iommu->lock);
+		spin_unlock_irqrestore(&device_domain_lock, flags);
+		return -EINVAL;
+	}
+
+	ctx_lo =3D context[0].lo;
+	/* Modes in which the device IOTLB is enabled are 1 and 5. Modes
+	 * 3 and 7 are invalid. so we only need to test the low bit of TT */
+	svm->dev_iotlb =3D (ctx_lo >> 2) & 1;
+
+	if (!(ctx_lo & CONTEXT_PASIDE)) {
+		context[1].hi =3D (u64)virt_to_phys(svm->iommu->pasid_state_table);
+		context[1].lo =3D (u64)virt_to_phys(svm->iommu->pasid_table) | ecap_pss(=
svm->iommu->ecap);
+		wmb();
+		/* CONTEXT_TT_MULTI_LEVEL and CONTEXT_TT_DEV_IOTLB are both
+		 * extended to permit requests-with-PASID if the PASIDE bit
+		 * is set. which makes sense. For CONTEXT_TT_PASS_THROUGH,
+		 * however, the PASIDE bit is ignored and requests-with-PASID
+		 * are unconditionally blocked. Which makes less sense.
+		 * So convert from CONTEXT_TT_PASS_THROUGH to one of the new
+		 * "guest mode" translation types depending on whether ATS
+		 * is available or not. */
+		if ((ctx_lo & CONTEXT_TT_MASK) =3D=3D (CONTEXT_TT_PASS_THROUGH << 2)) {
+			ctx_lo &=3D ~CONTEXT_TT_MASK;
+			info =3D iommu_support_dev_iotlb(domain, svm->iommu, bus, devfn);
+			if (info) {
+				ctx_lo |=3D CONTEXT_TT_PT_PASID_DEV_IOTLB << 2;
+				svm->dev_iotlb =3D 1;
+			} else
+				ctx_lo |=3D CONTEXT_TT_PT_PASID << 2;
+		}
+		ctx_lo |=3D CONTEXT_PASIDE;
+		context[0].lo =3D ctx_lo;
+		wmb();
+		svm->iommu->flush.flush_context(svm->iommu, svm->did,
+						(((u16)bus) << 8) | devfn,
+						DMA_CCMD_MASK_NOBIT,
+						DMA_CCMD_DEVICE_INVL);
+	}
+	spin_unlock(&svm->iommu->lock);
+	spin_unlock_irqrestore(&device_domain_lock, flags);
+
+	/* This only happens if we just switched from CONTEXT_TT_PASS_THROUGH */
+	if (info)
+		iommu_enable_dev_iotlb(info);
+
+	/* This can also happen when we were already in a dev-iotlb mode */
+	if (svm->dev_iotlb) {
+		svm->qdep =3D pci_ats_queue_depth(to_pci_dev(svm->dev));
+		if (svm->qdep >=3D QI_DEV_EIOTLB_MAX_INVS)
+			svm->qdep =3D 0;
+		svm->sid =3D (((u16)bus) << 8) | devfn;
+	}
+
+	return 0;
+}
+
+/* Helper function for SVM code, so that we can look up a given PASID
+ * in its IOMMU's pasid_idr for unbinding */
+struct intel_iommu *intel_iommu_device_to_iommu(struct device *dev)
+{
+	u8 bus, devfn;
+
+	return device_to_iommu(dev, &bus, &devfn);
+}
+#endif /* CONFIG_INTEL_IOMMU_SVM */
+
 static const struct iommu_ops intel_iommu_ops =3D {
 	.capable	=3D intel_iommu_capable,
 	.domain_alloc	=3D intel_iommu_domain_alloc,
diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 9b40ad6..913c3a1 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -14,6 +14,14 @@
  */
=20
 #include <linux/intel-iommu.h>
+#include <linux/mmu_notifier.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/intel-svm.h>
+
+struct pasid_entry {
+	u64 val;
+};
=20
 int intel_svm_alloc_pasid_tables(struct intel_iommu *iommu)
 {
@@ -40,6 +48,8 @@ int intel_svm_alloc_pasid_tables(struct intel_iommu *iomm=
u)
 		return -ENOMEM;
 	}
 	iommu->pasid_state_table =3D page_address(pages);
+	idr_init(&iommu->pasid_idr);
+
 	pr_info("%s: Allocated order %d PASID table.\n", iommu->name, order);
=20
 	return 0;
@@ -61,5 +71,224 @@ int intel_svm_free_pasid_tables(struct intel_iommu *iom=
mu)
 		free_pages((unsigned long)iommu->pasid_state_table, order);
 		iommu->pasid_state_table =3D NULL;
 	}
+	idr_destroy(&iommu->pasid_idr);
 	return 0;
 }
+
+static void intel_flush_svm_range(struct intel_svm *svm,
+				  unsigned long address, int pages, int ih)
+{
+	struct qi_desc desc;
+	int mask =3D ilog2(__roundup_pow_of_two(pages));
+
+	if (pages =3D=3D -1 || !cap_pgsel_inv(svm->iommu->cap) ||
+	    mask > cap_max_amask_val(svm->iommu->cap)) {
+		desc.low =3D QI_EIOTLB_PASID(svm->pasid) | QI_EIOTLB_DID(svm->did) |
+			QI_EIOTLB_GRAN(QI_GRAN_NONG_PASID) | QI_EIOTLB_TYPE;
+		desc.high =3D 0;
+	} else {
+		desc.low =3D QI_EIOTLB_PASID(svm->pasid) | QI_EIOTLB_DID(svm->did) |
+			QI_EIOTLB_GRAN(QI_GRAN_PSI_PASID) | QI_EIOTLB_TYPE;
+		desc.high =3D QI_EIOTLB_ADDR(address) | QI_EIOTLB_GL(1) |
+			QI_EIOTLB_IH(ih) | QI_EIOTLB_AM(mask);
+	}
+
+	qi_submit_sync(&desc, svm->iommu);
+
+	if (svm->dev_iotlb) {
+		desc.low =3D QI_DEV_EIOTLB_PASID(svm->pasid) | QI_DEV_EIOTLB_SID(svm->si=
d) |
+			QI_DEV_EIOTLB_QDEP(svm->qdep) | QI_DEIOTLB_TYPE;
+		if (mask) {
+			unsigned long adr, delta;
+
+			/* Least significant zero bits in the address indicate the
+			 * range of the request. So mask them out according to the
+			 * size. */
+			adr =3D address & ((1<<(VTD_PAGE_SHIFT + mask)) - 1);
+
+			/* Now ensure that we round down further if the original
+			 * request was not aligned w.r.t. its size */
+			delta =3D address - adr;
+			if (delta + (pages << VTD_PAGE_SHIFT) >=3D (1 << (VTD_PAGE_SHIFT + mask=
)))
+				adr &=3D ~(1 << (VTD_PAGE_SHIFT + mask));
+			desc.high =3D QI_DEV_EIOTLB_ADDR(adr) | QI_DEV_EIOTLB_SIZE;
+		} else {
+			desc.high =3D QI_DEV_EIOTLB_ADDR(address);
+		}
+		qi_submit_sync(&desc, svm->iommu);
+	}
+}
+
+
+static void intel_change_pte(struct mmu_notifier *mn, struct mm_struct *mm=
,
+			     unsigned long address, pte_t pte)
+{
+	struct intel_svm *svm =3D container_of(mn, struct intel_svm, notifier);
+
+	intel_flush_svm_range(svm, address, 1, 1);
+}
+
+static void intel_invalidate_page(struct mmu_notifier *mn, struct mm_struc=
t *mm,
+				  unsigned long address)
+{
+	struct intel_svm *svm =3D container_of(mn, struct intel_svm, notifier);
+
+	intel_flush_svm_range(svm, address, 1, 1);
+}
+
+/* Pages have been freed at this point */
+static void intel_invalidate_range_end(struct mmu_notifier *mn,
+				       struct mm_struct *mm,
+				       unsigned long start, unsigned long end)
+{
+	struct intel_svm *svm =3D container_of(mn, struct intel_svm, notifier);
+
+	intel_flush_svm_range(svm, start,
+			      (end - start + PAGE_SIZE - 1) >> VTD_PAGE_SHIFT , 0);
+}
+
+static void intel_flush_pasid(struct intel_svm *svm)
+{
+	struct qi_desc desc;
+
+	desc.high =3D 0;
+	desc.low =3D QI_PC_TYPE | QI_PC_DID(svm->did) | QI_PC_PASID_SEL | QI_PC_P=
ASID(svm->pasid);
+
+	qi_submit_sync(&desc, svm->iommu);
+}
+
+static void intel_mm_release(struct mmu_notifier *mn, struct mm_struct *mm=
)
+{
+	struct intel_svm *svm =3D container_of(mn, struct intel_svm, notifier);
+
+	/* Called either when the process exits, or on the last unbind */
+	svm->iommu->pasid_table[svm->pasid].val =3D 0;
+
+	intel_flush_pasid(svm);
+	intel_flush_svm_range(svm, 0, -1, 0);
+
+	/* XXX: Callback to device driver to let it know? */
+}
+
+static const struct mmu_notifier_ops intel_mmuops =3D {
+	.release =3D intel_mm_release,
+	.change_pte =3D intel_change_pte,
+	.invalidate_page =3D intel_invalidate_page,
+	.invalidate_range_end =3D intel_invalidate_range_end,
+};
+
+static DEFINE_MUTEX(pasid_mutex);
+
+int intel_svm_bind_mm(struct device *dev, int *pasid)
+{
+	struct intel_svm *svm;
+	int pasid_max;
+	int ret;
+
+	BUG_ON(pasid && !current->mm);
+
+	mutex_lock(&pasid_mutex);
+	if (pasid) {
+		struct intel_iommu *iommu =3D intel_iommu_device_to_iommu(dev);
+		int pasid;
+
+		if (!iommu || !iommu->pasid_table) {
+			ret =3D -EINVAL;
+			goto out;
+		}
+
+		idr_for_each_entry(&iommu->pasid_idr, svm, pasid) {
+			if (svm->mm !=3D current->mm)
+				continue;
+
+			if (dev !=3D svm->dev) {
+				ret =3D -EBUSY;
+				goto out;
+			}
+
+			kref_get(&svm->kref);
+			goto success;
+		}
+	}
+
+	svm =3D kzalloc(sizeof(*svm), GFP_KERNEL);
+	if (!svm) {
+		ret =3D -ENOMEM;
+		goto out;
+	}
+	kref_init(&svm->kref);
+	svm->dev =3D dev;
+	ret =3D intel_iommu_enable_pasid(svm);
+	if (ret) {
+		kfree(svm);
+		goto out;
+	}
+	if (!pasid) {
+		/* If they don't actually want to assign a PASID, this is
+		 * just an enabling check/preparation. */
+		kfree(svm);
+		goto out;
+	}
+
+	pasid_max =3D 2 << ecap_pss(svm->iommu->ecap);
+	/* FIXME: Factor in device max too. */
+	ret =3D idr_alloc(&svm->iommu->pasid_idr, svm, 0, pasid_max - 1,
+			GFP_KERNEL);
+	if (ret < 0) {
+		kfree(svm);
+		goto out;
+	}
+	svm->pasid =3D ret;
+	svm->notifier.ops =3D &intel_mmuops;
+	svm->mm =3D get_task_mm(current);
+	ret =3D -ENOMEM;
+	if (!svm->mm || (ret =3D mmu_notifier_register(&svm->notifier, svm->mm)))=
 {
+		idr_remove(&svm->iommu->pasid_idr, svm->pasid);
+		kfree(svm);
+		goto out;
+	}
+	svm->iommu->pasid_table[svm->pasid].val =3D (u64)__pa(current->mm->pgd) |=
 1;
+
+ success:
+	*pasid =3D svm->pasid;
+	ret =3D 0;
+ out:
+	mutex_unlock(&pasid_mutex);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(intel_svm_bind_mm);
+
+static void intel_mm_free(struct kref *svm_ref)
+{
+	struct intel_svm *svm =3D container_of(svm_ref, struct intel_svm, kref);
+
+	mmu_notifier_unregister(&svm->notifier, svm->mm);
+
+	idr_remove(&svm->iommu->pasid_idr, svm->pasid);
+	mmput(svm->mm);
+	kfree(svm);
+}
+
+int intel_svm_unbind_mm(struct device *dev, int pasid)
+{
+	struct intel_svm *svm;
+	struct intel_iommu *iommu;
+	int ret =3D -EINVAL;
+
+	mutex_lock(&pasid_mutex);
+	iommu =3D intel_iommu_device_to_iommu(dev);
+	if (!iommu || !iommu->pasid_table)
+		goto out;
+
+	svm =3D idr_find(&iommu->pasid_idr, pasid);
+	if (!svm)
+		goto out;
+
+	kref_put(&svm->kref, intel_mm_free);
+	ret =3D 0;
+ out:
+	mutex_unlock(&pasid_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(intel_svm_unbind_mm);
diff --git a/include/linux/dma_remapping.h b/include/linux/dma_remapping.h
index 7ac17f5..0e114bf 100644
--- a/include/linux/dma_remapping.h
+++ b/include/linux/dma_remapping.h
@@ -20,6 +20,13 @@
 #define CONTEXT_TT_MULTI_LEVEL	0
 #define CONTEXT_TT_DEV_IOTLB	1
 #define CONTEXT_TT_PASS_THROUGH 2
+/* Extended context entry types */
+#define CONTEXT_TT_PT_PASID	4
+#define CONTEXT_TT_PT_PASID_DEV_IOTLB 5
+#define CONTEXT_TT_MASK (7ULL << 2)
+
+#define CONTEXT_PRS		(1ULL << 9)
+#define CONTEXT_PASIDE		(1ULL << 11)
=20
 struct intel_iommu;
 struct dmar_domain;
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 47844cb..b0df572 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -1,5 +1,9 @@
 /*
- * Copyright (c) 2006, Intel Corporation.
+ * Copyright =C2=A9 2006-2015, Intel Corporation.
+ *
+ * Authors: Ashok Raj <ashok.raj@intel.com>
+ *          Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
+ *          David Woodhouse <David.Woodhouse@intel.com>
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -13,10 +17,6 @@
  * You should have received a copy of the GNU General Public License along=
 with
  * this program; if not, write to the Free Software Foundation, Inc., 59 T=
emple
  * Place - Suite 330, Boston, MA 02111-1307 USA.
- *
- * Copyright (C) 2006-2008 Intel Corporation
- * Author: Ashok Raj <ashok.raj@intel.com>
- * Author: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
  */
=20
 #ifndef _INTEL_IOMMU_H_
@@ -25,7 +25,9 @@
 #include <linux/types.h>
 #include <linux/iova.h>
 #include <linux/io.h>
+#include <linux/idr.h>
 #include <linux/dma_remapping.h>
+#include <linux/mmu_notifier.h>
 #include <asm/cacheflush.h>
 #include <asm/iommu.h>
=20
@@ -253,6 +255,9 @@ enum {
 #define QI_DIOTLB_TYPE		0x3
 #define QI_IEC_TYPE		0x4
 #define QI_IWD_TYPE		0x5
+#define QI_EIOTLB_TYPE		0x6
+#define QI_PC_TYPE		0x7
+#define QI_DEIOTLB_TYPE		0x8
=20
 #define QI_IEC_SELECTIVE	(((u64)1) << 4)
 #define QI_IEC_IIDEX(idx)	(((u64)(idx & 0xffff) << 32))
@@ -280,6 +285,34 @@ enum {
 #define QI_DEV_IOTLB_SIZE	1
 #define QI_DEV_IOTLB_MAX_INVS	32
=20
+#define QI_PC_PASID(pasid)	(((u64)pasid) << 32)
+#define QI_PC_DID(did)		(((u64)did) << 16)
+#define QI_PC_GRAN(gran)	(((u64)gran) << 4)
+
+#define QI_PC_ALL_PASIDS	(QI_PC_TYPE | QI_PC_GRAN(0))
+#define QI_PC_PASID_SEL		(QI_PC_TYPE | QI_PC_GRAN(1))
+
+#define QI_EIOTLB_ADDR(addr)	((u64)(addr) & VTD_PAGE_MASK)
+#define QI_EIOTLB_GL(gl)	(((u64)gl) << 7)
+#define QI_EIOTLB_IH(ih)	(((u64)ih) << 6)
+#define QI_EIOTLB_AM(am)	(((u64)am))
+#define QI_EIOTLB_PASID(pasid) 	(((u64)pasid) << 32)
+#define QI_EIOTLB_DID(did)	(((u64)did) << 16)
+#define QI_EIOTLB_GRAN(gran) 	(((u64)gran) << 4)
+
+#define QI_DEV_EIOTLB_ADDR(a)	((u64)(a) & VTD_PAGE_MASK)
+#define QI_DEV_EIOTLB_SIZE	(((u64)1) << 11)
+#define QI_DEV_EIOTLB_GLOB(g)	((u64)g)
+#define QI_DEV_EIOTLB_PASID(p)	(((u64)p) << 32)
+#define QI_DEV_EIOTLB_SID(sid)	((u64)((sid) & 0xffff) << 32)
+#define QI_DEV_EIOTLB_QDEP(qd)	(((qd) & 0x1f) << 16)
+#define QI_DEV_EIOTLB_MAX_INVS	32
+
+#define QI_GRAN_ALL_ALL			0
+#define QI_GRAN_NONG_ALL		1
+#define QI_GRAN_NONG_PASID		2
+#define QI_GRAN_PSI_PASID		3
+
 struct qi_desc {
 	u64 low, high;
 };
@@ -361,6 +394,7 @@ struct intel_iommu {
 	 * told to. But while it's all driver-arbitrated, we're fine. */
 	struct pasid_entry *pasid_table;
 	struct pasid_state_entry *pasid_state_table;
+	struct idr pasid_idr;
 #endif
 	struct q_inval  *qi;            /* Queued invalidation info */
 	u32 *iommu_state; /* Store iommu states between suspend and resume.*/
@@ -404,6 +438,21 @@ extern int dmar_ir_support(void);
 extern int intel_svm_alloc_pasid_tables(struct intel_iommu *iommu);
 extern int intel_svm_free_pasid_tables(struct intel_iommu *iommu);
=20
+struct intel_svm {
+	struct kref kref;
+	struct mmu_notifier notifier;
+	struct mm_struct *mm;
+	struct intel_iommu *iommu;
+	struct device *dev;
+	int pasid;
+	u16 did;
+	u16 dev_iotlb:1;
+	u16 sid, qdep;
+};
+
+extern int intel_iommu_enable_pasid(struct intel_svm *svm);
+extern struct intel_iommu *intel_iommu_device_to_iommu(struct device *dev)=
;
+
 extern const struct attribute_group *intel_iommu_groups[];
=20
 #endif
diff --git a/include/linux/intel-svm.h b/include/linux/intel-svm.h
new file mode 100644
index 0000000..1e84f3e
--- /dev/null
+++ b/include/linux/intel-svm.h
@@ -0,0 +1,68 @@
+/*
+ * Copyright =C2=A9 2015 Intel Corporation.
+ *
+ * Authors: David Woodhouse <David.Woodhouse@intel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License f=
or
+ * more details.
+ */
+
+#ifndef __INTEL_SVM_H__
+#define __INTEL_SVM_H__
+
+struct device;
+
+/**
+ * intel_svm_bind_mm() - Bind the current process to a PASID
+ * @dev:	Device to be granted acccess
+ * @pasid:	Address for allocated PASID
+ *
+ * This function attempts to enable PASID support for the given device.
+ * If the @pasid argument is non-%NULL, a PASID is allocated for access
+ * to the MM of the current process.
+ *
+ * By using a %NULL value for the @pasid argument, this function can
+ * be used to simply validate that PASID support is available for the
+ * given device =E2=80=94 i.e. that it is behind an IOMMU which has the
+ * requisite support, and is enabled.
+ *
+ * Page faults are handled transparently by the IOMMU code, and there
+ * should be no need for the device driver to be involved. If a page
+ * fault cannot be handled (i.e. is an invalid address rather than
+ * just needs paging in), then the page request will be completed by
+ * the core IOMMU code with appropriate status, and the device itself
+ * can then report the resulting fault to its driver via whatever
+ * mechanism is appropriate.
+ *
+ * Multiple calls from the same process may result in the same PASID
+ * being re-used. A reference count is kept.
+ */
+extern int intel_svm_bind_mm(struct device *dev, int *pasid);
+
+#define intel_svm_available(dev) intel_svm_bind_mm((dev), NULL)
+
+/**
+ * intel_svm_unbind_mm() - Unbind a specified PASID
+ * @dev:	Device for which PASID was allocated
+ * @pasid:	PASID value to be unbound
+ *
+ * This function allows a PASID to be retired when the device no
+ * longer requires access to the address space of a given process.
+ *
+ * If the use count for the PASID in question reaches zero, the
+ * PASID is revoked and may no longer be used by hardware.
+ *
+ * Device drivers are required to ensure that no access (including
+ * page requests) is currently outstanding for the PASID in question,
+ * before calling this function.
+ */
+extern int intel_svm_unbind_mm(struct device *dev, int pasid);
+
+
+#endif /* __INTEL_SVM_H__ */
--=20
2.4.3

--=20
David Woodhouse                            Open Source Technology Centre
David.Woodhouse@intel.com                              Intel Corporation

--=-qcRDw8A4mb6iavaiolCi
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
CQUxDxcNMTUxMDA4MjM1MjU2WjAjBgkqhkiG9w0BCQQxFgQUvZ3A1WpXrnjkvjLLsXivQvX0Mogw
gaUGCSsGAQQBgjcQBDGBlzCBlDCBjDELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0YXJ0Q29tIEx0
ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRlIFNpZ25pbmcxODA2BgNVBAMT
L1N0YXJ0Q29tIENsYXNzIDEgUHJpbWFyeSBJbnRlcm1lZGlhdGUgQ2xpZW50IENBAgMN7zcwgacG
CyqGSIb3DQEJEAILMYGXoIGUMIGMMQswCQYDVQQGEwJJTDEWMBQGA1UEChMNU3RhcnRDb20gTHRk
LjErMCkGA1UECxMiU2VjdXJlIERpZ2l0YWwgQ2VydGlmaWNhdGUgU2lnbmluZzE4MDYGA1UEAxMv
U3RhcnRDb20gQ2xhc3MgMSBQcmltYXJ5IEludGVybWVkaWF0ZSBDbGllbnQgQ0ECAw3vNzANBgkq
hkiG9w0BAQEFAASCAQCTq+n9W1ES6+irdVl48+b8rSiPywkjBzTHQTnIfY8xpm8qCg70+HHyg0/A
TGRHC63uT180X599Qk/YxaG+oKYkjXzD+OiOqodRfJ0rU3qynwiIrC1jp5wiFufpIOFRZVdbGhGh
qVrYoxCUZGvSEa/492Ibuobe2pqlavoUBl2WqyEhMCvsNj/IaMwIH3thBGxzU4KUcrETI6o7yXhC
eK9ieqKo1V7FKv8gXmhPVg6WThsMD9l7xfZTRcAZWBB2ibRyoxxXgF3WgbtwMPI4FSSZOrTN6+Ne
HkScdOavtK/TXIugMALEYp+d328ZtZYSn27KOHwpZU/2Yv1pcvV3qeskAAAAAAAA


--=-qcRDw8A4mb6iavaiolCi--


--===============0233914305==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4
IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHA6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9pbnRlbC1nZngK

--===============0233914305==--
