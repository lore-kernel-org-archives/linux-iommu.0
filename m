Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2040.outbound.protection.outlook.com [40.107.96.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA938F55
	for <iommu@lists.linux.dev>; Thu, 21 Sep 2023 09:25:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ON8V7kUXcsk5ciIaMObaG/Hx5QGHK1hZ9LXxTvpyXIRjs7ZQcgVkVHONOA7XLRq98woE8CjAB8bB17OjWW8qli4b+Dqcnfs/BMCZKoayHkkbleoC2y7GGQ7tENvxO0DKrSc8oKKoK+AGrlQnilCvtV+Lq9TU2WlbszC42ltJrZgAaP9ngqqx5f8BSxp5ACr4MwTvsQlPrMbDlEwIYiynAt96I+7Nnwi35yBZYIf8V9/WNF9RgnpmLIBrL1FDTaLAAJ8bpBV9XcM8nUEEVomflwBOcCDb0cQSBVxGW2OM0XY1vNl0WmG1MGzdcmjMyJbzXATzKBYxBa1Mh1dcaJUl0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+obP8VNOIXrVQ3KTgqj0RWA0NhA+AYcH9Wx3TpKu14=;
 b=R3HBIytAT4LEeonn2XYmtZDMeKKM8IMroVsj1/qMx3017dCX56jbXaq7GxyBrsOvb9qT4o9zFczffyaIc6TlfwW2ODlDa0QqVhwam3jcyIEMx5zP8etk9LHBqUnfR5B3s7J/eg/QRmqBhPboothI/0jNEGT8A/KWwxFGkdHdDsp6WKiPz6K+Klh4EwjL897zlyc9nkWSGY6C7aLpM/+7+N+EazQXPPyRQjBxCU1EGj7hqUYDUgCGJRVvjtZ+FAlWtUJSyMuNAs80oMchsWDTjsmTWqWK8nXRgvmG/ALz/QnA1sBxtj7LVQJtVtSaB3hjbM91+dOW1fKtycxenIV1SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+obP8VNOIXrVQ3KTgqj0RWA0NhA+AYcH9Wx3TpKu14=;
 b=CC5TM2Wws4o3k9hzVIt/+yMYWctei04KDxVxtvcbcmmX7FO5nT9c+IXU36Fp7c87nxfL5WqejfNSag0+xBaKhK4I6vnyPZRZ69eV7DSVzMMhbmfByIVc3U75SG/Uflig0cRA1aaGivqXK8/hhZGXzbgKcrr2npqjujBe6B9ngqY=
Received: from DM6PR08CA0048.namprd08.prod.outlook.com (2603:10b6:5:1e0::22)
 by CY8PR12MB7097.namprd12.prod.outlook.com (2603:10b6:930:51::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Thu, 21 Sep
 2023 09:25:29 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:5:1e0:cafe::ad) by DM6PR08CA0048.outlook.office365.com
 (2603:10b6:5:1e0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.30 via Frontend
 Transport; Thu, 21 Sep 2023 09:25:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 21 Sep 2023 09:25:28 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 21 Sep
 2023 04:25:22 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v6 07/14] iommu/amd: Miscellaneous clean up when free domain
Date: Thu, 21 Sep 2023 09:21:40 +0000
Message-ID: <20230921092147.5930-8-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921092147.5930-1-vasant.hegde@amd.com>
References: <20230921092147.5930-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|CY8PR12MB7097:EE_
X-MS-Office365-Filtering-Correlation-Id: 85c1bcf7-8448-45d8-d234-08dbba84b20d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vpZwLrJ2hONDfykqNKsUVd6bNJ8EH2+1zYQ7+LPK2vGRKojtLsAm/egt2Zmgtg7AzuZ/zGwEWzn+S24GizfZg8Vm2khxdcb3NSHDTBykpSs93aGgPVQ9tmHnuB79SUs+1J5AhWKHeiSvl5aJfiBeDI1gdVhn9KBvb/OmWSzEZi6IA2GZ7kpUzDkgAeOyt6yyTRwri+OTSg6SCu1/9V34eje+5gLjKFo3ktltbEimFMYlNQUHYBPA1ucOsXHCqOivCqQbA0dCetJdgPqw26380TbmnzYMjX4EJXAQR3KYmBhnpC7Rs3PKw9BER8cLZ2N1pprpsqmrP7xRBBSiMY2kaEBA3UJyh0LsKtwu4iXbRegqpc3Jmp/EafJp2k6rzjY/O1ysaR5JjZZtnub1CHpo+CaEQ+xDnB9V674tNywKqzbtmrt2WW/FWFSWtP5Gl4jDndgreQ/7zQDImlCEPLgLOAsgHvdZzO4G54Ze8a7eD3us5FSPl0hQePMpr2y9KCZgdjll2FNZCX4G151UBR+2L3TCKVu9xZaMXedm7dg24ZVIjSCnPDtC1l7MkyE8DHsJc2RW0ha0uxfEYV6XPmhkNRb2MPqTbVrq+aTV9h5lWbjKvW1jGCGGGUd8Mc4g08bePCVhH67REpn76V3gG9IpJMs+pwslztoQC0FCydmSObSp/bGEenlTyeyS65xLzU96bKmydzm01m6u9Jk65rPSxH0ZZ3GtlITL0q4wEB1s57ooVMr2u2LtFqNCfKZRCiNTz2L+cB4xvDqfjd38+5K2hQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(39860400002)(136003)(186009)(451199024)(82310400011)(1800799009)(46966006)(36840700001)(40470700004)(2616005)(5660300002)(16526019)(40460700003)(26005)(1076003)(426003)(41300700001)(2906002)(47076005)(336012)(81166007)(356005)(86362001)(82740400003)(36860700001)(40480700001)(36756003)(4326008)(8936002)(8676002)(44832011)(83380400001)(478600001)(6666004)(7696005)(316002)(110136005)(70586007)(70206006)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 09:25:28.7975
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85c1bcf7-8448-45d8-d234-08dbba84b20d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7097

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
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
 drivers/iommu/amd/io_pgtable_v2.c |  8 +++---
 drivers/iommu/amd/iommu.c         | 44 +++++++++++++++----------------
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/amd/io_pgtable_v2.c b/drivers/iommu/amd/io_pgtable_v2.c
index e9ef2e0a62f6..f818a7e254d4 100644
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
+	amd_iommu_domain_clear_gcr3(&pdom->domain, 0);
+
+	/* Make changes visible to IOMMUs */
 	amd_iommu_domain_update(pdom);
 
 	/* Free page table */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 46a10b489cf5..0dd8390113af 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2047,9 +2047,11 @@ void amd_iommu_domain_update(struct protection_domain *domain)
 static void cleanup_domain(struct protection_domain *domain)
 {
 	struct iommu_dev_data *entry;
-	unsigned long flags;
 
-	spin_lock_irqsave(&domain->lock, flags);
+	lockdep_assert_held(&domain->lock);
+
+	if (!domain->dev_cnt)
+		return;
 
 	while (!list_empty(&domain->dev_list)) {
 		entry = list_first_entry(&domain->dev_list,
@@ -2057,8 +2059,7 @@ static void cleanup_domain(struct protection_domain *domain)
 		BUG_ON(!entry->domain);
 		do_detach(entry);
 	}
-
-	spin_unlock_irqrestore(&domain->lock, flags);
+	WARN_ON(domain->dev_cnt != 0);
 }
 
 static void protection_domain_free(struct protection_domain *domain)
@@ -2069,6 +2070,12 @@ static void protection_domain_free(struct protection_domain *domain)
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
 
@@ -2083,10 +2090,8 @@ static int protection_domain_init_v1(struct protection_domain *domain, int mode)
 
 	if (mode != PAGE_MODE_NONE) {
 		pt_root = (void *)get_zeroed_page(GFP_KERNEL);
-		if (!pt_root) {
-			domain_id_free(domain->id);
+		if (!pt_root)
 			return -ENOMEM;
-		}
 	}
 
 	amd_iommu_domain_set_pgtable(domain, pt_root, mode);
@@ -2100,10 +2105,8 @@ static int protection_domain_init_v2(struct protection_domain *domain)
 
 	domain->domain.pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
 
-	if (setup_gcr3_table(domain, 1)) {
-		domain_id_free(domain->id);
+	if (setup_gcr3_table(domain, 1))
 		return -ENOMEM;
-	}
 
 	return 0;
 }
@@ -2162,14 +2165,12 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
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
 
@@ -2207,19 +2208,18 @@ static struct iommu_domain *amd_iommu_domain_alloc(unsigned type)
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

