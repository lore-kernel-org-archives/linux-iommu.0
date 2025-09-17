Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012057.outbound.protection.outlook.com [52.101.43.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62B4BA45
	for <iommu@lists.linux.dev>; Wed, 17 Sep 2025 11:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758108774; cv=fail; b=as6JUc44NBr2ySYnRfqNsN4/MFTpQhetLKZ+ioNt3gydGTarRh8hHpC3myQi1GuB1ZdaqwnrXfx+kTvX9HnX2bKWUPkwd7yDVRAF7rRUyVpWmdXD8XpyM0hupP719qbgOjljpD0GG/+SlIlz399JqETi5aTkB2hhqVOwvqY2Rn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758108774; c=relaxed/simple;
	bh=AGx/mFSeQNrhODuGmK1B1Xb9QqaPTAuDJIDZFLt+6ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ks1OaWY/z+s3QHOv4R4Qm/8Wknu1PCCr/yh7xY5UmiJCZSD4gLJR4y/R64Xm+Pr+82BJLm76nqcjhnHU5ePoilwe3WHqHXIHDQolEvZvzNHqZjvxLwSYYUmk7+vUmKdsKrvl6R5mghVrq0RnoTrsine569nNwoRfGE5ZefNihEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T7mJxNgU; arc=fail smtp.client-ip=52.101.43.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T7mJxNgU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jdxRzoRzxRmMo1IVbeAyNxcxrb/hUBMjcnPImLSsvkWJ4IePQl3GzgdS5zcoPTASJ3uBDswGWC4MeLPL+IVClqkR8RdoKyOXMGLLhnGl327w7WhgidZhdyLkXj2WtAehf5ScZ2ZLhO5GW4ZAMLrUnhYdCdN03NTzAxo9+XQjALiIzPx5yQYXWz2/0nxIw8U1dRFsx1I6Udsv6VLHX/Y8hwSKY3QbbBpgp6Eo0noDosB63D1RZdd3MN/uKiQ7BJPljtP+t3+W3TaU4F/CROdoUcBxyVh3NHi7f15Ps5kUHA9BOe9s283zbCY+TQimdlyelMgmqyBChReLaw7JqoJUBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EmlpJxowL13vVmZwfjspeQzbRZHwDDSRCmF2O2u9k+U=;
 b=KYDMk4Uey7iPX2WqfVcYNx0khgqL2JOoBP++23X2wzjiuE81ZqaS1ys9ARwyMF7YDry2hn+dYjRY+eSOyX+vuEYmAzHXwQfs6MwKzyaJyUa2/7Al01PbBxYVgC3ZIvk5TGUGelEQqvq9TmBz0xgkmWHbo2x04AmlEwc6tzaP+5xDnTp9houKFMXR82EZDmhAbTo1+gir1TvFqGDkdci4CShc2uMkFckhoLPc5Jr0As4w8tU6oH5PTblSYHQ9eeG10udq3feQMR15rewKAf0h/J3z4ZlLbhkr95aKBkhJ3KkVyFPn/g3lzmZiaX/Ofexa0a1QKOeKh6Bn6eM5u2Gilw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmlpJxowL13vVmZwfjspeQzbRZHwDDSRCmF2O2u9k+U=;
 b=T7mJxNgUK4Vv4dNtfx39oJwb2+UENvT1ivshIHCYb8EvOe6ZlT8Pf+MMLkIdiw22UFlKjQD0etzWEbzG36dRlQpwC0gozYxJfzHo62xcD520EQnBzUInJnUvj5qDEzFPmoPbZfa8eGEJzKN421ZTYCb9vEhZEx++m/li1smMCV9JWUwjQGnVxlDLfdB9n/4DnGOnLfMWFIR9wbRddnZahQwovI/wyJbpOYeTyYxWOXg1SvnowlQwyb6xydDFGYRves8zth3BkwcV7U9ApvhqrriTy4xAqEAkkNyECAMg9xM0kjqfrJ9Ap7mUd341YaRUdZui0avATYXGw4pG1oxHYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by LV9PR12MB9830.namprd12.prod.outlook.com (2603:10b6:408:2ec::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 11:32:50 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9115.022; Wed, 17 Sep 2025
 11:32:50 +0000
Date: Wed, 17 Sep 2025 08:32:48 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v3 3/4] ARM: dma-mapping: Switch to physical address
 mapping callbacks
Message-ID: <20250917113248.GA1086830@nvidia.com>
References: <cover.1758006942.git.leon@kernel.org>
 <5f96e44b1fb5d92a6a5f25fc9148a733a1a53b9d.1758006942.git.leon@kernel.org>
 <20250916184617.GW1086830@nvidia.com>
 <20250917103644.GB6464@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917103644.GB6464@unreal>
X-ClientProxiedBy: MN2PR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:208:c0::34) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|LV9PR12MB9830:EE_
X-MS-Office365-Filtering-Correlation-Id: 54654f6f-58c6-40d1-9080-08ddf5ddeed2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FLbhxhgeF1bPaoZVG9kuRnmtHEJXX+ST0qPfzlbjEY8K/rtuEeC1N/YzvuLX?=
 =?us-ascii?Q?koutXrYes7keiVnJUgx51dyE1aOZIUfKLK8t/rxE3xihLzZlMdc3CFBxR/Yi?=
 =?us-ascii?Q?Ng5zEgWujPbtkcUfE+hGPw2PikMOeAo/CrZ8D48UqgCHqVYpP2ABOMBGUcgX?=
 =?us-ascii?Q?h8mUJ+lhRP1J8qTSi5qrh49UDbDKhma9s3o4Yby3zx1UAKANDCF6kMkGB6yf?=
 =?us-ascii?Q?zFkuP2BA8nt0ZnBNgpFarPOOV3KmCGZ2mtpotmnwPdzyzJFe+E7f9Hk92vCh?=
 =?us-ascii?Q?CVM+8kbyscqDqtC7GdUETEi52ud5MAwIv3GBS20nMfaGZgKrH5HwVufHbE9S?=
 =?us-ascii?Q?Yz3XzBJc7+eT6c27DanisZ1TXArWriKhZygZBa092ViGDR1afd33orWtCbu0?=
 =?us-ascii?Q?thlDhXljcRKCmmvJASf22zhnHxL46BFWPnSaSrHyU+1p4vqF4auiXkdHZADm?=
 =?us-ascii?Q?qeL1FbFodAb45fGqsnY1qa36ve34+AP4bD/juAqCY74cD5QkYhu+S6BS+Z6e?=
 =?us-ascii?Q?EsG9l19L3USzm1/pBxWpseAiHruuqqs6JA4DS0dQuJKOzEUcjIhkLX/h8BcG?=
 =?us-ascii?Q?tNgmc+OLrmqOgCi2gc/C/30z/1YujXJkVfDKK2jimliEVni7lDdEWNHCC1RM?=
 =?us-ascii?Q?yyD03JQxotJl7sRdXEQi6W9/2Ka3dKia+Mi2T2IiBFDA7vHdiWc2PyIe3Cm7?=
 =?us-ascii?Q?5B54BqxNJKFXWtGc7VCMJd0SPLkI84qX7rJg8/QKA8/RZfzz+paOj7pPtLhY?=
 =?us-ascii?Q?Pfs6ws99XHkbINp3clbPfAjPWaGyo/OtUFYzvWINcGfFc+CyecB8OyII/6dM?=
 =?us-ascii?Q?hAe3rTyA2/T8gGAWdQCSGOCta2u76ewRZLy9fBp7oCVydwzkJ8MvHXERtmD4?=
 =?us-ascii?Q?IyN6f91HmiQg7Mb4JVECk3KVje8RJCXXXtz7YJjYh0iUqXsm+Ro+2SZUP8r+?=
 =?us-ascii?Q?VxC2cgY5EgfU/VAvUfbMsNg2LQiAQV/9UhT790YTKLb/QkI2yWHLKjxs+A8R?=
 =?us-ascii?Q?FkUVwAYSoEOzQuIj/uQU5YuSvozqnp7zGJO6qr5ZlyAhfXi8d5SPNxR29PdJ?=
 =?us-ascii?Q?HnsYRSOn7MIfa2IMPOwWI67drwckcUrlRUGfxPXEXuDPp4zqdbotydqb3t7q?=
 =?us-ascii?Q?5R8MSGQb8HGeRSEkCg7+pQ9PHCPTk0NBFPnO2adUmeIptDiX4YmP4PfpERcU?=
 =?us-ascii?Q?ZwIuwPXAF92btgHzjLmBS0fYg/4ddE0t4tyx3Mi2aTKPKq4SR7xXEm0T1Dk7?=
 =?us-ascii?Q?/klz1KzEft9ty5PtNJ+NOFVZS0mZQvfziAjlaGms19gF7xMVbdQc+U4f2H8h?=
 =?us-ascii?Q?V+l7I9YLFtvmirNmc95yNQcKmWFT1eOJfPeq0+zkmVXB2axN6mxsas4PiEdI?=
 =?us-ascii?Q?vXIaFZF60DkMBrR+2tqjchXARovHXBQJy4lrg7Q0Qq1cQiRTyw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kmEqGdS9/aQiieqZ372WMN9RWTxJfaiNj1DsKFD270fu5lY46VdV+36YJqMC?=
 =?us-ascii?Q?ilFfDmR7/2zjvoc0LIf5cgelPkg1zTCUz4KDlIzGEH5NU5ub9UseYi4ihQZy?=
 =?us-ascii?Q?IJNIOO1ztDGvHTWMjI1p8u+w/GtWbnsV1qk+i19TB6tb7x2NLSElKGWJ3wkl?=
 =?us-ascii?Q?GhdKkCAtoZcsTTjMPvaozQ5qsRMvUjDjXMfFfGKqDRNWnI3PGhbuy6LubxMX?=
 =?us-ascii?Q?8hSSQXc0jsFrSL3Z+GpVFh/gXF3v/1GTQspYRQgIjzfW7innticCvXhS1Gxg?=
 =?us-ascii?Q?en2ol1sQ+IFMmqLQ/Y2dgY+PoyfKqpplhf67cajHLLMxtzLw4QNGmCmKV9MM?=
 =?us-ascii?Q?1Sl9LFSq6orSfTxKkxxZSOcC/AuRlw47qNTga2X5Iqz/xXHtB61PIZyjkyVx?=
 =?us-ascii?Q?nksxoX0xlLkVTt88/OXgKQqwQPfrGxeUtt+yF1kaUm/J5aE7k+rTeLyjGfMp?=
 =?us-ascii?Q?+yRHxZFlNj5LlrAPZheqHd6J1E1JIijxok9LS/mQP9MJFbIIfh2pESVAlIDY?=
 =?us-ascii?Q?pjx+JHSbZ7rbKIuNsrPcTL3hz+9vNdT4ZB+8T2OsZgxTwzi7eH5Ixhg3EPpG?=
 =?us-ascii?Q?Fi6mqKtIxIQo3TR7rYaZ8S8Py8ZFxilJrca0RnxJ4ibh8uh5LyVfKCNFpjMP?=
 =?us-ascii?Q?tE3utiWEUhUeR881cP1v5ZS+X5/ufN+3TSFIgVsd6pZBNOR3b48FrkEw5Gvf?=
 =?us-ascii?Q?M4b4DsffLjAo0Mp8oD2ESwkCrrhDW2bxfAuHjtwusoZ0kSYMnJ7y++NRYTyR?=
 =?us-ascii?Q?SYuF+2Z6gcryeUphr+VhSFwE0Jwnb9L+/VSsieLKPMi5vndCZc2+NCYc77lI?=
 =?us-ascii?Q?Lq72H8W9D46OO97hS1bk3nkChuPGf5aswpoM40W9nOyfDxRCxWv+XK+NRLWq?=
 =?us-ascii?Q?RC/NWZNKIcnfcwL/pxj09tWnS7Xean2mmJBFddSJMOR0G1NAF3F1zZkZnXiT?=
 =?us-ascii?Q?p/TAaTj2I7cBF9s0wWpDPDXDaHTZYxPL/Wr9cyt3ag62hJZcSw/itWwZ7V5b?=
 =?us-ascii?Q?y081wdfv5BGw791tCN75X3N7qYv8/uifkXPxbpvKVXIbwxXsGM2ymW4jjPmK?=
 =?us-ascii?Q?AIi0PKcg/DUqtsgWcIjWIW8cfsWSUkpsDKJUWQhImU867whL8QTQdRBqAHT/?=
 =?us-ascii?Q?BVTyxudf7CCBM/oXjE/gZwWMGuAdsBV3kyBbrY5tuu0dkC11tuoXni3Un+Vn?=
 =?us-ascii?Q?1g6HLqs1Op5R+bILohPHRLGl741pKDwRlbiVl9XB5oLv1fXK+QsNLZOy+mEj?=
 =?us-ascii?Q?9cf0sY4cYkVyaCw0JRCW0ClziYfxfuuTfGsdkvL3DnylvA6NRlu8Vt4sn44L?=
 =?us-ascii?Q?UWTkBg+HMO4H92VH9EEaPy5PxfmmClDeiRjONyfOokcJ5VX7nAcZ4hCEFQIw?=
 =?us-ascii?Q?4MdpIyRJHiZScom5t49ebG8X2nrlpXxRownnqu8edSlCt2xnmuGbYBnCN+o4?=
 =?us-ascii?Q?rowH6jbMv/KoeNUbxmAEclokgWX+gNSRQli1KZouorPa4DD85VWH1JpJf9Cq?=
 =?us-ascii?Q?YzG64KhVuuR2DwP37zSiWpa3RDV57Gq2BEYm8t11d9x/AcrMHClE+M067LZ/?=
 =?us-ascii?Q?Zji0mTDk9ozScAhhsyr6Vl/2hIDx41Dq+p5hu47B?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54654f6f-58c6-40d1-9080-08ddf5ddeed2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 11:32:50.0993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wGq9ilpUZ3sbaAw7rlUco4e2u7TsVVCiURLNm+ZH+of1m8GctKSwkj05U8uBM8Bn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9830

On Wed, Sep 17, 2025 at 01:36:44PM +0300, Leon Romanovsky wrote:
> On Tue, Sep 16, 2025 at 03:46:17PM -0300, Jason Gunthorpe wrote:
> > On Tue, Sep 16, 2025 at 10:32:06AM +0300, Leon Romanovsky wrote:
> > > +	if (!dev->dma_coherent &&
> > > +	    !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO)))
> > > +		__dma_page_cpu_to_dev(phys_to_page(phys), offset, size, dir);
> > 
> > I'd keep going and get rid of the page here too, maybe as a second
> > patch in this series:
> 
> Thanks, it is always unclear how far to go with cleanups.

IMHO to maximally support what Matthew is working on I'd remove all
the struct page things and prefer the pfn/phys variations from the MM
side.

After this the only thing left is the kmap_high_get(), and I'm not
sure what becomes of WANT_PAGE_VIRTUAL in a memdesc world..

Jason
