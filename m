Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2065.outbound.protection.outlook.com [40.107.100.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE75D15A9
	for <iommu@lists.linux.dev>; Wed, 13 Jul 2022 05:31:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZ0wLh6ehqLL/saJOZCxQBs7pDTT5aMbfK/rngoPT/K8ZIJR1HpBZ96HUHstkFEy+PtCtCSDCTuqwTH7QKz8CydVie5ZgGEJf//9/XU4C3j3Tg7cz6o5y7elZTLwsvsRln8pAYpiFv+eNVsu/yPlGugwaTkZgUcyZ06+qnYytuU18nI/BnE+xqSRbHsmLi993RtvxdCx9IayOIuOGckDp5w++PleiaACPB0RLCojRLZOxFIFCDHyUvaUbrlmvScwInrU5YknFGrWIZl+Pl0/Qz69/25sVXeD7pWLvsdlZNCvNqf7Ug5SX9QC6KE8zY5kx1YsLLaMBd45COfLRH0B1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grczC26srIuVFOmFFCvIV+ixI/gC/xQMqGEK3aim81Q=;
 b=edI/WRrEBMCJkKM77fd5+pUxxMlHWC/dyK07DJ9bv1T3Z3IIcbmo+mIU/wZ68Y/trHgwHheB5RWim0KBBI7Db7CD0QVlkSuZMdfuVvYntcvZeCaMjIFy12mG2y1yEILMJM7GBhKO657sdOY8va50eGZ4hK4whDlPjwstDw+hjY1Q0HaYwCx8f1YGSTGQ5vT3epBqBIi97802uYcw5eMZhriwTpWQr9OYwMChrMamkHww7n+e97YFiFJbKdRsecd6NSFImqhRqTrRL/TkZ2+PB5BIdH2PU35HOj6n6ZjTZt0ARt/4bXnyyZn1lr0COIURgF5CsBkGyCj35p04Q1CApA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grczC26srIuVFOmFFCvIV+ixI/gC/xQMqGEK3aim81Q=;
 b=eu79R67czSuXT+Os+ZRlbd4uv/+WV62osP69dhZUvrAuMGYWu9AOtZ3wOT9k8+aSLHqtfBycy60n7PGua/4FuHHKH1XmUgUaFLTg2WfG7NhTV9LDCPL98ftu0nc7EZWeDYCihpyFPg4BtLlWHS/aGyWyw4+A9v23wdPsrMtue3g=
Received: from MWH0EPF00056D14.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:1c) by SN1PR12MB2509.namprd12.prod.outlook.com
 (2603:10b6:802:29::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Wed, 13 Jul
 2022 05:31:04 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::202) by MWH0EPF00056D14.outlook.office365.com
 (2603:1036:d20::b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.4 via Frontend
 Transport; Wed, 13 Jul 2022 05:31:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Wed, 13 Jul 2022 05:31:03 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 13 Jul
 2022 00:30:59 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <joro@8bytes.org>, <iommu@lists.linux.dev>
CC: <suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH v2 0/6] iommu/amd: Add Generic IO Page Table Framework Support for v2 Page Table
Date: Wed, 13 Jul 2022 11:00:28 +0530
Message-ID: <20220713053034.12061-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
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
X-MS-Office365-Filtering-Correlation-Id: eb5e77ef-81ab-4795-25dd-08da6490e0eb
X-MS-TrafficTypeDiagnostic: SN1PR12MB2509:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aX99SAwuXWfgjdBYdXlnDOougRTuov4UE1NqX4ZAC/rVNKpGcp/fLMJouxJX?=
 =?us-ascii?Q?x4MNC2toG2EN93/gbXnP4bCRQgQ5uXyS9HThSqd7pYCRU0VDbzSlJW46BKvO?=
 =?us-ascii?Q?TYdPpLU/nDeZvOn6MUQSm9W6hLC4SJGeeIVPi2q62HuQB+YFwKSPA37StLOa?=
 =?us-ascii?Q?o63urG7RB6VA2noIyk2nH683e1vpjFWaoiijRQGEsIhTHaVOBqaXy8XunUJt?=
 =?us-ascii?Q?1+Z6dnfAVws82TtGa6yOMSbjp+Q4HDHh1oBwYMEmmzqrwG3grRnOkZ58hDC2?=
 =?us-ascii?Q?Ppbmm6sIt7nANx0VNjCpkhkdbb/leQPMg7WRJ6lKgLUkrC7uXIF8+nt6O4Cj?=
 =?us-ascii?Q?ptlYLJcardUKLqzQt+LBYDN1Zz1ICk3FDgRW11nj4lfQE0ZIfv7+pLGDVyyi?=
 =?us-ascii?Q?qHBdeGJqPZrRdFkG80C4h87Fyq/Lkyh+x6TnNRijfMmhPD9iknOXQrjyLB4+?=
 =?us-ascii?Q?ziZ7UM6CritsT6i4rw2KSNVlAc//JBgApTGgFP1/1s1pzfLrOC6nykSfhE3J?=
 =?us-ascii?Q?xzgBhV/YxxaXxmwimzM+0yr2tLSaq26XZhkyyEhJBtkN9rDUek6IBSSTdlSp?=
 =?us-ascii?Q?kr/oqRO0Zl5/bPkmTqGTg3NwdYdwBVOtzR6Ezs/PMCiacMEQa2lfuUZ7itvv?=
 =?us-ascii?Q?XMWJt759mjSStQQ3nApiwtdJaJirMLWSpjHDGGJ8r46ifTF9egAlmg5MHLmp?=
 =?us-ascii?Q?4Rb1GrkhzJwzAtOBZsdkBAMmaTfMEWhDqPwabGRbUx1la4IMCsW++RmYtcdX?=
 =?us-ascii?Q?ryW6D/KGDdulgDIC6TR+184911d4D24E9DJek3MucTkDrrBDnI+IpEBurLHy?=
 =?us-ascii?Q?X3tTJ9hycKvEL9FCDsvBLQzYeMwD1XdRoadhFBVYEZPSQ6Zf9N3n/b9ndAK6?=
 =?us-ascii?Q?rKIkA24VI0QcVNCsJiDZAvJ8/NWs4W4g19q77vVrudYATMztyJcjBGHyHdSp?=
 =?us-ascii?Q?JYggKcCGrCVQoR1givKb3OygWNXDNZP/pmKQN7UniW0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(396003)(136003)(376002)(46966006)(36840700001)(40470700004)(70206006)(82310400005)(40480700001)(110136005)(54906003)(966005)(40460700003)(8676002)(41300700001)(70586007)(4326008)(2906002)(6666004)(316002)(83380400001)(8936002)(5660300002)(44832011)(478600001)(47076005)(86362001)(82740400003)(7696005)(36756003)(356005)(26005)(36860700001)(81166007)(426003)(336012)(2616005)(1076003)(186003)(16526019)(71600200004)(41533002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 05:31:03.6046
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb5e77ef-81ab-4795-25dd-08da6490e0eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2509

This series introduces a new usage model for the v2 page table, where it
can be used to implement support for DMA-API by adopting the generic
IO page table framework.

One of the target usecases is to support nested IO page tables
where the guest uses the guest IO page table (v2) for translating
GVA to GPA, and the hypervisor uses the host I/O page table (v1) for
translating GPA to SPA. This is a pre-requisite for supporting the new
HW-assisted vIOMMU presented at the KVM Forum 2020.

  https://static.sched.com/hosted_files/kvmforum2020/26/vIOMMU%20KVM%20Forum%202020.pdf

The following components are introduced in this series:

- Part 1 (patch 1-3 and 5)
  Refactor the current IOMMU page table code to adopt the generic IO page
  table framework, and add AMD IOMMU Guest (v2) page table management code.

- Part 2 (patch 4)
  Add support for the AMD IOMMU Guest IO Protection feature (GIOV)
  where requests from the I/O device without a PASID are treated as
  if they have PASID of 0.

- Part 3 (patch 6)
  Introduce new "amd_iommu_pgtable" command-line to allow users
  to select the mode of operation (v1 or v2).

See AMD I/O Virtualization Technology Specification for more detail.

  http://www.amd.com/system/files/TechDocs/48882_IOMMU_3.05_PUB.pdf

@Robin,
   We are not addressing your comment on cleaning up pgsize_bitmap in
   this series. As mentioned in other thread [1] we can work on that
   as separate cleanup series.

   [1] https://lore.kernel.org/linux-iommu/15337b9f-48d7-d956-5d6c-b40319ba38ad@amd.com/


Thanks,
Vasant

Changes from v1 -> v2 :
  - Allow v2 page table only when FEATURE_GT is enabled
  - V2 page table doesn't support IOMMU passthrough mode. Hence added
    check to fall back to v1 mode if system is booted with iommu=pt
  - Overloaded amd_iommu command line option (removed amd_iommu_pgtable option)
  - Override supported page sizes dynamically instead of selecting at boot time.

V1 patchset : https://lore.kernel.org/linux-iommu/20220603112107.8603-1-vasant.hegde@amd.com/T/#t

Changes from RFC -> v1:
  - Addressed review comments from Joerg
  - Reimplemented v2 page table

RFC patchset : https://lore.kernel.org/linux-iommu/20210312090411.6030-1-suravee.suthikulpanit@amd.com/T/#t

Suravee Suthikulpanit (4):
  iommu/amd: Refactor amd_iommu_domain_enable_v2 to remove locking
  iommu/amd: Update sanity check when enable PRI/ATS for IOMMU v1 table
  iommu/amd: Add support for Guest IO protection
  iommu/amd: Add support for using AMD IOMMU v2 page table for DMA-API

Vasant Hegde (2):
  iommu/amd: Initial support for AMD IOMMU v2 page table
  iommu/amd: Add command-line option to enable different page table

 .../admin-guide/kernel-parameters.txt         |   2 +
 drivers/iommu/amd/Makefile                    |   2 +-
 drivers/iommu/amd/amd_iommu_types.h           |   8 +-
 drivers/iommu/amd/init.c                      |  36 +-
 drivers/iommu/amd/io_pgtable_v2.c             | 407 ++++++++++++++++++
 drivers/iommu/amd/iommu.c                     |  89 +++-
 drivers/iommu/io-pgtable.c                    |   1 +
 include/linux/io-pgtable.h                    |   2 +
 8 files changed, 518 insertions(+), 29 deletions(-)
 create mode 100644 drivers/iommu/amd/io_pgtable_v2.c

-- 
2.31.1
