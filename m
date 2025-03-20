Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2089.outbound.protection.outlook.com [40.107.212.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E74226D02
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 17:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742493075; cv=fail; b=Jt8BegaEq/LihSMC+ZQSvMroZx0Nh7j+HnSHALeCwldvqdAE9bAl2PlUPbKAHfS7iZWYxEMhrBIQ3VLy4Y2F9QWBlUDtBBZ85dIZIXcwtN96Nm2gyP8GRpbNunxC7qlUxP+F5ItAcuXWZdzxzNuJRkv4ykDsXKac6bZplAG59tI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742493075; c=relaxed/simple;
	bh=bY68ObH/WJ9q9Beg1E3m0pCI9DmJG/n7m5JmGFwAdMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OHgd+yPSsrqPPiazkH3nOTl3nZKLpxkxrmYgrbNZsFTX4/44kbBLLLNQCsVfrZnt80kGO0wnalKRsgdnMDEkazNAxtRgd4gUyihsTs7xiU7t1oZwW2cJis0pJ8jhqca47LGdYVdrPsAtKBQn3ZZaEZeQfa4jb3W12g6lh4lKXMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EC13uncA; arc=fail smtp.client-ip=40.107.212.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EC13uncA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SX7EaQhGKGBTwEVx/ZUxzFGOtohfCHrZ7ts0PyxBWTm3tQ0gEJ3K6SYE0Vuhu9ZCoQHADv0Wl96sbkHEuag+aqEt/oz0IapCx9JqbKTeYmefjR8tRCTcIwuvrV7t+W86YqvOO6fa6Djsigpy7DpvYfrXYczUHHWpJHfEJsIQGUL01Q8g8R91zxxqX31Xje6UUrer50qyMSUgmnfPk8Pad64ALh9mUQu+baKt/QH/6ejbxvYi+mDN5Pt8aLQO7e/+fWIBERV3dbvw5LZaCb3vkquXaa6R1lzgrAhzaIRhiqaf0e+hwrybV9GUH7b5Jcf7iPsUe7znGU1FmZW7DJfswg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MB7iLFGShGjhiL0CaBGQf+ve+lNzEdRbsNlXc5Mg8HM=;
 b=XgyDZmcC++V82eUr2mVNB1Nn+tTs3Ks8rzLGl4GQeJXB9FGxILz0fBbgNbMGN6jADzfUMupTTa+SBuc/ThsmMf4FD5LUFO99ZNzY26OvcGP4N/uHEFDv+MSVs9khRMLgIBc0h59GkxP/1kvUZp7Ih6VFx2plb/UI58KtQwyBIkJ2A0m0XmyIMlVott2nEcemJjI5oj2WTAtfOVcUDf/x2yyK+/Alo4yLTVQjumqhEHg3r4a0Gw9yCgXwGE3+z4QwSk6Qps13XxO0IR+nURQ3yNeUG6axQEpSaKgCkssBvbryoHiLoz6WABNohRujVNI2a2NQXVgC3GynkX/bCeFssQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MB7iLFGShGjhiL0CaBGQf+ve+lNzEdRbsNlXc5Mg8HM=;
 b=EC13uncA4YX2uh/gmoCZwOox9m4cl60ZRF/z3/VIumfzAeK4MvpQuUGuFwnJWYoKR+B+l7TKFawmYhiIt7/vckJDGHwP4Khzi8s/zQhEmDUX6TRGcg1LG4tfv3GEIK4MQATlafLRlfPKkQhsh0lC2KOxYgKpF5gVGvGt7knuW33f6UJVxB08j6XdhbJA9k9CJo6j/wnq1a9oNCIMcDO4yLH2NWiIaVviKMvFAOHANZAsgqK8igXVHy2YEblAzffH7dqOoDiVHkE8RbMgCqauRiskYCM5oFmF4I+WLsQXlS3JD2ARC4nsSfqbTttoSB35DV2qowUdCBVbQPURUTd76g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB6332.namprd12.prod.outlook.com (2603:10b6:208:3e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 17:51:09 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 17:51:08 +0000
Date: Thu, 20 Mar 2025 14:51:07 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: kevin.tian@intel.com, joro@8bytes.org, baolu.lu@linux.intel.com,
	iommu@lists.linux.dev, nicolinc@nvidia.com
Subject: Re: [PATCH v10 14/18] iommufd: Allow allocating PASID-compatible
 domain
Message-ID: <20250320175107.GD206770@nvidia.com>
References: <20250320134744.5777-1-yi.l.liu@intel.com>
 <20250320134744.5777-15-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320134744.5777-15-yi.l.liu@intel.com>
X-ClientProxiedBy: BN9PR03CA0892.namprd03.prod.outlook.com
 (2603:10b6:408:13c::27) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB6332:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b4d20fa-492f-41c0-14c3-08dd67d7cb6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RaR+PjhoLNDiE35B6ojo2hAEud4oO2R4ekJBB/76qWDzV90aCT0QCFTGvSO+?=
 =?us-ascii?Q?72+aBTFyfGUbnADx0hwPayty8xjxAY9tYxV7AzCafgdv+i5Of/gB/uh2aNio?=
 =?us-ascii?Q?5B9JJ96tDcmaVDvPMnhSdaDLT2F9r0ehhzTdFp/Gd9Z+TQKBfbr7GEsBOCu8?=
 =?us-ascii?Q?ad1frQLG6NuZQ6yI6fGv5l1c+S91WMHY9u7TOBJF200W/mGqusySswU3AHKM?=
 =?us-ascii?Q?Yl97LGw0rENNfjJDzZ/FZnSSDoHcUr60uP19cLMexMfhiEwTudu8LdKoinCk?=
 =?us-ascii?Q?yE8sBHNKcgXsBNlCfpxGOJMZvTdvqJouJgSsN+Kqb6fqMk7DtZdlfumc+K8M?=
 =?us-ascii?Q?KfrD9RjWSDvqGgxJ4BD3rRRVjVB/6l4f/U/kD6MVRvYV3tyQ6WtUKK2bAL6x?=
 =?us-ascii?Q?EX8+i0kupVIka/7MZlaWYECdAEUifuNpx51PzD7LiLZSR59+LGfpqlSwfBhB?=
 =?us-ascii?Q?CWidLqiBr3gA3c8195ecsnXg+IofZqlSpEfUejEUJmDvIHP+I1INU3C0sYRV?=
 =?us-ascii?Q?63IBrwcAkKwvItE+P9zCllusLSx0Axk6qmzYYGOQ6/t4VfaLQJGAyqC1gOQG?=
 =?us-ascii?Q?HTTtrRS3BDhJRd5P7a0weHjNNXJR0zOGR+5hMdlEPuPzOg4+BCVdyT0SDdJP?=
 =?us-ascii?Q?pT0yAhwUJQy6GiaT0dqqIsEnqeNV/UWbDXzhebqU+DTZ1MDOch4VU9Y0Hk2m?=
 =?us-ascii?Q?FPf8lvt4FqGCQZVJlw6psNd6Dzkne/hcOzHv4nBTk7g2XugZMHmphzPLjylv?=
 =?us-ascii?Q?0Twf9v/mHjfGZ5OSBriJeVnRIJLFjN+ulaR4k1tuOU5YobB8WNX33GU5QZqV?=
 =?us-ascii?Q?nSseYPrQy0g8nODDTQUe8P8YqOhaIqlNcRotj1gB28GRkBF6dbiVyJbyJScP?=
 =?us-ascii?Q?WrNevDDojDmL+bt/42N9KLL0NOvjFRwxArmm39/w/BbqwRtTQ4bapgnjAw4p?=
 =?us-ascii?Q?rd+bFzAVTPVNyRQy2V4aAOqvbOJmkXzrKLww095OjoJr+So41A3R16WYXXXz?=
 =?us-ascii?Q?jtFyn6TAR/3PKekK+ztRR3T8WD+1O65tSt+COS6NicxD+PHAQtEKM3kdPTWw?=
 =?us-ascii?Q?99JZ6qHbVACUt5zJvH7qX3KrMa7MtdIvYcT2vlU9etW/FbeTvLv4qdn/qmKI?=
 =?us-ascii?Q?WviQ+9O6i0vIhNvHQrF0pbQGHXqb5v8sRwEKPtFJXVVYgH7pOJYYgM5npCQx?=
 =?us-ascii?Q?cRMpGKKiKGNL5p5IICD4DMWSFALbdixzfKEX3jISga+4AbOlTbu6ZmivKx0E?=
 =?us-ascii?Q?oZudPKJb2sIDffl1gYNHWfPvbr6PuppDiWLirzQqKW0ZwjsC5jX0NoNQpt5q?=
 =?us-ascii?Q?3vvcBQJ/LE9dZNHhVOh8mXCQBPHc8UjDhRwH1TLHTKlcmycd6abuvmz522Nw?=
 =?us-ascii?Q?O2xf8mlDel9k9h6Cof+jBxddo8SB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DD08WoZkAfOtVbtkCa1c4t4pOY2u1ZHy5tlkDOcEZ9Q3lv5w2AH5cTG22IAe?=
 =?us-ascii?Q?CofOwh15p/GMLiMkz2tLeUHBtT/2iJKV+irevj3ROs5rsIHl9xXx91lYSiiN?=
 =?us-ascii?Q?hX6iIvfzIYp7mm0JoxAoIs1F0g0BcipOSCwBbdicmjEHlRf36OpFZHoqKUxe?=
 =?us-ascii?Q?gHcq6rH6VeyzDfDKtue/W5Nc1/PYOlYMdt4wpm+l6UHvptGvfKZ+ePOlToBw?=
 =?us-ascii?Q?7QgDOJcaGq+231W6Ckk+A1cup5Anz1S+EWW9Xr6thnf2Ahe7Ozl/8khA/Qrp?=
 =?us-ascii?Q?t3hXFSgO/0neYsPXHTzffKgb26i8SZV1B/mK4Wz2hKPcy5/2tgrvyznVeU0e?=
 =?us-ascii?Q?HuyvTuXh/YOB9xo4+1VCg6BjW+IAxt0932SntWOz+z7jDqm4tp/aYouShxqm?=
 =?us-ascii?Q?/9nX3bKzgkJYYJSJlLQ2JnT7UXGyzi38GHDciFniCZ7WNG/Z8ujLvKeS1f5b?=
 =?us-ascii?Q?4sMeqPvgK7U8E4j2WQCyYf3RZXAO2AMj+o0ChiA+tnPc+3mPJNSycPjdpBpq?=
 =?us-ascii?Q?y3odg+T9hCn3H2aNT2XXrd7W5Z8YaNu037J5Zfd8tN7lcrlPbeu43k/m9nV7?=
 =?us-ascii?Q?gPYc5qBj3qPgsw+7ckq9OwiwWWPPawP4ykhVIbyKe9U2xlwNQ28ENl55HWLB?=
 =?us-ascii?Q?NIvb8leVodLGXi9xS3gb2ymV1dEVc71eYroZ091UjYSMhI2ugZqj1KG/2eSn?=
 =?us-ascii?Q?cBzY83ke+VNz9PseM2eslDGHe4L+r26Lwi7e6Isykqw+PUo35EUkOe/RYnJX?=
 =?us-ascii?Q?aUZXFCGDCBdAZvzKSfiCq7ao1rgQVZDT3B85M+2fEKiqD2sgIG/RVUJ2PVRJ?=
 =?us-ascii?Q?RGQ6rONPzV0DD1kKt0qW3kw36PdSzpG02e6nofT+OenEdaUTmKJLEC2dAxm1?=
 =?us-ascii?Q?AEbxzDiTlJYDLrR1bmbWKIqqWRGGnCVQ0nqY21TZ7TjfAYBph/grvsZNpRWV?=
 =?us-ascii?Q?C7s6oUscPZW7ZS45U9weRKterrRwkubrKv+SOIDWMBrrPfal8oiVRj/X0Dzd?=
 =?us-ascii?Q?L+YvB1PZ1PQMzMCggEO3Aajv6+HfXugd/bEb2aABg1ssxCYg1eXuYjRF/HDZ?=
 =?us-ascii?Q?UCpNZCqy/FcWcbh4j5ddUKbUWSh51b7MDbPsFhKFBGaiBp2Yn/XSzDs5YB8q?=
 =?us-ascii?Q?hEujk/mgOL3P+UWIZqTf3vHfvY8d8Nq52mvlYWwdh5PxoZTNpvaZivOgpEDy?=
 =?us-ascii?Q?luwIMqlE69FQPjJ0RVZEKrO6/rv1guSIXeBfcFgdJAmYq8GGekWl4UsElG+i?=
 =?us-ascii?Q?R1qIUaLP7y/cJGMtZsKeJ0h4OaBRAEydo22SL7apixo5NzegFl3mfNUGw2fG?=
 =?us-ascii?Q?roRq5U4XIV+LOk1nADH9N28DyRjDz8OaZ+Yf6k2kZdycHNH0Qpi07/uMs/Wo?=
 =?us-ascii?Q?mdb8fbmNk7qNRtVD8sC9oDbzagXv7ebrHh89yYeBLyh1zcIQ2Tj5kRw28lZf?=
 =?us-ascii?Q?bQE8+anE+u6qGwvrlWZXpqNQH6RqL+a46JhX6U8HZFYRRkRskfPA3JnL5ojF?=
 =?us-ascii?Q?sC/oe/tnctw7nMLmDRSLe3GtCpyJELkdAy662QMLRaVcyCzz/jv8C+m40+QJ?=
 =?us-ascii?Q?0ICzEXTwPeqdtF4mCgrJyRL7HxGT6C+QLkuQn3gx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b4d20fa-492f-41c0-14c3-08dd67d7cb6b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 17:51:08.6902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k6IENb2uW294bGikjURh5V+zJBy2XFliqriFceznhOrqdD4ZJjYSP9HBZbd8+xex
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6332

On Thu, Mar 20, 2025 at 06:47:40AM -0700, Yi Liu wrote:
> The underlying infrastructure has supported the PASID attach and related
> enforcement per the requirement of the IOMMU_HWPT_ALLOC_PASID flag. This
> extends iommufd to support PASID compatible domain requested by userspace.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
> v9 -> v10: Dropped r-b tag as the uapi description for ALLOC_PASID is modified
> ---
>  drivers/iommu/iommufd/device.c       | 4 +++-
>  drivers/iommu/iommufd/hw_pagetable.c | 7 ++++---
>  include/uapi/linux/iommufd.h         | 3 +++
>  3 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index 54ffef9c17f7..f09dcddf777b 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -973,7 +973,9 @@ iommufd_device_auto_get_domain(struct iommufd_device *idev, ioasid_t pasid,
>  	}
>  
>  	hwpt_paging = iommufd_hwpt_paging_alloc(idev->ictx, ioas, idev, pasid,
> -						0, immediate_attach, NULL);
> +						pasid != IOMMU_NO_PASID ?
> +						    IOMMU_HWPT_ALLOC_PASID : 0,
> +						immediate_attach, NULL);

I wonder if there is any point to this since userspace couldn't
actually just use autodomains and have something work since the RID
autodomain won't have PASID. I think if userspace wants to use pasid
it has to manually allocate the HWPT for the RID and then why not also
allocate for the PASID?

Anyhow, it doesn't matter much as it is so simple for autodomains..

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
