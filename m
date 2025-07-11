Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2072.outbound.protection.outlook.com [40.107.101.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C94522A
	for <iommu@lists.linux.dev>; Fri, 11 Jul 2025 17:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752255752; cv=fail; b=TaV9WskSgAR1OkOf2kF/UkWyFvijiD7083zkt+ldgyvvZUZeO+SkChcxVgAgnCEbE300wutbqTzWEAu4OKAARQRh7Kna/Gxdwk5rqH7KsGry25MiTcuUGrlXLMnzAUvA0NRm0lvelLc2UjdviXVlzzPzxLWTjrr3ggHWsyGHwAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752255752; c=relaxed/simple;
	bh=kmh4x0zoyXimdxBDFUXvwETlHDVILeI/xVT19dENMXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XuIVEt3tPoO8QURbVuGg+FovCw23nO1RvVALowZmmL/5cDg7IH8F05odFd26bCaGtpQ2vC0MGx3xuu3Ycr90HpVqWAlpoeBPKuaCNHH8aruWAqA6XwzF0ZUEZHNWl9+Q8vtnn3NyipGFLiPUV3X95LorkOsJOYtK87e/oWQ2txw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YgSXr9K3; arc=fail smtp.client-ip=40.107.101.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YgSXr9K3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Csn2hzcFNfKyX4uZhyYjuFfGwUxdS6l3g5t+F9BfmfepDivUmEvTSiY2RbCtT6nTU0sz03s+KcmZFwNj+x+CJM15+hW3r+cvvMRVKb0kWjXGKM/pEBjgLi9vQOaiktgwXLni9tOn58taOQTaTtAWS4fZL5+kkB32CQNlIpYjH0cvdqlaOVr31kHbtM6u89X7ek68yNcLEJiCgSJpS7sHShPD8gHp/xdkV0fwnCFde6/FLELYBEVebOwxa4XRr7hNyqBIy/t3ktSQGZYT2kYzUFYKEfrtNTSbB/RTahGIi1of/kx0IGEtLoOdhkmnS5HrJ7u1QrJMoPCtkSeGI7INYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7WHx0L2FwUXn2jJ5oWywC6PdEibPr1wiy1iPGdOQDtE=;
 b=XkPair0adkocWb2ZfV/Y6kYpFWtxF/SHdXLAlnAuOT2pflh09ZeSEClxgCL56otq1lebxDayJWfPjMcOeMlXKMNzPn+25CtLqMlHxth0mSNT7/vVDkpnzGi8syL8EJGZKu73C90CZn+sVRVZzxefLt/tduDGFQOarwT87mjhnn+JeYxPy0RAEWJ8zrR0UtA8SM31nhN5Nc+1zLB5cRgbkTuqLYaM34bmAYNlqr0EOPWrPUYLUJS1chn08RNr5BQVt8UhOxKAY5UReC9FKeF5UeIdVaWJrNhfLkIkMf0C31+k1UFLpUh6pqO0uG24Wmq4nwZdTlBi1LA2rnYpgaZUNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WHx0L2FwUXn2jJ5oWywC6PdEibPr1wiy1iPGdOQDtE=;
 b=YgSXr9K3QhDt48EbnfOjmSFbVr/8XQ8e9IXKbx93ZXn0gnrX7XdQBeWyBrZv0Auxu30aR4hblS4C/WnPhg5ywJ52lZkLtSqJXDqQ1NP2WzNEdnqbmOnP3b37KGGHquAVxVhHg87vfDzXK7RCQPU02zhbB28pu4b4kN0QrD26cLoJy2pPG92R4XUB9NuuNYnwe8O63DrBmAZ9NGrspIpBvX4Kk43WtTdBfR7jioinhRm9LU6C3t5gldwFGZz9iM3uibVOvAregb/MFZxMaat9F53o3xfmgfbT49nGL+TnnkCQBCIpYPzoGn/hkhxfW0nxTSI/MFi7tNBKhs0WF4o5+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ1PR12MB6123.namprd12.prod.outlook.com (2603:10b6:a03:45a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Fri, 11 Jul
 2025 17:42:27 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 17:42:27 +0000
Date: Fri, 11 Jul 2025 14:42:26 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: kevin.tian@intel.com, will@kernel.org, aneesh.kumar@kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	joro@8bytes.org, robin.murphy@arm.com, shuah@kernel.org,
	nicolinc@nvidia.com, aik@amd.com, dan.j.williams@intel.com,
	baolu.lu@linux.intel.com, yilun.xu@intel.com
Subject: Re: [PATCH v4 1/7] iommufd/viommu: Roll back to use
 iommufd_object_alloc() for vdevice
Message-ID: <20250711174226.GF1951027@nvidia.com>
References: <20250709040234.1773573-1-yilun.xu@linux.intel.com>
 <20250709040234.1773573-2-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709040234.1773573-2-yilun.xu@linux.intel.com>
X-ClientProxiedBy: BL1PR13CA0359.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::34) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ1PR12MB6123:EE_
X-MS-Office365-Filtering-Correlation-Id: eaa2b6f2-eb54-40ab-2439-08ddc0a24d63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?//3QcQvW7kUx1GHq5cB1T1/AkwP76Zj20duDEYtyNXf578l1uRXarSvehnoX?=
 =?us-ascii?Q?8b7RBqWb/ucZz/XcQZui7+68hd5sIZJmGi4NJrNOKkILWMkUq6rveoqmTiAI?=
 =?us-ascii?Q?JtVsBEpZ719j5yhzyT+PP/glbpnitWj2dUymze0k/6ATwTGNnLIeIb6eoRtJ?=
 =?us-ascii?Q?Bac4S8bJLScFb54EpSz/8FId0/YtpfgkyvmdbYHBUQMomfiYkk3l2KKnkdne?=
 =?us-ascii?Q?ha1ek6mHvbFZWxhbfXSHzfxXoRyUATHMXw0+ZkVvAt3x6ajWbfCGns/Y/75k?=
 =?us-ascii?Q?TT0na43uSyO3kCT1POrxh9HM9M9XL6gMEEQMmYb/rg49xBFjzHbEjeWL+FTR?=
 =?us-ascii?Q?9BwR/Fjz1UNSXQ8wFFirfMjdaINPem0L2NikH9m128QIr/NzNKCafhIbGCQ3?=
 =?us-ascii?Q?zZeqqdOpZoOQ/t2KmiuYy78x89qKkQqouziBrzfOwN1UY0P3GQDikFzhI2eQ?=
 =?us-ascii?Q?GOySmjiEo40k0QzJXXB4XgLOzqc7dSQi8qpHqfV6OCTywAwCRJwGh1tA501l?=
 =?us-ascii?Q?CYSTu8PSlcY2Ta6AS9KLXAFi3hoZq7S46gVF15qhZDB6b7DAU9Rlwte7nawc?=
 =?us-ascii?Q?zz1Hif8tVbxsNFX+2A1JdAlbXnOs0dmKvd83X9FBSL3Iz/zsDUs6Yns+mAqX?=
 =?us-ascii?Q?qoikoozkBOxwXmQ5GKBmkGDXuOAySu25Kjek8E80YND+5ftFGhZzG05pwWdr?=
 =?us-ascii?Q?0K2iGUHhfg+PoNt6DefyCQWkeHP45oBqy4iKK0FlTnwuzl9nw4ZSdjEwB1By?=
 =?us-ascii?Q?yXOTTfEacgOqdQBcXEPni3T5LYNh+IDKqUZnLNERVIXojaDHzBntTyiT/Qz7?=
 =?us-ascii?Q?5Ele6yd7LoU/JzfbB7PmE49V47W4ofUQcbwI0bwEr54iM4jKLZFNT0Q+hxCn?=
 =?us-ascii?Q?101s3utZALjLQQhSerAZ+LAU80Tj96QVzkPVaJAwHAi7jfsx8bi9KxAbAf7p?=
 =?us-ascii?Q?fyWMmXyhpjbOJaaIcRGC631lX+MhZ99WL0jGsiU/FKFfVp6xKlMs6UZwBCmS?=
 =?us-ascii?Q?WTAYYNyDMwDGPly4UThcr+iGcuif7ara+YoOHvqlr+faGYackpZozQongxZS?=
 =?us-ascii?Q?fOy6ZYu7aHmQKcdAE0H5PiErTvcJlfYgfQBzMunYsiFmz6EjNR+XSYnGMHkH?=
 =?us-ascii?Q?eGIcKH6WZssGrHAzd672T3N/JtCnifpLqQ0opisQSL3lL4HIx3+coSV4DtdE?=
 =?us-ascii?Q?fcDJM3gPKWtMiZRHBUvz4nutBSchc4p+OwLne7BlH3am6C5I2ZCW1fUUrfqx?=
 =?us-ascii?Q?E6MaB7sqHvL56pnDopBtqqHR/Z8hwmCt+vMBJREZPbgWXwKFb28Hq9Iq5NRW?=
 =?us-ascii?Q?GcQV0iJx/aoSkalFX/D5iR3UzlaiuechwUWJmBNWcNUuYAM7h6z3KRnEUMBr?=
 =?us-ascii?Q?WCrcfiVkJczRjM5hF5zwza0seguxCs8+hijnM7W1o3yTY59li0NVaKBmqOiZ?=
 =?us-ascii?Q?GqmBmnJu5fQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A8cyVV2Zd7Dh0SOycOIcGzLzUPooVqQ3/FvEfXXPT8+G8+bpHQMVTT1SWKSZ?=
 =?us-ascii?Q?xX/ekx3GYhZokwEhCz/tYnH9bZKbHcp+CjXg7e3lBcWtiUbwHVHbCxfoNCF8?=
 =?us-ascii?Q?wXpiIS5ZBVm2uv+R9P59UgHQlgu7tVCiOrNcepgwVazK5S45z0ncuSI2hk77?=
 =?us-ascii?Q?mpyLQvjGKYgdf7JekYy0hjwQFegE8hWA/UJI4ngojZqgXjRCRa18ObBk7hTZ?=
 =?us-ascii?Q?91totcdZDYqWQQ3MNP3aABGweJdyZGxj8SUbINcFgWyLusHAdHwgnTvOy8jL?=
 =?us-ascii?Q?sO63rqHdoJhJhGnLUnA/XY41lOJlz/5uBqzi6gEnkEHvchz5TV90qHZHi30a?=
 =?us-ascii?Q?8OMXltGijEJnyCbghF723Yo7hnKkbeEHgUtMyKCOvL/h9nIw2YxE+kZPiqCr?=
 =?us-ascii?Q?4xk4fIrL288+nDU9OSJ5sRraPlyJMtRW0KXs1c73xlpBqQfpjvB79396VTyk?=
 =?us-ascii?Q?lvGxDABYFFTG27IsGIgApJs2KN1CYpGPMaXMxezdltrdMIWcEK5JfpPUptf5?=
 =?us-ascii?Q?6KF819YpuOqqtHijEFyo6ehJLNK9LHmunVNbkm4pXLjp9seaPyrn+BETDc+J?=
 =?us-ascii?Q?pbrGoD1E+Ru70uFxqpe5vK5psi2sHx7vuAnaWH52hJdO3XgUfYS6QI5jJo7h?=
 =?us-ascii?Q?Phh6iQQDGwrF5s+dZSit36kTnadwYfs5Xs8lHyWC/jvtzPXWewYn8qo2Rhtg?=
 =?us-ascii?Q?NF+OvXuD5WoDYpDeuS96nZKBxjN77R6DAPnAelM6qFZ1IEhiJ/JS6M+W+VOk?=
 =?us-ascii?Q?gr+OxlmJ/rwca1a6nG2iIMs7EdY7Kcr0Vxy9xyvNiiWt0MuOP7dXyA95zauA?=
 =?us-ascii?Q?usBfL4uryBrs8g22hqTkq/VsIvPA+dtGns8vjQE47ZW9UMBvTXZVgBIExbw1?=
 =?us-ascii?Q?TUxK6VRw7spt+ER3f46+Z9+ImKyBo+u/mB3FL6YHQpo+ITyEoSUz6HdrvnEa?=
 =?us-ascii?Q?Wxx3cjaqYCJMYWT5mLGsq15zqae0UkItjNHOp74YMv9slOIouLOCnxn7oXaB?=
 =?us-ascii?Q?oh11yj74GcO4LPHQwOs7D7G4kv/cZkI1P8wysGPu90nYU9cZ+r8bxUhuFai8?=
 =?us-ascii?Q?CoAwdbxda+X9M10k1KCC1En8+FRbV0m8pjCgeKN02bjno29ksbfrap4UsI0C?=
 =?us-ascii?Q?fu2y4rsTfcTFIyyascNFR3IA+iJQIRVT3V1UshiwuPuZrIfU5uaAmKJuCh+R?=
 =?us-ascii?Q?gkuDGbFYe27rq/o036qEYMAIprRm+ecyxt5cWHMEhRfy2KRzcG9VBnfbO+MD?=
 =?us-ascii?Q?2fYVA955mcO7sOsPZ7WZRNX2p1gWZtlO5sntha3dTZTsAAw4KKttnlTG4v/h?=
 =?us-ascii?Q?LuTzQyaqMqTN2aVPq2bdtQHe//yl22pnFMINYig96yVt8OxJZLNfqg6KKVXh?=
 =?us-ascii?Q?x6AQBnMpEvQm5cAysuOX36DLWo+F4zQawSoYUEmCR7fGYcKX+Tr93wBOzLJ7?=
 =?us-ascii?Q?M1PGNMJUOO9r7rQ6f3JrRI+92XfQh4hBJPn2wywXwKLjjjZr+2cTY94dt5e7?=
 =?us-ascii?Q?gF/FujlmGjF+0YYysa3Ur0SqnKA2OWMSBoBYX+b4hs7J6cx/5wIVLFpVxhZv?=
 =?us-ascii?Q?iDRidBdlUyslze1R9BiWSS4/UOLNOft+3V3cmyXu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaa2b6f2-eb54-40ab-2439-08ddc0a24d63
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 17:42:27.4451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cT2WWMpR4DaCrPlwyitaszGG0PKzVTKtoNR010/fDWRoQw9hNzj99U1IFwA+AW8r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6123

On Wed, Jul 09, 2025 at 12:02:28PM +0800, Xu Yilun wrote:
> To solve the vdevice lifecycle issue, future patches make the vdevice
> allocation protected by lock. That will make
> iommufd_object_alloc_ucmd() not applicable for vdevice. Roll back to
> use iommufd_object_alloc() for preparation.
> 
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> ---
>  drivers/iommu/iommufd/viommu.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
