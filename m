Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D19E84DE2
	for <iommu@lists.linux.dev>; Fri, 24 May 2024 05:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716529237; cv=fail; b=Gfjx1mtTDzv3GumM27xIh3CnY3GCbktpHDpfC2kI8lgxu2nCgpEXZTLQGAL8w62YG1QOG0t0oSjV0b82FXSS6HxmyAFiQLyiN91GHEizZk/CdKGSEiUYUjPzcyFe6A0BoCNc9/DpAtyt/aReMfrhzlc9QRtrVKe//1P+3xtgw7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716529237; c=relaxed/simple;
	bh=ZdHOdsKQIaAvshhVPUaYViqqVaKHj7U7HytBgywAm74=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=phx6hwt+FUrn6XpeRSJtDY0RLlj1DNoZY2g7FbTLQZ7UReTZWht6XlVPCNFZTPSzrQpp+ac06WXhJ0UrPAuX6WjTF35n/mcsbPj+F/e3a8YPj+7UMVniEXteMw1I8HBQ+Klqkvl3IEuLFp/+RL06sY+ne5AnWNB0olX7i0gk8nw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XBfGZddK; arc=fail smtp.client-ip=40.107.220.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XBfGZddK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hs1si1gmeTCNeJMRTEsSjE974lIQfuqVA4eGGFbR2H2wkO75kV0Ku/nx8U8ZMRN+zdGcN329lJHlMnLzaS5Vwxm78E93wN36VLQ8gxFxuRdeHDb/+ZUsilLuVr1cW+KAbLIEFOE9RNGGoqNzT0Ur8C2BrmmA5MmzolokYHqQaYNz1mH7ManNr+k46forQ/z9oyxLYwM8xIral//kHujr9VDhGdT8RXu+E4UF3QjXUHDTTvBBRZHdHOM0AEY9y6JrLju2/QxqaET16UwwxsL2FbAq3VvfexRh7qCk9rYoGvEoWNn4rgO28R5478mXRwb2UEmv3Xs0qWQbt5CichItrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9N3bGM/lIiMq2MShNLbKTvu6/n7ybSIABNtahd/tu1U=;
 b=WueYZV1IxDaNHmVSGs8M5dQIDeNZQQ2XmXWgpKqGrVfhkH7BL7UJ7M5mp+/pSzKL/1hapM/i0CIp4VgpGYqcxAgDpxS1MqybCCV9vrbfsXJa4x7f2twEaTdReUfWUqETznjcjQf7i3DYjBW1Y8LCQMkX8Ax4dOC4TLNHz861BpsaL4x4SD3IkEf+bbHdk9v032PV1SqNU36L9bSAk6FOD29pC5cUk5LXzj7vK/17z6zXUZKA0/wyqeP3ZgF2GWP+hbarhklQm9LWMoBjKor0XtgCSvogSMxcYsJ0ntfA4zFgWI4uRlSxRGoglK56/zA5FDksJpz/SPY7wClZBKrJmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9N3bGM/lIiMq2MShNLbKTvu6/n7ybSIABNtahd/tu1U=;
 b=XBfGZddK0u/qmMCTYW2vFyU6dJ1V3F3jAz+AiShJEuf7O88tPwoabK6+W5mA0HZUSrwL7ivcmCUmzHEwcFyPUtlj4zCtMK/fFO+JcMP8N2F83cD2lieoU2gpSFBr/PT01+icgOUOOJeU+4TNgojj3c/0HJRdxxIwBOW/Z2rAhZb1MxyWLjwMzkwljSnQnd9EKruTkEbBXbG1oBU2xjb2ua/V+L7YSFj9GGc9CCXNcgLVbI3tPgh9rnfcB//+Xvwz+NrAAh6JxiK7U9oROVUfs/c0Vt7aYlphsQ9uJ+LYEX9sY7pXqBcLY3bIksu9Six0gd1EzwVMzTNsIXpdKxXeMg==
Received: from BYAPR02CA0017.namprd02.prod.outlook.com (2603:10b6:a02:ee::30)
 by DS7PR12MB6287.namprd12.prod.outlook.com (2603:10b6:8:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 05:40:31 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:a02:ee:cafe::f0) by BYAPR02CA0017.outlook.office365.com
 (2603:10b6:a02:ee::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22 via Frontend
 Transport; Fri, 24 May 2024 05:40:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.14 via Frontend Transport; Fri, 24 May 2024 05:40:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 23 May
 2024 22:40:13 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 23 May
 2024 22:40:13 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 23 May 2024 22:40:09 -0700
Date: Thu, 23 May 2024 22:40:07 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "jgg@nvidia.com" <jgg@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>
CC: "will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>, "jon.grimm@amd.com" <jon.grimm@amd.com>,
	"santosh.shukla@amd.com" <santosh.shukla@amd.com>, "Dhaval.Giani@amd.com"
	<Dhaval.Giani@amd.com>, "shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH RFCv1 08/14] iommufd: Add IOMMU_VIOMMU_SET_DEV_ID ioctl
Message-ID: <ZlAoN3s96HL7ROth@nvidia.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <c97a98a72ee3498c587e5898d6b899553ccd9b27.1712978212.git.nicolinc@nvidia.com>
 <BN9PR11MB5276A897A5386DFAC9A35F9D8CF42@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276A897A5386DFAC9A35F9D8CF42@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|DS7PR12MB6287:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f55e679-c069-48fe-b89e-08dc7bb40672
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|7416005|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C00PnJET1LRE2QtVvRMqk4rteI9yyCmHVIN/hCjjbqzFsVxqdQmxfasCyjdM?=
 =?us-ascii?Q?YW6R9gPPdcsjPn6AKhM3ZiDdJPym+VXq8qerkdFiQwD3QHckMApQF9z2B3gb?=
 =?us-ascii?Q?0+xHBll3fUoQegnjzcucDau+XbVwr+ahACj7ry4M+B0Dfz+4ibxsoqsmV3++?=
 =?us-ascii?Q?cYd0KwZV2vp+mhOZdpO6uCAU9QN0HlqvU3Oqf/53vkklGLEGM+39bJR7siTZ?=
 =?us-ascii?Q?7iH/45AeJB8rLgJsA1r5aCufea0dMF107VdcXyrZmAjOgPGeRYA8wSKl9GJF?=
 =?us-ascii?Q?7DDO4KBNG1jh3GPVFKoOOH6Ht6MFfb2pE0bHhRP6hpFsIDeINd2Pus8JA0Tu?=
 =?us-ascii?Q?QMjXrTP6JuvuPY1i5LAzvpz5NpLqEZ/v6WC7wFR6Qm+TecVqwVId9qbVF44P?=
 =?us-ascii?Q?E/F3I4jkj7WRDiauC4IkKHGZmAfgaa+od8TVylo5T6NRWl48JDOJBvywl8hf?=
 =?us-ascii?Q?Wp62PbzkkfUDVrLHWcfNWsB9UBrOh99OxkP1jqsMGSgs3G+P0JXsXrAQf5/6?=
 =?us-ascii?Q?rVwOCfpn+zBpjj9yOMLq+kCs+8tYhAYpbz3XXc72iQ3q8eN+tB9ac9S2kUtj?=
 =?us-ascii?Q?TM/CAUqGDoe8TRhhPN4OU3E/pFmTsWj1n99eIyM0xSa/ANkbt7J8/3L1J2JC?=
 =?us-ascii?Q?3NCwiDHd9srXxgsDqOv3WdC19Ju7guk5HMe9Xjd4kmu/yIDUDXxaScowxr59?=
 =?us-ascii?Q?Ah0aK0BGKPHGlwqtQ8zQBmkJzXq9Savu9QXTVmSoKUaEYN5GZFpCj0Mr/Qq4?=
 =?us-ascii?Q?wo1bZfpOnpKPGya01D9LI7ZjqJ5slIvJD+cdVpIiZf0rEsA81ym+GUOd3boD?=
 =?us-ascii?Q?gyiZtur6fRCd2xNn0ML1wCySkaH2ipPZk2pag/RSIHNLw14eq/C/ggR9L7Ft?=
 =?us-ascii?Q?mh13dT5G/K0De/N9GBCoWXqV6catkVNNX3PrKcH4+0ncUOL4/ybGNK1BKzWR?=
 =?us-ascii?Q?PaW8QuE4qglJFe11DNGrhfgrCQ+WYl0bTedc9k83rvvoLMNy8D6pQuf87u5r?=
 =?us-ascii?Q?5L8kl3beGu4PayalBgpc8qF7wT4/Ust2fR0psb74wAe0G1+8cIaTrLuoP/43?=
 =?us-ascii?Q?m1hUvnMg3W6KfNkDJJg3jdqiqmIH+UInDudKd0Hl1cXlL8E9+MOOeHzNBViX?=
 =?us-ascii?Q?B9WNz8ziD6//yd17EOnl+1zWcPl0YrRM5QEpMlfjRGUxKop6UotAP+RlK/Rz?=
 =?us-ascii?Q?RcFHgWUTg9XlLCI1B9Od4PnF2a4HjRPmFP4q67sWHnNpuCKwy0g3YY/D6fsB?=
 =?us-ascii?Q?lUjYBXau48VYIBcfLNqW3rkQ2rYA8ieNt4er2u/3AkwXty0zOBB/A0HV0G7f?=
 =?us-ascii?Q?JnAiSjna9bmJJORQHVNJrkuN0TO0vP6lRsccKggrYkje054OGiXLWg8aXPRm?=
 =?us-ascii?Q?0B0/gZ43951iGRTQALPQI7zNsnW6?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(7416005)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 05:40:31.0716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f55e679-c069-48fe-b89e-08dc7bb40672
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6287

On Thu, May 23, 2024 at 06:42:56AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Saturday, April 13, 2024 11:47 AM
> >
> > Introduce a new ioctl to set a per-viommu device virtual id that should be
> > linked to the physical device id (or just a struct device pointer).
> >
> > Since a viommu (user space IOMMU instance) can have multiple devices
> 
> this is true...
> 
> > while
> > it's not ideal to confine a device to one single user space IOMMU instance
> > either, these two shouldn't just do a 1:1 mapping. Add two xarrays in
> 
> ...but why would one device link to multiple viommu instances?

That's a suggestion from Jason, IIRC, to avoid limiting a device
to a single viommu, though I can't find out the source at this
moment.

Jason, would you mind shed some light here?

> Or is it referring to Tegra194 as arm-smmu-nvidia.c tries to support?

Not actual. It's an SMMUv2 driver, which is not in our plan for
virtualization at this moment. And that driver is essentially a
different "compatible" string as a unique SMMUv2 implementation.

> btw there is a check in the following code:
> 
> +       if (viommu->iommu_dev != idev->dev->iommu->iommu_dev) {
> +               rc = -EINVAL;
> +               goto out_put_viommu;
> +       }
> 
> I vaguely remember an earlier discussion about multiple vSMMU instances
> following the physical SMMU topology, but don't quite recall the exact
> reason.
> 
> What is the actual technical obstacle prohibiting one to put multiple
> VCMDQ's from different SMMU's into one vIOMMU instance?

Because a VCMDQ passthrough involves a direct mmap of a HW MMIO
page to the guest-level MMIO region. The MMIO page provides the
read/write of queue's head and tail indexes.

With a single pSMMU and a single vSMMU, it's simply 1:1 mapping.

With a multi-pSMMU and a single vSMMU, the single vSMMU will see
one guest-level MMIO region backed by multiple physical pages.
Since we are talking about MMIO, technically it cannot select the
corresponding MMIO page to the device, not to mention we don't
really want VMM to involve, i.e. no VM exist, when using VCMDQ.

So, there must be some kind of multi-instanced carriers to hold
those MMIO pages, by attaching devices behind different pSMMUs to
corresponding carriers. And today we have VIOMMU as the carrier.

One step back, even without VCMDQ feature, a multi-pSMMU setup
will have multiple viommus (with our latest design) being added
to a viommu list of a single vSMMU's. Yet, vSMMU in this case
always traps regular SMMU CMDQ, so it can do viommu selection
or even broadcast (if it has to).

Thanks
Nicolin
