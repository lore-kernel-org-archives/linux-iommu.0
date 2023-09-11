Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBECF9C2
	for <iommu@lists.linux.dev>; Mon, 11 Sep 2023 12:11:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bE5pI5R9LjRT6JaDlRB1iFEeyNUWi2/O7ZkJyLSn3PvmVXHnVlQLnVX9FgWMiy8DBBSkj3QpMjG0xa+1yKKxPYYAd5IffjG4fCFkYxkLc+qUM6cPHhqVEp3981wUN++DsXRIZ+qcqieYDKbOmlGnAiYuGhVsjH9FASl3yhpVPP6u7aSL4CBB5SInsORQ7fPBVX8KefHR5oJtaiFFvmcC2OX1XjahquaebkvXECsiNMFXaSMV/BmRoL6j3RF+j0J+64IR6l66szqMPeQ/7gycFawq9C5x2kod3SRIIbP5v1QVAYo43l7oAMnOB6UDroL4UMqQ8GpUf/Hc2v7/aHZIhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ZA6vHRU92GA6gdGgr8Q3DZPY3JCdeVR8EwtQhYfH40=;
 b=exUQf0CPXFlRSiEbeFi8rgHr1s8bMeNxy0Vjxs46Ak8R4spUQVOzhV7wfKP/gsEkXb37AYyttTAGykjRUotx2cCxTWwWM068N9WFTJZ/Aafv7QpazFPTT6ymr7/CpVsvOLaDEHaJArl4jQ3tzSBhpfjJFNpxO66dI/jjxdTNIUt3TFD3lG2LAfqi7zOzAI4ZAL+Go5J1DRiJi3zS5alJ/GzjfRZ3rwGQ5Dk1738YPotpQjgQYvHImcY+clqJvG6A0Q617o+obAaq4atzPjgiEknucc2HJPHA1S4oA2oRypoGiePmT5An+3OwG8g3oxE3c949SeR/ZVOEm+6WJ9qE1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ZA6vHRU92GA6gdGgr8Q3DZPY3JCdeVR8EwtQhYfH40=;
 b=dapMqwsF7DNWKua0E9KHVIGDDOlj1c+2aFEvdxFteeDRRfjWSlObOX+O+GRni4SLLJTVX8/bd+sa6wl33Itrs6+AfpP+lvFyz8wGba0S7HC04X74952aRGMQpbvW53pQJSIIMr+SBogtyRRmlFi5xZtfJa2SjpmXCe69iybkDso=
Received: from SN4PR0501CA0052.namprd05.prod.outlook.com
 (2603:10b6:803:41::29) by SJ1PR12MB6051.namprd12.prod.outlook.com
 (2603:10b6:a03:48a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Mon, 11 Sep
 2023 12:11:36 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:803:41:cafe::2c) by SN4PR0501CA0052.outlook.office365.com
 (2603:10b6:803:41::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.16 via Frontend
 Transport; Mon, 11 Sep 2023 12:11:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.17 via Frontend Transport; Mon, 11 Sep 2023 12:11:36 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 07:11:00 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 00/11] iommu/amd: SVA Support (Part 4) - SVA and IOPF
Date: Mon, 11 Sep 2023 12:10:35 +0000
Message-ID: <20230911121046.1025732-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|SJ1PR12MB6051:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f8e1f00-ce8d-421f-c4d1-08dbb2c03ef6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0EUfBtTHyqTA2C4ydPoHn72cbfLxMdUeKK47XSmL/KO3I1oP/2X4P5BE5CkoT30lXodfBTT2oH8CvuSMRHGCjvrMLlFCqWt/pilgimmjmc7nIKU9V3qDvFWN1Eq2HOFHK64mcnB/2169d/jJPHbBqOQZzyWRiwG+6+p0VeQOVd01BuRD/VMPNI08iD0XDUy567dorODeQ4MaodlGSoYQEPq9INspQX7FFtNgx5nl2Fq+Ifxv23pSpYDtJxSH5gZjkPo9giaJ/FzQC52Rz6vDggmtXA+hfBLLB9JYtRPft2TJvaCvnhYKe6zm314xRjv6oElFqSAK9LK8mGKEw1Z/PoonJ3aF/vB0SvfTb+mFVY5qaueDNKJKTa3UDMSMtLywGfSjpYwG8CzcnhgMTnDbrEMF5srKQ5JdMJFIYj3aFMuFuCDTb6ma98vlxwPnAf+x7fcPGgmtGMMauvHmDRbtQPU2HGQZapA1D3cDB2kUJZ54Y68PVPdy515B6X7TDqgSCNt1JMBlRg0RZhLEfcGyKyC3WuTc/3ck4S9xpnvSTDf0ZSUxe8/n5fIKfyl/qUKzQfDWmOn/pRsZezaUbdCEcrYYQdr/uU76MEkJRGXwUN3qUrK6AC5NUbhgMMFsB/qF/sU4qnjXNUEbClG/ZD2q8z6Ie1LliidwpsviDo5qn4a5Vda2Dv0fNUwwNCGGLbGeSdgcFCycA/Yj0Ph93ybuMeRMqbVvGiHtBYERRbuyOxKcdltXUiGoWP71cjn+YAgypVjDjj8x6auY1LQ9Vhkr4R0Wo17SYmo3HbV2UfSxiFU=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39850400004)(346002)(396003)(136003)(376002)(186009)(1800799009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(6666004)(7696005)(83380400001)(478600001)(1076003)(16526019)(426003)(26005)(2906002)(336012)(966005)(44832011)(54906003)(316002)(41300700001)(70206006)(110136005)(8676002)(70586007)(5660300002)(4326008)(8936002)(36756003)(40480700001)(2616005)(47076005)(40460700003)(82740400003)(86362001)(36860700001)(81166007)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 12:11:36.2412
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f8e1f00-ce8d-421f-c4d1-08dbb2c03ef6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6051

This is part 4 of the 4-part series to introduce Share Virtual Address
(SVA) support for devices, which can support PCI ATS, PASID and PRI
capabilities. These devices are referred to as SVA-capable devices in
this series.

It contains the following enhancements:

* Patch 1 - 3:
  Rename / add support to enable/disable features

* Patch 4 - 5:
  Introduce SVA support

* Patch 6 - 11:
  Add IOPF support


This patch series is based on top of SVA Part 3.
  https://lore.kernel.org/linux-iommu/20230816174031.634453-1-vasant.hegde@amd.com/

Also depends on :
  1) Tina's SVA domain improvement
     https://lore.kernel.org/linux-iommu/20230827084401.819852-1-tina.zhang@intel.com/

  2) Baolu's IOPF improvement
     https://lore.kernel.org/linux-iommu/cbfbe969-1a92-52bf-f00c-3fb89feefd66@linux.intel.com/


This is also available at github :
  https://github.com/AMDESE/linux/tree/iommu_sva_part4_v2_v6.5_rc7


Thanks everyone who reviewed previous version and provided valuable feedbacks.

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

Vasant Hegde (3):
  iommu/amd: Rename amd_iommu_v2_supported() as amd_iommu_sva_supported()
  iommu/amd: Do not override PASID entry in GCR3 table
  iommu/amd: Initial SVA support for AMD IOMMU

Wei Huang (3):
  iommu/amd: Add support for enabling/disabling IOMMU features
  iommu/amd: Add support for add/remove device for IOPF
  iommu/amd: Add IO page fault notifier handler

 drivers/iommu/amd/Kconfig           |   2 +
 drivers/iommu/amd/Makefile          |   2 +-
 drivers/iommu/amd/amd_iommu.h       |  44 +++-
 drivers/iommu/amd/amd_iommu_types.h |  37 +++
 drivers/iommu/amd/init.c            |  72 ++----
 drivers/iommu/amd/iommu.c           | 166 ++++++++-----
 drivers/iommu/amd/ppr.c             | 364 ++++++++++++++++++++++++++++
 drivers/iommu/amd/sva.c             | 221 +++++++++++++++++
 8 files changed, 784 insertions(+), 124 deletions(-)
 create mode 100644 drivers/iommu/amd/ppr.c
 create mode 100644 drivers/iommu/amd/sva.c

-- 
2.31.1

