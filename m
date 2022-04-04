Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA360C433EF
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 10:05:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 76E5D60C1C;
	Mon,  4 Apr 2022 10:05:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cFRTUgJvEXEf; Mon,  4 Apr 2022 10:05:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4E3B5607F4;
	Mon,  4 Apr 2022 10:05:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 37A99C002C;
	Mon,  4 Apr 2022 10:05:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8C14AC0012
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:05:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 699A24093E
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:05:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CHXoBBIi74mk for <iommu@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 10:05:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::62e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3259E4091C
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:05:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GfTOZ0GwFDN/9/c5WYcuBvjiCohsSFEIHoLq3vl20bkTricxsNnu1O5YAbjBaQKTIpIiS9gOlmBHnDBfhAseNHWwD51QN+xwnwfjvO6HuE2Bxs2ATEMYElseki/4HktlRDgD+WUzOuJWXJMWLuc/jBqXvi9Ka1ZH9ZC9BYkons9wks5DXkMc2eycXX9N+20NLOBZNpBWgyqDtpj/gmP6lq1DlTygN8Gozc6GBp13e+TNvnFuTOjALF2UHVqloAyseZVckkieTXuNMUptLiunYcmNNt1BcJThSF/P+duFLi1Yy932KAD4JsgKMlNT6j9HUBflxPKir1XAERJUTxekSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tuL79KpTx5eR2BfxQoMeE0z9iVAEcfcGozoHtzRP3wg=;
 b=kmYfZptuDxMIcRIq7LZYVYi79wsMe2PDDyohysmPd68t/ctuL7jfmfTVqu+goEClwpjH5WAUTrsfpvPgKZGKOkUChd1HPgGaNk/Xt/iFQjFH6oAQoPxo6Hbxvzt/yR9A26k/SiZ+xpYrt4EgeRa/hTMUiLVpn/TK/qchlo36mCB1oGaV23PRrn8WMhuOODjgSn2Bbw+jR4hXxPUk42MV0P27HY2d/+vyRaK2UVgYBkd8Q1DGH98en97ge5G0Lk1Xug6nMNPsZ1a0LZSZzyEqUWGeQzHfUaA2YRNfVFrZ6YMcH7mXmxUCzv6QVvVfeUHDQY/wOcdrD4keQ2L/t/aFRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tuL79KpTx5eR2BfxQoMeE0z9iVAEcfcGozoHtzRP3wg=;
 b=dPT6abhKq84WCDxwb91xN7lGqbdq1ryyeA+1IDREM9fwjEhhFiSqF+q+RralEmut5k9Wa8SHbdUTA7Z7te5pePcfVx6IIfnhWHgsFZmLD9bsZ0Z2AJ6yClD1Q8xttk0RKx/RtmKmkkGe3GwCQ1unfbgc1M5dtPO/heQLUYzddYw=
Received: from MW4PR04CA0346.namprd04.prod.outlook.com (2603:10b6:303:8a::21)
 by PH7PR12MB5952.namprd12.prod.outlook.com (2603:10b6:510:1db::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 10:05:37 +0000
Received: from CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::19) by MW4PR04CA0346.outlook.office365.com
 (2603:10b6:303:8a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Mon, 4 Apr 2022 10:05:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT032.mail.protection.outlook.com (10.13.174.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Mon, 4 Apr 2022 10:05:35 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Apr
 2022 05:05:32 -0500
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RESEND PATCH v1 19/37] iommu/amd: Update alloc_irq_table and
 alloc_irq_index
Date: Mon, 4 Apr 2022 15:30:05 +0530
Message-ID: <20220404100023.324645-20-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404100023.324645-1-vasant.hegde@amd.com>
References: <20220404100023.324645-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa56b52e-5b60-4d82-1b04-08da1622a988
X-MS-TrafficTypeDiagnostic: PH7PR12MB5952:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB59524C295BDB75F321BAAB4F87E59@PH7PR12MB5952.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2VOyXqPSq0J9qsbsvrCUAzenUcmhiLO1QKSw60wMgN8SAGlblquFI1OFdzEREY8mmEDlMLZOoqBgwWeZ/Z3fnRyWLx8VVNY3tjxNg8d1td4xGdlVKJTWhbxbTedXjP4UkZzGa1AjErCcbjuT/nNWIsS1TI+E6wf9IQPFFYH1H/ZXrXHnbmgQ10567779M9s5Ea3ZYmunZ+X6dL18Slt8oSgkHsRvTTK93zlMWyiXS0PJ5FVc84hjcbqsLJjOdTwpQgyXDF9eZfkF7QbIYsDy1/0VZGFkkT3WizTBKKCmhe14/pkAyxJWgjwhr3tH8S625ESmsDPNxHcDEXvtoKDNm+dkOlpn2iSHYfWRXURnTbwYOSFj1jYUB3m8HfOa2cP4OLc8n0Nb/r4Pm6M4oHylfDGu4z3iFQtwgJk/J+cAVeN/FSRxGwSNqWTvQEvXk4wC4luMHKc1WZzwRsQNsyNgHOzMlKb7KsYZv4HgJioLt0XdnkyXJ+lqsprLQIXE4pAGofTCc1lGZDN5Lq4Er+E9dMrn6FHwCM/QHX6rfoC4FH2Uvfuz6Nn4iSePxiGaolWLdnCWLXZZRUn2RyVNn1ypcDp8FVvkTAw+RSTlTWGohuxP2XsFS9xv0SREx1N4xRMpyjWkvVl7yPhzIbaSXsEJgx1VnHjjmv+LGGLZc2OvUEfbSSLTcpflBK1kSJAT2WhXzICBJXrgu3wetuvFsRCBsA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(70206006)(70586007)(316002)(5660300002)(356005)(8676002)(4326008)(508600001)(36756003)(110136005)(54906003)(47076005)(336012)(426003)(44832011)(1076003)(81166007)(40460700003)(16526019)(186003)(2616005)(36860700001)(6666004)(2906002)(26005)(86362001)(82310400004)(83380400001)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 10:05:35.3283 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa56b52e-5b60-4d82-1b04-08da1622a988
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5952
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

Pass amd_iommu structure as one of the parameter to these functions
as its needed to retrieve variable tables inside these functions.

Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 33b69843b860..814b5abe676a 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2809,21 +2809,17 @@ static int set_remap_table_entry_alias(struct pci_dev *pdev, u16 alias,
 	return 0;
 }
 
-static struct irq_remap_table *alloc_irq_table(u16 devid, struct pci_dev *pdev)
+static struct irq_remap_table *alloc_irq_table(struct amd_iommu *iommu,
+					       u16 devid, struct pci_dev *pdev)
 {
 	struct irq_remap_table *table = NULL;
 	struct irq_remap_table *new_table = NULL;
 	struct amd_iommu_pci_seg *pci_seg;
-	struct amd_iommu *iommu;
 	unsigned long flags;
 	u16 alias;
 
 	spin_lock_irqsave(&iommu_table_lock, flags);
 
-	iommu = amd_iommu_rlookup_table[devid];
-	if (!iommu)
-		goto out_unlock;
-
 	pci_seg = iommu->pci_seg;
 	table = pci_seg->irq_lookup_table[devid];
 	if (table)
@@ -2879,18 +2875,14 @@ static struct irq_remap_table *alloc_irq_table(u16 devid, struct pci_dev *pdev)
 	return table;
 }
 
-static int alloc_irq_index(u16 devid, int count, bool align,
-			   struct pci_dev *pdev)
+static int alloc_irq_index(struct amd_iommu *iommu, u16 devid, int count,
+			   bool align, struct pci_dev *pdev)
 {
 	struct irq_remap_table *table;
 	int index, c, alignment = 1;
 	unsigned long flags;
-	struct amd_iommu *iommu = amd_iommu_rlookup_table[devid];
-
-	if (!iommu)
-		return -ENODEV;
 
-	table = alloc_irq_table(devid, pdev);
+	table = alloc_irq_table(iommu, devid, pdev);
 	if (!table)
 		return -ENODEV;
 
@@ -3262,7 +3254,7 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 	if (info->type == X86_IRQ_ALLOC_TYPE_IOAPIC) {
 		struct irq_remap_table *table;
 
-		table = alloc_irq_table(devid, NULL);
+		table = alloc_irq_table(iommu, devid, NULL);
 		if (table) {
 			if (!table->min_index) {
 				/*
@@ -3282,10 +3274,10 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 		   info->type == X86_IRQ_ALLOC_TYPE_PCI_MSIX) {
 		bool align = (info->type == X86_IRQ_ALLOC_TYPE_PCI_MSI);
 
-		index = alloc_irq_index(devid, nr_irqs, align,
+		index = alloc_irq_index(iommu, devid, nr_irqs, align,
 					msi_desc_to_pci_dev(info->desc));
 	} else {
-		index = alloc_irq_index(devid, nr_irqs, false, NULL);
+		index = alloc_irq_index(iommu, devid, nr_irqs, false, NULL);
 	}
 
 	if (index < 0) {
@@ -3411,8 +3403,8 @@ static int irq_remapping_select(struct irq_domain *d, struct irq_fwspec *fwspec,
 
 	if (devid < 0)
 		return 0;
+	iommu = __rlookup_amd_iommu((devid >> 16), (devid & 0xffff));
 
-	iommu = amd_iommu_rlookup_table[devid];
 	return iommu && iommu->ir_domain == d;
 }
 
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
