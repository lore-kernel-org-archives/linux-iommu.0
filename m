Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17178381
	for <iommu@lists.linux.dev>; Sat, 19 Nov 2022 10:36:35 +0000 (UTC)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NDqk256tGzFq2Q;
	Sat, 19 Nov 2022 18:33:14 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 19 Nov 2022 18:36:26 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 19 Nov
 2022 18:36:26 +0800
From: Yang Yingliang <yangyingliang@huawei.com>
To: <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <joro@8bytes.org>,
	<will@kernel.org>, <robin.murphy@arm.com>
CC: <iommu@lists.linux.dev>, <yangyingliang@huawei.com>
Subject: [PATCH] iommu/vt-d: fix pci device refcount leak in prq_event_thread()
Date: Sat, 19 Nov 2022 18:34:36 +0800
Message-ID: <20221119103436.1859167-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected

As comment of pci_get_domain_bus_and_slot() says, it returns
a pci device with refcount increment, when finish using it,
the caller must decrement the reference count by calling
pci_dev_put(). So call pci_dev_put() after using the 'pdev'
to avoid refcount leak.

Fixes: 06f4b8d09dba ("iommu/vt-d: Remove unnecessary SVA data accesses in page fault path")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/iommu/intel/svm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 7d08eb034f2d..47c07556955e 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -751,6 +751,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 		trace_prq_report(iommu, &pdev->dev, req->qw_0, req->qw_1,
 				 req->priv_data[0], req->priv_data[1],
 				 iommu->prq_seq_number++);
+		pci_dev_put(pdev);
 prq_advance:
 		head = (head + sizeof(*req)) & PRQ_RING_MASK;
 	}
-- 
2.25.1

