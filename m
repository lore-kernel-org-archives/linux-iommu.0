Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF3B3C3E
	for <iommu@lists.linux.dev>; Wed, 17 Aug 2022 10:16:17 +0000 (UTC)
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.207])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M73nR5Qyrz685K1;
	Wed, 17 Aug 2022 18:15:55 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Wed, 17 Aug 2022 12:16:09 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 17 Aug 2022 11:16:07 +0100
From: John Garry <john.garry@huawei.com>
To: <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, John Garry
	<john.garry@huawei.com>
Subject: [PATCH 0/3] iova: Some misc changes
Date: Wed, 17 Aug 2022 18:09:41 +0800
Message-ID: <1660730984-30333-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected

This series includes:
- remove checks in the code which are not required
- the re-org, which I had originally posted separately

Based on v6.0-rc1

John Garry (3):
  iova: Remove some magazine pointer NULL checks
  iova: Remove magazine BUG_ON() checks
  iova: Re-order code to remove forward declarations

 drivers/iommu/iova.c | 1074 +++++++++++++++++++++---------------------
 include/linux/iova.h |   60 +--
 2 files changed, 559 insertions(+), 575 deletions(-)

-- 
2.35.3

