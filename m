Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011057.outbound.protection.outlook.com [52.101.52.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A732ED846
	for <iommu@lists.linux.dev>; Mon,  8 Jun 2026 02:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780886738; cv=fail; b=OtVyTdrPpozt64AtluLopylcs9aMEa8jpAmwPZwwFA+Npquzb4yuUvBtdSRDMRe8WY/g92/J71khhXceyl74bBCyPsHJ51Gh4yoaEORPFpKrSW+NBFA8wfk1LeU62oHb52DKE891/IgPXUUpksa9o3f94GBvtE0jJj9qyp3ctx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780886738; c=relaxed/simple;
	bh=dyX6uIQ8z2AaS+ujcxhWEjFGXIcyrFWIRRPj26DP3Xc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u+r8p/V85t8bJqrCQF5Etb/lYwV41kzp+wzfNt8STFMEDSTVPSzoN4gqXsl0JhLsRKgqa9gCvDHw7LsqH/WPhsgdezLY4PSAmQzRJc/BcxA1IF+6TFMu+uPbUiQkDCvKeo9kJI0LT1258CZsEZS2XUumvYcl9STLog5FRtDIPRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jgl43vjp; arc=fail smtp.client-ip=52.101.52.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jgl43vjp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sCzq1oQXw3fYQJv1K4r41qsfIy0b0hiA/mA5HmIrzoHfcRVguAAtWviPJHjrmB4B/bgHMZwzo7kJ7I7rrlrMqAy/aLA/xdl0oU0H0N+RLxwTcuxgar+TEsIas+DCC0/SYtxLahTyrXrg5s7JSAubjkL9fFvNWdzgPa9yQAAFkH57vJrEE9FjfIU5UH4QBbuXXW0hYKgiYTDQ3tXALGn+mXrdQc1VljQ77KxDHjMJkWEUZjny7o678sg08odjJF1uMRjLMuRgFpcL7I1/K07EDomj9wBcMTSjJ3PW4n+ZA5jXBL4x3OV2aK5faFsAsTyCY58/si0kxeaRv5cmqFp/fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mUlHrsdQkzuDWI/pNOJqNIlDwzcowaidi3YYGC6l2vw=;
 b=En4Yf5CVwCEujJ+mzOoNk8yrKUPSpTsmY04yrGBiC6WAYtdFzwmJDWJ+lqgq8xujTKXocdinf/GYFS+o11WO3Q2Bi97msSMRoI3EtlAldHQGAAnOra43A+ZTMnJLhZnTYESWGuSANOle6cmJdHm97p6KLjiDOIh0ic7rBPc88E360ye4NoQ8s6iOOKTT8FOJxSSF9VgtcdK5JLEUECTUcG6YTAM4D6qUE1lYDbFCUVf4q3+C4h0uIeneOUe12V96antzHzUynl0wFk5WU2MSL/IE/OsDUB5IjX2X6lZapfMfPQVgocOJnpJmJ7nyBLY9s4C46ghDUi5C5xh2UjnVpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUlHrsdQkzuDWI/pNOJqNIlDwzcowaidi3YYGC6l2vw=;
 b=jgl43vjp1wXeF5p3KK6y2QgG6FXHUgdm/ZNRGm4fCxakU+BVxNu/HHzASDF8rwHZrLKYwlxeEWIc9Yco0qgIgIO0HEZpClYxoCNqQFuwnAiOmwxBSPRBy4stqL9wTTNrriVm9SAJ8Cj1UkAy0LJr+pxhs6A+PufJZKRewIWD/Cs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSSPR12MB999236.namprd12.prod.outlook.com (2603:10b6:8:374::10)
 by IA0PR12MB8206.namprd12.prod.outlook.com (2603:10b6:208:403::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 02:45:32 +0000
Received: from DSSPR12MB999236.namprd12.prod.outlook.com
 ([fe80::8a48:f674:71b8:d21e]) by DSSPR12MB999236.namprd12.prod.outlook.com
 ([fe80::8a48:f674:71b8:d21e%5]) with mapi id 15.21.0092.006; Mon, 8 Jun 2026
 02:45:32 +0000
Message-ID: <f5d028ff-872f-4fa4-a576-9e03c0326354@amd.com>
Date: Mon, 8 Jun 2026 09:45:22 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/26] iommu/amd: Assign IOMMU Private Address domain
 to IOMMU
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 sairaj.arunkodilkar@amd.com, jay.chen@amd.com, wvw@google.com,
 wnliu@google.com, dantuluris@google.com, chriscli@google.com,
 kpsingh@google.com
References: <20260528051738.596013-1-suravee.suthikulpanit@amd.com>
 <20260528051738.596013-11-suravee.suthikulpanit@amd.com>
 <20260601125958.GK3195266@nvidia.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20260601125958.GK3195266@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0022.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::8)
 To DSSPR12MB999236.namprd12.prod.outlook.com (2603:10b6:8:374::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSSPR12MB999236:EE_|IA0PR12MB8206:EE_
X-MS-Office365-Filtering-Correlation-Id: 18893727-eaa3-47cf-313c-08dec5080213
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	c0gTHIj3qMW9ayVW1hiQMLvtsrp/EsxSnY/gJgJLoGBrI3jAsfSMNxi+be1XY7qqx9WTGh6QlwiW5EgQ21+nZaEByvUJbnhuAVYVTdaWj1LzCg6BXAEjuzGPT6aLEJaLjLLQlD4DlfUXcY1NAzlIOSDNCANCrxQxeRKkvzs+HxSEiR/RBh0TeQqAxMDKc+hEsYYsHC/TQA/sROHx9bzQkC5VfBySnnFFwxhVQTmQpqvaJ5HJqTRneEbRp+vdBq7rmu/03jhQAzOLpP0RaNt1A1FOUX29tAQXV4GtEBokO8nkGDqPaqqpRC/aZIn+hwsGqG0hJwVJPdTFjqD/iOHXzWTDbunhriSbUOhb87C5ys9pkMz2YNnFHySGB9KL1f32LabWOqaHEO5o9yCZYNcsOmWdGqsskK8xWGkgmBnQHCt9bFUhvNkFD0p7WkT/acBw3YU5wOsWaK1mkad3sz8Nu2r9qShLdDmxFAoWKPfOc3SmUbkHEfj5exw/gW5B00/pybrGi/cXxMZNWVFo/Wh5s7Zc6odi2DuWYNZqLQhqmWhZYCwLzsvHBYlTvsr66l0VmwTdhGClcx5ek9eGUgRFk4RcRq03KrJfJx3SgMixstxpfar1JYRdU5Gi9D1SMowGxziogsuliOiahrxj91XXPZMEZZr55va7aNG2tV4IGkiBMSuBlWlR6LC5HX9fGpbC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSSPR12MB999236.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STdMUCt5ei9wR3NHb0EvK0hzSC9BdW9pOU9YZ1lQNzdBTzVxRmNJTS9EWXhU?=
 =?utf-8?B?TTN0SmxhSGZBa1g3NDFhSStIRnk4WnRqRXV4dXhRaHhUdC9PTlI0YzZEbHdQ?=
 =?utf-8?B?SkZzczZrNWNrOEVPaDNxWkNJbCt1dGpja1FyTGdsK2pWZG85RVhqM2NJb3ov?=
 =?utf-8?B?YWZib20xdTg5LytEYlB0SG1xMmd4bnZ0Q2hxc0ZRT1VRZ1BnTWdVRXJWMkV0?=
 =?utf-8?B?MG1McEp2dmlmT0lkbTZmYUNVVTlaUng2S2VvOTRXOW1BaWExVk4ySkJrSWIz?=
 =?utf-8?B?VjR0RnY2bEs4Tkhsc085cWM1dFI5dmRzOC92TmFIWTFWQzMvYk43YUJRVlox?=
 =?utf-8?B?dUE5MjV1a2pubFg1djhPQ1NiN3VkWnVEb2YyWHNzR2VPOUNpemxIRzlYNjF6?=
 =?utf-8?B?OEJSb3A4UHpIZVBieTN1N2Q2ZjVGS1FwdXV5cGdlUFhsdnZSeHNXRWFMZ1lS?=
 =?utf-8?B?RnBycENDQVVMTThYOFpnQjAzUmI3L0FDSUZ4d1dteEhnd3hrSFBLTEFmWjRt?=
 =?utf-8?B?alBZbnFKYkovV29aN2RIWWtkc3FyVnJWZDFiRWR2N1NKVGZiUWVuSWdZSGha?=
 =?utf-8?B?QWVseHk3NlJYYkkwb3pPR1Jld2UzNWRYak4rUGdVNVNsYVdEbGJWSUcva0Y5?=
 =?utf-8?B?eDRZQWNmQk00eVBuUGxpcGdUNElOcktoN2dBSjBXMFVsZE1GeEx6dkhwUUR4?=
 =?utf-8?B?cmIwZXhzbDQvbFNOYURCNFlLbHAyZlFTLytTVzVvVnpvQWlYenJhRm9LWlJt?=
 =?utf-8?B?bzV0ZXVuRXFYMzZ5SmN4TlRTRWNSa0R5N2VPY2xwbTV6SFlrdEMrREdlZzY3?=
 =?utf-8?B?RVpkcEFEdlNBenJzUU82cmIvK0lRODdaZUEzanNPVVltQmN2ZDBqTXdoeHhm?=
 =?utf-8?B?dldVOFpocERsbmNNTWRHcjlIZWI2cm9ETEY1Q1MzOUdxWWRhdDZQYjFKRWti?=
 =?utf-8?B?U0x6Wm1sNFZXSGVheW55SE9lLzVqV0FRRFpUd0gvb1ZnN3FVS1p0NndjSjhK?=
 =?utf-8?B?SVJsMU4rN3h2QWdNSEhReWlDcGdzZlJXRERLUE9YdmRKaVpRTzlSR1FJSmxa?=
 =?utf-8?B?WERTUm5FUEFIdTd6WkpIVUY4RnM3MDlMSGtyeTZIMllaQXFoUTB0Qk1VWmlZ?=
 =?utf-8?B?T3duQU1aNVhjS1pHcmI5OVBoU0Y5Qis4bVlJWkcrVUxrU3A4ZjRIVmpjRElE?=
 =?utf-8?B?NDhWWEJ1TzB6dzZxSjNkMmREaDQyM3ZIb1YvVVFuWVpIcSs4VlJyUVhYSEpu?=
 =?utf-8?B?NENvM2pIRFdwOGE5ak1SWm5UcEd6TlNydWpvRDBTL2ZkWmtMVHVJaFJDWlo2?=
 =?utf-8?B?Y3VQUmluZWoxenFLRmpqbk1QTTBrNGRCaDdSd0gvaGlpWXora1l2Y2thdlR3?=
 =?utf-8?B?c3JoYlNNMStvQnBJUG01K01wS3BMci90K2dFVE1DWG90STFtbEh6MVpDWndx?=
 =?utf-8?B?NXVEdzdVODJnQWFlTnBQRys0Ung2dFp1M3hPUUhPMnZlN1hjSVFKWTZtNFNw?=
 =?utf-8?B?U3ZhYWIzd2JmQVl2cGdQWnBuQk9PT2phSGIwY0hMSW1yRzFSTXJUTnN2ZlRG?=
 =?utf-8?B?akw2ME11Zjh4R2pYQ2FFZGYzeHlWY0t2bnFtRlBZUHRtTGs4K0JIa3dNUGYx?=
 =?utf-8?B?MVVGalQveit1NjY1aTR5UGQ4UG1BZ2pINEZHKzlGK2lDRnh3aVBrNlpVYnR2?=
 =?utf-8?B?Rld0WTZmWlFhdkt4bm1HYU9FNjdLUmEzMlN5L1BZblpHSkJHSlN5T3h2UFk2?=
 =?utf-8?B?eElMNE4xb1BvYXZ2Z3k2T1dob2F4OTE4cTlnbjdyV2hMNWNFcXA2cUpVTnli?=
 =?utf-8?B?dUMxUFZqQUlOekN4K3VqQS9GNGtIUXV4a3UyOFo4V1lydUpWTW9GOGpkc2dw?=
 =?utf-8?B?bDFPR2c4SUgvYkJYcTBFV29KQ2lWWmREWEZkWkJjZW5pNzdGUzBraTFsY0dh?=
 =?utf-8?B?cUdSUWNXT1E0M1BWZ2Y4TWdlcU1WY3pOSEdHVjVqWGg2OUdzQTFaS2pxZHVK?=
 =?utf-8?B?TFN3eXdaekh5R3ZtVzBGYjlCaWRRSFZtSFg2S2JjQ3RNTWt1M2FRNGQ3b2Jr?=
 =?utf-8?B?UWRxSmxLSEo3SjMvNGh6azFLNEJBU3Y1VitXT2ZmR092RzlaWVZ2VHR5dHVi?=
 =?utf-8?B?T09hVW1xY3BoN0ZDQlIrQ1FvM0svRU5keGFURWJadzNlWEVhakt3UkEwQWV0?=
 =?utf-8?B?NTZJUXp5Y2oyQ0JDbDhNcHZLWTJWa3NOeC9BM21waUdwZjlkemJOd25XeWJQ?=
 =?utf-8?B?N0Nja0hVbGpFOXRvbXpST3JhRUxUVURNNTVxdFNHSFNLSjhGS3B4YWNXRFZ6?=
 =?utf-8?B?MlpHTVdpVmRpbDAzRHdLcDl1Q1c4Q0FGYndKSG05ck9UUktRbHJpZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18893727-eaa3-47cf-313c-08dec5080213
X-MS-Exchange-CrossTenant-AuthSource: DSSPR12MB999236.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 02:45:32.0788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xb9ddb8qDsedXJAiRqI2tDfeS61fSZMfmKcF8K+PhSMNIzfrjm8Y/wi9qQTEXYWROhSOdgffScN3nuDpKECEvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8206



On 6/1/2026 7:59 PM, Jason Gunthorpe wrote:
> On Thu, May 28, 2026 at 05:17:22AM +0000, Suravee Suthikulpanit wrote:
>> By setting the domain ID, pagetable mode, and IOMMU v1 page table in the
>> IOMMU Device Table Entry (DTE) indexed using the device ID of the
>> AMD IOMMU.
>>
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> ---
>>   drivers/iommu/amd/viommu.c | 31 +++++++++++++++++++++++++++++++
>>   1 file changed, 31 insertions(+)
>>
>> diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
>> index 63360eef6b0d..14426649074f 100644
>> --- a/drivers/iommu/amd/viommu.c
>> +++ b/drivers/iommu/amd/viommu.c
>> @@ -173,6 +173,35 @@ u64 amd_viommu_get_vfmmio_addr(struct amd_iommu *iommu, u16 gid)
>>   }
>>   EXPORT_SYMBOL(amd_viommu_get_vfmmio_addr);
>>   
>> +/* Set DTE for IOMMU device */
>> +static void set_iommu_dte(struct amd_iommu *iommu)
>> +{
>> +	u64 dte0, dte1;
>> +	u16 devid = iommu->devid;
>> +	struct pt_iommu_amdv1_hw_info pt_info;
>> +	struct protection_domain *pdom = iommu->viommu_pdom;
>> +	struct dev_table_entry *dev_table = get_dev_table(iommu);
>> +
>> +	pt_iommu_amdv1_hw_info(&pdom->amdv1, &pt_info);
>> +
>> +	pr_debug("%s: host_pt_root=%#llx, mode=%#x\n",
>> +		 __func__, pt_info.host_pt_root, pt_info.mode);
>> +
>> +	dte0 = FIELD_PREP(DTE_HOST_TRP, pt_info.host_pt_root >> 12);
>> +	dte0 |= (pt_info.mode & DEV_ENTRY_MODE_MASK) << DEV_ENTRY_MODE_SHIFT;
>> +	dte0 |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_V | DTE_FLAG_TV;
>> +
>> +	dte1 = dev_table[devid].data[1];
>> +	dte1 &= ~DTE_DOMID_MASK;
>> +	dte1 |= pdom->id;
> 
> Why is this editing the DTE in place!?
> 
> The special DTE should be entirely deterministic. Call
> amd_iommu_make_clear_dte(), and use amd_iommu_update_dte() to write
> it like every other DTE.
> 
> Jason

I missed this one. I'll fix in v3.
Suravee
