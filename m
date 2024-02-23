Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667CB11739
	for <iommu@lists.linux.dev>; Fri, 23 Feb 2024 05:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708665546; cv=none; b=CwymMMYqh08OgM8q72XZTq/LDqgRtO7HqVJX1cpoM8e+Tdb/BOnTl6Xf7c0aym+jVuUa7jZvCFV58Zn570IGik/4lJ4EcGhJi5yACCiaLkJeN7mhFZU2RNAM7F5ZKyiLQWDgBSgvWg5YaXDyElEqHWy5jD/27RJDKhVW3zxgGBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708665546; c=relaxed/simple;
	bh=Tk9A4I0oMmelCpHSwdKZxqF1e4tJfbiF9SDU75PTANQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IiGyJA5CrO1ZqfTAXjDIkrNVItmUeRBiQsfc3CsXqSuCTwsY+0K11QDmNH5kOZ/aZuIm+pgMAZhDXZm3I/zgY2a+eUiULOeY03aUk/VTE4GG+hk+S2hGFWXFtlDQRaYZFPiddSL5WR7+oPDwvSHxDiDgrF/YcvPkBlWiS5lQd6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XoUy9ZEh; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XoUy9ZEh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708665544; x=1740201544;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Tk9A4I0oMmelCpHSwdKZxqF1e4tJfbiF9SDU75PTANQ=;
  b=XoUy9ZEhcb/1WdMDoh2xB+cxXgDkXzLTQq1CA/zYUy0eFejj2EiJYHAl
   QKXC99QAtS+bL+0whhLWtlpARk2t10FpgajrYXPb7XyWUfAt6fC3Q2Jeb
   AsVt6XmVd9YJB+EztX8xj0Ju93913+xIvCxNtMwTR5JEu8zlpAdux272v
   rbmzXU0pcREbNUis9Lh+NXMGvFOGXGhMgekUb3xLMQt76ErNpKiu12+L/
   w7X7pVWN9/vPmGBdshMHurSFFwMhjNhgNcFlsdU3T2j0p9DrBRA0RcZMt
   TcwhYKQhpTxbh+MEF+CKAj+qOq8NXc+UsKKx/ndqo0NXm6whDzjnZccTh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="28395437"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="28395437"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 21:19:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="5999892"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmviesa006.fm.intel.com with ESMTP; 22 Feb 2024 21:19:02 -0800
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
Subject: [PATCH 1/2] iommu: Add static iommu_ops->release_domain
Date: Fri, 23 Feb 2024 13:13:01 +0800
Message-Id: <20240223051302.177596-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223051302.177596-1-baolu.lu@linux.intel.com>
References: <20240223051302.177596-1-baolu.lu@linux.intel.com>
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
---
 include/linux/iommu.h |  1 +
 drivers/iommu/iommu.c | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index de839fd01bb8..e3d9365b0fa9 100644
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
index 210dc7b4c8cf..fb06c3f47320 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -459,6 +459,18 @@ static void iommu_deinit_device(struct device *dev)
 
 	iommu_device_unlink(dev->iommu->iommu_dev, dev);
 
+	/*
+	 * If the iommu driver provides release_domain then the core code
+	 * ensures that domain is attached prior to calling release_device.
+	 * Drivers can use this to enforce a translation on the idle iommu.
+	 * Usually the global static blocked_domain is a good choice.
+	 *
+	 * Anyway, if a deferred attach never happened then the release
+	 * should still avoid touching any hardware configuration either.
+	 */
+	if (!dev->iommu->attach_deferred && ops->release_domain)
+		ops->release_domain->ops->attach_dev(ops->release_domain, dev);
+
 	/*
 	 * release_device() must stop using any attached domain on the device.
 	 * If there are still other devices in the group they are not effected
-- 
2.34.1

