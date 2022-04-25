Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD1A6C433EF
	for <iommu@archiver.kernel.org>; Mon, 25 Apr 2022 11:42:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7CB1140250;
	Mon, 25 Apr 2022 11:42:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fEGomc6k2DoA; Mon, 25 Apr 2022 11:42:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E9950410AA;
	Mon, 25 Apr 2022 11:42:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9FA14C0039;
	Mon, 25 Apr 2022 11:42:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2D97C002D
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:42:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D217C405B3
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:42:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XHdPryfEJTcE for <iommu@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 11:42:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::631])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A671840566
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:42:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xd66zp1uTgOn8cmv78ErLHzOUYpgN6GchhUti4qMZc1Ki3tT6yr1uVNKhyYouRyNcQ2ji3a7C5ezTxgCKY72EISmzPYmx0y43dZMFXmMTDVs/XeGgHw7FbGVK+d1LPACKcAObYO9nKoh8tXvTuWIXFkqE2pES196ceKdAXfHUvIC7R8DEYovW/1yRjC1UAlBgYT47VfaRLlWwt2r9GcSxx+a3AHlO55a5+Ly/ql3ByURUwdJ+4VyPtPJ0RoLjfRn8LeiWBFrkd6qfczTh6vhnNrz3nyIgeSnINvW1pkw7sFk0meksQL88q1nqDIimBo3cWICuPExamvDVpO3leDNNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s03REyaBCqrYQbt6EENCM2+ZOM9KGRhd09WwDPk8h+M=;
 b=P/ND6i1XrQqWV3lbPQ8UxbNqL1aVa6cGeVwaEUvgMz5MKGygjZpT6knlbM1967hYvp1zPxt1HQ3DsYfrtJIeQWA/nL6g2V9liyFpWwByJ4eroreVCVDpnVOr3NV35JxccC5s2l+wUR78a8FQqlgIGzwIl5bPvfN4ycTw14nzeVK7926PCVC/ZYhVTdkZcqEbIWWpbynBlLTqqY8B3efEjAOYIgK0CKSYnIyekwazQ99BleeQNifQ+fGbznye8Zu4ddAH10JOcjDIMkkBKJ2GfdwVY61/fx6/y7TdQz7o6r+CvFIoo77wTbhPEaj+CUDm8fxUUQC8mKVDRDqekJDWOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s03REyaBCqrYQbt6EENCM2+ZOM9KGRhd09WwDPk8h+M=;
 b=G2AcEjYpuvprrKfj7kdmCsDba1Gm2iNZz9fWmqX3koDQyOOVhpt7A/EehpL3m0hs5NoowncGX2JYf8QTSJLwxmvj2/Q/GT/UHvAiUhZgXT4u1aFq0hnIYD76mA7IUc/ZPygNtbyvBR5SBRiN7QTc8ihck0EZYiGFVm3egmmhXHw=
Received: from BN0PR04CA0120.namprd04.prod.outlook.com (2603:10b6:408:ec::35)
 by DM4PR12MB5135.namprd12.prod.outlook.com (2603:10b6:5:392::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Mon, 25 Apr
 2022 11:41:59 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::af) by BN0PR04CA0120.outlook.office365.com
 (2603:10b6:408:ec::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Mon, 25 Apr 2022 11:41:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Mon, 25 Apr 2022 11:41:59 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 06:41:57 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v2 28/37] iommu/amd: Remove global amd_iommu_alias_table
Date: Mon, 25 Apr 2022 17:04:06 +0530
Message-ID: <20220425113415.24087-29-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425113415.24087-1-vasant.hegde@amd.com>
References: <20220425113415.24087-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db04fa44-df5c-4cea-e641-08da26b09b8f
X-MS-TrafficTypeDiagnostic: DM4PR12MB5135:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB513570967EE2186B7C5A5D7487F89@DM4PR12MB5135.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZDmP6T+7XMdYlvetMSI7GNPeI79ntlHsn0oJbL5rumpWLIaEckb7cBRQaGhzM7r07WYzX1eV0iBF+jQqacheIiehC+hOQXUAeajnidrNt7oVEFMLcTG5lq3Td3HnDuRi/h72mWiijCxmtaRG93PBgYv7B5cflgVtzjdXS38Eid5rDtk84sgL2pVDmS0jLEL1ZAnZ8wEskOIP3oVhd3u48avDEeQvyfGrb7uC0Ve3qJA6w0QsiPdwMFMUSVlrURVANtxwTR8S+EAay0QMQz2NLljsVJ/H/eIG9sAn260nwlTdgCS390c01zbjCWUB2f5KFr5DAeoJVR/KEiLSq7lb3YB3oGXtZqDC8fbVohU3DvFhEYEnh5ur9TjVrH4mtviYXPixAbw5D3hhg5XtBMErbHownNflMp62UJnB5d6d+kVsEjUmm2Wqz/ZgRf4fppP38TjqOkRC7vcUsW5nPnH821QlAMyDzP+OrDhYnUp2pRnYZ6MgrVe1fQmEtkPIarHorSca54YRgS7Zjn0JaqE7N1+p64daqNf/753Jb1STR54hbHGmpoaJEmAJdinGybwH+8TNbO85G0qDmsum4qcNrc00Iz19gJTx5h8bxuf6p2XRFLk+UFV6mJQ0fosOQG6nFGXC57FCNpnjAR0qIbnswGdFSw0RpM5uVdBpJhh2ooyP2kbBlCmUdO1UwWuUvU5QaK1IzXkHRejZrw4Yw3KUHg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(44832011)(356005)(81166007)(36860700001)(1076003)(6916009)(40460700003)(426003)(336012)(186003)(2616005)(16526019)(508600001)(54906003)(6666004)(26005)(8936002)(8676002)(316002)(5660300002)(47076005)(83380400001)(4326008)(70586007)(70206006)(86362001)(36756003)(2906002)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 11:41:59.1720 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db04fa44-df5c-4cea-e641-08da26b09b8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5135
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

This is replaced by the per PCI segment alias table.
Also remove alias_table_size variable.

Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  6 ------
 drivers/iommu/amd/init.c            | 24 ------------------------
 2 files changed, 30 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index dc76ee2c3ea5..0aa170014b85 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -826,12 +826,6 @@ struct unity_map_entry {
  * Data structures for device handling
  */
 
-/*
- * Alias table to find requestor ids to device ids. Not locked because only
- * read on runtime.
- */
-extern u16 *amd_iommu_alias_table;
-
 /* size of the dma_ops aperture as power of 2 */
 extern unsigned amd_iommu_aperture_order;
 
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index dd667dfb4355..b3905b1c4bc9 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -185,21 +185,12 @@ static bool amd_iommu_pc_present __read_mostly;
 
 bool amd_iommu_force_isolation __read_mostly;
 
-/*
- * The alias table is a driver specific data structure which contains the
- * mappings of the PCI device ids to the actual requestor ids on the IOMMU.
- * More than one device can share the same requestor id.
- */
-u16 *amd_iommu_alias_table;
-
 /*
  * AMD IOMMU allows up to 2^16 different protection domains. This is a bitmap
  * to know which ones are already in use.
  */
 unsigned long *amd_iommu_pd_alloc_bitmap;
 
-static u32 alias_table_size;	/* size of the alias table */
-
 enum iommu_init_state {
 	IOMMU_START_STATE,
 	IOMMU_IVRS_DETECTED,
@@ -2791,10 +2782,6 @@ static void __init free_iommu_resources(void)
 	kmem_cache_destroy(amd_iommu_irq_cache);
 	amd_iommu_irq_cache = NULL;
 
-	free_pages((unsigned long)amd_iommu_alias_table,
-		   get_order(alias_table_size));
-	amd_iommu_alias_table = NULL;
-
 	free_iommu_all();
 	free_pci_segment();
 }
@@ -2923,20 +2910,9 @@ static int __init early_amd_iommu_init(void)
 	amd_iommu_target_ivhd_type = get_highest_supported_ivhd_type(ivrs_base);
 	DUMP_printk("Using IVHD type %#x\n", amd_iommu_target_ivhd_type);
 
-	alias_table_size   = tbl_size(ALIAS_TABLE_ENTRY_SIZE);
-
 	/* Device table - directly used by all IOMMUs */
 	ret = -ENOMEM;
 
-	/*
-	 * Alias table - map PCI Bus/Dev/Func to Bus/Dev/Func the
-	 * IOMMU see for that device
-	 */
-	amd_iommu_alias_table = (void *)__get_free_pages(GFP_KERNEL,
-			get_order(alias_table_size));
-	if (amd_iommu_alias_table == NULL)
-		goto out;
-
 	amd_iommu_pd_alloc_bitmap = (void *)__get_free_pages(
 					    GFP_KERNEL | __GFP_ZERO,
 					    get_order(MAX_DOMAIN_ID/8));
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
