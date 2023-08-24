Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2BC17F2
	for <iommu@lists.linux.dev>; Thu, 24 Aug 2023 06:13:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPudalWnZ4d6ckiKOwtgGpxlIOF2ZiJqswHSHjhajj3Nv7R9kkMB9EhPsCY134rr8lAItZhrUUByRW1O1y84mVA98dZpclvQrvMswpUcOM2I17b9m5SnosBYFtyAWRs4cPU1uu0UEIlkShnE0N+rDtvCOO19KGCUD44x9vI1AfxPC5cVCf1ZvtmpCQWGuJjStPGp29VMBDP1P6AjhPq5ezN1qixW9AXeA61BNIyUtJy9wmktXM8trS1RB/DJdr2jr8eR9JDOc2/V+OwWGhpb455ZerPro2Unn+3pbbX959lVXqb9YrVVwxnlcsAmzn6LQqCvpOauQMmr4qPz2+qBTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CsWHGVEhJdOVt67rEiTh8zvtsb7qPRap4nFegEqjUmE=;
 b=TpZKsMxH7TZ0WK9JLInu2sHydmYiZ9MVZdkjPEi5uqw0vO/mMZPapJAEqc6zNrHYICwG/elJ6vh+nD7HSRl46XA7CchuWYTNehe+1FD9X+cEOF6L4XqxtEsOuKeAGS2OZmzHGQG6OqlB8m/7+CYpV7bOWkVp9fRZMG6vpjqsLqSYFERLo5T8AS4eJS8pY0Y/FAO34SSHvY/W7mkseeXw79Hv6iebjxbOV9Of1RgNueT4+hrbCacC3l86/SlTKgusbaubCMl3+ZsRDZTcBpHC7cJqnpDKc8Yv8Y+JkKRzOkzizXhKRxoZcjTcPzH4eLr71+A/U46gMmy4Nkj85wdORw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CsWHGVEhJdOVt67rEiTh8zvtsb7qPRap4nFegEqjUmE=;
 b=IDzxs7iraYu5Os2/N2vVSVcA5CwQnMTwV8Dkc+NuuGDjHmhFU5K/W1AZKBfmsl8bHMINTCVC1XLQJ4xZC5x0DWg6rf3IGzHXzHTCfRsgvDakqzSXMoOgE0Dl0X8hnZFJjddMBGuYMPEFt+NlNPcHTrJutPmcn0W1WMjP6mjTS5s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DM4PR12MB6064.namprd12.prod.outlook.com (2603:10b6:8:af::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.24; Thu, 24 Aug 2023 06:13:13 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e%7]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 06:13:13 +0000
Message-ID: <fcb7cb6e-923a-38f6-c4d8-b0f1c7537906@amd.com>
Date: Thu, 24 Aug 2023 11:42:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 01/10] iommu/amd: Use struct protection_domain in
 helper functions
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20230816174031.634453-1-vasant.hegde@amd.com>
 <20230816174031.634453-2-vasant.hegde@amd.com> <ZOY27tt9lBFPLlHB@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ZOY27tt9lBFPLlHB@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0150.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::20) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DM4PR12MB6064:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a8e2fe3-016c-4b33-cdae-08dba4693251
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	y8CKzwb8gIw/4XM0DHVr2+tXl3PV+AmaSN9wIGCfcoBhF7EpCDx3yv7PtjSZruqgfrJ9AsOiV9/A9U7fHDBYA51+ZsPry3+eDJ9BhnHASNuWbfbUGfTRrdVp4T+J1Efl3YE5MuqD5CkL0wXvPojFNNNXaQ6LAw0f/33RQQILKIhBVOMaxTc9pTdsPkvzHMtk4QKPIs6h8KqNLK2+NWJn2Owd+/fAUSiAb9twdpB62hXT6v9ss1JbmVbyP3/TnfirJeToahPqn1redDDfJxIhAFXEQaBXjpzAaQY3ef7ZdFSk7HL3zwWgNpKcxXr6ljzdtyMmSP7HALqb1SPTTaFAJcvxwRdBbBoZ7qHg5SAUeU2k670JbAe9JVO9weSQHzeWvCYthCoAJIrEwjfYtyPCp7lqdUPbp71pQthk7BPOE2PdCdNJjXQibUxkMj0aS3noD82Ehnpn5xv3cABlxIuYV4OnNuTjcFd3RW1giQCLlvCbj1e+yGaoJcMYVdAhM/VYUeZvUhhSzyjdXZ6iS5yps+OH+qaYk1XDwCItDQYmjGk8VOzaZkU4hAnh6DqQ5M0lVUperV7A51FbuhqhUVsf3UHUiwJxs3q2TZrgSSgnl0pS4UdmW/HDTLhDBIBzlMW+vMCQ6Z4DfS3jlAvxEqHGQQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199024)(186009)(1800799009)(2906002)(38100700002)(53546011)(6506007)(6486002)(83380400001)(5660300002)(44832011)(26005)(31686004)(31696002)(86362001)(8676002)(2616005)(8936002)(4326008)(66946007)(66556008)(6512007)(316002)(66476007)(6916009)(478600001)(6666004)(41300700001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dW1LWDJzQU9FRk1FeTEzRVhoR05MNVJ0enhsU3d5V2dZcytIbTNnT0N5L2Rm?=
 =?utf-8?B?UU1raDBMbGpkdXlEb0ZhWktNZVlheWJDS3J5MklIZ3kzYzUxVVFEZzdmWmlO?=
 =?utf-8?B?aEJQcERqcmRhcGJ2VzdtT1N5WGtpOGxOelZGWmZIQU5tMTlVZHNxOUFmR00z?=
 =?utf-8?B?NEtsOGpwS2RXMllGWXpmdE9tU2xyTVYxb09wLzUrYlpLVnVXLzJJdVRnWElR?=
 =?utf-8?B?U1RJS1FzYmZpUEhHbG8zV3lBeDg1eGM0VWNydThjS0hIeTNBVVVpdlV6VnZm?=
 =?utf-8?B?TGF1QWp0K1VQZU5veFo4UURtWUJZd05tN2UzRE80NnJPWXVGYzZVa2d4QUFm?=
 =?utf-8?B?MUN3ODM0N0NFdEk0aDZacVA3K2hpOU1FazhYZExHS1VyVzFHaHdHZmVITUxy?=
 =?utf-8?B?SlVqb2dDUG05VExmYnlYYUFDdXFwbC9IRmU1aC9LSTJBbWlPblllTktyZHVY?=
 =?utf-8?B?ZXZTVE4wUWJLVDI5NTVRekVIVzBvQlI3cDBxV1BOK3ZqS05Ib2c0TkZOcmFT?=
 =?utf-8?B?R25wbElFQXRZcTgyVnB0dXFPMk9mOWU0Zk1wRmMyUDJXY3pUZjZDSE8zbElZ?=
 =?utf-8?B?M2EvaDV6UUw0QWMvUDlvZVkwRW90eTVFVlZuL2RUd0h6cHYxWlFRMEliRjlQ?=
 =?utf-8?B?eHRzMXZNQmh6amdxVmdrc1U1czBNRzRQc0M4UkVTbXl3S2NrRFArZkVYNVdt?=
 =?utf-8?B?QUJBR1NZY1JpbldocTdpSDZ2NHVSOXE3c0FjbS9KRDYxZEtaNGFzbFV5eUg3?=
 =?utf-8?B?SUl4UytKdW94TzJLMCtleUVXNWNOczhqYTYxU2JRS1hjK04vT0FxTk83LzJi?=
 =?utf-8?B?NHVMODVJWWdOMVhoU2hySkp1Kzg5NTdlQVVydXczVWE2SlRWTTlqd29HQnZS?=
 =?utf-8?B?Um42STNoRXd0SjM0R1VCNVBhdE5pZjY2dnV6QjRlbnUydk9QYUNXQ1hhNlRu?=
 =?utf-8?B?ZlVsZ3BtYlBZR2RTdDg4eEJtY1cyeDB4OG9XcVdUNXhCMWw2RFpjVHBzLytW?=
 =?utf-8?B?am1iUnc1azFpMStrWEZaMXlNSk5HNXFWa2NlQnRxU21CR2hhbm9hdERGaC8z?=
 =?utf-8?B?N1NoMk92eFZ0UnJpMklpbzVWdmVuend6dUN2ZjZPeCt1UWlvWXZoQjJJbjNX?=
 =?utf-8?B?NG4xYkJyNktZbzZ5aENyRml0RFc4UHN2L2tvUlhoNGtValNxbkpQMkRsOHpm?=
 =?utf-8?B?d0dKakpQUjAxd1pwTUtaZk9CR2pmd1FDbGFrY0tkb2pOZE9UUzR4VXpFS0dT?=
 =?utf-8?B?b2phZUFWaUhIMDdvc1RRWnZpNHNLQ2laU0tEbEtmT29nREorUlhuZXIyUmVY?=
 =?utf-8?B?ZFlTS1piVnNDdWlweGRVNjZTNHNiK1kxb293cmJFclVYRW80TjQyRGx0bHRh?=
 =?utf-8?B?dnF2RFNVUlJhTG9wdjQvbi9Ha3pNTkM3bC85c1J0MFVNL3o3TjZPTXQrRlJh?=
 =?utf-8?B?WXN6TnM1dnloWDRacEx0OWV4Q2FJdnJGMThtUXk2MDNwY0FRYlBMZGFIRGhK?=
 =?utf-8?B?LzhRSUlIcW1XdEZXVXlRMmx0TzZBaDdoVDlMVFREWHFTM2VZTG91NENzcHR4?=
 =?utf-8?B?NEZ5OFdvblRYdk9YdEh3V2liVmtuQ2dtZ0NMNUhGQzRHTktvcHdIYmNDODNh?=
 =?utf-8?B?SXhwcGN1Q3ZzQ2djeGttcFRDSWQxVVNUSCtxeXNiazlCb1g3cUJNd0hrME1o?=
 =?utf-8?B?Vm9XNnZiSDFWVkpkdUs2UzF0ekhwTjJuOGx6TXdOSmg4Q2tGRENkVThrcUxm?=
 =?utf-8?B?cVlBS3VHdE9UMWRRRm5URDhNOHNSaDlqRFBtOHZQTmNUZ3ZWMHZFbHFvSWE2?=
 =?utf-8?B?VmxKK2Vqa0ZwdFFVK0haejNjVFNVb2JnLzZFM3czdy9adElYS0ZXd29Sa0Ra?=
 =?utf-8?B?VkhkRjlqdUExWi9JdllXSXp0cUpJeGl5eUNnbFFWbzJDMXByMVBzMnBSN0dR?=
 =?utf-8?B?V2NDVWtTL2t2VGZ2b2xaVWhxYWdiM2M1alB6WnN4ME9YQ0hhUlZWOGNnNVh5?=
 =?utf-8?B?bm56ZTJPckVLT2NRVzY3bnlhS0pSenJzK29WelpnZ24wQkttVFNaU2lUdnlQ?=
 =?utf-8?B?TEw4U3J6VGF4SGhSU2ZLZFRGTmphZUF5VDM0UTFFOWEzd0ZKZUtvbFREU0Jn?=
 =?utf-8?Q?odieW2i7oz1oziqmxk0wYPOs8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a8e2fe3-016c-4b33-cdae-08dba4693251
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 06:13:12.9948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g0Pfcv2fbRM8DFJu4+QSlvJ0+W9EWz+yHhWGxjjLWaLHDk0QuA33cqdBl7OQ5tVN/SrLhgcexA5ENcfKgt8tBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6064

Jason,


On 8/23/2023 10:12 PM, Jason Gunthorpe wrote:
> On Wed, Aug 16, 2023 at 05:40:22PM +0000, Vasant Hegde wrote:
>> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>>
>> To simplify the unnecessary use of container_of() on the struct
>> iommu_domain to get the container structure.
>>
>> No functional changes intended.
>>
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>>  drivers/iommu/amd/amd_iommu.h     | 13 +++++++++----
>>  drivers/iommu/amd/io_pgtable_v2.c |  8 ++++----
>>  drivers/iommu/amd/iommu.c         | 18 ++++--------------
>>  3 files changed, 17 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
>> index 8b586effbefc..87739d95ea8b 100644
>> --- a/drivers/iommu/amd/amd_iommu.h
>> +++ b/drivers/iommu/amd/amd_iommu.h
>> @@ -55,15 +55,15 @@ int amd_iommu_pc_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
>>  int amd_iommu_pdev_enable_cap_pri(struct pci_dev *pdev);
>>  void amd_iommu_pdev_disable_cap_pri(struct pci_dev *pdev);
>>  
>> -int amd_iommu_flush_page(struct iommu_domain *dom, u32 pasid, u64 address);
>> +int amd_iommu_flush_page(struct protection_domain *domain, u32 pasid, u64 address);
>>  void amd_iommu_update_and_flush_device_table(struct protection_domain *domain);
>>  void amd_iommu_domain_update(struct protection_domain *domain);
>>  void amd_iommu_domain_flush_complete(struct protection_domain *domain);
>>  void amd_iommu_domain_flush_tlb_pde(struct protection_domain *domain);
>> -int amd_iommu_flush_tlb(struct iommu_domain *dom, u32 pasid);
>> -int amd_iommu_domain_set_gcr3(struct iommu_domain *dom, u32 pasid,
>> +int amd_iommu_flush_tlb(struct protection_domain *domain, u32 pasid);
>> +int amd_iommu_domain_set_gcr3(struct protection_domain *domain, u32 pasid,
>>  			      unsigned long cr3);
>> -int amd_iommu_domain_clear_gcr3(struct iommu_domain *dom, u32 pasid);
>> +int amd_iommu_domain_clear_gcr3(struct protection_domain *domain, u32 pasid);
>>  
>>  #ifdef CONFIG_IRQ_REMAP
>>  int amd_iommu_create_irq_domain(struct amd_iommu *iommu);
>> @@ -147,6 +147,11 @@ static inline void *alloc_pgtable_page(int nid, gfp_t gfp)
>>  	return page ? page_address(page) : NULL;
>>  }
>>  
>> +static inline struct protection_domain *to_pdomain(struct iommu_domain *dom)
>> +{
>> +	return container_of(dom, struct protection_domain, domain);
>> +}
>> +
> 
> The change looks fine, but why did this patch move this into a header?

We wanted to use this function in other files as well. But lot of code changed
now. Now its only iommu.c is using this function. I will revert above change for
now.

-Vasant

> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Jason
