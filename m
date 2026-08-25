Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013044.outbound.protection.outlook.com [40.93.196.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DEC37CD2C
	for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 16:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787675782; cv=fail; b=nCwZj3cFtQi3fFAsdDtbCFHmO8a0h0BtGlyUVk/+SOqYDcJ3pLGXOLil3jI8hx/HzBeOI9cS2B71W9PBroNH1XFXtQ2v4i6Ej7uBik3y60aEu/Q3jkYo+s4WRHuTyKnMbGn9kA91AKh3+xrF1V/V6uORvmjSp90xVr8H+jy66D8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787675782; c=relaxed/simple;
	bh=l60eXjBt9dnJKlD3JTCOQqeVD5+Ru28hBlHahw3nQjg=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=k3mqfDHFAQ6mqUz2XeN1xij4Z+3PUgBc2e8ed09QQiDUSOX+R0Gdc8YcjRlq34k0v/EGMtYx1G9VvInmz7i9UxrA/TORQPzSG/pzLmHYSKpgIdsulJ5kk28ZXK39tQ+P6zL/prXvuABIhT/CgE8c6BtO401Gz3D/s4x8a+LUBgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pv9LTikx; arc=fail smtp.client-ip=40.93.196.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pv9LTikx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BHY3ECX5qVaA21VUG5E/18NaGYsrymdn9Z3dK93C/hTGGnEvuXzh90p5vjcLBnpCqOhuM2Qhhv0OmzH/CD2c46K5DEiON8UDfmXjWOKZ3uTzELq3UFsLgZtisZeE+g+mcwEW+P84WtJsXw6XaR3FT0Fdy8OQJl3uWFUyhU3MvUi3PNakxIYgoEFBUrJU2vS6vzikL20d0YOZAURJiileAN2JDtACv+xkDHu4qhD8IcvgLgUKueLSDN+AHkFJmcoPQN7soED1ZFbcMsRkCrQB4JUWw1rt/TnJGSup3xRBTVW2xYoxBerDc9Bf2l2nBMuhsvPHA1oLH+G5TOI4iLR96A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/n5kPELaScNmOhW5fMURrbUzjzYl3PqvGCIfvrI7BI=;
 b=ArwBNkMBaOx4iYDL/W0NQjzBqX5y/X2zfkrmF61VH2A+hgFLvlMnbh//mg8dXDu1zehJOGRKvQT91rw0flkm03noeHCp/XsUgNdx2lLxjn/f9mx7F0vFbZz8SnlvjWDPflqRrxPT0oUiCYu0S/xNgsW3qb0KNzHH57x/LkCLbsa+XCCmENOeA7ySytKwukS2DpdQo02gUzwMrieRESHfNVnDZU0MxxbA57VjoXb9O2QrIIkAFmcD4FT8bDQ10dntqEO7ADzzm938Po4NwBRQyvO3GiV0hYJYzazRKOPe5p93fzrdQXISiReMJH2txAsngGtO9GdAkvaMVl0pQiTvJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/n5kPELaScNmOhW5fMURrbUzjzYl3PqvGCIfvrI7BI=;
 b=pv9LTikxfqPLSbgDHFQ9SoLVqILrsNlXD26NyAr+VKsxUyLNS+Nq5dzc8iWqxxTwBA5jvJE2Ihm29KiSP7oZSVMCQGPUoAdoOMcmDM5Sd7LChcZvUQjvX0BMNRE4CSgLXvN+/g74+pVDO2ikO08guT5VAdNZ4QF0EFXQy3VPCLCsLtdOs3CrPBXAFGerNBjjpBagvGEt3G/+IIV+ZZD0ouGUV9qfELLkvPU2AmM45b61l/40H/5nlww6rYZnkonFEpUQ5rf8cRmh/vOg/y4fbIECJITr6ZvjcECTmO/Z7/WOVWZcTJRPKc9lJaT4Y/IlBE9QZbKfT1DCT7bJPckaqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB9466.namprd12.prod.outlook.com (2603:10b6:208:595::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 16:36:15 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 16:36:15 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v9 01/12] iommu/arm-smmu-v3: Refactor
 arm_smmu_setup_irqs
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>, 
 Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
 Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20260728210928.1050849-2-praan@google.com>
References: <20260728210928.1050849-1-praan@google.com>
 <20260728210928.1050849-2-praan@google.com>
Date: Tue, 25 Aug 2026 13:36:11 -0300
Message-Id: <178767577112.3356902.15076197547390630060.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: YT4PR01CA0279.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::17) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB9466:EE_
X-MS-Office365-Filtering-Correlation-Id: f14bbeaf-8ca3-448a-87c7-08df02c6fb1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|10067099003|4143699003|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	bQWonvQshPqwkPU3qNs1Z3tVwu1uELAyBqLz+mxgMGQA7p0ik4+Mhfeho/40kfxsNtJ+dLrhHZqOjTsWGMKXiHS9v343By/jf4/QurM7nai8NxMW8J7RdIr5xSv5aUsEsIuY9jCZrtpBpvOBAR1iD65nhd54KK4FPXW2l6CtPAQfxKl19+pRv0+r01xTHlUKZCcZbJl5coR97bZVrn9JSdepeQxkkP8Zx6eRx4ZaN8UlPPWDRB+/uMRfPxtra1E3n4ORfpjqG8gKIQirop87qRozCmndOpfXzbcsfsexoZHip0W6kQxyLWMX4WqFZ0utXTXNmXCwkKki+3RTOmOTCHr5zcoo68fKeMQ1PxCSxzxJFOfgdxKrghkNK7IcIMZUIjl0IbJEOBVTIm4bAqZix3o77glHpkGcQSy50qw7aQAbSjE80NDU8EKODKtPTu4KqcKL2EQ4wLtDHzKlPnWeEh87c9/k/Vb56V9avXuWjr5d38MPU92tqqZhPA6p/hJmiPiXn/YIAgMbXhYehWoGRnJWmbkg52bYueKCSclSFBmIXopq/Oftfk+K4WyOBXifdOw11fz4AHjakxZoP2iJ+KKwDlTfl4CHcfvUix+QACWvfxXkQJy5eYp8b3QxpQB8AiVxTXu7KFUxYzEOYVVyetxddR8xwspGU4qG/CgZR9Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(4143699003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzdxM2FJYytreEFqNHVHZlMyLzFQangycmtuTFkzZnpaNmFTU1JmTWw3bVZZ?=
 =?utf-8?B?OEJSaENHSjVtOXlXTlZwTjNGOEJkbUJkOG1tcVI2Z3p0L055VDRmZ01KcEpy?=
 =?utf-8?B?VDgzMS91RGt6bzR3cStESEZ3WXoyQi9tcVRheWUzWW5pYnZjaHR0ZkdrV1Rq?=
 =?utf-8?B?M21KUWFDL1dISE12cWVMSDNnS3ZJZWVkUG9jQ2g1eGlJZW0yQ0YrZENmcE5M?=
 =?utf-8?B?MDRKYkhBWHhRQ09rNU1LSnFzTlI0b0JZZGx3aW1vZUh6VW9URGVUZFVpc2tN?=
 =?utf-8?B?bXBLanFoSzVaUjlLRkIzdVAybmpvdlVYMXZqY09XNjB6QjEzRzFTdVlNUVRw?=
 =?utf-8?B?d3pLeHVYZDY1alBtQy9PRUkwd3Q4WlZ4Qmxha0xoeXQ4aS84emNYMWVXYXN6?=
 =?utf-8?B?THE0SG1XUzZyTFBQZ3VzbmlVVHQ2YmI1WFFEVUZOQm8vR2JlZlQ0VmRkS3Jk?=
 =?utf-8?B?RG1QZ2FqWWMxeWs1ek5zYTNJc21Ld3l6UGsySUJVbE5vQTVXTXdXUVBZQnE1?=
 =?utf-8?B?SkQyNlVTS0picmdsNWxvN3djQitaR0tUa1FSeEpucnVrdzdqS3ByU1lXaVNs?=
 =?utf-8?B?Y3lTaVc4ZHQ1eDJZZDYyczR3L0QxcVJRNzAxTG5JOXQvVW8wcE1KZFFmMzdE?=
 =?utf-8?B?alRTMU13MkVTWHZsRDFCWDlXWUFaQTNYTktPMWxmTStxZmFQQnpnOTdoaG5R?=
 =?utf-8?B?ZWRKNTROenN6L2lRendkVGtUb0l0MlNmWE5qZG9BNHBWSXA4cnRQVFB2RUY1?=
 =?utf-8?B?akNQT0g4TDdJQnYrK2dYeW9oQXBqWm5aczhWbjNWaUEvMGZ0eU9STDg1LzdP?=
 =?utf-8?B?amJCTE43b2JwbktXZXVVNGNXZTA2RW41dURKckk1WXB4WExkekpOcml5dHhI?=
 =?utf-8?B?cjIreEZMQmVXQnMwSTl6WkE2VUJGN1Zoc01uM09TL3NBMjRndy91ZEUzbzc3?=
 =?utf-8?B?TW5SYkhMbGRUV1BWQTZ4TEF5K3djVzB3Y2F6NmNaSkZVempDb3NMWmxXek8w?=
 =?utf-8?B?ZEVZbk84TnJyR3YvazMrdDBGUmVmZ1J0cXdNQ0d1ak40bTVkRlIxQ0ZERGty?=
 =?utf-8?B?aXE4VHVyeVdZUFlLTVdabzZtYkNYcER4ZitrQW4zUlNNTkhuakpxMUs5emRJ?=
 =?utf-8?B?Unh6OEVPdHI0cXlNamFrSE1TSFc0MnFvcFdFWmJqbGt1MFAwU2xxMUpNVDNL?=
 =?utf-8?B?K0c5d1lxbExCT0dId0FHeW5RUENZYmQyRWtnWXFOa1ZTVzFvaFJGdk1FMGlt?=
 =?utf-8?B?WTllK3pXY1FQSmw2S3ZiTG1lQy9sNm90d093K1hhNWFsc3FzcUhrbXBQRHhp?=
 =?utf-8?B?TXBSUmY0c2kzL0Z4SERUek5ZRjlJZXkzWWhnQWhHaWNmRVYzR3FoYjVNTFVv?=
 =?utf-8?B?NktLN3RtSWlHT2dGelh3RExzek1KdG11VWo0OUtDSUJySGxSYkVQN2F6YzJ6?=
 =?utf-8?B?WW4rZUFCUm5Ha0paNjlrSjNIaUNQcEQyUUNDZDBhQ01vNHBlR0pUNExjdVBJ?=
 =?utf-8?B?YlNUNWFneGI1L3RibUk3bW1ER1ZPcEMwK1dQbEx3RitHZzVrWnlpRVc2Q0VY?=
 =?utf-8?B?c3lrdVJGcUtiVE03UEsrSENaYUtuSDk1eVVheEM3YmduSzBVVG1GSzRWL0lJ?=
 =?utf-8?B?SlhhSTFnSGZqOTlPV1YyQXBaYnM1STZMZ2F3QXJtRzhDeEdWMXZabzJCU0o4?=
 =?utf-8?B?bCtZTGh5dko4TUxZdjhKZkJScTdYUnFQYWdhbi9uMTRTRGVoUzM1WlZKdTNG?=
 =?utf-8?B?cnY5dzB3UzJxdy9XWVdwRWVqZ2prdGtFa2ZOK3FlQk9zUWxkRk04T3lnckhS?=
 =?utf-8?B?a04xditkdDluWHNKNFFONnpEQzI0UmYzZkNqSW9WeHdkeHlPUkJkRHRzbnFq?=
 =?utf-8?B?R3g3aXUzQVNQeFJRSnB2ejlXTFRlUU9ScGk5RENHMDZmYlNZQ0M3OHRpS09s?=
 =?utf-8?B?cm93UGNmYmdiT0FWRUJJZGNLQjdBR01pSVZWSDR6MnlPcTFsWHl3QU05TlRD?=
 =?utf-8?B?Z1U4VE4rVEdyYjFBcUU4NHpKQURDTVh3eUZMZFVhNEVGcjdKdDJ1TWhiamU0?=
 =?utf-8?B?bTZvR0E1Z3dNUGdIb2ZYNmgzMEMzbzZjcThqdXV3elV4OHNDTXdlSG1UR2pJ?=
 =?utf-8?B?Vlg5Smhpcm5JbHJmbjNsaW12cGNaNWlwZFNTd0hZclZaeVVjQWY1Y2R4R0RO?=
 =?utf-8?B?YjhSVzRDMFhJM0RxVFk2YW11bkZ3MWRvbnhZQjVxR1JPNWMyWVpFS0ZyK0kx?=
 =?utf-8?B?SmtXV21xemt4SUJLc1RVcnh0cTVGQWVwRjB3ZUt6ZUxWR3ZoMWNZNG9FaFl4?=
 =?utf-8?Q?MmeN5TXjNPDhh24+cC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f14bbeaf-8ca3-448a-87c7-08df02c6fb1c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 16:36:15.1900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1BIAfAYae5ctwtdPOC27JYAaCwc8GVe+XOH0nrZPsrszyrdWUkFQrzTV5DgRmKQi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9466

> [ ... 84 lines skipped ... ]
> +	/* Setup interrupt handlers */
> +	ret = arm_smmu_setup_irqs(smmu);
> +	if (ret) {
> +		dev_err(smmu->dev, "failed to setup irqs\n");
> +		return ret;
> +	}
> +

The sashiko remark makes sense to me, we should not enable interrupts
until everything has been initialized and things are ready to go. So
this is better done after the device reset call, which is the thing
that is setting up the queue pointers in HW..

I'm not sure what to make of the MSI register ordering around kdump
comment.. Nicolin?

But the refactoing looks fine to me

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

-- 
Jason
