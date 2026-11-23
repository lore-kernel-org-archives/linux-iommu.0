Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795422687;
	b=KG2y/rGCx5ylJ+5z65P5wBKFdzuiYld999tKasSij45dLQKEyprOm4PFcXE0yk/9tCOY
	 GKkhZFpcXznmuKiw5K+xNflN+YRn9KplmQMydBFNek0bQIHPcysFKXJWRpe31n2Cb2NSy
	 S+U6vKzYHij4dzJX8nubZke4f6ehIfE5RKIvg+tTHi6CS7myO2hOE4rZJLA3xVnI0tHuZ
	 WikBn/T8mZ2iqdEi7qgaG1Zc0nyO/Bu2dwOqxrNx4LAkqqes0gO4p9J7q+9qkDhDxL0j0
	 +yAy7qVxI5dATYxTZ8ZWRmQzpbwFwfnyeWN1Lpru2xSk9fChLVSciUwRndWu+iE59+g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795422687;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=fincf4TfjxGP9kxsw3OM1M+X2yZ3k1uSu3W1Rm1oZPQ=;
	b=JuFcHQQrGPfaEUuggQfQ3Y2D/KXZZl8e5J08VbueTO5WOqLLdv7TJqapnCdQzKqfunpx
	 K+cMHHSerDMrJzjgBWEeTbZ0DI5qC6wdMyHe5YqP8qUHuu3Dq7sFNChWs158HaOeMdjUr
	 f5OFxj1VbejhgrSSJi4dIUfVycZ5ujHwUPgsrzrVAPyq2JhC5SqlgXPaucHcMtPuDH0kz
	 i1Lf99qFi3u5xCFYyaHTFXEBCQES+fn5IJ655d37fQpljlAQHx1ZRKWjoCDlyw/sM0Cc2
	 0gCXHYxZ21H8JBR8oEvJdomjHXSEGx/Y/vWnScnKt/dICIfO4nK/RrsZJFszcA54DXQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=qWxLPWqt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.41
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012041.outbound.protection.outlook.com [52.101.43.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C4F606A32E
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 08:31:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0C4F606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=qWxLPWqt
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gjXfKG1zgAGv0jql/1tvMyKl6pOhe7HbStOlkT4OuwxPzMZ3o2s+QQOFLC9PcBRMhkttPAjtfdqeaDopwHhlGpRsGbN/v1xF7BAJ5IZuHOHm4k91HRcYOYZcoknyua7F/kty7L2J7y+zVnBEe67Cyzs05ORkljPYOFeq6nShmrN7TZHqtr2V0X00ADZ4BRxx2rmVtiOyNzr1hTxZ4k/yIBqJZlfMV8m1LXosqiR2sVNpeBZGaduJdn1q74LWy7FqvyRlhEeBYd+DdcAIshqcqHGcqnBVzgLqXevalEfpTHlmbhZFt1p6W0MnHDlW/2LEbH0hFXfBGI9/X/bauOueUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fincf4TfjxGP9kxsw3OM1M+X2yZ3k1uSu3W1Rm1oZPQ=;
 b=w6fxGe72kFOA93OoCEO0JkKVIuCHh41Vk3meEVKi0DPwWfy+q9f0+8x02tKgAuOq5I+AmG3J3DeNHttQ5C1rSbFPwQAbxej11qjc+ySgAdlmfSQuO6CN/s+wLIX4pGy1s7rwZrKPFfUekwuOtQd1zK34TNPqdEazHCv5wcIe/tq0cAS5KYjWBVg6FURB0/lt4qRLR95YzxyNhaJEJq69sQqvMCSklsBIHyA75JCiYQvVA+JK+BQiS8CFZiDrpZvASXzr+ySp6tEBLgo9m6EgchoKYhbpbnbOlWVL5VVXXO78RYIjT/Klqd2pHwyKUSQlwzzGQ0u+kwg0manKDZrlug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fincf4TfjxGP9kxsw3OM1M+X2yZ3k1uSu3W1Rm1oZPQ=;
 b=qWxLPWqt13d+STLr8KoUG024MHFJIHQgUq97deQHH3ddDUV3lWBliMd4D3KbgkWoRut9gsGXrlqz3gi+X95Mvx1aXikqYcIgJ1xK46KAf5pLrb5cHTvLshOrmPXdW+ho9oV3Hz8Jh/Vj+9ijZZmLHfwVZr6a/Y0bQbDtuqtCi4I=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by SA1PR12MB6749.namprd12.prod.outlook.com (2603:10b6:806:255::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 08:31:23 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0639.011; Mon, 23 Nov 2026
 08:31:22 +0000
Message-ID: <b10f3e85-eeea-48f6-ba79-6fe391a9e358@amd.com>
Date: Mon, 23 Nov 2026 14:01:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] iommu/amd: Honor IVINFO[PAsize] for paging domains
To: Ankit Soni <Ankit.Soni@amd.com>, iommu@lists.linux.dev
Cc: suravee.suthikulpanit@amd.com, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, linux-kernel@vger.kernel.org
References: <cover.1792156095.git.Ankit.Soni@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <cover.1792156095.git.Ankit.Soni@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0213.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ab::11) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|SA1PR12MB6749:EE_
X-MS-Office365-Filtering-Correlation-Id: f7520054-3e6b-4a9c-fe1f-08df493c2772
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|261026121527099003|261026140227099003|261022105027099003|261028144727099003|261021121427099003|261102123227099003|11063799006|56012099006|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	20Zdeb3LFKymTEcj9jxfLYWzEEjd+VSfF64h8++vj8x7P4V7hzv5n8BmcZc2XKh0MR4cb7GEimxSHMGqqx+0u02L/hfqWqSqljui1mS3zNYhXfgP+nc4/KNMUgoF8DJYVzwOpgXOxnbEYfbHhJP4Z3bIZ8Aix7FWA88hndZnR41KQtcg2EbPz90+u3PvDc8FeJopSJKvd8g0LAajOiG3SAevMBmLFTVDSnWl7N5NarYYY8xyRIrxFjtVCVWbAWFfEy+gkdA9HIjPtv26eKuxtyUPNzg2rv7hFl+5/BsHAgTR61V4FSmtjoXqOqHFJ7fR6g2wLi7zLwJaxXZCyhGATqdWd/W0efR1FAwHN1dbDm5aEjWDtbrtF9ROUMDjWxur3bd9UbtqcSv+YrMcMcVpEGmd9UydsPpDicrC3fS5ThPihnbeNpzthWWvIf0RUFX0KggTOEar5FrW3MpQHbzozp6u+EigvmfVBCJKBOexcyWGl9xSKjSgdjV6hg+nD7s3suupw3UlK6lTJKx577uqFBddnQGnIeqbaOe4rDXkCUJr8MUeWG7gFyyppJ0bp0xXPjFpdnmlJrO5HxuY3Bd5I1Z8XVzen3UtG+Kiq9gRI29iAexjXrO5swlvjIX67HUZcy7hKWhEIgSXHf7dtd1ksqxbmkVyAUS6y8twVC1W/VQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(261026121527099003)(261026140227099003)(261022105027099003)(261028144727099003)(261021121427099003)(261102123227099003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZklxOHhyMUNGUXJMNUpSOS9WN2tkNjBxbU5ocGtFVmpvMitPNG9ubVQ4Qktm?=
 =?utf-8?B?WWlzL3k3UWNiYWpFRCtvQW9KRytFRTFyUFVoNVRVR1BEQkpIeXB6NS83R2JK?=
 =?utf-8?B?c2VSU0gyNHphajBYbitweFNnOHJjS0lSakZPY0tlK0NEK2dOdFdGL1paMitt?=
 =?utf-8?B?aEdFblo4MnRWbEdUc09qUGE2Y3VET2d4MGttYUM2WGkwQ2VKSVZwSkRTbEIv?=
 =?utf-8?B?K2R5T0p5UzRFenJVSUpyNGtoa1JWeS9BMlJ4a2gyNEhXRHQ1T3EzRTQ2NnB6?=
 =?utf-8?B?VWhOUzRpdHF5RndpdURJMElBOU9yNnRFMEdkV3pJUU9ZNVFGRmNwR1ZITEM4?=
 =?utf-8?B?Zm5KZE9zM3h4V0Y3K29DQVhJZjFIYWd6SDA2S2JpeXlwVktDWHdTVHUreTBY?=
 =?utf-8?B?WnpWZW5Eb05TWWZEMXhHSi96eENpemNpbUtUVCtCcktUZzBHb0RrN1UxNEdV?=
 =?utf-8?B?RXp4cTZZV1Z6aWMxZytxOHluSnNJMjZlNTA2NG01YWhCN2luUldPZWVnYTBi?=
 =?utf-8?B?NFNJbFN4VThJa2FPOVR0VkVIdGlHTW9WRjlOZGFNREtSVHdzSkF6eDMrZ0FR?=
 =?utf-8?B?NG9pUy9KSE1xTDJrLzd2WFBqN1BZTGlVL0h5ZEhIbk1HQnBkZ3VHeEN3dE1M?=
 =?utf-8?B?OVdNUHJrLzEvalNlRm11TkI4dXQ1RXVlZXdxQUNFQjBkNTUwM3J1T3dXWkpz?=
 =?utf-8?B?Kyt4LzZmbEZnMmhsWGV3a2Q4QWdpdlNyR3o5Unl2a3c4TUQwK2NvWVJZem5h?=
 =?utf-8?B?Q2RCZkdrdzFTZmY0UStOY2VSM205TmZLNnVhNXBwYWpwcmFSR1VvblEzTzlS?=
 =?utf-8?B?TnRoVWNkV0JkU0JJczNBV2NpUGNOQzJUTFlrUFVZZFRpQTJCRmNDcjEwNncw?=
 =?utf-8?B?OWtRQWFoMkh6S0JUR2sycTRGREw3amlNUGYwdkdFNWNVVldSNXBXZkRUUVd0?=
 =?utf-8?B?VmVqdnZTRFZRbXJSZW4rRG5RSTFOeUpUdUhpYXlqNGk5TjBzN3NuUmdVdEdN?=
 =?utf-8?B?a1REeVlUK245YlZuTnFjb0FFVlBCZVVDUk0zdTZEM1UxbWwzdXlDbklRbU1z?=
 =?utf-8?B?c1I1M2dKWTg0L0I2Z3RZNDB0dVVYWlFlVnk3WTBaVEN0WjZSQ25NY3R6TTJt?=
 =?utf-8?B?OWFYSDczUEd6cTBOTUJSTHF6bm9QaCsrK1JKNVdrcktsaTdCcVZjWWlaL3ZR?=
 =?utf-8?B?OGlkd25CM0cxN1lRRHo1UXJhcGZ1WS93VVpETlZYVDd5ZEd0K3RVTTlvaGdl?=
 =?utf-8?B?dVFoeTJnYVMyMXdRZ3BkekFPOFlCaVNjYkUxdU9WeXppMmo1Z2kzbDlZeDg5?=
 =?utf-8?B?ZHFQUldiTkRTaXdDTkwxRm92ZXVNbzhrMHBTSHNid1VObHBrSDNCbWMyQTZ0?=
 =?utf-8?B?THY3WWU4ZUZ2L0JKckxIeS9NVWFGYnBQOXRGZVEyWCtxT1hKaWxhWTlHeG9t?=
 =?utf-8?B?M2o2dnJUNzRtZGRTMk4xWFc3OWlRTk1nU0o2bWFYKzRYTnNQV0dOd21VSnU0?=
 =?utf-8?B?TGFmZ3pURlNscCtudVBQQTlONDdNM1RyRCs5Q3pCOVJvV1BIMkNFSWR6QXQ3?=
 =?utf-8?B?QVhQaXQ5eko0RGZJdnd6OHVXR0E1ZE1odXFsd2R1RjRzMUc5OVlxb2FTSzZi?=
 =?utf-8?B?THp1cGoxd2tZemMwTDhvcFprRTRPVFFvUjNUQmh0L1ZFL0QzL3JtT2ZDaEsw?=
 =?utf-8?B?bDdwVEtOUjU4Ri96dzJPTjkyeTdrUU9RRFJxNE5nak1kRm9oeUF4R3ZWaVNj?=
 =?utf-8?B?b28zck5HcCtkWWNOVjhLMUh6UHdkc0RiSjFnYzJqK3oxdDIrR1hpdk93Q0lj?=
 =?utf-8?B?cUhJY0Fxb2FQTkg1aUpwcW5FNTJlTXR2c3hVbFJuK2hvRlQ0L2VnZ3ErcXpD?=
 =?utf-8?B?ZEI0M05XLzdlRHNGaXl5T2g3d202NUl6RGdVSURYbUNqNmU4cU5TQlV6azcy?=
 =?utf-8?B?T09hUGZnSDBHVkVILzJrQlc5bTVMamtOWTgrTzFUa1YvbHhQMjZwOUtPZUo5?=
 =?utf-8?B?L2RDaEVlbENMbTd0ZEVLUFlGZmxYYkdCYUJzaFp6KzQ1Nk1INlV1d2RqaEU5?=
 =?utf-8?B?b0JZZHBqSnZJUVpxUWNkQ3E3Szd2Y1J2K1ppcTkrUUJlVzJFa1k4QTA0L2lr?=
 =?utf-8?B?b1FBbmdrMkhMakRpdG82U1FES2swR1VYeWpoWFBmY28xZ0VSNlI4cWkrS3RR?=
 =?utf-8?B?QnNjcWVkZkdIUERUZmxIa082Vk5Pckx2OE01bHU2ZGxDRWR6STNRNzN4ZHdF?=
 =?utf-8?B?d3RwSzB4bnhCZzVBSnByM2JDQUhVNDRqT08zT05ieVJWam5aT3I2S0JWNWt6?=
 =?utf-8?Q?egmBN/NLDQ2Rl+Fyvd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7520054-3e6b-4a9c-fe1f-08df493c2772
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 08:31:22.3100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DBFYdfK/7kateAMD6p1w13IEMcIHYnpU8Cvj0uK3GnluWja55n08w2RF8l7n4vf3jUTds7+Ajc7S19wHCtsa8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6749



On 10/19/2026 6:38 PM, Ankit Soni wrote:
> The AMD IOMMU driver hardcodes a 52-bit output address size when it
> creates paging domains. This series honors the PAsize reported in ACPI
> IVRS IVinfo instead, so maps cannot exceed what firmware or a VM
> advertises. Patch 1 moves page-table setup into init_pgtable_params()
> after the IVHD walk, with no functional change intended. Patch 2 uses that
> helper for PAsize and applies it to paging domains.

Applied, thanks!

-Vasant

