Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2066.outbound.protection.outlook.com [40.107.96.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D86154C09
	for <iommu@lists.linux.dev>; Thu, 31 Oct 2024 09:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730366207; cv=fail; b=Lx+UfZvpAtPmDUtE4tCpPRXAYy86ARPEeITDX96XSoLwhocyNjW4Kuj9inrwN1RDrrfZHaf1wGYsF08LD9LK10cVhovA4PWgFH7VSpm0oZ0MO1YCfL98y2Xm6I2Ox1Va87kh51aoais11stRP/Azid9nWJ9ce/u5R/y+RaNGEyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730366207; c=relaxed/simple;
	bh=yV+ZBja/BS0A4/mBU/QLmJHmRknoiJW0DV5e+gYLpOE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KqMcCUhpCeE1CAf5ra71B5Cr7k62PIf4NZIkXtnZPVY8AX+UisnsPjVyFTnpyp/RKvKnCdZoVlXol0BqQQFfIkeg1syjzVZvcIpwWt3nSE1m0devxnQQsLSE46SR+92iKJ/tP3mV3FHtchLwF0PlQ3fA0DZI2WSTfVehYr240DA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kc2A52+7; arc=fail smtp.client-ip=40.107.96.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kc2A52+7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SjSWx8C0gJvGDlNow15F0VmN8sXg072HHMe8uLs0BWLSDVPXWpoGdjG2fVZy463DW6XZFma7BowCnoA7xUIXxqQmZ38HyD0eKZ14Tn8gJK5BVEwySILbvL12SLKabf3yy3og9p7TiWHHGw+HQNBdRxhUdjT+zTKNle2IltR451CXT/m17srnpuQAHCwmKAJIkOTCXMdTlK3W+rOL1agoliDsBZk+YfBANIpYXVxmLOLrXwUiPGS7vv0I5S1QG+6k2vMywmBZg09kKvA7sRDXl86/vcNKLeBFD03NypdIqF3jtvHA3MhmdzqyYMi6LCpU0jqVxjUuC+KhjHeB+wCK3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4CxbGhuDLHxEL6AfsdEstNVfjyUyBWx6Frt97jC9DQ=;
 b=XnIUUrBBJcesbfK9uFTVrwPQx5Wkt52s1T1rW2BBWwOz9Mk0+yMrudSGf2nOvj02J+s9jspuqo6LLal0TSmw2FkzskiwwxbvAbGUoPjw70tTiknTvutV5JYAI6HFHLfedjx1JK6gB5oZz/LMsGf+SMs+BvKWRXanr+dZQKPaUrxbB5WHixudkf4vRqqnC4QnrHxuRrr/X6OOtwp6CdNNrSROknlyiW3VKIzS9qHYDSjk06o25ZxF/KdN1WSVHRsp5zNjjMrfwQLQ+nN7A6FBHSOm7+/B7uFpu70FcLAITaxRrq0L9HEbb4q32EOTYKoCCausBjb7GW72O+758Yrvug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4CxbGhuDLHxEL6AfsdEstNVfjyUyBWx6Frt97jC9DQ=;
 b=kc2A52+78Xm/U/vlm2CK0y96X+i8Obg5E88NP2aboo3V3gZCJyouhCTZcTHe51FpmaFErYgvnxeQWEIObZ1wiPmhHTqvsGO/ShH0160B1pCj1YyD42u3+3CER73tHj3aZcce8Cu+2dTIXAw4GsPOZ9Oyj3mYnBB/hHTlH/l0hcQ=
Received: from BY3PR05CA0014.namprd05.prod.outlook.com (2603:10b6:a03:254::19)
 by MW3PR12MB4489.namprd12.prod.outlook.com (2603:10b6:303:5e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 09:16:42 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::af) by BY3PR05CA0014.outlook.office365.com
 (2603:10b6:a03:254::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.7 via Frontend
 Transport; Thu, 31 Oct 2024 09:16:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 09:16:42 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 31 Oct
 2024 04:16:38 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v7 00/10] iommu/amd: Use 128-bit cmpxchg operation to update DTE
Date: Thu, 31 Oct 2024 09:16:14 +0000
Message-ID: <20241031091624.4895-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|MW3PR12MB4489:EE_
X-MS-Office365-Filtering-Correlation-Id: 218ef602-77ff-4b66-4eda-08dcf98cbc11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MXjf6VHY2sTnc6E/mrncekcEG2Bzb+5wAj90hXvsEkd7P4VhD0pNW2r7Ce+e?=
 =?us-ascii?Q?2SIBFRGEn2kNv6omtbmXt1KpdRobvS3P2yHU0rbHh+DbJybu8SX37rm4fYhd?=
 =?us-ascii?Q?cl25H9urPnviA51qUL6ckd0H5MufrQrywgoKYdVCqpzKVbpo7LOo9ZRwns85?=
 =?us-ascii?Q?eBc+aEQ+LkN2ffn0gSodlyKD88dVrKC1dZPcnmK8mYjBZJE3EqE7+qM4by5i?=
 =?us-ascii?Q?Qw/QmunLVVt0BFU17v7B+tHP+N8j1qeJKZvElxc91CCquZxuKG5fLg1INnui?=
 =?us-ascii?Q?JgycvLieL43qAoZg1KnGU5OEYDu/mk35LVKzdNFgZIhGfCvi7tvRq3821pj8?=
 =?us-ascii?Q?ERYZPOaKGuL3U83wMY5iRtA0ypce6NIJm8t2YsUXdvaH+bN3dVHjPN/LKSkh?=
 =?us-ascii?Q?hSrn2M+OAB+KU+D/hEteejoYRPDnT2YNUEB1qXSz6gitRNVBhkL7aT7bn6sQ?=
 =?us-ascii?Q?9OV0ynA0QZTUNFK4CwwRQyvtyb9FDVi5o465U6Vs49BHVktxiErXKQU3F/J7?=
 =?us-ascii?Q?zGRfXbxSw4OMNj9lSZ+Rj4uXhQcpPqzqrrKp7APPFaW5RfgERYUyn0zgEhKX?=
 =?us-ascii?Q?9hlE7IHsfhAn9n8+R+/B1cRIaKSckjzhcN/xqY8WgaI3YSkOGFoQuGfo/jdE?=
 =?us-ascii?Q?zyrGRhqyoQo3NAwuHilPfVYQVKWpwTLwLyudvw8r89XTXuPPEmIw7NJ+nmFI?=
 =?us-ascii?Q?kPTvXhFQmqWuHPIbW7fLNH5kr4qiR1j2iPYhqZDghbmzsmpIzbo/DAXKnu7l?=
 =?us-ascii?Q?LV+qDLMDKnQJsk0Pe4KXXpxqxehyJTydRoxLeJzF7h/RG9DgE2LDTmuM50b4?=
 =?us-ascii?Q?TSwrrqr/UH74VEK9uGSGq5OmEVT6wrG4Nmn+F+YmtAQAoxWKbeOUbVKiPsJW?=
 =?us-ascii?Q?IujFn8TjSkwArqwl0AC0tdnSe7TNgG7qxF6RBksCUOutDZdgZ3W1n/875bxN?=
 =?us-ascii?Q?F0Ulej/DRfH80BEFeC9KeAVL+Wcng0Dg+/MpWLVEdSpcmlNsPzmr4Gd5EZ6M?=
 =?us-ascii?Q?JpR6URtZLfon3OejXrznqBtWgs6qKqw1T1TgxT+KgBQyslvbFSK+aWFbsL+S?=
 =?us-ascii?Q?SIKfCj/bz8Q2Wx56peCjEUxa850lrAZ7cZlowMsegQqSd+fpOIiEKjq99ieQ?=
 =?us-ascii?Q?Orh0GQcQ3Xfa1Z+AZxhVktx+c93OVWyGE8AF1ZV/9cQBqDjofJp0wM/iH19l?=
 =?us-ascii?Q?Q9RfKWkRTda6TuyweJ0e1NVGUGLVIFxOEWBD5iI4nZpkLWiJeraB4Odaww7p?=
 =?us-ascii?Q?i2nQyX9zv1uwHnFnZzrMSSwomZHinupDAe6WD+4wdy+9JqTr9UWkHp1x7/f0?=
 =?us-ascii?Q?olwCy+I+jj7QoNmVaQ6Kx02KUh/7PtBcN67m/HPe7UWF4VxBdzoGKQymFQRb?=
 =?us-ascii?Q?yykaKoEEAJAVJYhvZiLjK/PILOF6XP04yQlN14ylYDDZlkdIEf6m1RFl89l1?=
 =?us-ascii?Q?tiUIzSb4Gfo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 09:16:42.4037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 218ef602-77ff-4b66-4eda-08dcf98cbc11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4489

This series modifies current implementation to use 128-bit cmpxchg to
update DTE when needed as specified in the AMD I/O Virtualization
Techonology (IOMMU) Specification.

Please note that I have verified with the hardware designer, and they have
confirmed that the IOMMU hardware has always been implemented with 256-bit
read. The next revision of the IOMMU spec will be updated to correctly
describe this part.  Therefore, I have updated the implementation to avoid
unnecessary flushing.

Changes in v7:

* Patch 1: Newly added

* Patch 4: Newly added
  Replace struct dev_data.initial_dte with global amd_ivhd_dev_flags_list
  to store persistent DTE fields for devices. The previous design has a major
  drawbacks where it needs to allocate the struct dev_data unnecessarily for
  non-existing devices to store initial DTE values.

* Patch 6: Clean up per Jason

* Patch 10: Newly added

v6: https://lore.kernel.org/lkml/20241016051756.4317-1-suravee.suthikulpanit@amd.com/ 
v5: https://lore.kernel.org/lkml/20241007041353.4756-1-suravee.suthikulpanit@amd.com/
v4: https://lore.kernel.org/lkml/20240916171805.324292-1-suravee.suthikulpanit@amd.com/
v3: https://lore.kernel.org/lkml/20240906121308.5013-1-suravee.suthikulpanit@amd.com/
v2: https://lore.kernel.org/lkml/20240829180726.5022-1-suravee.suthikulpanit@amd.com/
v1: https://lore.kernel.org/lkml/20240819161839.4657-1-suravee.suthikulpanit@amd.com/

Thanks,
Suravee

Suravee Suthikulpanit (9):
  iommu/amd: Misc ACPI IVRS debug info clean up
  iommu/amd: Disable AMD IOMMU if CMPXCHG16B feature is not supported
  iommu/amd: Introduce struct ivhd_dte_flags to store persistent DTE
    flags
  iommu/amd: Introduce helper function to update 256-bit DTE
  iommu/amd: Modify set_dte_entry() to use 256-bit DTE helpers
  iommu/amd: Introduce helper function get_dte256()
  iommu/amd: Modify clear_dte_entry() to avoid in-place update
  iommu/amd: Lock DTE before updating the entry with WRITE_ONCE()
  iommu/amd: Remove amd_iommu_apply_erratum_63()

Uros Bizjak (1):
  asm/rwonce: Introduce [READ|WRITE]_ONCE() support for __int128

 drivers/iommu/amd/amd_iommu.h       |   4 +-
 drivers/iommu/amd/amd_iommu_types.h |  40 ++-
 drivers/iommu/amd/init.c            | 224 +++++++++--------
 drivers/iommu/amd/iommu.c           | 370 ++++++++++++++++++++--------
 include/asm-generic/rwonce.h        |   2 +-
 include/linux/compiler_types.h      |   8 +-
 6 files changed, 434 insertions(+), 214 deletions(-)

-- 
2.34.1

