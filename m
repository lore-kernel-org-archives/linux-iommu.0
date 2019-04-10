From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: [PATCH v3 0/1] IOMMU SVA device driver interface
Date: Wed, 10 Apr 2019 16:15:15 +0100
Message-ID: <20190410151516.47754-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, christian.koenig@amd.com, kevin.tian@intel.com, jacob.jun.pan@linux.intel.com, ashok.raj@intel.com, baolu.lu@linux.intel.com, zhangfei.gao@foxmail.com
List-Id: iommu@lists.linux-foundation.org

This is the device driver API for SVA (Shared Virtual Addressing).
Since v2 I removed the set_sva_ops() IOMMU operation as suggested by
Joerg, instead doing the sva_ops assignment in iommu.c.

The four dev_feature functions are implemented by Lu Baolu's IOMMU-aware
mdev series [2].

	iommu_dev_has_feature(dev, IOMMU_DEV_FEAT_SVA) -> true/false
	iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) -> 0/err
	iommu_dev_disable_feature(dev, IOMMU_DEV_FEAT_SVA) -> 0/err
	iommu_dev_feature_enabled(dev, IOMMU_DEV_FEAT_SVA) -> true/false

Patch 1/1 adds the next four functions, once the SVA feature is enabled:

	iommu_sva_bind(dev, mm, drvdata) -> handle
	iommu_sva_set_ops(handle, iommu_sva_ops) -> 0/err
	iommu_sva_get_pasid(handle) -> pasid/invalid
	iommu_sva_unbind(handle)

Generic implementation and SMMUv3 support can be found at [3].

[1] https://lore.kernel.org/lkml/20190320150258.3240-1-jean-philippe.brucker@arm.com/
[2] https://lore.kernel.org/lkml/20190325013036.18400-1-baolu.lu@linux.intel.com/
[3] git://linux-arm.org/linux-jpb.git sva/current
    http://www.linux-arm.org/git?p=linux-jpb.git;a=shortlog;h=refs/heads/sva/current

Jean-Philippe Brucker (1):
  iommu: Bind process address spaces to devices

 drivers/iommu/iommu.c | 104 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h |  70 ++++++++++++++++++++++++++++
 2 files changed, 174 insertions(+)

-- 
2.21.0
