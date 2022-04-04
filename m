Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C8AFC433F5
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 09:46:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C833B4002B;
	Mon,  4 Apr 2022 09:46:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7HqTe8qrofgF; Mon,  4 Apr 2022 09:46:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 804DF40183;
	Mon,  4 Apr 2022 09:46:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5533EC002C;
	Mon,  4 Apr 2022 09:46:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 71CDFC0012
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 09:46:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 520D782948
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 09:46:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZsFBf2AU0CEi for <iommu@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 09:46:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::627])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9B898823A0
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 09:46:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0/FZnHn7kqpiQl3XeB9mXVUoqss1zr+A6UDGAahLlQH6iMR2ZweNlrATtAcligk+GAHpaeu2Ba3rg7oW3sGijUCeAmlVsUQ2lFOVeYH/N37CVzCJhJ1x/emVZovZ+V/65SoWSO3kcZu4ZxahdvVhR3nDWld4spLg5xr9hUqJddWnVuaJRbRVtWKLNu6Xse5tJSFUAt90pFR2ZX2Oq/TPuJz6VCn/OxIbnMQc1Hdgj/zQ3z2qGm5O2lbsgvUvCYSzSmThptKRWkgv3m/aJZ5SIuhb6TYumo2rrXIBZFSsEoXs4R/uHsLbXI+tKKr6cKRxgK1Mz/+WZaba03v0OPY8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R8bgQxgD+IN0OFY4jVB9lDV6Yz3rl0/4FeTyEiekMjY=;
 b=h+xUIXG0/8dRK8BJukG0mQi65nhPygsaJBDGiuzZhDbUw7y1xi9RMNL/ldMjgHFDLojKCuP36Wr8OF8T5viPHWqAjZh7qlfxR3231DM9xs7HhAhd0s3hpyqr6M5LIEuzdGYQOGv/vLTPuimoH3f+RYKHyBOmWA0zeOXEequ46GoT+6yQDpb7ITK9T5pAfW40A98S0gw5xz7ZrRUgWrBpxULRem2Zp0lMbYa8dVR7T+UdnvLAI3ws9kNM/nQ5NlHEHWLFBi8K7FSD7rWAT9M+uDd4L52/cihtzyc7uScQ8EbyidjwFqNjNXLKc0KQ5hmn7gGLzwgHfYQzVktC6cYqww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8bgQxgD+IN0OFY4jVB9lDV6Yz3rl0/4FeTyEiekMjY=;
 b=0SwDt2OKCi7kgAxCmkHqxgD20uACyPtMkXKU4K3PZuz3NfQaVEn/bMg3dj8ZUyZXjKwwXa25XOOVhvl092H9IO3+Q8OACBK8cnewt746FWtmJHSDIQkRE263PwQ8P4QVZzXKeCvbTEzZIuajNRjAmLFH7Qx6QWkHM5/dgLqMKmI=
Received: from DM6PR08CA0024.namprd08.prod.outlook.com (2603:10b6:5:80::37) by
 CY4PR12MB1591.namprd12.prod.outlook.com (2603:10b6:910:10::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5123.31; Mon, 4 Apr 2022 09:46:34 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::a9) by DM6PR08CA0024.outlook.office365.com
 (2603:10b6:5:80::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Mon, 4 Apr 2022 09:46:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Mon, 4 Apr 2022 09:46:33 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Apr
 2022 04:46:31 -0500
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [PATCH v1 13/37] iommu/amd: Introduce per PCI segment rlookup table
 size
Date: Mon, 4 Apr 2022 15:11:05 +0530
Message-ID: <20220404094129.323642-14-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404094129.323642-1-vasant.hegde@amd.com>
References: <20220404094129.323642-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ffcf781a-850f-4597-31cb-08da16200112
X-MS-TrafficTypeDiagnostic: CY4PR12MB1591:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB159100BD564EA9005BD5761087E59@CY4PR12MB1591.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S3UloxNzDBasup4BGIer7oGaVvlfEuALnDmPyvaMb65c+LISyvMfuhxmdfvTp7Ihg6K4gE5gj66UxCHCpsMSUN13yWhg8lAzReJtCS+IFEzGUJDL2GeINO19vpknqQWlixykkY6C76rqB2j0ShmgWKgSrIacHx8DfI0mVwx7yoqEbd4NjUq5YqJvAWYbcgqdDyd+9MyfnbcazTp6Rk7LPAyK4IztzmGzcGwkhGapBjQPSxU2/noQcK6t92SCr/LSUFW/2wjwdqawBM4XrUfZtUMMdy+QzkT9dDZDpjOr6oEe14T/KuDZMHtGsYMhT2setraIOXED0dvnMdQfVjHV/opxu95sf6Q+32ebqCxjY4Qt61ftj2joIj9bM1DdUKw4Bff84kFvo/67AiSV5m6MVH26A1AianOIFY+kH8IX5MipBrfyKqXc7NZ6fRm6x8mqUAt7mEonNfktFHQgQQNiBmXRkszuhzhXbu8TPFZvdIAQScfN2CZAo6YWwvToo76fG0w2TdsiNEyfnNlfLqV5vg1q6APq/t8s4vuNmJROo+cJ0/n+1NcSOutzAYuqaVIqCxgocBoyFHbLyH2GrH8RJq+gsiJ/z8eUgabQcHMtERHWgwqU2HJQMUiWLmrqnGZoMdxjg57tW8XI8ah9uxz+HzomsJzdxFzOX980SwGW9VAchKqPLhYOGQhzNE8M/AQMvB7SJY3SQTqw8WvULY9yWw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(86362001)(186003)(8676002)(16526019)(4326008)(1076003)(70586007)(70206006)(26005)(6666004)(44832011)(83380400001)(82310400004)(508600001)(5660300002)(54906003)(36756003)(426003)(316002)(47076005)(36860700001)(336012)(2906002)(110136005)(81166007)(356005)(2616005)(40460700003)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 09:46:33.7986 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffcf781a-850f-4597-31cb-08da16200112
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1591
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
