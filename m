From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: [PATCH v2 0/1] IOMMU SVA device driver interface
Date: Wed, 20 Mar 2019 15:02:57 +0000
Message-ID: <20190320150258.3240-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, christian.koenig@amd.com, kevin.tian@intel.com, jacob.jun.pan@linux.intel.com, ashok.raj@intel.com, baolu.lu@linux.intel.com, alex.williamson@redhat.com, zhangfei.gao@foxmail.com
List-Id: iommu@lists.linux-foundation.org

This is the device driver API for SVA (Shared Virtual Addressing).
Changes since v1 [1]:

* Following comments, return a handle rather than a PASID. I agree that
  it makes things easier for device drivers as well, because they don't
  need to worry about the unbind()/mm_exit() race as much. Previously
  they couldn't issue an unbind() if the mm exited since the PASID could
  have been reallocated.

* If a handle already exists, reuse it and take a reference instead of
  returning EEXIST. As noted by Zhangfei and myself during development,
  it can make things a bit easier for device drivers that need to handle
  multiple threads in a process issuing bind() for the same dev and mm.

The four dev_feature functions are implemented by Lu Baolu's IOMMU-aware
mdev series [2].

	iommu_dev_has_feature(dev, IOMMU_DEV_FEAT_SVA) -> true/false
	iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) -> 0/err
	iommu_dev_disable_feature(dev, IOMMU_DEV_FEAT_SVA) -> 0/err
	iommu_dev_feature_enabled(dev, IOMMU_DEV_FEAT_SVA) -> true/false

Patch 1/1 adds the next four functions, once the SVA feature is enabled:

	iommu_sva_bind(dev, mm, drvdata) -> handle

	/*
	 * Only exit_mm() for now, but later callbacks to deal with
	 * unhandled PRI faults and possible others:
	 */
	iommu_sva_set_ops(handle, iommu_sva_ops) -> 0/err

	iommu_sva_get_pasid(handle) -> pasid/invalid

	iommu_sva_unbind(handle)

Full support for the SMMUv3 can be found at [3]

[1] https://lore.kernel.org/lkml/20190220142759.33308-1-jean-philippe.brucker@arm.com/
[2] https://lore.kernel.org/lkml/20190213040301.23021-10-baolu.lu@linux.intel.com/T/
[3] git://linux-arm.org/linux-jpb.git sva/current
    http://www.linux-arm.org/git?p=linux-jpb.git;a=shortlog;h=refs/heads/sva/current

Jean-Philippe Brucker (1):
  iommu: Bind process address spaces to devices

 drivers/iommu/iommu.c | 105 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h |  71 ++++++++++++++++++++++++++++
 2 files changed, 176 insertions(+)

-- 
2.21.0
