Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD5828E39
	for <iommu@lists.linux.dev>; Fri,  9 Feb 2024 11:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707478194; cv=fail; b=bkhjCKRjuwyao0MGOodigTPk3L5SyrRLW1iEQ/SlXPHQJKOu4r2JoY762a3+sdEQHQ4res6lsMMusZeK5L3Eb76BMYepR4LDtvjdCMcotqALaR5TCk2uL70btGsHZ7y426H0qUI6+vH36BGL4EJwlSsYO4ihbKjqUG1Py8QAg6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707478194; c=relaxed/simple;
	bh=gYx6ijp9w6l3FP/bj0tMcSP1eBMNaiw6VwFzkBaz6mM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iAg2FYt6HpbrsQXNIQ/53WN+znShxqJrf0Q4xSjT4L74Jl5DwASAYd7F/RPntAB19djYsouocPhw3XCBwY78XgC1M6Xta3F+ku/eN27rDBvo8//XAK6OkqOv/LpwvYKELZulkLTWPShuEpJYgZHt6nlmWTVa8X+l5BRd+ObzN+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0uT81pII; arc=fail smtp.client-ip=40.107.223.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0uT81pII"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCa5J8cOr3LymTtGxp99vR4Mmb4dtAhXDyGoJ2FXUQUgiHHGFR6WWmpdc9PbslwG/CJG7z8Vig9/UivjzSVoPCHFufqLDAhWbiZGQw5ajFvkUIpucz9TvUh0nWdSoyf1V9rAssQ/RHdXfqv5gGGYKeyAmFinl7glSt9B9Xn/n9POZduKbmqDfje2JHosB59tZeZV6je1cxITj6QP4jl9Um7Z3VNcnRQCONWQn8+4BbteIbQq1ZSX75Bxa9dhNc8o1uoJqeH5Hr081JiUDtij/E9vDR4drvJihQywLxzntA9L1Opsd4AzkfyudmuOEwJ2gZN3d4Ufi2uFLLnSkNEIbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwQILCqXVNuqlrulJE7nOS/OxRwhjMGKcGHWwk+eZLI=;
 b=QseBW0Ae/qHPeRbvqd8FNak5r8AAWYcNeE/FqFV8RLcoEC+GkxaSg9EULuI2cQ4eaOkwq995UQ7KLuscMbTKtfbuHcWaWP6k7BXIsT5APrLoHzbO9nJIYipZJUWc6/ut5i12pUE9+w/K3fsg+ATMYkywqS5yOKJTzLmSb2Ll8x3ozIGJYNdE1z81jfzHcsP+3YemcJR5dCqn2rKuUUOS/Ghd/qBp9d16pXyu6ewSYojqA3kSIEqTMrqNmBxTMPUqWILPh2YYDQOFoxrbSzLm/LjZ7+anac2GQ5J39+5ebCZ9qyD74BTbc7Tfv4kCTMSMG2jawSAjQJAP37GcEgaYfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwQILCqXVNuqlrulJE7nOS/OxRwhjMGKcGHWwk+eZLI=;
 b=0uT81pIINEGUwR66sYRQIRTQwm5iDrM3TfKbWZe8mb5gFQu+CESHb6fD5MS5DtLSMhphSp0vMCDoSX08Wo8VYKyhAdQ9I6CuS8228nYgqk6MHzqnbwJurGgqMG5TcpLdRd6llMBagvRR/GqzB6chR0UHvAoDaLb3rEGSl7ytOs4=
Received: from CY5P221CA0145.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:6a::25)
 by DS7PR12MB5960.namprd12.prod.outlook.com (2603:10b6:8:7f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Fri, 9 Feb
 2024 11:29:49 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:930:6a:cafe::57) by CY5P221CA0145.outlook.office365.com
 (2603:10b6:930:6a::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24 via Frontend
 Transport; Fri, 9 Feb 2024 11:29:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.79) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Fri, 9 Feb 2024 11:29:49 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 9 Feb
 2024 05:29:46 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v6 00/15] iommu/amd: SVA Support (Part 4) - SVA and IOPF
Date: Fri, 9 Feb 2024 11:29:15 +0000
Message-ID: <20240209112930.63663-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|DS7PR12MB5960:EE_
X-MS-Office365-Filtering-Correlation-Id: c36821ad-3136-4234-9fb9-08dc29626d17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	c446HiJaxW/TWYk0jPEvS+8oosSk3uqzCZSNdccVmmGcrtERNB2fefzWsBEwfhb6S5Bx7yza+FvawJ4dIhTrnbF82HMLGeIJCHSMJkE0WpXECuDDqL6ohEJWLCN+qKjII8LtBtCXlCIqcUS8aZIiFGGBH+4VR5zawPrtLVBJia9QRhvmqnmOKPjP5F5InWiAS0WaNiAvdS8ilO01I7q1b4/JcO5USeg29HnqMxryHX3Y1vP+uaKa/GwXV/btUhgpGvXESUC4Yw97efvUNj3TV9wkQSTgEnu6tACrlLc7dQkQQhqGPPIvWYpkhYtzUeStq2VhA68aX6dFcT55BlDVeiYNfgoQcR1UzJH8p8DyU+D05iSk1PNRrBlgb/SkudFsoBdyINiZ0y7kGcKWzWyH7jhSQ+HNtyK3vsQkDRBQe18tXdbGlnu2pYWEjBZAbkkQJnpKLUymBeYPemgm71CvyFeePIQTXKC5cjOusOJY3SHutDDTiGavdyRYeOcqjUoRLUlDKTgVGfTKXSwYviAerWWjQAS1ohZbOMYPq/cURCjSWRWCYLHmMdWzdXS+puBUwxs73J2tjJljFUvLMBDhsg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(39860400002)(136003)(396003)(230922051799003)(451199024)(1800799012)(82310400011)(64100799003)(186009)(40470700004)(46966006)(36840700001)(2906002)(4326008)(8936002)(8676002)(5660300002)(44832011)(336012)(426003)(83380400001)(2616005)(26005)(16526019)(1076003)(82740400003)(36756003)(81166007)(356005)(86362001)(110136005)(70586007)(70206006)(54906003)(6666004)(7696005)(966005)(478600001)(316002)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 11:29:49.2316
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c36821ad-3136-4234-9fb9-08dc29626d17
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5960

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


This patch series is based on top of SVA Part 3 v7.
  https://lore.kernel.org/linux-iommu/20240205115615.6053-1-vasant.hegde@amd.com/T/#t

Also depends on :
  1) Baolu's IOPF improvement v12
     https://lore.kernel.org/linux-iommu/c918825d-ad74-4b1d-abcc-31c3f3ea4620@linux.intel.com/T/#t


This is also available at github :
  https://github.com/AMDESE/linux/tree/iommu_sva_part4_v6_v6.8_rc2

Thanks everyone who reviewed previous version and provided valuable feedbacks.


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

V4: https://lore.kernel.org/linux-iommu/20231221111558.64652-1-vasant.hegde@amd.com/

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

Thank you,
Vasant / Suravee


Jason Gunthorpe (1):
  iommu: Add ops->domain_alloc_sva()

Suravee Suthikulpanit (3):
  iommu/amd: Move PPR-related functions into ppr.c
  iommu/amd: Define per-IOMMU iopf_queue
  iommu/amd: Add support for page response

Vasant Hegde (9):
  iommu/amd: Rename amd_iommu_v2_supported() as
    amd_iommu_pasid_supported()
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
 drivers/iommu/amd/amd_iommu.h       |  50 ++++-
 drivers/iommu/amd/amd_iommu_types.h |  33 ++++
 drivers/iommu/amd/init.c            |  85 +++------
 drivers/iommu/amd/iommu.c           | 284 ++++++++++++++++++----------
 drivers/iommu/amd/pasid.c           | 202 ++++++++++++++++++++
 drivers/iommu/amd/ppr.c             | 284 ++++++++++++++++++++++++++++
 drivers/iommu/iommu-sva.c           |  16 +-
 include/linux/iommu.h               |   3 +
 10 files changed, 788 insertions(+), 173 deletions(-)
 create mode 100644 drivers/iommu/amd/pasid.c
 create mode 100644 drivers/iommu/amd/ppr.c

-- 
2.31.1

