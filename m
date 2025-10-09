Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012067.outbound.protection.outlook.com [52.101.48.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C036428BAB1
	for <iommu@lists.linux.dev>; Thu,  9 Oct 2025 23:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760054301; cv=fail; b=ISlw4/U7P4wYxJfQo529jUvAtLl04wiYfOSaCMY31//KzgS7sIdS1N0W9Wmw5QN0UV5/7tDiRr9jVnLFEr8YrrcKdZ3+sMPzQQGaNU8o9BeFZmE+2EQ+f7YaicTvFRSOObJT4ALxUtY5Ivn6KoMed4kBsbcFEQlY5QmJEciZRDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760054301; c=relaxed/simple;
	bh=MV0XScqH/+4aeUChyIE6yEhsG26nrW17BBdCUQ/w/nY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YH4EG+NXCzwQhz1N0jeSEnHzh8zJRpjX04HWC0VATSoIA4w/00s0c+09s8f7YrVwPeKozuedUcYbIS1uK4pCSPefmZhq6owjU0c5v1izRSXocTHWATk0Khx3RrgLvJfZD65e1GNZs6Seia3j45JNa8+LEQ6/FU4AcJo1nId22sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WQFxF7FT; arc=fail smtp.client-ip=52.101.48.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WQFxF7FT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M2UiXNYfz+0GU29sBBgHM15zrBoUKZTrv2RNG+VkUrkwD50bf6vaZQc0JmI9nuI4dHQook3irWRn25gPRf2lWizqT0kwxCro3XIonhLiEBoI+a34hJJmsITtxVpch9UN+ld8DGfbvWYa6aiWVsLH9ITxiaGTXrzt2/OTNDuDYQe8Ry6qV209bAdDePCRgLJStapfHtrS/9F42z79ZI7i6yHmviCO0Q+HaiPppEZ53xzscyJZkMO9XxspwDbosMx3yrzuqww74opvcc1WW4Jvrn1kiprX5hbbmq6e/liShOtsUeprqniGk0KNtpJ6hFTfqlTDo0cFr8BQ5NdlOcyBOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OB7EliHrfObOaw2ElWQcwjyVZF+Oxl/iJLW7DOgr3ic=;
 b=OvTlkI1DlvAH+OkHf7U3IPlypFBbVSAGZ8llH+UYRPWPs1Ogqn7yzaTWI5Vl38ffyVjonFbglFptiviMCmeECx8nSHzGpW4hjRrauz178C/hDvWnIdeEZGLWUt7U4CDL/LPCizCyxOTpbtdkQNkzbBS/VyZnZus2IzUCFIEBseR88e4N9pGLWjWioSRIzW/EU/ICdASsaYxVf6WF0tOcs3pXaSK3yGcrG7TZ15AvLPDtWjZPWv+eE6ibwFqqDeuRe6wB2Hp8Bt2GM6VSIEMvNNcP6k//LqfAF7pZpZmfAZdVT7H9yZ/XMicbzlVFf0kN2ZZvX0XJXi6S4S8z2Qx6kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OB7EliHrfObOaw2ElWQcwjyVZF+Oxl/iJLW7DOgr3ic=;
 b=WQFxF7FTGsOfc/AwBEy46WEql35gxuoQN1UwVKwqy73Ndr+IHrMKjjKLRUU6F00L2gyAyZyACY6HGPSmYHYVSmye1ASs8G4m5NVYRNHaTbg0IkLThfkBltyXDaX6ZueJcYeB+OQiazfu1Sy8iUHuLVU+PvRz7u2K+iwrJdvRB4E=
Received: from DM6PR03CA0045.namprd03.prod.outlook.com (2603:10b6:5:100::22)
 by PH7PR12MB7306.namprd12.prod.outlook.com (2603:10b6:510:20a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 23:58:14 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:5:100:cafe::69) by DM6PR03CA0045.outlook.office365.com
 (2603:10b6:5:100::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via Frontend Transport; Thu, 9
 Oct 2025 23:58:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Thu, 9 Oct 2025 23:58:13 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Oct
 2025 16:58:08 -0700
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
Subject: [PATCH v3 00/15] iommu/amd: Introduce Nested Translation support
Date: Thu, 9 Oct 2025 23:57:40 +0000
Message-ID: <20251009235755.4497-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|PH7PR12MB7306:EE_
X-MS-Office365-Filtering-Correlation-Id: c145763a-20b2-4e31-e984-08de078fb589
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Yoq/Ek2Xr9N5zJxLYgQOY5CvrY886kj81oWvp+HsnSQfW/t+UoHPzIxXxODb?=
 =?us-ascii?Q?x9aWuCYfGw5RlqNCwVIawKsBlPecb1H15cg/AW/RSk6wXqHHyF/oxVSvTCAb?=
 =?us-ascii?Q?RAqEJnVAc5EnPCJWFckAuGA8zYc5NhnhiytACEPYkqiBC4Y42dHMwB+dzren?=
 =?us-ascii?Q?25ufyb6Nbn0YQ+mayKm39G60dKmSX6sEY++AQz7BU9ldO5nRZb6uf7M6H/wN?=
 =?us-ascii?Q?7nzK3moluoPQh4U8MvZS2KfBT0akE4NiaI56ifaSgQRcBOTA4Yedr2qi4szZ?=
 =?us-ascii?Q?pUFHetOhfL6HYLeMAHZpJ1pSdD0BEIxRV1e2OoszEhCHJqWkHDvl9Y1QlACP?=
 =?us-ascii?Q?ddxehbAzhyPP4exSqB3EozdeDDsnKWamtw50xTWgafufidO14365mnEMqAYU?=
 =?us-ascii?Q?+aCro/c+XUJKQPCDd8KZrRxDZTsXkA5jgwpoGp/MZkq4Mkh2d3RH7U3CCXhx?=
 =?us-ascii?Q?bvhOfKzy5MkFZAOkor9vCGno0AZi5lsqVPoWyoifVt0NXrp/djLp3EhVpgDL?=
 =?us-ascii?Q?b7fLKjmex1YdfbltSiiKh2Lu4ln2+talWYR48up7feynkMHGe+B4RzotwNU1?=
 =?us-ascii?Q?uOH53mxTHjIjdyKeJ1JaNWheoVfWKRfYfjDZS2GjSj00wQEoMBSBk4Plhv19?=
 =?us-ascii?Q?JKU1FILIXJbOO54d1pJ+2rl8s+Dho2R46ZuXX1Q5BkcAKhjKzpVi3bznX9NK?=
 =?us-ascii?Q?4GYdGHCbvQDb6QOp7OiUu/z2uZa63ULLtAsAYi2NVnfVZznXnB/AgIZi36Ml?=
 =?us-ascii?Q?PFOcKYk+o8jF3llxajNudGM52MqqjaCVx6Lj+zI9EP8pgUiepmwAh9QWSbjH?=
 =?us-ascii?Q?s/twCo+nvj4E/aYdxIRr7RgHDMQR8FuUIfMii+TFBMPO2X5KvxfpURN3iozZ?=
 =?us-ascii?Q?gm20BCJYGdQhK8N7I17XUVPyqSF6VMcfRyapitsx8coAD9vPm4FCFcdfyx8z?=
 =?us-ascii?Q?dzBlUmmx+A/MrkQTZVuEyAcUBnHE2VqhYIRXmuIGQ4twgYh4DCGLagjVdhB1?=
 =?us-ascii?Q?e6Rv1t1uhbJV0K0egtZu5mg9ecXlQCOum+VFZ3bjD2Vt9JU3r1hqs9sDlSH0?=
 =?us-ascii?Q?uAft3URK6JeBXMlIy+auKB0HdwW73vzPRRmaELXMO8yN2zZ70rIbi5lIouby?=
 =?us-ascii?Q?yGnaNKns9rQe8CYBPUF4VOzLf1J0bCyxJ9pvWpeVqVrUiA57ja02qtW6DMxT?=
 =?us-ascii?Q?pufV/CgzlVI6aCiqXRz86IfqcPbxKgPkTMhWcDcTS6YueGQHP2m9VJ7R+tqI?=
 =?us-ascii?Q?LYqeGltE/6LnyDe6fzW2LIhHcYUNbIToM+wAI9x1DNYlVeB/YSmr907vF3gK?=
 =?us-ascii?Q?A8Taml7IzR7MZPU5w9AEP12bDkXghgb+wpRDtDT4ZFrj0to/z4ZAutQKOGlx?=
 =?us-ascii?Q?aHWr5DpaR6F7ob9cCH/eKpUthQlrjwbnkqu4gXEcXLTnebcvDWBO7qASY08e?=
 =?us-ascii?Q?krMlCAo0J5rXVF16JCmvOvglOnX+5EE+9HdWRFVNRr5eavOSzsGuuExWSpNu?=
 =?us-ascii?Q?fNez0Bkd16iiep97g6uJLDVRf7otilDVNH2OPRC5vb+aK6Dzs0abvXh0EiHi?=
 =?us-ascii?Q?oKlPYPG9KthHPF8csjrUe9y4fs4nyaqEOt2C0KDj?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 23:58:13.9806
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c145763a-20b2-4e31-e984-08de078fb589
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7306

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
 * Patch 8-15 implement nest-parent and nested domains support
   for IOMMUFD vIOMMU.

Note: This series is rebased on top of:
 * [PATCH v5] iommu/amd: Add support for hw_info for iommu capability query
   https://lore.kernel.org/linux-iommu/20250926141901.511313-1-suravee.suthikulpanit@amd.com/T/#u 

Changes from V2:
(https://lore.kernel.org/linux-iommu/20251001060954.5030-1-suravee.suthikulpanit@amd.com)
 * Patch 9 (new)
 * Patch 10: Update logic per Nicolin
 * Patch 11:
    - Do not change struct iommu_dev_data (remove parent, ndom)
    - Add comment on domain ID allocation
    - Move nested_domain_free() here
 * Patch 12, 13, 14 (new)
 * Patch 15:
    - Introduce struct amd_iommu_viommu to store struct iommufd_viommu,
      which is used to retrieve the parent domaina
    - Clean up the nested_attach_device() to use the new
      amd_iommu_set_dte_v1() instead of duplicating the logic. 

Thanks,
Suravee

Suravee Suthikulpanit (15):
  iommu/amd: Rename DEV_DOMID_MASK to DTE_DOMID_MASK
  iommu/amd: Make amd_iommu_pdom_id_alloc() non-static
  iommu/amd: Make amd_iommu_pdom_id_free() non-static
  iommu/amd: Make amd_iommu_device_flush_dte() non-static
  iommu/amd: Make amd_iommu_update_dte256() non-static
  iommu/amd: Make amd_iommu_make_clear_dte() non-static inline
  iommu/amd: Make amd_iommu_completion_wait() non-static
  iommufd: Introduce data struct for AMD nested domain allocation
  iommu/amd: Always enable GCR3TRPMode when supported.
  iommu/amd: Add support for nest parent domain allocation
  iommu/amd: Add support for nested domain allocation
  iommu/amd: Validate guest DTE for nested translation
  iommu/amd: Refactor persistent DTE bits programming into
    amd_iommu_make_clear_dte()
  iommu/amd: Refactor logic to program the host page table in DTE
  iommu/amd: Add support for nested domain attach/detach

 drivers/iommu/amd/Makefile          |   2 +-
 drivers/iommu/amd/amd_iommu.h       |  36 ++++++
 drivers/iommu/amd/amd_iommu_types.h |  45 +++++--
 drivers/iommu/amd/init.c            |   3 +
 drivers/iommu/amd/iommu.c           | 165 ++++++++++++------------
 drivers/iommu/amd/nested.c          | 191 ++++++++++++++++++++++++++++
 include/uapi/linux/iommufd.h        |  11 ++
 7 files changed, 361 insertions(+), 92 deletions(-)
 create mode 100644 drivers/iommu/amd/nested.c

-- 
2.34.1

