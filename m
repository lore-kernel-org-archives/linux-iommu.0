Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012067.outbound.protection.outlook.com [40.107.200.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A821A680C
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 22:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778539727; cv=fail; b=QTspSqCbX1pBXsXL+d6BWF+mVfqsG0MIDTsx+HnB5rANUG4ZZgPRwIWtfIC1X639gYLBaZ1BwWR8c0KC0CkfMOsJqfmf5N3T9gWyqoJLLSeD9EKpBwCJdI58YQBE3f7vVc7O47brfj3ZQxlIeJIBcpNy0u0VzxvP7NC07DoQhy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778539727; c=relaxed/simple;
	bh=ZcGlacXy9AYRaZhXq0nBnWKdQJhC4UKjtDu2CWmSOp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HcxVOVQS6Xz+duEFWKb+ZooEUtQ6aiIYPWCni0IrWLasmyoFwJpDD48oIeDvXG6+10xEZ3/8gJWFdZxywZ31CSoOTR7W5j7XEkVXEzVo6ULRJvk5hTr/w7TNZeqpcTZcjMjXPxCkm79DDVRJM6w9x83d/Aj5nm+HZ/WXFXCdBOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kQ5eDgM5; arc=fail smtp.client-ip=40.107.200.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kQ5eDgM5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BuzIDk8Tpey0sumH9F3PESFLEK4rU/nCs82HjujT5f8zg8tDYBg0x84/y1iuQ27Uanc/7b2YdRp4r3Yl5jBA23guHI/s9LM3vAx2wE5S5JWnDKedY277IponzEkucipNk0Zp4fm1v5pTvzUm/VJACBcamexHt7fdLff1btmysIAPAj8p1Yo5X4NFgH/hAFZIRxNcTEl9RHm9aOBPhg2R5+odIe8uKX+MlljaXOJMJuHrFXdWOgKkChWGhMradG/pN/r7lalrxt71lALewNxDexnFP1s9HaqZFxXfKxXkjlEk4ZzY+X1FD2DhREmZ4McWYYWAUNDjne2+c6+t1cJU8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34fmHfHLuYL6yOYa7+w4Tf35A4aKcUPqmxiOnnDyqPY=;
 b=MYLHn1vMEKHvWooWX0HxvcrajC/2H+IJFvPWl8MiagjfLCXJVytQjBZpQK7aWNJEhgmxoOKrJvSGieyAGxD7FvDrxCL+/zZHoGgOFT5jrzbBu7SKZfN6E7JujsG5HPk/bjHA72aQDzz9l0GMcXzjMAym7JkX8e9YS2h2ght7pToGGZk6B4vjCnu2ejBuIOnOLXUtuxbN5jFevbfMSCgSwKt6TDPN5swajFzxLYfmQdQF+taqPAh1nSqqqcIB+S5BO2rQ6q81Y4r+5CCHBygBN9GlWrHvHWeed7JR5k+SQiBEzwp0Iz7SRV02XpFwO84Iag3NrhJMLBAV2tniddipRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34fmHfHLuYL6yOYa7+w4Tf35A4aKcUPqmxiOnnDyqPY=;
 b=kQ5eDgM5sOq2rU2o+B02Tcvvw9hHVxkbTNZDyVJfBuXyiw3D9Q1i5kUDvdFJWhTRsYqt2B9R2QBuHdsbS+W3IpF4a19HJUzqXCNWfe9a52qGf93vgUiWUfQiAtFcxReNzE7PfuSF/FKBbE9CzMD9SmYaCO7uLcfVFU8b7CrGYsTdxkt1hLMqyIomb0RAUJm/JX5txJ0UOqBxycRmwA1gHT47iGGvgOk8UnVqgW4BQMPfWqwuYRvbzyeRVQJOPwuoK3UxGac2BS9VbejR0ZMsg9z9YI5/n01NjgMTMOGDWSVaPmUMs6uA1ajjCN9KMBqT8yJMWwiFqXyshtDQwgOHJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 22:48:42 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 22:48:42 +0000
Date: Mon, 11 May 2026 19:48:41 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Dongwon Kim <dongwon.kim@intel.com>,
	dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Leon Romanovsky <leonro@nvidia.com>, linaro-mm-sig@lists.linaro.org,
	linux-media@vger.kernel.org,
	Matthew Brost <matthew.brost@intel.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: Re: [PATCH RFC 21/26] dma-buf: Add the Physical Address List DMA
 mapping type
Message-ID: <20260511224841.GA1197107@nvidia.com>
References: <21-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com>
 <c413710b-4c28-4ed8-88ec-aeb8c4482011@amd.com>
 <20260413121628.GE2588311@nvidia.com>
 <f6d38a08-009c-4efe-9dc3-6bcf00ac35f7@amd.com>
 <20260422115306.GI3199414@nvidia.com>
 <fd8065ce-fd0e-4df5-9c80-8e9603657cfe@amd.com>
 <20260422131337.GJ3199414@nvidia.com>
 <e67426b9-4ded-4f6c-8309-7f847adb4540@amd.com>
 <20260422150000.GK3199414@nvidia.com>
 <af7GzASJiASopYiN@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af7GzASJiASopYiN@yilunxu-OptiPlex-7050>
X-ClientProxiedBy: YT4P288CA0064.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN0PR12MB6293:EE_
X-MS-Office365-Filtering-Correlation-Id: a4ec01ac-6ae7-4d6a-ff39-08deafaf7337
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|56012099003|22082099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	NkUryylRYpF4AN+g75t4XKt1Xy6npWeHukAEWYC/k3dvztsZEROaQ92UqepYD6q3prOlBKWxC020O0WrMNJVkxde0yFj8jDfl350jF5If4x+3rwY8kjzsFefo23f4HUKXJKKi+Kwo8waftVBW8a5D4xB2gdk/Q3jq+fgedmuUZ6E1xGb4ST7zSPb8hJoDjnNVB+Z2QyGiUt6wUlxzDQyoNLtpEuGmyDwSacMGD5fFcbahJELtMo9ZNFdu+O2PumuDu0FBC2LbVdzQCeBenNRbyxilKELgOsgqpA5uNy9W1UkIx5myh9PSEZU5rNx39R2oi+uxxueTM7ovseKQxsRWpEGhvU3K16Q6lqZ7HZbml423T2qtKEyOPCdzeM8KD+FDLMeJpucm2O0QIWxiTOXkqK98w4R4xIMf6MTVznfJD+t5SvgfitI8ZU4oHEL9+Xj76TiscDYuq2zHcthv5SVm12KB2BzT17kPWYuyNNLmACugj+RjAy4pTd+7iugc3+WAYuL1E8nYTK++J+fHlnAs3eE75pgRJoWpqDgr89Mk03+kZAhIPxMf27EUhpXSYXgB82YenFSPScjt81i5J31fWVfJIO1uyHLjI9vYehY/KdfNervAJz9oRaPHpyKI0FT4aXCS3V2uT7352y8CBzLaYfiMhzNV2sZNxeViLaArRsP7uwPZTROcNaGz3NYCtT9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dVwmFDil+D5xpY6yzP45s/3HQSz5CkfDIBsAXpt1GE/5LyrmJDXE+J+1JME4?=
 =?us-ascii?Q?IU4ynkIYH4j/+XGWdxXKmDVWuJpndn/ZX3popVLdouu6G+JVFZdV5oviI4cv?=
 =?us-ascii?Q?diHmefEzIj7H3YqeBcV6hXztq8/5GTbcyN7tGQteB79f934PbcZrQz1CycZG?=
 =?us-ascii?Q?Yd484vRtiSyRO7KdlsvoLe7np73e/x+zr3LAcDlOp2HDmL7FqTrkzRhxfRVA?=
 =?us-ascii?Q?KoVVM58FNtPR++pVE5Zhba+w6tVZinZN9llf/zGl5pPMg8at1VSk2RXwQrnb?=
 =?us-ascii?Q?c1RPiKCCasZ3T6CKRq/YRq6BWX1BK63VK9eJFk3yGfhBV2x8tocLP5PnuS7+?=
 =?us-ascii?Q?TLVV8JpB7GCgcsKGx8JIBW5PYrmOhHMrWMlE8TwPHfuzX3+v3ECq7+LQOMLL?=
 =?us-ascii?Q?VR2BezLHCzxyaTbKq8gZPoDj8W8YsP2SX2kOQoiBWaf+r6HsOn+tUCLy6ApN?=
 =?us-ascii?Q?JkYhUZ0RKJfuqF/k1c2PezlFyUjbEzW4ZvVqlg4Z8dXKJ2S1+oewqe5gXDk+?=
 =?us-ascii?Q?VT3BREcHgmuvuLjHMfkVGR6n/m9AN4LV0/cKvZMTmQ9RS5ikCH76FMFxi/az?=
 =?us-ascii?Q?q/ylPUrk5BymCBvaicOu+SO2zh5v4EIrB+Q3PzQaGF/Kxk7elnTfRkJxIywx?=
 =?us-ascii?Q?GZazpuPrQpuZm8R2JwgZ2izCnd7AerMCVZgMgkUTcoDvQ8Ev3q4f5FBMMdq7?=
 =?us-ascii?Q?/1WKwszUeOLmdDoZiQdCe2v5XqlZzNeFF0Q4VxUtPzBCNV/8aTeHFyW9YBX0?=
 =?us-ascii?Q?/2VIxFUtCEhI/5MFLmtuME/BAXI3ZtFLNDkCTcIx0aTNe65yCoxQow/atRVz?=
 =?us-ascii?Q?e1HD8PvlDwPO7y88yT4+OYm372zehzcgtvVPQX+9hHr+7G4aR6LoursjvdeC?=
 =?us-ascii?Q?HsZDSP51NVZH8RQq7nIO1DZQpsM3QqrQwz2nIn6RmChCxPuMOWGr9lNyTjXP?=
 =?us-ascii?Q?aQ6HjZ68pBkRmPkbwb+bz1A2ckUh+GrnGhlzX/99RQki3wiPWJl5rwlnYCJY?=
 =?us-ascii?Q?dZmuaa9O0Bm+ZeVdkkluAacDiXN0bSkNhjz5HaoFy/wZb8cWo4YMx9LODaNq?=
 =?us-ascii?Q?Xi4l/ig0u+zQP9KZYATi3d9k8kdbHIk4OlNpQv6RqcHNCHpjHb+241/dc03l?=
 =?us-ascii?Q?2PLUqtu7y/Tq2StBzvY0s36WG6iVZn42RH5/XQ58AkkDxnM1+//FR38u6505?=
 =?us-ascii?Q?EqeMO4avtwCxsi0VAzCr/1KvKn2GTxPL/mkddPo13z6+7LsORAAwBcmL5+1n?=
 =?us-ascii?Q?xI/GbHzQz9Os/pXc3KtlWPdrODdf+MK0TWib2po7NStlpMsGzHUC18ERCQWX?=
 =?us-ascii?Q?/bilgOahvt9AfzeTWI8AWi7f6sM17fDRtrTLZKJz7wYSFrTFF9DjTvm5LZFf?=
 =?us-ascii?Q?ddRFrOjbNVtvusEHFTJhzYNQLo2IAqPSrS6kTWU+l58/hcK7oweSBLcj1b4M?=
 =?us-ascii?Q?Gn5YXnoO7Dm1G0Xc5Ip7bdmFRXB4kHHx6VRTFSLt9uq79EM6vWTsrZu2TUqn?=
 =?us-ascii?Q?tkRjz6CoFs+hwb+/RfRDjD1Qs5NKT8jae0m1/oJHyYh1vWd640itwXzCwsDm?=
 =?us-ascii?Q?iTmfp5GktfFv3gOLBh3/lPSPZqFd2ief8U/BilawA5HE5LnpEmSlvGxEnaMf?=
 =?us-ascii?Q?P0srVi3VrqjOML2Zf7VHIVNdd2EimGJIwjaeClSvp47jbykGBWKzDlOicIKh?=
 =?us-ascii?Q?CDKwhIWqB/5sW77Sar+NWL1vJi7W4wYeCxWeQ2B914o0Nfl2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4ec01ac-6ae7-4d6a-ff39-08deafaf7337
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 22:48:42.2994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Q5zmiKIXDC058cnpcfzI8Bisrye2BTbX9tIEhtjXqESrfYZJ7J1JueOaKm5zceB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6293

On Sat, May 09, 2026 at 01:31:56PM +0800, Xu Yilun wrote:
> > Would you be open to an in-between? The exporter and importer both
> > have information that should not leak into each other's drivers. 
> > 
> > What if the dmabuf mapping type core code was the only thing that had
> > access to *BOTH*? The exporter provides the address data, the importer
> > provides the iommu_domain. The core code, and only the core code, has
> > both and does the required operation?
> 
> I think that may not work for KVM. On IOMMU side, IOMMUFD acts as the
> address space (iova) manager and dma_api/IOMMU driver acts as the
> actual page table mapper. But for KVM, it is both. KVM doesn't allow
> another component to provide an unknown address space (GPA space) and
> say "map it", so doesn't expose to other components about "KVM domain".
> 
> Even if we expose "KVM domain", KVM still acts as the importer and the
> mapper, is it wierd to say we trust KVM-the-mapper, but don't trust
> KVM-the-as-manager?
> 
> Is it also wierd that we trust IOMMU-the-mapper, but don't trust
> IOMMUFD-the-as-manager? There are more IOMMU drivers than IOMMUFD...

Yeah, it doesn't work well for kvm, and yes it is really weird and
worse that phys in every way..

Jason
