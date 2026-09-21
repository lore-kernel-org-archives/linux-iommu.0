Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731A82F2619
	for <iommu@lists.linux.dev>; Mon, 21 Sep 2026 00:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789951737; cv=none; b=qQ6SNynqXJQKbL9wiR5msdsspvXKINjFNtqV4hj3LwdHKR+TJa7C8c3VTZDyNqSgl9uvKnNg7abtZDN/J1jAJuLbrDyTn/gN6YUfMTDSpWYYPM+qvxh8OtTSexYTHi8NLak/u2Dn6gt4wwM72ayRhc+D1JjZ4ghvyJBb5fruGk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789951737; c=relaxed/simple;
	bh=zjw0Tnp8stathm9nlmJFxU761/AklxkMadgSeSWjsjE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IviJwK7KcKxNtqQyOTyCOFCB3X2RFTMQ2B81/ysqM6KAcCrGHEtQysOx4F4Zx0cpjeCby07PhLQNgeTduCDcaZljlogPg7GlOVbrIhhUJCSAt3IutjzfIVPP3/hK1oCv4qzwVDZwPWqINqmEyErjpKZffBW63/hlKwjJOLFcM74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k6e+3M3e; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k6e+3M3e"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2dd53f2b27cso31588205ad.0
        for <iommu@lists.linux.dev>; Sun, 20 Sep 2026 17:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789951731; x=1790556531; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6I3SvizF5qvgyNRrC3PScbaNSFdWu6HfLifwVu0oFvU=;
        b=k6e+3M3eI2xai/8ii7LFIVGoaf+nSXbcI6kTFl29H30JDXa/oOBhuboGv+hvLgF4cQ
         y6XdsOkn/EYVhYvOlZ9zbkR4/OY9EwIXfpuhAcRpfyn7NCXfSElQFR4CJBxddLNX0BL+
         VMSP4qWGI5/zFWFb827sKpUUrYZc14JzlV/+8bPrBFYz1wOWfjGUPlbtfJN0vhJ9BUDn
         S2zNbz9mL0ErJPBkthoSI6ZqanfSQ4FKvaT+fWZXcZm3eWXioqTMsj6EVK+UXjZlkeCO
         ZANu+wFyxkkqxetRCoUgHAz4x46l9n2759nEAQFi0sIGhD6w3v0TMeXZQmsdVqLLr5Yn
         HBZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789951731; x=1790556531;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6I3SvizF5qvgyNRrC3PScbaNSFdWu6HfLifwVu0oFvU=;
        b=N5n7KMw4hCimBKxWwVobmP09Sol/4+oOBffwd4hSfUfj3/RfcI27bgP0ACxmdM6dxs
         8f1yHK2cmf7wY3BTrCrZH9Gt1zUmtUOxbTs5VNSgl32eNTbKJNsfngYj+Ms6uh/Ugkfw
         NYijLyae5ZuBwOP4veBhyfkC4nxPAjEGWjkr9Utfcys0ATu3NTZ7PBrKGJgF0f16Vzef
         3QtHP1AtUHVZGH9szwFh/DvnZxIlV1czWrtr22TPKzee1Vi8a70RH3WlvXwv95zngWlg
         +wW2vF4Bcb0KaDGlVnvTmBj0QfLz7ZS4npcqoxXRkbLTI5VcDYqeuQeEYqRaHNQm/Dnl
         BMLg==
X-Forwarded-Encrypted: i=1; AKwUvBzG1jNbglWy6OupjhkWlMBmK3Eimj/itIRZZRDSYODzV5c/89Yh54WDJA5rePcYgcOvm8fk6Q==@lists.linux.dev
X-Gm-Message-State: AFuF++mO75tbNIkY2J2rFNmzrqfaPJvzL0bHBNVpymKRhgH7RQ1x6qEE
	3hA0ifAe2hLrQCieksHVOF0sSSXJEHFx7WDrOoFYft+j08kaMQ90ppN/6OvNTijiDlmBgHswU0R
	P3+LMebM55OlK+A==
X-Received: from plmm2.prod.google.com ([2002:a17:902:c442:b0:2df:4477:df93])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:bf46:b0:2dd:c100:4b79 with SMTP id d9443c01a7336-2ddc1005efcmr55134685ad.48.1789951730815;
 Sun, 20 Sep 2026 17:48:50 -0700 (PDT)
Date: Mon, 21 Sep 2026 00:48:28 +0000
In-Reply-To: <20260921004834.2601285-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260921004834.2601285-1-skhawaja@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921004834.2601285-13-skhawaja@google.com>
Subject: [PATCH v5 12/18] iommu/vt-d: Handle reattach of the restored domain
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Reattach the restored domain to the preserved device using restored
domain ID. While reattaching do not setup the context and PASID entries
as those are preserved during liveupdate.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/intel/iommu.c      |  32 +++++--
 drivers/iommu/intel/iommu.h      |  14 +++
 drivers/iommu/intel/liveupdate.c | 159 +++++++++++++++++++++++++++++++
 3 files changed, 197 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index c5044e834337..6d3cbe0745c9 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2819,6 +2819,9 @@ static int blocking_domain_attach_dev(struct iommu_domain *domain,
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 
+	if (dev_iommu_restored_state(dev))
+		return -EBUSY;
+
 	iopf_for_domain_remove(info->domain ? &info->domain->domain : NULL, dev);
 	device_block_translation(dev);
 	return 0;
@@ -3187,6 +3190,9 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 {
 	int ret;
 
+	if (dev_iommu_restored_state(dev))
+		return intel_iommu_restore_device(domain, dev);
+
 	device_block_translation(dev);
 
 	ret = paging_domain_compatible(domain, dev);
@@ -3317,7 +3323,8 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 	info->iommu = iommu;
 	RB_CLEAR_NODE(&info->node);
 	if (dev_is_pci(dev)) {
-		if (ecap_dev_iotlb_support(iommu->ecap) &&
+		if (!dev_iommu_restored_state(dev) &&
+		    ecap_dev_iotlb_support(iommu->ecap) &&
 		    pci_ats_supported(pdev) &&
 		    dmar_ats_supported(pdev, iommu)) {
 			info->ats_supported = 1;
@@ -3421,12 +3428,16 @@ static void intel_iommu_release_device(struct device *dev)
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
 
-	iommu_disable_pci_pri(info);
-	iommu_disable_pci_ats(info);
+	if (!dev_iommu_restored_state(dev)) {
+		iommu_disable_pci_pri(info);
+		iommu_disable_pci_ats(info);
 
-	if (info->pasid_enabled) {
-		pci_disable_pasid(to_pci_dev(dev));
-		info->pasid_enabled = 0;
+		if (info->pasid_enabled) {
+			pci_disable_pasid(to_pci_dev(dev));
+			info->pasid_enabled = 0;
+		}
+	} else {
+		intel_iommu_detach_restored_device(dev);
 	}
 
 	mutex_lock(&iommu->iopf_lock);
@@ -3434,11 +3445,13 @@ static void intel_iommu_release_device(struct device *dev)
 		device_rbtree_remove(info);
 	mutex_unlock(&iommu->iopf_lock);
 
-	if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev) &&
+	if (!dev_iommu_restored_state(dev) && sm_supported(iommu) &&
+	    !dev_is_real_dma_subdevice(dev) &&
 	    !context_copied(iommu, info->bus, info->devfn))
 		intel_pasid_teardown_sm_context(dev);
 
-	intel_pasid_free_table(dev);
+	if (!dev_iommu_restored_state(dev))
+		intel_pasid_free_table(dev);
 	intel_iommu_debugfs_remove_dev(info);
 	kfree(info);
 }
@@ -3900,6 +3913,9 @@ static int identity_domain_attach_dev(struct iommu_domain *domain,
 	struct intel_iommu *iommu = info->iommu;
 	int ret;
 
+	if (dev_iommu_restored_state(dev))
+		return -EBUSY;
+
 	device_block_translation(dev);
 
 	if (dev_is_real_dma_subdevice(dev))
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 3a2cb08c0ac1..25104644317c 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1310,6 +1310,9 @@ void intel_iommu_unpreserve(struct iommu_device *iommu,
 void clear_unpreserved_context_entries(struct intel_iommu *iommu);
 void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
 					       struct iommu_hw_ser *iommu_ser);
+int intel_iommu_restore_device(struct iommu_domain *domain,
+			       struct device *dev);
+int intel_iommu_detach_restored_device(struct device *dev);
 #else
 static inline void clear_unpreserved_context_entries(struct intel_iommu *iommu)
 {
@@ -1319,6 +1322,17 @@ static inline void intel_iommu_liveupdate_restore_root_table(struct intel_iommu
 							     struct iommu_hw_ser *iommu_ser)
 {
 }
+
+static inline int intel_iommu_restore_device(struct iommu_domain *domain,
+					     struct device *dev)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int intel_iommu_detach_restored_device(struct device *dev)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
index c9e553379683..6e6707eefc8c 100644
--- a/drivers/iommu/intel/liveupdate.c
+++ b/drivers/iommu/intel/liveupdate.c
@@ -351,6 +351,165 @@ void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
 	BUG_ON(iommu_for_each_preserved_device(_restore_used_domain_ids, iommu));
 }
 
+static void domain_detach_reattached_iommu(struct dmar_domain *domain,
+					   struct intel_iommu *iommu)
+{
+	struct iommu_domain_info *info;
+
+	guard(mutex)(&iommu->did_lock);
+	info = xa_load(&domain->iommu_array, iommu->seq_id);
+	if (--info->refcnt == 0) {
+		xa_erase(&domain->iommu_array, iommu->seq_id);
+		kfree(info);
+	}
+}
+
+static int domain_reattach_iommu(struct dmar_domain *domain,
+				 struct intel_iommu *iommu,
+				 struct iommu_device_ser *device_ser)
+{
+	struct iommu_domain_info *info, *curr;
+	struct iommu_domain_ser *domain_ser;
+	struct iommu_hw_ser *iommu_hw_ser;
+	int restored_did;
+	int ret;
+
+	if (!iommu_domain_restored_state(&domain->domain))
+		return -EINVAL;
+
+	if (!device_ser->domain_iommu_ser.domain_phys ||
+	    !device_ser->domain_iommu_ser.iommu_phys)
+		return -EINVAL;
+
+	domain_ser = phys_to_virt(device_ser->domain_iommu_ser.domain_phys);
+	if (domain_ser->restored_domain != &domain->domain)
+		return -EINVAL;
+
+	iommu_hw_ser = phys_to_virt(device_ser->domain_iommu_ser.iommu_phys);
+	if (iommu_hw_ser->type != IOMMU_INTEL ||
+	    iommu_hw_ser->intel.phys_addr != iommu->reg_phys)
+		return -EINVAL;
+
+	restored_did = device_ser->domain_iommu_ser.attachment_id;
+	if (!ida_exists(&iommu->domain_ida, restored_did))
+		return -EINVAL;
+
+	info = kzalloc_obj(*info);
+	if (!info)
+		return -ENOMEM;
+
+	guard(mutex)(&iommu->did_lock);
+	curr = xa_load(&domain->iommu_array, iommu->seq_id);
+	if (curr) {
+		curr->refcnt++;
+		kfree(info);
+		return 0;
+	}
+
+	info->refcnt	= 1;
+	info->did	= restored_did;
+	info->iommu	= iommu;
+	curr = xa_cmpxchg(&domain->iommu_array, iommu->seq_id,
+			  NULL, info, GFP_KERNEL);
+	if (curr) {
+		ret = xa_err(curr) ? : -EBUSY;
+		goto err_unlock;
+	}
+
+	return 0;
+
+err_unlock:
+	kfree(info);
+	return ret;
+}
+
+/**
+ * intel_iommu_restore_device() - Restore device domain attachment after live update
+ * @domain: Restored domain
+ * @dev: Restored device
+ *
+ * Return: 0 on success, or negative error code.
+ */
+int intel_iommu_restore_device(struct iommu_domain *domain,
+			       struct device *dev)
+{
+	struct iommu_device_ser *device_ser = dev_iommu_restored_state(dev);
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	struct intel_iommu *iommu = info->iommu;
+	unsigned long flags;
+	int ret;
+
+	if (!device_ser)
+		return -EINVAL;
+
+	if (dev_is_real_dma_subdevice(dev))
+		return -EOPNOTSUPP;
+
+	ret = domain_reattach_iommu(dmar_domain, iommu, device_ser);
+	if (ret)
+		return ret;
+
+	info->domain = dmar_domain;
+	info->domain_attached = true;
+	spin_lock_irqsave(&dmar_domain->lock, flags);
+	list_add(&info->link, &dmar_domain->devices);
+	spin_unlock_irqrestore(&dmar_domain->lock, flags);
+
+	ret = cache_tag_assign_domain(dmar_domain, dev, IOMMU_NO_PASID);
+	if (ret)
+		goto err;
+
+	ret = iopf_for_domain_set(domain, dev);
+	if (ret)
+		goto err;
+
+	return 0;
+
+err:
+	/*
+	 * Detach the restored domain from device and iommu on failure, but keep
+	 * the hardware state intact.
+	 */
+	info->domain_attached = false;
+	cache_tag_unassign_domain(info->domain, dev, IOMMU_NO_PASID);
+	spin_lock_irqsave(&info->domain->lock, flags);
+	list_del(&info->link);
+	spin_unlock_irqrestore(&info->domain->lock, flags);
+
+	domain_detach_reattached_iommu(info->domain, iommu);
+	info->domain = NULL;
+	return ret;
+}
+
+int intel_iommu_detach_restored_device(struct device *dev)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu = info->iommu;
+	struct iommu_domain *domain;
+	unsigned long flags;
+
+	if (!info->domain_attached || !info->domain)
+		return -EINVAL;
+
+	domain = &info->domain->domain;
+	if (!iommu_domain_restored_state(domain))
+		return -EINVAL;
+
+	iopf_for_domain_remove(domain, dev);
+	cache_tag_unassign_domain(info->domain, dev, IOMMU_NO_PASID);
+	info->domain_attached = false;
+
+	spin_lock_irqsave(&info->domain->lock, flags);
+	list_del(&info->link);
+	spin_unlock_irqrestore(&info->domain->lock, flags);
+
+	domain_detach_reattached_iommu(info->domain, iommu);
+	info->domain = NULL;
+
+	return 0;
+}
+
 /**
  * intel_iommu_preserve_device() - Intel IOMMU callback to preserve device state
  * @dev: Target device
-- 
2.55.0.1082.g2b9226bbc0-goog

