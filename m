Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F98C433F5
	for <iommu@archiver.kernel.org>; Mon, 25 Apr 2022 11:38:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A985981ABB;
	Mon, 25 Apr 2022 11:38:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id al2NHTRyTb7F; Mon, 25 Apr 2022 11:38:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6CC5C81A8E;
	Mon, 25 Apr 2022 11:38:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 41A22C0039;
	Mon, 25 Apr 2022 11:38:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5325BC002D
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:38:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4107B60C0D
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:38:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fA3A17lKUF0q for <iommu@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 11:38:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::612])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7093A60B2C
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:38:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bCvpZHUDr4d+geYXW13Owj9bdHuCE7cvuXs74ZhNSg6jEEYeyyE3joXX3iP6Gp9BiyLEzvKKr8FP07VvDmLTOHdnsp2ZHOCx+uYDGgdB3gFI4aVM6+sHh1Usa0EjW6zn88c18C2EiI+L7JP8AyVAnOgZzdubd7yRMQsqlU8d2d9HXjY1YOzVZwQ2Gu5ve6Uj/STNv0+wQxk8rPMatLf3zKhOSaIEh6AKbkb3kn5KbLA1D3nIzHhJ5Hwm6GLHY9oSbDw90Zz8vtr5IOyMQTPwhqmqFdVgBa42+6KeTB48cuPy0quWFI3+PZmJac63zoTseyx/7Vxdm0kwKPVDo82qdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R8bgQxgD+IN0OFY4jVB9lDV6Yz3rl0/4FeTyEiekMjY=;
 b=f6vSiosTbdUQi8qx/rlxEWlvGC4yVeIb/NV/OTDqNzxmiv0vxFG3y9idSqnITNAI9DoBCDcGwRfYg+leYX597z8m7iUAgPr16FoFjDEne+czMcLuK8aHdEbtF1kO5ulJsD2I8PvO3FU3evz2EUC0LN0HtRr700bv9CXVMHkpZQI1/7PRuMuP89ryXmMNZTYbx+Kkqjl+VMeMo0HPQ+SMkbUk+ITzcrAUnCRmmaOZ8P7fA0t9+U/Wj/KGbW5GiKGXHWLUMeIjS9rsKVKsnNLzs4SKKFYziuxtlAxzL36LOzc2lAdHOlgSE91SzjUM0l4ZFs21odKAwuzpqPsCtp/ugw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8bgQxgD+IN0OFY4jVB9lDV6Yz3rl0/4FeTyEiekMjY=;
 b=3VZLS0oa30IrHvmKYaTVGJjPP2JX/er0jJZY08u+fZelpJ9qbqTHo+OAgul5r/fRt+fHkaP9PXggg3VC4dES/2JNTg9mjVFw/ElniuFT1k3mouqoe9SIfu3En05uW7l0h8lhRgJBnvmji0naIeTRlGuEsWwMq4gddJm3MOJyS1M=
Received: from BN9PR03CA0216.namprd03.prod.outlook.com (2603:10b6:408:f8::11)
 by CH0PR12MB5385.namprd12.prod.outlook.com (2603:10b6:610:d4::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Mon, 25 Apr
 2022 11:38:16 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::4d) by BN9PR03CA0216.outlook.office365.com
 (2603:10b6:408:f8::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Mon, 25 Apr 2022 11:38:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Mon, 25 Apr 2022 11:38:16 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 06:38:14 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v2 13/37] iommu/amd: Introduce per PCI segment rlookup table
 size
Date: Mon, 25 Apr 2022 17:03:51 +0530
Message-ID: <20220425113415.24087-14-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425113415.24087-1-vasant.hegde@amd.com>
References: <20220425113415.24087-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 924dee7e-4965-4062-1757-08da26b016d8
X-MS-TrafficTypeDiagnostic: CH0PR12MB5385:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB53852816C140909DF270E36A87F89@CH0PR12MB5385.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lhdSTlxf7i5TyGrlTHJJv4MT6hcsPdi7SMVpHpIGLgpF1BKf8/ZaC9Y5tTw7bXvFo1gwVdnLB4xW8W6tUpn+N2WVxsrwyQQhmsEJSkp+Yok8r476GqG899UcYXz7cnfTLNFFFAKhUM83/MvNPpygfX8u4K2oypVg45awh1q1536/3UlfhN3a0FnEbR71/Bwc233hFcdNEbij+I+blFqzbrOtFcu1vtvbPzbAE5kXpLfIGaP+Ar0ggiWC5bc0mKROxAl4aGM+6qcKRBWk6dZyCj8sOwQSCTkqSSgQVszTK2/XbMeOdQgfa+Svc6lv3Veu2q3I6DNFUjumWUkfFqEwnYb5vrT3+HDAWYKi2AIr11UyERxeTnoQv4gjFpOVECkPBzjib1L6vywGkWZyO8fC/7z7GRHxksp/IacbA661ynJEjYlARTQVw15h+SP9uf8U21hoVtSwSziK48cI2pbnCht/qCgBXe1zh2S20PsKObcoUgl3ujPTyoF2thoLNxo5PSRnzIZW8/9Ji7OgI+Tx85j53H5ZSuqVHo3kqsuhN+jxousFTAOz3d5QskSE6yXVJpuacVrxuiOjLInf8v9EtmAmDEk3+mZcX++PavrTjeFfPqbdy+WGP5WOgul5JAlb9ugr9JB+9JFMs5hVXyfrGzXOpb9G5WWEGqNtK9OLqX8N7+MdizaKHqfT2wNYZ/tgrXmHwH8NL/8sF3leDGEZ1g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(8936002)(1076003)(40460700003)(508600001)(316002)(36756003)(82310400005)(5660300002)(36860700001)(47076005)(336012)(426003)(70586007)(70206006)(54906003)(6916009)(16526019)(186003)(8676002)(81166007)(4326008)(86362001)(2616005)(2906002)(356005)(83380400001)(26005)(44832011)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 11:38:16.5081 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 924dee7e-4965-4062-1757-08da26b016d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5385
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
