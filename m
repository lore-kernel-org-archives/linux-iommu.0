Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012026.outbound.protection.outlook.com [40.107.200.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9F84A3C
	for <iommu@lists.linux.dev>; Thu, 15 Jan 2026 18:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768501439; cv=fail; b=TEVF9CaaLMRU2bLq95uh8SBKXsXxXwQq8Nws95lRxo4uTYxz7Gy0qurlgbtHKN6FOES+75+D3eHjgf509d5xL/QXSvHZkC/rp5b50McBuBS7S7zl0Ck00W9yfqf9xGRgwSv79/FQptZHTjLtm3myN9gfxAf63pQFuyfxlorNz7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768501439; c=relaxed/simple;
	bh=4WDwArXbLushbTsys21CTwcXjTMF+QN+nyKC2QkCaxs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o7IIwZELpjxT4OdXeKjTxqzJmPwXrKlAsLsq0ZiGeo4OIbRmKDhb3eTyhKQwMc55z92//w/TcDxEScIMD7IjTYgef5pSbwPauYILJjBfr+swXbW974jeWnRcDbxM6wHHYjdFjbGUtYOcWJzaf+k3q3kja4bKqVTmufsdM1KY3g8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dAaGMDZ3; arc=fail smtp.client-ip=40.107.200.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dAaGMDZ3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f++8UG0KhoO8FkCYcC7ZpUPQMVA66vcAUp2GBvTMSrHz45kgPWZplhh4kxROsTpphEpE7iUO6xBvaCo7GGtujNcZXI2Eh2vZ7zJi7rAKGcx/VdePnrKHEMBRThdJVE5ARmYOTyRXKFIEILQaRVZaMpesX9l0I3n4bO782wzstTZiPwqwVM+rJYfHVhnF8IDgl3BqjvYi2cWIgIFnWFlxqUMOZO98C3SvL7XTzxCO9nMWBddFeXkbFw15Ai8A3TREKR/lcHQUeg5pdU8+4T6ymAOT3LKAn8GyvPb5GHjruKHVvsovS4xJ/rJ586vQnfAvzbM/Au8fWcdVPwbQtczcaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVNbVv+BvE1fwdcczNuv3X/8U0UgmxlES3cwPDJNF3E=;
 b=iMc1+vBcptMqyQFzHq1sYixq5pSHfVFNYbGXEowOeE1b2H0eLcckQHORkEMSwa5+X8qz2Av09UgfYSt+yomMAUQw3/ymCR7vAuJi0sSvIV+tevqMoDePXwRAQoijEmwQijKmjfYumRfwG+YTPk8gpp+AP92KZyvM9sljcDwmUR53Eqv6XqO0aQd/yReb4JclBVFOKuLKoq+AIcIGj4jcYfcpXB8oifSWjTGPlc03NxA0+Sb77Pe1sXBSsqo3eQt+O/PfEI2SGTvGzmpqXpG8Cl8+T5P1ew0V/AVLlFo/6pFbRqis/ZBsJyuklrZNUwg3zbjUbeWrnf6Yohv7p58ILQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVNbVv+BvE1fwdcczNuv3X/8U0UgmxlES3cwPDJNF3E=;
 b=dAaGMDZ3foqUwc1vCkhIaS1SVCTRE3IrrmhSpvI8R5oietQcRT5s0gMp+eIcWi+O0G6XuSK2fmZtiSU5biENnY2pvpN2YU61iUsg2+bP0KFRwaIJXC+nGgQmmxWiFod8835dIaISpJ229JGlSIkDkP/hRAwWh+X3VcV9u8bhGx9wE1PVJEy1947yK7Z8F2baPZACop+Is1BTSYOWLvp9hAdPzI5efSLnRumIlzpor25/fTNFo15emC5ieTx+op8Gn0D4gFTuQlEdNq7akVPJNqkRjlD5i++iBgfi9KVDOyQDh7H00PjIFHLuDYmnEXkoU3AMez2BLo7f7MlVwsCJhQ==
Received: from BYAPR11CA0085.namprd11.prod.outlook.com (2603:10b6:a03:f4::26)
 by CH2PR12MB4197.namprd12.prod.outlook.com (2603:10b6:610:ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Thu, 15 Jan
 2026 18:23:53 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:f4:cafe::57) by BYAPR11CA0085.outlook.office365.com
 (2603:10b6:a03:f4::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Thu,
 15 Jan 2026 18:23:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Thu, 15 Jan 2026 18:23:52 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 15 Jan
 2026 10:23:35 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 15 Jan 2026 10:23:35 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 15 Jan 2026 10:23:34 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jgg@nvidia.com>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <skolothumtho@nvidia.com>,
	<praan@google.com>, <xueshuai@linux.alibaba.com>, <smostafa@google.com>
Subject: [PATCH rc v7 0/4] iommu/arm-smmu-v3: Fix hitless STE update in nesting cases
Date: Thu, 15 Jan 2026 10:23:27 -0800
Message-ID: <cover.1768501336.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|CH2PR12MB4197:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ee9d4bc-db9e-4aca-fdde-08de54633c93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DcAGAiVNHyF83js1ZWpAomR54AAPzqbNgq4VpsPjotytJ6dZaVbtVVrR7/no?=
 =?us-ascii?Q?yizDgxXqvr+wXx3YOQhnQni1CCoSFfKZhdpunvTcCGpq9hnHjPMQR0unkVyY?=
 =?us-ascii?Q?i8ycwV/T4HQYoa2Fhivyvv1F41jrNkDO4ORZ/bpQfjdXSeCyuAobFUR3BM+h?=
 =?us-ascii?Q?Y+7nPfzN1o80aVFogsVpzrALd43+qSdmTN3lgYyEUC0aHRpwcwvHL2AdRKy9?=
 =?us-ascii?Q?3o8gdTpsm5rbHD4pFY9Ahg1/tsnBn5UFR1gs5mbKRd38uESkzcAaB2V+F4Y8?=
 =?us-ascii?Q?Zc1k/EyQ3kVRN6SoDWhrS0F4HlrOUjoa58Dn3chAkzeQ8tk+Q6JUR5kao4O9?=
 =?us-ascii?Q?SduVzIHBiPpv1325ApPivhTitGuFFWCb9IGAu+V8NJeBpj4C5NzUwztmjNdB?=
 =?us-ascii?Q?OFL8Y4pQeAAZ5dnjsr017ngyFk8bNu79wFMysVIrAsd3/mCnlfe9pL+OsGH5?=
 =?us-ascii?Q?x3HhqZMuUScyIjJnbil7u2U/dNEfHsUkft0+HBPSo+A3Ild9uXMFNr92Oz1K?=
 =?us-ascii?Q?/Hyny9UyCZliv4gGKA3Xog8kARkzbupQ8u8/EKpyxCJLL5F/s2jbRfvnY/Yr?=
 =?us-ascii?Q?lfbZ6YTL0609SiCpk/X9/3oDkPr3SWuQP1JXwAtfp46tO8kkJC0VriDOCrZu?=
 =?us-ascii?Q?0iKAwQSb7bRXi6EKtuvwfmqAI7eunIp1ZREVFximfBNwx+kifQODCEWjDaQO?=
 =?us-ascii?Q?o1Yd28iwpDUun1shSOWJ8O/U1oM24KhrY59a3BYYs/3OD7kIh3UkS76MqQPS?=
 =?us-ascii?Q?sljpeauxD/ua1d1ctoGcxMBGl6ptDGt0k3msLFkabNaxKtaQYz2PBKWMGzEi?=
 =?us-ascii?Q?nRoB5vZbH0nqbqtO+vyW8IwS4XZOuMQKVThXt4XLh4bi6eHQIQbPZKOV/0M3?=
 =?us-ascii?Q?t3tO/cxevv8PzAbTn6v78OksNsBowVCfwzBoh5YHBT+AhtzIqUXk4ij/9V63?=
 =?us-ascii?Q?RsAmw21qVSqTbeKKX5+54q43+7cPzOVT+Z0XN/H7hR0TD/04LNTzQyMrkz9w?=
 =?us-ascii?Q?Gj/mbnvQXJjII59k6457X0JIq3yWRlCL5Et09L5uCy1wbuPSUvDXGZUM3G/A?=
 =?us-ascii?Q?sfI2o6mXVzBjyAoZ4cRd0SYGOsddvp8xbrkcZr9GJEJ6xo9Gy+7LMcQWRf3k?=
 =?us-ascii?Q?0R25BsXBPzUnew9vF/DQCViucTEvSLJ2luFd2mWkd1AONTBRL1P5eAIFx3Hl?=
 =?us-ascii?Q?+p2ytJ++IrTr7Z2+fKyK+7t09kYn91Erm2AXgjWPjcxcYFOH1iTPA3HJRIHa?=
 =?us-ascii?Q?ncc8xU8odwpyqjOoOCNBz5Y8HKyBIzoP7DKTTvsJXUq7cJ2N7qjzmWXnX5jK?=
 =?us-ascii?Q?0qVJOi/rFoe0rGSKzXqjdWTAG1ZEEeYPt6kA6yirJgfRxJHmyG2fMhjlNPax?=
 =?us-ascii?Q?RsZVK11Kp2IfQXkCu2fgiWrd/zJGBImxc9M9Gxpj7UJFo86zXo9j4JTSbfuK?=
 =?us-ascii?Q?bgZinHV94b4epGcrwDzplyDNhERcQhdcZDMwGINxK3DsQPe1ZyEZ5bQ9eHSO?=
 =?us-ascii?Q?UBWZuTF2pME50sHBRcyCcQg91+0jlUZfn9CAl864lglql2ZcDzMuvnealk3k?=
 =?us-ascii?Q?ttouLLjqkX22j6TN9QaWYNBntRCB+V2OooDZBdhfayDH2d+UoXkUi7n2cQdT?=
 =?us-ascii?Q?0Z2ImHbbfPlf0FRnPxiOWn+f8lSV5E/0+lTBc7rdGukDVGfeAuUek80mpvak?=
 =?us-ascii?Q?zDq2zg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 18:23:52.7841
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ee9d4bc-db9e-4aca-fdde-08de54633c93
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4197

Occasional C_BAD_STE errors were observed in nesting setups where a device
attached to a nested bypass/identity domain enables PASID.

This occurred when the physical STE was updated from S2-only mode to S1+S2
nesting mode, but the update failed to use the hitless routine that it was
supposed to use. Instead, it cleared STE.V bit to load the CD table, while
the default substream was still actively performing DMA.

It was later found that the diff algorithm in arm_smmu_entry_qword_diff()
enforced an additional critical word due to misaligned MEV and EATS fields
between S2-only and S1+S2 modes.

Both fields are either well-managed or non-critical, so move them to the
"ignored" list to relax the qword diff algorithm.

Additionally, add KUnit test coverage for these nesting STE cases.

This is on Github:
https://github.com/nicolinc/iommufd/commits/smmuv3_ste_fixes/

A host kernel must apply this to fix the bug.

Changelog
v7:
 * Add Reviewed-by from Pranjal
 * Replace the 2-bit EATS field with the EATS_TRANS bit
 * Ensure S1CHK is not set when returning EATS to the safe bits
v6:
 * Add Reviewed-by from Mostafa
 * Update inline comments for EATS
 * Ensure S2S is not set when returning EATS to the safe bits
v5:
 * Pass in feat to arm_smmu_test_make_s2_ste()
v4:
 https://lore.kernel.org/all/cover.1765945258.git.nicolinc@nvidia.com/
 * s/ignored/update_safe
 * Change entry_set to void
v3:
 https://lore.kernel.org/all/cover.1765334526.git.nicolinc@nvidia.com/
 * Add Reviewed-by from Shuai
 * Add an inline comments in nested test cases
 * Reuse arm_smmu_test_make_cdtable_ste() for nested test cases
v2:
 https://lore.kernel.org/all/cover.1765140287.git.nicolinc@nvidia.com/
 * Fix kunit tests
 * Update commit message and inline comments
 * Keep MEV/EATS in used list by masking them away using ignored_bits
v1:
 https://lore.kernel.org/all/cover.1764982046.git.nicolinc@nvidia.com/

Jason Gunthorpe (3):
  iommu/arm-smmu-v3: Add update_safe bits to fix STE update sequence
  iommu/arm-smmu-v3: Mark STE MEV safe when computing the update
    sequence
  iommu/arm-smmu-v3: Mark EATS_TRANS safe when computing the update
    sequence

Nicolin Chen (1):
  iommu/arm-smmu-v3-test: Add nested s1bypass/s1dssbypass coverage

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  4 +
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  | 78 ++++++++++++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 64 +++++++++++++--
 3 files changed, 136 insertions(+), 10 deletions(-)

-- 
2.43.0

