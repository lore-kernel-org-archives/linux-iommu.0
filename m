Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2054.outbound.protection.outlook.com [40.107.212.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F8018643
	for <iommu@lists.linux.dev>; Mon, 16 Oct 2023 10:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wh23hS9c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SmrHno11umXh8lAYQm8ZhFmIO4J9KLmglI+MvOolxrVYCN/u+fH2hk6ksmeObmaCyW2hpibUHXomONpywZiuHVVkYOu4BmmGZHrend0pGZjhVlrnx82U7oAaIkEqQCKb4DyPRFeHSlaz30i+zI+0otgJrsrfJIR/gzW29wLkqNdYh/rg+6ATvR8Bi+lR09uHbd5rDAFczHDsqamgQjk07UkDsbJwdd99AtPvqrRxy583klqFgLzouWtrhZ/nPJDJA4bHyPbn2mwbDE/ktd01GczuyHrQRBUsKSDecn6dxso9mEIxa8xcVZwF47/H9v07pdQM1ZAyuigFiRSvAbAeug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGgw3+PzjdGbJX4XUWkyqPHJgR9I9qJ5M3xKMaCRTNA=;
 b=FgMa8sh60mpdrsaIepS1CQ9DFX8oGCL9TmQ4utymCaJISp4IX8p0vFKoeqcNZR2q1wq8wdqBPOR3dCS6bKE01VgcuQcRmhEf1ukTRs8XcAYCr5se6cGXr5zloVbNi3a49iJzNhx65Jz4u/RI4T69iozONiDmYwNn/S6Ifda/U8HHLLZqCzTeOr9QKYPbc4O9ImgyoOTqZ8DkVMDEn9vazVysTz2tK8VNj6IoMGjN/dOpH0ipcMzD69O7jve09WeJglUEBs9nMMxxKSpirVlWRULaCMduZaIndASmftt0hzeOzQuX4YnmTjCrS+hdaiOcpoBbS6dH9xztbIyHMV2tjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGgw3+PzjdGbJX4XUWkyqPHJgR9I9qJ5M3xKMaCRTNA=;
 b=wh23hS9ctx5aqlEaXPgZYuzskqBUCrxoZPLb2W3xTr/ZlyiJ4awIBSREheousfGa0rUQ3tfYtffUc1MBbVDPPSV9GOA50H9VPosQDDYmHIkDGyrwlyVhnVeLLFy5naeik4DZ2T57CcoUlfPIRB7F7F5fKelubg4CnMO4rC51Sto=
Received: from MN2PR16CA0021.namprd16.prod.outlook.com (2603:10b6:208:134::34)
 by SA3PR12MB7976.namprd12.prod.outlook.com (2603:10b6:806:312::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Mon, 16 Oct
 2023 10:44:45 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:208:134:cafe::e8) by MN2PR16CA0021.outlook.office365.com
 (2603:10b6:208:134::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37 via Frontend
 Transport; Mon, 16 Oct 2023 10:44:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 10:44:45 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 05:44:42 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 00/12] iommu/amd: SVA Support (Part 4) - SVA and IOPF
Date: Mon, 16 Oct 2023 10:43:39 +0000
Message-ID: <20231016104351.5749-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|SA3PR12MB7976:EE_
X-MS-Office365-Filtering-Correlation-Id: eec7667b-e367-4497-9478-08dbce34e9a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DT9ul3MD0ug7L76SWKY3yT+yjGlNlWRaO56mLbW8wxlL1WVRdOr7bZmCWG3DifDDShgEqMcU0d5hspRaJpfRGbhV2x+x+VehXEMlWD04v73UGDMCYR/eCFOqVNNYB2oOozZ1ZrmqcwWlRFOBlITWvk59rTTJuMp8JSsK5MkzmqvOFSuxbWdIXv8PJGPlQD75f3p8zmgHjF6nS5vN44Ylpf/ROam0UIG1xNCnAJUvjbLyIBS+2OEmoUQ11eo7jIQx7ahSw6huVxcS0v119SBEGd7zB/oVVodiCbIroWySaT2ps+xjGuDS8tyjknUBwV7Axqa3MLdxa8AoXIRN9tcyxhRxkmzBuuZi140Jtkzb3WRbU8szHe+TP3tTFkz7j8QWAKsbanzXAze57Ev4ykKYjpJThbtUiIU9yyopxY/ioAWSQg3G7+PNx3+3hSNhjdCgAOV/oOi60p5vhUURBdhqDoawpBGiNGomvwayokgAV8f1/OQLcfpJ1EmXOQrP+js/Xz4SVQMQ8nVn7oxMluCo7oQIe/M77b2X2QuEpthcKVd83i1+R9rvuvEYD+kPweKH6BV/yBhGks30TxBq5PAMf9mi1xhBJMTqg++Aj45/mXq8Wx80JhGMYA14EsiUx4G7VF22qmEUjd1ie/kLUJx1wvrOCPvLcUiHSkobOlfaEyL6Zf286UShAzSlm2C9cszap68dwQAinj1l/baZ1DrRuj+m1UglHeIIPO8O/Q4mwVD1LQqFGrEZIqwFGYhoGqYdewHaOeG0t6xoPJsLLVvTD+JtqX8kYxEX1iMrVEC1gB8=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(396003)(136003)(346002)(230922051799003)(186009)(451199024)(82310400011)(1800799009)(64100799003)(46966006)(40470700004)(36840700001)(40480700001)(82740400003)(336012)(26005)(426003)(16526019)(40460700003)(2616005)(356005)(81166007)(478600001)(966005)(1076003)(44832011)(5660300002)(8676002)(8936002)(4326008)(86362001)(2906002)(54906003)(316002)(41300700001)(70206006)(36756003)(70586007)(110136005)(6666004)(7696005)(47076005)(36860700001)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 10:44:45.5955
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eec7667b-e367-4497-9478-08dbce34e9a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7976

This is part 4 of the 4-part series to introduce Share Virtual Address
(SVA) support for devices, which can support PCI ATS, PASID and PRI
capabilities. These devices are referred to as SVA-capable devices in
this series.

It contains the following enhancements:

* Patch 1 - 4:
  Rename, add support to enable/disable features, update DTE etc.

* Patch 5 - 6:
  Introduce SVA support

* Patch 7 - 12:
  Add IOPF support

This patch series is based on top of SVA Part 3.
  https://lore.kernel.org/linux-iommu/20230816174031.634453-1-vasant.hegde@amd.com/T/#t

Also depends on :
  1) Tina's SVA domain improvement
     https://lore.kernel.org/linux-iommu/20230827084401.819852-1-tina.zhang@intel.com/

  2) Baolu's IOPF improvement
     https://lore.kernel.org/linux-iommu/cbfbe969-1a92-52bf-f00c-3fb89feefd66@linux.intel.com/


This is also available at github :
  https://github.com/AMDESE/linux/tree/iommu_sva_part4_v3_v6.6_rc5


Thanks everyone who reviewed previous version and provided valuable feedbacks.

Changes from v2 -> v3:
  - Rename sva.c -> pasid.c
  - Changed amd_iommu_sva_supported() -> amd_iommu_pasid_supported()
  - Added patch to update/flush DTE
  - Rework part of SVA support (Patch 5 and 6)
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


Suravee Suthikulpanit (5):
  iommu/amd: Add support to enable/disable PASID feature
  iommu/amd: Move PPR-related functions into ppr.c
  iommu/amd: Define per-IOMMU iopf_queue
  iommu/amd: Add support for page response
  iommu/amd: Introduce logic to enable/disable IOPF

Vasant Hegde (4):
  iommu/amd: Rename amd_iommu_v2_supported() as amd_iommu_pasid_supported()
  iommu/amd: Do not override PASID entry in GCR3 table
  iommu/amd: Introduce per device DTE update function
  iommu/amd: Initial SVA support for AMD IOMMU

Wei Huang (3):
  iommu/amd: Add support for enabling/disabling IOMMU features
  iommu/amd: Add support for add/remove device for IOPF
  iommu/amd: Add IO page fault notifier handler

 drivers/iommu/amd/Kconfig           |   2 +
 drivers/iommu/amd/Makefile          |   2 +-
 drivers/iommu/amd/amd_iommu.h       |  47 +++-
 drivers/iommu/amd/amd_iommu_types.h |  27 ++
 drivers/iommu/amd/init.c            |  72 ++----
 drivers/iommu/amd/iommu.c           | 189 ++++++++------
 drivers/iommu/amd/pasid.c           | 291 ++++++++++++++++++++++
 drivers/iommu/amd/ppr.c             | 366 ++++++++++++++++++++++++++++
 8 files changed, 858 insertions(+), 138 deletions(-)
 create mode 100644 drivers/iommu/amd/pasid.c
 create mode 100644 drivers/iommu/amd/ppr.c

-- 
2.31.1

