Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012069.outbound.protection.outlook.com [40.107.209.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DEB2773EE
	for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 18:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763402935; cv=fail; b=Win/OQFl5yh4u35/v3/vUBWHNC+s5D1vxQ9btW2ZOwJ9oaH1A86V9hfsANpuH/vWYz7qlEiZVOFl+7YJMImrRyPSZ/z6fL5z9Wlfs2RKyVZjYlSvfvrs2An3qh/6hEceWrNJBwuACNG8tLFYrakHcxZrbb5Iytq14gau/BVVMl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763402935; c=relaxed/simple;
	bh=Mde5H4U1KHAfU603XlMXCJAqJ8wz6HUzqh5N1wfBWq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b5zUbqKPRWbKVMSMc1wOLhP4My2BTr/4ToG9nxvHOjfbBUgWELXj+mm0rdXq39TjRigMjNl0NuAVseocCfwVuwOujHPRT1/FMqdJ3C99UZu+J8rAcx/Z2Lkq4S91AVf/BmhoWXY4N3SiXGxxoeo+OjiduRrSczjj0nZvXkECGq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I62CPeuQ; arc=fail smtp.client-ip=40.107.209.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I62CPeuQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xABeF1a/Zj5ejSmz4NXTzx65GyumcYGGUGOWu+sFZdAbHs8DEA5ZL+teapE4HdyKla5RIt8R7jmXdzAWOtHJDU1VDCG+lnm2aVjxS2aGH0SIyv2qR6MYrYbU4d62Ld2Tp72ujQpQ/7m06Zxue4DfyFChv9Yq7qQ+TKpSsqNcOjox7rZx/rVNN4nS3haCRleycu9WHiIitU8RsGhL73s3GnCce0qYQXP3/KgmdwJRdrMohnLSNNsH6sXpyO1/Zmfo2R+VRKVYQvsfOXTtW+pZUcI884Jce1Fo6xX1dEp9O0k/KskRJ3PE+cTk1Zb4jh6yFie/yUdKam+Gw6Qyw/h4xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cBjTeTAx0FocoiyvJXmNjCqXwVKvbybtwvh4WDRtrLM=;
 b=T1qZd70vKdfcGCk1zIMvT87mXqIE2x1V1A12yMWiPXI8HaiZhgznNlOx7MzUVWd7epbEo/E16M5v5s6IxIkojpe28AugycC+nym++mkAEatUWZEU4pcgGiBdlJNPGIwcAdUqfhoE62iQCARp0VMyTGBX0IyouXMxhzKWUd5Mti92gDgHjokTLTic0qxZLjum9HF5C3FhJoqNtlsSi6ed1pgtnpZ6O5KdXzFR1VXo3XXfXJhRBilL++ZEqwkTcGvMhcLLOpJpF67jJ4IW6AB2Hkq3TWa23W9uV07nZpg/Ao6JDVmiZjUOhow1BUVqt1/tVBmOyMPgBhUL68SxXz7jFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBjTeTAx0FocoiyvJXmNjCqXwVKvbybtwvh4WDRtrLM=;
 b=I62CPeuQOy8+8zUPsEAr4gBjMLq37R/UY+0KTkbp79VyrbKM7Z/l9MxPKt0K97NNV2oCpSYiCKlx9QDjXHqgQ31tPcNWDvFQI1ERow8IhwJntUUCgyTjFkf8mcySUXiHxie24mciyiylv7kKOgQtAztHcZ93GGGKSz7zSaUe0wUlhgLbLrMiy8NFy/UB/vlcYv3p1HOPIgMKT8G9aMMT0nxpKVqfjLISSg8McBMKWxEjOW8T4ym5CYZGdFDvjCf5UtOb1c9gjShC8VX07uqteMFcmPZBSohphrPr6FL0GWdWFl1ZB/mMlUkvmqxFgNQnZsyCUzYdYpempAxeTC3Fhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by PH7PR12MB7306.namprd12.prod.outlook.com (2603:10b6:510:20a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Mon, 17 Nov
 2025 18:08:49 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 18:08:49 +0000
Date: Mon, 17 Nov 2025 14:08:48 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>, nicolinc@nvidia.com,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
	joro@8bytes.org, kevin.tian@intel.com, jsnitsel@redhat.com,
	iommu@lists.linux.dev, santosh.shukla@amd.com,
	sairaj.arunkodilkar@amd.com, jon.grimm@amd.com,
	prashanthpra@google.com, wvw@google.com, wnliu@google.com,
	gptran@google.com, kpsingh@google.com, joao.m.martins@oracle.com,
	alejandro.j.jimenez@oracle.com
Subject: Re: [PATCH v4 15/16] iommu/amd: Refactor logic to program the host
 page table in DTE
Message-ID: <20251117180848.GH10864@nvidia.com>
References: <20251021014324.5837-1-suravee.suthikulpanit@amd.com>
 <20251021014324.5837-16-suravee.suthikulpanit@amd.com>
 <20251023130833.GF262900@nvidia.com>
 <62ba61a5-d172-400e-beb5-e593297129ef@amd.com>
 <20251108230348.GJ1932966@nvidia.com>
 <8c534f45-80ee-4537-93b5-2643afccde8c@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c534f45-80ee-4537-93b5-2643afccde8c@amd.com>
X-ClientProxiedBy: BN9PR03CA0443.namprd03.prod.outlook.com
 (2603:10b6:408:113::28) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|PH7PR12MB7306:EE_
X-MS-Office365-Filtering-Correlation-Id: 691fbeff-2c68-4d08-014d-08de26045bb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MFYMZwrq9j1OzBM6yB2O552Y355XxF9K4KF6gbQif6LzT5IkXTCCxPgiZyK7?=
 =?us-ascii?Q?nXPvK34Yr6SxT5xqlYsRdAy0xX2xFrDEPFA/bvd5xEyixtmt5/TKou68HK7e?=
 =?us-ascii?Q?tF4MMH8Vw+R16j+CM+BS2TQ9FVznlG1bGE+FZuE4l12A+Z/yDDx5aZaemuzm?=
 =?us-ascii?Q?X9x8jdzwa/9XqAqzLsfLtWK5wHrKklybsB/Muksvnvr413zfa+Q+c3n7hv+3?=
 =?us-ascii?Q?2bNhd5vIjahS04pdfBn7BH0z1+6GHQ69K2xkxPWPjZdklaTRdDYhYpamOoo2?=
 =?us-ascii?Q?jF102105NawNp6XYLi+j6OMgDfF7xDr05lJzwEsoU/fQHMeyuV4PsIa4cQ3g?=
 =?us-ascii?Q?s/zLG/zejJGWfFq9H1Ht8KR7dmiPOdi35jrB5UfMGJgP+mMZxkYYJERi1cwv?=
 =?us-ascii?Q?1Zm2eI5fK/ijjkG1cakZ7cQe85/iIrPgRqJF/GApc6oPYEJAknGS5PxA1Ads?=
 =?us-ascii?Q?olpQNJ7LB75rIByxe22xe8PlDXiNC3MsQxIQXcS9Spi0GDO4RceTxGvaU5+p?=
 =?us-ascii?Q?sXc1oRWk7IQ8KM+jo+qz+Bw3sg/kEj1Bbfn6XK/eJxwTpZuV2a4L34Kbctqx?=
 =?us-ascii?Q?h/nniTkiE7t0e+jtDrxFYz5PxH07Sg7H+RAsGvDLM2gpeVvOtvKRW1if+i9H?=
 =?us-ascii?Q?w+HYP7XOoUxKR9AQYOQNxOLNOzNTNq0Ugw14J+0NsdKXl+Qk+DOgrLyP1gm5?=
 =?us-ascii?Q?P07XodB3lDfXlxjZ61xiX4Pok0mVve65uL3pOtZDQPSkH5ulZ6NCxSOtnYOB?=
 =?us-ascii?Q?+EEHUztysVOP175LAiRz7NOTAUlNqDrWiNC7GaVvBpkc9uM3tyGavI8zkRR1?=
 =?us-ascii?Q?akRbmrDQFJqpENbHIEVeuoXv7wblCzsi760o67ILjmV7C8dkNC1HSSi1Nz7n?=
 =?us-ascii?Q?yB2rs/jaDU8TKbMeo0fUzCIfeWWP9d824Lx8MLN/ojoPoLwzbaaA7ijhrejb?=
 =?us-ascii?Q?lfedmDCAhScLsdMOmzAFVaw7VPm9UjtDZLmayOl/9g4kREA6sAEfDgUnwWEZ?=
 =?us-ascii?Q?lqCmgq4s2Vv++Wkhqa46u3ittmTgsCd8RQwTZF64FU/GmKzFe3BZio21e97l?=
 =?us-ascii?Q?ukAEbfRH7kwt6BiiUF3u/0JnRlo7K8QWdsu8PEh4PyB9kGSVEc0PETfRc03y?=
 =?us-ascii?Q?Jmi9Ta2v5LNlQ1Ep4gpfyb/vzgd1ZL8LLJVQNybK5EvEK0xk2Wju3ddRA68R?=
 =?us-ascii?Q?YPw2uqpXmEmZfTZSqZDaOxDN/rMblOSP1hVcNGZuSmhmKh0A+su81HyASZtR?=
 =?us-ascii?Q?v9gVutATCvzyyTIR3TQEUYbk+o6PyjV9wxeqpElf0yVN5z9fWEt7osoMBVd2?=
 =?us-ascii?Q?xmbun2CH0ImSw7aD4LL7e4KqmcICznMGaBFojaUy24N1ORENTMDzPcsfv/YL?=
 =?us-ascii?Q?jGDTHgUsUgpJNC1iLFw9gwMdMyA5XaP25vOYgokEtn5fI7l1MSf6W3fTgbSt?=
 =?us-ascii?Q?lTbG5tUHM6CPiU1tmZAN3q+DnpJZWPT4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cHXkPmDQs/WgGG+j5BjyLfDaEnj7MEYlc1AyXhqgvRVVDrvZfGZvLGKJlbV0?=
 =?us-ascii?Q?YLJ5pWD6h1lFCuZTIjD6iVwnjpx7W4y07opzkX8XqSoxvPcNT/FzdxK/xExd?=
 =?us-ascii?Q?GHSKOLmt6xmE56zYHZrtyGU2HeLovTCB98b60j4T1Eg0eWpybLqsr954Tflp?=
 =?us-ascii?Q?MEnx1RQncatRR8ooBkUo2BkBhcatjVtd2zIx45YGBiNxdGvTsBwjIn8oMOpb?=
 =?us-ascii?Q?GJRNfSRemlSm/i8d+Y8b2DEBTjBgEZoyVTg1N/7ICdF4fkthjzAMjXT63z/L?=
 =?us-ascii?Q?wf2rFFD5YLiHtgSFrmBlwQmZAXeUvhGKJQ9HTUmKdGDz7rCOi2a3UTShzRIu?=
 =?us-ascii?Q?V9Czo6+6Avr5ajJ1+SNsIf17KMsz2iNnfZRmoag56iStlzvsa48rnjowyALs?=
 =?us-ascii?Q?TB0zgxPb0U7gyMSgMfXRNcfvS7gnSJKH43ZaySteyX2UGCwrvnCnuPmZSnKZ?=
 =?us-ascii?Q?6wqs3n2PE5FzoedesUpKikGAXnpBZdUXRsHQ3LbuIwncCl0sE92uHG811ms7?=
 =?us-ascii?Q?WgAvf/ORR25SigqsN3YUSUgdNOmuHQUb0418mr2fjzgfhty6OpmmdQvSP5Q0?=
 =?us-ascii?Q?CqY+jXZb085ozbELrbJCrBqEVMK/sI+S8t9+SHlJvUe8fbwLKhbU9A2QYppQ?=
 =?us-ascii?Q?BK/sH70yTXv9r6DJ8RnefCrr7gkQ23qKMNRvOM6dVdHORw1wTBkWIayQNe23?=
 =?us-ascii?Q?+1532G0XtmcuIRJ6eSkiY05Qyf5ZEe6Rmw0topvbcXQyglme3VMHhn91QLzV?=
 =?us-ascii?Q?3jz21aoKA3jI6N4VW3YVeyri6I+4Wxr0vCZRV9XH8Ig0R6IwDgmtool287Jj?=
 =?us-ascii?Q?K22y6InkzKBjuq3Zd1xSYHyEnnilT7JlOnBubd8hdhthU52IQJsoZqt98X6C?=
 =?us-ascii?Q?f8eDewHr6Kf220WjFREJQKIBCY6rZQC7Gxwa5qhdSP/Yui3kzTH93JGeG1RH?=
 =?us-ascii?Q?/pULjmzJiItCPAazwFSaahlAH301gT+NLdOnKcCwEvcO+geJbTKSYIuvGDaw?=
 =?us-ascii?Q?7VyIs4+Iim5xSW0F2DmU2bepnpJ0jEIke1/RisYTib/AuBvAW5AiQkC32vAV?=
 =?us-ascii?Q?O6DYa0thFBMb/HhVQ4rX8TdmxzncZPVPjgroxYtgRAGgRmbohM6Du6wD0llm?=
 =?us-ascii?Q?Hp0Psg2Sx0m+hLovl+Xft3qHOg3w2Dp48E/JoQBR9oWHdTq0LBqlKazMsYsW?=
 =?us-ascii?Q?okpOIlZMwPkib7gmpp+MsgqMujOOi6WElSUl+3fQnM/0l/54TUh5vj+EMRSf?=
 =?us-ascii?Q?GUqxkcVGJNV58U92me6FqV/Ug7oY2Mq2jZ7TPtw1WqEqdv1C4rQOWIIzwUsC?=
 =?us-ascii?Q?OiD69USErZpLfbDiEOnUNFYqlQSjBeYQ09j4ljHCjzo8UBdhtushndDz6QHJ?=
 =?us-ascii?Q?f3/XbPwh+yNq1aU29uf5a540/15KR17sXJLZLCgmG3+SuitaniBpmGRspPP9?=
 =?us-ascii?Q?8OAfIc51M8AX9YC4KRCmWB6aCPARl2wQ3X3v6H7FqqlpPU13F415fTuqUQnp?=
 =?us-ascii?Q?x3zSrWMRLWsAL/m+yLNt/3dLwlufR0MApTFComEgHYIQqJjVUeF45Y/8xlDg?=
 =?us-ascii?Q?WjQDZmL0q+L0uTbp54M=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 691fbeff-2c68-4d08-014d-08de26045bb6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 18:08:49.6890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r6/GyNez80NcbXGMaM7bAcBdupySU1dVGMnQDzb7+ImYKC2srBZC1s7QyGt2CLj3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7306

On Thu, Nov 13, 2025 at 01:40:47AM +0700, Suthikulpanit, Suravee wrote:
> 
> 
> On 11/9/2025 6:03 AM, Jason Gunthorpe wrote:
> > On Sat, Nov 08, 2025 at 10:56:38PM +0530, Vasant Hegde wrote:
> > > On 10/23/2025 6:38 PM, Jason Gunthorpe wrote:
> > > > On Tue, Oct 21, 2025 at 01:43:23AM +0000, Suravee Suthikulpanit wrote:
> > > > 
> > > > (though how does IDENTITY on a device with a PASID installed work?)
> > > 
> > > Probably set_dte_identity() should call  set_dte_gcr3_table () and update
> > > relevant fields.
> 
> Actually, PASID would not work with IDENTITY since it has no page table
> (i.e. iommu=pt means DTE[Mode]=0 and does not have host table pointer).
> PASID only work with GCR3 table.
> 
> Therefore, it does not make sense for set_dte_identity() to call
> set_dte_gcr3_table(). Each one should be stand alone.

OK, so the HW cannot do this?

On SMMUv3 there are bits in the "DTE" (S1DSS) that control how
no-PASID, ie PASID 0 transactions are handled which allow it to be set
to indentity. Intel can do the same.

IMHO this is a HW gap that AMD probably should fix.

In the mean time the driver should be blocking this unsupported
combination, I don't remember seeing that code? It will make it more
difficult to use SVA on AMD platforms, but not much that can be done
about that :\

Jason
