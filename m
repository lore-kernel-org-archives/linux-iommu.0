Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012069.outbound.protection.outlook.com [40.107.209.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AE9278771
	for <iommu@lists.linux.dev>; Fri, 10 Oct 2025 22:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760136951; cv=fail; b=EJ3+Clf0tVBsCK1Gox8G+Vb29EgBO7qqUsrgDq09p6/ndMudpJDpcTP8jpyLM7yFScAMdmwjybHa+ZVjyIAXN8enfMRHVMAgMTX/gHZGeiuOFTBs6n45KfYJDPBTDkQdaAgnpXbpKOtunQ1jNjP+I8fEMTevf+AbGtMMDmQp48k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760136951; c=relaxed/simple;
	bh=Eqm1lHx5zuWoXSyb1yZd7XVMpHgjMtomD30LtYixWys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SObgQIbWFWadD5jbjTOZzo/ptEJg5z+0fze3bEouTGWCjimad6MuwZN7/J+865UiZq0Is1T8PnlfZkD03UD/jp/VvykCPdEIkQK5o6RoZUR53N+uubI/O+AgpPd8Hsal3Y+H2Ve1DMxHBIxdcVREiqRu/7LYSepTLVPcapl2+Kc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HBuSdw3a; arc=fail smtp.client-ip=40.107.209.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HBuSdw3a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wv4eR71Z/h9VEfL3j4Pah4Ry5OoTfnMDx/gErZMpU2GZcVHsUqF1EOCPdfB8DXqhxFlM2BBeTotcyNJkL2BOLUh8cRVZlv/a40JGUV9fY/Wo5PyQTBkOoWJsDMhcytZvvFpn10jfqi74TeUTdL13H3rrNldc4q4lzoNE9U7iL6tJC9HCZMUl311Gs4ZftHWK4erYF3B1ETCODE8PVm+uevjoj9QJe6Gt5Aw/axyY3KJt/bySqbjzR6WlqzJxRybmO3NI4h6F65UBRqXdCaBi2AXJyPRnABUuUu9e5lB3TGXBCfV/MzVSNPrqQj2trdqbOMeRi6FM2y6TM8HXwyvqOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nSBh8wt5pL8yJEfqdWABWoRw+5xwMjYHV3HVIimkLAA=;
 b=SC0KhA2bqWsYubo1zO83pAZYGCnQED8lFhJJSr+M1jHCKCWJ6X8SzyUORoqhwRmY1991AXfvzXuaa9l17pm25mHgr3nUAvf/H1sitM6Bd69FYoTV5G93vMg6f/VAOBpVDIcDeKLzUcqXEvukAyKLrKMhgG5cVShfXq7cEmJUuvRhnLn1XvdcWxz6MoSV/IsWPHJyao4wxE+yYGwiHoOgH/SEP8tiq0LXCGi0W9LpSkuMzZShPh7phuVTmeLkmr+CeuCQYsp1Em1p+Eckv28Bi1UtK9qD+SAiJH22kofbFsIsdqRTYy5eyUs142nEwoXreBnAa9xmuQLsL6xQG5dpqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSBh8wt5pL8yJEfqdWABWoRw+5xwMjYHV3HVIimkLAA=;
 b=HBuSdw3aOth0AbEWMRO3pfn2WQyfo3SuXJY5cZ9X+zt/1Lz9rV6NvO+XqgTdFq8ZFEljOXE8q/5Nzv5I6Gyf4WQRjBhs84+YzjShL+a2x85rr/2j9I6nsGEwMw7NZfuURB0jAWXcoMLYsLmpM1X9q8sYgqh9GLc+gm3X8uI102lcf/cyoc5p03/08VHP9AYhjFu3qQzeyiuVK/omXfDqteBByxWEFTO8XBUJC0oEsmHpvu8VtN1kO51pLtt967ArTXQDulq0/2Srm4GnlxEqkb8YJ7yHsPXBz7ngprExivZaPtBtV1aOaZZayvsKP5nMyBHrQtaPjcfRz+1iYaU3gQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by BL1PR12MB5972.namprd12.prod.outlook.com (2603:10b6:208:39b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 22:55:45 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 22:55:45 +0000
Date: Fri, 10 Oct 2025 19:55:44 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: nicolinc@nvidia.com, linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	will@kernel.org, joro@8bytes.org, kevin.tian@intel.com,
	jsnitsel@redhat.com, vasant.hegde@amd.com, iommu@lists.linux.dev,
	santosh.shukla@amd.com, sairaj.arunkodilkar@amd.com,
	jon.grimm@amd.com, prashanthpra@google.com, wvw@google.com,
	wnliu@google.com, gptran@google.com, kpsingh@google.com,
	joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com
Subject: Re: [PATCH v3 12/15] iommu/amd: Validate guest DTE for nested
 translation
Message-ID: <20251010225544.GM3901471@nvidia.com>
References: <20251009235755.4497-1-suravee.suthikulpanit@amd.com>
 <20251009235755.4497-13-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009235755.4497-13-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: BLAPR05CA0034.namprd05.prod.outlook.com
 (2603:10b6:208:335::15) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|BL1PR12MB5972:EE_
X-MS-Office365-Filtering-Correlation-Id: ebffab20-8095-4b10-a279-08de08502580
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jnS199FPwgmkPEsrHnhlS/KCbyV1h1a66cdaXWXeqfxVsFkrIexZRo2PsAAB?=
 =?us-ascii?Q?RaeI8DtXbeG80gOEuQgQ8HXWfBZoRPoeJM+D4/Hn1M+8mG3LMyOgKL5Is4XV?=
 =?us-ascii?Q?plfzGZj4ehJxDNMT3ZCVgFU5WIHr7CPoq10LsSJkJZ6qO2Sf8V3NDeL3UoqT?=
 =?us-ascii?Q?QopiNLjo2iKzryBrXWBPpugHTOpphgSfdToqYTnqReCS9usBkT+ofaFj0Cp5?=
 =?us-ascii?Q?eflF3339CL+X3CQ2OJCPRZ6iPIZs18Y6Zvpd4gzP8sBx7rfYKYoguPUJnyaP?=
 =?us-ascii?Q?5VJPmPsHiC/mZz7IFT/ju2JOr5ZxWWz35YjXyoVXKgwxow+lQoedMy7cJ2yC?=
 =?us-ascii?Q?WQq7wB1pDwIpvMjqxFvoI3hizOD5ZdgTetKV0RI8+Xt05WiPuxm/IZc8Wleq?=
 =?us-ascii?Q?ejl+7lWynJA6gTdh2Lg8imF1TwLrLoYEqCUMYlOYfpKPfwkFvZRgxYoX722z?=
 =?us-ascii?Q?63VVPMkjMxileNi57qVp/qq87vVITlszn6o8U/NI002rJGmaedFhhljzYdIa?=
 =?us-ascii?Q?fehs0ol+HEczBj84K3SntvdYPT056ocFlCxyarjh1PFI7UEH2KnKdZO0px4I?=
 =?us-ascii?Q?VPSJKTNQDzdaEEjWNV9vfHqTdqUdIVRRtBbKkRWum2dObAjPRmZorTg0eZNa?=
 =?us-ascii?Q?8wDwn6DUTL8uFa5LQrpeeYiQdGYbOJZHH4oaz3LOkH4e+EMjJeefshi6c99Q?=
 =?us-ascii?Q?tT9Uvq7Ai/iJ/qE070/In7aelCEW/i3zZQTxpPGF2uL2v8sJCePmVc74vDnO?=
 =?us-ascii?Q?GBQk18mJ7OHfmr201hijlY7QR9z+wMcJiVdpkm+sXrunp/6CqHo5H1vqFFtH?=
 =?us-ascii?Q?ij64D/lAgStAqhZrBRe0o7x/1Lx7x7yGrBdx0DJpXVYG87/SJ4aQVzLStBW4?=
 =?us-ascii?Q?lxlMisNVNEU4VMoPRRY7jz6rj0+JNq2NnlroS9Dz6I3HurAOSK5dUO36OQsR?=
 =?us-ascii?Q?tCt1xddET0nd3Fgeb84VGW+IV9mtvu8Vg601JJnIoysW/dbGgi8VyduBNObT?=
 =?us-ascii?Q?+U89ADmHDE0/iFZpHm/d/THRddCsgR8V3IjE1uAD4qHGxAMrLTwljHggJgFP?=
 =?us-ascii?Q?XOCePUun59SpwiSsbFbmASbwbjoLqtqS0+IIx1oY5C7cSUP08jGO7y+ATFds?=
 =?us-ascii?Q?wBGlUB4PneOsO1tWL13U744rlFqFTSYUPzexDXzVCtuAEtyrqsZ7YTFCO/hq?=
 =?us-ascii?Q?q5vjrT+QG3slItSWgx2Z6GNB3khjNBWDj8c1nEnmkLmc/HrXArgAy45JMpP7?=
 =?us-ascii?Q?BZJFlesa904cPEuRn2tU+eHLPpBk6hT2oonmN4aokfBy03Pa9yLTtnwWYk2l?=
 =?us-ascii?Q?y4HE3C2uOZ0z0/DTsI2lEbmYqlqxekZG4y0EHHed51A7+1DT+5qAUoXBY4H5?=
 =?us-ascii?Q?+7ZJI3nHQfLN78ldr94TqSRwceHaK5QXbIgcdCzyLGuKgrY7vy6+r6fXkd7G?=
 =?us-ascii?Q?K0zNsnZo9rU6729ksiOF7pFT68eYRgmv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8lzPzD4n9l1ZAIKkK+AaTNLYS1SnS1S+c79leProCUNkSvT9yhdpl9aIAh+b?=
 =?us-ascii?Q?FVu1j8Z8iL98i1NO0o0zTgU8JW6YMNiM4FEdif5ea5Ftv9mVoDGLXbFqFfLF?=
 =?us-ascii?Q?FjruPmnL0fFPmGl7iptOhxXjwCtC7iZgfEvO1wHYP5uH7KoQ6TmBYvAoFUF7?=
 =?us-ascii?Q?XHDERyAB9Bnyvn5031o8a3Ha00nsiJSz/kdnVJ1SLvdRzhWbH+pZjgxLNZoh?=
 =?us-ascii?Q?jKcPalyCRIWWGV9/hpDefEUcJnnm6IUimMODvrZ30Lsro+IUbi3smWWbcBZ8?=
 =?us-ascii?Q?kB98VNKCy8FbwrMSiZF2I7yYbpSGF45XnH95KW9cqBaztb7/pP/MeKjHjUqF?=
 =?us-ascii?Q?MDdYdL83/iJqPxX1nRUScgHSepz+Awmctlz1Zguo0lYAvOqy+hWHa5ZkuHJX?=
 =?us-ascii?Q?wXQjEFchj5FtM7S3SKy63AyFFbEfKeWQpYe87mpbP/8Dskcc2E+PDcEezNCn?=
 =?us-ascii?Q?M57iPQpO9ZtjnaX0e8d1PFITMKgXMAdaS4h5N4CnZJZEpM4wSloYzOSKtR6f?=
 =?us-ascii?Q?6shHDQ8pm6EE/5e0UvjiRGqUreK/76JqcQfj4HG5j2TYMYDz5tJYY5Jw6f7Z?=
 =?us-ascii?Q?uEQwflB2rJ8N4qWkfAn4TL+MItMBGIry8IyuwB7u2nuzK9jjDU4hnlpvRhap?=
 =?us-ascii?Q?JxxsvAq1OI5Bch6ijK/A7aCu3wiN9yea42Izna/a56gyfXb+l0eQUMNc2kED?=
 =?us-ascii?Q?vjxuxlfhWUk7mFwlJBqkCUk2AWbgNTyXGI3DMjF4BhhReTMzGQH/0/nDtfmo?=
 =?us-ascii?Q?Ud9saBNLy34DTjms/fa2P/c4EtS/bS4aCiMoKae8t+fIuZ+1yOt31VG6jLs+?=
 =?us-ascii?Q?utz+udrP0nsIbgAFA+joIierIN0sHW4bT3FlOXxRZX+sS4Pg5lRxgE/YzMOz?=
 =?us-ascii?Q?BVXu3kNZT/1eGkUOsoT2CrMkBk1jcVBpgwjMdZQZwOv4ZMdxE11MuQSpnzf/?=
 =?us-ascii?Q?IxAmvbCpNiThTkGoDBOL8JLmAjxCIt1SiuawWm9spSFPAOWcMlQoNrnOQ31D?=
 =?us-ascii?Q?hx7PSM8yC8/9kJJpXWbtffAAjmifzlyvcH0obI0QrsyY6wluDltOd3/b2cjc?=
 =?us-ascii?Q?xLgVRDmA3jvcZZvNd9/e0I0rsUZiDjp0Fr5cM/wDemi5GIev+52xXO0mQKFj?=
 =?us-ascii?Q?5Pem5RD82sR4l2qcKwIWX40c0URNtVILm1AWabUrD+yq6HbMk3W+oUEYJdcf?=
 =?us-ascii?Q?ZsLjQDUIcY3iQrpphnOGcSRxEbOKdebywDcsTX4yKROxCmlHJqf8z8rBuFzU?=
 =?us-ascii?Q?zwZ+X7vvNUkolwQVUU88Nkv6Lw/kpYZG9skGMh2hAo0GUz2S6wLzC7dFoXfU?=
 =?us-ascii?Q?Hyv1bIYsUpR+jnLInp18H9P2EQSPdPuRC2+GIhEG/bqxlqFJBNMBmQjXVhks?=
 =?us-ascii?Q?jUu5C2pwc8aE8mwnpfCSQOwH2yFrmbWpheCMSPutcYd2ei/lO+EeEmQFksTD?=
 =?us-ascii?Q?dicBiJyJ/MMsZnlmTe71HElcBqFfEWnOHuiXZSyTuSjUqbZ2+sghLh2vxCEh?=
 =?us-ascii?Q?163TMGjRvzIANPvkxxSbFcBxq8HOYffKSILP6G0kjqs63u/gOMkYIPOT9W0p?=
 =?us-ascii?Q?A177dpHTrl28+NR4Ygw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebffab20-8095-4b10-a279-08de08502580
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 22:55:45.4608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HMhwvuhTGEe3WF1wKgBFd7Bd/oDVlI4LO7kD0F7scVRAVSgbf20ot6wPUNvvvkTZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5972

On Thu, Oct 09, 2025 at 11:57:52PM +0000, Suravee Suthikulpanit wrote:
> To make sure that configuration for host (v1) and guest (v2) page tables
> are valid before allocate nested domain.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h |  2 ++
>  drivers/iommu/amd/nested.c          | 41 +++++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+)

I would squash this into the prior patch, but looks OK. I did not try
to do a detailed check this is a complete/correct list of fields.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
