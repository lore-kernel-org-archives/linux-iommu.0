Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3BD3C10A2
	for <iommu@lists.linux.dev>; Tue,  1 Sep 2026 14:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788271693; cv=none; b=bRUqphRCs7QGIyblK88/bOgaI8G8J2SMoh8GuUJwzWroblfwg+Ij4yLwRWlQd7AaQcjYq8+k4e3/+WGShm1wBh3uLiyqQM5P7i1pr211EwKvoxn6AkKKaOsouKOEwYYBC7wqAINlbzD8ZNcn9aKUevSSzLURvrQvuzJgx0R/HH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788271693; c=relaxed/simple;
	bh=fgWSAiqEXNtFexX0D/dPCGQnM+rsCFNBbe6tPgwzeCc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o1it7P56EBQoXi22EESn0t8JnZzWJ6wVgScpj6yvsxUnlIDZ8LuYSg6Qv5mB5+bsJWBfbpowjO9v1kneaO+FRJbAVO86LrxLfko3hmZw7H3iMnH9+bWlRr57KFJekxpQ0RgQimflKYLvWp3uOCwsIvOtpvMfb9NQr56BEILcocE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=VmrA+3fi; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="VmrA+3fi"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=fUVCRC8erTQTJxFM6RDLTv4k2iAL5mWt47ZMZ7KEb10=;
	b=VmrA+3fi55vvRnD6vbo2DmIBr5PmyfZQ8Y8PlDvK5tKzrEMnQObwAz2+rMy2A6XFJTeHNjJAc
	RZq8WxnsJiB5pFruCkYFXB42SFgraQHeknmibYJiQC05J+qlOiN6fY+ih+k3G/xslTuvae2Pe90
	FRW+R0jPoFz18XZWE++oD48=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hZ6q64lHLznTVd;
	Tue,  1 Sep 2026 21:56:50 +0800 (CST)
Received: from kwepemo500007.china.huawei.com (unknown [7.202.195.114])
	by mail.maildlp.com (Postfix) with ESMTPS id 4F37C40565;
	Tue,  1 Sep 2026 22:08:04 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemo500007.china.huawei.com (7.202.195.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 1 Sep 2026 22:08:03 +0800
From: Qinxin Xia <xiaqinxin@huawei.com>
To: <ben.horgan@arm.com>, <zhangzhanpeng.jasper@bytedance.com>,
	<joro@8bytes.org>, <palmer@dabbelt.com>, <tony.luck@intel.com>,
	<reinette.chatre@intel.com>, <tomasz.jeznach@linux.dev>,
	<zengheng4@huawei.com>, <fustini@kernel.org>, <cuiyunhui@bytedance.com>,
	<wangzhou1@hisilicon.com>, <xiaqinxin@huawei.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <pjw@kernel.org>,
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <Dave.Martin@arm.com>,
	<james.morse@arm.com>, <babu.moger@amd.com>, <corbet@lwn.net>,
	<shuah@kernel.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<yuanzhu@bytedance.com>, <iommu@lists.linux.dev>, <linuxarm@huawei.com>,
	<baolin.wang@linux.alibaba.com>
Subject: [RFC PATCH 0/5] resctrl: Assign devices to resource groups via IOMMU DMA QoS tagging
Date: Tue, 1 Sep 2026 22:07:57 +0800
Message-ID: <20260901140802.1215508-1-xiaqinxin@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemo500007.china.huawei.com (7.202.195.114)

Hi all,

This RFC series lets resctrl assign a device to a resource group so that the 
device's DMA traffic is subject to the same QoS controls (e.g. cache and 
memory-bandwidth allocation) as the tasks and CPUs in that group. Until now 
resctrl could only control CPU-originated traffic; DMA from devices behind an
IOMMU was unmanaged.

The mechanism is to tag a device's DMA with a QoS requestor ID at the IOMMU.
On Arm this maps to an MPAM PARTID/PMG programmed into the SMMUv3 stream table;
the interface is kept generic so other IOMMUs can plug in. resctrl exposes the 
assignment through a new per-group "devices" file: writing a device name moves
it into the group and stamps its DMA with the group's QoS IDs. The file is only
shown on platforms where an IOMMU can actually tag device DMA.

Sending as an RFC to get feedback on the overall approach and on the generic
IOMMU interface in particular.

Previously we had some discussions with Ben and Zeng Heng about this[1], and we all
agreed that some refactoring would be desirable later. Later, Zhanpeng posted
his RFC series[2]. Like his patch, this series also introduces a new devices ABI
under resctrl. The difference is that in this series, the devices file accepts
device names directly, rather than iommu_group identifiers (we consider supporting
fuzzy matching in the future to allow batch addition of devices). 
Welcome any discussions based on this :-)

[1] https://lore.kernel.org/lkml/d13fdc75-b647-44f3-9657-d592353e8a1a@huawei.com/
[2] https://lore.kernel.org/all/20260714130657.46963-1-zhangzhanpeng.jasper@bytedance.com/

Qinxin Xia (5):
  iommu: Add per-device requestor QoS tagging and lookup helpers
  arm_mpam: resctrl: Add arch query for device DMA QoS support
  iommu/arm-smmu-v3: Support MPAM device DMA QoS tagging
  fs/resctrl: Add device-to-group QoS tracking infrastructure
  fs/resctrl: Add a "devices" file to assign devices to groups

 Documentation/filesystems/resctrl.rst       |  18 +-
 arch/x86/include/asm/resctrl.h              |   5 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  96 ++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  13 +
 drivers/iommu/iommu.c                       | 113 +++++++++
 drivers/resctrl/mpam_devices.c              |  20 ++
 drivers/resctrl/mpam_resctrl.c              |   5 +
 fs/resctrl/internal.h                       |   9 +
 fs/resctrl/pseudo_lock.c                    |   5 +
 fs/resctrl/rdtgroup.c                       | 249 ++++++++++++++++++++
 include/linux/arm_mpam.h                    |   5 +
 include/linux/iommu.h                       |  29 +++
 12 files changed, 565 insertions(+), 2 deletions(-)

-- 
2.33.0

