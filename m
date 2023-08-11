Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5156F63B6
	for <iommu@lists.linux.dev>; Fri, 11 Aug 2023 13:11:15 +0000 (UTC)
Received: from kwepemi500019.china.huawei.com (unknown [172.30.72.55])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RMkfS02syzrSbH;
	Fri, 11 Aug 2023 21:09:51 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemi500019.china.huawei.com
 (7.221.188.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 21:11:05 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<baolu.lu@linux.intel.com>, <robh@kernel.org>, <nicolinc@nvidia.com>,
	<john.g.garry@oracle.com>, <kevin.tian@intel.com>
Subject: [RESEND PATCH 0/2] iommu/iova: optimize the iova rcache 
Date: Fri, 11 Aug 2023 21:02:44 +0800
Message-ID: <20230811130246.42719-1-zhangzekun11@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500019.china.huawei.com (7.221.188.117)
X-CFilter-Loop: Reflected

The number of iova_cpu_rcache can grow with the number of cpus in
iova_rcache, but the size of rcache->depot will not. The deeper of
rcache->depot can help iova_rcache cache more iovas, and can help
iova_rcache better dealing with senarios in which drivers allocating
and free iovas on different cpu cores. We only let the size of rcache->depot
to grow with the number of cpus which is larger than 32 to avoid potential
performance decrease on machines which don't have much cpus.

Also, it is unsafe to directly free cpu rcache magazines in free_iova_rcaches,
add check before freeing it.

Zhang Zekun (2):
  iommu/iova: Add check for cpu_rcache in free_iova_rcaches
  iommu/iova: allocate iova_rcache->depot dynamicly

 drivers/iommu/iova.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

-- 
2.17.1

