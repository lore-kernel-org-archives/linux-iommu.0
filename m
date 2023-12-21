Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2079.outbound.protection.outlook.com [40.107.100.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A176AB88
	for <iommu@lists.linux.dev>; Thu, 21 Dec 2023 11:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JjaFqvvz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8N/wXvwT+hvloGDYy5DW19Fg91wj9WMm9WYMIt78rLWS4mP+zwFyOndSli7yaOtjZI1cOHNHxfK0wVJwdjqfxbH3yNKWmWFd6wogLRC0bVqCg1gv4Zi0NWF+UZcWnX40STdTq0Vyi2qraLfy0FGlZM8znufI32+TogEZRCRol+0jKV3T0WfhwkB/zs67PJDj508ZGXApRgy8uOXmNO6aKNAmHzomtqbVSP2ATQKUXxB2ldS2lRip/V8++1EJyFyE2xXcy8YS/fPs2d4YDhYJ0uWimw9su5iOi8yr55MZHS5+8VPJSBBgltgW1qzgshnB9j2wnRMsN586IblITovSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=36n7KMNOjA16b1hed0l6mUCoPIzzaAwVf7tkGWixjbs=;
 b=jc1vCTpMjazG02VkpAfTaiF7HRmss677e1zBoC6/bSDNqtzRP6R9m2IqU45AMp2NTN2YpJHrruJE58vTyJsVrTfU1DN8AAlerIADAiHggbpLzfDe91zSh/rvDkT9gRELBLidIoww+N49008YfDwvIxwwy+CuhK6PT+6zgqwl7HqZSfGDdZG4S+D0nGexmVtqp0wVddNPddYXVnCgokAc0x7wOkKFNj8DrSU+sSSoscgUqefGCVPXPPEeDnw20xQyu90V4cYt1OmPpcf5D94V+niis4jHnZERdJlz6To92jdPywu/0XJZS9nBKTfye3kWZNw8hdTqiRTvCidTgvLFeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36n7KMNOjA16b1hed0l6mUCoPIzzaAwVf7tkGWixjbs=;
 b=JjaFqvvzjZ7c09gGJm7V7XTPAC3suTGihUnMidrYjqFRI+AWxdVMftezPwAL77Tmz+jj5k0hCp2jDyXyruMoESLu/6duL2RodgRG2NPTIcx/8VzbjyA/gi8J2XfuULhwgB8SPEcDBSXJFoFgjYSw5WmpCsm9iXoELyXOvxYHlfE=
Received: from SJ0PR03CA0150.namprd03.prod.outlook.com (2603:10b6:a03:33c::35)
 by BL3PR12MB6548.namprd12.prod.outlook.com (2603:10b6:208:38f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Thu, 21 Dec
 2023 11:16:21 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:a03:33c:cafe::95) by SJ0PR03CA0150.outlook.office365.com
 (2603:10b6:a03:33c::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Thu, 21 Dec 2023 11:16:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Thu, 21 Dec 2023 11:16:20 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 21 Dec
 2023 05:16:17 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v4 00/14] iommu/amd: SVA Support (Part 4) - SVA and IOPF
Date: Thu, 21 Dec 2023 11:15:44 +0000
Message-ID: <20231221111558.64652-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|BL3PR12MB6548:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fad1a97-11bc-48ef-cc73-08dc02164286
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xcwSUJAC/DLyjE5NCMNIMYZl+tF10Qq0TR2gUcN3qYbS8taH2XBhKQRKTi7XJ0GQ2rTZ8pAW9Yxk5CWsJyyTgTfovv9tToPdrIKopK4Up/886SFog7kZ4FB2faz0TbdoGFdbdW82k4NT873duaWLiHpr/ZiAWLffr5MFD+T9g4bZK8jiJYUJOwK+s1rNyk8k4IeCJFkLzvaYm99MB9OzkOD4by7g+G24/aO1iN6XkFsUgPpp14dYVD/tQdJXfUdtAK42kOQLlL34vQ3a20pTi7L87v4SlbU4yv6VriP7FtXkvBkeF82B3/GShMj4xKzVDN1FXxEr0xK3pJsD4Xn+0o7Tr9aTs43K/6xDrfmj6F5VKiQrTtuzGYsneY2tutZjzMy6pSuDSmJUiytjW0BY1sR6AgtvNljmJKp9G+IZsSuPkZ8wNQnOz/1YsNNJgtK9p1ldAvFy862JGouSsbBVtSekQyqx08GnU9NHULCbw9poxzhPEpyhuxcr2s+4ga4fcPsUtYpRypXWxXJgIyn7cp3eLO7dcE4U/5BFCxFNe51OuVhp7dGzsqU8BCb6PUkBhkxbf6AYVVi+ra1CCgW0WfRPtW4GXNAw1UHUwE/yaCjEOIg7kXBo6pcrrTeMPxaZ7ruqHDhXJlHLZyh6picpzE3Khy4gl5NKra+IMrXMKdyCg/HBEFDqNd8Z4AhGrhMkxXG8ytW8qb/hJNAVE3rNKHCWMSNepZaJtUB5RAJ9/Zi0HLIby0+ExBxLxfxojO7Kd4E7ZEp0P16LDCUHwj/d7WwyK2oD03COL1gEafQUA3k=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39860400002)(136003)(376002)(230922051799003)(451199024)(82310400011)(1800799012)(64100799003)(186009)(46966006)(40470700004)(36840700001)(6666004)(2906002)(86362001)(36756003)(356005)(7696005)(478600001)(36860700001)(26005)(83380400001)(47076005)(82740400003)(16526019)(1076003)(2616005)(336012)(81166007)(426003)(41300700001)(5660300002)(966005)(54906003)(110136005)(70586007)(70206006)(40480700001)(4326008)(8676002)(8936002)(40460700003)(316002)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 11:16:20.7028
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fad1a97-11bc-48ef-cc73-08dc02164286
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6548

This is part 4 of the 4-part series to introduce Share Virtual Address
(SVA) support for devices, which can support PCI ATS, PASID and PRI
capabilities. These devices are referred to as SVA-capable devices in
this series.

It contains the following enhancements:

* Patch 1 - 3:
  Rename, add support to enable/disable features, update DTE etc.

* Patch 4 - 10:
  Add IOPF support

* Patch 11 - 14:
  Introduce SVA support


This patch series is based on top of SVA Part 3 v4.
  https://lore.kernel.org/linux-iommu/20231212085224.6985-1-vasant.hegde@amd.com/T/#t

Also depends on :
  1) Baolu's IOPF improvement
     https://lore.kernel.org/linux-iommu/cbfbe969-1a92-52bf-f00c-3fb89feefd66@linux.intel.com/


This is also available at github :
  https://github.com/AMDESE/linux/tree/iommu_sva_part4_v4_v6.7_rc5


Thanks everyone who reviewed previous version and provided valuable feedbacks.

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

Suravee Suthikulpanit (5):
  iommu/amd: Move PPR-related functions into ppr.c
  iommu/amd: Define per-IOMMU iopf_queue
  iommu/amd: Add support for page response
  iommu/amd: Introduce logic to enable/disable IOPF
  iommu/amd: Add GCR3 [un]initialization function

Vasant Hegde (5):
  iommu/amd: Rename amd_iommu_v2_supported() as amd_iommu_pasid_supported()
  iommu/amd: Introduce per device DTE update function
  iommu/amd: Fix PPR interrupt processing logic
  iommu/amd: Initial SVA support for AMD IOMMU
  iommu/amd: Add SVA domain support

Wei Huang (3):
  iommu/amd: Add support for enabling/disabling IOMMU features
  iommu/amd: Add support for add/remove device for IOPF
  iommu/amd: Add IO page fault notifier handler

 drivers/iommu/amd/Kconfig           |   2 +
 drivers/iommu/amd/Makefile          |   2 +-
 drivers/iommu/amd/amd_iommu.h       |  51 +++-
 drivers/iommu/amd/amd_iommu_types.h |  27 +++
 drivers/iommu/amd/init.c            |  79 ++----
 drivers/iommu/amd/iommu.c           | 182 ++++++++------
 drivers/iommu/amd/pasid.c           | 277 +++++++++++++++++++++
 drivers/iommu/amd/ppr.c             | 362 ++++++++++++++++++++++++++++
 drivers/iommu/iommu-sva.c           |  17 +-
 include/linux/iommu.h               |   3 +
 10 files changed, 862 insertions(+), 140 deletions(-)
 create mode 100644 drivers/iommu/amd/pasid.c
 create mode 100644 drivers/iommu/amd/ppr.c

-- 
2.31.1

