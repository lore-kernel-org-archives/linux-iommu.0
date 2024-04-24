Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D50C15E210
	for <iommu@lists.linux.dev>; Wed, 24 Apr 2024 13:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713965543; cv=fail; b=mCZiMkzKgtk4IM050vlZVgllAkGgCHOn6iAqTu/XOrnb0uLhaGKwkSM6b0FqJY8C7KLajzeuj9yJiQVfyWTS/Q07468LcWOMPRvHQw6Jgxv1XRRm7L/E1HgBYsX3XH/04Nehke+HEFhgi2pYYAYAFlqZUhby91XR9nAmEQ1DVg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713965543; c=relaxed/simple;
	bh=/LUUMrSPVJPpNBAC/fGbqmOOFZaPbj6pMe9Yql4+cQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Zet2HmfjCS8hjI4IbITEki220Pi4+1O5C+HnoAZrkMhkHDqq4IbDcfcYrxozauO7eK+PI4y4ygsF3b3EvZ4KabRj5U2m056pBDFOR/fHm71vM4nvA99DsJz6vgPvdXyEAKqrbBroLVnVws+CMBCtmfkZ7Bv9f4FTlzfdbsR1RTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z5WVOest; arc=fail smtp.client-ip=40.107.93.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z5WVOest"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KXASVc9BPIDvUsxQWjEVEG3BVS7iHaITixmsZioKZC1Hs2i9fGhZz7RKZFbQPYwhi5JgSdtw3qhoc9VGanvMM2CZAKxIZ7cCtKavgHOI/DJO1FCP6tOsi5MF3ma6qvy2ek53m20CSEVf0r4IFyUfUqdMkNgO4bLWnxWhwlzvBrU4923CMmddQgp3vdMt4FDCGGcRBPCzxEIyv97WG/8YMkFMQUWVl7hFiqyO4b97169/pXK3/zY13ibwjkZH9TlhSD+jcLRKZlvR8uQmF2rj49sYqyvIo0GsoYmgFwv2AAjg9HOBcxafLNRHNVbw7C2QKCMPbdTOypI59m1y1vDfmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZN4FqbQyYKhnDPb6A+V8edHnN227Q8msYYmQYo8Idg=;
 b=oXuRLuv5qSxaj9i5/yvHiD0InT6NxNGamBJNTRI5/fgdymmMbvgZtJwmPvAPyim3NwlIkA7K8YlwF64eQi+qdiuXr4xVUGzeYVjHmecWotTYjUdz2HXEELML8FbRYM0nO/vhDEpCXTRYges22V0q/oT5w4ZwyuNHqE8Sj8dS9S3drql3fbcbboRUTW3GlEUh/RpYllWOZ3/Is0A/BkOnaxDf9AbIgtfUuot1Ipt6tpSZKroTPNsBU/0GI/22XRhaIxHy3YUh0i8e8wNSjkfCwXzXDZMHChEd/Qh9WI6FHDkvkjc26DA/xckQeUvQA216x9kLuOtHeLmj/+oge4IFLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZN4FqbQyYKhnDPb6A+V8edHnN227Q8msYYmQYo8Idg=;
 b=Z5WVOestT6Ahj5IwwDIp9SfO6Xz6TKzms2wmKlJdEeNNV2XWqfpMs7MvcgzEIQBNnd3k7a3SOsonKKsdlItKKNTWTmYmFsUUCPPvp2+QCFNMqfzzZLEpOJEd1VbhbxvDv/AizMzIm9CkLGdOIgKeDNdd0a6z6frnSvTLuEKMJTmh45dOe49XET+vR0mxOEyvr9bzX9Vq14ihV1jPfEAJkbsY1ey114ojllSGQE6SmbaFPAo76xsi06V4a3hpGvsT/0Jb30v0rh+YgxdRIROyOJkYOwEvpk8GXezg48rCwZABdQw5e6sPK+3cf7A740Hyo/sc9GLLwCJAZS4lYj4eUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by MN0PR12MB6102.namprd12.prod.outlook.com (2603:10b6:208:3ca::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 13:32:16 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%3]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 13:32:16 +0000
Date: Wed, 24 Apr 2024 10:32:14 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"mshavit@google.com" <mshavit@google.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"will@kernel.org" <will@kernel.org>,
	"joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
	jiangkunkun <jiangkunkun@huawei.com>,
	zhukeqian <zhukeqian1@huawei.com>, Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v2 1/4] iommu/arm-smmu-v3: Add feature detection for HTTU
Message-ID: <20240424133214.GI941030@nvidia.com>
References: <20240222094923.33104-1-shameerali.kolothum.thodi@huawei.com>
 <20240222094923.33104-2-shameerali.kolothum.thodi@huawei.com>
 <3733929c-657e-4d24-b5e9-a5d946645abe@arm.com>
 <20240423145237.GD772409@nvidia.com>
 <90985ae5-fa1c-40f5-b4b3-57350a16e011@arm.com>
 <20240424122349.GH941030@nvidia.com>
 <6e434a9e97be4abfad8c19dafe88456d@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e434a9e97be4abfad8c19dafe88456d@huawei.com>
X-ClientProxiedBy: SN7PR04CA0184.namprd04.prod.outlook.com
 (2603:10b6:806:126::9) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|MN0PR12MB6102:EE_
X-MS-Office365-Filtering-Correlation-Id: d2baa3b8-b302-48b6-f70a-08dc6462f4fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M2C4N9wkg46dP5I4rkOoBltk4O+zy7nqOTIy2Qfru+cElB5eFVmnK6L0kZKs?=
 =?us-ascii?Q?v0jp5yWlgpDMNf5qlVs8aKcMrlo40LOCYAAsYouyXgL2OAHmHoL3Y0qys6TJ?=
 =?us-ascii?Q?aGINV5GuDF7TwixRjHyzkav6KenyA3bKsOTkZ63PbrrvpsuSHkpeYBmoWHEK?=
 =?us-ascii?Q?R+ash03FJWZgCt291Juhdeb/SSPoQHITkB8v3tiwAJJKHucNfu4w1T24NbWB?=
 =?us-ascii?Q?7ZOgbzW/unbqVRHsSerPVc8zSWm8NsAEeRHxe7UZOR/XnZpMOKqoChpQcM+3?=
 =?us-ascii?Q?Pc1uNUH+TaBP6eDk2hUMTShB9gEuOUMfKjS83zW9CvDKMfvBYYilMS0OiiI7?=
 =?us-ascii?Q?MtldCwuJn75Au9X1za4FAw4wyKI/Wn2v+eHCi22FvPMFeYUxob2mg76qUp1q?=
 =?us-ascii?Q?z0mSEhLJvH1DMx7b3fj0VLLTNYdlW+pj/xmiY/gxjzkL9JgcPZv/VvfUDm5Y?=
 =?us-ascii?Q?memf0YkTd62wQq4eP4+H9O7+QRozHb3WN/aJsWpGm3hIK+TGqdomtC2bmrLw?=
 =?us-ascii?Q?Byf2z7njqnhWWnNXJ1ExIXu1DHSXsbwnS2oHhuNgddpOGnER4RKOgOyAmwEe?=
 =?us-ascii?Q?wh7NTcsSRXVq68KFYGUkTNICFEjhs3LJwtoWL8/Zk3LmblS9iA0JjANIRnjY?=
 =?us-ascii?Q?c51umB3WLrPfVQkQkmDm0rtonSIDr6PSdusI2SnjYCeYQt24bk8TKvtWhbIX?=
 =?us-ascii?Q?xMmIEFL3FZzymycXkLWnqYOMBBsMfdhNPsS8LpUj8N5XQhbDACAmNXEI/l3o?=
 =?us-ascii?Q?HJVgCRzQFBOP3XtGyOQnj1uH91DIjdrPSIAXqc7l2CapsUjzr5WiOLBtsyfg?=
 =?us-ascii?Q?2l0C6bUuoe7dY+4PsJ2q00I9AhYbfW4XEhsKcuB4HbxPwPb4slG+vVvC0iEg?=
 =?us-ascii?Q?UMSNDhFBBqN24FdBEdMO/ObIctjUL9WaLrQHnGUMHcLBoFe9gfTN/CP8Tduq?=
 =?us-ascii?Q?MZsexdeJvj+0CZdpA/O1YmGJ32ssshCnIp6cLXx3GMqRJFK0pOo1RA7QY4AF?=
 =?us-ascii?Q?UivZxdzRJDLqR8dtKMY24/MmO0hS4DbzOgYJ9solIu21IvFCZbdW8R8nPi6a?=
 =?us-ascii?Q?PNDKtNzvQotlEi+0HjttDw+HFqSz9vU+n0HCvG/XYfLvwd7KneLOyIco/Ox8?=
 =?us-ascii?Q?cttOW6kjXUoKTCntsAFx6bCJ2kKQZAKTcwPD2dIvwxJUwjEI0q7452wCZ9WC?=
 =?us-ascii?Q?vIao7PGSUOpFHstbUt9VnbdW2kMCEe5DXwKw1QTeAA3y+v9rrEacXUn6ZcgX?=
 =?us-ascii?Q?opGFJ828SIfnV+ciEJrbCBhbBnFZOM7aanVWVb17YQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G6dc/n87rb215DjEAOCZ1vAtiNi5G35L01zWoSmr97j+41v7OtOIu21rwQn6?=
 =?us-ascii?Q?UcZjUuOt+PXh/8MUEHnEMGP0YTlTq9xqRsgpnGl4qaJ08U9WSDhLt6nJg/yQ?=
 =?us-ascii?Q?paa0Gf+Pl48D7MxobT0693i9TodoCxIFbD2030gzHZ7dqhI1EDcV2zHJAQ/v?=
 =?us-ascii?Q?zb3HFKPizMepqOlGUtpW64yBR/uLSiGZAztP3gA2W3SrpIEnhFRnhq8j3gXd?=
 =?us-ascii?Q?yWsxlujs+T+Msn+pajRtNiMLYOZAExdWkrk5zzhZxOQIkq1v3PHWoQEB3OMX?=
 =?us-ascii?Q?HPSRCQbrTXpTevtdjieT8+MxTe9rmlyDRTMvsqbicHn8obleFx5PqMY+v/aM?=
 =?us-ascii?Q?dfIIqlm8CcfIzQMWeK8n9rPyKN2NWKOVaV6DhZWmkeNNt9r4p56ZleG3gxkS?=
 =?us-ascii?Q?QZRYyn016W2jU+Tvq487NiYHYIvxc/CkiILS1JXyEGYfvd/6Kn6Rm2dT3ECE?=
 =?us-ascii?Q?W0vsGIckpIJeY9XHiP6kErChiJGU+cO7fEXn1w9lj0a+obDSLZjzsCM2gRNp?=
 =?us-ascii?Q?WKMSdSsVmQZOyMa1mV85khYYd9fYmAUJxDOl7RWO5j3TLn58QBI58x877LIq?=
 =?us-ascii?Q?nKffggHjhFy25qaoB9FHMuslKSNTUkDqvOrB29T+jczdoQ492EhNdmTIDL4G?=
 =?us-ascii?Q?+ekKT1rQm93gEdLR9zweNClNFdSc/kj7kvfrjARkXloEgF9ARnrRyQQQF98x?=
 =?us-ascii?Q?rNj16ppPrkqDFxHqdycmNjsD7m6uXYwGn4vMzyt2/q3HWT8uQp+23bh3x0hi?=
 =?us-ascii?Q?E4lMkAdIH8KAU4c3fOh9uEwg/cc5gp/rCxUkKSVZiw9qCqKmU3SF32jcYt6g?=
 =?us-ascii?Q?K0yldtsy8wG7Qv0UX4177pf6ppe+A5sD6bg7gTmQcWT5D1Hy+qrOkbNxO50j?=
 =?us-ascii?Q?yctCLD1LvHWx+Ch9qHpHbhDV/XO0+vdGsLK0sXX0eHPUuDUmimWEzzdgEYMM?=
 =?us-ascii?Q?xsSqLQxTebK0ybHquCXhTVgd7DJ2bs5t//fEPaBwv2Ffnkb6Mmreqj31PK37?=
 =?us-ascii?Q?dzXZMexzROrYgqAQ1wT6dIIVMqnqIygw5zFJCu7sZQShM8XJD6RZbwbP86d6?=
 =?us-ascii?Q?u4vMLaHd/dN5dQ5hLfZxYrCyYkX1q+McTjwJO0Xz0J73ckvzDbXKvR8Hq5CM?=
 =?us-ascii?Q?CXvqbFmYsAzq3bgoYAiT0tPznVVWrHLx5g5s7fspYwUVEcopDuktCJEJfmAX?=
 =?us-ascii?Q?Fgy4X8HGbL+gMe+kLhhIKenON0vH9nUS9SY9bCZJauu/VFxKNjw96ihdaJ+6?=
 =?us-ascii?Q?/+QSWN6ylrF7WHh8WKUZyfjzyh8yG8UKmnkteIIZUk2MQ4Oo2LrMF0U9qCx0?=
 =?us-ascii?Q?AwCfl5pAJQQfc2FK96oCsj0u3gAn70Fxf1q+O7alhZ95ZmvSGG3tA8akJ/ea?=
 =?us-ascii?Q?XHyH34pauHc2i5+p6FoSdats5liTZwPE1l2mrpmTcaFqP86E2xK+uxgwpFau?=
 =?us-ascii?Q?ppa+mLvDUPzYG63HzM3f6sZK2OIvBOd5A6Q0Dlo0CfUoKJ4opQgxzSycVI2i?=
 =?us-ascii?Q?JKNLiR2jOE7berpajqIBINojLhlXfyMgRrC7mO5h8NbT+Bg7rtFF4orTepV5?=
 =?us-ascii?Q?PRwaBwsOqFUK7nGiSWI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2baa3b8-b302-48b6-f70a-08dc6462f4fc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 13:32:16.0645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kWoO8H0r/qGUT76a5uREOz1RdTwUSgfbV7L9VwEudoKrhrxpZS4Yxt0PFckXEC68
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6102

On Wed, Apr 24, 2024 at 01:20:53PM +0000, Shameerali Kolothum Thodi wrote:

> > On Wed, Apr 24, 2024 at 11:04:43AM +0100, Ryan Roberts wrote:
> > > On 23/04/2024 15:52, Jason Gunthorpe wrote:
> > > > On Tue, Apr 23, 2024 at 03:41:30PM +0100, Ryan Roberts wrote:
> > > >> Hi,
> > > >>
> > > >> I'm aiming to (slowly) get more involved with SMMU activities, although I'm
> > sure
> > > >> it will take a while to get up to speed and provide useful input. It was
> > > >> suggested that this series would be a useful starting point to dip my toe in.
> > > >> Please bear with me while I ask stupid questions...
> > > >
> > > > Nice!
> > > >
> > > > I would like to see this merged as it was part of the original three
> > > > implementations for iommufd dirty tracking. The other two have been
> > > > merged for a long time now..
> > >
> > > My understanding is that this series should pretty much apply on top of
> > > mainline, is that correct? (in practice there are some conflicts, but I think
> > > they are trivial).
> > 
> > It was originally based on my part 2, but I suspect it could apply
> > easially on top of part 2a. I don't think it is worth rebasing to
> > v6.9-rc since I expect Will to take 2a.
> 
> But isn't arm_smmu_domain_alloc_user() gets introduced only in part 3
> of the series? 

Right. "easially" was perhaps a bit too strong. It would have to be
rebased and pull back a little bit of the domain_alloc_user()
implementation.

If it is good otherwise lets consider doing this. Maybe HTTU and part
2b can go together during the v6.11 cycle?

> Do we plan to support DIRTY_TRACKING with domain_alloc( )
> itself by default?

No

Jason
