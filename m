Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1445296D1D
	for <iommu@lists.linux.dev>; Tue, 15 Apr 2025 13:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744723449; cv=fail; b=lvoCAk7Ic97Ikjrh2SpQDTiwDqNRNnW01KwH6nkiHwieRs7Xg1trIKRRpL86vfJdC6+mouuCPFiw652uDCZ9wbpJSrq3KS4K/aKUt/27DRcbJovCqYahZ0V3Qc7XUOBsvFC1EHYz3W7xr436hzK4kAfwM3Yc9+/GmbWcB7njlQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744723449; c=relaxed/simple;
	bh=wr5YRI+tRH2HNocBecs1kuIuKOO8/BRlYVIjzjg1dUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sq9zysn5Pjhq/uYPevaleuiel99vF/khaxUNqYF7j+l+klJOMYqrwb5zNFLU6/VZrtQkSIFegOtqbfM80hpQvqnaAbx0LAXCDwLsIdwloyGiz0+SdKND0Asn4NDMPyH/OD+p0WbkHLk2ut8dL1D0j9V/vGDVR5aaBKQyNqKRpH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BlNtueDO; arc=fail smtp.client-ip=40.107.220.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BlNtueDO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S6wUI/zkbSnVA4q3H6BOSYJpDgMCEtViZHRVmgY6PAWNIMzjzUIgRgChQpXOwBRmfLKf31eYTfhTbqaCtUrPmnV7GOuw20FfKIv36cNAePM6Zs30TArhsWAhbppMsP4e5ae9wMKpBI/uqGyPJF2qdLNQ7YNL0szImIGoCqU27bCInM5HJqK3DyA3njuQSN4VTSvI1MPjMveMPZd6uG2hFtYCWSabhbF22i4S0rA/1NZJ3Z94JmwhvhHGmy9bPldSNNY8ELT4bi60DWTe1wif46PX6m43qGWvUi0Wd/o/6rhF5LllygIj6Osh4zpIRzcnolGA5bq2SnYnhjaZMQHoYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HuuYHDaqjKPudBAYPIA6471AJe2/vowV3w2H1hjjd7A=;
 b=n07fSXq2P1iJpXfzgjknY0sTO1IF6L4gDLjFnG60tSA7B/Nmy8PGCaIkpvRP4SL+E3733v4i9lIm939RbRjxchCjjO9cWJwlwLx2UD+9CCQraF9aC4FD4aqNvDtRPf8tNhh00WT8C5KdKgas1/3NoDF9KVBmfVYCYERz12cRjd2fQKQLsMJZYYo+bMHrh7QShKgdb6m+cEhPMZXdopkngSBhsQMxC9jO2JXiGy64IR2EdSOmCBWiRMT85OEeKl5MypFlxiKuyiTlu7ZSb94Nva4k8MRrKJECV9iePEg9vQ7wUyXxj/VpLSbWa3rELeckdGehr298Qjgpuysq81SOMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HuuYHDaqjKPudBAYPIA6471AJe2/vowV3w2H1hjjd7A=;
 b=BlNtueDOStVPpnu9P8Dx0O4meo7v8pbihFb7sSkROU6qXzlxIkRD5XAwcPQ2Oxmg2sx2x7SHXIP0MCC6AInbWKoMNozY+K3ume1/QxWyYUs7j83FVmQvelMNwR43Ro21i5dIqnSyygKRcoWC4N6fOVgM07i4i3tQ1vsyTVs9jc2rSQa75WmzLDoGSIuLxMr5qu0q7K/2TFfPAZNJ/7xbykpLXtuVLSN9zy4Eg7PsaGyEXRWetXk1EWgdy1Od5ZCpS3UMADBs+B7NBnNi4y6rOwrzncwH7MUPI43we6Ih32zR+uK/5zMS1dV/94SQTEuNn1JOyv5gZz6EMUqSTC0gSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS7PR12MB8321.namprd12.prod.outlook.com (2603:10b6:8:ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Tue, 15 Apr
 2025 13:24:02 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 13:24:02 +0000
Date: Tue, 15 Apr 2025 10:24:01 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	jsnitsel@redhat.com, kevin.tian@intel.com, praan@google.com,
	zhukeqian1@huawei.com, Jonathan.Cameron@huawei.com,
	jean-philippe@linaro.org, eric.auger@redhat.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix iommu_device_probe bug due to
 duplicated stream ids
Message-ID: <20250415132401.GC517881@nvidia.com>
References: <20250412180658.439499-1-nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250412180658.439499-1-nicolinc@nvidia.com>
X-ClientProxiedBy: BN9PR03CA0669.namprd03.prod.outlook.com
 (2603:10b6:408:10e::14) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS7PR12MB8321:EE_
X-MS-Office365-Filtering-Correlation-Id: fc0dc720-81ee-4bf2-66c3-08dd7c20c9ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/Dzm9MWa5s1Wvvjz1oZy5W7xJqM6v+2npBBFFZjQY6BS/d1QRxhJGXx+e/VA?=
 =?us-ascii?Q?NWVH9HAzO8cqQvhCoxq1dhKMABW3HLPYRMZJbxma9wR1oWhUusY4ykewcm1r?=
 =?us-ascii?Q?c7FdgfpJU9pwFW+OAa2Sp1DALtI0rYIexXaHBSmRWKHoODf6Wop0eLK2GJ8H?=
 =?us-ascii?Q?2T9e884e0arTGB3QTidWNlQtddBeQbAqTEMhuV355ZKo6QmO6YFXs6Ll8vpS?=
 =?us-ascii?Q?InVvZPwXpbhzbpvVsmkNx3VTo7wMrXpRjuZ3WCBn2GY1WZK+zci2a+LRhxM4?=
 =?us-ascii?Q?LEQXwkmB/759Kgb5yI6GaU0iqVOcyfoOdHDvNHoL3EOCt1PqG2Q+aZe1Xa6f?=
 =?us-ascii?Q?QVpGLCvPfNKo/HuIpUqzK//RUY6DUakaViIZjeaBy50z48xaAgrddmQTyg7s?=
 =?us-ascii?Q?pT1X8cPnyTOZVOYbhzsDPWr7o2JCAICuu9frMt5C8uKtcV1teOG0lQyNGKQR?=
 =?us-ascii?Q?5MmQKBcgnGPfH3ASsVwybnWArHd7g7a1De0PhgvJbTPFs5MKVsye0Vw6h/g1?=
 =?us-ascii?Q?np3QupbRwbrg6yyBLa0tfzjCgEKt8k7dlZK6O7hsdcG/6FYPGmuY2vHNdOT6?=
 =?us-ascii?Q?Xx76TpgJs1Rly+A82xxSkvcv6ks+hODQruXvLY/NQiGpAAgOwfSAF2syspDx?=
 =?us-ascii?Q?+QvgyIEdyr1BfsWB3GkDEnvCoS8DNKs2WtV9WPLkOgbCOT/Z2gABGeh3fpQc?=
 =?us-ascii?Q?SG/alpSQCwSctvgjAlAA93Ffc+GZ6HY9FBSmmHLl5fwIu3pwaUJ8OIcWERsa?=
 =?us-ascii?Q?eWAfNFLiYgSYTwehqKCEj5Pwj0spomVEAmqhZVLWJw3SyhX0XiMtRSsfxdW3?=
 =?us-ascii?Q?xz+SEh44G2mpuyDic4vWFrbCdx/y6YYSYI51riMR20Q6KJpxitFolt27wR5w?=
 =?us-ascii?Q?QiT9kGIP/qbhrrd22D4hpPXDQz49+3dVQGe45+d/QmILqzTg/VHJNIYqF9Np?=
 =?us-ascii?Q?URzzlU7ypY2GUFqg4Q5w5H/jDpfCP1Qb1V8B2Bcj/4N2WrEOFv2FfMqEqCWt?=
 =?us-ascii?Q?eU4dX8DxXK/0jdRSNb+0j48tvqKMUSAebtU6pPRP4PTiseT2AVqghxXXmee5?=
 =?us-ascii?Q?D8/HKyZ0yNB//Jrjr7mZg0RX9fNYkoJSPZdrkkf09TmiLxITIzSIvh71F+AR?=
 =?us-ascii?Q?CVMW45kq33kwY3cky/9mdGwcDC25GlSTinAQKVBGvXKxbEl3jHGmJ+P0+rSN?=
 =?us-ascii?Q?AV8hFAT7CGd7X7inL6stIVWa79yvOjfktklTeYqtBv4XpZdSVCVyvT+L9Y3z?=
 =?us-ascii?Q?9+P3Ydg+8SFhUeS6wp/dcCdVl13No6gsIlsIAQwAFY9JqZNaYhGk9RK34qB2?=
 =?us-ascii?Q?W3qXDB6s/H/77RwEHgoXuFZF7omHyfzdPGaPsiCBju5WmdpI41yh9gRXIwSE?=
 =?us-ascii?Q?K/sUXcPs+ZNlN+U9Zc4mcaEZYX8ag4RDzGGLyzGtAp+L1lquS1RJxeOAlrR0?=
 =?us-ascii?Q?j0BWph0pUys=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hdNtAlPaQasDML7oeZDUvS+3u0cnPZUXj83v+LP3Y4/CZ+CqCQ9t/P7S9on2?=
 =?us-ascii?Q?GG7gNmHPU5k4Ury5bGc+BKXDgm/86feojdXhzu5ciSAs9j9HiUZ9oh9k4nBw?=
 =?us-ascii?Q?ayblOTcgX7flo8y8Os8G+pUs0zATLZsIJ+QOxVffgUOzi4OET4bCP/yyLUaC?=
 =?us-ascii?Q?eBaoleD41TjE47wRO1Q/C5gOf9TJjdg9ksg36CAudV8bySOE10JEj/hSxJSM?=
 =?us-ascii?Q?HmgtVbibpd/rsOEBnumSo9RosjG/WUmgZKy3juv1cN+i69FA/O/oBrvmcDTP?=
 =?us-ascii?Q?KnMbCNJTtwmY8cJGOl/RH20OIVTpyENBz6K0t41PWqcsru1l7p9f2n65qdYy?=
 =?us-ascii?Q?GH0RW0u8aRaBAy8I7YGgH2+DniRRKjOyzc/FGbDVfHGOmLPztxbqylr6WUro?=
 =?us-ascii?Q?ts0u4+DtJlN10Fnh92rtCJlV0m5keFB3EGTQy06RUZnvERO6bTH87qBMNeul?=
 =?us-ascii?Q?VpiQOJLg4uQsbPr3bxy6mFMZK0Z5KzgpYpCkJUy6hv/Gel6MGy0H2ULWwj7J?=
 =?us-ascii?Q?B/wLsk0ESNGpvrLNbHO8N9Ks6w5ZYNSUn00mksmA8+s3ZCqtTEIGv4yqXc++?=
 =?us-ascii?Q?hinwb936e7GlCpIauY3z80ZPekoUta4EgrsJPJRJG+I+lhQ4HxdcvvmQbNxl?=
 =?us-ascii?Q?t9fHmjsbTXZZp1MeP8y+IbHbf5vJHeTbIllLXMrl68SrSFeVEdR0IsbL0mkb?=
 =?us-ascii?Q?uYQeYEq3NU7pemRTYXCkpi0W1fo+9tITj4YiHmpAw0wB1Zc/ceZaQ1PrFg3b?=
 =?us-ascii?Q?ym1G77Pau+dQAAALDLZ0oRoD3r7bkqj7pCx4fbdG9eoyMJH9gcH99dL/QyLk?=
 =?us-ascii?Q?GOD8yHhHyvUfGetTAtmT/brECF2tTzdvAv/WC0GJiEd6H8svsupyG6yuk2oa?=
 =?us-ascii?Q?oeWuCb5d/i5FEPByASgaRokzMcfBnE9eFUwL8wgzmRj4R2e6oRY8SHODTzdi?=
 =?us-ascii?Q?5t+V+DTUGcLTDr018QmDCq/tuqqDxOnpSxHptT/6//OfzyWJJBK8aQKgOc2M?=
 =?us-ascii?Q?pqleoBhDPikCN7cincqKUaAeLVwFwhrzntl0fVWATLZPte8fQssGS0iiNvyx?=
 =?us-ascii?Q?U5W/rUC8p2hhELnCi50Zv4EU6kkcVXfh/+FheiVy+IFKJfvVBQqeO0avgmiV?=
 =?us-ascii?Q?HVC2Xli25KEfdW7getDaLutA3oVbrpHlKpLxO8369m7irA+cdJPz/W6t40Ti?=
 =?us-ascii?Q?geM+ITlUVdbh4yuIFFykX9o4g/MRE6hrX7gpiFKUep3WtVw3eFd34j22v9fU?=
 =?us-ascii?Q?DlTBqo1furhKa60KQAq+NKBQcFF5oqieVtwjqpzjIRyS5ZDwlW15Ew554Adn?=
 =?us-ascii?Q?2RNlDOrO7dHmNHD15kriSCLUxlOdvXoIoXWdgtG/0u3b+shPnKj3feQyAbBO?=
 =?us-ascii?Q?EjzwA98tuyxfTPFd6eR1lR/Ef/XjKx51O1kaB2OwK9vYni5tZpGS4HPgz0pi?=
 =?us-ascii?Q?AUGPfO7niLK4ozDAvN3+iQh5YoD8Ws7W9ua0O3xchB815FztcSW/MLL5iVeB?=
 =?us-ascii?Q?rhBUjFoxn9W1xwqgr2IObNLU3CYVZ4tsweB1vs6mlWQRBRPL6YVNdKkozEZ2?=
 =?us-ascii?Q?829bZMtde+USDufXGvAYvIZBwVb8Xlayqj0Oh1zF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc0dc720-81ee-4bf2-66c3-08dd7c20c9ea
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 13:24:02.6686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7FAkdKLonein8elEKTK36iIo9FmwFsVsKhVto0Xs4ebX7xKzyapnIf4Ns1ktA9k/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8321

On Sat, Apr 12, 2025 at 11:06:58AM -0700, Nicolin Chen wrote:
> ASPEED VGA card has two built-in devices:
>  0008:06:00.0 PCI bridge: ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge (rev 06)
>  0008:07:00.0 VGA compatible controller: ASPEED Technology, Inc. ASPEED Graphics Family (rev 52)
> 
> Since SMMU driver had been already expecting a potential duplicated Stream
> ID in arm_smmu_install_ste_for_dev(), change the arm_smmu_insert_master()
> routine to ignore a duplicated ID from the fwspec->sids array as well.
> 
> Note: this has been failing the iommu_device_probe() since 2021, although a
> recent iommu commit in v6.15-rc1 that moves iommu_device_probe() started to
> fail the SMMU driver probe. Since nobody has cared about DMA Alias support,
> leave that as it was but fix the fundamental iommu_device_probe() breakage.
> 
> Fixes: cdf315f907d4 ("iommu/arm-smmu-v3: Maintain a SID->device structure")
> Cc: stable@vger.kernel.org
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

This should go to rc as it has become urgent with the probe
reorder. Use [PATCH rc] to idicate this..

Jason
