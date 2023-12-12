Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F2D56B90
	for <iommu@lists.linux.dev>; Tue, 12 Dec 2023 08:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="38k+SBKZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IJRcpa+8o3eQ2agAXyYCx4oBBeXKfg5/ohYp1KhMCRaRhMGtthePCsMQpj2bPPV5d5Abg8yDkUmZ/PdHk+5cuFn2v4FETenSHwhAzxfUQ12ZQ1L6l+9tsMOkyT5+d+uleFKn6BxKKQmexwd7uJ4RcAz33sJmreVU3JYnG6w4YZ29DPve3CReZOMHFnMRwGwCGV0vahxNP+Xtpg9th/eOMH4ArvWe5UxoI4zrO0QW9CDJ9cfZob3iZd/oyCOVKKNM/0T5HXeZ0nZtGor9yQqT2GxO1J+IUsq8G2UbO068NPH+B8zU4s9vyagvvYkRoZECR5r1RjwaKuGBGkxkXDLDYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXGuhK5fLf+K2MYTQEP7vwwe6SyIvAwMWWVoCFKhkOs=;
 b=mbDLzhM8Z36xwz/D/pWexNOwpk2t2Ufpf2jX/NyEg9LtiOrBNHaHNwtJ3cfkhP7vup5X5l06M6+pct8wphAQEOmpYyZ2h2nzZYhGLw7JRJGNhxwFf542QBkaPE/DFk6/z/NoZFp4BQSsYljdR6fr8sktqh6X1euxYpVZWPI/vgtL9XT4Swzi8zv4fDIH4gmBHONYEfFvlIQG6rx+gG0BBuh0bUyi83Tfgh1/gYihtDhXTE7qmBVhpCXbZzKamndXkeUR7ySuu3znf0HXrFhXC7v94p8bkZAU5ja6qR73o0TT6iSsnGGz16Uyt8V+mnLbDyuq5QCb2NgL99Jja03sSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uXGuhK5fLf+K2MYTQEP7vwwe6SyIvAwMWWVoCFKhkOs=;
 b=38k+SBKZRFA42bC09oCM346tt2qScElhY/5bXz1XJ7JjJ37YkzT9slj5IfjfDqB2zPM9UtY56qqM02EcfCFxsq5539r67pPfBaJJ5sLN628HjRG5pFndWHC13hYIsk3j7zj9XPy9tYKVEi8tLPLP7CZy17FEwM4++aCjVzdnagk=
Received: from MW4PR04CA0331.namprd04.prod.outlook.com (2603:10b6:303:8a::6)
 by SA3PR12MB8764.namprd12.prod.outlook.com (2603:10b6:806:31f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Tue, 12 Dec
 2023 08:52:53 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:303:8a:cafe::c4) by MW4PR04CA0331.outlook.office365.com
 (2603:10b6:303:8a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Tue, 12 Dec 2023 08:52:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Tue, 12 Dec 2023 08:52:53 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 12 Dec
 2023 02:52:49 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v4 00/16] iommu/amd: SVA Support (part 3) - refactor support for GCR3 table
Date: Tue, 12 Dec 2023 08:52:08 +0000
Message-ID: <20231212085224.6985-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|SA3PR12MB8764:EE_
X-MS-Office365-Filtering-Correlation-Id: d98f54f3-34d2-462d-6119-08dbfaefba3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VWlrl9FGqx+8bGq4+Veyt+n0UelNFlSufquyyNG6JunjSXSGgjqKYQI6fHpy0Gr8KSJ8vENoWinD5VjV5aw3e0rXgYMna0bGYMsfSNzsKJ8N3QAHGnGUdbKihi3A/qZsHZrXU/MCz6C7YPXrkO4T4Wlvbfc4a0ak9NOaqRpc69PKzk+OA3NG5rNzVLLY0Oa+iNS1PPOTqksqNl3H2P1vENzoLM3jkYjOgBNqQrYVmK6xS0VBBvBVSEryTzDgg2XrV+kGza2i6dg+xG8WE/HFlPxZitd5cKjVrRC1T3VY83SZ5LyTtGW880SNsfBfcGN5aqB6NhbDTKqAi7Q8D908t1CihBSfCKRzCAZULB0VrW2F9usZcnSZRCmPXQMlMjOFkaqHNIXDw2UrQWEhAl9DoEydWJveVoT1WzSkPGbsSFS1CUc+3w0sAZubytGG5QXteIo4yots61Qb5d697axRv5Db6JDuryZ80NcYlfHR01PJjwMy+2zfXWF16xM/GPyCZyKIMKB3/7G4R4PodN3Lu7zYPO9QsqAxj0AdGeh6qcFXZrUK1EXghDyUaT76juvZAcyDz23jPqz24qQSxlDa4BCxjqoBdOUwFNdVHGpA8krHQ8nub9ahqTDQ/Ngn5LE5NugTke9GYqN8CZzTSIc+3rXIqOXXJ0lT2A9QtvBN3ZrcQ9aDErSqWL6nlytS2ZSzNiJJUCrouBw+T31Ur2Bvw6uWaJpO5RSdF9zT45Iptk5pXn9S08cE38OFrMSIGcZAHEOcsR8rEGKP4HhkrynuUr6VcANqbaBDm838yN6wHoM=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(82310400011)(36840700001)(40470700004)(46966006)(40460700003)(36860700001)(1076003)(47076005)(5660300002)(336012)(26005)(2616005)(16526019)(44832011)(36756003)(40480700001)(426003)(70206006)(54906003)(70586007)(966005)(2906002)(83380400001)(86362001)(82740400003)(81166007)(478600001)(41300700001)(356005)(7696005)(8936002)(4326008)(8676002)(110136005)(316002)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 08:52:53.0141
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d98f54f3-34d2-462d-6119-08dbfaefba3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8764

This is part 3 of the 4-part series to introduce Share Virtual
Address (SVA) support, which focuses on refactoring GCR3 table.
This moves GCR3 related information from protection domain
structure to iommu_dev_data (per device) structure.

It contains the following enhancements:

* Patch 1 - 3:
  Cleanup and introduce helper function

* Patch 4 - 13:
  Introduce per device GCR3 table, per device domain ID, invalidation based
  on per device and code refactoring

* Patch 14 - 16:
  Remove unused variable, rearrange functions to make it easy to maintain

This patch series is based on top of iommu/next branch (commit bd19c7637024).

This is also available at github :
  https://github.com/AMDESE/linux/tree/iommu_sva_part3_v4_v6.7_rc5

Thanks Jason for reviewing previous versions and providing valuable feedbacks.


Changes from v3 -> v4:
  - Added new patch to enable IOMMU GT feature early
  - Fixed dirty tracking path to use get_amd_iommu_from_dev()
  - Fixed duplicate flush issue in do_attach() path
  - Removed gcr3_info->giov variable. Instead we use domain page table mode to decide
    DTE[GIOV] bit.
  - Free gcr3_table before calling set_dte_entry (otherwise there is a possibility
    of its setting up gcr3 table with glx 0)
  - Adjusted gfp_t flag for GCR3 table allocation (GPF_ATOMIC -> GFP_KERNEL)
  - Moved below patches from invalidation improvement series to this series
    * Remove unused flush_pasid() related functions
      (Originally it was part of Invalidation improvement series, I had to push it to
       this series as set_gcr3() was still using __amd_iommu_flush_tlb()).
    * Added patch to Rearrange device flush code

v3 : https://lore.kernel.org/linux-iommu/20231013151652.6008-1-vasant.hegde@amd.com/T/#t

Changes from v2 -> v3:
  - Dropped "iommu/amd: Use struct protection_domain in helper functions" as flush related
    functions are already fixed and set_gcr3 related functions is reworked in this series.
  - Removed moving to_pdomain() function from this series. It will be introduced
    in SVA series where it will be used.
  - Added per device domain ID and per device invalidation functions
  - Added functions to flush TLB for the given device
  - Added Review-by tags

v2 : https://lore.kernel.org/linux-iommu/20230816174031.634453-1-vasant.hegde@amd.com/T/#t

Changes from v1 - v2:
  - Dropped iommu_v2 module related support as newly introduced Part2
    removed iommu_v2 module.
  - Moved Patch 'Use struct protection_domain in helper functions' from Part1 to
    Part3
  - Updated get_amd_iommu_from_dev() to retrieve iommu from device structure
  - Removed 'PD_MODE_PT'

v1 : https://lore.kernel.org/linux-iommu/20230808100232.5977-1-vasant.hegde@amd.com/T/#t

Suravee Suthikulpanit (8):
  iommu/amd: Introduce get_amd_iommu_from_dev()
  iommu/amd: Introduce struct protection_domain.pd_mode
  iommu/amd: Introduce per-device GCR3 table
  iommu/amd: Refactor helper function for setting / clearing GCR3
  iommu/amd: Refactor attaching / detaching device functions
  iommu/amd: Refactor protection_domain helper functions
  iommu/amd: Refactor GCR3 table helper functions
  iommu/amd: Remove unused GCR3 table parameters from struct
    protection_domain

Vasant Hegde (8):
  iommu/amd: Pass struct iommu_dev_data to set_dte_entry()
  iommu/amd: Enable Guest Translation before registering devices
  iommu/amd: Use protection_domain.flags to check page table mode
  iommu/amd: Introduce per-device domain ID to workaround potential TLB
    aliasing issue
  iommu/amd: Add support for device based TLB invalidation
  iommu/amd: Rearrange GCR3 table setup code
  iommu/amd: Remove unused flush pasid functions
  iommu/amd: Rearrange device flush code

 drivers/iommu/amd/amd_iommu.h       |  25 +-
 drivers/iommu/amd/amd_iommu_types.h |  27 +-
 drivers/iommu/amd/init.c            |   6 +-
 drivers/iommu/amd/io_pgtable_v2.c   |  21 +-
 drivers/iommu/amd/iommu.c           | 646 ++++++++++++++--------------
 include/linux/iommu.h               |  13 +
 6 files changed, 371 insertions(+), 367 deletions(-)

-- 
2.31.1

