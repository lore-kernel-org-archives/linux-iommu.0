Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88B718054
	for <iommu@lists.linux.dev>; Fri,  4 Aug 2023 16:22:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZCuh5sqXdv67+xTieSgZrcN+1yUCYkm6ZPoqHuugPHMrkms79ZCB97J4aEGzBXy3jZLpnnPE8gfN1wU1OlMPWb28zvH8aJ/4nRpNTPV1Htx8jtl30cw3Vrc2fruglhawxifncxT/W69fIGMX6oqkns0ZRymvXCH0YGrVSgGoIQWLiDOM/klY4HHtu2+5Ud8ZEgGA22lU6BA3GB2BCfTx28TND9f0vIc5bvSRSlaUHB9mPN571t8VVl8G7ZXveYheK2JYULw6jkLnkY4Fs9uevQapReJdmfvVVsEW4pyHUFfHAD7djhPm0bTyzrt3eGKOW6iA1tX0tQi2SXWODHyELA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BF/E+hTNXjb1mzkOxb2wINBgAQqeezpuJHFPvZqFmEM=;
 b=TJMvlEYZNBGKMxTYRZ5J/eJZVM2888BUWq2RPa4Q0sO417JEvXsW50ZwBCzDuOBzFmJOk3OGPVkgq5mR1SXCCTV7EY1juoLq6xoUugywcRneoTN9dBrxb1bAiZR+wqC5TwQbZoKfBNqbvHlQD0tN+hqngfFjEKJ5uecIkedS86wMlTzfZaKBLNJYf6EGckeqQ+HYUv38YtOcrAYa6ofssac6hQqpt2M4TJCjUzb+bcbuBE5P9Aau5kv3DYIQU1IDH+RyYSJjeIugCDllUpJ97IKSDNspwxZRrSg5H5JUO2NX4QPRowsXbjRwFt/a0GavqnGX0RrH0fFtDI0Pp6l3BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BF/E+hTNXjb1mzkOxb2wINBgAQqeezpuJHFPvZqFmEM=;
 b=mIpKFqTpPrWMkUAmOMx6H09AGf7UpJPeC2+DATp7oGM5zD/01QsH57WWr+Gt1DBLYE8aA1iOL47y7e5baOSQD6pIsS3TX5B8gU41K+fUA/0FPQJCw92SgoKZQh7b7/ecSPOJHz/MZN3H2AGewZVCHxecWaHf9M79Hjv+d9pcuyk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DS7PR12MB5863.namprd12.prod.outlook.com (2603:10b6:8:7a::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.21; Fri, 4 Aug 2023 16:22:24 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e%7]) with mapi id 15.20.6652.021; Fri, 4 Aug 2023
 16:22:24 +0000
Message-ID: <dce0fde7-3d0d-65e4-42b0-51f5cccaada4@amd.com>
Date: Fri, 4 Aug 2023 21:52:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 12/16] iommu/amd: Add support for different types of
 PPR handler
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20230804064216.835544-1-vasant.hegde@amd.com>
 <20230804064216.835544-13-vasant.hegde@amd.com> <ZMz9E41XgqzFub2g@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ZMz9E41XgqzFub2g@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0165.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::9) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DS7PR12MB5863:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b7fdad7-7212-4648-defb-08db9506fbe0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QYJTj4zgq6MrZAv6HpjR9GRysyNBsniaph+npv23CjKLxf2qQeujztnPk7H0g77Vfv6p60xUHC/oQjD5x7GFGgGoUfxX8TWPzwetsk+KD+lXEdnIoe6nE89a9w9AcfD/whwTkYp7wtaMRYCBYWJSYVoXUuJOYadYwlzazUIJ/9SS5VCWLUZdIhB5poQJz7jn5ezUkJiQhQjbSOJtc6yNicU9md70qnOqKw+KM2NceICNdCZ4U19DbeJ/RLg2e4ksndmIOo+HakGml/Ke2d0ysSLgubMaFpfyxjD//AG/jnN478rr1pJptD6AT54XTUrgDsZUNcITFeMjHEATGxvDEhB4rEzeIW8kmLCpVloLLa3J+gEVbwCtx6sdceo38UAGlwgGIpdvPrZqVOpBhHsQhEhy2CDTW0XH7+ryFyODCdzZ30fFEFnl+PRF35pT/3X32g955DheVoaXB+ecmezLtuhjbj3veV19OpXk3Q5JEIYaMd1DuRk4nowMabka+HmJY7MV8VxDscMN15H4jvzFmg2az/21iRTuYt7J3d4CUm6gKm7Gj6xzFuzRrYsI1VIMGoFWVq2QvzTiwRmcFbd5YJZlioesOpV8G9fPmWqK0J5djvsXMyOKR7rJFy+zMnpFwEjsk2ZFFVsh8+mJxgPtjg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(136003)(39860400002)(376002)(1800799003)(186006)(451199021)(41300700001)(6916009)(4326008)(2906002)(66556008)(8936002)(8676002)(31686004)(5660300002)(66476007)(478600001)(44832011)(316002)(66946007)(86362001)(31696002)(6666004)(6486002)(6512007)(38100700002)(26005)(6506007)(2616005)(36756003)(53546011)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?KzRna0VSTnVsZGRKVXBqOFQ3TU1FSmhGV3N5bTRyTzNWdE90aEdOeGtIOWJP?=
 =?utf-8?B?ZVZRcXdBanc0aVEwTDBtU0dhZFJINmRPb2ZieC9Zd3E0VXpEYk1Za0dVUnV0?=
 =?utf-8?B?OGNOb2RmcVRrdzZoSWFPSy9LczNvWE5FZzF6VTFUcWZYSFhUR0dSQnBNbmJ1?=
 =?utf-8?B?eHhzZXRKWVVKWERCTXhzakVlTW1vbW5sOENiNDg4amZLMmdjY1dwejJRM3Jn?=
 =?utf-8?B?V3VCanZleXBHVFM0Y3cxWk9ybXBFT1lkQWtCUTMwZXpQWjhVZDE4VmhqbHd3?=
 =?utf-8?B?Vk1MRitDejVNa1EvQjFEc0hnazU4bzN3NlI2NjM0YmpPMDd6NmRQd0tzSjIy?=
 =?utf-8?B?SGNrbjkwRUpFb0RydS9oVlNmTTY2VlBMVWt0ZWpqLzd5NWlwOWJtMTRhcnh5?=
 =?utf-8?B?OWx0S1A0K3RoMFA5dGwzNElxQ3U1aGk1NWdzSTVabUZrem4rSW5ZMm5HNkdz?=
 =?utf-8?B?RVN2eTRkOXYzcVhmdzhnK0liY2ZQdWZVOEJNQ2MwbW9wMDJ4Z29wbXQ2Z09p?=
 =?utf-8?B?aVlrVXBiNHpxZFFRcVQvbEVnUXQvSjl1aXl3bmo5b2I0a0RTMzVDQ0JyWk9C?=
 =?utf-8?B?ZXJNWHZaNjZLdXRIT0p3aTEvaTI0a2pPcXVZSUVEbTYvODdzV2VuOFRjTHox?=
 =?utf-8?B?QlQ5N3A5MTR2OG1jVlpJTkFJQzA1UTl2MWpDSTIzYVppUnJpcDRwT2hFT3JD?=
 =?utf-8?B?VGNKVFlMaGc0aUpuc1c0cFdBUjlsZG9BSUY0R3p2VnVwM2RMMFl3Ykd1MG1Q?=
 =?utf-8?B?MzdOU1Z3ZndkdVRDcWlHUzlyNklJVzhUeGRUd0RyckhFMy9oMjE1ZzhZWHFz?=
 =?utf-8?B?MDJnYzc4YmIzTWhoRGV1Uy9IRGdINE1XcWFvYjR1K2Q0YmRnRm5CWTRDV2Vj?=
 =?utf-8?B?Z1I0dnB3MjJqMGh6VUI0TlhXYnBDekwrODFGbkFxaTh5STVoS2FFMVhlbTdG?=
 =?utf-8?B?akhDVjNpeW81dlE5ejQrUlVueEtuZk5uaEVSeGtzaEJpM0dHTXdNcFRkZDN4?=
 =?utf-8?B?S3BsdURqZkZ6eWN3NTFOV3V0RHg1ZFM4ZEd3TWgrY2x3NVVqL2dRbnRFelpD?=
 =?utf-8?B?Qlc1UnNULzkvdHA5YlIvMTFiclhuOTZSblBLVlFiTGtyYldCekNkODlmZU1w?=
 =?utf-8?B?eEp4czVRWHRxM25Jc2huOUl6VytVbDlOWjFEVkV6R05SQkVmSXNCQzQ4Sys0?=
 =?utf-8?B?RmxyeFFNdzFGVTVSTEVmcHNidGJCVUsyYktZYUFPa2Z5WDhKbWU1NzZ3bUV3?=
 =?utf-8?B?OTQwM0VLWTcvVGJqd3pGUnN3RkNlV2Z6SW41ZzhuNFVjWWNaWjVqaktrOUM1?=
 =?utf-8?B?U0dpVzFHWC9jR3lNT3crUHlMK21DN2pORk9HejhQSUEvc3RBYnFsTFpXRHlZ?=
 =?utf-8?B?alp3UklXSnB3eWJmaTZtdC9CSjE5czNtMEVkQmdHajZDdDFna05xSExQMEVO?=
 =?utf-8?B?OTdvaWd0akdFMGJjU2J4a0dYOGVQTU10V1I4SDFLMi8vNzE0RWhiNUZxK0RN?=
 =?utf-8?B?ZW1sRHo0ZncycUVPa1FGeTE3RFRyclYvSm1qb0V1dVowSjUrZ2xQbmt4WjE0?=
 =?utf-8?B?d0lHRjVWMVVndHRUOUpBbXRva0F2RkF5Q2JCMVFDT0dta3JXYnpDVWcwT3VB?=
 =?utf-8?B?Uk9RM2NOWWE3eTRSQ3RHZXBnWURZZmVOQzl2enVYdE1EK2FUeUcrZmNSNytN?=
 =?utf-8?B?c05VS0dHREhON25jSkxRTWNCZUNCVGI2QitVNmp3eldubU1PRzZ0Z2hMMlh6?=
 =?utf-8?B?TENnMko1MUN3YVVoZCtMaUdRRW9QaG53UzZqb2wxZ3k4ME83NzVmMTFLdUYx?=
 =?utf-8?B?Z0hrOWNzRE1RY0IvV0RCR0VxcXd4RFl6NjJPZWh1ODhtRFBvdkpvRTVtYUVk?=
 =?utf-8?B?aTFIbFVJVVhQOWs4Qk1MT3R1SkRmZHlkYmEzVXlDakVOYkd6SzJBTnNyS0Qx?=
 =?utf-8?B?Qnduc3lxVElzWFUwWFdyOWpDTnJDMjF1WWFpanM0NDdnY0QyVnZpYlRnSXlN?=
 =?utf-8?B?eks1N2Q0R1R4Qk5oaG1VRU5GTzNxQ2h4bnBLNTN6bDBhZ1JPUEpNbE1MbFps?=
 =?utf-8?B?NGE0S0VDUWhvenJKRjM0K0t2aGg5eUtwVm9pS2RCYmNPdTlFeEwvY095QUp2?=
 =?utf-8?Q?1dK8s6CvOzxj323x9p0TcpYDQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b7fdad7-7212-4648-defb-08db9506fbe0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 16:22:23.6495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nFBcE5x7TH484ObCjoGYRGB3+1OYl+vxUtqUayOQcgB8wlr+E1lSqy9FMBQ3JHV034V+45TQwBRCatuZYU2aUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5863

Hi Jason,


On 8/4/2023 6:58 PM, Jason Gunthorpe wrote:
> On Fri, Aug 04, 2023 at 06:42:12AM +0000, Vasant Hegde wrote:
>> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>>
>> For AMD IOMMU, the PPR feature is needed to support IO page fault (IOPF).
>> PPR is enabled per PCI end-point device, and is configured by the PPR bit
>> in the IOMMU device table entry (i.e DTE[PPR]).
>>
>> Currently, PPR is enabled for a device when it is initialized for AMD
>> IOMMU v2API. To support paging for IOPF, the DTE[PPR] bit needs to be
>> updated when enable/disable IOPF feature.
>>
>> Introducing struct iommu_dev_data.ppr and enum ppr_handlers to track PPR
>> setting for each device.
>>
>> Finally iommu_dev_data.ppr is set only when IOMMU supports PPR. Hence
>> remove redundant feature support check in set_dte_entry().
>>
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>>  drivers/iommu/amd/amd_iommu_types.h |  6 ++++++
>>  drivers/iommu/amd/iommu.c           | 10 ++++------
>>  drivers/iommu/amd/iommu_v2.c        | 14 +++++++++++++-
>>  3 files changed, 23 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
>> index b79c6e10684d..443b13b56235 100644
>> --- a/drivers/iommu/amd/amd_iommu_types.h
>> +++ b/drivers/iommu/amd/amd_iommu_types.h
>> @@ -803,6 +803,11 @@ struct devid_map {
>>  	bool cmd_line;
>>  };
>>  
>> +enum ppr_handlers {
>> +	PPR_HANDLER_NONE,	/* No handler specified */
>> +	PPR_HANDLER_V2API,	/* IOMMU v2 API ppr handler */
>> +};
>> +
>>  /*
>>   * This struct contains device specific data for the IOMMU
>>   */
>> @@ -820,6 +825,7 @@ struct iommu_dev_data {
>>  	u8 ats_enabled  :1;		  /* ATS state */
>>  	u8 pri_tlp      :1;		  /* PASID TLB required for
>>  					     PPR completions */
>> +	enum ppr_handlers ppr;
>>  	bool use_vapic;			  /* Enable device to use vapic mode */
>>  	bool defer_attach;
>>  
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index 5968eb8d265c..888bce5abe56 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -1634,10 +1634,8 @@ static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
>>  	if (ats)
>>  		flags |= DTE_FLAG_IOTLB;
>>  
>> -	if (ppr) {
>> -		if (iommu_feature(iommu, FEATURE_EPHSUP))
>> -			pte_root |= 1ULL << DEV_ENTRY_PPR;
>> -	}
>> +	if (ppr)
>> +		pte_root |= 1ULL << DEV_ENTRY_PPR;
>>  
>>  	if (domain->flags & PD_IOMMUV2_MASK) {
>>  		u64 gcr3 = iommu_virt_to_phys(domain->gcr3_tbl);
>> @@ -1730,7 +1728,7 @@ static void do_attach(struct iommu_dev_data *dev_data,
>>  
>>  	/* Update device table */
>>  	set_dte_entry(iommu, dev_data->devid, domain,
>> -		      ats, dev_data->iommu_v2);
>> +		      ats, dev_data->ppr);
> 
> This is casting an enum to a bool, 
> 
> dev_data->ppr != PPR_HANDLER_NONE
> 
> ?
> 
> And in other places
> 
> Or maybe just pass in the enum.

My bad. I missed it. I will pass enum in next iteration.

-Vasant
