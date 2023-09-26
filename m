Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876B1134A4
	for <iommu@lists.linux.dev>; Tue, 26 Sep 2023 09:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695720423; x=1727256423;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W+uOy9Ige3oZ7x7YvATxosVpM3ybZgqwu1X08uq0/aA=;
  b=NDA/NdD3Vq3FbsCuEyazLzy++mJXCJlaSYy21x9nuWXSLBxzl8h5sDPM
   HPsvliRH3FVdLUglPlLnQQpt3ZT41pQbN7yEusC/CkdQndgr5cPlVVdUo
   TQC1bIsocJf+LkY0Xdaknjfsf0Em1BNPFCdG2/Z9Dz+bmjCpRnUq9iBnS
   ypidLi5MxqrbzwerniN2dgtaU/lK6JgfzgwKpVva3C8gRgCPKsW1oHeoA
   2JS+R9x/A6bQzWFN6RUzrEYbD7zZQlapFhnUUkeFCA/MCtXI3S8ODX/wS
   bybFOYWBHMSMEIJgxP3EdSE1+CZt80iaSID1o3zGs9xLYPgrzTVVOcoe7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="360905442"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="360905442"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 02:27:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="1079642580"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="1079642580"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga005.fm.intel.com with ESMTP; 26 Sep 2023 02:27:02 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	alex.williamson@redhat.com,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	robin.murphy@arm.com,
	baolu.lu@linux.intel.com
Cc: cohuck@redhat.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	mjrosato@linux.ibm.com,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	yi.y.sun@linux.intel.com,
	peterx@redhat.com,
	jasowang@redhat.com,
	shameerali.kolothum.thodi@huawei.com,
	lulu@redhat.com,
	suravee.suthikulpanit@amd.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	zhenzhong.duan@intel.com,
	joao.m.martins@oracle.com
Subject: [RFC 8/8] iommu/vt-d: Add set_dev_pasid callback for nested domain
Date: Tue, 26 Sep 2023 02:26:51 -0700
Message-Id: <20230926092651.17041-9-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230926092651.17041-1-yi.l.liu@intel.com>
References: <20230926092651.17041-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lu Baolu <baolu.lu@linux.intel.com>

This allows the upper layers to set a nested type domain to a PASID of a
device if the PASID feature is supported by the IOMMU hardware.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/nested.c | 47 ++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index 4853fee216d9..dc99ea1abf68 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -63,6 +63,52 @@ static int intel_nested_attach_dev(struct iommu_domain *domain,
 	return 0;
 }
 
+static int intel_nested_set_dev_pasid(struct iommu_domain *domain,
+				      struct device *dev, ioasid_t pasid)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	struct intel_iommu *iommu = info->iommu;
+	struct dev_pasid_info *dev_pasid;
+	unsigned long flags;
+	int ret = 0;
+
+	if (!pasid_supported(iommu))
+		return -EOPNOTSUPP;
+
+	if (iommu->agaw < dmar_domain->s2_domain->agaw)
+		return -EINVAL;
+
+	ret = prepare_domain_attach_device(&dmar_domain->s2_domain->domain, dev);
+	if (ret)
+		return ret;
+
+	dev_pasid = kzalloc(sizeof(*dev_pasid), GFP_KERNEL);
+	if (!dev_pasid)
+		return -ENOMEM;
+
+	ret = domain_attach_iommu(dmar_domain, iommu);
+	if (ret)
+		goto err_free;
+
+	ret = intel_pasid_setup_nested(iommu, dev, pasid, dmar_domain);
+	if (ret)
+		goto err_detach_iommu;
+
+	dev_pasid->dev = dev;
+	dev_pasid->pasid = pasid;
+	spin_lock_irqsave(&dmar_domain->lock, flags);
+	list_add(&dev_pasid->link_domain, &dmar_domain->dev_pasids);
+	spin_unlock_irqrestore(&dmar_domain->lock, flags);
+
+	return 0;
+err_detach_iommu:
+	domain_detach_iommu(dmar_domain, iommu);
+err_free:
+	kfree(dev_pasid);
+	return ret;
+}
+
 static void intel_nested_domain_free(struct iommu_domain *domain)
 {
 	kfree(to_dmar_domain(domain));
@@ -127,6 +173,7 @@ static int intel_nested_cache_invalidate_user(struct iommu_domain *domain,
 
 static const struct iommu_domain_ops intel_nested_domain_ops = {
 	.attach_dev		= intel_nested_attach_dev,
+	.set_dev_pasid		= intel_nested_set_dev_pasid,
 	.free			= intel_nested_domain_free,
 	.cache_invalidate_user	= intel_nested_cache_invalidate_user,
 };
-- 
2.34.1

