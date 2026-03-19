Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012066.outbound.protection.outlook.com [40.107.200.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBD53EB7FB
	for <iommu@lists.linux.dev>; Thu, 19 Mar 2026 19:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773949957; cv=fail; b=OlK1S/AMctBTcvsJvJfnxGitW2As4DvhyRNgb88g1iYA6qStTT9aVGdBKsJOZU9Z3fUcTzQLkpG2yC1NzFNHQBCZ84SbicxFIebVuuiB5Ypfqjnqho/yAFC32+jByvbeumGmDWGkRuH0bbZJtmKam+PSTRrDYSl5V02GKKf9RQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773949957; c=relaxed/simple;
	bh=5I28sP5/Vh9d6EI+sw8sgNh7pY9FoH8U1rzedf8hcAc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fD+JFgWmkBlIvCxHWInaiilTKznk8pVTFNCeeziPn7bojPa646l5gob8AJLkpNZuxiqQV6sJ3gM+w4Dwp5CLQcACmlyijx3j1uFumzpohDIMRf7nBFNpGXa8TJxGhSpCEZQVbVPmq/czXpU69jKO7aZsZ1cC298JrLw8ov0Jne8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YYQ8bOLS; arc=fail smtp.client-ip=40.107.200.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YYQ8bOLS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pN0sxneigjhKT1mWvmT0sxD2yxuWs/LCYqZd92svCRmrZj9swfMb8hm0W8hgrDTiRTmA81jvku6JeLxdD7IVTL/ITBlgUpbFPbfQU2POwtQsNkwEWS0s6cjNGHhVP6KqzqPsaxjvx31UcaUEyrtUdmpWKg/xeCx5SIHaG5rUqIg65HC6RVah01MntsndDgFXJ7R3tsP0fKR2JWWvXZz/EU4P3eW54aJ7P52dSqZ1MV9uzNEXl7bPxKQfIF2VD+GRxdrUwqiVd1pRxFd3P6l3OO5/mejWhJLce7WzSTd3NhYhcLsE28enQ4AdZUR307TRi+VNUsns84PJ6X8ZoY1QOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/KnjxGLFPtcrhof589VyZU11/h7u0s5Y9v6IkepeVg=;
 b=HNLp9O9xh5FXGlxw/7V+AeoYgjYQDmSqkyFLXJ6zjnf4xqrs7w1HE21yM7USE3LnsLBVo2xlmyx+Mfo7XG9BlcbDh84k8LVt57cC6eC/zgbNzG7vxx1hb+l3MI3rrZDI+B2xqGP+lWtD08sSstRP4LkBkXFSDO6cU4DEiNT/yJyMID4W3BpTM9rai2UolMoLN3JSmGf/szM7Gun6i6krrM2U1oxxUYuuxA9yhIoCn9gqmz+blwvcFen527o2d2sKcW557LThTp+o/dnJzqc3CrGkMtD/4OZPTRVEKZfFq/s1Zm98jC64rNYCcJiLTLiXdTP5AYtVu9W+S/WkVrb7Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/KnjxGLFPtcrhof589VyZU11/h7u0s5Y9v6IkepeVg=;
 b=YYQ8bOLSTzauOg7VL/B1xlmOI5vR6RwgLbCvCBDaeT8X2xp8auhiQ7qNEckcqneBG1LqR8S8pA3wif6SdeWB8TOy7Dh2xZngKa/X92jXoBQfWIQ9E9XB0SsR45XlcPh631uNQn0EUvMbK6uoJe/7UDyxiles8S3peILRLy9/4L9l6XDE88CRxmgAUUum6dVuRmgM3fJJTPceYlFoCdVsvndVncx74sWxagKA6JDS3ymeRyeyrDHp9kexJ/xFcuyvjCv+O7yPCviFDmJ0Uz0sPYDOUi2+czoTbKyQbdcppQytyxWUDdABNZncLeor5W1U/pNGzHzJ8grIe6J3XSJ8eQ==
Received: from SJ0P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::20)
 by EAYPR12MB999155.namprd12.prod.outlook.com (2603:10b6:303:2be::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 19:52:32 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::c2) by SJ0P220CA0013.outlook.office365.com
 (2603:10b6:a03:41b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19 via Frontend Transport; Thu,
 19 Mar 2026 19:52:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 19 Mar 2026 19:52:31 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Mar
 2026 12:52:14 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Mar
 2026 12:52:14 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 19 Mar 2026 12:52:13 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <jgg@nvidia.com>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jpb@kernel.org>,
	<praan@google.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<jonathan.cameron@huawei.com>
Subject: [PATCH v4 09/10] iommu/arm-smmu-v3: Remove ASID/VMID from arm_smmu_domain
Date: Thu, 19 Mar 2026 12:51:55 -0700
Message-ID: <b6d87a722635d29e896b277cb60f0208859073d6.1773949042.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1773949042.git.nicolinc@nvidia.com>
References: <cover.1773949042.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|EAYPR12MB999155:EE_
X-MS-Office365-Filtering-Correlation-Id: a5ba399c-a541-4d0d-368b-08de85f10f23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	1oU04qXqDGRfsyNkjQOGIN8ZaDGDP0rexARL3bHpte7EGYfVi4I3di7c9RfStsUuNgTQowmoiPfsML9+L1jrCuWaNX7qxEE5e9HUcjOOaf7dgBEq95c7ZU4l07RJOi8EPczhEZK48uGdF7zTeiYM3Hf+5/NQvEUYVw9rj8+j/lrEhPJ6ayhOwbF4H7icyXJiJJgI1Sv+TvVznrNXodzUR0nGItnfO65sjnInKveokwB9VCPTYFTtoD4XWOUWGmIF1tNbLkleIqODUp13gOOYVBILs+nUu74SdNXg+ak7eapjyCbf5Qg3+TYyX7y/gh5qYOEfRUp8lp9sdpMX7pDpjvl6SOMTmYxl//VpkmAzTTSB9Lv3WigcECvnZiIJfQWWQGvVKKIebGPaOOV031Np2DUOwUxRFof6Sdqid5a2UoYnlbPPw3JnxCLaqrVoBVbpXbGBNZKLCVbNMa5IQlxUn9aUpqln06w+awerNvW8Zw8GpvBm/SpYryyqkb72wO/9g9ta77pcdUXe3bdAdrhKLBLl48iGkEOgzFSP9lnEusmUD7iMh8jgaFc8CR1mI3FhwBwUvG8S9XZBjLnrvU2O4BKED4GtGS7hVwVKC31Z4PoNBWznSPXNqiikIgQaTqKfhiqbWDTJCvmL2kiogX5WSCYRwxRi9mCUWG//5fbnF6fgSjvht0bT0LCsJaXwb8tW4GnP6DW0jQo+U5p6kn44MNh+wwbfx/tVDSMzfvohUHNZTFCsuAbrbftpExoo6SyjSDleY/czhaXSf40XWDt4TA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	z7Veuq/vbhCQOfqO0nITnuCrwgrY2aqv6gk4zMeCXP02ssDNCCmxYElSlg8iVk6wDQvesQF2wVCQLpvekDGS1p1XbpjRJm6ahHZw8BMY9P6fGfncwYIPDix99Fn7L829jjf5jQcllnWgsvWMWEJgProkYIJSXqf5CVdh6MP01vMrmcL1PjJxAG+k20LRC2hWmcjmLnRlocqJLmS7PUpkwBoNouW0bEb1blsGiUfeB1zOrq3Rvzp66ZmHQMp/s+8qPSxj4gPr4mWuymUlaJJVkYjh5E2L264BjJLV9F1wpU4JQwYP6XAXQEmak4aHiPrBe3h1ASNtbA4S4mxfUtI2Zb+rsrU5H/QRS3addP94VuSLMFoml9Yvh7/YVhN/WUkqKjj9v6bhVdWFaLSP92Y/gYKPWLnqvscA1fV3ejPdrM4tngcfVlKdHTSQ9nroSjs4
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 19:52:31.9430
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5ba399c-a541-4d0d-368b-08de85f10f23
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB999155

Now ASID/VMID are stored in the arm_smmu_master. These are dead code now.

Remove all.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  8 ---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 20 +------
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  |  3 -
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 58 -------------------
 4 files changed, 1 insertion(+), 88 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 2e5520fdca3c5..e0da09a2cc07c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -790,10 +790,6 @@ static inline bool arm_smmu_ssids_in_use(struct arm_smmu_ctx_desc_cfg *cd_table)
 	return cd_table->used_ssids;
 }
 
-struct arm_smmu_s2_cfg {
-	u16				vmid;
-};
-
 struct arm_smmu_strtab_cfg {
 	union {
 		struct {
@@ -969,10 +965,6 @@ struct arm_smmu_domain {
 	atomic_t			nr_ats_masters;
 
 	enum arm_smmu_domain_stage	stage;
-	union {
-		struct arm_smmu_ctx_desc	cd;
-		struct arm_smmu_s2_cfg		s2_cfg;
-	};
 
 	struct iommu_domain		domain;
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 846a278fa5469..0e48264ccd01b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -300,14 +300,6 @@ static void arm_smmu_sva_domain_free(struct iommu_domain *domain)
 	 */
 	arm_smmu_domain_inv(smmu_domain);
 
-	/*
-	 * Notice that the arm_smmu_mm_arch_invalidate_secondary_tlbs op can
-	 * still be called/running at this point. We allow the ASID to be
-	 * reused, and if there is a race then it just suffers harmless
-	 * unnecessary invalidation.
-	 */
-	xa_erase(&arm_smmu_asid_xa, smmu_domain->cd.asid);
-
 	/*
 	 * Actual free is defered to the SRCU callback
 	 * arm_smmu_mmu_notifier_free()
@@ -326,7 +318,6 @@ struct iommu_domain *arm_smmu_sva_domain_alloc(struct device *dev,
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 	struct arm_smmu_device *smmu = master->smmu;
 	struct arm_smmu_domain *smmu_domain;
-	u32 asid;
 	int ret;
 
 	if (!(master->smmu->features & ARM_SMMU_FEAT_SVA))
@@ -345,22 +336,13 @@ struct iommu_domain *arm_smmu_sva_domain_alloc(struct device *dev,
 	smmu_domain->domain.pgsize_bitmap = PAGE_SIZE;
 	smmu_domain->stage = ARM_SMMU_DOMAIN_SVA;
 	smmu_domain->smmu = smmu;
-
-	ret = xa_alloc(&arm_smmu_asid_xa, &asid, smmu_domain,
-		       XA_LIMIT(1, (1 << smmu->asid_bits) - 1), GFP_KERNEL);
-	if (ret)
-		goto err_free;
-
-	smmu_domain->cd.asid = asid;
 	smmu_domain->mmu_notifier.ops = &arm_smmu_mmu_notifier_ops;
 	ret = mmu_notifier_register(&smmu_domain->mmu_notifier, mm);
 	if (ret)
-		goto err_asid;
+		goto err_free;
 
 	return &smmu_domain->domain;
 
-err_asid:
-	xa_erase(&arm_smmu_asid_xa, smmu_domain->cd.asid);
 err_free:
 	arm_smmu_domain_free(smmu_domain);
 	return ERR_PTR(ret);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
index 590bba5acc97e..55a9215bb97a8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
@@ -502,9 +502,6 @@ static void arm_smmu_test_make_s1_cd(struct arm_smmu_cd *cd, unsigned int asid)
 	struct io_pgtable io_pgtable = {};
 	struct arm_smmu_domain smmu_domain = {
 		.pgtbl_ops = &io_pgtable.ops,
-		.cd = {
-			.asid = asid,
-		},
 	};
 	struct arm_smmu_inv tag = {
 		.type = INV_TYPE_S1_ASID,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 1c9358ed3ecf7..ea288b6f39ff8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2876,66 +2876,17 @@ struct arm_smmu_domain *arm_smmu_domain_alloc(void)
 static void arm_smmu_domain_free_paging(struct iommu_domain *domain)
 {
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
 
 	free_io_pgtable_ops(smmu_domain->pgtbl_ops);
-
-	/* Free the ASID or VMID */
-	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
-		/* Prevent SVA from touching the CD while we're freeing it */
-		mutex_lock(&arm_smmu_asid_lock);
-		xa_erase(&arm_smmu_asid_xa, smmu_domain->cd.asid);
-		mutex_unlock(&arm_smmu_asid_lock);
-	} else {
-		struct arm_smmu_s2_cfg *cfg = &smmu_domain->s2_cfg;
-		if (cfg->vmid)
-			ida_free(&smmu->vmid_map, cfg->vmid);
-	}
-
 	arm_smmu_domain_free(smmu_domain);
 }
 
-static int arm_smmu_domain_finalise_s1(struct arm_smmu_device *smmu,
-				       struct arm_smmu_domain *smmu_domain)
-{
-	int ret;
-	u32 asid = 0;
-	struct arm_smmu_ctx_desc *cd = &smmu_domain->cd;
-
-	/* Prevent SVA from modifying the ASID until it is written to the CD */
-	mutex_lock(&arm_smmu_asid_lock);
-	ret = xa_alloc(&arm_smmu_asid_xa, &asid, smmu_domain,
-		       XA_LIMIT(1, (1 << smmu->asid_bits) - 1), GFP_KERNEL);
-	cd->asid	= (u16)asid;
-	mutex_unlock(&arm_smmu_asid_lock);
-	return ret;
-}
-
-static int arm_smmu_domain_finalise_s2(struct arm_smmu_device *smmu,
-				       struct arm_smmu_domain *smmu_domain)
-{
-	int vmid;
-	struct arm_smmu_s2_cfg *cfg = &smmu_domain->s2_cfg;
-
-	/* Reserve VMID 0 for stage-2 bypass STEs */
-	vmid = ida_alloc_range(&smmu->vmid_map, 1, (1 << smmu->vmid_bits) - 1,
-			       GFP_KERNEL);
-	if (vmid < 0)
-		return vmid;
-
-	cfg->vmid	= (u16)vmid;
-	return 0;
-}
-
 static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
 				    struct arm_smmu_device *smmu, u32 flags)
 {
-	int ret;
 	enum io_pgtable_fmt fmt;
 	struct io_pgtable_cfg pgtbl_cfg;
 	struct io_pgtable_ops *pgtbl_ops;
-	int (*finalise_stage_fn)(struct arm_smmu_device *smmu,
-				 struct arm_smmu_domain *smmu_domain);
 	bool enable_dirty = flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
 
 	pgtbl_cfg = (struct io_pgtable_cfg) {
@@ -2955,7 +2906,6 @@ static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
 		if (enable_dirty)
 			pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_ARM_HD;
 		fmt = ARM_64_LPAE_S1;
-		finalise_stage_fn = arm_smmu_domain_finalise_s1;
 		break;
 	}
 	case ARM_SMMU_DOMAIN_S2:
@@ -2964,7 +2914,6 @@ static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
 		pgtbl_cfg.ias = smmu->oas;
 		pgtbl_cfg.oas = smmu->oas;
 		fmt = ARM_64_LPAE_S2;
-		finalise_stage_fn = arm_smmu_domain_finalise_s2;
 		if ((smmu->features & ARM_SMMU_FEAT_S2FWB) &&
 		    (flags & IOMMU_HWPT_ALLOC_NEST_PARENT))
 			pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_ARM_S2FWB;
@@ -2982,13 +2931,6 @@ static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
 	smmu_domain->domain.geometry.force_aperture = true;
 	if (enable_dirty && smmu_domain->stage == ARM_SMMU_DOMAIN_S1)
 		smmu_domain->domain.dirty_ops = &arm_smmu_dirty_ops;
-
-	ret = finalise_stage_fn(smmu, smmu_domain);
-	if (ret < 0) {
-		free_io_pgtable_ops(pgtbl_ops);
-		return ret;
-	}
-
 	smmu_domain->pgtbl_ops = pgtbl_ops;
 	smmu_domain->smmu = smmu;
 	return 0;
-- 
2.43.0

