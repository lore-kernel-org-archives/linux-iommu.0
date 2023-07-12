Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623D5100AE
	for <iommu@lists.linux.dev>; Wed, 12 Jul 2023 14:15:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YUNkspmfJeBzTsAGwyyaGB8MHFboAtC9Rg4AF3QM3ZrcmlNZFqaJ9IKx43pZHK0Ei6j1usI/E8g92j24HO9jkypuYrNtSjIH0ph1ApAiYgKUlDOTt4bMgPHp7jeFFymXSn5KJ12YY8jODueRxZEDcZEE+Bra4/03hxPCiMtMFoHnlI9r0x9/WcVPajWz87MY0/10DZFc7OP0QcIoKxIx+q99z+V7s3qAtPz/bv9kVGpHWBDNvd3kT8IWNR4YYzUE+WRk4HvPPuulTjwT2TPpErM+G3amj4kxxIcS3LPdG1wuhTPtaYMz+tcjwjuY79k0oj/QQzVztoRZjQUlDTt9UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MAqmZ2Jl4DaSB2IoyTVQ8k2GCKNqk/bsPCDAik8VjFM=;
 b=B6U6BhtLy5Y0Pa88HU8MItdhUcOz4YMMR6AJubviEUKM6fYEfKrNIJkJ+AP6zO0OKnHjHyjZ6KHXQJG0F8/Be5rJSW/wHqeN5We59O7ZqWq3udm9KAWtYK+5Pa2/1oMI6z3XPldoP8gYDEWx0fc+5v4adGl3E4CcaMeyluzoBkc3W3la7AYlo+HwvAfoW5nCnH2XXvOCtFq10bunKpr7qlZtJqqozm37jkBS6sSsvesXbrnFgawPxDyQKP8fkkJJDGvN0Wxw9Pgy+PIo9ct0XJAE/M7kr8Xtr3uTDJaJMiAq8y1Wt+h8qoDdD349AMLU/ulfFd8CiNp4TDgD/vMm5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MAqmZ2Jl4DaSB2IoyTVQ8k2GCKNqk/bsPCDAik8VjFM=;
 b=VKxCHGe0tsxTGcfM2loDbCIWa8qQqZlKt+i87WVBziAUdEK/3yPfa7VbdPOwTGdsDRlwiarCdGAnXGQEMCCEtnigM5C2d8VmQtNqgM4TEOyanrLz7X0CJMMqGMveMguWsu9yNljObbnNSO3ODAFP7lauCRmeqbkczYMChpD/YJg=
Received: from DM6PR07CA0037.namprd07.prod.outlook.com (2603:10b6:5:74::14) by
 BL0PR12MB4882.namprd12.prod.outlook.com (2603:10b6:208:1c3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 14:15:53 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::46) by DM6PR07CA0037.outlook.office365.com
 (2603:10b6:5:74::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Wed, 12 Jul 2023 14:15:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.24 via Frontend Transport; Wed, 12 Jul 2023 14:15:53 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 09:15:51 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 00/21] iommu/amd: Preparation for SVA Support (Part 1 of 2)
Date: Wed, 12 Jul 2023 14:14:55 +0000
Message-ID: <20230712141516.154144-1-vasant.hegde@amd.com>
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
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT051:EE_|BL0PR12MB4882:EE_
X-MS-Office365-Filtering-Correlation-Id: aa8f60c3-2e2e-4786-ee98-08db82e28076
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Rg1hAiyuzXsO+Wxp6iAhlBOpPLqmcrmzmiOVUicTqH7eV1begpddkex7mU2CAknxAJwOjvK4uyGPm5ZqJj4DEbj+xFRzPEhtr6nMgfMgo9H1YCdE5hHrWVrtB8SNdGJZ/KdaAMhqO9TmADxRrQfvCryAgz3yiDslYo6/J3G9LX61K2Z8VRL1YxJ0zOUj0kQQI7Xhh75Klr4oeyn+zGl2YTB3tQicJyj8KHpDi3H7QoVzSU1i7/jOA+glymwSHV/2O+84ZlB6bgFWe1JQcYVW5scpVliRnRBuDvX4/ubX9McCrcnQK1mSkl2M2x+jYki3M1IVpWZvfVMGnPb1UlimoVNoFWwC8szkO7I1aEEUD0NuZw4lDtV6gdnHbieZRrKj34uydKJfrwFsrTjBaea3IaJNn07xWZ4uqnhgJVLK4U47mpATk3LkV1gVVYmAiSL75jflKBP47OL8Tw/RnJBaIQka0vyFvYneIR5NDjYT+oc2RiDBNoS/twFHCddU+kvBgSwaoJ9HZ6dmQh1FDIFw81Imh74fF7nPF52etGiBdV9R0WwN7qizyZSjcDozC5+Qxv6x/bXVmEc1cTkJIDw0NC5IaFFjpKvO865nv1W3kUMzR8wY0jaoKxkTzcOqPUYbXnyyUTOcp3brxx90Ocw1/1/x5MZwbX6zpY8tscYaZgYDe4rYkGbK+VvejTlahZBsFcfpox2Yh5ePXZ7RpSrwAUHDjly1GlZ93uwtunNkosfJ5aZq68BYDckUOHN7h/KDp7Ak7+EvQn6so0Iqud5n9NI94zg3FYJWUJoMJIUfWfY=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199021)(36840700001)(40470700004)(46966006)(4326008)(70586007)(70206006)(40460700003)(7696005)(426003)(83380400001)(36756003)(478600001)(54906003)(110136005)(336012)(186003)(16526019)(82310400005)(966005)(2616005)(356005)(82740400003)(81166007)(86362001)(1076003)(26005)(36860700001)(40480700001)(47076005)(41300700001)(44832011)(8676002)(8936002)(5660300002)(2906002)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 14:15:53.1773
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa8f60c3-2e2e-4786-ee98-08db82e28076
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4882

This is part 1 of the 2-part series to introduce Share Virtual Address
(SVA) support, which focuses on cleaning up and refactoring the existing
code in preparation for subsequent series.

It contains the following enhancements:

* Patch 1 - 7:
  Clean up and refactoring. No functional changes.

* Patch 8 - 11:
  Miscellaneous improvements.

* Patch 12 - 15:
  Introduce new set of AMD IOMMU protection domain flags, which simplifies
  domain manangements.

* Patch 16 - 21:
  Modify logic to independently enable PCI capabilities (ATS/PASID/PRI)
  for devices. This allows more flexibility in preparation for SVA and
  IOPF supports.

This patch series is based on top of upstream v6.5-rc1 and below set of patches.
  - iommu/amd: Add PPR overflow support
    https://lore.kernel.org/linux-iommu/20230628051624.5792-1-vasant.hegde@amd.com/T/#t

  - iommu/amd: Interrupt handling improvements
    https://lore.kernel.org/linux-iommu/20230628053222.5962-1-vasant.hegde@amd.com/T/#t

  - iommu/amd: Consolidate PPR log handling
    https://lore.kernel.org/linux-iommu/20230628054554.6131-1-vasant.hegde@amd.com/

This is also available at github :
  - https://github.com/AMDESE/linux/tree/iommu_sva_v1_part1_v6.5_rc1

Thank you,
Vasant / Suravee

Suravee Suthikulpanit (10):
  iommu/amd: Remove unused amd_io_pgtable.pt_root variable
  iommu/amd: Consolidate timeout pre-define to amd_iommu_type.h
  iommu/amd: Consolidate logic to allocate protection domain
  iommu/amd: Introduce helper functions for managing GCR3 table
  iommu/amd: Use struct protection_domain in helper functions
  iommu/amd: Miscellaneous clean up when free domain
  iommu/amd: Modify logic for checking GT and PPR features
  iommu/amd: Clean up and enhance protection domain flags
  iommu/amd: Consolidate logic for setting up v2 API mode
  iommu/amd: Refactor domain allocation code for v2DMA mode

Vasant Hegde (11):
  iommu/amd: Refactor protection domain allocation code
  iommu/amd/iommu_v2: Use protection_domain in struct device_state
  iommu/amd: Do not set amd_iommu_pgtable in pass-through mode
  iommu/amd: Use protection_domain.flags to check page table mode
  iommu/amd: Setup v2 domain with max pasids
  iommu/amd: Introduce iommu_dev_data.flags to track device capabilities
  iommu/amd: Rename ats related variables
  iommu/amd: Enable device ATS/PASID/PRI capabilities independently
  iommu/amd: Delay enabling PRI to after initializing domain
  iommu/amd: Initialize iommu_device->max_pasids
  iommu/amd: Simplify amd_iommu_device_info()

 drivers/iommu/amd/amd_iommu.h       |  35 +-
 drivers/iommu/amd/amd_iommu_types.h |  50 ++-
 drivers/iommu/amd/init.c            |  37 +-
 drivers/iommu/amd/io_pgtable_v2.c   |  16 +-
 drivers/iommu/amd/iommu.c           | 661 ++++++++++++++++------------
 drivers/iommu/amd/iommu_v2.c        |  38 +-
 6 files changed, 465 insertions(+), 372 deletions(-)

-- 
2.31.1

