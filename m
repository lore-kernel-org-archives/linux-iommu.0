Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527AE21D2AA
	for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 19:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729192809; cv=fail; b=Ty643Vn/3XlKiali++ligFEJl01RLMN93P5wdN8f9gbjgNUufdoVSXcizYTibolt6q4wAohGoBk87uSE24fBhgZ1A9V5WdEsRkn0UvzI42HvvXu7PEoGsyL7MbE1a5OJxiIo8PLoVEKB3vmn0A7LBJTEE7tbCxJlflnNjEDX0eA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729192809; c=relaxed/simple;
	bh=ugk8V0AiX2pF/dplM+rlweGBhu8D+h6wNmW/rDnCirM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VcVOARP5/hJXezpDmzN+FtrC816iRwnGld42BT2D/6YzuQDoxBIcBfS1kFpOF0ngw6rn7ww2n9kwjJ8xyoiJQVthA+ZrxA0SKn36fKYoLMAbuAWsT05Eb4gmwavoFNwUGqk1QLLAqU3a/Y6zQHj02XARf3cYXFS3mv9VgCf2xuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pJ4lR0il; arc=fail smtp.client-ip=40.107.223.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pJ4lR0il"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jHqy+4KE+e1cfhJ6+7YCBWX8Si7vy1Pmzo89Pb5ULrMYfWY6YhrbFr3Qp377tlOeQZ0UD4TcZXm5uKeFN+Of7T/BDCGTd1R6pBQ3ehfzrHnIneFAobBBSAZWXaHe0RU9l+bAhaYpcEsZ8k+AfvISg6GP/G9IGZ+i+tSYWDRReLppq9EvyzcCRb2KC5B1GCBMFt/8mAXqaFupl1hZHe3N42lfizXfK1xnLtcaclY+O9Ll5B/76l+A9vJHHDqq4JTjxDkS1y48XSvuWJtgwD4hzj6dQ65iQf3zRkYIm3Tt15WfApCePB/85rQSQiV0wrTtgZmBD8RNgvA1+rXOD24Xhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RwCYnecQjTc18mpPd3mLcHlX5S6NsmmXS5VSAkbOqnA=;
 b=wQrRwyMLz5VsOSqDuH32pNs4FgLErWOcPWGZXDnjKF+tKDchdXjsLZ5tXIfDmGKV3MurPGvTesZeEM0QerZ1FUyHZ+WVaDywZvbA5ug2QLV+irFIid7wf7aj2tnrNl93zKkAjX32H7SgOLsqRo9b65oRw+XtDgw6B4TYDUu5N/VIqH1BiswOjJzU30Fmsj6SxObZVDjuIgSB56K3sV2yw4rDn5jF7sLrbuej/qOxbCMCarzP6lFUz6EEe8+rpJ/C8+dmZKynfqtC6X9xYzkjhm/uwT+Xzztdv1pfQl6kaxmQZ3b5M4qp5Y5hIN4t2xQDB1rAYQ1XuQfZvlcKx3bijQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RwCYnecQjTc18mpPd3mLcHlX5S6NsmmXS5VSAkbOqnA=;
 b=pJ4lR0il3Tj6bh67kiq+V4fBT8iQP7Y7S+hy2VWKP8bvhEtJZoQNU3mdITIhCoL9ptXg19kA2cT96c+okjeSe6ReEQcOQO589a+0yYxCs2JrnCt+EZxyu/FjeCMQ6ijqDLmWN5fOaLqia4pMfMw1VIE4pOymLdj9343cU/HM+J57giPVkAwYWH920rfoX7BDj4i3UhqX5qZQA+o53w2Fldg8dgjkG/+1ZhyzykBJHNpkVlw11E4GRDKMUGOXAbwPee7OVL0CBBaXvO7TxqM3bZYiaPLWOHDdzrhVfnsmCD2dO+0/LIETSpwlLN7/wirAn327NFp88ujDcRob83kRvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB8700.namprd12.prod.outlook.com (2603:10b6:806:388::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 17 Oct
 2024 19:20:04 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 19:20:04 +0000
Date: Thu, 17 Oct 2024 16:20:03 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH V3 5/9] iommufd: IOMMU_IOAS_MAP_FILE
Message-ID: <20241017192003.GB3559746@nvidia.com>
References: <1728067700-32092-1-git-send-email-steven.sistare@oracle.com>
 <1728067700-32092-6-git-send-email-steven.sistare@oracle.com>
 <20241016124147.GG3559746@nvidia.com>
 <664df84b-f2ef-4e0d-89ee-68bf5ee08c83@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <664df84b-f2ef-4e0d-89ee-68bf5ee08c83@oracle.com>
X-ClientProxiedBy: BN0PR04CA0083.namprd04.prod.outlook.com
 (2603:10b6:408:ea::28) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB8700:EE_
X-MS-Office365-Filtering-Correlation-Id: 26cc4725-e246-4c81-b78a-08dceee0b407
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mUgmIgBfRIxWhgK065HNMqRrQfe9cees8W9pNuuJUBwJaJYfYuH7q5suL+SH?=
 =?us-ascii?Q?0wgrj5xQjB+eUIbNn/tWeNkBq3RUrww8QDCjqjCf9fvzp3dmtq4pTg+Z2610?=
 =?us-ascii?Q?BFDH/geKicxWbJ1Q1obqPR3Q0Fuj4YEg6evPr1x2uqFcnK3Cpn7sdat5SbEu?=
 =?us-ascii?Q?sIclcZBlV6oBSv9Tc9AgqS/UH8wg0NNd9MbebFiO0gEjRgVfnU9z6zL08arv?=
 =?us-ascii?Q?52o9h144VfftrxjAcJZJqZDKRvh6a+llP4+ZzUDUq/9cFeuFEuel3Rlu0IRJ?=
 =?us-ascii?Q?H/Sq8zZgrLPMm0K8Wtbz2kT0wzQgwof5z4gsSQwAwDdvEhCmH6un68r4L04S?=
 =?us-ascii?Q?G6vflF4CKXDHDXjdktbIzPiztDvBhBv4+jQuN14/gHRS6M4/Zjo6K6Gw8J0b?=
 =?us-ascii?Q?p3IoovbKUVw8zpLeE1sPsH6WK4MAt2KAw7ccOsLJKv4DF8XXl84dI6nU5/RM?=
 =?us-ascii?Q?9b0gQQB1k9bJONU4zg5nlpe7Hy8gnjRpdq1/MCxVJwdSlmmqo86ug3te7tpw?=
 =?us-ascii?Q?IuwwG2YfhKko71SJghQOSYkIt1hWqeqG56vneEmgiL2OFZaSZxMDYUGpXjs/?=
 =?us-ascii?Q?lTK95Jex3ahgk3xTlobAzvrildGasq+MxW/OvZKb7o+JSSGt7QuTa4T3WOgq?=
 =?us-ascii?Q?WeUx5/1SEBytN+2sSzzTwTyVsct6FZuSpF5FC/q3Z+0KF7u3KsCWELkSQ1xs?=
 =?us-ascii?Q?iTxZIs3AbUl6Zlo4d5n5egs/BQP1BhCJ4pD4lyFwzdiqn9SM1JdblXVFI9WS?=
 =?us-ascii?Q?Yv3IZHVpYIHfu3SdkAnWWGrabbRxSjslEy9pryJ9EkuthTTL66Z8zWQj8ZIB?=
 =?us-ascii?Q?HybuVD2rB8Ztcp6Ez0zXem3cqBaT+KanXLoSdUa1qI7EvB1W2DnLIsJ4FH7K?=
 =?us-ascii?Q?Ky2uiZhhxVEScI/0iYkyGsDxqZvBA4YFoaKNtUkM2hs0lkncLW63OeVLt7QS?=
 =?us-ascii?Q?wqRQp3DlRGJR4+JtW//Wbv6FXU/vcE2/1rmh77GPOPkx0S9GfIWeE9x1gZXm?=
 =?us-ascii?Q?3kO90XyNDK+s0DuXBGTzA0RdpU0kxCzjJK/5Y2p6y1p+Yh6QZJZYez2SE/mc?=
 =?us-ascii?Q?A8C43WiWAGFdWn/h/P97UAnuXN0/XvTNDM0CkMBKaHkUQcBPRyxBkSnZVKgn?=
 =?us-ascii?Q?gZsnXIRrUKA2a4Ab6Wtm6glrzXntmSG8zsDLZce1XRxijZoAfZ/U0eonFcuQ?=
 =?us-ascii?Q?sgW8BP0EZGtoB2Pq3BiiKI9iNjrqT4lw5pa/HyjMqEkqhL8FxyOl8tC1+sIV?=
 =?us-ascii?Q?JzlndBPUOoRR/1NDyulU+js4ft7j9PeQ6z/8b7BeTy14U4BIuV0YZKLUIuPp?=
 =?us-ascii?Q?z+w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QQ8gIXg80nDijAJkgRqAYOK/boEUr8XbWXdM5BMr8UAHQLVMGS5wBXkJFG7D?=
 =?us-ascii?Q?9XQcQQ9KTgKmIXH/48FSFeUfmtk8nTvYiIIB5lDu7PK6BgbkXywAo2u8mrK4?=
 =?us-ascii?Q?5WmQ74VUTbLDrT5XwuNP55znb5TiNGCG2hV/LIvHTJ+o6CfOeZNXoNs2Nb1H?=
 =?us-ascii?Q?DRgI+/wPwlNlvHoTPdP+K/9i1lUFGM2h7G75MON2mDxIQpVhG3oKe/lz0GHV?=
 =?us-ascii?Q?UZX2I/pFfTJ0oH6mIzFjG6nBopng/VHozqOeCnzz1mGzaoBjb93U2AkCx0tO?=
 =?us-ascii?Q?MHLJV7n1usu92D3833jzQBz/DWpI3o1RjjXmXn3pbI+I75DXDWRmCeZ2APY2?=
 =?us-ascii?Q?DmjuIv+OdHH9RRqaaqFdrHtxJGy1FU67040XW/crqXBNsT7LL/KRlCqhM4r3?=
 =?us-ascii?Q?l9GTn7z0/8wRuRXDVogm974W50eFEIOYCQ+BXUl2+Ul1Gjhd358xoPlmH8xE?=
 =?us-ascii?Q?GF8nCUzOpDlyJb/do3F+hlNNB8q6ZuxJ+bOTXYnrbfVZlFIYRBqgtL2c7uXm?=
 =?us-ascii?Q?U3g6mRgropXANQSWpIJJ+8F89xKvVwrapsfsTFv0xNQ+7iXP5O0lMRMoHhhq?=
 =?us-ascii?Q?oBaObT6hylDLZWZxBaImK18x8QaOX1/n/0cGJi9qSdevtT5w3jMByaIIXN6Q?=
 =?us-ascii?Q?TSZ7UijBwnv52yJ18tgrp8eCcsuzzwdX2gg+sO0Hje9nyHti4hndMk0AlmqX?=
 =?us-ascii?Q?pGI9YUSI8HLoJPow5OQwm4Fqh+MSOLD0bFrabmhzFOI6JFrlHVGdFv4K8T0l?=
 =?us-ascii?Q?rxiscLXxcfj/b36eJ4b1akv6oQJ4edMDK9jsvUdecXwaIj/cIV+vO3iTeVLn?=
 =?us-ascii?Q?WW/fkm0JYT9Bel5NtA8ZDy6I5kKoDaIqrolzZ0PJSuNvLm7P+wCQ2CinHDr2?=
 =?us-ascii?Q?YKSl40C0TZ8emgB0soK7zu/KCcJaiqKMpAshEbdKA1k6ssXd3uhAaxCEPbhN?=
 =?us-ascii?Q?ar2/dOTtm62r8L0JG5vnAk+jYH7aURKNjRghHbj8u0neWQIhag4qcgllFjtr?=
 =?us-ascii?Q?EYHYcH39yt6J4RJ6E/wOKi3JPibD/5CyP+24c+Esd+Hp7lywJYX1cyx8NLvx?=
 =?us-ascii?Q?spA1OSTsflME/FJHriVI6mumfEo8znBbNGz2z+fSBr0W0MsjW1YJV7cRclUh?=
 =?us-ascii?Q?pTTaP+VGs68tNvMs+OHTbpOihucUMsZ7jMctxfd7F5XY0qf1BDlqvaXzuZ6L?=
 =?us-ascii?Q?CAv0rvxVjrl9jfk5TKckNfZ00qdsOxTYMOGaqHgmgyRP+uIAIddeMsDI8bTn?=
 =?us-ascii?Q?enmtMY5RaRfy0zVyEMqewyk76eEAEmqt8oAgdO6Er/RqRZY+NlJORxR7F/OL?=
 =?us-ascii?Q?G7/6gLOLFIlvIA+poJRn21QZcRDtrjqM+DnSG37C2DMU7gq9aV0DsBt9k6vm?=
 =?us-ascii?Q?f+jyEagJoFCXmivqerPtamM7Sz4NWR0zIVEHg7HAahMm0cOct7g+adOhfaRi?=
 =?us-ascii?Q?BSqPlrN2OJQuH0zabZhYu1u2RCnoUtRMc4fBEOwcSgrWYqb5NJ0QT3By2mFo?=
 =?us-ascii?Q?D36+IX5YnORf6qQ/SRstGlOkBKx4rLS5DLTXwdW1qtciyyNcSJgkJtQ1rpkE?=
 =?us-ascii?Q?roGP0uj9BK2g35pTWa0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26cc4725-e246-4c81-b78a-08dceee0b407
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 19:20:04.1769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X8gfHiCYx5WdBxszfD7gkdqQzfTUbTUPL2cD7FhlZClOiqdMf0bTYISl8oMzODlF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8700

On Thu, Oct 17, 2024 at 01:00:51PM -0400, Steven Sistare wrote:
> On 10/16/2024 8:41 AM, Jason Gunthorpe wrote:
> > On Fri, Oct 04, 2024 at 11:48:16AM -0700, Steve Sistare wrote:
> > > +int iommufd_ioas_map_file(struct iommufd_ucmd *ucmd)
> > > +{
> > > +	struct iommu_ioas_map_file *cmd = ucmd->cmd;
> > > +	unsigned long iova = cmd->iova;
> > > +	struct iommufd_ioas *ioas;
> > > +	unsigned int flags = 0;
> > > +	int rc;
> > > +	struct file *file;
> > > +	unsigned long end;
> > > +
> > > +	if (cmd->iova >= ULONG_MAX || cmd->length >= ULONG_MAX)
> > > +		return -EOVERFLOW;
> > > +
> > > +	if (cmd->length > 0 &&
> > > +	    check_add_overflow(cmd->start, cmd->length - 1, &end))
> > > +		return -EOVERFLOW;
> > 
> > Why is this here? iopt_alloc_pages() does this validation and I don't
> > see math on these values between here and there?
> 
> Since the refactoring of iopt_alloc_pages into iopt_alloc_user_pages and
> iopt_alloc_file_pages, the former checks for overflow of start + length,
> but the latter does not.
>
> To make it symmetric, I could push the check from here (iommufd_ioas_map_file)
> down to iopt_alloc_file_pages.  Or, hoist the check from  iopt_alloc_user_pages to
> iommufd_ioas_map. Your call.

Put the check closer to the actual math it is protecting from overflow
please.

Jason
