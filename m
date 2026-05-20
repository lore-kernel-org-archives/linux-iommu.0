Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1928C3F20EE
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 15:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779289675; cv=none; b=mxlmKrPhPLafe3x5YK9irQ/IyDfYK7ly2MkUlo/MEcE7KS6YPaKLrRMXYFesisCtorGUnJzSgf3y1Llzw8Qk/dGiGTRiMVn90ihyHJmXiyDyXIRkeZPqOvnhfAsJ6WfE82XkZqwaW/CR5HzPC5u3Ht8nBvB2YjlB6ydsOM6DqNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779289675; c=relaxed/simple;
	bh=MVlFuUdSxChHlFJctVr5HZW91xXQ5JrSnHn1IZklfaY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nB/T6AGOBiyGfHJ1ywtDwc7kRuJEZwEN2MY86vGuRneZQ1uS5NdNw61FiF1K7XvLVnqqmdpJsVlzCHM3FJvsFC4fpV5i4AwQMEHYVE9frbvQrEev9NIPBjQE9aSu5aTf0SjHBdCva/BJZhSa1VPyOr2DeOYEa8vnewkApFaOH0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QSHESwke; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QSHESwke"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c82894155ceso7170061a12.1
        for <iommu@lists.linux.dev>; Wed, 20 May 2026 08:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779289671; x=1779894471; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wHUnnXFLKyxNLD+EvpucYoAufuRZ6w5hpv0Yeic6fcw=;
        b=QSHESwke3BfC6n7s2KNg1uhJbk7U/t7oDOi477jPqOjvAZTb48NBwZnSohPTw0s5he
         s3vDrz02/4u3dNMkRMwi3pTRdvNbwMI7XyMPz4WbeIgH0rWioCVal3MJjuVd9eSuhyY2
         8yCBFEnRE2FEIXsZkvl8AwClrKQQROAgGjEeuQWszth2B+pZfZ11GHW1QtNw4RDxpjZH
         +nYNar9Sz9DyU6O9EQk33vbXrMGnVcXKmUDpN7bRVwJBAims0fMGTi4jgLdsBCKZndN8
         AXaYKib0b+qJh8tQg0lJUp57MECUfnO826AlRNZY6sQuvhtJimWwT5HPZW1J0tNKHqq6
         KbPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779289671; x=1779894471;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wHUnnXFLKyxNLD+EvpucYoAufuRZ6w5hpv0Yeic6fcw=;
        b=sCHy9QQEZQ1D/gfHMNt/f1YdFPla3Zw712d/7ptuXQi/wA3mOfabqG41sYKraa6+Ep
         pcG9OCoonv0QLR/TSpC2WKEsIXlY5LrZMgmReu0446wEA2WnjvNb4hD/8bYlny5BiV+P
         3IjMADNCkCBH9VNVt9eDtbA7qYw767EQFiacvZG9ycwgTyGOiC0tglgK9G2Gwcw17EkP
         yxHHpB7rMA9qN11x+ID6C2GNZWuzyMAAalAItSS035JG77HuWsGihnwbaLDxyIsy0FmN
         UXHEyXru740Dblm4koC8RdQaATgza5BBsoZzbx7crLw4JRxOUmvXJs2GHhc6/+DJuJb2
         lkCA==
X-Forwarded-Encrypted: i=1; AFNElJ97TUJHfQVfOH1lYWIRLSIrDLmUEteEMyfGDsWUSv+yazGeAGO+p+beCid02QDkGweDa58ulw==@lists.linux.dev
X-Gm-Message-State: AOJu0YybIy++yAODxa4tH4IR5zpUsn6g1RFKGm50cnBloB/mgnQODiPM
	xZqUchMq2qnSAVCFLI7YuN3rUa89UU7Rb5xbQlM0NurW7+DAfJ2tq1p08/Pda+6SauudK0HCueJ
	h5WhrVFOiDvRj0QEAWiQWH98maA==
X-Received: from pfbem50.prod.google.com ([2002:a05:6a00:3772:b0:82f:6a57:a9aa])
 (user=joonwonkang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:ab0d:b0:82f:5125:a327 with SMTP id d2e1a72fcca58-83f33d97ad5mr24114337b3a.27.1779289670994;
 Wed, 20 May 2026 08:07:50 -0700 (PDT)
Date: Wed, 20 May 2026 15:07:43 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.631.ge1b05301d1-goog
Message-ID: <20260520150743.727106-1-joonwonkang@google.com>
Subject: [PATCH v2] iommu: Allow device driver to use its own PASID space for SVA
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

Another limitation is that a process cannot do `iommu_sva_bind_device()`
if it has ever done `iommu_sva_bind_device_pasid()` even though it has
been unbound after use.

Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Suggested-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Joonwon Kang <joonwonkang@google.com>
---
v2: Reuse iommu_mm->pasid after SVA bound by iommu_sva_bind_device_pasid()
    is unbound.
v1: Initial version.

 arch/x86/kernel/traps.c   |   9 +--
 drivers/iommu/iommu-sva.c | 151 +++++++++++++++++++++++++++++---------
 include/linux/iommu.h     |  14 +++-
 3 files changed, 134 insertions(+), 40 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 0ca3912ecb7f..0131c8e5fb10 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -857,13 +857,12 @@ static bool try_fixup_enqcmd_gp(void)
 		return false;
 
 	/*
-	 * If the mm has not been allocated a
-	 * PASID, the #GP can not be fixed up.
+	 * If the mm has not been allocated a PASID or ENQCMD has been
+	 * disallowed, the #GP can not be fixed up.
 	 */
-	if (!mm_valid_pasid(current->mm))
-		return false;
-
 	pasid = mm_get_enqcmd_pasid(current->mm);
+	if (pasid == IOMMU_PASID_INVALID)
+		return false;
 
 	/*
 	 * Did this thread already have its PASID activated?
diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index bc7c7232a43e..a83333651ad0 100644
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
 
@@ -30,8 +34,27 @@ static struct iommu_mm_data *iommu_alloc_mm_data(struct mm_struct *mm, struct de
 	iommu_mm = mm->iommu_mm;
 	/* Is a PASID already associated with this mm? */
 	if (iommu_mm) {
+		if ((pasid == IOMMU_PASID_GLOBAL_ANY && !iommu_mm->pasid_global) ||
+		    (pasid != IOMMU_PASID_GLOBAL_ANY && iommu_mm->pasid_global))
+			return ERR_PTR(-EBUSY);
+
+		if (!iommu_mm->pasid_global) {
+			if (list_empty(&iommu_mm->sva_domains))
+				iommu_mm->pasid = pasid;
+
+			if (pasid != iommu_mm->pasid) {
+				/*
+				 * Currently, a process simultaneously doing
+				 * SVA with multiple devices with different
+				 * PASIDs is not supported.
+				 */
+				return ERR_PTR(-ENOSPC);
+			}
+		}
+
 		if (iommu_mm->pasid >= dev->iommu->max_pasids)
 			return ERR_PTR(-EOVERFLOW);
+
 		return iommu_mm;
 	}
 
@@ -39,37 +62,30 @@ static struct iommu_mm_data *iommu_alloc_mm_data(struct mm_struct *mm, struct de
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
+		if (pasid >= dev->iommu->max_pasids) {
+			kfree(iommu_mm);
+			return ERR_PTR(-EOVERFLOW);
+		}
+		iommu_mm->pasid_global = false;
 	}
 	iommu_mm->pasid = pasid;
 	iommu_mm->mm = mm;
 	INIT_LIST_HEAD(&iommu_mm->sva_domains);
-	/*
-	 * Make sure the write to mm->iommu_mm is not reordered in front of
-	 * initialization to iommu_mm fields. If it does, readers may see a
-	 * valid iommu_mm with uninitialized values.
-	 */
-	smp_store_release(&mm->iommu_mm, iommu_mm);
+
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
@@ -84,7 +100,7 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 	mutex_lock(&iommu_sva_lock);
 
 	/* Allocate mm->pasid if necessary. */
-	iommu_mm = iommu_alloc_mm_data(mm, dev);
+	iommu_mm = iommu_alloc_mm_data(mm, dev, pasid);
 	if (IS_ERR(iommu_mm)) {
 		ret = PTR_ERR(iommu_mm);
 		goto out_unlock;
@@ -96,7 +112,7 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 		handle = container_of(attach_handle, struct iommu_sva, handle);
 		if (attach_handle->domain->mm != mm) {
 			ret = -EBUSY;
-			goto out_unlock;
+			goto out_free_iommu_mm;
 		}
 		refcount_inc(&handle->users);
 		mutex_unlock(&iommu_sva_lock);
@@ -105,17 +121,17 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 
 	if (PTR_ERR(attach_handle) != -ENOENT) {
 		ret = PTR_ERR(attach_handle);
-		goto out_unlock;
+		goto out_free_iommu_mm;
 	}
 
 	handle = kzalloc_obj(*handle);
 	if (!handle) {
 		ret = -ENOMEM;
-		goto out_unlock;
+		goto out_free_iommu_mm;
 	}
 
 	/* Search for an existing domain. */
-	list_for_each_entry(domain, &mm->iommu_mm->sva_domains, next) {
+	list_for_each_entry(domain, &iommu_mm->sva_domains, next) {
 		ret = iommu_attach_device_pasid(domain, dev, iommu_mm->pasid,
 						&handle->handle);
 		if (!ret) {
@@ -143,6 +159,15 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 		list_add(&iommu_mm->mm_list_elm, &iommu_sva_mms);
 	}
 	list_add(&domain->next, &iommu_mm->sva_domains);
+	if (!mm->iommu_mm) {
+		/*
+		 * Make sure the write to mm->iommu_mm is not reordered in
+		 * front of initialization to iommu_mm fields. If it does,
+		 * readers may see a valid iommu_mm with uninitialized values.
+		 */
+		smp_store_release(&mm->iommu_mm, iommu_mm);
+	}
+
 out:
 	refcount_set(&handle->users, 1);
 	mutex_unlock(&iommu_sva_lock);
@@ -153,12 +178,66 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 	iommu_domain_free(domain);
 out_free_handle:
 	kfree(handle);
+out_free_iommu_mm:
+	if (!mm->iommu_mm) {
+		if (iommu_mm->pasid_global)
+			iommu_free_global_pasid(iommu_mm->pasid);
+		kfree(iommu_mm);
+	}
 out_unlock:
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
@@ -198,9 +277,12 @@ EXPORT_SYMBOL_GPL(iommu_sva_unbind_device);
 
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
 
@@ -211,7 +293,8 @@ void mm_pasid_drop(struct mm_struct *mm)
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
2.54.0.631.ge1b05301d1-goog

