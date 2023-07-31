Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02D44431
	for <iommu@lists.linux.dev>; Mon, 31 Jul 2023 10:40:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TG1SKMZzZ6U4jn6i+c3Cv15h2VI97Q0mje5WupK21TEcJYah7ifkcrcCuqnGQ5mCNRQKc67naDs0A6l+fdzBU5GxOppEIOKGqNxiqGnJxkgpKlHis5xRKbrPAq4+aUdFImgkWfaPQy649ULyDi+LV5XB3d5X3gLViy2PJkCEPB/38mGxkolAxkJ1Er0yuP23Pvg4HWxmWYEk9gZE2zIJT3HrNUYFO03kq8zYE4+c2J/ir8cJwFIQQteYKcas5IhzaWmRXKH1lAMNF+7/evss4q08sCFtQdxqTSpECUtLuv3QoNr9AToNiJTASHMyQkbOLxz/t04RFSgaeIKP785Znw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WokQuQ8k2P4WCRV7v0EXRFSOuU+a2qObcoid9aCbHE8=;
 b=j9alyaUFJme+fPF58x9jwNb0IQiR+RiaZRhmqNSbIFAMpaZAaX2bBL8qHBIfg9kHeP4KcyL7TB+eQ8xhK4qm2noeTvwawZEjeeYKw1wyvWW1UqlY33W26GGbtbiR3Hq789LphqhXn4emzVbOYISLMqVkFaxk6QomhyJf11eM08a14KREZymeOcLI3383p8zB2HgdQ7TrO8AUxJ886ATxPjivRTLwRMLD2vBXaM8JcmD9SfDo15X2bH1Oc04qEvd3cpJcJvTe0psY5NVuK23cbLxvqXZC/RRYsKPooTjeo2t5M3q+iVc2jw+Wdv9jSUHDrAcJutEPwbJLNJ3AY+Gq+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WokQuQ8k2P4WCRV7v0EXRFSOuU+a2qObcoid9aCbHE8=;
 b=bPZO4n1KTmFiS5DVt74vgYmXmDgQEeniVgPXErCliGTN25p46WCEExESWqKTAjPG6u+VJb3MRLUGLsr4Jp9AD/lLjQXPteDclaBXyZ9ShEs38zX0HmR73xomDPNUH3Y/dwm3HGwWWuK9qHr3e5QzbJVCPN2Lh9TeO0NSi2SNm2o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DS7PR12MB8201.namprd12.prod.outlook.com (2603:10b6:8:ef::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.33; Mon, 31 Jul 2023 10:40:36 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e%7]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 10:40:36 +0000
Message-ID: <4cde2a10-298e-f04c-eea6-c501eeba4775@amd.com>
Date: Mon, 31 Jul 2023 16:10:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 06/16] iommu/amd: Introduce helper functions for
 managing GCR3 table
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20230728053609.165183-1-vasant.hegde@amd.com>
 <20230728053609.165183-7-vasant.hegde@amd.com> <ZMPMLD9NX3JUI0uS@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ZMPMLD9NX3JUI0uS@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0102.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::17) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DS7PR12MB8201:EE_
X-MS-Office365-Filtering-Correlation-Id: da543762-06c8-4760-1bd4-08db91b292c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	otIBKRsO5APV1f7sSkcN49K96DR7LuDeKU8snbRknwfcVk3SAucaXncxszE6FJZXi6HsNpGcQDMj1IjJRcatQ484qoDCe2OxTDYerZiZdQA/Tz1D1bc9y38qnzM9lNfiPEX39EHJ1iEVu0vseyCof4fnll9/e9jeuT77dEIgLN+iGe6mMlmQ976Xf19h4oETtEFgy7Fu1vasOB/tqD61FqvIVgfN2TRBcJNTqcc9NHD/HASRiIDLBRav5I/hZFhzjAJhKI5dFpC5jFiOAWFYE6kXQ/6J1Bn83GURrbQ4ao8BBtxDOOE4zfRDngknHD5oXNUmZrJdJDTwu+zZ2FhLsVyZ27XEPwXOFzdQiRyb23PBrnXgevqEQGT4R4M2i69ZAQd/XcpaLqbxDoHZW8c7H2oEUyS0XhVyf2AZT/utpzliWzilnEFzvKfKU4TY9qjU1AjVgR0xY/wwBL8LiLzKtcDwiH4kXbwyRFWJxBkqRaJ68QVODbiYGFlfmHFrByVpZqINNL0yWU76F7eUWeMAK0BHQHRYejWzojW2BmrlzWr63hQ7g4rhoj2Botd+kncOt4SyclvcabBR6ix8A20Rnnz6W9h7gv9danpjvFgBQK8uAHghx/Js6a1sH/8oKiYcab2Ynl/ti3GFY+ERzu8eFw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(451199021)(31686004)(6512007)(478600001)(6486002)(6666004)(6506007)(83380400001)(36756003)(86362001)(31696002)(44832011)(2906002)(26005)(2616005)(53546011)(186003)(38100700002)(41300700001)(6916009)(4326008)(5660300002)(66946007)(8676002)(66556008)(66476007)(316002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZDR6N01mandSbTJyb3V2K0lFZHZvY0xDazRqMXhCb1hwZXpxOXVwK2U5UWts?=
 =?utf-8?B?UFBRSmZrbE5oOEFwb2dWYnpEWTdodnZxUEhrUzUrck1HS2piZEM3UE5HV0Nz?=
 =?utf-8?B?cTAwY2xoYUFOS2hWL0FZa3hqaU0vak9SMStJczNUS3NIMEFVZG9NZVp1YTZR?=
 =?utf-8?B?MVJ2dWZlWWx5WmFnVTI2bVFZbVZ0SDZselhLay9KVGNDMFVObjN4SHBVMjdh?=
 =?utf-8?B?UDkxOE5CZHFVZkFBc1QyczkxV253NTRUajZrbkM3TWsvK3UrdTMzZW9JM1Ra?=
 =?utf-8?B?bEE2ak44dVUzNVU3cWRxeWxOQ3BwZ256VEZLZko2d3BIZHpTVHQ4T2pmU0Zr?=
 =?utf-8?B?eG9QTW5Cc1RrSHdxcmpCQTJlaE16WnJXRkhwSHF6dHZEbkZ3WDMrZHU0bm90?=
 =?utf-8?B?eGp5Q3dsS3BPSGVEMG4rWGY0cDMwUEVuQlJWTFlJZHEyTTVPOXVKSFppelRx?=
 =?utf-8?B?TlJsYUJSeTJXWUltbUIvMVc2K0xTYnBBMDREK1NWc3ZwbWJzZFUwb1hQdVRD?=
 =?utf-8?B?SkhUOFZVYWJMQUpGRytVYk1aVVY4bXFRTUVqTTZKYjJYUjY1MzRmRVVNOWpL?=
 =?utf-8?B?ZitsaHdzUndndkFMUFJoK3FBSjFWZ1NUbkFjdjRPV3ltZ3Uzd1ZpaVkyZzFu?=
 =?utf-8?B?bCtPbllrakR6VVJzb21DYnpRS3RldXhjWm5aY0pmbTViZFZxZzZPTld0ZUY5?=
 =?utf-8?B?TklybDNXcmtHcS94ZnNQYXZnMTBWTFJlWW9QeEE1dlNEZ1dWOTBYdlVITXow?=
 =?utf-8?B?ODUxa3F1cUZhT0JjQ1RLRlAvWXBTN3kwR2pZM1BGU0ZveDEwbEQ4QkxtV2tF?=
 =?utf-8?B?UEU0NGJyMG1RaW1HeXZxczdPRlEzVWpTK3FCaUZaMWk3QVhrV3RLb2VUOFdv?=
 =?utf-8?B?UU5ZU0VSQVJ4Mi9aanI1MnNwY2pzQmxjRVh0dmZiVDBXbE1SOVFYYU5yUnlp?=
 =?utf-8?B?Vnk4WUd2eGhNYjVYYy9hVVpKU2sxend2QUNaS3NkcXAzL21xMFV6dDlJWWNP?=
 =?utf-8?B?NjRyelhFZGVLYWpxalVqUWljeFE1ZU16OWJ6VnB0cDA4SUhBbE9PS1R0eEdm?=
 =?utf-8?B?RDhXWUdaRis0S3pNaUpqZnpncHF5ZlNNeUFhNEhNU0ltbitreHNCbmJXVmts?=
 =?utf-8?B?R05wTGVFMk54ajZDd1REc1E2MXFGTXpIUWY2N3lTM29rVlI2WFZWdy9FWUMv?=
 =?utf-8?B?MDc5YTNMVlNUeU9udS95RmZKTjlFb1VIVkRYdWI2U1lWc0ZZT1lUQmgzN0FC?=
 =?utf-8?B?aFpTM28yTm0wZ0NXSm16RkV2WnQvTWl5U2dXVVpjUlljREdJRXNVQzVCRlVT?=
 =?utf-8?B?Sk53RFRNckxIVkpIbWlvcVpwNmQ0Zzc2bFRVTHNDMjNSZHhKTVhRTXQrQ243?=
 =?utf-8?B?NGloR1BjTW03ZXVMUit6SzFtOUZuQjV2RVFUQVpPVUZRZTN6K21KTWJNbEtu?=
 =?utf-8?B?aHNzcXZnRUNLaFRjbVZMTG0yaWp1NHdFSlcwVytpZ3lZalIzeVFTSTAvMmsr?=
 =?utf-8?B?WTlkL1YwZFl3WW1NWnM3d3Z3RG9wKzdmdWw4b2ZHdjJmM1RoM3VMK0JEZm0z?=
 =?utf-8?B?RE1MTU1yQjk4S2k1SlJndVFaR3JhbXpWMmx0emtlMXh2ZmlFeWhVbHpkZ1Yz?=
 =?utf-8?B?N3c3NnB2THA3UGFTUjJkM1IrUGh5MSs1NU5NUm1Ua29EQVRFVzl3c0hFS1hu?=
 =?utf-8?B?VG9ZSjRSeWVvUm00NEFoQnJEcmg0ODJqOGt0QkZxRmJ3bkFlWkdxSTdaT1FC?=
 =?utf-8?B?OGRSMkVUNmJvVzd0bzZlYTV1MGhMZ01KdFhydjN0R0JQZE5tUVlXUUFXRk1j?=
 =?utf-8?B?cFc1dzREQUhoZmZCY1pzYXl5TjYyUDZNelZCRFAzd3g3RUNpY01LenYxS0xy?=
 =?utf-8?B?cFNOZmhrOHpKWU0wNTBFWmppc1h5L3pLRnBVaXVsT3NmdDlZd0dqR3dSQTdC?=
 =?utf-8?B?YkFTRTR6c1pXV3NPaTluNHBHUXkzRnk2WVV3VGN6K3l2V0VEd25YUlk4OXYw?=
 =?utf-8?B?akFDVlhHeklDaDAxZ09lcUN2WVorQzg5RE85aTF1WHFOL3N3L0UvcnhkZTVT?=
 =?utf-8?B?dHB5UmUrY2xNMkhhajBUNVdSVHFoRW14R041dUhwK011Q0ZMZWZmMDRaOWw2?=
 =?utf-8?Q?NGJ+MnuM6a7MwVKNBSm+F8mQM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da543762-06c8-4760-1bd4-08db91b292c8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 10:40:35.9747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dh05RKFfYlO4mZZbqdO7xuOdgThdB0y6tHIvm63mIIe1oSHhiTEOiJMTMqaAUy4tEnIxlN/q7JuX5YlWKyoSRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8201

Hi Jason,

On 7/28/2023 7:39 PM, Jason Gunthorpe wrote:
> On Fri, Jul 28, 2023 at 05:35:59AM +0000, Vasant Hegde wrote:
>> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>>
>> Refactor domain_enable_v2() into helper functions for managing GCR3 table
>> (i.e. setup_gcr3_table() and get_gcr3_levels()), which will be used in
>> subsequent patches. Also re-arrange code and remove forward declaration.
> 
> It makes alot of sense to change the name like this
>  
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>>  drivers/iommu/amd/iommu.c | 63 ++++++++++++++++++++++-----------------
>>  1 file changed, 36 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index 09749ad4445c..3c14c49d6d72 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -77,7 +77,6 @@ struct iommu_cmd {
>>  struct kmem_cache *amd_iommu_irq_cache;
>>  
>>  static void detach_device(struct device *dev);
>> -static int domain_enable_v2(struct protection_domain *domain, int pasids);
>>  
>>  /****************************************************************************
>>   *
>> @@ -1575,6 +1574,40 @@ static void free_gcr3_table(struct protection_domain *domain)
>>  	free_page((unsigned long)domain->gcr3_tbl);
>>  }
>>  
>> +static int get_gcr3_levels(int pasids)
>> +{
>> +	int levels = 0;
>> +
>> +	if (pasids == -1)
>> +		return amd_iommu_max_glx_val;
>> +
>> +	/* Number of GCR3 table levels required */
>> +	for ( ; (pasids != 0) && ((pasids - 1) & ~0x1ff); pasids >>= 9)
>> +		levels += 1;
> 
> This can surely be a closed expression, something like:
> 
> DIV_ROUND_UP(get_count_order(pasids), 9)

Yeah. We can use above macro. I will change in next version.

> 
> ?
> 
>> +
>> +	return levels;
>> +}
>> +
>> +/* Note: This function expects iommu_domain->lock to be held prior calling the function. */
>> +static int setup_gcr3_table(struct protection_domain *domain, int pasids)
>> +{
>> +	int levels = get_gcr3_levels(pasids);
>> +
>> +	if (levels > amd_iommu_max_glx_val)
>> +		return -EINVAL;
>> +
>> +	domain->gcr3_tbl = (void *)get_zeroed_page(GFP_ATOMIC);
> 
> I gather it is recommended to just call kzalloc(PAGE_SIZE) now. And
> really this shouldn't be PAGE_SIZE but some constant reflecting the
> size of the HW's gcr3 levels.

I will use the helper function we have .

-Vasant

