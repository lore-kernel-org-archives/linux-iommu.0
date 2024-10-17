Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7DE22738E
	for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 19:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729192840; cv=fail; b=CjcpPJnJp1xdxDUj7jiVhDF0k5N1h1aKW73dBAUiksz5YY60NEOa0pHtD0jIGX2n1rnEVPG+TzdB2wnADpQkZVTv70xQfzeNI6C+ziXa538/pYJcyXNkojQA6PSX93Gq4Lt+ahhRc+g/zz5n2xgEe4/6USn6kmFQMWDhetMAFjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729192840; c=relaxed/simple;
	bh=h9s0c6xlQPUOUZ91ttqXaP2woqAIMPcWiOe6a9xci/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FC0M7MQd59ypirl6a1Lh7R5POnaiL4tyUsjCV/hQYbvrC4Am49tBJu+yNtWwK2kZNVGBi9YpWQKzjeLWqBkAc0+PDBwJuelppiMZg21ilj/eY4LNmMm3rA5Tpqd5m12C/Q3GihDU5jcitQNUp6+bo79IUkYzk6wlGZRMkeHxeWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QuOsXEYb; arc=fail smtp.client-ip=40.107.223.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QuOsXEYb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eIo0/5i30eqjeGnWOkhGfSfrgrmraQQ/bVCAzPcO7qVmlyBiLHPBnvC/r34zvnJZe1p1wA7KeHnSpBhCXwwquysUaXA78ceRwgpyoFFisGFEWqsji1DHeIE9V6ETjdzriLux1HuGxRa8QbpM6Q6O0cJdE9wt2fYE2vRCgAcVEO1ErPTeHacAjn0pGZxQ5S/bDoQSH7/y3ArzZGh+8shfPor9wVs8eKY0wjHc87oWYgtm0KHtnOMB4KlNlTZ5Egx+JM6Xv5ntVzk2Rd9Iz087Uft6eECSF7V1Wqyn1fwSbgkDDKoRBVe6RznYQT4yodPrmkvzb2bfh2TmU3m0pT2XnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j5iRb+VWychxq4YhlVyROnpmkovmOUKOl/c/knfJoCI=;
 b=iN8ohxZ8+NHzA7XifR53g+QT8SiTaWgTzrduDC4Ho+414kuFojjpkUlnQu5YdkuneQFgscAXVfW7OMwMJ2pOaM0OXlp9r6EFWec19Nabv8kIyDOzRmd7UTBcxUCgWBzI7dlQDZJ6YU89dtHi5aauGsuyS50DIVmVQwFAnP5LmX8NXYxlscLaN+csppmZyo448x+3kX8KItCSTxFrQFV4x+o8dqWgD0daALLOE767gQRgCb+igjSdAzJK9P3OcbHvHAI2F5x75Ei7iYXlV5NJ6V6RaJK3r5B2x0GnUkjDdhdu1BuHPzICG/hKQc3HNNt5lvH4ucvS5XdNfIM0rDze2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5iRb+VWychxq4YhlVyROnpmkovmOUKOl/c/knfJoCI=;
 b=QuOsXEYb+dHW5owonHgrm9EB3pHSx4bhkxYJFvaIa46O8vG0jT+7gnH5w+40+Vu+zDgRDnnVuKp7ED7FReaefIoB4bIWLz1pxkWjo4tMkLDS+uybXiBzJYwYAbCx41EqYJL8dTcXL7bI0XWQHTJPOMZs898MehbgMbrgMNiof4MryDqr9Jr1KHzmY1p0MNtHlNjwRo6Atyeou5PpOSfuwcloIPBh69HbvUazPahhpX9+jl2Exj3eLdwVehxDfE3hvu4bTxnNnfXFuEibL6Shp4qZ6+79sV21aqXnJZImj6ygg/53Masyzg5J/1krge6fey1Rg2VEj/KuIfK7GYrtVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB8700.namprd12.prod.outlook.com (2603:10b6:806:388::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 17 Oct
 2024 19:20:36 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 19:20:36 +0000
Date: Thu, 17 Oct 2024 16:20:34 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH V3 4/9] iommufd: pfn reader for file mappings
Message-ID: <20241017192034.GC3559746@nvidia.com>
References: <1728067700-32092-1-git-send-email-steven.sistare@oracle.com>
 <1728067700-32092-5-git-send-email-steven.sistare@oracle.com>
 <20241016123716.GF3559746@nvidia.com>
 <1bad4f41-f030-4963-ba15-19fa0ccfbc70@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bad4f41-f030-4963-ba15-19fa0ccfbc70@oracle.com>
X-ClientProxiedBy: BN6PR17CA0045.namprd17.prod.outlook.com
 (2603:10b6:405:75::34) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB8700:EE_
X-MS-Office365-Filtering-Correlation-Id: fc2f8cbb-aa94-40d8-70f3-08dceee0c704
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+GBE2go6GX1+5jGXjTc7TXUcTTvMpbjSFIOrSRSFGsf2/vv15bCLz8Zh/8HQ?=
 =?us-ascii?Q?Ta4N0xi3Fq9PO7tVL/gQ0T8K+rdVRZmobR4Itbn5nzdvCR3QY1GPMjfwzgCy?=
 =?us-ascii?Q?iG02AH2UTZCi8PCRBBSck9lHLe1zuV9pWTpUBrN4Px7wdM68KzSx/Bjgo0T+?=
 =?us-ascii?Q?ICX7X/EvElC54+hAJR5bCgDgrmzkPOE104MpPo+WwT+Vr/5QtsY/QY0URXk3?=
 =?us-ascii?Q?gUh4sm680pw/wbSIIvVGU+Y0LtEvaHi3FZWSlUXBaTId/AMq+mYKdkt9o3r1?=
 =?us-ascii?Q?ljCLtT+pZFMHB7AthD/sBB5bt8K4cObpaquC3s+vAuSDG/j2VGCdXlpgbGeC?=
 =?us-ascii?Q?ScSgvHO2JPJT+Mzc0aJl6CJrJxy8tEq3tcfoC90N0EGq4EJ1SbjEIFkc8m7P?=
 =?us-ascii?Q?KVH9Pni3fMIrY9KlrbNiy/NQ42+fiVDrVB/x70pj7j4tGgiZF3hKZFZ4NK3Z?=
 =?us-ascii?Q?GZm4fc4LS0qPHbEU+9XLJdmUqdPnyyTtCOHZoEtgi7YPd5dMR5WbGwjLs0E/?=
 =?us-ascii?Q?WLwWFImDZRK1yTmjLXzCgho7LVHERwyIGSVmrC8ZBTT6MNNS4uPnuHoAS5wZ?=
 =?us-ascii?Q?RTPX5TDqIixK+Fg8kE7PjR1XL9mVr4G0x9IRxV/BelcsD/xwmrIAfBBYBpeM?=
 =?us-ascii?Q?6k+iMLyNvYbkIU5bGgtglNmVwXNW9ywFQs4CgWf/xeD+4HI+2FoZx1pEXNfj?=
 =?us-ascii?Q?AmBj1SlPJhK2HoZljWYzsMfvPiVnc0nXgOHCl/UpVTm/wPQ9u94ouOsB1A29?=
 =?us-ascii?Q?tScILBURQz8IYs5eZpwa/mfZB+yRnyZJ+ZGYTRwB2osXAhgfCGUg9QGdGKPQ?=
 =?us-ascii?Q?x2H3PS2BYde48NYummXI/2zEslXJasmizdxaXDyW6r83n3fVRvC1W4H0xu20?=
 =?us-ascii?Q?I+FB9o5dfh7LhKKPP1CaWGDgbYy/DnFFdOgO8uGO59RoMorgZw906+rwO3kd?=
 =?us-ascii?Q?SkIn34lvDAiTlrtJSPiqiMQCzTA6nGND1ZN7J1PhzcmHs5eDjRtHshYAatr4?=
 =?us-ascii?Q?ERlIsLbLgOkj8lOTtex0+APhsEDl8HhPooXcNw8kCjUWSyy6k78WKb4oIGPg?=
 =?us-ascii?Q?CRmPOoHDV6hP6ESCagkL4jYbMsNh3+8fJZQ4PQXych2iwVm1Cmz8IIuMLh3V?=
 =?us-ascii?Q?3/CZ7ypDE1ZnB64gqjDLTXEodMKTXag1WPP3gTOwxYA3Dj4FgFKqR547kIe9?=
 =?us-ascii?Q?5szbFFqyF6o52nWvSajKc+UL0WHH/FlxqP8ion6BDBXAAWeYIYZyAisC/bp7?=
 =?us-ascii?Q?FksZDwyTIKgqxEbWXDiE6VXJvTLAQVxnY/PfOA8F7dSWlQi9cznx0sUZsih3?=
 =?us-ascii?Q?YNpG4BieCCnGsbmV5FA5EqCY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ismBfVzRgWWmtEG3M2WWIoGUrUzl6/d9KZVl/+FtWrOENClQgaE7tfzooF4j?=
 =?us-ascii?Q?KC9YCp08OEe8jbcs1o0ZZqelkClFB4ktJywIFR/EqWZPZDd1G6TGApo84CQe?=
 =?us-ascii?Q?XpV6xtrJhATSxIfwkBrkbjkgoBXU8QHa7UI+26FsHAkNI59kefdSYP0SQhpu?=
 =?us-ascii?Q?xrOd1qV+4WcFa1FrQrMUP59/k1CGgbPd/OiHEsVuypzlDClB4rFfLUEFCQ3e?=
 =?us-ascii?Q?MxXnVodQ7dqoVrSHuUfxcxzsha84JFQZim/tKOOlCStqsKKu4ZHUqrDKp6Nu?=
 =?us-ascii?Q?wb8dadcU5KN8ZiUf71BytdkkNWZf179s/tROdW2cDcn6XDZL1Z/P+MxUpYGH?=
 =?us-ascii?Q?sYQpZJeqXBNfMoUUV6XCCS60qwX4F50iYvi0OvB1hZT/HutiCvQsjzORr7jv?=
 =?us-ascii?Q?JoPTK2PNr5rPkXH9YfkWvLPwoyS23LRqQRXru4up+R1kODWbfrG1xO/dtoaV?=
 =?us-ascii?Q?aZ4c1L54jKsVGzZy1dK/YonqV7JZ02ISUTehuxZuXMFC2cXOIxsFAoeURWd8?=
 =?us-ascii?Q?bxpfteAUPaN2qh48MVE6cNOk9X1jFlbMaUoBjpbV5+XPpaRpBCqRqWE8xbPO?=
 =?us-ascii?Q?zq7qe2wSjkwvtiNQfUv78M8b7QOan6SEH4BeXI7c2tPprya4NDVbyW6xiC/n?=
 =?us-ascii?Q?w8hKcUBVSm8fX5SBZKum+bgkXAt01pucn1eryFxVMeAK6pMV427TBVggIjr6?=
 =?us-ascii?Q?fuUyvwJlZ6LWTVBKUsE28qnJlcUehrs4GQ5TlyKLzOdM02fPn4M3qs/Oy0te?=
 =?us-ascii?Q?lAXZPOB9KaXj+kQBUnHfqS81py2GzOQDghqa1KEHaHNsw49HCTyobnTxdpkb?=
 =?us-ascii?Q?OAjLy9KRinMy/R9CtZFmnmGsKBqKmmdoPEBikCZfvn934fVPZHcm05lRHW5N?=
 =?us-ascii?Q?8LXdy2l/lWMwVQnh0lvNMQKLrCR92myBlZwlIxNIUcn2Uio3sOp76w5nRnGN?=
 =?us-ascii?Q?5Xyn+XoTWLQFCk3t0Z7YC/Sx0jsLDRrItQ9CLm3XPevQ6CBYdyFtiaWyHjD2?=
 =?us-ascii?Q?lIzk/aP01PTSdsAILSp3P+SAQOCU8hWKe3H8MIFoCSOE3I7xW4nG+Irqmarp?=
 =?us-ascii?Q?LJZ1VEeWXTFD+OUepukKRQNL8/+uYvttJ6Dw8H8XC0ZTy2f9tDF7+dgUX5cB?=
 =?us-ascii?Q?taUJpPECIhNm+ZJVYby1U0HuAhlLwBadVBFTSoJaT0Y0rkDTa8ldv31f7q4P?=
 =?us-ascii?Q?Qhppuw9Yi1GFoY6Yf8JyzqQGDID0hO1MqkaNx7IbmPM+Vj4e4LLRnoxj5Bck?=
 =?us-ascii?Q?Lo4TMaM5WIgbs09MUvtR0uqb3tOsrVLjlVZMhIKzpi/22valZm/NrWZImt3N?=
 =?us-ascii?Q?7OMjftUCCXaLXm+3zORJwC+3nhKbaEdbLLbPDofIjxMgwKCdQYXLdzaqkCdb?=
 =?us-ascii?Q?hc3uyWkROJCzUhwUI02EGPaEq9JY6BdGwZKxQbYtdc2gU3rhQBFhZlMlXd+v?=
 =?us-ascii?Q?VPdhSLG+DXYfwSdEBtzql4wGpkHH4oU1PULCOsFb96rOcdUdjjUCNHNRhUJa?=
 =?us-ascii?Q?4dKdhME7WTQ8EVm1oIyNtHIH8ZtqFZ9Zcu+IF5q5cndrOt1rFpmsOxviwEl5?=
 =?us-ascii?Q?M6M0EiwnvqQvxHI8T6o=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc2f8cbb-aa94-40d8-70f3-08dceee0c704
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 19:20:36.0077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zFSP+Wkf2z5kOPfMWHWrVStPcFtefEJ026c9u0UAnixTNv/uXKXNSv82027M+Bf/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8700

On Thu, Oct 17, 2024 at 01:01:02PM -0400, Steven Sistare wrote:
> On 10/16/2024 8:37 AM, Jason Gunthorpe wrote:
> > On Fri, Oct 04, 2024 at 11:48:15AM -0700, Steve Sistare wrote:
> > 
> > > +static long pin_memfd_pages(struct pfn_reader_user *user, unsigned long start,
> > > +			    unsigned long npages)
> > > +{
> > > +	unsigned long end, nr, i, j, npin, offset, npages_out;
> > > +	long nfolios;
> > > +	int rc;
> > > +	struct folio *folio;
> > > +	struct page **upages = user->upages;
> > > +
> > > +	nfolios = user->ufolios_len / sizeof(*user->ufolios);
> > > +	end = start + (npages << PAGE_SHIFT) - 1;
> > > +
> > > +	nfolios = memfd_pin_folios(user->file, start, end, user->ufolios,
> > > +				   nfolios, &offset);
> > > +	if (nfolios <= 0)
> > > +		return nfolios;
> > > +
> > > +	offset >>= PAGE_SHIFT;
> > > +	npages_out = 0;
> > > +
> > > +	for (i = 0; i < nfolios; i++) {
> > > +		folio = user->ufolios[i];
> > > +		nr = folio_nr_pages(folio);
> > > +		npin = min(nr - offset, npages);
> > 
> > What happens if all the folios don't fit into the upages array once
> > expanded? It looks like they are leaked?
> > 
> > I suppose the later patch gets this all sane, but I wonder if we need
> > this inbetween step?
> 
> Yup, I missed the leak if a folio is only partially converted to pages.
> The optimization patch does get it right.  I'll squash them and reduce its
> size by making a separate patch for the new subroutines
> batch_add_pfn_num etc.

That sounds good!

Jason
