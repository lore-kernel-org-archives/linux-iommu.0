Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2673168BC
	for <iommu@lists.linux.dev>; Mon,  5 Feb 2024 10:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707128353; cv=fail; b=LnB8WDROCsR43tMoOokmVr3a1HfmAwmKXi0U9j2Oe7oeL4y4o4qiw9BDatNLqY4CJLQcbNuBd8j1E6CyBRB8vFPSmjVaCdSqag3l+heIQ2AJvBLFXbjaLfvveFfzTZHY50Dgl+uvn/Ik05eTnnzOzJnpcMRqM+5q4T+8Y6n19C8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707128353; c=relaxed/simple;
	bh=jxgJ/n7b/zhaH32G/OYaJ2bTSaHEIgZorMKSFVvt//w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JDhtTOWPSMwArLP1SH4dI0XF63y7w57L16MhCZq41A5QwfJMdpL9FdOvNUwIp2pCYD2BDlAYu5ScoUWjzYsBGbcfjtoCHrHQG4n2qqqkaTYmZAZW6aM8q8bic8B0ci2q3immCYklanwnvMH3tdFV9J6vOgNCblALVZtzrWViW4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hndNM3sV; arc=fail smtp.client-ip=40.107.237.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hndNM3sV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MW5etkJuXXyrodpkORJbLkfuyFnQO9iplFNvub9vW/CzBlNVkfMz/Pmz+lxeU26bpe1+oMOjeaiYW5uJR9bX1zIltbKSBgRpYAB8hzyvJ1VbBXL5XYUkD2t4MS7K93Dqb3+uXICft7RCAI8s0hYkZcQiTmlmhpdo1v86MGL26xUHsyNlYtJMMkiJo10Ood8xVwjIe+UtkfPl2gkj/Fs8SOeiI8xZcias8Hbro38WUH5KhcRM70jmnxEQ3JuUNcWUMa+89lCA6xq0s1W9dZ54y8odCMN+F66xWLdLOlvQJZH8ZdpO3BonZmVJL6kbiVZE2L4+i1956+IvznMC5PKOeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/haFa57k287Gig4Jy/bbL+gCkgciTpiTCYSP8CxCzig=;
 b=eTeTr+JfU1wPL/uutlmCYCgNhT0VwNvADSBtH9hWQx1VxZmYDl15KowUU1pMdouro+8lOZny3r5t5pKbxR3C75OEGyKnlE0ga83Lxel1o9+udLdnWq2l7cpz77vStwJoYv4vE7aTB2dipMD7FXDZWWEOMao7IpSpt2MwZuqe3v/mkBNBCozPhQJOXKOypI3K0AEfAI3pVBwtgjOFR/dzh2zw5q1bu+Sbs6kZIkV6QCpbiOMse07qnwjEk+wOgkNV35dJpDPbBgV8qPHP9hru/3rp85oKvIjt7xH5NCa0LfMLC+yDBnXSgXTCgDaCVk3Gv3hJD2GcG09RxyCddYea6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/haFa57k287Gig4Jy/bbL+gCkgciTpiTCYSP8CxCzig=;
 b=hndNM3sVAT+UFc9z+QqO9AY3YM8ow/v/7rAcYo24UFbA1RIjBpaBPUsVpgZqBHMpevVj1gujRdpFiyqr1OiVUGicM5G9zvrarmJDTEi56mK3PpOMRY1v1oCt8WX3SZI9bWwvc8Q7KZFKWiZdo/XkUiIz5x7veVCPwj7SyxfqZnk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CY5PR12MB6057.namprd12.prod.outlook.com (2603:10b6:930:2e::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7270.17; Mon, 5 Feb 2024 10:19:09 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb%2]) with mapi id 15.20.7270.012; Mon, 5 Feb 2024
 10:19:09 +0000
Message-ID: <074838bc-1221-852c-daaa-f6f475f1df4b@amd.com>
Date: Mon, 5 Feb 2024 15:48:59 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v6 17/17] iommu/amd: Introduce per-device domain ID to
 workaround potential TLB aliasing issue
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20240125121135.8217-1-vasant.hegde@amd.com>
 <20240125121135.8217-18-vasant.hegde@amd.com>
 <20240201185121.GO50608@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240201185121.GO50608@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0075.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::15) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CY5PR12MB6057:EE_
X-MS-Office365-Filtering-Correlation-Id: c4ce9655-d7b8-4e82-18b2-08dc2633e3b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QEERP4bAGsEoSpqE7J0v1xM71HtJs2+kSjJ0w7TrrcK1L2Z2R/S2b6GmgVjloYuH/8r4/cZcteMxPg9n8gM6dy1FLTc1+Nn54SkK1JxUBs1NLiO5jMd7TZSNllKRyQQLo6x/nAAn/AZmgkE4j0iHoc84+C0JuXmZ4hJ6VgRGZmP9faa+i/PB/MiTsTfEBrMlRz0figUWEm3avRQcteSWhMLlN3QfOdhPeirPfzKhn2QX6ECWNl39aXHr38gy2/wbnTF4jDXzIMMg27hTKLumNI7ZvHjnKwu+0d3b7dKBM3/dUThBpBTFABwU+KLyn9C1JQePkpjOXKrzSJR8rijOYh8pkgW8WbkdZt5iAOWBPygG5I4TRtQJEo3OFz2Qd6I/RPUSOGlO/V56I1lxGr3BaNUipsfo4UemsQxMRyHaGtEpZj1Qp8pDtf4fdI2g1nO/sAXm6GzcmhVZ72z1iYsN1axYRGEjrRFlt9fYZL2l7Bc9dJoQbPb93H0ouB9isbtGwzkl1lk8SdKDQP6Y6ZDsDUe6cAvJrN/J9VSpNz7dEutmU6h624N/g/az62SQz9PPXx82h2eLVhJ8TUg9b16egJ73hNykRVI4ckzLxEHK05QBU4x3sE+diWi004p7CckMpWOITKqFxRsOCi2tCK5yaQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(136003)(396003)(39860400002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(36756003)(44832011)(5660300002)(2906002)(41300700001)(2616005)(26005)(6512007)(83380400001)(31696002)(478600001)(6486002)(86362001)(53546011)(6506007)(6666004)(38100700002)(31686004)(66476007)(66556008)(66946007)(6916009)(8936002)(316002)(4326008)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3RUNlRpSzhhOFZ1WERucjFWeTZnVURkdFZqb2dhVnc0MWU4dG1idVRSYVBI?=
 =?utf-8?B?ZlVIaVVEMXlndTVlbk9VQ1F5S2FYVlNtbTBZSEcyMWw4eUlhZ2Mxemk4czZp?=
 =?utf-8?B?RUNCUXFJZ3plcWVnOVp5bTRBNUtteEg2NjNjWkk5ODc4U3BVSmRCUXh5WVYr?=
 =?utf-8?B?V2oxMzd3RmZsZlRWTzlUVDhWSnlQQkxXdE9JcTJjak5mNHltNVBjTHhLV2Q4?=
 =?utf-8?B?R1dTSjg2Q1JEL0xLczlSZUtna0NQTmRjU0FkTG5oVGNndHk3VUR3THNPNUND?=
 =?utf-8?B?bjNvamJ0WXhqUDdva1MrRk5SWHB3d1grQlhkZnhTcjRRdFFLV2RGQWFlenBp?=
 =?utf-8?B?dUQ1TS8vNHVhbUVoLzZBdE1xMzVLY0tzZE5FUWFMNlhhNmxDR1ZTZjQ5U2Zh?=
 =?utf-8?B?T3YxeHhIVW5nc0xhdHdlQnZNV2Z2aGVhOThLVWlvTmVCRDVEb2xlUXhiMk43?=
 =?utf-8?B?dEhFTFEyT0srSTdvWVFWZWkxZ2dRVmVhVmZJcVovb3FLaHl5S0ZrMHhQRG1v?=
 =?utf-8?B?Y0dQWmJ4MzhEKzVJZWlqN3J0OEJLWGxSL21zMllLL0dnOG91bkg4WDg3dGlL?=
 =?utf-8?B?dEhqcDc0bGt1bEQzTlYxQjZhRWdkMWVUZ3p5end4cTdjR3NnbndjUVlCY0Jt?=
 =?utf-8?B?NWluUitQMVZHVFJYTEdweVErZFZ3S3VtLzQrajBsNnovTGlreVVRQ2FIVThB?=
 =?utf-8?B?akRNM29GcU1zdGpOVndvYkdRdHpTTGhRWUZyaVE2bmZqTXNjeVFvcnlWQytu?=
 =?utf-8?B?MXNUaXJpS1h1S290R1Y3cVBnakpmZjAwWHA3OVlKcVN3YWExK1E0VVNaNnFN?=
 =?utf-8?B?Nm5IQisvOHZGdUErQWN6bkhMb0w3NmZvYVJQNmxXQ3lNUDh1c0doOTB4VnJE?=
 =?utf-8?B?RnZiTUphUnUwTjRxMnduUGxVc2NBelFnc0FJNjhyL3lzWVRsQmhKcUljeW5p?=
 =?utf-8?B?elJ3QjkwOTgzUFhyOFZTM0YzaDRwdFA1ZWMrQ1A4ZE5wd1RCYVpLUHljQ2Zi?=
 =?utf-8?B?SVZ1WUxmWmJCUmhraWNrYnJyc1pFRks3UlZwRkpaa28zclpnRHFVUGN6UlVF?=
 =?utf-8?B?VmFtNVdBK01OYkxRd1o1UVhVaUsrNkZEZXBGUFc2ek9ReFE5ODNuL0FWL05Y?=
 =?utf-8?B?enlkZzhOa0V0MnYxZVFuWUFPV0J3KzB2TXNPdHh5VDMrUVYrNHdwcW43VkJU?=
 =?utf-8?B?ZFNwdC9SVVVaZ09ia2VuVVB5T2VDZmpoaU1tSm8rckplOWIzVWp4ODg1STgr?=
 =?utf-8?B?dThGV0t4ZzB0eDNuS2tGbVdUaWRlR3BNdTRDKy9GUjgwUkJldm1PYUpDdUZr?=
 =?utf-8?B?Y2YrQVBnZXZxV2s5b1psVWp1TFlCL3dhV1FKQXU1cDhIc2lvTFhoZXFUWC9V?=
 =?utf-8?B?N1J5dGFtcFFncGZ0Tkp5N1Y3Z0xtV1ZPY2dQYzhHa2V3cVFvRjNDeHN1UlNj?=
 =?utf-8?B?SjNXN09qUVBzc3NTSXJSdHZVMjNRbHZVVVBMY25YTEw5K1EzNUVyQ0s1ai9r?=
 =?utf-8?B?Yi8xVnF4QWpzOTFJM29nVVdaamtqT3JSeUt1cUIzV2pveWhVQWRDTmdDazRL?=
 =?utf-8?B?dmZTeXQ5amlia2xGdkpkbEdEbEF1UmJRNGxkMGs3WVBzRWcxWkd0QlUwN1JQ?=
 =?utf-8?B?UytvQy9DZWdVMWh4MGs5TmRxUUd2Tnd3S0JlbEt3aVp0ZWNHcTlaTjVjamdy?=
 =?utf-8?B?NXpNUzhXY0RnZmNYY3pWYmFlcFI4dUJ1cFZvU3VHaWFCWnZVVGNKOU1qbTU3?=
 =?utf-8?B?L2FqODlSK3RNMTUvRlQzbUtrY2x5OFZCYmZtcG9TbHZZTDFBNkRJWkJtLzI5?=
 =?utf-8?B?SmRSbE11Q3Y1b0RGeFU3VVZLOWxLWWgyTkM2ZkpLd3NKMmNiQUF0ZU9WcDBK?=
 =?utf-8?B?cHkzVTJiL2JYMkZ3UlV6ZlNvTGdCZ3o1eUlVbGt6aHZORzYvR2VqVHBEVFl2?=
 =?utf-8?B?eXBEWlNNemloRlZFNi9kckxDdHJMNFpoZ0xJSWt2ZVJwTzdSV0hzZUtKYWZM?=
 =?utf-8?B?a3BrTGxxL1AyZktYbVcyOFhyRVBSOXJXYVRxUGNibnd6QjZyRmhWSzJ3aWg0?=
 =?utf-8?B?MzFpNVE4WHJUZWdQcUtLZXNVOXlwL1RzTWNZNFlnazVMWDl1ME02Q0tEOVZE?=
 =?utf-8?Q?OpLwVSI2zOWMBIlcZL+radln2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ce9655-d7b8-4e82-18b2-08dc2633e3b5
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 10:19:08.9221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vwj1+DwZAASN045RvZqmWZzT1BFigDkeTwD7htL8glOE25FQ2lOl4mAot6cW+yOl1Zij7u8d9pUH+tkn8lA1xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6057



On 2/2/2024 12:21 AM, Jason Gunthorpe wrote:
> On Thu, Jan 25, 2024 at 12:11:35PM +0000, Vasant Hegde wrote:
> 
>> Hence, avoid the TLB aliasing issue with v2 page table by allocating unique
>> domain ID for each device even when multiple devices are sharing the same v1
>> page table. Please note that this workaround would result in multiple
>> INVALIDATE_IOMMU_PAGES commands (one per domain id) when unmapping a
>> translation.
> 
> I think the bigger downside is that it causes V2 domains to become
> IOTLB unsharable even in simple cases with no possible PASID.
> 
> BTW "workaround" is not quite right, this is "fix", and it is a
> security problem to get this wrong.

Fixed.

> 
> Anyhow:
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
>> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
>> index 79a07a2e4bec..d5786c33aee6 100644
>> --- a/drivers/iommu/amd/amd_iommu_types.h
>> +++ b/drivers/iommu/amd/amd_iommu_types.h
>> @@ -536,6 +536,7 @@ struct gcr3_tbl_info {
>>  	u64	*gcr3_tbl;	/* Guest CR3 table */
>>  	int	glx;		/* Number of levels for GCR3 table */
>>  	u32	pasid_cnt;	/* Track attached PASIDs */
>> +	u16	domid;		/* Per device domain ID */
> 
> It is minor, but per-table domain ID, not per device.
> 
> Same-gcr3 tables can always safely share the domain id.
> 
>> -static void __domain_flush_pages(struct protection_domain *domain,
>> +static int domain_flush_pages_v2(struct protection_domain *pdom,
>>  				 u64 address, size_t size)
>>  {
>>  	struct iommu_dev_data *dev_data;
>>  	struct iommu_cmd cmd;
>> -	int ret = 0, i;
>> -	ioasid_t pasid = IOMMU_NO_PASID;
>> -	bool gn = false;
>> +	int ret = 0;
>>  
>> -	if (pdom_is_v2_pgtbl_mode(domain))
>> -		gn = true;
>> +	list_for_each_entry(dev_data, &pdom->dev_list, list) {
> 
> Suggest a future patch to add
> 
> lockdep_assert_held(&pdom->lock);

Ack. I have added it in my TODO list.

-Vasant

> 
> To all functions touching dev_list.. That locking is a bit obscure.
> Also, I'm not sure using a spinlock with such a wide scope makes
> sense. :|
> 
> Jason
