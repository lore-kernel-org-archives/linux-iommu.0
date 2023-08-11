Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C7E746C
	for <iommu@lists.linux.dev>; Fri, 11 Aug 2023 10:10:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pnj2bPJZGzvqzIRYf5KqSfd6HdqI2FqJwDwu76bAbUWewhSkb1hIvOKDfVpK9eJhnXXE2AOFEaQJO2oiDOj7Oiqf1jhHYGvjvTRoaLuO+YuTT5uszTy2cFX3hoi8TkJkn/WHUdfLSLLcownhI/MQfLTnpzLZ6MmjcPg3Ax+5eQP6n1Lj2jf4o9OTMVGljJvEwCWGos/C5f/ou6Vq5pq52ZIBGaYUr2HcmgNe9qKEr0+dF4iLh1nq81ExOtUMJj9qdSOPAOiGiDUDElhXtIWId/v+qzv28p8pC7yMbwUsYM+r7Io7rZvwPey8MxvkD3zxsJT5ghMWSE3+3URr+PfYHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jjanbOp5pIXuTR+pyRFVWDbU2JY1KUmdorDJW/RezLk=;
 b=J4Q4YXqUMHHA5Up22pEEAYj2XyItqcahexCq9fDbA0S5XkbEweLL0rLMB+T8kBlmtP8/c5Z7gKCxfnGjMFcYDwtLqCLhKmNuGGRhIQMy8YiEGLh0RG558wWDm7MSl3tW7aCCv629nRzBi5D3gBRubXgO0zl9DvmLt0+lhYd1OzcgHRAA4jM/S8HzpfLAg+V9hDcYlmyxiP4rb9QKLfBUYEpZjoobj239hz8+pSiRHDyiRJvQa7ALcj6E8iRHOUbWz2s9EQzAA3REd5PcypXvsfL5PdN7HlfzCNhlTex/wQm4x5a7K9r5yW1OQg6x4D9KevUw36N5S5jo2EOj96GEDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjanbOp5pIXuTR+pyRFVWDbU2JY1KUmdorDJW/RezLk=;
 b=jtqg/jiqk0lOom7pvPStrIm587VR4IfPZsEP3FrUlpurV+2o7g2kzoh6Q6rKTr2cB2aYewYoqrHKbVxPcgLm+CoC6xv1hnPPmaA591X1ZGvIol6V0k5zmHfHA6xDouX+IY386tMRiGErJW6sAf+NExJ/6MmAqYgX3uJRBkRrC8o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DS0PR12MB6654.namprd12.prod.outlook.com (2603:10b6:8:d1::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.30; Fri, 11 Aug 2023 10:10:23 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e%7]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 10:10:23 +0000
Message-ID: <47f146b1-fd60-99b3-b437-5b6999450bc7@amd.com>
Date: Fri, 11 Aug 2023 15:40:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 04/11] iommu/amd: Use protection_domain.flags to check
 page table mode
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20230808100232.5977-1-vasant.hegde@amd.com>
 <20230808100232.5977-5-vasant.hegde@amd.com> <ZNJg1mUd+WXBDVaD@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ZNJg1mUd+WXBDVaD@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0043.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::18) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DS0PR12MB6654:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d4973b0-435d-44c9-f491-08db9a532cea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	znLWhMcnTTzYCnAInv48uZUS8HCDru76Xp0NtcL78vRp7SvxNDdAJlopdWfdOh5VZ+xXv1PtusPlIFKzkCun6gMrKt01Ky3KgALCjC9esRog0WcKsr9VXDm/TZFj0aoU2VZlhXGXgNyN2YZ0gPLLRm9j54Msx+TTa5ApLXU8Gqgk5pqS1vXqPogYSoEcd1W4e46T/uTE0dH4Emg22ze3NMxho1bkBTYWER7vfkLGcHCeZ8gUUFLsgQ6WnuuNsjJtk+H2QpRTHTgVLxLSn3vmlCi31pe43yGAjH2TKYHnFAJPDQ+RbUY07b0GL0/bqwUGP2CSorD70l5HlJoaVEKjBpwYyqGVP+1TBez0GWyTyBrB0MzsCe5XjKXrAj8Yp2kBev3qxpLM1MqPQXWawhZd9Gc8npdyfs3u7PiAT9KYZ5NzV9lzBmiYuhDRBNXfb2HpF5ZGYAOaszMJGHU4sABCFGgPP+kGtkLmztMV9mAlU7Pz28g0+KrN6/EhTsyG8nbFmU48IQ4mBSF1tvcd2J5/URthlcpXs9JQjQ1ri8oC8LtdDKgQ9+16fNlz9F4isxniTIya1nHREv05wRBo3vExDaAOXvrHvYYrH5oDMAcY7/In8frUqOeXeC94pZaLNOcmAZjIP+ER5UgosqIPoAP5+w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(1800799006)(451199021)(186006)(8936002)(8676002)(26005)(6506007)(53546011)(41300700001)(36756003)(83380400001)(2616005)(2906002)(38100700002)(31696002)(86362001)(44832011)(6486002)(6512007)(66476007)(4326008)(66946007)(66556008)(6916009)(6666004)(478600001)(5660300002)(31686004)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXN0R0FmeWZGRUJjdkdhSm9nd1BBSXdpYlV0b2JTd2ZBWEdNcG8yV1V0cGNE?=
 =?utf-8?B?OWU0SU1UWCtmcUYza1ZRMzRhS2JJcmI5cFI1OEd1c1hEelhGNHJuZ0J2eWdw?=
 =?utf-8?B?UzZKaHdJYWdNRDBFVkFzSHlNakQ3TlFkblppd2lIT1hGRHU2QWFWZWFjZW81?=
 =?utf-8?B?YklGL0x1RUlnb2pUeVYwZ0lZVzFvODhmUXViMjBXVExXbFhWb21UOUFhdXh6?=
 =?utf-8?B?OWN3QzdPNmkxenJiK2VkcWJSTDlwdUF3UmJiTy9EZy9OdzZINlZWaUgzZjVP?=
 =?utf-8?B?U1NsNVZKci9yQytJUzc1QVh1dTY5REVUTlZXWk1rOGF3ODNMZS93SVJYNGlI?=
 =?utf-8?B?SzBjbVBaSzBHMzV5bmg3aFcvOUFMaXJoYitENEU4VkY2ellRUUFsZTRTc1N0?=
 =?utf-8?B?aVhCM2dMWW1HNDBWbEdBRWZ5akFPSnlRMTZxUjEvQWFCc2FYengrTEdnVzFR?=
 =?utf-8?B?MCtlY0FsTlFCL3JvWm5PN2NycXRvSEtrdzlUdVdML2lOeFFFY1pVV3pzQnRU?=
 =?utf-8?B?WUNNN2FhckovdURCajdjRElrMlJlZmdwSFp0WWJhbFlNQ1VXOVM4MThFbVRx?=
 =?utf-8?B?NkJXZVdYb051a1lldlVMTE13dXA3WGdndTFId1NlZXE3WGwvSFAwWkt3blNv?=
 =?utf-8?B?UVJ2N3ZVN0hPR1lRbTArYzU2ci9iVjltUXU4K2cwM0drQnlvcHJCN1FxaWpO?=
 =?utf-8?B?QnA5RG1iU1VVTG41RTUwSW9WaFNOOGVYaHlBRWFsZjFHaGIrSnZEMy9xRkZv?=
 =?utf-8?B?Z01weURQK2Z5Ky9kek1MNFg5TFpucDNuaTBieUI3ZU9wbHQxaWQrbllWd0Jz?=
 =?utf-8?B?YkZiNFpVRmF4Q01aemhWS1RZcUVib25LNzk5WHk2NmszTlpBRm04cEdSczNh?=
 =?utf-8?B?ZjROOCtId1Y5SHVuSVZIRHdPYWdJS1dIeWlzcnFOTjRWNmczMXRUNlp3RmUy?=
 =?utf-8?B?WUIxUGxWSGxSM2lKUE5hdUM2WXd0TWhoejIzZUNNcXk2ZTN6VnVzMDhwSWc4?=
 =?utf-8?B?TTFOOEErT1ZzWlVuaXg2M0g2RUhaaW42dDhBVTZocGRSV1ZhZDJBcHlDRVV5?=
 =?utf-8?B?WEhNSVBUcUFpdGFOOFlOem8weDQvYnZZelI2OFBmaWw2K2FnMXU2RTRHL0dT?=
 =?utf-8?B?Umw0ZS9EV2pYNnJIVHFiVldaR1JMUWZENDMyZ29jaEl3STAwcmFXM2d6dDNz?=
 =?utf-8?B?dVZXOGNNcnZwQThIcTg3ZW1ZSHFDWC9tODVaWHZsNHlXZ21BMHltTmtPUm5P?=
 =?utf-8?B?Yys4cm8vcHVCc0NESHdIREZuRzhrTC9KTUxHRm9OS2dpNTJ1b3VPL3RtanZI?=
 =?utf-8?B?UEV4S0pGQmhpV0NlT3F4dmduS1lUUkp3RG5pQVkyd083Q3pCcHJEQlJoejhO?=
 =?utf-8?B?UGd3aVhoR0YxbGhjQnR6eU43c2FYbkw5US9rMXkxRjY3UHI3K1lCUXl5cXkz?=
 =?utf-8?B?SzJHbkhGL1B0Si9IN1lTSG9GbVdRUUszN2RUMjlMWlRPWDVrb2tOVFZZU28w?=
 =?utf-8?B?eXlBZHI3VkNGY0dRR1o2aHJqN1VzU1IyZ1ZWamdNZHlUS0F5ZU1QTGRiOXRi?=
 =?utf-8?B?K2hFSkUwZHlHSklIaFlyUVpmWUJoQlVhL2MvYjlZRG1VR2pYV1FwYm9NckhQ?=
 =?utf-8?B?TFNwOWUrWnNUcDVrdVo0Zllidll4QlExQVhzRE1QcFNqdFJEdlZMRE9tMjcx?=
 =?utf-8?B?d0JGVzFtdkpzUkp6eGdqZVBYSVdKVnhTeXRKK216dW9ZK3U0VWo1QWI1d3NS?=
 =?utf-8?B?WnlIcExTdVdKUjA2Njk0cGZnMjk2aXJpVVN1aEtvVWlJb29wTTVrY29UTjBK?=
 =?utf-8?B?MzZ0azN5QVZrcGc3RlpNdVRxWGkxNmp4OU1GdzZrVXVsUzNJRlRjLzJLN3Jw?=
 =?utf-8?B?YXBMRW5kS01RbzRQV09Gb0xyZXo0Wk5CaFJ1NndJajVxVWVaTnBZdjVqUjFL?=
 =?utf-8?B?UVU1WE9XQUdmY21ZNGsxMEZwNWlKSlkrRk8zekpQcXMzSU5RSGMvNlNRNkJs?=
 =?utf-8?B?QW9XcnFiVUluUndBTlVJYjFLVDRjaG1XbVovMXllKzQyUnhKM09Xb1kxV2lv?=
 =?utf-8?B?Qk94bkFuSmJ0R3Y2d1NJRTdDcXN3THNmZEREc0U5b051VjROTlRFZHJPenpM?=
 =?utf-8?Q?I+pJtAOurDR9bccSOIZ6+eiam?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d4973b0-435d-44c9-f491-08db9a532cea
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 10:10:23.3389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eXz4hXKpm1EKXzm7kuosAYMkhBgjvBkaqmrxbymMCjFpE2k1InO48nmoILL81s+u2hzNeTs9kttmV1aaM7RPiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6654

Jason,


On 8/8/2023 9:05 PM, Jason Gunthorpe wrote:
> On Tue, Aug 08, 2023 at 10:02:25AM +0000, Vasant Hegde wrote:
>> Page table mode (v1, v2 or pt) is per domain property. Recently we have
>> enhanced protection_domain.pd_mode to track per domain page table mode.
>> Use that variable to check the page table mode instead of global
>> 'amd_iommu_pgtable' in {map/unmap}_pages path.
>>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>>  drivers/iommu/amd/iommu.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> This is OK, but IMHO, it is much better to provide different ops for
> the v1/v2 page table map/unmap functions since they don't really share
> any code.
> 
> eg having a function pointer that does nothing other than call another
> function pointer:
> 
> 	struct io_pgtable_ops *ops = &domain->iop.iop.ops;
> 	if (ops->map_pages) {
> 		ret = ops->map_pages(ops, iova, paddr, pgsize,
> 				     pgcount, prot, gfp, mapped);
> 	}
> 
> Is quite inefficient these days. If you start with a map_pages_v2
> domain op then you can just directly call iommu_v2_map_pages().
> 
> We did alot of work on the core side to enable this.

Agreed. This code can be improved. We will look into it later.

-Vasant


> 
> Jason
