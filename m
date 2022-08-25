Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06EE1C30
	for <iommu@lists.linux.dev>; Thu, 25 Aug 2022 06:40:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cnfSrMWnmt1GyvrGYNFGZqiOqonEVzu0LyLFG+pIPOSXbHmb4+2w/UTRWhp22HAO1wm1f+6ufoJ/dTpnRyM7IHK8G8pn+cumXxg/RV6m2r3Y/miEMSBKebzXpy41eve8qR7Q4U+qUBz2BRfeUjyYsEhPdBJVJpWxagO+Md60fyYd/UUCLgNPEDRXt2bFjVVpLpnCzlvDFagiZFAu2BJN3rvld9OZqHiTpk444q06Mj1mBNu1LQc4vcWGoAuXZduFC1IagFL7AJ75BIczwHgd5Yl5+EVF85LEuV9q9FsIOO5a+Nd25cEBRU4hJmrYjOHQ1d8+nbRXqS7VEoUJ4MNpeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Cj5yTPdIUEwJoIEJub9XANz/puPnzSJ1ZLvQe9Qy4A=;
 b=im5FmN+RfPqC3mFpwvg2bIgCsPEuRcH0NISgwmzlJFat+z0QShRdl2vtMvZDygurjTZdNnAlKk7QUMNSY7J7MYt6tvc/WgOoGmM/qZCuwitfXn5yT7JAj17Y6KkdKvrb0VtCh0R88eV+cEsdp82bryqFSmkUGH9Wcj+BWpUpEE2L1Keuma6TNVtQHPCbv5hsB2w+glBJ8kQMkxhNQa1DaJJYDIteLKk5hpl6Tg8vL/6LpUcciJGyBAIH/hL+dpiPKHSRtJTqUvQhhJBkdiwqVetBrVBPFPvqQ9O9A5qS14h8K+guhrTb03gVOWmQ637vA96OKH57ijsjFoeH8bNQlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Cj5yTPdIUEwJoIEJub9XANz/puPnzSJ1ZLvQe9Qy4A=;
 b=LcfYLhpbMEJpvWaV5DjC4T4BpLF2BI3BattBdHf6lkNGlMKRpjJ2g5/si1Hh/Tv2Lj1KIjvVLSTQDnoub2CwrTzfbra3LMxLJLxwUphAsTEkVhp3tt6k08WOaRmDzFx69b9Ee30FWupHTtVJo1+kupyegNEKyAwnKKlPaeTi3oA=
Received: from MW4PR03CA0253.namprd03.prod.outlook.com (2603:10b6:303:b4::18)
 by SJ1PR12MB6193.namprd12.prod.outlook.com (2603:10b6:a03:459::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 06:40:29 +0000
Received: from CO1NAM11FT102.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::a5) by MW4PR03CA0253.outlook.office365.com
 (2603:10b6:303:b4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22 via Frontend
 Transport; Thu, 25 Aug 2022 06:40:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT102.mail.protection.outlook.com (10.13.175.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Thu, 25 Aug 2022 06:40:28 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 25 Aug
 2022 01:40:23 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>, <robin.murphy@arm.com>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 0/9] iommu/amd: Add Generic IO Page Table Framework Support for v2 Page Table
Date: Thu, 25 Aug 2022 06:39:30 +0000
Message-ID: <20220825063939.8360-1-vasant.hegde@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1616c110-2600-4104-355c-08da8664b372
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6193:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	heWqIrHAlbJT0nwu+5X6WfhDQvlSvBkAunExJSUwgHODSjRfHV9BenFPSfmnzzU+pX9z8DQg2nbq33fSR2M1y5aWiLMD2wVlx+b0v7501+jvtkp5KwBaYIqp2lF0/LWFThnP+lCvno4LTznA3aRvz08kbrX65E9+A95B6Ow3FSrdGO+IvdYKVASXBVwWPtTTQcEP0aWqc/zqsTr2+0l4XMXilrOQ7F874XB/G3NOvzj4u6v1jnyg0rlAZIm1p5n/uNKwte5yRCAX7lbud2yO222z9bed6GkheJA8pjqjZQx8RrINcmU7uyroFeMAUro2gdU4EUjOGrruQ6SYlJXoY3vKuO+CHbKo8heR1EG/C2d4QMYR5EzK1wxrhibjx7Reyo+qecNcGALSCoCqS+H+A8gNU/TxYIDFOwsf4kmKkwUA+Sdjb+K4WxjEJizydK1jil5OykSdMN3JH7JR0USperkrxzn2z8nmgnWJ/QZTNmzzDFLQ+Ib12LOXheFVgugXfqTogep8hJyvuNZgTO489wXWvMCVBZEfSNOjtLmd8GvrUAoVbgAYZsfQifIVhzH8BYmbArYQJ87S9pk3sas6zwhgJuTa0h5kRwoRjavGzUewYtsNK6ZGPvvf516/10LsWgGpq6WZcW6DlokxPXYgYQwUgKMQ48/WJRAy++PLLfk8Nj60g7MOOx2+CnAPepvSIeErd2PgLrvW1t6pHDFvJDRQl0/GtuzgCEmf7AQ+GMoGBOZwjEJhvktdFdbE3PW4WXyog6wNhOr+qI3e8V/6h8kJMXI1w9+zkjckVGk46zkCnu59b/sHx5Yy081wUDMMUWsCCdBD+9iZvAJ8WKJ2Yo6NoKXtg4YSAyrnfvuQQnRGuBn4q7JnnaU74/998vNPucVIEQC4Osogve4ZggbT8ukS0BtLDmceJCbYuiXO7UxCPiwCbR62sFs8P9DlQIvn
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(346002)(376002)(136003)(46966006)(40470700004)(36840700001)(70206006)(70586007)(86362001)(6666004)(82740400003)(356005)(4326008)(54906003)(316002)(81166007)(7696005)(966005)(41300700001)(478600001)(8676002)(40480700001)(2616005)(36860700001)(1076003)(40460700003)(83380400001)(110136005)(336012)(16526019)(82310400005)(186003)(26005)(36756003)(5660300002)(426003)(44832011)(2906002)(47076005)(8936002)(71600200004)(41533002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 06:40:28.9929
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1616c110-2600-4104-355c-08da8664b372
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT102.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6193

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

- Part 1 (patch 1-3)
  Move AMD v1 page table to use [un]map_pages interfaces and minor fixes to unmap path.

- Part 1 (patch 4-5 and 8)
  Refactor the current IOMMU page table code to adopt the generic IO page
  table framework, and add AMD IOMMU Guest (v2) page table management code.

- Part 2 (patch 7)
  Add support for the AMD IOMMU Guest IO Protection feature (GIOV)
  where requests from the I/O device without a PASID are treated as
  if they have PASID of 0.

- Part 3 (patch 9)
  Introduce new "amd_iommu_pgtable" command-line to allow users
  to select the mode of operation (v1 or v2).

See AMD I/O Virtualization Technology Specification for more detail.

  http://www.amd.com/system/files/TechDocs/48882_IOMMU_3.05_PUB.pdf


Thanks,
Vasant

Changes from v2 -> v3 :
  - As Robin suggested added support to use [un]map_pages interface (Patch 1 - 3)
  - Removed [un]map interface from AMD IOMMU driver
  - Updated v2 page table to use [un]map_pages interface

V2 patchset: https://lore.kernel.org/linux-iommu/20220713053034.12061-1-vasant.hegde@amd.com/

Changes from v1 -> v2 :
  - Allow v2 page table only when FEATURE_GT is enabled
  - V2 page table doesn't support IOMMU passthrough mode. Hence added
    check to fall back to v1 mode if system is booted with iommu=pt
  - Overloaded amd_iommu command line option (removed amd_iommu_pgtable
    option)
  - Override supported page sizes dynamically instead of selecting at
    boot time.

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

Vasant Hegde (5):
  iommu/amd/io-pgtable: Implement map_pages io_pgtable_ops callback
  iommu/amd/io-pgtable: Implement unmap_pages io_pgtable_ops callback
  iommu/amd: Add map/unmap_pages() iommu_domain_ops callback support
  iommu/amd: Initial support for AMD IOMMU v2 page table
  iommu/amd: Add command-line option to enable different page table

 .../admin-guide/kernel-parameters.txt         |   2 +
 drivers/iommu/amd/Makefile                    |   2 +-
 drivers/iommu/amd/amd_iommu_types.h           |   8 +-
 drivers/iommu/amd/init.c                      |  36 +-
 drivers/iommu/amd/io_pgtable.c                |  76 ++--
 drivers/iommu/amd/io_pgtable_v2.c             | 415 ++++++++++++++++++
 drivers/iommu/amd/iommu.c                     | 117 +++--
 drivers/iommu/io-pgtable.c                    |   1 +
 include/linux/io-pgtable.h                    |   2 +
 9 files changed, 584 insertions(+), 75 deletions(-)
 create mode 100644 drivers/iommu/amd/io_pgtable_v2.c

-- 
2.31.1

