Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E974433E4
	for <iommu@lists.linux.dev>; Mon, 27 Jun 2022 15:31:53 +0000 (UTC)
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.201])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LWs8w6lkwz6H6ql;
	Mon, 27 Jun 2022 23:29:36 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 27 Jun 2022 17:31:51 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 27 Jun 2022 16:31:47 +0100
From: John Garry <john.garry@huawei.com>
To: <damien.lemoal@opensource.wdc.com>, <joro@8bytes.org>, <will@kernel.org>,
	<jejb@linux.ibm.com>, <martin.petersen@oracle.com>, <hch@lst.de>,
	<m.szyprowski@samsung.com>, <robin.murphy@arm.com>
CC: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-ide@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
	<iommu@lists.linux.dev>, <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
	John Garry <john.garry@huawei.com>
Subject: [PATCH v4 5/5] libata-scsi: Cap ata_device->max_sectors according to shost->max_sectors
Date: Mon, 27 Jun 2022 23:25:21 +0800
Message-ID: <1656343521-62897-6-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1656343521-62897-1-git-send-email-john.garry@huawei.com>
References: <1656343521-62897-1-git-send-email-john.garry@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Message-ID: <20220627152521.jW0n7CLfgNf2uNYXZI4b2l4kAvE1mHWyF4HyDU0LBoM@z>

ATA devices (struct ata_device) have a max_sectors field which is
configured internally in libata. This is then used to (re)configure the
associated sdev request queue max_sectors value from how it is earlier set
in __scsi_init_queue(). In __scsi_init_queue() the max_sectors value is set
according to shost limits, which includes host DMA mapping limits.

Cap the ata_device max_sectors according to shost->max_sectors to respect
this shost limit.

Signed-off-by: John Garry <john.garry@huawei.com>
Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/libata-scsi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 86dbb1cdfabd..24a43d540d9f 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1060,6 +1060,7 @@ int ata_scsi_dev_config(struct scsi_device *sdev, struct ata_device *dev)
 		dev->flags |= ATA_DFLAG_NO_UNLOAD;
 
 	/* configure max sectors */
+	dev->max_sectors = min(dev->max_sectors, sdev->host->max_sectors);
 	blk_queue_max_hw_sectors(q, dev->max_sectors);
 
 	if (dev->class == ATA_DEV_ATAPI) {
-- 
2.35.3

