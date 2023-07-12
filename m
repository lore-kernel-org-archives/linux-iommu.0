Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330B6100AE
	for <iommu@lists.linux.dev>; Wed, 12 Jul 2023 14:18:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IAfKbhybw+BhNHvumko1iGE7n0s9swRV7W7uHaunsD+5HFH+VLuiAxhZ+5oJS/FcUFAs/JCODjeXB4JCs2RdgvHNZKzlElcPvc5Xe1TjokELCl/PD3vzhTztOjWHkucj+BlArfdVx/vly8tpoekm7vguRW/lpBTSdxLelax4s9id9rbPNRiESQvtW6HnID5ZDAoQNwY2X0DAlfPfuDQd1IiYSiXYQh8vywMD7FWTNF5iKFsaCOAceUORUxxc0MGJ9mYNaWpqoIv+UJxrhuu8187R+v2t/PK7Gg9E6kwdPcRAPrWQ95hKpO7OyWig1EhajIxunZdzybVqhcUU3/ScBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXppGw+RmwD1kvtiGb11dKLDYt75zBaxmERFHKNa+yM=;
 b=NWsL4trQbLhSgfYDGoMbL2DbmikwPBDLBET562iRWjcULyzFUpbH6QTVgwnGlSuERzuc2Qxkzb3pXIMK7oY3n6TGta5ZZcA2ZycXm0BKit8vF7ul5Sb2tMw6r/ZmqiUCEBQ/xnLF1zqF7HidOMCFewDxv47BQQhESk+geSjwrrfxPSGxNkvtBL4dWbgax2x3cD5ObERSCw8f4CbLd/pcAZTDaLtejeH9gvWucqUmTjEhuErilxJ1IF3Z22P7a680S2I6UQdv26xKsg64dC6lsDXKv3KIQBkzFDbaYz0I5Q0gLspSpNaTKlyd1OGS9VIwjSRtIm3dEsdphiVCpgoBzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXppGw+RmwD1kvtiGb11dKLDYt75zBaxmERFHKNa+yM=;
 b=hDkT1m01F3BSCccmLoxPj3jEbGyA3kJVSDW95IILDr72Ukui1bp1o8mdNCOoQyq4Xby0GM/vvtBp2CS71wsFTeXRYjYB+/TfLWISxvGNTO1yOgNFakcrvvwLl+SCgA2moadk276ATIg/g7I1yOG2G4HXh1fhDTaHP2qJdhO9rMI=
Received: from DM6PR06CA0066.namprd06.prod.outlook.com (2603:10b6:5:54::43) by
 BY5PR12MB4289.namprd12.prod.outlook.com (2603:10b6:a03:204::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Wed, 12 Jul
 2023 14:18:09 +0000
Received: from DM6NAM11FT111.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::8a) by DM6PR06CA0066.outlook.office365.com
 (2603:10b6:5:54::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Wed, 12 Jul 2023 14:18:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT111.mail.protection.outlook.com (10.13.173.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.22 via Frontend Transport; Wed, 12 Jul 2023 14:18:09 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 09:18:07 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 09/21] iommu/amd: Miscellaneous clean up when free domain
Date: Wed, 12 Jul 2023 14:15:04 +0000
Message-ID: <20230712141516.154144-10-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT111:EE_|BY5PR12MB4289:EE_
X-MS-Office365-Filtering-Correlation-Id: 6268ae2e-31e1-41b6-269d-08db82e2d1b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	n+7p1S/NHWiMBsdsWNq/4G3anc3uP3C3oHs9RrSM+8zPToYj/KwdFsCkk+chKppDM7yvs29uutXUbGDJg0dWhmRy292pF3Zru+5qkhqHMTSzr5Wn2kabcmH6RNzm4WXYOm+6Ow3zcAgY7dZnLXB93/Y0Yw54crrkBVf8n0kyNNv0H4L3BP2fEw4ppFSYu1Sy7yVD/1Ta3ZsD+kxD7jSm6XLzx1skhfWrnZ0ASWp7uKQzb3StLvdj2F8Gm6Bt//5f/eQ9aLG8d/2VYiGhgv/9O1oLJC+cVBZiXS3Q9V4zCrr/+ZLkE5b6N9LOXDqbuPZG3GKmNBbisNFuDGDy45vmG430CTsmJhKwyklzHxSdqv5murvUBFTookTLyI1oumjuAS6Xb33bP4MjpZZcU1C1jKieuegvs95vxrt5dosOx/WIERvJGIIP3rg0flakTdSsA9IMc79mdJTrc1EoOtUlkDHDdSbNCGn7MYPvIQb7wGJovyUHiDrpALuohPjnpcLK9ue1PPrY4eBA2Lp48TgY1pLQ1HuEEycyRxOrbmZLgoZMdnTceuff3/eFUzt8P4EgaAM5Itc7LZsdhcqSKRyAxIXIxsZ/sEu8R88SMsVUvnexesRJc0SepAaNVMRW4c6NZCuBNfDlGGwApONiAxZRaKZCtqawXIMepOVsVImP84iNW/AGCvM4qYUQlkVUP3W8QsyHhhHRAwYJoL0mPu/bdBQM/MROuysPf4XWK8zRlwExTgMvu9Zgv1Ss48T6UFRl1lrou1IsU60/e2sedznwgA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(36860700001)(82310400005)(36756003)(86362001)(40480700001)(40460700003)(81166007)(356005)(82740400003)(478600001)(110136005)(6666004)(41300700001)(54906003)(7696005)(8676002)(8936002)(44832011)(5660300002)(2906002)(4326008)(316002)(70586007)(70206006)(2616005)(426003)(336012)(1076003)(26005)(186003)(47076005)(16526019)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 14:18:09.4871
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6268ae2e-31e1-41b6-269d-08db82e2d1b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4289

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

* Use the protection_domain_free() helper function to free domain.
  The function has been modified to also free memory used for the v1 and v2
  page tables. Also clear gcr3 table in v2 page table free path.

* Refactor code into cleanup_domain() for reusability. Change BUG_ON to
  WARN_ON in cleanup path.

* Protection domain dev_cnt should be read when the domain is locked.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/io_pgtable_v2.c |  8 +++---
 drivers/iommu/amd/iommu.c         | 43 +++++++++++++++----------------
 2 files changed, 25 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/amd/io_pgtable_v2.c b/drivers/iommu/amd/io_pgtable_v2.c
index a4fa830eab54..c17cda83bca5 100644
--- a/drivers/iommu/amd/io_pgtable_v2.c
+++ b/drivers/iommu/amd/io_pgtable_v2.c
@@ -363,10 +363,10 @@ static void v2_free_pgtable(struct io_pgtable *iop)
 	if (!(pdom->flags & PD_IOMMUV2_MASK))
 		return;
 
-	/*
-	 * Make changes visible to IOMMUs. No need to clear gcr3 entry
-	 * as gcr3 table is already freed.
-	 */
+	/* Clear gcr3 entry */
+	amd_iommu_domain_clear_gcr3(pdom, 0);
+
+	/* Make changes visible to IOMMUs */
 	amd_iommu_domain_update(pdom);
 
 	/* Free page table */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 037a4e28a2f3..c90d97762c33 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2037,12 +2037,13 @@ void amd_iommu_domain_update(struct protection_domain *domain)
  *
  *****************************************************************************/
 
+/* Must be called with domain->lock held */
 static void cleanup_domain(struct protection_domain *domain)
 {
 	struct iommu_dev_data *entry;
-	unsigned long flags;
 
-	spin_lock_irqsave(&domain->lock, flags);
+	if (!domain->dev_cnt)
+		return;
 
 	while (!list_empty(&domain->dev_list)) {
 		entry = list_first_entry(&domain->dev_list,
@@ -2050,8 +2051,7 @@ static void cleanup_domain(struct protection_domain *domain)
 		BUG_ON(!entry->domain);
 		do_detach(entry);
 	}
-
-	spin_unlock_irqrestore(&domain->lock, flags);
+	WARN_ON(domain->dev_cnt != 0);
 }
 
 static void protection_domain_free(struct protection_domain *domain)
@@ -2062,6 +2062,12 @@ static void protection_domain_free(struct protection_domain *domain)
 	if (domain->iop.pgtbl_cfg.tlb)
 		free_io_pgtable_ops(&domain->iop.iop.ops);
 
+	if (domain->flags & PD_IOMMUV2_MASK)
+		free_gcr3_table(domain);
+
+	if (domain->iop.root)
+		free_page((unsigned long)domain->iop.root);
+
 	if (domain->id)
 		domain_id_free(domain->id);
 
@@ -2076,10 +2082,8 @@ static int protection_domain_init_v1(struct protection_domain *domain, int mode)
 
 	if (mode != PAGE_MODE_NONE) {
 		pt_root = (void *)get_zeroed_page(GFP_KERNEL);
-		if (!pt_root) {
-			domain_id_free(domain->id);
+		if (!pt_root)
 			return -ENOMEM;
-		}
 	}
 
 	amd_iommu_domain_set_pgtable(domain, pt_root, mode);
@@ -2093,10 +2097,8 @@ static int protection_domain_init_v2(struct protection_domain *domain)
 
 	domain->domain.pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
 
-	if (setup_gcr3_table(domain, 1)) {
-		domain_id_free(domain->id);
+	if (setup_gcr3_table(domain, 1))
 		return -ENOMEM;
-	}
 
 	return 0;
 }
@@ -2155,14 +2157,12 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
 		goto out_err;
 
 	pgtbl_ops = alloc_io_pgtable_ops(pgtable, &domain->iop.pgtbl_cfg, domain);
-	if (!pgtbl_ops) {
-		domain_id_free(domain->id);
+	if (!pgtbl_ops)
 		goto out_err;
-	}
 
 	return domain;
 out_err:
-	kfree(domain);
+	protection_domain_free(domain);
 	return NULL;
 }
 
@@ -2200,19 +2200,18 @@ static struct iommu_domain *amd_iommu_domain_alloc(unsigned type)
 static void amd_iommu_domain_free(struct iommu_domain *dom)
 {
 	struct protection_domain *domain;
+	unsigned long flags;
 
-	domain = to_pdomain(dom);
+	if (!dom)
+		return;
 
-	if (domain->dev_cnt > 0)
-		cleanup_domain(domain);
+	domain = to_pdomain(dom);
 
-	BUG_ON(domain->dev_cnt != 0);
+	spin_lock_irqsave(&domain->lock, flags);
 
-	if (!dom)
-		return;
+	cleanup_domain(domain);
 
-	if (domain->flags & PD_IOMMUV2_MASK)
-		free_gcr3_table(domain);
+	spin_unlock_irqrestore(&domain->lock, flags);
 
 	protection_domain_free(domain);
 }
-- 
2.31.1

