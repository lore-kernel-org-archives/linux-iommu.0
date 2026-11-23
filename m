Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795409404;
	b=4Kv/hqicvIYXhzIczOs5Eb1elN+H+jKkQx0XMJMan3nQ3hRDlUJ4DBAnp6x7OJ2DQ3p9
	 4sbdonCep4pXoG57BSlN1ODq2awLGbuKuaGUcMG/71Rfl0htWzyIaJ2Qfe33haqQ9HKg3
	 7+s7odXC7Im7zXJDGZFE23nMjVCUOISzXfQd6mq22XHXetcMIrkRjTCNWT1ftDDAZ4gVb
	 3h6NB6uXvGzA2eSjB7m6jjgtT9Pm5AWUAXNVuobY8b7ikddRIEIXP9QZ16OaYj9GxpdfH
	 ZZTLIFfGDazCil2w38Nemz15I5CXLdqsfslvA/xLTrqc6BoNrMHlz/sJ5dy+WOYje5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795409404;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=yg/KRlw/V2MQ/sD342ulB7AO28VSZsdYlNxvULrEbAA=;
	b=DW9YA0fKiQNP5wpr2LLs9LxnlLNRe1m/kPnYLiMXSk2V0k9ELSWctUHv7n9d94PxVJTH
	 cnz6mKWzRabVPH5d7zVjd9KJ0tx2zEZiL7ZCd2o6Da/b/twGIgdabSfOwd4tJHZjs6xHV
	 9poPr0hDzBmuWuyeiqhC0+hg0ErDtlxYXO8OVpbOPK1bxCzGXJqhmW8TKDZ4zyP4XttA1
	 kRhbo4oc7qw1HvYkUWoJAJh+by+A5heCpN8BIVOa72IRb+nTzEOQxYhKGfre3ZYHPw2Km
	 avNV1bwdrUOWXASBBrsUuZQloyhzpnNm3bHc5fk5ZeiY1RZbAemV2odkQYdkwVfft0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Dx8DqcZo;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E2160A6F5F
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 04:50:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30E2160A6F5F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Dx8DqcZo
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ae7faf4ff7so3582446a91.3
        for <iommu@lists.linux.dev>; Sun, 22 Nov 2026 20:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795409403; x=1796014203; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yg/KRlw/V2MQ/sD342ulB7AO28VSZsdYlNxvULrEbAA=;
        b=Dx8DqcZo0p8InZ+XPpdQlxfpLiKwiaoEbWjdAdfBddioDsIIjQMCePE0Eu14/xdm7J
         ywPGZMLGY3BQi6683BUEkQBIUuHB8Ea/efZv+atCUZhYMeJNGeTB4X4c0LKfqWL99nHe
         Viq75OKYhJ/CYoqYXkhaML+fA+XQkQMWSX1dYo5RvvlL1GynlOo00aNhmn9ndp9h/Wau
         1qCLeJEGa9qqcwAWy6SrbOMdG5xsUdAUpteUcBOH3/8Qwoe3XRjCRP7h5+lWwylC1LqT
         57hyLQBXSVWHWDfk1ual7/sgAT9NW750zcw0THv5jo+hb8AzWY83CDiCjtK7D6IIPrnx
         2AMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795409403; x=1796014203;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yg/KRlw/V2MQ/sD342ulB7AO28VSZsdYlNxvULrEbAA=;
        b=Z3UsWq+OKxP+JgunLZgZQF6lvzyoX6Ta1sjUAL/0dhEAg2KKIqKZoX4YJA5jGMIxQ7
         KxPhx0DpWxrhX5j/p+Hjvn0ZVyXf9vQLh4l1mUUUClyZwgxKIrLtMyfedwHZB/leSPiV
         LqhI7YGLIADwbBpI6Ups/uziz/ljfMujxtoqqKRGUPiJrBVaSzWrpJ7CJcb7OakdkK4W
         z92LZdp9TZhdSPKiVu1rmTyJEqQGES6JXi/LdqiEaCy+hWPxDr8UZRGioSQchIgB0hUm
         6RxtmQn/bsX8CKo0nkj+KdP8AbB0BrjMASDYq9+6KUisM0+AaZeG+lK8QaLeoBHUgVaq
         tfng==
X-Forwarded-Encrypted: i=1; AL+hErGEpY80vjrMjgpIV8rkQ7Jkyrr2qEYQB/R+3VT3i/mCSGZ2AjxaqaJlQMlU2eY/WlZgzY+Vog==@lists.linux.dev
X-Gm-Message-State: APuU4Z9tgtZq0iIpavTHgdl0bKqNDUd9wevxBHnK6nsFwedYIm2I5uPh
	pXEoheOS2RDviOILah7aQ6z7TdO17Um4r6m2m2/ErYl4SOXbA5fAbbVZQX0oO86XAMLd+U9t10S
	5viCBOBCVJ7P6KQ==
X-Received: from pjzv20.prod.google.com ([2002:a17:90b:414:b0:3b4:2a5f:97bc])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:560f:b0:3b4:60aa:9b74 with SMTP id 98e67ed59e1d1-3b460aaa7efmr4371271a91.65.1795409403328;
 Sun, 22 Nov 2026 20:50:03 -0800 (PST)
Date: Mon, 23 Nov 2026 04:49:45 +0000
In-Reply-To: <20261123044949.3610702-1-skhawaja@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261123044949.3610702-1-skhawaja@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261123044949.3610702-15-skhawaja@google.com>
Subject: [PATCH v8 14/18] iommu/vt-d: Handle reattach of the restored domain
From: Samiullah Khawaja <skhawaja@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	David Woodhouse <dwmw2@infradead.org>
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>, Ankit Soni <Ankit.Soni@amd.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, John Starks <dev@jstarks.net>
Content-Type: text/plain; charset="UTF-8"

Reattach the restored domain to the preserved device using restored
domain ID. While reattaching do not setup the context and PASID entries
as those are preserved during liveupdate.

Note that in this phase nothing clears IOMMU_SER_FLAG_INCOMING of the
restored domain or the restored state of the device, so the restored
domain cannot be replaced yet. Replacing it is left to a later phase.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/intel/iommu.c      |  36 ++++++-
 drivers/iommu/intel/iommu.h      |  20 ++++
 drivers/iommu/intel/liveupdate.c | 170 +++++++++++++++++++++++++++++++
 3 files changed, 224 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index a487b6ca0415..3b31d0962e33 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3174,6 +3174,25 @@ intel_iommu_domain_alloc_second_stage(struct device *dev,
 	return &dmar_domain->domain;
 }
 
+/*
+ * A restored device translates through the preserved page table, so use the
+ * stage of its preserved RID_PASID entry. The stage allocators reject flags
+ * that the stage doesn't support.
+ */
+static struct iommu_domain *
+intel_iommu_domain_alloc_restored(struct device *dev, struct intel_iommu *iommu,
+				  u32 flags)
+{
+	switch (intel_iommu_restored_pgtt(dev)) {
+	case PASID_ENTRY_PGTT_FL_ONLY:
+		return intel_iommu_domain_alloc_first_stage(dev, iommu, flags);
+	case PASID_ENTRY_PGTT_SL_ONLY:
+		return intel_iommu_domain_alloc_second_stage(dev, iommu, flags);
+	default:
+		return ERR_PTR(-EINVAL);
+	}
+}
+
 static struct iommu_domain *
 intel_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
 				      const struct iommu_user_data *user_data)
@@ -3185,6 +3204,9 @@ intel_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
 	if (user_data)
 		return ERR_PTR(-EOPNOTSUPP);
 
+	if (dev_iommu_restored_state(dev))
+		return intel_iommu_domain_alloc_restored(dev, iommu, flags);
+
 	/* Prefer first stage if possible by default. */
 	domain = intel_iommu_domain_alloc_first_stage(dev, iommu, flags);
 	if (domain != ERR_PTR(-EOPNOTSUPP))
@@ -3325,6 +3347,9 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 {
 	int ret;
 
+	if (dev_iommu_restored_state(dev))
+		return intel_iommu_attach_restored_device(domain, dev);
+
 	device_block_translation(dev);
 
 	ret = paging_domain_compatible(domain, dev);
@@ -3568,16 +3593,23 @@ static void intel_iommu_release_device(struct device *dev)
 		info->pasid_enabled = 0;
 	}
 
+	if (dev_iommu_restored_state(dev))
+		intel_iommu_detach_restored_device(dev);
+
 	mutex_lock(&iommu->iopf_lock);
 	if (dev_is_pci(dev) && pci_ats_supported(to_pci_dev(dev)))
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
+	else
+		kfree(info->pasid_table);
 	intel_iommu_debugfs_remove_dev(info);
 	kfree(info);
 }
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 633747672c22..7e397eed391a 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1322,6 +1322,10 @@ void intel_iommu_shutdown_preserved(struct dmar_drhd_unit *drhd);
 void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
 					       struct iommu_hw_ser *iommu_ser);
 void intel_iommu_handle_drhd_restore_failure(struct intel_iommu *iommu);
+int intel_iommu_attach_restored_device(struct iommu_domain *domain,
+				       struct device *dev);
+int intel_iommu_detach_restored_device(struct device *dev);
+u16 intel_iommu_restored_pgtt(struct device *dev);
 #else
 static inline void intel_iommu_shutdown_preserved(struct dmar_drhd_unit *drhd)
 {
@@ -1335,6 +1339,22 @@ static inline void intel_iommu_liveupdate_restore_root_table(struct intel_iommu
 static inline void intel_iommu_handle_drhd_restore_failure(struct intel_iommu *iommu)
 {
 }
+
+static inline int intel_iommu_attach_restored_device(struct iommu_domain *domain,
+						     struct device *dev)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int intel_iommu_detach_restored_device(struct device *dev)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline u16 intel_iommu_restored_pgtt(struct device *dev)
+{
+	return 0;
+}
 #endif
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
index 34651698b8e9..f907e52576e5 100644
--- a/drivers/iommu/intel/liveupdate.c
+++ b/drivers/iommu/intel/liveupdate.c
@@ -444,6 +444,176 @@ void intel_iommu_handle_drhd_restore_failure(struct intel_iommu *iommu)
 		      iommu->name);
 }
 
+static void domain_detach_restored_iommu(struct dmar_domain *domain,
+					 struct intel_iommu *iommu)
+{
+	struct iommu_domain_info *info;
+
+	/*
+	 * Unlike domain_detach_iommu(), the restored domain ID is not freed
+	 * here. A restored device can be removed and probed again while its
+	 * preserved context and PASID entries still use this domain ID, so it
+	 * stays reserved. Once iommufd reclaims the restored domain, the
+	 * normal detach path frees it.
+	 */
+	guard(mutex)(&iommu->did_lock);
+	info = xa_load(&domain->iommu_array, iommu->seq_id);
+	if (--info->refcnt == 0) {
+		xa_erase(&domain->iommu_array, iommu->seq_id);
+		kfree(info);
+	}
+}
+
+static int domain_attach_restored_iommu(struct dmar_domain *domain,
+					struct intel_iommu *iommu,
+					struct iommu_device_ser *device_ser)
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
+	if (!device_ser->attachment.domain_phys ||
+	    !device_ser->iommu_phys)
+		return -EINVAL;
+
+	domain_ser = phys_to_virt(device_ser->attachment.domain_phys);
+	if (domain_ser->restored_domain != &domain->domain)
+		return -EINVAL;
+
+	iommu_hw_ser = phys_to_virt(device_ser->iommu_phys);
+	if (iommu_hw_ser->type != IOMMU_SER_TYPE_INTEL ||
+	    iommu_hw_ser->intel.phys_addr != iommu->reg_phys)
+		return -EINVAL;
+
+	restored_did = device_ser->attachment.attachment_id;
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
+		kfree(info);
+		if (WARN_ON(curr->did != restored_did))
+			return -EINVAL;
+
+		curr->refcnt++;
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
+ * intel_iommu_attach_restored_device() - Restore device domain attachment after live update
+ * @domain: Restored domain
+ * @dev: Restored device
+ *
+ * Return: 0 on success, or negative error code.
+ */
+int intel_iommu_attach_restored_device(struct iommu_domain *domain,
+				       struct device *dev)
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
+	ret = domain_attach_restored_iommu(dmar_domain, iommu, device_ser);
+	if (ret)
+		return ret;
+
+	info->domain = dmar_domain;
+	info->domain_attached = true;
+	spin_lock_irqsave(&dmar_domain->lock, flags);
+	list_add(&info->link, &dmar_domain->devices);
+	spin_unlock_irqrestore(&dmar_domain->lock, flags);
+
+	return 0;
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
+	info->domain_attached = false;
+
+	spin_lock_irqsave(&info->domain->lock, flags);
+	list_del(&info->link);
+	spin_unlock_irqrestore(&info->domain->lock, flags);
+
+	domain_detach_restored_iommu(info->domain, iommu);
+	info->domain = NULL;
+
+	return 0;
+}
+
+/**
+ * intel_iommu_restored_pgtt() - Get the translation type of a restored device
+ * @dev: Restored device
+ *
+ * Return: PGTT of the preserved RID_PASID entry of @dev, or 0 if the entry is
+ * not present. Without a preserved PASID table the IOMMU is in legacy mode,
+ * which only supports second stage, so PASID_ENTRY_PGTT_SL_ONLY is returned.
+ */
+u16 intel_iommu_restored_pgtt(struct device *dev)
+{
+	struct iommu_device_ser *ser = dev_iommu_restored_state(dev);
+	struct pasid_entry *table, *pte;
+	struct pasid_dir_entry *dir;
+
+	if (!ser->intel.pasid_table)
+		return PASID_ENTRY_PGTT_SL_ONLY;
+
+	dir = phys_to_virt(ser->intel.pasid_table);
+	table = get_pasid_table_from_pde(&dir[IOMMU_NO_PASID >> PASID_PDE_SHIFT]);
+	if (!table)
+		return 0;
+
+	pte = &table[IOMMU_NO_PASID & PASID_PTE_MASK];
+	if (!pasid_pte_is_present(pte))
+		return 0;
+
+	return pasid_pte_get_pgtt(pte);
+}
+
 enum pasid_lu_op {
 	PASID_LU_OP_PRESERVE = 1,
 	PASID_LU_OP_UNPRESERVE,
-- 
2.56.1.809.ga0b61035b5-goog

