Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4AFECD
	for <iommu@lists.linux.dev>; Mon, 21 Nov 2022 11:19:00 +0000 (UTC)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.53])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NG4d96kmkzmV67;
	Mon, 21 Nov 2022 19:18:21 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 19:18:50 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 19:18:50 +0800
From: Xiongfeng Wang <wangxiongfeng2@huawei.com>
To: <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <joro@8bytes.org>,
	<will@kernel.org>, <robin.murphy@arm.com>, <jroedel@suse.de>
CC: <iommu@lists.linux.dev>, <yangyingliang@huawei.com>,
	<wangxiongfeng2@huawei.com>
Subject: [PATCH 0/2] iommu/vt-d: Fix PCI device reference count leak
Date: Mon, 21 Nov 2022 19:36:47 +0800
Message-ID: <20221121113649.190393-1-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected

for_each_pci_dev() is implemented by pci_get_device(). The comment of
pci_get_device() says that it will increase the reference count for the
returned pci_dev and also decrease the reference count for the input
pci_dev @from if it is not NULL.

If we break for_each_pci_dev() loop with pdev not NULL, we need to call
pci_dev_put() to decrease the reference count.

Xiongfeng Wang (2):
  iommu/vt-d: Fix PCI device reference count leak in has_external pci()
  iommu/vt-d: Fix PCI device reference count leak in
    dmar_dev_scope_init()

 drivers/iommu/intel/dmar.c  | 1 +
 drivers/iommu/intel/iommu.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.20.1

