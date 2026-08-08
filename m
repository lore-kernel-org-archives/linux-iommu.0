Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4784C34EF0D
	for <iommu@lists.linux.dev>; Sat,  8 Aug 2026 02:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786156058; cv=none; b=tLgqEnQyDvNwPMGObKn4U0Gn7oiSubaupZ+BIT4WEpQweUy0jGmVoJNR7oCUQU6hgdd6SA4uXgHiCytxLKV/S1UCSJ2tBDY08O9wGJP+/naKVfXQdIDnufSokK9KL7pzIQm96avoCXf7demf7BBOe2OnMTfGmzAKAk1M1AouLwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786156058; c=relaxed/simple;
	bh=5qpVBacu4NBLAhc1pfVFf5yJFvTA4zolajEODz3I81o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y1kD4/xuiMoA8tAcc6eI1NXLaqh57XUppBl12MgJoXtfckuIKj4e4nZI09HbFgBlsThhX6d0EvM9ls1I73SB/6R9kYl9MdkdmCpq1OomVr/fzcNR77HdtaUQfGL1TxP9n77NOJ7fG+a8sxaEaf8LhKuk494EuvW9a83bA58P+rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wCbR/cc9; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wCbR/cc9"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84a3514f912so275646b3a.3
        for <iommu@lists.linux.dev>; Fri, 07 Aug 2026 19:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786156054; x=1786760854; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h0I5m3kRcm6Zim8yk8tuyJQnlP/R/V9C8d9m0BO5rXQ=;
        b=wCbR/cc9mfaY7dFU3llNnAYlSYya2ZqeqkywNFiyJrKqh2NH2LbvB4iRz8npfJtdz2
         qDvS00KtPfmqhB7G0rg6MFzJvc5W0oUv7H8tGBoQOp/y+kIGK58G/wh6Sw+dddPP0+q1
         2jS1e8iL5Z/7lMP4OMXh0tkBtd7y7gZAcqR1wudKyX+SB69YNepVmbTc4HQN6CDL5lmb
         JuJmZ5BXpdsVbz4IjxDDOql2LAxYmyCXJDLUBXNEyyT43DbRnlRBazurW4tGzZiZATTx
         3eFIsoulINfb6aByy/gnnrNyxVlHjKLLsP0BcIBhUDhDwOfwk7EjofJjzuFefnVCUFZs
         1AYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786156054; x=1786760854;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h0I5m3kRcm6Zim8yk8tuyJQnlP/R/V9C8d9m0BO5rXQ=;
        b=Vsy9PchqsMOo+R8OINLeu4fBxUus1KX2RPWjR5i05U9luz16zznrdv0MmFWQfu1MOb
         Wx/sLvseSP9kn9rbqbv6DTnzzuTaRRF4vY5EqbcldcHtW02kxHjm7zyM7UAhLX61pSw3
         Ia2jPn4zXv8QCPfoH+dfyJEidCy02F8ExwmQ7yGgesN8+TIw2lf0u6C0LpHmjW9AO9jZ
         kHWUZkUWLJIVkjoQOoPFGMLEJoucikprlL5xFzrKYsH9B34rvN4sGlsvpaOiUot3lhZ1
         AgDoeaZ9eywKsRhbn7u2hbQTPXqDq8C2ZExIfRRlW+UtSR6fgYpScHGWOPKHwKkvM2+T
         TTyw==
X-Forwarded-Encrypted: i=1; AHgh+Ro5lmmtpYCP1AiLv0OA+AwXxt8YYpzg4MoEDyDJbsRiLwGV6FVmJb8x/N0b7q+PQO/uiXRybQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz9Rgxlzv0LEK4AWsF6oYanHQrUREaBj9zr2j0UgHzDsaXz6le/
	ds7ZgKavngr3NkSRHDM/2FdYR9y2ui7ggoSXk68zaAgeL/aRDs4RXbtdYiB6zksMe0jEUPFO4AO
	xGTTV/+H6zvLd/w==
X-Received: from pfam7.prod.google.com ([2002:aa7:8a07:0:b0:847:926b:dc15])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:6c82:b0:847:5ec6:3afe with SMTP id d2e1a72fcca58-84f2e0588demr32993883b3a.31.1786156054111;
 Fri, 07 Aug 2026 19:27:34 -0700 (PDT)
Date: Sat,  8 Aug 2026 02:27:17 +0000
In-Reply-To: <20260808022723.3893618-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260808022723.3893618-1-skhawaja@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260808022723.3893618-13-skhawaja@google.com>
Subject: [PATCH v4 12/18] iommu/vt-d: Handle reattach of the restored domain
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
 drivers/iommu/intel/iommu.c      |   9 ++-
 drivers/iommu/intel/iommu.h      |  10 +++
 drivers/iommu/intel/liveupdate.c | 120 +++++++++++++++++++++++++++++++
 3 files changed, 136 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 42d3ff6db281..5370214629f4 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -864,7 +864,7 @@ static bool dev_needs_extra_dtlb_flush(struct pci_dev *pdev)
 	return true;
 }
 
-static void iommu_enable_pci_ats(struct device_domain_info *info)
+void intel_iommu_enable_pci_ats(struct device_domain_info *info)
 {
 	struct pci_dev *pdev;
 
@@ -1225,7 +1225,7 @@ domain_context_mapping(struct dmar_domain *domain, struct device *dev)
 	if (ret)
 		return ret;
 
-	iommu_enable_pci_ats(info);
+	intel_iommu_enable_pci_ats(info);
 
 	return 0;
 }
@@ -3164,6 +3164,9 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 {
 	int ret;
 
+	if (dev_iommu_restored_state(dev))
+		return intel_iommu_restore_device(domain, dev);
+
 	device_block_translation(dev);
 
 	ret = paging_domain_compatible(domain, dev);
@@ -3376,7 +3379,7 @@ static void intel_iommu_probe_finalize(struct device *dev)
 		info->pasid_enabled = 1;
 
 	if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev)) {
-		iommu_enable_pci_ats(info);
+		intel_iommu_enable_pci_ats(info);
 		/* Assign a DEVTLB cache tag to the default domain. */
 		if (info->ats_enabled && info->domain) {
 			u16 did = domain_id_iommu(info->domain, iommu);
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index b33a12528066..1ef3b9309d44 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1187,6 +1187,8 @@ void domain_detach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu);
 void device_block_translation(struct device *dev);
 int paging_domain_compatible(struct iommu_domain *domain, struct device *dev);
 
+void intel_iommu_enable_pci_ats(struct device_domain_info *info);
+
 struct dev_pasid_info *
 domain_add_dev_pasid(struct iommu_domain *domain,
 		     struct device *dev, ioasid_t pasid);
@@ -1309,6 +1311,8 @@ void intel_iommu_unpreserve(struct iommu_device *iommu,
 void clear_unpreserved_context_entries(struct intel_iommu *iommu);
 void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
 					       struct iommu_hw_ser *iommu_ser);
+int intel_iommu_restore_device(struct iommu_domain *domain,
+			       struct device *dev);
 #else
 static inline int intel_iommu_preserve_device(struct device *dev,
 					      struct iommu_device_ser *device_ser)
@@ -1340,6 +1344,12 @@ static inline void intel_iommu_liveupdate_restore_root_table(struct intel_iommu
 							     struct iommu_hw_ser *iommu_ser)
 {
 }
+
+static inline int intel_iommu_restore_device(struct iommu_domain *domain,
+					     struct device *dev)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
index 480eab2d966b..05dea3893399 100644
--- a/drivers/iommu/intel/liveupdate.c
+++ b/drivers/iommu/intel/liveupdate.c
@@ -12,6 +12,7 @@
 #include <linux/iommu-liveupdate.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/pci-ats.h>
 
 #include "iommu.h"
 #include "../iommu-pages.h"
@@ -342,6 +343,125 @@ void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
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
+	int restored_did;
+	int ret;
+
+	if (!iommu_domain_restored_state(&domain->domain))
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
+	if (!sm_supported(iommu))
+		intel_iommu_enable_pci_ats(info);
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
 /**
  * intel_iommu_preserve_device() - Intel IOMMU callback to preserve device state
  * @dev: Target device
-- 
2.55.0.679.g6767b8d81c-goog

