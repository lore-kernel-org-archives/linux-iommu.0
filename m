Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB921FC8
	for <iommu@lists.linux.dev>; Fri,  4 Aug 2023 06:45:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PjiYRspw4j6eQuHEf7Efx6Lsdrkz3kpOHqMFgo+gC2kZ+UZ2wtDY4gllFTDupiTkgpiu/962+MYfE8pD8rNoJSTdBkNZX6gUPhHpmw1HuJK7NZQDkOLiWQLtCSWPtX8DutIKdpQFMjKuhphknHEmGhHmH1O3TlJ1zYoucseMg4AS8QzFoK4qV/kews02QCYkle+THrfi0YT9m6McWWg0j9ovPCSWg41WxbRgHDQD03bBGeBZjT7F5aSZVmsMFkuKU37kEp8kQnYrQCFUFOfjF4LMV/j7l6bEM16JJyXxhJ6lqIa8vcWCOf3vean5+kh1/I/GsdFKsa/cAVjrWfJYIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0IBpELfFrKfFJ5f0J4I25+LoU9CL7Hk1EGQ2nYAmHng=;
 b=LlJlH41OMH4+2dLiBBdTqqg1z2y556JRrRtzHn8Jjfjv7ldj9L1GGU8iuIoUeSvVCIRRHjlTXxcw8YVYi5nWRU/BvN5VcRl/WlrCCThbpmlnrjX8VJQy5n31nvArhltkNBUgaLfNYPRGYNNOoFJxSDB/4W8eeM6gfGIYrlKlgvDh8f0olfEfP9t9zGI0e3LBYdoL4k/Psj1Ucgx+DS10bjizhhdyEY+z/quBKk9+MmolnhJxQvVyy6BjBgSQwsPnjtzffBDbD/YxUDdyrJoeooAHwl77/xMF+z28tcgeH+eRRYnpRDhv41WIaIm9qezUStWWUUVVCA5PiUfTnFpnwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0IBpELfFrKfFJ5f0J4I25+LoU9CL7Hk1EGQ2nYAmHng=;
 b=SBqLmRb4fcI+FUq+MUbFwM0HjSE5Z5r950/RSC2RErgl1Naklh18Jv2GRl9AmpsN29jhbU0XcgUtp9PAblQ4HLY3c0+95KtptrTtczTSwQtf+rPCHyxTNWbb5rcWsk61OT0bl0N5PH+HwjaqJRP6lE83HeQpSZYMP2ZfvPi/eJI=
Received: from CY5P221CA0067.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:4::42) by
 DS0PR12MB7745.namprd12.prod.outlook.com (2603:10b6:8:13c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.47; Fri, 4 Aug 2023 06:45:22 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:930:4:cafe::45) by CY5P221CA0067.outlook.office365.com
 (2603:10b6:930:4::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21 via Frontend
 Transport; Fri, 4 Aug 2023 06:45:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Fri, 4 Aug 2023 06:45:21 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 01:45:18 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 09/16] iommu/amd: Miscellaneous clean up when free domain
Date: Fri, 4 Aug 2023 06:42:09 +0000
Message-ID: <20230804064216.835544-10-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804064216.835544-1-vasant.hegde@amd.com>
References: <20230804064216.835544-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|DS0PR12MB7745:EE_
X-MS-Office365-Filtering-Correlation-Id: a4d3c0c9-18b0-4007-f874-08db94b6600c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lXP9xaVcvu+c5WESu4JlR7bgbujqXbMqfsUE5n0kAeUuIacse5dT8Lv9B1reuFSI3ApgJ/RZym3jSjWrjtGO0HpzVRFWUPQmeJ514pIE6e3Id7JxNSeDaAprs+tJzInL19ZjTX63n2R/KTr3BvXqJCxierA9Rq/yi6giXhR3d92H9UODbdtbFN35s28E33vQ6KMf6q43qnxeQUOTY9klClGdbFNLSTh2KDdKdCdP7EOyCJE3xXCdolN7Vh/XirsUMeHMaVA58CHP+PUt3z2o/G7n/mdb8lhCMcddoZx1UyapT1QIo1E6eP1Vz60ipWUaaw3DJ8xslBW5N2gzqhDG+LLOGKYtwlHVccpN6xC8IbJXwWlLzstP33SCPpr5oM9VjcQqr59ZOqh6iBJ1j+chG0Ilf6SJVpdxnj4GQZ978I4ii/TyflXOOO9/ouIKFTYA7XiWxibTMUYIhqx+NFC1YwKSU11mRB2T4mREDqrW9+6lNIgApUyi44eyycURKsoiuQq4QV9Kdz/KWq8+PPbhyFgxRLpfXLOCqKNi2ZeWnkK716GkPXtkS/gY7ehholtWm3rOp576SMapAxEn5/4Tm9fW+Gz6RY/+H9DvCh+tIMEcoulYqAzePS7SAp2m6JoHn3lTxGcL22DLKjW6Tgof5JxrRSf6vwZn+KB4uM3jBIOnZFFYX82cL8ACDLqvJLVictxc1kp89iMtJCVAp7hOV0/IUE3YuvuH95RXzgygpVt8TfotLYBS7ib3IuuP/TEb4+k3+bYEiGYxMC4eWaTvNA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(136003)(396003)(1800799003)(451199021)(186006)(82310400008)(46966006)(40470700004)(36840700001)(40460700003)(16526019)(2616005)(1076003)(8676002)(26005)(83380400001)(336012)(47076005)(2906002)(36860700001)(316002)(4326008)(70586007)(5660300002)(426003)(70206006)(44832011)(8936002)(41300700001)(6666004)(7696005)(110136005)(478600001)(40480700001)(54906003)(356005)(81166007)(36756003)(86362001)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 06:45:21.8384
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4d3c0c9-18b0-4007-f874-08db94b6600c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7745

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
 drivers/iommu/amd/iommu.c         | 44 +++++++++++++++----------------
 2 files changed, 26 insertions(+), 26 deletions(-)

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
index 1836df41fc7e..22b38712b28b 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2043,9 +2043,11 @@ void amd_iommu_domain_update(struct protection_domain *domain)
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
@@ -2053,8 +2055,7 @@ static void cleanup_domain(struct protection_domain *domain)
 		BUG_ON(!entry->domain);
 		do_detach(entry);
 	}
-
-	spin_unlock_irqrestore(&domain->lock, flags);
+	WARN_ON(domain->dev_cnt != 0);
 }
 
 static void protection_domain_free(struct protection_domain *domain)
@@ -2065,6 +2066,12 @@ static void protection_domain_free(struct protection_domain *domain)
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
 
@@ -2079,10 +2086,8 @@ static int protection_domain_init_v1(struct protection_domain *domain, int mode)
 
 	if (mode != PAGE_MODE_NONE) {
 		pt_root = (void *)get_zeroed_page(GFP_KERNEL);
-		if (!pt_root) {
-			domain_id_free(domain->id);
+		if (!pt_root)
 			return -ENOMEM;
-		}
 	}
 
 	amd_iommu_domain_set_pgtable(domain, pt_root, mode);
@@ -2096,10 +2101,8 @@ static int protection_domain_init_v2(struct protection_domain *domain)
 
 	domain->domain.pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
 
-	if (setup_gcr3_table(domain, 1)) {
-		domain_id_free(domain->id);
+	if (setup_gcr3_table(domain, 1))
 		return -ENOMEM;
-	}
 
 	return 0;
 }
@@ -2158,14 +2161,12 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
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
 
@@ -2203,19 +2204,18 @@ static struct iommu_domain *amd_iommu_domain_alloc(unsigned type)
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

