Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C93C433F5
	for <iommu@archiver.kernel.org>; Fri, 11 Mar 2022 09:57:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9522A418F1;
	Fri, 11 Mar 2022 09:57:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a5yTGMux20kO; Fri, 11 Mar 2022 09:57:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5AC4841868;
	Fri, 11 Mar 2022 09:57:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 26F4CC0012;
	Fri, 11 Mar 2022 09:57:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E479FC000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:57:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D2D3B418C8
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:57:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pprdlZ-mcndi for <iommu@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 09:57:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::62c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 069CD41868
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:57:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5S41Zp994jitucQRgXoakazpVFfoLoxrF0zMiDbBk2LlnNPwMEKBFFdK6oJzvonrqxBnuRsjAOZUiCMpP5w5nxinHfzy5kfht3a24mnXTOZf6YB130/2HNBfrLK1238BnE+4+4Bmaa6zQJUnJPqQQvoEmNqaAYUdTPPHGbyx0nX4+BAYTR1IeXIeZhC7eo20cB5cd+NknFgtJWo656gn6X9cF9hlXkbJX1rvk0Ad8sKyXjrz24zWaPVAqJDesUrKljdpFlq4aVoX28Q5r3nFrKJIs5SToEmpXqZzbP6Jqru2nZctL0mLOMt4kpTA7cgrOwr5EilIKaBuvSHHUo8bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3DKi1gM4q4SEywRqwBuRKSIDr9Zh/gMvAarw9IVQMp8=;
 b=Hp/RlitMpcc313Ivgz1DTwzD4PNl7VjVn+P9ZeEFYZ9m5Vj+IUekOZ5YD49R/gNE0wIBR5RymUHLXmQS4gnK8hab/azctCaaPdSl0KtBZFTWa1VShgMZB/vOdl+EHJIBOIfj0WB446T2pzNO9yxMJCZf+toOo5JCW3UwtPGj33fKoaELkMR+SYk9/1QP9loe0+dRK84YCljZZsDD3ThYPrZ/lWLTER7ghUw3/r697XzEWKRKy2JB3hoIPW+95p0ABeIbNBvcLGP/rfzKDGF1tgCq6gzNsbm1/L3K8iSfejhnL8Dz3KOSystmhW4Jv4x55uMHMiVLEEse0++G6W4b6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3DKi1gM4q4SEywRqwBuRKSIDr9Zh/gMvAarw9IVQMp8=;
 b=bOiHhoUjRDqi38IajaxXEUodn5TyqTckKMrVlN3uh5TgoIbfjasiU4BRsW1DygPqzYrvkSUH8Mf5j+T5WBolk+HDjzlwEl7qpyA+RgDfk+56Hs4FI6ecmDuvKkRUifRAOQ3YAjkRrIUPsyPOoMwnL0XnQzYe8fVGTEXfbCSp/s4=
Received: from DS7P222CA0022.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::25) by
 DM5PR1201MB0123.namprd12.prod.outlook.com (2603:10b6:4:50::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.14; Fri, 11 Mar 2022 09:57:20 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::7f) by DS7P222CA0022.outlook.office365.com
 (2603:10b6:8:2e::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Fri, 11 Mar 2022 09:57:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Fri, 11 Mar 2022 09:57:19 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 11 Mar
 2022 03:56:53 -0600
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RFC PATCH 18/36] iommu/amd: Update alloc_irq_table and
 alloc_irq_index
Date: Fri, 11 Mar 2022 15:18:36 +0530
Message-ID: <20220311094854.31595-19-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220311094854.31595-1-vasant.hegde@amd.com>
References: <20220311094854.31595-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 598b1b5d-566c-4ce1-472c-08da034587bd
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0123:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB01232B2AD7C10EE977405F54870C9@DM5PR1201MB0123.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UJMKU4wkUlkObkTmgZfJAksLiPfBPOipVpRuh34gngkHDAiaAX5tMuzXJ4uDS1lHl4YoDS6bj89yvo3o/hU9AwdhfaEtp8/dD5KKepaFuFYb9QyqE/OW4GwpcUY8sJmPG4xwxXbdpN9tCmYIfYIDEHcYEZGqqpr/4xRuacQVHG9D2FFLUnkfZR9qPAX2jm7Xlkmq3kfjDoCNPlf7WotDw3+ZXGqwLK6o7IFX3f+14uLPEq3Z732DhpDy0bmW7fApU/UqcCeuMWArTnmIoGMFHlDrBbP+Yptk6/ibnGqozzb767TUPnCY5aZIAuesefBVm83ld37AaI0lLNYzfOT3YKYpHvMZWIYjY6AbtzsqoHX2Cp6925bz4IzZi9sAI6X6ZSQMOH+3/kiR95+iAvUslbj8WarltAVjY8YRurJ68wi+Fe+Rb29SfJ3aCANsquv+IS3WhyWpeXpfHWLNAkkWtWeBU/ii7xn5qZu3IxktiCTlzGDjSKDrhYrAf/850VxnDK1sPm9zZTttsE188HQdZ73Qr23nn5YpcKfpNukYxomHX7XducuAcBNkp1MFi+I9RAJjz5vb98MN5geC39ytLjZp1Af74D0RlgPU344iY/u9vAcuzekCi4Vgz/aV+cTYG78v0bnYENya9DDeOslVgctbPnlm4+V9apTc+5p5GbG8oUsjjZtsx19qr0wmxGqOYuPyp+3r4SeX235ruuMlmQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36756003)(8676002)(2616005)(40460700003)(26005)(82310400004)(186003)(16526019)(70206006)(1076003)(70586007)(316002)(5660300002)(81166007)(6666004)(36860700001)(8936002)(356005)(47076005)(83380400001)(4326008)(44832011)(86362001)(2906002)(508600001)(336012)(110136005)(54906003)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 09:57:19.0208 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 598b1b5d-566c-4ce1-472c-08da034587bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0123
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
index 98484b190869..d5fecca5a547 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2805,21 +2805,17 @@ static int set_remap_table_entry_alias(struct pci_dev *pdev, u16 alias,
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
@@ -2875,18 +2871,14 @@ static struct irq_remap_table *alloc_irq_table(u16 devid, struct pci_dev *pdev)
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
 
@@ -3258,7 +3250,7 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 	if (info->type == X86_IRQ_ALLOC_TYPE_IOAPIC) {
 		struct irq_remap_table *table;
 
-		table = alloc_irq_table(devid, NULL);
+		table = alloc_irq_table(iommu, devid, NULL);
 		if (table) {
 			if (!table->min_index) {
 				/*
@@ -3278,10 +3270,10 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
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
@@ -3407,8 +3399,8 @@ static int irq_remapping_select(struct irq_domain *d, struct irq_fwspec *fwspec,
 
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
