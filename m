Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFB7186D
	for <iommu@lists.linux.dev>; Mon, 21 Aug 2023 10:45:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dUgrWuYPH7qErvtKDAHk0u27Yw2zT1B+3K6dgj4ubYTjR3Tns5+IpkmbXk2BvzB6oM4yecXHOi9j8/GtJxR5GCRKOjgG+OyNM7rhGhT85qMmie8Lqrg54DlNjHx9OLZbiEcp83BesOCaArFkkIKKP2qiQ3+IkZMm46ZPKuVesPjcPdgLPIdnw4V0RG7er+Y70BpvqMH8tL6xohTiP+Z/ZZ0Pdu2RRlDPUtdK6mcGK47mJFuj7Pyz0tOColF8Tl8qplsMkfdMHiMAxQvArjUV/7yRDrj2KwD1n7eppPp59eTLT5wIHi093IxoL7+UYU0ONE50PFrH9pOsW6/Q1uugzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Lshe3SjXfQtQWOzOKJEFW9tA8JcxmP9slVpt5KTcG0=;
 b=l98jC5MR0IArvhZRQ23fyXLxrG2srA2PAgrMMqDuD5CnBMEuU7HH+bYEP3/RL1v6rkzLhhVsUnGVzSIdnCcu+k5LKwKny8b2bCfgkiwAvHc7jRxtn8zXZk5NQJFnJ4pjos1XETEQp2kPbghO2nIWePowOLlJTUCuiGlaU73rAeuqo1IPHX3EfAwdU4E8rZEt9ue/V8BqjuR1249Kt1hNUOA9Bw8Hbo4Jah0AalZlWwAm7foL6+xQ5OXHBkfYKPFrMVpBiVgUSAhBWzE67bsn+1/gr+fbCOqQTT9Oxf3IhfRN8WKIsT+Wa5H1tpMqAHlOdjD981DfX6E8lb19rfMB+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Lshe3SjXfQtQWOzOKJEFW9tA8JcxmP9slVpt5KTcG0=;
 b=E5HcLq9Ur1u2AWOKNnLHhRwq3WENhDIe9a+Dtk0bvfg1EeGAOMiKmtmnESZknAfnNMuL6/2EJnWMUDXvF2FrcpFx4cx1cysQ/HJdpz+J2UmqPs3kjQH+fJhcfqKvXv87oVX0L+DiiO64sJdoFlKLpcx9ITvI7maC9KyOVnsNZSw=
Received: from SA1P222CA0142.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c2::24)
 by SN7PR12MB8060.namprd12.prod.outlook.com (2603:10b6:806:343::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 10:45:53 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:3c2:cafe::f) by SA1P222CA0142.outlook.office365.com
 (2603:10b6:806:3c2::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.23 via Frontend
 Transport; Mon, 21 Aug 2023 10:45:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Mon, 21 Aug 2023 10:45:53 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 21 Aug
 2023 05:45:50 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v5 07/14] iommu/amd: Miscellaneous clean up when free domain
Date: Mon, 21 Aug 2023 10:42:20 +0000
Message-ID: <20230821104227.706997-8-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821104227.706997-1-vasant.hegde@amd.com>
References: <20230821104227.706997-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|SN7PR12MB8060:EE_
X-MS-Office365-Filtering-Correlation-Id: 481c3201-70fe-4d25-4a71-08dba233cb2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LvYShPjhXRezdUx6NoS0iwLRi3kyTLXwP23xEq+3or1cD09UGe77FvLbKNHfVxQuM09wXUFLxxvpPuQK0tyKWCgTyV813RGq4GQ22VaX0EbP38FpfOPRoCWz16sQ+Q3lQ4WaL5VBIJlgfbbvk0ztNmtcbElhGVlRR3xWC5HHMSi/WKYWndJg9xSlY3aaQo8/15DR+cmBIcQUrCZnEwZYQ8x3Bo4xRmX1a1iOpf8BtAg8VXhmF3RbIZWAs/6n4JbmVOM0SgcwoJY38m66Cp5ugodoWVM+ahV5b0n+bXi+kuj5jCWEZ7AiwWLg/VtqUy8I+KbIQlTjizzY8WaHzNq/X781py8q0kZGRUQDqSRGTI0VFFiyn8dWqWqinTJQpKOdlHkBr+I8+a+VjdMFiKdvXA2H9exD0W3hQB3UhgdWvvpVWeK5TgXKKkscITxoafjy8KV2II7eftk0QNFbKa+GlH5QWSNoDbz4azlQj6gp3w/jkY4lkXhHRYv+1zlMu35N2W+/pG9BexWaCW4wd+at0gLQL1eq2dBRHcR57HzX3Km1Xftqvh/L2xh1g1I5xKgXYqrvbNq3SovMcwC2+jyTxzC35DNahzhzq4nX2G0XJPX28B+83UjK6D8XSeDCqMTAUy/fYT4s0hNiTGawNPneCXY6Yt2OIV1nRId+O/whAiZJLKYWb/gJzqUwrfpT130vghgLJ4KmUZMkcF06sJ+fnEz7J7RgzwhbBHk+Y99MGIxmst5unr+iw+lu5wCZbVYTrq3xeZCxLqELHKSjVBnAoQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(82310400011)(451199024)(186009)(1800799009)(36840700001)(40470700004)(46966006)(2906002)(83380400001)(7696005)(40480700001)(5660300002)(44832011)(336012)(426003)(16526019)(26005)(86362001)(36860700001)(47076005)(8676002)(2616005)(8936002)(4326008)(70206006)(316002)(54906003)(70586007)(110136005)(478600001)(82740400003)(356005)(81166007)(6666004)(40460700003)(41300700001)(36756003)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 10:45:53.8181
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 481c3201-70fe-4d25-4a71-08dba233cb2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8060

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

