Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011038.outbound.protection.outlook.com [52.101.62.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1DE2D7DC8
	for <iommu@lists.linux.dev>; Fri,  7 Nov 2025 01:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762477435; cv=fail; b=NQJDBNsfesr1OZZc8Y3owFMuCrT8r25b4UfOgNO9hGKYRtnpBRrDFsgicbeZOFeq5m17ql3irRtsKX+LNdIsxKzNx6BGCYSqBqBQ1o9H2WX0erChuv1jpMnVg63eNjwGOO2hCdIdP6lgMqWiPnnxaibbsZIbPgJFD+nImcmURXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762477435; c=relaxed/simple;
	bh=zcJ8N0skGCTle7tnPAgoXbtfG9WKvMLPqR47TGqh5sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ryYN9YDGY74nZUUKMeBOojbtvLuukj9a+YqtF1UPadti5zc65mDzsByZ6Ca6levsyot5Maytdf5Xg/GLjNjrnZzy7eUxjv5JxI+X+CMKXsuw0zvaNTeSKoliELnDZKlFdpPxqMmLF4JFsyhjAY6k8rLM2LFNdDCJ/6r4qtRVXlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q7Ee4k/G; arc=fail smtp.client-ip=52.101.62.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q7Ee4k/G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lxjd4YeyH0hdWGDjpg1tfdNlS6mUUoVYqy3IeXbNEg8iIZz3+j+p/lbnNgVRKWvL1iQr7VBX0gAz2wVv7I1Jb2q14wJTCTd95rNa2ANWd6NZrQFogO6bxs5QB4LUFLR/1p9ojRaLP42G+6KlQP032RrdS4hVo8cV/yxcx8hyky/WbbgyPm120txmBo1n39X72XG49j9eV31UxdWEMXud7ObIBCE5X7r4d0orHCtzf0YEq7gn8l4WK09VYv2HY9UMs2qB0q9zcYG5jzn8sjnGctaBpQmk+RGG7ONH5RJSnwMbVjFn4sW3zArUGsStQtdi3UPZIXPOtnm3uwbNcxTEWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8yC+XOzccmcZGeZOpNfqgwPaoJ4j9QK0dV5uPRWFI64=;
 b=EwkAUZ0DOoNHMncTmdy0w23nirPtJ98S6VGZxT4x7ehUw9Z45+rl4Zi4WqlQV6xKyC8lVPtY1IklAmVFIgc9dzFr451NSgVXh9LGWoSPaEIi6Leg++X2460AtBSMCiKJ4ka5FXr1Zvk2K5724+bhFOMKfNhqCxjs3u9aMGt8G3oZcJFkGdrl66+5ZuGrM3vyEyDIp48gZ+IwLB1oUrrGF5TbGhj7A7GvISR2bLO3/Xa3f/tfCNXym3yTTU7nJIzld4AbHihEnxi4vzQPp7YcqZdfFAZeez2KAezgLJXqv3jd8vqLemrGPsIpiosN08z5uPvGCDPoR9XnjzxBTdUj0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8yC+XOzccmcZGeZOpNfqgwPaoJ4j9QK0dV5uPRWFI64=;
 b=Q7Ee4k/GVju4iCCFAlgRo7E3Ugc6ghrb9Z7e3Didfz2SQM60t8JzfEscyBoCaw8oFPrDq4WqRZnJeI5xlSIdW34tfE5Xc9tBEAIfi36N4ipFQE5yJQV8xQjlSFfB2pC1czpqc46TAoclaGnyf2J2anq+LxyPYn+HZ6jHbAsOeQarE9n5Z20jUIm1lzjv5rEa2K1YuOP5UAmXqfUxUoqgBWx8bD6wPBDtCGXcDeARI2E8Ph7WHEkGwlqOASvKgkRn+H+p1ef2eDl9SvpUDgxNLPwkjm2zmfKrD2tuVERBH8hooXIzS4Vj4JWA9AY+0gX6UClCoPujGo+116d4l4vchw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by MN2PR12MB4391.namprd12.prod.outlook.com (2603:10b6:208:269::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 01:03:50 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9298.006; Fri, 7 Nov 2025
 01:03:50 +0000
Date: Thu, 6 Nov 2025 21:03:49 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Wei Wang <wei.w.wang@hotmail.com>
Cc: alex@shazbot.org, suravee.suthikulpanit@amd.com,
	thomas.lendacky@amd.com, joro@8bytes.org, kevin.tian@intel.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH v2 2/2] vfio/type1: Set IOMMU_MMIO in dma->prot for
 MMIO-backed addresses
Message-ID: <20251107010349.GD1708009@nvidia.com>
References: <SI2PR01MB439373CA7A023D8EC4C42040DCC7A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <SI2PR01MB4393DFDCB2788CB823DAEC64DCC7A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SI2PR01MB4393DFDCB2788CB823DAEC64DCC7A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-ClientProxiedBy: MN0P223CA0015.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::9) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|MN2PR12MB4391:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b8c2ac8-f7ce-42a1-828b-08de1d99837d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zFUOurx05QI4EU7uds6DWKQwcwxAEHogrnpnqmx1a+ix71kJFD30iGYYnq1X?=
 =?us-ascii?Q?4iXYXvOnEm6TtCDOqolY0mZspXOeoX5YlJKSpRMOaoqciebpwZyMB0acc86I?=
 =?us-ascii?Q?bttuyHb8Bfxa0L0kokfj2WJULOBiKF7HR5Gpdei0Uv6spjOCX4BttRJH9k4A?=
 =?us-ascii?Q?gzdHn71I5CV43k/xLKVL5ZpzL6FM5bWVjLHgDCnh/M2DJcTx0abAhtE5LWZ7?=
 =?us-ascii?Q?HfWiZtyGeOldW7AN1aPONoEVf1KVBuzbKaJjTjjKDJicdTkAI7cCTlEIEypU?=
 =?us-ascii?Q?3t5p4YLfwVe90uucd8cMGGxjmKs25XjKaZ1TEoRKRt5lTc76VtJMq/qwNFsL?=
 =?us-ascii?Q?Yb5CjXDpZ/IvCQKaRxzt9GDcAP8z56CjClemFxnVphDqFABtpgWT2YUUDKGs?=
 =?us-ascii?Q?xtxUSxL5WGqsN/Aa8ZlniHTiMmADWD+L/hZvZgwdeG7qn0DBHywcEEwn5V+e?=
 =?us-ascii?Q?4RLfA9PEfW6qAtEov4NkDo4tG12eQ2IthsRPkb6ezDnWZkD/N/8GfGhGT2Yd?=
 =?us-ascii?Q?qvu850huG3nsxF8auz5TE2E33FydIZSg2Gk4KIOYw2lX+HGne+FSCZeDYWq6?=
 =?us-ascii?Q?ylyogJgmYD/BCag+svlE/JivLVYevc29Ba+ZlOPrhisBciT1EZPzP1UxBnCX?=
 =?us-ascii?Q?e6YNuiexgtEu4zFxOjBBbIUeN73raXjJxgFoRXO20btrVXK49VNPrpviigZx?=
 =?us-ascii?Q?9m87e1MZsHLgw0KfL4bN+h4Dc1WQl7N2oCWdhrDLpHq7C2htbN6o1WOwwX3C?=
 =?us-ascii?Q?r3xHzems/rNs4xknDlW8bgLwN9OkRP78Hnws9lHLazRZ10Y6lbqsYFsJ3g/D?=
 =?us-ascii?Q?dWtx4Ad/+TCiZ8FKlZI4STrwxiwFLoRXssItS9i/A4Ng+bP1d88/NrnSW2Rj?=
 =?us-ascii?Q?42BpQMuQPe7vSz0xYnO+1jQLWfPYN/1WKCuEUxfGSGy6rFufJleIJD7wOPlQ?=
 =?us-ascii?Q?xJA0z1ebSk9icbgoUU4L1BM4tTCv/Z3ubPTDlkZ0pHvQXmejhCmZkvnztPs/?=
 =?us-ascii?Q?LN+o5tWvw4f/hiQKSQ4UAjMXQs+oB7qS02XwVm9x2b8Koo69pJfYdbw9lIai?=
 =?us-ascii?Q?kRgmnbhJbSq+WWuckw+Fi1yzRZhao3HRHctTa34AsOhAyY/YqaC7kcUdfFRD?=
 =?us-ascii?Q?626vFrMfPogs9iIB5zpbC73togICklpor8lxtr49X/enWaPny8MxXAZoouqL?=
 =?us-ascii?Q?XpHrAUVOEbnzeGG93IK4hY+9T6TzlZhgzHjGZpK+NwCCt3rDOeUf9ugP9TPy?=
 =?us-ascii?Q?duKm6K224KQTuCvfvaGTYAn9PsXzHCVJBL1u4J6LQ9YlxW9aVpvKQc+DIKh0?=
 =?us-ascii?Q?ir7+4yCOc3tzGmGsoeiZM3RIwmDWxMYgz4gAVzC350oXzezaV3br6XUCKlga?=
 =?us-ascii?Q?sVyTBYdG5RaFcdXd/YNbaJfbc2Jzeey+SsiVVu4JJ3gpufpIBqg71qbBLcC+?=
 =?us-ascii?Q?x2/5w1AgDTWEGRSJQHuMmglXupNJrR6y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IBISujpdrPdq8gGuDbLc6riplRFc88UH53EzVRtmY2vPZF37739UpcTE/Hmf?=
 =?us-ascii?Q?gaiLJRmpFlNz7FpBHrY9gV/0BhPP7nXhFmnxJQ2kOrCwJgFXgB6Mcc2OAQhD?=
 =?us-ascii?Q?YTJoV2KDVsdy2b9T631L9hPjhmnwGaf404iRc3ZyIhJ1sT6Yghc95pREaEYz?=
 =?us-ascii?Q?gX3XodjW0g4riQRjvvpvgBZuPNHPGJV4XUxHA2tJmky0yh9n6oZSNFHKO/Yi?=
 =?us-ascii?Q?Khd0GE9umsxy90iJMmU+RoS9+F6eej87TQFnO1DW7S8onO6dZSmBZnda1tbE?=
 =?us-ascii?Q?oY1nDF6J+QSB9nV51d4s/XF4292yOKFjc5gwNG4dPHH5NbW2JWVZqL+biC+B?=
 =?us-ascii?Q?ZbGA+6SMlN9s4lDO5l5shvQ0Kbzm63LBNgu5KIPyaIuV+fj1TxAoU80LFbHo?=
 =?us-ascii?Q?LC9WLCm+fahMCU1Kn5Nt/mIkP487cNHDvKaxSdpfoLj+FJs/NT4QPVkX4k5z?=
 =?us-ascii?Q?3y+SzMlNqg6hLnQzJmzYz+9D+O/Mvp7KjbzFS0+sb2ygx694hYsayPMmZGrA?=
 =?us-ascii?Q?yYHhBFo9BRG7ds1Rt9fBGedib28srf+jXNELNWj5zYCK31hsOZNdAWVnoJ/B?=
 =?us-ascii?Q?xGg74TCu+qyPBnR6ClfIaDElBHLONG504IUx6kdaQu8dcEQo5BBG3Faobfd7?=
 =?us-ascii?Q?2WvBN8QBhPfk2eRJNXYOJRa5ZeopAFGm7c78a6nNP2Kl7PbZCcwKV0vxdl/p?=
 =?us-ascii?Q?eUC8Cb8eQ77HlHgHij57nZ0ikJysUzyda2dBJjVr8ZUl1W4B9TGCIJm30E+D?=
 =?us-ascii?Q?65Wm5MmESF2sSIiiMjwG86RuluCgiCfDQaVpl1zkmEIP/ylz2ro+/AZn3ioM?=
 =?us-ascii?Q?YFGmDqPR19XaSHgBYpPc1SitVIKelqirsH2pvA19SJTMvZgax2xSAEu4u85S?=
 =?us-ascii?Q?ZiRcvk9mmu7QIs3e977NXRfC+nsCr/YXDPnbNReKJGankadGulJgxoukp5Pt?=
 =?us-ascii?Q?Y3pnp1qaFqygF3yOXIFL0lmwg9e4y/WFTG3U6WxySZyyN4Ehzocdh1yTrVOo?=
 =?us-ascii?Q?TyKCoGJcE8aJ+LHMgJ+d37la78pVknwc/bYWPo2I/eZUE8cRVG5B4caC62+C?=
 =?us-ascii?Q?gCx40wdGWeuaCNcXu6UXEMcmlD8K1335PSAItrcxjpm+OISvd0yohbzKY+ef?=
 =?us-ascii?Q?FBzYwLUqUH1XP19OGKEn5uMHJrb5TzwQdqFpjHZkRnMQV12tZF1uMEK0S0sX?=
 =?us-ascii?Q?NMkgXbCLmK7dJgw3AErp7zyqnafp0vJnqeT7FQkluqYU2X7hkX2RxQ6TsDzO?=
 =?us-ascii?Q?p921s4Bfg5JkTqmLM5zsz/Wyfyy81nJlAsAkrlbGneO3Z3BIiUxZcn1gRfXA?=
 =?us-ascii?Q?R4s/E9dN0BaTtHUYeU644iv46Nt5aCoooRJxAy+6hOxgoFOKJOC4n8EfSbB/?=
 =?us-ascii?Q?207zYjSsGeftMnKe9AgOETKrQ2srGiPtRJ9Jk81lnyCVMZt/1K1Bc7nAZX1n?=
 =?us-ascii?Q?d48e8zKmqefd5Wz6XPcxYX584fFPuirCq5Bf7Lu6+xOM39nKlxonTdI3nE9L?=
 =?us-ascii?Q?Fs3+2ngtZ7TZ3YJbUfPiOK61NzucJ/uLWswzc54lPGnmDT7eveHYpH1JLdsu?=
 =?us-ascii?Q?8gX6jEgfNKSybMJ89Zo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b8c2ac8-f7ce-42a1-828b-08de1d99837d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 01:03:50.8115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YxFhdZ92qkjnSC5LxE2Xv0CdEcNSHmAEXQ8LjSIHFt5j5M5a2dWH3j0gOMMyE8Z8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4391

On Mon, Nov 03, 2025 at 10:00:34PM +0800, Wei Wang wrote:
> Before requesting the IOMMU driver to map an IOVA to a physical address,
> set the IOMMU_MMIO flag in dma->prot when the physical address corresponds
> to MMIO. This allows the IOMMU driver to handle MMIO mappings specially.
> For example, on AMD CPUs with SME enabled, the AMD IOMMU driver avoids
> setting the C-bit if iommu_map() is called with IOMMU_MMIO set in prot.
> This prevents issues with PCIe P2P communication, since current PCIe
> switches and devices do not interpret the C-bit correctly.
> 
> Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)

This may be the best you can do with vfio type1, but just because the
VMA is special doesn't necessarily mean it is MMIO, nor does it mean
it is decrypted memory.

I think to really make this work fully properly going forward people
are going to have to use iommufd's dmabuf.

Jason
