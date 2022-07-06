Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2044.outbound.protection.outlook.com [40.107.96.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C172F3A
	for <iommu@lists.linux.dev>; Wed,  6 Jul 2022 11:42:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LgP6dcLeMgjPxBTS4OZ9qcIH48867O2Ov0/Q6y9tYQVMRT8+eeoImVd4VnOWBcreJQXGVEhOxLv3g8MuPuT65MPqk1bPPr9hVKxgxnIA8VLAcho/QlSBvY6ciOKufqv+bVzFS0ShbceqlgqApCg0zsd7j8xcNRhEfvvswHmUicL7LAuiFUrf0eyZ/AFzdTkz6wuLaKBvmyy0qFxOBnEytjrF81R2PBLrBpeGg0uxk2pffEEaDfY5PBFGi9KvR0ognPz5MilKQCY2b8xY1VbvmjjORVlvrGaO1ZdDIy+aMivqVt5In3H69FGWYsbVZ83Yyz82M2hC3jovJeQJGS006A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJJawzqEQiHTZh+DffcNAB+kB3IJJo4IFLsOcX2U07A=;
 b=Gm6ZdmcnGEmU36MRhJ3XCqmJy7+FoOBGZdzGu/pRxP/gCG5XacESLbkNh8NaS0381SriThhVNr+cb28mWd6yaVOBf/ZORQI7KVLL7rD4iYi1+KFwiXvPGYLwQuF6T8KXergKoqsCWDMjilHefmxPcvFT8bCLbUCKkgrBoyR934PDSB7+7NE9LmZk3SiPrq1mM1O2lm73xHAQ5qWN1wmzbUH3lqvRPQNQe4baPl2L4LRLKj+8XxcAKRMDIEe+wBQTPe5M7wBZC9Y2WZ3OJhHjj2ie448gnAkCiSSAdE7mfMPuZnfZ4FFd9VzHn78+AFrHJaAlP1MXffAFk1YabzeciQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJJawzqEQiHTZh+DffcNAB+kB3IJJo4IFLsOcX2U07A=;
 b=XViZwrjK1Rh1fB28ztaoFmf3ecAeCvvp3KlOKd8a15KcNfBfxIQKFVJ315ogRHKXFZxuie9RYiOw3nd2AqQxyEEmBRHylkOJd4fon6H3kfokOMs98HXNqXDl5oe58Abw1LhZDJUWEAyShVGlM0VqmfDUrWeU+slbClDfImV9zD4=
Received: from BN6PR16CA0026.namprd16.prod.outlook.com (2603:10b6:405:14::12)
 by CY4PR1201MB0197.namprd12.prod.outlook.com (2603:10b6:910:23::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Wed, 6 Jul
 2022 11:42:26 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:14:cafe::d1) by BN6PR16CA0026.outlook.office365.com
 (2603:10b6:405:14::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18 via Frontend
 Transport; Wed, 6 Jul 2022 11:42:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Wed, 6 Jul 2022 11:42:26 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 6 Jul
 2022 06:42:23 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <joro@8bytes.org>, <iommu@lists.linux.dev>
CC: <iommu@lists.linux-foundation.org>, <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 RESEND 00/35] iommu/amd: Add multiple PCI segments support
Date: Wed, 6 Jul 2022 17:07:50 +0530
Message-ID: <20220706113825.25582-1-vasant.hegde@amd.com>
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
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5927c8c6-b7c4-4757-5e6a-08da5f449979
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0197:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2kUf8uyPtobTOzmvvpn/xEmKNkhVPXZKhKDZnqvkv6AuNwcs0LHRTDH7KWay?=
 =?us-ascii?Q?+VRFisz5gBzcre9yEx0O0brEHH+99g6+gHjTyqrpiKutybDoZoHXyqWDUzqQ?=
 =?us-ascii?Q?d8YfLx6FXjuXHEhe8P75pqhTULsGUkCmrOPBSApz2A1MgkM+wvZWYd86mXGF?=
 =?us-ascii?Q?3UXot6pSxpTzk1VchLHhJiModDs8+LGCZ71bqnurnOcuPM9OucHpadv5yKNh?=
 =?us-ascii?Q?m6mE5dm5CUKhlB8O5yS0Us1XM4v89LEm8GH3LZ2Pq4g/KUIpRi5N3QMr8VUp?=
 =?us-ascii?Q?v4o+/kCK+9oli9mRMuwml952NQdtqvylfpce9MFDM5XKILGSi3TEFO09LNBF?=
 =?us-ascii?Q?s7sbh3mY3EdK9cIB7l8jtHCkT78BrcUOxRphdUIhZcnNZUDJ6xt/TKbTwSBs?=
 =?us-ascii?Q?QHl/r05i1RdR10Xes9WtjNuCgZib/bZmJ632eBl4jietSUmlfaDzWFM8HNux?=
 =?us-ascii?Q?aoEbqEteX2PZKxDYV2UqNF9j4MkV5eRH2qMfXUbzkN1JP5tFhsx24jjNN3+h?=
 =?us-ascii?Q?VkvTw09jBKAcRevAS+2B9SN4ZFwbDjKt8XSnG38XiihJNPva8iZYOWxP00b8?=
 =?us-ascii?Q?Y3ApPs85FnGobpYDYpKELO1qtl3bzlzdfOykTBboohdt2FjZoOJnW+hlQ9z7?=
 =?us-ascii?Q?Uh1xUAfxvFGFyL5YFLXhzJOn0TK9VzTeXhraywdBMv8OluxKj7yzl3fxXN9r?=
 =?us-ascii?Q?IRcADNmOhoX494oUomO1eaFErfpv3LgPjMX5zcizJz1Fw21KcQaLCi5aJDFl?=
 =?us-ascii?Q?v0K+dA4CU10J1EjLVC/fGnVBo8GMa6aRwR5C3ipMGouQ4rBKM/xEfKRsBZPE?=
 =?us-ascii?Q?sHE5ekMqaBjy30hTv9yakD44xa3UUFtTMGMC22L4yg5Zb0asMOOcn4haCCH3?=
 =?us-ascii?Q?3MefZYk+/TTvRblpYYiA8fmwvS1p0SIGEHBn5Nn9tWcF8A4GkZU+3AzWeTdb?=
 =?us-ascii?Q?TCqzMj8/DP8Romo51Fc/eQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(346002)(396003)(39860400002)(46966006)(36840700001)(40470700004)(47076005)(1076003)(82310400005)(2616005)(81166007)(966005)(54906003)(110136005)(316002)(426003)(336012)(186003)(36756003)(16526019)(4326008)(8676002)(44832011)(41300700001)(86362001)(70586007)(70206006)(36860700001)(8936002)(83380400001)(5660300002)(34020700004)(26005)(40460700003)(7696005)(478600001)(6666004)(2906002)(82740400003)(40480700001)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 11:42:26.3004
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5927c8c6-b7c4-4757-5e6a-08da5f449979
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0197
Message-ID: <20220706113750.eXhMhen7eLk4ftM0AxmvK5wdERcp1aPfs-PfQnoph9E@z>

Hi Joerg,
   As discussed in other thread, I have updated "From:" tag and
   resending patchset. No changes in the actual patch content.
   This patchset is based on top on "iommu/x86/amd" branch.
   Base commit : 0d10fe75911787 ("iommu/amd: Use try_cmpxchg64 in ....")

Newer AMD systems can support multiple PCI segments, where each segment
contains one or more IOMMU instances. However, an IOMMU instance can only
support a single PCI segment.

Current code assumes a system contains only one PCI segment (segment 0)
and creates global data structures such as device table, rlookup table,
etc.

This series introduces per-PCI-segment data structure, which contains
device table, alias table, etc. For each PCI segment, all IOMMUs
share the same data structure. The series also makes necessary code
adjustment and logging enhancements. Finally it removes global data
structures like device table, alias table, etc.

In case of system w/ single PCI segment (e.g. PCI segment ID is zero),
IOMMU driver allocates one PCI segment data structure, which will
be shared by all IOMMUs.

Patch 1 updates struct iommu_dev_data definition.

Patch 2 - 13 introduce new PCI segment structure and allocate per
data structures, and introduce the amd_iommu.pci_seg pointer to point
to the corresponded pci_segment structure. Also, we have introduced
a helper function rlookup_amd_iommu() to reverse-lookup each iommu
for a particular device.

Patch 14 - 27 adopt to per PCI segment data structure and removes
global data structure.

Patch 28 fixes flushing logic to flush upto last_bdf.

Patch 29 - 35 convert usages of 16-bit PCI device ID to include
16-bit segment ID.

v3 patchset: https://lore.kernel.org/linux-iommu/20220511072141.15485-1-vasant.hegde@amd.com/

Changes from v2 -> v3:
  - Addressed Joerg's review comments
    - Fixed typo in patch 1 subject
    - Fixed few minor things in patch 2
    - Merged patch 27 - 29 into one patch
    - Added new macros to get seg and devid from sbdf
  - Patch 32 : Extend devid to 32bit and added new macro.

v2 patchset : https://lore.kernel.org/linux-iommu/20220425113415.24087-1-vasant.hegde@amd.com/T/#t

Changes from v1 -> v2:
  - Updated patch 1 to include dev_is_pci() check

v1 patchset : https://lore.kernel.org/linux-iommu/20220404100023.324645-1-vasant.hegde@amd.com/T/#t

Changes from RFC -> v1:
  - Rebased patches on top of iommu/next tree.
  - Update struct iommu_dev_data definition
  - Updated few log message to print segment ID
  - Fix smatch warnings

RFC patchset : https://lore.kernel.org/linux-iommu/20220311094854.31595-1-vasant.hegde@amd.com/T/#t


Regards,
Vasant

Suravee Suthikulpanit (20):
  iommu/amd: Introduce per PCI segment device table
  iommu/amd: Introduce per PCI segment rlookup table
  iommu/amd: Introduce per PCI segment old_dev_tbl_cpy
  iommu/amd: Introduce per PCI segment alias_table
  iommu/amd: Convert to use rlookup_amd_iommu helper function
  iommu/amd: Update irq_remapping_alloc to use IOMMU lookup helper function
  iommu/amd: Introduce struct amd_ir_data.iommu
  iommu/amd: Update amd_irte_ops functions
  iommu/amd: Update alloc_irq_table and alloc_irq_index
  iommu/amd: Update set_dte_entry and clear_dte_entry
  iommu/amd: Update iommu_ignore_device
  iommu/amd: Update dump_dte_entry
  iommu/amd: Update set_dte_irq_entry
  iommu/amd: Update (un)init_device_table_dma()
  iommu/amd: Update set_dev_entry_bit() and get_dev_entry_bit()
  iommu/amd: Remove global amd_iommu_[dev_table/alias_table/last_bdf]
  iommu/amd: Introduce get_device_sbdf_id() helper function
  iommu/amd: Include PCI segment ID when initialize IOMMU
  iommu/amd: Specify PCI segment ID when getting pci device
  iommu/amd: Add PCI segment support for ivrs_[ioapic/hpet/acpihid] commands

Vasant Hegde (15):
  iommu/amd: Update struct iommu_dev_data definition
  iommu/amd: Introduce pci segment structure
  iommu/amd: Introduce per PCI segment irq_lookup_table
  iommu/amd: Introduce per PCI segment dev_data_list
  iommu/amd: Introduce per PCI segment unity map list
  iommu/amd: Introduce per PCI segment last_bdf
  iommu/amd: Introduce per PCI segment device table size
  iommu/amd: Introduce per PCI segment alias table size
  iommu/amd: Introduce per PCI segment rlookup table size
  iommu/amd: Convert to use per PCI segment irq_lookup_table
  iommu/amd: Convert to use per PCI segment rlookup_table
  iommu/amd: Flush upto last_bdf only
  iommu/amd: Print PCI segment ID in error log messages
  iommu/amd: Update device_state structure to include PCI seg ID
  iommu/amd: Update amd_iommu_fault structure to include PCI seg ID

 .../admin-guide/kernel-parameters.txt         |  34 +-
 drivers/iommu/amd/amd_iommu.h                 |  13 +-
 drivers/iommu/amd/amd_iommu_types.h           | 133 +++-
 drivers/iommu/amd/init.c                      | 687 +++++++++++-------
 drivers/iommu/amd/iommu.c                     | 563 ++++++++------
 drivers/iommu/amd/iommu_v2.c                  |  67 +-
 drivers/iommu/amd/quirks.c                    |   4 +-
 7 files changed, 904 insertions(+), 597 deletions(-)

-- 
2.27.0
