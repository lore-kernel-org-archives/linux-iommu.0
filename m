Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F2C1078E
	for <iommu@lists.linux.dev>; Tue, 20 Jun 2023 16:16:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ki7Cw+as3RpOlrWS6V5E4GU5DM+3KhCfGtyWN0P40ZOev4sypkEn8iWy4pZf3zESq7fVXDGlTnex6HEqRqzAUil6TgcNZPLOfGN6mNk6OGwcqX2E3bEgBb6HxBpbB1a47qcNlMS1IwiLmJ9QE/TdD5OGjKBEotx8131rMH6ZbXgCmIpTi4sX9mEpTQ1kAzrocTcy/HX1A8bHIrqHIs+wo0YnsoQixqb4fewsMMl6wiQVs+51eMzixTYohZE7cDIhfjRuBOIRjzmqjj2jkfRFCUOKtInafBecioOUqft5nkcFNR1rg9U2ah4y4rYKC/WT/b8rrMBJ4GI+fzsSLld8Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1KIZyo9GB2dgxzfnMs8pciP8QuTZCoiMjRlKGa1FyA=;
 b=lHX0DuYhrvEwWdYaHaKzGMeCGbk0o/PHbYF0wMPduxZl0nNZOoOOi1zDbQsjj6LZ6b26tev+y6jFICnceetNe9/m9TjFIHtSGOXW68zFUlvWWlGTdVxbeTe4eSAuC/N20BJqWBbFm012AwRx5sgXFHxtSnlYPnkP2raPqXshE0xNyGGnU0xiASPDmTdQMXlCOzNE8l44CakNb01U2VUfyFcgPe/mr/H2zFFSUv7QihSKykZ4rKMoF81SVXc6/XmcqnsFVVsHf/tD5KZdOxjX+VBvYszAE6A6J8FTE2mNXI8XSUdpBrksH0g6Ptool6/r4cH3OdcOH6lKXKdPwPQkCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1KIZyo9GB2dgxzfnMs8pciP8QuTZCoiMjRlKGa1FyA=;
 b=tp2rbJLsfel4pDb8AWQdicmx9rcE8PvgzXypXizBEn2yhQoMdaNVwgaBo/pH0p+Wi+q+syu3KPF13MZsTTeyAsF4Xd1Qgufwkc25trJwoQ8FH8piT9wz0b1DTgwX7q6mDxl+NFphn22jWW6Y39s19VeLJrxAuuuGhFu2UmL0bYo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SN7PR12MB7180.namprd12.prod.outlook.com (2603:10b6:806:2a8::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.21; Tue, 20 Jun 2023 16:16:26 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::7cbf:236a:55b:2c99]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::7cbf:236a:55b:2c99%4]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 16:16:26 +0000
Message-ID: <bfd1e328-723a-c089-79fd-73440fd790be@amd.com>
Date: Tue, 20 Jun 2023 21:46:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/2] iommu/amd: Add separate interrupt handler for PPR and
 GA log
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>
Cc: suravee.suthikulpanit@amd.com, iommu@lists.linux.dev, joro@8bytes.org
References: <20230609102025.6498-1-vasant.hegde@amd.com>
 <20230609102025.6498-2-vasant.hegde@amd.com>
 <5532b0f2-3e9d-c4f9-07bc-7c07db8bb1ca@oracle.com>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <5532b0f2-3e9d-c4f9-07bc-7c07db8bb1ca@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0058.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::17) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SN7PR12MB7180:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f405971-a2e6-44e3-1030-08db71a9b260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ds/USnHiPrMzQLrmqTHr3+gAz76oRlidanGYJtQZ5iIakG6ktEU1Plmf4SdOq3waiGRXKFr+sqU3O//9YuT3whQHFCQMAStRRVBKaZNkIfQkU0w/UNASxWDyjcEtgcjEgmBe0j1OrDccBIm5KcOJlzuCgACx6WgfHIXBXXCVGZUWvsRrcGg+GeVH6NbU9xVeABlDTOU2dEcTbrtX2NEnSe6Yi/cMwjP4UpQynaTSRGeqOFEGNx7j+qqpSH4Br6Ze4gW4wQ9aXEPe1XqsIozagwWom/QvEtUOLivzdRX3jjQvZTEIib+xJQIrwxSMjSr+yA+I+5FGSVtuctDZUgUNFey//bPrARSLnwODjzvZEltjOs5juDKDPakX1CkHYNH7gdVqEb5sGIJAtNf0t7KxT/TxQN3DNXZJo9wBohfKavrS2/Nq4rTGDRIYcDa8bidPcilRSJOR1aFoLEC1qUM8VTk3MK+bOImMZYf16mDCrZTbLw8UyIEXTB/t5eFfLXnDSrOf0ypLYDJUInceWpVVA4vgFnVK0ssDT3Sj8cOQcnfkxTzR0xWBymRsiKnWY62YLDXV21sl8LC5T+jdvHhQ1X0tzhvNOf3UtZqjwPxlFkwa4MF/FN3Anypn1vBWOAhXDwCg3oSE3MOa8NiqGYCnAA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(376002)(396003)(39860400002)(346002)(451199021)(2906002)(2616005)(83380400001)(8676002)(478600001)(966005)(6486002)(6666004)(5660300002)(6506007)(6512007)(53546011)(8936002)(44832011)(6916009)(316002)(4326008)(66946007)(66556008)(66476007)(26005)(186003)(41300700001)(38100700002)(31696002)(86362001)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1ZNTGt1NFNDcFQ0VURFdDRBTUtNcUxJSVpCTnpIUkNrYjhDV3RPZmpkNllZ?=
 =?utf-8?B?eFFyZEhZaUFUbi9jVDRReGJwalh1QVNOS0Roc1RiOWpnQzlxZHZZcVdUVWNL?=
 =?utf-8?B?YVRZdVFKcjZlTmZOaWlvVWlnUC9pU3Y5RVlyNkZwdWVmVDVRNTBnQzRPL29r?=
 =?utf-8?B?NTFaZDRIUWM0Q1ZKMDFad3lBM09idnBFRmFqOGVKUTdxcVpzazcyb2xxOVEw?=
 =?utf-8?B?NFd1YzZTelFjQ3Z1RUZNZnozeFhtT3REeXdWb3paWXh2QURXS0lnbENqZWc2?=
 =?utf-8?B?L0Z2dkp4d3YxWHowMFpmeEMyWCtoWGVqTXhnQ1c2cUh3UTl2d3E5anJ2YlBY?=
 =?utf-8?B?STU2UTFOMklkTUY2TzR5UnVEbVlKMVpFazY3NnllRUN2WjFQNWY0SElGbGZy?=
 =?utf-8?B?RzUycGFvd05qY20vcUgrZFg2OXdvTmNZejhoRHJ2WjI1TFZKYzRMcnhlN2l3?=
 =?utf-8?B?WXNqemJhM1pvSHdYQmRqY005eUx4ZW5GN2VkL1VNdWlDcmNuYVJ0a1FzUDFq?=
 =?utf-8?B?M2F5eHFIZUZsa3NuS2tGK2FSaDR5bjd4dVVITU9LK0wvNEhUOUlaK0o3bklX?=
 =?utf-8?B?NXA5Nk01UVh6ZkJpL0hjQzBuVmZCVTNjTFozeTFCMzV2NmhCRW56MG1aOUF4?=
 =?utf-8?B?NWpkRjhHTzFNTTZXbFFyTDlxbXZIMTljaklBMW01R0RaK3dBbDlDQnc5cEV4?=
 =?utf-8?B?aFB0MWdsNDRGWldGZ1M2ODN5TFJDaEFhUExmWi9pYXZpaUtpQllNY2N6MG1s?=
 =?utf-8?B?L0lpdklhaFB3cjdjTVU3SHc2dHlmcjhDYkF3VWtUcTR3aU1yMlhPbUJ2TVRB?=
 =?utf-8?B?Q1RYZk0zSHhRS25ibjUzRjVLQU52MGlwVjJ2UVFkVDhBb09iaTF5V1ZJQ0lF?=
 =?utf-8?B?QVlNaEsySjBuc0tYQkhuYjdGWGZqZnlheGM3ckQvbWJSMDRia2ZCUXhxU3pG?=
 =?utf-8?B?N0VVQ24xWkU2eDVkUjBqeHdlQnlLM2wxdkE0T3NyVTFiM0dSRFkyUW9yOU5U?=
 =?utf-8?B?ajA1TmEwS2VnMU96R01nUGh0N3JkaWZqdjJCcGFwTS93eXRqSFd1YlExRUIw?=
 =?utf-8?B?S2hWdHZobzVuaktmTkZuV2ZyZS96NFJEYjhJa0RtNFVRQmNKYjNsNmJOSzNz?=
 =?utf-8?B?cDBDdFdaaVRhUEplSmhQMnV0WVFhZVNPU3dPYnRIQ010L1BFQTdlSHhiMUlG?=
 =?utf-8?B?YVJacVl6ZHhNUHdnQW41anMxTXBFTWtKY1Q4SW91Nkt2THpGK2dRMm81bFpM?=
 =?utf-8?B?WjRFeHd0THRzOEw0alB4blowRDBYVzZyVit3cjI0QXRuZmhUaDN2V2Z6MzlM?=
 =?utf-8?B?aytXS2szcFhNRW1TMGJud3lRZnlSMnQydVV4d29OMDJmVXJha0FvT1Nkak8v?=
 =?utf-8?B?NXl2RldmMG1kLzA5bWJoeHI5UjNLY0NHQzNtSTlCakFsN3krNXdQWkUxcjls?=
 =?utf-8?B?YkRyRXF3ZTN4NFRQNmM2bzcwU1JwVWhJZVRXaldJSG5XTFZxOW9aMzBrWUcw?=
 =?utf-8?B?MVRqUExBR1BWaHhuWjVzeHJRenFyUUNiTTJNUHpBL1UvUlJuSkZPWEQrQm0x?=
 =?utf-8?B?R0lncEd3NXBXRFhvZTJyWStodHJ5ZDlsSzlsN1drQmw1VTZpblBlWk14ejha?=
 =?utf-8?B?R2JCOXBzaHZDY3c2bVFpTVVwcVpEQkc2clBzQUtOQlNkODR2RjB2TXY5SVBh?=
 =?utf-8?B?SWlFUDF3RFVSQWdBMmRnRDJOc1Z4SUQvbTVWQWhyd2NaU3Z6MnVXUUVhZzFO?=
 =?utf-8?B?U3orRUlFRDNuRjkvb09CR1pDM3U3em1XWTVGNXVPMjFEbXQyMnFhL0pLNzJ2?=
 =?utf-8?B?cGlrSzhwZG94d3ptRUtFQi9TZm9FdXFUa0RrSDdFYUd3cDRCS21uSXVWcjRt?=
 =?utf-8?B?VU1kWGdCeFA2OGZiTkh5RzhxZEVSMnlUaXdHcWFTc1lycXVlWU1YQXFkYzVC?=
 =?utf-8?B?enBTWGtFYnAwQkJFL2tpUHBpZHBybzBPNk9CYksyVmZyNjFMVGwwNjBGbllu?=
 =?utf-8?B?Qk5qSFdBVThwN0ZJeXZUcFZlWTd3bVNYRmdFemI1dGIxcElmUDJQdGUvMWpK?=
 =?utf-8?B?Ykl0N2U1KzRWT0lRREdsUi9JcHJpbVZsbVBvT0QrN2VlVlRWeWRQR21URTZ6?=
 =?utf-8?Q?8fgFdBVSWiOc0F7ryfti1/C6H?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f405971-a2e6-44e3-1030-08db71a9b260
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 16:16:26.2831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DO8Gn/qte8K0Y9E9bLbHriZhDZ/M6LQIJMNP5R8ME3Yw8WXgFL0sNFnBYO7//E8bgLmk5/6JofRGMpH8rcZ0Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7180

Hi Joao,

Sorry. I missed to Cc you in V2 version.

Can you please look into
https://lore.kernel.org/linux-iommu/20230619133008.6221-1-vasant.hegde@amd.com/


On 6/20/2023 8:31 PM, Joao Martins wrote:
> 
> 
> On 09/06/2023 11:20, Vasant Hegde wrote:
>> The AMD IOMMU has three different logs (Event, PPR and GA) and it can be
>> configured to send separate interrupt for each log type.
>>   - Event log is used whenever IOMMU reports events like IO_PAGE_FAULT,
>>     TLB_INV_TIMEOUT, etc,. During normal system operation this log is not
>>     used actively.
>>
>>   - GA log is used to record device interrupt requests that could not be
>>     immediately delivered to the target virtual processor due the fact the
>>     target was not running. This is actively used when we do device
>>     passthrough to AVIC enabled guest.
>>
>>   - PPR log is used to service the page fault request from device in Shared
>>     Virtual Addressing (SVA) mode where page table is shared by CPU and
>>     device. In this mode it will generate PPR interrupt frequently.
>>
>> Currently we have single interrupt to handle all three logs. GA log and
>> PPR log usage is increasing. Hence, split interrupt handler thread
>> into three separate interrupt handler function. Following patch enables
>> separate interrupt for PPR and GA Log.
>>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>>  drivers/iommu/amd/amd_iommu.h |  3 ++
>>  drivers/iommu/amd/iommu.c     | 98 +++++++++++++++++++----------------
>>  2 files changed, 57 insertions(+), 44 deletions(-)
>>
>> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
>> index 156f57b4f78c..e2857109e966 100644
>> --- a/drivers/iommu/amd/amd_iommu.h
>> +++ b/drivers/iommu/amd/amd_iommu.h
>> @@ -12,6 +12,9 @@
>>  #include "amd_iommu_types.h"
>>  


.../...

>> @@ -908,6 +874,50 @@ irqreturn_t amd_iommu_int_thread(int irq, void *data)
>>  		 */
>>  		status = readl(iommu->mmio_base + MMIO_STATUS_OFFSET);
>>  	}
>> +}
>> +
>> +irqreturn_t amd_iommu_int_thread_evtlog(int irq, void *data)
>> +{
>> +	pr_devel("Processing IOMMU Event Log\n");
> 
> Similar to the overflow series you could probably move this pr_devel inside
> amd_iommu_handle_irq with a const string as an added argument (...)

Makes sense. Will fix it.

> 
>> +	amd_iommu_handle_irq(data, MMIO_STATUS_EVT_INT_MASK,
>> +			     MMIO_STATUS_EVT_OVERFLOW_MASK,
>> +			     iommu_poll_events, amd_iommu_restart_event_logging);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +irqreturn_t amd_iommu_int_thread_pprlog(int irq, void *data)
>> +{
>> +	pr_devel("Processing IOMMU PPR Log\n");
> 
> here (...)
> 
>> +	amd_iommu_handle_irq(data, MMIO_STATUS_PPR_INT_MASK,
>> +			     MMIO_STATUS_PPR_OVERFLOW_MASK,
>> +			     iommu_poll_ppr_log, amd_iommu_restart_ppr_log);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +irqreturn_t amd_iommu_int_thread_galog(int irq, void *data)
>> +{
>> +
>> +	pr_devel("Processing IOMMU GA Log\n");
> 
> here (...)
> 
>> +#ifdef CONFIG_IRQ_REMAP
>> +	amd_iommu_handle_irq(data, MMIO_STATUS_GALOG_INT_MASK,
>> +			     MMIO_STATUS_GALOG_OVERFLOW_MASK,
>> +			     iommu_poll_ga_log, amd_iommu_restart_ga_log);
>> +#else
>> +	amd_iommu_handle_irq(data, MMIO_STATUS_GALOG_INT_MASK,
>> +			     MMIO_STATUS_GALOG_OVERFLOW_MASK, NULL, NULL);
>> +#endif
>> +
> 
> As you and Jerry was discussing the else is probably not needed. Although it's
> probably easier to just move the ifdef into the function below (...)

If I move it to below function doesnot work as next patch configures separate
interrupt for GA log which calls this function directly.

-Vasant

