Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C98168BD
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 09:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778838391; cv=none; b=VFt+gWCcXYSzs383t7U46guG5KfjiZsndVLHgrxEmC+nr+6HJm3ff1ImhiQb3U0q/OH1tocY0Eu0p2fcdDYzMlb5GXv5X4aCyVRFDCUthuBx1MZWOjz1b2wc5QUNU+4W4Epe/csxB6Jl973xenvUDJMjuWWR5l0u7cGT8UPcNXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778838391; c=relaxed/simple;
	bh=UB5z2bdNCMl9SZhMBe08ZSbPxco7Kl/DCRaG6lsVoJ8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Y0f9BNExF+izZNe7gsUPiQhNo+irSILXzbe3a6TY/By+gxSXbizdBVtpPoNSP65knAP7Ty+krBjC/IIVsEgO9TTiiV25JBoOA0O3uL/EKx+wcPUCAryHXOHMLAnQCgck554twPdNH1O4rJv62H/MnOCq+9fZ5Gzx3cAMDz2MIkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ox8yfWEm; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ox8yfWEm"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ba5f794825so75280595ad.0
        for <iommu@lists.linux.dev>; Fri, 15 May 2026 02:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778838389; x=1779443189; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xWJsQ/41akAuUsf+Yb2x4PykPgg0DSrsfcVLaBUG/04=;
        b=Ox8yfWEmUulG6mNzPIPk011LLWlujdBH3zgKFvYjHJBWLi1sJWEKtIcq2Pb6jArxpy
         dGE3hP08gaJsHtQB8053ggquL7ZtcmzUTEuSiIxzL8wVuW04x+aKhFarbKS9Q6UufQiV
         fAUNMax4WsYcIM+KrL4hwZwSHC+X1Brcasv9acvu1ZaygUlYnbCZdKk3wrewlDgUYIRu
         /gNx7v1uz/N1Ec6JKRmlH53HbSxKlvkxTVBBG1+/wDgcfP0t2qycg8e2hAhCpQAYpHjR
         EP0kxfceIwjRIMxFFSVujC1wxR85RwWNsFZCEtOb7zJ8o8UHG6Bgg+nHt4Fy9oXb/4vK
         NG9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778838389; x=1779443189;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xWJsQ/41akAuUsf+Yb2x4PykPgg0DSrsfcVLaBUG/04=;
        b=aimf2+j3HGD/viRbNEPpKlG/zK2mwK4XYcxnA/F5t/+K9W4+t64eyRgtNz18HHFOLU
         pOnIqkF5CVDgeBKRNTPCVfv3R4d5eZiwNhg9OXh0ClgztrU7E1RIrYfMcYnm6gKtoH0F
         SnkIGfa63ZyHpx6A5Gp0M0hRQRh6qcDN4bfVXQ0tVchKBNmXUQVyvqWuUNAdsvC73yna
         egLm/r4TfWCLGOnnFCyrEKCJzk6IQD0Fb5q8LFguf6pROOhaNe48NfDFtrhzypeeuuli
         SFnAXOHGIjZxhVZZLxDEcX9ZwFPYKDzF7FukAyXAvEqPcheRLZ6ENAU/Qs1Kq1Eoxb4R
         lbAw==
X-Forwarded-Encrypted: i=1; AFNElJ8fUPet6ShgZNy1ID8CLQ/siEX1dwQBqYj12sjhD2sbR5xv6DUhAdqeQOiGkgQdKWAS1Jbn7g==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywtrp+TFFeF4ZVYKfBOAnuxZgVdJB6lxhipL2UMIEB6NwXsOScl
	OVKl4CKM9/EwkbDwYBUEGQr9y87absnWt6+PJUx8hJJ5nobFJVsOGq20ga8moTdNTo8FaX6iT6O
	rZFJnra8O0HIgtlQIhF4iEk12gQ==
X-Received: from pgbdo6.prod.google.com ([2002:a05:6a02:e86:b0:c76:669e:8145])
 (user=joonwonkang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:33a1:b0:3a3:a55f:405d with SMTP id adf61e73a8af0-3b22ea76bdamr3616498637.13.1778838388477;
 Fri, 15 May 2026 02:46:28 -0700 (PDT)
Date: Fri, 15 May 2026 09:46:05 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515094605.3195841-1-joonwonkang@google.com>
Subject: [PATCH] iommu: Allow device driver to use its own PASID space for SVA
From: Joonwon Kang <joonwonkang@google.com>
To: jgg@ziepe.ca, will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, 
	jpb@kernel.org
Cc: Alexander.Grest@microsoft.com, amhetre@nvidia.com, 
	baolu.lu@linux.intel.com, easwar.hariharan@linux.microsoft.com, 
	jacob.jun.pan@linux.intel.com, kees@kernel.org, kevin.tian@intel.com, 
	nicolinc@nvidia.com, praan@google.com, smostafa@google.com, tglx@kernel.org, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, peterz@infradead.org, sohil.mehta@intel.com, kas@kernel.org, 
	alexander.shishkin@linux.intel.com, ryasuoka@redhat.com, xin@zytor.com, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, joonwonkang@google.com
Content-Type: text/plain; charset="UTF-8"

For SVA, the IOMMU core always allocates PASID from the global PASID
space. The use of this global PASID space comes from the limitation of
the ENQCMD instruction in Intel CPUs that it fetches its PASID operand
from IA32_PASID, which is per-process; when a process wants to
communicate with multiple devices with the ENQCMD instruction, it cannot
change its PASID for each device without the kernel's intervention. Also
note that ARM introduced a similar instruction, which is ST64BV0.

Due to this nature, SVA with ARM SMMU v3 has been found not working in
our environment when other modules/devices compete for PASID. The
environment looks as follows:

- The device is not a PCIe device.
- The device is to use SVA.
- The supported SSID/PASID space is very small for the device; only 1 to
  3 SSIDs are supported.

With this setup, when other modules have allocated all the PASIDs that
our device is expected to use from the global PASID space via APIs like
iommu_alloc_global_pasid() or iommu_sva_bind_device(), SVA binding to
our device fails due to the lack of available PASIDs.

This commit resolves the issue by allowing device driver to maintain its
own PASID space and assign a PASID from that for the process-device bond
via a new API called `iommu_sva_bind_device_pasid(dev, mm, pasid)`. Doing
that, however, will disallow the process to execute the ENQCMD-like
instructions at EL0. It is because the process cannot change its PASID in
IA32_PASID(or ACCDATA_EL1 on ARM) for each device without the kernel's
intervention. For this reason, calling `iommu_sva_bind_device()` and then
`iommu_sva_bind_device_pasid()` for the same process will not be allowed
and vice versa.

Currently, there is a limitation that a process simultaneously doing SVA
with multiple devices with different PASIDs is not supported. So, calling
`iommu_sva_bind_device_pasid()` multiple times for the same process with
different devices will not be allowed for now while that for
`iommu_sva_bind_device()` will be.

Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Suggested-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Joonwon Kang <joonwonkang@google.com>
---
 arch/x86/kernel/traps.c   |   2 +
 drivers/iommu/iommu-sva.c | 111 +++++++++++++++++++++++++++++---------
 include/linux/iommu.h     |  14 ++++-
 3 files changed, 102 insertions(+), 25 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 0ca3912ecb7f..61e2e52105e5 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -864,6 +864,8 @@ static bool try_fixup_enqcmd_gp(void)
 		return false;
 
 	pasid = mm_get_enqcmd_pasid(current->mm);
+	if (pasid == IOMMU_PASID_INVALID)
+		return false;
 
 	/*
 	 * Did this thread already have its PASID activated?
diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index bc7c7232a43e..12d6d638c827 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -10,6 +10,9 @@
 
 #include "iommu-priv.h"
 
+/* Whether pasid is to be allocated from the global PASID space */
+#define IOMMU_PASID_GLOBAL_ANY IOMMU_NO_PASID
+
 static DEFINE_MUTEX(iommu_sva_lock);
 static bool iommu_sva_present;
 static LIST_HEAD(iommu_sva_mms);
@@ -17,10 +20,11 @@ static struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
 						   struct mm_struct *mm);
 
 /* Allocate a PASID for the mm within range (inclusive) */
-static struct iommu_mm_data *iommu_alloc_mm_data(struct mm_struct *mm, struct device *dev)
+static struct iommu_mm_data *iommu_alloc_mm_data(struct mm_struct *mm,
+						 struct device *dev,
+						 ioasid_t pasid)
 {
 	struct iommu_mm_data *iommu_mm;
-	ioasid_t pasid;
 
 	lockdep_assert_held(&iommu_sva_lock);
 
@@ -39,10 +43,15 @@ static struct iommu_mm_data *iommu_alloc_mm_data(struct mm_struct *mm, struct de
 	if (!iommu_mm)
 		return ERR_PTR(-ENOMEM);
 
-	pasid = iommu_alloc_global_pasid(dev);
-	if (pasid == IOMMU_PASID_INVALID) {
-		kfree(iommu_mm);
-		return ERR_PTR(-ENOSPC);
+	if (pasid == IOMMU_PASID_GLOBAL_ANY) {
+		pasid = iommu_alloc_global_pasid(dev);
+		if (pasid == IOMMU_PASID_INVALID) {
+			kfree(iommu_mm);
+			return ERR_PTR(-ENOSPC);
+		}
+		iommu_mm->pasid_global = true;
+	} else {
+		iommu_mm->pasid_global = false;
 	}
 	iommu_mm->pasid = pasid;
 	iommu_mm->mm = mm;
@@ -56,20 +65,9 @@ static struct iommu_mm_data *iommu_alloc_mm_data(struct mm_struct *mm, struct de
 	return iommu_mm;
 }
 
-/**
- * iommu_sva_bind_device() - Bind a process address space to a device
- * @dev: the device
- * @mm: the mm to bind, caller must hold a reference to mm_users
- *
- * Create a bond between device and address space, allowing the device to
- * access the mm using the PASID returned by iommu_sva_get_pasid(). If a
- * bond already exists between @device and @mm, an additional internal
- * reference is taken. Caller must call iommu_sva_unbind_device()
- * to release each reference.
- *
- * On error, returns an ERR_PTR value.
- */
-struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
+static struct iommu_sva *iommu_sva_bind_device_internal(struct device *dev,
+							struct mm_struct *mm,
+							ioasid_t pasid)
 {
 	struct iommu_group *group = dev->iommu_group;
 	struct iommu_attach_handle *attach_handle;
@@ -84,12 +82,25 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 	mutex_lock(&iommu_sva_lock);
 
 	/* Allocate mm->pasid if necessary. */
-	iommu_mm = iommu_alloc_mm_data(mm, dev);
+	iommu_mm = iommu_alloc_mm_data(mm, dev, pasid);
 	if (IS_ERR(iommu_mm)) {
 		ret = PTR_ERR(iommu_mm);
 		goto out_unlock;
 	}
 
+	if ((pasid == IOMMU_PASID_GLOBAL_ANY && !iommu_mm->pasid_global) ||
+	    (pasid != IOMMU_PASID_GLOBAL_ANY && iommu_mm->pasid_global)) {
+		ret = -EBUSY;
+		goto out_unlock;
+	} else if (pasid != IOMMU_PASID_GLOBAL_ANY && pasid != iommu_mm->pasid) {
+		/*
+		 * Currently, a process simultaneously doing SVA with multiple
+		 * devices with different PASIDs is not supported.
+		 */
+		ret = -ENOSPC;
+		goto out_unlock;
+	}
+
 	/* A bond already exists, just take a reference`. */
 	attach_handle = iommu_attach_handle_get(group, iommu_mm->pasid, IOMMU_DOMAIN_SVA);
 	if (!IS_ERR(attach_handle)) {
@@ -157,8 +168,56 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 	mutex_unlock(&iommu_sva_lock);
 	return ERR_PTR(ret);
 }
+
+/**
+ * iommu_sva_bind_device() - Bind a process address space to a device
+ * @dev: the device
+ * @mm: the mm to bind, caller must hold a reference to mm_users
+ *
+ * Create a bond between device and address space, allowing the device to
+ * access the mm using the PASID returned by iommu_sva_get_pasid(). If a
+ * bond already exists between @device and @mm, an additional internal
+ * reference is taken. Caller must call iommu_sva_unbind_device()
+ * to release each reference.
+ *
+ * On error, returns an ERR_PTR value.
+ */
+struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
+{
+	return iommu_sva_bind_device_internal(dev, mm, IOMMU_PASID_GLOBAL_ANY);
+}
 EXPORT_SYMBOL_GPL(iommu_sva_bind_device);
 
+/**
+ * iommu_sva_bind_device_pasid() - Bind a process address space to a device
+ * with a designated pasid
+ * @dev: the device
+ * @mm: the mm to bind, caller must hold a reference to mm_users
+ * @pasid: the pasid to assign to the bond
+ *
+ * Create a bond between device and address space, allowing the device to
+ * access the mm using the PASID returned by iommu_sva_get_pasid(). If a
+ * bond already exists between @device and @mm, an additional internal
+ * reference is taken. Caller must call iommu_sva_unbind_device()
+ * to release each reference.
+ *
+ * It is the caller's responsibility to maintain the PASID space for @pasid.
+ * After the bond is created, the process for @mm will not be able to execute
+ * ENQCMD or similar instructions at EL0. To allow those instructions at EL0,
+ * iommu_sva_bind_device() must be used instead.
+ *
+ * On error, returns an ERR_PTR value.
+ */
+struct iommu_sva *iommu_sva_bind_device_pasid(struct device *dev,
+					      struct mm_struct *mm,
+					      ioasid_t pasid)
+{
+	if (pasid == IOMMU_PASID_GLOBAL_ANY)
+		return ERR_PTR(-EINVAL);
+	return iommu_sva_bind_device_internal(dev, mm, pasid);
+}
+EXPORT_SYMBOL_GPL(iommu_sva_bind_device_pasid);
+
 /**
  * iommu_sva_unbind_device() - Remove a bond created with iommu_sva_bind_device
  * @handle: the handle returned by iommu_sva_bind_device()
@@ -198,9 +257,12 @@ EXPORT_SYMBOL_GPL(iommu_sva_unbind_device);
 
 u32 iommu_sva_get_pasid(struct iommu_sva *handle)
 {
-	struct iommu_domain *domain = handle->handle.domain;
+	struct iommu_mm_data *iommu_mm = handle->handle.domain->mm->iommu_mm;
+
+	if (!iommu_mm)
+		return IOMMU_PASID_INVALID;
 
-	return mm_get_enqcmd_pasid(domain->mm);
+	return iommu_mm->pasid;
 }
 EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
 
@@ -211,7 +273,8 @@ void mm_pasid_drop(struct mm_struct *mm)
 	if (!iommu_mm)
 		return;
 
-	iommu_free_global_pasid(iommu_mm->pasid);
+	if (iommu_mm->pasid_global)
+		iommu_free_global_pasid(iommu_mm->pasid);
 	kfree(iommu_mm);
 }
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index e587d4ac4d33..5b6116e7152d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1140,6 +1140,7 @@ struct iommu_sva {
 
 struct iommu_mm_data {
 	u32			pasid;
+	bool			pasid_global;
 	struct mm_struct	*mm;
 	struct list_head	sva_domains;
 	struct list_head	mm_list_elm;
@@ -1626,7 +1627,7 @@ static inline u32 mm_get_enqcmd_pasid(struct mm_struct *mm)
 {
 	struct iommu_mm_data *iommu_mm = READ_ONCE(mm->iommu_mm);
 
-	if (!iommu_mm)
+	if (!iommu_mm || !iommu_mm->pasid_global)
 		return IOMMU_PASID_INVALID;
 	return iommu_mm->pasid;
 }
@@ -1634,6 +1635,9 @@ static inline u32 mm_get_enqcmd_pasid(struct mm_struct *mm)
 void mm_pasid_drop(struct mm_struct *mm);
 struct iommu_sva *iommu_sva_bind_device(struct device *dev,
 					struct mm_struct *mm);
+struct iommu_sva *iommu_sva_bind_device_pasid(struct device *dev,
+					      struct mm_struct *mm,
+					      ioasid_t pasid);
 void iommu_sva_unbind_device(struct iommu_sva *handle);
 u32 iommu_sva_get_pasid(struct iommu_sva *handle);
 void iommu_sva_invalidate_kva_range(unsigned long start, unsigned long end);
@@ -1644,6 +1648,14 @@ iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
 	return ERR_PTR(-ENODEV);
 }
 
+static inline struct iommu_sva *
+iommu_sva_bind_device_pasid(struct device *dev,
+			    struct mm_struct *mm,
+			    ioasid_t pasid)
+{
+	return ERR_PTR(-ENODEV);
+}
+
 static inline void iommu_sva_unbind_device(struct iommu_sva *handle)
 {
 }
-- 
2.54.0.563.g4f69b47b94-goog

