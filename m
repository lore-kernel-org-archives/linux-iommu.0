Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E215F5679
	for <iommu@lists.linux.dev>; Mon, 24 Jul 2023 11:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690197229; x=1721733229;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tXRlj9btBIeoEUnM5jIM9VZ+Pcrfyh8ZFvgKt8H4Rkw=;
  b=dwgs8gvqRoLXQui0hjZMfZ9+Pq8PqytBXu4gTul2DkQIhuEAKcFWOO2U
   hP7qKDb/4Vxx3VNmykaj0iNMqIGNa0bZJBNgdB51iJQs7L148/ajDQLOf
   XxttK5prmRxg9Zvyec29Y+ZlBA90woU4iRYr5Z7j8OnlCnfDYn+ecauW6
   FvxfIuVaTQ0zRUF4lnCaXiKBcMgqdpvFsVfTB8JPbj0v6Tq+KyvGFyyy7
   g/TnIlRQAoZ3QRqsl/mFiVWM2EMPe7R8OK+pLYK3L9arLZBc1odkLriSw
   PwYS5GEKcvKPW962EvNVeOzBs/UmcrV70+OTMcR8Vv/QpX6V7BnqYeubQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="347015054"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="347015054"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 04:13:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="839415586"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="839415586"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga002.fm.intel.com with ESMTP; 24 Jul 2023 04:13:48 -0700
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
	zhenzhong.duan@intel.com
Subject: [PATCH v4 10/12] iommu/vt-d: Add nested domain allocation
Date: Mon, 24 Jul 2023 04:13:32 -0700
Message-Id: <20230724111335.107427-11-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724111335.107427-1-yi.l.liu@intel.com>
References: <20230724111335.107427-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lu Baolu <baolu.lu@linux.intel.com>

This adds the support for IOMMU_HWPT_TYPE_VTD_S1 type.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.c | 20 ++++++++++++++++++++
 include/linux/iommu.h       |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 3119a79ebc83..6977d320c440 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4084,6 +4084,25 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 	return NULL;
 }
 
+static struct iommu_domain *
+intel_iommu_domain_alloc_user(struct device *dev,
+			      enum iommu_hwpt_type hwpt_type,
+			      struct iommu_domain *parent,
+			      const union iommu_domain_user_data *user_data)
+{
+	if (hwpt_type != IOMMU_HWPT_TYPE_DEFAULT &&
+	    hwpt_type != IOMMU_HWPT_TYPE_VTD_S1)
+		return ERR_PTR(-EINVAL);
+
+	if ((hwpt_type == IOMMU_HWPT_TYPE_DEFAULT) == !!parent)
+		return ERR_PTR(-EINVAL);
+
+	if (parent)
+		return intel_nested_domain_alloc(parent, user_data);
+	else
+		return iommu_domain_alloc(dev->bus);
+}
+
 static void intel_iommu_domain_free(struct iommu_domain *domain)
 {
 	if (domain != &si_domain->domain && domain != &blocking_domain)
@@ -4732,6 +4751,7 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 const struct iommu_ops intel_iommu_ops = {
 	.capable		= intel_iommu_capable,
 	.domain_alloc		= intel_iommu_domain_alloc,
+	.domain_alloc_user	= intel_iommu_domain_alloc_user,
 	.probe_device		= intel_iommu_probe_device,
 	.probe_finalize		= intel_iommu_probe_finalize,
 	.release_device		= intel_iommu_release_device,
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 231920efab84..09b8e800b55e 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -240,6 +240,7 @@ union iommu_domain_user_data {
 #ifdef CONFIG_IOMMUFD_TEST
 	__u64 test[2];
 #endif
+	struct iommu_hwpt_vtd_s1 vtd;
 };
 
 /**
-- 
2.34.1

