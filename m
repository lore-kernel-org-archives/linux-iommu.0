Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA781ACED7
	for <iommu@lists.linux.dev>; Wed, 20 Aug 2025 11:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755689435; cv=fail; b=PrUXeNwjFa4gIkYrDKhT6s8qKOny9lWAgFnzW9QNdPSRRN3mb3s54sOyO6VKGVJe5m39aWMlkmzikiCN6Cn8tWN2NsME7i9DVG8Ni9etVtRzQ5oUW2sYuKno7PtN5Aciq4Pug4iAjtVSNXtbRhj2ZB9lRacX2WdvlWZ9XufOwoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755689435; c=relaxed/simple;
	bh=AYUBWjJHjvNqYs+FPWLcoB2qT4D2KtNMK8T50xEzJcs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mcD3oTqe8U3RP3Zwo1/JWZx86Ibjh68xnyXk69/s9pf68bMvWULbdPC0OLly3WxfxH6xD4zk0eevMVa8DCEZgWV2HwFYKU68MF0mDRxIbMyD7xTldRX4vev13wYDPZGx4vqLKA4ee0TSRauiNJiS7zR4lfcXkP5EObbNtP7/lnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mWA9I17M; arc=fail smtp.client-ip=40.107.94.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mWA9I17M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GDUJ63f2zdF6hEEoEVSgsoyQaED7ZatF2LwafOEEbPCjjJBFm+NnjCoX3fcPuQC0XW7V/bI0OUJjM/cCkG1XgC7x1V0Lzp9K2QPj3zCnQh+l738V3v+92l9qyHHlOUx1pWBX6Ank/ZNaYZwHk9XXTKcuaa+p7rMGLgwJwPW/29OrePQBOPtbGkDRh5CrHE+RNkG1o0hyeRHl9CZuYpuLcxlMKTY1Jb/BVhdIiWqofTmVfJdrf13/Lqdyfpcxq7OoWpZf3GxbDmJnBP35dsGa41H/rM0bcXbS/gBCO2K/XYoONXvNmy0jpgV6hXMgQh6+HpcSkp7e0bGBDBcxu83xYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZBl6Zc5xt1jRJC+hp3g2Y5/VcYDIGYFme4k0aogrgYE=;
 b=ZsIb838K6hLcQzZ8CBOHPpgZOi7e7mK8jWLS0a05MqJ/zFEDHBtz2Qu7NGpo2jgcWEpAHgjFNxep2TunN3sGdO6QdTx1N2nfcq6Lfovb8xnZfFOJiQwPpNf7uElV4iL7ttErBO8/ldTKGGw1X5zUlhCQIGANDww3xdzAzMoWsqDA8MIEYYJ5ikW26xYvrYLt4uduBsBfmnYHr1lnfs6bJLOwDvd7rcTXrOU2mCKcc26hARcZbYVvE/cLf0usMuRH9PBFIa1gpw1I8GTQQB8R5MnKhwMG1bZdOhN8ug9okOLKEqCTBQUXEW5N8u3eNCnDls+mqxiNEmZ1BdGnF7TbWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBl6Zc5xt1jRJC+hp3g2Y5/VcYDIGYFme4k0aogrgYE=;
 b=mWA9I17MDedoxQt74d7HhTiAeMf4FRciLo4/pu4eWchjOoAj2/Vqp91txlLHzPP5EKKt5lOBR+FbSA707kBsCuj2i8YlBvTOSdgRlgoemNmlNksoRpXKY4b32M+qcQHQC6Cz0vUKoUFE53QG/REAnSZ0isM2yERM7Eygui3ivHE=
Received: from BLAPR03CA0071.namprd03.prod.outlook.com (2603:10b6:208:329::16)
 by IA1PR12MB8190.namprd12.prod.outlook.com (2603:10b6:208:3f2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 11:30:29 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:208:329:cafe::68) by BLAPR03CA0071.outlook.office365.com
 (2603:10b6:208:329::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 11:30:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.0 via Frontend Transport; Wed, 20 Aug 2025 11:30:29 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 06:30:23 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <jgg@nvidia.com>, <nicolinc@nvidia.com>
CC: <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>, <will@kernel.org>,
	<joro@8bytes.org>, <kevin.tian@intel.com>, <jsnitsel@redhat.com>,
	<vasant.hegde@amd.com>, <iommu@lists.linux.dev>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH 0/8] iommu/amd: Introduce Nested Translation support
Date: Wed, 20 Aug 2025 11:30:01 +0000
Message-ID: <20250820113009.5233-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|IA1PR12MB8190:EE_
X-MS-Office365-Filtering-Correlation-Id: df0bf02e-1d3f-49c2-e6d1-08dddfdcf798
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oLLiV0jscklswsqnN5jevxWy90VJ9H05NiTajccBtCCpUBpr0VYFSN1P7Ob2?=
 =?us-ascii?Q?ZqHq0LyKixXchHtDQIOuMI1pyf9jliTVybPNoQibOQ4TcDC/wwib69jlIgIt?=
 =?us-ascii?Q?z8+5Nqe3MraHmuiwuyINgUZ4ElBOHu5uREPbpIap4f0cP9fkMRwyldqaZ32T?=
 =?us-ascii?Q?fIYx+BOhXS+NrxjcKkZ7ENUvzzBcsgbs+ZNeqMsV5QKgoBSNb+2FQ8qnbDGr?=
 =?us-ascii?Q?rGw/c5ND/MDiIHXlSHtYiWOr+g+GE7FxhN7kMCDwEQTu9dd8KO8xXhwb2aJV?=
 =?us-ascii?Q?E45IlUYuQhz9eNMvcL0zqNM2VApNXAm1evxe3I/voGtPG/QK/rI1/LdJklzi?=
 =?us-ascii?Q?8XxP09PIYDQ7QttuI1htZvt5EzoJq1ExOek9vIj+FyVrGd1vpq0NJ4cgHbci?=
 =?us-ascii?Q?62KpC6uDIhOY0tpyDUd1yJhJRcBAig8doqZ5NTHSJ67vGJtGrJEsq+jw1NAG?=
 =?us-ascii?Q?EnIgp6YDhAoBnRcOjGrM5NHhnwDtCEg6NLEGsLUCWqJCm2TvuzWEyuR8oSHD?=
 =?us-ascii?Q?syd6qU9Eulvd+L7kAZNKjSgQWwBj30P8UfK2hpSX5+Ng29Br02uw4yT4If1g?=
 =?us-ascii?Q?/SwXmhgjZAlT7x6Iz5S+NyGAuCwumKveh0i+Rnb4FgIns3J+Ij9VzEtvre88?=
 =?us-ascii?Q?GQz90C7SNFMAA7JIzjqpEseL+FdAOZPjBxkNxfBvHX8V9rUYg36PGxaCMNhp?=
 =?us-ascii?Q?yu2Vw55Y2tf//Si7ouq9pFRDfOrlbQ4mgBIpKLnpgsnATvfmrBW7kzavg3Rh?=
 =?us-ascii?Q?nwQQhzNjtm2vf/vtYorDthSn1GslKV0U3j2O3PwckQF3l5MtFs0tdFix5QkI?=
 =?us-ascii?Q?3ovTXJNK4I72BwhRvJH44SVKrthMqnnGgIKsEoGp10sOkRdojYha3DWkCZc8?=
 =?us-ascii?Q?7QEEiSMpidGEwZY5OTYNKeWqBqwhQnsmXborShKfRVy010ybiNBJVIXjlLfJ?=
 =?us-ascii?Q?FWqcqa3eKdUhRhOeU2zZe1eHanj1YnzZaiL1vcaRUU5+rTOqlaw4F9T/+R4A?=
 =?us-ascii?Q?kEJ+HtWVFAfFQnSteEMlPbs1JsHsws52qpmf3sVZFXhTASIAawFB7SSUygQw?=
 =?us-ascii?Q?ujV7indQVsTJ/QbfH28pNE+TOMO3xa1bEu7J6J6H8TyzdgRuuQOORLEN7nkj?=
 =?us-ascii?Q?3Vp+O6QEjH9+NVoceMb/vJhyqhsVY1864q5ojRbVH9hdNbhdxIoFSQTZqTbm?=
 =?us-ascii?Q?+yLLxbRmOqZMFbYMMVilHaF5aKHjCYyD5Ulaler/V6BqFcNB2EXNd9zUrgwV?=
 =?us-ascii?Q?N447Y0WLt95m0UAul8PXmowrVKgnqwynX47XhPV7gtOZcuai1FhPg0yw5kGD?=
 =?us-ascii?Q?SHXYoKkIB2ANVDjlqDVhIgKgRqjjlEAJCiyA51o9m73JFM0sToGQ44MliXyH?=
 =?us-ascii?Q?639zjOVxlvJ5PYSf+rJ28RiHUdNjuzw1qpcoCkouII+3Cp2MwfyKKIpnuv2z?=
 =?us-ascii?Q?YONRVicbhj+LILvNRKkzbOtLI5Pt13l9Ly4Muoxecm1p0UefIJpZlg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 11:30:29.5826
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df0bf02e-1d3f-49c2-e6d1-08dddfdcf798
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8190

This series introduces support for AMD IOMMU nested page table translation
with the host (v1) and guest (v2) page tables. In this mode, the AMD IOMMU
driver configures the Device Table Entry (DTE) with host page table
root pointer and Guest CR3 (GCR3) root pointer along with other related
paremeters.

The host table is configured by allocating domain with page table type
IOMMU_HWPT_ALLOC_NEST_PARENT. The guest table is configured by the
amd_iommu_domain_alloc_nested() and amd_iommu_nested_attach_device()
using GPA of the GCR3 root pointer and GIOV, GLX, GuestPagingMode
parametetrs from guest.

Thanks,
Suravee

Suravee Suthikulpanit (8):
  iommu/amd: Make amd_iommu_pdom_id_alloc() non-static
  iommu/amd: Making device attach / detach helpers non-static
  iommu/amd: Making amd_iommu_pdev_enable_cap_ats non-static
  iommu/amd: Introduce struct gcr3_tbl_info.giov
  iommufd: Introduce data struct for AMD nested domain allocation
  iommu/amd: Add support for nest parent domain allocation
  iommu/amd: Add support for nested domain allocation
  iommu/amd: Add support for nested domain attach/detach

 drivers/iommu/amd/Makefile          |   2 +-
 drivers/iommu/amd/amd_iommu.h       |   9 ++
 drivers/iommu/amd/amd_iommu_types.h |  12 +++
 drivers/iommu/amd/init.c            |   3 +
 drivers/iommu/amd/iommu.c           | 134 ++++++++++++++++++------
 drivers/iommu/amd/nested.c          | 153 ++++++++++++++++++++++++++++
 include/uapi/linux/iommufd.h        |  11 ++
 7 files changed, 290 insertions(+), 34 deletions(-)
 create mode 100644 drivers/iommu/amd/nested.c

-- 
2.34.1

