Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A290923AE
	for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 05:39:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YUWbBqAVb+q/41CDjD1XN50/eztYAU01oTW3wh1Zg7ACAHU1rFLRUNwaOxfNpzUk07ke+m2J7AmQTlrjVy/NRNbbjspA2KM9f4ioawYFQ/f4L+nmgp6DdE0qKUhYdjexlm8ygPnt11HemzMah1ZsD6VUd3e5KX04O/eHZb1+kyxeIXt61/0q0DOKyEppo/qPZFwxnrRFhDNxnbBEsICZTNlKCrwx/GKPvjYPb0YU3YQqOdUmKRpnO6cPn86eGre/xnDVxyq6ZpJOidfl+WN8OlqgvPp2gjMv42zXBzCX0OoIgjTl3jDavkEX14au9qCbhY9rgcbiubalN8M6DJztwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3BJt9StNZQGpuX9I4JyXHMEeWxUEKLpYOHxtO0CgsA=;
 b=ASuJxa01WzrQhe+AER8ayn6VQvTDgp0iurdN87hyAp0h1yPWqp85nUzhD/Gxdz0rMoY/CjYWdFEdQM4hULJzmvMN6EzWN7dy25kahBuKHE4jSnU+xxBwxNblnqAY/n9JRCpbg1nbryT6vukEq5n8ssXIYttpDndjcCe6r6QanNTh2C4SbWk4WlYtkB6bjDd8LZYP0qbru99aamw8Mrg/mXb5Vyr6C31fZ159z4sPU7NMvqIAGgGaOxg0idICUFyhK3n6QuzIRNUda5H7mMKeczG/5hSZ4/RTU5IBa/rKLIZxpIWMbCTX1b3+wJcRcdMqWuN8boIt8dWzwz5yopKx6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3BJt9StNZQGpuX9I4JyXHMEeWxUEKLpYOHxtO0CgsA=;
 b=n0QXjq9sWxKoTQtTRLMqn6zPmwIGo8z11ZIoQWaAm6If+5CcGczSfxiWIg/oHQEwlx6+s8TMuVJByPAZbHTuKvRaK43BMkjOosa+rQxeYgsm5hGIc6TtjTxvvIuYbQEy/mZk4puI0KP5092hyEYKZDzbLnndvMJg8Q//z5+aZxQ=
Received: from BN9PR03CA0182.namprd03.prod.outlook.com (2603:10b6:408:f9::7)
 by SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Fri, 28 Jul
 2023 05:39:09 +0000
Received: from BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::dd) by BN9PR03CA0182.outlook.office365.com
 (2603:10b6:408:f9::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 05:39:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT107.mail.protection.outlook.com (10.13.176.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Fri, 28 Jul 2023 05:39:08 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 00:39:06 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 09/16] iommu/amd: Miscellaneous clean up when free domain
Date: Fri, 28 Jul 2023 05:36:02 +0000
Message-ID: <20230728053609.165183-10-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230728053609.165183-1-vasant.hegde@amd.com>
References: <20230728053609.165183-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT107:EE_|SJ2PR12MB8739:EE_
X-MS-Office365-Filtering-Correlation-Id: d57353f0-ef35-47fc-831d-08db8f2cf70f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bCGyAHfjtdrj+z+dfGvKr3iBPd2LaKWu4AGcwUl2TpixwK40Y0LqjCwMT2IEFCEuZ7RHENfWe47GcVep5zKCl8hUtBhttRXTTIyhbgxAoPDuMov2QBngh7XTQ4fZFOITuatGObOUqYZDZUQz28sWTzd7pl4tuwUjg33td0HaGzhr5OaTko1pJj4dkI27T1QS0vfNOfhh6j79hS08PFJMQnmqJ2LQTpAjsTkdzA54X+2LEZbkKKH1AiLlwMEVOqVDRoy7zvzashn512tWHnEen5oLDdYO0HgTTowz5r9S7MC04bUTivO+78HKghEMSQKLfMBQr9qwrrgM0egRCeJKfzg0H1ehkk72tp9yFeOLjfwatuOhgXqP+fXquLMqNJkgIoDK4g0w9Va1s8K8cklDb8kUT7KPW8ndzbHBd49aNuiYZS7i0jo+Q2VxfDVPLet5eSIGhvfbXKxyvcPx3NEouRrbxJLVEfem0QZ9uzaE4CeTdQSLaiB+pZ+6yMidn5KBCV7WrcBEOj4nzBA3/VSjjZYqZXmsB7Wys3yXEK0udyVacYv9IDoPmC33tSWx8U64yuQZ1ZBrvx+crR4ARLjPyuQOyIY17skQf71RfgBk/3png8rAG/M/iIdZePDsMtUJ8TsUqgiDdBEwxIgULqXwFvADSM8cji6zB6N5++F5pozFtmGaZEVdWg9ZLDw+WNNS70w/jfVULq8HGLSULzC0ezYNC8oGEMitpp5sRbV5OH62VzRRdM18xy4muMhjgHQQBB7Cy8x9dNMu/aD4bxmmyA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(396003)(136003)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(336012)(1076003)(26005)(186003)(316002)(478600001)(70586007)(16526019)(70206006)(4326008)(41300700001)(86362001)(7696005)(8936002)(8676002)(6666004)(44832011)(54906003)(110136005)(36756003)(5660300002)(426003)(2616005)(2906002)(36860700001)(47076005)(83380400001)(40460700003)(82740400003)(356005)(40480700001)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 05:39:08.8910
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d57353f0-ef35-47fc-831d-08db8f2cf70f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8739

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
index f5a05779573f..a0b0deb6fbcb 100644
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
@@ -2156,14 +2158,12 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
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
 
@@ -2201,19 +2201,18 @@ static struct iommu_domain *amd_iommu_domain_alloc(unsigned type)
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

