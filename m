Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011006.outbound.protection.outlook.com [52.101.52.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE9D27A91F
	for <iommu@lists.linux.dev>; Tue, 21 Oct 2025 01:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761011200; cv=fail; b=CCfRLyiIr31+X6pndpJtyi1Z71XWfIUkfjF2BEaQUG7jTuj6E1GSMgj5uCvwq5HtZJdKI1T+Za7lTPnq/zE05D2EiIe9H4U+WQPzGUcoXo/cE0Q71KwKjxbuRQg/sbdu8ZvJ8/SX7VBQqnx0Hd2Fsp0BX8QC0qccwBs3daRBJmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761011200; c=relaxed/simple;
	bh=B3szW5Cs60l5wSjrorG2mZ1yD/qKFI0RkMj/3dDT+eA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VSTf3Ro7RjzT/529RYT6M9S6zkNZffv5swJUDZMdl9JfwdZQyw9p9aqvxRIvWqAG7mfi9WKUmcIxeaKLTqsYDzJHWLJBvX5LlMT0yevrnL9nmsTLxPOuR6ly9iPa4XwbEVoA/4f0hrcNS0NZuYbXX8LhExM/YREswlzXkJRNw5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SgI5GEl/; arc=fail smtp.client-ip=52.101.52.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SgI5GEl/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bd8i6OJtnoijAgid2r0T5VdJ80rQd7fs/lwe6PSuVTSGZ4QtCf5aWEvcyM6Opmcc6PABqgDjZ7MVUaANGY3AvtlkK2dHjvNa/etJjAFLlel+K+huVSMLZhw21F6cdwm36uyPsfsAusDWy4BMXAsuR/avDfjXUOBWII2StOmJyFIBWPIhZDiuJTPvF86sihhXi4IUci0CwMBH6r8sDj9E+9ylyUGnaRhgvyz0dBkpmJzSCjfN5FCTgY6D8VM50eINLSALxsVz1G0pIVBsoTgaP3Xx5Ng7xdmH1gEq/SS11aei5cIyDGM9FWmQZXY3bqcCADPEXtsyrKvrx2pNc6JxqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sPQ9Sh8toKD1Ee65E7YmCwWsxolQn1GiBJTt8qZQYE4=;
 b=LwXsXMsUKdNn/Ofj+j6O3Ng078e9Xn1VeXknNuM7FDUkksK9AeG0DTsdQIamgwdI8dDuwAMav+CKa7j7pEmXVgz6KttTKIKqoRDlRYFWI6AUcHg9Nznxgo+gtf+VF6vJKx/HnJ2I0cY/ZMo7dkuT8LURNC1IwP85L+xFlqgRt3kU4RBKkZmuCEYC8yCAOD8ob56z4KY50cWSsHf2VBd2V6bKAuUllBG5YXt4Z0sDBatTchiw+Q/Lt1Aaxqie6yjI1Q242E5yIr5S9+oD9/ci9eqpmPgBxYF92swIMlPkvwZjtW32belyGLH/N6eCKbu8I3/A5jaolwlmTtcgH78NdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sPQ9Sh8toKD1Ee65E7YmCwWsxolQn1GiBJTt8qZQYE4=;
 b=SgI5GEl/7onnUyZX67JXsAjaGTRse6Tb6FNHl5Nn6tv7vZEbNrXLPgksFaRQP1E+BxtNFTZJ6fA/lc9tbsNqjilHdY108rAlW+zwYhlnlV1b02euhQDjSpgselSOBuFiUJ46mxm/3xL8ZuPkUMCRDn5CG+x6Azy3F2U73R/H+SA=
Received: from BN9PR03CA0930.namprd03.prod.outlook.com (2603:10b6:408:107::35)
 by DM3PR12MB9415.namprd12.prod.outlook.com (2603:10b6:8:1ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 21 Oct
 2025 01:43:50 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:408:107:cafe::cb) by BN9PR03CA0930.outlook.office365.com
 (2603:10b6:408:107::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.15 via Frontend Transport; Tue,
 21 Oct 2025 01:43:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Tue, 21 Oct 2025 01:43:50 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Oct
 2025 18:43:44 -0700
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
Subject: [PATCH v4 00/16] iommu/amd: Introduce Nested Translation support
Date: Tue, 21 Oct 2025 01:43:08 +0000
Message-ID: <20251021014324.5837-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|DM3PR12MB9415:EE_
X-MS-Office365-Filtering-Correlation-Id: 1751b333-37bc-421f-405c-08de104348c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xebos0pXhmtVIEtyLNVhaawQI8PygYhcVVf9MeFob6wbuiF9N6AK/OrlQArc?=
 =?us-ascii?Q?PhK/3CfhSHHIaAAtgbU8202Kn/EelIvej5HZCIyb9lQ2hxO7NPLxvMfb7idF?=
 =?us-ascii?Q?V3k0m9iVUab9UbCId6ESzaqbKs/yfQkYEU/s7WDey6Mw3vUvngnfIeMHkXcN?=
 =?us-ascii?Q?6iJZ9uTRbX+fwLjx0IucGzNtALkalbpftuRN4Y9wgfnppSj+CCAt3r6lbkIK?=
 =?us-ascii?Q?SArzx+ZpQLSS//hmzIcc7ZV6SzLNBybDCxixNYmCmfp+R0tClcez+YTeCH4D?=
 =?us-ascii?Q?oB5XKken2zO768U2B11JeVsqCED3QElg0D+LuLPlaqCVNigqOPnZLJpj3HD3?=
 =?us-ascii?Q?MLGuCfEAsMhhvaTu2HS/007ybOcp518IVd8oeATSGo+NrvzzMCEQCxtpGWfy?=
 =?us-ascii?Q?ZhT/S/wA9kCtj8KloVcTub+xy/1HpbQva5NghRqShGnEoA0q8QREoqX7AWYj?=
 =?us-ascii?Q?zZSVl6f44Q26JFfdPPwNim/baz17u8DjYlYXBisr2EfMP0wJT48jilCjHPyB?=
 =?us-ascii?Q?8VIEUZDyimu1iGtVonbSMSCZpIExtTqk2Y1D68ehtwYDTxAYB2dE+zPLmTpK?=
 =?us-ascii?Q?VLK7ZqBsLWDP47xCgDm9NM4vfZC5COa+cJs+m9Y86dkZaPjvpTq1fT4JTtUm?=
 =?us-ascii?Q?HR2Iq5s6LvvekZlk2YSDwXvvQuG/Nngls417dJAR2upUSkCHEXJ0zt9+tCQJ?=
 =?us-ascii?Q?hHXCiyGgI1thnPtAm+ddYiGD+6CsR5/L89CC5SzTwwi5JiG+HlVljaCTbw1Q?=
 =?us-ascii?Q?2puIMpJ5VcvcM9oLprL1ddZgbh4w607MEtIF0yXNT3gSuVe2b1z30praYUjS?=
 =?us-ascii?Q?7LKt9ESDkDAOYiY1FohJwyllZARNpO52lat4l7cOp0in4UrP0OKxFiCpbsTq?=
 =?us-ascii?Q?AwE2aEuEuebtX4OHh/QdvWiHfT871toC6J9C3jX/glJelxfUp28tRgA8Qggd?=
 =?us-ascii?Q?FPdZNBIl6hh1gxHmENTWdwgpbxfLwNZj1+dR7/BncMzgahusmktQI+tsZ7QN?=
 =?us-ascii?Q?BCF5JBc7zP08iLJdYixktKHxNQtjgSf/18OFgD+p9yu8qATb64PpcacTm4eM?=
 =?us-ascii?Q?ICGpLB9/0kHTQ35+PVCahQwqQorF7eu/SzLrPAnIr5691YuV2zXZQWHXdmOB?=
 =?us-ascii?Q?plB2UlgvnsmczqcBLAx/rEUToFBvWiWRcb2mPkhYB2r6IJzLEqiG5uDtEc7i?=
 =?us-ascii?Q?fiibMdLlWzwQdbMZkZOcVDtZwCL00rdAAgKXVi+zdqcMU4En64AzkoXsaLOb?=
 =?us-ascii?Q?4vd4v0xWXKdtOjPqwRqHtaXCIAdDq0WsqRnm6wqpTPoU4DWO7ArFSwztYY12?=
 =?us-ascii?Q?lECF4XucHaDCRQjaTzsL6UHJHA2wsDKM+Lo6YaPwoesX8T3snwtNtH43UIZY?=
 =?us-ascii?Q?hc8L7GfcwoYGbnEss8l/SUTENwO7cZgC0uUCrojHrvjBkx2PTVp4arnkbSin?=
 =?us-ascii?Q?KUDJmhEGcGAVhg6il64y0/iEYpBzXxVGK7tAjqhjJ6ZeqSZRG65z8fu4+cVI?=
 =?us-ascii?Q?P/r7ZhD6220Bco9TabMPQW7iu6bTDfJM+Ju+D1AaiXcRp77AZo8ohSzPeqij?=
 =?us-ascii?Q?MLU3sLvlK7yFC8G4hAMhFLH0kTVXCsGVvpHhcrqP?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 01:43:50.2643
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1751b333-37bc-421f-405c-08de104348c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9415

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
 * Patch 8-16 implement nest-parent and nested domains support
   for IOMMUFD vIOMMU.

Note: This series is rebased on top of:
 * [PATCH v5] iommu/amd: Add support for hw_info for iommu capability query
   https://lore.kernel.org/linux-iommu/20250926141901.511313-1-suravee.suthikulpanit@amd.com/T/#u 

Changes from V3:
(https://lore.kernel.org/linux-iommu/20251009235755.4497-1-suravee.suthikulpanit@amd.com)
 * (New) Patch 11 introduces struct amd_iommu_viommu and amd_iommufd_viommu_init(),
   which contain minimal code to store reference to nest parent domain for
   nested domain attachment. (Per Jason / Nicolin)
 * (New) Patch 13 refactor hDomID-related logic, and invalidate host (S2) page
   table with host domain IDs stored in an xarray. (Per Jason)
 * Patch 15: Clean up logic in set_dte_entry().

Thanks,
Suravee

Suravee Suthikulpanit (16):
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
  iommu/amd: Introduce struct amd_iommu_viommu
  iommu/amd: Add support for nested domain allocation
  iommu/amd: Track host Domain ID mapping for each guest Domain ID
  iommu/amd: Refactor persistent DTE bits programming into
    amd_iommu_make_clear_dte()
  iommu/amd: Refactor logic to program the host page table in DTE
  iommu/amd: Add support for nested domain attach/detach

 drivers/iommu/amd/Makefile          |   2 +-
 drivers/iommu/amd/amd_iommu.h       |  36 +++++
 drivers/iommu/amd/amd_iommu_types.h |  28 +++-
 drivers/iommu/amd/init.c            |   3 +
 drivers/iommu/amd/iommu.c           | 200 ++++++++++++++----------
 drivers/iommu/amd/iommufd.c         |  17 ++
 drivers/iommu/amd/iommufd.h         |   5 +
 drivers/iommu/amd/nested.c          | 233 ++++++++++++++++++++++++++++
 include/uapi/linux/iommufd.h        |  11 ++
 9 files changed, 453 insertions(+), 82 deletions(-)
 create mode 100644 drivers/iommu/amd/nested.c

-- 
2.34.1

