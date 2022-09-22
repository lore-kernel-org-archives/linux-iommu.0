Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663EC3207
	for <iommu@lists.linux.dev>; Thu, 22 Sep 2022 11:40:56 +0000 (UTC)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VQSkvRx_1663845886;
Received: from localhost(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0VQSkvRx_1663845886)
          by smtp.aliyun-inc.com;
          Thu, 22 Sep 2022 19:25:13 +0800
From: Liu Song <liusong@linux.alibaba.com>
To: jean-philippe@linaro.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com
Cc: virtualization@lists.linux-foundation.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] iommu/virtio: __viommu_sync_req is no need to return a value
Date: Thu, 22 Sep 2022 19:24:46 +0800
Message-Id: <1663845886-11341-1-git-send-email-liusong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

From: Liu Song <liusong@linux.alibaba.com>

In "__viommu_sync_req", 0 is always returned as the only return value, no
return value is needed for this case, and the processes and functions
involved are adjusted accordingly.

Signed-off-by: Liu Song <liusong@linux.alibaba.com>
---
 drivers/iommu/virtio-iommu.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index b7c2280..fde5661 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -151,7 +151,7 @@ static off_t viommu_get_write_desc_offset(struct viommu_dev *viommu,
  * Wait for all added requests to complete. When this function returns, all
  * requests that were in-flight at the time of the call have completed.
  */
-static int __viommu_sync_req(struct viommu_dev *viommu)
+static void __viommu_sync_req(struct viommu_dev *viommu)
 {
 	unsigned int len;
 	size_t write_len;
@@ -180,22 +180,15 @@ static int __viommu_sync_req(struct viommu_dev *viommu)
 		list_del(&req->list);
 		kfree(req);
 	}
-
-	return 0;
 }
 
-static int viommu_sync_req(struct viommu_dev *viommu)
+static void viommu_sync_req(struct viommu_dev *viommu)
 {
-	int ret;
 	unsigned long flags;
 
 	spin_lock_irqsave(&viommu->request_lock, flags);
-	ret = __viommu_sync_req(viommu);
-	if (ret)
-		dev_dbg(viommu->dev, "could not sync requests (%d)\n", ret);
+	__viommu_sync_req(viommu);
 	spin_unlock_irqrestore(&viommu->request_lock, flags);
-
-	return ret;
 }
 
 /*
@@ -247,8 +240,8 @@ static int __viommu_add_req(struct viommu_dev *viommu, void *buf, size_t len,
 	ret = virtqueue_add_sgs(vq, sg, 1, 1, req, GFP_ATOMIC);
 	if (ret == -ENOSPC) {
 		/* If the queue is full, sync and retry */
-		if (!__viommu_sync_req(viommu))
-			ret = virtqueue_add_sgs(vq, sg, 1, 1, req, GFP_ATOMIC);
+		__viommu_sync_req(viommu);
+		ret = virtqueue_add_sgs(vq, sg, 1, 1, req, GFP_ATOMIC);
 	}
 	if (ret)
 		goto err_free;
@@ -293,11 +286,7 @@ static int viommu_send_req_sync(struct viommu_dev *viommu, void *buf,
 		goto out_unlock;
 	}
 
-	ret = __viommu_sync_req(viommu);
-	if (ret) {
-		dev_dbg(viommu->dev, "could not sync requests (%d)\n", ret);
-		/* Fall-through (get the actual request status) */
-	}
+	__viommu_sync_req(viommu);
 
 	ret = viommu_get_req_errno(buf, len);
 out_unlock:
-- 
1.8.3.1

