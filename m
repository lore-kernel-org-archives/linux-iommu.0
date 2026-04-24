Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4349033A9F8
	for <iommu@lists.linux.dev>; Fri, 24 Apr 2026 08:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777020619; cv=none; b=lUCJZMFFuRLiyWl7bImt9WL2FJ72m3g55EEZW3H7aqcRF2aVPNm2KJ+xsLjLw/GCJ1pDIitacdKdQU8j1au/6es0ImNnhfEa6mlqE4Bw2YPsHBW7lwCqh6mG8LlX6wHXXpPS+WYfNrFVdfkVgr0am0eniJNGPOt7uqYPaseNtI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777020619; c=relaxed/simple;
	bh=QjYFSBeCbFK99m1dIJR+XgEazeT5WRvnB7NyWckUAM0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rSYTPRxYFg7erwjUyBdsvvSjcWbq/wAy14rbOXm+S8/dKxRSWrsllNSXvd01OkYs61zHCGDJ79J1u4/ApNDWoKkzWHzblHDRhwi0khQNAtUr9uRLkzA8WI3ZmB67ONZoVKVXRJXGirNEftmtFwVBUCrgsqMY0gmExHlQM1OZKKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kOcmA9Ec; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kOcmA9Ec"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c79281bd14cso3029228a12.3
        for <iommu@lists.linux.dev>; Fri, 24 Apr 2026 01:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777020618; x=1777625418; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i9nRQWrSO8yCuAghUfsOuR4TVxWLZXmy5/OuspGEKv4=;
        b=kOcmA9EcKH/P+4ywxuZiAH7OqbQxCL7jysPrM04/CQqeVubgWD8tBbgrnsWmx44vWE
         vE2d2u3lHSjFO5fKXjYD7Vpyc5cJ1egNBjzw8MCjAIWhocZ6qN2Et2TdQyt/oR80POZA
         qEe6YsZTc6GwtS4rh6UZWhHH7E+d1jqvQAjmT94sQo09rWui/YErjvzwh/2bAv+D3M4X
         gVA0Z7sFc1WeOXCeJczDHWrs5VxyH1KmVoN9kvSy6jrbjj81XTG5w8Y2VR5ntcD50pG3
         iDFM9OkRTuExJMDQu7yvN/xRrg635/YttuD6ZKJuccoSa04JYPORUDDwiXeyCAxbv+Ty
         hRww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777020618; x=1777625418;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i9nRQWrSO8yCuAghUfsOuR4TVxWLZXmy5/OuspGEKv4=;
        b=hW3mFBf/D7cQjy94DAUOxJKJ9NTgXw2KfX+8KHpL/Obkb5LpsJqy/T95V1xgqEjSNT
         0umXSX8TkIl+QVNfiHK9sLOYFMigoW2hAFHrT9DImXIGOkLdcM1hw2aE0NgV6joQuZtJ
         Z1BDSueCRF/8WFD0QcDO0AjwBtwGsBlKbQ3b5wOyPaDJJNZsg12dqF7EWxrHKIdCXM/W
         fuqOPL9GSAIAdOc4yaqgR4yUd/0rwqL/H6a+9ZxBZ5xZOvk8reD3UZP9IJTFT3pvoLAn
         m9L593aQ/5BYLYMSHvybttW3DwB9Luv6H1r2r802j1YQn2vtaVuU2G1bDOks53ResY2g
         zn7w==
X-Forwarded-Encrypted: i=1; AFNElJ8swhSP+vdZ7URhjjzVG7leVV47hvjtK639cInSbaCBC3VkNqdly+hJmA8DLbU2TXvCgSeGPw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywo86p+8pnNrLhruuPBO5hiNDBI9TAiE7PIzYBFSYS/zilzb/MF
	WnMOCkpc4xnZe/W+LRhS4fMBvYcKH9HsgdtEQtbVXOEDVdvZw2wPrSkcYpnfwjPeTZJ3UixjAHj
	qkPB2T0Ik3YuoG8KiDdNC80INLw==
X-Received: from pgx2.prod.google.com ([2002:a63:1742:0:b0:c79:63dd:68f3])
 (user=joonwonkang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:7fa2:b0:398:9662:10ff with SMTP id adf61e73a8af0-3a08d687750mr36319637637.4.1777020617462;
 Fri, 24 Apr 2026 01:50:17 -0700 (PDT)
Date: Fri, 24 Apr 2026 08:50:10 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260424085011.3502295-1-joonwonkang@google.com>
Subject: [PATCH RFC] iommu: Enable per-device SSID space for SVA
From: Joonwon Kang <joonwonkang@google.com>
To: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org
Cc: jgg@ziepe.ca, nicolinc@nvidia.com, praan@google.com, kees@kernel.org, 
	amhetre@nvidia.com, Alexander.Grest@microsoft.com, baolu.lu@linux.intel.com, 
	smostafa@google.com, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Joonwon Kang <joonwonkang@google.com>
Content-Type: text/plain; charset="UTF-8"

For SVA, the IOMMU core always allocates PASID from the global PASID
space. The use of this global PASID space comes from the limitation of
the ENQCMD instruction in Intel CPUs that it fetches its PASID operand
from IA32_PASID, which is per-task.

Due to this nature, SVA with ARM SMMU v3 has been found not working in
our environment when other modules/devices compete for PASID. The
environment looks as follows:

- The device is not a PCIe device.
- The device is to use SVA.
- The supported SSID/PASID space is very small for the device; only 1 to
  3 SSIDs are supported.
- There is a custom way of transmitting the SSID from the kernel to the
  device.

With this setup, when other modules have allocated all the PASIDs that
our device is expected to use from the global PASID space via APIs like
iommu_alloc_global_pasid() or iommu_sva_bind_device(), SVA binding to
our device fails due to the lack of available PASIDs.

Since SSID/PASID is supported per-SID in ARM SMMU v3, this commit
leverages the fact and lifts the use of the global PASID space if
possible. What it does includes:

- Introduce a new IOMMU capability IOMMU_CAP_PER_DEV_PASID_SPACE, which
  represents whether the IOMMU supports an independent PASID space per-
  device, not shared across devices. ARM SMMU v3 is the case.
- Open a new API iommu_attach_device_pasid_any() to allocate any
  available PASID and attach an IOMMU domain to it.
- Opt out the use of the global PASID space for SVA if the IOMMU has
  that capability, and use the new API to allocate a PASID in that case.

Signed-off-by: Joonwon Kang <joonwonkang@google.com>
---
v1: Request comments for this approach, other possible approaches and/or
  other aspects to consider more. Code is not sanitized and commits are
  not separated appropriately in this version.

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  2 +
 drivers/iommu/iommu-sva.c                   | 44 +++++++----
 drivers/iommu/iommu.c                       | 85 ++++++++++++++++++++-
 include/linux/iommu.h                       |  5 ++
 4 files changed, 121 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 4d00d796f078..3a700ab0b5c7 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2494,6 +2494,8 @@ static bool arm_smmu_capable(struct device *dev, enum iommu_cap cap)
 		return true;
 	case IOMMU_CAP_DIRTY_TRACKING:
 		return arm_smmu_dbm_capable(master->smmu);
+	case IOMMU_CAP_PER_DEV_PASID_SPACE:
+		return true;
 	default:
 		return false;
 	}
diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 07d64908a05f..637d8fd29cbf 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -21,6 +21,7 @@ static struct iommu_mm_data *iommu_alloc_mm_data(struct mm_struct *mm, struct de
 {
 	struct iommu_mm_data *iommu_mm;
 	ioasid_t pasid;
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
 
 	lockdep_assert_held(&iommu_sva_lock);
 
@@ -39,11 +40,18 @@ static struct iommu_mm_data *iommu_alloc_mm_data(struct mm_struct *mm, struct de
 	if (!iommu_mm)
 		return ERR_PTR(-ENOMEM);
 
-	pasid = iommu_alloc_global_pasid(dev);
-	if (pasid == IOMMU_PASID_INVALID) {
-		kfree(iommu_mm);
-		return ERR_PTR(-ENOSPC);
+	if (ops->capable && ops->capable(dev, IOMMU_CAP_PER_DEV_PASID_SPACE)) {
+		pasid = IOMMU_NO_PASID;
+		iommu_mm->pasid_global = false;
+	} else {
+		pasid = iommu_alloc_global_pasid(dev);
+		if (pasid == IOMMU_PASID_INVALID) {
+			kfree(iommu_mm);
+			return ERR_PTR(-ENOSPC);
+		}
+		iommu_mm->pasid_global = true;
 	}
+
 	iommu_mm->pasid = pasid;
 	iommu_mm->mm = mm;
 	INIT_LIST_HEAD(&iommu_mm->sva_domains);
@@ -114,13 +122,15 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 		goto out_unlock;
 	}
 
-	/* Search for an existing domain. */
-	list_for_each_entry(domain, &mm->iommu_mm->sva_domains, next) {
-		ret = iommu_attach_device_pasid(domain, dev, iommu_mm->pasid,
-						&handle->handle);
-		if (!ret) {
-			domain->users++;
-			goto out;
+	if (iommu_mm->pasid != IOMMU_NO_PASID) {
+		/* Search for an existing domain. */
+		list_for_each_entry(domain, &mm->iommu_mm->sva_domains, next) {
+			ret = iommu_attach_device_pasid(domain, dev, iommu_mm->pasid,
+							&handle->handle);
+			if (!ret) {
+				domain->users++;
+				goto out;
+			}
 		}
 	}
 
@@ -131,8 +141,13 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 		goto out_free_handle;
 	}
 
-	ret = iommu_attach_device_pasid(domain, dev, iommu_mm->pasid,
-					&handle->handle);
+	if (iommu_mm->pasid != IOMMU_NO_PASID) {
+		ret = iommu_attach_device_pasid(domain, dev, iommu_mm->pasid,
+						&handle->handle);
+	} else {
+		ret = iommu_attach_device_pasid_any(domain, dev, &iommu_mm->pasid,
+						    &handle->handle);
+	}
 	if (ret)
 		goto out_free_domain;
 	domain->users = 1;
@@ -211,7 +226,8 @@ void mm_pasid_drop(struct mm_struct *mm)
 	if (!iommu_mm)
 		return;
 
-	iommu_free_global_pasid(iommu_mm->pasid);
+	if (iommu_mm->pasid_global)
+		iommu_free_global_pasid(iommu_mm->pasid);
 	kfree(iommu_mm);
 }
 
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 35db51780954..b882ecad7f57 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1061,7 +1061,7 @@ struct iommu_group *iommu_group_alloc(void)
 	mutex_init(&group->mutex);
 	INIT_LIST_HEAD(&group->devices);
 	INIT_LIST_HEAD(&group->entry);
-	xa_init(&group->pasid_array);
+	xa_init_flags(&group->pasid_array, XA_FLAGS_ALLOC);
 
 	ret = ida_alloc(&iommu_group_ida, GFP_KERNEL);
 	if (ret < 0) {
@@ -3619,6 +3619,89 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 }
 EXPORT_SYMBOL_GPL(iommu_attach_device_pasid);
 
+/**
+ * iommu_attach_device_pasid_any() - Allocate a pasid of device and attach a
+ * domain to it
+ * @domain: the iommu domain.
+ * @dev: the attached device.
+ * @pasid: pointer to the pasid of the device to be allocated.
+ * @handle: the attach handle.
+ *
+ * Caller should always provide a new handle to avoid race with the paths
+ * that have lockless reference to handle if it intends to pass a valid handle.
+ *
+ * Return: 0 on success, or an error.
+ */
+int iommu_attach_device_pasid_any(struct iommu_domain *domain,
+				  struct device *dev,
+				  ioasid_t *pasid,
+				  struct iommu_attach_handle *handle)
+{
+	/* Caller must be a probed driver on dev */
+	struct iommu_group *group = dev->iommu_group;
+	const struct iommu_ops *ops;
+	void *entry;
+	u32 new_pasid;
+	int ret;
+
+	if (!group)
+		return -ENODEV;
+
+	ops = dev_iommu_ops(dev);
+
+	if (!domain->ops->set_dev_pasid ||
+	    !ops->blocked_domain ||
+	    !ops->blocked_domain->ops->set_dev_pasid)
+		return -EOPNOTSUPP;
+
+	if (!domain_iommu_ops_compatible(ops, domain) || !pasid)
+		return -EINVAL;
+
+	mutex_lock(&group->mutex);
+
+	/*
+	 * This is a concurrent attach during a device reset. Reject it until
+	 * pci_dev_reset_iommu_done() attaches the device to group->domain.
+	 */
+	if (group->resetting_domain) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
+	entry = iommu_make_pasid_array_entry(domain, handle);
+
+	struct xa_limit limit = {
+		.min = IOMMU_FIRST_GLOBAL_PASID,
+		.max = dev->iommu->max_pasids - 1,
+	};
+
+	ret = xa_alloc(&group->pasid_array, &new_pasid, XA_ZERO_ENTRY, limit, GFP_KERNEL);
+	if (ret)
+		goto out_unlock;
+
+	ret = __iommu_set_group_pasid(domain, group, new_pasid, NULL);
+	if (ret) {
+		xa_release(&group->pasid_array, new_pasid);
+		goto out_unlock;
+	}
+
+	/*
+	 * The xa_insert() above reserved the memory, and the group->mutex is
+	 * held, this cannot fail. The new domain cannot be visible until the
+	 * operation succeeds as we cannot tolerate PRIs becoming concurrently
+	 * queued and then failing attach.
+	 */
+	WARN_ON(xa_is_err(xa_store(&group->pasid_array,
+				   new_pasid, entry, GFP_KERNEL)));
+
+	*pasid = new_pasid;
+
+out_unlock:
+	mutex_unlock(&group->mutex);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_attach_device_pasid_any);
+
 /**
  * iommu_replace_device_pasid - Replace the domain that a specific pasid
  *                              of the device is attached to
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 54b8b48c762e..1665f9fe1d8a 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -271,6 +271,7 @@ enum iommu_cap {
 	 */
 	IOMMU_CAP_DEFERRED_FLUSH,
 	IOMMU_CAP_DIRTY_TRACKING,	/* IOMMU supports dirty tracking */
+	IOMMU_CAP_PER_DEV_PASID_SPACE,	/* IOMMU supports per-device PASID space */
 };
 
 /* These are the possible reserved region types */
@@ -1136,6 +1137,7 @@ struct iommu_sva {
 
 struct iommu_mm_data {
 	u32			pasid;
+	bool			pasid_global;
 	struct mm_struct	*mm;
 	struct list_head	sva_domains;
 	struct list_head	mm_list_elm;
@@ -1184,6 +1186,9 @@ void iommu_device_release_dma_owner(struct device *dev);
 int iommu_attach_device_pasid(struct iommu_domain *domain,
 			      struct device *dev, ioasid_t pasid,
 			      struct iommu_attach_handle *handle);
+int iommu_attach_device_pasid_any(struct iommu_domain *domain,
+				  struct device *dev, ioasid_t *pasid,
+				  struct iommu_attach_handle *handle);
 void iommu_detach_device_pasid(struct iommu_domain *domain,
 			       struct device *dev, ioasid_t pasid);
 ioasid_t iommu_alloc_global_pasid(struct device *dev);
-- 
2.54.0.545.g6539524ca2-goog

