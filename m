From: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v4 0/5] iommu/arm-smmu: add support for non-pci devices
Date: Thu, 15 Oct 2015 16:30:42 +0800
Message-ID: <1444897847-18040-1-git-send-email-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, iommu <iommu@lists.linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: Zefan Li <lizefan@huawei.com>, Xinwei Hu <huxinwei@huawei.com>, Tianhong Ding <dingtianhong@huawei.com>, Hanjun Guo <guohanjun@huawei.com>, Zhen Lei <thunder.leizhen@huawei.com>
List-Id: iommu@lists.linux-foundation.org

Hi, all:

It's been a long time since my patch v3. I don't known when Laurent's
probe-deferral series will be upstreamed? I really have no time to wait. So
I add patch 4/5, to keep both cases(Laurent's series upstreamed or not),
smmu-v3 can always work well.


Changelog:
v3 -> v4:
1. base upon the lastest arm-smmu-v3.c update patchset.
2. add patch 4/5, keep smmu-v3 can still work normally before Laurent's series upstreamed.

   Describe process flow as below:
   All: (A-->B means: function A directly or indirectly call function B)
   [1] of_iommu_init-->arm_smmu_of_iommu_init-->of_iommu_set_ops

   1) without Laurent's series
   [1] of_platform_populate-->of_dma_configure-->of_iommu_configure-->.of_xlate
   	/* time before step [2], so smmu is NULL yet */
   	smmu = platform_get_drvdata(pdev);
	if (!smmu) {
		dev->archdata.iommu = ERR_PTR(-EPROBE_DEFER);

		return -EPROBE_DEFER;
	}
   [2] arm_smmu_device_dt_probe-->platform_set_drvdata
   [3] call .add_device
   	if (dev->archdata.iommu == ERR_PTR(-EPROBE_DEFER)) {
		dev->archdata.iommu = NULL;

		/* scan master's "iommus" property */
		return of_iommu_configure(dev, dev->of_node) ? 0 : -ENODEV;
	}
   [4] call master's probe function

   2) with Laurent's series
   [1] of_platform_populate-->of_dma_configure
   	the call of of_iommu_configure have been putted off, see [4] below
   	so the value of dev->archdata.iommu have no change
   [2] arm_smmu_device_dt_probe-->platform_set_drvdata
   [3] call .add_device
   	if (dev->archdata.iommu == ERR_PTR(-EPROBE_DEFER)) {
		/* see [1], dev->archdata.iommu is NULL, so this branch can not be entered */
	}
   [4] call .of_xlate
   [5] call master's probe function

v2 -> v3:
1. add support for pci device hotplug, which missed in patch v2.
2. only support #iommu-cells = <1>, add corresponding description in arm,smmu-v3.txt.
3. add function find_smmu_by_device which extracted from find_smmu_by_node, to resolve
   the problem mentioned by Robin Murphy in [PATCH v2 7/9].
   Additionally:
   +    platform_set_drvdata(pdev, smmu);       //Patch v2
   +	dev->archdata.iommu = smmu;             //Patch v3, dev = &pdev->dev

v1 -> v2:
update the implementation of patch 1/9 according to Will Deacon's suggestion.
update the comment of patch 3/9 and 4/9.
use arm_smmu_options to skip the execution of command CMD_PREFETCH_CONFIG, see patch 5/9.
patch 6/9 is base on Laurent's series, to support probe deferral.
patch 7/9 according to Robin Murphy's suggestion, remove global variable arm_smmu_devices, thanks.
patch 9/9 add support for a master with multiple stream IDs.

Zhen Lei (5):
  iommu/arm-smmu: to support probe deferral
  iommu/arm-smmu: rename __arm_smmu_get_pci_sid
  iommu/arm-smmu: add support for non-pci devices
  iommu/arm-smmu: to backward compatible with probe non-deferral
  iommu/arm-smmu: describe the limitation of #iommu-cells

 .../devicetree/bindings/iommu/arm,smmu-v3.txt      |   6 +
 drivers/iommu/arm-smmu-v3.c                        | 166 +++++++++++++++++----
 2 files changed, 143 insertions(+), 29 deletions(-)

--
2.5.0
