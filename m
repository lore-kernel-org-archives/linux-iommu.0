Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721FA812
	for <iommu@lists.linux.dev>; Wed, 15 May 2024 01:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715736031; cv=fail; b=YwfOQnIFd/YKnWYtam4fSmKqJ+9Ja4PYoU9frBdLKv0LgIfpRK6YJowXMfT5CuHN9FbsCSlizbqzYwIiUAdyRGnPvg9Yd9N+wqFxAqdJkkTaoYf5v6II2rfB0KpeFYjaKfmQmovABeGV3h9bayLibrHK+oRxUy86ppLi3xBUd1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715736031; c=relaxed/simple;
	bh=TSqcDCEAYLHgUg5zIEM18n32l4x43YMcMrFJZBeind4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4/mH4HcoSOHG9HeUi1yzyHCQbneD+DQimeD2l79rKRvgq3GzAIESmrdb0RL5rboEJjvjkGWdXVlzeX0cULImOo1Zlnx0A+kZ1opxf68L/hPDqqMeX2iCDi8mhUQ96Wvz7Rj5Awm6KXUqmMLyxRhvIQojgZECKw18mzTl89d6l0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OGwWqRvF; arc=fail smtp.client-ip=40.107.220.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OGwWqRvF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RB6oHXoM2g/NmOXQ7LL0ZLhP4+7K4Mjj2ELRBw5dAULoVQL2l7+tua9TV9H2heuBNblRyQWyR0ZehwLuSzvbN6ZtHeT4D2JIAHaY9v76/3s8I4RQaGVyAFr6gbKmNbwOMNnPbREmRI1B6lq19+G1jHsvvkEpU9YalobzC7OPQhxJ7d+eP7N1CZ87/cDLqLRWQ5nQJzh3DSPP40jirhYrt/wM+y/CzZ6pIMa1ZtY7984H74kusYdsXJyPtRXlaQD98KZRI5EqZA6evcj33hxRR2pb6PCFkedNS3wQ51MPac4mlJp+Kx2G6J9oXaPs3tiOr49LpMoAg1pPq1pMLmOeKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UOsI/ihgGxrGbRTD8SEjC00omYfmW8VZETVBM24GTEA=;
 b=MUvNNUkZul/refZF0k/DwNhW7gHYjQg9cR4QCOfXSieV5Re5xdsf/fkGemOMS94dzswcCz0spljCQjRqEN4gIETrKoYORWbaynwQGlLnuAaGCnDXUmJJaQX8Sy1i/X1adQDsyOXipTYkKBluMHCQsoUJRFpM6u1BAowi2jZsVawPjfWQXBsdk9JMbKVxISq5w8vedwAGfTiUUc19EaZFxDEheWqA/REwztJUNYu6cJncNhOASVU0+WRvgILj+X6IzZ6XcHqCLAFc4gRS7xKRIX+D3JGqaXhjIsYNTcMTxq8Wa6gVgfvQCBBn71qWtspFlGom7GkgpC0gEREzXlJ9Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOsI/ihgGxrGbRTD8SEjC00omYfmW8VZETVBM24GTEA=;
 b=OGwWqRvFaDdHik69MYiHmMYSAihBD1XDYEFWEd9TEaFKfk6IvIqsok+WiGtV6TeHHnwuBORYTlOEh2DtM9eEfVwy0SgjEiplte21EIYlSMlZhAYNxMh7VJOsIPBbaTG3eeIlKvfq5LIfk+ue5v/ui35AUaybj2HZhrXHfsCFqX1rNDv0Wjz8THw3CR8sDvVpYiUSR7p/L86VedzJcNTSDc4d4hJRzFaOtfUDIt8ctRVOEskRPmz7xbAWE4czCxQNxVj72Wis6rLFANTWLJ9wO6iGcRBVOBSWosbW+UZbks+PO6/frIiw2LcNr/Ny4Hd/uTGYIf5Z2oVXDztK6euLRw==
Received: from BN0PR04CA0106.namprd04.prod.outlook.com (2603:10b6:408:ec::21)
 by LV3PR12MB9439.namprd12.prod.outlook.com (2603:10b6:408:20e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 01:20:23 +0000
Received: from BN1PEPF00004683.namprd03.prod.outlook.com
 (2603:10b6:408:ec:cafe::e) by BN0PR04CA0106.outlook.office365.com
 (2603:10b6:408:ec::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.25 via Frontend
 Transport; Wed, 15 May 2024 01:20:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF00004683.mail.protection.outlook.com (10.167.243.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.21 via Frontend Transport; Wed, 15 May 2024 01:20:23 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 14 May
 2024 18:20:12 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 14 May 2024 18:20:12 -0700
Received: from nvidia.com (10.127.8.11) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 14 May 2024 18:20:07 -0700
Date: Tue, 14 May 2024 18:20:06 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <kevin.tian@intel.com>,
	<suravee.suthikulpanit@amd.com>, <joro@8bytes.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<yi.l.liu@intel.com>, <eric.auger@redhat.com>, <vasant.hegde@amd.com>,
	<jon.grimm@amd.com>, <santosh.shukla@amd.com>, <Dhaval.Giani@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH RFCv1 05/14] iommufd: Add IOMMUFD_OBJ_VIOMMU and
 IOMMUFD_CMD_VIOMMU_ALLOC
Message-ID: <ZkQNxkYv23z7i6e0@nvidia.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <3aa9bc1df6a2ee58a03c6ea6ededbc210a2d23a8.1712978212.git.nicolinc@nvidia.com>
 <ZkDR4Rp57cy9qSqP@nvidia.com>
 <ZkGYN36N7sh2vUmv@nvidia.com>
 <ZkOFkfHhG2h2fv/c@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZkOFkfHhG2h2fv/c@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004683:EE_|LV3PR12MB9439:EE_
X-MS-Office365-Filtering-Correlation-Id: 859b7dd6-078a-4930-8b71-08dc747d31cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|376005|1800799015|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LCCYxgg6ACJ7hLMuLHN2ZVm630wE1sNsEGF9CVZvEbnKDDmabMaKofiQSsK4?=
 =?us-ascii?Q?A6s1k2Xgfyody3ERvzCBAQoQGnUelNSkMo/Q0gS1w5HSMHDCIiOtUPCTyHYu?=
 =?us-ascii?Q?5bs5zbW7iPiW+2Y3q8VqOmt9S0mc2uiZFS6TS8UtHzPmyP4d6mWADJXj9j0d?=
 =?us-ascii?Q?Q4QUtOOeBqH/G/LZrmlHBuXJBlGxRc+rX7BZcF6/kVkngPQ/06/WFFmKIQFT?=
 =?us-ascii?Q?A055LX0N99YNLljbWNDCF3y2PZ2RP1vegVKBwAlLb4S3myne74wV0kNOemsU?=
 =?us-ascii?Q?TYMeIAiAjyRJImkxmHHxtrfC+NiRIcp5WcVfw/PIgkpgyJr9pYEZJqIRklVz?=
 =?us-ascii?Q?D/h4ZRbccvaR6q1HMDfm1cxB2PSfC5R9IoO1tT1FPz1yYjLJrmH6pLZq8D1U?=
 =?us-ascii?Q?yTEXTxbbo9K+GQg96Tg3h7Oh27NiW9UkLKJiUFisc0HJnv6gk7WZ8lEA/4VU?=
 =?us-ascii?Q?jcvHWV1dYunAgYvO1bMIEpLmzVQqc3Txjzm31wZXK3JIonQ2yOZ/sx9TG0+R?=
 =?us-ascii?Q?e3vGXWLJmOoMHm/R0F5m8LqqHrIE9JceGHd0FbGrDf6xGB7+kZeHjzbm604/?=
 =?us-ascii?Q?fKWmUFfZZvY3vF3IyPENVTsWLlmAAtrLj/k4+HEiBYvkXrv4rG0EqFlzkOT7?=
 =?us-ascii?Q?fy/b038R8V4Zsk7wowVWABWuPZFwLBB6L83ALa7pAoKnVGg9t6yBsPsb9GTR?=
 =?us-ascii?Q?RNBhmzUQuoFeh1K3lfpPrrGz/zc9sKunxoKaOGLeDdNqyTQIC8INp66GssYP?=
 =?us-ascii?Q?XT9d7wdvH0dBeY04HllZ/9fgGcIp7MoAahMCa4NIQTJKoLYqLRQUuEKBr098?=
 =?us-ascii?Q?7wFpq1m2JJ4X0s7vyXYJUvQE38qyq4X0e6lSdE/ZHQpg1TY7gu2nxN0Ez+Xl?=
 =?us-ascii?Q?EHux0LVMdkJeLsYTk6QbkPKAhiM9ALW37/DzsGdAgKOjhle2IPGrxcQm2QWN?=
 =?us-ascii?Q?Ydondc19U0qdTFim+EMdlaAz2ywd3Emr1gmmNvUXQLJxdDggBn+d5UeNjhgu?=
 =?us-ascii?Q?y/wkJ0v0jdJ+J/Co+QPGO/mENxpK/6HgBEMV1wyQI8grgkQ7kH/xP2orWrpp?=
 =?us-ascii?Q?3IraE5PgeJJ0SDllkAyXeZ4o0zdyfOSSchmDoO1xwYxvf4Npu31zwGB4vEFc?=
 =?us-ascii?Q?YxyZ2ECXJwhE3rd/pgRkDKYvDt5KyCpsrFpDVuJ/2L6Oz0vFikUieOxDXvL/?=
 =?us-ascii?Q?mH+euMWVlFWs9XEAofqtX1QkF9VO0j9GPCMppVCfKQ3igX4yDvjcEuXpzuK7?=
 =?us-ascii?Q?pqoVPnrbKNypOFyFp5m36YmghxpS674w70krzlj3xF8m0xVSPR7l5Io8Fab6?=
 =?us-ascii?Q?EHk4mbXDfX//30UCsVhiY4hCqRjvO6uyPOdERTvUjM1GCAKWh3ejPkexD5Le?=
 =?us-ascii?Q?JMD43YdGp36PaXRisnfBMnZYV63o?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 01:20:23.3180
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 859b7dd6-078a-4930-8b71-08dc747d31cd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004683.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9439

On Tue, May 14, 2024 at 12:38:57PM -0300, Jason Gunthorpe wrote:
> > > > +
> > > > +/**
> > > > + * enum iommu_viommu_type - VIOMMU Type
> > > > + * @IOMMU_VIOMMU_TEGRA241_CMDQV: NVIDIA Tegra241 CMDQV Extension for SMMUv3
> > > > + */
> > > > +enum iommu_viommu_type {
> > > > +	IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV,
> > > > +};
> > > 
> > > At least the 241 line should be in a following patch
> > 
> > It's for the "enum iommu_viommu_type" mentioned in the following
> > structure. Yi told me that you don't like an empty enum, and he
> > did something like this in HWPT_INVALIDATE series:
> > https://lore.kernel.org/linux-iommu/20240111041015.47920-3-yi.l.liu@intel.com/
> 
> I suspect 0 should be reserved as a non-set value for some
> basic sanity in all these driver type enums.

We have an IOMMU_HWPT_DATA_NONE for HWPT_ALLOC to compatible
with an S2 hwpt, since it doesn't need a data.

Maybe we can have an IOMMU_VIOMMU_TYPE_DEFAULT to be 0, for
an IOMMU driver (e.g. VT-d) that doesn't need to handle nor
be aware of any viommu object?

So, VMM can have a unified "attach-to-viommu" practice with
different IOMMUs, v.s. some still doing "attach-to-s2"?

> > > So, to make this all work perfectly we need approx the following
> > >  - S2 sharing across instances in ARM - meaning the VMID is allocated
> > >    at attach not domain alloc
> > >  - S2 hwpt is refcounted by the VIOMMU in the iommufd layer
> > >  - VIOMMU is refcounted by every nesting child in the iommufd layer
> > >  - The nesting child holds a pointer to both the S2 and the VIOMMU
> > >    (viommu optional)
> > >  - When the nesting child attaches to a device the STE will source the
> > >    VMID from the VIOMMU if present otherwise from the S2
> > >  - "RID" attach (ie naked S2) will have to be done with a Nesting
> > >    Child using a vSTE that indicates Identity. Then the attach logic
> > >    will have enough information to get the VMID from the VIOMMU
> > 
> > What is this RID attach (naked S2) case? S1DSS_BYPASS + SVA?
> 
> No, when the guest installs a vSTE that simply says bypass with no CD
> table pointer. That should result in a pSTE that is the S2 with on CD
> pointer.
> 
> I was originally thinking that the VMM would simply directly attach
> the S2 HWPT in this caes, but given the above issue with the VMID lifetime
> it makes more sense to 'attach' the viommu which holds the correct
> VMID. 
> 
> The issue with direct attach the S2 HWPT is the VMID lifetime, as it
> would have to borrow the VMID from the viommu but then the lifetime
> becomes more complex as it has to live beyond VIOMMU destruction. Not
> unsolvable but it seems easier to just avoid it entirely.

That makes a lot sense. I'd need to go through QEMU code and
see how we will accommodate these two more naturally: likely
the QEMU core should allocate an S2 HWPT for a VM, while the
viommu code should allocate a VIOMMU for each instance.

Thanks
Nicolin
