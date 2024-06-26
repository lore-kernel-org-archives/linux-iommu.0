Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900DF181BBF
	for <iommu@lists.linux.dev>; Wed, 26 Jun 2024 13:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719409307; cv=fail; b=pAWQE+kZyPfFqjwv/GF/4a7v79sXyJQjIikF29Mm6FAB0CjXW0spim+JkcMqURNLMPnQOZHIJ2uDQXpAsKW2l+hPa0neMM29hHM2nkIPArZFAsASB50EQhINX/PG5NBFbRPTrdneTOmH6zv9wynVwCOBsjznPPFLEYf9QwkYIPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719409307; c=relaxed/simple;
	bh=8hjDy4m+AR/yyhB/bnUWlf9+EelU/QbA72sPwJRuadA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DmP3yTdhg17FDl5IUU0icL7UsbnznT3U8y9D36pS7YFubEi4BGnHlDpDgSQK+bk3ufLfVALAaibAHC7lhR6zjXl5WtBOsBIEcfwXC1DzYJysoArlx4ygIe9lQ/sZsWLKxGW8g7g1amQXDl9ESQRrMELDkwa7k+30iIpj4VbgTaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n11Q/S/l; arc=fail smtp.client-ip=40.107.93.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n11Q/S/l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzeXpDTIQy2wPzQOK/8XGfIwSz+eT7kNblWS+/16gUD8eey/BvNMAbzUjHwGDraLdNH181pqSXReqsj044EX9cuWmHViUpy/K/OZClWxlp9jo4kGjDe1Rsoqtr3VidS4ZI0uLJ4ZovnHVVUzkUE8bR1HODTU1EdNGH/6XAPPzLuDyvI3WZybnCESfbmCYqXz/4GZzAFfjMefvYfQ9NaKHlVXOKkslBPnn78YntngS4u0YFogeFzA2EXMqsQkCpQmY53ru4dKBbWxQDw3qD+ICefsMMsjDNShukw77pUKKAw1Pva69F940gl0IBi9Rk4jIEQrWaYWxZ6QYML2zg1OHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMsxApVYjEF8oF7HW++dd7IrN/fQmcpOdX0Cgd1LaZI=;
 b=BmEtK9HTw5mO6jdUJteNO9++kLYkeiIeVO3GkeqmCcNLB15uAFJjeA7eOM6ycAl94MnHCwPKduwv7oURhaWGBeXbjA3tDq+41OD537hWPmyV7wumJ4iLfMMbfr2RGPEDqUrdqn00FOfhgvAYHFzvA6y0cxwoPS1a0l9P01s6j+IUqGrUnOo+pX5olfu8Yp5RqqVJTugNUlcVeH4nO43G8c8KpThlvNkx3Gc+qpXdQA2tnS725dN5Kjqyks/wlfsg0mkTgd/aLY59uWjuSom2ucgt1Ezee8Fju078L0lTNtsrv60VRmaTfOlmKR3JD2FoBqqyk3aMaRRPtLzWB+hrxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMsxApVYjEF8oF7HW++dd7IrN/fQmcpOdX0Cgd1LaZI=;
 b=n11Q/S/lgj5xF4XxXuoc8pwTG4sIVMhWy7vZU7jT7BKA8FwnV2ebEQhEQqiMKy6o9xrVI2B/9cRL8W0+pE56AiMeXtcywX5ZVYvc/Zdt/l2zQFTU7Ea3cROCLuuZ99byM8enkkih6uEQCg6fZmWZxedA2TfI/hsBeclyXlnh+l540c1+Tz2oLsV/Hzuoqc7qk2pMhA/lPcsuAG+9WGTW2aDEpD26QplZS7XW/+kEjYK10o7uBsKACUZdlAhj0ll/txPoSfZn+XVnb0upVbkiKMdg6gKGfvX9Rj/Sw16BGK2uQZbOCY2DAxQGPqLb3AImPxT39ltZ2geAVcFKoEvRJQ==
Received: from LV3PR12MB9095.namprd12.prod.outlook.com (2603:10b6:408:1a6::22)
 by LV2PR12MB6015.namprd12.prod.outlook.com (2603:10b6:408:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 13:41:40 +0000
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by LV3PR12MB9095.namprd12.prod.outlook.com (2603:10b6:408:1a6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 13:41:39 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%6]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 13:41:38 +0000
Date: Wed, 26 Jun 2024 10:41:37 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Avihai Horon <avihaih@nvidia.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v1 00/10] iommufd/{iova_bitmap,selftest}: Fix dirty
 hugepages tracking and selftests
Message-ID: <20240626134137.GF2494510@nvidia.com>
References: <20240621184254.45477-1-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621184254.45477-1-joao.m.martins@oracle.com>
X-ClientProxiedBy: BL1PR13CA0231.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::26) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	DM6PR12MB3849:EE_|LV3PR12MB9095:EE_|LV2PR12MB6015:EE_
X-MS-Office365-Filtering-Correlation-Id: 98040660-6220-4380-1c47-08dc95e5b447
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|1800799022|376012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f9h51iQ5CtuI6rJxAc0XIoM1seElXMFRZQcLlUm2qYKpO6jDlVu9w59V3u7L?=
 =?us-ascii?Q?1kRfurgUKUjap1aoOmId7FAgn0lbzx8KhPnC01omutxH4/NXI2IPQQjVySFE?=
 =?us-ascii?Q?JF4k7KuOAfZrzv2VNttM3trmdKB01zRug5ks7OYirqSRQhnxX8RpCLllgjsH?=
 =?us-ascii?Q?AI+7yZXMgq6sSmMaKuDLbAcGQXUdaEd8lBpPMK2fEUVHWYnpMGZJvHjuSGw/?=
 =?us-ascii?Q?QWCo4TRRbE0IDnHWAQ/EI2NMY5mqWvmC6F5cilywWWYqiScgqICoVQ19QoAa?=
 =?us-ascii?Q?jS64pDtbSh20ZGb/yzK1dxb0Z/bf4xw57e8eB1iipNyZk1x6I7f8f5tAOMbS?=
 =?us-ascii?Q?UDkdgViAWF7pRx6+c4Qtun80ZInrWqfC7hgEqDEYlUHjHaWZOi8mvG3F8p3C?=
 =?us-ascii?Q?JWZPttnTiUEIVN76iHrkomYpFqejbVbfXGHZ6OedRRtEW8zWDVJ2G0kErokq?=
 =?us-ascii?Q?Duytru0JaYISDn2Qs5C7qT4JpWvMA+cE8DsMUm6hkzwF6UaZTAGoB0SHuMK4?=
 =?us-ascii?Q?QCkjenYEa+RDH1Z1E/yJWdMwoHIH0y3YDh/2A4kM8Q64hKj03MkKH998qBEE?=
 =?us-ascii?Q?GA1KUHW0uvoVy3L9NV2/3U+GIiy3cPHLdw9Azoz/HYfmkLPMY1k7+TeKQzDU?=
 =?us-ascii?Q?V4lrrCXRsVzRsLgazTpelZl/SQR3IrLxFxDIP0dFUdCIkMi52M33S7Yu0hqI?=
 =?us-ascii?Q?8BUhIKGuKEwTjNo95sDi7wgFlKyEwHpBhnipE3Ik+y8TF5IpPkcJrMxbvRFX?=
 =?us-ascii?Q?woy59Rt7QTHGMj76tMgz4mdPFxgsn870yAd+YUUGQWEmbraIYjNv8kTCj4C2?=
 =?us-ascii?Q?I3C5U6usrVUmXmEh65tenuCzKvukHg08XmELgPmTfmbK1Vay1h+BjRqiGPCo?=
 =?us-ascii?Q?DiACBUKHCWDzhKM0yQRKcVVXPWr5htQQ1eaQZ673rkV0Mo0xRMce4yvwrQxQ?=
 =?us-ascii?Q?VoYyQ2+7JafyoGGceZ7Xu+PsZiNxPEuqm5iEzHFckG7XruWDr/dZwiXozF5h?=
 =?us-ascii?Q?e/HmkgZT26QMuEs+mqs8FjM6d2qx5W2ggW3W2qLlsbh0M7CIDr8HcnPV6X8w?=
 =?us-ascii?Q?J4wHFvhocHOXmurKARly1ZN96K631/nHmeY2//vjwiLPK4hBDN9Q7eDog9RT?=
 =?us-ascii?Q?873lLqPQq+9HDMN2GJvn3YOZgDGBNJOGXs2irFYhK2FjVo16B6bPoe+tmZEZ?=
 =?us-ascii?Q?YtrSDTedXzNEnhUld6OQdH0cr1bj/3/F0T/uRkTQQ/VZHKCUAharsxtZ6uRy?=
 =?us-ascii?Q?I8SREvAFgjFoEAu+BcbXxgyInFvdzWkbLzolrsKBUxac1ETBqsb9K/YcZscv?=
 =?us-ascii?Q?kTc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9095.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(1800799022)(376012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q55CLnHMpn3IgyZ2ERNGkeatU2Cv58LEuYH7qakdntHGz5yN4nPZxP+zQWxW?=
 =?us-ascii?Q?IRe365d3PrYfVoRIpdt5crVRwmfWVlOFuC4xTyprjtGVyikb4ve3XkE8vNHa?=
 =?us-ascii?Q?uW+EjtYZR3Mq8R1N/JrwYG3qYaxh9X9y27ExaSoW0t7vTE++ZlpdflLEGAop?=
 =?us-ascii?Q?z1mLcMP8vAOVuoC3gPg+1x57eovIjO3WGlWbv7gikMnT0M5xgInO6E7zxk7J?=
 =?us-ascii?Q?oat7LqS0816GgKB1kk1gDPilk0aHNjH5wL8oheFVAkBKC10L0H5lUrToE6iG?=
 =?us-ascii?Q?kOW7329QG63sa7ovEUnQR6oOC8gZY3wse7YaQbLy8Bj2IMJjQ5jAryYp4g3G?=
 =?us-ascii?Q?j5sPk7y58o+OhtMyjsnfEdTGPiA2ShSNarbUfjobHXDXZ20aQ7mb1onHs+Ll?=
 =?us-ascii?Q?5fl35q42UrawN/df8xLi6WjchxUZTVpO+ltAU51QfKPwcZtUzgk3CBk5Smml?=
 =?us-ascii?Q?DuNoh6i/gVDwRzEdoMbuOEEhlNZYRcJNyw6Z3SvnxIOoRvL6eYdlY09v5/ur?=
 =?us-ascii?Q?OQzGOMI9vMF0n6jG6Xw9r734s9JDaC+aPi8W7+A1VmgoYwO/K/vuG+wZfb1H?=
 =?us-ascii?Q?H7oqmCAhPolFjDL6XoHx7+naFmVqe6xjHiHkp4AMhDvnCn5W1kOmyUazQdl3?=
 =?us-ascii?Q?45e8sYNFkcOxXpjuEoUSH+NtQ3Y7Vyylwh9oXk7uw2TdZkEzWq2TrwoVlj6g?=
 =?us-ascii?Q?m23NWbv46INiPUSRSV1DMtK4mnHWVnHxAfW/7dolHpviRt9WEAFfNjozli/F?=
 =?us-ascii?Q?ilhoVF++1BUcv2mCZSYZ+IV+Wqwzbuwp5jLpNQNuPx3TdvGxpfVLF4d/iZ12?=
 =?us-ascii?Q?GD4taLpQkFiO3+9lcUURrYDrTsM/jGfbkRWrYlbgGUt0bqwQFdiMxxUAc+JN?=
 =?us-ascii?Q?SBkJnpz3bCmss26ZcRZmJvIsBNRt6hp6GnbHHmRXIA3YcASlWQymCCguWQDO?=
 =?us-ascii?Q?xGO3QZPcPfNadllyYjrB/EyWVgJk3oB6hxVHUn9CClLc95ZOfCCL60ojDMsw?=
 =?us-ascii?Q?LHXb9Z7wKo9A1jQPZgvrkrZsXDmhpIuX4HNj+719EzKWdejv0xGKrJskaeiH?=
 =?us-ascii?Q?oU4I6x3MurqYCnhZF/KLD5h4qRI9eHinK/ZwssxLcnRDfYwwqGJATmoW8xCb?=
 =?us-ascii?Q?ywDaYp2yvGp5CHMYriizLooLM+ynzvwiZgKRT8gOEV/NGEZwZ/d1xL+9Mtcf?=
 =?us-ascii?Q?3hbbfDU9ZG0BjzPJxLt3g9IGpGXd3i7n42iHUnqPQOW44JJIyzewTwYhfkL5?=
 =?us-ascii?Q?M+5p8pKX4pEs9jvJMm/DxkBaeDiA/auIWqht94x1k86mWO0hLZDraH8gZnrv?=
 =?us-ascii?Q?52EdM+dG2RtacR5OV+r+2P6HjYKDLvu4A5iGJ5I7p6At2rjsSkCjmThZ7g+D?=
 =?us-ascii?Q?A8AcGTXiKaarsv/wmcfJeT8XkH6j6WnE3on6C+r6OKHzl5QCUxsArk3Nc1PJ?=
 =?us-ascii?Q?w+fPAdRgWOFMM0iovCiSVgkKQb7NST+qxyfyQSsOVdSJl2T9WuxLnx2daZuu?=
 =?us-ascii?Q?h4IoNQdv2XOHdkSPrLNPk1xqtmlENlABqgI/8/Eg2jrLYrzIED6lXYqkK9Iv?=
 =?us-ascii?Q?dGRXa9EMNiSlwpmlzE6OdJ47dv9fgkemrGRJqbPr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98040660-6220-4380-1c47-08dc95e5b447
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 13:41:38.6434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jsKqURYFaeQnZ9Lt0pgnyUwQWSsWCuGgg0x1sVMAGGcmSqMiyfKPjg6WAINLd/NU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6015

On Fri, Jun 21, 2024 at 07:42:44PM +0100, Joao Martins wrote:
> Joao Martins (10):
>   iommufd/selftest: Fix dirty bitmap tests with u8 bitmaps
>   iommufd/selftest: Fix iommufd_test_dirty() to handle <u8 bitmaps
>   iommufd/selftest: Add tests for <= u8 bitmap sizes
>   iommufd/selftest: Do not record head iova to better match iommu drivers
>   iommufd/iova_bitmap: Check iova_bitmap_done() after set ahead
>   iommufd/iova_bitmap: Cache mapped length in iova_bitmap_map struct
>   iommufd/iova_bitmap: Move initial pinning to iova_bitmap_for_each()
>   iommufd/iova_bitmap: Consolidate iova_bitmap_set exit conditionals
>   iommufd/iova_bitmap: Dynamic pinning on iova_bitmap_set()
>   iommufd/iova_bitmap: Remove iterator logic

It seems OK, you'll send a v2 with the little updates?

Thanks,
Jason
