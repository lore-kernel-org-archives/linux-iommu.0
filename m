Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3CD4A06
	for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 02:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745374690; cv=none; b=Mit5RWlKeMINbmZbPaR0esSRYORsh1n5XMHyD8TIfKHD6i8bgRoOgopBue2D7TKZ+tjHvAGotBctNMWMJrNmLHkEOj17y105VeXg8IBtCz2E6nsyA69x1Rldfm1zCKtzPsFSgbNxAkLgW+W+iHygDFPnZ2+544lkEqDxN6NN3Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745374690; c=relaxed/simple;
	bh=5RuBUtVjpiGQGj/Vk92xds65q/q+9PT+wtZ+LO4f4mg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h7Oo1/+krTGKFIFOt0LTYNdWG7gcQ730i1xBJghoYIt9gX+pXZsp+V+3pzoLSpjGjCt2GODDfgqytNpPJUqYAPHAQWzsOBdEP0leTMXkgzpUCHeEWpUMRvEuEHP4WMfXvjoo8HM0QqUMttAmmI0rxfM9Kn+MBXowhE24dpKvvkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jo0FIfWv; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jo0FIfWv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745374690; x=1776910690;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5RuBUtVjpiGQGj/Vk92xds65q/q+9PT+wtZ+LO4f4mg=;
  b=Jo0FIfWvWdzXwxd7siRKfEtmyvQJavNmoiO/374ZPFABsqf3YkveE8zY
   YeB+M3GqBr97I97RhcHNlawITiu18819EwZIE76rWX8FTIXZH6D8ow3XL
   sd3TPXsY7P8/9JXv1UrMvx7ne0z8AUYWjP1MvFPS0aX4qWoBHb2Nklst8
   V6GOfkY9rAHNPJ6H+3/ETTkb9aXNgW7acBJl4JrBYT8xVHaJC5aXK7Woc
   THQsCx/uNLXetkQsPmKwyY9WTj3ejw1VfYXHnwwMXigwEC9xhM+g7xRc4
   P4c8Hbp8asKxOE0bNhwqzzPhnV/b/GJG9j3jUwR6N4ln54orOQdrUBPAw
   Q==;
X-CSE-ConnectionGUID: Zpg2HTAIRf+o2z+EsJizCw==
X-CSE-MsgGUID: NLPXCAvUQAOSwIuRjUtKWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="46833166"
X-IronPort-AV: E=Sophos;i="6.15,232,1739865600"; 
   d="scan'208";a="46833166"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 19:18:09 -0700
X-CSE-ConnectionGUID: J/pRmyruR6qBJ1tQv4ZVbg==
X-CSE-MsgGUID: QkQdpDTeQFiK3xCwWUe4mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,232,1739865600"; 
   d="scan'208";a="137045327"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa003.jf.intel.com with ESMTP; 22 Apr 2025 19:18:06 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	shangsong2@lenovo.com,
	Dave Jiang <dave.jiang@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/1] iommu: Allow attaching static domains in iommu_attach_device_pasid()
Date: Wed, 23 Apr 2025 10:18:39 +0800
Message-ID: <20250423021839.2189204-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The idxd driver attaches the default domain to a PASID of the device to
perform kernel DMA using that PASID. The domain is attached to the
device's PASID through iommu_attach_device_pasid(), which checks if the
domain->owner matches the iommu_ops retrieved from the device. If they
do not match, it returns a failure.

        if (ops != domain->owner || pasid == IOMMU_NO_PASID)
                return -EINVAL;

The static identity domain implemented by the intel iommu driver doesn't
specify the domain owner. Therefore, kernel DMA with PASID doesn't work
for the idxd driver if the device translation mode is set to passthrough.

Generally the owner field of static domains are not set because they are
already part of iommu ops. Add a helper domain_iommu_ops_compatible()
that checks if a domain is compatible with the device's iommu ops. This
helper explicitly allows the static blocked and identity domains associated
with the device's iommu_ops to be considered compatible.

Fixes: 2031c469f816 ("iommu/vt-d: Add support for static identity domain")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220031
Cc: stable@vger.kernel.org
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/linux-iommu/20250422191554.GC1213339@ziepe.ca/
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

Change log:
-v2:
 - Make the solution generic for all static domains as suggested by
   Jason.
-v1: https://lore.kernel.org/linux-iommu/20250422075422.2084548-1-baolu.lu@linux.intel.com/

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 4f91a740c15f..abda40ec377a 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3402,6 +3402,19 @@ static void __iommu_remove_group_pasid(struct iommu_group *group,
 		iommu_remove_dev_pasid(device->dev, pasid, domain);
 }
 
+static bool domain_iommu_ops_compatible(const struct iommu_ops *ops,
+					struct iommu_domain *domain)
+{
+	if (domain->owner == ops)
+		return true;
+
+	/* For static domains, owner isn't set. */
+	if (domain == ops->blocked_domain || domain == ops->identity_domain)
+		return true;
+
+	return false;
+}
+
 /*
  * iommu_attach_device_pasid() - Attach a domain to pasid of device
  * @domain: the iommu domain.
@@ -3435,7 +3448,8 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 	    !ops->blocked_domain->ops->set_dev_pasid)
 		return -EOPNOTSUPP;
 
-	if (ops != domain->owner || pasid == IOMMU_NO_PASID)
+	if (!domain_iommu_ops_compatible(ops, domain) ||
+	    pasid == IOMMU_NO_PASID)
 		return -EINVAL;
 
 	mutex_lock(&group->mutex);
-- 
2.43.0

