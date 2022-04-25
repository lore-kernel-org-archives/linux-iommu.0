Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD43C433F5
	for <iommu@archiver.kernel.org>; Mon, 25 Apr 2022 11:41:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 68E8B60B2C;
	Mon, 25 Apr 2022 11:41:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iRqS6JT-OUVm; Mon, 25 Apr 2022 11:41:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 33E8260681;
	Mon, 25 Apr 2022 11:41:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0DF7DC0039;
	Mon, 25 Apr 2022 11:41:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 102F4C002D
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:41:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0C94360A83
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:41:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V9OfMtNUS6jh for <iommu@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 11:41:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::605])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 44A5060681
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:41:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aysRCwiFmVfNnuSSDSDl7z7KaHcZ06q3CKfdvQnZKsPqkNG4pmZt+wmqmLudl2ShnYpQzrrcQ9R2G/xX1ciFGrlQS/j3jfQyHevnYWqTLP+CcHMybJB8L5Udd5xZCiWP0H9nk7HTMt0Fj43nEMfZipQtNGdvcB+PYr5N9qRrlrljPq3LYLUb2PKeD+PRJUD0ljOMqNVaKSfvX4TNCPiP51yc8a31eR03PWgIo2ZZWgR2g36rU364FYUXDxkBFdZAcGcdfIvGJaRbIj6s5k2mLAYGb7mdjMM++cgJGKdqMPP24VtaZKAnvclZIII9Cs8OYYvHQeRzhc1QGkmaAnZc8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9sYGDsJ3mhpmlhRv/pDjh43p/rLlyvSAarl2mRagIms=;
 b=V44uKldVPVKurcqfiaFX26mXBZwylNlXFDrftrD5wODcvdVeda6QT90W8CkvVpFQZ51MgUS9Mdrg2FsZvK3YA7VjM5URYQq6ttd1QDF5eAvBwODTH6q23n9O2ufchzYjBCbTbBW4dgjOAQUrEJdJ0VMlmR4jgX2pmzXJCXWJBXRUsZad5W9h2viqUqpn9w4oiKkeZwkaTAfPH1z7FaD/mo2NUouemxPnavHCZvV2+xGQnvskH/RhdChGAcd/OvnzcEBSUciqtfOkK87lglZx9zF8nYgLCgo6uZ3hI1MKsxYHwBpvYlqnoakFWdm9wE+KH6O5AeKlyze72OTRq+MIYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sYGDsJ3mhpmlhRv/pDjh43p/rLlyvSAarl2mRagIms=;
 b=QRIR+VUcrjuP/DJQkjUN+XU1W7zw1IW329aUaGpujWPxfJODZMozIHK30whhZxYOcsLD6W6fr3S+i5c4HcuI0E4LsrL31SRA0XhR0AvyRZdi1ycQIMdcTk6Z2eK4iDILyA4QIV/Agt3+Lo1IATOPG8wDEZql6B5Yk29bg3ua4Ww=
Received: from BN0PR02CA0014.namprd02.prod.outlook.com (2603:10b6:408:e4::19)
 by CH0PR12MB5369.namprd12.prod.outlook.com (2603:10b6:610:d4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Mon, 25 Apr
 2022 11:41:00 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::6) by BN0PR02CA0014.outlook.office365.com
 (2603:10b6:408:e4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Mon, 25 Apr 2022 11:41:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Mon, 25 Apr 2022 11:40:59 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 06:40:58 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v2 24/37] iommu/amd: Update set_dte_irq_entry
Date: Mon, 25 Apr 2022 17:04:02 +0530
Message-ID: <20220425113415.24087-25-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425113415.24087-1-vasant.hegde@amd.com>
References: <20220425113415.24087-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bdbdedc9-312f-452a-8ac6-08da26b07837
X-MS-TrafficTypeDiagnostic: CH0PR12MB5369:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5369D7E40BB428E9425200D587F89@CH0PR12MB5369.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3+P0SGguj5atTWfWR0GcvddV4+5KeFdMfX5xVQHXlynDPpNErAW49r1Rei71AIkm8sGXN8DuWPR2VJrVs3jDiKSAr1ALYpOExmWsV2MMmgV3+AX9CKnt+JtZjbCXdVzRsuwp6Xt1ak8E4xwDm3n3dj/RScDuSHuHjLwwHcfVGBy2tSXKETt1+roz51sYqGW4zfsM1W4InFrRa00G1czM5RWSMzaCZOwUoBfeNpvMR/GtCOsL6fS3LgQs8EHwleu+LJE/ak5ntKb4kUyCloNfALnPsxmLaVLcab/h4/WfxbYiPYZTR71cEuv1xX4tnNRhEs29r/ld9veltKwgTuQ/PgcuI9Gn1841MYs/OoiOjT9sbkU4of5yLNv15A3S6nCz2188bgVyof5ITzcqPJC8ZTp7p+ux8M9oaQ2FGTgv4WV5y2tNKLzVQFZAmi9JfZcu/tR417ObSUrlheZbec46xnVGJWTOoHOqODxe8ylPBYigdHLUUr98UChMkoeyJAAKoqk92KopL/uleiG2CZi4KDLEuiNFbPaAzQTIuDoHn3M7sPmo5DEX81oq4BLlP5Q4tCa6QizR7eOwvPmq1F4ZsQfoAgGWVkzPxY/AYmEQUkh/SJBf8bF8/PS2wKIalOzVLN2/LOGMKiwyOBtwdTcOP8kmksmTE3NBkfy2OSGmo2BNk0wQCStJKatrqrBl6cK73fThGBHuBbb7cpDs/EQciw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(16526019)(186003)(426003)(83380400001)(1076003)(81166007)(356005)(336012)(508600001)(47076005)(86362001)(36756003)(5660300002)(8936002)(44832011)(2906002)(6916009)(26005)(54906003)(4326008)(2616005)(8676002)(70206006)(70586007)(36860700001)(40460700003)(316002)(6666004)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 11:40:59.8727 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdbdedc9-312f-452a-8ac6-08da26b07837
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5369
Cc: Vasant Hegde <vasant.hegde@amd.com>
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
From: Vasant Hegde via iommu <iommu@lists.linux-foundation.org>
Reply-To: Vasant Hegde <vasant.hegde@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Start using per PCI segment device table instead of global
device table.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 5a2a4a08da2f..6773f218512c 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2729,18 +2729,20 @@ EXPORT_SYMBOL(amd_iommu_device_info);
 static struct irq_chip amd_ir_chip;
 static DEFINE_SPINLOCK(iommu_table_lock);
 
-static void set_dte_irq_entry(u16 devid, struct irq_remap_table *table)
+static void set_dte_irq_entry(struct amd_iommu *iommu, u16 devid,
+			      struct irq_remap_table *table)
 {
 	u64 dte;
+	struct dev_table_entry *dev_table = get_dev_table(iommu);
 
-	dte	= amd_iommu_dev_table[devid].data[2];
+	dte	= dev_table[devid].data[2];
 	dte	&= ~DTE_IRQ_PHYS_ADDR_MASK;
 	dte	|= iommu_virt_to_phys(table->table);
 	dte	|= DTE_IRQ_REMAP_INTCTL;
 	dte	|= DTE_INTTABLEN;
 	dte	|= DTE_IRQ_REMAP_ENABLE;
 
-	amd_iommu_dev_table[devid].data[2] = dte;
+	dev_table[devid].data[2] = dte;
 }
 
 static struct irq_remap_table *get_irq_table(struct amd_iommu *iommu, u16 devid)
@@ -2791,7 +2793,7 @@ static void set_remap_table_entry(struct amd_iommu *iommu, u16 devid,
 	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
 
 	pci_seg->irq_lookup_table[devid] = table;
-	set_dte_irq_entry(devid, table);
+	set_dte_irq_entry(iommu, devid, table);
 	iommu_flush_dte(iommu, devid);
 }
 
@@ -2807,8 +2809,7 @@ static int set_remap_table_entry_alias(struct pci_dev *pdev, u16 alias,
 
 	pci_seg = iommu->pci_seg;
 	pci_seg->irq_lookup_table[alias] = table;
-	set_dte_irq_entry(alias, table);
-
+	set_dte_irq_entry(iommu, alias, table);
 	iommu_flush_dte(pci_seg->rlookup_table[alias], alias);
 
 	return 0;
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
