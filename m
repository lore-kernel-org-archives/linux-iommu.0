Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447F41C9DCB
	for <iommu@lists.linux.dev>; Fri,  1 Nov 2024 16:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730478211; cv=fail; b=IV4s80iOeGhXY7ysRGf04sDu4pR3W1ZxfUeeinC7R3EezBw/LDd2+qmEn851UjpuVQxOm9qw+6bARgry3+SIc9AT0e6Azh9vQuxcaZzBSIgKmlMC8RRcoZ7nJLQrQ5g+KwF9Sx/ojGvtEf/BBqqJMiZZZ+PFasCZgaCp1osepOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730478211; c=relaxed/simple;
	bh=YPz+MTBDHzgiv7ZSQpuY+v2Wvo1+5iP6s9jT1mDeY3k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VlChbtaFgcc7GAOzKlYmAwP5n/l8AOCuHhkcuUbVNX933xA2et5T4wO9tJZktrUggmMXqx6mXr2WSHAYBFtU8epGPlRn42wbQafwv6UgsnpL5JsQwyIIVXQstAbbfL7WhAtcByGXGI3J6cGMlb1TLup2G73i7WKniQgt24vbiPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v9JMkdP3; arc=fail smtp.client-ip=40.107.223.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v9JMkdP3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LN+XGCbUEG0GsI7sxShdIkpyESBmh6tlJmtZgSpqDh/+1K8yDwZf/EJwoIWmNCLL8N+HD7uzggJKQQnbQzFqrVs+b9Gap3rx+Vv+i5DF9DXn0iEDzQsiLVOQ8XiJo9AArYd4dgBxJU6tkYsbVHqsG+y6PffkFoYPa4QE6YXXFAJ27efVyeHeQqe9Y2bDyQLjYxHZ/TKkcLfjbH4DmeLlwiWV9oTLNEjcEtvjXKL0Nc7E87lRMxhLcH0xJxrM8OUTmJjCxnKgj08a4/iNy3dg99tx8y6jEENCEBHwatJJJVTn/ELyAN/hMbUwtTL730OIaJ7/3weQYqnRA7vIfYt6oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q5HjvrWoGbmCds/bd1bpltgRlD7beoEvabwx/7oFf34=;
 b=nKlmObGHw9pUKsAkY/M6ygdZq1kp0ZLwSretgSf4TaqaDwjMqMIsev0i4GsIy8AvE/tmN+3bTyX1CzsfZKHcOxjI8gIduuFPPFrKEMIj76Uhc+91mI7ogf4mnY1tzBAZsExJA2MMhLIkulc0MPLts4WBATJbUFkWUbahXDZX9oaVpolxAIt3K5Pz10N3RX3oFOOPUVCwfYB6OqFl+Yg9FEVKlLe0EU3SPH7l5EQ1XoYCSyEAtrsq/KHw+krS87hfERE/SmiIN/5A1VLBDs/ksHhCNF1I2EBavRtSlXEJeSSiAQN1m3iqmr6VpBzZWi2F1sXHgJToamxYxEru8bCoug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5HjvrWoGbmCds/bd1bpltgRlD7beoEvabwx/7oFf34=;
 b=v9JMkdP31sQO9bITfZlhfDPs3WCSVECFJIAImJ9VjouYZfvNk6b/uYywLyTc0CJLGT4WHzM0X4KRsiAmxII0mWtGnRpPwTNceBaELuThBpzhf91akwyBkI3DUVB90crhJvGBK4Yub68PaFhlfLFx8m4L0irwvJLnv4u3oO7MofA=
Received: from SA0PR11CA0127.namprd11.prod.outlook.com (2603:10b6:806:131::12)
 by MW3PR12MB4474.namprd12.prod.outlook.com (2603:10b6:303:2e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.26; Fri, 1 Nov
 2024 16:23:23 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:131:cafe::74) by SA0PR11CA0127.outlook.office365.com
 (2603:10b6:806:131::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.23 via Frontend
 Transport; Fri, 1 Nov 2024 16:23:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Fri, 1 Nov 2024 16:23:23 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Nov
 2024 11:23:18 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v9 00/10] iommu/amd: Use 128-bit cmpxchg operation to update DTE
Date: Fri, 1 Nov 2024 16:22:54 +0000
Message-ID: <20241101162304.4688-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|MW3PR12MB4474:EE_
X-MS-Office365-Filtering-Correlation-Id: 590dedeb-0877-4add-c8ad-08dcfa9181cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BtFPV/Q8hLdNhGhuP+dFLHhhnlO89Ez/IVOUHvqYeByoPX9HV3/k62BtDeY4?=
 =?us-ascii?Q?J/Zw3C935XpfXZY7eMjyKX8KUr5mxINr3T34rxDSKcukArjs/wJN3QmwJBLh?=
 =?us-ascii?Q?FpMDEeqmvwuOW4zx5VPFe1UWOZduR8e+PPc5F/hnNa8pGNRwT+R6iwNYjWlK?=
 =?us-ascii?Q?c2HfX2lv5AgBYoukxTdP5SQbxGYhuGefpI9wchUejDEHlbC6Z7ku+eZbzNBM?=
 =?us-ascii?Q?ll2CPnUYkbY6ANcdPu7DXwjY2XMWtMLpFxxirhd7JDeIh/sl2Q+HiOAFqemu?=
 =?us-ascii?Q?8nPFAf/2vD5oaK7lSLrWyYwjSAD8CXo/epFEDFmf7/8ekFsMtpnx59/v0mn2?=
 =?us-ascii?Q?tVI688aZLCe0eFo8Qg0RLkHeLN64gTzGfoQooa4hKsDUQBfLkrITm8jXovzX?=
 =?us-ascii?Q?LTFkZVbMPDyvn68lPFnmRquvWWSzTpmWjxG+KMyd5c2rjlS2P0u+JiH05BYZ?=
 =?us-ascii?Q?dK1WSMGAraAkoMkkb2qlSaSg/A4AzaReB44nFoAnpL5ZdLMrUH2gJln9qC9k?=
 =?us-ascii?Q?J8vkdIixzj71hevjch9cEfsvFGmoscPVbH5ConIFPOgr3Y0g1E65pIStfRAp?=
 =?us-ascii?Q?rJX43Ln5dtUHwC+Tlgo3SUYKQKMGL9woHbOmLZyhKTx0dnVu+sZQ6LVs35gZ?=
 =?us-ascii?Q?bd/6YD1/u4tyEOBwCBHwyE3hASOhx3aKIk919mfby8N0Rdk9EvuBscDyVvWi?=
 =?us-ascii?Q?hFVQHimWX4g5fvR859eC3hVOMQn1oWaFEH9sTE55RhhceRbGHhK+cN1Clfa2?=
 =?us-ascii?Q?jIdFczgFBpTuv/w8nuAB2iwSWAVBiZPMeYMYmr6n6lwEq/N3AtlzPB1+6y3C?=
 =?us-ascii?Q?hfcsH8wB/y6LP3cLebIQusJEVAUkc57M5S0u+F1D+jOjRJ7lGdxzTG3EE7RH?=
 =?us-ascii?Q?CN2o2yAx8pbqWQskh7rc+Ha8we9cUw9MmMoSg6B0sGhPEYkBVxUU0ucyuRh9?=
 =?us-ascii?Q?mvEwG+oz2TmjXChGW/WyDHXFX2sOQjhMcjwFZvF3rcPUzGR7CI2QFD9PqDIH?=
 =?us-ascii?Q?Tf1QJLdZYLhWMqLAnZTbUSwBvgW3amfgyIaDtg7Yzjc5kykOKS7pI+EosgPL?=
 =?us-ascii?Q?CILXdioA7Ri2tAOsxZPFn7HvJUZY9K5xiNYhJ5ZzC3vzbglfuI7acZMFHWAq?=
 =?us-ascii?Q?UqAiUNojjyZv95+OqZmbEKqj5izbuGRn093zi0bblJU8l1zycOUIvss+5D+4?=
 =?us-ascii?Q?EiNgGYUoPqu/D4e9wyvS9lWdE+9PvfA44SOR6hYVIiKqM3UK/r6fGh7k2vuP?=
 =?us-ascii?Q?EmX8E+MmGGXi+hykWp4LoLS5zVyDFof8U8VaUC75K0e7+OdWSIS4d4RxZpE6?=
 =?us-ascii?Q?cmmjGmG2d3FyHHy3103DcIMvtg1H+XOiApzfOI1x1goGcsMp4p0LWdXNXDo+?=
 =?us-ascii?Q?Sl8GACMfsrDdiZSIapWqhpW2M+z+JtUYqK9eVQGAKEQ3yHQwPz0DDX2D/osb?=
 =?us-ascii?Q?ydEqi953/Kw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 16:23:23.3779
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 590dedeb-0877-4add-c8ad-08dcfa9181cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4474

This series modifies current implementation to use 128-bit cmpxchg to
update DTE when needed as specified in the AMD I/O Virtualization
Techonology (IOMMU) Specification.

Please note that I have verified with the hardware designer, and they have
confirmed that the IOMMU hardware has always been implemented with 256-bit
read. The next revision of the IOMMU spec will be updated to correctly
describe this part.  Therefore, I have updated the implementation to avoid
unnecessary flushing.

Changes in v9:
* Patch 6: Fix logic error in amd_iommu_get_ivhd_dte_flags()
* Rebased on top of https://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git/log/?h=next

v8: https://lore.kernel.org/lkml/20241031184243.4184-1-suravee.suthikulpanit@amd.com/
v7: https://lore.kernel.org/lkml/20241031091624.4895-1-suravee.suthikulpanit@amd.com/
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
 drivers/iommu/amd/amd_iommu_types.h |  41 ++-
 drivers/iommu/amd/init.c            | 229 +++++++++--------
 drivers/iommu/amd/iommu.c           | 370 ++++++++++++++++++++--------
 include/asm-generic/rwonce.h        |   2 +-
 include/linux/compiler_types.h      |   8 +-
 6 files changed, 440 insertions(+), 214 deletions(-)

-- 
2.34.1

