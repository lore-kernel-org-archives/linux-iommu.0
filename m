Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CFA18659
	for <iommu@lists.linux.dev>; Mon, 11 Mar 2024 11:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710156018; cv=fail; b=DBwj3WWWzToVnarSes4bY24AjoWR9l0Zdm2czPCAeA2smz4o9w1+W6pbZlTuu4nYYSzDKK3vl1cAT9LTyYUDuSI+6ccvsXJ5l+P1hjGjGfB0antXtwq5scgjqPcbwRxlNENQnXCX6oR2TNIrwtYtoS5US+9KyIDImLzGSpvoUw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710156018; c=relaxed/simple;
	bh=cFEisg0gMgACOjp/c+SnsKcP8RPvlUo/UiuzUeNRqfU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WqnRBaEQglMylL4fobWD4PHQAK3LJH7qzzaomxeh0wT8OChNtlBDvfqzeOnEiPtSbEQUFZWYRePzpMkgvGf8apaVSls5ejxDI8aEheEjO4y7vw05FTIn0lwuoT4lUwZaopwKZxBQHnsqOFxx51Oy4ZcEtlkvN1k0i5e6ZElBOCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BfkkQ+IF; arc=fail smtp.client-ip=40.107.92.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BfkkQ+IF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=buLCq1EK7SCeMD6BGpnWJshq8YTw32bbmL7FOP42pcrDmOXbx5W3OlIb/R3/d6mpAuiYYVyu0yFRJuo0L8I6nr/TiZJJtqyn9I4S5eyJLme7/yG1qhMxGIK+0Xyu6FpcEgOMriX980luuBkZW4i2Gp0JVqDhuAwA5mRnBREH/lVJbQpb0eYhDL+64VxcfDHw9eyUgfFb86kS6b4XJOQ2wQMl+7z08faZEE9+/xGF+w+AYPgJtwT76+PPB/MaE+2kFZa1yPLyWKNwGV9sAUpRviJBDvAafra6/xU78vtVXB66x4DYMuS59YdQH3dBH6dXE/qN2+xAWdXH4YGWgC1JMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hGGz9r9ejdwu3wfFR1UpnMn9OhQzzoosFvasPtN2MAM=;
 b=dLHR9ZQ8DM2RsPkthzGlRHtM562fz7Yb1sG5xIFKIz9Slhy0PPDAf7XchFbYsPBA0TJYoCfY/uEPWOmyiTyyWOJhWL3WLse5uu+rq+RjDHq2LuYhgAGGVbcya1GkxsNIcLZVBsXcb5E3whC4cZCQtzIH5GDtCatXv9zTJF6NHIg9767mchEvezW+OdeU513wohZnn3fSsOL9cJuVZVUOvZGSzSCkRm7w+Z4/P1HrvruJiq0OOdZCeaujsVKxNUdegCTmq5qNTMhIAV8e6OTElJ5Aw9b3lMNSLSn2EIWiK/Qa86Jp+d5GqvzzUdj5s/7aAuxN55ojiRGe8ymiSKqURQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hGGz9r9ejdwu3wfFR1UpnMn9OhQzzoosFvasPtN2MAM=;
 b=BfkkQ+IFyj5FFtUdGhBXIQ8ge4nFu3liTKHQX/oV/41fcOTD6+7QOv5k5/0RBD33VtlupMRdhL7sX1FMQICk4cNeVZYA6AfVsdHzsbk9DDeKqdPdr6KuVbvsrSFWXZhOERjG5md2qGnImRqoEyjEub9pwgpy+BIO0iYwE6MztDg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SJ0PR12MB6902.namprd12.prod.outlook.com (2603:10b6:a03:484::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.33; Mon, 11 Mar 2024 11:20:09 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::d709:cb7d:2612:bb27]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::d709:cb7d:2612:bb27%5]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 11:20:09 +0000
Message-ID: <6b01274c-043c-aa1c-1fdf-19df1bf2d6b2@amd.com>
Date: Mon, 11 Mar 2024 16:50:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v6 07/15] iommu/amd: Setup GCR3 table in advance if domain
 is SVA capable
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20240209112930.63663-1-vasant.hegde@amd.com>
 <20240209112930.63663-8-vasant.hegde@amd.com>
 <20240305001117.GB9225@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240305001117.GB9225@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0182.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::6) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SJ0PR12MB6902:EE_
X-MS-Office365-Filtering-Correlation-Id: 04daeac7-7d7c-4502-1b4a-08dc41bd362e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dj2ARi5b/i7L/7CFKi1Xe7ZJTBtoS4VLXnRSdWfoskY0851CzWxUWnVvaVSmJjJFHxfi0oOY+vp35h6t4DvjfpshV9LmU5errjSB6E+OlWg7zI+LDK22R59Je2m414SAlkt4gJk5oqWvHZbC5H1ZmovoxG59oLIpRA8f4Vc6mHGXSqMpNdmR9BHVg23ow3IY0V25YmGWVGeGo6VsaALUoBEoYgu1xTv75bG2hJ1VSa7s/6bVQ/Tgsrwy8oQbnLjFm+L6+sZrEf9RGCaDI3x+PdXpNmyz61oaxQOzpGFDWpFJhTrgF2VxcUi9HzloIBXHtCiGd5/7JmVeYMhquSi0zaiJYYxuH5mOsYUUTlE0x2I067uuK0giNYehX9ve8Fm/tRO4uLOcOcbmYuo0cx4qS7DmrIZF74/0QQuKAJKsEo49MrFoTJ0i+X/FdH6ytMkeZHysi5RQKz7LkdH9FiaI6fKCeqKLYuV6G0osDEWMhD8uziFWqvauDbe9spHlIb7RqjoqET0tamRiqc0FpGthOHX3lLNcuVEnftjLs2rPay5Ln3qB3huiCCdesHKlzOUZ6fdB3IYd7jeSW6WhWoCd4voySHGR0YmbI5H3ZdHjAR8hjWBszBPZYfkrlx5ZIC2vGdXnuUKDfb3uw4MkjTO/m5qv+87lgYd+oRt1VCkuhFA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SkVQdkx1Z0Z3Q3lBN0x4OGc2QWhmWHN5MmNTbk14dGE2ak1vOStCWktrazdH?=
 =?utf-8?B?a2FGTlFxSEl6SXg5Znphbk1xVXNJUm1JOVJ5TDRCUGp2dUVPaERzWG1DaCsw?=
 =?utf-8?B?REh1NjlPN0JQQnEyb1cxY3VwT1BmbWMyZnl3OE9BelpYVFVuVFlielhLWHZw?=
 =?utf-8?B?R1gzWnJUY09UQW5SNHhsdThXT0crUU02ZUdWU3loOTRoSjJiS25hK0lwdkR6?=
 =?utf-8?B?WmNIMndJMGdzMTUvZ2p3ZTMrSG55S3pydzBpNkdFckxvdisyN1B2VldCQ1hB?=
 =?utf-8?B?M0JHVlBtVTlmOWJRMmxKeWdpZHNndGVWSXhndnN4cFZFcnNkODZhNGU5eGVV?=
 =?utf-8?B?dEYzYzBiZDJaZXNDVGN5dGp5aXAweEhkVDBmbytYZStKTU9vSDVBYmFtOUUw?=
 =?utf-8?B?ZFdhSHVKeEpuYjNkaklWWTFyRjZ3KytrNmNZaVF6WUZKeHQxdXZsV3dTZE00?=
 =?utf-8?B?VEFneUFwUk9YNjRNaDA2c2YxRlVxTW9JVjdzNHVUSkRQSDBPNnhJYXZDTWI5?=
 =?utf-8?B?MVVqN3J5T053WHJxdWM0YldLYXlCd0dha1liaGs5RlllWmxnZ05rRVgwM1hj?=
 =?utf-8?B?YUZiNkwwQ21ybWlJMzdKcEUxclUyTThPdFY1MEx3NHdERk4zTlJ5MmdlMHlX?=
 =?utf-8?B?amF3VTBtYTFpTjAxZWl4cTdLMXQ3b2UwQUVhcGxwUjA4ZnhIYkRKTElxL1Vt?=
 =?utf-8?B?L1k0Smd0RU5kN3FRMmRXTUxoazFMa2o4NHBuSm5jUXZPQTdlUkxKR0RldXRv?=
 =?utf-8?B?aWE4NTZtZUdpSnM5ejlqbG1OT093UWRidFZ2cFg1dURRRmF5a1lvaHU5ZXNT?=
 =?utf-8?B?VWxHOTVjKy9HWURHU3NsR0xsNG5FQ01uSjYwWTVTQUJjM3RaZjZXMVhVaGlF?=
 =?utf-8?B?YzVNTW9FSUUwdUFESXhVNW5qTVdkR0tWVkRYei9ZTEwxa0tqS0hyTGVFOUwz?=
 =?utf-8?B?RWNMd1FOWmVkUjNrMFNld2FGNEdjSXdqWWhSUjJUZmxoMGdwRmh5ZUJqc0tj?=
 =?utf-8?B?eFAxdktILzFzSU9lZ1dqZHVyaE1rVXNscXVKaXZVMHhtMFNITXJNd0pLMVpj?=
 =?utf-8?B?eHpPVHVsSmFhaVBqbnd4SmVXazZHWURXWkRzdDloZVdab3orUUZCeG1kc212?=
 =?utf-8?B?ZjN1cGtjMTR4R2c1cUladE4zdHplb1FOdDRLQnQ1UlNLMXJoL3Q1cVBUTXhv?=
 =?utf-8?B?SzZSc0kwUEpnRS9QcTh1ZGF1NkdieWhwNEtUQjlUbDBCdkxldXZ0SU56a2lI?=
 =?utf-8?B?SmFkOFZsTnJJZlVPMGF5aXZlMVI5eGMzNFdJMkNROTEwNmp2S1hOekpvY3dZ?=
 =?utf-8?B?bG1TMnhBaGZ2M2piZHg5NkNBM2ZlRm9yZmhhektqY2hMUjhxZkdaZjlkZE9V?=
 =?utf-8?B?bkVkcDFzalcycnE2Myt0Ylo5SGlTKzZUTXF4Z0srT0RhdEhvbU5YeFRBV2kv?=
 =?utf-8?B?dW9CZEZNWHBmWWQwVm1lSHNabTBxMDllU0VadVp3WjQxRFA5dktIeGhEOU9z?=
 =?utf-8?B?TVYwa3V5YVVFdmpNTkVEZjE4MDZTdlZKZzdSY3NwOWFtaCtQZzNwSE9MWGNL?=
 =?utf-8?B?SlhiOHBoQ0taRUlaYkU2b0JPME11MEdRQkdzSGlWUVQ1RXN2UHp2THIyblM3?=
 =?utf-8?B?aGEvYWNoYmVGTkxrM2ZMcHp1Q05PU2wxV2FqcWpseVpmRW1TL1hjdHpYVmtT?=
 =?utf-8?B?Wk05emR2c29MSjRWS05OcVp4YnE0d0VxNmp1RFNCYTkvc1FlUWxpY1RFcEdU?=
 =?utf-8?B?R2xES28zUWtSQjFlbTVHajJUTGdSWjNYWkFvc0JXSk9VUXpNbU5IQzV4NW0z?=
 =?utf-8?B?QlVsMjRNNExKbVl1bU5Hd3lTNk5WOGRTVXJsbEs0RlI4Y0tsVm5tMURxZmcx?=
 =?utf-8?B?QVZ2a29pZFFUVlN0RWp2T0E3OFJ3WUZSY1hsdUxlbHdaMnRwSUQ4RlYvL3Nw?=
 =?utf-8?B?NjhUMzFYV0lxZlhrbUg1U2E0WjJ1ZDM4Q1haS1JPT2UxemNqVkJSaEhPRmV0?=
 =?utf-8?B?UDBnejV3TXlBTFVxRXBxU09qNm5QaGNMZDFtZVFxMTRvRFBFUVJzMW1QYjNP?=
 =?utf-8?B?eEJZQ1RsTzcrZkxMSnNEMTRHRjJPQWpRdkxTeDRGNlBIS2hDUW1JbGt6blNx?=
 =?utf-8?Q?8qHg/DI2sgnZR38xLcHxVaRIA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04daeac7-7d7c-4502-1b4a-08dc41bd362e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 11:20:09.6855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SRsvodrq4rpOZdxJ7/AXWUrq2K+RoI+xM+zf2PP86BCVPozLZQh3A6w6BEdyysviTpJWmeU8/7noFVBuPZbgxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6902



On 3/5/2024 5:41 AM, Jason Gunthorpe wrote:
> On Fri, Feb 09, 2024 at 11:29:22AM +0000, Vasant Hegde wrote:
>> SVA can be supported if domain is in passthrough mode or paging domain
>> with v2 page table. Current code sets up GCR3 table for domain with v2
>> page table only. Setup GCR3 table for all SVA capable domains.
>>
>>   - Move GCR3 init/destroy to separate function.
>>
>>   - Change default GCR3 table to use MAX supported PASIDs. Ideally it
>>     should use 1 level PASID table as its using PASID zero only. But we
>>     don't have support to extend PASID table yet. We will fix this later.
>>
>>   - When domain is configured with passthrough mode, allocate default GCR3
>>     table only if device is SVA capable.
>>
>> Note that in attach_device() path it will not know whether device will use
>> SVA or not. If device is attached to passthrough domain and if it doesn't
>> use SVA then GCR3 table will never be used. We will endup wasting memory
>> allocated for GCR3 table. This is done to avoid DTE update when
>> attaching PASID to device.
> 
> It is certainly not elegant, but I can appreciate why you don't want
> to tackle the DTE update right now.
> 
>> +/*
>> + * If domain is SVA capable then initialize GCR3 table. Also if domain is
>> + * in v2 page table mode then update GCR3[0].
>> + */
>> +static int init_gcr3_table(struct iommu_dev_data *dev_data,
>> +			   struct protection_domain *pdom)
>> +{
>> +	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
>> +	int max_pasids = dev_data->max_pasids;
>> +	int ret = 0;
>> +
>> +	 /*
>> +	  * If domain is in pt mode then setup GCR3 table only if device
>> +	  * is PASID capable
>> +	  */
>> +	if (pdom_is_in_pt_mode(pdom) && !pdev_pasid_supported(dev_data))
>> +		return ret;
> 
> This logic seems like it would be clearer as:
> 
> if (WARN_ON(gcr3_info->gcr3_tbl))
>    return -EINVAL;
> if (pdom->domain.type == IOMMU_DOMAIN_IDENTITIY)
>     max_pasids = dev_data->max_pasids;
> else if (pdom_is_v2_pgtbl_mode(pdom))
>     max_pasids = min(1, dev_data->pasids);
> else
>     max_pasids = 0;
> 
> if (!max_pasids)
>     return 0;
> 
> ret = setup_gcr3_table(&dev_data->gcr3_info, iommu, max_pasids)
> if (ret)
>    return ret;
> return 0;

Will look into it later.

> 
>> +static void destroy_gcr3_table(struct iommu_dev_data *dev_data,
>> +			       struct protection_domain *pdom)
>> +{
>> +	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
>> +
>> +	if (pdom_is_v2_pgtbl_mode(pdom))
>> +		update_gcr3(dev_data, 0, 0, false);
> 
> This doesn't make alot of sense, we are about to free this table
> memory, why zero it and flush? If the DTE still points here we are in
> trouble!

This is for GCR3[0].. But yeah. detach path we can just ignore this and free
gcr3 table. Will fix it later.

> 
> Similar comment for storing the gcr3 in init_gcr3_table(), that should
> just stay in the caller..
> 
>> @@ -2010,10 +2068,8 @@ static void do_detach(struct iommu_dev_data *dev_data)
>>  	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
>>  
>>  	/* Clear GCR3 table */
>> -	if (domain->pd_mode == PD_MODE_V2) {
>> -		update_gcr3(dev_data, 0, 0, false);
>> -		free_gcr3_table(&dev_data->gcr3_info);
>> -	}
>> +	if (pdom_is_sva_capable(domain))
>> +		destroy_gcr3_table(dev_data, domain);
> 
> if (dev_data->gcr3_info)
> 	destroy_gcr3_table(dev_data, domain);

Makes sense. I will post separate patch later.

> 
> ?
> 
> Don't really care how we got here..
> 
> Anyhow, this looks like the right thing in the big picture, nit picks
> aside, so:
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thanks
-Vasant
