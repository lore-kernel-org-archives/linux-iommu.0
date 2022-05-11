Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E83C433F5
	for <iommu@archiver.kernel.org>; Wed, 11 May 2022 07:25:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E74C54056F;
	Wed, 11 May 2022 07:25:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XjtZg-Dzlksp; Wed, 11 May 2022 07:25:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C4820404F0;
	Wed, 11 May 2022 07:25:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9EC31C0039;
	Wed, 11 May 2022 07:25:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34EDCC002D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:25:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 14E67415CD
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:25:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cweVZUnXSDqS for <iommu@lists.linux-foundation.org>;
 Wed, 11 May 2022 07:25:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::622])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 083F4415A2
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:25:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ftMNn3oYxbH8U/l4ZOOvPhQ+wvu9nja2s/vJAqwo8ufRFtm4TL/aIqF99V0RuuUysJzIYWRXBeqGtCbQe2vpt/7SCfsh1v7R+UtiRw+XMblK+omz3RJHKMlq0r0PdzSJOYxqgGpZeJHiL9FC9OwSGegTIkk5m4wg1xErPKnMhsrXI+8lbqDEt4pwr40pxmRh5eq56HlXXi6nVx7Kr7wHlEqsI1rXoogI3vnPvHJXnKbVhhV4qHCH2KxcDMPjy62U60h+MbfT/qUN1n6aQ/pylup+AM5l9pW0W+D4A5gFYLp5bcTtO7XlhU0OYJpBP/7rs7Da3N7Va/bO/M73AllIvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2kKA4SdIHJkIwONf9GI1LrLGCJcT9d2ojWkA+MrD7o=;
 b=S21DFQlfWSZI0rdbpooLMokcexv3175xkgBwVaeKmy5TRftGPmWuSWar1N5Laf+5auDv3rsPd2XaASPtl1kugdQYH9p1rV/MvMMgPXE4AyfX87gFfAhllRsqYN6KSyxshDWp8M5lTmVeMWxELoTvPt7torU8mJW/XMmSyLolPD08BcXyKPDSv3Atln+Qd2A3HCLA4E4U8Ze48PR2RZRuJ3jons+2ISaLzysA1Q88u2XrNp6jLR4wJMPVF0KFNN3VjNoC0PJ7tmTgzF9WnjzmRKBqbPOrLhNX2xj5TD1qyq3RoIGb3cYCDrd6hLi8UwOQro4CviuQGjmrdMV4jsdEqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2kKA4SdIHJkIwONf9GI1LrLGCJcT9d2ojWkA+MrD7o=;
 b=mcIQl9wpuUbnic+Ql1ynZv14n0u3Z0mBGj8VbQXF0YMhuPETYgQ2n19S1uep0hENr5uLKIoFzURl7mO4VoGbd22CfqZK7WXrw8QELknO0p2TCRchOhxZA3rSNM3scIazyg2fu4fXtVEXy/m8XnxrYQzHaBFAWGdavnAunneQ3Z0=
Received: from DM6PR08CA0022.namprd08.prod.outlook.com (2603:10b6:5:80::35) by
 DM5PR12MB2344.namprd12.prod.outlook.com (2603:10b6:4:b2::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.23; Wed, 11 May 2022 07:25:16 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::55) by DM6PR08CA0022.outlook.office365.com
 (2603:10b6:5:80::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.27 via Frontend
 Transport; Wed, 11 May 2022 07:25:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 07:25:15 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 11 May
 2022 02:25:13 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v3 12/35] iommu/amd: Introduce per PCI segment alias table size
Date: Wed, 11 May 2022 12:51:18 +0530
Message-ID: <20220511072141.15485-13-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220511072141.15485-1-vasant.hegde@amd.com>
References: <20220511072141.15485-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29fa470a-d652-4d4a-84a8-08da331f652e
X-MS-TrafficTypeDiagnostic: DM5PR12MB2344:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB2344F68D0D20B54A2087EDDE87C89@DM5PR12MB2344.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rODGCKHW+/Vb4MGCizanspU1XRgjWuUfVE7+kILzhjLC7u6lLsPA3GfhbJ68wtMrUpjZ97WWQRk0psn4rGBXOkmaoLLek8rFAhV8OtTsy1oUDMqIi4VH7d/CwWoXzfrcI3p5Niyyq1iXE7Zph89vb/8dsC7lX3HyyqS4walvvEbksz+RfTm0UKCxTaRHQYb8x+YSyXLxp4E7lFnzn/pSh+4sPVqWyo4ahQK8TokXaZcd4xqQlOovy4mOWuq9WR+ADb3D4wF8Z301NoFJ53ZGNPgII4qPRCket/FzpTTva1BzGfO9Pp/nNmm3KWtJYrjETfNVbeF1Tv+dgy8QA6gyKlLMKiVueAWxXCqpD6h5SialWtVdwq/v4XX0JWMSwE7JwafJHC//WURHXVbrtU9ZW24ad+/gE3LaT1TROdoXUeulscO9a/982kvX+UB0tatnlHt18CgW8o2XPdIHZQOz3K1+ly54SH9vkgJ4vw8msQBKKff7zt8W6C08zoCTCNBMqkPRDmQlQY+kJfJN08LNSdK9FYncY7n1cVTvmRmhpo68+Rt0kE126LH/cwDt8kRAA96v99YlzlESbwUhsRSzK54sHwb8oJI2rhRRQDKMpPV/Cvq5NLoXypJkNYpcf8aOLbcxqQJQA2uzPMe+qJ/4rDSawYUrBHrgVgegiHSmYfwtQ/2BGhIhMLCqy16ZBaE1JJ2Nb2KqqSya8aVRyXdOqg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(7696005)(16526019)(36860700001)(186003)(83380400001)(2906002)(2616005)(26005)(44832011)(1076003)(36756003)(40460700003)(47076005)(336012)(82310400005)(426003)(356005)(508600001)(86362001)(5660300002)(8936002)(54906003)(70206006)(6916009)(70586007)(8676002)(81166007)(4326008)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 07:25:15.9802 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29fa470a-d652-4d4a-84a8-08da331f652e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2344
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

It will replace global "alias_table_size" variable.

Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 3 +++
 drivers/iommu/amd/init.c            | 5 +++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 6d979c4efd54..4912e1913b96 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -554,6 +554,9 @@ struct amd_iommu_pci_seg {
 	/* Size of the device table */
 	u32 dev_table_size;
 
+	/* Size of the alias table */
+	u32 alias_table_size;
+
 	/*
 	 * device table virtual address
 	 *
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 721154c3bf4d..0d9126a92cff 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -710,7 +710,7 @@ static int __init alloc_alias_table(struct amd_iommu_pci_seg *pci_seg)
 	int i;
 
 	pci_seg->alias_table = (void *)__get_free_pages(GFP_KERNEL,
-						    get_order(alias_table_size));
+					get_order(pci_seg->alias_table_size));
 	if (!pci_seg->alias_table)
 		return -ENOMEM;
 
@@ -726,7 +726,7 @@ static int __init alloc_alias_table(struct amd_iommu_pci_seg *pci_seg)
 static void __init free_alias_table(struct amd_iommu_pci_seg *pci_seg)
 {
 	free_pages((unsigned long)pci_seg->alias_table,
-		   get_order(alias_table_size));
+		   get_order(pci_seg->alias_table_size));
 	pci_seg->alias_table = NULL;
 }
 
@@ -1581,6 +1581,7 @@ static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id,
 	pci_seg->last_bdf = last_bdf;
 	DUMP_printk("PCI segment : 0x%0x, last bdf : 0x%04x\n", id, last_bdf);
 	pci_seg->dev_table_size     = tbl_size(DEV_TABLE_ENTRY_SIZE);
+	pci_seg->alias_table_size   = tbl_size(ALIAS_TABLE_ENTRY_SIZE);
 
 	pci_seg->id = id;
 	init_llist_head(&pci_seg->dev_data_list);
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
