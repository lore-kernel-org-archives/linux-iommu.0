From: David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH v2 06/10] iommu/vt-d: Add basic SVM PASID support
Date: Tue, 13 Oct 2015 22:34:50 +0100
Message-ID: <1444772090.125804.64.camel@infradead.org>
References: <1444771787.125804.50.camel@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1490154302=="
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <1444771787.125804.50.camel@infradead.org>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: iommu@lists.linux-foundation.org, intel-gfx@lists.freedesktop.org, Jesse Barnes <jesse.barnes@intel.com>
List-Id: iommu@lists.linux-foundation.org


--===============1490154302==
Content-Type: multipart/signed; micalg="sha-1"; protocol="application/x-pkcs7-signature";
	boundary="=-yerk5Am1G+zanBaFWBxf"


--=-yerk5Am1G+zanBaFWBxf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This provides basic PASID support for endpoint devices, tested with a
version of the i915 driver.

Signed-off-by: David Woodhouse <David.Woodhouse@intel.com>
---
 drivers/iommu/Kconfig         |   1 +
 drivers/iommu/intel-iommu.c   | 111 ++++++++++++++++
 drivers/iommu/intel-svm.c     | 291 ++++++++++++++++++++++++++++++++++++++=
++++
 include/linux/dma_remapping.h |   7 +
 include/linux/intel-iommu.h   |  68 +++++++++-
 include/linux/intel-svm.h     |  82 ++++++++++++
 6 files changed, 555 insertions(+), 5 deletions(-)
 create mode 100644 include/linux/intel-svm.h

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 8d23f5e..be18b21 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -139,6 +139,7 @@ config INTEL_IOMMU_SVM
 	bool "Support for Shared Virtual Memory with Intel IOMMU"
 	depends on INTEL_IOMMU && X86
 	select PCI_PASID
+	select MMU_NOTIFIER
 	help
 	  Shared Virtual Memory (SVM) provides a facility for devices
 	  to access DMA resources through process address space by
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 3b901ca..4c462ab 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4933,6 +4933,117 @@ static void intel_iommu_remove_device(struct device=
 *dev)
 	iommu_device_unlink(iommu->iommu_dev, dev);
 }
=20
+#ifdef CONFIG_INTEL_IOMMU_SVM
+int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct intel_svm_d=
ev *sdev)
+{
+	struct device_domain_info *info;
+	struct context_entry *context;
+	struct dmar_domain *domain;
+	unsigned long flags;
+	u8 bus, devfn;
+	u64 ctx_lo;
+
+	domain =3D get_valid_domain_for_dev(sdev->dev);
+	if (!domain)
+		return -EINVAL;
+
+	if (WARN_ON(device_to_iommu(sdev->dev, &bus, &devfn) !=3D iommu))
+		return -EINVAL;
+
+	sdev->did =3D domain->iommu_did[iommu->seq_id];
+
+	spin_lock_irqsave(&device_domain_lock, flags);
+	spin_lock(&iommu->lock);
+
+	info =3D iommu_support_dev_iotlb(domain, iommu, bus, devfn);
+	if (!info || !info->pasid_supported)
+		goto err;
+
+	context =3D iommu_context_addr(iommu, bus, devfn, 0);
+	if (WARN_ON(!context)) {
+	err:
+		spin_unlock(&iommu->lock);
+		spin_unlock_irqrestore(&device_domain_lock, flags);
+		return -EINVAL;
+	}
+
+	ctx_lo =3D context[0].lo;
+	/* Modes in which the device IOTLB is enabled are 1 and 5. Modes
+	 * 3 and 7 are invalid. so we only need to test the low bit of TT */
+	sdev->dev_iotlb =3D (ctx_lo >> 2) & 1;
+
+	if (!(ctx_lo & CONTEXT_PASIDE)) {
+		context[1].hi =3D (u64)virt_to_phys(iommu->pasid_state_table);
+		context[1].lo =3D (u64)virt_to_phys(iommu->pasid_table) | ecap_pss(iommu=
->ecap);
+		wmb();
+		/* CONTEXT_TT_MULTI_LEVEL and CONTEXT_TT_DEV_IOTLB are both
+		 * extended to permit requests-with-PASID if the PASIDE bit
+		 * is set. which makes sense. For CONTEXT_TT_PASS_THROUGH,
+		 * however, the PASIDE bit is ignored and requests-with-PASID
+		 * are unconditionally blocked. Which makes less sense.
+		 * So convert from CONTEXT_TT_PASS_THROUGH to one of the new
+		 * "guest mode" translation types depending on whether ATS
+		 * is available or not. Annoyingly, we can't use the new
+		 * modes *unless* PASIDE is set. */
+		if ((ctx_lo & CONTEXT_TT_MASK) =3D=3D (CONTEXT_TT_PASS_THROUGH << 2)) {
+			ctx_lo &=3D ~CONTEXT_TT_MASK;
+			if (info->ats_supported)
+				ctx_lo |=3D CONTEXT_TT_PT_PASID_DEV_IOTLB << 2;
+			else
+				ctx_lo |=3D CONTEXT_TT_PT_PASID << 2;
+		}
+		ctx_lo |=3D CONTEXT_PASIDE;
+		context[0].lo =3D ctx_lo;
+		wmb();
+		iommu->flush.flush_context(iommu, sdev->did,
+					   (((u16)bus) << 8) | devfn,
+					   DMA_CCMD_MASK_NOBIT,
+					   DMA_CCMD_DEVICE_INVL);
+	}
+	spin_unlock(&iommu->lock);
+	spin_unlock_irqrestore(&device_domain_lock, flags);
+
+	/* Enable PASID support in the device, if it wasn't already */
+	if (!info->pasid_enabled)
+		iommu_enable_dev_iotlb(info);
+
+	if (info->ats_enabled) {
+		sdev->dev_iotlb =3D 1;
+		sdev->qdep =3D info->ats_qdep;
+		if (sdev->qdep >=3D QI_DEV_EIOTLB_MAX_INVS)
+			sdev->qdep =3D 0;
+		sdev->sid =3D (((u16)bus) << 8) | devfn;
+	}
+
+	return 0;
+}
+
+struct intel_iommu *intel_svm_device_to_iommu(struct device *dev)
+{
+	struct intel_iommu *iommu;
+	u8 bus, devfn;
+
+	if (iommu_dummy(dev)) {
+		dev_warn(dev,
+			 "No IOMMU translation for device; cannot enable SVM\n");
+		return NULL;
+	}
+
+	iommu =3D device_to_iommu(dev, &bus, &devfn);
+	if ((!iommu)) {
+		dev_dbg(dev, "No IOMMU for device; cannot enable SVM\n");
+		return NULL;
+	}
+
+	if (!iommu->pasid_table) {
+		dev_dbg(dev, "PASID not enabled on IOMMU; cannot enable SVM\n");
+		return NULL;
+	}
+
+	return iommu;
+}
+#endif /* CONFIG_INTEL_IOMMU_SVM */
+
 static const struct iommu_ops intel_iommu_ops =3D {
 	.capable	=3D intel_iommu_capable,
 	.domain_alloc	=3D intel_iommu_domain_alloc,
diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 5b42a95..82d53e1 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -14,6 +14,17 @@
  */
=20
 #include <linux/intel-iommu.h>
+#include <linux/mmu_notifier.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/intel-svm.h>
+#include <linux/rculist.h>
+#include <linux/pci.h>
+#include <linux/pci-ats.h>
+
+struct pasid_entry {
+	u64 val;
+};
=20
 int intel_svm_alloc_pasid_tables(struct intel_iommu *iommu)
 {
@@ -42,6 +53,8 @@ int intel_svm_alloc_pasid_tables(struct intel_iommu *iomm=
u)
 				iommu->name);
 	}
=20
+	idr_init(&iommu->pasid_idr);
+
 	return 0;
 }
=20
@@ -61,5 +74,283 @@ int intel_svm_free_pasid_tables(struct intel_iommu *iom=
mu)
 		free_pages((unsigned long)iommu->pasid_state_table, order);
 		iommu->pasid_state_table =3D NULL;
 	}
+	idr_destroy(&iommu->pasid_idr);
 	return 0;
 }
+
+static void intel_flush_svm_range_dev (struct intel_svm *svm, struct intel=
_svm_dev *sdev,
+				       unsigned long address, int pages, int ih)
+{
+	struct qi_desc desc;
+	int mask =3D ilog2(__roundup_pow_of_two(pages));
+
+	if (pages =3D=3D -1 || !cap_pgsel_inv(svm->iommu->cap) ||
+	    mask > cap_max_amask_val(svm->iommu->cap)) {
+		desc.low =3D QI_EIOTLB_PASID(svm->pasid) | QI_EIOTLB_DID(sdev->did) |
+			QI_EIOTLB_GRAN(QI_GRAN_NONG_PASID) | QI_EIOTLB_TYPE;
+		desc.high =3D 0;
+	} else {
+		desc.low =3D QI_EIOTLB_PASID(svm->pasid) | QI_EIOTLB_DID(sdev->did) |
+			QI_EIOTLB_GRAN(QI_GRAN_PSI_PASID) | QI_EIOTLB_TYPE;
+		desc.high =3D QI_EIOTLB_ADDR(address) | QI_EIOTLB_GL(1) |
+			QI_EIOTLB_IH(ih) | QI_EIOTLB_AM(mask);
+	}
+
+	qi_submit_sync(&desc, svm->iommu);
+
+	if (sdev->dev_iotlb) {
+		desc.low =3D QI_DEV_EIOTLB_PASID(svm->pasid) | QI_DEV_EIOTLB_SID(sdev->s=
id) |
+			QI_DEV_EIOTLB_QDEP(sdev->qdep) | QI_DEIOTLB_TYPE;
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
+static void intel_flush_svm_range(struct intel_svm *svm, unsigned long add=
ress,
+				  int pages, int ih)
+{
+	struct intel_svm_dev *sdev;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(sdev, &svm->devs, list)
+		intel_flush_svm_range_dev(svm, sdev, address, pages, ih);
+	rcu_read_unlock();
+}
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
+static void intel_invalidate_range(struct mmu_notifier *mn,
+				   struct mm_struct *mm,
+				   unsigned long start, unsigned long end)
+{
+	struct intel_svm *svm =3D container_of(mn, struct intel_svm, notifier);
+
+	intel_flush_svm_range(svm, start,
+			      (end - start + PAGE_SIZE - 1) >> VTD_PAGE_SHIFT , 0);
+}
+
+
+static void intel_flush_pasid_dev(struct intel_svm *svm, struct intel_svm_=
dev *sdev)
+{
+	struct qi_desc desc;
+
+	desc.high =3D 0;
+	desc.low =3D QI_PC_TYPE | QI_PC_DID(sdev->did) | QI_PC_PASID_SEL | QI_PC_=
PASID(svm->pasid);
+
+	qi_submit_sync(&desc, svm->iommu);
+}
+
+static void intel_mm_release(struct mmu_notifier *mn, struct mm_struct *mm=
)
+{
+	struct intel_svm *svm =3D container_of(mn, struct intel_svm, notifier);
+
+	svm->iommu->pasid_table[svm->pasid].val =3D 0;
+
+	/* There's no need to do any flush because we can't get here if there
+	 * are any devices left anyway. */
+	WARN_ON(!list_empty(&svm->devs));
+}
+
+static const struct mmu_notifier_ops intel_mmuops =3D {
+	.release =3D intel_mm_release,
+	.change_pte =3D intel_change_pte,
+	.invalidate_page =3D intel_invalidate_page,
+	.invalidate_range =3D intel_invalidate_range,
+};
+
+static DEFINE_MUTEX(pasid_mutex);
+
+int intel_svm_bind_mm(struct device *dev, int *pasid)
+{
+	struct intel_iommu *iommu =3D intel_svm_device_to_iommu(dev);
+	struct intel_svm_dev *sdev;
+	struct intel_svm *svm =3D NULL;
+	int pasid_max;
+	int ret;
+
+	BUG_ON(pasid && !current->mm);
+
+	if (WARN_ON(!iommu))
+		return -EINVAL;
+
+	if (dev_is_pci(dev)) {
+		pasid_max =3D pci_max_pasids(to_pci_dev(dev));
+		if (pasid_max < 0)
+			return -EINVAL;
+	} else
+		pasid_max =3D 1 << 20;
+
+	mutex_lock(&pasid_mutex);
+	if (pasid) {
+		int i;
+
+		idr_for_each_entry(&iommu->pasid_idr, svm, i) {
+			if (svm->mm !=3D current->mm)
+				continue;
+
+			if (svm->pasid >=3D pasid_max) {
+				dev_warn(dev,
+					 "Limited PASID width. Cannot use existing PASID %d\n",
+					 svm->pasid);
+				ret =3D -ENOSPC;
+				goto out;
+			}
+
+			list_for_each_entry(sdev, &svm->devs, list) {
+				if (dev =3D=3D sdev->dev) {
+					sdev->users++;
+					goto success;
+				}
+			}
+
+			break;
+		}
+	}
+
+	sdev =3D kzalloc(sizeof(*sdev), GFP_KERNEL);
+	if (!sdev) {
+		ret =3D -ENOMEM;
+		goto out;
+	}
+	sdev->dev =3D dev;
+
+	ret =3D intel_iommu_enable_pasid(iommu, sdev);
+	if (ret || !pasid) {
+		/* If they don't actually want to assign a PASID, this is
+		 * just an enabling check/preparation. */
+		kfree(sdev);
+		goto out;
+	}
+	/* Finish the setup now we know we're keeping it */
+	sdev->users =3D 1;
+	init_rcu_head(&sdev->rcu);
+
+	if (!svm) {
+		svm =3D kzalloc(sizeof(*svm), GFP_KERNEL);
+		if (!svm) {
+			ret =3D -ENOMEM;
+			kfree(sdev);
+			goto out;
+		}
+		svm->iommu =3D iommu;
+
+		if (pasid_max > 2 << ecap_pss(iommu->ecap))
+			pasid_max =3D 2 << ecap_pss(iommu->ecap);
+
+		ret =3D idr_alloc(&iommu->pasid_idr, svm, 0, pasid_max - 1,
+				GFP_KERNEL);
+		if (ret < 0) {
+			kfree(svm);
+			goto out;
+		}
+		svm->pasid =3D ret;
+		svm->notifier.ops =3D &intel_mmuops;
+		svm->mm =3D get_task_mm(current);
+		INIT_LIST_HEAD_RCU(&svm->devs);
+		ret =3D -ENOMEM;
+		if (!svm->mm || (ret =3D mmu_notifier_register(&svm->notifier, svm->mm))=
) {
+			idr_remove(&svm->iommu->pasid_idr, svm->pasid);
+			kfree(svm);
+			kfree(sdev);
+			goto out;
+		}
+		iommu->pasid_table[svm->pasid].val =3D (u64)__pa(svm->mm->pgd) | 1;
+		wmb();
+	}
+	list_add_rcu(&sdev->list, &svm->devs);
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
+int intel_svm_unbind_mm(struct device *dev, int pasid)
+{
+	struct intel_svm_dev *sdev;
+	struct intel_iommu *iommu;
+	struct intel_svm *svm;
+	int ret =3D -EINVAL;
+
+	mutex_lock(&pasid_mutex);
+	iommu =3D intel_svm_device_to_iommu(dev);
+	if (!iommu || !iommu->pasid_table)
+		goto out;
+
+	svm =3D idr_find(&iommu->pasid_idr, pasid);
+	if (!svm)
+		goto out;
+
+	list_for_each_entry(sdev, &svm->devs, list) {
+		if (dev =3D=3D sdev->dev) {
+			ret =3D 0;
+			sdev->users--;
+			if (!sdev->users) {
+				list_del_rcu(&sdev->list);
+				/* Flush the PASID cache and IOTLB for this device.
+				 * Note that we do depend on the hardware *not* using
+				 * the PASID any more. Just as we depend on other
+				 * devices never using PASIDs that they have no right
+				 * to use. We have a *shared* PASID table, because it's
+				 * large and has to be physically contiguous. So it's
+				 * hard to be as defensive as we might like. */
+				intel_flush_pasid_dev(svm, sdev);
+				intel_flush_svm_range_dev(svm, sdev, 0, -1, 0);
+				kfree_rcu(sdev, rcu);
+
+				if (list_empty(&svm->devs)) {
+					mmu_notifier_unregister(&svm->notifier, svm->mm);
+
+					idr_remove(&svm->iommu->pasid_idr, svm->pasid);
+					mmput(svm->mm);
+					/* We mandate that no page faults may be outstanding
+					 * for the PASID when intel_svm_unbind_mm() is called.
+					 * If that is not obeyed, subtle errors will happen.
+					 * Let's make them less subtle... */
+					memset(svm, 0x6b, sizeof(*svm));
+					kfree(svm);
+				}
+			}
+			break;
+		}
+	}
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
index 0f38e60..46add60 100644
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
@@ -25,7 +25,10 @@
 #include <linux/types.h>
 #include <linux/iova.h>
 #include <linux/io.h>
+#include <linux/idr.h>
 #include <linux/dma_remapping.h>
+#include <linux/mmu_notifier.h>
+#include <linux/list.h>
 #include <asm/cacheflush.h>
 #include <asm/iommu.h>
=20
@@ -251,6 +254,9 @@ enum {
 #define QI_DIOTLB_TYPE		0x3
 #define QI_IEC_TYPE		0x4
 #define QI_IWD_TYPE		0x5
+#define QI_EIOTLB_TYPE		0x6
+#define QI_PC_TYPE		0x7
+#define QI_DEIOTLB_TYPE		0x8
=20
 #define QI_IEC_SELECTIVE	(((u64)1) << 4)
 #define QI_IEC_IIDEX(idx)	(((u64)(idx & 0xffff) << 32))
@@ -278,6 +284,34 @@ enum {
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
@@ -359,6 +393,7 @@ struct intel_iommu {
 	 * told to. But while it's all driver-arbitrated, we're fine. */
 	struct pasid_entry *pasid_table;
 	struct pasid_state_entry *pasid_state_table;
+	struct idr pasid_idr;
 #endif
 	struct q_inval  *qi;            /* Queued invalidation info */
 	u32 *iommu_state; /* Store iommu states between suspend and resume.*/
@@ -399,9 +434,32 @@ extern int qi_submit_sync(struct qi_desc *desc, struct=
 intel_iommu *iommu);
=20
 extern int dmar_ir_support(void);
=20
+#ifdef CONFIG_INTEL_IOMMU_SVM
 extern int intel_svm_alloc_pasid_tables(struct intel_iommu *iommu);
 extern int intel_svm_free_pasid_tables(struct intel_iommu *iommu);
=20
+struct intel_svm_dev {
+	struct list_head list;
+	struct rcu_head rcu;
+	struct device *dev;
+	int users;
+	u16 did;
+	u16 dev_iotlb:1;
+	u16 sid, qdep;
+};
+
+struct intel_svm {
+	struct mmu_notifier notifier;
+	struct mm_struct *mm;
+	struct intel_iommu *iommu;
+	int pasid;
+	struct list_head devs;
+};
+
+extern int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct inte=
l_svm_dev *sdev);
+extern struct intel_iommu *intel_svm_device_to_iommu(struct device *dev);
+#endif
+
 extern const struct attribute_group *intel_iommu_groups[];
=20
 #endif
diff --git a/include/linux/intel-svm.h b/include/linux/intel-svm.h
new file mode 100644
index 0000000..42f80ad
--- /dev/null
+++ b/include/linux/intel-svm.h
@@ -0,0 +1,82 @@
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
+#ifdef CONFIG_INTEL_IOMMU_SVM
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
+#else /* CONFIG_INTEL_IOMMU_SVM */
+
+static inline int intel_svm_bind_mm(struct device *dev, int *pasid)
+{
+	return -ENOSYS;
+}
+
+static inline int intel_svm_unbind_mm(struct device *dev, int pasid)
+{
+	BUG();
+}
+#endif /* CONFIG_INTEL_IOMMU_SVM */
+
+#define intel_svm_available(dev) (!intel_svm_bind_mm((dev), NULL))
+
+#endif /* __INTEL_SVM_H__ */
--=20
2.4.3

--=20
David Woodhouse                            Open Source Technology Centre
David.Woodhouse@intel.com                              Intel Corporation

--=-yerk5Am1G+zanBaFWBxf
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
CQUxDxcNMTUxMDEzMjEzNDUwWjAjBgkqhkiG9w0BCQQxFgQUcWho2/f41yPN5E64junLpNdcOTAw
gaUGCSsGAQQBgjcQBDGBlzCBlDCBjDELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0YXJ0Q29tIEx0
ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRlIFNpZ25pbmcxODA2BgNVBAMT
L1N0YXJ0Q29tIENsYXNzIDEgUHJpbWFyeSBJbnRlcm1lZGlhdGUgQ2xpZW50IENBAgMN7zcwgacG
CyqGSIb3DQEJEAILMYGXoIGUMIGMMQswCQYDVQQGEwJJTDEWMBQGA1UEChMNU3RhcnRDb20gTHRk
LjErMCkGA1UECxMiU2VjdXJlIERpZ2l0YWwgQ2VydGlmaWNhdGUgU2lnbmluZzE4MDYGA1UEAxMv
U3RhcnRDb20gQ2xhc3MgMSBQcmltYXJ5IEludGVybWVkaWF0ZSBDbGllbnQgQ0ECAw3vNzANBgkq
hkiG9w0BAQEFAASCAQB16Kk3lG1CaQv84D343C5NcZObH0zUnip2zsLq+e1+x9QMg4xG9gW53sI9
TKLrU33zjt+84whmHMExeq22CZ+GiYoXdw1OAw7DNurMPDyVtJhQA6PVijBC6GzZzkjDx0i+7APE
uC6LrCX9ADM1x6TKAsee7lYiw99J6uUA47eSGyIAsfKeD7b6FiStgd5Y57C5jt6DOif4g05oq9Vz
2u+E1gohILonABN/pozFxBgcFpx1tOM0LWou1iz8fYSrnK2VJ0ZjK3HitM6z3jALEwqrocMcM4hZ
2i7eT9THQhIIZz4tQkfSnbBZsb+vD0kABhf83ICjgIv6Mot95GwcNTePAAAAAAAA


--=-yerk5Am1G+zanBaFWBxf--


--===============1490154302==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4
IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHA6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9pbnRlbC1nZngK

--===============1490154302==--
