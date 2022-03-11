Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D3FEC433EF
	for <iommu@archiver.kernel.org>; Fri, 11 Mar 2022 09:52:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 018B0418DF;
	Fri, 11 Mar 2022 09:52:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X1sVwIaZF2j3; Fri, 11 Mar 2022 09:52:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B3F2E418CF;
	Fri, 11 Mar 2022 09:52:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9BCBDC0012;
	Fri, 11 Mar 2022 09:52:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE9C2C000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:52:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AE3FB611D9
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:52:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MvNC1f_fxkF9 for <iommu@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 09:52:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::62a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 80815611EA
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:52:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZLcWp5jzHiX6LbWI80fchdQAjpuCshYJtrRPTMWj9vfhMylELfocu/c0ONtPOiadIZjRiptdEtvbLkEziniFSQ1lN5JZJPR+MnqPYKoyrcvkM8E6j1rtekEjbNPSXyIkC44+oX4RTF40M9iVdNZ1IZ2tYswYf/qjP4ekYqb7PoWSGV/A0urgieuXzORE7PadKVptBoduvti7rNBY/rKk7jLs3kbY+a/8xeIrDoQQmKhHkN17n1Bjtjxu3YWwKH3xDBJx8+bgGfwlUJb6tIIPBa5aqx37zwmN85OsVRVni2H3VLK6pHlR8o9tlK4+pYtojEUH1tqA5ONcz4vVZFtJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j0nkYIDpR1mLLHoLtd9VDDluYIOWci5q/9elRMT6Mw4=;
 b=X/bKQ/PnweGpGM5cGOjm+S6/kYMseivEOZei8L6FfkZlbcKKssjWBf9rMIrsdHWN81JijI3dXyhPuHhK4+KfeJI6Pbl0BxFv7kfK4nh1/nZGM9SLFsJRAeTE1n0ut2O0YI1g61tgCJs+qNXdDcUW6OS15919SBo1aKwWHdUMQa2RR5fONm3bs1SuuPOKaWilLaPdgLcS38Mfci/YHPot3QLKsxGbS9qdxSuICTudKHisjdbAJ6MBxuWvRDBsCakWtRhITFTR/EqV/Vp7hmY+0nh4ZLibsEFO0AAQfaK3VmE2OdgmBdJvkkoGASkNUGyZfRMoU/Z06Y2WaYL2iJYePg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j0nkYIDpR1mLLHoLtd9VDDluYIOWci5q/9elRMT6Mw4=;
 b=vCXtox0KDIUAadzWfygakKWbjRqUW/cmIv/UgIznJDWBAaFZpM+crV2zbZDSjnVndEjTMjWUd7+rXAAsDhge/JtG2kbYNKr/WSpK1kdbBeozAkqixU/N2xLuTUROoWaMratxOa4bioermrvIXBP/x3bd8DHhl9fHNKYR/goJ5H8=
Received: from BN8PR04CA0021.namprd04.prod.outlook.com (2603:10b6:408:70::34)
 by DM6PR12MB4563.namprd12.prod.outlook.com (2603:10b6:5:28e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21; Fri, 11 Mar
 2022 09:52:46 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::c9) by BN8PR04CA0021.outlook.office365.com
 (2603:10b6:408:70::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22 via Frontend
 Transport; Fri, 11 Mar 2022 09:52:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Fri, 11 Mar 2022 09:52:45 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 11 Mar
 2022 03:52:42 -0600
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RFC PATCH 12/36] iommu/amd: Introduce per PCI segment rlookup table
 size
Date: Fri, 11 Mar 2022 15:18:30 +0530
Message-ID: <20220311094854.31595-13-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220311094854.31595-1-vasant.hegde@amd.com>
References: <20220311094854.31595-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c733d7ec-49a6-4293-3a56-08da0344e4a3
X-MS-TrafficTypeDiagnostic: DM6PR12MB4563:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4563EB7268CC11CCA4C91929870C9@DM6PR12MB4563.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XTT0UBm4TGCZTDLFvJjic3AX1AimOXS31MenEgTNqtDJcQX63fIVM0bu3m/GHye2Z5WkAwg3zman2wNmvkfuITX+kHpg681XDp6jS9biqh4EhV9dJDEqYx4uM0Svnow/iiL43oPecrxRf9EWfxT2J1boReYbjasIfSm/UkckAprnDgrAChvO5oWQOC+QsCJO0tPxoXdOepE8I2Knn+28Ycy23LCtNRU8h6eqxdHRJ/nmTDd9/ohoxIsPL27qI7g9TYSy3ouwYhv7Yb1ROeN0Ypv0qvIKzK8VRjZCoxGtdhy6byZ9gbwaLU88oc3cBBJfiYJs+gH2jxxRDu26SOknquNNo69LR996hA4DRpCOnJHgMNhk/wximh04tD/uXeGKCTmgIT02jGy92sEDp56oovzHqCRd/ZK3SvVyOpEKhPwnCclIEaHR1Q/Hjcq+Tn6FBBRfrPXPN2hBY9Yl3oUdeDk6BbeKMR2x7pBvKWnc55l45g+Zdq1Gxn4RLaN9Ql2Ot+L3cAh2zsPK7AwZOJczrYIYr5gQOmvqUoBVLUNqxJyX0Po5MXZAzt2GKczgPpnCYaOzEDJULRGMQ1cooGYdewF00FUJWz90W6Uiod+y9uF87kxEfJvhUiEy7iNUI/J4kIKpI40pUpP1Q+kQp3tINqboszy4WLUROQdh5VuyxWFz/IgivAKFfI2N4GfOJDKdIYsab/Lfj6cA1tLE2BUP7w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(16526019)(8936002)(83380400001)(44832011)(2616005)(1076003)(426003)(26005)(36860700001)(70586007)(81166007)(82310400004)(70206006)(336012)(47076005)(508600001)(54906003)(186003)(4326008)(40460700003)(86362001)(8676002)(110136005)(2906002)(6666004)(5660300002)(36756003)(356005)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 09:52:45.4283 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c733d7ec-49a6-4293-3a56-08da0344e4a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4563
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

It will replace global "rlookup_table_size" variable.

Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  3 +++
 drivers/iommu/amd/init.c            | 11 ++++++-----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index e6ee376b6280..8df736dea1d4 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -553,6 +553,9 @@ struct amd_iommu_pci_seg {
 	/* Size of the alias table */
 	u32 alias_table_size;
 
+	/* Size of the rlookup table */
+	u32 rlookup_table_size;
+
 	/*
 	 * device table virtual address
 	 *
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index d4e4f49066f8..1688532dffb8 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -671,7 +671,7 @@ static inline int __init alloc_rlookup_table(struct amd_iommu_pci_seg *pci_seg)
 {
 	pci_seg->rlookup_table = (void *)__get_free_pages(
 						GFP_KERNEL | __GFP_ZERO,
-						get_order(rlookup_table_size));
+						get_order(pci_seg->rlookup_table_size));
 	if (pci_seg->rlookup_table == NULL)
 		return -ENOMEM;
 
@@ -681,7 +681,7 @@ static inline int __init alloc_rlookup_table(struct amd_iommu_pci_seg *pci_seg)
 static inline void free_rlookup_table(struct amd_iommu_pci_seg *pci_seg)
 {
 	free_pages((unsigned long)pci_seg->rlookup_table,
-		   get_order(rlookup_table_size));
+		   get_order(pci_seg->rlookup_table_size));
 	pci_seg->rlookup_table = NULL;
 }
 
@@ -689,9 +689,9 @@ static inline int __init alloc_irq_lookup_table(struct amd_iommu_pci_seg *pci_se
 {
 	pci_seg->irq_lookup_table = (void *)__get_free_pages(
 					     GFP_KERNEL | __GFP_ZERO,
-					     get_order(rlookup_table_size));
+					     get_order(pci_seg->rlookup_table_size));
 	kmemleak_alloc(pci_seg->irq_lookup_table,
-		       rlookup_table_size, 1, GFP_KERNEL);
+		       pci_seg->rlookup_table_size, 1, GFP_KERNEL);
 	if (pci_seg->irq_lookup_table == NULL)
 		return -ENOMEM;
 
@@ -702,7 +702,7 @@ static inline void free_irq_lookup_table(struct amd_iommu_pci_seg *pci_seg)
 {
 	kmemleak_free(pci_seg->irq_lookup_table);
 	free_pages((unsigned long)pci_seg->irq_lookup_table,
-		   get_order(rlookup_table_size));
+		   get_order(pci_seg->rlookup_table_size));
 	pci_seg->irq_lookup_table = NULL;
 }
 
@@ -1583,6 +1583,7 @@ static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id,
 	DUMP_printk("PCI segment : 0x%0x, last bdf : 0x%04x\n", id, last_bdf);
 	pci_seg->dev_table_size     = tbl_size(DEV_TABLE_ENTRY_SIZE);
 	pci_seg->alias_table_size   = tbl_size(ALIAS_TABLE_ENTRY_SIZE);
+	pci_seg->rlookup_table_size = tbl_size(RLOOKUP_TABLE_ENTRY_SIZE);
 
 	pci_seg->id = id;
 	init_llist_head(&pci_seg->dev_data_list);
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
