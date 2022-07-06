Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E181B33C6
	for <iommu@lists.linux.dev>; Wed,  6 Jul 2022 11:47:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cr2LzfLMqHnpLJFwSgDFg5TOGdExu4eErUfU0rKG8/2269OoTy5Nz+Th0ugVPWF7mBKRZo2ckA5/4fBx3z70mfSyZVdL95L29cvhdNHlo96h92weel3tOubnLiv3VRh3DJRMuSSLzQGLsl6HQf9fYwUgPvjtw4qwFkKjaKni/v4M/HKJvgSoZhum4jM0xR7AdRuy4nhtpopy06eIw5cv4pg3Fxz4TwIB8kntPYd0jHYzDoy2uC/a4wrYhT0JfKcVi7XrcfPFTsHlqqqtVD8YNsQ5OhyvMsqQaYHBV7Znk6jnxUatk4i2MvcEKEXGRcjPjybRD8Xmj32gT3RMwMHfmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtDKs/tBmyaLi/oDjEcXmqyxQIkCebTmDLXmP2WNxM0=;
 b=FEqNCAS2jXpE7X0bbePMGWc4SuLj9Zwe3tyTI28sw5xTzMSkFOhpkxiPxJHjS56d8nrqrR4Bgc0Fq2Nj65C4h70IlGMqB9Q7x7BxV0YDNpUA+JdIGad6Gcq/KOKJ0NydsHSmI0hSgp5x8Dd8xrKFUQaD/J3FN1lVmH4dmvtnt7Rqw8gXRzHQNNZEeajXXdDCE4HSuZm6Skim3/2Fq4szIOZoSwFbAR52KYbh4R1HFU7kIcGp72BhAlu4XsVnVfi//USxJCMb1fN9qeK2Ql40ZxNPlOxb4SkiLi4hi1Fo7GwEeugkxilwatC2xLYj+AeMThw58n8ST3ZeB0VtWPkMfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtDKs/tBmyaLi/oDjEcXmqyxQIkCebTmDLXmP2WNxM0=;
 b=xaA9zKaHsWm0o+k3Ffe7w3zYlCrqSmMRxltyqJz7V4fTm39EQyFhm9Va38lnJKBAFJuIJMQ0sisK0Kjb2trMkkZ5X5NOkeBxocO1sJ/QFcen6juBGMSRZGKhF7DM/myfAX0KcKswQwb/243M5xl+H1SEzeFfrDD8+oUtBDtrfks=
Received: from MW4PR04CA0200.namprd04.prod.outlook.com (2603:10b6:303:86::25)
 by SJ1PR12MB6289.namprd12.prod.outlook.com (2603:10b6:a03:458::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Wed, 6 Jul
 2022 11:47:17 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::fc) by MW4PR04CA0200.outlook.office365.com
 (2603:10b6:303:86::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15 via Frontend
 Transport; Wed, 6 Jul 2022 11:47:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Wed, 6 Jul 2022 11:47:16 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 6 Jul
 2022 06:47:14 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <joro@8bytes.org>, <iommu@lists.linux.dev>
CC: <iommu@lists.linux-foundation.org>, <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 RESEND 19/35] iommu/amd: Update alloc_irq_table and alloc_irq_index
Date: Wed, 6 Jul 2022 17:08:09 +0530
Message-ID: <20220706113825.25582-20-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220706113825.25582-1-vasant.hegde@amd.com>
References: <20220706113825.25582-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ddd114b4-727b-487d-3860-08da5f4546d0
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6289:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NdQXaySbofHZNkcQN7PnJAfytHiCg6Dy3fV3cRLdQ7+4JdJcJwBThSgFfuFMOFNEtvNFONtOX+yrw1x+K4tI6Cup6a481st29/TcyvVU+DHrnawPXnaD0Ad/8UX3Xs5HMTgjRwW/ILfJ5jrDOa9M0RJH6dEdKrwapNrNojLW2Dh64d7PDMce4w5xx6eyW6B4Sv3EBmzCATZd68af8WWmgUf7gDA8qjEhEAcUSw6Ots2EtTToICUXrayrABeWfFbBmv3ZPfVejnHRPZhXjeoXyHZwuYG1rAqJcS1xBA5OFp+yvHX8zSYVeWkR15iZk6sQrCNMAg3sdbcVK/7/eu13vayW6QLjLEjyaVSzz2Gp+ee4ya7ML82K3WBOvOaAHVKSOBSByrcbZyJLunQ8tMQAcdFckleN4X2WjIdob+hakScrLuxtw8Z51sROhmH9z5KCZQwWyju/Ga/7P4juRTlCJwH/6IlP1nQY0GEwNC4luK1Ypb0fLY8HMLdkTQQU259JFgjICqeTaVVBhTw4BjbpiCFrLeosa2E1+IhPNOa/afR2wH92d3lNSJWSuoLJFOzyOUYnVwvtWIQXcPOBeXkTj/1voJtHUy09IEqXHWoD+rjFmbesJZ2vBrQz87i6p680IOd/0gRrE1KogqEYM2OP1LYeiMpxaRnazojnvgZODIySD7oWOdR3/rZtP0Nbof9t9z7Kvmk5PUOugTeGZmcaQkj0bsq04m5jU+vJNgkN4uflHdL9dtO4pTZCgEsDi4jjpCGGJcE0FKfuaEi7GpnUko28d8wIrDSNnMZEC7/8Cx357JzQjMrwiWf18m+SWyiMKPkgLp4+QNfSuavr2Ve0sVvw3JAgFcNtJvt7giZ5e0gFphUr0rupwapnbn3IBXyQ
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(396003)(136003)(39860400002)(40470700004)(36840700001)(46966006)(316002)(82310400005)(110136005)(54906003)(40460700003)(36860700001)(336012)(426003)(47076005)(83380400001)(36756003)(26005)(34020700004)(16526019)(186003)(86362001)(5660300002)(44832011)(2906002)(81166007)(1076003)(7696005)(70206006)(8676002)(4326008)(70586007)(40480700001)(6666004)(478600001)(41300700001)(82740400003)(356005)(2616005)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 11:47:16.9904
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddd114b4-727b-487d-3860-08da5f4546d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6289
Message-ID: <20220706113809.MaWg0PWv7f8fxltmCOs7rqhKTXtRAsU1hmeUGx8Ndwg@z>

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
index c4701fa957d0..5ee1af9a0a54 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2814,21 +2814,17 @@ static int set_remap_table_entry_alias(struct pci_dev *pdev, u16 alias,
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
@@ -2884,18 +2880,14 @@ static struct irq_remap_table *alloc_irq_table(u16 devid, struct pci_dev *pdev)
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
 
@@ -3267,7 +3259,7 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 	if (info->type == X86_IRQ_ALLOC_TYPE_IOAPIC) {
 		struct irq_remap_table *table;
 
-		table = alloc_irq_table(devid, NULL);
+		table = alloc_irq_table(iommu, devid, NULL);
 		if (table) {
 			if (!table->min_index) {
 				/*
@@ -3287,10 +3279,10 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
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
@@ -3416,8 +3408,8 @@ static int irq_remapping_select(struct irq_domain *d, struct irq_fwspec *fwspec,
 
 	if (devid < 0)
 		return 0;
+	iommu = __rlookup_amd_iommu((devid >> 16), (devid & 0xffff));
 
-	iommu = amd_iommu_rlookup_table[devid];
 	return iommu && iommu->ir_domain == d;
 }
 
-- 
2.31.1

