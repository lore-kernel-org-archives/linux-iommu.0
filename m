Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010028.outbound.protection.outlook.com [52.101.56.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1AD345CDA
	for <iommu@lists.linux.dev>; Fri, 12 Jun 2026 13:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781272492; cv=fail; b=hu6lCISVZkR4Z58gqk0vGonUh59d+ke014tJjI0qRZaLdnkzlkv5lGSQHdoC89ifn/mH4N5ZjuigrxWY6eptNjPgfmXIwuEqRof6GRiGiQqKWuwP8z/0jk3fDuhKW3dkmfUmLN4IqVteeFMk/zD2NkiDpdcrMr0m36bJ5df1uLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781272492; c=relaxed/simple;
	bh=Q2KZ8b2pDsfs+TeRVaSCI+ZN6mAD8vkSh8CH8R4R+bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qdb2Aj1CEqHcyN/Uy5KkMsR3vFrZ3opvQ357mW+O7H1JZyIdmRpqREBL5mKFbtJ8L4zehAkF1hkfNv0HTRmlyS6yAx4mcffO+LmedPMU2mW+LWdLCjHj/HX9XJVBgO4j7bBVkEzhZRJlCSvh7V8d23WEQvo27AYjdPqLYCSSdgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JBrjQH9Y; arc=fail smtp.client-ip=52.101.56.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JBrjQH9Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IU7j2zAnfAPgrT311h04OgOsN6HMVCqJ/rcSbm/kfyjqFGAJYVzcli4g/bdQ9vsYLo4sxYMq+UJ9OFObSLQUBqr5pM+BtOPGVR2kgvFYcrEs+dZheffJiPRAjTnMf8xQ/7JS3qVLZtiU4PcVf0YPrKUPoI4nM+fkfAsmvYN39flIrYuQf0IDsf/JK3OvXN55Yod/UCAV26swsnzphs9zvNJHTT5Q0nYmEVxGMsjdwN3bFjFVX4iVwxjQu8eXtjIpADee2BnROtPI+ful6U1hXEkGHzmHOMl+QJH9v86yJaNwCxI7lnV/L4DztgPhsWaPptb+bkIUwm4en6h7hBZH/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PfFvAY3XixwuBfPHnf/UJXz729X/5T3ln2EgIWxSKZQ=;
 b=YkempFJXcvsttFgc6XH8DPPPPi+VMukwmKLjpLwg9zl4QwohIRB7Yir+fy7ZtUG6TojQWI46KqPeuh+4VvwQxfOHQ5gvFHJ4hrNEUb+cO/B2urm6iJOTecHb9yrS6/+ndVDQU5DgKeboOFKmIMEIw4q7sVkFDShPRQP2/WLEW80/PF3rN1ICRNnObIUlKDVw+8DVMuBYuRUNlNTTfsAkZ1PlpIVnfaE8d1Kuv4dMzEBdgK1t8O58S10PSmsu6djLhPoe+TImVQD/jbZNxcTcly2UCzih+rDGk71j+yTpDlpXCB9XhsmIHbVqvwOAwHHuluaXip3rWeobt4dXlB9aSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PfFvAY3XixwuBfPHnf/UJXz729X/5T3ln2EgIWxSKZQ=;
 b=JBrjQH9Yx2iHQ6KTVocPg0eGnM4vSCGnwzwz+yReezk4TBseQowZsJvKIHpE7KadZ/ENykiI8cZWoCHXNy/YQ/lcLvhlhAKJHn7AzDRR2zt69HUV0XQc7AcdulmQ/IktRBWF9Q732O4n9PJa9ph7aADLcFEXd/DZsN3ZcuJGh0YmkIxeR6WS7gzKw9d7dtlrou5z6jNANi3x2JjWW1lNyYX8S+rbV3rUm3jF9dLE+xxTtb+DRUKTWS0VIDtN9vDUG3a3+b08QAE7PteB33st8QSWxSxNrp2D0poScAm8yV0Vj0hJ0NEJJo7se1jIMtfMJWFQL/kRC2Pkl/pCsxQv4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB6065.namprd12.prod.outlook.com (2603:10b6:208:3ef::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Fri, 12 Jun
 2026 13:54:46 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 13:54:46 +0000
Date: Fri, 12 Jun 2026 10:54:45 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Kevin Tian <kevin.tian@intel.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Shuah Khan <shuah@kernel.org>,
	Pranjal Shrivastava <praan@google.com>, Kees Cook <kees@kernel.org>,
	Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 0/4] iommufd: Cache invalidation hardening and SMMUv3
 batching rework
Message-ID: <20260612135445.GJ1962447@nvidia.com>
References: <cover.1780521606.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1780521606.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0065.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB6065:EE_
X-MS-Office365-Filtering-Correlation-Id: 915b5e77-d604-4030-d4d6-08dec88a29b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|6133799003|11063799006|18002099003|56012099006|3023799007|22082099003;
X-Microsoft-Antispam-Message-Info:
	6wJ7YZurtSCY4vNnSeqKCMfItfE57hyVjNOlfqU+Z6f/huntg/F2PeRZvfRVnpy5SFqWwAQhuRmCr04884tIx+Xa+1nRRMzZ0MobX8a+OaCAnUialqpri4+DnC/dues/FPvI/Wp99CUSKzBTg2VzO0gEQ7AevnnIf6YPj6r+dDt8MMVs77Cu4SdsFusPd5OZz3kYudQF8psrYVMFRinQ/CO7hnp7ySi9fKOZ4rpWYtXH7muFaUdGmxRYeYWDzOaJrTEaJKFTbe5+Jln3OUmtnLUL6TUgzDw1f8hQBdLRXPqaSglZtTU1dw4D5Ql/2dTPu+l7WZEVuWs6+SX84oT2unBj1/sOonBdYNuu7vOFjM/WDC3XsBsfND86e+wanJ2yUd6DSrLok++LETde0hltXcma9Jx8AADk5ehkWTcjZP05+hbVPW+njgMdEAim3bh3z2pvLQCMooUjYd0AqDWWS51zrf71qeuLzGyCKooXPj0lbnN2yyVs+mOZzax1C204iBZvftvjgOaWC+E3ejqnCH7a88CJS9OBqZzdp8X0bosq8i7Q0zx+6mUXMVjrFpjIwVNVLDuZeKz9SOiYQgoZViW7qh6iSIwnBDK6lVsfzd4zavaC+q0Br2NgpHZbpGy52BX2Yow7rYZfuPK+UCOtA4EWaulrya8/xy1MAK8dWXiDozO5NRVMnvWQ6BLWMc7f
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(6133799003)(11063799006)(18002099003)(56012099006)(3023799007)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V7l73xK0Wzav5UaBY33AaZ8MvRScIVWW5cNx/m9XcT6JOMu8xjqgH8o9t77O?=
 =?us-ascii?Q?v3fJil6KAd2QE4xLCf+EyxDFvs8wyJMpirOeJnV0P7Cbl2eE4vVFPqnWbrNq?=
 =?us-ascii?Q?gDY6KG5kw6YE6Yd4CMP7UHj3/eVgfzCMVl4JlmI0yq6b73xHYGeJ4It7mcdQ?=
 =?us-ascii?Q?DL8RO+3/6rvGpnjhVqzuMdKt3mZlUhp6o+QXf66iy01Nkj0jo+530GsUzATb?=
 =?us-ascii?Q?wEklHGpLt0OrG+4OxbztvP5togY/DLlWNDzutU9pKuCptejmAZunc2zLCXP+?=
 =?us-ascii?Q?Xz6u4X/U4Xg/Npk4EzddI3zXkcZzxBRfiCTC43QIPTOd/mK9F23yYfvsUEV9?=
 =?us-ascii?Q?7KThBxGFI2XvOcsRaYFRUYq+o4ah+1V9dgvYdsjW17LeeOOp5z+z3MuAwqBE?=
 =?us-ascii?Q?GYkMQUTCQSZNx7OM7MPzEPcPz/qtdcftPm2u2l5m77Vg1M1WV3LF1SESUonA?=
 =?us-ascii?Q?4C/Zl9saLp4EP2AKXKwDOInYZX/0svFcPiyuINgHM5rMGY7as6qK5/EnAQNQ?=
 =?us-ascii?Q?cHoZiBlHJ+pcicKBGi99K3hHnw9qhjvru0wyO+6PqBFFgDE7V6Idjo4cSsAV?=
 =?us-ascii?Q?ia7ZQ5RyvwZ/cO+xDWv0ViVD1QuISFQ1aQz32G6byUbkosdhv0klfTTvv+0w?=
 =?us-ascii?Q?Dazv7K5cJaTSdnlmVOlZmuy6FT1hJccBgdoh2R8/kKw/ARmB+9BpbM8CS9dx?=
 =?us-ascii?Q?nFC2WW0Zp/pVk5elBGF3arQ56ya4ki2ygv57fJ3qjfDjgs18x0UsAImu6Ll2?=
 =?us-ascii?Q?D35DsygDfr57dmLFKrZocZTPqHFW9jFVmRabUUgL66DXcB7INjTYvPn8nyFP?=
 =?us-ascii?Q?UVJ995g16dhAkPRJ720hbo5kVB4V2UOyr4XRPMOkYt5Ci8PyhFsAypIMRXvA?=
 =?us-ascii?Q?XAE3/nOP9EgjTehMUU7S9wTPQVWvNiM21cqHjJLhrcRZLyDfu8hBjsduyK1G?=
 =?us-ascii?Q?JLjT1efHhyaLaWIkhJzSWWsE7xqpGftrHhexB8Zlxrs2bh9qGIBaXTpFz0J+?=
 =?us-ascii?Q?mDCmnW/7G/vb2AL7nYfMJJjGtxWn3lB5/nm3l+BSgLofoFTzlfGqsW261uxo?=
 =?us-ascii?Q?+6FoKRjxZaVuw57uaJiWlx2MZqEgmpiyFG6u1n1wgfLVH2QeVFZLViGOEcq8?=
 =?us-ascii?Q?kdOXlg5rDKoA8YE7X26xGiQ3oaX5htVfztNZMsy96EwxS7vOuPGWAb7wqHOJ?=
 =?us-ascii?Q?aANfpFLciF/v3bvWtcUXaYrEmElC/UUqEIHByL9Hj9/foY55u8AGpp9r9YBQ?=
 =?us-ascii?Q?XzPGdi9TZqJATuDjSpGqVxpTW04tN1O/xQMwyjnuh7Vq4buJv9cRejuOXgky?=
 =?us-ascii?Q?NGNLGd1DMqgIskow/C1dxWKhQDwW7OmlPcPgk4QpdoHLUEg5o/d1/zfTm+sa?=
 =?us-ascii?Q?jhDaDQ/94LS91f1Qt/fy6LyJqqnaLCg+ziYsdmnrHeJRm1sWX8MFha3rI5Ta?=
 =?us-ascii?Q?DVtmEhL1FbufaEutIIvPIZ5tH3MPLjG0e1XEpemydmIu5zX4DjSQZTYWKdCz?=
 =?us-ascii?Q?efFqQEtOwhxDQ3w3Sa96Y+FugHk+Qn33g06jCrsxjhcNuceAd1pZhkgZvRtW?=
 =?us-ascii?Q?SbdjMsEWd2HTO5LHidNrR5N5G0eha2FQD59r3LTG1teascAu6bF7c/i2XKdt?=
 =?us-ascii?Q?lvVlM2NBnoab5E26+v8CosgHAY8/4+dmzSeBPZh3Yp8a/ptPhBa4EnLNv4C3?=
 =?us-ascii?Q?pKAUs3+d7MfSTAVsUSyq3AorcUCgMhchncNGrXFz9YPGna9J?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 915b5e77-d604-4030-d4d6-08dec88a29b1
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 13:54:46.5147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KfqB2NuTP4/b3RMMzvhpW3xZb/n1vCCypRgnAdw+qK+fxZg5xPv1lygYL+Ey7sNT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6065

On Wed, Jun 03, 2026 at 02:26:52PM -0700, Nicolin Chen wrote:
> Sashiko pointed out several issues in the iommufd invalidation path, which
> also prompted a rework of the ARM SMMUv3 vIOMMU invalidation handler:
> 
>  - entry_len is user-controlled and unbounded, so the trailing-zero check
>    for its forward-compat fields can scan gigabytes of user memory without
>    yielding, long enough to trip the soft-lockup watchdog.
> 
>  - A large entry_num drives a backend's per-entry invalidation loop with no
>    reschedule, e.g. the VT-d nested path, pinning the CPU.
> 
>  - The full-array copy helper copies the array twice on the equal-size fast
>    path: once in bulk, then again entry by entry.
> 
>  - arm_vsmmu_cache_invalidate() reports converted-but-unsubmitted commands
>    as handled on its error paths.
> 
>  - It sizes a single kernel allocation from the user-controlled entry_num.
> 
>  - It rejects an empty-array data_type probe that the uAPI allows.
> 
> Fix them properly.
> 
> This is on Github:
> https://github.com/nicolinc/iommufd/commits/smmuv3_fix_iommufd-v1
> 
> Nicolin Chen (4):
>   iommufd: Set upper bounds on cache invalidation entry_num and
>     entry_len
>   iommufd/selftest: Add invalidation entry_num and entry_len boundary
>     tests
>   iommu: Avoid copying the user array twice in the full-array copy
>     helper

I picked up these ones, lets resend this next cycle for Will:

>   iommu/arm-smmu-v3: Process vIOMMU invalidations in batches

Thanks,
Jason
