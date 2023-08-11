Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2086.outbound.protection.outlook.com [40.107.212.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E6263C3
	for <iommu@lists.linux.dev>; Fri, 11 Aug 2023 10:05:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTijmaWXyKBL4mnydqKR6pdmBx/wL36O4igN3PZP11a3Rp+/61mmMw602iHHtG3xjvvc18VUzeOzQeuxPLELjl3ax1/Qx0OavMP6fECT5OFTzifg0atYdi1BI15Mdl5kZDRwEgy3bMd9IpJkPc2Vew/tGn0+/jXQx8TCR3jk1OiR1wiFZuU7QcTSZ5hbg+TCKTPtuP+MRHuyEfHdBiV7feGNC84Ai6JvwuHwmHq9Ui68Tl9B+LIIbCKtt0DDcsYjH/GLCxAFnilW+1FEh66RPrPLnmP2sxmOCQrlqMDBNJLHIE7lqekQFn3pF36xdOo5Nox190w+cnOLeM0GHds+jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CHlTuD8YbAn+C05bERFEV4KnXOsH34inOGoDW1YdsJM=;
 b=hgoxaRWEKYfkdDaeysIsDKMs1xC6+lOoajwyWW9hWT1hswEGIS1h5LwuU4hBiymbLZUVnK9VkrTVSMNzHjTp92bg3yNAnHSO7SGQilzBXiLDe6se8Yw1llZOhn7SRBsDtPD9lFO//dFNV5bywUoaKLSSX4YmZtxh8RyVqHKYG8ZKzgvjJ32OWaGqG8Gk8YPhdmSksTyqbQBLSKj+/prZHas735/iThu6zOrZk3q4a2mqINYAKXwt8MISv43bIbWROhIUWU5EdzSE+i7QiJHxgX/l1FwEfqI7p6gKXyTPWJjFOeppShrsIgTyMxeJnpADbyscBlhaOJLD6mv/Wa67vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHlTuD8YbAn+C05bERFEV4KnXOsH34inOGoDW1YdsJM=;
 b=QYD5Yr6/TAjOsmvpSqFgnevdB7kE4b9sDcj7PqbXewWifUNLDbXWCGhvZYJUlBWUIZB+ri1kBSjLArlfGQJ1sNyrMOzkLdld3iaHAve2a8qfoa9ApMIQDqalsWnaLZYSxT8OQpyQ8ZS1WY+N01Ut1u8ab/1VIam12M0XHSFGpl8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DS0PR12MB6654.namprd12.prod.outlook.com (2603:10b6:8:d1::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.30; Fri, 11 Aug 2023 10:04:59 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e%7]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 10:04:59 +0000
Message-ID: <7725dfde-2fed-ad61-eb5f-358edd2df052@amd.com>
Date: Fri, 11 Aug 2023 15:34:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 02/11] iommu/amd: Introduce struct
 protection_domain.pd_mode
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20230808100232.5977-1-vasant.hegde@amd.com>
 <20230808100232.5977-3-vasant.hegde@amd.com> <ZNJflxeIWtJLC896@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ZNJflxeIWtJLC896@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0111.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::26) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DS0PR12MB6654:EE_
X-MS-Office365-Filtering-Correlation-Id: 0361dc52-a093-4ffc-438f-08db9a526b8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rJH3LutPkldKzA4DCqW0PFSw0IC/bTvUdi1mJepihIDF0ordZ9ziX5upW7ejsFZIKbND1tyXjOQfVVCEIoo6nSulaFHq8JNhTTkzVBdOS8SHO6XC09CVMkkSyVRQhFecYuqINVDVBcXi5lXGcxhiyzkJTbNddPw1/ybOqVQG2e0XMkCaT8jOpYmiMKfuu6YJCWHxBVxvsWzoEf0dIQeP6Q5LjIlbUqyA+3PAvxkTTv4g/Rlu31HG11a6heSiqeFk7PwHTDvvhNSfXziT9HnnUslQoiQiqhA+9ciKYB77YcgiUy4z7U/E5ArkTNzPsKSSpeOLM+8t+z3h/1Yn0vN/uoah1EBBNM0xq0vnEV3O9Aut6MfxYI+sfy91BJYOV2gIDqMWMHT5mKJ3crHDCw9wFb9D6eubQ2S9v0UiWV0eTvk8sSjFDSQToO0W5zAE1yItwdinsIlwbNRkH6ZiN7XFYQlTUeoSxEt5q8Uu49EzSvKIfl59hyyMg8UCVBsaNATlDKI6OeJYMJjYupSQAFw2MxCVjJl6tHHqgqcWS78WkqEZA1dzc3HbHv61b9nZ40p+2rnVjwlYZe9tVTiFG8WBsxeYqCwkQ4zdqXMxxReE2aG3yyMJY7ctl3hNXoolOQI+JK2ZN91tiIJ2IvZQP7qXeQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(1800799006)(451199021)(186006)(8936002)(8676002)(26005)(6506007)(53546011)(41300700001)(36756003)(2616005)(2906002)(38100700002)(31696002)(86362001)(44832011)(6486002)(6512007)(66476007)(4326008)(66946007)(66556008)(6916009)(6666004)(478600001)(5660300002)(31686004)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MEU4NlpMekgwcyswU3Bsd1NkWmk0VzZNa2JnMVFDd3Npc01KSFFJc2hNUUFp?=
 =?utf-8?B?dWJDQWU3NEI2eEJJbUVNZDVzYWR3SVkvdjlmTEFpUUJHWmpKN3gyRzZ5NzY5?=
 =?utf-8?B?OUVlVmxrMHNTRWJsOURobE01WisvUXVDcndRZW1oZ1B2ZFdNOWFoQnJTQTNk?=
 =?utf-8?B?czZXYVltck0wNUxPMzdtYUR6VkJCRjcvNDA4QlA0V2MyamI0Z0JpaUtDcEc2?=
 =?utf-8?B?aUM2bWlCVjVYaUpLTjhDMGlCTWRjUzZBMVM2OUdGU3ZidWtvVkdEOVVhYlFI?=
 =?utf-8?B?WHhHRUx5c0NZRzRTU09aQ09jTXk4ZEpsN0t1YWptOEg4ejNCd1N4R3p1cUpl?=
 =?utf-8?B?eDYrbDh3bW1FS3V1SEowNDBQSXV5SDQ0VnJvVkpxaWNMQ2oxTVN2b3hBNThk?=
 =?utf-8?B?MDlPbERoMXdzejRhOEdTUm01Nk5uTVZLbDR1OTZYU0Q3YkVUNmthRVFOLzRv?=
 =?utf-8?B?S1JuMFhCRy94eWgvM1FXNERiV3FRK3FPUzFMMitlcWFvdFdtdUpWMFk5bW9i?=
 =?utf-8?B?b2Q4c1FoYTVmN1Z3c3YwbXR2US81Q0tmTmQrejAwVGl4VzRKbWlzZkgzQkh6?=
 =?utf-8?B?alZsTW5hRkpaUkVpM1pPVFV5cDBzaXZMT1FqcXNPOWV6UWJaK0paQkZFbEFZ?=
 =?utf-8?B?a0h6eFVaZ3I0ek85RVRFQ0NpY0hNSmhrU3BZbEFJNTA1TUFqVFJuYURMKy9J?=
 =?utf-8?B?Y0VhMDVhcncxL295aTIzRm5NZ010RU1Bbnc5WWZET25VNms3am1Ra1pCMnc1?=
 =?utf-8?B?Qy8rVTRRQThuUUQzOERCU1JjRTZSRzBwWXFJZjFwbFArc2o4cGtCdWE1VWcx?=
 =?utf-8?B?c1FoZzBpakZxZk9Ia1FrdGhWUzVva2E3ckZhU1NHOHJvdjBxNU40UzZPbzhq?=
 =?utf-8?B?NXlNd29qN0hLbmgwRHVqMHBuZnljSFFOeTdyTDF2N09WdnNUdjZlRkdJTVB3?=
 =?utf-8?B?QW1JajNLRlg4emFPbmk0U2pMSGVYT2RCVEZUM2NDUkYwd3BWK0UzanVwTXZR?=
 =?utf-8?B?Y2JuMlAyei9MQnYvN1JTYnNRQXNMeDkrK2ZGVTJYYlF1dHJtRkc3SEJ0VndX?=
 =?utf-8?B?dC9tL1Z3QUFmcThEengxa3ZqVE40cFNIbTJBeFhVWDlBZmt6MFdMM2FkU1lO?=
 =?utf-8?B?UWtLeCtvajc1bnNSZkRhUWh4UWQwbXdOYmJNZjYxZUc4R25CSGNJYzk4SHZy?=
 =?utf-8?B?R0pteEltaFNlQ3BoZmxUMGg5VnIydWNjZGk3TDZ5SXAvOG1JZDV0UVpNWjg2?=
 =?utf-8?B?K3NjTm54NFAzTXEzQjczNUFRVDlqem5DT1pFTzVFaUM0WmZzeW5uU0FzZXRa?=
 =?utf-8?B?aWhldHUwRk5CeGIvSFBWNnlkMlprcnd6bUFrZy9nUWorMXdVSElsWWk1aWk2?=
 =?utf-8?B?c09UMFFGcHJ5UFZBTEl5RWxTL3R0YXhReUkrVS9RVG12RU4xTTFKcCtvZnRP?=
 =?utf-8?B?VHhoMmM0MFBRbEtaTWFPUktTU0ZzZEVsbGx0R2N3VVFqZFcwUkdRK0ZVQTRm?=
 =?utf-8?B?YjgyVHNBMjR5REJKazFLREowVDZvRmNjSWVDNVFsYldwVmtVUEZ2ZmZjOE40?=
 =?utf-8?B?ZnJXYVZEdjJ0UjluWS9uNFJjSmExV3FPcVFlRkpxWGdHbWtUM2FMdGRpdWpB?=
 =?utf-8?B?R2trL3VSK3VleTZrQm13OWlyUTdYUllJUW5rN2Y1WHRHM2Y5WlowaFpGNkxR?=
 =?utf-8?B?RmxuWDNKNDFjbUdEK1F1UENPSWE3U2VhMHpEV2dmVmNXR2E1TytwTWFyUVJ0?=
 =?utf-8?B?cldlQndYMm9iekEvc2VpdEhaZ1l3emxJa3FKclArRXM0VG9wWGs4bmhyNW5J?=
 =?utf-8?B?MVVVeWl2dFVsZ2ZWbk1TcGlkN2QvdnJGNmo2U3R5SmJQTFhGS0hXVU9ZeEl0?=
 =?utf-8?B?UEJqSVd2RXJBYVdJb1NzR0gwMFZBN0dnamR6TDljdmtBMlprTFBXM2dBTVBC?=
 =?utf-8?B?V2RkRHRaRFJBZDlHdllsZUdzRTg0TUdlZUZBbSthS3RNMlRQd3ZsY2MvRjdr?=
 =?utf-8?B?YkRpRkpGSEdDMWpYTnU2QWJteGE2N0RsakppZEpOL3pnZU00QVRQR1JXVXBE?=
 =?utf-8?B?VGVNSHE3eTAvWFdkcGIyTVFRWkZFNHZ5c3JWNzlzNE52dGI1NWp5N0hSMmN6?=
 =?utf-8?Q?K9GODwTHpigSawyzijvCQ2JoD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0361dc52-a093-4ffc-438f-08db9a526b8c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 10:04:59.1272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EipGF70X+y0YsWX7G9G6Ni8nyPHeBtWVUiAYzJG0PBcVWu9jyMCHwrI3fzCnuaaWwWcC7hQ98lIvB4tSWCRbrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6654

Jason,


On 8/8/2023 9:00 PM, Jason Gunthorpe wrote:
> On Tue, Aug 08, 2023 at 10:02:23AM +0000, Vasant Hegde wrote:
>> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>>
>> This enum variable is used to track the type of page table used by the
>> protection domain. It will replace the protection_domain.flags in
>> subsequent series.
>>
>> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>>  drivers/iommu/amd/amd_iommu_types.h | 7 +++++++
>>  drivers/iommu/amd/iommu.c           | 3 +++
>>  2 files changed, 10 insertions(+)
>>
>> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
>> index 0d339e022572..5e89032b3dee 100644
>> --- a/drivers/iommu/amd/amd_iommu_types.h
>> +++ b/drivers/iommu/amd/amd_iommu_types.h
>> @@ -555,6 +555,12 @@ struct amd_io_pgtable {
>>  	u64			*pgd;		/* v2 pgtable pgd pointer */
>>  };
>>  
>> +enum protection_domain_mode {
>> +	PD_MODE_PT = 0,
>> +	PD_MODE_V1,
>> +	PD_MODE_V2,
>> +};
> 
> PD_MODE_PT is redundant because the domain->type ==
> IOMMU_DOMAIN_IDENTITY already indicates identity. It is better not to
> denormalize the data structures.

We need to track how we have setup the hardware page table here. We can use
`IOMMU_DOMAIN_IDENTITY` for PT mode, but we don't have anything for other two
modes. So having macros makes it easy. Hence we have introduced new macros for
protection domain.

-Vasant
