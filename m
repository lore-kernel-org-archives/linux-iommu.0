Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CF362154
	for <iommu@lists.linux.dev>; Thu, 29 Feb 2024 09:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709200339; cv=none; b=RhRhTcxB6VjGZ5y9gh6iHH+hNhW32Zjckvh4DMh2qRHDUYR7Ksj3+dEKr2S14Fb5gDnSMCi6OjOrb3bCdqua6l2hHMtWcquUZdCFmuSuGi6cfzJkDLeo6CVvox/IL/v4SJOqyQKpuzSl6QBLLZM5MKSNOwpNN77+Jk39/aMgPFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709200339; c=relaxed/simple;
	bh=vaA/zQDUtXU1RUde31FgXuYCnR5c2pHYcZwv74k8mCM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ETZwVTHr26quik+nQwuoxRC/GO2bmbmJx0shj7E9Bq5toABqMu7WcF1UePjIxwmkO97Qde1orkgVccqelS+LcOS5d5bss+yDMI0cT4QqD/8xU1ft4MnYzFTKLrE7BKLktNvtGYs810fGfh7GZe1vHQpI+JBuNDlwUa+WdaCS9t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MREaiAEM; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MREaiAEM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709200337; x=1740736337;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vaA/zQDUtXU1RUde31FgXuYCnR5c2pHYcZwv74k8mCM=;
  b=MREaiAEMNHY5V/T5wZrCaxdazu7RlQ6y8sYeLwA2LCn4ls9W0JTR7l8R
   0qSJ6Yn/DjGXAlv0tYgWac7G5GiUf/dmor1BRkigu+hl4gS69DQA71Syl
   KB2awXWbaL9fFSKjSFNTEc62r9ZBJV+xnPXNar7RvlJY2hLfmA2TCFwe4
   28bgoTamGoG6LnGHX/m+YXpSXA1bNilPsN1Fvs84kmhhfKaARZNa3Y33g
   xm4+HnfmCcf3aohp5g+0jC8vRGjPtoKWjPwFs6jxbFLJ8i0VKnWv9PEnf
   Gfx18T3gk1srCNqBluZLTsT6gZv2YbDl8iJGMhnQ/nlMcmNknyTmCMiTD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="14366671"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="14366671"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 01:52:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="38811017"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmviesa001.fm.intel.com with ESMTP; 29 Feb 2024 01:52:15 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Eric Badger <ebadger@purestorage.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 1/2] iommu: Add static iommu_ops->release_domain
Date: Thu, 29 Feb 2024 17:46:12 +0800
Message-Id: <20240229094613.121575-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240229094613.121575-1-baolu.lu@linux.intel.com>
References: <20240229094613.121575-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current device_release callback for individual iommu drivers does the
following:

1) Silent IOMMU DMA translation: It detaches any existing domain from the
   device and puts it into a blocking state (some drivers might use the
   identity state).
2) Resource release: It releases resources allocated during the
   device_probe callback and restores the device to its pre-probe state.

Step 1 is challenging for individual iommu drivers because each must check
if a domain is already attached to the device. Additionally, if a deferred
attach never occurred, the device_release should avoid modifying hardware
configuration regardless of the reason for its call.

To simplify this process, introduce a static release_domain within the
iommu_ops structure. It can be either a blocking or identity domain
depending on the iommu hardware. The iommu core will decide whether to
attach this domain before the device_release callback, eliminating the
need for repetitive code in various drivers.

Consequently, the device_release callback can focus solely on the opposite
operations of device_probe, including releasing all resources allocated
during that callback.

Co-developed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 include/linux/iommu.h |  1 +
 drivers/iommu/iommu.c | 19 +++++++++++++++----
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index f08e6aa32657..2d44d4f01cc2 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -585,6 +585,7 @@ struct iommu_ops {
 	struct module *owner;
 	struct iommu_domain *identity_domain;
 	struct iommu_domain *blocked_domain;
+	struct iommu_domain *release_domain;
 	struct iommu_domain *default_domain;
 };
 
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 210dc7b4c8cf..7158aa3d38af 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -461,13 +461,24 @@ static void iommu_deinit_device(struct device *dev)
 
 	/*
 	 * release_device() must stop using any attached domain on the device.
-	 * If there are still other devices in the group they are not effected
+	 * If there are still other devices in the group, they are not affected
 	 * by this callback.
 	 *
-	 * The IOMMU driver must set the device to either an identity or
-	 * blocking translation and stop using any domain pointer, as it is
-	 * going to be freed.
+	 * If the iommu driver provides release_domain, the core code ensures
+	 * that domain is attached prior to calling release_device. Drivers can
+	 * use this to enforce a translation on the idle iommu. Typically, the
+	 * global static blocked_domain is a good choice.
+	 *
+	 * Otherwise, the iommu driver must set the device to either an identity
+	 * or a blocking translation in release_device() and stop using any
+	 * domain pointer, as it is going to be freed.
+	 *
+	 * Regardless, if a delayed attach never occurred, then the release
+	 * should still avoid touching any hardware configuration either.
 	 */
+	if (!dev->iommu->attach_deferred && ops->release_domain)
+		ops->release_domain->ops->attach_dev(ops->release_domain, dev);
+
 	if (ops->release_device)
 		ops->release_device(dev);
 
-- 
2.34.1

