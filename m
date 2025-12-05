Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012036.outbound.protection.outlook.com [40.93.195.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7741E98E6;
	Fri,  5 Dec 2025 06:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764915371; cv=fail; b=H9YOednPOR+F6xtTO3vSaql59ATlcQB8DFpVbdHgTlSC/yIyim/DtOci/H6kS0uZZfitCrwcNU/m7TVNClAwuR46pYQI5EHGj2nZ9IOCLteC9962aPwdQwCAAMSVkbcn0/vfpZKf3qAwZpQ89JH838T826BswvZmZthSL/hVBZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764915371; c=relaxed/simple;
	bh=btwJu1CDGGqbiap3lo6sWwaFmtsACV2V24U1Jj105r4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Po3tcCLE+YUGOx1xZdoZg/KWqc0R/DH5ImGIg8vUSyQGnZ/1ga+UzN6qsuuilVikla3YWwR4Ac/V6twozsq72D/5tEv1gEu2FxQ+fthm4pCOyvBX2UMYgIIQweeLCKuDAcwqQy84hH6uIMG/Z7xCG9kFC7+XXdP6TQ/k9kprK0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uU4e2QkM; arc=fail smtp.client-ip=40.93.195.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uU4e2QkM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UqdoFUr0GlmNu8Kxte5Q16Rw8FYiVNGXX47Q1k0VHPPhUhn94sFg1u/7AHzdomUFOfmjVt7Oe1gLaKNyc++2aFlx5F8d1kvBz+tV/SHaWeANWK5csEqHGYX4MC3WKaKA+kPv4k1/PwrT5nyPdkeOsJmVVZd3RmOxt8+Cqk25Sgj7gaslmZU/z6fQ3HQaeYRCbZG7h0EPbUlfHCuQdQ9GWd2mpFKVUOQ0xoZWjiFFm7KtwZwt4/2Mz5uaFu6LwCYnElp5p93vs9/o/xGJCh9BxTOGJ8TldfEUAtSy40b0pMa+sIfyWPKBZV8ZS51/soz71qLfMu8wGVwOWTBKdNH6Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=59F+Jdk/IkkWqrX1B+kQ3PFvLXDzbo6qLsvvnE4i2hg=;
 b=CYzNE/14tp56i72rrMpiOhZJ/iyZP6/CzxPuasBAeNPxQFK1ZxjngcE0WmbGjB8E8n4U9P2rsiARzDCKGiFhAyym7zTlpiEwXUmB36i7hJxAYXOvPocg6NgGCv4Zs4WQIgYvMKfy5grFmczgZGqrXQI2Km594I7pc2LLkhW4BweYmk72x4ZQvMki/nK4JpJEMaQ01PCRdNVCe2FT0OAxxOcyOGD0XfzVmrs7TQTwiOm9t621RltL/WxfmzoI4HOOu6gEU0bOcIuIk6IYaV7qQH7xpKX0eNcXOB9XUsoOGdTiTD10grCYc9J2Vct9KqnyJcE6cKKzljTdNKwOi3qOJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59F+Jdk/IkkWqrX1B+kQ3PFvLXDzbo6qLsvvnE4i2hg=;
 b=uU4e2QkM5seT8yjwYfwXXvKo1avzRUfR4o9hTIpOI5c79XTCPeITfwRiNB/OPQxZVXgBB9x6+oiq85o/YqoN2lLXl8x/oQwAh+OKPIumKY9S2s7pIG1XASzhradTDZLo6F9G1WQkUIhoySZquSWRePOC8Z5C/FGqwj/oWUPyEX5vWvtDhB1pgVf6v5iriaz0snrKZA9lV2uJdgxhaDENrnbuOHec/fBrG/s9ZMW/aSIX9yz4EnEyTf3ksfuRdS7eYnIgyxPzyzj14pUS8tYg+8MfJH/thiBgn+Ez2GW5ua+LXR3IX26hSbKbVM1GnqGP/PO6RXcme7vWXDudZ6uaUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN5PR12MB9511.namprd12.prod.outlook.com (2603:10b6:408:2a9::14)
 by PH8PR12MB6700.namprd12.prod.outlook.com (2603:10b6:510:1cf::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.10; Fri, 5 Dec
 2025 06:16:05 +0000
Received: from BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c]) by BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c%4]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 06:16:05 +0000
Message-ID: <3be111a4-faa8-4a30-8638-d8e8db0f365d@nvidia.com>
Date: Fri, 5 Dec 2025 11:45:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/3] iommu/arm-smmu-v3: Add device-tree support for
 CMDQV driver
To: Robin Murphy <robin.murphy@arm.com>, will@kernel.org, nicolinc@nvidia.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 thierry.reding@gmail.com, jonathanh@nvidia.com, vdumpa@nvidia.com,
 jgg@ziepe.ca, linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
 joro@8bytes.org, robh@kernel.org, kernel test robot <lkp@intel.com>
References: <20251201163219.3237266-2-amhetre@nvidia.com>
 <202512031601.IpliwbHW-lkp@intel.com>
 <47684b91-7c0f-4260-abfd-2795fdaa2b31@nvidia.com>
 <a917aded-4404-4b63-8d2c-96aa8b84f81f@arm.com>
Content-Language: en-US
From: Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <a917aded-4404-4b63-8d2c-96aa8b84f81f@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0031.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26f::14) To BN5PR12MB9511.namprd12.prod.outlook.com
 (2603:10b6:408:2a9::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PR12MB9511:EE_|PH8PR12MB6700:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fb11623-f180-4973-9f95-08de33c5c563
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NFUxNmU0b3EwRTV0QlNFUlBLa0V4M2tYZE9vOXRKUHFDdmlOTEYvdGk5TXNn?=
 =?utf-8?B?MXNWK1A5WlJCMUw4QU1IbExUdllBK2puZ2dSMzMrZmZSclhGOGFwY0ovZ2Qz?=
 =?utf-8?B?NisxUmpDaFNJWHpsUlVPQms1Y2Z0RlBHQlhuRXJRTXdlUzdGY2w4L09xZjJp?=
 =?utf-8?B?Z3hqWG1KOWliUENraEpDOEd4UGZxRzBOOXJqNzArTzRPaTEzVklrTEM3STdo?=
 =?utf-8?B?dTlIcHo4NFF1b01uT01takxVUUFGWDQwdHFOYUV2cUJBMUdXeGttWEcxaEZG?=
 =?utf-8?B?S0Yyb09WbWFlZHNLd1dWd2U5YnVMUFBLdkFLa3BxK0FQMUYvWDBueTZ1Qmti?=
 =?utf-8?B?KzQ4QWJia3YzS2pYVjJrdWNYVzJ4bytibHEwQTlLNEE2VHZPeXJWMHJhQ3FB?=
 =?utf-8?B?M2kzV09UZWh4YTBDdFdUOG1uRU44T25QWEpJNnZLT1M3WDdDeEVuUndwUlpC?=
 =?utf-8?B?SE9GSEpuNWRiYkxWblZEV25CSis5ZXdwMUUzTmFOaG1COU8rSTZnMzAzOE96?=
 =?utf-8?B?ZEdwQ0p1b2VJZW1BdGRFM25SMDlUMmdDZVVMd1AvNW84SDQ2SndsTFl5b1dD?=
 =?utf-8?B?dCtPRXJHd05XL1J1L0Yzd3hxazFXSHJqKytFeThNdGxXaUt6NEtkaDBxVmtn?=
 =?utf-8?B?dG5KZ1BhcWUvckh2Mk1lLzNvOUtKalhsUDBuWDI0NUp1RFo2dDUvSGhvdGFq?=
 =?utf-8?B?NXRWNXhzMC9oTmMzTFpsZ2FoRjVEaE1COVZlTjhnWmd1TkMzY2YzY05WWk1o?=
 =?utf-8?B?SXJtWUZzcmUrK0Z0T2VqcVphZnk5eUNIMkRaQUtUL2l1MlF6ZGpWcTJjOGM1?=
 =?utf-8?B?ZFM5dEt1WWVTNHRhVUZ0SUh3dU8rU3dsMmJOenBJQjBVTklzcVhSaW40cTg0?=
 =?utf-8?B?aTVWSm5tSThxTkJrVUNPaCs5T1pkY0NKUEFXUHhiQm5iUVgra05hNi9YK0hY?=
 =?utf-8?B?cDJtWGdFTnpNSXd0NzNjZEkwM2hlcGtVV0dCUmM5eHFnanNrMGgrVTJQb25x?=
 =?utf-8?B?aUl6Ky9rLzZCbkJzcHFXb2xPeC9nZGFtSTI2cEZUUWg2Q0JMb1N1ZEhNdUVw?=
 =?utf-8?B?V256REpkNTV6eVNBUmVhU1R2bzdsZFZkaFhKbk9INUF0QUY0bkYzTDJ1UnFZ?=
 =?utf-8?B?RW5DZ0lsY2V5NC9XcGpxaEhaTVlUY2hTWjMxVW84T1lrWVRnUUtTc3p3Z2hS?=
 =?utf-8?B?NFQrVWRsUElkSEdFdHJTaUJWMEtuUXM3RHFMdTNUZGRRbG1zNUZ5UEpBYUF5?=
 =?utf-8?B?WkdYeStrQk9vMVpUQ1BKRVA2U2FyNFFhb2NoTW0vZVU3aWF0N0k4ZzhIdzJp?=
 =?utf-8?B?ZUVKUGl2NldyQXY3UWxTNk1xVVU5TmhTOUNQNWc1UWJjR3VhMWNaY0VycVpX?=
 =?utf-8?B?N1c5T0o3STh5WWVNbXFaaVQ2TkxFdVZSUTc3RnBYVHNpWVZlalo0TGlUTDdK?=
 =?utf-8?B?Z3ZOcFRiOFB6MjJBOFFhTFRSVHNTRlBlak4wTGJHMm5CK2lYUGszNWNwalBD?=
 =?utf-8?B?NUJuK3VENmtQZHVaLzFzam1xdGhNTkhVemNBMXhyNWh5MzdlR2dLZ255dVVV?=
 =?utf-8?B?U0JleFZuL3ROc3VDbEUxdEtCMER6cUVYeGpxOSt5MEhHL2ZwV28rQ3l5MHZy?=
 =?utf-8?B?UjVxL2dXcllkTjhHOVQvLytZUXpaQXdjRDY5b1VVNGdkbngvWmRaY1Y1VTJX?=
 =?utf-8?B?dHlsbUNlamRBU0RJeEhRMlpZUWN4MS9pNXMzeVcyTzFBOGdwTzdpdDB4V0Fp?=
 =?utf-8?B?Vk05ajU1Q3pYa216WENSUnE3SHYzKzhkSGZHUEdhM1BKTk9uRkZuWUIvODBB?=
 =?utf-8?B?empWaU1zN2JCb09ZTm91ZGFtNmEvREJIZlNEQ1NHK1BDREpRM1hkUGkyS2pE?=
 =?utf-8?B?UGoxNHlhZksxUk9FQTBVQ09UaGNrdktvRUVNaUF0bDFEa0pyQUlPNVdsTit5?=
 =?utf-8?B?TjZxMWpVOWVrVFNDVDRBTThxRE4vTHVRZ01wSFdJSmNBV1djRUZyRVZYK3lu?=
 =?utf-8?B?SEhnd0tIQW9nPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN5PR12MB9511.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXVYYmlwMWp6UUUxd21ZdFVOeWE5b0xNd3NaL3V4ZEs3Wi9pVS95QWtSaCtV?=
 =?utf-8?B?ZFZ0YjhBSW1sTWdsNENGNlFPNDBNOXZlNGVqVHVMdlM5aHVSd2lTY1dSaHBQ?=
 =?utf-8?B?WTgxS01ZMmcxY1RLNGdzTUFZVFFzalpYMGJYd3FSUFlFc0pnOWZYTkV2STlH?=
 =?utf-8?B?TWg0ODl3Z3ZXZXNzZXFST1lHTDRwdytBNlRDMGNQQlhNbmJrWlJ4ZE1IN1oz?=
 =?utf-8?B?NStqaFB4SHFoSnk5WWdQSlBaL0xaNjB0LzFHbHI4WUpZRTR5Y2dRUlZoN2VP?=
 =?utf-8?B?ay9aTjdod0tJS2tOOVk3OXZkRDBmNXU5TzBTMzFITklJQU9ETDhQZHNYa2Fo?=
 =?utf-8?B?eE1zZ0Nnc1JBTVZuemg2UEpzZEdFUmdYZFU3Tm44blZkQnRtcnEzV1c3TXdQ?=
 =?utf-8?B?T25mUFo1UHV0WkVSd1U1Wm5BQlloVmZmRjRQWkxlelg0VHZtV3diaCtEYlVw?=
 =?utf-8?B?VUFVd2VDV09xeWQ5ckV6b0lYd2NLbmd6K08xazBsNXZpQXhqcHI0L0I4elJR?=
 =?utf-8?B?UVRWQUNBQUJZcTlCdnBpZ2hZbWZNWHM3UEZ4bWRKbnd1TVpoL1hZdit4bEEv?=
 =?utf-8?B?YUFKTHQ4aFM2eEFZbVZZZmZDRThFNzNHUE95RGhDd2VQUWF3TTJsL3BSeVFo?=
 =?utf-8?B?VVc5K0NwOE95ZktYUGk3T0I5NUdBdk8wQVB3bi9tQUg2V1BGdUhFS1htMWpF?=
 =?utf-8?B?c3o3TlY3T0M5QVduK2wvZFNRMEYwaGRIMENLRVdnSmtLWHV5Sjd3d2M0UG5o?=
 =?utf-8?B?MnJRZ2tOanlJWmhWaHRlZ2htTGNnL3RGSEE2ZFpuYzI1NVUvRU4vMzNCdlYr?=
 =?utf-8?B?eG5vNTEyS0QwNzRTOVNaTkV4N0w5aThEZmhBSU5HQ1BScU1LWTFzYkY0akdK?=
 =?utf-8?B?a0xOSnAvaHJpTTgxNmJhSjAyOCtYdm5wTFpBeXl4c2N5bzZja1NOVnZrYm1s?=
 =?utf-8?B?K1NLSzkwUEsyWFFWY2FMUDkxcnBqV2F1SUN4KzVMWk81RFhGV0pzdVYxSzcz?=
 =?utf-8?B?NnFYRFNjTVZ2TzYybjl6OGk0Qm1pVnRrYU8xa2JsdGU0SzJ0dExNM2Y3YXVi?=
 =?utf-8?B?UzdnSGVRaUFkejVyZmtQNUtXVEgxZGJmRFlDc0ZlVFdueXMxeEgrS1N6d3N6?=
 =?utf-8?B?YlBzaENWWVM1VndyL1RjSmdCZWNiWkIvY3BEOStSYzdpa3F5OXkvTDBaUEhJ?=
 =?utf-8?B?aHNQdEVtaitjaGRSN3RxaDM1TU9xdm0wU2E2K1NrMnJZYVMrMjBCZWVsbFVT?=
 =?utf-8?B?WHRLZDJqdUViejg0UW1ZVDBsaWdKK0xGblltWlRtdzdUYVBDdk1yUXNTYVFy?=
 =?utf-8?B?RElUYk96YllZUkc4aEZtRTlBZlpETjltS08zZi9ySmRWU0EzSThwSE8xSUpT?=
 =?utf-8?B?a0krbFExRlI0d0RDc2lYVW04UUJrOTRZeWJkSDdGek1yNEhQVzBvc2dQam94?=
 =?utf-8?B?NG5Hb0dpOENOdEh1aFFtenR6YTN0Z21KSGd3R1RRemhrTlA4UXkwMkN5MFpN?=
 =?utf-8?B?Vk1HWmdTZitITmQ5dWlTbC9xWURKUk9hSUVOV1FhZGN3anlLekw1ckNCYU5m?=
 =?utf-8?B?dnRub21ZVWJxeFd4TFRJSTJhSGRhZVJRVGp1NlkxbFVxdVNiTHZwWktzR2xp?=
 =?utf-8?B?SmZmMnBVTC9qd1paM3FtaEpobmpaN1B5UzZoK09KUDZBV2V3b1dSRGpMaGU1?=
 =?utf-8?B?Ylovd0twVmlQUUdBZnJvWkZtTzhNSmd4VmQ4eWhEWndrT2lscGg4R2hEUXRp?=
 =?utf-8?B?MjJCaW9qVzZBbzI2TFBhUUxJczRrOERZOUEwRHRnUXpUQnZFYlVSSmZlVEZr?=
 =?utf-8?B?QTV2a3ZaU2RoV1hPekc5T0tTWVFQbWRydDBNYWZQUmtabmsyZ096R1V4a3hZ?=
 =?utf-8?B?dDdvMkJZZGdtMHp2VmFvVktzM2VtYjU4bUlwRGxYNk5QMEhuUU5hdTdIN0Vj?=
 =?utf-8?B?VUJJQXpieHhsUUQxQW5HY201TDFkSDFXdG9UNityUHdlVWhwYXNuUmVYQmtl?=
 =?utf-8?B?MVp5SDE1bHQ5d1E5S3Z0TXAvdDhiQTQxUjJkMjB2UnZnN3NUenFLd3lrMEtG?=
 =?utf-8?B?QW5iWkdhKy9zWmRUQXY2Z29SL3JwUzhsZzRuQUZyWG5SRFRzZ3gyYVdMT1pP?=
 =?utf-8?Q?BIoE/7YfYeXu1sXEfQoNpS980?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb11623-f180-4973-9f95-08de33c5c563
X-MS-Exchange-CrossTenant-AuthSource: BN5PR12MB9511.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 06:16:04.9626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iz4T3KfC85OzGf/llUoZRoWhH6MkF1d13vd3ZP/4a3iqlRtAxb8HdendIcdke3gemVhxzvNaeRP7JAcFtOOtWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6700


On 12/3/2025 9:19 PM, Robin Murphy wrote:
> External email: Use caution opening links or attachments
>
>
> On 2025-12-03 11:04 am, Ashish Mhetre wrote:
>>
>> On 12/3/2025 2:05 PM, kernel test robot wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> Hi Ashish,
>>>
>>> kernel test robot noticed the following build errors:
>>>
>>> [auto build test ERROR on next-20251201]
>>> [also build test ERROR on v6.18]
>>> [cannot apply to robh/for-next linus/master v6.18 v6.18-rc7 v6.18-rc6]
>>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>>> And when submitting patch, we suggest to use '--base' as documented in
>>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>>>
>>> url: https://github.com/intel-lab-lkp/linux/commits/Ashish-Mhetre/
>>> iommu-arm-smmu-v3-Add-device-tree-support-for-CMDQV-
>>> driver/20251202-003517
>>> base:   next-20251201
>>> patch link: https://lore.kernel.org/r/20251201163219.3237266-2-
>>> amhetre%40nvidia.com
>>> patch subject: [PATCH V3 1/3] iommu/arm-smmu-v3: Add device-tree
>>> support for CMDQV driver
>>> config: arm64-allmodconfig (https://download.01.org/0day-ci/
>>> archive/20251203/202512031601.IpliwbHW-lkp@intel.com/config)
>>> compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project
>>> cd708029e0b2869e80abe31ddb175f7c35361f90)
>>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/
>>> archive/20251203/202512031601.IpliwbHW-lkp@intel.com/reproduce)
>>>
>>> If you fix the issue in a separate patch/commit (i.e. not just a new
>>> version of
>>> the same patch/commit), kindly add following tags
>>> | Reported-by: kernel test robot <lkp@intel.com>
>>> | Closes: https://lore.kernel.org/oe-kbuild-all/202512031601.IpliwbHW-
>>> lkp@intel.com/
>>>
>>> All errors (new ones prefixed by >>):
>>>
>>>>> ld.lld: error: duplicate symbol: init_module
>>>     >>> defined at arm-smmu-v3.c
>>>     >>> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.o:
>>> (init_module)
>>>     >>> defined at tegra241-cmdqv.c
>>>     >>> drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.o:
>>> (.init.text+0x4)
>>> -- 
>>>>> ld.lld: error: duplicate symbol: cleanup_module
>>>     >>> defined at arm-smmu-v3.c
>>>     >>> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.o:
>>> (cleanup_module)
>>>     >>> defined at tegra241-cmdqv.c
>>>     >>> drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.o:
>>> (.exit.text+0x4)
>>
>> Hi Nic, Robin,
>>
>> How do you suggest fixing this? Is it fine to compile tegra241-cmdqv as
>> separate module
>> and export tegra241_cmdqv_probe() to fix this warning?
>
> As Jon just pointed out, the issue is using module_platform_driver(),
> which is unnecessary anyway since this is not a driver; nor is it even a
> module, it's just some extra code that can be included in the
> arm_smmu_v3 driver, and will be integral to the arm_smmu_v3.ko module if
> built as a such.
>
> You could sanity-check the compatible of the phandle target in
> tegra_cmdqv_dt_probe() if you feel like you should do more than just
> blindly trust the DT, but either way trying to register a dummy platform
> driver that won't bind to anything is pointless.
>

Thanks for the pointers Jon, Robin. I agree that this part of code is
redundant and can be removed. I will make these changes in next version.

>> I am using GCC compiler and was not able to reproduce this with W=1 
>> build.
>
> This will be happening with CONFIG_ARM_SMMU_V3=m.
>
> Thanks,
> Robin.
>
>>
>> Thanks,
>> Ashish Mhetre
>>
>>> -- 
>>> 0-DAY CI Kernel Test Service
>>> https://github.com/intel/lkp-tests/wiki
>
