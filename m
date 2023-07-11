Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E0A7F
	for <iommu@lists.linux.dev>; Tue, 11 Jul 2023 03:03:51 +0000 (UTC)
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R0Qf01RnXzVhpV;
	Tue, 11 Jul 2023 11:02:32 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 11 Jul
 2023 11:03:42 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: <guohanjun@huawei.com>, <xuqiang36@huawei.com>, <chenweilong@huawei.com>,
	<thunder.leizhen@huawei.com>, <zhangzekun11@huawei.com>
Subject: [PATCH -next 0/2] iommu/iova: optimize the iova rcache 
Date: Tue, 11 Jul 2023 10:54:50 +0800
Message-ID: <20230711025452.35475-1-zhangzekun11@huawei.com>
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
 dggpeml500022.china.huawei.com (7.185.36.66)
X-CFilter-Loop: Reflected

The struct of iova rcache has diffcult in dealing with machine with
lots of cpus, because every cpu has a cpu_rcache and they need to
exchange iova in a fixed length buffer rcache->depot, this buffer
can sometimes become a bottle neck of allocating iova from iova_rcache.
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

