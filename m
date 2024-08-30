Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2041.outbound.protection.outlook.com [40.107.96.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC77C1369AE
	for <iommu@lists.linux.dev>; Fri, 30 Aug 2024 16:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725035518; cv=fail; b=XL62f5o5/YrcG9mxZbTe/TRAuZQAHdxjkm3Rkm6gdIO7V3TViNcijgm4aYOMlz2V/er3B57vvdMOllTptYVTQ4obqq35nlYJEWkNfwvu0xSCeTfo0xkUVn+kSl/Zc/7KzcmaJLlr/r4kwDyVyU1uOG7Sj+HMke/gRok3YHJYKAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725035518; c=relaxed/simple;
	bh=+DwX2X/Q6A69cY+GQaFqDWD3pInRIPCvlFc6LfSsjSg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uuPJ4eIKD4Zw2J6dOe+AXOxGmOCzN40LcSnCjZICApbm0AJCnkJ4lEyB3VGwwyNfnzNyXDH/tmNeB2U5MKyGvuKNwqSHOCaNAhpbZ8GEr/GiSO3Fe0EGlxRGhsLTbvxeLNb145vfz4tjeWJgKvE37Xw51ZsSyP//dNdvX2vURG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jhONJ0Nn; arc=fail smtp.client-ip=40.107.96.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jhONJ0Nn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=POHUiw40MvyU7uj781MCO1bJHXjxTG4VpWXqxY/O6KaRzgBYPKhR9veMq/ce2qjuuXd9SdbD1G0sN/msiYk5ROdy2f5HFOrbmFXGBWv9Kxb5HmFJLQRaChCpLiqZ0Vv4kMEc3uobFPw//gG82I0QT+JsBu1kyvH0yYRURbmIZoFR9Get/aMvw+QqEbET7CX2+9P7WaN2+M5y5wQIdkn582nPzt882jrDOccZGQuZ9VjAjHgOg9+kDdwqHGdIK6HqCHAprhziOOr3zU+SWItH5czjKXNdsZz5JT/3+l7AWnUzN5N7pmr4ASeS0ksFK7IzUGjnWatnPkuSPty8UDnKFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Py1JAPE2oUX4cXciZ7KKsCA2fc7nCA389M7aW4LwwX8=;
 b=BZOxjlsGcWmHyXv0YTpkF0VRD27AV2pPEtHCrR0IwS1XQ4PMXD6zMx+E4RLmgweD7J8yDQx4sjk3pj+BoHmFxWI+1MmT2PqLeCnhq9DAdfswZP4MSj6Gtnyde6S153oFjqqjjVUMH11Q3w58aFn5U/wDvaTxRQuIJ6WA1URx0bRxztBSjkIluYpF4vhbqUYJF0spYoMDKNQqKxag/B2liR4ja6IU0tBHb4bOmoBh3p3O+DMY6foHTvp1TqQ8oDmDFh1oHbvFeWpAHXrHq4TvBwZ+KzsDHbEaAJaieFwVHgm5pkm7hldxvT7FJyRxR727UOk5Y1reXudKEs/O96DPDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Py1JAPE2oUX4cXciZ7KKsCA2fc7nCA389M7aW4LwwX8=;
 b=jhONJ0Nncfpdb0OLFdCOtNAUyIEvzSTvVjaYViN5rV962E5RFD7VriJyf+2s14yQTfA3Q0nTUskJ6f+V2VUG9+e3LREfzKbZGpMdz/K2BHs1Zn/+6nYnPvTOLzCQMBvaocfHJ1iT9reWC1eaUdENtQ8q4/zxABZJKA/p4pCdZN8dBxw0zC+XshjCmZKyxjoGc/amIfRUQHMa/Clqvxwe0kAnnn7N3UELBdjQXjnXPDA04oqCO6ya3AOMAeos7+ildjn9qoDKolleNjvHMi/gNYnbpl9JIBtuVw19LlM7bUDPNfMzXqqfJLhIPvo2c66BNRSAA6R6kSv0ySveRgueCQ==
Received: from BL1PR13CA0134.namprd13.prod.outlook.com (2603:10b6:208:2bb::19)
 by BL1PR12MB5970.namprd12.prod.outlook.com (2603:10b6:208:399::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Fri, 30 Aug
 2024 16:31:50 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:208:2bb:cafe::ca) by BL1PR13CA0134.outlook.office365.com
 (2603:10b6:208:2bb::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.21 via Frontend
 Transport; Fri, 30 Aug 2024 16:31:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Fri, 30 Aug 2024 16:31:50 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 30 Aug
 2024 09:31:37 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 30 Aug 2024 09:31:36 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Fri, 30 Aug 2024 09:31:36 -0700
Date: Fri, 30 Aug 2024 09:31:34 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: <catalin.marinas@arm.com>, <kernel-team@android.com>,
	<robin.murphy@arm.com>, <joro@8bytes.org>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v14 00/10] Add Tegra241 (Grace) CMDQV Support (part 1/2)
Message-ID: <ZtHz5r8K0W29+ZQK@Asurada-Nvidia>
References: <cover.1724970714.git.nicolinc@nvidia.com>
 <172502752365.3788306.13276843969148976864.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <172502752365.3788306.13276843969148976864.b4-ty@kernel.org>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|BL1PR12MB5970:EE_
X-MS-Office365-Filtering-Correlation-Id: e4ccc40c-0686-45f2-a603-08dcc9114035
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wob1uu6fh1aLtmTczGW4HOMfEFBnW0xtSSm8r9jEG0smEojTBGANWl/4sheP?=
 =?us-ascii?Q?Ai80IPaYQrPf91yQ6mCNNb77NXFiPxNyESZX4+ZMTNpADSdhHM4VbMrL5mHn?=
 =?us-ascii?Q?FQeAF5kl55eCyDafq1J96KB0vc1WCtxX/DyAPgvTVktxbGKjG9qw7z3rqy+l?=
 =?us-ascii?Q?98hdILD2MuVA9Ajl8Y4DAYWQAnKm6C1VHeFP2UA0RUM654mV2P/ZMj+0LCX/?=
 =?us-ascii?Q?YbOXe5p1HG8NlNqmTu8YyNIkvatf1/s+/Dwr4TSvG6uJjoseZDyYoTsICEuH?=
 =?us-ascii?Q?bONMFkhdzj8twQlCq+TyaUuqp10JWOx095vHqz2AN8DMVXoWsCLeaqmp6w2u?=
 =?us-ascii?Q?os+WmyXgwnXv2l0YwSAcvMaD1ccWLAk9CQPJ+9oyYffxvWUZy/qdGBb1Hueq?=
 =?us-ascii?Q?rUEDNY5bKEdBsvGM96ySoKweMoYCWJ0aJiOHv/WCYqVeIsTkHpONitlvLpeq?=
 =?us-ascii?Q?8I+CI+AS2ausYmt7QjVB9VdGs059bKBPBhXpPG2AtN1Hx3G7ldZFzbrz84cS?=
 =?us-ascii?Q?5REgtLFMBwx3tbjKU5pkDCrw/D+8weQ3sz7PoUoBYntdc1m3PO2BoskEKVuK?=
 =?us-ascii?Q?tUz1PfdFif8HOPDCloCewwA84tE7/sI6IxDStXhhchbgzFv6xXYHaJJMxldK?=
 =?us-ascii?Q?KCn79mTgNo5oEb5coxB/Ltp5sjOwMRgNh3lZr3C6L+VqSDU+rotHtM5JtJNF?=
 =?us-ascii?Q?xuqnBUZ5IYaf5HrVfBf35VqbCbYciXSsFa7eiSAj9gX63LuckQRPgY/sPdXz?=
 =?us-ascii?Q?xojBhCLA3V/JNc2La6cClihaMfmwXRKZWRunnGeyJpAhkyInb6IO8J0zQiJ4?=
 =?us-ascii?Q?PRIlO0L3zIqJ8f5Gq3X+CkdCsNKlx3ucHgPMfGfC3UrGJob0CXuXxdyobJil?=
 =?us-ascii?Q?Hg9c+sZJUeiWJzTkZe7ek5PnWLkm1BqMCoXKpBC57tVS0XQx0bOsMMnXOlry?=
 =?us-ascii?Q?627vK987iDnfJ+0HPMRkATAz59xUJdN12TjDJ21/1CJ/sBcjRCFACtlxHnpG?=
 =?us-ascii?Q?9xDUZXOQL0fwZxzClAJwfnr4F/CVEj6IQJAgQLzeaNcn4+P3kBkL3hEMDxZS?=
 =?us-ascii?Q?G7Z8WpjP/psx8Kioi7dj56EuRNr+CG+iA+42aAXGB8qEeEJsjW3Ez02Uz24N?=
 =?us-ascii?Q?yCBTGWOCzofupacEZ/hTXP8Lrkw10bYK5Ilb3KCGoREaO3xd0dQ/NiuthmVR?=
 =?us-ascii?Q?u9FDn4RAZY98cVK0fdbHjH2aZvzyIQE05loS2RvsZWRObveUhq+eLne4bkwF?=
 =?us-ascii?Q?TIwdIMhk+JpMuMV6oj1vV+o0V1TXMKkT4UXzwFCuGc2xwDJm17u5l5elTEAW?=
 =?us-ascii?Q?nlJGW/m54jzANcMGq1IjeSz5+/LP6moVaqstFWOjmDu2k6t3MciyVoeo3CyO?=
 =?us-ascii?Q?XDPqdTLY6DYNF60QR9Rkr+p0JjAaV10IgNIRBAVkkaAUGDaqWEZoUoO5kGx6?=
 =?us-ascii?Q?+kgyKKqN4jWRHX0kYIbJYd03qDTsMSbe?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 16:31:50.6777
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ccc40c-0686-45f2-a603-08dcc9114035
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5970

On Fri, Aug 30, 2024 at 05:12:12PM +0100, Will Deacon wrote:

> On Thu, 29 Aug 2024 15:34:29 -0700, Nicolin Chen wrote:
> > NVIDIA's Tegra241 (Grace) SoC has a CMDQ-Virtualization (CMDQV) hardware
> > that extends standard ARM SMMUv3 to support multiple command queues with
> > virtualization capabilities. Though this is similar to the ECMDQ in SMMU
> > v3.3, CMDQV provides additional Virtual Interfaces (VINTFs) allowing VMs
> > to have their own VINTFs and Virtual Command Queues (VCMDQs). The VCMDQs
> > can only execute a limited set of commands, mainly invalidation commands
> > when exclusively used by the VMs, compared to the standard SMMUv3 CMDQ.
> >
> > [...]
> 
> Thanks for this, Nicolin! I did drop the 'default' statement in the end,
> as I think it's a bit overkill to fail the probe in that case.
> 
> Applied to will (for-joerg/arm-smmu/updates), thanks!
> 
> [01/10] iommu/arm-smmu-v3: Issue a batch of commands to the same cmdq
>         https://git.kernel.org/will/c/56ae8866f3b4
> [02/10] iommu/arm-smmu-v3: Pass in cmdq pointer to arm_smmu_cmdq_build_sync_cmd
>         https://git.kernel.org/will/c/2ea1f0120f90
> [03/10] iommu/arm-smmu-v3: Pass in cmdq pointer to arm_smmu_cmdq_init
>         https://git.kernel.org/will/c/e736c895c45b
> [04/10] iommu/arm-smmu-v3: Make symbols public for CONFIG_TEGRA241_CMDQV
>         https://git.kernel.org/will/c/a7a08b857a32
> [05/10] iommu/arm-smmu-v3: Add ARM_SMMU_OPT_TEGRA241_CMDQV
>         https://git.kernel.org/will/c/b935a5b1c670
> [06/10] iommu/arm-smmu-v3: Add acpi_smmu_iort_probe_model for impl
>         https://git.kernel.org/will/c/6f3f9ff43d00
> [07/10] iommu/arm-smmu-v3: Add struct arm_smmu_impl_ops
>         https://git.kernel.org/will/c/6de80d619203
> [08/10] iommu/arm-smmu-v3: Add in-kernel support for NVIDIA Tegra241 (Grace) CMDQV
>         https://git.kernel.org/will/c/918eb5c856f6
> [09/10] iommu/arm-smmu-v3: Start a new batch if new command is not supported
>         https://git.kernel.org/will/c/f59e85490712
> [10/10] iommu/tegra241-cmdqv: Limit CMDs for VCMDQs of a guest owned VINTF
>         https://git.kernel.org/will/c/a9d40285bdef
> 
> Cheers,

This makes my day :)

Cheers!
Nicolin
