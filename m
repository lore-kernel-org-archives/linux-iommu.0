Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2057.outbound.protection.outlook.com [40.107.212.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B50B2F23
	for <iommu@lists.linux.dev>; Thu,  8 Aug 2024 19:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723146805; cv=fail; b=lxqxsuFW8yx+LwL4Fdbp1tOBtbLNfD6qqV4k9JkBF13w83XY41yoE+ilZ8uqg4BjGJSWKqHM2JXMrmpFOAgjxjArho7KK+x1QyUksgpqI0cI1xkXQRt/QOs9Z4mEVI08EoX4aGZxzMNaORabx0GSkQpJNgqsnFm9B6+gsdpH2dg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723146805; c=relaxed/simple;
	bh=DkKVbTA1Yl1P418MXnOnJ26cRHrqOruZy4ET7uH7WaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BsIi1MD6s597v4XCe89ytBDLzhUAPb111c1tyNtCZlSnwfDpVMdWbn23zZAudqQ0JZFN4Iir64/Euxy6FJb80QSudSPZHMcYqVGXL04IiqggNs+Tw1VukPtkFXM5gqfUrj/8ndKUMDvE/VT0UVu6sayUvC3WZaRRX0EOBf20oRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WelEn6+d; arc=fail smtp.client-ip=40.107.212.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WelEn6+d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rm4EbD3lmufzUh3fN7VgoyPn0gvPvjcF3t0z4j2GGuY7NNfQfLYlmzQ6R7j3ddAtJa2tqW/447MVlxqT1zScq5M203bcm33KsBHy9Hv50M6y1jXL1HUXwGAWs7pYcPtNefO5pb64OGCscSThzl7XpB4HQ6NaofP3cV+gKqSdCHrIi+SITpsONix11/yyCSYQA532N+x5kN1YraXhTbOroZVweIijf+rDIEO3FiG6zcy1Xn0gmLcb788xtYgRX23cWJXnEWMmul9BW8KlLjuhFSAvOgAf7yV+MACA92SJSYfOFFqSZsnpI0jtMd67lAA1G8d1vEtIVkSqeVgfQJd9Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7htQYvXskiH5OaeSeOgTdRKFlbtX/7vhBrUuocuJ3E=;
 b=T3HheHkktMTIj0KnmqoRfmvPjdACZkfO0kglVD41mdMlnHEI1RQhPFJZynzGNoVpnkblpQH6tG1zvmuhXrcYiSoBiV3EvUkxNXbF7eqpTz0f6gidyFPA86y8K5Ro8ntSau8hbLmweC7kwUb87Cmz5pZ1l0oBkCwYdX4O8jURUrMFwwhKZOPdCIur8rXi/xfuySVq7pPgMBiVJDzzrfpMRIdtpC0YuD9F2RC1ZvuySA0HG4Ooant8tUNYm6y8zKvXRp36KqUczvRhzjjaSXhaVINZF/mQaCNgid33qcRK4g99fmeTEtdKL/8n9gglhUcw7nnkNSZ4ff+JfVWcAmmVJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7htQYvXskiH5OaeSeOgTdRKFlbtX/7vhBrUuocuJ3E=;
 b=WelEn6+dcj/Dzk8xRXj1OpNIut3nKkN9F5AqiR0s6lXksNoyIxiEs0A5e66MbHY/r2U1EbquK/z+fz2IPeuWPFq/tmq6b3j5X08NZoK/Osbwd17MYEfScZZytC2RpJ43KBmivo3/cORJ0ZLIdG8mNC30Zy3tOhYJ1HiXo9GbJ3W3jR4JIWtUFQwj2XKqaTUC96Z68h54sV0WvGBsaRGgdBtE1YYnHG0TCXzwjwMkYboEdBVVBCmYYjgDqcKUICSXYypChuzLP065ePDZKV2FOJxp2KpbNe0QS6YLx0oN0fD64CxmVWUq/AWSsgdmnfkR2GE5uvgUMQIBGTfOrva+MQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by SJ2PR12MB8925.namprd12.prod.outlook.com (2603:10b6:a03:542::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Thu, 8 Aug
 2024 19:53:16 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7849.014; Thu, 8 Aug 2024
 19:53:16 +0000
Date: Thu, 8 Aug 2024 16:52:52 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC V1 0/4] iommufd live update
Message-ID: <20240808195252.GE8378@nvidia.com>
References: <1721501805-86928-1-git-send-email-steven.sistare@oracle.com>
 <20240722155500.GI3371438@nvidia.com>
 <3329e042-e4b1-40b3-9875-623f26386609@oracle.com>
 <20240806125602.GJ478300@nvidia.com>
 <54f33881-26e4-4b7f-bbdb-89f4cb207be9@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54f33881-26e4-4b7f-bbdb-89f4cb207be9@oracle.com>
X-ClientProxiedBy: MN2PR10CA0015.namprd10.prod.outlook.com
 (2603:10b6:208:120::28) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|SJ2PR12MB8925:EE_
X-MS-Office365-Filtering-Correlation-Id: fa0a80ea-e86a-427b-3777-08dcb7e3b108
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8hWVao9KaCHt6/AvKQiunMSLxwyvwKJ3mGiJNyCdXQgNO3qynjVaraVrIxuw?=
 =?us-ascii?Q?1GE4Ik02YOSZEYWAaQx2x1F2LfYxeplDoVC76LvfiD2XP0tWpt9h9Utsb0V7?=
 =?us-ascii?Q?ouOdu9gTD70HXYEpNliFNfgP4L/mQ8jtcKrkG7j5f9jHDU0aHv5S3xZGV9Wx?=
 =?us-ascii?Q?DbB/YMD929mxPggVPij8Sk1VnsI6f7ow3U+vyBHtk0YgSMgJLp0LNE9dvq/p?=
 =?us-ascii?Q?rJoEu92SmO8qsYtPBzLaic1V11GNRqH96DkusGNK3RydtPQiymQi8zX9RZtk?=
 =?us-ascii?Q?V9LwZDVFgMgPiA2Lzjx8NfEYTvUeq2Ezd5vwamwrLDpE69CSClRHrrjkg5/z?=
 =?us-ascii?Q?22d9ejidmfEHmFcm6q3tHp6xNi2J+2ApC6J/B8wUpwNQBJWzF/Xu+1HFZaW4?=
 =?us-ascii?Q?SMysUFn3jiX4ahl2uYMg+QTSnplW8/ckXW4aT1KP8lJaC9X/zUaa979LtoIi?=
 =?us-ascii?Q?VrY/34A+1AzQBUUTwPJuMnsn32nhxFVoaVLFU0Pg1DJ9SHPZh6zWs09E6q7E?=
 =?us-ascii?Q?tTaYmiH8jRnUg9X6n/SNCD/cGztMnEFuKScO1PIM4nuZR133ycDdikObq2dL?=
 =?us-ascii?Q?pmEmBWLqGjJgGxPbQrYpZskyXnnF/tsdXfhray9P3vJ5dvCkhuntUm1JL2It?=
 =?us-ascii?Q?B/pZdZ3fHkH/O75BmgM4CkxQyxFXlJQCzqAKAixJZR+3Yaws13cQU6VarVq/?=
 =?us-ascii?Q?nuMUoJSh32pRbU8TVL/Nr12tNmhCkwV3/Ol1CHWv3tr1AxBRKKKYndrxlpEY?=
 =?us-ascii?Q?PKklCvkGZG+HJCtsit7IagXuvQXVunaDv6/BgHPX/d3y20V2LY0U1DuPjGL3?=
 =?us-ascii?Q?Z6Hm8r2BRQAbaj+d7SlWY04lKGUiZoSju9BWILPaAxDDowXBHlBqxhte9Xil?=
 =?us-ascii?Q?uMaeTKMEa/JCnAq+6GNq2GQ7hQTvoE4pc81uIS+ocgFHd3JWYf11Phm6AV6j?=
 =?us-ascii?Q?NaAMYyphk5kgFELlvMyN8K7mMSS0rtIamTFP+p3QQIQsyfFbOSGBwotA3uP0?=
 =?us-ascii?Q?o6rx/wkjSBi2R5uvVURibZiYwcC8i6ctgEyDSOyGObum08GXvmLzlmbjkSgt?=
 =?us-ascii?Q?jIjZFiB7rZuanodUUm+8OWbgmIlfhkWpCnVrWXPSXTZaz1jlbWVmmiBPDWvT?=
 =?us-ascii?Q?uHlH+q/V1Yhs1/Rg6phkvxb+nqlX7g5eA/vp87nNmUgIXCMjSmiSIMjMCwU3?=
 =?us-ascii?Q?PId+lvyIYed08jdq+Ir2/2JAeldLfUCKbpNTmI2J07iQ3dFbp22klL4eKw0c?=
 =?us-ascii?Q?KHyfzEvNpTlYDGh6D33ow1Mh9jJOYd8rniXIYSqLCYJKLfJUHgxorcSzzCgR?=
 =?us-ascii?Q?xXk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mSUMvAk2bp3ZxG4WB0jyrH791cYSs9SGvQ3/qZybMgStS5W2w+zvRmOJuXdw?=
 =?us-ascii?Q?NoJACSGlmr9P/x5gKelv2T5U0AHAdjwdniMdOj2OhZsJwdT7D7p1n+/lsQav?=
 =?us-ascii?Q?pgm2h0hv3qY1RGh0PJpE60/mq9wOGD9y1AApHVx/fEDTTHpu5Od3jeXkk9Ep?=
 =?us-ascii?Q?HAZshXq+lSIwxHUjiJ9ytNeU6c4jNar3X3Y8O/Wf7WZccCTm1IRBFI4VN/8k?=
 =?us-ascii?Q?pt1VQkRx3L9AI8Pj4Ug4/agBroOlSyM76VJF8gHK+B5lVuW4mfch4KBZjY58?=
 =?us-ascii?Q?1pm9Dz5na9Bnd551EoH5UpQFrPaHv0yuvFupUa+bXMH4xbP3DVlBDT55+2HS?=
 =?us-ascii?Q?Gwa49CyB+lFMEmOv5ksNk5QuBoeTu/gvKfMcfpDDgUYdGtj4uNqIevHzYWJq?=
 =?us-ascii?Q?AVBBOCZGD+tBDM5u1bZ4QcX8GiTDPWb3IOiC313tnEZVkuO0ugDJOO0lH/bs?=
 =?us-ascii?Q?apduf8mP6qA4tInYM8vG6wp8++8yUc7d79enIHgse6yDkQ+TxEKyg++cE/2k?=
 =?us-ascii?Q?W88qtqE7C9QsrOOwHKtBCJSSJZqvkzUSbZKz9cBNSFuVHHyqxXHbzla36V4W?=
 =?us-ascii?Q?2c0YYW8/OIK/O7w3MMryDjmvrcu9xK7VqRXnVBGqdZ0fgLUetiZeg5cxMRXg?=
 =?us-ascii?Q?MWES+lADS/ILaZ8HiYCkMdNveSdeDutRId9a59tkQXzGIO7jzyAQ/ORJbC5p?=
 =?us-ascii?Q?OAa+pRKrMYa9Si6F3E+KreS7BFR0AX2EdC03C2tb17b9Ms1MHXrMa25hIpKJ?=
 =?us-ascii?Q?SyFHaySkJGWOq1T2b07dO7EYQvbo1Dv1FFiBsb2uR2GVRkZ0j1SqRmHL8d9/?=
 =?us-ascii?Q?LbNaAH24h2fv96jyvmr1Y2SlHpw8uP42/oj7ivj0/QkzgrAhUf5zFQrM8Pif?=
 =?us-ascii?Q?1CSnDGxygUNW/JgsOWNA1jz8dCtkLDwZDrerKbGPaWbJC6C8nV+YAmS/AyPq?=
 =?us-ascii?Q?C3nYsR4CGBU5CmKF4uSnTwCDXSi9kBobjIzAe4Qb87CMqW7SrnESkWjTndJ8?=
 =?us-ascii?Q?dEVynKHffwvRzGmHjaNyU/MkTywFGCNVM0CDsaIGMAaLYqAoR9Q4rKzPlj0i?=
 =?us-ascii?Q?TZLA8px/+UURpz4cTa1XVTne4sq+3A+KvpcsSSGdlQ6pROY+vCd+hm5WIKtn?=
 =?us-ascii?Q?5/BFvXWlXC2Tf+r0NWEjIfTlABHxZFz9rK3GqKzH/VVax3/nuhdUjbvOuIcR?=
 =?us-ascii?Q?KdT9Go3VnOuh+/VOTWyIs9/TztUqLvRVXImHPeG9vO/TV66pOL/n35fbP7oa?=
 =?us-ascii?Q?ynLqok/HmvRXvTgglALaAcY3GuYN8x7bMyUbUT1Ja5a05ATu4KuAH54LOm1h?=
 =?us-ascii?Q?tHSzCZec62CVYnqTVxkB14Rqwkm5jrfiiD7YaY+UuuORXE55Mthb6SYFExKl?=
 =?us-ascii?Q?Cgj6bc9KYPrBtSvOVaAMWvYeYAYhuY2mEuMM41+6N3j5olvxaf9zpiKIF996?=
 =?us-ascii?Q?B1aPXSCVLcLQ/Tb57TaTxhRjGToYcj9WL5GQ2Wx3UiAnK01kvCNUzGnOwBvh?=
 =?us-ascii?Q?uFRNlRqK+qPzsW+2QP7FC56Ws0R38GggTg0Np+LUTst4ev0gXAAwaZsC/g93?=
 =?us-ascii?Q?1zpV+YfTpPl9w2K63Ac=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa0a80ea-e86a-427b-3777-08dcb7e3b108
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 19:53:14.8081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SjpgeQuaJnZ6mQDOHnCaLSmFgrmHkUU/eqmckK8lOgiMdTFso8zVBuOnm/PKO6BX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8925

On Thu, Aug 08, 2024 at 03:15:02PM -0400, Steven Sistare wrote:
> 
> 
> On 8/6/2024 8:56 AM, Jason Gunthorpe wrote:
> > On Mon, Aug 05, 2024 at 03:03:30PM -0400, Steven Sistare wrote:
> > > On 7/22/2024 11:55 AM, Jason Gunthorpe wrote:
> > > > On Sat, Jul 20, 2024 at 11:56:40AM -0700, Steve Sistare wrote:
> > > > > Live update is a technique wherein an application saves its state, launches
> > > > > an updated version of itself, and restores its state.  Clients of the
> > > > > application experience a brief suspension of service, on the order of
> > > > > 100's of milliseconds, but are otherwise unaffected.
> > > > > 
> > > > > Define the IOMMU_IOAS_CHANGE_PROCESS ioctl to allow management and use
> > > > > of an iommufd device to be transferred from one process to another.  The
> > > > > application is responsible for transferring the device descriptor to the new
> > > > > process, eg either by preservation across fork and exec or via SCM_RIGHTS.
> > > > 
> > > > It seems Ok to me, I'm glad it worked out for you
> > > > 
> > > > But have you considered using something like the new
> > > > memfd_pin_folios() system so that iommufd is bound to the FDs backing
> > > > the memory instead of VMAs?
> > > > 
> > > > https://lore.kernel.org/all/20240624063952.1572359-1-vivek.kasireddy@intel.com/
> > > > 
> > > > I've been expecting to add support for that, but does it help this scenario?
> > > 
> > > Thanks for the pointer, I had not seen it.
> > > AFAICT it does not affect live update.  The memfd is passed to new qemu, and
> > > the manner in which its pages were pinned does not matter, as long as the effect
> > > on the mm fields that we manipulate is the same.
> > 
> > I mean instead of using mmap's() and telling iommfd to take the pages
> > from a VMA you'd use a memfd and tell iommufd to take the pages from
> > the memfd directly.
> > 
> > Since the memfd is not part of a process or mm_struct it is not
> > effected by live update's exec() and none of these gyrations are
> > necessary.
> 
> The problem is that kernel clients (eg mdevs) use userland VA to identify
> memory when calling iommufd, so we must update the VA's after exec.

Technically no, they use IOVA too and iommufd translates IOVA into a
VMA and what not.

So if we teach iommufd how to do memfd it would also learn how to
adapt it to mdevs as well.

> vdpa does the same, if/when it converts to iommufd.  I cannot see us
> changing vaddr to (file, offset) everywhere in iommufd and its clients,
> up through the mdev code stack, can you?

That is exactly what I imagine, because it isn't vaddr already, it is
IOVA and IOVA always already translates to an area which gets you the
vaddr.

It is why this series can remap the vaddrs on the fly without reaching
outside the area struct.

Jason
