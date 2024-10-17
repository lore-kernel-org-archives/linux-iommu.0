Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611901DDA24
	for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 14:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729173738; cv=fail; b=sH8ZpmIdn6UpEuSREz7cc0+3zfca51YdepN9mjIXpD3InI8CAFcF4HqInuP7k7XXz3pqB+aGDQqEfNppnvA3GiCgF3txngohukfgKWV80OFIYNZ6X6qP9MZf3po0GdrTybZtQ2DSJlWRbogLc7d8Z2KkHB6seYCzge6DUfO1Ryg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729173738; c=relaxed/simple;
	bh=oIHCNjXg7qc2n1oBesOzQVSftkHcKlPh/AQ2aEcTC08=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dohmx1T/S7qwp3TdxJXrR/FuRneocXBsyEoB4qQbKOeg2/GFkxiJgEoIx47WkI4UKhYrTgPQhAukxVUpW6ujW70vZBH8TGJ2x2QcWNPOPlR8azmDxrRIluSmYUxFzPF4XzZu3mUtd8f1G2Ed+NGzbH66JW6SB7fVCCHEplp/dZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HQTVfrSb; arc=fail smtp.client-ip=40.107.237.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HQTVfrSb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZVfjBJ3ux3T1ILDvEB8XFTwLppVro8Tu3heZ9+7QYcJ8R/XVJlZVirg/hov7Ob6m6+gDum/JzqRCGg3BU+O0+cQnyxTdMuvhIGGJSqlLfDpGlbB4a3KGhtpjXQsCpo/XQE3SJjPA5dc31WtmBHu2IbbSQDg4A2GqkctGBVeU2hnsr/fFUZqIA2Ft4xijQSwyeyRncMhz/KQscDqhd04nJRclFpfQzHnyGH60B7OB0POfYR+7f1UgETn0kFIBtGZCS+5JvMHmHFkU606cXBxcPyg67DKk6kmTalryB7DdHGMuAnuAvNXoPbtk+rdeSJE1oNwPQPOBv46rjUCivctM2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ug4jWVriGZN9K1RYMMUca5iiIZEdhgRZY47i6YyaRbk=;
 b=VByGe3MpR3psWNgn7Hhw/mlVWUpsnvADfPOSwtmXRlDxvoiNRwGIuTrrpgyvWVZ15DYMlOjBiCWbaAcAb+1qy1TTbLv8u/nhadx8WAYykRNHzIiTyfmWWxc3uSFN2mDFz2rxabYwBscyo6JiL0tgHZhvbBc67PF10J4Ans5FBHRHSUpQ6Ndo/wyFDL+fuP7uqV9krjZB7deRgHTpnpi1e7XLwo/Fbr/4BMe+PTTpFVB5qPXqYDtC3sMeLNPWJ0kS7SLHWIetZh+b1Vpg010ZuOHtWFVYIxk3TmfeIDAOkU/YqqiPkpb8rkNImpsmxYIwGPJBAcmli5SDDhLV3sADNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ug4jWVriGZN9K1RYMMUca5iiIZEdhgRZY47i6YyaRbk=;
 b=HQTVfrSbWrlqAQzhqt3Y3wWBMDA9ZknsvPti0S4jJMC8miQ1qcgDHgdjWlxBXzH8iLRqQ6/nRJBhVc/UMUIVTuuF8oCuwrvGhpyt1anzH5rCcpf6XD5RCh6NFtzFF2EaPTvzKvLMuO/Y+j5FnoQq3tAnlzWc+lPou+tV6/6GvWM=
Received: from CH0PR13CA0046.namprd13.prod.outlook.com (2603:10b6:610:b2::21)
 by CY8PR12MB7635.namprd12.prod.outlook.com (2603:10b6:930:9e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Thu, 17 Oct
 2024 14:02:09 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:b2:cafe::59) by CH0PR13CA0046.outlook.office365.com
 (2603:10b6:610:b2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.7 via Frontend
 Transport; Thu, 17 Oct 2024 14:02:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 14:02:08 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 09:02:02 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, <yi.l.liu@intel.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<jacob.pan@linux.microsoft.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 00/12] iommu: Domain allocation enhancements
Date: Thu, 17 Oct 2024 14:01:25 +0000
Message-ID: <20241017140137.6028-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|CY8PR12MB7635:EE_
X-MS-Office365-Filtering-Correlation-Id: 44ba578d-f6d2-46fb-ed9b-08dceeb44a77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?muYRvUdBHdV5yopqiguE70AV1bo26RIrH+bM3wuM7nj62RaRnsM/zmL2tTzD?=
 =?us-ascii?Q?zcLcvk8B9nt0pIZ7ZdmREgFrgEo3avmgR+KfhXIREokrM8qnqd38b0atYBxD?=
 =?us-ascii?Q?5QLCxNwWgYdZDJMpfWi8Ssi5U0WTefzi0v4K4XMm1T3JipKL7SXOJ3oklYWe?=
 =?us-ascii?Q?y6bmOKGu2PLV2kM6KnQ8PREa7YYv8j02aaNkY0lzBSBQwk5cad44v2kYHlYU?=
 =?us-ascii?Q?6BLaCCodbjUZIFWkUw97MbcGiUBzptoRIOvaFYB4NMQohX1NFW4wEiqepCFq?=
 =?us-ascii?Q?Fzomyi9tUjGrYoNh8diMtloaz2CMJF0AAfOvpgCZjOKuwTY65Byd2zkzRRfV?=
 =?us-ascii?Q?3JvOpuXbo1NaFLGM7UYYYNvTjU73WRuOoHo0L67AGD0+aLMFBaNuLr62Y9CV?=
 =?us-ascii?Q?6MaQAr90NG4LA4de6UMrPv3hu0W43HV7G1CZ4lii7779mR9NH2idyguuHO4J?=
 =?us-ascii?Q?lQZvlbvtl5ID4GnjcWTATywMQRBmoJHrY5MtojOljRXyKBu0vR2LYnQLLxtY?=
 =?us-ascii?Q?/cWmmOBhjDhOfxKAv1HlH0y8U3dSQAqMZQh7dZFlNplcWi+/UnLHlDEI+oTJ?=
 =?us-ascii?Q?s5AHRUzG0YJHaByAtklBWTkha2jhZ26Gn1rMeplhYxkWj7rq3XXBzkL8nvh4?=
 =?us-ascii?Q?UuiFsIRkaChyat4kaqbz/56I+qqPSblyVF7di6HJp7lfuAvmffB9B932S5G5?=
 =?us-ascii?Q?kBqF8MKtgfsZRXHtRNr+oAMejYVYVFIVi328kcjvcYYA82s+kJGvTrF97G+e?=
 =?us-ascii?Q?oYGnl6ZO6ICRG2/+KQturkqqe80TSHSGRhHTYlhDLBbGriBHDy1B6Y85CElj?=
 =?us-ascii?Q?yftUcqyJpqL0DXWbjzCEZw7Umpoc4pzXqNCtS04p57vEICuI+pyVPa+M87eU?=
 =?us-ascii?Q?1mj6+wilGE7P9i5tINNtsjrL8MaqiFVDFvrC/z6BoSmK4z26GxkC3iPTmPuO?=
 =?us-ascii?Q?6GPumxg0oW5kdWJQpR3CTCNyjuGbq3EEfdxdCaHD1yNASdVPDq6KS3YuDX3e?=
 =?us-ascii?Q?PVMQeEuPx8EYwyL6XL8yZwmhxE4mJ5nlRbWrCbJ2swGU84HHgM6r/oBjNv87?=
 =?us-ascii?Q?OrTLz5MIZx0XMlaD+EJQrDWLmFXAGTG6BNzoCe0+y5xiy2WDfuFFziLYuMok?=
 =?us-ascii?Q?QA+g6D4cX5AdmcF9zbbMqoDT8LdldOaNQACxJiL4R7ij0fN4lBB1+SLI7E51?=
 =?us-ascii?Q?3Tyxm5+9+hIKNDljQcgKM/WEmuaQHJOBy9dByB18FNFffPxuRe0dJxA5Kf5n?=
 =?us-ascii?Q?NQAxMF2MG8aZyoIt6sdWDMUso6hjVoyvLuZMv9X1WiOPBwbZJGX6TtAIH3me?=
 =?us-ascii?Q?4zeHhfJG2r65fGJxfMSgzpw9miJDO8AbWZ7OnRDoXTHyVShMgluxJxSAclRI?=
 =?us-ascii?Q?u+dCPgpv/SBu5pPMXtLRXB5ysFebnoRKTLSmmPl7Frp825fJAPnzVv2N2xLQ?=
 =?us-ascii?Q?ufMPFsvmtpU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 14:02:08.9727
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44ba578d-f6d2-46fb-ed9b-08dceeb44a77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7635

This series adds iommu_paging_domain_alloc_flags() which takes flags to
pass additional details for domain allocation (like domain with PASID
support). Also adjusts core code to handler variuos domain allocations.

Also updates AMD IOMMU driver domain allocation code. With this by
default it will allocate domain with V2 page table for PASID capable
device and v1 page table for rest of the devices.


TODO:
@Jason, @Kevin, @Baolu,
  With this series if driver implements domain_alloc_user() then we assume
  IOMMU always supports PASID. If IOMMU doesn't support PASID (ex: AMD driver
  not supporting V2 page table) and device is PASID capable, then driver will
  return error. Device probe will fail.

  I think if driver return error, core layer should retry without
  IOMMU_HWPT_ALLOC_PASID flag. Other option is indivisual driver in error path
  of domain_alloc_user allocating non-PASID capable domain.

  I prefer first option. Just wanted to discuss before implementing. Any preferred
  option here? OR any other better way to solve this?


Note :
  vt-d specific changes is handled in separate series [1].

[1] https://lore.kernel.org/linux-iommu/20241011042722.73930-8-baolu.lu@linux.intel.com/

@Baolu,
  Do you want me to include above patch in this series so that it doesn't break intel driver?

Thanks everyone who reviewed previous version and provided valuable feedbacks.


This series is based on top of v6.12-rc3.

This is also available at github :
  https://github.com/AMDESE/linux-iommu/tree/iommu_paging_domain_v3


Changes from V2 -> v3:
  - Added Review-by tags
  - Fixed warnings reported by 0-DAY CI
  - Added patch to enhance arm_smmu_domain_alloc_user() to support IOMMU_HWPT_ALLOC_PASID flag
  - Added new patch to check GIOSUP/GTSUP
  - Added patch to move V2 page table check to early_amd_iommu_init()
  - Added patch to adjust blocked/identity domain allocation in core layer
  - Dropped "iommu/amd: Add iommu_ops->domain_alloc_paging support"

V2 : https://lore.kernel.org/linux-iommu/20240911101911.6269-1-vasant.hegde@amd.com/T/#t

Changes from v1 -> v2:
  - Rebased on top of iommu/next
  - Split patches into smaller patches
  - Added global static identity domain support

V1 : https://lore.kernel.org/linux-iommu/20240821133554.7405-1-vasant.hegde@amd.com/

RFC v2: https://lore.kernel.org/linux-iommu/fc8715e4-fb44-433b-a42a-7804118ebc57@amd.com/T/#t

RFC v1 : https://lore.kernel.org/linux-iommu/7e249bc6-c578-40f0-aca7-835149a0ad39@amd.com/


Jason Gunthorpe (5):
  iommu: Refactor __iommu_domain_alloc()
  iommu: Introduce iommu_paging_domain_alloc_flags()
  iommu: Add new flag to explictly request PASID capable domain
  iommu: Put domain allocation in __iommu_group_alloc_blocking_domain()
  iommu: Create __iommu_alloc_identity_domain()

Vasant Hegde (7):
  iommu/arm-smmu-v3: Enhance domain_alloc_user() to allocate PASID
    capable domain
  iommu/amd: Add helper function to check GIOSUP/GTSUP
  iommu/amd: Move V2 page table support check to early_amd_iommu_init()
  iommu/amd: Separate page table setup from domain allocation
  iommu/amd: Pass page table type as param to pdom_setup_pgtable()
  iommu/amd: Enhance amd_iommu_domain_alloc_user()
  iommu/amd: Implement global identity domain

 drivers/iommu/amd/amd_iommu.h               |   8 +-
 drivers/iommu/amd/init.c                    |  18 ++-
 drivers/iommu/amd/iommu.c                   | 125 +++++++++-----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |   3 +
 drivers/iommu/iommu.c                       | 171 +++++++++++++-------
 include/linux/iommu.h                       |  14 +-
 include/uapi/linux/iommufd.h                |   6 +
 7 files changed, 240 insertions(+), 105 deletions(-)

-- 
2.31.1

