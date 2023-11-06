Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2084.outbound.protection.outlook.com [40.107.101.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24821A5A4
	for <iommu@lists.linux.dev>; Mon,  6 Nov 2023 11:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GyKgXo22"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jmhFgfv0a5IuG7CWEWBMuebHIs0BX2k5/5UPsCkEujQDkLfpeEXqKFlYc9eecwIINJgJkINmpJsWBrovzc7JN0FAUaDAzY0IaEjedh2nv4fJ8tKsYmRz0WA+Gq2IMcaL3depvEN4JQEj26ayrs/4boUFN+Mk97GCMViMTzunUchuQPCCSg3iu0LYg1m0l32gXPSylg9RXAA6p1JDMhHPCkUm56XrHJIikwTWrWHrBHxljPH3YIjbMW0ZIaaC+z2XuUbAjiws9rYaeooeePqkLmtW2QcQYgjYUibUITpkWJ7NuNKefTiuNvYg6+ChZ/9ulln/d+Ov1/FXTkMbLxi9MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5BwqONwJuNTbpRKuiR0+ldcX/D3qOxJHZ117Uc/HDt0=;
 b=FuczUoiK6Rs7AnuIKKoY23kgkU6iK7zsqdUimTIhQwyoWYAEPfSanonj14RdllxdAME/LCvf3D2ZOQKw80HXGhUYJ54OMaj63uCL1dy7rBPXXIfGScw1KcSZ7E//VJWTybGyQw6XF8ka6jC9p56/AELmEBKv1AHK98BLEtKhUYJWgMCgOsAqTilquNFfDjQCmBijr+xCCIeiOI9Fgb1YkZK2P0gCOeDweg9JQd14BINzBL6xKmmocvZ6t8u/Vk/eYDLEEWP0nVFaiquAMxRBeBhzUONjbq8n64k+782E0QA13K2NmtgVCMvG4ce9Px1eAYgT7ZDGJAwjiligio3XfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5BwqONwJuNTbpRKuiR0+ldcX/D3qOxJHZ117Uc/HDt0=;
 b=GyKgXo22pcdZR6yhHAXGrp0KILkHEFxeNj7ldkGYG4+uCb+J49C45iZFfG3mqQJb5sxHri0+73XF2doaGIs+hniwMF+WTtOnHOg6StoX+wMbjMVKdHPlY2N4fykbIfYpeHItIQObzmlRezp3OT8uNGdLGWb5qXFC2mvkz2MPWEw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 MW6PR12MB8735.namprd12.prod.outlook.com (2603:10b6:303:245::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 11:54:42 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::befc:daea:28e6:32af]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::befc:daea:28e6:32af%3]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 11:54:42 +0000
Message-ID: <0de29c1b-fd65-d781-42b8-a8322129c33e@amd.com>
Date: Mon, 6 Nov 2023 17:24:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 02/13] iommu/amd: Introduce get_amd_iommu_from_dev()
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20231013151652.6008-1-vasant.hegde@amd.com>
 <20231013151652.6008-3-vasant.hegde@amd.com> <20231105180516.GF4634@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20231105180516.GF4634@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0171.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::14) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|MW6PR12MB8735:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dfd864a-0506-4b74-576e-08dbdebf2944
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AjCQrzOatkqNoMapWG2ZKy2UlvAF4WcEESgRMgh8r54XTHXll8PrqX7ufFatQcq90T14LiKUjI0Foc+pSqMEdbBxlCqDhXatFAC2Od/I/wlS30BLEqDEftVPOOVZiAXnLZQd9tWwDkRqA2v02RFTYm02z3HCEBUdU7D6u8XjbguKbsKjhk0IuWecxEF9o96u04kDZRNtszA87TDYMx8Eiv/zbCE9waslwi58CIGm2052gjN3ReLb5ScIDBd2QIf6k6lDTXsDUHi+SkB1MDhQRDRCuf+xaFhrMwofdP6IaF002V3T6Rck4ELXDpuNZIShCTEyMdMeIEwLA5y15xMzBFLDxA8dLpIeCDXcLf0LCGgyzA33wKvOE3ghtoibuXgM4dgawDzV1mQAEZO1CsaCsI1t7EnSz9ThiFcvZ6Myl1FaCzvK8AJBZpb5Hw7AYfXa2wa5g2faWiQnuOfCNE8697cIZRjh6NiKIrtFmP9wNoxUCElSsKgu4IYWDyygcuP5nkoZTwTF1SL0FbjfWbxt+IOPC6VdSTfpAmRlg4u8ostzC5UTWoNoXNVkxosjo8O9bsv1A6ip0s6sIbh5Yg6kX9RSCKOViWz0yuUYEiqeFRQ2Bdwh7OfhUH5JrLaz3mxpgBncU34jh8eV1FOdyxUr2Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(346002)(136003)(376002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(8676002)(4326008)(8936002)(41300700001)(36756003)(2906002)(38100700002)(5660300002)(31696002)(6486002)(53546011)(66899024)(66556008)(6512007)(316002)(66476007)(31686004)(86362001)(44832011)(6916009)(66946007)(83380400001)(26005)(2616005)(6666004)(478600001)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzMwMFBYSTJVTXBnVEVQcVdoMGFJYzZLekIzSEcvVm1xUGxjV1hNenV2aERx?=
 =?utf-8?B?RFZFb2NhWWo5Rk9xdGFHQWFEUHdHWGVDaDI2Uk1qdnZVUlZRZlZ0RTdQQ2xt?=
 =?utf-8?B?RnI0RXN0dngzMTRvVWkySUNCR05NNW5NejlDWUFhdHlNa3RaZjFyalhneThL?=
 =?utf-8?B?aWl4cXNxclVWSkFZNkdGUjFPN3phZG5Xa2VHNjdwNUYzcVdCNkpNYmtlTFNK?=
 =?utf-8?B?QTBXNVBhSUd4cVFKYUNkeEx3M1Z5VkZWTkJlWDJvY2xPdytralh2bmIyS05U?=
 =?utf-8?B?VG1WbC9WditYYUdRN1l6L3NFMlJtVC9YWjNzK1dnTUxMOVFOcmhDZWh0aGEy?=
 =?utf-8?B?S043RTNVVzVzTXk4UW1ubXZLQTNHa09Lc3J3OGlJZTAvTGJUK1hoNm8rY2xP?=
 =?utf-8?B?YmhKbGNJek1HaEhBcDFXMDJaOXlnbndBL1M1NlUyRUVIcSthWjJMbXhTdGNi?=
 =?utf-8?B?WE1xMkcveHlObGIwbDVBNlZpT0czTDRxQ1pmdDBCQnlkMHdKSWZlbUR1dVUr?=
 =?utf-8?B?RjR1ZUdPSGVBdXpNM1psZUNvYUJtSFdsWWI4d3JoZUFqYWtBRnlWYVJvWDVQ?=
 =?utf-8?B?aExuQW85V1FxQlFBUkc2OXU4N1RDT1BvT3lLSzU2dWEvN05qdDNKSnBYZFho?=
 =?utf-8?B?aG8zOGJnVjBPU2JhRTU5RTg2SFNiSW1laHNkSE9pRi9WMmg0V1RtZTNFOWdm?=
 =?utf-8?B?Q3lpaEo2U0szOGh5ekJvUm9CRUk2NURqeGp5VFRpS0JyK3VhRzI2UEVGMith?=
 =?utf-8?B?VHliU1Ric3ZiaklveVNSZVd2TFA4Q25kcjg4em1RUmhlczFzMlRiamIydDhy?=
 =?utf-8?B?K1hTellUMWJ1UU4vNEQ0aStDNmVxVno4ck5YRDIxbzdSZU1ralhFVjlWN0o2?=
 =?utf-8?B?aTJZaGw3OFh6WDZVM2xyUE52ajhMWWxLVzg4alh6TjJiWCtycm9mR2NkNmU4?=
 =?utf-8?B?TG9UVE14elRqaFE0U0tNdjNrOVJrMHFJL3ZWTFFndDNRRjFlOTB5RUtmNDBI?=
 =?utf-8?B?U0Z3ZWxMMlNicmZvTlJ0WldSZE9xcldaK1J6SCtCV3YwcGFKeVBmV2hjVmpH?=
 =?utf-8?B?MWJWZXFQYWRNSjR4enFiRnBWT2g4MVhwbjlBWHVNVlN5QXRyVStWdHVlWndq?=
 =?utf-8?B?ampQcElWVlZ3SXNUTVB2VVd0Qk9BdzA0TDY1SGFObndtSWFhdzlnS2VxRDZZ?=
 =?utf-8?B?R2lBTXZ5NDg1NjdOVTgyb2Q4K0d2MXdYSzRuZ1RybWdOWFNBV1BoNGQzcjdE?=
 =?utf-8?B?WUZqUkUxSTh0UkNWOXRIT0tTWlFWYkxGZ2JFWW8xMWtaMFNDZXFELzFQbzAx?=
 =?utf-8?B?Unh6VjVtKzY5NnBsYnJXUjV4TW5uRk1hb3RsWVZCdk5OMUllU2hNMnlDVXhL?=
 =?utf-8?B?M3BBb1BmWVRaUlBRV2dJQnV5UWgycVo5a0xta2dBaEhVQU5DSmVYWGtqcGNQ?=
 =?utf-8?B?OStWcktPeXpOdGxZTmg0dTk1Q2VjeXJzbmYrbkhTQUozVE5kbTVmN1ZPaWZw?=
 =?utf-8?B?cGordkloZkFXaCtnSS9jb29Jd2R1eUluZ1BNSkRHR2NSNDhqMWd3aVczREtN?=
 =?utf-8?B?akdqbU5hdXJPdGJ6cSt3dUlrRGZwRkl6eGZxM0tuMVo0Qlp2c1EzaDcrblMx?=
 =?utf-8?B?RXdoZXlMaFJsd1VMZkpqNEhqYXZ1VTZtbjVLY3lrNXFlOFZkd2pGam03Rjdx?=
 =?utf-8?B?bzBxUlRISXJybGlvbkV2bU5oakdhNlZERnN2bHZ6WkZIaVcvK2lmd0c3QUJK?=
 =?utf-8?B?aDA5NTBzbEVabnlPVGZ5OU1pMzByTTlRem1HV0hjalNtRGlQOU1yV2VXd2d3?=
 =?utf-8?B?Z1VjNXRiVWgrZTdFaHVhNmtzRTFOMEh0VnlhUTJsbHBJMUZmcUo4d0lqdlpV?=
 =?utf-8?B?Y0NwY0RTNnZGTDJia3ZMdnFNSlJnMXpIcE5PbTJXdnZ4UWRvSzNIazhkOEVl?=
 =?utf-8?B?dk5xN0NpZm9tY3NGc0VkblJCMHpqU09tVndVV3g4cldYSVA0NWZTQkt5Vnh5?=
 =?utf-8?B?S2lzY1Jucm1jUFJaa1VSaXVPL1VrVWpoV0xrbG9jNitReVZQK1dzOXdjVTFS?=
 =?utf-8?B?M25ocWhYVXRPQmdhK0pkRjAvNXRNZUZmK3hCQVBQRDRnT2RCZzZjU0ZOSFgv?=
 =?utf-8?Q?Da1/uN9j6udgM74hNb0rqRldo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dfd864a-0506-4b74-576e-08dbdebf2944
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 11:54:41.9291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MYpRDpKW/Ez9a0sBH93CKTypLpqvWVpABlJ6tBA7d6JYMTsn7gRSYBAYEtuARxReUl2xi3CW6VytnyufdRBfgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8735



On 11/5/2023 11:35 PM, Jason Gunthorpe wrote:
> On Fri, Oct 13, 2023 at 03:16:41PM +0000, Vasant Hegde wrote:
>> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>>
>> And replace rlookup_amd_iommu() with the new helper function where
>> applicable to avoid unnecessary loop to look up struct amd_iommu from
>> struct device.
>>
>> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>>  drivers/iommu/amd/amd_iommu.h | 14 ++++++++++++++
>>  drivers/iommu/amd/iommu.c     | 20 ++++++++++----------
>>  include/linux/iommu.h         | 13 +++++++++++++
>>  3 files changed, 37 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
>> index 38b3f4562f3b..b2071ebc73b5 100644
>> --- a/drivers/iommu/amd/amd_iommu.h
>> +++ b/drivers/iommu/amd/amd_iommu.h
>> @@ -150,6 +150,20 @@ static inline void *alloc_pgtable_page(int nid, gfp_t gfp)
>>  	return page ? page_address(page) : NULL;
>>  }
>>  
>> +/*
>> + * This must be called after device probe completes. During probe
>> + * use rlookup_amd_iommu() get the iommu.
>> + */
>> +static inline struct amd_iommu *get_amd_iommu_from_dev(struct device *dev)
>> +{
>> +	struct iommu_device *iommu = iommu_get_iommu_dev(dev);
>> +
>> +	if (!iommu)
>> +		return NULL;
> 
> This shouldn't be done. See the comment for iommu_get_iommu_dev(). If
> you are calling this outside an op context it is broken and the if
> won't save it.
> 

Fixed.

> Ideally you'd put these calls only at the top of functions
> implementing ops and then pass either the amd_iommu or iommu_dev_data
> pointers down the call chain.
> 
>> +	return container_of(iommu, struct amd_iommu, iommu);
>> +}
>> +
>>  bool translation_pre_enabled(struct amd_iommu *iommu);
>>  bool amd_iommu_is_attach_deferred(struct device *dev);
>>  int __init add_special_device(u8 type, u8 id, u32 *devid, bool cmd_line);
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index 4f1b356adb8f..eedfa341085c 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -1408,7 +1408,7 @@ static int device_flush_iotlb_range(struct iommu_dev_data *dev_data,
>>  	bool gn = is_pasid_valid(pasid);
>>
>>  	qdep     = dev_data->ats_qdep;
>> -	iommu    = rlookup_amd_iommu(dev_data->dev);
>> +	iommu    = get_amd_iommu_from_dev(dev_data->dev);
>>  	if (!iommu)
>>  		return -EINVAL;
> 
> Eg here we have an iommu_dev_data which must mean the device is probed
> and iommu is valid.

Fixed.

-Vasant
