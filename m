Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011024.outbound.protection.outlook.com [40.93.194.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78B832B9BB
	for <iommu@lists.linux.dev>; Tue,  8 Sep 2026 06:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788850689; cv=fail; b=HvuowNoaNlb/o/d+HgT+0aRwQsdRmh7xhhpeS7BKTUfMKEF6w8TG74OelOpVVaeEqMUcYR+uJEM0UMY09vqBLtdCkgeR1eydOp9nR8P8f4QJAv9edCKQs/GZUcfFH51qYdBaPo6LmRAmYMJBPEWIsnJ6Y34/3Bwx27NW8jzEn0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788850689; c=relaxed/simple;
	bh=kTX2oiniZENE1fwrMBoaNwZ7eHo0F7Hn3TwAWWZZJEk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LDdqvE01jo8T+C+iuV/tvLUEoAbBAao6fNS2U2W1j+ZVVpMqf7wcFUJIziMxqbvDEuKYhZgxpXwmCg1RTuuGHNgCXuzg7EEt68e3O13s0al6HGE7sXycGpQEliDm/Gmvx811Ac3hwlNjw1aW/9cWTdQHfY1898uZsN2F1GKdCTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kuTu4OOo; arc=fail smtp.client-ip=40.93.194.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kuTu4OOo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A7VkVUNT6t1piXx+zaYJHgtUJsc6cBYPvm9V93aOIMSCMPRyYuMAV6uu1WafNW5kNX/QJMPC6UCAKXJa9zQdGGSw8vmRw1axf0ZRXq4qdEEglo4IjOkOq1/9iagVod9NMCvX+bFkHKWjc4V2xBfJeCVSeOX9SsxBMJkIrpbNlksKgI4HFDw95TPDLktdjQpR11uv73Xqw+KJGeh6Sb5dxyvk+gNfx6uBKs2PEHki6ojOo7br3+SJfX4stimDPLd1YjdG/I3ORIvZFgt/Ue4xu2C4N6BRQaFYAcRVaHIHgREABJskKhssLN+5SnQFbhYbaoS1JlWiw0DDOt6GJBDaZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQbLLxEb7LF4IV+LkKpR+/s4goNq4fW42aRnrKZYeh4=;
 b=TCxQ7Faoa74xRzIPhB13x1l/XaMtMV4ugTeqrf8/IlhI/IBTvE/fhsQatylwYp2sYUZRD82FgJ4gl3fdKWV79pvEM40ZVoTHggRAWkJU8HL6XHRE66RcQB/9TnngNWRy6UEOUXGFV73R9amJFCHvN7BSAzFnv7p5pFiivAL88C6lzooOyCtty6PTPr4IM9Y08Cr7S6sdm5tHvL1TaN3H0ZM73ECRdshG0DXXATAZtNaWlYAKZ/zfjlcSGAmVR4aqHbjAaCjmPhJWEIL/j4bfNnNAx9QlK67WCxSqvmpwsSb/f+wyhWRsqfV8CxYNmB16OqJmMZwqmFRRp6JnCXBlbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQbLLxEb7LF4IV+LkKpR+/s4goNq4fW42aRnrKZYeh4=;
 b=kuTu4OOoFvhBEeEnuFVPgXPbcid/l7nwIWhlT3aW8YwIuT9ZNdYmxy30lQACL2sOfGKK35Kc6iOKUFxWD5zRCMbxuEg6Td8wDCbl5S3RAwisLkAULXrZNekgNDVCxUqggSXvBvPpuOngXT8LwrEMf+LV0cN20BBtEnKlTMBxXOI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSVPR12MB999171.namprd12.prod.outlook.com (2603:10b6:8:388::22)
 by DS0PR12MB6389.namprd12.prod.outlook.com (2603:10b6:8:cf::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.15; Tue, 8 Sep 2026 06:57:58 +0000
Received: from DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19]) by DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19%4]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 06:57:58 +0000
Message-ID: <78e40c23-b033-46a7-af7b-75cdf7148e61@amd.com>
Date: Tue, 8 Sep 2026 13:57:48 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/24] iommu/amd: Assign IOMMU Private Address domain to
 IOMMU
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 Sairaj.K@amd.com, jay.chen@amd.com, wvw@google.com, wnliu@google.com,
 dantuluris@google.com, chriscli@google.com, kpsingh@google.com,
 alejandro.j.jimenez@oracle.com, joao.m.martins@oracle.com
References: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
 <20260727132913.22475-14-suravee.suthikulpanit@amd.com>
 <178759229635.3131778.5081474165505014029.b4-review@b4>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <178759229635.3131778.5081474165505014029.b4-review@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU2P306CA0007.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:14::13) To DSVPR12MB999171.namprd12.prod.outlook.com
 (2603:10b6:8:388::22)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR12MB999171:EE_|DS0PR12MB6389:EE_
X-MS-Office365-Filtering-Correlation-Id: d9e82da0-9db0-4dd8-a412-08df0d7683b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	4MkcQtZyah9lwv+4I7+0b7X0z9SLfOxbP2lsyoyQV7PBX4AmLc0uQsjX5FCZjkdWG0aXMmASuU7Lb6PyI9GEyPUh4A+qXB/DKN8wuUB8AmA3s0LxtDRkRwgRhPlbi8q3dhLX4MD0bEWZMOQ235lfcasLJsGMV4BuCdcCNj2lrNim6zhuo6xtyVEYHDEVzh4NJU1kwkU/ge8MBx22QxwZDuM+T1VLN4b/kMQixQ3MiUzkXR3/Sriqely4I3L0XZi1Huegn5JAvWP9nXkdLkeT1ULWO48aCOfrS1ReLeHqD/kHzCG1Fvp2O7p+VV+STFP12wljRHggEUwhlTztD2J7GL0uRa+BEJzYtNSWchQYMmRaSZCmq86vjUbmyXxoZQyZl5OyegEg2/2NPqRq02tXrUSna6ifqc7416Fi4/u8BXDqbmo9nHdWsKQDC43UnE6wtTUg20CSy7Menk60peGWx1bljl65P4cxndYkMnpwPXXG1h3iov90u15J9nkLyrzSY/vEbnbDtLw8XSvOvADVOEVfHDPMD/icSwNyJRmexkab6nFGR651lta+nmVuithv8rHFv32s5ypp2gadI0WHcNzE63zmAVoxcT0bWNRgLL80mMy0gPNrAaUywsslAUGlz20XHI8JOtmRK5JUOZpfYpenmtK6/u/rblzrr+cIUh4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR12MB999171.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEd6dytEeDVDV2ZGUTJMTlFNQVgxMVNDVlU2cWI1dTVxMW1FbG9Pclg0Q3o4?=
 =?utf-8?B?d3JQRHE1U1VtOUIyOVluQXNKKzcrWncyS2V2cUlQZDVtd1Q5Tlo3V1FmTUFJ?=
 =?utf-8?B?ZlhSR0Yzend5ajlpTlhFTTQzcG13QjBDbVUzaDBXNVpVdjMyU3I3SStzL3Zp?=
 =?utf-8?B?UzJVeEpYc3p2WEZTRzBYWTcwL0FZaTQweWJhZHhMa2pGNm5YTklqUUlyZU8x?=
 =?utf-8?B?QWxxRFg3UDBLUFkrNW5VTXFIejN4c1p4RDg2bm1qamVEOTJlMEY2KzNEYU9S?=
 =?utf-8?B?MFpIOVFHUkF2S1d5Vy9RcXB1aklMZDAwRjc0cW9sQXR1aWdEdHlNbDRFVjE3?=
 =?utf-8?B?SW5pR2YzMDh3SlgvMFJkeER5OS8xd0JDQWxlQ2Mya2lHYlhCSVVhQXhpZEZV?=
 =?utf-8?B?UVVGcHlZQVgrbkF5VlFINGVVaDFPaVJhV041UTYwMVdQRk5VOWFkb0VVR1M5?=
 =?utf-8?B?R3RHQW5ueG5qVWVaeVR4aEMwa1hIQlpxWC9jZ3NjMEZSTjhuU1dwcm43eXQz?=
 =?utf-8?B?TExZNURkb1NSQTI3MTV1cHpGYkhZbSszbDRjS0lrM2tlYldMbnhoWUQvUlRq?=
 =?utf-8?B?dDcxU2pTaGNib1JOS3dRSUE1bGRNSXpmNDlrKzEyWk1aLy9lbTdLdndxeW84?=
 =?utf-8?B?UjdtSHlwd3VlTVNqb0dnY2JLSWtNeUpzZEZFcDBnNE5nd1ZXeWpTTzNhdEFu?=
 =?utf-8?B?UkZXdDBub1JrZFlYSHBsaTNDbmRPOHZGK3pSV1hLV0U1SGUyb1MxUGV3UFZr?=
 =?utf-8?B?cDVnTnRrRVZ3blV5OXFsYWc0NFE0Vk15TURzYm1KYVBnL3BCZkVPUElxdk0z?=
 =?utf-8?B?aUljaThiWDZOYzdDUGxEQmZJQXlsNTI3RzQxa1gzUkM2TjI4U1REdTU0QlY0?=
 =?utf-8?B?TEFzU2tMTjhGOWYxVEVSQm5EUjJsUU4xUk1ZWjJza29KK3UwRzArL3pzd2RT?=
 =?utf-8?B?NjArK3BuYUh6Um9abk5BWW9xdUZzUUpJUmprbUdLNklMUFpsTjY0VW1IK3JP?=
 =?utf-8?B?V0piTGIva21lZjlIN0YvSEY3bllPZXRFb3Fxd3Q1a3FXZnFEcE9sREJrU0lE?=
 =?utf-8?B?dlFSYUY3L1REdkdkSVpnTWNHaXBxVU5ybDlqMC90dFZsT25yRlZVRXNyamIv?=
 =?utf-8?B?UElTR216a3E2aUNhLzJMVjV4UVdSRlE3Rnl2RmhpSS9KUjdnM3NOaENVRE00?=
 =?utf-8?B?SkpoNVVpSkx1ZHRRUFkzYWlEOFdWN0ZEaytwVGhyYW9kd1ZEcTJLZHl5RXlj?=
 =?utf-8?B?ZVpHOFZreUZMbnFXdVg3a1hsVlpLSm81dlVkeExMTWxRNXhseVltREpDZGFx?=
 =?utf-8?B?Yk1VTys5cWNmUTdVVU5CcUlGalQ1NFYyRXZSeDZXUWVVQkFaNFJNUi9XdnZi?=
 =?utf-8?B?SW5YMWh3bDN3WmNzUml6Tms2ZFlEWHpkMGJST0dZbE1jdmgwSGVLUDRNT05u?=
 =?utf-8?B?L01uN2tvWEQzZ2FCQ2ErMklWV1hPZEdUME40RWMxTXNEUytjdmlsa3hHcXVq?=
 =?utf-8?B?bWNmOTg5MmJEOFpYS0MxcHZFN3FJcUF5VGN2bjRyWXY1S2hOUXhaR3FQcjdO?=
 =?utf-8?B?RHpoMjVMWDdGM2paVFRoT2R5Y1FoVS9vMWg3RDhwMER6Z05hbUFGS1E0MytN?=
 =?utf-8?B?aXZtVHlDaHAwQW9LSGNrV0JWZUJTazRjRDVOYjF6aE4vcDQ0MDNmenpFcEMr?=
 =?utf-8?B?UXU1SU5kVDEvSHU1ZVpMbE14c0lUOFVXVTZmUGV5Z2NodWt6MDZaRS9TT3hQ?=
 =?utf-8?B?aUxKMGJla1dhaU5jRzdwRkJUOGY5YWlhWFl3aXlVQlVOVkVTQ3lyclpuU3RJ?=
 =?utf-8?B?UkJDSUh6K3RHeFE3aDFFNTJMTTNwRlQ5eGhrNlBGaGNYblIwYW16WEgwVW0z?=
 =?utf-8?B?RFhFR2ZZalJFalVUM2dmNXRtTXlWeVlLSUNKOVB2L05kNlVreG9mc3F6ZHBM?=
 =?utf-8?B?STRMWlRHQU93cWkycXUxQ2x4ZjIwSzZjamJGS2pya2tXQXc3OG9hdGZNYVpC?=
 =?utf-8?B?TEh2bUVtZjJjcElnNVJiRUVMT2tBNjd3UkdBd2dYeWZhN0VCVUQvMWROMUUx?=
 =?utf-8?B?NFRxOFlQc0QwY05JWlpoK1VSYTcreVBHTit4aGdnTVdIaFFXVzV0R2VkTEJO?=
 =?utf-8?B?SFViSkJ2azVkdlpVTi83WCtEVjVkTGkzVUFpdVhjeGNvTCsycU91dHhkNENr?=
 =?utf-8?B?QXdFQ2podGxib3J4RXUvT0xQbGJaK3REYUZYcWl0cFM0aW9BeXNpaGRsYUEr?=
 =?utf-8?B?cStEV2dIMzVzZ0ZMbXFVVlltdkFEWmFHMFBPZmhtKytTTVd3Q3I1eDNVQVpN?=
 =?utf-8?B?QnEzQ3lCdWhSSGdQNVJVZjlZUW1NeUxjSjMwakZFNEk1ZHRuYUdJQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9e82da0-9db0-4dd8-a412-08df0d7683b7
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB999171.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 06:57:58.0714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FLgcOKtjhBHeN8DXNbxEsg1v9nK0BBBGEZZSMghH8qGX6xd8uYAaX4+pPkk74LmlaXQJRPbGaCzaj4QJoVDeXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6389



On 8/25/2026 12:24 AM, Jason Gunthorpe wrote:
>> [ ... 39 lines skipped ... ]
>> +void amd_iommu_free_dev_data(struct amd_iommu *iommu,
>> +			     struct iommu_dev_data *dev_data)
>> +{
>> +	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
>> +	struct llist_node *prev = NULL, *node;
>> +
>> +	if (!dev_data)
>> +		return;
>> +
>> +	for (node = pci_seg->dev_data_list.first; node;
>> +	     prev = node, node = node->next) {
>> +		if (node == &dev_data->dev_data_list) {
>> +			if (prev)
>> +				prev->next = node->next;
>> +			else
>> +				pci_seg->dev_data_list.first = node->next;
>> +			break;
> 
> Why is this open coding llist manipulation? That stuff is tricky, if
> you can't do the mutation you want using the existing helpers then you
> probably shouldn't be using llist..

For v5, I'm replacing the per-segment llist of iommu_dev_data with an 
xarray keyed by devid so lookup is O(1) and a given id can be removed on 
teardown.

> 
>> [ ... 45 lines skipped ... ]
>> +static void set_dte_ipa(struct amd_iommu *iommu, struct dev_table_entry *new)
>> +{
> 
> This is a strange name for a function that fills a DTE with the paging
> domain for the "viommu_pdom"
> 

Removing this in V5.

>> [ ... 7 lines skipped ... ]
>>   int __init amd_viommu_init(struct amd_iommu *iommu)
>>   {
>>   	int ret;
>> +	bool dte_set = false;
>> +	struct dev_table_entry new = {};
>>   
>>   	if (!amd_iommu_viommu ||
>>   	    !check_feature(FEATURE_VIOMMU))
>>   		return 0;
>>   
>> +	iommu->viommu_dev_data = amd_iommu_alloc_dev_data(iommu, iommu->devid);
>> +	if (!iommu->viommu_dev_data) {
>> +		pr_err("%s: Failed to allocate dev_data\n", __func__);
>> +		return -ENOMEM;
>> +	}
>> +	iommu->viommu_dev_data->dev = &iommu->dev->dev;
>> +
>>   	ret = viommu_init_pci_vsc(iommu);
>>   	if (ret)
>> -		return ret;
>> +		goto err_dev_data;
>>   
>>   	ret = viommu_vf_vfcntl_init(iommu);
>>   	if (ret)
>> -		return ret;
>> +		goto err_dev_data;
>>   
>>   	amd_viommu_gid_ida_init(iommu);
>>   
>> @@ -318,5 +355,15 @@ int __init amd_viommu_init(struct amd_iommu *iommu)
>>   	if (ret)
>>   		return ret;
>>   
>> +	/* Set DTE for IOMMU device */
>> +	amd_iommu_make_clear_dte(iommu, iommu->devid, &new);
>> +	set_dte_ipa(iommu, &new);
>> +	amd_iommu_update_dte(iommu, iommu->viommu_dev_data, &new);
>> +	dte_set = true;
> 
> Why split this so far from the alloc_dev_data() ? The dte set cannot
> even fail?
> 
> If you make the alloc and set one function then the free function
> viommu_free_self_dev_data() will naturally pair and no need for the
> weird dte_set

Ok, I'll clean up this part in V5.

Thanks,
Suravee
