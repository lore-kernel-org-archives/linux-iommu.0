Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3898BC433F5
	for <iommu@archiver.kernel.org>; Wed, 11 May 2022 07:25:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EC0F560D93;
	Wed, 11 May 2022 07:25:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EKZNLvgbJxAc; Wed, 11 May 2022 07:25:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 994EA610B7;
	Wed, 11 May 2022 07:25:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 677EAC0039;
	Wed, 11 May 2022 07:25:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E392EC002D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:25:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CDD228329E
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:25:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id El2RsNuLhhqQ for <iommu@lists.linux-foundation.org>;
 Wed, 11 May 2022 07:25:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::620])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DC20883224
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:25:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YARxp8PYzz1PCQzLuFc4EMzF1pfyBfUQZqsJRfBsTX6jKcsUWkw0fKj2kVtyeEOgrUNod2fgMEMKshBb3cXc7f3jyBQ30/BUVxQuMSy4zL9LoA7UPqgLLomH48gR7uE6jeQsncNp8VWal8FxsWN+3wRdBLoUm2VtaH6RkoMN1mTvvhwG2jfHbAyGwz2kaD1U7wmgwg7NUIe/8m5IbirqYD/haaFa5098Vwh5hG02HvtNfGAhUZ/ZArzmVVy5bfyznLuJYiZBP8zHV7cMqfTmmN0G9UCnqRiHNfmf61fSYTpy2Ul0DV3QaNID3AuGZtkLpkRkACFlh50SD2mvBX5nUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CGBS3wJ0FJJDod8+6BPQg3y+j+C6ePVs4Q00jXb/GSw=;
 b=AbEKmhHzEMuH+LH7Rof+An0gVD3oMQAcz8Hj+cXb/R1GKWsfY+UrG0vfnXdqC6oHSJL0xKs2BfiBQvyc0jek97HI0P6RpQ2qJ7+C7e+xtYUsB9Yc03AuMLtXMqTmbZlqS/2LGZK/r16/u5jdgPgDN5x9Ge+iMuM+lhIck5fQg3IATd2xygcOaPz3mYjnUkqJZrzBihsTWOTVJ6YDAg5XNbZOrNDxzcXGsgBL0aWL0LRpeyhbXPFqVcpW9C9CAcuqqOzf61uL3J+6OwOuIGZZ0dRwC0lO4+Xjru8SrKsvyppcJlMjUZyxWDXZVrBzsJWHKxpUVAON9G2+Oi0y01WFRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGBS3wJ0FJJDod8+6BPQg3y+j+C6ePVs4Q00jXb/GSw=;
 b=HDhniov/4lYRxkWbc4tyn8B6UTtfVKNha+1cRyvmq1sMs7JtZksxLFUBY7qoLAJHc69B4CxikRgI8OtR4WnaNumb8AerXf58b/sUj9vGMGmY7ZROz+jIm+XcL7nFclP4RnB3JLIW/hzmgj3lRfWVumdaNtkdsN3VT5sagYplps8=
Received: from DM6PR07CA0072.namprd07.prod.outlook.com (2603:10b6:5:74::49) by
 SJ1PR12MB6340.namprd12.prod.outlook.com (2603:10b6:a03:453::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Wed, 11 May
 2022 07:25:02 +0000
Received: from DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::12) by DM6PR07CA0072.outlook.office365.com
 (2603:10b6:5:74::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20 via Frontend
 Transport; Wed, 11 May 2022 07:25:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT061.mail.protection.outlook.com (10.13.173.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 07:25:01 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 11 May
 2022 02:24:58 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v3 11/35] iommu/amd: Introduce per PCI segment device table
 size
Date: Wed, 11 May 2022 12:51:17 +0530
Message-ID: <20220511072141.15485-12-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220511072141.15485-1-vasant.hegde@amd.com>
References: <20220511072141.15485-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6aca78df-530d-4eb0-ae9e-08da331f5c93
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6340:EE_
X-Microsoft-Antispam-PRVS: <SJ1PR12MB6340AAF09875F20B90479E3187C89@SJ1PR12MB6340.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9nVbFRl3Hu1yk6c7HURCsE3YGnPrllEydwfyuIWB2yry4I0/RZh4xLduwELxjA5l2ETJ6O2iilVdPg1o/Cg7RENwUJQMeN7rHqrm61jEe9GkM+bzylF+wkiSU70WstHVUGcPVlm4eApL++PwqlV6TedKF4/+O3OjMXO0oyHlQFT6TWrNo6jma1tGpHadLvbWTYeAGG08KClS8NbmGfOQrAUa1CVnUV7hi4MhtOTCLJb5A65j6KbmgiGahUdzokKi8wWe2t42H+RPG2AR4tPSAggNiw9fOLYkqYkPs+SLJNEBVxK8LQ5URU7nq05AXLWvfGD20oVhuO/Vw2arjd/0LkK9rMmSwvj5eHtPVjmF4P+JuQg2+J30Yf/O5GAVKiKdQzmYYk2TGAf4DzpcWV/BDp7gMa4IsGxRTqSYYqR+SMRl1By1Hlxn/o9uaXYgDpCYxXSgg3rfovKITD3iKtfa15fg77Faunc+N2AbpS79AQkzW4Ym6iobt3Z3APLgDUH6xUVRXX0pAoCog5aBfoMq+w7nXbhxOa7WLHyCaKAeyt+tzd9MbMsX4rAlxO/WCUHKCRIzBpSzH93cWjXoPyUzVDj15PB9+zABXJnuDcz31Ln2t4eCbidq53//jn+Q61dXIcs2oV3wp7cjo6CzJ3PiAZVh3es8cdOSpU80ZnU+A6hc1CXYgPkt/eNCGcYxahqYi7GZYq85Glu/nwVxNV1o5w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(508600001)(316002)(8936002)(6916009)(36860700001)(81166007)(54906003)(356005)(8676002)(70206006)(4326008)(70586007)(86362001)(6666004)(83380400001)(26005)(44832011)(40460700003)(7696005)(2616005)(186003)(1076003)(426003)(336012)(47076005)(82310400005)(2906002)(36756003)(5660300002)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 07:25:01.5437 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aca78df-530d-4eb0-ae9e-08da331f5c93
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6340
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

With multiple pci segment support, number of BDF supported by each
segment may differ. Hence introduce per segment device table size
which depends on last_bdf. This will replace global
"device_table_size" variable.

Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  3 +++
 drivers/iommu/amd/init.c            | 18 ++++++++++--------
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 8b8079fdf0d4..6d979c4efd54 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -551,6 +551,9 @@ struct amd_iommu_pci_seg {
 	/* Largest PCI device id we expect translation requests for */
 	u16 last_bdf;
 
+	/* Size of the device table */
+	u32 dev_table_size;
+
 	/*
 	 * device table virtual address
 	 *
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 67a92f453731..721154c3bf4d 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -414,6 +414,7 @@ static void iommu_set_cwwb_range(struct amd_iommu *iommu)
 static void iommu_set_device_table(struct amd_iommu *iommu)
 {
 	u64 entry;
+	u32 dev_table_size = iommu->pci_seg->dev_table_size;
 
 	BUG_ON(iommu->mmio_base == NULL);
 
@@ -650,7 +651,7 @@ static int __init find_last_devid_acpi(struct acpi_table_header *table, u16 pci_
 static inline int __init alloc_dev_table(struct amd_iommu_pci_seg *pci_seg)
 {
 	pci_seg->dev_table = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO | GFP_DMA32,
-						      get_order(dev_table_size));
+						      get_order(pci_seg->dev_table_size));
 	if (!pci_seg->dev_table)
 		return -ENOMEM;
 
@@ -660,7 +661,7 @@ static inline int __init alloc_dev_table(struct amd_iommu_pci_seg *pci_seg)
 static inline void free_dev_table(struct amd_iommu_pci_seg *pci_seg)
 {
 	free_pages((unsigned long)pci_seg->dev_table,
-		    get_order(dev_table_size));
+		    get_order(pci_seg->dev_table_size));
 	pci_seg->dev_table = NULL;
 }
 
@@ -1033,7 +1034,7 @@ static bool __copy_device_table(struct amd_iommu *iommu)
 	entry = (((u64) hi) << 32) + lo;
 
 	old_devtb_size = ((entry & ~PAGE_MASK) + 1) << 12;
-	if (old_devtb_size != dev_table_size) {
+	if (old_devtb_size != pci_seg->dev_table_size) {
 		pr_err("The device table size of IOMMU:%d is not expected!\n",
 			iommu->index);
 		return false;
@@ -1052,15 +1053,15 @@ static bool __copy_device_table(struct amd_iommu *iommu)
 	}
 	old_devtb = (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT) && is_kdump_kernel())
 		    ? (__force void *)ioremap_encrypted(old_devtb_phys,
-							dev_table_size)
-		    : memremap(old_devtb_phys, dev_table_size, MEMREMAP_WB);
+							pci_seg->dev_table_size)
+		    : memremap(old_devtb_phys, pci_seg->dev_table_size, MEMREMAP_WB);
 
 	if (!old_devtb)
 		return false;
 
 	gfp_flag = GFP_KERNEL | __GFP_ZERO | GFP_DMA32;
 	pci_seg->old_dev_tbl_cpy = (void *)__get_free_pages(gfp_flag,
-						    get_order(dev_table_size));
+						    get_order(pci_seg->dev_table_size));
 	if (pci_seg->old_dev_tbl_cpy == NULL) {
 		pr_err("Failed to allocate memory for copying old device table!\n");
 		memunmap(old_devtb);
@@ -1579,6 +1580,7 @@ static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id,
 
 	pci_seg->last_bdf = last_bdf;
 	DUMP_printk("PCI segment : 0x%0x, last bdf : 0x%04x\n", id, last_bdf);
+	pci_seg->dev_table_size     = tbl_size(DEV_TABLE_ENTRY_SIZE);
 
 	pci_seg->id = id;
 	init_llist_head(&pci_seg->dev_data_list);
@@ -2674,7 +2676,7 @@ static void early_enable_iommus(void)
 		for_each_pci_segment(pci_seg) {
 			if (pci_seg->old_dev_tbl_cpy != NULL) {
 				free_pages((unsigned long)pci_seg->old_dev_tbl_cpy,
-						get_order(dev_table_size));
+						get_order(pci_seg->dev_table_size));
 				pci_seg->old_dev_tbl_cpy = NULL;
 			}
 		}
@@ -2688,7 +2690,7 @@ static void early_enable_iommus(void)
 
 		for_each_pci_segment(pci_seg) {
 			free_pages((unsigned long)pci_seg->dev_table,
-				   get_order(dev_table_size));
+				   get_order(pci_seg->dev_table_size));
 			pci_seg->dev_table = pci_seg->old_dev_tbl_cpy;
 		}
 
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
