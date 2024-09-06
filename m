Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2077.outbound.protection.outlook.com [40.107.96.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981E51CCB31
	for <iommu@lists.linux.dev>; Fri,  6 Sep 2024 12:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725624831; cv=fail; b=RhvnRy5RTquX+ciUfjjvfCCBxXw9cpWJ/3eV9pZp8EO0heh3vsmMZUjfQU6gKPwBYClvSY32gjtdilYodBJETQGK5j29GbrligEMIG6qyolrhRirZGDnLroQzm9FSmU2HvEVCb0DP75QI6nGCYh7Fe5FzcAkW35aR0h2uPWHvMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725624831; c=relaxed/simple;
	bh=S2LUwt6UGv1a6AlQ3kRHKYdK1o7NAATuCp+6UNEOS/w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qI1UEm0WnZV7eVcy8KLuY8w3Yjz9hKRWxnvlOQAKAZJ2OJ12wJ8mKt80PIrBS4FYaePEk1Rr0Cjn9oehpdhkDL7OTLluavF+2DwXX3HLc6nJ99KTlZ8GS67QkcPWC8/abfyBWQU9x22THLdutvGj6rxGM/Ng1MaWkg4lZFrp2CM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iYlNYDyj; arc=fail smtp.client-ip=40.107.96.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iYlNYDyj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vvFAAmj1ohnxQNDqaXc6clwus80PIDH6AayyYKlmc1pSEumRLEDY9M5cdoi5Fsz9Vk8JrlxSbDoObwaooWLkYHDlXuyyTB8d8QobIXhv0V3OLWGcg+UI/R+c0Pr3NMNK66wC3E9fB3IRQTQr866ABpdEcAZtOi8gtejTreMasygHXVWg+pznf370MTjNKyYCYyWY3zWy6ejkxRa3c0t0Vma1gCom0DkbB9LBgQ5OAnzjUXMhxIOIauLC2+tppoJ5hS+/0oNEOhLJIMqyeY5/FbPr7lQKgc/YdGEhdscDxpdXPc63WyBPHc8nVDmqT2/TG2vXG8xqGnNndspMdwWkrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CPfkLVtLTG1Rf4ODxQr9nOI8kueJ45RiMXm2Z4g0fVY=;
 b=CbV3IIuk4U9j/jvKKB/63FfOJCq6ZBzROQXLOCuMK1PJKSGvUrKmQYsot06XiJLn9colwM46qY2/kwqHjIyVZH4QXSFsxIfSaXbg5ipc5SMQYwzE41CTBCS1Un0PFuG14C2ZQxDHECoPDwDents74F3awFnhEFyHMUsBmFiFcdfnrwYJxcpd+3I6gHiGKM6j5NtMyzwo3v8jXqrYYMLkkF5qaGuQEkWTRmZs5Ckb/oQ8paTHKqZS5RxbNUAdrWYNfdoC3ZwNnNEQ/FJDIKyRK4d3K4YNIoyC3pbVYtoN/GmaYkftKbRvec3YEXkq7JfP8E08K8wTUyNNzaEmGDTHiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPfkLVtLTG1Rf4ODxQr9nOI8kueJ45RiMXm2Z4g0fVY=;
 b=iYlNYDyj/1N9z2Kbcf433BozOREgBFoGF2UlvTb8phwdpjApRjJR/IucwMScfjEFQ6TPRoKRfCsxGV3HN0t2OpP4GVp4A66DMqDoJefudaTxO7lYXr/CXEtDpDyOY6kDM4QwHdTNo9GjhySmw5GVVMs3gW8IO27QcFD5gPcuBFo=
Received: from MN2PR02CA0035.namprd02.prod.outlook.com (2603:10b6:208:fc::48)
 by BL1PR12MB5852.namprd12.prod.outlook.com (2603:10b6:208:397::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Fri, 6 Sep
 2024 12:13:44 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:fc:cafe::e8) by MN2PR02CA0035.outlook.office365.com
 (2603:10b6:208:fc::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17 via Frontend
 Transport; Fri, 6 Sep 2024 12:13:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 12:13:44 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Sep
 2024 07:13:40 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<ubizjak@gmail.com>, <jgg@nvidia.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v3 1/5] iommu/amd: Disable AMD IOMMU if CMPXCHG16B feature is not supported
Date: Fri, 6 Sep 2024 12:13:04 +0000
Message-ID: <20240906121308.5013-2-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240906121308.5013-1-suravee.suthikulpanit@amd.com>
References: <20240906121308.5013-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|BL1PR12MB5852:EE_
X-MS-Office365-Filtering-Correlation-Id: 0733087c-a8f8-4ded-a052-08dcce6d5a79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KA7EgFLBDWv98yCRrz8LL5s7wpEcyu1UcxXbKaPR4h3a//6MIqsIjFyE+KiF?=
 =?us-ascii?Q?QaFsJ4Ox57uluoF3so/p6DLeSdDf6mACz7wu0/RPv3xgsr4C+cxDxcURqScI?=
 =?us-ascii?Q?pL7C4cFdo+wweit/4mzvkdTIfZJUa1o9YtDreNLsXyuCNty34Y625Gz0Xn9I?=
 =?us-ascii?Q?eFkT8nA5nMxArYES2Y71K1WgiDFUCYJdjzdsTHwrB3dWU68pDvQrJKmDE91K?=
 =?us-ascii?Q?HBvErduN8NGVIuJNmboAtrXJ5GgLPfqRzrF7bDvEOQz4ynvJyo8aZzNoAveY?=
 =?us-ascii?Q?db4HZfAZsciqJGr1hmikEe4kxz9cTeN/pcz1H5XJRfFJzqLks6f2S4ybScRa?=
 =?us-ascii?Q?s7iU7CFmGj+WhF1hebdnkogtGQfkOsY23NJzDvmvBb5nir0LbGwN/8BJVxLV?=
 =?us-ascii?Q?FKBo4YcSLR7SIwmLIv+8dycMnJ9ZD2KaXSq2l3zjr8eAzLfHIIPJ7Oa3piJg?=
 =?us-ascii?Q?LXEqlWO3jC72Em0AxYpatb9+m8Z5eJ385mdxkkNxbHBlt8+vtX/wXi/ZSp6k?=
 =?us-ascii?Q?Vot5+exTYTTtFYFiVqeHnhD7N2Z9azLmCF5cWP/ct+eWl8kTIzMRqlx5FDW2?=
 =?us-ascii?Q?Su7kSdD7LCyWIux2clN+LhMHAT2T/5OtgAB6jtKKXsRFt2xpO41AAtnahnvk?=
 =?us-ascii?Q?ejdExQ/VVW6weyySH4MQiyY30fU9W4ZXWovBVBgHh1JaaCmnphgeptm0hGmU?=
 =?us-ascii?Q?OIbiIC7FpBaS2AN9DgRonK2EUTQW6HLbxbHqcU/cFtDvmtHOpwhMe2knomOS?=
 =?us-ascii?Q?PsaD3Ig2bpiAmnW9yaR8PhqEa7AFdE6ILelRqG26wmHBagmhCmhAMjrgILKR?=
 =?us-ascii?Q?J9i6pLpFYCtcvQNOTgAg2+YPnJJDMBcSlErQOwwpD6vrJMxO3htpuEpC1DNP?=
 =?us-ascii?Q?3k0e3T4KjFpeTh9jRxiwR8NFDVAF39I0/OUYV+yYOkpjn03jj5AtxJ7RyCpT?=
 =?us-ascii?Q?5ISDGf0xd0VL7UGiri/3PCA9RtoJxfrXqhsMq0A6f1wT8f9dThlTJvuXqjQq?=
 =?us-ascii?Q?SXKmFkot3iPl28JsgP/57AIrEZ7V2+A+azJFtr0gt+R8y/x3Ew7xfBrYBhn9?=
 =?us-ascii?Q?HXBkZI933wN4lZr6jKqf/gSQdLRF6iLrFQAGkB7JnJ+d4o6FDHYXlFwLaD11?=
 =?us-ascii?Q?mshpUr+MHMwZ2GwuTg7e6bPe+GujQtE+EllMzNAw08jfKh01kdUhLZk7go6X?=
 =?us-ascii?Q?3/Gg4c0XRIox4rt43IkVmRbFQ8mKEkj9VWz4vto3xrJRx9AovsaDQd+Nkjrf?=
 =?us-ascii?Q?zlGtwYDByfOriGKwYDvpf164cfNkxTqu58ddLcTk3Aj3f+j0rJ5bDirSdCQ9?=
 =?us-ascii?Q?EzacFmqNtQpNVMBD3SdI7HDaSNImw/2VtEbo7zOfpldAQeeUp8/SFn0Jv6dC?=
 =?us-ascii?Q?w3+Okpzl4DA4FC0XJTE1/B6vuIzKHvxW0Bsahq7vMJ5iurqYKBCxnsrYstNk?=
 =?us-ascii?Q?YCmSlC/faHOv0L6DZbuiKA0EY2z+E1hC?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 12:13:44.3820
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0733087c-a8f8-4ded-a052-08dcce6d5a79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5852

According to the AMD IOMMU spec, the IOMMU reads the entire DTE either
in two 128-bit transactions or a single 256-bit transaction. It is
recommended to update DTE using 128-bit operation followed by an
INVALIDATE_DEVTAB_ENTYRY command when the IV=1b or V=1b.

According to the AMD BIOS and Kernel Developer's Guide (BDKG) dated back
to family 10h Processor [1], which is the first introduction of AMD IOMMU,
AMD processor always has CPUID Fn0000_0001_ECX[CMPXCHG16B]=1.
Therefore, it is safe to assume cmpxchg128 is available with all AMD
processor w/ IOMMU.

In addition, the CMPXCHG16B feature has already been checked separately
before enabling the GA, XT, and GAM modes. Consolidate the detection logic,
and fail the IOMMU initialization if the feature is not supported.

[1] https://www.amd.com/content/dam/amd/en/documents/archived-tech-docs/programmer-references/31116.pdf

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/init.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 6b15ce09e78d..983c09898a10 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1762,13 +1762,8 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h,
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
@@ -1778,13 +1773,8 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h,
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
@@ -3049,6 +3039,11 @@ static int __init early_amd_iommu_init(void)
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

