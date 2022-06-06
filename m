Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F269C43334
	for <iommu@archiver.kernel.org>; Mon,  6 Jun 2022 09:36:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C9DD1405C8;
	Mon,  6 Jun 2022 09:36:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WQNlGADrGqCM; Mon,  6 Jun 2022 09:36:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A1C2C405B0;
	Mon,  6 Jun 2022 09:36:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8C896C0032;
	Mon,  6 Jun 2022 09:36:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9D58C002D
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jun 2022 09:36:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D8AE1405C2
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jun 2022 09:36:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s1NWV_s_myko for <iommu@lists.linux-foundation.org>;
 Mon,  6 Jun 2022 09:36:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3F3C54011D
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jun 2022 09:36:45 +0000 (UTC)
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LGpFQ1FFVz684JT;
 Mon,  6 Jun 2022 17:33:14 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 6 Jun 2022 11:36:43 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 6 Jun 2022 10:36:39 +0100
To: <damien.lemoal@opensource.wdc.com>, <joro@8bytes.org>, <will@kernel.org>, 
 <jejb@linux.ibm.com>, <martin.petersen@oracle.com>, <hch@lst.de>,
 <m.szyprowski@samsung.com>, <robin.murphy@arm.com>
Subject: [PATCH v3 3/4] scsi: core: Cap shost max_sectors according to DMA
 optimum mapping limits
Date: Mon, 6 Jun 2022 17:30:21 +0800
Message-ID: <1654507822-168026-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1654507822-168026-1-git-send-email-john.garry@huawei.com>
References: <1654507822-168026-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: linux-scsi@vger.kernel.org, linux-doc@vger.kernel.org,
 liyihang6@hisilicon.com, linux-kernel@vger.kernel.org,
 linux-ide@vger.kernel.org, iommu@lists.linux-foundation.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
From: John Garry via iommu <iommu@lists.linux-foundation.org>
Reply-To: John Garry <john.garry@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Streaming DMA mappings may be considerably slower when mappings go through
an IOMMU and the total mapping length is somewhat long. This is because the
IOMMU IOVA code allocates and free an IOVA for each mapping, which may
affect performance.

For performance reasons set the request_queue max_sectors from
dma_opt_mapping_size(), which knows this mapping limit.

In addition, the shost->max_sectors is repeatedly set for each sdev in
__scsi_init_queue(). This is unnecessary, so set once when adding the
host.

Signed-off-by: John Garry <john.garry@huawei.com>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 drivers/scsi/hosts.c    | 5 +++++
 drivers/scsi/scsi_lib.c | 4 ----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index 8352f90d997d..ea1a207634d1 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -236,6 +236,11 @@ int scsi_add_host_with_dma(struct Scsi_Host *shost, struct device *dev,
 
 	shost->dma_dev = dma_dev;
 
+	if (dma_dev->dma_mask) {
+		shost->max_sectors = min_t(unsigned int, shost->max_sectors,
+				dma_opt_mapping_size(dma_dev) >> SECTOR_SHIFT);
+	}
+
 	error = scsi_mq_setup_tags(shost);
 	if (error)
 		goto fail;
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 6ffc9e4258a8..6ce8acea322a 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1884,10 +1884,6 @@ void __scsi_init_queue(struct Scsi_Host *shost, struct request_queue *q)
 		blk_queue_max_integrity_segments(q, shost->sg_prot_tablesize);
 	}
 
-	if (dev->dma_mask) {
-		shost->max_sectors = min_t(unsigned int, shost->max_sectors,
-				dma_max_mapping_size(dev) >> SECTOR_SHIFT);
-	}
 	blk_queue_max_hw_sectors(q, shost->max_sectors);
 	blk_queue_segment_boundary(q, shost->dma_boundary);
 	dma_set_seg_boundary(dev, shost->dma_boundary);
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
