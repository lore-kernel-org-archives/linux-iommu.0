Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9208F55
	for <iommu@lists.linux.dev>; Thu, 21 Sep 2023 09:22:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JabyDKbD1CiXdlbqLqK+dfFsUyGIfkFeKFUPFvA8ZzR4fF0/BR4i53W+o3wDusoIKt9igcIeXbwcPDU+LGZP66WH/5QDfjehJ95lNdIROaRtfREXS9PPupLt3WbF/IIjjRW5Mgy0c791RWuajMP83cBfleT+54HWdnmIGxrgdICw0g6DntIpOJlj36AyYY1bkxCwdr3tHdQnQdYH36RwuoxewV3kMv82GCZQDoe9m+d5wi2uAB5ptbsDPaEowrsFbSKwYniaj85uUbhJsV1rbvFJWiU4oF/TUzzxMW1o68A4y7U2q8A2ZhDMQK/xCJNEl7l+LWggVYdHFtmEf4Ea4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+4VCX9qa4KFlI/lOO08+geAdbzu/EZzDDTTGDIz4tM=;
 b=dLHpKqvUlEeMyShJNcmnSVwcpW5P4b2cos5PJfl7ZOCc9daWCYdkpiHuCxw4pjPxdwRuqI6Qsls2yyWqrfAJSCIsaitFthBykisoM5JSHFMkAytUHa1FkZRz/Ab8lDmE3YS/TYZNEHwEJTiK+enH1w3D8SP4TNbtimcEry9on+mGHviHg9ErHSvdMMHptKTH6o10cnHuJJBxbs07GLdb11txTeGemfulDa8GrZBt7Cmjqqaa0TP//GtkdIxcNqOdVOM5sKNeNtOMq8MgWcg5NmceHCGbNVqlh5ZnTAkOnErYcbY4lznApBcUGNx7QOg6DSzB+I/DGtsFb9o83CirsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+4VCX9qa4KFlI/lOO08+geAdbzu/EZzDDTTGDIz4tM=;
 b=eLQJxlPW0eqamWIXbUMgQw965hxh9cljj1MalOfTACFGm5sWKUHKEmg0U5HQTqTtwOLmcZYC3p8Aj5juLcT/YOMJd4f2NZz5cs27U6OXx1scjz1HsCowiT6UufdePaNO5GXvPjxqU/MtuGCSHs3ny3BE0bhaSwOJ0cuvZeL7iuA=
Received: from CY5PR13CA0011.namprd13.prod.outlook.com (2603:10b6:930::16) by
 DS0PR12MB9038.namprd12.prod.outlook.com (2603:10b6:8:f2::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.19; Thu, 21 Sep 2023 09:22:19 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:930:0:cafe::e5) by CY5PR13CA0011.outlook.office365.com
 (2603:10b6:930::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.9 via Frontend
 Transport; Thu, 21 Sep 2023 09:22:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.76) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 21 Sep 2023 09:22:19 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 21 Sep
 2023 04:22:11 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v6 00/14] iommu/amd: SVA Support (Part 1) - cleanup/refactoring
Date: Thu, 21 Sep 2023 09:21:33 +0000
Message-ID: <20230921092147.5930-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|DS0PR12MB9038:EE_
X-MS-Office365-Filtering-Correlation-Id: 77a56bab-5608-4bd3-0f9d-08dbba84412e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cBA+A8RmekfAbff30BsepNZq2QWCe+Xk7aJIweeJAkX/mW8MskRRsEpG2n1Nlu3Bai3UUCYsknzUNnKGmVkvFY4SonhYXkMZlYp0F5ENm87BJ2ZdivgYdeM9i9H728krKbgUCrTDUmIAYOcHDe6bQ/Fy9m+88IONfeME/c0Woec6qvuan2kkUhvlyIbaKLlcUbSUmKWJmRoDSXlaD8AnwAG+KgmKDth6hTHgEu7cmbJY7JdESKk/RRiTzvA/ed7qlpbjid/GW5r05CC0kU9maFMGDNbmb+aHR1454YG5GnY+Pz58Dx40aZcHGRVodj59siIQFDEgcC/XRfEQB5qcC5GB7b6lLzEEBSVrM27fTPx8QZW1+0YLW2ZLLTdobaOCXXM2Mjyz8xRqpMp1xpBj0aLwi5ixApxQ7oE3famjNoDm+gZzoDOhOL7qhEQmqn1EctaKH4wKWiaPPWzxdJs8kYO9E5gwg9JLzJnp9zDDC9kd25o8+ECCqA9LzKioruCQbFcCFUwTIvc30N5p/IAVoGdRkglYhuhErHf9ZQVikNAMQ/UYSXMXfV1YbmmAqxUsiYacXyp4dwBsNlez9i2knw3/HkkCKslYpt1HK+tV89eH7Muks5NSAklfgPElWG/EXECEfMqn66rckLIc1j2kEIN+VOC73LIFy9GSQUsKFtLkDDx8h/mMtRxBH7VVhPQ7he5ISBr/OGFxhZqJXg7hNqQpoT8Rudy5qFHWV/RK+NP7g3YWn2/l45UV0aZBlMJE0KoN21ks0cbCbnBWu6zVfLmuSC+VQXvlTATEMcTq2HY=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(82310400011)(1800799009)(451199024)(186009)(40470700004)(36840700001)(46966006)(6666004)(7696005)(966005)(336012)(478600001)(47076005)(2616005)(426003)(16526019)(26005)(2906002)(70206006)(70586007)(44832011)(316002)(54906003)(110136005)(5660300002)(4326008)(8936002)(41300700001)(8676002)(40460700003)(81166007)(1076003)(86362001)(36860700001)(36756003)(40480700001)(356005)(82740400003)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 09:22:19.3950
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77a56bab-5608-4bd3-0f9d-08dbba84412e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9038

This is part 1 of the 4-part series to introduce Share Virtual Address
(SVA) support, which focuses on cleaning up and refactoring the existing
code in preparation for subsequent series.

It contains the following enhancements:

* Patch 1 - 7:
  Clean up, refactoring and miscellaneous improvements.

* Patch 8 - 9:
  Use global functions to check iommu features

* Patch 10 - 14:
  Modify logic to independently enable PCI capabilities (ATS/PASID/PRI)
  for devices. This allows more flexibility in preparation for SVA and
  IOPF supports.

This patch series is based on top of linux v6.6-rc1.
Base commit : 0bb80ecc33a (Linux 6.6-rc1)

This is also available at github :
  https://github.com/AMDESE/linux/tree/iommu_sva_part1_v6_v6.6_rc1

Thanks Jason, Jerry, Robin for reviewing previous versions and providing valuable
feedbacks.


Changes from v5 -> v6:
  - Rebased on top v6.6-rc1
  - Added Review-by tags

v5: https://lore.kernel.org/linux-iommu/20230821104227.706997-1-vasant.hegde@amd.com/T/#t

Changes from v4 -> v5:
  - Changed dev_data.ppr from bool to bit field
  - Reverted sysfs_emit that was changing existing behaviour

v4 : https://lore.kernel.org/linux-iommu/20230815102202.565012-1-vasant.hegde@amd.com/T/#t

Changes from v3 -> v4:
  - Dropped patches that were touching iommu_v2.c as we will be deprecating
    iommu_v2 module.
  - Dropped Review-by tags for the patches which got modified (mostly the
    patches that were touching iommu_v2.c code).
  - Introduced new patch to use global EFR/EFR2 to check the iommu features
  - Pass enum to set_dte_entry() instead of bool
  - Used DIV_ROUND_UP instead of loop to calculate gcr3 levels

v3 : https://lore.kernel.org/linux-iommu/20230804064216.835544-1-vasant.hegde@amd.com/T/#t

Changes from v2 -> v3:
  - Removed fallthrough from switch-case
  - Added lockdep_assert_held() instead of comment on top of the function
  - Moved macro defination (PPR_HANDLER_IOPF) to the patch where its
    actually used
  - Use helper function to allocate memory instead of get_zeroed_page()
  - Converted boolean to bit fields

v2 : https://lore.kernel.org/linux-iommu/20230728053609.165183-1-vasant.hegde@amd.com/T/#t

Changes from v1 -> v2:
  - Dropped GCR3 related changes from Part1. We are reworking
    GCR3 management based on Jason's comment. We will post them
    as separate part.
  - Addressed review comment from Jason
  - Added iommu_dev_data.ppr to track PPR status

v1 : https://lore.kernel.org/linux-iommu/20230712141516.154144-1-vasant.hegde@amd.com/


Thank you,
Vasant / Suravee


Suravee Suthikulpanit (8):
  iommu/amd: Remove unused amd_io_pgtable.pt_root variable
  iommu/amd: Consolidate timeout pre-define to amd_iommu_type.h
  iommu/amd: Consolidate logic to allocate protection domain
  iommu/amd: Introduce helper functions for managing GCR3 table
  iommu/amd: Miscellaneous clean up when free domain
  iommu/amd: Consolidate feature detection and reporting logic
  iommu/amd: Modify logic for checking GT and PPR features
  iommu/amd: Introduce iommu_dev_data.ppr

Vasant Hegde (6):
  iommu/amd: Refactor protection domain allocation code
  iommu/amd: Do not set amd_iommu_pgtable in pass-through mode
  iommu/amd: Rename ats related variables
  iommu/amd: Introduce iommu_dev_data.flags to track device capabilities
  iommu/amd: Enable device ATS/PASID/PRI capabilities independently
  iommu/amd: Initialize iommu_device->max_pasids

 drivers/iommu/amd/amd_iommu.h       |  28 +-
 drivers/iommu/amd/amd_iommu_types.h |  31 +-
 drivers/iommu/amd/init.c            | 116 +++-----
 drivers/iommu/amd/io_pgtable_v2.c   |   8 +-
 drivers/iommu/amd/iommu.c           | 442 +++++++++++++++-------------
 5 files changed, 322 insertions(+), 303 deletions(-)

-- 
2.31.1
