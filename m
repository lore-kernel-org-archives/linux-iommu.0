Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DEF23AE
	for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 05:36:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hxnusZSs7wWFU89PwdlpeUwLXHYKFeeSIu/1VUFYl2KhkJOk8qQSfy9Ufl7TIciSyiGkyAHzr+LS2gpcejamwfoXQwwmMkO5UYiymLqBgxWFz3s8FQkojQfSkDG3KCkRWA6ZKNfo6OSRhOd9bsPQbiqGkr63IAnSv5mzpO8acdVWAknHNBREPtD1okMHg2N5aKfOQ7Vr3W66XB6NFIWhIkvMffddAVL9ZdjAaUxQD6RSSbKe3foaax2OHPxQjp9e8Xl2/z5rT/S48rgGxmjuL8d63ebJ1S/WPBP85RR92f7S/y83hoccZzfTO8K+7T6bOmMLxyPLMkxYnb3EpMOC3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OsgIAW7V3tSgE1Bd2yzGzAeiJ73VLcNZFtOGrUYnvzM=;
 b=Wtu9HaKFf2E5ZsjhG78B7wAVzj7RFZFA2xIs5zXFYhwrzk3hLzvlmYNMcI6KycHnFDVefWIYIke08sQqs21RM2eMZpHHKQQC1sNPpjZPPaqDqjlaH9bumPsTypIBLxvImt5OXJZmaourIU1NNiZ/oViAziAm4mx8ikZv7HY1Xzs5Tdg+dURvQs8BPHbwKxuU66W3JD1aWfr0ta2RdnV8OcHh1b5ZNe1QDhkvLfAa+9KIXI5OXvhugQ0RmY+jCDvjJ9BlTmPqkOzdTlHMyMgQJYSREANY4T7/yDEMN8wHQkTNQn15DhQzM7CFR7uIENFDTaavFAw6D6i29HAfLoRaAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OsgIAW7V3tSgE1Bd2yzGzAeiJ73VLcNZFtOGrUYnvzM=;
 b=IsHj1BILxjBSvAZsTArcIu+XP/eVXXYBVhynJwXA2mMBfp0aG4R88zOx2zhkAqAbwuHtxSnOgMTB9C6E9J2yTWARlm9AdyQqjIDHZ21SQ7ryFYMMydm+9VBvhkEG/b1hnPe1CIk7wIpSmtateCtfjr4su3q0sr9MQdBMZcv8BSk=
Received: from MW4PR04CA0063.namprd04.prod.outlook.com (2603:10b6:303:6b::8)
 by SA3PR12MB8440.namprd12.prod.outlook.com (2603:10b6:806:2f8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 05:36:35 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::9c) by MW4PR04CA0063.outlook.office365.com
 (2603:10b6:303:6b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 05:36:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Fri, 28 Jul 2023 05:36:34 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 00:36:31 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 00/16] iommu/amd: SVA Support (Part 1) - cleanup/refactoring
Date: Fri, 28 Jul 2023 05:35:53 +0000
Message-ID: <20230728053609.165183-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT051:EE_|SA3PR12MB8440:EE_
X-MS-Office365-Filtering-Correlation-Id: 50e1ffcb-b15f-4290-769f-08db8f2c9b1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zksnGu2JJDTS9Su6lQVPzttrhnvg9wJDs5ahmjrF5jTfYFNWKDjbJsSfMNoXyWwwGQHQZqgfuHyVgHLqHRf8EHNoV6AQpwIudMap3jc1UfLirqakHIsCk6cYlkGA/yxihzB/EQ9GWBevFgNglQKwpQNr4SZ3hZXZEnAik0ftmkV718Q0Kzse0vRNcg1w+YtNVxR1pYjuqkLIk3lnIoA3pspjGBLSB0aX9hIKn5jJgc+dk8IPuswCY5lLYJ2HDpFLwEMeDJCTVgGfGUAjnoA6u8xeLATSiz1evDxscVgfv3Q7NOiuzk67kkA/7X8QDbhebTQHJcbX1Pn0r/mrc/0RBXAkcrgnxvmiMUmvsEoM/A1FoTNKwtLAoFRi0yZsjnBbQXX9q7TdWWmAKlzhr/6udztU1/A1hQY3lQLswqVGnYXqNknklJVFQUYcNy8W3+rKHDr6U+/Sw1AQnudxTF+Hp9jP0IGQQIzojTIve5R4Wwm0+KHfhfjFtkB9V/B6lVoQFQZzDRuO6KlWUS8pMXnQQTLONRcrgAYXQ49Y0U7/iyBz0aPjiuTp2XQYh++XcdoYOR7de/M8FbyPXvSWd53hK7svQ5p5juAhwvp/hWk/DlrpJwWcncZ/Ot+TxFGw4V3Ety4UHihwQP/cAHHT7FHsVeYvgqfmrESglTNLlpJqdZy5jGpMEdx49QjDn1eo1r13SYJmP5OZeoh3kuNQE4QonNEyvLFRJsLL9ohMquTfj+IGNPMpDhDJBQ1mqA3kzFQy1Lxf053VQ5X81HhdFD3lntnTkEVU28L700U940ctqKs=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(40460700003)(8676002)(8936002)(86362001)(41300700001)(36860700001)(2616005)(2906002)(36756003)(426003)(47076005)(83380400001)(1076003)(26005)(336012)(16526019)(186003)(44832011)(5660300002)(40480700001)(7696005)(82740400003)(478600001)(70586007)(70206006)(4326008)(6666004)(356005)(81166007)(54906003)(110136005)(316002)(966005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 05:36:34.5317
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50e1ffcb-b15f-4290-769f-08db8f2c9b1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8440

This is part 1 of the 3-part series to introduce Share Virtual Address
(SVA) support, which focuses on cleaning up and refactoring the existing
code in preparation for subsequent series.

It contains the following enhancements:

* Patch 1 - 10:
  Clean up and refactoring and miscellaneous improvements.

* Patch 11 - 16:
  Modify logic to independently enable PCI capabilities (ATS/PASID/PRI)
  for devices. This allows more flexibility in preparation for SVA and
  IOPF supports.

This patch series is based on top of iommu/next branch.
Base commit : a5003e75a171

This is also available at github :
 https://github.com/AMDESE/linux/tree/iommu_sva_part1_v2_v6.5_rc1

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
  iommu/amd: Use struct protection_domain in helper functions
  iommu/amd: Miscellaneous clean up when free domain
  iommu/amd: Modify logic for checking GT and PPR features
  iommu/amd: Add support for different types of PPR handler

Vasant Hegde (8):
  iommu/amd: Refactor protection domain allocation code
  iommu/amd/iommu_v2: Use protection_domain in struct device_state
  iommu/amd: Do not set amd_iommu_pgtable in pass-through mode
  iommu/amd: Rename ats related variables
  iommu/amd: Introduce iommu_dev_data.flags to track device capabilities
  iommu/amd: Enable device ATS/PASID/PRI capabilities independently
  iommu/amd: Initialize iommu_device->max_pasids
  iommu/amd: Simplify amd_iommu_device_info()

 drivers/iommu/amd/amd_iommu.h       |  29 +-
 drivers/iommu/amd/amd_iommu_types.h |  34 +-
 drivers/iommu/amd/init.c            |  37 +--
 drivers/iommu/amd/io_pgtable_v2.c   |  14 +-
 drivers/iommu/amd/iommu.c           | 484 ++++++++++++++--------------
 drivers/iommu/amd/iommu_v2.c        |  51 +--
 6 files changed, 336 insertions(+), 313 deletions(-)

-- 
2.31.1

