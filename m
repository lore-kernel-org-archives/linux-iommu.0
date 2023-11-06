Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2056.outbound.protection.outlook.com [40.107.101.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C138156F4
	for <iommu@lists.linux.dev>; Mon,  6 Nov 2023 11:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MxTPosEb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQmcPDDNLcjYuQgFjYzEN0t1JCVuSFFrh7NyrRKuoppH87lWvCGKmSjLOE6AFy9wj2iMAnqDmm3mGBxeQVoHqOPpMtNW+CTEsm3T+1IabfL3ZdZNbAncEMWz/+6dn5f3RTdNQzX3L7oDVCdATEHV8dYiCXZtvEiGI/T7NIRvmab+wcDf4Fezr3s6AgZ+D88is/dN2jsellXfFzznNkOtr5/s7HHe0oFLcoS7E+9aStbwXXV7hyDCUJOY/5d15tX1wGzBxoOdt9swocLd50iQkoKIaJ3Aqz2JiNqrt4B315xRGXv/+50Yxr159hY4wHOQDMVBnk/gXw9LQfzi6WqgrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7giHz2RqGOEyGduqZ4AyMxejs78TqueE/bj0QTjamFA=;
 b=lJHk1cDdkllx6JF0fJqYCzG3X977IcRHkB8NIjl9e/POAFzBzSOoib12ZqJNi3QYVLaohnB2ZUd6uVyd4xxLrUdAiymlBPuF20WHh+dxCjzC1HB3YJIvqfTT8aEptYmaTFYe2o44jGs2Dab8Dyig16sDqcVqBOC3tVmT32sWUPSojXbbKkb0WSah6KRO31ToVQQj/pFHIoMl5zMOuc3zKGz+x4aDwgM6HPt2NA5AG7m9yzaTV+IU+rsXpeMZHtzxwAjm0kDM2HiVVdjtlmCQqNxrxgxlrSo80d2H4Rmpe8kzth2Njhe5YiFEOhbRpwgrPBq7Hf4+j0v2l+ySTi+fxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7giHz2RqGOEyGduqZ4AyMxejs78TqueE/bj0QTjamFA=;
 b=MxTPosEbECrj1RgldE5mUty58aBUcjT8yg6AfQQs12KTnw/XlykEIDfS55MYc7Sr60gpO3LtO17zxxPtVKRYIzRR9fBnybnQs4002pgUWyatDD6ocKqH5BbAqqSjXNjIfhP8VsOmzi3T8d8vks11LIzVGm5TXklmToehbOkwoKo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 BL1PR12MB5207.namprd12.prod.outlook.com (2603:10b6:208:318::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 11:16:23 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::befc:daea:28e6:32af]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::befc:daea:28e6:32af%3]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 11:16:23 +0000
Message-ID: <abee1951-9014-4b81-7bd6-0a296b13d26c@amd.com>
Date: Mon, 6 Nov 2023 16:46:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v1 11/13] iommu/amd/pgtbl_v2: Invalidate updated page
 ranges only
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com
References: <20231006101624.5912-1-vasant.hegde@amd.com>
 <20231006101624.5912-12-vasant.hegde@amd.com>
 <20231105175723.GK223197@nvidia.com>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20231105175723.GK223197@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0181.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::7) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|BL1PR12MB5207:EE_
X-MS-Office365-Filtering-Correlation-Id: 33be30c3-f050-4b64-82b6-08dbdeb9cf0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	V9cPF8tcEMZ3v9JfMHeMl+2IqymMHLXZkEyju54v15pEmD5oEIK1XJgGpM/ELL57spDpHjrdA3Lvv+BZhR5QVMwO/94SG1cUE/tIh5Hza8BdseQFgt3kp2V7QgvSTvLPom/JIAO2OadhVT2rBML6enJSQZ8qo3toqqokxugWljjwzvrBdP4MxNJ0JAWclyBfZdGXC2Wl8eVd46+qehCPlL7LMqEgcWezlH2d4cym+O9bwJ3dkYlojwJXa3KnNYPpV7Yyr/GuOJEV87KOMhUK0gDqylFJU6r8F2EPArVnpFEIQ1PuMRCkDywnmWTnEid6h6lGqTKzG9T4InJt6qfZrZrnub8DXSl5CXdhYBC6SafnfJdwlMfuykMYSWulVmTl5W+k8h+zVvL9Z1rgxZ0aa3BIUeL+ll1uewZ1pF+9npoOIl+vaPn6h6z2knYH6UcQDPAx+vmuvP63kqvc6Kvu3FXuCecE9jk4vN6Wlw86ztwNovJS5vPHfKlraxaOM0iaBOmLXlbHjNWi7xuUg8fZE5tNpQpcF6H9kzDJxVhSZIIQiolbwdiCA7ZZLXr+KyEfxLbkArg1zRXurxyk3WJa58qFO3koZcsPETLNdWKhTSGqsLB9XSyuVG0B4OkPmbv5gDD/0BYHQz4Xajexkb/loA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(38100700002)(6666004)(6506007)(53546011)(83380400001)(31686004)(6512007)(2616005)(86362001)(41300700001)(2906002)(15650500001)(44832011)(8676002)(36756003)(4326008)(8936002)(31696002)(5660300002)(66556008)(6916009)(66476007)(316002)(66946007)(26005)(478600001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHFyUlZVMmRtVXFXT1R3ZG1CKzNXOVVUSmEzcGhsMFFtKzhIdDVzSTl4NnBu?=
 =?utf-8?B?OG5RT0pFT0VjaXlYNm1zNWlxMEhoQWFscllZbC9OMXF6enRIRnl4cVZremky?=
 =?utf-8?B?UVFRc2I1YlJTcjZsb0lObFByYWdtUm9WNVgzTjlQc3dJYWJWYUpQZDRrdjVx?=
 =?utf-8?B?L21hVG9HRlgrUy9VMjFDb1BOaDhwL200Q2lXRVBuYy9zT1V0QWllTVVjZzJD?=
 =?utf-8?B?NEtSd2h0bUUyNWZtQ0xydVVyMm5VSUVocnlOdFNocEJ0MWc0UGhRUVRHREo3?=
 =?utf-8?B?VHhBSXl1V0FwaXppUHhOM0NPLzFIUit2RVhBOVJrT0U0YkZDWW8xWnR4WXNC?=
 =?utf-8?B?Q010TE43Slc4bUJZY0NkbFBYOFVjWjVzV3dKWk1wZlYrY1krQllzdFROMDFs?=
 =?utf-8?B?UERVRHUzK1ozR2RGblFPTHM2Mjdic1NRWEJVTDllVXV4cGlLR2dyQVA1S29D?=
 =?utf-8?B?dEFzMDBFNDl2Q2lhQkVZaG15M1NyUDh6UlpNcDlBRXh5eUVjRmM3TVJOLzYy?=
 =?utf-8?B?UjV3S0Y2STJUQVo1aW5NVjIxYWpjb2tWbW1kZWVGcTFzdE9hZitWRENNMW1F?=
 =?utf-8?B?Uk05YW5IL1dVVG1TM0dzYlM3ZVdQR1ZpbU1FY0g2NE8vVUJHUnVVVmQrWW9I?=
 =?utf-8?B?WitERU4zWlhwekpaTi9lSmpTQm5Yd3hJdW9VN3prd29SdDdZNm03STk0Y0oz?=
 =?utf-8?B?R0hFY1ZxTnRpZ3FUKzE4MzRNUk1uR3cwdjU3YlVnKyt4Y1lFelFvMjltMzQ3?=
 =?utf-8?B?c3FuQnNYSzFnQzlkVlhPUDVobkJWeFQwZlNyNU12Q1NyTTRRakkrNC9UbFdu?=
 =?utf-8?B?a0haZkVZNWxzZktwMVFCZUgza3lEOGhHQkg0S3BtRmtsU3liK0NwcnQ2dE5P?=
 =?utf-8?B?Z3lFbEpTL2xiZFM1eXd6Z1ZidWtDWlVYYlZ0aUpkOExubEFMU29yVDdrWGY1?=
 =?utf-8?B?NkVod2ZmQ2tBRWQ1RVVQZWNiWHBDd0o1cWtTeThNQXh5RFBHTm9zZW5IMXd6?=
 =?utf-8?B?ZXQvSGpGeHNpa0phRHhKRWZLTUtoYW1tQU1YdURtbFRkRVVTRDc1NzhUZnht?=
 =?utf-8?B?MDJXZmhoZjU4YXpUemZQamF6cmJpL2thRnNVc3FSYzRGNUk2REozcTNic1Ur?=
 =?utf-8?B?SHFCT1kzVVE4M01YN3g5QmlkL1F4STJEVEhGSDNsYlhQUUtia0RTWS84Mm9m?=
 =?utf-8?B?NmorQ29pWUt5WVlCeDdlMmIvSGVMV2tZOWMvZHRTODg0UkVCbHd2aWUxUTV4?=
 =?utf-8?B?ZWpNZ1FKZDJkb3RxOVBYKzVENFhtNjZHdnBjZ1lzTElHS1BDOFVpcFhyTk9s?=
 =?utf-8?B?N3VPTjZRNmFRQThMVlM3cUgrT01NckhSRGg5UmRaSjA0ck4yMjc3N2lDRVND?=
 =?utf-8?B?TXVtM2FWaXBCaGpDY1gvVGcwTGFpd01ReVpIQ3JCQVlaMmhUSHFIK3R2cE5G?=
 =?utf-8?B?anFIeS8wUmwwZC9IVm1iYXBVMVpmd1JzcmdoUnRVeGRleVVONkQwa2NVbWxy?=
 =?utf-8?B?Z1NmcGpYNjZmS3JnUnhtdHRWZEVIQ1lTWjVLekxGQ3ppMHJNYkF1YnhWbCtM?=
 =?utf-8?B?RkUzdVl3TDJMalJObWs0VllrM05MSjdET2JNOUhtcGEwMG1pa0pvZS9YOVF1?=
 =?utf-8?B?azVsQW1BcUtwdldqaHZ2MTlTY3FNdFZVaWZaZnJJSzAwWjZpVnBqd1ZHd1gw?=
 =?utf-8?B?cWllSHFwV3NoMG45cEk2ZmZ0TDBmV1JxUDBtUXZySzBQRVFFUUp4dnlabmRa?=
 =?utf-8?B?aGZQbnNSclp4STI4M1U0UjMrWGRZS0FyanNhZVJXL3ZNR3FoaVVxcitEbWVz?=
 =?utf-8?B?NUU4cWpVVkM4Yklrb3RJNFBudnh3eVNDL1ZpSDZDQnVIV294NkhiR2RsUFQw?=
 =?utf-8?B?azJxUWN0L0VRZ0VwQW8waUp4WlRhSUlERnRLME5DMUtqUlF3OGdYWWY5MDBL?=
 =?utf-8?B?Smw3aDYyUHkxMGpVaDRNWXZOaHFZdnNudEJFMnBNL1R0L3BLMDBqR2p3Rm9H?=
 =?utf-8?B?Ri9jUzR3RVJhSzFGbFpIcDlqMFdzMGs4dW1QZHE1Z2QyU1Y3VS9ORDVvdjE5?=
 =?utf-8?B?WUZlYVVKQWovYVNtSWMvMUhkb29YWWRCdmttNnZpNXBSa00xZlVUcjdvQ3FI?=
 =?utf-8?Q?WJZOmdnztDQS4yDNhJnN9TfnE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33be30c3-f050-4b64-82b6-08dbdeb9cf0e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 11:16:23.0407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IxW6PsIqqxJqCN58NPKwBXwskbBGv2ihxTvNwm0NuFllgMBCXdMoY+YHBwrcmLShZJfUbG0TykItawYWfyFRdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5207



On 11/5/2023 11:27 PM, Jason Gunthorpe wrote:
> On Fri, Oct 06, 2023 at 10:16:22AM +0000, Vasant Hegde wrote:
>> amd_iommu_domain_flush_pages() uses protection domain page table mode
>> to detect/get default PASID. Hence we can use this function to
>> invalidate v2 page table as well.
>>
>> Also in __set_gcr3()/__clear_gcr3() path call domain_flush_pages()
>> directly. So that we can remove __amd_iommu_flush_tlb() and related
>> functions. This works fine as we have GCR3 table per domain.
>>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>>  drivers/iommu/amd/io_pgtable_v2.c | 10 ++--------
>>  drivers/iommu/amd/iommu.c         |  6 ++++--
>>  2 files changed, 6 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/iommu/amd/io_pgtable_v2.c b/drivers/iommu/amd/io_pgtable_v2.c
>> index f818a7e254d4..6d69ba60744f 100644
>> --- a/drivers/iommu/amd/io_pgtable_v2.c
>> +++ b/drivers/iommu/amd/io_pgtable_v2.c
>> @@ -244,7 +244,6 @@ static int iommu_v2_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
>>  	unsigned long mapped_size = 0;
>>  	unsigned long o_iova = iova;
>>  	size_t size = pgcount << __ffs(pgsize);
>> -	int count = 0;
>>  	int ret = 0;
>>  	bool updated = false;
>>  
>> @@ -265,19 +264,14 @@ static int iommu_v2_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
>>  
>>  		*pte = set_pte_attr(paddr, map_size, prot);
>>  
>> -		count++;
>>  		iova += map_size;
>>  		paddr += map_size;
>>  		mapped_size += map_size;
>>  	}
>>  
>>  out:
>> -	if (updated) {
>> -		if (count > 1)
>> -			amd_iommu_flush_tlb(&pdom->domain, 0);
>> -		else
>> -			amd_iommu_flush_page(&pdom->domain, 0, o_iova);
>> -	}
>> +	if (updated)
>> +		amd_iommu_domain_flush_pages(pdom, o_iova, size);
>>  
>>  	if (mapped)
>>  		*mapped += mapped_size;
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index 8da445e51251..764a5656b56b 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -2698,7 +2698,8 @@ static int __set_gcr3(struct protection_domain *domain, u32 pasid,
>>  
>>  	*pte = (cr3 & PAGE_MASK) | GCR3_VALID;
>>  
>> -	return __amd_iommu_flush_tlb(domain, pasid);
>> +	domain_flush_pages(domain, pasid, 0, CMD_INV_IOMMU_ALL_PAGES_ADDRESS);
>> +	return 0;
>>  }
>>  
>>  static int __clear_gcr3(struct protection_domain *domain, u32 pasid)
>> @@ -2714,7 +2715,8 @@ static int __clear_gcr3(struct protection_domain *domain, u32 pasid)
>>  
>>  	*pte = 0;
>>  
>> -	return __amd_iommu_flush_tlb(domain, pasid);
>> +	domain_flush_pages(domain, pasid, 0, CMD_INV_IOMMU_ALL_PAGES_ADDRESS);
>> +	return 0;
>>  }
> 
> You should make the other "flush all" wrapper accept a PASID and call
> it here as well instead of open coding it, or do away with the flush
> all wraper completely.

I'd say this is just a temporary fix to make sure we don't break things... as
next series (SVA Part3) completely changed these functions.

-Vasant
