Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D2E53B5
	for <iommu@lists.linux.dev>; Wed,  7 Sep 2022 13:09:26 +0000 (UTC)
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.201])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MN2Y52Kbhz6HHkk;
	Wed,  7 Sep 2022 21:05:13 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Wed, 7 Sep 2022 15:09:17 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 14:09:15 +0100
From: John Garry <john.garry@huawei.com>
To: <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jsnitsel@redhat.com>, <haifeng.zhao@linux.intel.com>,
	John Garry <john.garry@huawei.com>
Subject: [PATCH v3 0/3] iova: Some misc changes
Date: Wed, 7 Sep 2022 21:02:31 +0800
Message-ID: <1662555754-142760-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected

This series removes some checks in the code which are not required or
don't fulfil their purpose.

Differences to v2:
- Add more words in 1/3 commit log
- Add Jerry's tags (thanks)
- Add patch to drop iovad->rcaches check

Differences to v1:
- Drop re-org
- Add RB/AB tags

Based on v6.0-rc4

John Garry (3):
  iova: Remove some magazine pointer NULL checks
  iova: Remove magazine BUG_ON() checks
  iova: Remove iovad->rcaches check in iova_rcache_get()

 drivers/iommu/iova.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

-- 
2.25.1

