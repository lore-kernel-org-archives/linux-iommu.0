Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150E742052
	for <iommu@lists.linux.dev>; Tue,  9 Jul 2024 04:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720499994; cv=fail; b=i3HqRPaQbElsVHlGnqJja9WSfMGWOug6wdXzcS+nXxmsKTSwA2vaYKpY5HbDZJw42km65ft/YMFTHia0hBcQJPkn1ub8FeKcaLYn4PFJTFXcAvb2kjSuiWtGEPTqGX5nWyJn6KS8Edq9Gs7C7buGY1AJQFfPtP4/dBl+SEm1ong=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720499994; c=relaxed/simple;
	bh=/Lp146YjN1WDXnec2PYVOuwXpBi33ElV7krim3zUpMA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a39KiWPMxWAa7y/DVt3W0AkM5JAJlDfFdoVgNcSTKZKhcINRo2zeJlaaLWCgYx7JkgO6mOp6eNCQHJZ/E8Kbf548nvb/Q7C7tC6diJf/sh2WztTuKj3HQwhmqzD05ttWbAn1PDv81nv74t3ju1P46b3rcoq7oW7vIlMMpQS0BWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EusXa9Yu; arc=fail smtp.client-ip=40.107.236.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EusXa9Yu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=not+LL6TCgrvgskZSjSP9cGXKnNFzXCdEmWKiQeaN0x+QWqoXr31rC4LtIWwhlqMNoIBzFmSlYnYI4CFnyj99xR1bRr8wha6S2yXTY/yRkCnYftV7R6C6Hz/EBg0mLQwUz1KqN4f1S86qz1tTVnCtxSuixi+vLiwSHM+FqHXrSBIrVp3feLrDOAwSO75lhDBO4NbEU50HYHEsbqo97KNXAiyy9zYu9sEg0qfkrEYAwKdhjshoz8o9TSXVw57e25PYlGIB572PdRoIO92gLGd7Yvm2NvtCEfSiXUZOA1gSOVDFGkNX+Mur0eo9O57hI27/qWXwdIL5NeMTCFy9O743g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3z2ZKZMn7QyPpa2/CzHxbW2MJklzLOsH88oooAibKog=;
 b=a8g1uIadCNyyaU2iz/r2z0sdGdS7QEF9zsSdXzlvo8fFT2FzskWETjq9d5pZIFou+eiVHjAt4vApJd316duwh7BS0QA4mR0oe43ZyF0XPHuWi7WCL6iC7mWItWLTqoE1lT9NXLeI0/na+qCmrDRF7LW9Fo3x9Ew3k/py1qZbJTmNra0aLnf55rnL2r0DGEr6oYOJXe7DzM6xRpLNdQv8XZx82MnSg85kYh51kQAKlhBjOMsLoc2Wn87lvPziU51oxU9Dwgiu2do9MEYAuM2W5S4jMkBQQfOIQxAJMyOm2fhWo3rdHcZ2tO+JQ9mz2CmWHhk1AIlxSkeiJ+WLgcrXhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3z2ZKZMn7QyPpa2/CzHxbW2MJklzLOsH88oooAibKog=;
 b=EusXa9YuxapLQLQ4GLLqLl4xRrDACv9zYSaZc94GlzU9Wc15ZMhBg8YHoqtjtLg47EmfTsIsALjPPFRFQijlpouO1K50bQPZ1IUN5gTmCz4jIsRXEViNij96Q2bwUdRXG4Pq9lwCcDsXLxF7BIeccmCw21/ViBBZQgCl0HTczmUwTEKjmE6dRfE07ygyY2kyBiZKnniNOWnBviMroOhJzn80oxxa9XUwzPmxGfnMw4JZV1+9jAIy6d7qYsjzOGWrQ4omghwqSKk5g1l4Vu8olfa5472uBM+qLJXI/UBp4gizeOHQDGr9FwlzxiH+Quto/0JQC58cJfw/FHF2W56Omw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB7426.namprd12.prod.outlook.com (2603:10b6:510:201::18)
 by DM4PR12MB7527.namprd12.prod.outlook.com (2603:10b6:8:111::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 04:39:48 +0000
Received: from PH7PR12MB7426.namprd12.prod.outlook.com
 ([fe80::6fdd:1491:4d83:ac33]) by PH7PR12MB7426.namprd12.prod.outlook.com
 ([fe80::6fdd:1491:4d83:ac33%4]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 04:39:48 +0000
Message-ID: <eaa4f128-40f2-4db0-be86-84ae1b652ab7@nvidia.com>
Date: Tue, 9 Jul 2024 10:09:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] iommu: Optimize IOMMU UnMap
To: Robin Murphy <robin.murphy@arm.com>, will@kernel.org, joro@8bytes.org,
 linux-arm-kernel@lists.infradead.org, Rob Clark <robdclark@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>
Cc: vdumpa@nvidia.com, linux-tegra@vger.kernel.org, treding@nvidia.com,
 jonathanh@nvidia.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240523031935.90856-1-amhetre@nvidia.com>
 <6b707eb4-5cf3-4b66-8152-5ba252f5df39@arm.com>
 <2a349725-72cf-45e2-9ca2-5a8b153a6fae@nvidia.com>
 <d854664c-ab56-46b6-81f9-9ef712c32b3a@nvidia.com>
 <39d1635d-25b4-47ca-beb3-0baaae6252db@nvidia.com>
 <cc69b154-ca4b-42eb-950a-9ea3c5a4e4ee@arm.com>
Content-Language: en-US
From: Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <cc69b154-ca4b-42eb-950a-9ea3c5a4e4ee@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0098.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::11) To PH7PR12MB7426.namprd12.prod.outlook.com
 (2603:10b6:510:201::18)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7426:EE_|DM4PR12MB7527:EE_
X-MS-Office365-Filtering-Correlation-Id: 61f21001-6a0a-463f-48dd-08dc9fd129ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c2hWbTMvem9FMjhCN3NMK0VrVldLRHljOGVETlhySUxSeDJtM2R1SlpvTE1s?=
 =?utf-8?B?VE95cFdkNW9aSXZjZ256MXYwb1ZEcUw1UFFRZWZXMnFJYml5NitaZmZlelZ1?=
 =?utf-8?B?L1pQQ1BQaXh3aGQrd0c4SEN5S2ZZVTVsdjBXbUxtQU9VWkE0MXJWeTc3VW10?=
 =?utf-8?B?a3RnOXhVYzBuNE81YUtoajRqMWU4Mlc0bXI5OFl4RXdiQ0pzU0RZQTl1TDVy?=
 =?utf-8?B?MDlRcWNrOEJTdVE3cWxmSnNrV1dMRXRGRFU2SWZ5V2tSWXhSTHJpQUdHc3li?=
 =?utf-8?B?UGhuL3RkMllGYU9HSFgwQVY3cDh0SmVCdFcwczNsL1MxV0xRT3Nuc2Z3R250?=
 =?utf-8?B?MVhUaVVSenQ1dGVnTU00bzh0L3lROU52a215dHdiYnlYNEYwa0k5b1VEN0p0?=
 =?utf-8?B?bWhuM2RRV0FKSjhGaE5ndEhYVVFiK0s2M21GUEhUUnd1TjR2aTlScG9TZ2NJ?=
 =?utf-8?B?YUp1T2kzVDJ2UVI3QUJyUFlqdXQ5Wnd4M3NaSHM4TmJkOWhFZzlNbUJkWk1E?=
 =?utf-8?B?aURjc1M2YWxRZGM1dEVibk9JLzZsRlNOWERYRVMrWU11N2FKY1Fnb3dlSVI3?=
 =?utf-8?B?bktzTVo5NU9HeEplblJEQ0pwU0NoSnphaEFwTGE1WDFMbmtCRGh0MG5KVy8w?=
 =?utf-8?B?dkNzMjJIcklMY09HMnNMcnltRXdmczJWTlphWHM0MG9YS2h2NFRvTnRLckRK?=
 =?utf-8?B?MWpqZ1FRR0lkdHgrOSs1cURRWE5rR1ZMd3piTzRCR2JCS3JQalVLVkdQZDgx?=
 =?utf-8?B?QkdMZ3BkbkVMWXR2b3NEY1ZBblRUKy90MkVLZUhiendIUHVXdi9aT0MzUVhL?=
 =?utf-8?B?NzZ3VXZDL3k1UUhPSkJZZWVxbFFVRXp6UUQ5c3FkNldBczdoZGNvTlNXaTVN?=
 =?utf-8?B?TVkwNWxiaGJSUVJlWThBMmRqMzFyd2ZRZExNdnNsY0taRU41VU9paDJEeWRj?=
 =?utf-8?B?eHYyc2IyMU5OOU1oRVFBT3JsUjZwRVpod3R5YlE1akVaVGtUVXo3d0N1Z2NF?=
 =?utf-8?B?QnRnYzlHT2pzSFRoTWJobyswTWZIODVCWlNSSjIwY05VNHJTMlhSMFRDRlhv?=
 =?utf-8?B?Z3RSREVxTHFOd1BDUVNBK0lMNTVwRk16YWpaVUd4YzBXZWtsZXVGNVNtQnd4?=
 =?utf-8?B?YldCOC81cFFwcEFTOWU5MFdoZnM1VjJ0Nm5vOWd6clg3WEo5Y2p6SlplblVN?=
 =?utf-8?B?cktQT0dmN1RXS2JTK3VmR2t3SGdQaDdxdjFmVzhweWNObGxYd3lGbmVuMTMz?=
 =?utf-8?B?L2hxcU0yNTNwZTZMckFodTNjMzYzeXZSaE9FZVJvckRJZmtQdGdrcktlKy9h?=
 =?utf-8?B?ZzNEYnFDeTExSUdWVmNGSGhhQlBzR0JQOTJac1lxb1pRU0RSRnFtY2VXNlZV?=
 =?utf-8?B?ZWlZYWdyY2xveXZZQzJDejQ3SzVhNmhDK3h6a2thczQzVmM3bjBGYWNrUmVL?=
 =?utf-8?B?bHVlc1JnR1ZpbDdLNjJPa0lGMDNwdmwvSHJ1RlhydlhDVE8rbFFpVXQ4MGJz?=
 =?utf-8?B?MkFjYVhmQ1NkY3RxZnZWcGpwK3lVd1pEQlZzMnlVSjZGODdOQTErT0E3cnpP?=
 =?utf-8?B?VFVCdk9NZldkZzRaZzYxUU01SWhPZ2thekoxRXNpMWduVnJFRjlFVUhmVHFy?=
 =?utf-8?B?dTQyVmQ4WVRpL01qekFBZ1hVUlFzeGVXNTA2cUN4L2M2OE9uWjc1eVZHQjNk?=
 =?utf-8?B?TWtSZVBmMGRnMGpyV1ZMdG43ZnhYbXR1Qkp4RVlmdllSNzF1WFJ0MjhtVmEx?=
 =?utf-8?B?WHZMUDRlRjdLS2NSZVpwZzNML0lxcXlWSVEyVk9GdTJmMkp2OUpqN2ZYNS9L?=
 =?utf-8?B?dGU0a1JINkI4SlhrMmo5UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7426.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmNNTURvMmNCeVZUdE1OSnhkOFp3Z2VIelg2RXRoNTZRTlpLRG1PbSsyQm1p?=
 =?utf-8?B?Q1l4STJCWlNONDRRTG1lR3Q1bmFvajZpb3VlRFVyUDFzbHRmcmZqd2NTYW1J?=
 =?utf-8?B?ZHptdTdOZUhuMHlZbVhnSmJ6NWN0bjgvdzJhRFJTWHFMaXBZd3hPdGhUazJP?=
 =?utf-8?B?bFM0V015Rzg2dml1L2tjWVpXdXZmY1JRV3hHL2drTisrTlVucG14NW9GSGlk?=
 =?utf-8?B?R2ZCMmRaN3FRZTMvSS8zNFFtSUxFdVA1cHZDV0JYUDBpMlM5THhlWUtia09y?=
 =?utf-8?B?TTNNRFRndXlXUklRcm5rMWlQODlILzZWN0JmTU1VY1k4VjZUZWJnRTZhcGw2?=
 =?utf-8?B?aXJja24zMFIwWnFDTWJ6Z0MweDVFVUlSTDFJcXRBbXRoU3MyOWQwNVh5UUh2?=
 =?utf-8?B?Tk5XWkptNlJJaGJLS1hkUHJhSElWazVKQWZ5dFF0amFyK21nNlRUbzJ1Z2Q4?=
 =?utf-8?B?QTN3alZ4KzVCV2pXUkhYb09hYjc3dm5XQlVqN0Rjby9hN3JleWV6QzZKZ055?=
 =?utf-8?B?WWU0ZzZVOUZFQWc0aVpRNkFJQ1dkZDdCL09zSHRYN21NSEQxdTRLYjJIaThO?=
 =?utf-8?B?all2OWVlQ2RobURvYW5CV2FwYUw5RzBKL0lGeEdVWUtMQXRnbFJLcGpFS2Fh?=
 =?utf-8?B?Ynd2NUdKY1R2WndCR1FOMVlnYlQwR2ZYenBkUW45dndUQ25wTlJSaS9BZXBi?=
 =?utf-8?B?bzhLZHJycGlmOVNOQ2JuN3VvbWpUa3RXbWxuVVo4RWY1OE84RWlWTi9BQ3Nz?=
 =?utf-8?B?ZHpEa0p5NWNrdmd3dnBVQThlVUx6ay9Ec011bWFwczJxRUNucmh4Y0ZYeTFo?=
 =?utf-8?B?dVM4TFd1YzNQeVd2enpXN3c4aVI4WEZnZnpreDFVMlIzRHZ0Tkt2a2RQYmJF?=
 =?utf-8?B?RVhvMGJiL25zOGFzUkpmOXBZdEx3U2thbkRjVEpkTGJndFBJektRZUFNVlZ6?=
 =?utf-8?B?Y3JwNHJJWHU5NUc5QndwWHl2WlplMjJSWCtPY0E3Sk9pc0JneGxtc013ZHNX?=
 =?utf-8?B?czM5WkZHODFURjd0QWJOd2krd29yNS9zS0daNkI3WWJuWElVZVdkaWlhVlBY?=
 =?utf-8?B?U0crMTBadDMzVCtwMlFKNTRCWU5tanY2VTRZa3ZBeHFUYWJUU2hsdU9OQXRt?=
 =?utf-8?B?MzdSdmhWRWRnenNSNW5KZXU4cTQyWi8wUjFpd0NsdnhKVjllWnZFa1RCa3hO?=
 =?utf-8?B?cSsrNW90K044aGNMbktwM0pHVEpjYWhGSThqSHNCZEQxZmhWZVduenpPa2lX?=
 =?utf-8?B?aXN6amlZTmVwdUVPUTZZeXBxdFJuMW5zTnZaM0M5ckJzOWNsS0VaRXlXWW82?=
 =?utf-8?B?dFN1S3dQYmdxaWlGTG1xcnAwWmpQWmQ0ZS9vWHBzaFBiUUEwczUrb0x3aWF1?=
 =?utf-8?B?empXdUZvczJtbzJ5ZGx0R3Ara01hd2IvM2hMUFFQdS9lU0NNYnBUbDlBRVVB?=
 =?utf-8?B?K3k3V1kwb0pkUmlRbm1yQThyeDhiQWNCdTZ5bTgwY1A4V1lFdlFBMkwzeEh2?=
 =?utf-8?B?aThWeENuT1lFQkFlcEZ0QVdhRHVoNnNqK3BmdUxBV2xMZFZ1N1piSmRHdHVw?=
 =?utf-8?B?OWF0WEI5MEg0YVZSWUpnYWxJTFcyMCtGU3VuTlRDcEs5QjMvbVVmVEpxM2M5?=
 =?utf-8?B?VGZsenFoNXhjdS92dkdjYkwra1FKOHlhNUxSaWsxcGpzZXNWemhMNmR2eXBm?=
 =?utf-8?B?OTdPcUs0Qno5aHVSYnY3M3puY2t1eE10UFlubTM1MWtNT1VMWFRmYTFwZmNR?=
 =?utf-8?B?ajMremprVnhGQlZuTUYzYnBEMVdCV0lYUGIrZWJpRlhyanV1aW5kMTlScFla?=
 =?utf-8?B?bnM0NnB1bmlXK241R3VmZjJxY0NkcUtWNU5vVnhqTXhLOGdERzVBSXY5eUNY?=
 =?utf-8?B?cFRNYy9iZ1duKzNBNURHQUJWclkrS3dRVXlBT1lsZ1BNdmJVa3dPY2lxMzkz?=
 =?utf-8?B?RUFKYUxxclZUZjBQc00rd0xGOFhndXZ2WnRYcmJQNjNuMUlYeVRlbDJvc0Zr?=
 =?utf-8?B?VjVHT01VSWhkQTVScERzTXVubHlYdTgwN1lrdDZWZXpBVFFSMWs5di84c3VV?=
 =?utf-8?B?djBjRWJobTlDYnZQN3JlVE5OdWxGR0sxTTdpcDRncnVXUnppQUNSbFNXTE1J?=
 =?utf-8?Q?CASAFKQYbP3L1QRoODKAR/UkQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61f21001-6a0a-463f-48dd-08dc9fd129ab
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7426.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 04:39:47.9704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rTqxKv4R498i0UGc5rGFqzBQDoxKk+Nr0cmLUeko6be3X3FrXt91ULpKegbNz1FWzAXIuV924F6Eca4sDra+/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7527


On 7/3/2024 9:05 PM, Robin Murphy wrote:
> External email: Use caution opening links or attachments
>
>
> On 2024-07-01 8:49 am, Ashish Mhetre wrote:
>>
>> On 5/31/2024 2:52 PM, Ashish Mhetre wrote:
>>>
>>> On 5/24/2024 6:09 PM, Ashish Mhetre wrote:
>>>>
>>>> On 5/23/2024 7:11 PM, Robin Murphy wrote:
>>>>> External email: Use caution opening links or attachments
>>>>>
>>>>>
>>>>> On 23/05/2024 4:19 am, Ashish Mhetre wrote:
>>>>>> The current __arm_lpae_unmap() function calls dma_sync() on 
>>>>>> individual
>>>>>> PTEs after clearing them. By updating the __arm_lpae_unmap() to call
>>>>>> dma_sync() once for all cleared PTEs, the overall performance can be
>>>>>> improved 25% for large buffer sizes.
>>>>>> Below is detailed analysis of average unmap latency(in us) with and
>>>>>> without this optimization obtained by running dma_map_benchmark for
>>>>>> different buffer sizes.
>>>>>>
>>>>>> Size  Time W/O        Time With       % Improvement
>>>>>>       Optimization    Optimization
>>>>>>       (us)            (us)
>>>>>>
>>>>>> 4KB   3.0             3.1             -3.33
>>>>>> 1MB   250.3           187.9           24.93
>>>>>
>>>>> This seems highly suspect - the smallest possible block size is 2MB
>>>>> so a
>>>>> 1MB unmap should not be affected by this path at all.
>>>>>
>>>> It will be unmapped at 4KB block size, right? The 'size' passed to
>>>> __arm_lpae_unmap will be 4KB and 'pgcount' will be 256 for 1MB
>>>> buffer from iommu_pgsize() unless the IOVA and phys address met
>>>> conditions for next bigger size i.e., 2MB.
>>>>>> 2MB   493.7           368.7 25.32
>>>>>> 4MB   974.7           723.4           25.78
>>>>>
>>>>> I'm guessing this is on Tegra with the workaround to force
>>>>> everything to
>>>>> PAGE_SIZE? In the normal case a 2MB unmap should be nominally 
>>>>> *faster*
>>>>> than 4KB, since it would also be a single PTE, but with one fewer 
>>>>> level
>>>>> of table to walk to reach it. The 25% figure is rather misleading if
>>>>> it's only a mitigation of an existing erratum workaround, and the
>>>>> actual
>>>>> impact on the majority of non-broken systems is unmeasured.
>>>>>
>>>> Yes, I forgot about the workaround we have and agree that without the
>>>> workaround, 2MB unmap will be faster without this optimization. But
>>>> for any size between 4KB and 2MB, this optimization would help in
>>>> improving the unmap latencies. To verify that, I reverted the 
>>>> workaround
>>>> and again got unmap latencies using dma_map_benchmark which are as
>>>> mentioned below. We can see an improvement around 20% to 25%:
>>>>
>>>> Size          Time WO Opt(us)     Time With Opt(us)       % 
>>>> improvement
>>>> 4KB          3                                  3.1 -3.33
>>>> 64KB        18.6                            15 19.36
>>>> 128KB      35.2                            27.7 21.31
>>>> 256KB      67.6                            52.6 22.19
>>>> 512KB      128.4                          97.7 23.91
>>>> 1MB         249.9                          188.1 24.72
>>>> 2MB         67.4                             67.5 -0.15
>>>> 4MB         121.3                          121.2 0.08
>>>>
>>>>> (As an aside, I think that workaround itself is a bit broken, 
>>>>> since at
>>>>> least on Tegra234 with Cortex-A78, PAGE_SIZE could be 16KB which
>>>>> MMU-500
>>>>> doesn't support.)
>>>>>
>>>> Yes, that's true. For 16KB PAGE_SIZE, we need to fall back to 4KB
>>>> pgsize_bitmap.
>>>>>> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
>>>>>> ---
>>>>>>   drivers/iommu/io-pgtable-arm.c | 34
>>>>>> +++++++++++++++++++++++++---------
>>>>>>   1 file changed, 25 insertions(+), 9 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/iommu/io-pgtable-arm.c
>>>>>> b/drivers/iommu/io-pgtable-arm.c
>>>>>> index 3d23b924cec1..94094b711cba 100644
>>>>>> --- a/drivers/iommu/io-pgtable-arm.c
>>>>>> +++ b/drivers/iommu/io-pgtable-arm.c
>>>>>> @@ -256,13 +256,15 @@ static void
>>>>>> __arm_lpae_sync_pte(arm_lpae_iopte *ptep, int num_entries,
>>>>>>                                  sizeof(*ptep) * num_entries,
>>>>>> DMA_TO_DEVICE);
>>>>>>   }
>>>>>>
>>>>>> -static void __arm_lpae_clear_pte(arm_lpae_iopte *ptep, struct
>>>>>> io_pgtable_cfg *cfg)
>>>>>> +static void __arm_lpae_clear_pte(arm_lpae_iopte *ptep, struct
>>>>>> io_pgtable_cfg *cfg, int num_entries)
>>>>>>   {
>>>>>> +     int i;
>>>>>>
>>>>>> -     *ptep = 0;
>>>>>> +     for (i = 0; i < num_entries; i++)
>>>>>> +             ptep[i] = 0;
>>>>>>
>>>>>>       if (!cfg->coherent_walk)
>>>>>> -             __arm_lpae_sync_pte(ptep, 1, cfg);
>>>>>> +             __arm_lpae_sync_pte(ptep, num_entries, cfg);
>>>>>>   }
>>>>>>
>>>>>>   static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>>>>>> @@ -633,13 +635,25 @@ static size_t __arm_lpae_unmap(struct
>>>>>> arm_lpae_io_pgtable *data,
>>>>>>       if (size == ARM_LPAE_BLOCK_SIZE(lvl, data)) {
>>>>>>               max_entries = ARM_LPAE_PTES_PER_TABLE(data) -
>>>>>> unmap_idx_start;
>>>>>>               num_entries = min_t(int, pgcount, max_entries);
>>>>>> -
>>>>>> -             while (i < num_entries) {
>>>>>> -                     pte = READ_ONCE(*ptep);
>>>>>> +             arm_lpae_iopte *pte_flush;
>>>>>> +             int j = 0;
>>>>>> +
>>>>>> +             pte_flush = kvcalloc(num_entries, sizeof(*pte_flush),
>>>>>> GFP_ATOMIC);
>>>>>
>>>>> kvmalloc() with GFP_ATOMIC isn't valid. However, I'm not sure if 
>>>>> there
>>>>> isn't a more fundamental problem here - Rob, Boris; was it just 
>>>>> the map
>>>>> path, or would any allocation on unmap risk the GPU reclaim deadlock
>>>>> thing as well?
>>>>>
>>>> I am using kvmalloc() here to create an array which is used to store
>>>> PTEs
>>>> that are going to be flushed after clearing. If we don't store them 
>>>> then
>>>> those will be lost once cleared and we won't be able to flush them.
>>>> I tried using GFP_KERNEL instead of GFP_ATOMIC but then I am getting
>>>> warning from might_sleep().
>>>> Is there any other alternative way we can use here to store the PTEs?
>>>>> Thanks,
>>>>> Robin.
>>>>>
>>>>>> +             if (pte_flush) {
>>>>>> +                     for (j = 0; j < num_entries; j++) {
>>>>>> +                             pte_flush[j] = READ_ONCE(ptep[j]);
>>>>>> +                             if (WARN_ON(!pte_flush[j]))
>>>>>> +                                     break;
>>>>>> +                     }
>>>>>> +                     __arm_lpae_clear_pte(ptep, &iop->cfg, j);
>>>>>> +             }
>>>>>> +             while (i < (pte_flush ? j : num_entries)) {
>>>>>> +                     pte = pte_flush ? pte_flush[i] :
>>>>>> READ_ONCE(*ptep);
>>>>>>                       if (WARN_ON(!pte))
>>>>>>                               break;
>>>>>>
>>>>>> -                     __arm_lpae_clear_pte(ptep, &iop->cfg);
>>>>>> +                     if (!pte_flush)
>>>>>> +                             __arm_lpae_clear_pte(ptep, &iop->cfg,
>>>>>> 1);
>>>>>>
>>>>>>                       if (!iopte_leaf(pte, lvl, iop->fmt)) {
>>>>>>                               /* Also flush any partial walks */
>>>>>> @@ -649,10 +663,12 @@ static size_t __arm_lpae_unmap(struct
>>>>>> arm_lpae_io_pgtable *data,
>>>>>>                       } else if 
>>>>>> (!iommu_iotlb_gather_queued(gather)) {
>>>>>> io_pgtable_tlb_add_page(iop, gather,
>>>>>> iova + i * size, size);
>>>>>>                       }
>>>>>> -
>>>>>> -                     ptep++;
>>>>>> +                     if (!pte_flush)
>>>>>> +                             ptep++;
>>>>>>                       i++;
>>>>>>               }
>>>>>> +             if (pte_flush)
>>>>>> +                     kvfree(pte_flush);
>>>>>>
>>>>>>               return i * size;
>>>>>>       } else if (iopte_leaf(pte, lvl, iop->fmt)) {
>>> Hi all,
>>>
>>> Can you please provide feedback on this patch? Is this optimization
>>> worth pursuing?
>>>
>>> Thanks,
>>> Ashish Mhetre
>> Hi Robin,
>>
>> Can you please share feedback on this? Is more testing required
>> for this on non-Tegra platforms? Perhaps shall I send it as RFT ?
>> I have used 'dma_map_benchmark' available in kernel to test this.
>> Same can be used to test on other platforms.
>
> Apologies I was slightly mistaken before - I confess I was trying to
> remember how the code worked from the patch context alone, and forgot
> that this same path is actually used for clearing leaf entries all the
> way down to L3 as well as freeing tables. So yes, indeed there should be
> something to gain in general from combining the syncs for adjacent leaf
> entries. However we still have the problem that we can't put an
> unconditional allocation in here, so we'd have to do something like
> combine up to the next non-leaf entry and keep the "inline" sync for
> those. Or perhaps it might end up quite a neat compromise overall to do
> your current idea on a smaller scale, with a fixed number of PTEs that's
> reasonable to keep on the stack - even in the worst case, I'd expect to
> still get a fair boost from doing, say, 32 syncs of 2 cachelines each
> vs. 512 that touch each line multiple times.
>
> Thanks,
> Robin.

Thanks for the feedback Robin. I am thinking of going with "combining sync
up to next non-leaf entry" approach. At this point there is a very less 
chance
of encountering a non-leaf entry as we are entering this part of code after
matching size with BLOCK_SIZE.
Shall I send a new version with this update?

Thanks,
Ashish Mhetre
