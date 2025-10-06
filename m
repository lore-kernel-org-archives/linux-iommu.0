Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011004.outbound.protection.outlook.com [40.107.208.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEBA27AC35
	for <iommu@lists.linux.dev>; Mon,  6 Oct 2025 14:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759761810; cv=fail; b=Bjre+8rKDxLXQJ1DWjwu/kLTjGt0MAvqOqUab7O5dnm+Ud2rh3/bupLzCZRWjwshChUs7FaDW6Irae+bcNVzm8JRHGrVB3RAXqKOatPZOcILDlGqbIMB7hxqrA+to5DWQdrHmV87C/RYuntoJQqDJHG3lMajtvWi6ullZBtagDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759761810; c=relaxed/simple;
	bh=yo2LacD7gd1sG5r9NxvChPGAuP8nSNnIPmJ15LXpy1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qzQl9V6wyVJRg88Ev3g/d1TfmK63XbBM087OdFwRIr/RNEYh7rGmeq/pklAWLlg72yIgOPeW4ZoUJotZ3KCy+LsztHw2uKCatLOmTqV0aGSe/2sv80vy9eYtxU0Jy1STP/L6YsXpWAV/noBLyhGlVyTLopfDDMAfKW8wMujaM9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mAHk9GtP; arc=fail smtp.client-ip=40.107.208.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mAHk9GtP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P9bIRPqdtj37Zsdea0sGItMJyp/joc5DXM+vZ3rQeTmGWdkLyRQNA0AP7iwLBgm5/9euV65FbHhfwQWpYSTD3UvH7uuTivDShe+qN9GSKwvAx3wNbglviglP4BeotUGSpg7wGZ7QRFmjlyNn/j+mAqaQhQXPqepvDAAvXgA5sTV3qO7Wvz16ApWzregjvuywJKcu4BdG5v7yTBfDdcV444D54cFLKFZ78SK+qj08gRWLc0ZUVHMlfXJ26wWfld16nB1fgptjunQSQ2xkBRop4q784DItttK6rz2UNaJhBuo++ftGpIi2fXNJMdga61gxwsVqctZe9SB3lfg0F82u4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPQUS9sTvCspoBcSTu9ewXHsLkyqd6ftvOxmQn8rxUo=;
 b=h70iaM5Hc66XqKcDbr0SdiImOUky3izEc13WQ1k/kTETOGsC1MQQx29IH3K7tb9Kz9mbSnRvezFk09Fa1grJqiPnS6Tpv922hajSlPCdebzlCPe8xZvA7y0SMSMwh0gzoM8KNoFbOYtIAlFhGtFCLNd05eH5KYSpEeYVPg1xD9Lg30q4i0FJtF+5YP5lPoUPRV+EKAoUFrewXVuq/HRs0zZ9u6lg+PcD2lVBisaN+OsQClLhDOU+0qVCmjHnYqWeAyWzOI3Pqw1BmnYMLIimTQ4Et9mvcxT9y+BhytaPjk4sjJpT3PIVHzFpo7mVoDVfbyBISncyybp9XjhM9kQEDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPQUS9sTvCspoBcSTu9ewXHsLkyqd6ftvOxmQn8rxUo=;
 b=mAHk9GtPxS4N09/gPuc09t00Y+yDKxkS/KNscHqGMcDZ59axVecPnbzg0Y0Es54M4UQQUBJGalYy3uS4f9pMB76tkdXD3JHbcXkRF7rV5zHcl5RBYCmi11vN1PL2Vki/a2lUZpBliYfQ+QZsxixvuEsOXT2F2pr/VdbS685UDD7dhKf6PMzm1piYF0IVElQXVj4BUeYlCVd5NzqW4rHZLrMZoEzONDF/oqXiL+23pvswLnzmlxyPe8N+eZkj6d1kOGfEGQe7vRuuUog7jrrJ6A3t9xjsz9wED+XEuRI+QJn2qEaPoYm1qeS3gFzqe3TEDhTa7XFjxUT8GWzdjU97eA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by BY5PR12MB4146.namprd12.prod.outlook.com (2603:10b6:a03:20d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 14:43:21 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 14:43:20 +0000
Date: Mon, 6 Oct 2025 11:43:19 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
	joro@8bytes.org, kevin.tian@intel.com, jsnitsel@redhat.com,
	vasant.hegde@amd.com, iommu@lists.linux.dev, santosh.shukla@amd.com,
	sairaj.arunkodilkar@amd.com, jon.grimm@amd.com,
	prashanthpra@google.com, wvw@google.com, wnliu@google.com,
	gptran@google.com, kpsingh@google.com, joao.m.martins@oracle.com,
	alejandro.j.jimenez@oracle.com
Subject: Re: [PATCH v2 09/12] iommu/amd: Add support for nest parent domain
 allocation
Message-ID: <20251006144319.GR3360665@nvidia.com>
References: <20251001060954.5030-1-suravee.suthikulpanit@amd.com>
 <20251001060954.5030-10-suravee.suthikulpanit@amd.com>
 <aN69rkBJS2hIcZjk@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aN69rkBJS2hIcZjk@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR07CA0029.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::39) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|BY5PR12MB4146:EE_
X-MS-Office365-Filtering-Correlation-Id: 28ee6a69-292b-423e-6c64-08de04e6b1ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A/gmgEoKp1QyoPIMYpKcB60JVxnVjF5RfJDkzwVBMtoJ296QCcUXjT8Ijo0z?=
 =?us-ascii?Q?gpKn0yWvaOjToca5v65TtF+93ZX5H5lCrCNgbvPeuzoux0e2PmN94lv6CWaU?=
 =?us-ascii?Q?2yFzWjWKqkA0PhYOGg+Cp83Fm7hrnZ/wq/ZFGUy+f7sxu4C64QkqA7Ha9rp6?=
 =?us-ascii?Q?1GpUmBF0UZvRY6QCFlW3jGyR1JPuMyiCiioaFjEJg5PjCgV4Nu9p7BJSkmCS?=
 =?us-ascii?Q?iSQAoJMKQH2e3i/E+HebMdNpWEGFFXqQWW+PkSs8tmbLEwFfOBgibKSFbQzs?=
 =?us-ascii?Q?d3vEl8niOcegAARWTETx1/tyVmA71O5wkQnlTF8E12M4CtOJG0A0i4zti/j1?=
 =?us-ascii?Q?6IS5n8KHLkUdAoYEggF1p4leFVjFmafYegGYbcFhhVbGtNhugZ9VZWbaHmsG?=
 =?us-ascii?Q?xstJo0ZyVIgZgjbqD/EEmDG+HUASMTaUHWTjvoCgvmNXGf84TxT4L9h4r6xl?=
 =?us-ascii?Q?9JHjfxk8i6WjxA25Hhhe/PjdJAD6f6SdVCAjJsQQZxd4LM0f1Pf3pZx5hzvs?=
 =?us-ascii?Q?EcsyE/M88CpklvKksZOmB0HstUpIszYj0M/Ovu7p547ElvJkX9l+mg7LDKBF?=
 =?us-ascii?Q?cbUa0Iy4XX8KC2uOLAGe7D3OjllhHfqch8Rx+0w2EisfUDsFBmF242CUjXtS?=
 =?us-ascii?Q?xWksJKAjrYKv5FvF+y0aoXYWNqTuTYv/8dWDSMY1Pzys/H7TjDbW0OSvKrRh?=
 =?us-ascii?Q?oMcJmbnxlF4AVBzUUuXkGPUhOVQA5QrEzBP9thmh66vJ7sWsxRNDciJu9pzt?=
 =?us-ascii?Q?/5rsb5opuMGSsY1uACnilnzuuh3Kwx8GtilZbIkejRCEAaf2s33LFbvkM8wp?=
 =?us-ascii?Q?d0ORZbHzdnP4Vi44TNhwKzLbXBsACuDwGZzeg2rpFZLby50laQDM4FVx46S/?=
 =?us-ascii?Q?OGDFIpkk3xnvfMnddo/3gAOCEY3RPIQbsiJQHrnSqKjfJYfPC90gm28vf/bf?=
 =?us-ascii?Q?er+3J64/mbgLJ1Vy0Md5zTL1tb34WP7WaEwh6uoc9hWuZ5ZYRcyGtJZhsrDJ?=
 =?us-ascii?Q?96nX5XMMJjX40PNifZmb5/64E4TvJJ39nMM4uqzykTfxgVNkowvSjE3V+Fpv?=
 =?us-ascii?Q?9unW3WWY+OP17yiMa3ocPa7GZULN+AAGnuT9z572CJWlPQf2RmNJ9S+FKk49?=
 =?us-ascii?Q?T0KXgABUd1ZEd55+O9I6lXCk8SbtJ3djAcblWUu9qChthWja3B99FeQzGF+0?=
 =?us-ascii?Q?pG17Z8ord6p7QN2Vb/mZiUU88hCXDrX/s4AD9UyLQivcbE3LvYnuNab7luLh?=
 =?us-ascii?Q?WBkNtfT7tATfADI553XZoq4yR2mK+xGhqMmDEEYpxXh34y5/XAn9QKnPY5hs?=
 =?us-ascii?Q?JR9CchnGCna7jqc3CgOIc1sJchsROXrU6YLiAKMnC+EGMj6nJWQ37ZRSnrL1?=
 =?us-ascii?Q?nEof1Yu3qHkxLlavFeAp4I5g7OXnZ16q74llqteyUwXlFOFmnv9r4pXY7Vd2?=
 =?us-ascii?Q?4IzMZa2BMoUiiq89lz8bSNUwI4kok82D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?izZeL0K3tkfqqrRwDtxXmVYMYYUfyzkbh1lf9UeM3p8QHVNFbM3H0xu+fbHt?=
 =?us-ascii?Q?WMTsghMps43iBshUzwX59xcicV2Uz2dQzPJS3Or4fse205e474/vOJq58y78?=
 =?us-ascii?Q?ruPU+Xckx/h/35uie7RCVqRvvQ6N/212uYYQbHGJQUpVM97e3FphI6QG8lZk?=
 =?us-ascii?Q?LlJyHmIugJGA50iczjZBtC4geCjWU+9MVIydiLTl6dJs6joNq4RBuptkD/PP?=
 =?us-ascii?Q?+B3U8RBMdOSlRkm5HApG5X0XydOUz+/pMPmFmIGNEFSfK3y5hvqRsfzjUWIe?=
 =?us-ascii?Q?n5ekveKwtQUhiFw7pbV4LIkuRUM4sYPQO66TeX4waYPPH2xqCZoSvBnS+wEC?=
 =?us-ascii?Q?bJcRSfD1SnDf0I2zkjstEXBJqZtPYsBYvYMRqwJ9lKBL9qQR8InFOaAm7JAu?=
 =?us-ascii?Q?DKLsysNTJ5SAQkoA+6WDd9x6g8tpI0Bqmvr44gvTqdLl2gSA4cjk7QSuNGcS?=
 =?us-ascii?Q?Wjp6RzrEZO+jmKYqK6LxKPslB2xCLhXR9Yo+0kQfOYAOlRGQ3EH6iotJzbZw?=
 =?us-ascii?Q?jzYxTH+MbF9oSHSm7OWmNdJgNlJ9eLkftJmZz5gGN9b3WXlFEM9NcT1VfTqC?=
 =?us-ascii?Q?dUvjwmwBYhCrcyjUYHU0lzCiD08WcVw8Fr0aY+PRUdYBnHLSIFM9emr+Exfw?=
 =?us-ascii?Q?FN7a5zn7HIJ5Y+7veejd50lD++7tgcjuc2bGrVqbjnO9jmgbKiV3KKnZ1XgH?=
 =?us-ascii?Q?A/bXyLjMRQBi4t0ItLDDFFChyz0qyX57BtIMiqLNb51DVMTKwgekvi74TeVf?=
 =?us-ascii?Q?KaitysZh7ry4Ef8/n9o76/H2h7qIGf2Lkj6KA/bvs3dDi2oLPCWjhXjVcAdA?=
 =?us-ascii?Q?KWrBrrbpLYNWcpBfQ5/2VUFwwiwPRd5DDhecfwpZFOEuWsunYSva4DptYIWh?=
 =?us-ascii?Q?lbY4ucrcfvYnvgrCtGBXB/+ocAzv0It4Zz/jOJxD22LVprdPkf5pgexJ5ANF?=
 =?us-ascii?Q?a3xKDqAO+RTRPSpuEsZZUtKWuUKSmUfuIhaYkUzijmKEeXZfXYOo7OurV3kS?=
 =?us-ascii?Q?DC8SiX02O0ROF8kOKvgJC7ZghGXXr7IkqkEt1F6UYBOx2N7Wmp3m+U9hD8PB?=
 =?us-ascii?Q?tvOTNAPY4f7KT63ViffsGb8l3DDv6hV/0cYS2xWP1nVPmCAm1PDPvgjyzQag?=
 =?us-ascii?Q?jgrgrbv3cefvtU8m5jqDtK9R9XNp20JvGxwM4haCI0GGUtkj7RmxfO72BIGX?=
 =?us-ascii?Q?18WxIK/GaApE+vYNENOKxT4iUtIREI9xQsPy8DIWrPl7cYKSImbpXmSF0PeU?=
 =?us-ascii?Q?phsHb5oCTiBmTEaE4pUcd5WD17zItkiLAYqhwRjNhWjO1A8wUGexeTUpBiE4?=
 =?us-ascii?Q?PMXrDIokBx63ffov1jAZ6MTheXiwydAaUBWX8owxj4WXFaUNbWNp0QKIJOTC?=
 =?us-ascii?Q?IcyoWKWGW/m6GlAKB15qPlPfeo2dbPRLi8rBcmW9aLl4DMPee7mzWnnQnWzZ?=
 =?us-ascii?Q?EDfq2ahiac7O2FEkMOYR71gw0AwBE7Tqw9IgpzyBIvHMEhxm7CGT+cFJYtqw?=
 =?us-ascii?Q?abfkYHXBtdZ8LtD0M1UiUQaPWOENzq7uwYPFDDMZZ9Db8HteyxzC1AWIl2m/?=
 =?us-ascii?Q?zBWoEbRWSRqjVE8fPe0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28ee6a69-292b-423e-6c64-08de04e6b1ce
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 14:43:20.8146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: meArj24aiGYc9eeN6AFPbsC/FkIMCvaeJ0rxFJQdmy9+e6dyCxNNlkBFlLu6aSZ6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4146

On Thu, Oct 02, 2025 at 11:00:14AM -0700, Nicolin Chen wrote:

> >  	switch (flags & supported_flags) {
> >  	case IOMMU_HWPT_ALLOC_DIRTY_TRACKING:
> > -		/* Allocate domain with v1 page table for dirty tracking */
> > -		if (!amd_iommu_hd_support(iommu))
> > +	case IOMMU_HWPT_ALLOC_NEST_PARENT:
> > +	case IOMMU_HWPT_ALLOC_DIRTY_TRACKING | IOMMU_HWPT_ALLOC_NEST_PARENT:
> > +		/*
> > +		 * Allocate domain with v1 page table for dirty tracking
> > +		 * and/or Nest parent.
> > +		 */
> > +		if ((flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING) &&
> > +		    !amd_iommu_hd_support(iommu))
> >  			break;
> 
> And add here:
> 		if ((flags & IOMMU_HWPT_ALLOC_NEST_PARENT)) &&
> 		    !is_nest_parent_supported())
> 			    break;

Yeah this looks better

On VT-D we have V1/V2 specific alloc functions and these tests were
put at the top of those functions in this form. This is close enough,
it is helpful to be consistent.

Jason
