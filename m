Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8322361
	for <iommu@lists.linux.dev>; Mon, 28 Nov 2022 06:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669618515; x=1701154515;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PhxHKh8gGEUFxS7QMyT5AZD9ZvqhOGgKls6j0D/stek=;
  b=Rc3bmt03yumtNzpQzASOiUaOg72feZgWsxxZ+8r3Q0yjPEx8Xul7mPXV
   VcNN8OLYEq6BukDVTixEPl4F08GNnuKjtulfRabyXtIHr/RfCfzewizNx
   7cdXgEr4Po8rYIBreSDqHjbjtCG/Dc58n9xKUQM2xSybVFn9fi/qe0vOV
   AvaqSpLIKosjWfVcTjHCnuBDUv9/j16sWSNsT8+WOsbTKLmeLVL4aIohI
   ChLog/6J/RGVD0YHvVw7eRoXeHb1kteb6UeM05Er5ih+IUCtQMVlltQg4
   6GrudMQci49lVstCpvZAUQYqxEoe1NQuoV+YK4+3aQCHYZG2Z1VGJgVtL
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="379016199"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="379016199"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2022 22:55:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="674120967"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="674120967"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga008.jf.intel.com with ESMTP; 27 Nov 2022 22:55:08 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Christoph Hellwig <hch@infradead.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Rob Clark <robdclark@gmail.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Yong Wu <yong.wu@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 10/20] iommu: Add set_platform_dma iommu ops
Date: Mon, 28 Nov 2022 14:46:38 +0800
Message-Id: <20221128064648.1934720-11-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221128064648.1934720-1-baolu.lu@linux.intel.com>
References: <20221128064648.1934720-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When VFIO finishes assigning a device to user space and calls
iommu_group_release_dma_owner() to return the device to kernel, the IOMMU
core will attach the default domain to the device. Unfortunately, some
IOMMU drivers don't support default domain, hence in the end, the core
calls .detach_dev instead.

This adds set_platform_dma iommu ops to make it clear that what it does
is returning control back to the platform DMA ops.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 68d7d304cdb7..3542461558fa 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -223,6 +223,9 @@ struct iommu_iotlb_gather {
  * @release_device: Remove device from iommu driver handling
  * @probe_finalize: Do final setup work after the device is added to an IOMMU
  *                  group and attached to the groups domain
+ * @set_platform_dma: Returning control back to the platform DMA ops. Only
+ *                    valid for IOMMU drivers which don't support default
+ *                    domain.
  * @device_group: find iommu group for a particular device
  * @get_resv_regions: Request list of reserved regions for a device
  * @of_xlate: add OF master IDs to iommu grouping
@@ -251,6 +254,7 @@ struct iommu_ops {
 	struct iommu_device *(*probe_device)(struct device *dev);
 	void (*release_device)(struct device *dev);
 	void (*probe_finalize)(struct device *dev);
+	void (*set_platform_dma)(struct device *dev);
 	struct iommu_group *(*device_group)(struct device *dev);
 
 	/* Request/Free a list of reserved regions for a device */
-- 
2.34.1

