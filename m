Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03474C433F5
	for <iommu@archiver.kernel.org>; Fri, 20 May 2022 08:29:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B207384676;
	Fri, 20 May 2022 08:29:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bEmjffuD9UQK; Fri, 20 May 2022 08:29:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A44E284670;
	Fri, 20 May 2022 08:29:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69BFAC0032;
	Fri, 20 May 2022 08:29:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 82BABC002D
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 08:29:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 702C984670
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 08:29:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C8yuRjUxalWK for <iommu@lists.linux-foundation.org>;
 Fri, 20 May 2022 08:29:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DA60D84676
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 08:29:40 +0000 (UTC)
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4L4KYR55tBz687XH;
 Fri, 20 May 2022 16:25:47 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 20 May 2022 10:29:38 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 20 May 2022 09:29:34 +0100
To: <damien.lemoal@opensource.wdc.com>, <joro@8bytes.org>, <will@kernel.org>, 
 <jejb@linux.ibm.com>, <martin.petersen@oracle.com>, <hch@lst.de>,
 <m.szyprowski@samsung.com>, <robin.murphy@arm.com>
Subject: [PATCH 4/4] libata-scsi: Cap ata_device->max_sectors according to
 shost->max_sectors
Date: Fri, 20 May 2022 16:23:23 +0800
Message-ID: <1653035003-70312-5-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1653035003-70312-1-git-send-email-john.garry@huawei.com>
References: <1653035003-70312-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

ATA devices (struct ata_device) have a max_sectors field which is
configured internally in libata. This is then used to (re)configure the
associated sdev request queue max_sectors value from how it is earlier set
in __scsi_init_queue(). In __scsi_init_queue() the max_sectors value is set
according to shost limits, which includes host DMA mapping limits.

Cap the ata_device max_sectors according to shost->max_sectors to respect
this shost limit.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/ata/libata-scsi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 06c9d90238d9..25fe89791641 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1036,6 +1036,7 @@ int ata_scsi_dev_config(struct scsi_device *sdev, struct ata_device *dev)
 		dev->flags |= ATA_DFLAG_NO_UNLOAD;
 
 	/* configure max sectors */
+	dev->max_sectors = min(dev->max_sectors, sdev->host->max_sectors);
 	blk_queue_max_hw_sectors(q, dev->max_sectors);
 
 	if (dev->class == ATA_DEV_ATAPI) {
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
