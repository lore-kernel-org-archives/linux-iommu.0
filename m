Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236B529405
	for <iommu@lists.linux.dev>; Mon,  4 Nov 2024 13:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730726334; cv=none; b=MJQxNqI5Tz55x29LfDO5WHi/Px5TZsjmD3P0rFNmQHihtsEGZ9p+CHUg247JQoA2U2DWsu5M0UobEgT9lBzjf/+A/B52/KUsJyLjBKDSWZEtDZfDp8Z6WYYIz4sxiocAbbgyrq2lLjUNfd+9xPZvrtosubVlhfFHCdj8UNWuqeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730726334; c=relaxed/simple;
	bh=gMYG7UOEuMyu8AfR7Pogm+TtNwTYxh9McZ89AwcDOQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s5wLdSsj34myaLspS4l1Z6Agsd2U/2qQjHyM7iyKwPiTtmVrbjnC7krAHZkESF7g9lxaLX60TL59f3hFtH7rVQAkniXs9VSuQkkwfZXCtcHKUaK4If8GXl+R01E/PBwu057SFxc7rmPbAdltyAlHk6Wlp4cIkIJ/376gnzqWU60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LGb4n2GJ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LGb4n2GJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730726333; x=1762262333;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gMYG7UOEuMyu8AfR7Pogm+TtNwTYxh9McZ89AwcDOQ4=;
  b=LGb4n2GJ/UMiEXZm4cRHcWog8wh+XcTXqC7GtB6FRXW9VVS7saybMzfO
   wactSuBqV9HUFyuXTAUJauhbp3Ypc/zu3KQ1cSPKDER69CRsUnw2RvL7L
   2QRsic9zeN42jT4Icg6hkdrIGZ5MP+RE/MnC4yFURhDd6dxNSU7U7Aa9q
   eBxuEThLvHWhRdpC3mgu912j0Qk+UHQIAEoEc+M/EoXQr2qz+xHUewCyX
   wXmZQeCsYa80H2GbDztd+eZAlAHNpPl+fg+gy2huhnsBwJ01LNp/5UOdJ
   eks3p2Iqjh84gUqEvg/wxUkoUasgGiBpskvdI5VgrEXExYwLQRNMceych
   Q==;
X-CSE-ConnectionGUID: UF5wecCcREe6hrUKSsJrQw==
X-CSE-MsgGUID: /K2Jh0vrSd6sNdTwWBL0oQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="41003734"
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="41003734"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 05:18:52 -0800
X-CSE-ConnectionGUID: SipXGohaQgCHpKxgcNfQ1g==
X-CSE-MsgGUID: q+grGuPTRdSJ9LF90NPSBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="83999490"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmviesa010.fm.intel.com with ESMTP; 04 Nov 2024 05:18:48 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: alex.williamson@redhat.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	zhenzhong.duan@intel.com,
	vasant.hegde@amd.com,
	will@kernel.org
Subject: [PATCH v4 05/13] iommu/vt-d: Prepare intel_iommu_set_dev_pasid() handle replacement
Date: Mon,  4 Nov 2024 05:18:34 -0800
Message-Id: <20241104131842.13303-6-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104131842.13303-1-yi.l.liu@intel.com>
References: <20241104131842.13303-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To handle domain replacement, the intel_iommu_set_dev_pasid() needs to
keep the old configuration and the prepare for the new setup. This requires
a bit refactoring to prepare for it.

domain_add_dev_pasid() and domain_remove_dev_pasid() are added to add/remove
the dev_pasid_info which represents the association of the pasid/device and
domain. Till now, it's still not ready for replacement yet.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.c | 90 +++++++++++++++++++++++++------------
 1 file changed, 61 insertions(+), 29 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 86000901de46..6bc5ce03c6f5 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4252,8 +4252,8 @@ static int intel_iommu_iotlb_sync_map(struct iommu_domain *domain,
 	return 0;
 }
 
-static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
-					 struct iommu_domain *domain)
+static void domain_remove_dev_pasid(struct iommu_domain *domain,
+				    struct device *dev, ioasid_t pasid)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct dev_pasid_info *curr, *dev_pasid = NULL;
@@ -4261,10 +4261,12 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
 	struct dmar_domain *dmar_domain;
 	unsigned long flags;
 
-	if (domain->type == IOMMU_DOMAIN_IDENTITY) {
-		intel_pasid_tear_down_entry(iommu, dev, pasid, false);
+	if (!domain)
+		return;
+
+	/* Identity domain has no meta data for pasid. */
+	if (domain->type == IOMMU_DOMAIN_IDENTITY)
 		return;
-	}
 
 	dmar_domain = to_dmar_domain(domain);
 	spin_lock_irqsave(&dmar_domain->lock, flags);
@@ -4282,8 +4284,54 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
 	domain_detach_iommu(dmar_domain, iommu);
 	intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
 	kfree(dev_pasid);
+}
+
+static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
+					 struct iommu_domain *domain)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu = info->iommu;
+
 	intel_pasid_tear_down_entry(iommu, dev, pasid, false);
 	intel_drain_pasid_prq(dev, pasid);
+	domain_remove_dev_pasid(domain, dev, pasid);
+}
+
+static struct dev_pasid_info *
+domain_add_dev_pasid(struct iommu_domain *domain,
+		     struct device *dev, ioasid_t pasid)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	struct intel_iommu *iommu = info->iommu;
+	struct dev_pasid_info *dev_pasid;
+	unsigned long flags;
+	int ret;
+
+	dev_pasid = kzalloc(sizeof(*dev_pasid), GFP_KERNEL);
+	if (!dev_pasid)
+		return ERR_PTR(-ENOMEM);
+
+	ret = domain_attach_iommu(dmar_domain, iommu);
+	if (ret)
+		goto out_free;
+
+	ret = cache_tag_assign_domain(dmar_domain, dev, pasid);
+	if (ret)
+		goto out_detach_iommu;
+
+	dev_pasid->dev = dev;
+	dev_pasid->pasid = pasid;
+	spin_lock_irqsave(&dmar_domain->lock, flags);
+	list_add(&dev_pasid->link_domain, &dmar_domain->dev_pasids);
+	spin_unlock_irqrestore(&dmar_domain->lock, flags);
+
+	return dev_pasid;
+out_detach_iommu:
+	domain_detach_iommu(dmar_domain, iommu);
+out_free:
+	kfree(dev_pasid);
+	return ERR_PTR(ret);
 }
 
 static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
@@ -4294,7 +4342,6 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
 	struct intel_iommu *iommu = info->iommu;
 	struct dev_pasid_info *dev_pasid;
-	unsigned long flags;
 	int ret;
 
 	if (!pasid_supported(iommu) || dev_is_real_dma_subdevice(dev))
@@ -4310,17 +4357,9 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 	if (ret)
 		return ret;
 
-	dev_pasid = kzalloc(sizeof(*dev_pasid), GFP_KERNEL);
-	if (!dev_pasid)
-		return -ENOMEM;
-
-	ret = domain_attach_iommu(dmar_domain, iommu);
-	if (ret)
-		goto out_free;
-
-	ret = cache_tag_assign_domain(dmar_domain, dev, pasid);
-	if (ret)
-		goto out_detach_iommu;
+	dev_pasid = domain_add_dev_pasid(domain, dev, pasid);
+	if (IS_ERR(dev_pasid))
+		return PTR_ERR(dev_pasid);
 
 	if (dmar_domain->use_first_level)
 		ret = domain_setup_first_level(iommu, dmar_domain,
@@ -4329,24 +4368,17 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 		ret = intel_pasid_setup_second_level(iommu, dmar_domain,
 						     dev, pasid);
 	if (ret)
-		goto out_unassign_tag;
+		goto out_remove_dev_pasid;
 
-	dev_pasid->dev = dev;
-	dev_pasid->pasid = pasid;
-	spin_lock_irqsave(&dmar_domain->lock, flags);
-	list_add(&dev_pasid->link_domain, &dmar_domain->dev_pasids);
-	spin_unlock_irqrestore(&dmar_domain->lock, flags);
+	domain_remove_dev_pasid(old, dev, pasid);
 
 	if (domain->type & __IOMMU_DOMAIN_PAGING)
 		intel_iommu_debugfs_create_dev_pasid(dev_pasid);
 
 	return 0;
-out_unassign_tag:
-	cache_tag_unassign_domain(dmar_domain, dev, pasid);
-out_detach_iommu:
-	domain_detach_iommu(dmar_domain, iommu);
-out_free:
-	kfree(dev_pasid);
+
+out_remove_dev_pasid:
+	domain_remove_dev_pasid(domain, dev, pasid);
 	return ret;
 }
 
-- 
2.34.1

