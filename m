Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012061.outbound.protection.outlook.com [52.103.66.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F8E2D23B9
	for <iommu@lists.linux.dev>; Mon, 22 Dec 2025 02:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766369675; cv=fail; b=Lr5QvDe+trrXH12SJ2fs2f03JgNpSfrAAnRrrdtfBSbGywa3RQgeQBWZDxZ15EBLC9I/K7aiKQF1UvjfLk2TfctT6jKV3xTSwsOxt7a+N+4Q7BZABwuBd0nYnRUvVnTQbgMM39ozvYEGNG4SFmo1zoctgbC/hxL1h+pON9q8W84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766369675; c=relaxed/simple;
	bh=KgHfzFE7MXwSLthCXxmsG+A/unzTUYwex1Dmrmft+bw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=luMsmSYgfc9NMWMlYcL9/I/HYFlcHMSJkeRSNMvqR/sBiPcSkX85G9yL0Oq0GkBd3f+qZJZl1kE46gL7VJVPSv8FbaAoL/B0PLzmPyr2drihYvM4qceHGUPkjC6dwRiahNqsECeSejhPkBJ1vSDFApirWmGuctSR+JMbm3RoIpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=IT4IHFBe; arc=fail smtp.client-ip=52.103.66.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="IT4IHFBe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tKYf0CGAGxVnwniA2visHhRviYkSvJWuBgAmf5UpbNiDwMFVwM9tEaK1LdPgITqVu64VAjTHI+BcVcXZJzNuuLvyyZ8Ql7Vr+yyUfd/Z8WN7CYXwOM02u+SHuoLUKFDa7NLQQos5Ezlo8o3hF7zZhHwJXfzW7kj6SKb+LRaF7rEn/wcAb85ELQVGG7WcBK46syrZ3BbgOsO2TgBUEBNt2Kh5Ni7sZtnZ+wiGyKcSBU7rwh5hOyYo98bOky1uG4zgd+jK5anp57azFqCIdw4CYRIiNpAZxMkfZ2Mix9kzJkqO/vN+pc/0gmSnTVKjQRnjW7k5me9rhVWQ0e3ZMzD6EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0B4GsqWc9O+gQsiBRFqX291meewy7BrdnM+F/THwLcc=;
 b=HOnL47/S/Zuqd/OBSleX+ldFFWs0OfJ4JbkaIUMlAMy8hXDlQYyDUVDV7kAXE1zOOQeOMakFVigdS/85MFvlVTNhqY/3L+a+kGQwPNycO7BwlBl8wUJJQW4HOQ+lWQJzvgJyZ3r3EYPenwCUbwIKSoD2bT/oISulDzKeye3g5kAEdLL+x3Vk7NIj5JmbVOM3zVOhJlvCrMG3vKhEoYTWMNj9hWQwFgAzAkz+UHnut3eDnLppPMHBKgljfCRQjrsJ6OIDPgAZ5E77Xjke1stsQPq85/zckNSto0zgf+MCCFM3ce7ZLSEe7OTsYmFknIefWzHOw9yKZOZvUvgKU0i8Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0B4GsqWc9O+gQsiBRFqX291meewy7BrdnM+F/THwLcc=;
 b=IT4IHFBe268qMTQssb7ayLLgsq+DjUqH1F9+n4qBkugSg3cI+1ttyEJykycYBwJAAh3aaTETEQgOdHL6Mb0ZoN3kSygrJhCm5Xz4IUU5sLXA+7zxnZfNYePlJm55WfmItdWfBBmIlnnuVKA2RebSJV4gWHiFMxqa/FI9WoaCuxXUQR+ToJYthGilIUWgNyPlUA7k4UPMMhf8DJToEYfMK6LgPV9isPKdoHpVZQNceU1LXWmiEOQ+SZqnbu1MRq4KTD6MVWPKPmb/FRcmhDYAmMXRhNr0bbUYD7DHOTnpAc7w1tm5iiw4qc3ohOJ6yI/7AxI6kbg5Cy1zcN5wOpCkTg==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by TY2PPFCFC9D84CA.apcprd01.prod.exchangelabs.com
 (2603:1096:408::3d1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.10; Mon, 22 Dec
 2025 02:14:27 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::5e86:f04a:37e5:64f1]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::5e86:f04a:37e5:64f1%5]) with mapi id 15.20.9434.009; Mon, 22 Dec 2025
 02:14:26 +0000
Message-ID:
 <SI2PR01MB439311868FBFB7DDAD19692CDCB4A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Date: Mon, 22 Dec 2025 10:14:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] vfio/type1: Set IOMMU_MMIO in dma->prot for
 MMIO-backed addresses
To: Alexey Kardashevskiy <aik@amd.com>, jgg@nvidia.com, kevin.tian@intel.com,
 alex@shazbot.org, joro@8bytes.org, thomas.lendacky@amd.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <SEZPR01MB4399D06A044791DEA8BE43CBDCAAA@SEZPR01MB4399.apcprd01.prod.exchangelabs.com>
 <SEZPR01MB4399DA27E304E8BFB3C667DEDCAAA@SEZPR01MB4399.apcprd01.prod.exchangelabs.com>
 <10029978-31bb-4ff2-891f-564b970a41b5@amd.com>
Content-Language: en-US
From: Wei Wang <wei.w.wang@hotmail.com>
In-Reply-To: <10029978-31bb-4ff2-891f-564b970a41b5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0060.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::15) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <a8a7d0d0-3bb4-4f87-bc82-4e6387481974@hotmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|TY2PPFCFC9D84CA:EE_
X-MS-Office365-Filtering-Correlation-Id: 204e1786-78f5-4c7a-32aa-08de40ffd43f
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|51005399006|36102599003|6090799003|5072599009|461199028|15080799012|8060799015|19110799012|23021999003|41001999006|440099028|3412199025|40105399003|13041999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UE5RQ214dFdoVkowNnM3WE8vSlVNTm5BbUwrS3FFKy9CNkEvNU04TXIvYS9L?=
 =?utf-8?B?bDEzVHFMQjFpaFJvb2JnZVVjdHVTRXdFeG9FZmJ4UEpITWZKWjN4ZC9qanFY?=
 =?utf-8?B?NFcrZXRtKzE0TVREdk9HYXlzUHJ6T3FkcFBJV0xyMlRxaUZlN2lMcVlScTZJ?=
 =?utf-8?B?dVhBUXhldS91MWpNUWNRWEZiQnE1SzNUMkRuNGJMa2VaYjgvaHU3NnMvczI5?=
 =?utf-8?B?WDU5SEsyUkVsY0xGZXJJTE90Z2RqTW83U3c1bGxYa2wrQVQ2Ym90NTkwVDdH?=
 =?utf-8?B?N2lhanpLcStReHoxM2VMTjIrd2dadnIxT3NkeDNyTzFXNitkZEJSOEt2eW9Z?=
 =?utf-8?B?eEJoNTh1NCtNSml0RkdLTnNGUExmNTBkTFljT2dSN1AxeGtMd25jK0hsem9r?=
 =?utf-8?B?cFRpR1JHSUZQYThTZ0FhVmZRV1ltK2MycEZqU0IxNERHbmRLdmJvY3BvT1l5?=
 =?utf-8?B?RUx2WEEzWE1DMVBxZ3JzMkFNSTRZL3B6L1o5dlVtRGZkS3pJUzhtZmVRcjZB?=
 =?utf-8?B?NVBXekNrREtzMC95Q3hvUTVRckZMR2VNOC9wdzFHdWhhdVNJc1VxQUhzM1ln?=
 =?utf-8?B?TWhMZ3phNEk5M2lDMkU5d1FKaVJlM0t3Q0w5V3RPK3ozY0hvVVFVZUNUZGNY?=
 =?utf-8?B?SFNBbkVVdTY3a0FNUm1VdUtudGlRcEtYNzNicjMrc2Y4cHZ2STlkUzJVSFpl?=
 =?utf-8?B?V2lDNXhteTlLaWxqRnVPdklPVVplc2d1bGJ1M3JEK1pvRjBhaldpWFc1NlV3?=
 =?utf-8?B?c0NZYmJzZm1nVkJydHZCMmxoaTBtWXB2dTdZS1NHcGNLb0xHR0crMWVGSlhE?=
 =?utf-8?B?dmFQYW1QOXJqZHpiR2hVUFBIUFRKMURSYThwVVZvTXhUOWNPTkR6czhJUXRY?=
 =?utf-8?B?YmhNSjl4cnZIa3EvM002VzloZXBoMnQycWNkZ0ZnelVwd1ZELytTdE5JUTE0?=
 =?utf-8?B?Z29JelowZWJSVkhpZW1mQklSbC9TNFg0Wkp2UnVTUjRHV2JSQWROcVlpQVEy?=
 =?utf-8?B?OXQ3TzRBb2g0cTBoUkY1akNOcWZOcUtNb3dBbW9mNzBEMDkvVzZrdGpFdDhT?=
 =?utf-8?B?YVVONGNzRUlQbU1VY0pSUTNtUTJHSzROMUhkcFpBV211TnFhMDlQTVo0TjlY?=
 =?utf-8?B?RHoyVTFVM1JPVXV5bGhacHZ3K2Q5cFZoZ0NuV3o3anY3c0Z2cTRGUGJUYjFk?=
 =?utf-8?B?VFVVYWJpRmRLWVkvY1FCM1RUckI3dkhXSGZhaWtBUG4vWW41VWlPOUpROWo1?=
 =?utf-8?B?S0xwT3BSZWdYTUdUSHdlU2hjQ1Y3VGVKczNGTHV0aUJnTUFjT2NyTlpkT0VM?=
 =?utf-8?B?a2NFMEpoZ0NGUTV1bHZDeUJhczN2L2hHOUdnOWpZeTBzOER3OS96WUZwbzJK?=
 =?utf-8?B?bG54OC9YZVpwUERKbDdzZkVMRndGVHgveWpUamlHL1JWdEU0aFlaR1ZBTmlx?=
 =?utf-8?B?WUZnaGRmcm1NbEQwcGJoaVdmT0NXVjlVajJpV1E5ek9QbkNvN3lTMEJGQStB?=
 =?utf-8?B?TkhBcUpzMlFtWmEyS1NDdUViQmZMRDJKZFlyaTM3OUZTVVVMeElrRDcyYnVv?=
 =?utf-8?B?bXdnTjZUUzZTa1k3NDJabjhCbUVmdjJvWjlNSVhreW41YVdnTlpvK1NEU0I1?=
 =?utf-8?B?cjZtaGc4L3ZKaTFIcjJhVWpubmRpSkxNNjhKZzE4REdRSU5PUXQ3aXpXRmQr?=
 =?utf-8?B?dGdNeTFuZU5tblp5S1JJc2pjMTVuWE5JejZTRmpOWWE5dnpOZVJtd3BqN0dN?=
 =?utf-8?Q?PB84iojE74P7DjF+GVglAtGzC4ihkpcBEUKf1Aj?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djlYakpIY09CVjV6V2tEWWIwdXZjT3p2MFVUMnZSd2pvV1pRdUNsOWVwd0NS?=
 =?utf-8?B?cXNBWC9SYlM4K1lKSlluZk9FWUhqdW5zQmQvMmJMcFVLQnRjSmE5WWNVRXhi?=
 =?utf-8?B?L1dNQ1p1djdwbUNCRTFaVzVvcWNiNE5jRXpsNVlYQklGM3pqcEd0akNmb3ZY?=
 =?utf-8?B?Zy9JRzAycnZycjcvckEycWhMdnV3VndnMFRJNmpWSHZwOG4zbGFYV0FUQnFh?=
 =?utf-8?B?QkxPMnNoTUtZYndJRm5oclIrQ2drR0tWKy9kSUhWMnB3b1lkZXRSb3VWcUJl?=
 =?utf-8?B?OWZ4T0s1K0N0MnJucXVHRUxrMW9kNGtLRGdEMHNPUVNKUHNzek1QeDBldm9w?=
 =?utf-8?B?dEs5QThPOE0xSjEvdk00NHRKcU45M2hMWTgxSm8zTXN0ZklaVnpNb1dNd3pG?=
 =?utf-8?B?QzNLSm5VLzkyYlJyL1piNzR5Tkl5RlFIY1hESlN5RnMrM0s5K041YXdZUWQ4?=
 =?utf-8?B?MkFqaWd2TlV0YlZEMERmVnd3RTJDWUV5OHVKQ2F3L0VuWit0VDd1UVQ0Y3JJ?=
 =?utf-8?B?MUJiRUJBbDBoZXRmdmQ4L3crTTZWcGk4QjVCaDU2QlNRcVB0NEIzaDdRMm5x?=
 =?utf-8?B?dXRLVVNwK0ZMUmFQK0Zud3FnNVhyVnNzbkk4aExhQ055S3NtQitMNzdweVhD?=
 =?utf-8?B?K0VSaWtLRHBTMVY5ZXdqRFp2Zlk0SGUrYWtXRElCZ2doY04yYVhYWkxhT1ZY?=
 =?utf-8?B?UnJ3Qllxa2FpS1dRMTFiYi9jdXpHTlduS3lDeWx4SndkR2JZbWpzbWlZMXFE?=
 =?utf-8?B?d1RvdmR4Vk95dnBodkdSR0tkMjJLU2NOekZpc28vVjk4RDhmamRaWlQxMUtn?=
 =?utf-8?B?YUQ1K1MzL2dYWTdtYTVZOEdmUHVzWDlHVVZxdjFoTDVDSHJUTTdocS9yaUtM?=
 =?utf-8?B?RHFScjBMdU9odExrVDNZeS9JbER0aWRKK1gvd3JNWUxEcTYvL1hmT2F5ZE1V?=
 =?utf-8?B?anEyTlE2UHJrdmZtaFVNenkvVjRzcjUrQ3MxY3ZaQTJDbTVNVnlLcWN5QlJP?=
 =?utf-8?B?cldBN2gzWFA5REF2OUx6L3k4SEdSSXR1L2M5d1ZIdGh4YWFsZFhrSVFCSG1U?=
 =?utf-8?B?UlY4M0ppbEhUWHBVTlVkUXBnRk5NQ3gxa1Z1bHFSbHBxaU5Xb0xrVzdrYzQy?=
 =?utf-8?B?ZzZDN2VrK2wxLzJNVE5PRzFUUE9qSUZvbDNJNTZSYld3MGxvNWRUZ2grYlpW?=
 =?utf-8?B?dG1WR3VZODAxUkhJQ1psVVlONEhTeUJqb2dpRkR5UnZTcGIybWI0UFVuNnhl?=
 =?utf-8?B?M0JFTVFoSXlSRWZOMFQyQVErNzk5bE81UXhVS21RR2Y1b1p6QWpJeXY0aDk3?=
 =?utf-8?B?dEpXVWpVUFhwT0hsbmNmVG45WUtVdVRNaXZNb1NiY0NoQ0pTckZSNU5HRDBY?=
 =?utf-8?B?YVUvVGdVanFZTVp1VE5iQnBybUYzQTZWOUZwNjZpNVk2NEtYWDRYOHY0Mno1?=
 =?utf-8?B?cjZONjZaRys0N1pOSzFBTWd4SllVVVNFRklIdm1LRlJ6ejhMQUZiajNsdVBJ?=
 =?utf-8?B?ZDZBYTRhWkZ4b3NRUjQ4djBwaEUvU0ptWS9qQnRKUXN6T2Q3TnR1M3FycGhC?=
 =?utf-8?B?ZjRMYnZ4NVVNaldJSmVGRGVQUS9admkzSzkzM2FkR0JYUy9FYUxiZC9UMFJX?=
 =?utf-8?B?a3JjWUNCVjRqOXJ2d2VRQjlPRjJaSjBaS29zMkRJRnYxdUdmNVNuSkZpSmlm?=
 =?utf-8?B?S04zRUdEMzQvK01BRnlJYmJjOE93QUdFdUZ6Q1lQM25raW5aTHhuWkxKMG5i?=
 =?utf-8?B?RXRaL1U4SGo5K0V2ZUpJa3VmRjhYYXNsUmFJa3oxS201MWlWUUowdFp3OTkx?=
 =?utf-8?B?ZFRUMUxyQkFtUCtJK2ZZTE9rK2hGbkpzMWVPZFFreWd1NHdvai91WW9VTFpO?=
 =?utf-8?Q?h7ZGzUahmFzsi?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-5f51e.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 204e1786-78f5-4c7a-32aa-08de40ffd43f
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 02:14:26.1278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPFCFC9D84CA

On 12/17/25 12:24 PM, Alexey Kardashevskiy wrote:
> 
> 
> On 17/12/25 03:13, Wei Wang wrote:
>> Before requesting the IOMMU driver to map an IOVA to a physical address,
>> set the IOMMU_MMIO flag in dma->prot when the physical address 
>> corresponds
>> to MMIO. This allows the IOMMU driver to handle MMIO mappings specially.
>> For example, on AMD CPUs with SME enabled, the IOMMU driver avoids 
>> setting
>> the C-bit if iommu_map() is called with IOMMU_MMIO set in prot. This
>> prevents issues with PCIe P2P communication when IOVA is used.
>>
>> Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
>> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
>> ---
>>   drivers/vfio/vfio_iommu_type1.c | 14 +++++++++-----
>>   1 file changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/ 
>> vfio_iommu_type1.c
>> index 5167bec14e36..dfe53da53b80 100644
>> --- a/drivers/vfio/vfio_iommu_type1.c
>> +++ b/drivers/vfio/vfio_iommu_type1.c
>> @@ -583,7 +583,7 @@ static int follow_fault_pfn(struct vm_area_struct 
>> *vma, struct mm_struct *mm,
>>    * returned initial pfn are provided; subsequent pfns are contiguous.
>>    */
>>   static long vaddr_get_pfns(struct mm_struct *mm, unsigned long vaddr,
>> -               unsigned long npages, int prot, unsigned long *pfn,
>> +               unsigned long npages, int *prot, unsigned long *pfn,
>>                  struct vfio_batch *batch)
>>   {
>>       unsigned long pin_pages = min_t(unsigned long, npages, batch- 
>> >capacity);
>> @@ -591,7 +591,7 @@ static long vaddr_get_pfns(struct mm_struct *mm, 
>> unsigned long vaddr,
>>       unsigned int flags = 0;
>>       long ret;
>> -    if (prot & IOMMU_WRITE)
>> +    if (*prot & IOMMU_WRITE)
>>           flags |= FOLL_WRITE;
>>       mmap_read_lock(mm);
>> @@ -601,6 +601,7 @@ static long vaddr_get_pfns(struct mm_struct *mm, 
>> unsigned long vaddr,
>>           *pfn = page_to_pfn(batch->pages[0]);
>>           batch->size = ret;
>>           batch->offset = 0;
>> +        *prot &= ~IOMMU_MMIO;
> 
> 
> Do you expect IOMMU_MMIO here, why?
> 
> Then, what if this vaddr_get_pfns() called with vaddr which is some RAM 
> immediately followed by MMIO? The whole vfio_dma descriptor will get 
> IOMMU_MMIO, hardly desirable (also quite unlikely though).
> 

Yeah, thanks for pointing this out. The current implementation logic 
allows the adjacent RAM and MMIO address ranges to be handled via 
separate vfio_iommu_map() calls (in vfio_pin_map_dma()). Given the 
issues you mentioned above, it might not be appropriate to clear the 
IOMMU_MMIO flag here. I’m considering removing the above IOMMU_MMIO
flag clearing in vaddr_get_pfns() and adding the following changes
to vfio_pin_pages_remote():

out:
         dma->has_rsvd |= rsvd;
+      if (!rsvd)
+               dma->prot &= ~IOMMU_MMIO;
         ret = vfio_lock_acct(dma, lock_acct, false);

unpin_out:
         if (ret < 0) {
                 if (pinned && !rsvd) {
                         for (pfn = *pfn_base ; pinned ; pfn++, pinned--)
                                 put_pfn(pfn, dma->prot);
                 }
                 vfio_batch_unpin(batch, dma);

                 return ret;
         }

         return pinned;
}

*pfn_base is the address that will be returned to vfio_pin_map_dma() to 
do vfio_iommu_map, and rsvd indicates the status of *pfn_base — MMIO 
addresses are guaranteed to have rsvd=true. Thus, when !rsvd, *pfn_base 
is not MMIO, and the IOMMU_MMIO flag needs to be cleared.

Then revisit the two corner cases:
- RAM immediately followed by MMIO: The first call to vaddr_get_pfns() 
will set *pfn_base to a RAM physical address,  and rsvd will be updated 
to false. In the subsequent iteration of the “while (npage)” loop, 
vaddr_get_pfns() will detect an MMIO address and update dma->prot to 
include IOMMU_MMIO. Since the value returned to vfio_pin_map_dma() 
corresponds to a RAM’s pfn (with rsvd=false) obtained in the first call 
above, the IOMMU_MMIO flag will be cleared when going to “out:”.

- MMIO immediately followed by RAM: The first vaddr_get_pfns() 
invocation will identify an MMIO address, set *pfn_base to this MMIO 
address, and then mark rsvd=true. When going to “out:”, the IOMMU_MMIO 
flag will remain set.
