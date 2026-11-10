Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794283727;
	b=CmgQKu7ucpqtsp/T4s7gb/rFBIeJJSkhwjrf/1IyywL8lC5kDgj6sJkkPxJfnPwDXovj
	 mV2ufdmnwXRsyQ/lMf/g5Ac5aC9rJ0RtfCj97R/jYc3PIsKRZ28dbbPnDtXMJge3UkoDL
	 c5Qv1AiX6t5C3bGXvdqhWWetgy7FqZKdw143nItxKHZeegIZqrwDZ7k23nngNGtYoC/oH
	 eTcV0a9oms3UAMb5hIRIZT6iPKVufc3d6SQ0a+6uj7/kG0tgOeb9wbqcD0UffUNQzvds7
	 FUf1zCXWV6ytxLJ0pGAZmel2pGBWto0CGfy8XzgarwrfGL3zqRpJIGR0f+r42Q91sNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283727;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=nF7PeotkxI25PsxTGqryYBvXwPt4qCKTDConpXkI7U8=;
	b=EyM0U6KV95M68ZDPxbdga+K9Y51h7daXiIIk5UZwfDK7jQRSjpJpt6eHB7RVaCkryoLR
	 eSDX5J2Bng1750pRgh1HfzvuFgZbuTBu/0AfkZ6sAHLS6ltK3X5ctgD61JxwdF6aNtJqO
	 bxZ/sRBps2i7rpkYL87tDDdu/OPJKDaVXKyhlH8TbcXn6o5gMGbmM7iGijGOl1BPu9XGV
	 +HxYhgoDjOMXas7KJFL5cAgO5J+g3q2Z6d9t2ATaPfDST0fkG99e2ZSYOgfJp6L5wILnD
	 Ym4a8UGJ926hdSZeuDGUu5M276MhKb/qKDeOdgzDEp50f10Ne/Ku3JGpT0amuejL41g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EKXcFt+S;
	arc=none smtp.remote-ip=209.85.167.197
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF0A606AA1E
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 04:08:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CF0A606AA1E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EKXcFt+S
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-567ac848d83so2053540b6e.3
        for <iommu@lists.linux.dev>; Mon, 09 Nov 2026 20:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794283726; x=1794888526; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nF7PeotkxI25PsxTGqryYBvXwPt4qCKTDConpXkI7U8=;
        b=EKXcFt+SiZJlUOciUnrF6HOscBZLjEX5m4Plz943GOV6tdM0wqRXOAz0+NBXbbsx8M
         6JIGdq8wIMNXRTSKrXIdCoclULuFaReSvVrAvzUY2SxZdb0bQcvefMuNuY5htgpp/URZ
         gXIl+JQrYzUyRVMt2axUjca/5y0XpxPJxQqpOpMrLtw4e2W4dt4XErRYSdpd0S8MeeTs
         tYxIG1BMEGKJ0hdrpDCZFlNT+oykp3qsK7mZPL7Ivlr6gWyq7Zz55hk8j4k09gKdofZm
         8Va6KDQq03vLDXZX0/BEfqS1bnMaMVmoLayWNsYR4DBFrZoTmP0W5O2SIcJV8f+znkyN
         O2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794283726; x=1794888526;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nF7PeotkxI25PsxTGqryYBvXwPt4qCKTDConpXkI7U8=;
        b=An91LClxCCnJlVFGtPMIhwRjYvrwKx/cklGSXsNEXLPCnCb157z44dq1FF5PUSiIao
         DtbWKG2NKEKC3neNoEHDzVi2sKWRZFn4t7yreKT659WzsTDMDwQnc8ZC6HwycIdhWTd8
         0eC1uyAiAT1qE6/2lq/WO4zP5CAIae29VJz1AxiWVS/MX2rqzVsdjr1tCCwwrTdP2BxJ
         aqz98qer/NGrkJLxH2YwrHFsSli73MGpLw4U8+aOiCW9wRFaM2YWxxPAJZ9QkBwl3Hdn
         Ld9fytCrovFHSsH05KzyrcbSit360vESY1C3qwEfXa2+C8knTuIKNPgExjuGMWoZauBL
         UGVg==
X-Forwarded-Encrypted: i=1; AL+hErGipD2u4GMUEm/YWnJC+tAO3cOA+ddhg8jmkI3Ucgfa3ihc+HnwnE9GoslLn491gnG/Gen8vQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+f969NOBZYk0D6s8WnRnmejR5CqZ/ucc5VKzrkWdw4ITrBb1/t
	IDzZADd1FLOGCuHQDIEhwovQ7SQu/CMAcDJnNEXipUNx6ZPFlUjm88rFD3IC/oVRWap/DXcbmYD
	r7gfoWvCsYotmBQ==
X-Received: from iogp8-n1.prod.google.com ([2002:a05:6602:c3c8:10b0:9cb:8099:40ad])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:120c:b0:4e6:e72a:1ba0 with SMTP id 5614622812f47-5683cbf0072mr1235923b6e.12.1794283726109;
 Mon, 09 Nov 2026 20:08:46 -0800 (PST)
Date: Tue, 10 Nov 2026 04:08:19 +0000
In-Reply-To: <20261110040828.1774343-1-skhawaja@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261110040828.1774343-1-skhawaja@google.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
Message-ID: <20261110040828.1774343-14-skhawaja@google.com>
Subject: [PATCH v7 13/18] iommu/vt-d: Handle reattach of the restored domain
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
 drivers/iommu/intel/iommu.c      |  28 ++++--
 drivers/iommu/intel/iommu.h      |  14 +++
 drivers/iommu/intel/liveupdate.c | 141 +++++++++++++++++++++++++++++++
 3 files changed, 175 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index b3402fd9fe75..95ec37554360 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3296,6 +3296,9 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 {
 	int ret;
 
+	if (dev_iommu_restored_state(dev))
+		return intel_iommu_attach_restored_device(domain, dev);
+
 	device_block_translation(dev);
 
 	ret = paging_domain_compatible(domain, dev);
@@ -3426,7 +3429,8 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 	info->iommu = iommu;
 	RB_CLEAR_NODE(&info->node);
 	if (dev_is_pci(dev)) {
-		if (ecap_dev_iotlb_support(iommu->ecap) &&
+		if (!dev_iommu_restored_state(dev) &&
+		    ecap_dev_iotlb_support(iommu->ecap) &&
 		    pci_ats_supported(pdev) &&
 		    dmar_ats_supported(pdev, iommu)) {
 			info->ats_supported = 1;
@@ -3531,12 +3535,16 @@ static void intel_iommu_release_device(struct device *dev)
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
@@ -3544,11 +3552,15 @@ static void intel_iommu_release_device(struct device *dev)
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
index 633747672c22..301f3f70e583 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1322,6 +1322,9 @@ void intel_iommu_shutdown_preserved(struct dmar_drhd_unit *drhd);
 void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
 					       struct iommu_hw_ser *iommu_ser);
 void intel_iommu_handle_drhd_restore_failure(struct intel_iommu *iommu);
+int intel_iommu_attach_restored_device(struct iommu_domain *domain,
+				       struct device *dev);
+int intel_iommu_detach_restored_device(struct device *dev);
 #else
 static inline void intel_iommu_shutdown_preserved(struct dmar_drhd_unit *drhd)
 {
@@ -1335,6 +1338,17 @@ static inline void intel_iommu_liveupdate_restore_root_table(struct intel_iommu
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
 #endif
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
index 34651698b8e9..4bc882117e21 100644
--- a/drivers/iommu/intel/liveupdate.c
+++ b/drivers/iommu/intel/liveupdate.c
@@ -444,6 +444,147 @@ void intel_iommu_handle_drhd_restore_failure(struct intel_iommu *iommu)
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
 enum pasid_lu_op {
 	PASID_LU_OP_PRESERVE = 1,
 	PASID_LU_OP_UNPRESERVE,
-- 
2.56.0.506.g506a7eabc5-goog

