Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B401101D1
	for <iommu@lists.linux.dev>; Tue, 28 Nov 2023 09:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Sfd3J1D92z6JB75;
	Tue, 28 Nov 2023 17:49:48 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 837C2140135;
	Tue, 28 Nov 2023 17:50:04 +0800 (CST)
Received: from A2006125610.china.huawei.com (10.202.227.178) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 28 Nov 2023 09:49:57 +0000
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>
CC: <robin.murphy@arm.com>, <will@kernel.org>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<mshavit@google.com>, <eric.auger@redhat.com>, <joao.m.martins@oracle.com>,
	<jiangkunkun@huawei.com>, <zhukeqian1@huawei.com>, <linuxarm@huawei.com>
Subject: [PATCH 0/5] iommu/smmuv3: Add IOMMUFD dirty tracking support for SMMUv3 
Date: Tue, 28 Nov 2023 09:49:35 +0000
Message-ID: <20231128094940.1344-1-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

Hi,

This is revisiting the earlier attempts [1, 2] to use SMMUv3 HTTU feature
for dirty page tracking. The Intel/AMD support is already mainline.

The code is now based on the new IOMMUFD APIs and is rebased on
Jason's SMMUv3 driver refactor series[3].

One major change is in patch #3 where the IO PTE walker code is modified
to take care of any iova size instead of iommu pgsize,

This is tested using a Qemu branch based on "vfio: Adopt iommufd" v4 series[4].

Basic sanity tests are done using an emulation setup and on a test hardware
setup. Block page split/merge(BBML) is not part of this series. I am planning
to send it separately.

Complete git branches are here,

https://github.com/hisilicon/kernel-dev/tree/smmuv3_newapi-dbm-arm
https://github.com/hisilicon/qemu/tree/iommufd_cdev_v4-dbm-arm

Please take a look and let me know your feedback.

Thanks,
Shameer
1. https://lore.kernel.org/lkml/20210413085457.25400-1-zhukeqian1@huawei.com/
2. https://lore.kernel.org/linux-iommu/20230518204650.14541-1-joao.m.martins@oracle.com/
3. https://lore.kernel.org/all/0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com/
4. https://lore.kernel.org/qemu-devel/20231102071302.1818071-1-zhenzhong.duan@intel.com/

Jean-Philippe Brucker (1):
  iommu/arm-smmu-v3: Add feature detection for HTTU

Joao Martins (2):
  iommu/arm-smmu-v3: Add set_dirty_tracking() support
  iommu/arm-smmu-v3: Enforce dirty tracking in domain attach/alloc

Keqian Zhu (1):
  iommu/arm-smmu-v3: Add read_and_clear_dirty() support

Kunkun Jiang (1):
  iommu/arm-smmu-v3: Enable HTTU for stage1 with io-pgtable mapping

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 115 +++++++++++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |   8 ++
 drivers/iommu/io-pgtable-arm.c              | 125 +++++++++++++++++++-
 include/linux/io-pgtable.h                  |   4 +
 4 files changed, 249 insertions(+), 3 deletions(-)

-- 
2.34.1

