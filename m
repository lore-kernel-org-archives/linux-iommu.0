Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E3F23AD
	for <iommu@lists.linux.dev>; Thu, 22 Sep 2022 08:12:12 +0000 (UTC)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.56])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MY7FL3zyMzWgsX;
	Thu, 22 Sep 2022 16:08:06 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 22 Sep
 2022 16:12:02 +0800
From: Yuan Can <yuancan@huawei.com>
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<iommu@lists.linux.dev>
CC: <yuancan@huawei.com>
Subject: [PATCH v2 0/3] iommu: Clean up and fixes
Date: Thu, 22 Sep 2022 08:09:32 +0000
Message-ID: <20220922080935.21454-1-yuancan@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected

This series contains two cleanups and one fix.

Changes in v2:
- Update the comments.

Yuan Can (3):
  iommu: return early when devices in a group require different domain
    type
  iommu: fix resource leak in iommu_group_alloc
  iommu/ioasid: Add missing new line for info message

 drivers/iommu/ioasid.c |  2 +-
 drivers/iommu/iommu.c  | 12 ++++++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

-- 
2.17.1

