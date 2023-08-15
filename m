Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C109E10788
	for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 10:24:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FMWI+uV/Q1+ry5RkzMj9pqrZ3WLb2JVfMDtmunBsu+l7RuaqHxQ+M5xU2G0lc9funPhl61VxBWvYA521ASWKor3qQxBLhnTn+mw+hj7djN1o7PpcH/dV5I82L29HYAWpTJvMzxNoo8tf4k8hC7YJJEYDK1wZUAqCZER6AELgr7zEmUFyLad6RaihKGWpWz4Swk7+Ue3BlAsjkKXLQIqQz3DBGRIQa7f+sIXSdyI0nyXuJtWEAJiAFoSGtI/z/z3Kb5VDRhiKxd+suMJ4oixZSt0YyvuxQ3DKDtXfYYcvPlwViAFdXX9BneamR5YzXTTY0aHRiVkQXP+FqbefensXkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Lshe3SjXfQtQWOzOKJEFW9tA8JcxmP9slVpt5KTcG0=;
 b=N2DOrvkiGivU8Ls2MmZI7eANj//nO9xyEWj1ixyjcJGeBJSfxiV0x2JuIChUYgVRCx7pSSHT0mXhBzYXsDbaColvpAu2dulCqMCR8vxiNHIntsaPK73RMMLSzdEaA1+vMtaCkdw+47PM1cKjNEGFqLhux/0g6+Kq0965qclzPfjMsYS2OF0x9ak6woLCQ49Ki/8dIQA8CCwwNGL7OP7kNYDCZgHOeJeAa4Ph7+55LSyJsF+UPBCVP0QBqi1TI9jJgREXXAYdaTKFLGZX4Ho/G1pQXq609XErzEWpeyDsTbrMAeGESNqeskWNJKIPDnnz1LY6ExTofvJiirQeqerYSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Lshe3SjXfQtQWOzOKJEFW9tA8JcxmP9slVpt5KTcG0=;
 b=fp5Wn9lf3Y5xd6sYn9CJ7dvMsj+YRqGkkSDEalcbpWGEmkPyJpRelGr1Qy5U06Mz+mtLatdSqlLYiy4DvRXRAIkwkQHuUUdqiAv94xjm3IXuW5lGHtXZzKpB14WzJn+1D8jE03kq+fYhsbxIuQhlruM13Knd7IxgyedSaFMbeP0=
Received: from MW4P221CA0023.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::28)
 by IA1PR12MB6482.namprd12.prod.outlook.com (2603:10b6:208:3a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Tue, 15 Aug
 2023 10:24:30 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:303:8b:cafe::a6) by MW4P221CA0023.outlook.office365.com
 (2603:10b6:303:8b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Tue, 15 Aug 2023 10:24:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6723.3 via Frontend Transport; Tue, 15 Aug 2023 10:24:30 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 05:24:26 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v4 07/14] iommu/amd: Miscellaneous clean up when free domain
Date: Tue, 15 Aug 2023 10:21:55 +0000
Message-ID: <20230815102202.565012-8-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815102202.565012-1-vasant.hegde@amd.com>
References: <20230815102202.565012-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|IA1PR12MB6482:EE_
X-MS-Office365-Filtering-Correlation-Id: 31e6918b-6dc1-43eb-5f2f-08db9d79cf98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vS0gq+fvfZWz4pb/3jlHrLeyTQKSj8FHGid+KTQhDD42WMCPDvVwez0QIFM4M91Zj/LgxlNFyemarB0HSMzscIexkiXt9gxKyPspG/2fI+oQOEJz4VIlZoMOUUQP/Bll49f/0YYslxT4QiY04/myxBQb8x4VSNsLB96RIaTdD0ThM0fvb/UXjVgaAcB6KV7l+rIWEAxS4zihdGpfcr/PH83hirQO6kQ4XI33FT/8BEdsp/NDNUzfo+OwcoszXhC0WO+cDEWIqMjhg+tfCcI2zAn4ouUd0HsZ93wkzPEysLDNmMZkYNXYWbkfaq1s/yuYmNN3f2bkR4MO8UT5p0sgR+wYruE9KpHMc+JwFsyVJAF4lFdR1wXEC8OiGnCpJzBNVp37z5CFaHQdFWS/BT0KHCNU+kNCnnV3vsUHZYxlgUt4yK4rzNpB3z4/HFw5ApCrg4rkTRdlGq5bhN9UMkcdkAVeLe4ZECKOClOWKyw4YBCASudeVybydhdh6cqX42dcfscKYA+hCCiB2uFvapJOSuPmM9dTEthNf1LgcTxF9oMoKnK1+moFYBf1I0WatD/EJPXcetCIIJly4wNnlb+Ov6KsXS0xwtuAQX3mhuB1sjLVBuZZsP+bcIOQFUkVpwbmnY8Ojj35UrYG2JXN99krKQ/UmyRsvaxsF9puABToHjNeOdIjrMDz4/bZ6w6zmt5uJ3yNC+HG6odFQpw90kDvi4IsbuwC0wqlrr/LOTal1KgqOWs1/B0PGCBkXBI0e7OcwsBQYXweJG+am9AG4vYLAg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(82310400008)(451199021)(186006)(1800799006)(46966006)(40470700004)(36840700001)(36756003)(5660300002)(86362001)(44832011)(2906002)(40460700003)(40480700001)(36860700001)(4326008)(316002)(70206006)(70586007)(54906003)(110136005)(41300700001)(426003)(26005)(1076003)(16526019)(2616005)(336012)(47076005)(7696005)(8676002)(8936002)(6666004)(82740400003)(356005)(83380400001)(81166007)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 10:24:30.0811
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31e6918b-6dc1-43eb-5f2f-08db9d79cf98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6482

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
index bf1640f4287c..f8319214064d 100644
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

