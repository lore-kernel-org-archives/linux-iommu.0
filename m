Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.27
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793874330;
	b=YXR/uPnq7mLcm0sNfLVk6UtOFv3bibzuoNA8g0uMgQdP85PEfOQUGOSyF+StSc13okFX
	 Otkc7AgfOhcewizrAWcmdkPpeq2aiKuEbLR6oh/p9m0UymWq5y/x689naYh14QqzAfUAU
	 cvOUziKUsPvD+KlLj38K+Z/2BNll7cwiC5Q9VrYubeBcTfar5Cu6bP212IGTlt/n+BUn+
	 eIYccNqi32PlHsxEW/1U43JKzQ9/fbo8jViv9ugT4FZcnnnGNg6cVEFBrKRQmVNzycmv8
	 6MBBJd5KTExxARO7SsNPx+i2292ydbxojl5kypQ1cqTejRmA/fWaksaQJs2Pny3umJw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793874330;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:From:To:Cc:References:Content-Language:In-Reply-To:
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
	bh=7g4AnHz1b45ylnVeVQvuDBjdf3MBOm/p+0a96v3wy0I=;
	b=4oUy/FJxrlxXZ5+o8Kq3u6Q0E8L9fiKTxpu2T0Djax4AQKX79E7oICllAyfXYI9LJXc8
	 HXlBVYOAmozVQu7bSToTfNyuT4ac20exA5EY2X9mYdP658D5xyq5fzgVw6ReucSWGecF2
	 XfZhvowZT47HNldUGF/pvQ6Mu/HIKDX0B3F/ZmkcjXnoKGreR2IurgX9ljKi9fId0QQoH
	 N2ez6jizeaeRHPggHghVdRYBp28uZAQeWmXPvc8Ixf0Af4/DqemjYNfaWcwKx4WGhnp1/
	 efSPkFiSPRosP2xKcAY9CFXoCd2+XYrhfC3tWF+um2U09Ls20HWgdd7aAJz3P8k2/jw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=zdS8i2c9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.27
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012027.outbound.protection.outlook.com [40.93.195.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84EE606A32C
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 10:25:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E84EE606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=zdS8i2c9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fipkPoxhtyZGQIrjVJSQDKkNH+ueftCHeXfpefOg6blZIqWnV9Cl0Ngym6eoghOmnTVFRYMBGxKallbSS+VWcOHauYLyrTwcFV9VzTgdZrssYphfdXavAb4RqcgQmc7eDKsZwWqHHkPuXwSicLsZu2vRkr9NN+bJCzmB8hATP3s4m4hf8ciTwYjhdZ/JOkN5gTroJvEmbmHAUPUOR7Gomc9FoKGhCSlxgvF+RX+t/5ncjkAPETvm0pb1SfIeUKq7V2jqgoneHxVP5p9J3u1helXfkB0LA7OInce7sLkbgMU8VJWXoRsZqEAkW9y7YSte7EJ7JuES5f4KJiVNwa4K6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7g4AnHz1b45ylnVeVQvuDBjdf3MBOm/p+0a96v3wy0I=;
 b=S8j7/PYbyKAGDgtoUq3GVvCTXoW1EyYLU155qJCTNzX2Mj9jjTRM9WQ+N5YZNlbLUHzgv5t4aChoeacKtFJqyZ1lJWfvj5nzirMBeZ02698ubYPGT9SKwuf22WooOEYDqNiekQgQW4/rf82R6QmwTikR0EuzLAzxxpicFxpa+6lcPjPMt8krIc00bii1EGwNrK8FnasVE9UKtOe5nnOgBJFnZc8XOCfrSviacANoI27OhsJ73ZNvtXmeEOwSAzaFK09ERxxOtS5hDjT/Z2nX6tx/j/AsNYGh3ppWgthuqU0zdez37MDDPkTVuebURVWXMt/pPq4mga2PJuyYjX9DPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7g4AnHz1b45ylnVeVQvuDBjdf3MBOm/p+0a96v3wy0I=;
 b=zdS8i2c9aXaibUbKh6JF94HuczCrKn3IzXUePG3czhTPXtUFalHuDVpuu1jMZmkE+XsaQ89FHKE2XxpmG333FCtD20B+0NET8kty/e9Ki3FPRsHn9+TEwc6lMDhyVaiBuUygwyhmcqq/qCpl5KHtscs/dXHDB5XG2JmXywUeuYg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by DS5PPFA3734E4BA.namprd12.prod.outlook.com (2603:10b6:f:fc00::65c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 10:25:25 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 10:25:24 +0000
Message-ID: <efd2a9cc-dcbb-4f45-8dd7-7fcd713830ec@amd.com>
Date: Thu, 5 Nov 2026 15:55:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] iommu/amd: Enable PerfOpt automatically for integrated
 GPUs
From: Vasant Hegde <vasant.hegde@amd.com>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Alex Deucher <alexander.deucher@amd.com>,
 Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
References: <20261022-superm1-perf-opt-next-v5-1-dfef0b78b7b9@kernel.org>
 <4206ec86-c6aa-447a-a5d1-4d2e89a31b5c@amd.com>
Content-Language: en-US
In-Reply-To: <4206ec86-c6aa-447a-a5d1-4d2e89a31b5c@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0069.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::10) To BL4PR12MB9505.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|DS5PPFA3734E4BA:EE_
X-MS-Office365-Filtering-Correlation-Id: 20603a5d-4952-432a-fa1f-08df3b271a49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|261026140227099003|11063799006|4143699003|56012099006|261022075727099003|261021121427099003|261022105027099003|261102123227099003|261028144727099003|261026121527099003|261102130727099003|18002099003|22082099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	9SYyg8p9VTVizQJashi0VhLb1+P6V2YX/r42htB87d8g4xpd0FIQd7j+Rqy22QVTGMdGtA66LBXn6jhlWUOQPzvxhPho/2hNosAv5QMofAG867czfAkutURsoZ0wOhiC92DVG3m99ih0PLEwrlFQTdBabFu8QtzbLG5xmQhKE6eM0141p60uxNVXaOs5tcM2Dmnag8b8zxgkBCKDnwisTKVKxgs7DlebsUfnsY1sXXsfSNBHOEQOFjK1t4F5+TAAcKMNiSbpyKACYGE/Zfj3v4Bw4OkwbSntFaq3+Vf/TV6XfXn1Y4ypEFA1JcQaAQTvCDqi7CiSmzG2zRCkX330uzt7Q3ixg7xTe0AxAHLyzi/yInV7XNXf7NNCK6XaSJR+yaz9f5Dqlq4doz6iITsGNqXQe+CURxCqZoUTh3V3M+HmOQeMAM+3oF7hmsMULiuY0PuoaU2bS0+VnMxVXosqok/cf8LsEPfFwHUVoDfAB14w80glck0lnS+zHRjSMUuaFJia0fIu2Larxs9YROvdxhdAU03D2SiAc8F56E7oWzXA4KNtir/n+tiYG7tyvbI9MpVB+ibHefZ1KA3wlcggmu9n1sVEGyovTrXYsbmtjVgpIKF442Gq2oI+1URPTLSBwCaW7w/GURWNlSAppcCd31K9JY/nBJ9qDTTlNvNtCFE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(261026140227099003)(11063799006)(4143699003)(56012099006)(261022075727099003)(261021121427099003)(261022105027099003)(261102123227099003)(261028144727099003)(261026121527099003)(261102130727099003)(18002099003)(22082099003)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmVjMCtYQ3Jxa3VDM2FTeUp3SlV1clpTdmNxY25IY2tEdkI1L3VOY2ZHK3lN?=
 =?utf-8?B?MmcyOUxEbTR3SjgyQ3U3MWZmQTUrUEp5M1VyKzZhWHZjQmxmWDF6cllVQmZ4?=
 =?utf-8?B?TWUzRlg4czVGTHJ4MmF0QUorSzN1R0lZcEdXVUhuMlpwU2hLQTNiV0h6dDRH?=
 =?utf-8?B?OHFoQTNwdGZpcURYaXI5TEtmVjJ5VHlLdkF4RnR3QkhMVGJnY1pTbjZPWGp6?=
 =?utf-8?B?QStySXAzSTB1RTA3THNZa2Znc0ErTms0UWF1QmZrR0ptQWxMUGpnWEVvUGRh?=
 =?utf-8?B?YWk1RW9zZXBOYmNhMkhnSHN2ZEhCRmNWd2hWc2dLMEhMMUxZZXNCZkZYaGtl?=
 =?utf-8?B?OHVuTFJKT1Y2WmpycGtoOUlwZW9LZm1aWGpKUnFJNURJWFRpS1ZyQ2VMRTJW?=
 =?utf-8?B?VGlkT0tnUHZMMHBrRUU4dTZvcDl1NFU0VzMxZ3RqNXVWdFg0K3BXSkRUYXdQ?=
 =?utf-8?B?NnppOVZ3L2ZHL1NHWUNTUUsyWlVXVUZxQUZSQWhwQWczL3Z3ejV4VUxpcTli?=
 =?utf-8?B?ZmljU3NnaFp5cmp4UVZmYVJ0RXdrbFprdHdFMFl2bTFCbVAvWTVvbWViSzhW?=
 =?utf-8?B?YXhSa2svS251dk5wd2xZRWUzZFlLQkljTVlkdHIxV1UzS3FnMWFsK1A0R1d1?=
 =?utf-8?B?K0phNEliekRUY2tsZHVUVFgzSHEyMEkydnltaEdJWC9qMUtud2daSEFpdlAv?=
 =?utf-8?B?K3JZYXNYOE9Bc0pUa05kN0g3Y2RmcXIrQUFGY2RXeGJWUnBEak1xZmFUOGZZ?=
 =?utf-8?B?d0VUcXVpOHg5c1VhSDMvSUlCbGFZSUROSDllNmY4OC9maWZkVnZoZmw2M3I3?=
 =?utf-8?B?SUVjTkhwcWtwdDVXRDBhaUJYampFd2ZEK3c4ajF3NU5vamNaVU92dDRJSHNz?=
 =?utf-8?B?bDVGMnVXYVBFYUZjaXlnT1crZVZOeWFmOWM5NEdXWFUyY3M3a2F0bCt4bnlq?=
 =?utf-8?B?by8yeFQvVzMxKzdLUGJSRi9tdlFEVCtmUmVTKzhabnVvUGFFRE80UWZZRng0?=
 =?utf-8?B?SnpJRE9Td1dOVmZiaGNIOWxtWFdyYTNpR0lRZUNwcWMxQ1J1bkUvaUMwTjF5?=
 =?utf-8?B?MGlnU3hWV1RzNW92a2VyUjdMcTQ5VEU2T2lwdWhsRGNqM2ZsTi8rVVIrN3J6?=
 =?utf-8?B?akJpREdFZ3dMRG5oYTE3Z2FEaUtsZmw2cE9Ibk1odE1BREJrT2J3anovMlRI?=
 =?utf-8?B?UXQySi9nT0xjTCsxWGhOclBZWTlJSEpaVjVIRnZEWUs0ektDQ2JWMFRXT2Zq?=
 =?utf-8?B?YXB1WXk5a0hRUnNHNlNjZDR0L1YvbjVEcXpmc3NYL05qT3pZb2cvYnZLckJy?=
 =?utf-8?B?MFV1Tjg2M0dYeENWNGFjV2ZwQmxRTm5UWGFSOUhDQkxkTGZrRS9tMTJieENW?=
 =?utf-8?B?UklWZHd1ZWR4M05BV1lMQWcxVEVvVW1MZnFObFU1UGxFRmw2Q01TelZGdmNi?=
 =?utf-8?B?M0ZXME5yT2psaE9DYmVUOFpQWUdINXdoeER4VGltWGF4M0dXSGxIb3VyL1FR?=
 =?utf-8?B?MzNxUXlPZXVSV3l2RjRXNFB6czNQd0pQUDJOYjBrbk90bXlFMkJhT0x1YTRm?=
 =?utf-8?B?aHNaSEdTd0ZiOWZnay9OOC8zbmo3YTcyeXd5S285dVhsTUpadWZMdy9HajhU?=
 =?utf-8?B?T1FoQ0UwcHYzeDVCejgyN2c5V3ZvRlMyU1VhVEphWnNDS1lMUTZubjFzS2JE?=
 =?utf-8?B?a2JydFJicG15cEFROTd6dG9UZXlEVG9heVlQcmF3YmlaeDBIdmhkSGNVdmdS?=
 =?utf-8?B?YVN5cmdnUk1GMEc3eENoaWZPam1QSnowZU1paFBiUktwdFFjajJXZW9GRUt2?=
 =?utf-8?B?VU5CaE1pYjBhVDJtczYzNElRQlZVVDNnQVFLNHNsTnM3SU9lVHFZTmdWclN0?=
 =?utf-8?B?dVppWEkrVmhhNnU0dDhrYm13bUFJVHk0eFVSSi9UVVNtY1FxRllxNXRsVnpC?=
 =?utf-8?B?RnpiZFp0Q29aVTM0QlBDQ1RPZ3BwcHE3cVZJQ0h0bCt5RGdLK2kveVROZFkr?=
 =?utf-8?B?TWZ4SE1SWUJmTzdVOGZqZmtVSlpJZmRaL3J6eU5SeUFkSVlldjdhSjRTeWFQ?=
 =?utf-8?B?UFp5TkhFMUtub1VSbVlsZnpLeHV1ME5BN01udVZ6bW43WHJNOW5MVGxLSVZa?=
 =?utf-8?B?TjhWZXNKQmhkYVlwOEt0MWNtLzl0TmdYWWZlVHE3bzhNSUZWNVNydWNpOTRh?=
 =?utf-8?B?U0gyZ2d0YmNvbXhKc3h4N0lUTUZEVXVLalNnWXc3TCtDK2FCMU5yYVcyVGlP?=
 =?utf-8?B?VHRsRklKTXpRRXBWT0ZoZlMwZTBGeVloY1kwVWVhNjhPc1gxTHJIN05qKzF4?=
 =?utf-8?Q?lDSwQy+/3UAXhpInfR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20603a5d-4952-432a-fa1f-08df3b271a49
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 10:25:24.1711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uTPXSwX9OiMofQgz3//TzuZC4FyKS6UKW/h/aKqbTSG2+88y94yvPmy3Y08BvJQ7M85guUnfLiaSpfntvAozsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFA3734E4BA

Alex,


On 11/2/2026 8:26 PM, Vasant Hegde wrote:
> 
> 
> On 10/23/2026 2:16 AM, Mario Limonciello (AMD) wrote:
>> PerfOpt is usable by integrated GPUs in identity mode. Enable it from
>> the IOMMU driver's domain attachment paths instead of requiring an
>> amdgpu policy knob and exported enable/disable interfaces.
>>
>> Mark supported integrated GPUs as PerfOpt-eligible when selecting their
>> default identity domain. Skip GCR3 setup and ATS/PRI/PASID enablement for
>> these identity attachments, then enable PerfOpt after installing the DTE.
>> Clear PerfOpt before attaching an eligible GPU to a translated or blocked
>> domain, including unmanaged domains used by VFIO. Propagate failures to
>> clear bypass, but keep a completed identity attachment successful if the
>> optional PerfOpt enable fails.
>>
>> Clear inherited PerfOpt state during initialization, including when a crash
>> kernel reuses device tables. Read feature support directly from hardware
>> because cached features may not be available yet, and stop initialization
>> if the initial clear fails.
>>
>> Each IOMMU has at most one PerfOpt-eligible GPU, so track activation with a
>> boolean under the IOMMU lock. Preserve this state while clearing hardware
>> at suspend and shutdown, and restore the bit on resume only where it was
>> active. Do not enable PerfOpt unconditionally during early IOMMU
>> initialization.
>>
>> Remove the amdgpu parameter, driver callbacks, and exported interfaces.
>> Translated attachments retain their normal device capability setup.
>>
>> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
>> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> 
> Looks good. Queued for rc.

Can you ack this patch so that we can pick it through IOMMU tree?

-Vasant

