Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D076FA9
	for <iommu@lists.linux.dev>; Tue,  6 Feb 2024 17:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707238843; cv=fail; b=Q/XtwQuWDHqmvIYS9D86W1kejugCE6fhdIuDcggopNTdoZ6PkdRDLGjKa+WBLOgng6yRA1vuoR340V5xdrpgz9t3NzKzxkTvJiii+qEx4ZbOyBC4GJjuwSVUfExsHg0Qtts7w+LXPdtU1DI2DNUXWoTYewy+C+ZGZOsfBpOQeBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707238843; c=relaxed/simple;
	bh=PEAIiQkAdOfXCURIoCLsxr21++ig94DMS7zpYgyfvrc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pGETr/nEKvleEN6L2+9C/YFTBrweIwFx8w/0Z9rToUz974zm8QUIaN9XvGybY7x83d+zfJzf7xABwEgyUK2pTIsjj4piv7FenqklYIdZ+dXVOnaJy9Yvtcu1/ihP0F2E4/lx5l4qwXFtdBjM2M9L3hj2Dx7VKAxcwp1fGwqLkR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3fNC8uY2; arc=fail smtp.client-ip=40.107.93.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3fNC8uY2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DIQHeEXZRuYE/xoux0LJKhMOMHkHqcbfz2jbJOH9l8O/kWuOWYnAGTCf9Q/AT6lmCPRqiCiYAbT0Wfk7/ZK6xIhVnf3qEQXS60L9VruCGmM6hwb5UlsJfAcQ5k3zma3AnFSBCMakX0AX3opGRaVxW85dFiVQlOGo5PGwt+7ss05hePY2/qqsd3Vs/eVoGcnL+3Ikz+MITZy7KJ+xteRoq1N1XGnU3HTA9E8IUUYM7OpEMbHWeN0UYNTMPHp2HmLrQWbaoVRIkHw5fYqWt1gjjt47rxUHGyOXE1etLUfC7B/BvdYR5SXpdYSdH+bzs8z6oQRGDw3UCrde1S966u+1pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=io7bXLeE2eToYXBnuCjXWJ9efYm6RCsm4+uBch4JI8M=;
 b=lVOSkIJuz8XsOo+UFDapW8ZE88wnIGfPil7xWWJzsA1VFoySQaiQlei/7fP6LZar4YsQJJQuGrT1ayCo71Kn+5AYgubV0K3SP+MB9Dnn2u9qYNixqoalwUa4xg8hgFywHhutSNkZmTWoeridb0C9zP/SVG5APjOhE/rOf2VtIm1tVuZ3+Z03aBy3qlNt2TQmx+mO8b5lwC/uqcg+W+5AzArqlUQLtD+GsO4i4WlWUd4yAvLUjAOLQHopjqs8T2GEBOfJbXyWQ8AETNYlf9B1Oh9IVjxn17Z/DO9adqVIWgO/MjCRGoZ2mtjAoIZ6u5dzqMCeMDH/LdfAdKmzX1ybNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=io7bXLeE2eToYXBnuCjXWJ9efYm6RCsm4+uBch4JI8M=;
 b=3fNC8uY2+c/4dInGYHLOKgo+rQNwOMX69hX+ozDNaqFYg5qkgfbdj7bgROe2VJc68K1DC6N3Pm5URN8hc6nrjub97mw6bBjfxT9GLJegmuElat/3KYgeWKRoghNGj8e636pgC0AcQyGk3kloOwydejSe806/8BDD6fRklMqel/k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DM4PR12MB5087.namprd12.prod.outlook.com (2603:10b6:5:38a::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7270.16; Tue, 6 Feb 2024 17:00:39 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb%2]) with mapi id 15.20.7270.012; Tue, 6 Feb 2024
 17:00:39 +0000
Message-ID: <b67e0505-ec89-a849-a3cf-14fc1b3e5804@amd.com>
Date: Tue, 6 Feb 2024 22:30:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v5 11/14] iommu/amd: Add GCR3 [un]initialization function
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20240118073339.6978-1-vasant.hegde@amd.com>
 <20240118073339.6978-12-vasant.hegde@amd.com>
 <20240202151738.GU50608@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240202151738.GU50608@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0040.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::9) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DM4PR12MB5087:EE_
X-MS-Office365-Filtering-Correlation-Id: 33fe07bb-6f60-45cd-ae2f-08dc2735254c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cHxjHR51mtHF0t8zRnFnZ6l1nc+h49plJGby43DHSUpCcy0HkoPBJaPSY25r9ypbVhux41bpEgGPuwNVuqt0ye2n4ZaQFXROdZJRK0sBzF7l5i155SZ2Y8O5emRoJtDcCCMFaUkGElIq7p/byItt2TfXmq+d1gn3W2mlHJhFZDjOCX16qs+rVF5Qy4nxSg89mtbZidqnF/7aQC83p9uBvag9vYZD5mTaCoaibdnScFQH4jv5Z/LNGtsgEEIHBj2MM+LQJuQuRp4HqOW5Tyor/N8EgukxDMqFTqAhR6I3GBN9yhDMU19W8eWTDAZ7faxksMC2KDspkmTnbdKKD8AXnA/A2tikSod9qj4fPIcCK8j7JkU9u8RWKbsfIKbIqRnzTTGY6PCloh0fz68HHv/eMNpvbBahHvPxcTnt2PQZX8i0/KMcXvjNr+hBDzcAKP8lrnlUxixiseRDvSiF5cklTtZuH24E2c1AQa8gtqBKz3gNFe14S/TE4gZLNBANGJHsu26TE5bMtnAlNavg2LJcbtt9WTPZ76fPc1cKDWDQxgrYqQTlOO4X5eDg1vGEBT3TjaBWrfhrByanavdlWnpYtzZHeZauUEcC1mrMzIu5mVL/YD5Z4nMEblY0njsZvuvfY/uJbxSELaumeeT1vltbUw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(346002)(376002)(396003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(44832011)(5660300002)(2906002)(31686004)(26005)(31696002)(66899024)(83380400001)(38100700002)(86362001)(2616005)(53546011)(6506007)(6512007)(6666004)(66476007)(66946007)(66556008)(478600001)(41300700001)(8936002)(6916009)(6486002)(36756003)(4326008)(8676002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ylh3OEhoKzFjRTIwUEtYWngvTWpGYW5rTDhxYno5OGY4UUtmK2FkUzl0ZDVF?=
 =?utf-8?B?bm5JRnNmZGZxbFdTVW00bUg5Y2pZZHl6TlFRdUF2VVAzYk5xTllxSUt4UlVt?=
 =?utf-8?B?ZkR3OHNUVzRJYWRFeHhmUWFYT3lLTU5LYnRoSXZyekgxL3Q5UXNYeklnVEdh?=
 =?utf-8?B?Y1JxSDRnZXZvWTNDeGg1RXdkMTRXOWRMQkxxMS82YzRjVWljeDRWcjYyVk5U?=
 =?utf-8?B?VnZyQ1gzM1gxZHM3RUZWVXprTk1WSTlEdUpoYUYvcVh2U1ZqL2pxN0Nwc01X?=
 =?utf-8?B?M003UnVING9ZR0hwdUlsS1AyVS81VEtZaGFOT3ZwSlVrcHRtbC96NnZWN1Mx?=
 =?utf-8?B?dzY2bk9qVG83em5zTVRmcy9KR3ZTVFlhZXBHMUJrQmdHUU5UUC80am5mN0dj?=
 =?utf-8?B?cysxeDNQejRjaHJZVnc4Ry9rL2wyMWRaZzJITUx6eXc5c0M0WjIyUEsvUnow?=
 =?utf-8?B?djdBbnNoQXRTcFdSdkpXdnd6ZTdiNVkyaGlrdlFheEhLV212ZHp4Tm91UVh6?=
 =?utf-8?B?ek1GRlpwMWhTbHJQYThCSUx5ZjhTRno2SjZhY1NjNWtTdlIxM0ZkbkVBaFFG?=
 =?utf-8?B?dHZoM0FUQ2p2SC8xYjYzSmRxYjVEeG8wMkxkYlhOTDVzNDhETGxaMjI0VUtD?=
 =?utf-8?B?Z2hRU2lqYzZhdWlYamZQdGp2dENLWWYwTG5WRVdMVGNlS1JoM3ZoQmMzMzBW?=
 =?utf-8?B?SllMNVRwb3NOL2V5bTU1NVp1OHI0Yzhidi9NcVBxRndkMGpJbjdlVTNxZGFl?=
 =?utf-8?B?Uy9ZQWdoNmdJd3MydzFjc282UEJEYWNIckNwN0cxY3Zzb0xvaWJCWG50Q2JQ?=
 =?utf-8?B?REFyM0lLclFmeGNNQXAxSkN4UHB1UDhRUGJVbkRMYnNlZ1hoVTFTQ1JEZFlt?=
 =?utf-8?B?WnlzTEtCMDZJWWw5R2tBbFNTVEdtdzNocHY5WVVSSnBTSHkxd3dYQmNCVGJa?=
 =?utf-8?B?MmJYUXV6cmZOWUhOS1FYTFZSbzl5NUJyZ3VnRSsxbnFmVDR2SC9MSWx4UDJj?=
 =?utf-8?B?eFo1UWtGRElidGNvT1UxSTNNaEVjTkdEZ3V5bjZHQVROdEk3eDN5ZE5BZ3Vl?=
 =?utf-8?B?NzBSOHVaOWE4eG9pYi9Ud2E1RkhwaE9CU0MrM01idUxKV3JCeTNjT09SQVF1?=
 =?utf-8?B?MjQ0MU5vUEZvNlpoOTdwVHc2MXVSb1hXQy9FVU9YMzB3VjJEb0FnK0xWZzhW?=
 =?utf-8?B?YmMvWTloY2RJcUNPWTlMUHlZYk5pV0VJVTJjd3FSU3NRVWgrWU5wZGh6TUk3?=
 =?utf-8?B?SXh6dHhBa1h5amx2cEIvd0I3VFhaQndaejlESC91SnJvaWFZSjBPRnhQSDlj?=
 =?utf-8?B?S005ZS9Tb3F4cVJuNkZXYitTKytNeDU2ZUhTZFRWbHdZc2NZWHZwZWhYblFh?=
 =?utf-8?B?RDViTDVqcTZaMUVod01lZENDQWtWdDF3WDg3cHlQMXdRcWtJQUpmSkN2VnZk?=
 =?utf-8?B?aEJlcmRXcWNhV1h2aXJJMmg2YzJsUW4xcGJFZld1TmNtZGhmQ2tTVUVhdU1Y?=
 =?utf-8?B?ZjE0aEVyRk9wK1Y2eTFna1VGcEd6SlNQOXhETVRGaWw2UUJEazdYbzVLUTJK?=
 =?utf-8?B?NnFxMXBEcEFMcDJ0WVpCY3ZUcmtjeW45UWxYN1grRk9XWU9aTnNrcTBET09J?=
 =?utf-8?B?Uk84UkwyS0ZBM3VGRUlEWDJraWlsOCs0S2lHNmk5MkJmSEY2Y05YYTVRenBi?=
 =?utf-8?B?ZmVrZ29rck5LQ2ZWQ0xhMjBoNFMreEVjODlmdENyWUtFTUhKd1pyUU16SWZL?=
 =?utf-8?B?SWlLdkJMSTJpaGE0bGxMMGJLR0lRS0pPR3EvQ2V5R3lvM2lJTTFLRXZHc3pS?=
 =?utf-8?B?SFNJOFhEaFk2K3JidUtVNzk5V2lzWGhIdVJ5eUdwS0ppTlZ4aXAzSFhvNkxz?=
 =?utf-8?B?UjhucENhdnpZRVkvUzFVbkc3eVlqSEkzSnJ1VHQxMFB6M0ZGM2l2Z2dBdDht?=
 =?utf-8?B?ekcrMTVDYXhNZUhqNjBkRzZCWWFacUM2ZHpkcTNUL0tKTVVKbEl2ZGRMMWI5?=
 =?utf-8?B?Tzd2SHR1NUFpOExXLzRoaExESTQ4SllBeE9DdG9DN3oremVyeEJuQWovUG1j?=
 =?utf-8?B?bThwMGNoc0Jza2p0OXkzMWtsUlIyU1BiQWY2NGFFbnhnUHk4Z1BlTXZYa2x6?=
 =?utf-8?Q?T4xSoON2TYVCmPpFBKFdcNtmG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33fe07bb-6f60-45cd-ae2f-08dc2735254c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 17:00:39.5798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9rBo5k/KnFije3ehrLSprsHU+QzQqDv+OcMCSdv7x6L+kYPh1BU35XSvJww+32Y5dJsKFZQruXiP4zlqy9v2tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5087

Jason,


On 2/2/2024 8:47 PM, Jason Gunthorpe wrote:
> On Thu, Jan 18, 2024 at 07:33:36AM +0000, Vasant Hegde wrote:
>> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>>
>> These functions are used in PASID to device bind path. In this path
>> it checks whether device GCR3 table is setup or not. If not it will
>> setup GCR3 table.
>>
>> Also in attach device path change default GCR3 table to use MAX
>> supported PASIDs. Ideally it should use 1 level PASID table as its
>> using PASID zero only. But we don't have support to extend PASID table
>> yet. We will fix this later.
>>
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>>  drivers/iommu/amd/amd_iommu.h |  3 ++
>>  drivers/iommu/amd/iommu.c     | 52 +++++++++++++++++++++++++++++++++--
>>  2 files changed, 53 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
>> index d5e6315ef9dd..2d099c54b941 100644
>> --- a/drivers/iommu/amd/amd_iommu.h
>> +++ b/drivers/iommu/amd/amd_iommu.h
>> @@ -44,7 +44,10 @@ extern int amd_iommu_guest_ir;
>>  extern enum io_pgtable_fmt amd_iommu_pgtable;
>>  extern int amd_iommu_gpt_level;
>>  
>> +/* SVA/PASID */
>>  bool amd_iommu_pasid_supported(void);
>> +int amd_iommu_gcr3_init(struct iommu_dev_data *dev_data, ioasid_t pasids);
>> +void amd_iommu_gcr3_uninit(struct iommu_dev_data *dev_data);
>>  
>>  /* IOPF */
>>  int amd_iommu_iopf_init(struct amd_iommu *iommu);
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index 36a5458a7946..6f5900333946 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -93,6 +93,11 @@ static inline bool pdom_is_v2_pgtbl_mode(struct protection_domain *pdom)
>>  	return (pdom && (pdom->pd_mode == PD_MODE_V2));
>>  }
>>  
>> +static inline bool pdom_is_in_pt_mode(struct protection_domain *pdom)
>> +{
>> +	return (pdom->domain.type == IOMMU_DOMAIN_IDENTITY);
>> +}
> 
> Why? And what about blocking someday?

Today model allocates GCR3 if its in PT mode only. If we support PASID with
BLOCKing domain then I will add that support.

> 
> Just use dev_data->gcr3_info.gcr3_tbl == NULL to indicate if GCR3 is
> loaded or not?

Given number of combination (like v2, v1, pt) above check is not sufficient.

> 
>>  /*
>>   * Allocate per device domain ID when using V2 page table
>>   */
>> @@ -1837,6 +1842,46 @@ int amd_iommu_clear_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid)
>>  	return ret;
>>  }
>>  
>> +int amd_iommu_gcr3_init(struct iommu_dev_data *dev_data, ioasid_t pasids)
>> +{
>> +	struct protection_domain *pdom = dev_data->domain;
>> +	int ret = 0;
>> +
>> +	lockdep_assert_held(&dev_data->lock);
>> +
>> +	/*
>> +	 * We cannot support PASID w/ existing v1 page table in the same domain
>> +	 * since it will be nested. However, existing domain w/ v2 page table
>> +	 * can be used for PASID.
>> +	 */
>> +	if (!pdom_is_v2_pgtbl_mode(pdom) && !pdom_is_in_pt_mode(pdom))
>> +		return -EOPNOTSUPP;
> 
> Put the test directly in the set dev pasid op and it should be more
> like
> 
> if (!dev_data->gcr3_info.gcr3_tbl && dev_data->domain->type & _IOMMU_DOMAIN_PAGING)
>     return -EINVAL;

I don't think that's right place. sev_dev pasid doesn't need to know all domain
combination, setting up gcr3 table, etc.

> 
> 
> And you need the mirroring test in alloc_dev to prevent changing the
> RID to things the driver does not yet support, I didn't notice that?

You mean attach_dev() path?

> 
>> +	/* Allocate GCR3 table */
>> +	if (pdom_is_in_pt_mode(pdom) && dev_data->gcr3_info.gcr3_tbl == NULL) {
>> +		ret = setup_gcr3_table(&dev_data->gcr3_info,
>> +				       dev_to_node(dev_data->dev), pasids);
>> +
>> +		/* Update device table */
>> +		amd_iommu_dev_update_dte(dev_data, true);
>> +	}
> 
> This shouldn't be any different from do_attach()

We have allocated new GCR3 table and DTE needs to be updated.

> 
>> +
>> +	return ret;
> 
> success oritened flow please

Ok.

> 
>> +void amd_iommu_gcr3_uninit(struct iommu_dev_data *dev_data)
>> +{
>> +	lockdep_assert_held(&dev_data->lock);
>> +
>> +	/* Free GCR3 table */
>> +	if (pdom_is_in_pt_mode(dev_data->domain)) {
>> +		free_gcr3_table(&dev_data->gcr3_info);
>> +
>> +		/* Update device table */
>> +		amd_iommu_dev_update_dte(dev_data, true);
>> +	}
>> +}
> 
> Is it really worth freeing it?

Why not? But I don't like the domain ID changes every time. So may be OK to drop
the uninit. Will look into it.


> 
>>  static void set_dte_entry(struct amd_iommu *iommu,
>>  			  struct iommu_dev_data *dev_data)
>>  {
>> @@ -1986,9 +2031,12 @@ static int do_attach(struct iommu_dev_data *dev_data,
>>  
>>  	/* Init GCR3 table and update device table */
>>  	if (domain->pd_mode == PD_MODE_V2) {
>> -		/* By default, setup GCR3 table to support single PASID */
>> +		/*
>> +		 * By default, setup GCR3 table to support MAX PASIDs
>> +		 * supported by the IOMMU HW.
>> +		 */
>>  		ret = setup_gcr3_table(&dev_data->gcr3_info,
>> -				       dev_to_node(dev_data->dev), 1);
>> +				       dev_to_node(dev_data->dev), -1);
> 
> -1 should be dev->iommu->max_pasids, but better would be this specific
> device's max pasid size, cached from pci_max_pasids()

Ok will fix it.

-Vasant
