Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED1042A86
	for <iommu@lists.linux.dev>; Mon, 13 May 2024 03:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715571266; cv=fail; b=C+GqndazhzjGPU4DseU8kT7Yv5muz4ySIBfzsTgxdPNrijX35HF+4LvNCAwZTV1coyIPISLxk3wxvx9MmWaF117VwrfeQjkISfpzSsKcIu4HAhuoh9kg19tvsCStju7nCPUYCURN9buQoSfx2Ev96gHxOpZhNi0kf2/0NstUms0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715571266; c=relaxed/simple;
	bh=m31snSfz5ezQU7T5WuFaCvl0hzEMJ/wFvR0T54rWWlY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jNadNubZcdRSBNjp2exvqYR615n6uac3ct8HEFBe1aA677AfhC4mnTyLxTdY27wnz8uYxvPMjTIBdQLwCvaD2YjgqlUP7kWDRNwNVDVnTQK4DzvxqN1+EW1js0D+ZJXZhEYreS6XkGQ1wqmk6HbzVFEJ0b22bbTXaFHETmYr4Rw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nabvomW4; arc=fail smtp.client-ip=40.107.94.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nabvomW4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k6o1DXRgDsJ+PuKIsIZfcQjqddgs492SYiB/P91CpeSBoZXnm+lWKYvw7xghDIKQ/kdWlii6c0U9AR9e5au+Np+GoitvSoZwh0vXvTc4rFOPQ2hMERpxDH7Pea+bcuWeTKP/AGF3htEXyAasqlUu4DlFAm/EaJJIcSLiE5XPhbvKI1meoeq95kXZ9Nc4KZ/RtF4pNMKUeWZMgE7n91/c4sTcaHN4WT9XrjGXC4oAjutUkYGJ8m8ActnPkgXxr0hGI13XC8jIUPjmBhriIexo01yo1qS62wi5keR8uogoHgTCQwVCkVsyNo4RyMCxOjonKCsNeND+v2ig4f2ZhLOwUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QcX2brfGADkaIPPoQS2ujD5YuBcTCTwLMY437sEiY38=;
 b=E/ro2pOOYo8U8jfoUHKT02i84/kGAzjm5NexorbHTtW0UImjk9XmCMHvwP4d+0JOycgBsO9kKmBGI9PJXYeGNAVmvLbciDjxFBmcm5SKDBDRpDV291j+NJZ2WW+GDq7SVrH7L9IJKH/2Mm79DF0HDwADtR7pP5J5bvMEpcw795exQN0odCxbEpdlpVrAG1rCUgTMBDpv9PM0dr8+LmAg0/u2jQ7cH94lp9BkynoZ0Ux1BTOdYiv0HTmp6FcZagsRSQOmWWz3iqSxvjs3OdyFsUB0IW0bzSgCHsLSa6z3VS6lE2dVqKVLmE4qtQR93RE0Abzj+o7ajlkVi562wKGn3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QcX2brfGADkaIPPoQS2ujD5YuBcTCTwLMY437sEiY38=;
 b=nabvomW4boktMC+Bs3/Jn+4yb/c7RXmaKp5JejyQ43APkJEWxJqCDYtmAktPnlaYWUEHfdrkYWZwSAClN0M9uHRsYPpg0EM0SZRID2nHBuLmhs7ybBl1UPEysd1O1a/gE6aQYuLEiO2HLnILVjeaCNMSsNpbHZ3zy6q4aZxEvvl/UDO8MFKvwPoOaQJN0QmLpDDcfovJe+zGPTmnklUOgPj+fB/UHIA9coLYgvbj70SnAkTHnragefm09I53A9LiVIp4n+GpkIIafxtQbsZ0nY64r9XYZsUUKYRwW5YQOaKSUZ3fyUsEukf0w8ZFOBltUOQ8jN+T3x/PhHnv/T6T4A==
Received: from BYAPR11CA0046.namprd11.prod.outlook.com (2603:10b6:a03:80::23)
 by CY8PR12MB8297.namprd12.prod.outlook.com (2603:10b6:930:79::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 03:34:21 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a03:80:cafe::bb) by BYAPR11CA0046.outlook.office365.com
 (2603:10b6:a03:80::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Mon, 13 May 2024 03:34:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.21 via Frontend Transport; Mon, 13 May 2024 03:34:21 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 12 May
 2024 20:34:10 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 12 May
 2024 20:34:09 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Sun, 12 May 2024 20:34:05 -0700
Date: Sun, 12 May 2024 20:34:02 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <kevin.tian@intel.com>,
	<suravee.suthikulpanit@amd.com>, <joro@8bytes.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<yi.l.liu@intel.com>, <eric.auger@redhat.com>, <vasant.hegde@amd.com>,
	<jon.grimm@amd.com>, <santosh.shukla@amd.com>, <Dhaval.Giani@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH RFCv1 04/14] iommufd: Add struct iommufd_viommu and
 iommufd_viommu_ops
Message-ID: <ZkGKKoHnykAdGJq6@nvidia.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <8610498e3fc00000e78bb9cef6fac9f6a54978a4.1712978212.git.nicolinc@nvidia.com>
 <ZkDMSfd9BXmsFfb+@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZkDMSfd9BXmsFfb+@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|CY8PR12MB8297:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d81b2aa-40e5-4cf2-75d7-08dc72fd93fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|376005|1800799015|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Fw837d+1uGK/gl35mOw1huAQuzumzmicWwenz6XhKh8UNV+q54k78vUOl9EY?=
 =?us-ascii?Q?CE9U51WAvARvUOzZ/HnTWN2bl7NsKv8abZeYXvyy56b7lZNHjTkd3dQE3l/i?=
 =?us-ascii?Q?oHOckBeQpyqQgBU21P3hotOH116KrDJlZa9SFz+2ef8y5pOOcHY02tf+ABTl?=
 =?us-ascii?Q?V3tAbVZ19dBb7z/fTHPfO1bKD+7Wab6Bo8bWjUuMdYhGtQjp5IAm/V4cm3zZ?=
 =?us-ascii?Q?f2aGQoQ2NV5k7yAMktjy+mbZixI0stCev6Av1t6LlBoGW9RiEnOlEqps8L8l?=
 =?us-ascii?Q?eK0LxxT2fEeSVVOYtoH2ZlOIJ5Zxrl/hbVJaYZ8p6H3lajOY1aq/ApwMH/Mr?=
 =?us-ascii?Q?SdBG4DFAoB6ktxMQ4HoeMH3wVKpwKr6EmYIcS95GpPNgtifwmerI2T0EwYgY?=
 =?us-ascii?Q?UN6X8tM8/2UtbJH3PsAYaYn/QbltcQQ8+OBShHxwG2Pe6hMv/0kiQRXuUHmS?=
 =?us-ascii?Q?fzVi0gyLjUihnKelhbANUlXlvNKRkXH11pj59aUbfiHAFgigtgUv8wb3sW9x?=
 =?us-ascii?Q?X1hYZNEXhxLVSkeuG1wMp/RZMUfmyJgk1o/sOUIInLiypv8Np2EFajmfAxmt?=
 =?us-ascii?Q?bO6MgyBnuLtFXWP0WIsIw1lw0/mcpM8l7ii0id9k5kuwxNmv1B8bX1E2Z34f?=
 =?us-ascii?Q?8T6cdtGJXl621ZBclpdy1tIQ5mpFQFjAuMcAByXhjWfUf1RSr/AsNN1Qq6oL?=
 =?us-ascii?Q?+gnXOvr3sZQ/9xsl5+skKElGVtOzn7becg4oqb6HWZQbujYCDeOQu3ljhtKP?=
 =?us-ascii?Q?eChARW6wiPciOZBxLUzu279IClS94rjeunrHtI/UEiY7Kq33Run9uLK6fVVb?=
 =?us-ascii?Q?0fzMRpNuXvvRaAhTH94sTeLEyl1Reo310Fld+yr6947xUfcHtOyAeaQ7S00Y?=
 =?us-ascii?Q?QkROJJyPm0T4rbttvdKLJNPtAisw7IkilskNjO5tt6OSl5AGUF/WVNnGmO5d?=
 =?us-ascii?Q?SNN1RNia68bdwzMsW+Uc1bluV8e+B7W+oKnUX1zCLpBlWyZXehWGLpP6oG6k?=
 =?us-ascii?Q?mraVAI5HcwegaPc2G/R19cqAQn4cJbOSX0359elsSYU+/tXXHRfdv9r2opop?=
 =?us-ascii?Q?6Cxa7ji7cdAB4EvYlQTYoBRPG1NJWronSE72v1VB5f1LimHo1N2XvJkGgrHk?=
 =?us-ascii?Q?SklJcYgqdwxMEEIzKu9DFQzvGPmaN/bEvlFeMXqwm2Mgld5Ymz8bI7fKaLnj?=
 =?us-ascii?Q?VnjY/XJVnxatDRKOkFM1lZq8QSTJMZ71l90zoo/LYpHJu5iVQWQIwfPTib57?=
 =?us-ascii?Q?tHc3yn7C176xEMyp5ZmVm4ZMPse2yhKOBcukFO/CK1x8d6R0PtTZCKN4F4C3?=
 =?us-ascii?Q?PD01bc30lrTott21vYFj76WOS3z3HHXI82CS/QDk5eIvIhN3uIXqeatUG25f?=
 =?us-ascii?Q?GIi2guzRtehJ67ZXq0lOHJNJdJW8?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 03:34:21.3787
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d81b2aa-40e5-4cf2-75d7-08dc72fd93fa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8297

On Sun, May 12, 2024 at 11:03:53AM -0300, Jason Gunthorpe wrote:
> On Fri, Apr 12, 2024 at 08:47:01PM -0700, Nicolin Chen wrote:
> > Add a new iommufd_viommu core structure to represent a vIOMMU instance in
> > the user space, typically backed by a HW-accelerated feature of an IOMMU,
> > e.g. NVIDIA CMDQ-Virtualization (an ARM SMMUv3 extension) and AMD Hardware
> > Accelerated Virtualized IOMMU (vIOMMU).
> 
> I expect this will also be the only way to pass in an associated KVM,
> userspace would supply the kvm when creating the viommu.
> 
> The tricky bit of this flow is how to manage the S2. It is necessary
> that the S2 be linked to the viommu:
> 
>  1) ARM BTM requires the VMID to be shared with KVM
>  2) AMD and others need the S2 translation because some of the HW
>     acceleration is done inside the guest address space
> 
> I haven't looked closely at AMD but presumably the VIOMMU create will
> have to install the S2 into a DID or something?
> 
> So we need the S2 to exist before the VIOMMU is created, but the
> drivers are going to need some more fixing before that will fully
> work.
> 
> Does the nesting domain create need the viommu as well (in place of
> the S2 hwpt)? That feels sort of natural.

Yes, I had a similar thought initially: each viommu is backed by
a nested IOMMU HW, and a special HW accelerator like VCMDQ could
be treated as an extension on top of that. It might not be very
straightforward like the current design having vintf<->viommu and
vcmdq <-> vqueue though...

In that case, we can then support viommu_cache_invalidate, which
is quite natural for SMMUv3. Yet, I recall Kevin said that VT-d
doesn't want or need that.

> There is still a lot of fixing before everything can work fully, but
> do we need to make some preperations here in the uapi? Like starting
> to thread the S2 through it as I described?
> 
> Kevin, does Intel forsee any viommu needs on current/future Intel HW?
> I assume you are thinking about invalidation queue bypass like
> everyone else. I think it is an essential feature for vSVA.
> 
> > A driver should embed this core structure in its driver viommu structure
> > and call the new iommufd_viommu_alloc() helper to allocate a core/driver
> > structure bundle and fill its core viommu->ops:
> >     struct my_driver_viommu {
> >         struct iommufd_viommu core;
> > 	....
> >     };
> > 
> >     static const struct iommufd_viommu_ops my_driver_viommu_ops = {
> >         .free = my_driver_viommu_free,
> >     };
> > 
> >     struct my_driver_viommu *my_viommu =
> >             iommufd_viommu_alloc(my_driver_viommu, core);
> 
> Why don't we have an ictx here anyhow? The caller has it? Just pass it
> down and then it is normal:
> 
> my_viommu = iommufd_object_alloc_elm(ictx, my_viommu, IOMMUFD_OBJ_HWPT_VIOMMU, core.obj);

Oh, in that case, we probably don't need a level-3 obj allocator
that was previously missing ictx to allocate an obj->id.

Thanks
Nicolin
