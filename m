Received: from sinmsgout03.his.huawei.com (sinmsgout03.his.huawei.com [119.8.177.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578AF2C9D
	for <iommu@lists.linux.dev>; Thu, 14 Jul 2022 11:22:25 +0000 (UTC)
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.156.208])
	by sinmsgout03.his.huawei.com (SkyGuard) with ESMTP id 4LkBrV5CLvz9xGPv;
	Thu, 14 Jul 2022 19:21:14 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 14 Jul 2022 13:22:18 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 14 Jul 2022 12:22:14 +0100
From: John Garry <john.garry@huawei.com>
To: <damien.lemoal@opensource.wdc.com>, <joro@8bytes.org>, <will@kernel.org>,
	<jejb@linux.ibm.com>, <martin.petersen@oracle.com>, <hch@lst.de>,
	<m.szyprowski@samsung.com>, <robin.murphy@arm.com>
CC: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-ide@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>, John Garry
	<john.garry@huawei.com>
Subject: [PATCH v6 4/6] scsi: sd: Allow max_sectors be capped at DMA optimal size limit
Date: Thu, 14 Jul 2022 19:15:27 +0800
Message-ID: <1657797329-98541-5-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1657797329-98541-1-git-send-email-john.garry@huawei.com>
References: <1657797329-98541-1-git-send-email-john.garry@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected

Streaming DMA mappings may be considerably slower when mappings go through
an IOMMU and the total mapping length is somewhat long. This is because the
IOMMU IOVA code allocates and free an IOVA for each mapping, which may
affect performance.

New member Scsi_Host.opt_sectors is added, which is the optimal host
max_sectors, and use this value to cap the request queue max_sectors when
set.

It could be considered to have request queues io_opt value initially
set at Scsi_Host.opt_sectors in __scsi_init_queue(), but that is not
really the purpose of io_opt.

Finally, even though Scsi_Host.opt_sectors value should never be greater
than the request queue max_hw_sectors value, continue to limit to this
value for safety.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/sd.c        | 2 ++
 include/scsi/scsi_host.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index a1a2ac09066f..3eaee1f7aaca 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3296,6 +3296,8 @@ static int sd_revalidate_disk(struct gendisk *disk)
 				      (sector_t)BLK_DEF_MAX_SECTORS);
 	}
 
+	rw_max = min_not_zero(rw_max, sdp->host->opt_sectors);
+
 	/* Do not exceed controller limit */
 	rw_max = min(rw_max, queue_max_hw_sectors(q));
 
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index 667d889b92b5..d32a84b2bb40 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -607,6 +607,7 @@ struct Scsi_Host {
 	short unsigned int sg_tablesize;
 	short unsigned int sg_prot_tablesize;
 	unsigned int max_sectors;
+	unsigned int opt_sectors;
 	unsigned int max_segment_size;
 	unsigned long dma_boundary;
 	unsigned long virt_boundary_mask;
-- 
2.35.3

