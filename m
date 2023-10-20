Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B2B10A3D
	for <iommu@lists.linux.dev>; Fri, 20 Oct 2023 09:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X5tqPhUn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697793598; x=1729329598;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pw4CXcAB+7pwTGUAZedG47AYASIyAmD8xc7RBFXXQaw=;
  b=X5tqPhUnSaKg3VSLB+X/jv/wgBZ5dx33ah18oXydiyGqP1oErR7zKdyR
   jwWcY3kRQL7JSlOFWSWtC6ks7zW2nz5RNKSMchmd3OjKD/imeNPWqL2j/
   pZh+ONHopBTx6B6jLkogyAFX8WNOHVsn7rJm6uGUnu6Rg7UnqTnNWH0k+
   oNIUzKLIPCAjUElLWDo8bE2mupKX35JPJAYn43uwIdq/DMGa2JJoJ6aki
   fu8KXxkKAQq+BxjaKan8Bcz93ZpLwParbMoJ74O9iAah+6+bWJudCm9ed
   9Y36hZPtnnqdCgCd1DnL5DjOiaot1d6PhgCb+ai8w79Ej6IDMwat4FZME
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="366693301"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="366693301"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 02:19:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="707179406"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="707179406"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga003.jf.intel.com with ESMTP; 20 Oct 2023 02:19:56 -0700
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
	joao.m.martins@oracle.com,
	xin.zeng@intel.com
Subject: [PATCH v5 01/10] iommu: Add IOMMU_DOMAIN_NESTED
Date: Fri, 20 Oct 2023 02:19:37 -0700
Message-Id: <20231020091946.12173-2-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020091946.12173-1-yi.l.liu@intel.com>
References: <20231020091946.12173-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lu Baolu <baolu.lu@linux.intel.com>

Introduce a new domain type for a user I/O page table, which is nested on
top of another user space address represented by a PAGING domain. This
new domain can be allocated by the domain_alloc_user op, and attached to
a device through the existing iommu_attach_device/group() interfaces.

The mappings of a nested domain are managed by user space software, so it
is not necessary to have map/unmap callbacks.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 include/linux/iommu.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 3861d66b65c1..ce08a3c41446 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -65,6 +65,9 @@ struct iommu_domain_geometry {
 
 #define __IOMMU_DOMAIN_SVA	(1U << 4)  /* Shared process address space */
 
+#define __IOMMU_DOMAIN_NESTED	(1U << 5)  /* User-managed address space nested
+					      on a stage-2 translation        */
+
 #define IOMMU_DOMAIN_ALLOC_FLAGS ~__IOMMU_DOMAIN_DMA_FQ
 /*
  * This are the possible domain-types
@@ -91,6 +94,7 @@ struct iommu_domain_geometry {
 				 __IOMMU_DOMAIN_DMA_API |	\
 				 __IOMMU_DOMAIN_DMA_FQ)
 #define IOMMU_DOMAIN_SVA	(__IOMMU_DOMAIN_SVA)
+#define IOMMU_DOMAIN_NESTED	(__IOMMU_DOMAIN_NESTED)
 
 struct iommu_domain {
 	unsigned type;
-- 
2.34.1

