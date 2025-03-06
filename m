Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DD4204089
	for <iommu@lists.linux.dev>; Thu,  6 Mar 2025 12:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741263231; cv=fail; b=VeO8PWGZgDmDc38eMM/5d2Hh2PNtMLK+PUsk9XZBwMBcbBrvKJQ43hwBwCu0ur7lGkUE8jSm6dFr4Ua9XAXSpjav1p4jP0OaRRL/31E0Ebon3od0VjxA6A1kAiyCM0SRX8zGWiOIZd6JmyKWQCjF2dt3pD9cHzFYpK9+/tIP0bo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741263231; c=relaxed/simple;
	bh=w5wFYmthWw8W8oZ0ujFIAeKwoB8eJb4vSC2WHaqSxkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jA3/3m5B/Cs6YLvkUWeYdkjBgeWAfGyyTEBHczRas0ZtEbi4YOsTpbH9OMfSYw1Pi/0VHDF790xiIzGbc0VZEvhqqbIjbgvQN+M8MTNywm/7YTUHKVNL7UnrJEXemfmMx6x+Ci5Dif6cCOBdXXmNGFHG2u4n12fNKFzoo8bPStU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UqZqQDw2; arc=fail smtp.client-ip=40.107.237.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UqZqQDw2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hTovD+9fNJiP04REsUrtXNAKaan7VcmI+o0Y71WfjiEluXrgleHlVE0HQV55ZWhIXdE6qYf9RYXxnfSnxxgzmPDz/9HD/nvvXa0zJQUqX/bbL9b1/Wp76DaJYTkGdgXY/EhPUeiNOpzWZtMUtQrzZnkACq/BUnILvHRCyJ86MXLA7t5/J4sze/2vZXVViHtfX1q2oMLZeSnATdgvaUwuwbduBaImsGChE5gakhWh53YFaSCaV/uktPz8eUZWIZyXA8XHMNBcCiQ4F3l53RC+9ykyAXcTJrHhc+/QdsuTZ0FG+rMdrD4FVtBmtkRgWpjtfQDfkxbPs/pnhEgP1P1gkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DzxV0RZrmNm128sMA7rG3YAiwWE9ZnOzVTFuIM4BPqY=;
 b=DALGSUIsEJfkmpe9LAFEgicW/63LVG9JPyIZt4Tvd7aX9QIzKd2x949Oikf9Cwb3DBwltEbjhm7hXx1jKHkY7sgo92COI1MVp5uVa868fQYRspRzQEVWLM33/O0DoL636SU6/aFFOd8Ter9HMsc1LAmJKBw0+yCPQQ9jObSzd7Y42RlvQhi5nL5LxpeUklLEBFsxPpCmo+Akr7EJD1+hkcVxLF3f7Sphxf75b7By0X5QGgu26nqHAAaXabSB7qRQjIGS2Zywn6/GAGvbmqftZoxYAqokc8TV8sn7sYmPuL7RfvhwI56zv2G0pWfYPZFC7J+Xx0bjPMuRI4VSrBRO1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DzxV0RZrmNm128sMA7rG3YAiwWE9ZnOzVTFuIM4BPqY=;
 b=UqZqQDw2bq9xJOzQcqiqb4OyqEBYzEKiM7LJHSmf2582CapxLzk/lSDFVurTTPtr/HV/3ly1PeWS80MHVfNIDpUTNcdI9YjHuwHmzBCPGmO82NuGwkQ/noRiC7sg2af5hmqIzi/oTXPYK70Y6E2wJvlGsU1ZzDYQKLziINrxlcAmqF9rE+GFwWa7zToAjGDxgwn9ptv/eY/ENvMkfq1RfFgJ+RG0YV5WqDUSlDlv4CQSwlXIOP+S5qH94qYaDYDsYjia1Dy1rE59Q9LWNYGhAbQPZNGVWu3EihufnT82Ogvbd86DQq6cNd/rfZYtcen+x42cfln7QedbLO391nibhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH2PR12MB4038.namprd12.prod.outlook.com (2603:10b6:610:7b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 12:13:46 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8511.019; Thu, 6 Mar 2025
 12:13:46 +0000
Date: Thu, 6 Mar 2025 08:13:44 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: [RFC] iommufd: Use accurate dev_id in the PRI forwarding path
Message-ID: <20250306121344.GC354511@nvidia.com>
References: <20250305130356.126424-1-yi.l.liu@intel.com>
 <20250305171838.GC133783@nvidia.com>
 <BN9PR11MB5276771968FF57AC0FE74BCB8CCA2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <d4da9e8a-e393-487d-ae4c-892fc139f2b3@intel.com>
 <BN9PR11MB52760A7D6D2A5680A3DC240C8CCA2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <f66eba4a-7de1-47ca-bf9e-22ad30b53418@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f66eba4a-7de1-47ca-bf9e-22ad30b53418@intel.com>
X-ClientProxiedBy: BN9PR03CA0072.namprd03.prod.outlook.com
 (2603:10b6:408:fc::17) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH2PR12MB4038:EE_
X-MS-Office365-Filtering-Correlation-Id: 128b4534-c96b-45b6-1331-08dd5ca85844
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ssSy81WtWPEaevN/fZzoXzSZnPSqnylRLXkxOtNxv4Zl56pBPM3SrxFoeUls?=
 =?us-ascii?Q?4WlJaRHOjYBGrqyYi9gLgSBMHHh1Khb7Aurjsb6BwFsqNOULBt8B+CvQQS52?=
 =?us-ascii?Q?vFccdqikqAivCk+d9I0oOOxEbL2KSVMdO7vLfJMLc53uWQ1me5Yc14alojls?=
 =?us-ascii?Q?7r3wDfLdmdl/+3S/VJZAjTaNNzuQW4fdITmijGWSBzjtrJIdVbtPdyh7ZT3R?=
 =?us-ascii?Q?KERFPTyQ02QjMD7+LY39Rga6JQFomRGeMy7nKLSfNrz+lq2TIs3ZJqvRrthS?=
 =?us-ascii?Q?QvM3nibLQRjbMF7M4sgxJKm53MW0EYi8ePtB9lNyRQxAP3RttaER6zJIZqnH?=
 =?us-ascii?Q?V0o6KOyGytqrHevYgBwAlPqPvpWpQ18GSk/hQQNWD0Dc0jaD+cCMBAHdgiE1?=
 =?us-ascii?Q?M1DUfd0lc6fg3hxJ4TiLjvhHsDyt3/txxno+MVotrPsfevce4SEf7nNTafXq?=
 =?us-ascii?Q?XWBLZep9wUIm14DO5pkiVDdfwbVcAZmUn8H7OHhaChPauPruMsFxH2pocsSR?=
 =?us-ascii?Q?e6zDHk7n0BXkKAFABQ7/64/vkS/bbEkk2q49RKi56nGwjXQVbbkPly36E/YN?=
 =?us-ascii?Q?co60UrHtGjoR1Xtmx4PmM7UMBHP+KqO/uuR9W6ka9xXu/nETZNuSC2tR0w49?=
 =?us-ascii?Q?7UCES0WHbXYdiBtHch5f5pVZnSe9A7/Fmw7fJ+DnUTmpoJqI4kk9zz4eVJ9O?=
 =?us-ascii?Q?/Q/3sYkGNh+TA9hAwyOYGNqL1xz6bEQGHbX1WP/0iVMLV6Ajo9Y36N/4ykFI?=
 =?us-ascii?Q?C3aN444tlVh48gcyvPkrbLqC7LmtKIXgIP0naLxQ3NNcnW5HlrdCU5bcHEGT?=
 =?us-ascii?Q?sF3VAkqqaNOe55i7AHCLLHE4CUo6hnb/x6bSrtk3itnnL9fPRggiS/62Trgc?=
 =?us-ascii?Q?Fv6Enj2hMG4HrR20kFmhgoQnl9Yov06lfpppwOouSxIHhAaKBKAigbgtul6X?=
 =?us-ascii?Q?90jpkIDiSPudcjdVTSmn4W3BOaQGSiCNiJvxzSIUh5ERFNLmeMYeJLHBLmUF?=
 =?us-ascii?Q?QF4NCFocUA50/CmaAp6emXeWX0nJE7PQea9OH/RArKJsalSdZpTe0PPt9cA8?=
 =?us-ascii?Q?SrARF5NA1nhFy/OE69bILySElIWX1h0WpLr3n5ub2U/8ULxyr6sYIqhH7mpV?=
 =?us-ascii?Q?v3F8lS0KknZ4ZDoJQNlNhRftL76lYCVt5SQO1ORsQiw6biR/ZzgE/pxtXovs?=
 =?us-ascii?Q?MBZS09c56T0ShjyGoVWFtLLiLIOlhlT58J0NMtn2z7duUBrqh/tOhvS3clHD?=
 =?us-ascii?Q?At/BS5cTTZ76NpyMC19fEqOy9T/QZGZM0vu88NPUZJRRHYPBl1bdycIoyYg0?=
 =?us-ascii?Q?i0ORPWnL/bLMAHC/q3zSex0Qfa8mP+x0Ct2AIEMPhA6TKdsKCUMoa5crrYQY?=
 =?us-ascii?Q?L2vAsTt2WZGaUaEPam5inYI5e5Q/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DdolSVl5gqrMU/AzkBdtlhHcU5P7onlD5ByimCiahR6UceY5JKN5vhim1NtR?=
 =?us-ascii?Q?JgpIxp7Xf3LfE9J6cgcLJP9KLarfy9pSWJeuKK8ceIRXFqAm4u9fRNfFO5fk?=
 =?us-ascii?Q?4iIJcv2OQPn1vaW1LxDVJPiFSuxPpm5t8qoCKGhBLiw3/xSLKV3FyJzl2VC+?=
 =?us-ascii?Q?L8YhunzM+OKIhrWJkmdTHl6O5jdL7MaeOQJOkDFtWeJ/F2OWYfVcZm1YZrnw?=
 =?us-ascii?Q?5k9lp9cypTl/KJqEJ2cC+URZu/nRCdzfiYqAdfUnDa9HxYQPRiKklfoDb39P?=
 =?us-ascii?Q?XIVOQ/TVQZEcSwVDGwkVCMWGzuIpZrvYuL3leyhG1X/U53AI9yUvSYLbvA3I?=
 =?us-ascii?Q?DPzsS3U1nYClXw/lkkOcLF+zqcvgWsjUK/Y26foySa/JZxlCm+PlGXbdmMSw?=
 =?us-ascii?Q?FOj1/gnR5jChmBIjzYR/8aXCVBaut0Ohc1RThK3uAg/6423ys/02nTY+32tv?=
 =?us-ascii?Q?VrSHfaUg9e9+/fRvlGjVLb9mhnZHY95QQygQSep6eK+Eo4aPFZXb9XrgotbW?=
 =?us-ascii?Q?kKaZtDQ77U8LdjUkpFyEzLFHuCzPh/wzS52tYtWXNi5/sRsIPpWJuxvRrDzW?=
 =?us-ascii?Q?D9VUlweyawGut43B3bXi2duzHH2wSRkw1UaGPxKEe00ZBbcXqLauxAA3aAVo?=
 =?us-ascii?Q?Wi/sLVFJ4mbwlxWChxT3P7I19W4tC9dMFSSgTZEZQ4BDQra0KLI9phmXrhTz?=
 =?us-ascii?Q?1HPC8spy3RJ+hXHANHiTYrmQXUJyAKtohwOj/BkXEPStvMHmifyZJQK9Nq4Z?=
 =?us-ascii?Q?ThUZiohL82IHa0hjPF0T9hhV02BjhACw4yNu+DW+D3aWBdQIW4H3Ie/zs2qF?=
 =?us-ascii?Q?vjfXh67cwC8bzNBeExU7uDHn9Lluf4c9odDBqnYkxzyVL72F5RwQLL52+qpn?=
 =?us-ascii?Q?9lVkXN+jO/7khCz67WYFWMD/dMAgVkFta3HqKJaTLP/YnwRZMJdFRWTJ9d4b?=
 =?us-ascii?Q?8QIjxOsytc2p1O5cak5WidTC3soK9YBu3XWKfjuGamQ0E9eU7Z7r/wWz7LPm?=
 =?us-ascii?Q?41ce/0yeMWa8DKPy3tMyr5EIeRqtii+RHYPL67ocs+pV9mTzFszTtDnyf52b?=
 =?us-ascii?Q?LatT6JTTBGpUpIoMrplgd7N/2MjIxljCGfnDaiNiDYH0hmwORxt31GIPA3V5?=
 =?us-ascii?Q?InFwoM0V5/Qu06YOfLV5fajTuhxdXpHYslGJ89qz8iFHWe7ahDGAfXXmSkCl?=
 =?us-ascii?Q?jqAH4k2/INdHHlYxoVEOcKmqZi44+gMSUaaZqFqsJ8PrUoxI6ryvsWOhtZKB?=
 =?us-ascii?Q?7ZYVwDhhluUE28t9qnKI2dqm4x2Y2Ww+qDn0yJPIkPUBkB6CfA9G4BxRRSqu?=
 =?us-ascii?Q?nrpAb3FHFYlZ4jsZEbPG6QzD5vYqr31Ua77oFP3ityItmLGcAju/bjZ/mGfu?=
 =?us-ascii?Q?EJDg5In7jci32up6h17hm4/UIpOqNaTVws+xmpTbWTr2ic2iZRHqVOS/wyEk?=
 =?us-ascii?Q?6o2z/vRX1+MBwZhTOOhk1mYYFxrTng0WR8jB8RE0ICBMWbJiMXOD2jMrTZIm?=
 =?us-ascii?Q?aUisbKo869U4sqmLjvhLaFyCKIfkIk2svRkT6cWEdmHXYZGV9kEsa66FPZUf?=
 =?us-ascii?Q?kZ3XTo3K6HInERXkmKE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 128b4534-c96b-45b6-1331-08dd5ca85844
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 12:13:46.3609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hFjSGcLTDf0KslP1lFWvhhlihOFWfmdrCtDozzd8Ir6A8EA5QWH6XOMpGM0k2qFV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4038

On Thu, Mar 06, 2025 at 01:01:30PM +0800, Yi Liu wrote:
> On 2025/3/6 12:10, Tian, Kevin wrote:
> > > From: Liu, Yi L <yi.l.liu@intel.com>
> > > Sent: Thursday, March 6, 2025 11:30 AM
> > > 
> > > On 2025/3/6 11:10, Tian, Kevin wrote:
> > > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > > Sent: Thursday, March 6, 2025 1:19 AM
> > > > > 
> > > > > I'm confused about how that can even work if the RID is erased in the
> > > > > fabric, how do we deliver the PRI response to the correct entity?
> > > > > 
> > > 
> > > If the RID is detached, kernel should response any pending PRIs. If user
> > > sends a response, it won't suit any pending PRI then dropped.
> > > 
> > 
> > Jason talked about the case where the iommu group is created e.g
> > for a legacy PCI bridge, with all devices behind sharing a same RID.
> > Then there is no way to know which device should receive the response.
> 
> hmmm. such devices shall not support PRI I suppose. But yes, this also
> pushes us to not supporting PRI for devices that have alias. We might
> need an iommu API to count the device number of a given iommu group.

iommu groups are not the same thing as aliases..

Aliased devices go into groups, but groups are not just consistent of
aliased devices..

Jason 
