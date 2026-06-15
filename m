Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011030.outbound.protection.outlook.com [40.93.194.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349EA36B061
	for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 23:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781567599; cv=fail; b=BVA/bVuxE/GXOr0cy5iFu5XolqYAyX9Gyh5a2Sguiuh+xbd3Hn2E9eOJphvMbvZ2vu6L0UsstZSp8RdbBOYuHe/vlxkV63HomHXUr9LoZ1Ygwsew+F2Enr1y29Nf2AS19HHPCDuy8pHeWza1gyhs6DOv3+hX2E/Uiuqqxs4xRXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781567599; c=relaxed/simple;
	bh=CTSyn5jBk/ukHTxZmhFCBrV1oGIewDSzJMkP6svd8mU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bnZrENQPOcCaYphv6gH/qfavw45kn9dHnd4YPWpmLUjjQhsuioU3TDJi3ysRpEIY6AkR2bexEW5Zc53hD9eQIrArHGSG5sQS3i0MRRR0+aNAkXT3js1qfKH0Ew0dk1e7D5NRDlFdc0tzZE6gHLD0IUziAYhyviPGPdHt7TlboI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LjdfL1lG; arc=fail smtp.client-ip=40.93.194.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LjdfL1lG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YGrZkFFO6W488U+KYf9wKFL9mcIHBGwrUa5j3QECega8Km9+BgxYvFKKv/E0KM91z47lS9+H7cAoiYZGDH10FIfDM98V/cIsIv2DoI/4Risp2uG4dn1fcIihv+0VYQzCwoKC5LYN9KmY7MJVMeB8fQ0U8tjieioROuoJP+88rmefHKWzZCtVq38TiVRoSFcITQ5LvUluebl8577skg8wXZ8tBhh5JWnStCGfvoM0Y+T7K5YMBcP9s6IQj1754fggvqy7+h+S0uWbP32me0tWwhkatfFSwNYHd30rphLy4igeCzBuV+sVSdDGIPbYtLYz93dSTqbMvL1ovgwElgyrUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EfozI+Tt78rNpp1B1dacVsXtWSgxrbisM8tWGCAXQrA=;
 b=x6yqbhfOqh7WGqHmR00lkxIElXp9RiTkpcC7yMztyrS/vtpSfEQlw0b9bZsIavd1YbLjVuWrbM7gcElBcYSgvNYIss9qjenCyX3B4SI47+xnpyH48F3utkRp+l8aXJQ2xwMLD1ovvDUhLF8jztYuzqTopJ4E+KRXC+ZYGh6TyvYqsPgluUpqCxR23NBsoaxaJtw0UcDzy8gP4hRgJfwuCX0uutF2wGJtBqsf26V0ls7OTK261oH71pQ1a7RH1HUXR1Y/KvwmGlcOijixbf+zLYz9VcjpuyR7DVV3uZpqO2h2mbFvSYOLL+oEI3oTlh0fLGOjUmFXPUYivZ8Ozd5/Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfozI+Tt78rNpp1B1dacVsXtWSgxrbisM8tWGCAXQrA=;
 b=LjdfL1lGpAgq0eYwiVcQljWiH74iGZoyp7ZaZ/XTLGB9upPc8YSJJYJBz6W6ZwNCOjC7as2gtbNjKINOe+O550ka9izaMHuGRmttWP1RRVbOTodVBJcmy4HVe3mD2viItwyIzlbx3v2hUX9s4pWbBVwVIIFqGqoBBf4tNV16TAzzZ0G5Bd7Kf2jiY6Z6JvZeR9HS75bEzkxXNRwBNWNlm0bWPecKYVZ231C4+pkQ25owaIY3l8jlZWf9h0JQ4+zsR3JYB92idyBunMfe3wh0zOZpmuZpox9/BrgxqToy6eBQAdoFjx9bmkmZv07/H5Wyx9ie1pnNHOVMAhgVivTyDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ2PR12MB7919.namprd12.prod.outlook.com (2603:10b6:a03:4cc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 23:53:04 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 23:53:04 +0000
Date: Mon, 15 Jun 2026 20:53:03 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	joro@8bytes.org, Shuai Xue <xueshuai@linux.alibaba.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Declare eats_s1chk and eats_trans as
 host-endian u64
Message-ID: <20260615235303.GM1962447@nvidia.com>
References: <20260615194533.3290010-1-nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615194533.3290010-1-nicolinc@nvidia.com>
X-ClientProxiedBy: MN2PR20CA0044.namprd20.prod.outlook.com
 (2603:10b6:208:235::13) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ2PR12MB7919:EE_
X-MS-Office365-Filtering-Correlation-Id: ae4ad850-6ed5-4e39-00aa-08decb393d87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	3+lkXg2A6KI+RRM9twRvcegMMynZquOD1qRogUK5s49nUSgcMSP0jVpDTBSjyNAm5uZiLITpRWImeq91QjNZ2FtjckTmfoBC+jWRpnXIdeLTcu47CIQNf8V9W3gVsJWpNNvPbO0sPWWVLYHVK9nhSsEjHGEHZ3KI2dD/HeR2dV2+orqGXxPyASSkjvhRaZrz9TxX2z6Zb7CmeKe/d+LOpUMLmw3ke6+Z9GWSnTMglK673ggL53sEYlrTIChDFaPAgTcYDHkXReCL2/HiMtC/ntGX0W0y8qrovVLOK/oqxWwUvpCYjeKb7+kolB6RHEQuI3hfTZnLyd3gfluYhjPYfbNqnuNnmNCR/jN9bMeEVaIne8EYzimHkfyPSpJiJxY4YU7svomN38u+27owZI/Uqj/e9iK2yO3H4lH6QvTmUDCdroseFO4wu0yEWzEtsFlcukypFP6ABEKCvIHMpyH1CGxwq+i+sXeZIulgkd4tu/Zw8q8/kJmtiypja39cw7f7ZQvXuXA7ACv3bm3mJh6p4DTiPhFhzK8anFVs0H4IyQPmzIFS2Gmd8p96j51kFI4VY4FHAp1s8Rlgb3CQvEwrHHTGqk67PUu+9RSPRMII3bI35o1oMoHtJbPDYNSKfua5duM+eSOXPf/X4cbB6GbsqojVR9MfvkvKxtWMSvudvOfV2yE+/ofGKuqoiFKvVbx+IxqaopmCSFFyZl4abdFLQQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QNtmCYw1uBJQoEBDhh8d1NOvbAkLg8IDF0fjb5+7rpG4QFx6wUgb5NPWuyin?=
 =?us-ascii?Q?3/MDh7xmUNfysUOmEziMrSaL7ra9puwvNQDbO2pel47HKQVDwZsnMzOt52ig?=
 =?us-ascii?Q?gg0axm6+PDet62gbBufgMfVj/ctfOEay7DDEkU9/fxwlFUDCJc/eRgrICYOb?=
 =?us-ascii?Q?lus7FsGZe8dPOPzcNt+90PI4w8y60STmoQdo1M4JERmYtTwPAWgYhhPyfxXN?=
 =?us-ascii?Q?Qg7JADGn7tRJ+5+5ezFCMOwTkLlWmPzqkbmGZw3nz8BnsqFXJQg07topsjAm?=
 =?us-ascii?Q?K3Oh9JzvByvGRhMBEnyrr7PPcGoPnGRaHdUfELwOSgX5MfbXVxfr4XBIQQXK?=
 =?us-ascii?Q?vfS4mvJhBkbFEaT7qON4cBGRBIJ0n3haF//zQKCL5IfLZ3I4uFcH/vQtlBTS?=
 =?us-ascii?Q?xWZT/J3v8S0UGFklna4F9Y0vhdTdvkWJnPDE3Zu8UneKZ1BcMKOHY3RnNnvm?=
 =?us-ascii?Q?mJ4SdwgHAv5HhVyQ2X5gjo/mhsk2yOCLZ9r76qWKpUJZPejYdHdMgRnRdNWU?=
 =?us-ascii?Q?mAtFsQvu5mRmxN1geuVnCJokje5r2ZgnW511sKvta/mpfEy2VuYCn+z49Xpt?=
 =?us-ascii?Q?5modcN1QqvPg6yOkpZtyA76kIuyJkkOCciHCHZJusbMOWEphR3ulVRvsUlmM?=
 =?us-ascii?Q?bcebSjPY12D4LsmPgB/ZGNfSQd6KL82oU1ot1i90HXhQTTPTt0bv4KokwfTT?=
 =?us-ascii?Q?MpMfVvOGux2vZVxPH79WT+hdGFMiyFBFxUJ7Rjh2ygrJnjEao2VROYm64nRM?=
 =?us-ascii?Q?tvI/u/AePmIgPXu2AOy4pRTHNKEbBmeMKIbDz84UDh/imnqGNFJ21GT50sRC?=
 =?us-ascii?Q?EldASw90xzbZK5fg0vctL8CoRkJ9WKhmeph9MH+LK2IGO1Q9a8HQn/OviZE4?=
 =?us-ascii?Q?dv3g0EwjVM/Wr2CteqaISdEr8Aw4V9uujHt/vt9N58pFQ5r9bgOHn0pubyqS?=
 =?us-ascii?Q?sQRHrLrvGFE+LuxrwIxSN/+sxKdGq9sSUPdzWHHZEtEa/RJU9HmSTcjDhyZO?=
 =?us-ascii?Q?Fvbb/qsHOK50Fo4TcQhxXgYxASfgAdLIHkK8bI9O6KPO2M0IpavN/MCKWctn?=
 =?us-ascii?Q?iVS2EulmOMhQ99IFChMmMy7gQ3MIVWPRIGkYPNOPPPe8b3l6EbqK8yzZgTIY?=
 =?us-ascii?Q?GuxiNCl+RVKVMCj3IXDDWLCeMULXt6NU8WbMn76Rz3ocumOPN/pov13/N9z7?=
 =?us-ascii?Q?Xg5hE8NORNFYx+fLmwM2OFbTfomCB/LA7HNcf70t1zEh6zf2oA8bf/sYL1My?=
 =?us-ascii?Q?8W5Y79yzTTJGVdLXVL6vVGPAMUeXJRkGX38LzQtgUhV/a4d/GLZGJEl2AahQ?=
 =?us-ascii?Q?LvsuSYlvULJcTA4ZISM9Zch+ikSAKC/XiretQ2gQT82gO/s3ObWUPuew9dh1?=
 =?us-ascii?Q?m0fu8Bd4dJSenG2DQmfxwvl6pvMKfMN9bANZdDJmB17xxSSMlPY/tH4x1Lq1?=
 =?us-ascii?Q?eYVgp+81CZIY1Zp5VtS17aw0UJppTktiGm7d1hk+voUe5IWWGDa9oyoYifTc?=
 =?us-ascii?Q?3mpTTKSy+527Vm4lg/ePbgeNxavouEpkxTb3aHMxGth0P88IfUf5yhwIxIOV?=
 =?us-ascii?Q?T1UdFQSBv3xL5nTqHnoLSP+9U5xT67RNToQkWRVbuPL11OgfsXqDa28QnVhZ?=
 =?us-ascii?Q?wYxuhrlgyagtM7ctzzeZFux3kgVtMkWa2+UntVh7keNhtP1Xvk8uFnAmMU8W?=
 =?us-ascii?Q?cTKji6tF+hpQNHwazjCcIkJ7rwEFCWHDvVuZj8LpHZFiftbm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae4ad850-6ed5-4e39-00aa-08decb393d87
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 23:53:04.0366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yl3eCAkIPGQt+fR1l38ED0cgSKB6//MGKRDIHaPlVUkrnRs+YI3m/r8rzl6cwoMz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7919

On Mon, Jun 15, 2026 at 12:45:33PM -0700, Nicolin Chen wrote:
> arm_smmu_get_ste_update_safe() declares the eats_s1chk and eats_trans
> locals as __le64, but initializes them from FIELD_PREP(), which returns a
> host-endian value, and passes them through cpu_to_le64() at the use sites.
> 
> Sparse reports the following warnings:
> 
> >> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:1122:38: sparse: sparse: cast from restricted __le64
>    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:1124:33: sparse: sparse: cast from restricted __le64
> 
> Declare both locals as u64 so the type matches FIELD_PREP() and the
> existing cpu_to_le64() at the use sites performs the host-to-little-endian
> conversion. No functional change.
> 
> Fixes: 7cad80048595 ("iommu/arm-smmu-v3: Mark EATS_TRANS safe when computing the update sequence")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/all/202606151017.QU0evpH9-lkp@intel.com/
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
