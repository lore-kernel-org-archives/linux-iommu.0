Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAA433E4
	for <iommu@lists.linux.dev>; Mon, 27 Jun 2022 15:31:49 +0000 (UTC)
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.201])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LWs6q2Lcmz6H8F0;
	Mon, 27 Jun 2022 23:27:47 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 27 Jun 2022 17:31:47 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 27 Jun 2022 16:31:43 +0100
From: John Garry <john.garry@huawei.com>
To: <damien.lemoal@opensource.wdc.com>, <joro@8bytes.org>, <will@kernel.org>,
	<jejb@linux.ibm.com>, <martin.petersen@oracle.com>, <hch@lst.de>,
	<m.szyprowski@samsung.com>, <robin.murphy@arm.com>
CC: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-ide@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
	<iommu@lists.linux.dev>, <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
	John Garry <john.garry@huawei.com>
Subject: [PATCH v4 4/5] scsi: scsi_transport_sas: Cap shost max_sectors according to DMA optimal mapping limit
Date: Mon, 27 Jun 2022 23:25:20 +0800
Message-ID: <1656343521-62897-5-git-send-email-john.garry@huawei.com>
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
Message-ID: <20220627152520.HFG4hwajmN59w2UEN-BXlMl0sWm_tgS3FNX1QVMqYPk@z>

Streaming DMA mappings may be considerably slower when mappings go through
an IOMMU and the total mapping length is somewhat long. This is because the
IOMMU IOVA code allocates and free an IOVA for each mapping, which may
affect performance.

For performance reasons set the request queue max_sectors from
dma_opt_mapping_size(), which knows this mapping limit.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/scsi_transport_sas.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/scsi/scsi_transport_sas.c b/drivers/scsi/scsi_transport_sas.c
index 12bff64dade6..1b45248748e0 100644
--- a/drivers/scsi/scsi_transport_sas.c
+++ b/drivers/scsi/scsi_transport_sas.c
@@ -225,6 +225,7 @@ static int sas_host_setup(struct transport_container *tc, struct device *dev,
 {
 	struct Scsi_Host *shost = dev_to_shost(dev);
 	struct sas_host_attrs *sas_host = to_sas_host_attrs(shost);
+	struct device *dma_dev = shost->dma_dev;
 
 	INIT_LIST_HEAD(&sas_host->rphy_list);
 	mutex_init(&sas_host->lock);
@@ -236,6 +237,11 @@ static int sas_host_setup(struct transport_container *tc, struct device *dev,
 		dev_printk(KERN_ERR, dev, "fail to a bsg device %d\n",
 			   shost->host_no);
 
+	if (dma_dev) {
+		shost->max_sectors = min_t(unsigned int, shost->max_sectors,
+				dma_opt_mapping_size(dma_dev) >> SECTOR_SHIFT);
+	}
+
 	return 0;
 }
 
-- 
2.35.3

