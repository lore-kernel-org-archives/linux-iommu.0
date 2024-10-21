Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2055.outbound.protection.outlook.com [40.107.212.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23C6191F8A
	for <iommu@lists.linux.dev>; Mon, 21 Oct 2024 17:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729531832; cv=fail; b=Ua7OpRcifx48iMj+8YZh66TLadkTH9CTEKOJ/YzI47fo8/hnd2tIGQ27ezcNAolLDlPMBBRzhsSE2xmbZhKBxCQDlWz5OTbUh4Dw1CQnLfwGFUH0mUlhMtQaNTBxGg5San4KWLPypHvyznVvdLVx8o5K81hl0UPvTS8QwGkTVfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729531832; c=relaxed/simple;
	bh=89ci+V/CUQjMVioRubPZwN3hlxh6qnmJB3IyieZkLgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OtY3qJ+dSnlBEPIx2goF0Ws44VN+0tvQhp4J5lXAUXECmSrltm1T64sbUv1r4pwm2E04r9jtuLlRlVgO03XFf9UlhRIbeNzT3s5NeFvVIOgcI0Mm0D3wCYfyjBC7asDq+nwJwGqkTZ+UVBbfKcLQQAoAxt9XD6iyV4MTNt2sPLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jIBV8EXz; arc=fail smtp.client-ip=40.107.212.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jIBV8EXz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YWqEGeIfllLoonJjMZBXU8j2ZewZ3ZfRVPNz43mjuTcdi56T+mix2zxXxmP0s8Z3pTvqa8ppJ7XnNTmndCTWeLQjmMMTcw6cdBZLED0taEFHHUxlk7EOz4yF42Ekk8bHWH27nCvdfTp+Hg610/H1EFU240/Xs3gwIIk+HBK80q+pAzCNHtPPYSvPHow03pu+noehbXUrzxdG1xUiLYGH9T0M2nv8dfvHdHNj1V0eRfU/+p9HmP1HGX9J30RoyLBvw6HsmWk7zue1FlITcLGQaQDlNy1GmWF2rfpxf/dIWObuBH/9pCU9gs+VRNWDJVOwQM74U4ccqpyRnfqR2zENyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RdUGDAXyb3ctBIxHKR+PYoHhmcjQ+Jqo8EgpbOu+zXs=;
 b=Q6vujEqMtrzZse2AzKX076me6eKOI7V1gkezBI4AnF0iMEnn2uaR4zn8U1mi4/Ec3VizFdTwQvfgzdZUEfcAjzTu53HMCLobn4P0yy0YWp6a68tSiUVMHMnCIT+AxCn/9pux8TKFNTdAWf5acUkymkxWoaJEkuonkBfKrNh7ej+QEOWtNue48j3czM0VehFUCrknWqDL9mZNpAWLev56ZjcMJqhXZq4bpG85TnUdSnSyyTQPHOaJniiNtq3qCw1G9MEbWEDTeelhgWWGQQLMUYJhAWTv/2Z2wRH7cogOt+hxKNlHnW3YgQp/YjAdY6rKkNd4+u5uT4tIyIuNuA/THg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RdUGDAXyb3ctBIxHKR+PYoHhmcjQ+Jqo8EgpbOu+zXs=;
 b=jIBV8EXzj6CUhiztbE5EAgt2tTYana4ptZ4k6DuoYg6Psj3CAmhGSc3vBk8tEZuzEnoOdFERaKs40VxftNKcTICnbvcoBsdsvcWLQQta94HRe8R6SLl5RyJ5ZGdxQPbOaGbdIrTd2GdQ7IHvOh3EB/XgaawxQ4cp6SaU1o61D92RtfX69Hd38H6+5OkMowGPmf4dJjjr+X8cEHuwgduzsQrGxlxn+iN8akUgERnL6O9GDU/wBMOk5PxITDdDFmzOI0W2ZHALSPrtZEfPT/IuvJFPvybLk9am8FzZ5pp7tIadz1xi6ps12V07plE1LEg2fIkAuace12zsG6pnoHpnBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB7827.namprd12.prod.outlook.com (2603:10b6:8:146::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Mon, 21 Oct
 2024 17:30:23 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 17:30:22 +0000
Date: Mon, 21 Oct 2024 14:30:21 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH V4 5/9] iommufd: folio subroutines
Message-ID: <20241021173021.GC13034@nvidia.com>
References: <1729286856-127844-1-git-send-email-steven.sistare@oracle.com>
 <1729286856-127844-6-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1729286856-127844-6-git-send-email-steven.sistare@oracle.com>
X-ClientProxiedBy: MN2PR04CA0016.namprd04.prod.outlook.com
 (2603:10b6:208:d4::29) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB7827:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a82a77d-5654-47ae-e73b-08dcf1f60acc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N9VIG3a3bBLmQlQ6vOgkyTsCJjBm0rmE/35eP11K5UyOzeHTMhJYsfdoiIcY?=
 =?us-ascii?Q?PIYaZmiK8baMyHiloU3hUOYvXwLD03j/7wxWIK75+knXejUs7nvMqltHAD/D?=
 =?us-ascii?Q?Hml/T0CQonOxj94ZLIVOpSg5usakL2I/m39cG2zcfRaM8eDrwRTW5pDxVsae?=
 =?us-ascii?Q?xmgQaNxUqkcot9I3LfZ6dnVGCCFICk9wGGIY+QkXrCHBAFfucC0mT1ohT5WE?=
 =?us-ascii?Q?VCIV5KC+ncLfa0Xk5bYPkVpvFbeefLHaw77qttX/ENgZOD7sVWJm3hqtvTmb?=
 =?us-ascii?Q?w4N++63BIvtDJ4seoZbWJOv4osS798UdA0neHUV0bP/lORGHY5kUJNuNI/4O?=
 =?us-ascii?Q?3kCivAUXX4ZboQ5o/sprhur3MXM/+P9XWEd3idVwC3Kcpb7Yhsr/EEnn/qzj?=
 =?us-ascii?Q?2k8O8lTLqppm1QUM2uyEzqUVniMVgYanoIrpz8CXb0vXoXvdrvfFt/ljIjQV?=
 =?us-ascii?Q?qMkDcjSAwjow2YVMEnpUUzsYyPazmgH2/xv9hU1aNM/u+TxML1l0sR6sXtMK?=
 =?us-ascii?Q?a5bMeJ4j+XadXCV5jlgUtgetOvctAaZVRd9jEZvuJdTU/dYZ0VTgWxdmnagf?=
 =?us-ascii?Q?zQxEK1ppKhDHx8lKFe0K/B5OwtpZ3YxjyV+OOgzODNc+8yrXllNs/MFe0UR6?=
 =?us-ascii?Q?xR2b+izj3dopO9Hf0gOefAD/apgFkHkGFNmWpENetMLSe/niVZX1R+oKAik4?=
 =?us-ascii?Q?588+e5aI7S0PI4ZU+wRCELqHDyIR8bYChX4Fj6z09kon256NGb6DNoxgmIbz?=
 =?us-ascii?Q?MaGCh7RsfUd+ImJEkEGlxblGDFTjka6+klZfOMkzli0c427YoK4+ef+ag9Ga?=
 =?us-ascii?Q?jnhskLGG4DdNYgmUOUwf5wtLUDyt3XZBE6sxqqfBbxGlm2S9D2RdeQuFmOpU?=
 =?us-ascii?Q?YZYIgxReKSumT+GONeqMpNpbaOMmmEXq/6hBkGfcKmjCxBSVenMFcWSfSPC0?=
 =?us-ascii?Q?/z94NZt2f+uiGMvjLIntNw72rb/Kfp3NAr1fUt4VVfWEjCCeA6wK1/47mcNN?=
 =?us-ascii?Q?WVVgVRY/hXH0dp8+LGgKt0GAjG6K4YwRP1iAy4r/vpznQty6C+Oxnddt9EQy?=
 =?us-ascii?Q?LKSktBUo0MOQlU3+C+eSP5UQIpCXqyy++qvrEipPftki39qSLQu5FvE3dqBd?=
 =?us-ascii?Q?WQxQFthieSsU57PWtR6E/hRrY99BQ7+5lfYGYkvE4bb/lBjTGdkQJ4uLWQoU?=
 =?us-ascii?Q?kNGnJ7TCvggNl3gTx7GKFzmk5UoCr3xQQEsubIjy+o87j4lt5HgYrnhYmPQ1?=
 =?us-ascii?Q?guSE6TXrmlzu1DwV3zYjOnY72pD2LDm+HAgne7h2N5cS5rEK+NMvciONXSfJ?=
 =?us-ascii?Q?8xhF0+6xEpQoRZ5HjKoBKN4B?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?giLugOVufRunMwrJ6p9db/UFHqPyEoY6OxGVaJeJejKznxiQjBjC83L8LY8e?=
 =?us-ascii?Q?RzTj99Pttrex0vCyewGxPEcDfl1YSJ8RlTNHhGNNdTzzDrwXvr3Z3hjluhyt?=
 =?us-ascii?Q?F2qOBO7l2KxJPEZSowOa4BveIc2TuPihYRfdS/Y/Nr4WUmOhK41UzMJwwe0K?=
 =?us-ascii?Q?HPd6VP8XI3oBa5N95WYTBwoj8fcjzEoZJKIlVqLhUwWYdns98wd5fZfLNsGM?=
 =?us-ascii?Q?ESW8TWEbIbv6tZ6O6hYXl/8NLUISzJfVEzGVe1iOBJwDSe0sRoyDPvVHoG0e?=
 =?us-ascii?Q?R/TpbFYNmm9hWaGFV54D1QDI5SK/2hew8jWdCPXY4aHwWLOJHnpMmNAi61lz?=
 =?us-ascii?Q?ja+UU8PsGl/mCT/KNGcZs3TH9s4HViyLAzNFf7f5yGJp8h8b0WGi7hDzR63+?=
 =?us-ascii?Q?TtEHDGiR8L++ubrJ+rU42zdbv7+NUOHN7XM4STpn0c9o7SGie4v81Ir41DoC?=
 =?us-ascii?Q?2sXZg99j5dzO+Qywozj34oTZJicXw3JXWIS2KeB5rZ2ptQokzQnMp/0L+eT9?=
 =?us-ascii?Q?jTqxoX5xMqbWSGw5qXof3XE5Oqmy8IlBH90OyooD+utLnqKX5uNb7UPtX8BJ?=
 =?us-ascii?Q?oIDxkk67q37xK6omgpMdWBYc/Sw3D+oogIzs8QhKSsTpJcmJm0WFA0hNTtA3?=
 =?us-ascii?Q?xohIbx7cNCtguGE5yHwznFTlrXuZpvhSs3WpkOgJlj027M4UMjRRmICNVwUp?=
 =?us-ascii?Q?nRO3QMpbXXWFiQw4FkcwLzqHj6NqYXsmCTFP8PGa9UnYPmYj9DkjtHpeHpEq?=
 =?us-ascii?Q?fEOepgOl65jluec38xabT+uo6VH3nl2rTdkn0iUM8Y+zLkTv4MIEKiStBQTc?=
 =?us-ascii?Q?WTlzfNHp9r1PQpFk8IVOrd2/WN8txgfQhul11lXS1vP3LjhD+LJTeQoGHQyN?=
 =?us-ascii?Q?aaUI7iNw16lRBA1D8oC2veUz3jsWyh/iD3HcoUjYZ1GZqiyH7EOOiNmzgDq8?=
 =?us-ascii?Q?RQ8zzKak8fujQMAI/R4vwGR331isSCQi/rOsinweqEgcPtHD+T535Xj7NtDy?=
 =?us-ascii?Q?WBwoK5OQET9522mmR3z4sLMGIcYHOHJd+Rd/aVvJ1ClfIEfC8sQhGdS6O4Oh?=
 =?us-ascii?Q?fNvXlCyfutj+ZkRJZbLH7HVzzQuyxas6VPOUDKCdCINWnSQ6fadVPIzZG7cp?=
 =?us-ascii?Q?ylgfwJJn9LRdAxIwIRMLa6IBs4FtJ1WPv6o4LFSGXzaF/JR4okYAFQQFYLsS?=
 =?us-ascii?Q?UNk39gwGAkqb4ZIUzbXvbktcx0h5KxbvC5uiEWuzIWS9x5Sa5VIDLv80E4H1?=
 =?us-ascii?Q?tv8PTtLg8MvI+S70yACvMgBbpPWan58s4jQC+B5bBXIlVyOeKwA+PnbEKO2D?=
 =?us-ascii?Q?sZND7WPBBhdPTfwlWD3R0H+A6iWJSJu+/bJ8uxra7K7jUb0sFnPFeiIHu6e6?=
 =?us-ascii?Q?sL9QJISjbdNPIeJnMU8HPrFSy3UpquAvKRAs+WE+D14Iba/ikweQYjh+fliK?=
 =?us-ascii?Q?I4lyA9+AnnmGjxBwfhfBu8EGi0vTFQtLyHzlgO8pivOrRZeLP8EpaaQ9zQcU?=
 =?us-ascii?Q?FAV2DxqKmlABER4cnY29l76UmxzGlMVLTQnpB1khNCsQ0yHmPPCW0qeQKJZC?=
 =?us-ascii?Q?6AAJW75fldeWr1LXV1TgaQs2JecRjLfuC8i+gUqN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a82a77d-5654-47ae-e73b-08dcf1f60acc
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 17:30:22.6775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dMw8zWgxUo3Pff5NxMCYSPAxCnjZDWu5WHu9s2L12uslhE7mmL407Ah/Uu4PHcBz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7827

On Fri, Oct 18, 2024 at 02:27:32PM -0700, Steve Sistare wrote:
> -/* true if the pfn was added, false otherwise */
> -static bool batch_add_pfn(struct pfn_batch *batch, unsigned long pfn)
> +/* returns the number of pfn's added */
> +static long batch_add_pfn_num(struct pfn_batch *batch, unsigned long pfn,
> +			      unsigned long nr)
>  {
> -	const unsigned int MAX_NPFNS = type_max(typeof(*batch->npfns));
> +	const unsigned long MAX_NPFNS = type_max(typeof(*batch->npfns));
> +	unsigned long n = 0;
>  
> -	if (batch->end &&
> -	    pfn == batch->pfns[batch->end - 1] + batch->npfns[batch->end - 1] &&
> -	    batch->npfns[batch->end - 1] != MAX_NPFNS) {
> -		batch->npfns[batch->end - 1]++;
> -		batch->total_pfns++;
> -		return true;
> +	if (batch->end) {
> +		unsigned long npfn_end = batch->npfns[batch->end - 1];
> +		unsigned long pfn_end = batch->pfns[batch->end - 1];
> +
> +		if (pfn == pfn_end + npfn_end && npfn_end < MAX_NPFNS) {
> +			n = min_t(unsigned long, MAX_NPFNS - npfn_end, nr);
> +			batch->npfns[batch->end - 1] += n;
> +			batch->total_pfns += n;
> +			if (nr == n)
> +				return n;
> +			nr -= n;

Looking at this a bit more carefully, MAX_NPFNS is 2**32 and a PFN is
2**12, so a batch entry can describe 2**44 bytes of contiguous memory.

I don't think we need all this logic to try to do 'min'. If the thing
we are trying to add doesn't fit then just skip trying to join it and
continue on.

The next empty item will hold 2**44 and that can hold any single folio
- folio npages is limited to an unsigned int.

One reason I bring this up is that we really don't want to split
across folios, like if you get a 2M,2M,1G pattern then we don't want
to split the 1G across batches as that will definately harm
construction of the page table. Theoretical because of how big the
size is but still.

> +static void batch_from_folios(struct pfn_batch *batch, struct folio ***folios_p,
> +			      unsigned long *offset_p, unsigned long npages)
> +{
> +	unsigned long offset = *offset_p;
> +	struct folio **folios = *folios_p;
> +
> +	while (npages) {
> +		unsigned long n;
> +		struct folio *folio = *folios;
> +		unsigned long nr = folio_nr_pages(folio) - offset;
> +		unsigned long pfn = page_to_pfn(folio_page(folio, offset));
> +
> +		nr = min(nr, npages);

Ah, npages is used for the trailing partial folio too..

> +		n = batch_add_pfn_num(batch, pfn, nr);
> +		npages -= n;
> +
> +		if (n == nr) {
> +			folios++;
> +			offset = 0;
> +		} else if (n) {
> +			offset += n;
> +		} else {
> +			break;
> +		}

Then this gets to be quite a bit simpler

And you'll put the refcount adjustment in here like you said?

Otherwise this patch looks like the right thing

Thanks,
Jason
