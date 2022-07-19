Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7B310E9
	for <iommu@lists.linux.dev>; Tue, 19 Jul 2022 09:57:15 +0000 (UTC)
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.206])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LnDf149Xbz67T9q;
	Tue, 19 Jul 2022 17:52:41 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Jul 2022 11:57:12 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Jul 2022 10:57:10 +0100
From: John Garry <john.garry@huawei.com>
To: <jejb@linux.ibm.com>, <martin.petersen@oracle.com>, <hch@lst.de>,
	<damien.lemoal@opensource.wdc.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, John Garry <john.garry@huawei.com>
Subject: [PATCH] scsi: sd: Add a comment about limiting max_sectors to shost optimal limit
Date: Tue, 19 Jul 2022 17:51:04 +0800
Message-ID: <1658224264-49972-1-git-send-email-john.garry@huawei.com>
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
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected

Add a comment about limiting the default the SCSI disk request_queue
max_sectors initial value to that of the SCSI host optimal sectors limit.

Suggested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 3eaee1f7aaca..ed9f43f9512e 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3296,6 +3296,11 @@ static int sd_revalidate_disk(struct gendisk *disk)
 				      (sector_t)BLK_DEF_MAX_SECTORS);
 	}
 
+	/*
+	 * Limit default to SCSI host optimal sector limit if set. There may be
+	 * an impact on performance for when the size of a request exceeds this
+	 * host limit.
+	 */
 	rw_max = min_not_zero(rw_max, sdp->host->opt_sectors);
 
 	/* Do not exceed controller limit */
-- 
2.35.3

