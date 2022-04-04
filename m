Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76ED5C433F5
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 10:04:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3B8C340546;
	Mon,  4 Apr 2022 10:04:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FHhv-HHQoqjy; Mon,  4 Apr 2022 10:04:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 160A940423;
	Mon,  4 Apr 2022 10:04:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F3699C002C;
	Mon,  4 Apr 2022 10:04:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CA5F9C0012
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:04:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B6EBF404B0
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:04:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lGLPAvP_ucRI for <iommu@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 10:04:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::619])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F060540498
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:04:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dDexLnXSc+GINcjaeF//sdQfb2JpNdt2F5Ey97CyfYJEEPq+i+8N1qxAtuKsOJy1MKERkHjIYZZYYnxWHMAwLwtduApS+SbmCOscYJx5jKZDxw9iUAo8D1YSD5hKzBCVcSF8W2P7uWTTBgObZxSPZ8ibFQT8BUc2USFjDsCNhsgdjk8/rKaWu+lE0pUeZBAsqoAGY+5cUQ+ZuG5F3jDRXunM7wl2SDDSm+Mi5CMNmsNgorqXDmawdhFUA2EMY9p1SjM1fzHgjWLjLeHusC4WvHpB8oXU6nrnzuutzHFpaJw6/AfPf8kPBp7q4BeC5Tm6yyS0tUYPTYpBZQQuSNO9pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R8bgQxgD+IN0OFY4jVB9lDV6Yz3rl0/4FeTyEiekMjY=;
 b=b7C6K+Or9EZtu+z/ZbIqgS1wxznpcml2qdb5eOdalJ4TW+kAbhe8GIqkJrIwOVv++3zAny0Dxwm9uYQ9OmbHggEFT0as5G5BEvccDJ7D/tlK9rvpHgVrocUWhFkJV9hJtKu2D0OAC5Qeajaddr57OJAgCABL0rgAXNNZrcBo7xv++CQgioUs795ILMA1vowW8e5SHGSahQWuIwOZ/jiLTCYxvtVtTvRFsNbheIQ2ibKdV5F0sU9SmQrQ0YVjfFJLzzp/CF+l68eDppWsoJFBdJPTgDaa65w+lbpK+iGoVRdbaIFXwUBFMFj2gS/ht9fWbAz4d3y3uHALT7rdLfx6Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8bgQxgD+IN0OFY4jVB9lDV6Yz3rl0/4FeTyEiekMjY=;
 b=xmOJhBN2bRiD2jZP+561SCa1+l337w6E2hI/9ZKU8lvJVL08QnWR5s7wSqjgRn388zTRKOa2sofmzUpj2VkJOnT+Qqqn7ptuusPGbMZwz0ZsMWhEK5aDBQ5ciwGVlf2feWYp9QGcfY15N8FousI8/CJjVGi7U9/b1NniV6xC59g=
Received: from BN9PR03CA0087.namprd03.prod.outlook.com (2603:10b6:408:fc::32)
 by MN2PR12MB4189.namprd12.prod.outlook.com (2603:10b6:208:1d8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 10:04:05 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::f5) by BN9PR03CA0087.outlook.office365.com
 (2603:10b6:408:fc::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Mon, 4 Apr 2022 10:04:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Mon, 4 Apr 2022 10:04:04 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Apr
 2022 05:04:02 -0500
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RESEND PATCH v1 13/37] iommu/amd: Introduce per PCI segment rlookup
 table size
Date: Mon, 4 Apr 2022 15:29:59 +0530
Message-ID: <20220404100023.324645-14-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404100023.324645-1-vasant.hegde@amd.com>
References: <20220404100023.324645-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4ac5df4-b707-4a73-d84d-08da16227374
X-MS-TrafficTypeDiagnostic: MN2PR12MB4189:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB418900E18377A73AE0F3B67487E59@MN2PR12MB4189.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9pxLCsA0r7aeyWYLhZscmIiWmex7i71lOB7xEXpWAYyYJ5Tid0AbdvYAqdytnsBp64lRcmAlpPghixMWSCZqFDSy7f4Z9aidC/ielUv0l4wRwC9tol0K/ExJjjWjHVqUP8Xz7/6plNFUyQ9oIqzJSHypuDNb7h+mSVVTdFVWKLTnSk2c2WGW1B67ftvRpAUkQ/vkw5bnNq5Ols7A3aMLHqnb3VUyhuPJolt0nT7EloZItKz3wirn/VVohp8bsWGM9jOxxJU+3kfhwSp6XHOLepd7fBUGOSfWitAGqNtZcW0S3bi1dC/vxLqgwZ5d6Lpv5a76P5GfvGO0/Jxb9uf6YdtA8U2eS8yCe4pPahT6mNj1cNvccV+3JO8OG0/7aOtsVA97I8ES+OSbnLZAVd3JdWEn5mpXI7XcG74TruvY2ScO+vf/zj3DHD4YBhC8yxed/yIydGkQ7gCacHQDHJRXDzdhw4lyrn70uNPA6EfQyPr/kQ4rzSm4R4/Np8X6ANTbU4imwCu8tsqZPVe+AGGYACPUqFOGR2r39hokP4YP4HJB+O7oEykMTWlZLXvTN1NdRi+AvlzswnZoDiLhTb8vHrk/B+mSGU8skbCc6OB6ifVt9JVMnw6yad0je+471UyPYBH09jpVKX+9KG5AuvXmz14AIXbP27UrYMPJlvbPeRPjuEyDn3ugqcO24fnPePVkkUJ90bUleuWQBhzhwWnopw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(2616005)(54906003)(26005)(316002)(16526019)(110136005)(83380400001)(186003)(1076003)(86362001)(36756003)(336012)(426003)(40460700003)(81166007)(47076005)(8676002)(70206006)(70586007)(356005)(44832011)(82310400004)(4326008)(5660300002)(508600001)(2906002)(8936002)(36860700001)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 10:04:04.7458 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ac5df4-b707-4a73-d84d-08da16227374
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4189
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
index 4bed64ad2068..6f1900fa86d2 100644
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
