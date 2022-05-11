Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6173C433EF
	for <iommu@archiver.kernel.org>; Wed, 11 May 2022 07:27:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 83B3C831DA;
	Wed, 11 May 2022 07:27:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8ApT4VaQL3jP; Wed, 11 May 2022 07:27:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5F08D831DE;
	Wed, 11 May 2022 07:27:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3BADBC0039;
	Wed, 11 May 2022 07:27:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 864C7C002D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:27:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6783C831DA
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:27:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RNsNCrqHaRFk for <iommu@lists.linux-foundation.org>;
 Wed, 11 May 2022 07:27:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::604])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3FB5A831DE
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:27:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JYddhGBawSyKtdKNeF2gBZdxOxmK+AgdV92YEBPApNLXFTFiuGPCHpFLWQdgQr5ORuvmx5bPTUVDQHP1oQc9LNhHd9zbVKNVsXThIbJGicf8ma7MAnBG33Dr3I0u7b35bhs1d2N8BxVH7YE16pRfR6U2jiIS36u/gLN33MfhGyxaZqEv6YarNc796klvrBtpsZ5xeJbJr4hLJDFGe053e16TRTUtTV93nRlXRgLzL1pt0yjcLGXSEBkfT+7OEBWHA47KOZkhnURud7UwgoXn0jbeBxx5Lch7LKPVklHCsoGrXx+vG+xUDGQlOYNN5l/ljV6w2nDp/NKt1IBSBZ1qKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3kn8vbOCcdzWNZwZpDniFblI5dWCW2hRrYq9aH9GH8=;
 b=AVbpadzqE2ka9RBFxpZ/AckX4Fdx+NDzYO0dzjDxBwdqH/C52+q1O/oB2bnOAazrYPWJertKYU/CstrjuNRjg1ygbfwrULBHBBL326Zgp5c3PaZcKrRL4aM5mw6qL1zFlZYM9UZj6GIKoDoTiQlZH8GOVAFNlM7LQ732QUYbMyzJy5nwYDC3KjQ+y3rg3jO97pwQrR8mTlAgPISF6WGpHBvbVk07hj+BkZj+elnIkzlX8cyCPeReGBz49qR+1zSzoCnZOkWSqCyY12HGwZLnvqoW27nXkzHdqBpMUEqQnsC/8HRSeUyHZ3azG2Mx7fNrEt0eKAH+eS9/OpvUm3NDXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3kn8vbOCcdzWNZwZpDniFblI5dWCW2hRrYq9aH9GH8=;
 b=b4aTReDQP/9J2F7n0ma80nO1V/dzLbOOOiSI2cxIHFYcy5ZBCM0TO8S2KRRodIrYd/qm9tdXdCF/YvsnzXm8gCsebFjEtk6kH8iu0KsgxIr2r6oblOKAqYiO1d+CG01BRoWPGGbutu8QcBvTvBfLZ3K8NgoSdTxteiNkbAlQh3Q=
Received: from DS7P222CA0007.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::24) by
 DM8PR12MB5447.namprd12.prod.outlook.com (2603:10b6:8:36::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.22; Wed, 11 May 2022 07:27:06 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::c9) by DS7P222CA0007.outlook.office365.com
 (2603:10b6:8:2e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22 via Frontend
 Transport; Wed, 11 May 2022 07:27:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 07:27:05 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 11 May
 2022 02:26:59 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v3 19/35] iommu/amd: Update alloc_irq_table and alloc_irq_index
Date: Wed, 11 May 2022 12:51:25 +0530
Message-ID: <20220511072141.15485-20-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220511072141.15485-1-vasant.hegde@amd.com>
References: <20220511072141.15485-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6109b9ba-f868-4933-ae3c-08da331fa6b5
X-MS-TrafficTypeDiagnostic: DM8PR12MB5447:EE_
X-Microsoft-Antispam-PRVS: <DM8PR12MB544788722F6B4451326B325287C89@DM8PR12MB5447.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tIQNSQ1gVVBSY9rEERi2tMgjy3Q2PTJej7YGZojYtVHWWa+g2hw41LLXYWdRzzvVuLBG5mWqC2B3gxuPRXlBW+4PLypfkwTeQLCYvaC04ai/ZYBAosM//dsmT3iKUgK3zn/+uyCM55wRhQ2oPMkzpLuYHwuZUhSi6INnzAcO+DEXFmpjKe7WlclDujWU3v+F+QP6at+1HMO4t1Rb5RUYtxzZrz4pN51x5RyiFqnwQaDS/h2qXpNhBwfT1+jIj8Hv7l7jl67oVhqnMJ3tSBSJPSIXboxgd0BTYIr8joaL18Aua1dEDFwUIZR/xBledvpmwcjWUQvVwV+HEbksx0J5bAVwAQESnO/ateq8elmEOXwv4uekutP9Mp3+fs0ud4V8uYRo8+rss5bpOEP2ETDNnM/ixn+4yz4EUqrAfkzE0sF449SAO/cVJ3a6scRLgfcex28EUrofdHlVVCCT4WGSTqP8jsErjzqhedsBB7BSZPowOGeReRUfyJHArbCGP6ymeaP8yXuFl15XX4XDhzDIi8e58diD5rrY0fiNZfF5JU2UoNeeDxc8ky8NzAXQCXeH5wDKNQau0UwNLq/WtIqH+i8SllqvZc992SYWZ0gXPA96dJAs+XS0IUOApCEYbE6KymtJQPYZExM6pRID9HBDNOC7AyhSJkokbgL49ntJtS2z3NUhtfON31Z5AdY3TTcvJ01SSJxKTKvKBHJIUOQl5A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(508600001)(36860700001)(8676002)(40460700003)(356005)(81166007)(70206006)(86362001)(4326008)(70586007)(2616005)(316002)(5660300002)(54906003)(6916009)(6666004)(26005)(7696005)(186003)(2906002)(16526019)(47076005)(336012)(426003)(1076003)(83380400001)(82310400005)(44832011)(36756003)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 07:27:05.9336 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6109b9ba-f868-4933-ae3c-08da331fa6b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5447
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
index 2023bb7c2c3a..34909faeef76 100644
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
