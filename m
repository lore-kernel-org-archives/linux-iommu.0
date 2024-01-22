Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E000E3A8D7
	for <iommu@lists.linux.dev>; Mon, 22 Jan 2024 10:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705919010; cv=fail; b=jYKXJgK0FVeEhDvwVK/4PMr/EuOL6+at1C1RhJ2xh41N6PFL8Thx36D4AfHe2TyVbT50VaI+u+dMMOWtyuCdKCVvOhqYIA9u7QJAyESV9biwrf4Ual+cRUDi6zqxZWkp9alZgtuOG4o6FYPqNng8Wk8xKBFnhZPZ37bhFnY1MIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705919010; c=relaxed/simple;
	bh=/e7f/srtGL9beFja+lgnpZh+Q5jMdvV/Lsn4ChvHByw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LJKOF+2hxciOYsJuMvqxhydiAb2+Q/x8jqZlRIn6sTVATXvXWnJfllhjSN8V8GDXES4Uz4En9uPgSW1SoJf101OaDFCwCSgXrahy+9PftFgd49RSbDvLisi4M66wULI5Zvljd4x7GC41yY5Vo1xL75AHWAxF1QLmlcAhP8KqUvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eqUTAgAF; arc=fail smtp.client-ip=40.107.94.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eqUTAgAF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XnkGLnZ7faNIYqY6k706d8CBBcprxThVxlDXTok9InUOiJ8YdNrD+7bcY9kAC3Z52XEcka/Fuu4CT+w9fyAdu3tYFEpFgfWQ12qtLC2Ph0DQdWvKv7NdWFkLEixdIpZQ26ZGQyBV3EbyMFjmLV2+jLcrTWA387jbmFgJO3O+VGfOWu200OtxtnPRTSbs8q4pocv5LpniY0WEFbjpBvLgbWMAee0nIY3bFcxQ5wRcHIcYvgueRJJKfX9Aba2SsGhwf1/S9EWrlmAgCVX4qnGBcs78xz6H/WhXWmbyy5L9Q9WOVNB5CoaT0bGRoCBIB9pevlTxIArrlcMbwNhpxDq0rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1WZmZ1Qj4kp0DQOx20n7PGuYWMDjoHKxRweTY1ylZ9g=;
 b=jUDIVG214ZPevhzzKkT2lQv/0V9AqNtscHSbHRlUzPdgIjv0+sB7m95l8jSZkG/mFu0ykU4Pb9ueqn/h5jnm/ja9R+gznLAFEJwbCwtO8elLLHtkeS2+rI/GVu7SRTj8HN7OVY6G7tTSRlw54lUO+2k57EZIWL5Dm70QZ11xoTx4c9+HesbdEVyKnckK2OYo7+00fkoZeU3ErnODPq1iYUrRXJVhyFq2ZAz+8krwKBb8bDk4+jwSo785DgrFyz3dBmrGDqcgtsYf51SdP6fqS+sRnVcijrnC14B6+BOyQNsDhRVjmcnhxJ5LZZechJ7hgNxsLIYHyqbTxX115z4jSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WZmZ1Qj4kp0DQOx20n7PGuYWMDjoHKxRweTY1ylZ9g=;
 b=eqUTAgAFnspAToxPXYED0EhxtcZ0nTXFzqbkHg7PTgHJHIs9AyKaoDwtUuZ3xGYrZhLi7kvoF0LS3O8dirARPLd1ZXj8GgKVlICbP7nMHydjG5VPNnwhJSjhf5IzynsE9b8/bQc7vHOFBX9HcjA0gQ6YRJLC/n2DSVmYYv/JJms=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CY8PR12MB8243.namprd12.prod.outlook.com (2603:10b6:930:78::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.32; Mon, 22 Jan 2024 10:23:26 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb%2]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 10:23:26 +0000
Message-ID: <e8f2c380-acb9-bafa-c2b5-5445c0f06a4e@amd.com>
Date: Mon, 22 Jan 2024 15:53:18 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v5 14/17] iommu/amd: Refactor GCR3 table helper functions
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20240116165335.6043-1-vasant.hegde@amd.com>
 <20240116165335.6043-15-vasant.hegde@amd.com>
 <20240119195907.GN50608@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240119195907.GN50608@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0088.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::23) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CY8PR12MB8243:EE_
X-MS-Office365-Filtering-Correlation-Id: 776213c4-e1ba-47bc-a694-08dc1b342b89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OEjB+1MGWEhH2+lXCBnhnlXtrAjGVmj6P1kmTHIj4tX1WZP9iX/yBPkSru9zJLyb5umwVy+gvqwh5jitUEbDnxw4wHSLT4DU+3UFpeJzALAv2ykPnaBs7SQkQBSHt6OxQu1+WsL8Q+YLKFcLCpsbaxMXgxyvILe/+cbp5WL1vPtA7EBjm05SJ9hEf/HGipd4YxOnFOxePqrfOTGGAPyyj8eT0u1ze74oELhR7G6IrHvAlNH6ydpxMPNadsLylX5+Fnze7oO2gnyw4jFL28DFKjmmISbB9MIv0Fslj9GwFBrnsn39BE3+BbcOihQEqySkrs+Mv96/e/ZC6MZV/Uvv6lRwFv0hJ038I/Maqbhwxej3/ZQcyQPB0KFZYIkEWzZinSy+2P3np123sp6TbXB5jMgOJN/nSR+JgD2Bx9c2Jp5jA7CSuR11a7gsM7JHgvS4IrXmhAwGz6kZhEbVGdSWSSuqyo+ylSnDHfh7uslT2V77EvlkaGVZKPd9Apr1VHxjQ4Y91orcXqNjeO+olE2R/SIJ0lAxbJ34TQyO6Gzvi3GjghkYEBksLnMWAh3LnUv3QrMWGPy04XqNiF0XS8eQdcMtWdJU25FmYrirCcfZ7vWt7VwvO4IqTULEjSnZoQWzgTqUOP1baSnnDiFNhosw+w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(83380400001)(38100700002)(66556008)(26005)(53546011)(4326008)(8676002)(8936002)(41300700001)(2616005)(44832011)(2906002)(5660300002)(478600001)(316002)(6512007)(6666004)(6506007)(6486002)(6916009)(66946007)(66476007)(36756003)(86362001)(31696002)(31686004)(66899024)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTZKL0U0YVZuR3ZtakFaenJTZDN6NFVyVjJINTQ2QmF6Yzk2bkZTQTZZZEZ6?=
 =?utf-8?B?YXhLckNzRUFYYTNVazhZeWx3RzJjaEtPaStTMmloQnNvbDJtaU5XMUVPb0VT?=
 =?utf-8?B?T21tY3N0aWdndjQ1Tk5vdTRFMXpwVEg4UC9seXNSZElnS3J1NnNHSUFSRHNh?=
 =?utf-8?B?UjVwdUJuOS9ScjVlME16Y0JRdklWS3ZuOTlDVlZuWXVmTk41SmlwTjRUd0U4?=
 =?utf-8?B?TUp6RXl6Qmg5UVBtTEczVTgydjV1UlpMYkRScDFEZ2ozVUNnWlZCRkdaWmM1?=
 =?utf-8?B?NVVINDBPbUdJbTVsT3J5SGxKanR2WWc5L0FmUUxDMjJaTmFkSDFHakp6Y0w3?=
 =?utf-8?B?ZXpUZFJ5R2p0NG1lcXNyZnpEL1RCUzdGNStac1ZhV2ZhZkFTOTdHRzF5dGVM?=
 =?utf-8?B?WG0rb0pwMCs1anBVZXNaZmZsbXhFdFYvWE12RnMweWRmWk5mZlBhVGcwRHVl?=
 =?utf-8?B?NTV1Y21md2FXZHFyb0dIaWErTEFnRHl4N2JTbktXWXUwejNKZnpNaFoyaVY4?=
 =?utf-8?B?Y3ovR3ZUUFlOWGtzbXR3STFib2o2a1prTjZPcTBwUXRmL0VpMzNtbnBMU05w?=
 =?utf-8?B?aEdhVUl3dmNhOGFKbDAvemk1dGRDdGl2M3lnZm1oMDlyOGFTRWNyZ0tLSU9n?=
 =?utf-8?B?MlRVUkgzMWNObllwOXVMOFNENlFIR204TXZaUVVhM285bS9yb2haSE4yRGx1?=
 =?utf-8?B?eW41MVFNdE5rMGVLN3hJaXFvd3dxditSOGt1ak51eGZGMmlobDVJYVVqSEFX?=
 =?utf-8?B?K24ydGl0R2RTOWlzS0hsWFRYNGt5aEZXU1oxOUJaaHpmVGdYb1Jkb0NDaVBo?=
 =?utf-8?B?MVJUcUVkSDhSbW1TR2cwVUxZUTdFdEVuL0FyR3Nsck10RWl1RG1VNWc4YnY4?=
 =?utf-8?B?N1ZsQjNqT1hFUnRnNklXNm9GSW0yREJTUE80aGhTVmZhdDh1bnRRdGg5NDha?=
 =?utf-8?B?ZFlSbGtnN29WU0ZjVU55RFIrdVc0VDVzakxKbWRqdWsxVnpUaWF2ZnIwS1dq?=
 =?utf-8?B?SzJBUDhzY3owSkJJQkxTNlIxZ0hxRExCdXRJWjdRbW1jeW1ETUJEMTExYzVr?=
 =?utf-8?B?VWRQNXBQVzJJb09rSEg4UTlpYnE5RG1uZzNtK3FSdnY5VEhoa0Z3UmQ4U1lU?=
 =?utf-8?B?NEJQVEpwTmFJdVQzWXd3SXc5dUVrd2xEK1hLQXVQMmpGN1pycG14dWgxT0I2?=
 =?utf-8?B?S1RIQXduNDBqbE1tL1ZBWnJQS3NDbytjTkZOQVB0V01XWW5sbDdmaHREWTVa?=
 =?utf-8?B?YnJBb2FXMmsxSGZjVVczL2pFZXpyZGJ1QnJQclFjRWUzb2JVSDc4SWZSZ1hi?=
 =?utf-8?B?M2h3Mk1kQlBkV1M4d000ek1jNTdIcFcwczVwZzNON3doOWgrNTh5ODVLVVhV?=
 =?utf-8?B?UllBM1FHZnhwSFBBZFYwRU4rV0dQRk1udzdVeHdSRkFXeHQ5TGNFVElHeHBi?=
 =?utf-8?B?UXc5Z3FpaUlCNW1BanN4dzJOT2tRcndzSURBUTVJazZuZzhuUktLWnpVTXo3?=
 =?utf-8?B?MjBOcENEemxHb2ZoRGZBZlFBSkRJWHJ3cHc1UTJ5WjRWeVozTTlPTjJPbGhO?=
 =?utf-8?B?WVgwNlYrYy9kbEJxcEdqekpKR0JMbkljb1d0VXBQRmt1Y3Iyb3FocEFrQTJY?=
 =?utf-8?B?S0xXdzlKSHQzNlZlMDFLbkFlaHB4cVR1VERUSHMwR2daeVlPOVZVMDRRSU5U?=
 =?utf-8?B?MzJFR0N3WkJodzVIQVQ5TWpLSXpuRVY3UjczclJYRmhhUlRCQzRMa3RkZUgv?=
 =?utf-8?B?QU4weUxzRVg1VG9SMGQwNmxiN0pnM2hUNkRINUoyT3RRQmFoZVVVWCtTSGNK?=
 =?utf-8?B?c0tldzlXMXJxNHVTK0E1NXRETDFaYm05dEZQd0ZuQ3FHQVVvVElNL09sTkJ1?=
 =?utf-8?B?Y0NQN1VhQ1RYUkd6K2orMGdzSVhnaDRibjVmM2wxQTFjaGFaT3FNcEdUQW55?=
 =?utf-8?B?Slh2b3VVNDY2Y3l3czUzL3BoaW5MUjc0M29BTENqU2FHMFZMdEtBZDh0eWdE?=
 =?utf-8?B?OENTV25mcnk1b2tucjlQTWhDLzFOSVIybGdQaU4vZGtVbXJOSUY0QmhUZkFL?=
 =?utf-8?B?OVF4MWFxMS8xb2o1eVpqUmgxVWdQMno5cC9tbmtBQlB1SkZIMW8wNmw1d1RU?=
 =?utf-8?Q?ZbHYBeSimt1fHhZRJ+K3AFL2X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 776213c4-e1ba-47bc-a694-08dc1b342b89
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 10:23:26.5651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PxV9uiVMq8kUyqhNUBZpdptDlrZHHPTwUH3m5rUiP2uBI9USpoU7lKtk9il/eeDoor8H0m6o+bfZuA54DUiz9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8243

Jason,


On 1/20/2024 1:29 AM, Jason Gunthorpe wrote:
> On Tue, Jan 16, 2024 at 04:53:32PM +0000, Vasant Hegde wrote:
> 
>> @@ -1738,22 +1744,22 @@ static int get_gcr3_levels(int pasids)
>>  	return levels ? (DIV_ROUND_UP(levels, 9) - 1) : levels;
>>  }
>>  
>> -/* Note: This function expects iommu_domain->lock to be held prior calling the function. */
>> -static int setup_gcr3_table(struct protection_domain *domain, int pasids)
>> +static int setup_gcr3_table(struct gcr3_tbl_info *gcr3_info,
>> +			    int nid, int pasids)
>>  {
>>  	int levels = get_gcr3_levels(pasids);
>>  
>>  	if (levels > amd_iommu_max_glx_val)
>>  		return -EINVAL;
>>  
>> -	domain->gcr3_tbl = alloc_pgtable_page(domain->nid, GFP_ATOMIC);
>> -	if (domain->gcr3_tbl == NULL)
>> -		return -ENOMEM;
>> +	if (gcr3_info->gcr3_tbl)
>> +		return -EBUSY;
>>  
>> -	domain->glx      = levels;
>> -	domain->flags   |= PD_IOMMUV2_MASK;
>> +	gcr3_info->gcr3_tbl = alloc_pgtable_page(nid, GFP_KERNEL);
>> +	if (gcr3_info->gcr3_tbl == NULL)
>> +		return -ENOMEM;
>>  
>> -	amd_iommu_domain_update(domain);
>> +	gcr3_info->glx = levels;
> 
> I think this patch should also move the domain_id
> allocation/deallocation into setup_gcr3_table()/free_gcr3_table()

We do domain allocation in device attach path only. But GCR3 table
allocation/setup can happen while enabling SVA (like passthrough -> SVA path).
Hence I have kept it in attach() path itself.


> 
> But it would really be better to move patch 7 to after the gcr3 layer
> is cleaned and seperated from protection_domain so you don't have to
> move it in the first place..

Fine I can do that.

> 
> It is missing some error handling too

Where?

> 
> And domain_id_is_per_dev() is pretty redundant once you do that. See below

We need to handle passthrough as well. It doesn't make sense to allocate and
keep GCR3 table when we are not going to use it.

-Vasant


> 
>> @@ -1974,14 +1982,15 @@ static int do_attach(struct iommu_dev_data *dev_data,
>>  	/* Init GCR3 table and update device table */
>>  	if (domain->pd_mode == PD_MODE_V2) {
>>  		/* By default, setup GCR3 table to support single PASID */
>> -		ret = setup_gcr3_table(dev_data->domain, 1);
>> +		ret = setup_gcr3_table(&dev_data->gcr3_info,
>> +				       dev_to_node(dev_data->dev), 1);
> 
> IMO it is better to pass the struct amd_iommu * to setup_gcr3_table()
> and then it can get the NUMA locality more sensibly via
> 
>  dev_to_node(&iommu->dev->dev)
> 
> The iommu is the thing that will walk the table and needs the
> locality, not the end point device. Locality should flow from
> the affiliated amd_iommu always.
> 
> Jason
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 256b5507272ff9..fb94ffa269717b 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -1769,6 +1769,8 @@ static void free_gcr3_table(struct gcr3_tbl_info *gcr3_info)
>  
>  	free_page((unsigned long)gcr3_info->gcr3_tbl);
>  	gcr3_info->gcr3_tbl = NULL;
> +
> +	domain_id_free(gcr3_info.domid);
>  }
>  
>  /*
> @@ -1788,7 +1790,7 @@ static int get_gcr3_levels(int pasids)
>  }
>  
>  static int setup_gcr3_table(struct gcr3_tbl_info *gcr3_info,
> -			    int nid, int pasids)
> +			    struct amd_iommu *iommu, int pasids)
>  {
>  	int levels = get_gcr3_levels(pasids);
>  
> @@ -1798,12 +1800,19 @@ static int setup_gcr3_table(struct gcr3_tbl_info *gcr3_info,
>  	if (gcr3_info->gcr3_tbl)
>  		return -EBUSY;
>  
> -	gcr3_info->gcr3_tbl = alloc_pgtable_page(nid, GFP_KERNEL);
> +	gcr3_info->gcr3_tbl = alloc_pgtable_page(
> +		iommu ? dev_to_node(&iommu->dev->dev) : 1, GFP_KERNEL);
>  	if (gcr3_info->gcr3_tbl == NULL)
>  		return -ENOMEM;
>  
>  	gcr3_info->glx = levels;
>  
> +	gcr3_info.domid = domain_id_alloc();
> +	if (!gcr3_info.domid) {
> +		free_page((unsigned long)gcr3_info->gcr3_tbl);
> +		return -ENOMEM;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -1902,7 +1911,7 @@ static void set_dte_entry(struct amd_iommu *iommu,
>  	struct dev_table_entry *dev_table = get_dev_table(iommu);
>  	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
>  
> -	if (domain_id_is_per_dev(domain))
> +	if (gcr3_info && gcr3_info->gcr3_tbl) {
>  		domid = dev_data->gcr3_info.domid;
>  	else
>  		domid = domain->id;
> @@ -2018,15 +2027,10 @@ static int do_attach(struct iommu_dev_data *dev_data,
>  	domain->dev_iommu[iommu->index] += 1;
>  	domain->dev_cnt                 += 1;
>  
> -	/* Allocate per device domain ID */
> -	if (domain_id_is_per_dev(domain))
> -		dev_data->gcr3_info.domid = domain_id_alloc();
> -
>  	/* Init GCR3 table and update device table */
>  	if (domain->pd_mode == PD_MODE_V2) {
>  		/* By default, setup GCR3 table to support single PASID */
> -		ret = setup_gcr3_table(&dev_data->gcr3_info,
> -				       dev_to_node(dev_data->dev), 1);
> +		ret = setup_gcr3_table(&dev_data->gcr3_info, iommu, 1);
>  		if (ret)
>  			return ret;
>  
> @@ -2073,10 +2077,6 @@ static void do_detach(struct iommu_dev_data *dev_data)
>  	/* decrease reference counters - needs to happen after the flushes */
>  	domain->dev_iommu[iommu->index] -= 1;
>  	domain->dev_cnt                 -= 1;
> -
> -	/* Free per device domain ID */
> -	if (domain_id_is_per_dev(domain))
> -		domain_id_free(dev_data->gcr3_info.domid);
>  }
>  
>  /*
