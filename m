Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1FD7C
	for <iommu@lists.linux.dev>; Sat, 19 Nov 2022 14:42:30 +0000 (UTC)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NDxF70bqVzRpFb;
	Sat, 19 Nov 2022 22:42:03 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 19 Nov 2022 22:42:27 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 19 Nov
 2022 22:42:26 +0800
From: Yang Yingliang <yangyingliang@huawei.com>
To: <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <joro@8bytes.org>,
	<will@kernel.org>, <robin.murphy@arm.com>
CC: <iommu@lists.linux.dev>, <yangyingliang@huawei.com>
Subject: [PATCH v2] iommu/vt-d: fix pci device refcount leak in prq_event_thread()
Date: Sat, 19 Nov 2022 22:40:28 +0800
Message-ID: <20221119144028.2452731-1-yangyingliang@huawei.com>
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
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected

As comment of pci_get_domain_bus_and_slot() says, it returns
a pci device with refcount increment, when finish using it,
the caller must decrement the reference count by calling
pci_dev_put(). So call pci_dev_put() after using the 'pdev'
to avoid refcount leak.

Besides, if the 'pdev' is null or intel_svm_prq_report()
returns error, there is no need to trace this fault.

Fixes: 06f4b8d09dba ("iommu/vt-d: Remove unnecessary SVA data accesses in page fault path")
Suggested-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/iommu/intel/svm.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 7d08eb034f2d..3fa7446fb2e9 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -745,12 +745,16 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 		 * If prq is to be handled outside iommu driver via receiver of
 		 * the fault notifiers, we skip the page response here.
 		 */
-		if (!pdev || intel_svm_prq_report(iommu, &pdev->dev, req))
-			handle_bad_prq_event(iommu, req, QI_RESP_INVALID);
+		if (!pdev)
+			goto bad_req;
 
-		trace_prq_report(iommu, &pdev->dev, req->qw_0, req->qw_1,
-				 req->priv_data[0], req->priv_data[1],
-				 iommu->prq_seq_number++);
+		if (intel_svm_prq_report(iommu, &pdev->dev, req))
+			handle_bad_prq_event(iommu, req, QI_RESP_INVALID);
+		else
+			trace_prq_report(iommu, &pdev->dev, req->qw_0, req->qw_1,
+					 req->priv_data[0], req->priv_data[1],
+					 iommu->prq_seq_number++);
+		pci_dev_put(pdev);
 prq_advance:
 		head = (head + sizeof(*req)) & PRQ_RING_MASK;
 	}
-- 
2.25.1

