Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D9C15C2
	for <iommu@lists.linux.dev>; Fri,  6 Oct 2023 10:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JswIVXoA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lm7EIeXC9AEcwChUVvgiGXHyxnp1PrfvsPcrWsqZGyUT8Gq7bhaymeJNEMPRQxbFYHk1NBiAaJvuawcRvEmPj6NK4hP6n4avXHvXohvh7peOByFuHTL0dz2AABCUHkUc9bDJK7LVWiaR0T8bhiZBDhGP4Q2ikSdZbmXQBzk4ZdZcbyXn0FZLwlTLwNf93b4a8yb/3e/Og3reK5P31r0G3pYxpNdIxPm9+S+DBkrAHim9ZIMpPW6JZDNnburevvPQIvCbJCMnirLp5M8AtszONujPnTqJxZ72yOPj6BYKqzVdDn9ZO/H/dOrMmTREAKMOrlF9aCKwoc9jrh54Y+TAVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p3uZlkcH5e2F0g4TWmPFsiO2Uy3wBeegWL7ZuBtyHEc=;
 b=MiDw9L/flgPeF5DFdvMiDbrGlOn73hnpvgRBa4npZ60t20SIjbPaaSDAMA1nU3mfc8tRMyOGXHtjmXqD9gfiJ4MG1gA0THPTiZuGomzewb0n+0Rqs8iKgagRzmDPs2NE9NtRa8LUlf84j5v5XacGKMwipnnJPADsURkTmC4A1YUiU6chZ/cfeMLgpwBKygknQe6qfl+GfPYObWA0svLwkFpgY3QWeorokHvImd30TADvc3cYXUPHiMkOPiImfemtkIrvRhx9JddZq9J2bJx4lOw3Cnbwzvvz096YhNjM6AsuYR5xr0tbFgyX1cdrfn9OWPv3l+AZumUDtHO55MTAdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3uZlkcH5e2F0g4TWmPFsiO2Uy3wBeegWL7ZuBtyHEc=;
 b=JswIVXoAaSJFWe91UEgTTPJ0ThezSHrY/0exXZ5CyruEE4VbbN8uZ0GwZTnrPXfOBTtFGhrMRfzOBt9SNjC739F7zVylpG2BV//NrgQDJ3nwno9ubs2p89DFmZssnHEWJP1ou7aBjKUQ/l52je/1qw94v+ikCUWpKa3cZFx7Ovs=
Received: from MW3PR05CA0003.namprd05.prod.outlook.com (2603:10b6:303:2b::8)
 by MN2PR12MB4535.namprd12.prod.outlook.com (2603:10b6:208:267::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Fri, 6 Oct
 2023 10:19:20 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:303:2b:cafe::c3) by MW3PR05CA0003.outlook.office365.com
 (2603:10b6:303:2b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.29 via Frontend
 Transport; Fri, 6 Oct 2023 10:19:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 6 Oct 2023 10:19:20 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 6 Oct
 2023 05:19:17 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v1 09/13] iommu/amd: Refactor domain flush global function
Date: Fri, 6 Oct 2023 10:16:20 +0000
Message-ID: <20231006101624.5912-10-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006101624.5912-1-vasant.hegde@amd.com>
References: <20231006101624.5912-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|MN2PR12MB4535:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c4f0e16-175d-494f-59cd-08dbc655b450
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MuXHaCUQDh3spJw0bHxns6AAVFHZpv2rovLIHAwSpS1PLYUVPHqktrFRUd775eMnKe3x/ukGjrtFmVMV9GHsbpuUWgbsf8xSzgiiEz0meFA/r0Q/bZevSTduVIUGfMUejnwbJ0VqKI9Pp3p+eqb58f2CCHs2pmVt3OmPy+L9TNXxN8I+cL6sH2iZknQ5/bc0spY3tMGvMhHplg972PckG/WvWMxGx7wP56fDJ8ttObQgWkzTH/M1PLSt1fOIyNarQnpegufIdyGfnMI4SYVs43IwaB+6rfbDaPjtlBkmNV7MAk835mL7OXSQ8ggZqSOXo09e1OQXWaOh5pwmslNu6XJBw1MkOr7YtsLdk9gjS/2xPU0r4ltbAFdAuOaon3h/fwR6M+xPmLIBScUclLBvJWa6g07Rw26EZPYoWasDkfCAmQUUyj84jQpmJsRER9NmzNxCDwesdCL+isNcFb9qQMg2FgvDnalOqv/IxW46XktzxpfS6qenaktFtKZVNDNxCETW0xJlft30WeZEC0EDRr25bbewdX9yqaKBAFiKZjFoaRWuvBNHZd7lc6yoCPFd7m0NmmnXb2bzL4vYO3NoURY30D13CihuhvCEqOaLRpDe353poa6k1YQc2yCzWMwBLdlehgwqhazzFlep0/a/2KQJaGjkIHdfZ4UGQOj1neh6nmRVFA5IWwt+GtMq49/iV3saOTS5ZyZhrROwb/F9YIvFXHesFECdy+TJggiIAFX7GbaMFWKsN7uyu6ilVRqwrZpbrH3i9KnZ0m4MY11BJw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(346002)(396003)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(82310400011)(46966006)(36840700001)(40470700004)(86362001)(2906002)(5660300002)(8936002)(8676002)(4326008)(316002)(41300700001)(36756003)(54906003)(70206006)(70586007)(110136005)(36860700001)(47076005)(478600001)(44832011)(83380400001)(81166007)(6666004)(356005)(336012)(426003)(40480700001)(1076003)(26005)(16526019)(40460700003)(2616005)(7696005)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 10:19:20.1022
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c4f0e16-175d-494f-59cd-08dbc655b450
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4535

- Add new function (amd_iommu_domain_flush_pages()) to invalidate range
  of pages. Current patch adds support to flush host page table.
  Following patch will enhance this function to flush guest page table
  with default PASID. So that we can use same function to flush v2 page
  table as well.

- Convert v1 page table (io_pgtble.c) to use newly introduced functions.
  So that it invalidates updated page ranges only instead of invalidating
  everything.

- Rename amd_iommu_domain_flush_tlb_pde() -> amd_iommu_domain_flush_all().
  It will reflect its usage as PDE is not passed explicitly. Also make it
  static as its used inside iommu.c only.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h  |  4 +++-
 drivers/iommu/amd/io_pgtable.c |  4 +++-
 drivers/iommu/amd/iommu.c      | 23 ++++++++++++++++-------
 3 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 234db57cd320..088890f9618a 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -52,6 +52,7 @@ int amd_iommu_pc_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
 int amd_iommu_pdev_enable_cap_pri(struct pci_dev *pdev);
 void amd_iommu_pdev_disable_cap_pri(struct pci_dev *pdev);
 
+/* TLB flush */
 int amd_iommu_flush_page(struct iommu_domain *dom, u32 pasid, u64 address);
 /*
  * This function flushes all internal caches of
@@ -61,7 +62,8 @@ void amd_iommu_flush_all_caches(struct amd_iommu *iommu);
 void amd_iommu_update_and_flush_device_table(struct protection_domain *domain);
 void amd_iommu_domain_update(struct protection_domain *domain);
 void amd_iommu_domain_flush_complete(struct protection_domain *domain);
-void amd_iommu_domain_flush_tlb_pde(struct protection_domain *domain);
+void amd_iommu_domain_flush_pages(struct protection_domain *pdom,
+				  u64 address, size_t size);
 int amd_iommu_flush_tlb(struct iommu_domain *dom, u32 pasid);
 int amd_iommu_domain_set_gcr3(struct iommu_domain *dom, u32 pasid,
 			      unsigned long cr3);
diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index 2f072c434fd9..35bf829d1fb4 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -369,6 +369,8 @@ static int iommu_v1_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
 	bool updated = false;
 	u64 __pte, *pte;
 	int ret, i, count;
+	size_t size = pgcount << __ffs(pgsize);
+	unsigned long o_iova = iova;
 
 	BUG_ON(!IS_ALIGNED(iova, pgsize));
 	BUG_ON(!IS_ALIGNED(paddr, pgsize));
@@ -424,7 +426,7 @@ static int iommu_v1_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
 		 * Updates and flushing already happened in
 		 * increase_address_space().
 		 */
-		amd_iommu_domain_flush_tlb_pde(dom);
+		amd_iommu_domain_flush_pages(dom, o_iova, size);
 		spin_unlock_irqrestore(&dom->lock, flags);
 	}
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 1f695dd50fec..c30b08e2a939 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1553,10 +1553,18 @@ static void domain_flush_pages(struct protection_domain *domain,
 	amd_iommu_domain_flush_complete(domain);
 }
 
+/* Flush range of IO/TLB for a given protection domain */
+void amd_iommu_domain_flush_pages(struct protection_domain *pdom,
+				  u64 address, size_t size)
+{
+	return domain_flush_pages(pdom, address, size);
+}
+
 /* Flush the whole IO/TLB for a given protection domain - including PDE */
-void amd_iommu_domain_flush_tlb_pde(struct protection_domain *domain)
+static void amd_iommu_domain_flush_all(struct protection_domain *pdom)
 {
-	domain_flush_pages(domain, 0, CMD_INV_IOMMU_ALL_PAGES_ADDRESS);
+	return amd_iommu_domain_flush_pages(pdom,  0,
+					    CMD_INV_IOMMU_ALL_PAGES_ADDRESS);
 }
 
 void amd_iommu_domain_flush_complete(struct protection_domain *domain)
@@ -1583,7 +1591,7 @@ static void domain_flush_np_cache(struct protection_domain *domain,
 		unsigned long flags;
 
 		spin_lock_irqsave(&domain->lock, flags);
-		domain_flush_pages(domain, iova, size);
+		amd_iommu_domain_flush_pages(domain, iova, size);
 		spin_unlock_irqrestore(&domain->lock, flags);
 	}
 }
@@ -1859,7 +1867,7 @@ static void do_detach(struct iommu_dev_data *dev_data)
 	device_flush_dte(dev_data);
 
 	/* Flush IOTLB and wait for the flushes to finish */
-	amd_iommu_domain_flush_tlb_pde(domain);
+	amd_iommu_domain_flush_all(domain);
 
 	/* decrease reference counters - needs to happen after the flushes */
 	domain->dev_iommu[iommu->index] -= 1;
@@ -2036,7 +2044,7 @@ void amd_iommu_domain_update(struct protection_domain *domain)
 	amd_iommu_update_and_flush_device_table(domain);
 
 	/* Flush domain TLB(s) and wait for completion */
-	amd_iommu_domain_flush_tlb_pde(domain);
+	amd_iommu_domain_flush_all(domain);
 }
 
 /*****************************************************************************
@@ -2446,7 +2454,7 @@ static void amd_iommu_flush_iotlb_all(struct iommu_domain *domain)
 	unsigned long flags;
 
 	spin_lock_irqsave(&dom->lock, flags);
-	amd_iommu_domain_flush_tlb_pde(dom);
+	amd_iommu_domain_flush_all(dom);
 	spin_unlock_irqrestore(&dom->lock, flags);
 }
 
@@ -2457,7 +2465,8 @@ static void amd_iommu_iotlb_sync(struct iommu_domain *domain,
 	unsigned long flags;
 
 	spin_lock_irqsave(&dom->lock, flags);
-	domain_flush_pages(dom, gather->start, gather->end - gather->start + 1);
+	amd_iommu_domain_flush_pages(dom, gather->start,
+				     gather->end - gather->start + 1);
 	spin_unlock_irqrestore(&dom->lock, flags);
 }
 
-- 
2.31.1

