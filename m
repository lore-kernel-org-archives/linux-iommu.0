Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D2E5382
	for <iommu@lists.linux.dev>; Thu, 11 Jan 2024 05:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cj0bqS9u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UkKZE2rh0OrI3p9Hs5nRWtkSHRqcZZDskSX27FmH+ZvzieHj41MaHSNyELEq1vSclMJfc5p+OsIZYh1S+wHSrp+NmXKeBZnw3Oz8ugHWTNvsVo9ehWtAjyL32uZWSNieaot+qLxhbOKmtf7GbbBCUJKpMmGcZj1xJTWObCz3ibBop8CbsDla8NSMwUUUin+W4mQCNgeM5AXVs4CD9jixmBvvW0ZwRQy8u9D1zEJay1V4dj/uPEMX3CZvAjp1W5c994T9wLBgplTWjS88AYKFVTwna0gJNITj1v7R8kJ3Vtw+7DPEIwpdwzkXe4p73vpTUSBJo0rxv0WisDDj9/VWZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3bSxm0Yvhjmk9sfbFKSXUTvHNIcbIncZlrZk7uWYS0I=;
 b=dQartDNLLgd2MfgS3ZknftOy49n25+hOQPENkkrYNOYD3MFjASj5cYVyCRguYFoiaZ9BAJzPT+J2XzPq+YGU4TkNRUFi71fNBxG9CPJ0OxqXP1kQiEYlJZElQs94S4IFQnoLrSqVqI1c3J8TxPY9gOrmEWCHzDoyP+wpRCQtpe/EqfPvZnga4gZpooFVjRHifIt4mXkxtpsJjZ+o/B7RRyLNpMke784hjGJKqsqgMM72ewb6XOkVn7CnlRJZOC3oR01TU2dqUvWFNsOLp6IIIN/Rg5ZXfR/idG5bnhzcLCT4L0UPAwVBoUkNdbvvkzyhGVsM6KiH1wsg1imusdO72w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3bSxm0Yvhjmk9sfbFKSXUTvHNIcbIncZlrZk7uWYS0I=;
 b=cj0bqS9uHvR1/o0LEYLrD7KACt8X/lXHg/3+hs6G2WCmpqlPsJh1ugN4G8ZgT57joKOyGwRLMuktralR2RS/6AtSvmFd+K9CBzMvUBNleorbLYF2160pn+KknU/1ehXAGdc6M8q//3Ctp+V60/plw3CFqjDnFMurIiXATCgOfT4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 BL3PR12MB6378.namprd12.prod.outlook.com (2603:10b6:208:3b1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.19; Thu, 11 Jan 2024 05:39:45 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb%2]) with mapi id 15.20.7159.020; Thu, 11 Jan 2024
 05:39:45 +0000
Message-ID: <e6bb58ef-67e5-dd8b-263e-47177357a288@amd.com>
Date: Thu, 11 Jan 2024 11:09:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 13/16] iommu/amd: Refactor GCR3 table helper functions
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20231212085224.6985-1-vasant.hegde@amd.com>
 <20231212085224.6985-14-vasant.hegde@amd.com>
 <20240105192141.GR50608@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240105192141.GR50608@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0096.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::13) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|BL3PR12MB6378:EE_
X-MS-Office365-Filtering-Correlation-Id: eaca9a18-52b1-48f6-3bc2-08dc1267b77a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4pYvD5w3v755/wNtCkjPCAwFTtrtXy0IyBowRnWM2tggV1NDx1TdwG0jV13iUlf36Wy02G9WXPPQIgKJ4GSFhG2wbxEUTnZKqaIk7JtDo6mxe/uMGK6rK9ENkaBZtK5BYtTOHl2n1lmnDIs5h7Zy8QEzn0sh4ME3JjWbs/lY5aPNkcqmahrpDG//WL3i4nsMOUjPAsFQuFvsiMsYgXaEXgvnOr7/ynm+Q3X1i4XfVW8HBpmyMi/ENKgHTA5ns19Zl9ScqeQtHGxVfVmxuY5pzsMa0uR2RONO612xcpIfA9YjzKVV6f+/cF0uy6GorSkjqMZ92QBbNEwqNUP4cGQ4J0D4RXgB0g54Ez+qhwokFjBU5ZCFr54XQyfK1rf5osNTgd9Cifmfu0sobviuCRvXf5pBU2qNss16Fiu1EZsI+46NfLhXZZ6ELJ720k5W0tTQPy3ApUI56rvJePriSDFeWVQ7X+0/lobvaTzplappfSkbY19pOsThkxwznKjKDjXgj8CrGE039NDdcs5BSU6oFFwTVozF4DQOxVDrnJOKpKYkGc8Iemr+D5uybqZRzTHbHB0B3hPG80heBFuGu5qffdjz7OY0443ESRyU71L73W/0bx1IGcxy1MPRug1fZU2JPRXN0n04oju63odlrBqfKg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(376002)(346002)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(38100700002)(86362001)(83380400001)(31696002)(4326008)(6486002)(478600001)(44832011)(66946007)(66556008)(6916009)(66476007)(8936002)(8676002)(316002)(26005)(2616005)(5660300002)(6666004)(53546011)(6506007)(6512007)(36756003)(41300700001)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aE1qT3hwNVN4bTVmS3Fkak04aEJrak1WLzNIb3YwRWo5L0IvVldVSk5QK2RP?=
 =?utf-8?B?bzJpUjZBUnY4NWVlazViVGhPdVdWbkUvT200cnl2WXliNC91aG1NNE16aXdi?=
 =?utf-8?B?YURiQkh6OWxCcFNrWXErbUs3NTZuM09qTDQvWlFtZTRrVVlxLzd6U0UyTUU3?=
 =?utf-8?B?T0VaWTcwbmRnZnRTRUJPcm8wSlkvUCs2MWkycXdZN0w5WTlJeTh1eUY3NG50?=
 =?utf-8?B?YUhXOUgzRGNJU3l0ZDJCT2I5RzE1bklUdnU3N3dzVnlvdm1vM1JsaTczOWFB?=
 =?utf-8?B?UTE4SVZiZGpxamxxOERoUGdpMExjRWo4bGhXSWtvU3dJdnVndm1yZjhuMlFx?=
 =?utf-8?B?Nks1ZlRiMlk0S1BjdWFvY01TSTcvczJLaHIydlB0WThNMVVyY2NrMDRaWUps?=
 =?utf-8?B?L3hCNXA5YW5wdTBwUCt1YWg5b09HUmVCakh0VjhVRWYvUmJ5MXd2QnpMdklq?=
 =?utf-8?B?Wm03aUtQUU9UdzRmU05aWkxHSTlNd2dkY1Z6TXl4T1FQMEFNdUxaL0Z1YXUv?=
 =?utf-8?B?U3huZ3RLU2tCaHIzNDJ3VWRWR0RDNjR4MTdnNmpsWjd1NVFKcTNiNFFKWFRw?=
 =?utf-8?B?OHdlb1FpUXptbTlLM2UzNlRydzBuMWtXREgrclo3L3E2eXM2QThFSlliRWk4?=
 =?utf-8?B?emgyamYrVWQyTXcxRm9rNFNVSU9zckYySlE4bll3UmduS1VtT1FJVnJBd0N1?=
 =?utf-8?B?QTVjbzNXQlpCZE1CQkVTNDdRWDYyZzdnNWhHT2N4YXJEUVFIZ3Bsa3VwSzc5?=
 =?utf-8?B?WVhQeHo4T2ErWGk5L3BTSUN0aDk1eHBsOWhiUmwvbFlpQmRFN21OZnVVSHpi?=
 =?utf-8?B?NXB6SXFYWnM1elRxSTh1dElRRWpERnJyVjNQU3NrbHBPN2E4VEhqdk1VRzcz?=
 =?utf-8?B?S0ZpWk52K2NWVkJHQkp5a0I0cHBwVWxkbFBocnh5MG5ack9DYUVYVmFaYnlC?=
 =?utf-8?B?ZUdkc2FYcDkrcG1ESzEwdThGeTJ1b1hVNlZsRDd4RTBYZFpWUkpzbFQvNzN1?=
 =?utf-8?B?dHRiUW52NFdvRXNNY2xCUXdURVhNVlA5VGlsSTR0VG54ejhET3d6UkgvZ1N5?=
 =?utf-8?B?d2gvMzhxV0RJRHNmTUMrbmlyQ0pSdk9qT3dyMXVSemllSitlKzRMd1hmZkFy?=
 =?utf-8?B?a2hSVjAwSTF4UVdWQzhPdXNCak93US9Kckt0TDVmY1cvendESnQ0cTlLOE05?=
 =?utf-8?B?eVBJTmlSMldqdHJDSi8rNFdONXlkNXBmNEJSNXBKWnlpS2g2TjdmVXBVdVFu?=
 =?utf-8?B?NzFMNURQOVJscSt6clpzNWltL0U0dVpDeHc5eFRFbFM0SXRxdWNQYkptSnhS?=
 =?utf-8?B?TmNCbDVESmVyemdzdWlTT3FhaWh3ekJ6K3NHSmYybFQwT2pveDgyWFgvSHpN?=
 =?utf-8?B?dEtBRmpycWFuRUJ6aFQ1TFpyK1NOcG9QeXhWZWJrbVZSWVJIMzdNemhXWUlB?=
 =?utf-8?B?ZG11RlRvTU16U1pwcUxSTlFWeFJPVVFQYkxkUDIyMHlwTkRYdlVLZGxrTExu?=
 =?utf-8?B?ME05eVZzcVZDVnZxc1czVXVqZ0FRb0hYOHZqYURlVnVMZWhhTEV0dkNjckt1?=
 =?utf-8?B?c2dKcGlyb25FM243dmV6YTFwOW5vUjY5TFZab1FUQjhjVWRwNjFrOHVZaS9X?=
 =?utf-8?B?Wjdwa0Z5eDlqaG9WZUpDbWRGV2ZMdGdsZGdtUGI3KzArN3lkUUw1eHNuenhH?=
 =?utf-8?B?T0xmbDJqdThpaDFNcG1KL1F1bG50WmFIeGtvQkRrbFlUcEc4Qkl0ZHNmakFa?=
 =?utf-8?B?dFgrTDFWTkIvR1hkcmh4UnA0QXpjclluOS9YK0xCc1BRZkh0ckJPYk9hekVj?=
 =?utf-8?B?SHJva3M4UTYzUGlXVk1rNjBzZkxwRWlLY1RNbEl1Z1MzMy9BbVlveG1OVmtT?=
 =?utf-8?B?ckI2VnFDb1FTdkI2VjdKZ1k5eVZPWnY1OExYQjhmVDZkVmt4dXdxM3VZME93?=
 =?utf-8?B?MnVXbTloR1RBREo3dlVoWGhXT0V0WlRTNGdlRzNqbkJwMFZnejkyWXUwNUdp?=
 =?utf-8?B?SHZrOGhuNk9sQlhESElIWGdFN01tZEJiR3VFaXRzbmNRV3lLUnBuS21tZnlQ?=
 =?utf-8?B?RzhCRU1LOXU3V1pzNllNc21paVpaV29yakovdGF5MmloMXREWS9BaGhUR0hK?=
 =?utf-8?Q?LzlbXrNGkS7he5XZw3rKmllNF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaca9a18-52b1-48f6-3bc2-08dc1267b77a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 05:39:45.2194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cBJMR2F+rJOo0RYI10pOYrz5JSZMsUz9u6uRckTLVN3Wo89LA3UJ4JWKTN4fW4Apxg+7g2yeLMe3XDLEW/gzow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6378

Jason,


On 1/6/2024 12:51 AM, Jason Gunthorpe wrote:
> On Tue, Dec 12, 2023 at 08:52:21AM +0000, Vasant Hegde wrote:
>> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>>
>> To use the new per-device struct gcr3_tbl_info. Use GFP_KERNEL flag
>> instead of GFP_ATOMIC for GCR3 table allocation. Also modify
>> set_dte_entry() to use new per device GCR3 table.
>>
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>>  drivers/iommu/amd/iommu.c | 55 +++++++++++++++++++++++----------------
>>  1 file changed, 33 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index 584608b98f26..7e5f32817931 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -79,6 +79,9 @@ struct kmem_cache *amd_iommu_irq_cache;
>>  
>>  static void detach_device(struct device *dev);
>>  
>> +static void set_dte_entry(struct amd_iommu *iommu,
>> +			  struct iommu_dev_data *dev_data);
>> +
>>  /****************************************************************************
>>   *
>>   * Helper functions
>> @@ -1716,16 +1719,21 @@ static void free_gcr3_tbl_level2(u64 *tbl)
>>  	}
>>  }
>>  
>> -static void free_gcr3_table(struct protection_domain *domain)
>> +static void free_gcr3_table(struct iommu_dev_data *dev_data)
>>  {
> 
> Pass in struct gcr3_tbl_info not dev_data

Fixed.

> 
>> -/* Note: This function expects iommu_domain->lock to be held prior calling the function. */
>> -static int setup_gcr3_table(struct protection_domain *domain, int pasids)
>> +static int setup_gcr3_table(struct iommu_dev_data *dev_data, int pasids)
>>  {
>> +	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
>>  	int levels = get_gcr3_levels(pasids);
> 
> Pass in struct gcr3_tbl_info not dev_data

Fixed.

-Vasant

> 
> I don't think it is worth re-doing at this point - but I probably
> would have tried to structure this series as creating the struct
> gcr3_tbl_info and migrating the protection_domain to use it, then
> streamlined the APIs to have a clean gcr3_tbl_info layer, finally
> adding a gcr3_tbl_info to the iommu_dev_data and using it when
> appropriate.
> 
> Jason
