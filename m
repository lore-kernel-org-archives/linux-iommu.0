Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295381CB31F
	for <iommu@lists.linux.dev>; Thu, 31 Oct 2024 18:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730400195; cv=fail; b=beshEszX9xLiR+Md5RhTU/8TSvRoAFPhZgDdkISEFqkghaq8TzR1mdQUF3DIsL2C6Gb66QlHFgKgWnrq7Vvy42wha3LW+kjwqm4RW3AqJhxQQ2ZyG2loF+mrkxSZb5cShyeYfSJ/R0tqiw9xJuAweBKgRq5uq9tKS1OEbpoZLb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730400195; c=relaxed/simple;
	bh=/B9ONeJZvFX/uLGZdTC73vVJnB4rukuiJQn0V67ePkk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=poxu43M+pwaJOVR2Bp89HiI/nWc38KS1oZACZFzS5L1z5s4JVh+7AC5OQwy/bRnTiuN8jCOYVqGOgVgpZGbs5brPnhTULUM6ylA1MTri9AsBb66Kpga4uD1B1gnDVFFdWm9syKqlWFQxf0QOZgUhBqWRnzN6slT933356Ozjx6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RVAmyxoO; arc=fail smtp.client-ip=40.107.237.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RVAmyxoO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t0Y9yimds6wbhxRNqo/v9yDrbRAoZhP+O+1tmG0D7Ft0BCacLu8qf2/wBr/iwvTvnZfHYPha61fTSPkjMtBVSJjsC8bV0WoS5Yo9tdYrS9qY7cSgzmi2iiSSAm9jmedIXg193KinZIfOAUC7dNp36pcuOSAXfAOj6fJwfRBdf2Rb7uOxgI/ZJj4iSzct1T5mvCfFOM8b6haOu+XjMZKJ3j28Fmcl78gWypNhmj/gBMhc5IWTL6DN6/Qn0RIqfKHQ43J6aBQyMacdZPkkmGS9XezgWXaUavrCbOIRdD25kH2ChvZUslmR0g7NlaU29OSbHGwC2oAO1JjiFdwUMWa4Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iclqgk50i33J5FbXKPZlqFmeW7ZTFcvXwbAE9Vt4Xes=;
 b=ioJMiVZ6g9dUHf+JlXm61YMHbSvO4mUiDxAV/0h1olBYe2hM4RAML8VbaE4RoBO3Pc4oERFheqlt0OeKUHnXwbYZaMlWeaSptCHq6J65a7Qm7FpLo9FpmH172SUMutzSB0EoEVcnyyVS4+cw/DCfsHzXOwQJhMZLrvWPkrbPRekMkfro+bFh4rRlg+vobO1cVjRGfEgphGFLHrzMi+wgpfW8LwexGTNNTL7cfzOD7OBCf9jJtcFCOQ+aUXY8Mh7GmuJ3bm+Pg3eQRgtPEUbMMqhs5iLGy4G7kty8TEHpG8IC1xsM2Ms5Y/3kQbFMnIpcqjwy7yi4wLNb21sccpq3ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iclqgk50i33J5FbXKPZlqFmeW7ZTFcvXwbAE9Vt4Xes=;
 b=RVAmyxoOPdbWX3+DbVvqK6Pj+PflQwSQL2y1kMIYHBjjwYK29KkbU2WIyZW9zEdSgDD81djy10fN35aQJzOS/jAjzltBXWJSperjU5lHwmD4BU587DjcIIIcqrMeWm6nHjzABvfSBUYl0p76wt3+bcinCV3ik+sVj2HwFujp/4U=
Received: from CH0PR03CA0222.namprd03.prod.outlook.com (2603:10b6:610:e7::17)
 by SA3PR12MB8803.namprd12.prod.outlook.com (2603:10b6:806:317::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Thu, 31 Oct
 2024 18:43:09 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:e7:cafe::e4) by CH0PR03CA0222.outlook.office365.com
 (2603:10b6:610:e7::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.22 via Frontend
 Transport; Thu, 31 Oct 2024 18:43:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 18:43:09 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 31 Oct
 2024 13:43:05 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v8 02/10] iommu/amd: Disable AMD IOMMU if CMPXCHG16B feature is not supported
Date: Thu, 31 Oct 2024 18:42:35 +0000
Message-ID: <20241031184243.4184-3-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|SA3PR12MB8803:EE_
X-MS-Office365-Filtering-Correlation-Id: a7d87f5d-5d0d-4256-c036-08dcf9dbddb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e9gyneDDCbmQAGCUNhmyK+5LJjezFfLkGdeBbOdB8tSFn/cZlOc3Howq8g3Q?=
 =?us-ascii?Q?B5tP6rpxLp60c9NEKluy1PHEbfRVhHnaqsF/F/Au/NTkWJT0wn83/bn+xXPO?=
 =?us-ascii?Q?U9q3LvnF1dYC0g6ICRMJ5pm/p6WSrgJwDY+u61mDu0p2JKg0q6KiBwee/+iC?=
 =?us-ascii?Q?VBSxT6dV/m1N15bh04oYbwQKYgBmy98EKoYczmJO1GB524J7X3rsO+nMHpxH?=
 =?us-ascii?Q?1t9flvDWCFSOw7Q3FC7BTX1Jcti+NW3KjF1CQJKyqjuYUHjfUYNtVcqDPwAh?=
 =?us-ascii?Q?kMi4bWD1u90W4fFY/1b9MCZW03EtYRapXRKxbO6CSUFFzimyWYnny0Tml+xJ?=
 =?us-ascii?Q?aCsjfjwCVmZgbFCOn41PsmFv4vgVY44IPsAahXT0V6r5qikUExV5QiSXAWPA?=
 =?us-ascii?Q?qxbzNe0AFhsi1QDnA+Aei/mO+tcqTS/TRuYn5j9+/zLc2AfIrYD5fkjLN/uk?=
 =?us-ascii?Q?euNRh4KZ8i/k8RfjOrnhx6AD9CZ3QKYR3AcEZSPv2LJQXQt/f7QBHD3xvnaG?=
 =?us-ascii?Q?LSrFc3JkdeZ/UtFppnQIhRckutkOevr/5tpmTxGtocvBrCBkZYDjfQgXpgiQ?=
 =?us-ascii?Q?lYfThDu8VoXsDFWiAfPtaG+aaKbEDtx1Z4hLmzZmHtu2cYYL9eCSA4xHRQyx?=
 =?us-ascii?Q?cfgHXld+AttYA4J+6+dlTfx0++pCNOmqDGCXYxr2VVDF2XZJTv34DTI9YCH2?=
 =?us-ascii?Q?bjBtFZK5qEFPRPH+Knwk/3OmeA8hHXY7v+2DY7kK1c/nPAg/OOW55CM7SV5t?=
 =?us-ascii?Q?9HU4fy7O6OyDX+dPMkGK4bre1HWE9MdneTk94FHc4jHraFWZQrhlrB5xMGno?=
 =?us-ascii?Q?Uz8HyFPz8GHXlbJeXmee5OS35rQ9jHX5t82r7LCqPSPnr3iDidMS8l5LvIPg?=
 =?us-ascii?Q?UBH+ei+T+zCyu0wysJThhmih2gY05QMleAICC2qFz7DCfx5SOKhsI463C0Zl?=
 =?us-ascii?Q?lgaGJ5QiXxBOJ3mgss88lxcNj5kagVcNiu8WU/68/kVuetJH3fpNnVf68SFD?=
 =?us-ascii?Q?msbbC5QjXfp2YWVpcUufBMJC7fjAsqMwhKWfMGVdIdVPrLmHOXXln8GqLVLm?=
 =?us-ascii?Q?kCZq7u6YqmTtZB3CYZmik1T2/WVC1l2c2leoWL1asnuGxB5MIlOrezhTuEvN?=
 =?us-ascii?Q?E2SMiHyp3D4CPWRItMCWiKHHwrTGvNjoTSIAH8FzfJOPSKYcTCmDx+8hrUco?=
 =?us-ascii?Q?j64iG6qiaWwaz1kERQ8KcBEbZwCSYx0FcRDGFUEr8SVyd0Eb7Sgcrv1LiwFl?=
 =?us-ascii?Q?a6CLcxKIWav0VowwNFVDPZF0kxvb45ITO2AtSfQoxw6cGvckg/Y5tFHTJYZQ?=
 =?us-ascii?Q?hAJhtZVtXR/an6d7nAY7Men2LijRqVPb2+eW4NFP5wfuGqNcV+TjFWLuZfY2?=
 =?us-ascii?Q?06dA9VEoCMTIoiuOIwRGhQOI/ZGmtUkkquFMR17BPqHRoNmg9w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 18:43:09.1398
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7d87f5d-5d0d-4256-c036-08dcf9dbddb1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8803

According to the AMD IOMMU spec, IOMMU hardware reads the entire DTE
in a single 256-bit transaction. It is recommended to update DTE using
128-bit operation followed by an INVALIDATE_DEVTAB_ENTYRY command when
the IV=1b or V=1b before the change.

According to the AMD BIOS and Kernel Developer's Guide (BDKG) dated back
to family 10h Processor [1], which is the first introduction of AMD IOMMU,
AMD processor always has CPUID Fn0000_0001_ECX[CMPXCHG16B]=1.
Therefore, it is safe to assume cmpxchg128 is available with all AMD
processor w/ IOMMU.

In addition, the CMPXCHG16B feature has already been checked separately
before enabling the GA, XT, and GAM modes. Consolidate the detection logic,
and fail the IOMMU initialization if the feature is not supported.

[1] https://www.amd.com/content/dam/amd/en/documents/archived-tech-docs/programmer-references/31116.pdf

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/init.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index aa9bf81a6ec9..8868838139df 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1759,13 +1759,8 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h,
 		else
 			iommu->mmio_phys_end = MMIO_CNTR_CONF_OFFSET;
 
-		/*
-		 * Note: GA (128-bit IRTE) mode requires cmpxchg16b supports.
-		 * GAM also requires GA mode. Therefore, we need to
-		 * check cmpxchg16b support before enabling it.
-		 */
-		if (!boot_cpu_has(X86_FEATURE_CX16) ||
-		    ((h->efr_attr & (0x1 << IOMMU_FEAT_GASUP_SHIFT)) == 0))
+		/* GAM requires GA mode. */
+		if ((h->efr_attr & (0x1 << IOMMU_FEAT_GASUP_SHIFT)) == 0)
 			amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY;
 		break;
 	case 0x11:
@@ -1775,13 +1770,8 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h,
 		else
 			iommu->mmio_phys_end = MMIO_CNTR_CONF_OFFSET;
 
-		/*
-		 * Note: GA (128-bit IRTE) mode requires cmpxchg16b supports.
-		 * XT, GAM also requires GA mode. Therefore, we need to
-		 * check cmpxchg16b support before enabling them.
-		 */
-		if (!boot_cpu_has(X86_FEATURE_CX16) ||
-		    ((h->efr_reg & (0x1 << IOMMU_EFR_GASUP_SHIFT)) == 0)) {
+		/* XT and GAM require GA mode. */
+		if ((h->efr_reg & (0x1 << IOMMU_EFR_GASUP_SHIFT)) == 0) {
 			amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY;
 			break;
 		}
@@ -3046,6 +3036,11 @@ static int __init early_amd_iommu_init(void)
 		return -EINVAL;
 	}
 
+	if (!boot_cpu_has(X86_FEATURE_CX16)) {
+		pr_err("Failed to initialize. The CMPXCHG16B feature is required.\n");
+		return -EINVAL;
+	}
+
 	/*
 	 * Validate checksum here so we don't need to do it when
 	 * we actually parse the table
-- 
2.34.1

