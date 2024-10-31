Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01931CDFCC
	for <iommu@lists.linux.dev>; Thu, 31 Oct 2024 18:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730400224; cv=fail; b=YIgEtGlWeWd+PxW73xP+fKDSrgdjYXddZhG/cABmgFF9GgEaHAPjQ2cJJAK4LOBwtHH7ck57PJEYDocGcD5kww4Ai+nmQzBT4lCxzXvi/62RsjyPaVGogHB1MgjIr6V1AjOkdnlwovRH5mUjVddC0afF22qWJeh6IpYm95dRi54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730400224; c=relaxed/simple;
	bh=xeRWW4zvUqOpuR1sVQhIMdgRFyuKd3lvLAJ/acdf0LI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r2q9XyDfkbfbKy6VT7ufqy18GUZFg647Hr6ktRHOZgZqS57m14yp3pLcxh3CjYyrVvFX4NwJhnvkrIt+AqKXKeyCAmMl+TlytxucC093+hov/4W+UHjRVOcGQfKNrhnpNOVrm6EirBA8ksGLRzZK9lvHR7wCf/6KhBBf4RHmea0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Fp0Q9Lu0; arc=fail smtp.client-ip=40.107.236.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Fp0Q9Lu0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=muLgBFReyxBG0VooTCaB2du00i2lnoknTVUitgyflbtWgnMDPJnqX0SVO3eWOWO/g4S5v+EnlulNXkKcEQiXd99+qCVjA76V0HjucFdXjQmo/ZbDi2fwO2ubD5B97LVeVlvNVwnQtlUDOcvf+J4rfCRU9JwfplD6JhyBs/95N6Z1eBTMt259MHsOv4bbWexiD6vLFvg61xm/ejiFmoAxxE8qvX6t2BWMCw7ytKmFyvSCPHWMc0SfvY2dCS+tMT16vy64d30mRQtWs6yM1O7tmsT+zIPcQK9DHafS4AezHUluDWz7GQIpE21imRJB2k1a1YpyBWWDDj7rpnKEk7evHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uD4cARgDgWSDiPEKNunLs9w1VM/I4QbMZNF8q0H489I=;
 b=eBY3IvvFMgKCB/1SevtD2GpIhlGrADhn/3/z8aJvxJfW0Z2ECdMt+/WDIaV6BALI9W0tasY/J7lxp2uXtJa+7bMZsWyGxNWG5Cd4daZxamHryNVJSCJCXIZhHeAX4fIwD5ZHaUZlZ0z3R7FpBQgkzrFIoHChO/hvcUUs6/hZmy6xjImvsp7pPh46z5Uh9cTrHAxTaTYllqgKU9EfEb8qHrL0zM1rvr+V83QSHm8t9RsOyynSJx0ZNx38FIZVwKKB7Z4+wMU34pFacJp+flOYW5DgrY8r4SNQjT3V72MJeabUbVO9N7Xzwuq9dT4WFUkEdkTz5mkRJHMURckwCe3ehg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uD4cARgDgWSDiPEKNunLs9w1VM/I4QbMZNF8q0H489I=;
 b=Fp0Q9Lu0nFvD7mdtKviUjTYW7wh4nDcsyZdsgk/Llb4bi/veYO6wGb9TsPQjx+Qr8poUcM7S/uEit5AfM60s8r4uFPuTMRPrI51ir9eLEOMvSQL94SyGP7TQuaGDF9V2d5hpy6iRCAclJt0xcdDq1ER3IWGTv4vFjEXsD+MhwHg=
Received: from CH0PR07CA0026.namprd07.prod.outlook.com (2603:10b6:610:32::31)
 by DS0PR12MB7512.namprd12.prod.outlook.com (2603:10b6:8:13a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Thu, 31 Oct
 2024 18:43:39 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::c4) by CH0PR07CA0026.outlook.office365.com
 (2603:10b6:610:32::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.22 via Frontend
 Transport; Thu, 31 Oct 2024 18:43:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 18:43:39 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 31 Oct
 2024 13:43:34 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v8 10/10] iommu/amd: Remove amd_iommu_apply_erratum_63()
Date: Thu, 31 Oct 2024 18:42:43 +0000
Message-ID: <20241031184243.4184-11-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241031184243.4184-1-suravee.suthikulpanit@amd.com>
References: <20241031184243.4184-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|DS0PR12MB7512:EE_
X-MS-Office365-Filtering-Correlation-Id: b4f7f344-3a8f-4ab2-7cef-08dcf9dbefb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SfcWFkeysRjH9Hztau43tGyc+QQ30p0sRaSCKqulHqy4zAxgFgHpWKGpru/7?=
 =?us-ascii?Q?wbkpLmvy7XeBRhrZsjFqTHC65Kw1f5ArdhMmKxUm54q77cd8y9XNL1DYAkN1?=
 =?us-ascii?Q?l+57ShrB9qNzX4EcyGcmfFi4SfyntE630obCz+LVFUdKEnmhbStcCcsj9K8/?=
 =?us-ascii?Q?FgCyeWZ9hLwXaYVFbea2ptuPMv2PhddZ+kNG5dOA0/XywVrgaQOwp8F657Ow?=
 =?us-ascii?Q?XYUxrToXlrxMaqVdN13sPZyGoquDeUJR7yt3bXhw48fOn94wzM8M6Hma7V+6?=
 =?us-ascii?Q?RsHPfyzHemfahnfIaKT3toh9/5aQ3aaBD95z/zZmRxDFBb5Vw6/bYh1wJq0Q?=
 =?us-ascii?Q?dE0Pol6L8FhKBAb3UML3xhbxKM5bnDkqN5kvpmR8JeiZKomX7o4mvvAZ+oCJ?=
 =?us-ascii?Q?rj99qpLG2LBgXaB1EXFMfk64zsX4AN60u25mcbP0I7KqEUpKzUr+kg/fW8h2?=
 =?us-ascii?Q?yNjItVS3FBm3AdKFoLPxlyZ+c2cXgiWoGIAnoV3qOB8EhZV6Flx4QmBx6onM?=
 =?us-ascii?Q?OfTJzf2UQOMX5ILqALnwBzGDk1pT0gcSSVMXeaKeNC6bCfMXFBZV64momj2k?=
 =?us-ascii?Q?/fxgElJn8mlZZC1IXKnZ4XKeQZGsonks5luEbHjvUD1TSb+1LqjHGD9a7Gmk?=
 =?us-ascii?Q?IwhAQ5l03rEAaFVn1vi+H2Mh+eDBWoiFut7FJbI30/e8a/+LaDJodZZeSFbB?=
 =?us-ascii?Q?XZOZ1aUruOh6EMWQpP3MaqsWVJroNDaagI9s33o/gEtQFozCNbSbjzQ7oyFN?=
 =?us-ascii?Q?xX9mcBO4HPctWbrlmMLEnT3rVUrs1Uz2mhrIcZKdm2Jxe6lv/uc9wnCQXx61?=
 =?us-ascii?Q?fu/yGXrx+LhMsBx6Myho5OxyeIyfl7RR9qMl2F57p+lsG87I6qE6ssDv/yuv?=
 =?us-ascii?Q?k5IEi3tQzOG9KrMYYm8W9fxfLlJn7hxca5sVmFp7msvAXx9miWyWrBs1BHha?=
 =?us-ascii?Q?AEpqFF7CHKZGK1ecD3t5Gr8rCWu++HJI5oh28dcmXt7M/A3sOpfbi3/lbO+0?=
 =?us-ascii?Q?G6PG0at/APvLLv5JFxECmCziONegt3qYMWNUfUeJElMZp3Hj6WcQzE46t3zy?=
 =?us-ascii?Q?TZCCRIIzArZd6eaiF+Yeqa3BHL/TG58qcLMEGrBQ4PV9mFwAE2UFDFBZm58q?=
 =?us-ascii?Q?hqggDo/ZlDXubYpth7HEMgU2JHgn8gAmB/jw7IRNiV2sPK8MbghPsPJWJsP8?=
 =?us-ascii?Q?rg6wr1kmhyJjQ/8Xb7ra8ywnJ+u8i7OJvgN8QaU3Kd48EdgVbRI1nD8GtaOx?=
 =?us-ascii?Q?aqtgNnS1Kqoi83QIDoaagBlDjWUSRyXNtWsHEppm1afMaMEvjH+qiT9oGlOI?=
 =?us-ascii?Q?bh8sMlgDE2RzseIdwkqIklfCnITxyXJSB1t6cfOc0IxWtCD4uL5YH8uE38Y3?=
 =?us-ascii?Q?q5JdZfyzPP5qCPERpg5IFuTQCeHg+VQqRyAC2dUGxujEdwMzkg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 18:43:39.3895
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4f7f344-3a8f-4ab2-7cef-08dcf9dbefb9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7512

Also replace __set_dev_entry_bit() with set_dte_bit() and remove unused
helper functions.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  1 -
 drivers/iommu/amd/init.c      | 50 +++--------------------------------
 2 files changed, 3 insertions(+), 48 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 3bdceff30abf..ae7332995d8d 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -16,7 +16,6 @@ irqreturn_t amd_iommu_int_thread_evtlog(int irq, void *data);
 irqreturn_t amd_iommu_int_thread_pprlog(int irq, void *data);
 irqreturn_t amd_iommu_int_thread_galog(int irq, void *data);
 irqreturn_t amd_iommu_int_handler(int irq, void *data);
-void amd_iommu_apply_erratum_63(struct amd_iommu *iommu, u16 devid);
 void amd_iommu_restart_log(struct amd_iommu *iommu, const char *evt_type,
 			   u8 cntrl_intr, u8 cntrl_log,
 			   u32 status_run_mask, u32 status_overflow_mask);
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 6821ec7f3f8f..84c0fd483550 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1001,38 +1001,6 @@ static void set_dte_bit(struct dev_table_entry *dte, u8 bit)
 	dte->data[i] |= (1UL << _bit);
 }
 
-static void __set_dev_entry_bit(struct dev_table_entry *dev_table,
-				u16 devid, u8 bit)
-{
-	int i = (bit >> 6) & 0x03;
-	int _bit = bit & 0x3f;
-
-	dev_table[devid].data[i] |= (1UL << _bit);
-}
-
-static void set_dev_entry_bit(struct amd_iommu *iommu, u16 devid, u8 bit)
-{
-	struct dev_table_entry *dev_table = get_dev_table(iommu);
-
-	return __set_dev_entry_bit(dev_table, devid, bit);
-}
-
-static int __get_dev_entry_bit(struct dev_table_entry *dev_table,
-			       u16 devid, u8 bit)
-{
-	int i = (bit >> 6) & 0x03;
-	int _bit = bit & 0x3f;
-
-	return (dev_table[devid].data[i] & (1UL << _bit)) >> _bit;
-}
-
-static int get_dev_entry_bit(struct amd_iommu *iommu, u16 devid, u8 bit)
-{
-	struct dev_table_entry *dev_table = get_dev_table(iommu);
-
-	return __get_dev_entry_bit(dev_table, devid, bit);
-}
-
 static bool __copy_device_table(struct amd_iommu *iommu)
 {
 	u64 int_ctl, int_tab_len, entry = 0;
@@ -1184,17 +1152,6 @@ static bool search_ivhd_dte_flags(u16 segid, u16 first, u16 last)
 	return false;
 }
 
-void amd_iommu_apply_erratum_63(struct amd_iommu *iommu, u16 devid)
-{
-	int sysmgt;
-
-	sysmgt = get_dev_entry_bit(iommu, devid, DEV_ENTRY_SYSMGT1) |
-		 (get_dev_entry_bit(iommu, devid, DEV_ENTRY_SYSMGT2) << 1);
-
-	if (sysmgt == 0x01)
-		set_dev_entry_bit(iommu, devid, DEV_ENTRY_IW);
-}
-
 /*
  * This function takes the device specific flags read from the ACPI
  * table and sets up the device table entry with that information
@@ -2650,9 +2607,9 @@ static void init_device_table_dma(struct amd_iommu_pci_seg *pci_seg)
 		return;
 
 	for (devid = 0; devid <= pci_seg->last_bdf; ++devid) {
-		__set_dev_entry_bit(dev_table, devid, DEV_ENTRY_VALID);
+		set_dte_bit(&dev_table[devid], DEV_ENTRY_VALID);
 		if (!amd_iommu_snp_en)
-			__set_dev_entry_bit(dev_table, devid, DEV_ENTRY_TRANSLATION);
+			set_dte_bit(&dev_table[devid], DEV_ENTRY_TRANSLATION);
 	}
 }
 
@@ -2680,8 +2637,7 @@ static void init_device_table(void)
 
 	for_each_pci_segment(pci_seg) {
 		for (devid = 0; devid <= pci_seg->last_bdf; ++devid)
-			__set_dev_entry_bit(pci_seg->dev_table,
-					    devid, DEV_ENTRY_IRQ_TBL_EN);
+			set_dte_bit(&pci_seg->dev_table[devid], DEV_ENTRY_IRQ_TBL_EN);
 	}
 }
 
-- 
2.34.1

