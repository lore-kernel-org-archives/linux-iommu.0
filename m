Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CFF1C8FBE
	for <iommu@lists.linux.dev>; Tue,  2 Jul 2024 19:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719948250; cv=fail; b=Q16lJQlxit8oRgjUuyhJeLKOtrsrRwH6LZDARRtjJGeMVwN0QOEZz2wfXtC9Ak8u/RCHLaqtHT97RjQ8/QPC4MA+VVmDW1+6JdiZYd3YvKZfjUveSYigxc+TKrBuAmNZvO6DhiIFjqoX5aXG9pmppq+GOwloax545D1t8zdS/s4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719948250; c=relaxed/simple;
	bh=Jyrskk9McyeJwtLTK0aOPjDaZKTDL+hyQEEYXm4239I=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UF1oMwAxpbyc3/MDU4VcsMd4G2cGeE0nDYrFFUC0FS3sN9agVpdshtOyPvRnmzNo/KgSRVDWZkdJxRymiFW6XgVdcyvHgvjb/xmXLJJo0VrL+O3e5UM5h5dzEqB5GdYXdy4dDBUsqlzoOvP1BVGAW2Mp0y7+EkuZKgEH5wZ13TU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GI4zcMNe; arc=fail smtp.client-ip=40.107.223.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GI4zcMNe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQTS60fKDz5ImWnrOwcRz3w8JCJwDFcFC0Jay4N3x4P/mAaqYMP4Pp5h2TukwA0sPFj/NXRrpAUwc8df6jD/aat+qOFpb0zSHmYjkPxW1Qt8UbraHzM7zjs5DFJ9IxRHITdH+oR5Sw3qqxDgzWeq9D9HmlaHjLvDWlK74VtgrkKml8QdEZgTU0aWO6lmAHZnhABYeySFlnQV0bF1C0i9Ql7ODs2n69qswiXwhV85WEUDpsZxLfzkj/OMqusRy+zP1VNfyrBC6z7qPCPmxQJftv2+vXIs/JgvxamwNkY48/dVq2XVxyUpHM89tDAWg2lffE/bfmQ+mpDyJtmuR9Qveg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XTUxS4JfKFwSVQZCg/9M0gsWjutLOVbpgPve8R2UIDE=;
 b=c7RsLhIh4UbTw8fq1nTlkVf5SeKDUxfSn2zpwHOSKhDOdDytPIwYA3tKM6eINUUWrln880qsfp+eZECvRvsgYqrB32Xcn3XKeQ3SfAYrkyVopt8hgy7+lRf+auiKIquoqoxIZUvvfxs2LRYfT8TkAMbnTLBsrWdteQq0t2dmJ3CUKVKPeguC3cVMp64j4oEWJJ5dGRV+aqAPbMdZgZnuvI5xF53sJlII49GTwUAk5rtRXqZ8+oIndcMj/NuB/osVscZDH/5v1MKu1A9B8ujkwbTj4sPnvtCfexL14MQEWrZMMGwz/Qka4+ceiSMi/m3wek9VKFmZy+/XRU/t13ghxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTUxS4JfKFwSVQZCg/9M0gsWjutLOVbpgPve8R2UIDE=;
 b=GI4zcMNec4xkBeEhwOLdSqbrwQnsQXFvebA25i80QfdN8lB7pzVRZ3uW/movMpg5mCrG6ijhRIOTJB2d1m85k2KthttPhSwuzrBhhH4aY3e4dBuvRmvHd9RjnAwIVwpR1tkQRHd5q/hB3rKTwpFMfNWGdNQyo5099ArAUEyXLJLCONDQhhq21SHZqX9/EskG/Wcm5ofNFN34VBHoBFTdgJTHABJdRmtWKIOGN2s0Z1lnTLfbKMy+tsBUVujHJ2nQbnMPN2FBQ0dRaBgHjjZqgWXwB+AGeqbSefD/ftknvEVMpDz4nhN0jSbYLvNsyDgR9CVd7cg4FV/S5l+TSZpQzA==
Received: from SJ0PR03CA0007.namprd03.prod.outlook.com (2603:10b6:a03:33a::12)
 by IA1PR12MB6387.namprd12.prod.outlook.com (2603:10b6:208:389::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Tue, 2 Jul
 2024 19:23:58 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::bb) by SJ0PR03CA0007.outlook.office365.com
 (2603:10b6:a03:33a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23 via Frontend
 Transport; Tue, 2 Jul 2024 19:23:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.18 via Frontend Transport; Tue, 2 Jul 2024 19:23:58 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 2 Jul 2024
 12:23:40 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 2 Jul 2024 12:23:39 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 2 Jul 2024 12:23:38 -0700
Date: Tue, 2 Jul 2024 12:23:37 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v9 5/6] iommu/arm-smmu-v3: Add in-kernel support for
 NVIDIA Tegra241 (Grace) CMDQV
Message-ID: <ZoRTuaxDQVlbmbTN@Asurada-Nvidia>
References: <cover.1718228494.git.nicolinc@nvidia.com>
 <d74b091a1216421ab8431f4c684242cd70ef0b77.1718228494.git.nicolinc@nvidia.com>
 <20240702174152.GA4740@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240702174152.GA4740@willie-the-truck>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|IA1PR12MB6387:EE_
X-MS-Office365-Filtering-Correlation-Id: ad978033-0a37-4ac8-0b67-08dc9acc8599
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mmXBPlWVf0LpwvuoA3BDfYb61VudhzOxjLbW48rvaRGboNXZQXgt6Dxdut1G?=
 =?us-ascii?Q?yMpOo845Hf6EPiFR0x+AwS+VdgUU3JZ2Wcr9PCY6s0Q4TXm2VcOAaLQbDCcQ?=
 =?us-ascii?Q?mwBJ3Rwk0pP1fFAdA9k2IxY4isPIKscJFjbVNrGvI8pxT0P2qvAKyRwemXKc?=
 =?us-ascii?Q?E47QaxmqzVxuVfclRANmCkXyDfmOvy7WU2OsdUHHnmU0Ia/C3DCt8A5frBK6?=
 =?us-ascii?Q?XzMt/NxqHUeZ40NajeivfjV7pTfhB8nb41kVXA7+Wd6gMfv7I6gL2am+BgsP?=
 =?us-ascii?Q?iN+benrb4ECRZGePj2e4M5DenDXAlNUiMD4NrDPvSEixmWJ5uHybFbWekd7E?=
 =?us-ascii?Q?qI9nVuQypwh6KFyQpOdS151G2U86ZmXJ3CkDPgTklyExEtaHva37puCLexRa?=
 =?us-ascii?Q?IhP+WKdGXA9fLFYVynJOloglFC0KgPo8FCw2TPdwZSnc03kpCemkX1hYfSGo?=
 =?us-ascii?Q?ZSXVIV7wAGTXlXU12LFBF2ukYwrNCgV0eyrWfl9QeibhArfgC2XW0u3VqanI?=
 =?us-ascii?Q?ZVkHpT/7kxMKCNkVCgC1E+dxYwxNJROJuIGSqHlD5Zkzl2N6fTH8jIx8Az/t?=
 =?us-ascii?Q?GnlZH7xHleJbb40HTHmK7LrE4Bt3xCpurWWPzt4/xnVZoO7L1s04qvXNcVf1?=
 =?us-ascii?Q?k9vYW9W/ghJgij9Uih06bPgA4uTGWsF/aQtKANZDhwiEHk1x0BILfoB/3s5m?=
 =?us-ascii?Q?EjBSx15KqjdUYu7CX+xkyUA7S+Hwtasjgertq3uA9gjOJnsdyTwyGNkAVyTg?=
 =?us-ascii?Q?OfQyjN0fpBhg677b22keAbUS3AEoqga5WDn9G0pob6fGHDGHNPIVpiTi5fHv?=
 =?us-ascii?Q?O9aoz50zbU7ciu6ryIb24Ad+xKbyV0VIsdZje0e2p5dcJuiDxzF5BOz5vxzc?=
 =?us-ascii?Q?uHTyWZYAWIeJbr0Z5n5gC9ybZSN4oMNINLOmYaSduuXzIEizWkhZ+ubhuhDs?=
 =?us-ascii?Q?P/6w9+pX2h/VyxB9CvjCiaxdRzd50a70C1tytE3k+5RMK8Lcuqkc3Q/v4GFa?=
 =?us-ascii?Q?5NTGICUWn64asrH7GvVoww1hTDkBRUY/+gQ6ys5HZQ/Gxo6iDcSygwg4HwCz?=
 =?us-ascii?Q?W8XaWVC8LlELmiEzcwUDUjlGuWTym5l3rVWszdfGrPD1XOVupMVNzLcvaGyW?=
 =?us-ascii?Q?eTdIW1vrRcmvsXHDfGy9SkByv95Aqp8cZ/XkW2ipivNVqFkaUKxL9vvgF7vi?=
 =?us-ascii?Q?qtMf5NNeMC/r0TU2IofD+fusH2Wb7yu6lbxZbuKGLYhgL01bWcOZIvqQXub/?=
 =?us-ascii?Q?8FD2q+uap7lLy3zSJGJg2ui5eLE0c2Nen43jQImV+EZJOCbiPhGDsalEpyuw?=
 =?us-ascii?Q?/x37q30Kr8/gS90FCk3MDIvsXDc9EV0i5coH5Ey2NsiZ4XaMfINzn40jBQWi?=
 =?us-ascii?Q?2A3WKUFAV1J29BVKDU+2E3lXfsER0NkyLnqYuNyzYD6RN4BIBVrjvlYt/Cn8?=
 =?us-ascii?Q?Tn0XJzNgIf2OSDIQ5gKeCsFo21/j+8No?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 19:23:58.5017
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad978033-0a37-4ac8-0b67-08dc9acc8599
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6387

Hi Will,

On Tue, Jul 02, 2024 at 06:41:53PM +0100, Will Deacon wrote:
> On Wed, Jun 12, 2024 at 02:45:32PM -0700, Nicolin Chen wrote:
> > From: Nate Watterson <nwatterson@nvidia.com>
> >
> > NVIDIA's Tegra241 Soc has a CMDQ-Virtualization (CMDQV) hardware, extending
> > the standard ARM SMMU v3 IP to support multiple VCMDQs with virtualization
> > capabilities. In terms of command queue, they are very like a standard SMMU
> > CMDQ (or ECMDQs), but only support CS_NONE in the CS field of CMD_SYNC.
> >
> > Add a new tegra241-cmdqv driver, and insert its structure pointer into the
> > existing arm_smmu_device, and then add related function calls in the SMMUv3
> > driver to interact with the CMDQV driver.
> >
> > In the CMDQV driver, add a minimal part for the in-kernel support: reserve
> > VINTF0 for in-kernel use, and assign some of the VCMDQs to the VINTF0, and
> > select one VCMDQ based on the current CPU ID to execute supported commands.
> > This multi-queue design for in-kernel use gives some limited improvements:
> > up to 20% reduction of invalidation time was measured by a multi-threaded
> > DMA unmap benchmark, compared to a single queue.
> >
> > The other part of the CMDQV driver will be user-space support that gives a
> > hypervisor running on the host OS to talk to the driver for virtualization
> > use cases, allowing VMs to use VCMDQs without trappings, i.e. no VM Exits.
> > This is designed based on IOMMUFD, and its RFC series is also under review.
> > It will provide a guest OS a bigger improvement: 70% to 90% reductions of
> > TLB invalidation time were measured by DMA unmap tests running in a guest,
> > compared to nested SMMU CMDQ (with trappings).
> >
> > However, it is very important for this in-kernel support to get merged and
> > installed to VMs running on Grace-powered servers as soon as possible. So,
> > later those servers would only need to upgrade their host kernels for the
> > user-space support.
> 
> ^^^ This is a weird paragraph to put in the commit message.

Ah, I could drop that if you prefer. We already highlight it in
the cover-letter anyway :)

> > As the initial version, the CMDQV driver only supports ACPI configurations.
> >
> > Signed-off-by: Nate Watterson <nwatterson@nvidia.com>
> > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > ---
> >  MAINTAINERS                                   |   1 +
> >  drivers/iommu/Kconfig                         |  11 +
> >  drivers/iommu/arm/arm-smmu-v3/Makefile        |   1 +
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  52 +-
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  50 ++
> >  .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 842 ++++++++++++++++++
> >  6 files changed, 945 insertions(+), 12 deletions(-)
> >  create mode 100644 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index aacccb376c28..ecf7af1b2df8 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -22078,6 +22078,7 @@ M:    Thierry Reding <thierry.reding@gmail.com>
> >  R:   Krishna Reddy <vdumpa@nvidia.com>
> >  L:   linux-tegra@vger.kernel.org
> >  S:   Supported
> > +F:   drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> >  F:   drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
> >  F:   drivers/iommu/tegra*
> >
> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > index c04584be3089..e009387d3cba 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -423,6 +423,17 @@ config ARM_SMMU_V3_KUNIT_TEST
> >         Enable this option to unit-test arm-smmu-v3 driver functions.
> >
> >         If unsure, say N.
> > +
> > +config TEGRA241_CMDQV
> > +     bool "NVIDIA Tegra241 CMDQ-V extension support for ARM SMMUv3"
> > +     depends on ACPI
> > +     help
> > +       Support for NVIDIA CMDQ-Virtualization extension for ARM SMMUv3. The
> > +       CMDQ-V extension is similar to v3.3 ECMDQ for multi command queues
> > +       support, except with virtualization capabilities.
> > +
> > +       Say Y here if your system is NVIDIA Tegra241 (Grace) or it has the same
> > +       CMDQ-V extension.
> >  endif
> >
> >  config S390_IOMMU
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/Makefile b/drivers/iommu/arm/arm-smmu-v3/Makefile
> > index 014a997753a8..55201fdd7007 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/Makefile
> > +++ b/drivers/iommu/arm/arm-smmu-v3/Makefile
> > @@ -2,6 +2,7 @@
> >  obj-$(CONFIG_ARM_SMMU_V3) += arm_smmu_v3.o
> >  arm_smmu_v3-objs-y += arm-smmu-v3.o
> >  arm_smmu_v3-objs-$(CONFIG_ARM_SMMU_V3_SVA) += arm-smmu-v3-sva.o
> > +arm_smmu_v3-objs-$(CONFIG_TEGRA241_CMDQV) += tegra241-cmdqv.o
> >  arm_smmu_v3-objs := $(arm_smmu_v3-objs-y)
> >
> >  obj-$(CONFIG_ARM_SMMU_V3_KUNIT_TEST) += arm-smmu-v3-test.o
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index ba0e24d5ffbf..430e84fe3679 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -334,6 +334,9 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
> >
> >  static struct arm_smmu_cmdq *arm_smmu_get_cmdq(struct arm_smmu_device *smmu)
> >  {
> > +     if (arm_smmu_has_tegra241_cmdqv(smmu))
> > +             return tegra241_cmdqv_get_cmdq(smmu);
> > +
> >       return &smmu->cmdq;
> 
> Hardcoding all these tegra-specific checks in the core driver is pretty
> horrible :/
> 
> Instead, please can we do something similar to the SMMUv2 driver? That
> is, tweak the probe routine to call something akin to the
> arm_smmu_impl_init() function, which looks at the 'model' field pulled
> out of the IORT and can then dispatch directly to a tegra-specific init
> function (see, e.g. nvidia_smmu_impl_init() for SMMUv2).

Unfortunately, this isn't like the SMMUv2: the whole CMDQV thing
is not really a 'model', as ARM suggested us from the beginning
not to use the 'model' field but to treat it as an extension via
DSDT v.s. IORT. So, there is unlikely a way to avoid some level
of hardcoding to check "cmdqv" in the SMMUv3 driver, since CMDQV
HW info sits outside the IORT, while still requiring everything
in the SMMUv3.

FWIW, we had the following piece in our earlier version (nearly
three years ago), which looked equally "horrible" IMHO:

 struct arm_smmu_device *arm_smmu_v3_impl_init(struct arm_smmu_device *smmu)
 {
+	/*
+	 * Nvidia implementation supports ACPI only, so calling its init()
+	 * unconditionally to walk through ACPI tables to probe the device.
+	 * It will keep the smmu pointer intact, if it fails.
+	*/
+	smmu = nvidia_smmu_v3_impl_init(smmu);

And the current extension design is a preferable way, suggested
by Jason at that time during our internal reviews against this
impl design above. I am leaving some of his remarks, just FYI:

-------------------------------------------------------------------
Do not create a huge complicated artifice that could have been
done with a few simple ifs. An ill defined abstraction is not more
maintainable just because it has function pointers.
-------------------------------------------------------------------

> From there, you can both install function pointers into the
> 'arm_smmu_device' structure which can be used instead of having the the
> 'if (tegra)' checks in the main driver and you can also re-allocate the
> structu to live inside a private structure instead of having the
> backpointer.
> 
> Maybe those cmdq function pointers would be happy for other extensions
> too (e.g. the ECMDQ stuff at [1]).
> 
> Will
> 
> [1] https://lore.kernel.org/r/20240425144152.52352-3-tanmay@marvell.com

We have studied the ECMDQ patches too. It simply needs something
similar in the arm_smmu_get_cmdq(), as we did in our design.

Worth mentioning that the whole preempt_disable thing is unlikely
required any more after the patch in this series:
[PATCH v9 2/6] iommu/arm-smmu-v3: Issue a batch of commands to the same cmdq

Thanks
Nicolin
