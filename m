Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2073.outbound.protection.outlook.com [40.107.96.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25AF1BDA94
	for <iommu@lists.linux.dev>; Fri, 16 Aug 2024 15:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723823051; cv=fail; b=gBwO1DcWhQ8fYSqvion2wHuSj2jt1GdGXnN3PXXBKKaRFeuBvXwEMi8qzJEwLj36PHfjjBimy4dq0WruGeL6ils+RnLj5FM0lbDaACrc0uocoTTb/MSPp6OXPrDzG/aJ8/obifnwPC+l/ckWnxVgtr0syjbjx7ZQ/UX/ATSH5Zg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723823051; c=relaxed/simple;
	bh=JELhRd9QSrIkuxEqKqWgkG+SkJi3xVWPH2/tGUfyL8Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HjfQ8Jx4kv3ci3XbBCTERypRqLEyiE7ZDBMw+7wVRG3XhJlxWty7xKbmQp2kCKiqNLHg1vBk6z3FkYxzRZR8jFiNLO6tEP9+FFHs1FzvkDjG0etND41BfI3RXe0m8Rjl2qGUgncrN6BQsds0Pw4L20ZtPTkvnooELGt8Tnp6i7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2oyeo8w5; arc=fail smtp.client-ip=40.107.96.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2oyeo8w5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BwJLX761MQEvgpQmxTI3vDTMk7wuOvUeXS6/A95oJm1DRqT5hmwnyckQ0r9v+6YTiZBBzFZC9dZMJ8CPeE2yF8QiGiHHPB4TnDhaPoE2UmzgL+W4dscK3wtMD551TqrYYFiCQ/7wcZw0IDC09GeY3xpV1zbBYGRTDZcnws00NHY4suXcYpLZVieqIo0XlSC1EhnnVZ6H1ZaYMFgWw1AZmj+x5kDJLBr1NKMsL90FiqaWEPi76SoBU84EQvs/bXjsNoKnzn4JMNkKRcMhmq4y+Xfr64fnM1ZH//CehneHh6xqfnsJ+Y4e2B35lLQdFQJRT1r5E/lzH4bTxNL+N6clrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40gJ53B/ZJu0TsgYOR4Naa8eA81os0MWIjTu5HPrisY=;
 b=Jtm/ZS8m5epxFoE8r6awgd1xroKI4Nhzjng7gBWru5Efhcho+Y3nT06+yFYds7h9t/yQ+PiWXuTSxWdPZBhH7QYK0fTmR9j6ULBl6aXKHy5D1F0z/QpOt7HgWREn0b6Hci9YqEsh9RryadICynH5A2ge+3lV7uoLRWFOf/OXwJqAzpO4prQl3DyxPma1JKIEhRALcTlFE379sgTKkitamDg85QovpAQCk9bRs8QrIDB/yErNVV64pX5X4ay0zU7JMsci1x2C3mP18qiR3d2azo0/Cu6vFSZ1ooqU8stZrUW0tnpZwhMEX3TKdONUoV4jR3qVj4aMPAjNSnf9XqljHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40gJ53B/ZJu0TsgYOR4Naa8eA81os0MWIjTu5HPrisY=;
 b=2oyeo8w5WAA/bT2YMhfl/8lmaACE8N0EPf4XYE7uke5NIIisRl4zAId1cSuMhA7wE23XzhPpYX39JwFek+QRTjEQfpDNhCMiiOb2Wdo/y1d7PeSKYTyWbZUuoZHH2lqKPoWmTYmqAIiTD/5AZdMUm6NE4pm3oViYHHR1hHWKyog=
Received: from PH0PR07CA0034.namprd07.prod.outlook.com (2603:10b6:510:e::9) by
 DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.19; Fri, 16 Aug 2024 15:44:02 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:510:e:cafe::88) by PH0PR07CA0034.outlook.office365.com
 (2603:10b6:510:e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.24 via Frontend
 Transport; Fri, 16 Aug 2024 15:44:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Fri, 16 Aug 2024 15:44:01 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 Aug
 2024 10:43:57 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<jon.grimm@amd.com>, <santosh.shukla@amd.com>, <pandoh@google.com>,
	<kumaranand@google.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH 2/2] iommu/amd: Refactor set_dte_entry to simplify GCR3 Table Root Pointer programming
Date: Fri, 16 Aug 2024 15:43:31 +0000
Message-ID: <20240816154331.5003-3-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816154331.5003-1-suravee.suthikulpanit@amd.com>
References: <20240816154331.5003-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|DS0PR12MB6560:EE_
X-MS-Office365-Filtering-Correlation-Id: d1a8cccd-9173-4722-8b4b-08dcbe0a4068
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ScKrp2jtLqkfwY7uPgjiiY9Z/XatIFGtUxVV7WtASV8OxEzD4LId+IO5M8le?=
 =?us-ascii?Q?Dxi+6DjLTt3sPfHaSogEH/nyhh2qquhAsTL2amJNdCZzlOfoH4BhJiLFNT0r?=
 =?us-ascii?Q?Zx+hAfDsIXIlRfLWkqEZQ77SnXvsZgs3NzfNmWElSA8nA3lo/mXH5accBw96?=
 =?us-ascii?Q?yEJaA9I+J2E1JKHHnuF6oD5wqy+HnlrF96cYkTtEMCmnTpv25/B+fDHsd7He?=
 =?us-ascii?Q?58Uqq/Sm2xTQQmMtJnrrVf7UcjCM7wThIl9KteahCjuirQnneRBArzKYw8DQ?=
 =?us-ascii?Q?nq7VM/TIM0Bs92zErcvG02bpU83yc9sJR5wLiYzb4kTToQF4cAPUxvczq3vi?=
 =?us-ascii?Q?wx4HBcPYDdj8sDz9HwOEbqEaOabBMNI6vIhalMU7jLU4junVZDdawGWIX+lx?=
 =?us-ascii?Q?9ai+Fn9Gc6Hw3BszpnHAonnBHxAV+NxXA5MsLBt5aojKiL4kt0Lh/mXNsQ41?=
 =?us-ascii?Q?7xZc1GUFqw9HiYZZ5m6Uc3kiPp0XrR05A8xPF62cyVXsX1YNEfMc+j+DJezn?=
 =?us-ascii?Q?4DlTe9F6kitgItUXcOplPn1eGHhzQZfLxII7GQeUrKpvJ92jOYRKM7zM0gda?=
 =?us-ascii?Q?kQOHVSeOamd2oDuxbNrvNq8ptBnM/rBpROHKlgQ0EEWZs+uytxbTa43kJqky?=
 =?us-ascii?Q?DBb1I9sbCsvjvNQTWRP6A861hcjvZC9FTsjfC8zOcc/Nb+kBp3uPbNdIfkDf?=
 =?us-ascii?Q?7hy5sZZB7CXkdzx+yL2LbmMWboCe3ENlc5tjwhRxhdWcNtHxvf+ftJxPuMSd?=
 =?us-ascii?Q?MVNoPZkiKtrcvVXxOVMVAewY9y1jgN4yuLqUGiryeZxcu8zsEgG7b86/AJS5?=
 =?us-ascii?Q?fhGEtIWC3Q2yz5B8whYh9DhRbAU9Gw3F0dCz0hhoTfNKC1l7r1PWD/NlPqkC?=
 =?us-ascii?Q?ReSJgpk3vzT6hIRxpzh8JvluuluAsV13B7LT9v8pQaJHLTpgUjPgQXPifGzy?=
 =?us-ascii?Q?3jG865c6K5VHigvTzkwz9bdp47xtTxOISnvDCB8oq/SHuJ4T1KWlJf541o8v?=
 =?us-ascii?Q?nnH0rz8fnQxz+0u+ch19cnUoh9n7UFcvne/0ISDah0mx4VWimVPSn5ipD8Aj?=
 =?us-ascii?Q?2yiC+kTh+mkhl2e5eQO5NIhUTqG5gnXTvoomGbwuaApYp20z4xV9Y2bqYo6/?=
 =?us-ascii?Q?aHikLQQnjgAW453AU6olpqUNiQqAu4jrRVWFCs/lLVlVr+bsCrHnaWS+n0Y+?=
 =?us-ascii?Q?gAtmRbUGPptw+84iJu5HjfzilReoCX27GUAeFIJGSkhH9OJ58KEVvkC36hST?=
 =?us-ascii?Q?Gf4rD/NFebNPZg5m4Uc5vfnokY7KUwHn57N3ba0pDTjkZXr+GNGQJt27GXb4?=
 =?us-ascii?Q?rhYrixisyqzt5jJ279a2XT1eJDx/t9QfSqe4ua6Lu6TaIvRZdd2Aszb9BArC?=
 =?us-ascii?Q?vT3wUGvTKi9FffFzpfCzxTy3pgzSrx5ojxN78WJJvaeKMdcob4LQgh2CIlZd?=
 =?us-ascii?Q?LMfYnGMC0ZiGt+D/AKK5DGznsei9M1ls?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 15:44:01.7436
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1a8cccd-9173-4722-8b4b-08dcbe0a4068
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6560

Separate logic for setting DTE[GCR3 Table Root Pointer] into a helper
function set_dte_gcr3_table().

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 121 +++++++++++++++++++++-----------------
 1 file changed, 68 insertions(+), 53 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 4667b6c4906f..8fc496db5560 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1851,90 +1851,105 @@ int amd_iommu_clear_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid)
 	return ret;
 }
 
+static void set_dte_gcr3_table(struct amd_iommu *iommu,
+			       struct iommu_dev_data *dev_data,
+			       struct dev_table_entry *target)
+{
+	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
+	u64 tmp, gcr3;
+
+	if (!gcr3_info->gcr3_tbl)
+		return;
+
+	pr_debug("%s: devid=%#x, glx=%#x, giov=%#x, gcr3_tbl=%#llx\n",
+		 __func__, dev_data->devid, gcr3_info->glx, gcr3_info->giov,
+		 (unsigned long long)gcr3_info->gcr3_tbl);
+
+	tmp = gcr3_info->glx;
+	target->data[0] |= (tmp & DTE_GLX_MASK) << DTE_GLX_SHIFT;
+	if (gcr3_info->giov)
+		target->data[0] |= DTE_FLAG_GIOV;
+	target->data[0] |= DTE_FLAG_GV;
+
+	/* First mask out possible old values for GCR3 table */
+	tmp = DTE_GCR3_VAL_A(~0ULL) << DTE_GCR3_SHIFT_A;
+	target->data[0] &= ~tmp;
+	tmp = DTE_GCR3_VAL_B(~0ULL) << DTE_GCR3_SHIFT_B;
+	tmp |= DTE_GCR3_VAL_C(~0ULL) << DTE_GCR3_SHIFT_C;
+	target->data[1] &= ~tmp;
+
+	gcr3 = iommu_virt_to_phys(gcr3_info->gcr3_tbl);
+
+	/* Encode GCR3 table into DTE */
+	tmp = DTE_GCR3_VAL_A(gcr3) << DTE_GCR3_SHIFT_A;
+	target->data[0] |= tmp;
+	tmp = DTE_GCR3_VAL_B(gcr3) << DTE_GCR3_SHIFT_B;
+	tmp |= DTE_GCR3_VAL_C(gcr3) << DTE_GCR3_SHIFT_C;
+	target->data[1] |= tmp;
+
+	/* Use system default */
+	tmp = amd_iommu_gpt_level;
+
+	/* Mask out old values for GuestPagingMode */
+	target->data[2] &= ~(0x3ULL << DTE_GPT_LEVEL_SHIFT);
+	target->data[2] |= (tmp << DTE_GPT_LEVEL_SHIFT);
+}
+
 static void set_dte_entry(struct amd_iommu *iommu,
 			  struct iommu_dev_data *dev_data)
 {
-	u64 pte_root = 0;
-	u64 flags = 0;
-	u32 old_domid;
-	u16 devid = dev_data->devid;
 	u16 domid;
+	u16 devid = dev_data->devid;
 	struct protection_domain *domain = dev_data->domain;
+	struct dev_table_entry target = {.data = {0, 0, 0, 0}};
 	struct dev_table_entry *dev_table = get_dev_table(iommu);
 	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
+	u32 old_domid = dev_table[devid].data[1] & DEV_DOMID_MASK;
 
-	if (gcr3_info && gcr3_info->gcr3_tbl)
+	if (gcr3_info->gcr3_tbl)
 		domid = dev_data->gcr3_info.domid;
 	else
 		domid = domain->id;
 
+	/*
+	 * Need to get the current value in dte[1,2] because they contain
+	 * interrupt-remapping settings, which has been programmed earlier.
+	 */
+	target.data[1] = dev_table[devid].data[1];
+	target.data[2] = dev_table[devid].data[2];
+
 	if (domain->iop.mode != PAGE_MODE_NONE)
-		pte_root = iommu_virt_to_phys(domain->iop.root);
+		target.data[0] = iommu_virt_to_phys(domain->iop.root);
 
-	pte_root |= (domain->iop.mode & DEV_ENTRY_MODE_MASK)
+	target.data[0] |= (domain->iop.mode & DEV_ENTRY_MODE_MASK)
 		    << DEV_ENTRY_MODE_SHIFT;
 
-	pte_root |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_V;
+	target.data[0] |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_V;
 
 	/*
 	 * When SNP is enabled, Only set TV bit when IOMMU
 	 * page translation is in use.
 	 */
 	if (!amd_iommu_snp_en || (domid != 0))
-		pte_root |= DTE_FLAG_TV;
-
-	flags = dev_table[devid].data[1];
+		target.data[0] |= DTE_FLAG_TV;
 
 	if (dev_data->ats_enabled)
-		flags |= DTE_FLAG_IOTLB;
+		target.data[1] |= DTE_FLAG_IOTLB;
 
 	if (dev_data->ppr)
-		pte_root |= 1ULL << DEV_ENTRY_PPR;
+		target.data[0] |= 1ULL << DEV_ENTRY_PPR;
 
 	if (domain->dirty_tracking)
-		pte_root |= DTE_FLAG_HAD;
-
-	if (gcr3_info && gcr3_info->gcr3_tbl) {
-		u64 gcr3 = iommu_virt_to_phys(gcr3_info->gcr3_tbl);
-		u64 glx  = gcr3_info->glx;
-		u64 tmp;
-
-		pte_root |= DTE_FLAG_GV;
-		pte_root |= (glx & DTE_GLX_MASK) << DTE_GLX_SHIFT;
-
-		/* First mask out possible old values for GCR3 table */
-		tmp = DTE_GCR3_VAL_B(~0ULL) << DTE_GCR3_SHIFT_B;
-		flags    &= ~tmp;
+		target.data[0] |= DTE_FLAG_HAD;
 
-		tmp = DTE_GCR3_VAL_C(~0ULL) << DTE_GCR3_SHIFT_C;
-		flags    &= ~tmp;
-
-		/* Encode GCR3 table into DTE */
-		tmp = DTE_GCR3_VAL_A(gcr3) << DTE_GCR3_SHIFT_A;
-		pte_root |= tmp;
-
-		tmp = DTE_GCR3_VAL_B(gcr3) << DTE_GCR3_SHIFT_B;
-		flags    |= tmp;
-
-		tmp = DTE_GCR3_VAL_C(gcr3) << DTE_GCR3_SHIFT_C;
-		flags    |= tmp;
-
-		if (amd_iommu_gpt_level == PAGE_MODE_5_LEVEL) {
-			dev_table[devid].data[2] |=
-				((u64)GUEST_PGTABLE_5_LEVEL << DTE_GPT_LEVEL_SHIFT);
-		}
-
-		/* GIOV is supported with V2 page table mode only */
-		if (pdom_is_v2_pgtbl_mode(domain))
-			pte_root |= DTE_FLAG_GIOV;
-	}
+	target.data[1] &= ~DEV_DOMID_MASK;
+	target.data[1] |= domid;
 
-	flags &= ~DEV_DOMID_MASK;
-	flags |= domid;
+	set_dte_gcr3_table(iommu, dev_data, &target);
 
-	old_domid = dev_table[devid].data[1] & DEV_DOMID_MASK;
-	dev_table[devid].data[1]  = flags;
-	dev_table[devid].data[0]  = pte_root;
+	dev_table[devid].data[0] = target.data[0];
+	dev_table[devid].data[1] = target.data[1];
+	dev_table[devid].data[2] = target.data[2];
 
 	/*
 	 * A kdump kernel might be replacing a domain ID that was copied from
-- 
2.34.1

