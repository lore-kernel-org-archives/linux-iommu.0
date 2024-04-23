Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2072.outbound.protection.outlook.com [40.107.96.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871B613CA9F
	for <iommu@lists.linux.dev>; Tue, 23 Apr 2024 16:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713890402; cv=fail; b=ClheSbApxp5grkHraNFzMvy1VF5S1uNff3RNQtuF36R/WOIUuS0FQVlqWW7RTHzAKsGy4qi21Fb57fFR/WisrJkSAcF4cTbREHxqKhC2V7eR5f2/BNsSoINJ3nsizJkw0WgR1IwENs9736D7A6ZDlb6quQpC7Pl69s7l8QvuqNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713890402; c=relaxed/simple;
	bh=qE42qxYOq9XdoXT+kFpEQH/Xvb8xKlQNF4kGG5ZK8Do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qwDfLsvu+siSH4aKaYQLS16ms7U+A9Kbgzymzbvy+jKKmxFMxijICH5zdJfEMsLcPGSb7sxB9B7Vp2FpiKHNJUUK1hqM+pSarG/nl9qR1TyklmIV1WD51G+Wrd3W5Zqh1lCPBlXzaOymBXCbuilBm91hAHXf9W/v4lFekuRyAQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NxH1jpgS; arc=fail smtp.client-ip=40.107.96.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NxH1jpgS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FYpaZ7ghUxolVPuCzAKC8IFty8vl/QxDxeUgivuYeHNAIe3CfgBy2hIDGCEskAlG4jqygNZ0/vMt89hSmbg69RhcwTMO74OOBHyuGNM7tKojW7j4QkEtli4ltgHsUPgZTopppEngc+EsTDIdiEJ+sIGbBYnqEqw5ZfZAOflgRB0HYbeCAWwJ/9qdg+ttxBoc7ChZcC2jbAWfCxsXDk0C5KIywYmdNuIzrORjfi55J5BlI+UxxcWQgGMNR94Y0omb7OOrBFaAIOs+M4vu2VvxaNzy890B5S8sZRPAkOBTCt8FWcFC35530ytodtUaGAc4TPpLzSxyoed+EJL5YWE1BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fniDksOy4/4wfTprQX6phnVZAgWZJ/Zsug2Id3dZYLU=;
 b=f0VFBdDqyPXjMF1l7fJVqbCmJEnWr5ChCSfZGq6uBK9jgwx+bPJh6+7padbgFwEYQYZftfMzUW2RwQer+xGxwsNPbDPL1cuzYmu88k7ek9jwaGFfZH56q0Nj3pmfmYU4TMznXzgjV/uqV25Yc5UhYdzB0IRVs8AUppWyC8GETc7uKlW6jWZI4OUZEt3dqi0DzhMBqaboiWagD6X33+vPb2IBGf0LRvStpsrRXHHOWlYKovUsHVTfoJDtO2hpSmvDNgyPEKZwmsIY/YLW+SO+BXSm382xwq+R8vTKibAWpHb1jh+8dJMoLMIR55h/gJwecKdSmEJQmdvSVpYwq5YmZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fniDksOy4/4wfTprQX6phnVZAgWZJ/Zsug2Id3dZYLU=;
 b=NxH1jpgSWJI8JH+JgwE+p0kf3zpWgtvPOKPxjGWJbf8hlGqvXPp0sctE6Kmr6HR3ly5sV4p3QI8XUPYhLjL+FRwi7RjmEZEivTNBcHKURxL5tutoQnZRYhJN/wgryN2XX7qflbCZ11dQsW/AUvdoc1RuSwcG+J5ED0rgBG8VXILeaCYjGEBxcmiBZjPXSfHCH4gVKh0dq2dznYOqPL7o5/HzZdqV2+mv5xeLVcXXk/B4ATSWMM2p4GDaTtT6G+gIEAxscW+3bjmJ3aexIEIo8UhWpuAO0xNcjlCJjCSGvp/5AbyGzKCCwdjqib/Rq/XTVeiHPRyW+OETMHfIqjsUDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by IA1PR12MB8238.namprd12.prod.outlook.com (2603:10b6:208:3f9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 16:39:56 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%3]) with mapi id 15.20.7519.021; Tue, 23 Apr 2024
 16:39:56 +0000
Date: Tue, 23 Apr 2024 13:39:54 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	joro@8bytes.org, kevin.tian@intel.com, nicolinc@nvidia.com,
	mshavit@google.com, robin.murphy@arm.com, will@kernel.org,
	joao.m.martins@oracle.com, jiangkunkun@huawei.com,
	zhukeqian1@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH v2 3/4] iommu/arm-smmu-v3: Add support for dirty tracking
 in domain alloc
Message-ID: <20240423163954.GA941030@nvidia.com>
References: <20240222094923.33104-1-shameerali.kolothum.thodi@huawei.com>
 <20240222094923.33104-4-shameerali.kolothum.thodi@huawei.com>
 <fa1968eb-9ad0-41a4-8259-6c500fc88521@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa1968eb-9ad0-41a4-8259-6c500fc88521@arm.com>
X-ClientProxiedBy: SN7PR04CA0088.namprd04.prod.outlook.com
 (2603:10b6:806:121::33) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|IA1PR12MB8238:EE_
X-MS-Office365-Filtering-Correlation-Id: ebcfdd7d-e2b8-4ab0-5075-08dc63b4024f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C+44URMtWHhCPB2ySu5tftU9x2W6+KMh7vg+AhXOyp9ooSUBVgaXYJ7UMH29?=
 =?us-ascii?Q?kkjm8zObDGjPc+I5T6KzeXIP7vGdpv+3koGeD8xhSa7qt4AjyPe3o3c8A+sc?=
 =?us-ascii?Q?9WcdY+3Cm1HnZRZj9jAQZtTAG4KVveqaSr+S3Q4MMc6ZuLXbei2lpZ8Q+K6G?=
 =?us-ascii?Q?uMmXxbkVhSjR0+YI1ojCIVtg0yaKLcUGgslsN6FGaJVxOa5Ur1OPAkktUiq/?=
 =?us-ascii?Q?R26CE17jBp6wHyYCfNWoQ5Ij2wmD+IB67apzHJQMppAPuDRjAz8kmIaKsiVU?=
 =?us-ascii?Q?5Mb6yNXVrF3gqOmM+CIkqgs4R+taQvmG6C4Y6wGtrFE1jKIZr2q5i4/gY+N9?=
 =?us-ascii?Q?K/d7slhKdew93HSG5rXGyobC5An3vV+LWGSq6kClyeKwjXplgTivFCFko6bU?=
 =?us-ascii?Q?IMGUuSieAA96YzuRexOuyR8Tw5A4Up8iehvcEWjEbc7nFdc6AmaveTeJ3IBL?=
 =?us-ascii?Q?Z/pH5K6vNRp4MqQh3mZiOMp4w2+oxNyZn2SI1eUtgyvcUZWzzaTQmcYj4wHr?=
 =?us-ascii?Q?fuGJWwZ+5W8ucgKZ9qVjGPPgnwzCrQgxJeelS8AMErXF8QmkGFuMSKRyucwD?=
 =?us-ascii?Q?yOmbWVvL8GG13BG7aoNcLpSwxI5neSeSAcYbBP64aUqOfwu2/hraqt19KmxP?=
 =?us-ascii?Q?cY3kdUdxbCfB0BGgh5RyQoUN8whJLO6YpzweShnll16bCGKjXympnQUqm9ZS?=
 =?us-ascii?Q?CBTvTU8yK2t2wMzwuGjw6ecetJFqhemYdbWK8jw57AwLQV/rbMAeis9mDKwI?=
 =?us-ascii?Q?SdlfeDLaz28joWr01gA55A04zhsixRrdJ3ZPOF8WDX46VhDhiSYAtt53WnEc?=
 =?us-ascii?Q?tCCxPT/pPbiUd1zTbxdFYhaj4tYsKdDc7JbSnYIAsGRAQb0nD7EzEEKQL85u?=
 =?us-ascii?Q?BUf+PWiJTVTbczdd0oTOp64nQjnUoH0gQjR0qnf5imJg9ypiJn0p88j1Rb3+?=
 =?us-ascii?Q?6j8XwqPTrfaSrMbfiq43y24dPLSt3VJn76g7eoeaz/im8DdoAJBVwRsnaQR5?=
 =?us-ascii?Q?M3BRZc71RXfpa1gD/cc+zCulaFbFgyTajYmoKin1Xbb+Z7vdqWVj3qdtHWhb?=
 =?us-ascii?Q?6bfmC74kDjkbOjVrR8ubDqZ/p+gvwYrlb0IHle0ZQstzb3aOnZUirKFOjER5?=
 =?us-ascii?Q?sj+JVGS+pbot+0It5oewD2cwusBh48Lxa3PywUPJgZ1q9uO6+nBf9+BdSElA?=
 =?us-ascii?Q?prdsNb7StTZpreBFUXvF9+6szx/ofQXp4pJJ5JPp9O0Am4GVJrkwK4LU+nqI?=
 =?us-ascii?Q?iO8ii1xqfRGbB8uuytqF9nik/F/VtX51RWl1dLfKtQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n2UasNozjvFLluCUUFWgsaseKkeBEwNfL+jb+i2/VHaymGMRBzXwqxRVqpl2?=
 =?us-ascii?Q?8gCnDorfJlL5M8tmCDe5ET9hGc/pS7ndPtRtB6NfOI2pfzFgCpu0gfrof++U?=
 =?us-ascii?Q?n4/v5ZvJxd5ycbOVpxOjxGUhcWC9s56UWqYSZP3YQj+aXNGv+K5RLVjsy/RP?=
 =?us-ascii?Q?G3v9hjwN8Os7uEmKIfQGZUlabiJnbi2Sf8krxvyAbIKalap01+fkf1jCTNcK?=
 =?us-ascii?Q?HlZP39/6nejzdkNN9eBQ8k71k41nZDCwGXB3PbNmIpsUSuIrBAxJP8Ikazxa?=
 =?us-ascii?Q?YQ46EwW7aWvyJ5mL0IEelxagVVSAG+wjZzpEbA5eCEnKggSkzEnMc/h7NvMX?=
 =?us-ascii?Q?a2tm2wsQ04jyfzROrj/yomJiQypnpbT4e+hQqoYUp2U2MJbGuqYxxan1jBws?=
 =?us-ascii?Q?TtAiTck6qdylXY3/mBOqID7qlMvvjuZKF7zTcWk3By9Rdek5dikwSSgvo3tY?=
 =?us-ascii?Q?c04Mi4pCD9xxC/yZtwOIvdPfvX8buNIWamKAMhpTFQj4zUvkTkPZHodbPO4D?=
 =?us-ascii?Q?swbVwJd/D3H6ZRL0r2Ufy7hRyIYeFADULf2S9MA8Hyn0DS2ik7xpNuk8NbTq?=
 =?us-ascii?Q?1H8bMDzyK77C37gOr57tNScZqViTwtnwRew/6VzxMD8ncYGFUtb7mszK0L8I?=
 =?us-ascii?Q?vxb+bKJQj7gyTeRFOOCG+fW8Hz01BOu23EfRln60z5Av06W3rEHG2ZBgarQX?=
 =?us-ascii?Q?LPtX7wWt2L95ftk+AGO5TsR4ssmzUctyEDJ2mazOxjmR6wdW/CX0bHYCLNxA?=
 =?us-ascii?Q?qEv+HfAwa6iwxmvhb36UiZh0ct/Y0X4SncaCYwvVEwbmVWLoKjyKDSB5Qx5R?=
 =?us-ascii?Q?UnN74SAMiz4iUN4ZwOstCuRvqySqPHW2G2UG3of1x63YzqgM2dD3pC0j12Wx?=
 =?us-ascii?Q?r9WSOhh7x6kWiaklAKdBBZYIP7oxHSFp2UokzziamRr3229fTXGhkaplCpAW?=
 =?us-ascii?Q?lUbUglzq22OoYyLtu0jiEkGrR6/8WmOHm5xiEnqCBb5WM6Fm3H+dJDVOwbd3?=
 =?us-ascii?Q?Cpk39Nr7q6MEUltSTlC84mKaWb8kWz9gERVoF1qpPUjGCEGZ9+H6tdiO8eAi?=
 =?us-ascii?Q?/WFYFOj6c9YaMwTnG6IfYHlKe0KVAOVbvHpkY3NgP/FT4kxPin9Vbimm9LT5?=
 =?us-ascii?Q?L1KCyFDlkh+wrUBRIg/ZjnI+6VF0YHuQW8asbuI1KcKiAOFBqSbs+AjY4qXf?=
 =?us-ascii?Q?xOFJX/xrK8ow+eKCwsRshj894Ca10XX80MVkLAw9L/OQc+IMWxUVgjZXoTJz?=
 =?us-ascii?Q?++u0QTrEme9YVeYyCUEzGSk3rFKUEbx/OJTtsw8lkNkFquTpURQvyBgdsqCa?=
 =?us-ascii?Q?GShgiPlojuttXadgvAH4pPCtZ1vA0tCeqjfy6J4LLC9ZjlLd6mw6l4HfD+c0?=
 =?us-ascii?Q?xtcWElQineUeUUnuC2kgkIKKcoiWulmeLfgb0FXXpmnYWb1jRoCvZ12kgRpG?=
 =?us-ascii?Q?6Z5BwZDjTPIC06qvEzhihzStOg5Fe6Ny+4AoJRP128TLZRry8D8+VSAgWiQC?=
 =?us-ascii?Q?PmvO3XrF9/l7LwEw7GC2lcCe0s6PjvubkcPYnvUYosri5+vni4omZUnhLA8l?=
 =?us-ascii?Q?flqHxYIIwIHm7NnPINE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebcfdd7d-e2b8-4ab0-5075-08dc63b4024f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 16:39:56.5215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pbzHwBayrdTswASMhWcfKmK5pDKDK2D0U131BY1qbBgcbRaf4B4u56Jda44A7zri
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8238

On Tue, Apr 23, 2024 at 05:27:09PM +0100, Ryan Roberts wrote:

> >  	switch (smmu_domain->stage) {
> >  	case ARM_SMMU_DOMAIN_S1:
> >  		ias = (smmu->features & ARM_SMMU_FEAT_VAX) ? 52 : 48;
> > -		ias = min_t(unsigned long, ias, VA_BITS);
> > -		oas = smmu->ias;
> > +		pgtbl_cfg.ias = min_t(unsigned long, ias, VA_BITS);
> 
> I know this isn't changed by this patch, but do we really mean VA_BITS here?
> Don't we want vabits_actual? I'm guessing we are intending to limit ias to the
> size the kernel is using.

I think the intention here is to allow CONFIG_ARM64_VA_BITS to choose
the number of page table levels in the iommu. Perhaps a SMMU specific
config option would be clearer.

There is no relationship to the configuration of the S1 paging domain
and what the MM is doing, there should be no crossing between those
two worlds.

vabits_actual is used in the SVA code to match the SMMU SVA S1 to the
mm_struct.

> > @@ -3206,6 +3212,10 @@ arm_smmu_domain_alloc_user(struct device *dev, u32 flags,
> >  	if (user_data)
> >  		return ERR_PTR(-EINVAL);
> >  
> > +	if (enforce_dirty &&
> > +	    !device_iommu_capable(dev, IOMMU_CAP_DIRTY_TRACKING))
> > +		return ERR_PTR(-EOPNOTSUPP);
> 
> I'm guessing the intention is that only a stage 1 will ever be marked with
> IOMMU_CAP_DIRTY_TRACKING (there are a few places that assume/check we are
> dealing with S1)? But is there a reason why stage 2 can't be supported as well?

Stage 2 really should ultimately be supported..

I'd say this is a first step as iommufd will naturally prefer the S1
configuration when not using nesting. After the nesting support is
merged the vSMMU will require the S2 to do the dirty tracking.

Jason
