Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010039.outbound.protection.outlook.com [52.101.85.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506F0346A02
	for <iommu@lists.linux.dev>; Fri,  7 Aug 2026 22:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786142709; cv=fail; b=bLnoyhop/MwypseZ2FIby89Hg7KHUtOd62oAeSu3aXLHEjLe1Oa/OH3yZvUlA1HFJsnH04tRhxE9gi2XNHa5cXfOm+D9+MmBMShsuMEFgtiko9MUz7L4CpdgGQDb2Qi7eDIMPXRAPQbiHhuBWNt/y2pclfqFWMY9U/3TtC4Fplw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786142709; c=relaxed/simple;
	bh=ovjPz4m350vGzRgJASkVtJpL4BEd5lwygvmXoi8ynl8=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=FD1XuN0yEhGXWQIdZTXqH67s2vdQgQdb8mu2nnuTcwh3c1rZ7WzFSOGUPbEYQsEIU517c4dN6KHznJk2WJK+2tGMkeKKDfGDkr6Vx27MsFDe/AdFka4bTzc+CpEbL23hCHq4nxGiBskMbKPHCwibeqWpJAwZdK7WSufcaAF9gvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bovPQKn2; arc=fail smtp.client-ip=52.101.85.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bovPQKn2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aSLH7qroj9UVRu1xQoiiIZ6E3XMosx8t8QGCRnOqIYmvBuVDHZgBEDKDNy77nkU8tN7Hjwe5jzElAD6I2S2ljcJFOCHjRBtsEZoPC+A1WTBWs1QkUilN7JDIYk11VXLDHqxy7OCJxC2bimOsTQgkcFVOOX5LxW54icc2x9+hPuz6R1iBY1MLAPK3EEZb0wi4j/AD4Q+iIda7zzF8B92ka0NkD8jn8hqXrH+hnvDZ+88Cn3SrFDqAnJYyz7GmgWE8YFCnWhyKHgdjlMp+AJui8UuIJggAtX/H6OFiqPpszxW6vCHaQdk8OQ4+g+a33LbQ7qKLIjNkPAcUcHZGumDSIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nn8szB6TM+Ngj096NENzdDpZ1pKae2vC3mIdMxBpaUo=;
 b=gVzqaA0cJrHvSXuAOStTzL6bh1v26jQ/VCX26owB1frLUQZoRnI4xdat8WquORVxfR7F6PzN4LKybJT9Qpq4OGwNMRMVzzgGjMRkzuylqNIimEw3TWOmM42xIOHglsyTFQYIiL5p7TQDcT6bsbdreEnk+vs+1OIrdkqgVUjvv0qmSAph4gCV9Jkj59c2ss5OdRghZlUF+iXczvDl0btl7d6l/93zcCkG06CmZqcubcx7/BiRf/RblBQSRh+fhtrLy1c1qFGKVZDaHmscj63l/hwdFNrFUJLRdCrwwmqRzJxpQGj2qLVG212x4fylN0uRRmBYgNLR0lmR+OLHi2umIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nn8szB6TM+Ngj096NENzdDpZ1pKae2vC3mIdMxBpaUo=;
 b=bovPQKn2B7IErh3BpQgKbL3Z8Zd01hZuN9yq57ZWqO2UDxjff18oVKBOA3UHSNip7U9qfEGPl4bdcedU0vvq0tzssz3zzSypANd3L1m5TyJybg/LqpibUqfvY481+hjtUufvo5ZPkf/O8bCKfVGX3Slgi2w1py07W4e1IBXoDosCkkO4IV3u6GPllqy9mvb/DA0EV/VBDbSnga4UikXRNBuNYWCoihBk6Hyr6M9jgHmJuWvhOP1pm1mWB/ZbxN0JNmWeAz+iV1SNAocDTsaTIs3PrXLyWbgrZY/iIRtzi15pgmo1AwcjsYPtPEm9mPOMysDSzvg1kErEuSQr646mnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS2PR12MB9613.namprd12.prod.outlook.com (2603:10b6:8:276::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 22:45:03 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0292.022; Fri, 7 Aug 2026
 22:45:03 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 0/4] iommu: Fix SVA, iommufd, and iommupt error paths
From: Jason Gunthorpe <jgg@nvidia.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
 kevin.tian@intel.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 oliver.yang@linux.alibaba.com, zhuo.song@linux.alibaba.com, 
 xueshuai@linux.alibaba.com
In-Reply-To: <cover.1785050951.git.xueshuai@linux.alibaba.com>
References: <cover.1785050951.git.xueshuai@linux.alibaba.com>
Date: Fri, 07 Aug 2026 19:45:00 -0300
Message-Id: <178614270050.282103.13460544946125510796.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: YT4PR01CA0027.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::6) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS2PR12MB9613:EE_
X-MS-Office365-Filtering-Correlation-Id: 430ba80e-231e-449c-e820-08def4d584ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|56012099006|22082099003|18002099003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	fBbp+JcP/jjnnjkId8M/BsnPzNYQRQNRlGiK2RSajeYqFyAzs8JGRWzB0/I8GY+rk1qKJXtj3gMVOmKHy2cISQcSr2Utuu5qoM/YDAkxcruqvdMrVWWU87KKzC2PGJA15C+NFbs+h8Dr38jtCpf3Filv/pue4hzE+L4fRPNLO6VnRrP8+KSmgIe4AMNTIT+UVb9+JeTZDw8EGUdEhq07ZXXGj6+1d+G4VVsRTgr5mXSxGzvB2IOLeBtm39IEc+2odHukMGXUj/6uOuU+Rl4keuYLQb1EQ79jvsQKM+9Mph71cXbcb7kzkAY4OSLFuFPioW61d+4sIDjQu9s2MXAwsbaJGWA8Q2POmbzz2BAvk006b7ryYtg6QglfAjp9Ea/BiPOS5p/YYv9nOY32JN3nmMW3bWZ8Pl6DCC2zV4GjMQULvaQ9vEVI5FEJ3a7+/3kBoJ9Qv5127Zs8hnBqe+nv2f4zRQjZnvjT21USsVXgdGOcbxTmgDSND6GCS/mJK4MCH3w3UnQzfr3DgGdkpFzKGmJ5M2BliLaXuwtO1iy/efXwaAfwJ63zD8X6k7lsNuAwzSn3MtS4K7iHdsvhKfIfblA0PuSR22aMFO/Tw0c4XW5N2VwDn/s5qeqJnLuv+WCQhykChjdTy7OuPaT6l+pzQjl09nbsD683lwd3Ofpqheo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(56012099006)(22082099003)(18002099003)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGl6a1hVdFQyZVh4QzVNdkxkOW42MVlxK2VYRU9rdnM2NUxWaCt3UU02dmVn?=
 =?utf-8?B?cHlSL1ptc2ZRWjd3dDZUMHRvOVI5cXRRdWxoYW9Qam9hL3B2ZVNhTThlQVM5?=
 =?utf-8?B?cVVoS3hvN2FZOE1NRktRVkxNVkxrWGRCNGRET1U5dUsyZkRKemp6YUs0MEt0?=
 =?utf-8?B?NHFGOC80N0o0SHlJSGozaW1CTzEzUXFpUDB5MVkyZVpGeTQ4RFhYbldFZXNx?=
 =?utf-8?B?UnpsV2NKU1NVbkIvM21Gd25Xa0cyWWJOV0gxM0tzQWllcytjOUV2aHVxQ1ZV?=
 =?utf-8?B?YXRnalZoTW10aTQ3ekJUQVJLeVJVMldKRlRwWHBzODZnQWJBSk9TcDl4a2E0?=
 =?utf-8?B?SW4xMHBuSzYxdTdPSUZieXZ1YnNuNjVpbU0zbXF6RUJ0TjZvUWpSdVVmN0lj?=
 =?utf-8?B?R0FFQ3ljeWNHdnpUalhrZWthVTVsZW0ySDNxcWdFaHZVVmJMTDNsN2VUVE9s?=
 =?utf-8?B?L1o3amtVeUtWMWZDeUs1bFhaNDFsbE8zeHFsTXpaRG55bDZOVk9rb0hKZXBW?=
 =?utf-8?B?bTYzOUJsYmpOSTRQYjQ2TnJUSmJjSTh0SWRadjE5RUp1OENWVWNPWEpQWlAy?=
 =?utf-8?B?L1JXRW43ZXY4eC9aaStCeXk1SmFLelRqWTFRSW1xQlZGQnhvZldBM3dPcDBm?=
 =?utf-8?B?OUYwYlhCZVVVWmNlUThkUzl2cFR6M1cwb0w0Q0FRVW9rZUNNc3BTeFZRWTYz?=
 =?utf-8?B?THZWOHpTRHZ0TU5RVm95dzRwWGtYQVEvYzBQMXBLUHluNnlRa1dicUgrWVhn?=
 =?utf-8?B?ditENjRTRmVPaXkvZjJqL2hYZk9PUjZTWWVOQURobG9Ua0RDMFFnTU1QU1Y3?=
 =?utf-8?B?ZWZJZHFrb3pRVEJuU0ZyN3BKNFNZQ2hGenlXMmMzTGhKUEdMdDFnem9Yb3RM?=
 =?utf-8?B?QVBER0JUUUd3bkNja0czUjFtcjMwRmFvRFdCNVdadmVORzg2K1ExckpzeURD?=
 =?utf-8?B?cXZMcUxXdDJYUU1PdUFmVTRDUWFNb0hnTWhzcENPd2E4R3hRT0tuL2VBbjI5?=
 =?utf-8?B?dmdpcU9VN09NOExXM3BKeDR6ZWIrcTl1a1c5Y3MxL0hxOEljUko1TGliR1li?=
 =?utf-8?B?YUxWYnVkalJEU3VyZEU5MDhrNHZhRGR6TTdIaW9rTThvSlhkS3lYVzc4aHhD?=
 =?utf-8?B?VE1IZmZsdm9oQUlLcFc1K2U0d3NEeWVKQmhWQkxxK1IvK0RwcmRmRld3K3M1?=
 =?utf-8?B?OTVSS3dNYzlpWjRqbXdmdGNVd1BKNEt4cTRlYWNQcVozT1hBK2ZUeE0yU0tL?=
 =?utf-8?B?VkpuczJXTDhpTkhSS0Q3TWJPbHBCUUFqVFk2T3E5a2JUMW1kZEZNZHNaVHVa?=
 =?utf-8?B?V1ovSkxqSEZnSjRuSm5XbDJqQ2RNbVpuRmN0QWNhTjF2emdFZk5oRHR0RHhD?=
 =?utf-8?B?ZlZjcUJGeEIxRC9QaytBTmpLWkRmZ29sTXF3UDBibFcyYWtjbU1GMXhodkVq?=
 =?utf-8?B?bjVGbjRpR3J2UlUwS3dvNnhka2ZvbGpvUUp1eElwL3IyR1ZJZzZBSzBUL1d2?=
 =?utf-8?B?eVFtYnJRdXdTR1pIb2ZvT2xuYlEzVU16MjBiQU5qNHNWWmVaWkE1SXFKYVZy?=
 =?utf-8?B?MkZOZTJwOEEwM1VxRFpHSlhkWHNxSngySk9BMFVVWVV2T0R6aE5Zd3V4dGsr?=
 =?utf-8?B?ZC8rbUp3N3E0VVpoTFFzaHM5VVJWVEMyOVJnSTBmakIybVhjWm9xOERqMSsz?=
 =?utf-8?B?K0xvZG9SZXFTUElhVDJ0b3VEK2EyRG14VUkwY1pKL2w4S2Jmbm5RVHgyZEx2?=
 =?utf-8?B?OWxMMDFtU0U3dWxTMm9GQ1Byd2xad3lGbm4zMk1DUHJJcU1zUGpIUWMzQXd1?=
 =?utf-8?B?U2h4Mld6L2lXU0JqT2REN3VRbGFJZUJRc0hsNGRTZUtiT2JFM0haMjU2M1Ar?=
 =?utf-8?B?NjRzY0dJNW5QSEpsanVXbks0MnI3VjBpOEMvZUVNS0w3STFJeERhVlhQMTJ1?=
 =?utf-8?B?UUNBWXpSVlZKcE52cWkvelRDU25pQUxYcllpS3BPV1FBZnkvOWo0eFpXeXRD?=
 =?utf-8?B?UlVQMEpaNGJySHR0OWJTQ0lsd3FjbVVsWGJjSnBLaWZkTWU0WXZiRFM2dm5w?=
 =?utf-8?B?Q0J3ZU1YaFJPRmgxQTFGemliVTVTS2lzQXFLSUhsLy9vTHJSTlhkUHBSb3U2?=
 =?utf-8?B?cTlVWnU0Z09jdFkxLytxMXFmOEpRRCtwMTVVckJhd2x5Vm9xUEFzZUZwZ0U0?=
 =?utf-8?B?elpmSGNQbnZpMml6bW5XV0ljbkd4ZGF6QlJtbDlBTzJiYlpmdnZXQWN5a1E1?=
 =?utf-8?B?U1FDOVBZNTFCS2N6SFR4aWFnb0VnOFhPUUtYMkkzRWRHcUQySm45eTJzNWVB?=
 =?utf-8?Q?sIqYpzh6rZqViTNdvt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 430ba80e-231e-449c-e820-08def4d584ea
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 22:45:03.1060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: deGXPYclf/pulGaYNFvtrdcv/Kmsy/3slr9WL3TTMJOuDIo2/UHwSh44P2sR1UjS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9613

> All patches are small fixes with Fixes tags and Cc: stable.
> 
> Shuai Xue (4):
>   iommu/sva: Set handle->dev before the SVA handle is visible
>   iommufd: Avoid locking internal accesses during unmap
>   iommufd: Release current IOAS on xa_store() failure
>   iommupt: Return zero for invalid iova_to_phys() ranges

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>    

Joerg, can you pick this up please?

Thanks,

-- 
Jason
