Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013004.outbound.protection.outlook.com [40.93.201.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D29A3538A6
	for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 18:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762971937; cv=fail; b=YTe+biV+plwS+7SC5DGcKzhM8kJ1KNcCgVZRBi//ubEj1FZivrrAfDCw3mO51Z3u3iN66ZWCUyqPILYtK6tgTHmpDEEiOoVH9ZBld2lQG4K2uiGtW84aDs1LT8VMKxEyswlg/V0GgLMs9oTkxlt4NwQvu/n+BZaGBDnVwFMmT1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762971937; c=relaxed/simple;
	bh=2wLB0Sblim8QKf1DqrgzhPidUBHig5xle16jRktjbjs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EK6xFFQp7NsX3QOqQgz5kyB9qI7HV7/kW4jOrXfTSytB2/BlivDZKy9AIdKbpbAENRfrKu6xjs91wAWsTWufKGqmxC7zwLqBc2IfTghdORWkhedfvjsaSjjNYfRNq8IoA2KOuTvkXW6Kk/r4I5+sF37xfovs4cCzdWWzX/u1XD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xWFl3O/I; arc=fail smtp.client-ip=40.93.201.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xWFl3O/I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U8xchTFm6obiXWna0cX1hkuBPKoNQW84OCw/DOdFUg7A6u5g6g9khZHptusk5Tw6Jl12rYdki2kaSaMSP3Cgn5IIyF4D7iuTaUh/QnZfGGsn/qk9u5Qolw7S1zWTs7KgRZUGtgEyyOONPpJOISOWBK2KcDxaKQrlj79C6Dr8vsJL9OJif4Pxwo04qx71xhibRSBKWt6ibeSXRsQ6P7c42BydZiH//Edaxw4KhN58S69mvAaJ4Kir6B+937RU+1R150GN62Vp1++Cv/vvoK4qH3C4XkpPXLY6Aj0s3pELDRZ/CfuQnnoNQpIm4vOmp7gSGZg8yrTBbGTLjAlJX+KsLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ndfeEaurtwPzqYeZhS1xQLEC4DnX9MQlu3dG4CAmLs=;
 b=pGXPgCTfuC1p7vVx9NpqFY4F3vwT+JCVnjTTXiBBBnKN0T7zybpRq3tT55xvfSSDQhtXIsV38Ls9/jrEnemxnHT1WTRE+5v/KQ8EbH1VD+YJE/DihQZahAWzJ8eJxDghBk/IgJYuGg+HO/XV9JJg/tAMKK/CkvGVFMt9qdvywbFO/EvO1KKB081SM/gX4AUy2AltS+1HkEhuaTVD0hgFKFQM+o/CQN0P1rvKg90Y3fQz3NqXi7QqYvcm2O2+drYuAGgOI5lh0pG0nArjGizCzeuc8VRbWBHduxcFMkURqUqnXPjGur7gy/EEgObFDGIkXJH/LyVGWY9fFN5XxSlnJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ndfeEaurtwPzqYeZhS1xQLEC4DnX9MQlu3dG4CAmLs=;
 b=xWFl3O/Ity6ZMvAG75Wz7z8aAxxrYi/Y0m6vUhEQEoTUeyK2ZECeyEZr2qjlM96KyRHfzDn8V15xK/5W1WrXfGn9n/DU9UmrDFikHprHMGUIoZi6te/s9jrG8+UtxIRu7iaQwVoLbz9VpXPX/R4aI0234glnh/ESL03VWZEalH4=
Received: from SJ0PR05CA0143.namprd05.prod.outlook.com (2603:10b6:a03:33d::28)
 by CH3PR12MB9028.namprd12.prod.outlook.com (2603:10b6:610:123::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 18:25:30 +0000
Received: from SJ1PEPF000026C5.namprd04.prod.outlook.com
 (2603:10b6:a03:33d:cafe::8b) by SJ0PR05CA0143.outlook.office365.com
 (2603:10b6:a03:33d::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Wed,
 12 Nov 2025 18:25:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C5.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 18:25:29 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 10:25:22 -0800
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <jgg@nvidia.com>, <nicolinc@nvidia.com>
CC: <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>, <will@kernel.org>,
	<joro@8bytes.org>, <kevin.tian@intel.com>, <jsnitsel@redhat.com>,
	<vasant.hegde@amd.com>, <iommu@lists.linux.dev>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v5 00/14] iommu/amd: Introduce Nested Translation support
Date: Wed, 12 Nov 2025 18:24:52 +0000
Message-ID: <20251112182506.7165-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C5:EE_|CH3PR12MB9028:EE_
X-MS-Office365-Filtering-Correlation-Id: f779190a-bdc8-44d2-7b48-08de2218dbf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Fc585QcQ6yMIv6CGVj/y46F4Jbjz36oTOqcREJZmY8J19s2GgYtXj64I1uVM?=
 =?us-ascii?Q?19RcqD+mww6NhMNb/bqU9QdLIMDjYjAAGJDFlGwQty4u16df0h2YTZXMtHL7?=
 =?us-ascii?Q?BWq1JXPhhTnkRK1BE4Mta80xqLavNefO987r6U2KZyXvW6ZwmDFJlIxwuXyN?=
 =?us-ascii?Q?FqbkVxcLMFAIRzlkmtRFJfibqawTX440rR0zvvbtQC0C2jAysXmJRa8+BTRL?=
 =?us-ascii?Q?/JDC9rwqWJFJsbTVGRcmzMyogvVzBO/+CK6vuqylgaQ3wAH8aBFUqQEUlQXo?=
 =?us-ascii?Q?HLSJ3Qf7z3n++3+U6HQCuH4e7xtl1Fbk4XhkO2gkjkictBdwrenW7TWDoxeC?=
 =?us-ascii?Q?HBFAQ0HG1d6xn1lVTZTGRrePsS9eAbB39fqSg9myNhhWkL/OgcAFJfaEdtqj?=
 =?us-ascii?Q?13bMvTkzYvmwMUl1/nEDOcS6ozqZVeyaRpk3FpzwGNd0aNsVesunB7VWMpjM?=
 =?us-ascii?Q?MvJndziLq213NPxpSf2cKYPQz8FaS+n07QwdHpcZayeXCWJvYAK0b+DyTHvN?=
 =?us-ascii?Q?09znDgaRZ/jvLyUXXUwuDNG2FFIQbGXwCRPquPL6W+lbyr33UVxyvQwJA+2s?=
 =?us-ascii?Q?/5CN9RKxyLH1GEFfZb1UxuBHW/rQLp3naEg90S/2ghtejgNMMif2lzk2IusH?=
 =?us-ascii?Q?FhswdxDh9BTkoTb+RV5aggUmrKS+Pkcgc35XB4UsmjHUbVVEo6qZz62TJMMc?=
 =?us-ascii?Q?UtdzW35gVu3gBrbktjO17FamhFGGe9MmhzwFYzIVkxQHmf+wSY6tFg+qHYj7?=
 =?us-ascii?Q?86szJm2zV1cuxE5e1XM6iQnC2s8ivnBfyDIqGoop26EAWtyf6m1Lu3pLLsW7?=
 =?us-ascii?Q?SKOVmM6dOD9gU9qsHl8+fET5ecc7fxykSkvaGl5yRLvCDrhfCFHhPPpcezN4?=
 =?us-ascii?Q?2cUwuGya4ym9TK6qiOLs3egrSp7d4+tP3T1L9AdLQzPK+GgCRAUbzcECLuF8?=
 =?us-ascii?Q?OLQ2m1YDvjlBXa8z3EHNgXNCMTySV8o9jiTANPPtTuoG+ucQCU1MpjpOuwlX?=
 =?us-ascii?Q?waOofinXl6NCinoZMzW6NTIHHvDhdbFO1amnVxYlCEvl3RD3PrmqpY6OkX64?=
 =?us-ascii?Q?VBXDGIufnQahdloibrN7NOTNyilYaJaKg171a2mBhAWwSk4+wlLxuQdEopq/?=
 =?us-ascii?Q?aaj5IfjpykIfyNpQCgepPI1lUnjAXQJkpnIPqBVq31iS4JfNYRVdHCSt6ETo?=
 =?us-ascii?Q?KEsB2mGwX9Ww5Z20UFU+tYrCKPQUJb4d09hBTMkypKtmkWZ768G4pN3fjB4u?=
 =?us-ascii?Q?DwY3Mx6g/2dTIfKeFN+Szg7A/fkgB88Aq2iz7DIrYOYNdOIME5SobW5a2d9C?=
 =?us-ascii?Q?n0a4m2fUjPUjXZjpUOjvwqP1eS6K67z3xMJLE9PKWdnXRHbEpdWuqB5VxmNY?=
 =?us-ascii?Q?eqn5FC/L1ZnklVrttSz1qEbCKKPE4/NOAwXfw4R+iH/8OmVjeLATPLSoMbRo?=
 =?us-ascii?Q?V1oMnBZowwl164jtce0oJWLueQ+P3eWMc1VG5+E+SDaEled1iuAreALpBpFV?=
 =?us-ascii?Q?dgtgX70P5VzoKC+MazVYE75aRcgHtk+ZMzPvbZrfNUAzc74lL4aAohy9/ZeS?=
 =?us-ascii?Q?5RCDQYhkJlhSFg4kfJFLdgqAzRRvHsk00Pz06ncX?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 18:25:29.7380
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f779190a-bdc8-44d2-7b48-08de2218dbf7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9028

This series introduces support for AMD IOMMU nested page table translation
with the host (v1) and guest (v2) page tables.

In this mode, the AMD IOMMU driver configures the Device Table Entry (DTE)
with host page table root pointer, which is configured by allocating domain
with page table type IOMMU_HWPT_ALLOC_NEST_PARENT.

The guest page tables and Guest CR3 (GCR3) tables are managed by Guest OS,
and stored in the guest DTE (gDTE) in guest memory. VMM is responsible for
passing gDTE information to the host IOMMU driver using struct
iommu_hwpt_amd_guest when allocating a domain type IOMMU_DOMAIN_NESTED.
Then, the gDTE is parsed and program onto host DTE by the AMD IOMMU driver.

In addition, this series introduces base code for IOMMUFD vIOMMU for AMD
IOMMU, and implements vIOMMU-based nested domain allocation interface.
The struct nested_domain to store nested domain information, and
set_dte_nested() helper function to handle DTE programing for the nested
domain.

The series is separated into two parts:
 * Patch 1-5 are preparatory patches.
 * Patch 6-17 implement nest-parent and nested domains support
   for IOMMUFD vIOMMU.

Note: This series is rebased on top of:
 * Git repo: git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git 
   Branch: next
   Commit: 91920a9d87f5 ("Merge branches 'arm/smmu/updates', 'arm/smmu/bindings',
                          'mediatek', 'nvidia/tegra', 'amd/amd-vi' and 'core' 
                          into next")
 * [PATCH v5] iommu/amd: Add support for hw_info for iommu capability query
   https://lore.kernel.org/linux-iommu/20250926141901.511313-1-suravee.suthikulpanit@amd.com/T/#u 

Changes from V4:
(https://lore.kernel.org/linux-iommu/20251009235755.4497-1-suravee.suthikulpanit@amd.com)
  * Remove unused patch to modify device_flush_dte().
  * Remove unused patch to modify iommu_completion_wait()
  * Remove unused patch to modify update_dte256()
  * Patch 5: (new)
  * Patch 11:
    - Move gdomid_array from protection_domain to struct amd_iommu_viommu.
    - Introduce struct guest_domain_mapping_info.
    - Rework logic to support multiple viommu.
    - Introduce amd_iommufd_viommu_destroy() to clean up data structurs
  * Patch 13:
    - Rework based on Jason's suggestion
    - Rebase on top of gen_pt changes, which affect the logic in set_dte_entry()
  * Patch 14
    - Modify to use the new amd_iommu_update_dte() per Jason's suggestion.

Thanks,
Suravee

Suravee Suthikulpanit (14):
  iommu/amd: Rename DEV_DOMID_MASK to DTE_DOMID_MASK
  iommu/amd: Make amd_iommu_pdom_id_alloc() non-static
  iommu/amd: Make amd_iommu_pdom_id_free() non-static
  iommu/amd: Make amd_iommu_make_clear_dte() non-static inline
  iommu/amd: Introduce helper function amd_iommu_update_dte()
  iommufd: Introduce data struct for AMD nested domain allocation
  iommu/amd: Always enable GCR3TRPMode when supported.
  iommu/amd: Add support for nest parent domain allocation
  iommu/amd: Introduce struct amd_iommu_viommu
  iommu/amd: Add support for nested domain allocation
  iommu/amd: Introduce gDomID-to-hDomID Mapping and handle parent domain
    invalidation
  iommu/amd: Refactor persistent DTE bits programming into
    amd_iommu_make_clear_dte()
  iommu/amd: Refactor logic to program the host page table in DTE
  iommu/amd: Add support for nested domain attach/detach

 drivers/iommu/amd/Makefile          |   2 +-
 drivers/iommu/amd/amd_iommu.h       |  36 ++++
 drivers/iommu/amd/amd_iommu_types.h |  48 +++++-
 drivers/iommu/amd/init.c            |   8 +
 drivers/iommu/amd/iommu.c           | 221 +++++++++++++++---------
 drivers/iommu/amd/iommufd.c         |  50 ++++++
 drivers/iommu/amd/iommufd.h         |   5 +
 drivers/iommu/amd/nested.c          | 259 ++++++++++++++++++++++++++++
 include/uapi/linux/iommufd.h        |  11 ++
 9 files changed, 558 insertions(+), 82 deletions(-)
 create mode 100644 drivers/iommu/amd/nested.c

-- 
2.34.1

