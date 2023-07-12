Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80627100AE
	for <iommu@lists.linux.dev>; Wed, 12 Jul 2023 14:19:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rp3r6Yuz2ebpJWUn3DPIgdPZQ1i7s1ZWGrei9AsOXYV9xsXba5cw8px0FTO1bC6MXdxUjIcCheo00hYqrdNihC+4ENk1GbFEZNufU0Xz56bOkGyGNMlDoXzr0TtbCGqQqCJSL2h1+YjJg+7vGESwyKlqje7oyQUdU0Rl/eYACvl6vkEJLbJz5zusYh6jC7bwdsR3K/8bFlLh3IAeFtxUEbeyA690esiE1JOyKqF0BegvcVk+LxjknFfHFStO2YqwZnCnsfJy2SrQAM3oEkch9Ifq8LM0PTv5CRYA4/MiLSRC3/Y5vkwoYqWuggCIaDdy/C/7qXwfVjt3yiKnDC/IfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RhUrXApcoAOkAvQQ6eljnVvf5NRzGFIY2MNY/4Xcxlw=;
 b=JsxGPK1jvCHFdMM5WhUdDNg8gj9bZ0OmwkvGIdpn6RhVSHv9OjLvYt/zQpf8Pdgh9trw+AMqTwcUrsjK7JkxFiO4ivAkdLquTzF+HvXVrxrFeijxKeb8Sx1k3oUaSssleLfZo0Jg/UKKDzco8OCZ6edq8WCzp6iLX8wW46+u1fW4hrgyU6ptCr+s9fIRe37kmwjXikNKjzbO0OHS8I4+Vg0jtaUB3+T9KCU7TOAEFgVE5W9wq9v5yNdpvgK94LUNTbqiwvd6p5Y8+BqtFFLMPLZvBgnf98bHevIClykf3mGKD5ltrjlCi8ilaIdmsCSgemzavluBchQ14B+XwH0Zgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhUrXApcoAOkAvQQ6eljnVvf5NRzGFIY2MNY/4Xcxlw=;
 b=LrUxtdaD6/D8FIqlup5pjbSAEt1Cs3+z1vdjINicjXwb91D7bnresO3edRskA8lf+BYoWG/YR4HGPuLPf6b4ea5PQ2k7jkPUscQ+kOo/2Q8Kj0BJFvB/yPCFuMkUMEUOuygWoZwZmGZaPDEKPtbGAMlAqGyMei8OxKivn68ZYQE=
Received: from DS7PR05CA0002.namprd05.prod.outlook.com (2603:10b6:5:3b9::7) by
 CY5PR12MB6480.namprd12.prod.outlook.com (2603:10b6:930:33::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.32; Wed, 12 Jul 2023 14:19:10 +0000
Received: from DM6NAM11FT095.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::68) by DS7PR05CA0002.outlook.office365.com
 (2603:10b6:5:3b9::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Wed, 12 Jul 2023 14:19:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT095.mail.protection.outlook.com (10.13.172.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.22 via Frontend Transport; Wed, 12 Jul 2023 14:19:10 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 09:19:07 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 13/21] iommu/amd: Consolidate logic for setting up v2 API mode
Date: Wed, 12 Jul 2023 14:15:08 +0000
Message-ID: <20230712141516.154144-14-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712141516.154144-1-vasant.hegde@amd.com>
References: <20230712141516.154144-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT095:EE_|CY5PR12MB6480:EE_
X-MS-Office365-Filtering-Correlation-Id: 0538ae1e-807f-4c57-619f-08db82e2f5c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/Ta6ogSLdELD9ga1g/OO87PXoa8PKXkjctZP6iWYzoUvU7qajBt4k1zvRAI+4Zt/1EDrH8Rsq217iOhR2QWPNaOzb4kyefa68fk7FLiFKKgPRxyGUgT4gIRftkCbdb+0POp3NGo/xkOGc87P/DKxIZwOmvgHaXpKlezJmbaTYKZsFWYQrK5FwJ5aoy+1TmEZ3eayjKz8jN9i0KvvQcoHQPEr7k7lMgqSPPpit4DPXDHTK40B6NoLa1hqmlgLGYbVpd+vIp5NJaVKtaJ2jn7yg96LsvEqqRfKjWOhzUs9SpPWFSVJW90RF34dyIHEKgho31TvBXCgGxaNh10MvG1LGUIJXZLWlhUrSkvta+mvHQf9pGPk56iAImbQt40+FWM4NLB+pATFkHYhVpcZPK6oio4RpkiSpWFe+jRa3NzOZRtDFG/DxYbVCl0lMjrUyWi0Y9fGlbYkXcA3KzPXo2ZbGKvb0fdJm6WHLBFUYjhqgjW+mTeHhVILgf6dt29bMWebBsPSlfim+UtPE2FO07hnpw0XPhaFcejhAFfMD+N3gohAcgFK4yMlPeGf4PeqcuIZWxjz9K9k1Rcf29UwEhJVUeXip4tlZLBWfQZUot6w7sXUXbX9WSIXomEhpoUNFpKpKJPNTL8hmdR1tiFJ9tcDem0nVWEDkZ4ShAabwyAzxRSap/XY1Aim7zXn6Udd1Ok++n2c1uoo6m8WMX3mNjCqOOoGzqqstah2sQjUTNzioxybCt+fsaCCIeQpiGKVZlHd5gjuY2CaNx09ZxBZvmMq9w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(396003)(346002)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(336012)(1076003)(16526019)(26005)(186003)(36860700001)(2616005)(426003)(41300700001)(478600001)(47076005)(316002)(44832011)(5660300002)(83380400001)(4326008)(8676002)(8936002)(2906002)(70206006)(70586007)(110136005)(54906003)(36756003)(40480700001)(7696005)(356005)(81166007)(82740400003)(82310400005)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 14:19:10.0111
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0538ae1e-807f-4c57-619f-08db82e2f5c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT095.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6480

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Use the AMD IOMMU domain flags to help simplify domain setup when
enabling v2 API support for a domain.

This includes:
  * Introducing new functions to init and uninit v2 domain. These
    functions will take care of necessary changes before enabling v2
    domain. iommu_v2 module will just call amd_iommu_v2_domain_init()
    to enable new domain.

  * Consolidate logic to free all io page tables, which was handled by
    amd_iommu_domain_direct_map().

  * Enhance free_gcr3_table() to cleanup v2 page table related
    variables.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |   6 +-
 drivers/iommu/amd/amd_iommu_types.h |   1 +
 drivers/iommu/amd/iommu.c           | 127 +++++++++++++++++++---------
 drivers/iommu/amd/iommu_v2.c        |   5 +-
 4 files changed, 95 insertions(+), 44 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 0605f02fa711..7773315e5adc 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -56,8 +56,10 @@ int amd_iommu_pc_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
 
 int amd_iommu_register_ppr_notifier(struct notifier_block *nb);
 int amd_iommu_unregister_ppr_notifier(struct notifier_block *nb);
-void amd_iommu_domain_direct_map(struct iommu_domain *dom);
-int amd_iommu_domain_enable_v2(struct iommu_domain *dom, int pasids);
+int amd_iommu_v2_domain_init(struct protection_domain *pdom,
+			     struct pci_dev *pdev, int pasids, u32 pd_flags);
+void amd_iommu_v2_domain_uninit(struct protection_domain *pdom,
+				struct pci_dev *pdev, u32 pd_flags);
 int amd_iommu_flush_page(struct protection_domain *domain, u32 pasid, u64 address);
 void amd_iommu_update_and_flush_device_table(struct protection_domain *domain);
 void amd_iommu_domain_update(struct protection_domain *domain);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 907af6e41ae9..f74750b7f963 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -448,6 +448,7 @@
 #define PD_FLAG_V2DMA		BIT(2) /* DMA-API mode w/ v2 page table */
 #define PD_FLAG_GCR3		BIT(3) /* domain has gcr3 table */
 #define PD_FLAG_GIOV		BIT(4) /* domain enable GIOV support */
+#define PD_FLAG_V2API		BIT(5) /* domain is used for v2API */
 
 /* Timeout stuff */
 #define LOOP_TIMEOUT		100000
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 685efe942ce0..22d5ac82efc1 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1566,7 +1566,13 @@ static void free_gcr3_table(struct protection_domain *domain)
 	else
 		BUG_ON(domain->glx != 0);
 
+	domain->glx = 0;
+	domain->flags &= ~PD_FLAG_GCR3;
+
+	amd_iommu_domain_update(domain);
+
 	free_page((unsigned long)domain->gcr3_tbl);
+	domain->gcr3_tbl = NULL;
 }
 
 static int get_gcr3_levels(int pasids)
@@ -2074,6 +2080,87 @@ static void protection_domain_free(struct protection_domain *domain)
 	kfree(domain);
 }
 
+static int v2api_domain_init(struct protection_domain *pdom)
+{
+	/* V2API is already enabled for this domain */
+	if (!!(pdom->flags & PD_FLAG_V2API))
+		return -EBUSY;
+
+	/*
+	 * The V2API mode cannot be initialized if domain is not in
+	 * passthrough mode
+	 */
+	if (pdom->flags != PD_FLAG_PT)
+		return -EOPNOTSUPP;
+
+	/*
+	 * Free any existing page tables for this domain since
+	 * the V2API mode require v1 table to be in identity mode.
+	 * The iommu_v2 driver will handle setting up v2 table
+	 * when binding.
+	 */
+	if (pdom->iop.pgtbl_cfg.tlb)
+		free_io_pgtable_ops(&pdom->iop.iop.ops);
+
+	return 0;
+}
+
+int amd_iommu_v2_domain_init(struct protection_domain *pdom,
+			     struct pci_dev *pdev, int pasids, u32 pd_flags)
+{
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&pdom->lock, flags);
+
+	switch (pd_flags) {
+	case PD_FLAG_V2API:
+		ret = v2api_domain_init(pdom);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	if (ret)
+		goto out;
+
+	/* Allocate guest page table */
+	if (pdom->gcr3_tbl == NULL)
+		ret = setup_gcr3_table(pdom, pasids);
+
+out:
+	/* Retain default page table mode flags. */
+	if (!ret)
+		pdom->flags |= pd_flags;
+
+	spin_unlock_irqrestore(&pdom->lock, flags);
+	return ret;
+}
+EXPORT_SYMBOL(amd_iommu_v2_domain_init);
+
+void amd_iommu_v2_domain_uninit(struct protection_domain *pdom,
+				struct pci_dev *pdev, u32 pd_flags)
+{
+	unsigned long flags;
+
+	if (!pdom || !(pdom->flags & PD_FLAG_V2API))
+		return;
+
+	spin_lock_irqsave(&pdom->lock, flags);
+
+	/*
+	 * If device is booted with passthrough mode then clear guest
+	 * page table.
+	 */
+	if (!!(pdom->flags & PD_FLAG_PT))
+		free_gcr3_table(pdom);
+
+	pdom->flags &= ~(pd_flags);
+	spin_unlock_irqrestore(&pdom->lock, flags);
+}
+EXPORT_SYMBOL(amd_iommu_v2_domain_uninit);
+
 static int protection_domain_init_v1(struct protection_domain *domain, int mode)
 {
 	u64 *pt_root = NULL;
@@ -2530,46 +2617,6 @@ int amd_iommu_unregister_ppr_notifier(struct notifier_block *nb)
 }
 EXPORT_SYMBOL(amd_iommu_unregister_ppr_notifier);
 
-void amd_iommu_domain_direct_map(struct iommu_domain *dom)
-{
-	struct protection_domain *domain = to_pdomain(dom);
-	unsigned long flags;
-
-	spin_lock_irqsave(&domain->lock, flags);
-
-	if (domain->iop.pgtbl_cfg.tlb)
-		free_io_pgtable_ops(&domain->iop.iop.ops);
-
-	spin_unlock_irqrestore(&domain->lock, flags);
-}
-EXPORT_SYMBOL(amd_iommu_domain_direct_map);
-
-int amd_iommu_domain_enable_v2(struct iommu_domain *dom, int pasids)
-{
-	struct protection_domain *pdom = to_pdomain(dom);
-	unsigned long flags;
-	int ret;
-
-	spin_lock_irqsave(&pdom->lock, flags);
-
-	/*
-	 * Save us all sanity checks whether devices already in the
-	 * domain support IOMMUv2. Just force that the domain has no
-	 * devices attached when it is switched into IOMMUv2 mode.
-	 */
-	ret = -EBUSY;
-	if (pdom->dev_cnt > 0 || pdom->flags & PD_FLAG_GCR3)
-		goto out;
-
-	if (!pdom->gcr3_tbl)
-		ret = setup_gcr3_table(pdom, pasids);
-
-out:
-	spin_unlock_irqrestore(&pdom->lock, flags);
-	return ret;
-}
-EXPORT_SYMBOL(amd_iommu_domain_enable_v2);
-
 static int __flush_pasid(struct protection_domain *domain, u32 pasid,
 			 u64 address, bool size)
 {
diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
index a9733fbc1761..dce5e006ceb7 100644
--- a/drivers/iommu/amd/iommu_v2.c
+++ b/drivers/iommu/amd/iommu_v2.c
@@ -785,9 +785,10 @@ int amd_iommu_init_device(struct pci_dev *pdev, int pasids)
 
 	/* See iommu_is_default_domain() */
 	domain->type = IOMMU_DOMAIN_IDENTITY;
-	amd_iommu_domain_direct_map(&dev_state->pdom->domain);
+	dev_state->pdom->flags = PD_FLAG_PT;
 
-	ret = amd_iommu_domain_enable_v2(domain, pasids);
+	ret = amd_iommu_v2_domain_init(dev_state->pdom, pdev,
+				       pasids, PD_FLAG_V2API);
 	if (ret)
 		goto out_free_domain;
 
-- 
2.31.1

