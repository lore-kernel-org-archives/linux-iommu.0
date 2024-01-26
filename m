Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745861427F
	for <iommu@lists.linux.dev>; Fri, 26 Jan 2024 10:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706266767; cv=none; b=lTKAkIN+lorPMoytHhDaT77BBVvSjacVnrIif9NC9w8uV9NywLCnmjQWd3tWGD5tsfgvZJGjZ2Q6z92UyGN0ZW3/UeKUtcFuJNPpYQBVeL5wgvxHdJTMtHXpBNFGA5Uo7Mg6kx07qbrgoarV4YtYQlATcgwfalscM4x+WDYg52Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706266767; c=relaxed/simple;
	bh=zo5LBMZV0B5NEfxZY5cK3SYRyArtsbTV+MJeKCnjfLM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eXnqvuRLQKVOyIsyOFdJ7Ic+NRG+tqzkbt3d2+cspAe9E+lkda2NaFv0aCbflMLwK8gb/tWprXHhtnc04y3RagrIQdAt/uw2ThYLDE8k1e9sA58Bc/gUIrmCVnLsr+W0ggZ8AOsbr5G/gEYSCvqcx1Hl7ml9ZGKfD3U5+mG08mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dm6Zk2c8; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dm6Zk2c8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706266758; x=1737802758;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zo5LBMZV0B5NEfxZY5cK3SYRyArtsbTV+MJeKCnjfLM=;
  b=Dm6Zk2c87CKw79rS5eKIsiM3h3CcHwl6lZJqLu1zAsHtFXbasUdxY0f1
   AouESgMzchQgLC9k9NN5Z4+063GTPdhsBbnHq4ojw45gjB3uE6eJqaP2g
   qKu0N4pWSY0MCupCOy7CB5iIwhncf9Ow1ksBxYNGiSY+3uJRTJNmKOmGy
   o0U52/rnSvG+VqJpvP8p5QBQUIRw5xpysVmlOFsu7ybw20FfLBBHYVyCY
   B7eZ1KalhzD6ssrnDm3PhOKwlBuig4ihKOxEttVgrnFL+RbUIVTJaZgih
   20TYt5kQAFiSlh4D/Wm/npmNz9/CInmFniIMstEdlZCLuGM99eNBxcgMv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="9123364"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="9123364"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 02:59:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="857367842"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="857367842"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga004.fm.intel.com with ESMTP; 26 Jan 2024 02:59:14 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 1/2] iommu: Use mutex instead of spinlock for iommu_device_list
Date: Fri, 26 Jan 2024 18:53:40 +0800
Message-Id: <20240126105341.78086-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240126105341.78086-1-baolu.lu@linux.intel.com>
References: <20240126105341.78086-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The iommu_device_lock spinlock was used to protect the iommu device
list. However, there is no requirement to access the iommu device
list in interrupt context. Therefore, a mutex is sufficient.

This also prepares for the next change, which will iterate the iommu
device list and call the probe callback within the locking area.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 68e648b55767..0af0b5544072 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -146,7 +146,7 @@ struct iommu_group_attribute iommu_group_attr_##_name =		\
 	container_of(_kobj, struct iommu_group, kobj)
 
 static LIST_HEAD(iommu_device_list);
-static DEFINE_SPINLOCK(iommu_device_lock);
+static DEFINE_MUTEX(iommu_device_lock);
 
 static const struct bus_type * const iommu_buses[] = {
 	&platform_bus_type,
@@ -262,9 +262,9 @@ int iommu_device_register(struct iommu_device *iommu,
 	if (hwdev)
 		iommu->fwnode = dev_fwnode(hwdev);
 
-	spin_lock(&iommu_device_lock);
+	mutex_lock(&iommu_device_lock);
 	list_add_tail(&iommu->list, &iommu_device_list);
-	spin_unlock(&iommu_device_lock);
+	mutex_unlock(&iommu_device_lock);
 
 	for (int i = 0; i < ARRAY_SIZE(iommu_buses) && !err; i++)
 		err = bus_iommu_probe(iommu_buses[i]);
@@ -279,9 +279,9 @@ void iommu_device_unregister(struct iommu_device *iommu)
 	for (int i = 0; i < ARRAY_SIZE(iommu_buses); i++)
 		bus_for_each_dev(iommu_buses[i], NULL, iommu, remove_iommu_group);
 
-	spin_lock(&iommu_device_lock);
+	mutex_lock(&iommu_device_lock);
 	list_del(&iommu->list);
-	spin_unlock(&iommu_device_lock);
+	mutex_unlock(&iommu_device_lock);
 
 	/* Pairs with the alloc in generic_single_device_group() */
 	iommu_group_put(iommu->singleton_group);
@@ -316,9 +316,9 @@ int iommu_device_register_bus(struct iommu_device *iommu,
 	if (err)
 		return err;
 
-	spin_lock(&iommu_device_lock);
+	mutex_lock(&iommu_device_lock);
 	list_add_tail(&iommu->list, &iommu_device_list);
-	spin_unlock(&iommu_device_lock);
+	mutex_unlock(&iommu_device_lock);
 
 	err = bus_iommu_probe(bus);
 	if (err) {
@@ -2033,9 +2033,9 @@ bool iommu_present(const struct bus_type *bus)
 
 	for (int i = 0; i < ARRAY_SIZE(iommu_buses); i++) {
 		if (iommu_buses[i] == bus) {
-			spin_lock(&iommu_device_lock);
+			mutex_lock(&iommu_device_lock);
 			ret = !list_empty(&iommu_device_list);
-			spin_unlock(&iommu_device_lock);
+			mutex_unlock(&iommu_device_lock);
 		}
 	}
 	return ret;
@@ -2983,13 +2983,13 @@ const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
 	const struct iommu_ops *ops = NULL;
 	struct iommu_device *iommu;
 
-	spin_lock(&iommu_device_lock);
+	mutex_lock(&iommu_device_lock);
 	list_for_each_entry(iommu, &iommu_device_list, list)
 		if (iommu->fwnode == fwnode) {
 			ops = iommu->ops;
 			break;
 		}
-	spin_unlock(&iommu_device_lock);
+	mutex_unlock(&iommu_device_lock);
 	return ops;
 }
 
-- 
2.34.1

