Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E74CDC433F5
	for <iommu@archiver.kernel.org>; Mon, 25 Apr 2022 11:39:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9F09D4109D;
	Mon, 25 Apr 2022 11:39:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TjA_lWbm1Mhy; Mon, 25 Apr 2022 11:39:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2EBA64109F;
	Mon, 25 Apr 2022 11:39:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D57BFC0039;
	Mon, 25 Apr 2022 11:39:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D0B2BC002D
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:39:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ADFAA4109F
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:39:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kjq7vhpg5bJW for <iommu@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 11:39:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::619])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5C0E84109E
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:39:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3NPTlc7r3LTxLDbGdD9IRRFG4nytEz/7C6+3LiOb8FhBiZC84MjcpvJjv3qAIRDbrzzR95g1WdHnuqy8YFV74LMC7ej3m6msyyz5976QCRsD3PGt9T4uxConOZbQR6AZHkCVHp68zGKQaxxR0uRw7wrmc3XcuPn5KYqw5R/yniPY4bkp7F+Bvt3YeQBXufs2k2NGHkNQX1KwnYKseG4HKYs5jnpJzcGOk7qHL4RTLwB0PESZ+sShVnXQhIYBMeAq7QuydGen9kDE9WS3m7JdGUpk+DRRVF0vaNI1XyiKdZreGhctKqEBtJxEpbj70bUGmGwDubpdllSEBA3RQPVhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y23/lgqfSt2NKxZX2Ne1JAbOeXLu66TmV8ZHMqXOqGY=;
 b=CRKL1/9pCupEaoY5O95WE4b0oRfPa3N1PR40plMiOCm++M194qjBYKfZ9Vrz7TsVoSpQD2epL9Tcngl1Sju697wwsNbwh6xlQWb00IoeMIsAnUwEhdu6tIik/xjrTBSUseQ1mtrCo7P6LqvK84ZMMIpJRxsrSXSVBHGZC5YMrknouDAHq84Os75dDgaUvx6H46Z7fz42qe28NwkEY1WjQ3Ok0uzbRKiVX7YMw0RUF1YAnYwiwt8o/x6EQEZBLTG+TwnQsAKNCwdJMZ5hq8bD5+broIBe2suNRrnmqLilMlpwwhjiEIYP3ZdeU6YSYl1mAx+EBG7lEq0k4ooJcetnpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y23/lgqfSt2NKxZX2Ne1JAbOeXLu66TmV8ZHMqXOqGY=;
 b=pg1uF98MF/OffY4Zap+JZyZGics8aHGKPOMZcxfa4jRdvliqNrKYnU/kf2zp7Dlkyc1E8Y8kUK9X2U05Vv7oPzOW7vR1F4C+0k4HjolBAmEUuAwN1k6OqghXvnspF4fQcMcq2YqzY8Q1sAWyO/FNUYekoz+54HfFFAHGmloie/Q=
Received: from BN0PR02CA0001.namprd02.prod.outlook.com (2603:10b6:408:e4::6)
 by BY5PR12MB4918.namprd12.prod.outlook.com (2603:10b6:a03:1df::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Mon, 25 Apr
 2022 11:39:46 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::2d) by BN0PR02CA0001.outlook.office365.com
 (2603:10b6:408:e4::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Mon, 25 Apr 2022 11:39:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Mon, 25 Apr 2022 11:39:45 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 06:39:43 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v2 19/37] iommu/amd: Update alloc_irq_table and alloc_irq_index
Date: Mon, 25 Apr 2022 17:03:57 +0530
Message-ID: <20220425113415.24087-20-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425113415.24087-1-vasant.hegde@amd.com>
References: <20220425113415.24087-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0fdd5757-3e9a-4127-9b5f-08da26b04c04
X-MS-TrafficTypeDiagnostic: BY5PR12MB4918:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4918587B0AA3156ED162629E87F89@BY5PR12MB4918.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JnRLnwmopK1DXd3lV6P3hm1HKQ1XTbWfb/HK7KkUN2tSntsG76meTrvqI/Z4CZncj8G8JdUlMEHv2uxYhlU2MhZtCh6FJmhJ0IFDEcyIvyP+qKF4SHg5jdD5mQsjQXXjFRqTMKRfh4CoQkBkE5djNrbruQzEoCU8/nNDBWOO7lmjhiuPv+eTH+BAIgW4Zqcal3eF51Asz+uR6J3pgwiW0r1Cd7Mx9HftK18mk5zfli2YP5Cm8ZCH0q1J0n1+LC+tQfpFY73VJeYkpyR16zWN8YtFCI7nORiiEfluCwsnU7rmjrc9fdEPKRr4vpwQZPhZesQzpYWVTh4zTcaMJV0iUs/lwb5V4SrAAUzrcBzU1eXdss6sjqxlPBNhON0m82xgPiPTAOpqH/SCElvXHvSVvPqGv5zfM7pSVAby9T1p9boA8v5iQe/cQFpqrGWn3XnANOizrI0HB13CPQmesowrT3x+sm8RiiEUn4RUXXa/U6yMGMnF7ZvXgQyN0Qadthb7ryEt5+offTIpa94a6hHfIg0RlTZwzAo0CeUAhdFMM9CdHo0XQNzqhI133DNBEPZgEwg/aZItBXyvUSj4RizEDOvAyDJUxkM/KOI+Ty7Tqz5CPfd6XdB2c2Of3GkO0JN7o/FiPN5bRJNN/DxOEgbzzvmOJxs2udA9mRTebr4CRgb94IGHUtWaxFYkc4ZnjikBFeLVajS4qmbJAABuh74vKw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(36860700001)(2906002)(336012)(6916009)(47076005)(86362001)(16526019)(316002)(4326008)(8676002)(70206006)(70586007)(5660300002)(44832011)(36756003)(8936002)(426003)(1076003)(6666004)(54906003)(26005)(82310400005)(2616005)(40460700003)(356005)(83380400001)(81166007)(186003)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 11:39:45.7035 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fdd5757-3e9a-4127-9b5f-08da26b04c04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4918
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
index ecace06d61cb..770a7ba558cf 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2812,21 +2812,17 @@ static int set_remap_table_entry_alias(struct pci_dev *pdev, u16 alias,
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
@@ -2882,18 +2878,14 @@ static struct irq_remap_table *alloc_irq_table(u16 devid, struct pci_dev *pdev)
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
 
@@ -3265,7 +3257,7 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 	if (info->type == X86_IRQ_ALLOC_TYPE_IOAPIC) {
 		struct irq_remap_table *table;
 
-		table = alloc_irq_table(devid, NULL);
+		table = alloc_irq_table(iommu, devid, NULL);
 		if (table) {
 			if (!table->min_index) {
 				/*
@@ -3285,10 +3277,10 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
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
@@ -3414,8 +3406,8 @@ static int irq_remapping_select(struct irq_domain *d, struct irq_fwspec *fwspec,
 
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
