Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2044.outbound.protection.outlook.com [40.107.212.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DF512B73
	for <iommu@lists.linux.dev>; Wed, 19 Feb 2025 13:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739970661; cv=fail; b=BjMdB5HRus64H4LkkBsdUSjXrfPu9PvpeGm/4IBJjGYDtMiecUgJf291SQmy4OgltrJc/ZP1Q/g1aF/HozQTtteqt2kI879l3f1gO40MMYfqy/Fc6onWUIRuEVK0ttyldCoGK3nE/fCAMUtERVP5dYJ/GekOG9WOW0WS1/1QlOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739970661; c=relaxed/simple;
	bh=UdKqFeG8fm3SqolAT6ZBKoeQXhSPtIQ0yhW0iMc/0Q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TBJ+0zTbNpnN6SdQtisySY4/B6d6rs/lhJKvdhrXIMoUBVtAprrzu3YDBJoTbwmCrGYZJJX0Vt1UcMVS72/tNOHV2C6FasHSq9usfR4XZQsar+ajyruib1GRFCrCDfQKGUGilJi3YUCKg/ekrwSBCHWezB7oeXsXjQrEwQz5D0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mXeZlcE1; arc=fail smtp.client-ip=40.107.212.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mXeZlcE1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rsWFoeCtSzw5Bh5EIomGzSE58kZ6aISlWXgE0ByAcYXrIT+1KxxL9555g60Z8zejmWfga3YsnxxWja8aep036dQcIHx8myX1u7A1wFpjrtj4RhVmIOnrTHJw+2206iJuB0kmTkej5E0Y8TcUjhxDFcNJ+BowQx1rQO1RrOK9xzmhaHRu7F8WJGVV/E0vMtl0WPiAfBpUFDlXDeATpKwNkfcR7RmiKxktDNpD1z/5r89/mF2vdCs//ClW+gY2gIQ+8DWbR6jtbb53vBrotCACDAV9QO4UZ/q/ZhHRArvtlGdvWLHdIm7fJH27fIm/tO3DGRqwNNUm96HZokcj6L1MXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IupRwKjJALYn3NklFR0BbmWNYZSAlndXwfEBhkVNiso=;
 b=ra/rk4XHpZcX8//m5TkZstI/uMobubplPSmRyyRNs0Jgkt1FqrUIzPRJwIRiVoobCZYKAufbTIBJjQ0Lc/qNGdGGLKsNMwdWx07IR98JMf8Ne9SvVHpTZOuNPoW4BcNzbnuXqRn8k4X2g1nI6X4DA9C9mQV/OWfd3RnzNQStvRt+YCnYXF7Yzcqdf3ik2g9ULNXOtvasnd4AlpOe8sHuhsxwIFrRdowAv9oxr+lDKo65iazvDrU0EHCR9uB1qny2l917hf+JxCu+OWJJlPAV5owHMxJ4ncXVZg10J6Rmr25kogjdy3g9bHo8GngOnyyey9pLrAC1BLfj99RRq4CFtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IupRwKjJALYn3NklFR0BbmWNYZSAlndXwfEBhkVNiso=;
 b=mXeZlcE1sCyMimIvN/40PZOdnXwWH+TRMT88s3fqD9wbt5mfzpWifrpZSY97a/anDga/r57xK7uivVQ3KIHuW6elUoDgHVfmaMAJckiYlJurNWStoRZxG8RbbQ29omGSVY5WGLMqUHlZVBAzsJlTPhpLBG8hmZfoZobNrnNSEF3YPvf2GSpjGjkHMaLXlajujjxuiW6ywj5R3k9lnTYV+zrUlGsioAzOjcCUcwhXwiEWiF8ix4dzfANSifkiHjOAVAo7yk71faF08T/De0IIVHtPwPtHxCZGwyM2MlqLNsO5aiUZ46wlEPShNxwalWdazocHBmEhbbnMtdHUhwj83A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB7197.namprd12.prod.outlook.com (2603:10b6:806:2bd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 13:10:56 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8445.019; Wed, 19 Feb 2025
 13:10:56 +0000
Date: Wed, 19 Feb 2025 09:10:54 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: joro@8bytes.org, kevin.tian@intel.com, baolu.lu@linux.intel.com,
	iommu@lists.linux.dev, robin.murphy@arm.com, nicolinc@nvidia.com,
	will@kernel.org
Subject: Re: [PATCH 5/5] iommu: Retire group->domain
Message-ID: <20250219131054.GL4183890@nvidia.com>
References: <20250212060540.261436-1-yi.l.liu@intel.com>
 <20250212060540.261436-6-yi.l.liu@intel.com>
 <20250218193909.GF4183890@nvidia.com>
 <1df9b532-1b42-40da-8499-503f53ba8998@intel.com>
 <7a6bd064-afec-4492-b703-f076c50d41b1@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a6bd064-afec-4492-b703-f076c50d41b1@intel.com>
X-ClientProxiedBy: BN9PR03CA0404.namprd03.prod.outlook.com
 (2603:10b6:408:111::19) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB7197:EE_
X-MS-Office365-Filtering-Correlation-Id: ac832b08-f6fa-4b08-0673-08dd50e6d81d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OzBu45wpyby/vLMzku5dZBqBFPQkDdOLKAcCkTaxjvyxZtp2Jdvdb9GVoR9M?=
 =?us-ascii?Q?wVnToiUec2W8X/KTOQgRlHx4VjXQtZ8A/dL7OKQxqtls/QDR4/e4QxuHj6WR?=
 =?us-ascii?Q?APvDyFQzJLY5+5PCpLm4RDFpJJNKtyv8ozbY/Vco6hhnOhEJZkMLqMZKPuaC?=
 =?us-ascii?Q?bFqV47xBUzBtzVwhvjcCuZe3nWpgKdMpKWF421ZAOG8JDBHvuirN49ECd8T4?=
 =?us-ascii?Q?0+ZxKGpC1KFm+5G5KqSlnxU887EIDdMRFNwmcvrS5kYjJPE92TwkZsKNz3k7?=
 =?us-ascii?Q?RqsvXpT3cBYHnSPyfhTj8O4JSfpxjbOC2O4kCVoacepd0a0dfC8vStXteQvs?=
 =?us-ascii?Q?eDPRnPZ+sqbG3HT6SYIVedG6EfEavctXge1nXwKPVfUEz1vAJQIkqU0DVcWt?=
 =?us-ascii?Q?4+2789CG3u5Ww7LO6cqEz6eCNDBAEuFNmpbdUbtM7zLKAy7D83K4tAMEr/Z/?=
 =?us-ascii?Q?I2AazYnBo/ihwkRLJm8comEXmdzvcblRvGrb3TfT1EodFTAu/rkOe5LLCwZK?=
 =?us-ascii?Q?CwzhT3cDVW+f1mkMWLnjh5praR/2miKcIZXUrdJjhNdlTKggnxkbHOrid6Om?=
 =?us-ascii?Q?c/TbQs7hUpZxU9NTysMQKChhaVXHAWBZ45jRUitWrIKOyWps6GoZ/CyN3bqQ?=
 =?us-ascii?Q?Sa9+dmJ5HI1UyB5IYgiir4P+ZMeddB5MpLQHLYmsAvB/QJTKMLTZHGZS93YQ?=
 =?us-ascii?Q?+GRWLuXz2QjHdKS7HTU8wKOQkU67lH8Th4EuN4s8cVxqOKA9KmU42/6X8M8F?=
 =?us-ascii?Q?GgAjy7ETFaRJaVxg+mbXdZBrDYRyY0wt5w/arjqJ2N9F2Sh/3pLJfyHp/Mrg?=
 =?us-ascii?Q?6fY5h9hRwTgahT7Xe7HAnKkpeL36ZEqPLIEK3ua4/x0VuIXlXlqgLoUbJCZV?=
 =?us-ascii?Q?S27qSmUAQ9qzcCNhM2B6K5AeYCVofu8VgUxbpLaLhD3IjTYkH4ThFW1uZAuf?=
 =?us-ascii?Q?t86S1Kkw9ItSdQuHA4jrTu7151xSJ/QTfjSq63eIWk+QlXitwo/I+9mz9i0R?=
 =?us-ascii?Q?6fVQ8NArJmQdhLN2dI9HRxgIV7c0quiegnkGa2S6C4tzrmw4wmdy87rPFYaN?=
 =?us-ascii?Q?Cv3sM0TpDEv13ytstLzU0OLEnpVTx4rhbzskaY8umVamDmbXbXpbfXciJE/c?=
 =?us-ascii?Q?E293kAkEStUc5NyGVY9Zpw68lIE2EmhtWh6oQr5c5iIw3pCCv9KVQslDjq6j?=
 =?us-ascii?Q?PIUhWa/rromV818QK7a7R1BnR9PcRcG8CW2Xr96xcVaKAkBheVVzVPQmE51e?=
 =?us-ascii?Q?VE9yuodMLj1j/QtMvyTF7xhATiuuLeXzq0lcbRnv8mZU328QNnouhGEou1Cr?=
 =?us-ascii?Q?BBrXCChhRMnS5CY2kn3kOTccXSKpqPgezYKws9MYEeQGWKTmQb7S3NOY6YK3?=
 =?us-ascii?Q?EarVDBrS9UOgtExa/DuBCEl9tozm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vwgI7/hMdlkcCXgMMj/jDS4NGJVQzFJYwMfrH/xcjPq2hY79pnb84wui7U3z?=
 =?us-ascii?Q?6ezMZZVuVYHahZkn1TGUCD8qbzC3vkeucJoRKBRDRDI/0SIM3e5hbbnev+Ru?=
 =?us-ascii?Q?FFPtQYdkKspHyv6dut2arIXxreV7zdZECiwLll4jZBCpGLsU/hj/HcxDWsBg?=
 =?us-ascii?Q?VEG45ti6B143Ot0+iZwZvLnizt0Oj6qH65E1LItTO6bD/1vOkLyC2uECPBr9?=
 =?us-ascii?Q?6As17I3XerK+Ha216vT8+BPjA7IKtd5kCbYf6JP63YWCsgKEQ5FTpERksT5Q?=
 =?us-ascii?Q?LIXeYqo1zpyBi6mxpCPUS2byhCgu7XTvGX6AX87YvP7x3qx0CWcr+iUpjcZv?=
 =?us-ascii?Q?JLczWOeM/DsTldRZi6B3XAkUhVK2P1e3zWkLpkoVrJ6apDukK4E//5ElaOIo?=
 =?us-ascii?Q?p2tIP7Q8xWaeiWAH9/Ypb3dCf8DyryISTDERBdkIN64Cs7I0me9isSxX6Jwr?=
 =?us-ascii?Q?egXwPP30E7/d6OsrsY4tUdf67mR7lmXkpOaZpuNpJRA7RjxjUIxweENklZCA?=
 =?us-ascii?Q?yNsxVD11d5w0zGqeA5KGshtX3Nyk51vwtG+8ljwERKPst+s05uoPMgcrNt2D?=
 =?us-ascii?Q?j+Vag6uQiTEBL9VCD6l03rmsJtupsaXgEUV0b4EzAyd5nHZjxG2A79cR49Sa?=
 =?us-ascii?Q?SKtW8gfHtCGH9RX/jJY8e9w6MVbH+SKwS8TN326E4VWrKTR+X0jrTQyldIpQ?=
 =?us-ascii?Q?aOH2aUGyamgVApQI1saXBljVDrXP1RHF1t8XDtwbMFklK7Hc/KiekWyCAQgu?=
 =?us-ascii?Q?M6coyDvo0yvuTwqZEVqIG4aniLtXuB1q5aCNCFN5RSbA4v0aUBmbKX391TWH?=
 =?us-ascii?Q?tKGFC0ouNhw33g6z1vRUmpvhybBEeaXU0FYhwCiWznADFHIvwLcdPrKGlLYT?=
 =?us-ascii?Q?7zXZfTqXyQeGl/v8UVZN0mmBKKr3bh0enZjPtmrhOgy/neMIFNTwK6jNRzF+?=
 =?us-ascii?Q?x6IT65fds69eiWsrsoWM5jdn+aYd63woOOllcWChUkABtpZJhfMCpnj37b1q?=
 =?us-ascii?Q?d6z76yUcn5GvdWX5ZXSZ0vcQkS3W2ycu52VfWl5lKFNLgmtbHVJvGgS2/7uE?=
 =?us-ascii?Q?caya+yHNOvo5GiP+0azDi4j7T4kl9CljUS4k2YwnJt8AkyIWpUS6r3PiVtRm?=
 =?us-ascii?Q?u3vyMoA6BXTkYwA6VvK+yZFHaoRRqVdHxlpDFpIYpbTflFJpPokkXk4TvaSj?=
 =?us-ascii?Q?dvKRUThjol9ning/8Clp1saRJyFp3ZdiR/3/JX9QTTYHPSj/2GHuqY0f8KkD?=
 =?us-ascii?Q?/SH67LEMTZHpIVcVGU92wOTP0e4Y5LVgUM3xt/iBL7e9Afmj2D/Ntp6FE+xU?=
 =?us-ascii?Q?miYLjcpirTXA2kzP/R/jSzoJ9Kabz711t31JB7hTXqtLaTwgWNnLLzIEsrnf?=
 =?us-ascii?Q?JCr6YC6H2bkpJNPtkXlzzh+Ijv26+iyeB/eQ8hsvQOCwcW/8EZ+kW8Dl4G+f?=
 =?us-ascii?Q?iR8JZD9hPM3TLNwyA0DlyFgCgWL8sEjYruPJRLFpt+ob8OmJiUlIloGsDqKu?=
 =?us-ascii?Q?2ee6aQAD4m8jgob7Mi6raPAXgM9VASWwb7NgFTcPm/9PiTHWn/YetwR+yNE/?=
 =?us-ascii?Q?IlCLM7JteKfLNkWGjeQfbH9QgKhECW9kQej2HOtY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac832b08-f6fa-4b08-0673-08dd50e6d81d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 13:10:55.7027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IINOdZJmxiPUm+8XkT4qzObxR6fmvdaS3pf2Hq4aP51itHYubk61suOtphtvcFQ1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7197

On Wed, Feb 19, 2025 at 08:31:52PM +0800, Yi Liu wrote:
> > > And then iommu_get_domain_for_dev() which explains it is an older
> > > function that depends on the caller somehow ensuring that the attached
> > > domain cannot change. Ideally we would someday try to remove calls to
> > > iommu_get_domain_for_dev()..
> 
> currently, the paths hold group->mutex are mostly in the iommu drivers.
> So what we may do is updating the iommu drivers to use a version that
> has lockdep. While other callers keep using the iommu_get_domain_for_dev().

Honestly I would prefer to pass the old domain in as a function argument to
attach and remove the calls entirely.

> > > Since the xarray cannot change for non-lockdepable reasons, it can
> > > just call xa_load(). Probably re-organize iommu_group_domain() to have
> > > a __iommu_group_domain() which has the body but no lockdep assertion.
> 
> another approach may be holding xa_lock when retrieving domain from xarray
> in the iommu_get_domain_for_dev() helper. This approach is consistent with
> the usage pattern of iommu_attach_handle_get(), where callers also do not
> acquire the group->mutex. Thoughts?

It doesn't matter, the pointer is unsafe the instant the xa_lock is
released.

The locking works in most places that don't hold the group mutex
because they rely on a driver being probed and the dma api keeping the
domain constant during that period.

Jason
