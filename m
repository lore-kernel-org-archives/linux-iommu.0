Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D34D323B
	for <iommu@lists.linux.dev>; Tue,  7 Nov 2023 06:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TDGYNuKz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f5e2zqNm30wqM2cXBxwB+yPPmS60BdNdw3Y9QLtmouA9W05yivjYrZFEvu/bf71hZH+PNrowBU22X9nCu3ae1GlGphUCTIqRvaMDf2XrFxaGBiudGM+YjX3sbO+ImVdbUymEHacFGPStzx8Zw1zeBAEWtIVqEOfDFqsHunkVyQyhykaKrV/6LsioLZrur3DoJz1YbUrtN5Qqq6seI9oBjwRk505pTY34u7pwbm5RQ36u+o6NV3I2sBWauOr8oyRt5nQMQYuXfvbF5pF4qFGZ2hjVufL1vdwL4KmjWMYKC6yEJe5LOuTuRCoG1PXoLMMdkbAA3Wl9umA1ecsAYBIq6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rU7QucKcGRiVmSjl30YP4EIKLGgmbOldVTf4lL1+0oI=;
 b=i5/Fam0qwQTgabtk6V+7lOQRtxZwBqrHxCjmABTZGMgmbarXksMc2pWVBHAoZDTGp8V6Tgji16l/jsbNNxC3Zsyup8KCcS2kPhPLPQhYHuG0PXvQj1RWkAlIMoRvbn26m6sDtZSr97kBVrFi34QrY9noiYW5Rywft1+HOTmVhOB2KDl8fhTy3A7ex2YKR1nx/GFw1c8uQAbwvAP4lO5fx3oaWzeo3wMRakzFgGHssi1tyvFPX4Bd39EXzBdKMcJaN6z31NQrrtVWWRQl9Rxml6dhyRU9vcOXF0xT9GB89/u53B8f716Cs9V5sNtfzHdBZ59M91L9EaW1l8XVJ+qudQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rU7QucKcGRiVmSjl30YP4EIKLGgmbOldVTf4lL1+0oI=;
 b=TDGYNuKzY0coxxkAf/o25F5CMDFiCU69d5iL2Bnu4kJ/Gx0tslpnAnwGJfcru5cHieh5nNvrnajsqdwIYo37xYvYAp5rpPNkAszRDjKLdv4YEVY3tRM9RzI3JpoO6/aoO6V9DIqScQ0LEpXo9m4NaF1QPa4eealpRukxw0d4KCI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 IA1PR12MB7733.namprd12.prod.outlook.com (2603:10b6:208:423::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Tue, 7 Nov
 2023 06:13:18 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::befc:daea:28e6:32af]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::befc:daea:28e6:32af%3]) with mapi id 15.20.6954.029; Tue, 7 Nov 2023
 06:13:17 +0000
Message-ID: <d905c553-964a-b15e-19f5-1be4896a7818@amd.com>
Date: Tue, 7 Nov 2023 11:43:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 12/13] iommu/amd: Refactor GCR3 table helper functions
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20231013151652.6008-1-vasant.hegde@amd.com>
 <20231013151652.6008-13-vasant.hegde@amd.com>
 <20231106174003.GP4634@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20231106174003.GP4634@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0177.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::19) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|IA1PR12MB7733:EE_
X-MS-Office365-Filtering-Correlation-Id: 098a514e-1b26-462b-365e-08dbdf58a1eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	68PRTCtxtfJFKpQ5+VJMtUvyvG/f3Bc7pSlJzXFjnZvqsXnZrPjn1tTz/eEN9Wb5srDqjzN4O/FIA/UxwsKGDuv1r4SsJq5ENiBSV4qs11poTXEKK/Ce6fTq8neqifk1wxhUNTrphe1+7BdSZoIHgREGWtsq2q3glgfLMGHzbGvN7JZRKug2++qO0DGpwKBjGG5R9DgB7AQRwgRR/G/Q4pVjr6KL5nk0zTcZL5atjx2cONfjaT9MYUBT/p3GhjjeF8Otnjz/pKqUrSVsCXr25vALNiTXNAeySrotWY3elNR1ksYpQgGJIJJgWpM4QKCXryjWX2zIqWvP7futRFvRoNvTT/mWtRRPHqhe+ZdGHubnrVSv0Tt511A4m01wqqTpdckAAlmfYY4G8f+cIfrq0g2CeQRDz8HKqkCrpijhWShvBsBUiu+8vSLuhy4hlLWnKS7hi6vvHeCzejssCjfi7J0w9Ze/3SG0aOoHkqOYs96aPCq7Z2A7o3sIDGR28LkEbKblmqyeJ1tnoNfrj6B4ByCoeLV0w67Lr9lvihuBcJKlX11UBnytUdsNNHgSQunegzPmGp5k9u5l4ZRFXDoZJSFbsz0yyjuvAQkDpNXaDufN1pZiZzJCBk3JLdq6Qmsph1Pjb4xZdA8ioICSSxay4Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(346002)(396003)(366004)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(38100700002)(36756003)(5660300002)(41300700001)(2906002)(31696002)(86362001)(66946007)(26005)(66556008)(66476007)(316002)(6916009)(31686004)(6486002)(53546011)(6512007)(478600001)(2616005)(6506007)(44832011)(83380400001)(6666004)(8936002)(8676002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vkl0N3dBOFgwT2RsMmVWb3gwSjJ0bFNaYmFPMVdaSS9Bc0YwR0ZsTjdIQ1N4?=
 =?utf-8?B?UHhhdmtVSHpKSjFSbER4djVjWjJGRmpIays4ZURjbzlOLzdyY3BSTjhUcTN5?=
 =?utf-8?B?YUhhdnZwbzRjbVlEb2VKaktZNHZNNTZLSEt2SWJ2NkxuK0ZXVVZNN2JjM0xZ?=
 =?utf-8?B?NU5TZzVWRktQRDhZKzZ5RDNBSUxZOUNWSjFwSHliUjZyWlB0ME4ybmJiN1No?=
 =?utf-8?B?ZVNiODZ0MzdyUWtzbnZSOG5iRkEzNHVOc0ZNYi92VVJDb3JpZnMzaWtTSW4w?=
 =?utf-8?B?aEgrQjJiSzlrOWdYdjhzZGdSeFkyM2IwZk9ZcitwZGl5YWwrVXcyN21DbG5y?=
 =?utf-8?B?SGRJcXdaNmMycGhZL2w1bjJZL0FHKzlxUGllaG1CMXhGdDh2K2wxaHhySFhQ?=
 =?utf-8?B?OThpVTJtSks1OXMyQVJzUXVmVlJQTm9XVDQraHc0ZzVPUFpXTnRrM2JsVTNR?=
 =?utf-8?B?RXVOeEwzenk3WVM1dnh4WFIyYzBkOHY3RnpiL2FHTUVPUVJTNzI4WFdhVU56?=
 =?utf-8?B?MzA3NEVMQVZPdkxiZzhWMzFaczNEcEtLNTR6T0IvalNTR0h3cGR4K2lBRmh5?=
 =?utf-8?B?UVlRbXg3SkR0WDJwdTNjanhkVG93VmNiNUVjd0hQVG5SSk1jcXZCYkQ4K3U5?=
 =?utf-8?B?cm5YMmxvK3J2dTIyc0FjdUlLejMvWWRTbG81TUxsYWVubFhUVFdtWThvZjJ0?=
 =?utf-8?B?REhBR0MyV0VabFBHSXlwWGxSMVRNYUplejFaSkRPNkJ3empIaHZweXdENjUy?=
 =?utf-8?B?Vk5NNDBTU1NwWkw0K2N6c0dUSG5nM0hFTWhnZjljWGlkdGo1SGRnMHpmQmwz?=
 =?utf-8?B?ODNUQ3JJSWRHbFNlUWRZQTk3QlAvUVQrZzRqVU83YmhXa2hVZXBma3dESjNo?=
 =?utf-8?B?blNscVRjMVF3cHNQYUhsOGZBUndCUWxxc21PbkVFQWRmVm5TeExhd1hIbzZ6?=
 =?utf-8?B?bG11ak1vbVVEeCthWHhadGhyOFhhQytCR21kMCszU09tUERrOG9IOWhudFRz?=
 =?utf-8?B?UUNYcjEyRzkydUZHRFpnU2VsViszamhMSmpYWHlMU3ZoeHRlbUR6R0lrQmVS?=
 =?utf-8?B?WXQ0M1B0ZkllTWV4cE53UXM0OVB2dDFyU05zRkZ4UFNqME5OREM2anVxSlVJ?=
 =?utf-8?B?RHNSZlZRU1REZ3dKTG5kSDR0cEpobVFsVmZXOE00OWpnZCt2RjBHRjdTMHZG?=
 =?utf-8?B?eDVLTllsVE9kdS84SVpFTUd1RUFlMlQyT1o2NlFJMHdEd0NCRWtrUTNFSmpn?=
 =?utf-8?B?ajY1ditZRW9MbXF6MFI4S0locFRvTDFDaktXUEpMTGhKU0pBYnc2RDBka0Vh?=
 =?utf-8?B?SG1zcC9reDVoeXl3ZVQ4b2Rxd1ZFL0FXYU9SM0piTXVJWmFzVXVCZE9MNVEx?=
 =?utf-8?B?MWJmWWVqSU5TcTU5VGcrc3RmcGNIMkZOOTZFUzB4K3Jza2JHbXVMWjVNMklP?=
 =?utf-8?B?MkwwMUpKOHVvSkZ6YWlEaERZVVM4N3BvdmZ5OTE2eWhJdXdDMmJIVllRSmtF?=
 =?utf-8?B?UjhiSGhnVlpUMUtWVXBvY054Qm00Z0w3TEdFNkFRUWlKSlJiWjJRYnFKL2R5?=
 =?utf-8?B?M0VaYi9lSnhYTFRveENTTk1JQVBCeTF1ZWhDYml6Y0x1d0FadjZYSWVhc2Ry?=
 =?utf-8?B?a3dBRDdUVG81V1F0TkRFZXhkcnByZUs3T0VUbDJ5TE9ROUY2VUxMZ3Mxa0ow?=
 =?utf-8?B?V3pPbVdEQ3ppUHN5REVab20rMTRUaU9rdDFTQmRub2ZrU2JrNVdtNGZwck5l?=
 =?utf-8?B?NHBpamo3dTRaOEtEUGJITnZvdERMdE9qaHBOWEtZWUlGb1VnSFRKalQ0YzFn?=
 =?utf-8?B?NGxTZVd2OEVpVDlNZzdvK3FjaytZbGR0VUExNjJYYkJQazZuclBvekVlV3Rw?=
 =?utf-8?B?anM0RkRldmVTWWRuYTk5VVlxQkNhY0JSV0pmaW9HYm9ORWF6a3VaU01TWjdp?=
 =?utf-8?B?UUloNVU2U3VRVGpiRk4vbWVjYXNwa2hpR0VJWW85czlNZVBpN0lCUktuaERQ?=
 =?utf-8?B?TzJUem0yV3lYa05hTFVhUithczZOMDRTRUlyQURnWkhMVkxoVkZraWFjV1dq?=
 =?utf-8?B?TnBLSmRUYnhXYzY3aFpJSzNSeGpDREViZnR6VTFyS1MrT3d1enZvU2NPVi9F?=
 =?utf-8?Q?Y4xYN5sksmkrkUNBxfriqs3O9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 098a514e-1b26-462b-365e-08dbdf58a1eb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 06:13:17.3066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LZmK0vaWm0vgKNob6D5DbWd5Ox4ksfR5GfkIiuDoS0TSyPWFAT52lNU10OdyEJoUYwaIDD/RvL3GMi+LenO87w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7733



On 11/6/2023 11:10 PM, Jason Gunthorpe wrote:
> On Fri, Oct 13, 2023 at 03:16:51PM +0000, Vasant Hegde wrote:
>> -static void free_gcr3_table(struct protection_domain *domain)
>> +static void free_gcr3_table(struct iommu_dev_data *dev_data)
>>  {
>> -	if (domain->glx == 2)
>> -		free_gcr3_tbl_level2(domain->gcr3_tbl);
>> -	else if (domain->glx == 1)
>> -		free_gcr3_tbl_level1(domain->gcr3_tbl);
>> +	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
>> +	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev_data->dev);
>> +
>> +	if (gcr3_info->glx == 2)
>> +		free_gcr3_tbl_level2(gcr3_info->gcr3_tbl);
>> +	else if (gcr3_info->glx == 1)
>> +		free_gcr3_tbl_level1(gcr3_info->gcr3_tbl);
>>  	else
>> -		BUG_ON(domain->glx != 0);
>> +		WARN_ON_ONCE(gcr3_info->glx != 0);
>> +
>> +	gcr3_info->glx = 0;
>> +
>> +	set_dte_entry(iommu, dev_data);
>> +	clone_aliases(iommu, dev_data->dev);
>> +	device_flush_dte(dev_data);
> 
> This looks super wonky. We free some of the gcr3 memory and *then*
> update the DTE? Is that ordered properly?

Its not. I have fixed it.

> 
> As per my prior email the caller should have already updated the DTE
> because it attached some non-gcr3 needing thing. Once the new DTE is
> in place then free_gcr3_table() should simply just free the allocated
> memory.

We make sure its detached before attaching to new domain.

> 
> Commingling DTE manipulation inside the gcr3 layer is not good layering.

Its not GCR3 entry update path. Its removing GCR3 completely which needs to be
reflected in DTE. So it makes sense to have a DTE flush. Having it here is
causing extra DTE flush. I have already moved this to do_detach() and
amd_iommu_gcr3_uninit().

> 
> You should be moving to a direction where the ops->attach_dev does
> exactly one update to the DTE. It loads the new correct value of the
> DTE that attach_dev is asking to create. All this repeated touching of
> the DTE during the attach_dev flow is sort of a functional bug, or at
> least a sub-optimal implementation of the API.

We are not touching DTE repeatedly. We do need to detach device (so touch DTE)
and then attach device to domain (another touch).

I am not confident to make change like above (i. e. just attaching device to new
domain and then destroying old domain related data) in this series. Those
improvements can be looked into it later.

> 
>> -/* Note: This function expects iommu_domain->lock to be held prior calling the function. */
>> -static int setup_gcr3_table(struct protection_domain *domain, int pasids)
>> +static int setup_gcr3_table(struct iommu_dev_data *dev_data, int pasids)
>>  {
>> +	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
>> +	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev_data->dev);
>>  	int levels = get_gcr3_levels(pasids);
>>  
>>  	if (levels > amd_iommu_max_glx_val)
>>  		return -EINVAL;
>>  
>> -	domain->gcr3_tbl = alloc_pgtable_page(domain->nid, GFP_ATOMIC);
>> -	if (domain->gcr3_tbl == NULL)
>> +	if (gcr3_info->gcr3_tbl)
>> +		return -EBUSY;
>> +
>> +	gcr3_info->gcr3_tbl = alloc_pgtable_page(dev_to_node(dev_data->dev),
>> +						 GFP_ATOMIC);
>> +	if (gcr3_info->gcr3_tbl == NULL)
>>  		return -ENOMEM;
> 
> Why is this in an atomic context? I can understand that the domain was
> because it used a spinlock, but this should now be locked by the group
> mutex which is not atomic.

We still hold device lock. It will be fixed after switch to group mutex lock.

-Vasant
