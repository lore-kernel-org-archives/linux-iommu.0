Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EAB198E63
	for <iommu@lists.linux.dev>; Thu, 31 Oct 2024 09:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730366218; cv=fail; b=boYULXCJc72AInkryY+pQFHfRrK+BnnfJH19e+XN1QPoBzpjJTrQ0RGLTIiqHuET1epEXI6DqoY4quq7F4wnkRLvnMmJyFbH/KaRi7zyCdxS4b+zccKfJAIjRkpqctYdbHX8x0gn3EArRDAryNYtRGMXACmBcdpxR4iC77oziwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730366218; c=relaxed/simple;
	bh=/B9ONeJZvFX/uLGZdTC73vVJnB4rukuiJQn0V67ePkk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BVt5oVEQPiLLbmeupx/FblMn/hSgVF7GzBRqgVF9sGaR15gSANP5EkUodkmXHgF193GXmCX/wOHkt6wA7yzVEcT8b96mmYQCIJn1akLRsEOsPumcapqHXTFXIcVu5uRXatBZhn7Hrkj/I2DgHQjdo5pUIZlM9USjx4QQPTtWgHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=K7vtreIF; arc=fail smtp.client-ip=40.107.94.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="K7vtreIF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jc6/3nlnfN4WVURlJohES8ZwCy+6jHGoqTpSaJ5SWWOqOUovLm5lH7eyzn07arHlqmsLuL8B15qRNjLMrteNyge/nonZDFYNUCTi9TrIQ0hT50CE8tJufEgLHctUmIAdaA/CabHjZ+/D45vMuzWv2hOkcN5LMmtJYLenxFfXBtMaNrubvDNjg82l6oRCIKQtEzb5VghTsz8NFsjUNEn82yBCVcKhHXRMxP/0EPDjGcY+1WKa9Q3zhT6FhLAhJZEPIMMYay+DILyzrE6vqcW2dDw6I170PvIOzCpvmOZ1NobAjBu8v34dHLM9RHvCkaK0wgQyxaT/O3HDjdY3qq2rvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iclqgk50i33J5FbXKPZlqFmeW7ZTFcvXwbAE9Vt4Xes=;
 b=CxZBZhNCGoLVMUsdkd9+d5T/GYwsO8fX4mroQSG9SfkhPvWSzhNwpdSMEGhxEYWJjJjKOp5J+EkaMuch0Ls6p908E1j4H3QTWuzGogh3aPc6rDQA/OKAldxYxJVKpL0OqXmZXyWo7g6y5Dg+Hu1kGpy1SX4M3U6woTIkfUDe2f1GSzJYB4zm9+vdoI4ySlJM91D5VBL8Jh/u46S6tOA6AO0/zTubi1iW9VefKqBwrWSHsbkGWV8w7GJw/yf0MCVmQ7I92a8V0sQ7tNy+ygMMOasTmBkMF4MQI6sJD7Dq+u+6jiaqpEMWMnDWSThexk0UocKnsLt3VDKorScexIorfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iclqgk50i33J5FbXKPZlqFmeW7ZTFcvXwbAE9Vt4Xes=;
 b=K7vtreIFFT1KOUFWZMnK6szfs9j2pn9QNBWsOp8xN71ruh9MgDMIyfH++zZa9I88OxVG3Yeec3S2z7IAv7UwlBXR9iHhArT0PiLdOe5x93F+8JMUCkMMVGlQHBTcbNZ5Bfex6xchxTNUVhXXaYvg1+5lMB2ZjNdx3F7dXizCh9Q=
Received: from BY5PR03CA0025.namprd03.prod.outlook.com (2603:10b6:a03:1e0::35)
 by LV8PR12MB9358.namprd12.prod.outlook.com (2603:10b6:408:201::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Thu, 31 Oct
 2024 09:16:51 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::8c) by BY5PR03CA0025.outlook.office365.com
 (2603:10b6:a03:1e0::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.17 via Frontend
 Transport; Thu, 31 Oct 2024 09:16:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 09:16:50 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 31 Oct
 2024 04:16:45 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v7 02/10] iommu/amd: Disable AMD IOMMU if CMPXCHG16B feature is not supported
Date: Thu, 31 Oct 2024 09:16:16 +0000
Message-ID: <20241031091624.4895-3-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241031091624.4895-1-suravee.suthikulpanit@amd.com>
References: <20241031091624.4895-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|LV8PR12MB9358:EE_
X-MS-Office365-Filtering-Correlation-Id: 33d954b9-fd08-4bde-aad1-08dcf98cc0bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ESCymKNfOEMCGEjln0s1Ck7/2ElN+OgBTodEytGQ7s57ba6ugGtUlAdyvY4e?=
 =?us-ascii?Q?R33T8Xp7ixOYL3Q+gXLSqhMlUe6tyos6LyiTvnSbZ/jhfRZQ+sJmYMly+rcK?=
 =?us-ascii?Q?IczxEq9JR/t7YzK//6RDPNUt44edbzzR05v/+VI3WihGpWwwIzoyYVTgcd/b?=
 =?us-ascii?Q?vJ6U+TFI8tHXsOaqiXd3URAI3vVpRjOrC75Z1nECEi4zYVNJeK7VjqTy4XL2?=
 =?us-ascii?Q?iEacBsCP3WDVAP3Xql6FuvXyZ3afQL8PcMIqXH5HZ1cj7HxFaTaDcjyG3Fa8?=
 =?us-ascii?Q?aHOGMrWluOmBCd2s0Ixao/SgqwLK2ZNkJMbQIiDUPMdXwXKKFgdm7XFdgvr5?=
 =?us-ascii?Q?T2tsB0z1Q7TxafNj80iUJJPfBK2mH8BeY3stn/2sDZk4a8XVS/sVj95r9+FZ?=
 =?us-ascii?Q?ikPNthzSXXbHeTWmsFr7Istf2aFtXWB7XLJBCD1xA4axpZUK6atnyu0ZTBDo?=
 =?us-ascii?Q?QNFAbF4SOOYHTmoz0BJgDE6Ir1iinoE3CPe+lLZm74X+G6luDdiaPuCBJfXK?=
 =?us-ascii?Q?b/fCGzf7Bbvb7IsznZ+IRT0rMZZ6gu6A8UOPz1RV3ObYgXINRSoBJzciOSBX?=
 =?us-ascii?Q?08sKxYWK2Bp9UttAagKttv1Gd6Yuee0rIggeX7YF9JEcrSFV2+MqKP4lcBM2?=
 =?us-ascii?Q?2bw8k8YtSf1a2a3P/IOSiv5U1b5dfQ1QeV+w/H+dh/LQfZnvXED2H4v0fFcq?=
 =?us-ascii?Q?duVWnvaHFNmHiDZJ6wgPju7C5nAfSaZHfBDt4ttGxStT6bIVv04EIFniiSSR?=
 =?us-ascii?Q?yCn7SaFjrdQ6NtACijSlRuJzLbaTLAPNd06W6PoVq58/whDNoMIco5AwCT3J?=
 =?us-ascii?Q?JSgTouCvTUSXsh52NB6ukPW7FXLkotAlNx0FRmE5yEhw4ZKX4+8xeJ9E7xG7?=
 =?us-ascii?Q?WdAi5zF0XjmSxmR/4QQThtH/kqPJoePwQrzWkZdOlUZ7UBHBRP1fQ6IlIsCm?=
 =?us-ascii?Q?OMU42X+pZWJiSd0qQffVuVLZjfU1amRyyJNLQJgfWeaiGWqAQEpbVNHWI4VX?=
 =?us-ascii?Q?kna/szWAx20MKNlJRfQw+pq794ZV+8fWFrZOoR5WX67bTaxOL8jK1tpqpS61?=
 =?us-ascii?Q?NcE6kMvc72menE7wgfDBqx4QcGeQWvh24u7zby6OkWO8cEPVXNY7bfW4gOmz?=
 =?us-ascii?Q?VtQxHgI4qiqP6PjHndT8VKoXtIXvaycKBr6LtcQ1wRzoz9pqOn9aKUU9rGxE?=
 =?us-ascii?Q?5VEwv3uwWYvd2HSe/VcR82fuXEEFx1b7uexI4nqS8UAn8EAdv/Jev1mHG5dZ?=
 =?us-ascii?Q?NjVbRSTqDN+kyFBmDzCiq2YqiGUVKBqsv3TsPEw2+qM9A8SuBwsZkAs1J3/h?=
 =?us-ascii?Q?TkfIRqM+47TgvNRPgT3LnpqiwQw0uMy/NBbFHWhP3jmYncOtQNBdTlyzPAjd?=
 =?us-ascii?Q?ZF8weKimeyfjhrBZT49LnCUd2N7cPjebzTXctVYnVRKYM4oCLg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 09:16:50.2729
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33d954b9-fd08-4bde-aad1-08dcf98cc0bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9358

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

