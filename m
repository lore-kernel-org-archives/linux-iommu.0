Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB34335081
	for <iommu@lists.linux.dev>; Wed,  7 Jan 2026 20:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767817086; cv=none; b=PdVa/4uAKY77KY7icOz86jzGM+5sDm0AvGx7Y6ABl2aFHEPCWF65HPVpcxtvU9E/rylY2jtgw9wNWcU0heh/X6Mr7sPSdDfmjGZLcDNV/G3X7eVOmn0JhzWOOt/XVDzPq1ywNMgehtTiOefGMm3BrOA7XPtVkhe4gSiUu4tp9KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767817086; c=relaxed/simple;
	bh=98LSmDyrncFN4yAfUmC/lF2S2QLQXjk1Mnqe7MNMAYA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TgUE/nwdaHbtfc9AAPApcgeLdiRV2FIvHuFyyEkeLR0mG2OJv9AW09mWCaTT4jVrXfSscnp+RNcYAV3a1X3Hf3lu5f6MESoDLavU9MtUlIuHk6ZDxDXSGIqOpf4mm8IkZWruAcimIhDYF0IFNV/TP8SbZhTUfkBGIknvGOhcigQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TBFMF63G; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TBFMF63G"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-34c5d6193daso4676822a91.1
        for <iommu@lists.linux.dev>; Wed, 07 Jan 2026 12:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767817084; x=1768421884; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=igY4dYldp2fGVYjzSgtn3dTLLodbnD38eUgrWzBU1Xo=;
        b=TBFMF63GBHGuSlwexXxyaKDXnUM2ldMY+LqyKqCZnyOgO+G9EY/71UXF+JLStbEO6v
         fx2zkVxZTm4OF22yCqUbnWvKt6TenLhTIWDEExP6lyaeXKXLls0rf6AvhnmIJ2Wz8RNK
         DqLbQBAfp5Dgo+oUtdrFbZUHUeQR/zuQPIlZvE5xV4rrChJhPOOP4KFpCS+LvDCrRo3F
         siL3X/+RgcJ6grPVkjkEZPbT/FoVd6ysHBWgj41ySpzI/O00NLcOYZlOMM8Hgz/cqVR5
         2fFgjURhrvAAz/Eyp3qY84nEbLTd4JL4atOWRH/4oT6wQEsJEFlLBfD51wciHkZLT46c
         mjiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767817084; x=1768421884;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=igY4dYldp2fGVYjzSgtn3dTLLodbnD38eUgrWzBU1Xo=;
        b=E8mDLoFtrl1K940j3/xedgkpfs/bya7CJdBusDc6ut0TKBtDDIQMs7hwjEw0Y0eYmG
         z20+gRNjz0bO5f62YLTD1VDW8fCzKlLqKEfuhz381JFDL43qiFqstEj5LZsXJznA7CRc
         s0XxGBHkqpgnRfKHGOY2LEl6XKsQ5AjmzK1gOemcyWZ/tK6n7kudbP0wQo0fj9yLinsn
         D2JhVuRmj4+SZiyN4X4xKx50NUGgEZZp86Nz56SmnIU2qaOIwcKsTM3v0tVKJeTGkUb1
         jd36FK1rVq5srq5RC8iCZYVr7SWegtMDHHD0D3sjMmCyr8Q4ci/TtkiIrp2/aiFrJW1r
         VLgA==
X-Forwarded-Encrypted: i=1; AJvYcCUxpcQddqSF2AvgkVEmt2ti6KNew8693wRFcE90jtsp4si5PXwITSYSsqu/2peglb8FTME1DQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzGf3SFBPj1A76+AqpS7rJAfM5U3uuiwJvd3HWbvbUqS6UOJpzV
	XgZIysNLg2w3PZI1HLfJTL/q3f4LlSOjwDzGlp4dY5oQlU3uZ8rwaRUIQK7sxUd4EsVR9YwvNBC
	zpgDC1/J3If6OUQ==
X-Google-Smtp-Source: AGHT+IHfXVop97/Vz192HqH+eaT1EXDIWQ0CMkd2UMbL7Q1pQUtgV9kwq04SG9DCOLRooq67paZ2vlfZ5GXHcw==
X-Received: from pjcc11.prod.google.com ([2002:a17:90b:574b:b0:34c:c510:f186])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:544f:b0:343:7714:4ca8 with SMTP id 98e67ed59e1d1-34f68c94494mr3403970a91.15.1767817084253;
 Wed, 07 Jan 2026 12:18:04 -0800 (PST)
Date: Wed,  7 Jan 2026 20:17:58 +0000
In-Reply-To: <20260107201800.2486137-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260107201800.2486137-1-skhawaja@google.com>
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20260107201800.2486137-2-skhawaja@google.com>
Subject: [PATCH 1/3] iommu/vt-d: Allow replacing no_pasid iommu_domain
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	David Matlack <dmatlack@google.com>
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

Intel IOMMU driver already supports replacing IOMMU domains attachments
with PASIDs. Add support for replacing a domain attached with no_pasid.
This includes replacing domains in legacy mode.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/intel/iommu.c | 107 ++++++++++++++++++++++++++----------
 1 file changed, 77 insertions(+), 30 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 134302fbcd92..c0e359fd3ee1 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1140,6 +1140,7 @@ static void context_present_cache_flush(struct intel_iommu *iommu, u16 did,
 }
 
 static int domain_context_mapping_one(struct dmar_domain *domain,
+				      struct dmar_domain *old_domain,
 				      struct intel_iommu *iommu,
 				      u8 bus, u8 devfn)
 {
@@ -1148,7 +1149,8 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 	u16 did = domain_id_iommu(domain, iommu);
 	int translation = CONTEXT_TT_MULTI_LEVEL;
 	struct pt_iommu_vtdss_hw_info pt_info;
-	struct context_entry *context;
+	struct context_entry *context, new_context;
+	u16 did_old;
 	int ret;
 
 	if (WARN_ON(!intel_domain_is_ss_paging(domain)))
@@ -1166,26 +1168,44 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 		goto out_unlock;
 
 	ret = 0;
-	if (context_present(context) && !context_copied(iommu, bus, devfn))
+	if (!old_domain && (context_present(context) && !context_copied(iommu, bus, devfn)))
 		goto out_unlock;
 
+	if (old_domain) {
+		did_old = context_domain_id(context);
+		WARN_ON(did_old != domain_id_iommu(old_domain, iommu));
+	}
+
 	copied_context_tear_down(iommu, context, bus, devfn);
-	context_clear_entry(context);
-	context_set_domain_id(context, did);
+	context_set_domain_id(&new_context, did);
 
 	if (info && info->ats_supported)
 		translation = CONTEXT_TT_DEV_IOTLB;
 	else
 		translation = CONTEXT_TT_MULTI_LEVEL;
 
-	context_set_address_root(context, pt_info.ssptptr);
-	context_set_address_width(context, pt_info.aw);
-	context_set_translation_type(context, translation);
-	context_set_fault_enable(context);
-	context_set_present(context);
+	context_set_address_root(&new_context, pt_info.ssptptr);
+	context_set_address_width(&new_context, pt_info.aw);
+	context_set_translation_type(&new_context, translation);
+	context_set_fault_enable(&new_context);
+	context_set_present(&new_context);
+
+	*context = new_context;
 	if (!ecap_coherent(iommu->ecap))
 		clflush_cache_range(context, sizeof(*context));
-	context_present_cache_flush(iommu, did, bus, devfn);
+
+	/*
+	 * Spec 6.5.3.3, changing a present context entry requires,
+	 * - IOTLB invalidation for each effected Domain.
+	 * - Issue Device IOTLB invalidation for function.
+	 */
+	if (old_domain) {
+		intel_context_flush_no_pasid(info, context, did);
+		intel_context_flush_no_pasid(info, context, did_old);
+	} else {
+		context_present_cache_flush(iommu, did, bus, devfn);
+	}
+
 	ret = 0;
 
 out_unlock:
@@ -1194,30 +1214,39 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 	return ret;
 }
 
+struct domain_context_mapping_data {
+	struct dmar_domain *domain;
+	struct dmar_domain *old_domain;
+};
+
 static int domain_context_mapping_cb(struct pci_dev *pdev,
 				     u16 alias, void *opaque)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(&pdev->dev);
 	struct intel_iommu *iommu = info->iommu;
-	struct dmar_domain *domain = opaque;
+	struct domain_context_mapping_data *data = opaque;
 
-	return domain_context_mapping_one(domain, iommu,
+	return domain_context_mapping_one(data->domain, data->old_domain, iommu,
 					  PCI_BUS_NUM(alias), alias & 0xff);
 }
 
 static int
-domain_context_mapping(struct dmar_domain *domain, struct device *dev)
+domain_context_mapping(struct dmar_domain *domain,
+		       struct dmar_domain *old_domain, struct device *dev)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
 	u8 bus = info->bus, devfn = info->devfn;
+	struct domain_context_mapping_data data;
 	int ret;
 
 	if (!dev_is_pci(dev))
-		return domain_context_mapping_one(domain, iommu, bus, devfn);
+		return domain_context_mapping_one(domain, old_domain, iommu, bus, devfn);
 
+	data.domain = domain;
+	data.old_domain = old_domain;
 	ret = pci_for_each_dma_alias(to_pci_dev(dev),
-				     domain_context_mapping_cb, domain);
+				     domain_context_mapping_cb, &data);
 	if (ret)
 		return ret;
 
@@ -1309,18 +1338,28 @@ static int domain_setup_first_level(struct intel_iommu *iommu,
 					  pt_info.gcr3_pt, flags, old);
 }
 
-static int dmar_domain_attach_device(struct dmar_domain *domain,
-				     struct device *dev)
+static int device_replace_dmar_domain(struct dmar_domain *domain,
+				      struct dmar_domain *old_domain,
+				      struct device *dev)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
 	unsigned long flags;
 	int ret;
 
+	if (old_domain && dev_is_real_dma_subdevice(dev))
+		return -EOPNOTSUPP;
+
 	ret = domain_attach_iommu(domain, iommu);
 	if (ret)
 		return ret;
 
+	if (old_domain) {
+		spin_lock_irqsave(&info->domain->lock, flags);
+		list_del(&info->link);
+		spin_unlock_irqrestore(&info->domain->lock, flags);
+	}
+
 	info->domain = domain;
 	info->domain_attached = true;
 	spin_lock_irqsave(&domain->lock, flags);
@@ -1331,27 +1370,27 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
 		return 0;
 
 	if (!sm_supported(iommu))
-		ret = domain_context_mapping(domain, dev);
+		ret = domain_context_mapping(domain, old_domain, dev);
 	else if (intel_domain_is_fs_paging(domain))
 		ret = domain_setup_first_level(iommu, domain, dev,
-					       IOMMU_NO_PASID, NULL);
+					       IOMMU_NO_PASID, &old_domain->domain);
 	else if (intel_domain_is_ss_paging(domain))
 		ret = domain_setup_second_level(iommu, domain, dev,
-						IOMMU_NO_PASID, NULL);
+						IOMMU_NO_PASID, &old_domain->domain);
 	else if (WARN_ON(true))
 		ret = -EINVAL;
 
-	if (ret)
-		goto out_block_translation;
+	if (!ret)
+		ret = cache_tag_assign_domain(domain, dev, IOMMU_NO_PASID);
 
-	ret = cache_tag_assign_domain(domain, dev, IOMMU_NO_PASID);
 	if (ret)
-		goto out_block_translation;
+		device_block_translation(dev);
 
-	return 0;
+	if (old_domain) {
+		cache_tag_unassign_domain(old_domain, dev, IOMMU_NO_PASID);
+		domain_detach_iommu(old_domain, iommu);
+	}
 
-out_block_translation:
-	device_block_translation(dev);
 	return ret;
 }
 
@@ -3127,19 +3166,27 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 				     struct device *dev,
 				     struct iommu_domain *old)
 {
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	int ret;
 
-	device_block_translation(dev);
+	if (dev_is_real_dma_subdevice(dev) ||
+	    domain->type != __IOMMU_DOMAIN_PAGING ||
+	    !info->domain || &info->domain->domain != old)
+		old = NULL;
+
+	if (!old)
+		device_block_translation(dev);
 
 	ret = paging_domain_compatible(domain, dev);
 	if (ret)
 		return ret;
 
-	ret = iopf_for_domain_set(domain, dev);
+	ret = iopf_for_domain_replace(domain, old, dev);
 	if (ret)
 		return ret;
 
-	ret = dmar_domain_attach_device(to_dmar_domain(domain), dev);
+	ret = device_replace_dmar_domain(to_dmar_domain(domain),
+					 old ? to_dmar_domain(old) : NULL, dev);
 	if (ret)
 		iopf_for_domain_remove(domain, dev);
 
-- 
2.52.0.351.gbe84eed79e-goog

