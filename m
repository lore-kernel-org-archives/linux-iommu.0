Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012025.outbound.protection.outlook.com [52.101.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FF617A305
	for <iommu@lists.linux.dev>; Wed,  1 Oct 2025 06:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759299022; cv=fail; b=gsOd7pwXPMvUL6sUmvVpi5HKK0NrKkcsUV1CnUilFbRT8RZ+rWfQJBpGWex8AmknpMVZxf6P4FQKQJBBSkHKakcWQKAEWs7htn7FnYnStTByKpGnN1iYnZ3HJP8yJcknXFQ2nt+ijIGnrKmJzKQmBjVTdOQEVpMOCF+Eh7fwuEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759299022; c=relaxed/simple;
	bh=NimiVPGLvt8kd6Ax+fiDzqJHltRhmQiEmYcNik97rS0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gMaTc4T39Vari2IoD9EoOGr2cXJJRnJbuCRNigLYcjYzm2GEeyqkKYvzisa4KBSRqqFtFDuPTjmyWw0/oDDVVQat0DNJF2ZlGLWvTyCb7ZvVdMrtygm3dWeGb90OzbuZm0Nh3cYRuICC6lkQOSIZtTafaZlE6XAFSpnr4t5kAKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ev6x48Vl; arc=fail smtp.client-ip=52.101.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ev6x48Vl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TEwVuIRFkhMgb2KvLpl65a/6Dz6tbMiOugFFclCYygxmoPbw46692LtG5zOlMUq1qDQO2Nb0eoDbSUJDdp1ezuaLpqULtFcLvEbjDRuWNUQ2pAeVEqNPls2qr+r0ogPr392Ji3TPWl9bjTBwfvlvWO0BcXOLcdp1whJN3sMWxtP5UEfDN7gfzu53TS9inqEwZ27AIKIDUYeFMHuNc5oogwz5N8Nuh5ud3b6Mx6L1yGf4u4ulccG3pd4pZUTzp8jHX1/u92YldoAowiWkDgo7lpnX6laMby+F/BK8wbxwhZCbwZr3qq+MZToXR26WA8kRfiRtsnGwUnroYErY074gHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/zCo4VfqKq/XMGB9Jclzh+TeVBxOX4bF5JOYIwFn1jM=;
 b=dhOqlfr8gRKGw8iv6pRc0ChxPyIv8P/UTnU1DoahBblTlHm2Xs5XDXCkNadFJ2Yi3Z0MmL6TZZ1dLprgWzSLf42B5n1H+p50VRdPUtlO4t4oMw7uwIk2H15nAIx9mnd03D99JQBjE8QLHIze7l6bxRYUNz2HdSvwL0C4YFxt7oSUwhez5ZdjlhRpJi/Z3tL87qKArItR/z+nnuHFFrWYXuWGrfZchliZU/AWxhkkL7id9pmZ/ApmgoHkoKWF+Oq50jPgh5KZk88c1AVkGq6cPIVxD0bT+KspGc7BAzJ4QkdJ47Z338ZyLePDU758aNW8ytR62zQOK27DxC+YMJjIvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zCo4VfqKq/XMGB9Jclzh+TeVBxOX4bF5JOYIwFn1jM=;
 b=Ev6x48VlhinWWoIDhWBxpGUB6dY0+rqJhgK1Sn8rLDsbAsMrazf0D/9XiEsxLiOYfpc66kgX9s7wvfeaqSUOXNT32DQIuzJc9hMJivgZvQkiX/DZ88g57XVbfl13CwZYyLNZpMgjGMbztSLZwbpQ/W3eoJVHGqAEgKbjecJ05Ak=
Received: from SJ0PR05CA0200.namprd05.prod.outlook.com (2603:10b6:a03:330::25)
 by CH2PR12MB4312.namprd12.prod.outlook.com (2603:10b6:610:af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 06:10:14 +0000
Received: from SJ5PEPF00000207.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::76) by SJ0PR05CA0200.outlook.office365.com
 (2603:10b6:a03:330::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.8 via Frontend Transport; Wed, 1
 Oct 2025 06:10:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000207.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Wed, 1 Oct 2025 06:10:14 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 30 Sep
 2025 23:10:08 -0700
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
Subject: [PATCH v2 00/12] iommu/amd: Introduce Nested Translation support
Date: Wed, 1 Oct 2025 06:09:42 +0000
Message-ID: <20251001060954.5030-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000207:EE_|CH2PR12MB4312:EE_
X-MS-Office365-Filtering-Correlation-Id: 303e47f8-2cc1-47dc-ad48-08de00b12fca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fIgHvLONBoW6HZ4LOlzOntHpgPpefsae5008V8zfjDRnUUIHZY2cX2wGmgGX?=
 =?us-ascii?Q?+DqE8/5HcctxzpgJbLbjOY8/nL/KO8Q376uOAqrbzUWVXiccxBwOkGGYSEbv?=
 =?us-ascii?Q?yJseqrvvdTBTovq6U5w8EeNzrLUI/C/hKHacho7UmAp++YuJJWTbELRN1x4g?=
 =?us-ascii?Q?1x0bxm0qJ9GO5TM5HBx+r18cUkgq2JOzx/pbl9JWmnkKA1UIVg1f9Hvrv+rz?=
 =?us-ascii?Q?SGoD6VE5C1yJTAydFqcFMji+jEryhKEetCA5GHPpW0DKCK/jaXiTVaZ/KE5i?=
 =?us-ascii?Q?FnmT+szmM50p10AJ2DEiwmxlkO7AAWakt2/FJSyT/LXOHiH28EmYtEmbOafZ?=
 =?us-ascii?Q?fcuDp1bLvH4cKUhSF+NJrh+/6rjyKVMgK8OjJFJSB4jGs0epVzu0tymxtO6+?=
 =?us-ascii?Q?FJKU9KI7DYFTHmEicdxisX/UUjOhDNLfHiPh6w2jcBmNyBRomCW1rav5FiD5?=
 =?us-ascii?Q?rgejZHFDPtP83E9duEDhSXvRZKT4AxEwtZypwfNiCBIuhlJFKMWrICMfQKyM?=
 =?us-ascii?Q?9gnxKQ82K8AEo301yRCZ9ln7WZQNTkCoP+x/bUNLRPjQUUQayhlanldG29XT?=
 =?us-ascii?Q?uHxqzAnKocjOUZSwQuB/kbV7eqTWJ808b0K3BiBu8I3s+eoYDEY16lBJ6Ydx?=
 =?us-ascii?Q?XLf9CZQeaNffL9uBU1IF0HIeUWOlb1h8y09XA0jDwaxaqwOWFsHyiK2f+W3K?=
 =?us-ascii?Q?Iw2KqU/sFAhnkpleX0dgPgfjP0wQBSdJanBLoTN8ArNtm7JBLvAEDI1tg5cF?=
 =?us-ascii?Q?YhWxm5JuypW5qveaLpIcs1RDZaEw8z9etR4Iaedq+lEA2SfVSscnhwOve/+t?=
 =?us-ascii?Q?175CQ+SzlVwGIoPAsVlHsJh9749xDTV4DUcxZ2FL8378YFTNnN+IX7LZvKC8?=
 =?us-ascii?Q?KOwntOHR9FRAGzmhO55bhVJd7J1RjIe9vWr/ymEJ862qo1VGltFXpZWSRegB?=
 =?us-ascii?Q?cmYRmGLnhG0kXLU3/3eyOz1+pi1WF0EsPtM8esROME5+/bC2OjxRp8yX4ufZ?=
 =?us-ascii?Q?vruzD5Bs43YKTFKqm2+qFngIapbWZXiHBJMzibKfSCA6kDY1qbmnUu7Fc55P?=
 =?us-ascii?Q?o6ejaC+vXdiTFEWDKMAIOzYSsyFOF4x0tXR2vIwfS0oL7VqzU2jEujrMgj2x?=
 =?us-ascii?Q?cR7rl3sLOVAjCm2XAZeddLb7B7ihkMVW8KWoFQDgOsOpGtvbIO+J7kNHjP/R?=
 =?us-ascii?Q?ROu+WLQ0OsAtgNSC3mtdQFwZdGSpeK4tDS6DDoNTlcLogDmLSBMq3YkVsFr7?=
 =?us-ascii?Q?ohLVtEkVZaiTyOUKNNNoPhtvmnk6tBXJo11kML/v33N/3zgHY004ELmMBAgq?=
 =?us-ascii?Q?4CDCv2hg1lFQTzEWScEhKEkfW7OYAhYUt3OMUgwi1D8e4a6P1W7JHRdiiILG?=
 =?us-ascii?Q?4goplaY1QHnr/s9dZY7MZCFKS1rhzcBlhmybei8ajCmB0OE12eMFsFCdNvSg?=
 =?us-ascii?Q?nYZOSvW9ygdqf26lyJnlEp638NQ2ZW4fqXjiW/ugWUqjOM89YmBawACI8gz0?=
 =?us-ascii?Q?w4en+B5LVxz2WGF3sk8cuYh6wl1TLwObGIou?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 06:10:14.2950
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 303e47f8-2cc1-47dc-ad48-08de00b12fca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4312

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
 * Patch 1-7 are preparatory patches.
 * Patch 8-12 implement nest-parent and nested domains support
   for IOMMUFD vIOMMU.

Thanks,
Suravee

Note: This series is rebased on top of:
 * [PATCH v5] iommu/amd: Add support for hw_info for iommu capability query
   https://lore.kernel.org/linux-iommu/20250926141901.511313-1-suravee.suthikulpanit@amd.com/T/#u 

Changes from V1:
(https://lore.kernel.org/linux-iommu/20250820113009.5233-1-suravee.suthikulpanit@amd.com/)
 * Patch 10: Introduce struct nested_domain instead of reusing
             struct protection_domain.
 * Patch 11: Introduce set_dte_nested() insted of reusing set_dte_entry().
 * Patch 12: Introduce struct iommu_viommu_amd and base code for IOMMUFD
             vIOMMU. This is mainly to allow nested domain integration with
             struct iommufd_viommu_ops.alloc_domain_nested for vIOMMU-based
             nesting support.

Suravee Suthikulpanit (12):
  iommu/amd: Rename DEV_DOMID_MASK to DTE_DOMID_MASK
  iommu/amd: Make amd_iommu_pdom_id_alloc() non-static
  iommu/amd: Make amd_iommu_pdom_id_free() non-static
  iommu/amd: Make amd_iommu_device_flush_dte() non-static
  iommu/amd: Make amd_iommu_update_dte256() non-static
  iommu/amd: Make amd_iommu_make_clear_dte() non-static inline
  iommu/amd: Make amd_iommu_completion_wait() non-static
  iommufd: Introduce data struct for AMD nested domain allocation
  iommu/amd: Add support for nest parent domain allocation
  iommu/amd: Add support for nested domain allocation
  iommu/amd: Add support for nested domain attach/detach
  iommu/amd: Introduce IOMMUFD vIOMMU support for AMD

 drivers/iommu/amd/Makefile          |   2 +-
 drivers/iommu/amd/amd_iommu.h       |  33 ++++++
 drivers/iommu/amd/amd_iommu_types.h |  45 +++++--
 drivers/iommu/amd/init.c            |   3 +
 drivers/iommu/amd/iommu.c           | 178 ++++++++++++++++++++--------
 drivers/iommu/amd/iommufd.c         |   8 ++
 drivers/iommu/amd/iommufd.h         |   2 +
 drivers/iommu/amd/nested.c          | 172 +++++++++++++++++++++++++++
 include/uapi/linux/iommufd.h        |  30 +++++
 9 files changed, 413 insertions(+), 60 deletions(-)
 create mode 100644 drivers/iommu/amd/nested.c

-- 
2.34.1

