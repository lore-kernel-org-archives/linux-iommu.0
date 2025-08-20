Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2082.outbound.protection.outlook.com [40.107.102.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6666D2E337E
	for <iommu@lists.linux.dev>; Wed, 20 Aug 2025 11:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755689475; cv=fail; b=O6xqTndxCWhLH0GGo3OKsH43yOYf19LPdtNmA8nUJrM1f4XaW5NjsZy0DI84Ij4KX6tVO+seWjE+68LDI0JxDGoBD9Z+44KAYtuBNmqNxrUI6CdKTcVOQ1GLup6Xz3Psuc8Xem71JXT6i22v93q6N6UbivJLKzPlblQAbt/di1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755689475; c=relaxed/simple;
	bh=uVe6bOT+mQxRhTx8YD7C3b3RqFi5gimon2r08kYcVxo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sNt5pOrtpWfr3eovtq7NzlfkWPHgZyKEyXNqHbZUymb1Gmgc8F47aGk4CCWNYOOLONHsU57Wy670HlVMgnEtCmzxyKa0igJ7uZd7wibnLD3s4QJPkEOgmjn820Mi4rvoTLxgmTqyTGSG98Y2J8w2gq1L2WFalXlC4hacLN5xZ+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BUopBDcp; arc=fail smtp.client-ip=40.107.102.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BUopBDcp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u4dYvSN9h61mArMblYVsdKQPeB94HxtObfswi+E9PfSXpEAjT8lyqu8iJpgKVBgpruDSFqtaK0gv4NR9ftdDWOn/hnCmV+y0DxC1xZw7Ak7Xo4FHkGdjFSZO0ydO8aqxLQ+Bpi5yVj2wlFJFjlYVYg1vov8ZJwh/I2Z6JMjixdH+BVFqrsz2+qq/ekOLGblwQI/21XkZmQ+0xft6Nzr0qgDe4ph1flQJExKKe/JG9SHXqt97AqTEMQOP7dwD3B+i7uefi/zLMXmFQaPE5SYqXP27RM6NjTOeYWdjVO//XFo+WM8dnAAPrR02st3gUUNbUMD2S2RubVWVmsUjW8aAmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1kONVt9iZJ2EqyJWpQzyiEbQbEHFDWPUdLH2mjTno8=;
 b=u6CsOzZN40jsXxwJqPBdZJEtoe0VSzbwLK12K041pa7uE5MPh2hqiVvL2QSqqzwkxb2Aef8IRkMSncTFphcKu21Qa/rsZXVSPOoEaulo3QrWbXkykZzbhAIaivoUsNZx10iYiNLcrSscrtI1gzrXo5Lbx9pY+NU9ukGf+NCGas0Aw/7BkxB+8eodqFjZHcf2ZmtBGL2g4wFwAORuyB0qDcmigRNA8v57SioxCMBNf7qNw2FJ+Dvey63lNsL12t/Fg9NfW77jiquaIiRCysuhH0KcJOvsPGGEs4Wg0BF+x6kwrFIvBazm+LAjvPXBcU9MaNRVk5kAAZ5lTMMdP45uXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1kONVt9iZJ2EqyJWpQzyiEbQbEHFDWPUdLH2mjTno8=;
 b=BUopBDcpwz+YfANrZrOXHUCRWp2w+GbhnQ8GxiWZBduXYf+kvVIDRqSvMh7BFt5qcpMzQj459XTsZhUVKRy7/7YG/BCH8koYxR8ANnB/u+D7yIfgSzwM/5IBsIo751V5DsgapG1JovPvHG2FHHtb8iBzW+ofVi+QzIy+WjSa0Tc=
Received: from BLAP220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::29)
 by SA0PR12MB4382.namprd12.prod.outlook.com (2603:10b6:806:9a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.16; Wed, 20 Aug
 2025 11:31:10 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:208:32c:cafe::79) by BLAP220CA0024.outlook.office365.com
 (2603:10b6:208:32c::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 11:31:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.0 via Frontend Transport; Wed, 20 Aug 2025 11:31:10 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 06:31:04 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <jgg@nvidia.com>, <nicolinc@nvidia.com>
CC: <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>, <will@kernel.org>,
	<joro@8bytes.org>, <kevin.tian@intel.com>, <jsnitsel@redhat.com>,
	<vasant.hegde@amd.com>, <iommu@lists.linux.dev>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH 8/8] iommu/amd: Add support for nested domain attach/detach
Date: Wed, 20 Aug 2025 11:30:09 +0000
Message-ID: <20250820113009.5233-9-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250820113009.5233-1-suravee.suthikulpanit@amd.com>
References: <20250820113009.5233-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|SA0PR12MB4382:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f772652-7391-4596-05f8-08dddfdd0ff2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3ud3ojJGMYKy/4o/ULhfd/TzZVFQFUjzTIEL7eFC5+ZuJAnlNDSFBP5+dncE?=
 =?us-ascii?Q?hFg+ER5Ap5Yw1EsDChJsNnPIZ/XBzQmRYU9QY9AUk+cPZZhKiR5YTBr9q68k?=
 =?us-ascii?Q?wnrqUQrcKeVDLichCy6cm42KA97nuugOsUQP/+zc+u2f2MohdffH5x4yeEIK?=
 =?us-ascii?Q?/JqAiYGXjMb6YZ/F47o0elVjNn9WcUb+nzaEM5y4kqCS0BbmDiznWJlpIj0q?=
 =?us-ascii?Q?qVR78pfYog1vk33Jd8+QZ/yb2FcrAdf6PcAWx23u1Ncxbtmi+rjTo7DcBhKY?=
 =?us-ascii?Q?OQyBOzHGTwHzMTXPlF3jnFKAj2jv0LNjdlLAeL8USOVfWMqutI15rIm2a0bQ?=
 =?us-ascii?Q?SUu2PWFWMoYybIRVzz2w1CxbIZHUjM/vMs0qC0fkfCNPwbMFAfj2ykIE5BB1?=
 =?us-ascii?Q?C4H9OHAjTUUT0PEies8rusjuc/5dH1z0ZDGRN5Wf0hVb52eGalbY3d7vjj8t?=
 =?us-ascii?Q?xVPHXbaXlWacp4yCl4Zd7m5HqBdjzZPu3UPJoP2Z2JGuKMpAcxkUnCARqlJa?=
 =?us-ascii?Q?pWHMugO7DlnDgIydBUAj9p2fG7eRZ4L0aWLnfwIibNdxcFr3B/m+Soplluaa?=
 =?us-ascii?Q?0D8REJZkm1U/pezCDo9bejcwv/O26Yse/msZBQxTQ87SlQd2AWLBp7nAdIfH?=
 =?us-ascii?Q?EL/hz903YNwaoTfsTQ4ZGiyUUvy8MjW3T+807/+xqFSgQFkPGU31i3APLwhY?=
 =?us-ascii?Q?+9CmcsxHgmXj0eFHwgSWr7BuEY10WQs2P1mrP5eKYs2Ol9w3EFa338npTPpg?=
 =?us-ascii?Q?MGKREC/Ko0h0tmIQ7O6nRnW1lAtfmLx9wdo1rYEKU1q6i+uonfAJhNs9co0p?=
 =?us-ascii?Q?O2eHzPiPGewAMChVijGLP25Qqb3CGSAtBwT+1tTMN67v0nEu5n8IqfQCwP03?=
 =?us-ascii?Q?Q+T2a+k3QGCChLObSBbytWL3+AZ4W+cO9DFa+F5co1Fu0qzw/BDSF3vcz2Y0?=
 =?us-ascii?Q?G7ifTVEgG2Qpq6ef//Z66O5Qujy3HhV5/E4Q6utUFA5EzK2m8BEbChOkTjSM?=
 =?us-ascii?Q?rd76oV68R3lGgoBn8GDPpSsMCZGi/mc3bac19ps1+EBX2xRBfzBcO0izKa1J?=
 =?us-ascii?Q?DGF2ja8jKyjSO59YXm4efK4WT+jYABeQ5Q7hAAvLzzmPnRsmaVckILGf49xD?=
 =?us-ascii?Q?oofDERNnVHbbT2kjipMRICEayOFDm+UqzMtb+eRQCwmPInPhxI25gyBQPsim?=
 =?us-ascii?Q?fVHyEJSTgZydmaBH37m22qkoBnPYgcUh4F+ccnUgqqW7077r3/jwVkkJAAKw?=
 =?us-ascii?Q?XcC49V3W2ULeKK0Equ8TuloH6CTHrh7lAm6w2WRvFJ1/2VydVAezwkJI7Fp5?=
 =?us-ascii?Q?tVAZODVoa0CL4CgLneKoQ4LwNbx4P8XbHDB7cZp9NtIVmds9+TgT675/4piw?=
 =?us-ascii?Q?DgmfMZUe8l2ItwGjEt+M5D2lt/m70vBG5zMdu9npHRkeSSU+pWeuDixCb8F5?=
 =?us-ascii?Q?1sL+x1bnkNP4h7VjR/7KIWGKNAXozCwsNNKiavSDDo5R5ZpJUjjuQQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 11:31:10.3371
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f772652-7391-4596-05f8-08dddfdd0ff2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4382

Programs guest translation settings in the host DTE when attaches the
nested domain to a device.

Also, enable the GCR3TRPMode feature when supported.

Note that nested translation is only supported with the GCR3TRP mode.
When it is enabled, the AMD IOMMU driver programs the GCR3 Table Root
Pointer field of the device table entry with the GPA provided by the guest.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  5 ++
 drivers/iommu/amd/init.c            |  3 ++
 drivers/iommu/amd/iommu.c           | 49 +++++++++++++++---
 drivers/iommu/amd/nested.c          | 80 +++++++++++++++++++++++++++--
 4 files changed, 127 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 94f51a09b364..f8c392aadeb1 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -191,6 +191,7 @@
 #define CONTROL_EPH_EN		45
 #define CONTROL_XT_EN		50
 #define CONTROL_INTCAPXT_EN	51
+#define CONTROL_GCR3TRPMODE	58
 #define CONTROL_IRTCACHEDIS	59
 #define CONTROL_SNPAVIC_EN	61
 
@@ -420,6 +421,8 @@
 #define DTE_FLAG_V	BIT_ULL(0)
 #define DTE_FLAG_TV	BIT_ULL(1)
 #define DTE_FLAG_HAD	(3ULL << 7)
+#define DTE_FLAG_PPR	BIT_ULL(52)
+#define DTE_FLAG_GLX	BIT_ULL(53)
 #define DTE_FLAG_GIOV	BIT_ULL(54)
 #define DTE_FLAG_GV	BIT_ULL(55)
 #define DTE_GLX		GENMASK_ULL(57, 56)
@@ -555,6 +558,7 @@ struct amd_irte_ops;
 
 struct gcr3_tbl_info {
 	u64	*gcr3_tbl;	/* Guest CR3 table */
+	u64	trp_gpa;	/* Guest CR3 TRP GPA for nested domain */
 	int	glx;		/* Number of levels for GCR3 table */
 	u32	pasid_cnt;	/* Track attached PASIDs */
 	u16	domid;		/* Per device domain ID */
@@ -610,6 +614,7 @@ struct protection_domain {
 
 	struct protection_domain *parent; /* Nested parent domain */
 	struct iommu_hwpt_amd_v2 guest_hwpt;
+	u16 guest_paging_mode;	/* Guest paging mode */
 };
 
 /*
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 8de689b2c5ed..b340afd6901f 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -971,6 +971,9 @@ static void iommu_enable_gt(struct amd_iommu *iommu)
 		return;
 
 	iommu_feature_enable(iommu, CONTROL_GT_EN);
+
+	if (check_feature2(FEATURE_GCR3TRPMODE))
+		iommu_feature_enable(iommu, CONTROL_GCR3TRPMODE);
 }
 
 /* sets a specific bit in the device table entry. */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index ea790a8997ee..935eaffb6814 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1856,6 +1856,18 @@ static void free_gcr3_tbl_level2(u64 *tbl)
 	}
 }
 
+static inline bool amd_iommu_domain_is_nested(struct protection_domain *pdom)
+{
+	return (pdom && (pdom->domain.type == IOMMU_DOMAIN_NESTED));
+}
+
+static inline bool has_gcr3_table(struct gcr3_tbl_info *gcr3_info)
+{
+	if (!gcr3_info || (!gcr3_info->gcr3_tbl && !gcr3_info->trp_gpa))
+		return false;
+	return true;
+}
+
 static void free_gcr3_table(struct gcr3_tbl_info *gcr3_info)
 {
 	if (gcr3_info->glx == 2)
@@ -1901,7 +1913,7 @@ static int setup_gcr3_table(struct gcr3_tbl_info *gcr3_info,
 	if (levels > amd_iommu_max_glx_val)
 		return -EINVAL;
 
-	if (gcr3_info->gcr3_tbl)
+	if (has_gcr3_table(gcr3_info))
 		return -EBUSY;
 
 	/* Allocate per device domain ID */
@@ -2023,17 +2035,31 @@ static void set_dte_gcr3_table(struct amd_iommu *iommu,
 			       struct dev_table_entry *target)
 {
 	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
+	struct protection_domain *pdom = dev_data->domain;
 	u64 gcr3;
 
-	if (!gcr3_info->gcr3_tbl)
+	if (!has_gcr3_table(gcr3_info))
 		return;
 
-	pr_debug("%s: devid=%#x, glx=%#x, giov=%#x, gcr3_tbl=%#llx\n",
+	/* We need to check host capability before setting the mode.  */
+	if ((pdom->guest_paging_mode == PAGE_MODE_5_LEVEL) &&
+	    (amd_iommu_gpt_level < PAGE_MODE_5_LEVEL)) {
+		pr_err("Cannot support Guest paging mode=%#x (dom_id=%#x).\n",
+		       pdom->guest_paging_mode, pdom->id);
+		return;
+	}
+
+	pr_debug("%s: devid=%#x, glx=%#x, giov=%#x, gcr3_tbl=%#llx, trp_gpa=%#llx, type=%#x\n",
 		 __func__, dev_data->devid, gcr3_info->glx, gcr3_info->giov,
-		 (unsigned long long)gcr3_info->gcr3_tbl);
+		 (unsigned long long)gcr3_info->gcr3_tbl, gcr3_info->trp_gpa,
+		 pdom->domain.type);
 
 	gcr3 = iommu_virt_to_phys(gcr3_info->gcr3_tbl);
 
+	/* For nested domain, use GCR3 GPA provided */
+	if (gcr3_info->trp_gpa)
+		gcr3 = gcr3_info->trp_gpa;
+
 	target->data[0] |= DTE_FLAG_GV |
 			   FIELD_PREP(DTE_GLX, gcr3_info->glx) |
 			   FIELD_PREP(DTE_GCR3_14_12, gcr3 >> 12);
@@ -2044,7 +2070,7 @@ static void set_dte_gcr3_table(struct amd_iommu *iommu,
 			   FIELD_PREP(DTE_GCR3_51_31, gcr3 >> 31);
 
 	/* Guest page table can only support 4 and 5 levels  */
-	if (amd_iommu_gpt_level == PAGE_MODE_5_LEVEL)
+	if (pdom->guest_paging_mode == PAGE_MODE_5_LEVEL)
 		target->data[2] |= FIELD_PREP(DTE_GPT_LEVEL_MASK, GUEST_PGTABLE_5_LEVEL);
 	else
 		target->data[2] |= FIELD_PREP(DTE_GPT_LEVEL_MASK, GUEST_PGTABLE_4_LEVEL);
@@ -2061,7 +2087,14 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
 	struct dev_table_entry *dte = &get_dev_table(iommu)[dev_data->devid];
 
-	if (gcr3_info && gcr3_info->gcr3_tbl)
+	/*
+	 * For nested domain, use parent domain to setup v1 table
+	 * information and domain id.
+	 */
+	if (amd_iommu_domain_is_nested(domain))
+		domain = domain->parent;
+
+	if (has_gcr3_table(gcr3_info))
 		domid = dev_data->gcr3_info.domid;
 	else
 		domid = domain->id;
@@ -2293,7 +2326,8 @@ int __amd_iommu_attach_device(struct device *dev, struct protection_domain *doma
 		goto out;
 
 	/* Setup GCR3 table */
-	if (pdom_is_sva_capable(domain)) {
+	if (!amd_iommu_domain_is_nested(domain) && pdom_is_sva_capable(domain)) {
+		pr_warn("%s: Allocating guest page table\n", __func__);
 		ret = init_gcr3_table(dev_data, domain);
 		if (ret) {
 			pdom_detach_iommu(iommu, domain);
@@ -2519,6 +2553,7 @@ static int pdom_setup_pgtable(struct protection_domain *domain,
 		fmt = AMD_IOMMU_V1;
 		break;
 	case PD_MODE_V2:
+		domain->guest_paging_mode = amd_iommu_gpt_level;
 		fmt = AMD_IOMMU_V2;
 		break;
 	case PD_MODE_NONE:
diff --git a/drivers/iommu/amd/nested.c b/drivers/iommu/amd/nested.c
index 09f2a455af33..c9bf44e6298d 100644
--- a/drivers/iommu/amd/nested.c
+++ b/drivers/iommu/amd/nested.c
@@ -12,9 +12,7 @@
 #include "amd_iommu.h"
 #include "amd_iommu_types.h"
 
-const struct iommu_domain_ops nested_domain_ops = {
-	.free = amd_iommu_domain_free,
-};
+const struct iommu_domain_ops nested_domain_ops;
 
 static int udata_to_iommu_hwpt_amd_v2(const struct iommu_user_data *user_data,
 				       struct iommu_hwpt_amd_v2 *hwpt)
@@ -77,3 +75,79 @@ amd_iommu_domain_alloc_nested(struct device *dev, struct iommu_domain *parent,
 	kfree(pdom);
 	return ERR_PTR(-EINVAL);
 }
+
+static inline u64 hwpt_to_gcr3_trp(u64 *dte)
+{
+	u64 gcr3;
+
+	gcr3  = (FIELD_GET(DTE_GCR3_14_12, dte[0]) << 12);
+	gcr3 |= (FIELD_GET(DTE_GCR3_30_15, dte[1]) << 15);
+	gcr3 |= (FIELD_GET(DTE_GCR3_51_31, dte[1]) << 31);
+	return gcr3;
+}
+
+static int nested_gcr3_update(struct protection_domain *pdom, struct device *dev)
+{
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
+	struct iommu_hwpt_amd_v2 *hwpt = &pdom->guest_hwpt;
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	if (!pdev || !hwpt)
+		return -EINVAL;
+
+	/* Note: Currently only support GCR3TRPMode with nested translation */
+	if (!check_feature2(FEATURE_GCR3TRPMODE))
+		return -EOPNOTSUPP;
+
+	if (FIELD_GET(DTE_GPT_LEVEL_MASK, hwpt->dte[2]) == GUEST_PGTABLE_5_LEVEL)
+		pdom->guest_paging_mode = PAGE_MODE_5_LEVEL;
+	else
+		pdom->guest_paging_mode = PAGE_MODE_4_LEVEL;
+
+	dev_data->ppr = FIELD_GET(DTE_FLAG_PPR, hwpt->dte[0]);
+	dev_data->gcr3_info.glx = FIELD_GET(DTE_FLAG_GLX, hwpt->dte[0]);
+	dev_data->gcr3_info.giov = FIELD_GET(DTE_FLAG_GIOV, hwpt->dte[0]);
+	dev_data->gcr3_info.trp_gpa = hwpt_to_gcr3_trp(hwpt->dte);
+	/* Due to possible aliasing issue use nested domain ID */
+	dev_data->gcr3_info.domid = pdom->id;
+	pr_debug("%s: devid=%#x, domid=%#x, trp_gpa=%#llx, glx=%#x\n", __func__,
+		 pci_dev_id(pdev),
+		 dev_data->gcr3_info.domid,
+		 dev_data->gcr3_info.trp_gpa,
+		 dev_data->gcr3_info.glx);
+
+	return 0;
+}
+
+static int amd_iommu_nested_attach_device(struct iommu_domain *dom, struct device *dev)
+{
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
+	struct protection_domain *pdom = to_pdomain(dom);
+	struct pci_dev *pdev;
+	int ret;
+
+	if (dev_data->domain == pdom)
+		return 0;
+
+	ret = nested_gcr3_update(pdom, dev);
+	if (ret)
+		return ret;
+
+	if (dev_data->domain)
+		amd_iommu_detach_device(dev);
+
+	ret = __amd_iommu_attach_device(dev, pdom);
+	if (ret)
+		return ret;
+
+	pdev = dev_is_pci(dev_data->dev) ? to_pci_dev(dev_data->dev) : NULL;
+	if (pdev)
+		amd_iommu_pdev_enable_cap_ats(pdev);
+
+	return ret;
+}
+
+const struct iommu_domain_ops nested_domain_ops = {
+	.attach_dev = amd_iommu_nested_attach_device,
+	.free = amd_iommu_domain_free,
+};
-- 
2.34.1

