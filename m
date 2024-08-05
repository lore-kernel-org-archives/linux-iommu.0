Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2042.outbound.protection.outlook.com [40.107.101.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C7A55887
	for <iommu@lists.linux.dev>; Mon,  5 Aug 2024 04:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722831915; cv=fail; b=RnxofQe8F7Q6UyTYPu4bJj0AhQBj0OoifMyTNKvOns8mlM33GuFPrAN6vWlm8vvK0Nlugvh18t+KZlTA8IHK+5KEFzYUP4p7z/pVKt9FULpTSp2uoxvVVjbRqbLjKKerN3k4dNdJuYeFxSgubTx2dN6jmnd9Q5BXCS6YhLlSeNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722831915; c=relaxed/simple;
	bh=ROXdxgbiHyDB1LeuM7o56XXw8qIZCQzEZmX4ogyENnM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f74bmBfSNDOfn6YoOs7mJpQIWe7qO8llw3W3wkeZ9cJDoW607d8GZVeSrk09wvg6j6hB52476p7KtYiSj/ZIok41g0nD6tj21IDvf3lBGJIt4O+5FeKSOcA5FuDCx1fYXkqpVol5LP4bhoLJJb0WB4y9OL8T/Sih6m4QirC+7mk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZsHD7+qE; arc=fail smtp.client-ip=40.107.101.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZsHD7+qE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZbbU9EyldfejMHG5n45U3AGvBhCMB2+MKoLeksDdhxLjwYFMA8j+Vu+RprJS5Ag5w8oE1msBeRfimCP4uYKa4j2oDvarvy6dWf3r3QRjHqC5XZuHDXs0RPdrxkMHSvRYoxBObBllXgyPd4rmdnVAiG8JNd1c/KK2JpT4ZJ9jwjnMFZ4XZbj4NYE6YRkNZYLuPAFWCeniyZ39QOATyNj3LScodJKjCgu4Lj+CpC9fsNFjJAlgtMpHrodP2QK6N9ik99fRpmXcV88jCzDpiXL5iRLdyBS+HHJg0Z7p/NPyfh+KEnyxrEGxV2yuJI6vLs/x3ETjcQHip83JVihEqwJSWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MbWnz7675/hcWRY7Zuj1hh+NKQdvmZBAZndWGoIVYWo=;
 b=cshT3gYDNh8Yn0eTG9nEDCprCroRJUjY0YVqZ64M/Xc7UYX6HggcaWdsSHjSG2+Vq+2EZ8GTz7xJb7gNVpv9yxVpAwgEbWb5rebi1hTuVOAdjSD6wwzY7guRaFaZSHIHaa1MtsgjIRGT4HqW3QNsah6YAw1JG5urR6VQwoyTkik51uuQHa8sOAdbOicafS1fBj558UpoojNzFIaFv5c9nie3bF7vRlQF0tBRZHNtUtBIV9iVwxjIqn9SDDLyBih/VswMlRo//qBXu04E916Hi1NEF9HXf8zmFEh5OIJ+ItUL9clBsQOBkjCbB+24dsGVsdYD2IZHXzea0LlAB3Amtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MbWnz7675/hcWRY7Zuj1hh+NKQdvmZBAZndWGoIVYWo=;
 b=ZsHD7+qEO+h5VBRdIce3MFnFJFMshrRRDJgoKUrcvCk3lV8oehgTK/tpkf2Jh8ENgBaMPcuwl++EA51/KP5e4nib3IaxGiprZNNOECX1lHzcfwvaP0ry4Zr8wQtUyx1CQ2U4MuizTX1LjXPY3ixIPvJ0ilTnoKjGBY/CEfAxNnrAX4gMU+oVTtKR/XXZgDpNcyeSo5z1MSLhwDJ0d0ldNqfypbegV6Hey4T41dFxhZqyDI/60dOSFeeveFMu7KDOjto1nmJLQnNReQ8HKtqCODz/OhmYxOLbZq+z9UTd8+eliZncsvYSiRZG3gaFvVckIjMRLyGlHpw0RxLx7jWv9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL3PR12MB9052.namprd12.prod.outlook.com (2603:10b6:208:3bb::14)
 by LV2PR12MB5989.namprd12.prod.outlook.com (2603:10b6:408:171::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Mon, 5 Aug
 2024 04:25:08 +0000
Received: from BL3PR12MB9052.namprd12.prod.outlook.com
 ([fe80::d7e1:595e:d907:90d3]) by BL3PR12MB9052.namprd12.prod.outlook.com
 ([fe80::d7e1:595e:d907:90d3%6]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 04:25:08 +0000
Message-ID: <deda486f-8d1c-4990-9636-d267831247bd@nvidia.com>
Date: Mon, 5 Aug 2024 09:55:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] include: linux: Update gather only if it's not
 NULL
To: Robin Murphy <robin.murphy@arm.com>, will@kernel.org, joro@8bytes.org
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20240801033432.106837-1-amhetre@nvidia.com>
 <20240801033432.106837-2-amhetre@nvidia.com>
 <6cb4e7db-4ac0-43b4-a823-7d230ff3438b@arm.com>
Content-Language: en-US
From: Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <6cb4e7db-4ac0-43b4-a823-7d230ff3438b@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0185.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::12) To BL3PR12MB9052.namprd12.prod.outlook.com
 (2603:10b6:208:3bb::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB9052:EE_|LV2PR12MB5989:EE_
X-MS-Office365-Filtering-Correlation-Id: bd862dd0-dcba-4c9f-4092-08dcb50696a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?akNQejhuZFFDaW4wNjV1bzJIc3c1VW83SDZJeHV6K1p2emR1ZnJaekQ0YVB3?=
 =?utf-8?B?WWxvT1Jka0tPdnlGOUhtTDFtT3l2ajFIZWRLZGpOOTczT05OR2I0b1lCYkph?=
 =?utf-8?B?aXFLa1N2dS90S1dVeDVqMXBJY1hINk5iSUswejl4Z0tBRkMyNGZmQ3N2Z1FO?=
 =?utf-8?B?N1g4VkJicXorMjluYVVZV2JKdEd2WjlBRHJ5TUxxNFd0MVdLZEhaOVJhOWMr?=
 =?utf-8?B?bFNhZXZTbTVMdHRnOFIwTnZ5MEF1WEF5cGxmUU44VDlscUcvTkYyaEgzVkVo?=
 =?utf-8?B?SUpwZlh3N0k0dVBHNmQ3V2NuNHBVaFByWm5BSFhOcW1xeGZxejBoMVUxaDZC?=
 =?utf-8?B?bHFRRHJRV1FNQUR0QlcxRk5QU2w0cGVzVzFwQXFiVFhUeSsxOVcxdk1yNGFu?=
 =?utf-8?B?OTc3VjNNSTNZc216Zk1IT2RraHpvWVlPNWV5eXNzSFlpczdGT3RNdks3ME5t?=
 =?utf-8?B?Si9kSjR2aVhlY2dXQUk5NmU1elBUalQxRit3dlJhWFZnMThzSW1tQ1JsT04r?=
 =?utf-8?B?QXFjVHBJNkwrQ0lGaVRScGlWRzZGMjI5UlR0SDNWQ2g5Y3JiNFZsVWVpNlZH?=
 =?utf-8?B?Z3d1RHgyUmFZK1dTNDk1TzFwOW8wZ3pocndzeEZoUHNsbGlSWk8vTEVmMnBt?=
 =?utf-8?B?Uy9IUnprT2xSSGxOZFpQbksxdGpXR2hXbURXOXc2SXNhejRjbENYS21LSGlI?=
 =?utf-8?B?amZKbWtPYm5UbUk1THF3QUhONUp1TzhKWDdCOHVGdjhKWm9RbURCWHBKRUlt?=
 =?utf-8?B?QXNYdWJVSzdjanJHYm9kY3dTbGQ0aTdkTTN3VkZPbEJVcnQzdXZjRjBISzN0?=
 =?utf-8?B?a1FwUjFWUzErczFxQnB0WlBsUytmVFJjRUdiNFBGeFcrNU5xRzZwSWVIL2I0?=
 =?utf-8?B?RTBZdzgwNStNdVN5WWNoYThYZU8wdUNtand3SGhpQ01waE9mbUxVeDlOSmdJ?=
 =?utf-8?B?Tk5CNWxaazk2Nk1kTUFMRzNyU2UwTENYMHBOU0dXM1ovVjYvVGNYNVZIS29u?=
 =?utf-8?B?NnJyYlhuUVpJMU5HUlBiblRjQjlaTDN2eHFOK3RQc21IeDQyMkgwM0t2Rk9t?=
 =?utf-8?B?T3RzajJMUytZQjRVbytXRmtIWjJNS3FRLzRXalVBVy9jS2Yrd1J6Yjl5aWd1?=
 =?utf-8?B?amFwSUoyaTFDQVN3VVdwZUFKRk5GZ3MyM3YvNHFvemo0WEp4NllBS0cwYVpa?=
 =?utf-8?B?K2h1ZVI1VkNSaC8vL2lPa3dMVEk4a2ZaUzBIVXVyL2tyUVJWL0pWRTZuWDhj?=
 =?utf-8?B?OHBYc0Y3T1JWY0NsQm8wMVN1SVRwU21wTlFyRzNpZk9yaXRaRU5mc1lSeGpC?=
 =?utf-8?B?Z2U2ZWFuclVXWGxxbkNsS1dBblRCVEpnYmFLays4ZnVDQWp6ak4xTHpxNlhr?=
 =?utf-8?B?aXNGNUJDcmVOUE9iMGZGZ0V4TThVbWtVTzc2L3RvSTRZb3ZEQ3kzWkdVd21D?=
 =?utf-8?B?bGk1eTJrWXNJRktQVUg1SDY0ZTUxblBPOU01My95UnhLZ0dGOTJ3anVrWjlt?=
 =?utf-8?B?dVovVW1iTG1kamt1Q2JJbEQ1bjVieFJQZFlJa0IxNjVwN0RsRnZLSSt3VWhk?=
 =?utf-8?B?bEVjSzNibWRVTHdVZlZKc2E0THpZSk5ERk1neDZUcVlxQVpmNUZmbEd6UDR0?=
 =?utf-8?B?MDJrQ2pacEhXUDZnL3l5bzNQQnNuNXhXLzJkejQrVS9UMW1sV2pHdHdaYjl4?=
 =?utf-8?B?OUZKVm50dGJnZ1lEenAzQWRTK1gvNDJLS3Rld3EzM3VuMkJ1VENVZHJOV1Rs?=
 =?utf-8?B?Ulkzb2hrUW1vOHR4T2E3MUd0dytDdXZBQVFGMEt4QzVrRDVYT2tGMVhlRGNH?=
 =?utf-8?B?clNNT2FycTdNaFJDV2c1UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB9052.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NU5ucHduelFLaDhvV05xeGJETmJNelpVQVFKR0Z2RXVDVU9ibjhaVjhwTEt1?=
 =?utf-8?B?UTZXdFk1eGNsR0VEUURHTnFUVTZObkZhZWVWekRucmFsQ2s0RjJlQ3VTbG1p?=
 =?utf-8?B?ZUU1MFNKamljTkdVd09WUS91UjFFWXdlaldtNTMrOWg5NEt6Znd2TExza2Nu?=
 =?utf-8?B?NzMySjh0VWFUaDlOOCtYOXhFS2w0aEh2ekNlOXluUDcrMHJ5cytUS3Qvamha?=
 =?utf-8?B?UEM4RFA3d3ZnWlVsdVIwYXFmR0kzUWszeHRKL2NqNDVnSnlHS3VmK2Z6L2h3?=
 =?utf-8?B?a2xBMk4xTHBMTUZURVFiZnNkQjNHV2luRTlmcGtEdEZhN2pkQmE0L1pXVWtx?=
 =?utf-8?B?WWk0dERDWjVsWTUwVnBnaWpieis3WnpsNHdRU1QrVmU4eXQ0SytRNXdMcUlG?=
 =?utf-8?B?bXZ5Y3hxc1VlTEowSUdyeWxVZmRreW5Wd0xQaUpjUHRwbU9Oclpqb2dOSkt4?=
 =?utf-8?B?cnR2MzhSbGFMd0xwcTB5ZlU2TGdFZHhiZG9WRmhBWlRmNm05eWxMaWxVckpF?=
 =?utf-8?B?a2NTVnI3bVA4N2JEVlpQSWhSUk0rL3VydWxPOG1GMW1PTXNQcHMzWnVKMW1L?=
 =?utf-8?B?SmFLK3REVGRhZ0czdFJHMzhBQ1k5a0taMHpDN1gvNlJjUnkveGdadFp1QUov?=
 =?utf-8?B?VFg5Z3QyWXEzUHUvczFEcnB4OFVMTWdJZmZLZElyV0ZsRXJIVE40WlQ0Q00y?=
 =?utf-8?B?RnJobFV0TnVLaTFRTkFqU2xUZ3N2VnB4Z0h4NVZqSHlrNCs3TmZweG9CQmxr?=
 =?utf-8?B?QmVBVWhrNHZXSms4SHpZLy9TWXNyR3lBM3NzRGZwK2JKMHNaNWhxMjA0S1Y0?=
 =?utf-8?B?bnZIaDRmM1Q3NkFSMVBKeDJlYzNnR0RGY2YwSXp4bDdzL3lTeGY1YjdjZjBD?=
 =?utf-8?B?N3dTMmVtd2cwM240UWdKdWVaSzZPYmc0NWRVSEh1cHpSK1pUMGU1amthVEpa?=
 =?utf-8?B?ZWlZQ2xTQkc3UTVQRm9qUG1iQ1Z3QVg4WU5Xcjd6Rm82TWJFVXJaZlVYUUty?=
 =?utf-8?B?R2pSR25IWUhNYm5Dd0pLR3gxRmtRSjNtQVB1Z2ZXTFc3cHNWcXBYT0NCNDA2?=
 =?utf-8?B?a3ErZC9KTERnS2pQWXEvc3ZvQ1RtdE1LbThDU3NyYmd0ZHJnbkhVWFV2TkU4?=
 =?utf-8?B?TloyUEpGWlZ4SVE3YjZ2aGtFMGQyMXRoU3hhRjJlWDJSSkFLSzU2VFBSdlN0?=
 =?utf-8?B?N253WUxsYlhidDk0TTFyT2hlRGFuVnU4dm1zdEtScWhGNHZGNk0vR2ZNd01X?=
 =?utf-8?B?ZTVTMlQyVlI3SGNpTnZrWktNZHFuUEJwdlVoTlpYc3VHQUc4aW9abHA4QzVI?=
 =?utf-8?B?dUVuL0VMb1RzYXZLZ2FzRGIrM2ZZK1Y0NklMazBBcWk4cjFhdmNwWEUrbWhH?=
 =?utf-8?B?WFdINm9zN3d5RFNnUzdtUXFVWm5HM3JBZ0tYTmVubFEwWVg1dFRxTFNTR25M?=
 =?utf-8?B?bjdVRDB6c3grMjJyTkFsWVNEemlOVjlqVUpQUGNZckVyL1RjMWNEMWczZFBX?=
 =?utf-8?B?YWcrN05nK2lnR04vSVl3RnYrSHFDZVNOa0ZmWHJIMFU1OWZPVlJYVEVDT2Uw?=
 =?utf-8?B?SUFiNnYvK3BLWW1BaHp2SlNTRUlKWE1NQkF2OTZKY3JkRmNRR2dYSWFvM1dz?=
 =?utf-8?B?eU9LUW5QUmMrckw1aVI2dmNJenZvdk83UHRqK0V0R0kxNzhGRExkbnNZbVBn?=
 =?utf-8?B?QUNCZDN6VGRaVnB0WnVJWTNTMllxOUxPVFNJMFk5a3ZnWFllWHpza1BqOThS?=
 =?utf-8?B?OFdkRWRsWmdrbTdKV3ZKYWNlSDFQUDNnNlJWeHdrdDJHbjlmVTNUV2hkV0lX?=
 =?utf-8?B?QjVFMjlIQTJkcGZEOW1SWWt5RDNLL0NhR1FoSlhLM0lBd0lLcWkvYmdvVDBH?=
 =?utf-8?B?dFlmMnlFVEsrekQ2RHpZcDRzM0ZuS1U2anZML2I1VVJIaldZS01Vak4yYVFs?=
 =?utf-8?B?TFlrQkpXNEZUaG4yMjNWY1dTaGJaSTZvRWNWanptUGFLMzFaV01YRkorQStq?=
 =?utf-8?B?SEhlL2VOeXJUQmZ5RDJUSVJkWUZoejNLSFhSVHF1ZHZXVEdPVDBpRCtFSVNr?=
 =?utf-8?B?UzVFRWJVK1JucnJGNmEwR01zV09FQ0JHRFFHV1hhMGZWaVZzNkdnNVBVLzNu?=
 =?utf-8?Q?Uq/284iCqcMyWAREWz4gcvnO1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd862dd0-dcba-4c9f-4092-08dcb50696a6
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB9052.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 04:25:08.4561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HTib/UKXc4ozIZJvV60HDW7xkEFWEsd/uq0ekNilcddK4z71KO2S4GCnHWq2tVoFS+R1SENVSnapskMddC8weA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5989


On 8/1/2024 10:12 PM, Robin Murphy wrote:
> External email: Use caution opening links or attachments
>
>
> On 01/08/2024 4:34 am, Ashish Mhetre wrote:
>> Gather can be NULL when unmap is called for freeing old table while
>> mapping. If it's NULL then there is no need to add page for syncing
>> the TLB.
>
> But that's only because __arm_lpae_unmap() is now choosing to
> over-invalidate the table entries for simplicity. I think it would make
> more sense to handle that at the callsite, e.g. "if (gather &&
> !iommu_iotlb_gather_queued(gather))".
>
> Also doesn't this mean that bisection is broken as-is since patch #1 on
> its own is going to blow up dereferencing NULL->pgsize when it gets here?
>
> Thanks,
> Robin.
>
Yes, gather can be NULL because of patch #1 only. I will fix it at 
callsite only
with a single patch rather than splitting.

>> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
>> ---
>>   include/linux/iommu.h | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 4d47f2c33311..2a28c1ef8517 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -928,6 +928,9 @@ static inline void 
>> iommu_iotlb_gather_add_page(struct iommu_domain *domain,
>>                                              struct 
>> iommu_iotlb_gather *gather,
>>                                              unsigned long iova, 
>> size_t size)
>>   {
>> +     if (!gather)
>> +             return;
>> +
>>       /*
>>        * If the new page is disjoint from the current range or is 
>> mapped at
>>        * a different granularity, then sync the TLB so that the gather
