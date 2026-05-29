Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010006.outbound.protection.outlook.com [52.101.61.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570CA1427A
	for <iommu@lists.linux.dev>; Fri, 29 May 2026 04:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780029026; cv=fail; b=DtzHa4P/2WIQOP/uD5CL08wsHJ8UUw2XOEzCBEJpKbfTkQzQwhzaOwn6AmbMDDHVbRpP3znqdSSyL78P9YkNdVp9QkMUcQGi0xTTwCtkF/UCcn1kBl5iFUgELnVanP+mN0uBFmSzs3hcMzxfNetK1q8ApndoVba+99b/zYLyvEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780029026; c=relaxed/simple;
	bh=OTsrWKZeMXlqbfyzMNGoTXANHXVbfiCZTxhaKVxGH58=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ofxPWn7nFcVklR9zrUFWTJwXixTTlEsJTcmeOC+4mz5kkLUNO2bTS3TLCt5MKg7UngGUyPPjIZbQ9gIc1yAmQXpCys0Tu/dZuKaWlxyAmsO8HXFNGt0o8LJlCsh/mN16TjFBN3yYk/walS2lp7N3J8fdmlkfKilEKGEvapvWDeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MkUOOcrD; arc=fail smtp.client-ip=52.101.61.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MkUOOcrD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HNP0dEQj8psubYUKmcecDUMZdYoY0mWwevyvQGSxlTWR7xtTeqw5DeyAIDNSGYPiNUPRi5/C+9JqHegGRUTb4fauac5vNYUqtCAAtTBsIVUMoWCFPSmJZYAIGToxiDnRnwnuB+ADUmMzo5rvRQWQoYs2LtLB46mQpIrwsZ81yjUvll6L0pXBJslGB7jl7DINkcy4+tT7FXsyaI2y+tVuUDXNK/sH9AP7dDagPaI2YgxXD9kD8tk+GMxcz69XBICBBZplj5X+SwLrT3CH4nmitOzkl+9yFEOdWPb+dM0mc8uqeNrFB8SBu4kJaA3QuieW2umiGzWT+ZnuhihQBzm1ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IRtgM4tikRn8QbTkkp6aE/35TslnQr24nnKiVtgjaFw=;
 b=PdmcSGKAHnpXe0rjSA9aSUebjT0MGnEr7eMuRCf2jKxvglivZ+AkqJ3O4aty2YYyBKN3xoRovtiCPe9aMnupGQaiD7+nTkpe9g5shcnbQBWgCsZaCyy1SK58opKvl6kAryEgFlQ/j0lSLSc3DTsLrSQWqyZ2lgdsoa1MiB/ioyltaKo1P0NdAjnRPOr4gt9XdRH8H72v/fsNPECUeasmrXHHiX0No1AL71bqEy2Uk48d6NQkgwbT2RycVqxPE414T1JolgTYkWPN29+Aek4OenL4nYTZlKktji7fJRNx03jVBEhYBwY/WwI5TEvkrohOhIeTfIQPwLCYXI8ZyNJmLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IRtgM4tikRn8QbTkkp6aE/35TslnQr24nnKiVtgjaFw=;
 b=MkUOOcrDk7BYXvJUdq2tI3NAl9QXftIFhV4fGLL/qy9dUUkUhFtOc7rCF9UVEl9JQi0ygxyVTdVx1DqINZnVT+Xm98eAR+wLTrS3D7eyYhDXyPCWHZgUh3sy/C4xaGCVcj8VUGh2fVlChnJXs5VWF4TFCw7cPgLWSASXICqmdqE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) by
 DS4PR12MB9771.namprd12.prod.outlook.com (2603:10b6:8:29b::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.12; Fri, 29 May 2026 04:30:20 +0000
Received: from DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e]) by DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e%3]) with mapi id 15.21.0071.010; Fri, 29 May 2026
 04:30:20 +0000
Message-ID: <52ea7085-d4d1-4af0-86d1-6f832ffe5e93@amd.com>
Date: Fri, 29 May 2026 10:00:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] iommu/amd: Fix false positive in SB IOAPIC IVRS
 validation
To: Wei Wang <wei.w.wang@hotmail.com>, joro@8bytes.org,
 suravee.suthikulpanit@amd.com, will@kernel.org, robin.murphy@arm.com,
 thomas.lendacky@amd.com, aik@amd.com, jgg@nvidia.com, kevin.tian@intel.com,
 xuyongwei@open-hieco.net
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <SI2PR01MB4393DCD4BF7E79CB63066D16DC5DA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <SI2PR01MB43933B2373A4FB93FF5CD5D5DC5DA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <SI2PR01MB43933B2373A4FB93FF5CD5D5DC5DA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0058.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:270::15) To DS7PR12MB5766.namprd12.prod.outlook.com
 (2603:10b6:8:75::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5766:EE_|DS4PR12MB9771:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f64d871-f510-46f2-cf66-08debd3afdf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|921020|18002099003|22082099003|3023799007|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	SarV4Qo1jhF7RTNLeZBObI5jUERfvzvsqGpaK/6PaRPdP+vV08O31/kSQwsGa0mN77vQZWNBeKC+AFbnvTrKixuV5T8ZgyYHzPbuGtcjnj87A9Na1/3Lj2wG9rAv/o7XWa1hio8DKjrtuJuki4TOQVTc7a55Q9OOvAoYMokXXpkHBDWlFf6Q0Dte5B+KjlKsW603ljal3DmhgKU6OKVG5HCo0C8MdJmxzatNEolBOLFk0sOfJMNyjpmVItqPt+01KhISkRGcv7sszl+/2zv9bL+yfj4uBy3sdIihMepipjHP39gRAWOzA8Kkvsge8CtLk5xNDRGpZRPl7Ffqhm/CuDfpkOHSg3agqzUhcVVwBb1w33AYcZTARi1oNN43cXJGCGC5t7kGXjB48Eie40W5idG1t1ikF7620PkbeMQzrKqcyjgqWs491DwZg+SQRB0aiIxhEEyZ3oGKKZDEJt+fYoWrqfFkouz7qdO56Tvl7MKrwOYtlVF4ctk2/rzhnzy7sYB0vqbEpDWVdUKVa+3WUvBdVKD+eFQTgH0SJW6cHTOew847BBgPrVcJwxQ/yJbvXtZ1ZNSsiWLmFrU+SzL62jlFjBiz10Oqx9Jc1P5jME1iidV6+RXiGBUmiZ+/2Iy/Thhv4h4Rh4uFVh1iVkCAbS0bJZ5KuPfL2Aia0kxVirSBz1y+Ovf6GOlS9SGschhwI4kU33UQOJMB22deZmHrsmXsv+zoXr09pHfDMyAh4BA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(921020)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHlTM2N4UTE1djZaUTY3ZDRSRUNhZjY5MnFPdmc4dnZBY09yNU1PWUp5dHVT?=
 =?utf-8?B?azhqRlYwMzQvclNUK2k3elB0RklEbDU2SjcyKzduOW83cHpPbDNYME9SbllC?=
 =?utf-8?B?aHBaT0lFNkZreGhLNHMwNFhrVjhuK2pINTJyNXl4ZmJKcHBTNnRWbldWakp5?=
 =?utf-8?B?V1FIQytvbjRuczVVWkhxL1ArT2dSRDJ0dmYybTZQbGViekZaT3poVE84K3FX?=
 =?utf-8?B?UDJ3ZnpMRWplODYrZkpnSE9pRkxselNKRWJFcExxMnA4T3dobVcvU3NqQmxX?=
 =?utf-8?B?ZTQ0ZHBBOFNEMUVRNkxjc1UxZ2s4R2Y1d2VyU0x1V3ArNHBoUWZzOVVKYStG?=
 =?utf-8?B?SXo0L21ENjlsUWF5N1NUM21hbk9sTTRnUHh2dGZFR25ZMjJiR0lHTE5VSzNj?=
 =?utf-8?B?Y1FQY3RRVWpObFBRZmRZM054OGtCZmFjTUJLYUJpVFRrdzhzREdkQ1FoOEZu?=
 =?utf-8?B?NzBkeWt5UTNpYkRFWGxOWkhGYTZQSUIzT0gyOU9jMnI3eWw2UnI1OFFveWZG?=
 =?utf-8?B?VC83WnFvY05qdlU3TUMvWmVGNU5qZ2I4ZURILzJNemk4L2VJV1B1VVdGdno0?=
 =?utf-8?B?ODQySzVNc3E3dk4yZjBTQUM0bnVJZTNCRVNIZmtYaGE4eTRlUVUzR3cwTUkx?=
 =?utf-8?B?b0pGOHltOHFRNFFFWXBjaVFieU1ZRTY1aFRXenBxYk5sVmE4aE5YVDVEZHln?=
 =?utf-8?B?dkwwcGs1ZGNZMUtscXh4R2FJVEQyQkU0cDVWQVUwZVNPa0tYbndrdkNTWjlR?=
 =?utf-8?B?T3AxdmRNY0hrLzJJSkF4bnhMdm1SU3RLS0RBSnpJaXVFaDRMZ0M5RUF1Yjh0?=
 =?utf-8?B?MWtScHhMTUFHNmM4ckZ0cXBrOTUrUGZyQWVpRDJGcmwzSXNORHhaT2diVUdi?=
 =?utf-8?B?WDI4MTZyVjZvcVpjbERiVFlnM2lReXZWd2c0MGxuOUhtREp3UlRtUnJGWXVK?=
 =?utf-8?B?ZVFraGZkVEIzNzMyUklVZzZDOWp6UDNhaTlsd2xVYzRhaFQwNzMrVU40cm8r?=
 =?utf-8?B?ODE3TlVTOW5rVEVTcStWeExmM3hUM2xEQlBrWWxBeEo2V2RUS2RkMkdtNXlo?=
 =?utf-8?B?SWNUVmt2V0QxejYwVzZ5cmc2b1RWVSt6d3dLWjAxZERySURVSkU2WWF5YUpC?=
 =?utf-8?B?SlpTVVUxdm1oSFovZVNvb2tsNzZBeENFYTA1djdFZElCTkdDOHd1WVU0K0lD?=
 =?utf-8?B?VjJlYjRoTktSRE1OZWF5c1dEb2VpOGFLRVpwaitsUjJDSHduMjBHS1BjL3BL?=
 =?utf-8?B?WWZlTzYyZmhObUM3SUdxeStoc1ZSeXJxRlI3MkpMMm1SbFYvWDdSeUZuNGlw?=
 =?utf-8?B?dTk1bXlldmFNdnBxS01WMGpuekFVaEZvTlg2eW1mZjJ1VHN0SUd4eE1JbDQ4?=
 =?utf-8?B?blVaQjlLL3Bqdk5RQi9zdFM1dlJaZEhiNmowd3d0elUvb2loQXJZQmI2Zkl5?=
 =?utf-8?B?a3FzN290UUlkTmNxeUtMZ2NJUkVMdlZYbER6SmVoUTlMYWQ2RXBWZXVXZTUw?=
 =?utf-8?B?WTgwL0wyVkZhaC9YOEd5VWdRcDIxM0xmUjBNSkVDYk94V2x4V1JUaUpTTTNs?=
 =?utf-8?B?ZElzckFwdWtOb3BVMzc4bURnWjdmbmJJUzNyLzBySG84QmVYVmZCOGwveHpR?=
 =?utf-8?B?ZkZ2ZVZSOElNV2ZKMzh4bHJ4dmhrRnpMTGJnRmpqMzJHZDJtZ3VIVkhEUTBl?=
 =?utf-8?B?UWhhSjJyMWFGYWtQZmpsVEdmK1V1S0NaUDVaQmR0Q2pzR3d4ZFJJTnZFdEEw?=
 =?utf-8?B?OSs4dWRsK0MvaUREOU9vTW04blhZWHRYbXlwazZwWituOC9vbkpRZHl6MTY3?=
 =?utf-8?B?N3JzQ0NQMWdaUThPQS9TOU54WWswRlVOSytiZldYbnJMMzZCRUU0aUZjTjQ1?=
 =?utf-8?B?NWFqTTFRUDFmQUhnUHdUb3ordlNTNUswa0paVCtnZTNUaVBUWVlhUTg4NDEy?=
 =?utf-8?B?QlVVeTNLeHVtWm5mSWgyL1duZEVPcXdtSUtiSmlJdytTVE02UFE4NnVEZ1BJ?=
 =?utf-8?B?UGxpMWhFNVVxNEgwNGlKUVlFamJOck1vVSsxaTdvM1ZUaXpsQ2l1WWxHWVJ5?=
 =?utf-8?B?SXZaamhUWkdRVktTNjE1QWxYcnErVkpSNXRkY3g4T1NhbUJSNXRUenBxWmpV?=
 =?utf-8?B?NlY1TitvSDJnbVdsVHdjWFIyZFFiR29ISUE0RVUyR2JLeUJjenhlb2xTSndt?=
 =?utf-8?B?aVFhY0pDUTcvOXN4MGptcGZ3MWFpU1NoYnQ5ejlzZnd5RjZFVndIdEdid3Fi?=
 =?utf-8?B?dGttcmNpOEsvMXRGM3BXNm1NMGNrcWxVR2lSZG80MTIvMFRmaDNQeHUwYzRV?=
 =?utf-8?B?MmZ2SUtmQmlzVmxvY3BZZTNtM3gvUkFxWFlNQ3hYYk0xVjR1bWRMZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f64d871-f510-46f2-cf66-08debd3afdf9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 04:30:20.3545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xJOyUJgs4JiZYzCj9VMnKs24PT+KZ0MM+2LqMW8HJ67J/8pXjY+K9jHy2RLbjrGQFiTQ+E4uTHrEnEF/58OAGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9771



On 4/6/2026 9:10 PM, Wei Wang wrote:
> The check_ioapic_information() function is designed to prevent boot hangs
> by ensuring the Southbridge (SB) IOAPIC is properly mapped in the IVRS
> table before enabling Interrupt Remapping.
> 
> Currently, this check passes if *any* enumerated IOAPIC matches the
> expected SB IOAPIC device ID. If a buggy BIOS assigns IOAPIC_SB_DEVID
> (00:14.0) to a non-SB IOAPIC entry in the IVRS, while the actual SB IOAPIC
> (APIC ID that owns GSI 0) gets a different or wrong devid, the check hits
> a false positive and succeeds.
> 
> This erroneously enables Interrupt Remapping. Consequently, the IOMMU
> blocks unmapped interrupts from the actual SB IOAPIC, dropping the system
> timer and leading to a silent kernel boot hang.
> 
> Tighten the validation to verify the device ID specifically against the SB
> IOAPIC by matching their APIC IDs first. This prevents the validation
> check from being bypassed via device ID aliasing.
> 
> Fixes: c2ff5cf5294b ("iommu/amd: Work around wrong IOAPIC device-id in IVRS table")
> Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>


Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>


-Vasant



