Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2071.outbound.protection.outlook.com [40.107.95.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69365221
	for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 05:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729057019; cv=fail; b=SzRLUdX9Q5Y5kbRf84qShSMprJW+ccm7KbsOjPSqpsqG0a8ASsQCqEl021MgSoVbEeH25Lw3bLevqqnCDZ8ltCx0nY50gx0npjFKd5yvVjQgFwhIeAccbRckHv4R0oz9TRBLgY20IEv1ssPNqyRmNje8yyKPWVjFlP1eb64bt3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729057019; c=relaxed/simple;
	bh=AV5xSwKxP7uSNzJjk2xXE8CerusYKABeKPwaOXjYRrQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a5S9a0w9gx84qWERIBT63y1F/N+kozKeskkSM3e8cO7IACAPU9R/ywJiGZtAqTVm26wFM87FYvX3Hu3l+6+nQEIH8JiwOCQpG48R+bfyo/sm0VGWfZ1wvCWD5afaJoI5daQ9FxOuPRbJIZ891b/IgFTVTvddUWpAa0iblnYlJao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3KTsZktN; arc=fail smtp.client-ip=40.107.95.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3KTsZktN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LeFzWDWyIH2RtezpH2mFqryopVh5Jk3TRxwlnPzvNYfatY7dLh71eF3ZqxIuPC+8d9Omf5Yiim9Lf1fRcRMmxvTaG5glo4n0JeUwigDJecL0Yd9EIRo68J5e7oRNPY6/eRjGwq8JXUwJNn8LD3CCpl5IrfojHRHT1qUbO5IGDrxoxCue5EXKLuDlT/ZnvDPZHRN1uFx4jcc7AEOJTiWWY25U/KWV7SKE/+0e4trBl1mZFxRR2EIMIUiatRT3Z+1AevbVOTDT/psALA3ctcg2xVdvF/G8ceHu0eC6bv8UF86s/9cLrIulIqbsb+jc6weHzyyq7hcqHcKSrpd/ssKD1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iHmcUv13z+UEkF8gOV0zbQKrHquDOmBwgnzjzAkshi0=;
 b=nOaCfaCFw3hRBrOIiQV/wxUz20ETPN2Q0e9eP45wTmE7RjZwVrkIsPzH8Md5uyshfaL9XrZa2cD/IV+wP7bwawuT/E3M3eRPjZnJBBu7vvN3a3bYpUzwO6S2szNwjSztVHW+EJeRvSqHTGwLSycmFQkk57pJv3NfTuTpuGc9KmToPepOP1UJ6EpGb4YjYRPclhraGt/rYqwyT2ib3BKjbL9dv4l9mCmwPHy/oadhwPn5eF90S0H3dVKdzzKOvpwSGDM3lQIDoL5xQHr1t1j4z2Uq5XlmKhyrdYx/+Ztzwf2qkNhiD+XzJrxQgM+ikR5920oEgyLoGlgjrF8KqbU7kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHmcUv13z+UEkF8gOV0zbQKrHquDOmBwgnzjzAkshi0=;
 b=3KTsZktNFelN23XLKJRdrPtpXqwm96ByZ21yXgnB0zzscQ/Btnz4Q4GmCYxxPboahJQcWWIQ8XSSD1VighIMBdIrv0N+J3eBC8gxqFmqeEfPyNKaIDmKU147UU0bDp1qYL7xhJ2UPeXMj61Y3z2gpC2YUrC8AjL67KZXWzN938Y=
Received: from BN9PR03CA0633.namprd03.prod.outlook.com (2603:10b6:408:13b::8)
 by DS0PR12MB6654.namprd12.prod.outlook.com (2603:10b6:8:d1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.24; Wed, 16 Oct
 2024 05:36:53 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:408:13b:cafe::fd) by BN9PR03CA0633.outlook.office365.com
 (2603:10b6:408:13b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Wed, 16 Oct 2024 05:36:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 05:36:53 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Oct
 2024 00:36:50 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, "Joerg
 Roedel" <jroedel@suse.de>
Subject: [PATCH v3 03/10] iommu/amd: xarray to track protection_domain->iommu list
Date: Wed, 16 Oct 2024 05:34:54 +0000
Message-ID: <20241016053501.97497-4-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241016053501.97497-1-vasant.hegde@amd.com>
References: <20241016053501.97497-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|DS0PR12MB6654:EE_
X-MS-Office365-Filtering-Correlation-Id: b0001596-233f-4341-3390-08dceda48aa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xqs0Mco2HN3pwBG0TSLQ2XnbZ3SVTyc2/OGmKQzQ+Vgwlcdce4uN8bnos5o8?=
 =?us-ascii?Q?OMh/c6oSOugkGQNrzoe4BTdC9E9KpfqTcnA8s40jDbIqJX4HICyiYJDf4eJ8?=
 =?us-ascii?Q?y0OVtJo2XSe3SmwLbYJUAtNzq53Kt5CVjiW0BTnzhMESYxkG7CMJA5HEbkmI?=
 =?us-ascii?Q?wzHgLQfTSJGGU/xZTdxWISCxi5WVQnXIMYibUW7AK73yLbw5osCOFaPJ9j1j?=
 =?us-ascii?Q?G4x/lWSHT3XD10YpvZogTfeOcEWw3cZMwJk553PFDTmSjUDPI9O0IxRsUkML?=
 =?us-ascii?Q?VFWGU8rONYGsaMsfQmine6h3gGt+FYIcUxR+yXth1mDbuXiHyxzxT1K58MQg?=
 =?us-ascii?Q?Gq418fUstxIKacMPFgO5ecyCDZdcCQAm6Js+N0o1G6MgCI8Shpd3C4Kjm/Pt?=
 =?us-ascii?Q?UyWRdUmm1R+pVwRLoCL4rT7Cf6BCIYxvhOYbTI918mKzwj1CcG7kumxQbxk2?=
 =?us-ascii?Q?3/0lO3HEx0CZaHZxj4NfZVw1+dPoqAiNojbcI20Qg3LcBclimSLXdG7SOVgH?=
 =?us-ascii?Q?IUI1evvTqxV/eE24pXWnUbnzV//FEvJpzTAYCyAM63/HkWTlirk8DhTVLJ3H?=
 =?us-ascii?Q?yLTM2dqTfmRD0Qll+1BSDfonhei4rvgFBrgWYJpyTSQG3KfCfTTIWNovL9NW?=
 =?us-ascii?Q?n+T6OJB99fLX+3mkhGFHpDjhdbfJaCsRAAU5EOVkzHkb9IX+tsSs4ovBH/hj?=
 =?us-ascii?Q?BJxjLiBKuLx+dJcAX9NJfipT6D8+RyHILfE7uaFS2ADfv3pj92U8Ujd66EeQ?=
 =?us-ascii?Q?YLtx0ctjo/08tCqPqgd71PZE0+qOmoAVd+t0JwOP5TCMF6d2aQaWpFRjOoh3?=
 =?us-ascii?Q?jQdzFkjHlhg1p5q6U9/Zxds9u6IbwsAZshMoxcST3+g28shfIN1yGsWtX5lR?=
 =?us-ascii?Q?hds+BQv1Im9qY8wmdDa0t1L+AF+Fx+ausFpxUIHovbrvnNkw+J3+5zYWNv2Z?=
 =?us-ascii?Q?s+UWoSYn0XIIkQqGFwSJ9W0ynglEPj0EYPtKc2D1P7kJeefng6P2T3ylivPw?=
 =?us-ascii?Q?78fXRH3CYsQGDrnfx2OUKk9Eoa3ua2eVGwLeTnzzM3TN72gxzTWcWGxFNs00?=
 =?us-ascii?Q?83o75ZGgv2wyKHUMlGGY9m56q5/aSf20wX+jYdhKjCI5xUENtXqHbIjXjVo0?=
 =?us-ascii?Q?GXvrcJsRvZs2WaSUY1M0Zd/YdtmQDJXhlb2WZspHATMCS5xprD2PTUopY2FG?=
 =?us-ascii?Q?0/Mve4AcM6KTsxU3LpyO9Kq5K5Pvbj6pD5KAgmVjVd/4aAAJhpbUu/8QapO6?=
 =?us-ascii?Q?odGtYdOT+Lm+MLhc5rBA7DtcmylzdX+aZZKgrRQ91MYUD/BLOdt8UPnWJCwW?=
 =?us-ascii?Q?3CSttKO3V1qf881kCZigbofXlJXZVyds57olArsjJ/E5O7uq02dx/NFy3E9a?=
 =?us-ascii?Q?N5FR5260JplngCx5zjyPg6IABTqL?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 05:36:53.5446
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0001596-233f-4341-3390-08dceda48aa2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6654

Use xarray to track IOMMU attached to protection domain instead of
static array of MAX_IOMMUS.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd/amd_iommu_types.h |  8 ++-
 drivers/iommu/amd/iommu.c           | 85 ++++++++++++++++++++++-------
 2 files changed, 72 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 418c14aa4ec9..0f030a61ceb2 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -565,6 +565,12 @@ struct pdom_dev_data {
 	struct list_head list;
 };
 
+/* Keeps track of the IOMMUs attached to protection domain */
+struct pdom_iommu_info {
+	struct amd_iommu *iommu; /* IOMMUs attach to protection domain */
+	u32 refcnt;	/* Count of attached dev/pasid per domain/IOMMU */
+};
+
 /*
  * This structure contains generic data for  IOMMU protection domains
  * independent of their use.
@@ -578,7 +584,7 @@ struct protection_domain {
 	u16 id;			/* the domain id written to the device table */
 	enum protection_domain_mode pd_mode; /* Track page table type */
 	bool dirty_tracking;	/* dirty tracking is enabled in the domain */
-	unsigned dev_iommu[MAX_IOMMUS]; /* per-IOMMU reference count */
+	struct xarray iommu_array;	/* per-IOMMU reference count */
 
 	struct mmu_notifier mn;	/* mmu notifier for the SVA domain */
 	struct list_head dev_data_list; /* List of pdom_dev_data */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index c9514284382e..76af6304cc1b 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1254,18 +1254,15 @@ static int iommu_completion_wait(struct amd_iommu *iommu)
 
 static void domain_flush_complete(struct protection_domain *domain)
 {
-	int i;
-
-	for (i = 0; i < amd_iommu_get_num_iommus(); ++i) {
-		if (domain && !domain->dev_iommu[i])
-			continue;
+	struct pdom_iommu_info *pdom_iommu_info;
+	unsigned long i;
 
-		/*
-		 * Devices of this domain are behind this IOMMU
-		 * We need to wait for completion of all commands.
-		 */
-		iommu_completion_wait(amd_iommus[i]);
-	}
+	/*
+	 * Devices of this domain are behind this IOMMU
+	 * We need to wait for completion of all commands.
+	 */
+	 xa_for_each(&domain->iommu_array, i, pdom_iommu_info)
+		iommu_completion_wait(pdom_iommu_info->iommu);
 }
 
 static int iommu_flush_dte(struct amd_iommu *iommu, u16 devid)
@@ -1447,21 +1444,20 @@ static int domain_flush_pages_v2(struct protection_domain *pdom,
 static int domain_flush_pages_v1(struct protection_domain *pdom,
 				 u64 address, size_t size)
 {
+	struct pdom_iommu_info *pdom_iommu_info;
 	struct iommu_cmd cmd;
-	int ret = 0, i;
+	int ret = 0;
+	unsigned long i;
 
 	build_inv_iommu_pages(&cmd, address, size,
 			      pdom->id, IOMMU_NO_PASID, false);
 
-	for (i = 0; i < amd_iommu_get_num_iommus(); ++i) {
-		if (!pdom->dev_iommu[i])
-			continue;
-
+	xa_for_each(&pdom->iommu_array, i, pdom_iommu_info) {
 		/*
 		 * Devices of this domain are behind this IOMMU
 		 * We need a TLB flush
 		 */
-		ret |= iommu_queue_command(amd_iommus[i], &cmd);
+		ret |= iommu_queue_command(pdom_iommu_info->iommu, &cmd);
 	}
 
 	return ret;
@@ -2016,6 +2012,50 @@ static void destroy_gcr3_table(struct iommu_dev_data *dev_data,
 	free_gcr3_table(gcr3_info);
 }
 
+static int pdom_attach_iommu(struct amd_iommu *iommu,
+			     struct protection_domain *pdom)
+{
+	struct pdom_iommu_info *pdom_iommu_info, *curr;
+
+	pdom_iommu_info = xa_load(&pdom->iommu_array, iommu->index);
+	if (pdom_iommu_info) {
+		pdom_iommu_info->refcnt++;
+		return 0;
+	}
+
+	pdom_iommu_info = kzalloc(sizeof(*pdom_iommu_info), GFP_ATOMIC);
+	if (!pdom_iommu_info)
+		return -ENOMEM;
+
+	pdom_iommu_info->iommu = iommu;
+	pdom_iommu_info->refcnt = 1;
+
+	curr = xa_cmpxchg(&pdom->iommu_array, iommu->index,
+			  NULL, pdom_iommu_info, GFP_ATOMIC);
+	if (curr) {
+		kfree(pdom_iommu_info);
+		return -ENOSPC;
+	}
+
+	return 0;
+}
+
+static void pdom_detach_iommu(struct amd_iommu *iommu,
+			      struct protection_domain *pdom)
+{
+	struct pdom_iommu_info *pdom_iommu_info;
+
+	pdom_iommu_info = xa_load(&pdom->iommu_array, iommu->index);
+	if (!pdom_iommu_info)
+		return;
+
+	pdom_iommu_info->refcnt--;
+	if (pdom_iommu_info->refcnt == 0) {
+		xa_erase(&pdom->iommu_array, iommu->index);
+		kfree(pdom_iommu_info);
+	}
+}
+
 static int do_attach(struct iommu_dev_data *dev_data,
 		     struct protection_domain *domain)
 {
@@ -2032,13 +2072,17 @@ static int do_attach(struct iommu_dev_data *dev_data,
 		cfg->amd.nid = dev_to_node(dev_data->dev);
 
 	/* Do reference counting */
-	domain->dev_iommu[iommu->index] += 1;
+	ret = pdom_attach_iommu(iommu, domain);
+	if (ret)
+		return ret;
 
 	/* Setup GCR3 table */
 	if (pdom_is_sva_capable(domain)) {
 		ret = init_gcr3_table(dev_data, domain);
-		if (ret)
+		if (ret) {
+			pdom_detach_iommu(iommu, domain);
 			return ret;
+		}
 	}
 
 	return ret;
@@ -2064,7 +2108,7 @@ static void do_detach(struct iommu_dev_data *dev_data)
 	list_del(&dev_data->list);
 
 	/* decrease reference counters - needs to happen after the flushes */
-	domain->dev_iommu[iommu->index] -= 1;
+	pdom_detach_iommu(iommu, domain);
 }
 
 /*
@@ -2273,6 +2317,7 @@ struct protection_domain *protection_domain_alloc(unsigned int type, int nid)
 	spin_lock_init(&domain->lock);
 	INIT_LIST_HEAD(&domain->dev_list);
 	INIT_LIST_HEAD(&domain->dev_data_list);
+	xa_init(&domain->iommu_array);
 	domain->iop.pgtbl.cfg.amd.nid = nid;
 
 	switch (type) {
-- 
2.31.1

