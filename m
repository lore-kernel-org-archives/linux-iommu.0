Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012005.outbound.protection.outlook.com [40.107.209.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B193A782B
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 13:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780321088; cv=fail; b=LRP4ZDW1asFkRhI+bicYSOd1JnyCK0pOg39sHZ5fznR/Ds689IV/I/oDKpk302EiWTdpSMF4Lmb3vJj6o6QRJWtWni7EGxvdcfS/zHVRPKwtWGMw4X41UJlW6u/LdeXPpz/cVHiSdxYplrkEco7TB+357nxaTaicMe0SH7CABtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780321088; c=relaxed/simple;
	bh=6JzZn9EmhQgBgSiP8dFK8AURPVEfhtXBr4Vp8F8u1go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=khof5aZCasVNxjoRIez5aKhqw9zNZKi5WDtza1eS7TEOtXi2V77JIVYwYe1hxLrdmPmlYVZ9Hl0oOV3N7OOXQYlGdLkI5k0QTMegXkW5htfYz/7mlzTF8wNQbCBvGc+KkT0uyiwCJ9+1/sBaiRvYyKinDjCBmQE9iVNV0H5YpZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nujAMNFf; arc=fail smtp.client-ip=40.107.209.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nujAMNFf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=feAi5IzrjQM4JakTAdnymzmqyIrzHnViUcYpEBz1uKazcgtcwdyCxdkv5nhSH3gohX4/J4Ehk3CPpSLcHauVEPs6nlKAp3G6iuyyWH8SQ6X5JY73sCWVBQuBMGml/gBrtWBeMZMuTbg1s4qM5Jg9pet41l8QBAXs1CaVDTYKuM2aig3ePYFxNG+BEVcKlH0/fCoFekNxwBc2rokVIQemyrqkOf7bcTJVqCJHgvtBoslP/V2sEr9eweq96froojuFJrr2n6OIJs4PJtUMSFXn+N7kT5Ag2rd9KruK0Dg1SCSZOqvdjyCcUveWjbDtOAGPzKJ7PVaRGY0yv3Vb4U5z9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ac+GR1DxljHTShkP4THo12g1N1RJul01GAL9nCAbwqc=;
 b=cJ2nfRwoViYiysHdrYtTZRfExRLC9cHoqplnXQNKtCvsB67+eRcKs6yoys/RUclFnsTmf7FGGg5/sevtM1j/2tlm9N/9dhFm4ECC9eNxbwi4xVZ4sd9cBartV4WbdBfWTz9+NmMnHL38OB/iC02J/RcS3GgqetAEhAY6Dk6mVZeWNMOCuM0sZ9ABR422C3StgdvTe5gr/CmvRri7al71mw8sleuyRLZJ3D+IRULZT4mRbV5wDO3GAlGHv+YHvUwxlF3iDuxdBJCOV+LyS0COg83y27uBL5JlDxgrCcfPcD+uHKrzmmrK/MHx4iKRm+6obXLFn6j1zJqqzBp2dAXDDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ac+GR1DxljHTShkP4THo12g1N1RJul01GAL9nCAbwqc=;
 b=nujAMNFfM3R098i1RPMO4YxwXx48R7WEHK9q9dgft1mLgMnTM/sZvHe3691WXQv94Wv0jpst72iJj3im4a7RjeTSGNL0EgfLek+Sg4N4cTpn4ZyXWf6Cq3Nd89i24ZpLu0Zb8wGCoxV+ix5D21AqaUfWxStWf4BdKCStpaJBO+hcwtUVtwPRRk/NlI4BEo3eN51Zs1Hl6LeCoR8b818dFgfOKrXPquGXVOsxsDAD/EhSb4weNhYIyPR0vlpjjJANA2zHoiJLdpKQoqPjPVhdw4t4C3BkJvvtSbK6dY8zBYKMCEmuaV5snHUPK6PO3sDp1fhp7VlwtP0EWr03cZ/7+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH1PPF9C964DBFE.namprd12.prod.outlook.com (2603:10b6:61f:fc00::61e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 13:38:02 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0071.011; Mon, 1 Jun 2026
 13:38:02 +0000
Date: Mon, 1 Jun 2026 10:38:01 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
	vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
	sairaj.arunkodilkar@amd.com, jay.chen@amd.com, wvw@google.com,
	wnliu@google.com, dantuluris@google.com, chriscli@google.com,
	kpsingh@google.com
Subject: Re: [PATCH v2 22/26] iommufd: Add hw_queue_init and split queue
 alloc paths
Message-ID: <20260601133801.GP3195266@nvidia.com>
References: <20260528051738.596013-1-suravee.suthikulpanit@amd.com>
 <20260528051738.596013-23-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528051738.596013-23-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: BLAP220CA0015.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::20) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH1PPF9C964DBFE:EE_
X-MS-Office365-Filtering-Correlation-Id: cf3a2825-db94-495f-9ba8-08debfe3009a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	GQxISkb7DX1RqerYNcjh/AWyDC6f4c6UAKyNVflf0yuLSzOTJ0IVclNi/rcWGB4x99cUXUi3bJDkbWHOzO528C0HZNYS3dV9Fe3ziHR2V7nyLV7KkCP1gQsISqEDTgDxHVs9r4gXuaCd8GEH9FdpPhC7aanPKuJ4+G9Ue6HeYLYOXIXctLfSmNjIxzqXLltN5BFkRkg+5tKMrw3v5bqxdmrBAVZL1iRajHKsyLLkqJ+AMu/0vOyLdYJPFlZGxkonOPM6YeXPhaCzTKjfobcOT7RmK4LWUEMRgcj39AySNAjCa60Lu6oTjClBQOLI0PiSrgVq8Cs5oNDMiIJ+g+BNIifSkV7odgWJS273eOI/e/ktM/1f4/aPJ7iYrDjh2On5qCD4NyZXAAiK+Nkvfk6FQYC3Ikb85Z6tGLylqbP0sPTYS5FLXfjKuQnhE0j0lOWTrbJnrjBhc1qs0shzvJW80kL8tmOhTM5g6IGUutCHD1w/4Hcmvm+0qS7vjquc+SroAyp32XGrqmqVgtWVn0xkpxdl3B/5VP+h/mWcW5IoMyTZqTRyrcXVFJtkVfqIjiKXT+hg/UUsLX8PBMGdmjTsVoc+QwrOBO90dgZFWcWzf96I8fkB5TBvtFO0fmpVmi9Vru4bWci9Y3GbeFGbxhwMZZUEkHxwaf5hIde91IigWp5HFwCVZCfaDN4TY/TJNvqD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2oC1ot3QhJBKClwI+6il4IttgDfSzopk6Iuvpzj0a0TmCVwz5TRKgOIEPwXh?=
 =?us-ascii?Q?W64e9MqbRq9Qk5Ux7AtnbV3PijREjeXyKFs/ZPIiIO5jhuXuS4pFHCRwbcmy?=
 =?us-ascii?Q?QD2EK7pfLzwcrwwqJuMWUKrGBRIDSR+vPpdQdSBjWAY+9kkHMXSAPXoycR+V?=
 =?us-ascii?Q?h6tEnVeG3BhDEB7t9WsdZNfmZ/t5u0W9Y4tBK59a+OHVXSan5pm53KLQFVNe?=
 =?us-ascii?Q?mJfLp1pvklcCPzNeUtczHture2dRqk8goa1rsh5LQRJGZN2Gp4wle0zI4gLK?=
 =?us-ascii?Q?i+7vXe6OglFQOGXd0DxXitYb6Urx9GrnmPA6IaErehNx/mgki3PYelVgVTPg?=
 =?us-ascii?Q?EZ9K058+8QqeKV7wwPxWz8BAdcVim5QRX0IlUHvpxjEePZiVQJu7SpJm0/x0?=
 =?us-ascii?Q?UEWforlD2lsGMd0TS+9MupPPf7gfuDyGDDf/BzwRFX5C40FOZrDfZhoxGEH1?=
 =?us-ascii?Q?JNYc220jLLw6qyohgLilMjnhFG8cME3CxTwMZ6h9BNtCDLbbZ01Mym6n7rO7?=
 =?us-ascii?Q?pX8O+oovI9+7G7OH07jltMz6edmsrJr/x48IvE5l5/zhvQA5BceBRuMvGsle?=
 =?us-ascii?Q?7+XaVLT7rI9dFvawGNgDP3UNPRbdkUQWoHnCqAj1/K/H5G2T2ontiqo2Iwdo?=
 =?us-ascii?Q?y0yAIUS0Skn/miuaB/HGOKqbDhhUD+oO3UsLs/ZYgD27SIm9XYb/Dpctb8bo?=
 =?us-ascii?Q?sqD97hWMJiroK17Q+3rGy6hP7PqYMDXjh7+xAhHrtTqhPFy4pC2u3lrxvVG1?=
 =?us-ascii?Q?2hg0wurc2yiLGwvwSyoWtrLNGKHcGuFce/fmoAehNuqOhCWkXH+gV5U/ovva?=
 =?us-ascii?Q?wzLAQhFQSHzzBtCcOXb9IpD7TnFCPMR5wkDEfO5TsvGP50OuUySsvdL7n7CV?=
 =?us-ascii?Q?y2dIES8Fxl4aXt8pcw2CAJ8FBGm4kHDEnjYeI6kwKvV7uqjGj4louxPcLDWl?=
 =?us-ascii?Q?iOf2sKlFujhory9vskyhDxwZaE+L9+FBeuQs3QPxDjc7qxmNzeufiX4jrMs6?=
 =?us-ascii?Q?Ep3qlDq5BecXOzdU4CxuI9SjHVkzxeKoIhpAEb7AHXsKSzX840Vr+vuOsQ9u?=
 =?us-ascii?Q?d06r8MVTZzhAmu+6U2xpAY5Y0hqaEFesHSdtb2Fj41Rl/uMF0Kdi1qAMa2S5?=
 =?us-ascii?Q?e1D6dIzgK1oooIMYlohyzgvRd8UF2m3nMA5WeWp0civdy4qHKBrNyq5qoyyW?=
 =?us-ascii?Q?8p9ZIYIhQtuwv1FMSaH7814ZKRpGlCzXgn+Of/EgAi5vBdTEWpk2EGbB33uL?=
 =?us-ascii?Q?cJd07GtieRvb0j4aAnFWnuwceqgY+CF6beY6xM0YjAZrFuFVeXSVvTQG9Eoh?=
 =?us-ascii?Q?DVu1AcE2UiArvwqatMq0mHIrGA6knz5tJBLE6kpU+0lagl32TtwqAlhMvT2H?=
 =?us-ascii?Q?6z1BbpXl+6XHU9Vyg0L/PyzselWmgjqAKjoMPqpSvD2DuG6P+MJ+ibmk7mth?=
 =?us-ascii?Q?5T8oyR498xO7rZzZ7A18BYui6TF8n0eHk2RUcfYVnngKUTfZF2YBU7JF/1el?=
 =?us-ascii?Q?IfsSaoME4+iR2a8OrKna95g31VORoTQJfTZyw3IeffxItdpU8rXSRUoTeFtg?=
 =?us-ascii?Q?FbrWqqwfBsb+MLKLhruSDOtBFjeYZg15BkEZpvfZ9jF10qjm7AfvJ4iczU5I?=
 =?us-ascii?Q?kPk9t7ZNIZUL4rX1skVxaIyoRd0TmZiokHS33ZC4dB4ecX2ByriZo5i6KHGo?=
 =?us-ascii?Q?hoqegiwas2H8C18AEoH0EbPoiKqPKWgc9s+nzSTvSM7M55k2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf3a2825-db94-495f-9ba8-08debfe3009a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 13:38:02.3763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pvPjJDAm9V+bEvV6Z3sv3rWdP24xSH3vhWOp8AdqQMkHfRN9EE8s5R4GPSl1noO0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF9C964DBFE

On Thu, May 28, 2026 at 05:17:34AM +0000, Suravee Suthikulpanit wrote:
> Add iommufd_viommu_ops.hw_queue_init for vIOMMU backends whose
> hardware uses a guest physical queue base from hw_queue->base_addr
> instead of a host physical address.
> 
> Previously, HW queue alloc always went through
> iommufd_hw_queue_alloc_phys(), an iommufd_access, and
> hw_queue_init_phys(base_pa). AMD vIOMMU instead takes GPA from
> userspace in hw_queue->base_addr and programs hardware without host PA
> resolution. Splitting helpers and dispatching from the ioctl keeps
> one uAPI while making the contract explicit. Each vIOMMU driver should
> implement only one of hw_queue_init_phys or hw_queue_init.
> 
> Refactor iommufd_hw_queue_alloc_ioctl() so shared validation and
> viommu lookup stay in the ioctl, while setup is delegated to
> _iommufd_hw_queue_init_phys() or _iommufd_hw_queue_init().

This patch series is getting pretty big, getting the viommu working
alone is enough for one series, I would split getting the direct
assigned queues working to a following series

Jason
