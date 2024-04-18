Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8788821
	for <iommu@lists.linux.dev>; Thu, 18 Apr 2024 10:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713436468; cv=fail; b=ZWvejYLZf5z4x76JB230P0jm23/MtMdKLQIgIH8DG2z1JDVKu0hewDhF+HD+xxEDC8RHWrqGsq9SzqDczrNxvJBqIQyMM9G4S8PFN1JFZAukrKS9U2dZ8cerVZuNlZogSA+CbOA6wSctfdtSL2azBuGgrayBomMSlD7d1+to5Tg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713436468; c=relaxed/simple;
	bh=XReJLqlOjshfnzm4k9cdkiyteyjfimA0TcmCwsw5FNg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AqRALmpoJPFyVK1M5wrkY0qULRkjDcL0cCJv6mv38uP2DV85uM3cqpe6//hAmZMskn1O/n+WsM40YvLIKVsdGhEmTXbVgT8ECy+fnm3RDdvTpokkvWKIvJlxWAsSbH+oCF2w4gR3idUaWIqkguGXLxSnY+kGyDUBdRqNmjqbJOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=14coN7rK; arc=fail smtp.client-ip=40.107.223.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="14coN7rK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HpV4RnJ7gXSAzS9RQArDeU7310Sz3kszr5l6e8tsTSfaKkeK1Y6jhzS3s1bU/YUEp0q0wdaQP1gV245jApaO/KxG/6vHl2p2ErZrVm6ihgc5q1PreWM7roVddKWlPYYw6kLd2VqFi1XZFkz6FLX8xYhrqSHOkdqv5DZtAYfAls6RglP6ZD4gARBt8zDO+LwWsDZFZJlub44lgXE40vkrKZue3KMdkYl+/AXuaaZCbsEiD0mUSdrpB3Vhk6J/o7W7hVsjz6n/CnyGSlM1wuBYls9rBS8M2kPw+SgIPRQwYi07+n806/IlPm23pTcrU66zUyqVslHvGRq5koUHMITxwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSvBMWWpYLRUupa3dP2qVc9Exd1SVseYTEU3A0oSdwQ=;
 b=W98bNSKqwfhyjSkOnuB6Mj1NLt/F/MdjH03IKeJ0P4Yh1DtRC3qmBNGpwsuKtmEMauotDNxNrT0Hw5M6bpfvz/Opxlo4k7/jGtfLARjAhHEzlDde/EikkLOsjY3etS81RutLTQmcARseEsN+YY9z/yX9NC9iAVVgrBOGEC3qFaQiZqN8TKwdn3+BDLDxwcFw7iHuzLjpM3wlln//f7hS6mPSJwnK+lTojG4kOOLWC5pmbclPZ9Y9FE6MuYuOm8lKdbdLpbJG7iqZ9zLslQGE0tOrcN1f0buoqIZ1LH54+KeqtnlRdZssWpmuoFy6oKO8XMM/opK6AEuf/CWdGQ109g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSvBMWWpYLRUupa3dP2qVc9Exd1SVseYTEU3A0oSdwQ=;
 b=14coN7rKoS1tmzS2OZkvTIY0LZ2PYTXaF5uGD5GT4CWq6qo/LhQ9LUTaRxjOEOmxaKYRG4BHqo4Ntz/SDGh6ZcFd0gcx4P9NMAeSRJRuY3shfC++VQbUI9Ck4wdigm45j2h0jt6Hzp+9JpYBArLnRBDkRMFy4XgFAs1buTToIPo=
Received: from CH0PR13CA0038.namprd13.prod.outlook.com (2603:10b6:610:b2::13)
 by PH7PR12MB8593.namprd12.prod.outlook.com (2603:10b6:510:1b1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 10:34:22 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:b2:cafe::83) by CH0PR13CA0038.outlook.office365.com
 (2603:10b6:610:b2::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.19 via Frontend
 Transport; Thu, 18 Apr 2024 10:34:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 10:34:22 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 18 Apr
 2024 05:34:19 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v8 00/15] iommu/amd: SVA Support (Part 4) - SVA and IOPF
Date: Thu, 18 Apr 2024 10:33:45 +0000
Message-ID: <20240418103400.6229-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|PH7PR12MB8593:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d9c4d87-a856-4db9-817e-08dc5f931c97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Q7t+8ARcY+l9hxPnQBBLmPUv01YurUU9n4d13l77chZPp+WdkzUN7yhdN8wJ6gDo5SJsRGKSPmbWxrjs53c3SKlxGfinrgcQSQ09dTFSkgWAwTxoIBtsQdRJ8WaQK12+SA9F73PAlts0sWJkS51LW8y5Zg9sasU97WOif5xyE5YJN4GahbUXeatJeXQU8z3g5IJf65kWAs58Kk9EDbGpMLxoMGBCrf6yPbKqxvhmbXQ477xLf/yBji4U3mLR1R4S0UqhyZ0Wkye4WiARFt9BFxuHu8gNFwsNXIwoAk4YlBaTtNQGftRckBFCk+dLUiPkljR5/N3C6dO0q9LTYHABMJj484JaEMWcNCwKf4LbyF//b1+K/iIoKSQpeeiJC38tvgFp0vTT2xfR/6eVDLPHEMekbufUVTROOgurQ5cEJhjS2rrjXvEfX+pOlmCXhku3QInPfb9PJ6KaZT5UUzPV6CU0m6pJ9MT2WLCTDzW5De07KdrilZ6gIh1n6vGFrTvIiph9aI0b7huhaJ7I+o9k/4BQektFMo2juZBsr3E6dG7z8aYD82qW4TGNYEQbpMRqi21ECLu0cwl8svlOOo3O+D5kjEOTHxt9L4Pl0Zfc6dtBj9dM7CvVXLfH/xaqT67oqShW2vfiqR17v7N3lFpfVLtDpjkNAIOfbYDpRpWKmj1jV2k7qbd0pGk0Y3XF+efwBzjwhywIdwxah6p+kmgVOw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(1800799015)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 10:34:22.3665
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d9c4d87-a856-4db9-817e-08dc5f931c97
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8593

This is part 4 of the 4-part series to introduce Share Virtual Address
(SVA) support for devices, which can support PCI ATS, PASID and PRI
capabilities. These devices are referred to as SVA-capable devices in
this series.

It contains the following enhancements:

* Patch 1 - 3:
  Rename, add support to enable/disable features, update DTE etc.

* Patch 4 - 12:
  Add IOPF support

* Patch 13 - 15:
  Introduce SVA support


This patch series is based on top of v6.9-rc4.

This is also available at github :
  https://github.com/AMDESE/linux-iommu/tree/iommu_sva_part4_v8_v6.9_rc4

Thanks everyone who reviewed previous version and provided valuable feedbacks.

Changes from v7 -> v8:
  - Rebased on top of v6.9-rc4
  - Added "iommu.h" to ppr.c to fix build error

v7: https://lore.kernel.org/linux-iommu/20240311090843.133455-1-vasant.hegde@amd.com/T/#t

Changes from v6 -> v7:
  - Rebased on top of iommu/next
  - Trivial white space fix
  - Added Reviewed-by tag


v6: https://lore.kernel.org/linux-iommu/20240209112930.63663-1-vasant.hegde@amd.com/T/#t

Changes from v5 -> v6:
  - Rebased on top of SVA Part3 v7
  - Reorganized, added few patches
    - Patch to track per device max PASIDs
    - Patch to setup GCR3 table for SVA capable domain
    - Patch to enable PASID/PRI only when domain is capable of PRI support
  - Dropped below patches as they are not needed anymore
    - iommu/amd: Add GCR3 [un]initialization function
    - iommu/amd: Add support for add/remove device for IOPF
  - Rework sev[/remove_dev]_dev_pasid() functions
  - Dropped late gcr3 setup patch

v5: https://lore.kernel.org/linux-iommu/20240118073339.6978-1-vasant.hegde@amd.com/T/#t


Changes from v4 -> v5:
  - Rebased on top of v6.7-rc8 + SVA Part3 patches
  - Few minor improvements like renaming structure name for better, introducing macros, etc


v4: https://lore.kernel.org/linux-iommu/20231221111558.64652-1-vasant.hegde@amd.com/

Changes from v3 -> v4:
  - Moved amd_iommu_dev_update_dte() after set/clear_dte() so that we can avoid
    forward declaration
  - Dropped "iommu/amd: Do not override PASID entry in GCR3 table"
  - Added patch to fix PPR interrupt processing logic
  - Renamed enable_iommus_v2() -> enable_iommus_ppr()
  - Added ops->domain_alloc_sva()
  - Added domain_alloc_sva() support and reorganize SVA patches
  - In error path iommu_call_iopf_notifier() calls amd_iommu_complete_ppr()
    instead of amd_iommu_page_response()


v3: https://lore.kernel.org/linux-iommu/20231016104351.5749-1-vasant.hegde@amd.com/T/#t

Changes from v2 -> v3:
  - Rename sva.c -> pasid.c
  - Changed amd_iommu_sva_supported() -> amd_iommu_pasid_supported()
  - Added patch to update/flush DTE
  - Rework part of SVA support
  - Move IOPF enablement to PASID bind time

v2: https://lore.kernel.org/linux-iommu/20230911121046.1025732-1-vasant.hegde@amd.com/T/#u

Changes from v1 -> v2:
  - Added new patch to fix PASID override issue in GCR3 table
  - Complete rework of SVA code on top of Tina's SVA series.
  - Rework SVA enable code
  - Reworked IOPF handler code on top of Baolu's IOPF improvement series.


v1: https://lore.kernel.org/linux-iommu/20230823140415.729050-1-vasant.hegde@amd.com/T/#t


Jason Gunthorpe (1):
  iommu: Add ops->domain_alloc_sva()

Suravee Suthikulpanit (3):
  iommu/amd: Move PPR-related functions into ppr.c
  iommu/amd: Define per-IOMMU iopf_queue
  iommu/amd: Add support for page response

Vasant Hegde (9):
  iommu/amd: Rename amd_iommu_v2_supported() as amd_iommu_pasid_supported()
  iommu/amd: Introduce per device DTE update function
  iommu/amd: Fix PPR interrupt processing logic
  iommu/amd: Introduce iommu_dev_data.max_pasids
  iommu/amd: Setup GCR3 table in advance if domain is SVA capable
  iommu/amd: Enable PCI features based on attached domain capability
  iommu/amd: Add support for enable/disable IOPF
  iommu/amd: Initial SVA support for AMD IOMMU
  iommu/amd: Add SVA domain support

Wei Huang (2):
  iommu/amd: Add support for enabling/disabling IOMMU features
  iommu/amd: Add IO page fault notifier handler

 drivers/iommu/amd/Kconfig           |   2 +
 drivers/iommu/amd/Makefile          |   2 +-
 drivers/iommu/amd/amd_iommu.h       |  49 ++++-
 drivers/iommu/amd/amd_iommu_types.h |  33 ++++
 drivers/iommu/amd/init.c            |  85 +++------
 drivers/iommu/amd/iommu.c           | 283 +++++++++++++++++----------
 drivers/iommu/amd/pasid.c           | 202 ++++++++++++++++++++
 drivers/iommu/amd/ppr.c             | 286 ++++++++++++++++++++++++++++
 drivers/iommu/iommu-sva.c           |  16 +-
 include/linux/iommu.h               |   3 +
 10 files changed, 788 insertions(+), 173 deletions(-)
 create mode 100644 drivers/iommu/amd/pasid.c
 create mode 100644 drivers/iommu/amd/ppr.c

-- 
2.31.1

