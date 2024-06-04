Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BA713F425
	for <iommu@lists.linux.dev>; Tue,  4 Jun 2024 01:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717466143; cv=none; b=gaU6+G74LlQ85zUiYx4nooX/otiEKeySrTa/WZQIGGO89+97YtruM6MyV2+K3ljW4bYCTqqCAOX7JJlm2pVuJX73ydvLV4L0FvvrfMxogsK54HimfHUndTvKw5T7L3qigxQciEGHBp2Wrx9lHhKT/QFIMtgd4DKd3rvlzdNoMKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717466143; c=relaxed/simple;
	bh=w7xpZF6zFqfkcvZbi2eydbd2CTcSjXyT/TTFm+mMIv4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qxIRwYkRMZMe1k/yKJeFYakjH8C76MFPgVUYYLo0Ju5Kevga2vh7hVzxl/kpzMDDOKhLKfxOk6mNJOKulg/9vl6KR0ugr85R+yicvv3CgvZRfxtjWmDA0ag/h5/ar/I9oJO/REqOUoy/4/CfYdJOZg7eE1eKpaYYtuXw8oFR4Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A44Ut/5v; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A44Ut/5v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717466142; x=1749002142;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w7xpZF6zFqfkcvZbi2eydbd2CTcSjXyT/TTFm+mMIv4=;
  b=A44Ut/5v5EJQIzV5A+gAJUJuApNZT2i7q1HcSEPGdJaWOFj0nVRxRiAM
   NQ1yzjoHEjs4GDDOHIRxaJdiOKZou6ZzYKPmipVeh09lSGdDu5qm+mJCH
   Qeg0INszW3vuJv0sqQFBUhFL672+nK/dvWK0LW+Ifvxd+IisSs+rvouGN
   vm0srd/YIQnN6g2JceWnn+UPnON01l6xKB/tq5/sfr6IZqI6+4sRY35Hs
   gxHj3nXNs8YiJ2Z9fRxp0sKhBtq4RKS8fQunWjPO0TfH7+yPtQkjv0IUq
   MtaxPvgKwAwu55iSh4o49FitjdmGfnTBNwa7qPruEDXrMzxqlA2gUqDo9
   Q==;
X-CSE-ConnectionGUID: SE8XPlusTgSBGpZdBCW6ZQ==
X-CSE-MsgGUID: x94QGwfZRd+lafr4p9Z4gQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="25385271"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="25385271"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 18:55:40 -0700
X-CSE-ConnectionGUID: UYTWYDDfT0qdTFCeWKMbag==
X-CSE-MsgGUID: slPdM7OrRP2pa5uJS4C6wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="37662057"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa008.jf.intel.com with ESMTP; 03 Jun 2024 18:55:36 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Yi Liu <yi.l.liu@intel.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	mst@redhat.com,
	Jason Wang <jasowang@redhat.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	iommu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 21/22] iommu: Remove iommu_present()
Date: Tue,  4 Jun 2024 09:51:33 +0800
Message-Id: <20240604015134.164206-22-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240604015134.164206-1-baolu.lu@linux.intel.com>
References: <20240604015134.164206-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The iommu_present() interface is no longer used in the tree anymore.
Remove it to avoid dead code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h |  6 ------
 drivers/iommu/iommu.c | 25 -------------------------
 2 files changed, 31 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 16401de7802d..b0bd16a7768e 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -776,7 +776,6 @@ static inline void iommu_iotlb_gather_init(struct iommu_iotlb_gather *gather)
 }
 
 extern int bus_iommu_probe(const struct bus_type *bus);
-extern bool iommu_present(const struct bus_type *bus);
 extern bool device_iommu_capable(struct device *dev, enum iommu_cap cap);
 extern bool iommu_group_has_isolated_msi(struct iommu_group *group);
 extern struct iommu_domain *iommu_domain_alloc(const struct bus_type *bus);
@@ -1073,11 +1072,6 @@ struct iommu_iotlb_gather {};
 struct iommu_dirty_bitmap {};
 struct iommu_dirty_ops {};
 
-static inline bool iommu_present(const struct bus_type *bus)
-{
-	return false;
-}
-
 static inline bool device_iommu_capable(struct device *dev, enum iommu_cap cap)
 {
 	return false;
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 7df4a021b040..3e4195c28e85 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1846,31 +1846,6 @@ int bus_iommu_probe(const struct bus_type *bus)
 	return 0;
 }
 
-/**
- * iommu_present() - make platform-specific assumptions about an IOMMU
- * @bus: bus to check
- *
- * Do not use this function. You want device_iommu_mapped() instead.
- *
- * Return: true if some IOMMU is present and aware of devices on the given bus;
- * in general it may not be the only IOMMU, and it may not have anything to do
- * with whatever device you are ultimately interested in.
- */
-bool iommu_present(const struct bus_type *bus)
-{
-	bool ret = false;
-
-	for (int i = 0; i < ARRAY_SIZE(iommu_buses); i++) {
-		if (iommu_buses[i] == bus) {
-			spin_lock(&iommu_device_lock);
-			ret = !list_empty(&iommu_device_list);
-			spin_unlock(&iommu_device_lock);
-		}
-	}
-	return ret;
-}
-EXPORT_SYMBOL_GPL(iommu_present);
-
 /**
  * device_iommu_capable() - check for a general IOMMU capability
  * @dev: device to which the capability would be relevant, if available
-- 
2.34.1

