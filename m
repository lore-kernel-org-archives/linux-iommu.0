Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010031.outbound.protection.outlook.com [52.101.201.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3326B42900A
	for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 23:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787354157; cv=fail; b=c9PiF3dN3hCLqpvfRD2IZe+4jJUV+6o6h7fq0ZAEFJ52BOxXlr6hgEEig4IoGJWjBgtoT+4Qw26yqsEIgISbZAgvkpsodK3oJabObIJfHvW+6IghfjUvX85GjHI2vjv8FibRAovcgK/rJv7eZDlerTqjYBNwD+ytN9drNqHiMtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787354157; c=relaxed/simple;
	bh=BJXQl40FiGHlDM3qPw+sz63oRMAPRZbx5+oOfRo5dLQ=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=GIGzd7x1+uuUdQUGgDqbbyU8v2nPVlJrCiNWSPQc1YkGUzpoxLNoznfU4vYJKq7QaATA4mdSrbztmyBmu1M5VxLHIBDCJXJGX2fs3IoCUspytqFxSliual4REozGFTgqERQ60fyUG5tG46oymnWQl428q4633m6WWkwOtPYe5Gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uagC9c8n; arc=fail smtp.client-ip=52.101.201.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uagC9c8n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G0EcFxfG2YWhY6N5sheNWFvzYBph1VoiuinmQZhsrubg3mr0whJIyjtU/eXRbqUMpqTTlj/j8VQNBRXApZhg8eNKUcqsPY/45/xx8vWOoO1eq//6bTmocik4B83I1/6W4F13sZnCfhpnhT2DJLfuxotN0Q39YREeelfMb5bWNwH7VKmlpW4H3x65Ob3cz0MR8Uds6nrpCq+eWISuuWqMB/Mx9ThnjHhf4QpSvZ5zh19PypTuSoxLurQfSdWz3NJ5iyRmoqpyzSAMEsFUsfZvsQSwvAVF+cgQq+wIKP7EY/qVHUVhoJ2gtrIGMPkjqFTbaksUpZIJRkQQDidK3gvzzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUHyE3zMRsWUfjOxtmDvHBuaT7MG6QQCdcpEBcCP+2Y=;
 b=v01K18+KhhiW1C0UauhyoX4sBaM1C/KskwvhkaEuZbSYFJH359uQ/FTYCdp+DDuDJIz2nf4Xz16/Zdy+hialofQqT6B979jmTWueRIfhsxr2t7OW+xl79vngkPnGe7uzy2eAJ9+okGQlI9JVPwT0Mu6u7XKXadhEwRjiFGxC9Dor8mMCiD0UJ/N4o/QfLaZ0hhU98qDZZfgk6KGBwEag/oeQU9H7VQ/4Gj0f9n3WX89q9GgmVIrx5Ez6tqUL+nuy6lYmaV90ieCZEwDrysEIBmizvy8YEGGxg1BqCffOlaKbTLyP/QY91XivXMl35vpyAznsszaUgSplFM/CDSUA9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUHyE3zMRsWUfjOxtmDvHBuaT7MG6QQCdcpEBcCP+2Y=;
 b=uagC9c8nFHvhS5M5fUTESDEl2yuI8BsGmTLYXeWTZDnryZuxhhR5UDr1UzoFe5F/FzDi2M5jwdFXv2j+twzqMBoWk+oJA4J9OWSUhU8lIbCeMA4SlI/3dQ8Zvpj+BOBOIABBNMUM2qw2pza2xp8qMyHhj0ZPcjFRVrcHMr4l+H7Un+4j8DxsrEZJHU7ACPPa3YxPuD6bj8tUw/kc1pQWW+c1toKur08rKf4e1SAuiN/KB2jNqw6Q1NHzUS3b88nv9bn1wQvmkrwNofmn5Km7+H2mas6M5o1MhFGf83d+o8sd4rvMGvt6Nam1vwDvzdXC9beYdtxIBYL+YIYnM0H+Cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by BL3PR12MB6402.namprd12.prod.outlook.com (2603:10b6:208:3b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 23:15:34 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 23:15:34 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v9 01/12] iommu/arm-smmu-v3: Do not enable EVTQ/PRIQ
 interrupts in kdump kernel
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org, 
 praan@google.com, kevin.tian@intel.com, smostafa@google.com, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, jamien@nvidia.com
In-Reply-To: <35000f29472b5e12114073d614168c251551ff0a.1784663184.git.nicolinc@nvidia.com>
References: <cover.1784663183.git.nicolinc@nvidia.com>
 <35000f29472b5e12114073d614168c251551ff0a.1784663184.git.nicolinc@nvidia.com>
Date: Fri, 21 Aug 2026 20:15:25 -0300
Message-Id: <178735412597.18212.9285735691655908532.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: YT4P288CA0060.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::20) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BL3PR12MB6402:EE_
X-MS-Office365-Filtering-Correlation-Id: 789cd68c-94d2-46da-7541-08deffda1899
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|22082099003|18002099003|56012099006|10067099003|11063799006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	GAoed3aStD68WQPf4whUO3+BK2C6KW+DSbSvxO4OPhtRlpx+8sOXV/AM3bOyGup+pAnvtNLS6uE/0qTOPG0kLTRdMhYUAAtVSZI+CuqgGcTeAqeK73b9JnBrlJKr94u21eEABqUb0RuqzGty1bpNy03Qw+IJP+6c9YvqH7qBF8GZSD7C1pGsX62xx2Blhu5+8WEGyo0NLREDFA4N/UPZ49InyM5e8tCgoiEhFAZXN3C5zDblTqWT6mCgIAAniF7c0zNw3AafOR0h+mL1Fc++UNFDw6wE2btIKJg8OS2YgFfNNf3b40x4NmwBL36BUrtJzKXjVhM587vR1QiwZAxBrx43c8KxtIkMLMPm7hcf8YVSoNCHDCtbF/3STukNhSds5zUQKYo3p2GTPBiPe81EM5qGUZd/dbkKNFSrbruRqbEIG3RrAdMmenR6e+HZRvWZMHgjF4kMzbnp+d51U2xLcUD+kgOkidr4ndbAasi4QMjE7c0MBIEA8LH6eSpHELNiTVzUj/VFVljkyNtdbbk7TVWuZFJ0INWQ6n0XmqmvEdJIbu4iyPVtOfFjhxZ9orFIz7NvNqiSL7p0VpKaf1+hiHGrHxoRq9rWTqxUq1DeEHFpJN7LPyCH8r5B+HXb7cmyOWPx804KRCZivcxhGQuBCmmp/Ox+T/zMieWKTjzhnKw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHJDTUQwTmpYSGloaE1SN2I1NlRFQnBuNHcyZ2FpRmRTNlBnbGN4SHVCTElR?=
 =?utf-8?B?d2VGTTM0Uk9rZHdjZ0FzUDFKaERYZ0hkUWY1YW9uMWdITzZPbEEyOVdoVUY5?=
 =?utf-8?B?TWtJSmpUK2QyeGdCeXpvZzVXSFNzdmtCNVRpNDRQdzFWdmx0bEJyWXQ3Y1N4?=
 =?utf-8?B?OXZLNVZpR2ZjTnkwTFNnYTdnaWRMNUt6ZVEvVmZIY0RqUUV0eWloamVSVjdK?=
 =?utf-8?B?anJjcFNBbmpCTmY0WG5WR3ZjYnNKMHByNjJBTy9HcEw3ekt4cGY2QXRUc1Rv?=
 =?utf-8?B?WTlNT1RaSTZabFRPSy8wcTdMZmpyekl0eERoRlIwNnN2UHpHNWQzMUt4cmRU?=
 =?utf-8?B?djlrMnh3aEhqUzlxOFR6cUswTTVUam9wc2g2ci9tdGVNaUFpNEx6a1ZzVy9k?=
 =?utf-8?B?TmJySkhUVG5KVEgveHFMcG5QNWZuVnRHMDBSTUxxRVc2WFpHVXdLdHlTK2Q3?=
 =?utf-8?B?Y3FGS09zaUdMcWpxNXVtUVNvdnF4MmduTXV4WHlSc0pDRnZGT0JiWW9xNm83?=
 =?utf-8?B?QittWVA1SEdZa1IydmJzQlN0MEdFUWN1blZKbU5ZRlN0WThxYTBFVXB4dmVD?=
 =?utf-8?B?K2JOV21nVXhlLzk2VGtDTHkzaE9MOXZFSy92TXFObVMvSzhTdjFkNXplSWN6?=
 =?utf-8?B?NFdoZm5UWkhpRmEvVzNCekxVWlN3NEc1MFltRnhYakVuV2Q4SzBSa0J5bFAz?=
 =?utf-8?B?a201VWhKSWcyS2lyTGNTVmw0V1NiSUVsa0FUVzlxTktxUkJtVXUvalUvempi?=
 =?utf-8?B?QXYyS0tCZFhSdUJBZS91eEZicU5GdFVROTIzTStvbDllZ2ppNkJWVEFQR1Er?=
 =?utf-8?B?RlF5UHdvL1pmNitIODJQWVFsUDJvWWYycTVZelNzUmE2UmFtTVN2UTZaRWRq?=
 =?utf-8?B?SUIwUEdwY0ZhUStZWXROMWFyV05NR0xHT3pickJpKzkvcWQwU08vMm44bmhB?=
 =?utf-8?B?elBNK090YTJ1SDNnZHNocDZibWsxS2NmK3ZsSWtkRng5UGNWZHEydHNsMWlh?=
 =?utf-8?B?blMyS2FDWEUvbWtvUzV6RDBwWEMyLzVLK21MclZ5L1NoTG1ENnMzUytiSVZu?=
 =?utf-8?B?RmRIay9pd3BiS3h6YVQwYlBGOXZmWGNzdXgzUXhNejNMeVpUY0dEOUQxUEJ3?=
 =?utf-8?B?K3M5Um4ySTJ3dVZkQm1CSlgyYTdoK1lxUVpHMWxEeEhFMVUwMmNoOWFPdC9D?=
 =?utf-8?B?QkFXMnh2djBSY0xSUHo3WVMvTnBSYXpHbzRBelQ0WUJRRUJESkk0TUo5Rm5K?=
 =?utf-8?B?RGsxUkIrRVM2WGs2bXBjbWxKeVZyTGZzOU9mbFdiYTdJdjJTVjd1NTRWQTVn?=
 =?utf-8?B?Mk85ZEZxdlJGbGRBVXM4eUFKd05TUFlRQTlLWC9UOGR5SUhWZTQ2SHMxQWxw?=
 =?utf-8?B?cWtneklOU0owcU0wNFFOMmRqVHNhZDJmTVBoN1hxc1Rtc0xTd3crVUQ2MXl6?=
 =?utf-8?B?WjFIVllwWHltamQxK2NNbURoWXczbnNRYzk1VW5KK25sTmFuR0FLQzhvV2RD?=
 =?utf-8?B?WXN1TjdrWWtabUpWNktQR2R0Mmh0aG5SOEhzQ1hBUitDK3VRZmJnVUp0azBG?=
 =?utf-8?B?NTVjN3JwdTNlb0tSOGJreUVzT2x4WW1CVWZFMlN4OVN4SGUxcjYyN0dsS00v?=
 =?utf-8?B?NVpSQUtqSC9aWWtRaWNlaWhHcUt1d2pNMXBqYVBPZ3dRQlZPSmNyNTJIcXp3?=
 =?utf-8?B?d2Z5ajFXd0xzdE9veUo3TFpldjFUOEgxMzVFT3RvVXB2cE9BVFpBTG9Mb3Fw?=
 =?utf-8?B?b1dhaVQ1bkgwNG1ndmNVZFN0eW0rNVpVOXZ5RXYyOWZmaUQ0cklMSkhKZkp2?=
 =?utf-8?B?S0d0NGt3aHYzRmovSUZWVEVmMmI4QzlJQlRFRG5LZUJkQ1c2dWl3aVlQVWw3?=
 =?utf-8?B?SElkS1VEa2ZQdmIrZ2N5NVdQSEZYUjZ0cjhhc1pDYlpyK0x1ODRBR0FwenY0?=
 =?utf-8?B?ZHJZNXlOUzQ1WHBqcnRHT0pwR2hGMkxJU2dKSDR6WTd0RDQ1K3E5S244ZXVD?=
 =?utf-8?B?bnAzUERCNlM4ZTQzQ095aE5uL0Y1YUUvU3hhTlBOaGJCd3ZBNE5JY2pQWHZk?=
 =?utf-8?B?OG9uaFh6cHJGMVJsSHRSR3RNdDUycnZlTXpTRXZxSjlFQjJpNXplLzJyVVNt?=
 =?utf-8?B?NFZXWGhkZHNpaUsvdDdZRW9HWm9TdWluT0VZVjVTbE5lOVkzNnNKZUxkWXdM?=
 =?utf-8?B?dHlxNWlOT2JKdEI5ZnFaWHFuSzJiT3NVYjJsNkhsVHAwemJDYzFsRXBqMzB4?=
 =?utf-8?B?NTBZMzZ1c0Y0NjdYTFZYZFc2NVdSS1FaK0dWRkl5Z2RtRHd0Z2lsRVVxc3F0?=
 =?utf-8?Q?nq5uPonoHktDTi+Sx6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 789cd68c-94d2-46da-7541-08deffda1899
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 23:15:31.5584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RAwJu7H5LKymYsA4eSTd/Q+mHc3YMJOcHdpsMzcIVvs3RF3VOEDvjrCsyUFM+r8p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6402

>  static irqreturn_t arm_smmu_combined_irq_handler(int irq, void *dev)
>  {
> -	arm_smmu_gerror_handler(irq, dev);
> +	irqreturn_t ret = arm_smmu_gerror_handler(irq, dev);
> +
> +	/* In kdump, EVTQ/PRIQ are disabled and there is no thread to wake */
> +	if (is_kdump_kernel())
> +		return ret;
>  	return IRQ_WAKE_THREAD;

To Robin's earlier point, how about some ARM_SMMU_FEAT_EVTQ ? We already have
ARM_SMMU_FEAT_PRI. Unset these by kdump instead of sprinkling kdump things
everywhere?

I'm not especially kean on these kdump annotations as a long term
maintainability, but having a FEAT to protect a well defined area of
functionality seems more understandable long term.

Plus maybe an embedded user would disable FEAT_PRI for other reasons, somehow?

> @@ -4625,6 +4629,21 @@ static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
>  	arm_smmu_setup_msis(smmu);
>  
>  	/* Request interrupt lines */
> +	irq = smmu->gerr_irq;
> +	if (irq) {
> +		ret = devm_request_irq(smmu->dev, irq, arm_smmu_gerror_handler,
> +				       0, "arm-smmu-v3-gerror", smmu);
> +		if (ret < 0)
> +			dev_warn(smmu->dev, "failed to enable gerror irq\n");
> +	} else {
> +		dev_warn(smmu->dev,
> +			 "no gerr irq - errors will not be reported!\n");
> +	}
> +
> +	/* No EVTQ/PRIQ interrupts in kdump -- queues are disabled */
> +	if (is_kdump_kernel())
> +		return;

Then this would flow nicer, you just wrap evtq in a FEAT_EVTQ test and don't
have to move things

> +> @@ -4682,19 +4691,30 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
>  		/*
>  		 * Cavium ThunderX2 implementation doesn't support unique irq
>  		 * lines. Use a single irq line for all the SMMUv3 interrupts.
> +		 *
> +		 * In kdump, EVTQ/PRIQ are disabled, so no threaded handling.
>  		 */

Why? I mean I get we might not need a threaded IRQ handler without PRI, but is
there a reason kdump would not want to create one anyhow?

> -	if (smmu->features & ARM_SMMU_FEAT_PRI)
> -		irqen_flags |= IRQ_CTRL_PRIQ_IRQEN;
> +	/* No EVTQ/PRIQ IRQ generation in kdump -- queues are disabled */
> +	if (!is_kdump_kernel()) {
> +		irqen_flags |= IRQ_CTRL_EVTQ_IRQEN;
> +		if (smmu->features & ARM_SMMU_FEAT_PRI)
> +			irqen_flags |= IRQ_CTRL_PRIQ_IRQEN;
> +	}

And here is also just a simple FEAT_EVTQ?

The overall thing looks broadly right to me

-- 
Jason
