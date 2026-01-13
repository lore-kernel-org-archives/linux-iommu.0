Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazolkn19013072.outbound.protection.outlook.com [52.103.43.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281071A262D
	for <iommu@lists.linux.dev>; Tue, 13 Jan 2026 11:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768302432; cv=fail; b=u9k7Luz0Wtu7EKsGcIrXNEzLd9TjObuTWPHIBAZZVgKfyJte5lY0coEHS1147rS6yVbbdsUwClS1oR1RckuBsWsnTe18i0pLkV/DTtrDGbH8LzADQ8mLbFnoRgryxexTBEkYZkcKTeTfG6HX+8Bfy4DK99o5pPgl/xfNHOXSq+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768302432; c=relaxed/simple;
	bh=OZKJXp8I6YzxJD+U9DbZpu9PTtUTMzlcyJEWDdFftHw=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p434N9IGf1xKoUv5NiEAO7m1pyyFei6CGs+LG8nTlLKlCo1zbAPB2r3f5YSEgDjJdFRGDtjygdOOjQ+JDbRv4wSEp16AHDYWTCOyXLiOOHypmmBSbWOIOtuQbF/dFpWviGWngvoOZQtF+fLTSKa9PxslL1Y+RUJOgcHJAF0EIhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=ieUr2a5y; arc=fail smtp.client-ip=52.103.43.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="ieUr2a5y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=idFwKjvbVQhl5g6FCgcyCPrwALhQx1ft9zPtMtdPs7g4ryybDQGEK0PQqdiWFIjEIoBNINuiFteUySlaNQxZ1rIBGvVKg+D7YRtNK9qQNE3mUxVubiVsSYmzQw+epTxDTZwMhZJQeoewNK2os9ypj2tJD+2GCytfqXepOi4iX29b1j3IZDV3mOVVCyaE1l+dRv7TXNtK/nJ9eFBTf8RrQuRBgWKhZAmxPl8G3LHYeNghEXTgjPqzaiiYKINkg4U5W8t3QkaOsTYJ5oRE5Pi9jgR50QaATQojuQb2iQ+OTb09IO5Gtb+JdtCZRxnGolAO5wuF1okjladNM9eqlhVg8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ehGOoihth1U+Z8bevi/XbQw35jleGVP2/d63VPkHZFs=;
 b=sOv10oUvtg1GjRCBDB8y2FfXmyV2cNPj7RfmynQHiTgIZrEFZ8oZU2VV/TqMVQbh4t3RgZ+rTbQYPlrO6SMvQgyUmucLpXgBQ1oyBe0tPdV6slRyCQICyp9uI9CrOJWWZPCtGsidAcV2RVdtFGxNwNGhDRhXIX16jX9sx1/dwDL6M4QPDsT1cTY6N4wrM2dN+el1KQkICVqjxsEADG0moU1GLzIVNPPlBLlHFiibJLNKRYeHXIphoepZeIlX+xFNXFdy6l5c120Xso5lAII9RfAUJ6foqCQ7AQm1M3Z16dFl/qjnRc7TaJ7v2aUcpmUPQU/H8aUrw0aSMEytn9GGlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehGOoihth1U+Z8bevi/XbQw35jleGVP2/d63VPkHZFs=;
 b=ieUr2a5yfmnlrc13I47gWjunw9HxQk4Sa+HSP3121sL4oTRNTFELvmiovAOj4CattMSOrAoC5vPXlSOJfCE/XEnE6O4CRRaq+fpLbchzBOgvjXMdOKCMqrSjrOG/GFLz+U+D3zcKbfW84Ycs1lB6oP9/3T+Q3uLOKpWaLJyXfLRlw2ku+LUgKQlp5SPsM6bkLdwvOXxtLyVTo8pjQGgwL8M313pQogRXStsJcoWuc7DxM6P1uIt9+b2nouCYRo1E3L5NvIwwqVbTAKl6Mq/6wZQt/sft7XPav+sbGYoostJztYSK86u9X4Nqnsl4yycfYqvzTWKhjLjl1Dta+d62wA==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by TYSPR01MB6054.apcprd01.prod.exchangelabs.com
 (2603:1096:405:60::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Tue, 13 Jan
 2026 11:07:07 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::5e86:f04a:37e5:64f1]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::5e86:f04a:37e5:64f1%5]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 11:07:05 +0000
Message-ID:
 <SI2PR01MB4393A70032FCAAECA48D9D26DC8EA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Date: Tue, 13 Jan 2026 19:06:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] vfio/type1: Set IOMMU_MMIO in dma->prot for
 MMIO-backed addresses
From: Wei Wang <wei.w.wang@hotmail.com>
To: Alexey Kardashevskiy <aik@amd.com>, jgg@nvidia.com, kevin.tian@intel.com,
 alex@shazbot.org, joro@8bytes.org, thomas.lendacky@amd.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <SEZPR01MB4399D06A044791DEA8BE43CBDCAAA@SEZPR01MB4399.apcprd01.prod.exchangelabs.com>
 <SEZPR01MB4399DA27E304E8BFB3C667DEDCAAA@SEZPR01MB4399.apcprd01.prod.exchangelabs.com>
 <10029978-31bb-4ff2-891f-564b970a41b5@amd.com>
 <a8a7d0d0-3bb4-4f87-bc82-4e6387481974@hotmail.com>
Content-Language: en-US
In-Reply-To: <a8a7d0d0-3bb4-4f87-bc82-4e6387481974@hotmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYWPR01CA0016.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::21) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <e35a0765-f935-4285-ae8c-6c652bf2acd1@hotmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|TYSPR01MB6054:EE_
X-MS-Office365-Filtering-Correlation-Id: abeb66ef-5955-49c5-578c-08de5293e2d2
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|8060799015|51005399006|5072599009|6090799003|461199028|41001999006|37102599003|23021999003|15080799012|3412199025|440099028|40105399003|13041999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dUpvc09WaGY3c1RkL1NXd0U2Tk0zTytNRnNDMzhZY1hpelg5RFlsWGdacHBF?=
 =?utf-8?B?aVRyTmd5dGVuU3AwZ2VSMlBDTklKdnNRd2lVMEZVR29TU3ZOd0MyL0kvYis5?=
 =?utf-8?B?eGxlckc5RG1TSjM2NTlRZTNDV243SDAycWZPems0b1haK2hZZDdDcTFGOG45?=
 =?utf-8?B?ZmJFMTJOK2V5SDY2UWxFWlJaVjJBekZRczVkdS9YVlg3Mk9oZVB2SFR1VkdI?=
 =?utf-8?B?b0Z5Y1FHVmxrTDdibjJaRUVJM2E5amNkTE50a3NxM2ZXZmVHdktuem5nRFhS?=
 =?utf-8?B?emUydkpjTjg0ZnpURGcvQU0yTEMyd2FucVl0QXZIZ1dFcVg0K1J4SDNVYTgz?=
 =?utf-8?B?UGdrRGtFd0tGejkyM05SWmQ5d0pNNldkRzRIMThEOHRtM1M1TFRwTk1taC9I?=
 =?utf-8?B?YU1vai9pU3Z3V2prM20wbGRxY1ZDd3hZdjRuUjYxNUUwbXFRN0QzaTMxNXJY?=
 =?utf-8?B?R2ZSeWVnVDRqaWo4SnJ4NTM1a3I4SWg2L1grU0Mzb2tIM0MvUG1ia1ZBMHFV?=
 =?utf-8?B?VEJJelpWNWpISlhsMFFqYUhGMjI4RkpVZTRydGhTQ25QOHloMjRxZkxDQjky?=
 =?utf-8?B?OTR6eUVzQkV0MlpmQ21pWE1qQitrUG13Vm94cXZreEt5SHBvMnU4UGNhMDU1?=
 =?utf-8?B?ek1iQzY0RDRIYnFOZFVOenZoQjhrNGRpdE52ZFc1WWJCMi9xUXd3emdpWWJa?=
 =?utf-8?B?MFdsSG5FclhEY1dUWVQySmtwd25PQStCNUtHdktSU3lTdmpKSDBKR3ZaWHp1?=
 =?utf-8?B?akk3cEhnOURzMHBXV3g1a1IrNUtYQmJCZVFtVDlDWDJtTUZCcXEydUpQNlg5?=
 =?utf-8?B?aStRbWJvdWRGQ0xxYnp5RFFJMTdLa1phaW5GYVNXT0RSTDA5VldUbGgxWnNo?=
 =?utf-8?B?QXhveTFTaUt3eWlJbnBhaEtmMkpFcHlrQi9va1J6NWNNWDdLUXYxcmxYa3VW?=
 =?utf-8?B?Y2lvR0JtcVNpRGJKVW5PV25FK3d3WG5oYTE2RGc4VmhQcVF2WmJXOHVRcnk5?=
 =?utf-8?B?bmlQRStqajIydng1aWRNenV5OWVaYURYL0t4NHNLbHh3cHR6VlQxVm92N1Fq?=
 =?utf-8?B?YzU1TjNWWk9Od0tYRHZiRWY4b2tXSEYwR21JL3Z1Wnd4eTdQbFVBT0RCbDJo?=
 =?utf-8?B?aG1qMy8vcy93cU9QRkVSMzNkNlNlcVF4Q01yRjFoclEvVHBRV2hjZTNmanBG?=
 =?utf-8?B?YzIxRUs4aDJjbWUzVnViYU5INk9KYnViNFdveG5xRERPREc3dGNiVVN5TGsy?=
 =?utf-8?B?aHp3UHRIRzhhaGE5cml6ajJDMTBDN2NwRHJ4UjY3MmZLZzJFUWd6aTd6b3Ez?=
 =?utf-8?B?Q2dNeHBQMW9RKzZxb3hVSHVnWXRISzVtOXFXR2NpcEtlZGgvNjJHUHAreXJU?=
 =?utf-8?B?YVFiVkNDMkRCcmNGengrUVdzZkxqeVZoYzNtNDNEcDlhbXZZdXBJNUt3MmVu?=
 =?utf-8?B?amtLdEExWTVvVmRLaTk0TTJJK0dHdnAzOHdzS0sySG9xSXVzTVZPVGNZeHZ4?=
 =?utf-8?B?ejlESldncXZjQkdRKzUxVVdPSHZCaW5RSzVSRXFrYkFhazlSZFpaUEMxaTAz?=
 =?utf-8?B?RHJWeERQK2ZzalhRQnE1cXFYeTVnN0ZQRmVBcFhMaVZVaXpOclZnSCtJTHFO?=
 =?utf-8?B?SlhlRHZGd3IwRjljVnVjalFwZ2ZoV24rTFV0b3hRN1djNjIrRFdLcXJkTzVW?=
 =?utf-8?B?OW93UGs5Y1ZMekFPVVZ6a1plUWZ4R09BdTkxbXROK0F3ZHdIa1EzRTdlaC8w?=
 =?utf-8?Q?uCUTguRJWucuSHH07U=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aURDc1dzaXVISEJtVGR1a1NDblpjZjlEcU9vMTlZaDkraFNodmdCbDZHU2xL?=
 =?utf-8?B?ajNHdW1vRDYwRUNHUjBjL3M0TG00WS9jR2xCYnA0ZjZtNGVVNUFYMS9xM2tD?=
 =?utf-8?B?YldLU3k4WEN1dlErZGZyb3JQdk8rUmovQmpzbnB1ZFpPa3hPeEFYUXlaalVL?=
 =?utf-8?B?d0VEZ0Fra1A4QmpmY0liS2tMRituT0F0S3Q2QjRpRUk3ODNrVExMN3hENkRV?=
 =?utf-8?B?WEZJYis1MGR5OXNITVFTQkdSb3EzVWZwdXJMWHFNbVRkSW9UYVpXTEdwOGVN?=
 =?utf-8?B?bHFLR1o3c2xCZ25xYldUMzJKMjRqeHhsLzZjbjdUZzg2eC8xMXpTUG5VUldW?=
 =?utf-8?B?MFVZSW5WamYrU3BzMGhOZmhFWHc3dGpYcEhPelJUdzc5YW9EM3ZyL1dHV3B1?=
 =?utf-8?B?N0YvbWtIcHluQjR1d3lidVNHc3NwVTlXVUJIMmRvRllDcGZEMjJWUHAxdFg0?=
 =?utf-8?B?ZzFYbkszNjhyY0RocU4rNGtuVVVJVWlwNEMzYzlOVGNzNVhEb3BWOUJsTFd3?=
 =?utf-8?B?eWEzSEY1VS8wRHRWZ2E3NmFoSGhCc2MxdVdFOGxFeGNpL29UUDV1dFZieDFu?=
 =?utf-8?B?K1NscUtqc3ovS1A2WTJKeHpsa0lTamFJNnZSL2lUQ2ZBY3Bwc2dtZDNNSEZV?=
 =?utf-8?B?QW1xcjJ2V3lLMnNHQU5BejlRY05iVW02OTJrMCtvdGxBUWtkS2NCRFI1T2k3?=
 =?utf-8?B?aHFQS29rTlJhZEFqaUZCd1pRSEVtUUs0bDM5SHhpQ2FuVUZGZTNBVVdvSll4?=
 =?utf-8?B?QTMrQWtvM3N5WW1XK0xhNVpsYS9XTkI2MlYrZW9ISFJTYU1vS2lxeVdWTWJV?=
 =?utf-8?B?enVsZUpXdTd0emhrWEpzUWhPVHZHV3FkWXBrQ2tFVEg5RGw2akJ1SDJhMTJj?=
 =?utf-8?B?RzJaY3IzcnBJZDlRUkRReTNOenhSU0x2RUZZRUwxYVBjT0tTNXVuTlJSd29p?=
 =?utf-8?B?UlJNU3BPVWh4SSt2dXkvNVE0M280YWpFNjBrVkxTQTNxejVhQWRIS0J3emVZ?=
 =?utf-8?B?dDQyUk1RSWIzbHhNb3k2NHVKU0NTeHdNUy9DdEN4QWRROE9zek15eiswM0V3?=
 =?utf-8?B?dWlPTFFYb2ZIdkdRN3ozYVFrN2xCT0RyRlFKQWdUUm9HMGN6MElVeHd6VE12?=
 =?utf-8?B?QXRuQXAwRUFpOWhtK09relc2S09tZmtQYzhwdHB5ejlibk85UDluTHVaTGJy?=
 =?utf-8?B?WWZQR3hhZkd0b3VqOElaR3pWR3h3cnAxdkkyTkNuQ2tzUlBFeUpzdmdTanFx?=
 =?utf-8?B?U3c4TlNVQUJSZmk0ak8vakdPeFJiK2xIeDEyZG9kdXJIYzJXL0RMY1QyZGRq?=
 =?utf-8?B?bHVzVFUvd1lrd1NPV25vdnNRcTRWYWsxSFRMTWkwQ0hkZzhEalQrY1ZMTGpH?=
 =?utf-8?B?SEJ6eXVobEZQazlsYk9jZExLdTBBOHRMQ0NXWkJBMkYxdml5a1VRUzdvbW1X?=
 =?utf-8?B?SjhxWDBnMEFSOEFkRDNmNUdBa1ZjZUs0S2dkY1o4ZDlVUE45SmUwRm1CYzVL?=
 =?utf-8?B?MjRINVJsaFdZT1VSYmlDSXZnL2g1cHgxM2Rkd1RrVGRtOGd0VjVDQTdpRmwz?=
 =?utf-8?B?eng3SVM0K0ZqdU0zRXNoM1dBRnhlYXl5ZEJPaVFVZzU1MUdwTXhyZ3RuY3Zn?=
 =?utf-8?B?ZEkyTVFtbWpPVzhlTkU4dFhESHhBUkVFM1NWUThqczlyRmFNVXFMZk5xRFRu?=
 =?utf-8?B?ZEhIc2lDQVZCdDlmNnM2RTZ5N3dNU2g1Sk93VUh5VDkzTDlncnIySTFLc3Av?=
 =?utf-8?B?MGZNbWl6dXhKM2tSNmhUbHM2R1R2ZVpYRFBVY3U2NVJxYTVEL3c1ZjVNSHE1?=
 =?utf-8?B?MkQ5d1JsL2ZsNVNHNTh5eFpKR2l3ZmxXVDdRbnVaVkNNMVFJMU1hTlJ4OGMz?=
 =?utf-8?Q?sUpTNNWneb4Om?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-5f51e.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: abeb66ef-5955-49c5-578c-08de5293e2d2
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 11:07:05.8910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR01MB6054


On 12/22/25 10:14 AM, Wei Wang wrote:
> On 12/17/25 12:24 PM, Alexey Kardashevskiy wrote:
>>
>>
>> On 17/12/25 03:13, Wei Wang wrote:
>>> Before requesting the IOMMU driver to map an IOVA to a physical address,
>>> set the IOMMU_MMIO flag in dma->prot when the physical address 
>>> corresponds
>>> to MMIO. This allows the IOMMU driver to handle MMIO mappings specially.
>>> For example, on AMD CPUs with SME enabled, the IOMMU driver avoids 
>>> setting
>>> the C-bit if iommu_map() is called with IOMMU_MMIO set in prot. This
>>> prevents issues with PCIe P2P communication when IOVA is used.
>>>
>>> Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
>>> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
>>> ---
>>>   drivers/vfio/vfio_iommu_type1.c | 14 +++++++++-----
>>>   1 file changed, 9 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/ 
>>> vfio_iommu_type1.c
>>> index 5167bec14e36..dfe53da53b80 100644
>>> --- a/drivers/vfio/vfio_iommu_type1.c
>>> +++ b/drivers/vfio/vfio_iommu_type1.c
>>> @@ -583,7 +583,7 @@ static int follow_fault_pfn(struct vm_area_struct 
>>> *vma, struct mm_struct *mm,
>>>    * returned initial pfn are provided; subsequent pfns are contiguous.
>>>    */
>>>   static long vaddr_get_pfns(struct mm_struct *mm, unsigned long vaddr,
>>> -               unsigned long npages, int prot, unsigned long *pfn,
>>> +               unsigned long npages, int *prot, unsigned long *pfn,
>>>                  struct vfio_batch *batch)
>>>   {
>>>       unsigned long pin_pages = min_t(unsigned long, npages, batch- 
>>> >capacity);
>>> @@ -591,7 +591,7 @@ static long vaddr_get_pfns(struct mm_struct *mm, 
>>> unsigned long vaddr,
>>>       unsigned int flags = 0;
>>>       long ret;
>>> -    if (prot & IOMMU_WRITE)
>>> +    if (*prot & IOMMU_WRITE)
>>>           flags |= FOLL_WRITE;
>>>       mmap_read_lock(mm);
>>> @@ -601,6 +601,7 @@ static long vaddr_get_pfns(struct mm_struct *mm, 
>>> unsigned long vaddr,
>>>           *pfn = page_to_pfn(batch->pages[0]);
>>>           batch->size = ret;
>>>           batch->offset = 0;
>>> +        *prot &= ~IOMMU_MMIO;
>>
>>
>> Do you expect IOMMU_MMIO here, why?
>>
>> Then, what if this vaddr_get_pfns() called with vaddr which is some 
>> RAM immediately followed by MMIO? The whole vfio_dma descriptor will 
>> get IOMMU_MMIO, hardly desirable (also quite unlikely though).
>>
> 
> Yeah, thanks for pointing this out. The current implementation logic 
> allows the adjacent RAM and MMIO address ranges to be handled via 
> separate vfio_iommu_map() calls (in vfio_pin_map_dma()). Given the 
> issues you mentioned above, it might not be appropriate to clear the 
> IOMMU_MMIO flag here. I’m considering removing the above IOMMU_MMIO
> flag clearing in vaddr_get_pfns() and adding the following changes
> to vfio_pin_pages_remote():
> 
> out:
>          dma->has_rsvd |= rsvd;
> +      if (!rsvd)
> +               dma->prot &= ~IOMMU_MMIO;
>          ret = vfio_lock_acct(dma, lock_acct, false);
> 
> unpin_out:
>          if (ret < 0) {
>                  if (pinned && !rsvd) {
>                          for (pfn = *pfn_base ; pinned ; pfn++, pinned--)
>                                  put_pfn(pfn, dma->prot);
>                  }
>                  vfio_batch_unpin(batch, dma);
> 
>                  return ret;
>          }
> 
>          return pinned;
> }
> 
> *pfn_base is the address that will be returned to vfio_pin_map_dma() to 
> do vfio_iommu_map, and rsvd indicates the status of *pfn_base — MMIO 
> addresses are guaranteed to have rsvd=true. Thus, when !rsvd, *pfn_base 
> is not MMIO, and the IOMMU_MMIO flag needs to be cleared.
> 
> Then revisit the two corner cases:
> - RAM immediately followed by MMIO: The first call to vaddr_get_pfns() 
> will set *pfn_base to a RAM physical address,  and rsvd will be updated 
> to false. In the subsequent iteration of the “while (npage)” loop, 
> vaddr_get_pfns() will detect an MMIO address and update dma->prot to 
> include IOMMU_MMIO. Since the value returned to vfio_pin_map_dma() 
> corresponds to a RAM’s pfn (with rsvd=false) obtained in the first call 
> above, the IOMMU_MMIO flag will be cleared when going to “out:”.
> 
> - MMIO immediately followed by RAM: The first vaddr_get_pfns() 
> invocation will identify an MMIO address, set *pfn_base to this MMIO 
> address, and then mark rsvd=true. When going to “out:”, the IOMMU_MMIO 
> flag will remain set.

Hi Alexey, any thoughts on the changes above?

If there are no objections from others, I'll send a new version with 
that update.
