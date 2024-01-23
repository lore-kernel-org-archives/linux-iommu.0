Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1090956B83
	for <iommu@lists.linux.dev>; Tue, 23 Jan 2024 08:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706000105; cv=fail; b=F92HTadO7ziyG/sHA8/K9r19kKy0Tg/I6imv2BH3VCSqp8IWTxuEo+KVg4+m0JPmdD/5ogS3ty0Rmj6xVGtsrhogZ47dLtlf6iwwcgClPQkYiXpINntiMkvsJsVkElu5fVTsoUw6KsNIQ8Q2EXJ39FhKxkKGXejw0tVaodxYYVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706000105; c=relaxed/simple;
	bh=GJnvVJitIXdT7ZMWLj6Gsdz79Jd3KtWO56vuLbaTpIg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nROFQTx9y566SvPRfzQJLWHnCjeYa68Sym1hC0RLjp7+OuHA8Z+P+rPXmKXgTA0WnvLxlEpv1jthMCzF8+EzFSEuK3yDcXFojIBc4BBXk2CaD6Fw1qAg4tHnPfHvm9sMiHWyrRZCkJqoqDElA0Z5fy7bExFej5p9drVCtC8yl6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OWlFWv3f; arc=fail smtp.client-ip=40.107.237.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OWlFWv3f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XSNHhxpEIACzIp70qIpnHVx8xCodZDfLUyUxk8L4hB9lnVKRAbPCdJq1VV3nTWp10As9mjweANnR3tgKlOgY4LhvBGZEfi3Z33EhulbjhYuLBV0sgZ6o9l4BUm4616cuzEdeoKIsTN5urXMGwSMG0z4XhKOmC6sDh2jhgbFqPwwnqhodpbYybSwIlRgox2etKO1D2ChG6R4DrEPBUPA45csR8o99sh69jcXLzIt6xDpZePw5uJ/W7LoQv0OdQ8jtPH8i/DAi2ZyPmXz+RIJXJhCLF4GaJEx5IluZauLVGLW8Igk5nTYII78sqZWytjrI4RyRPGMGfzux4CxWorI3lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uAjoP5dRCEhejN2l6M1DgRcaQB65EPTa6xSmITqBUHQ=;
 b=U8R9p+plC3jYSDuQwBCEQH+MMG6A4EdtJnKbP9N3s1X6d2Eo074+dG6Abibhq/y5bxY0hSSntAjOxU3inKlFM3uq5uJqs73VTtmA6EL/u4oaa641rcN4ucirNHbpiaXVzxznTogfL+PE1Jd/eG4K4OW4zeo3CVCtgC/tWN+L9mEY0h0VPq0vyGC17uCFPUO7TWTgWQxhZG0B8EqR3CTYpgwKtkrnakh5uvz3Cqj7bI58FVxfdRGF1IWoFVzisO4JXifljx1RD4ebU5Mhle5OjJZyHWRLNNy0eS5iasiKTRbfHecc2+SsBC7W+13HsHW98gBPL8KMSzd8hGQIKVANhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uAjoP5dRCEhejN2l6M1DgRcaQB65EPTa6xSmITqBUHQ=;
 b=OWlFWv3fbYR9LVXIO0xc+jthoSa0V50+tdC1gYlkbDY6pGgucT+wu7Za75F9fhmKTcdj47Tfs/kmbNee9MmF/zUrs7vaRpOWN0Ax2JNfglsKyO4cFhTzsOL93I2saQiWl+7d2e6Ece4BX/o8HbLVpdqJeQCh1nnJKcluWU9TqlM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 LV2PR12MB5750.namprd12.prod.outlook.com (2603:10b6:408:17e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.22; Tue, 23 Jan 2024 08:54:59 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb%2]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 08:54:59 +0000
Message-ID: <c60ed34e-063a-b9fb-9255-365d3662f076@amd.com>
Date: Tue, 23 Jan 2024 14:24:51 +0530
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
 <e8f2c380-acb9-bafa-c2b5-5445c0f06a4e@amd.com>
 <20240122182607.GP50608@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240122182607.GP50608@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0106.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::21) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|LV2PR12MB5750:EE_
X-MS-Office365-Filtering-Correlation-Id: bb43a503-514f-436d-531a-08dc1bf0faae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XeSpINj7oqBdZUf1qyzXNZb6TZY//JFapPFX4etGqr+nmvLuBqPteCoLtW2WENytFWFzNS9zN5kWkJ0ShkUOk7Y6pVvzdZrHeTOLNhUF+EPUIdrgFQhvlKWIJyDvYi06uHGKLvs4O29AI8bXH2pXHDFGq1Y7uJU6Cca/PsCcAJVhrwGMgep2LPcSARpbdSDwbs+OTpaq3cvJImEHZuKhHqlbJGuuzHVVy5OD2u1oUISECCutGF8bzqTvVDRDrx+bDTNhiSrpkP0sFGdhMsBEeyPmQsah4uBAMMEM4jX5pnYyFc5kvv97UwHHM3tu0HuDvPCnWCcF3xXsGTxUL2/L6Ul3uXl79vfxm0nHss172X/WW9CSlv2pg5a+iFmeRbEAvwCDTum76o97IJJD1nUflUhaJ7e5EgtqzgQziq1FFpvVqEoyNWdZmQL5I/ryGUj69XTwvsxd9Ad9V94i/yv/1c5DKyIDggo/3QmiMQ9ZyC3oqPq9bOSTVq2xbKY+1mH1uUyEvtrrlzFM30zXUG4R2yWNmZCWKG4BmO0egeV5nqSgtGEgnGjCkel+yrmh6M2EhJw6PbksH+ThUPhyfLSslSMJ4DpVApOdzQL8G3+lUL674U1gDAA60Z/dpNovbhcZnt1KvST1UPnGbPocHUpStQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(136003)(39860400002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(66899024)(6666004)(6506007)(6512007)(53546011)(26005)(2616005)(31696002)(86362001)(38100700002)(36756003)(41300700001)(2906002)(44832011)(478600001)(83380400001)(5660300002)(8936002)(8676002)(4326008)(66556008)(66946007)(316002)(6486002)(66476007)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmxxc0U2cXdVNWtuOTdqNE95RHN1d1pnbVAvY0ppVk02K21xSW4vUiswQWE5?=
 =?utf-8?B?QjYrUXJaMUlqUXlhdkRHeHJERHdpdHdJUFd0ZDY2T2JYbENKYXBRU0oyYkFw?=
 =?utf-8?B?bFQ1UFgrSE9mVFdWZFV1ZzhCZTh0RFFKTFVKVGg4KzlHVkR3K1h2SThQTjcr?=
 =?utf-8?B?V1NRVUNMRWxMR1pJZjNwY0ZIS0QzMWVQNlo3Ulc4cGRKQ1NjUmtTMVUyZTdi?=
 =?utf-8?B?RURSNm4zOU5SODVqWjh2QzMrNnUzb3BZZlFsRzZYQ1dwR2RQdUNWZGRnVEtj?=
 =?utf-8?B?STR1WVFEN2VMUHFvbDRXeW5kVjZ4ZjNRRmcyNVdEUnppZEF1c1ZxS2t2eGtV?=
 =?utf-8?B?bW8wY1V0dUsrMDk1U05VdmFtTUs3Tm1JMURrYVZRVkFBTWlNMmFBdnR4ODk1?=
 =?utf-8?B?SU8wc1BoYXBXSlFjcytrUFNLazNZYUxDb09Bdlh1clJwRVRCVWxOU1RXK0VQ?=
 =?utf-8?B?eXpXVk9VTGpickdOVkw1WTg5bm5XVGVhbmZpdGtJcVpvVmRMT2VCVnMyQVBO?=
 =?utf-8?B?N3duQ3hjUUZWd1ZMWFZsRVdvamdRVlNXSjhmNzhTTVVOSFROOVZhMTJ5ekRK?=
 =?utf-8?B?Z1QrcERZQjZ5eTd5R1FycVNrY2J6VnJqRmJqaUdtSUs3VjBZQ094Mzg3dTVk?=
 =?utf-8?B?Q2lGczk5d1FkSVBQNUpEbTdndXVUSW5naHJ3MnpkQUtaVTdZVnFSSTJmcHBJ?=
 =?utf-8?B?WHY5clVVQUZRNEZjUEJSYTM2cjlyNkFCMXdoQytOUTMwOHArMm03ZGRxTkxu?=
 =?utf-8?B?TWRKSDJTWDRDL09BVll0VU0zTlYxdkE2S3p4Mm56dGEveGhmNjMxckRWYUwx?=
 =?utf-8?B?aDdzdnY3ckVwci83R2thYW9IdXlTZE4rL2JoZHYxNElRMUpqQ3dDWmpRUGdY?=
 =?utf-8?B?MGszZFJKbmFSSU5lWEk1dEFuUmVLb1Ayb3RNR3E5d09hR3pialJDaGtpbDJX?=
 =?utf-8?B?MHFOSTdDcU5BYkFsSkgxblJzbjJucDFoNEFKZHZQQ0djbXFxS2I2ZVdTc0Vm?=
 =?utf-8?B?M0YzN0s0TFZMN2JNZUovUEl4SnoydS9sQ2l0U3RnZjFHVzFZWWd2eUF6NW1J?=
 =?utf-8?B?QjdVZlBMTk1uc3c1OHZZdWNTWndkYkJjeUZySXVGSkJVYzJPOG1vYngrQ0Zu?=
 =?utf-8?B?T3BnQUlNVTRDeUFLcU1MODJCRnM2MHAxdjRpRUlOaE1xbmxtdmxNWU5PYTVu?=
 =?utf-8?B?eG4wQWRwZzg5OXJTNExsWG5rcHZFdHNkemwrZ1MwNzV0VGZ4VlRmSEQ3OVR4?=
 =?utf-8?B?VHpoM2lqUEZVSWVrUzBXeFV6OEJKeWZ0MS9zSkNrN1IxcVNoQW9qY3FMbVps?=
 =?utf-8?B?djM5a3kyUW1Qa3JYRUdNNVVNNEFIeHBCU3VpenZOc2dOUFJicmYwQXFNM2N0?=
 =?utf-8?B?ekcvYWRvTWFKSDU3NC9YckRteWV0MUFsOXdaWVV6ZEd1QlNKaDh2T3FzaDQr?=
 =?utf-8?B?MGhlRzVBVEZHOXExUWs4dFBzYW9MSGYwTWhWZzRQckxWTnJNUlk4VXN6RUQx?=
 =?utf-8?B?Qlgzd1RyZU1IZnhvS09VclNkbVVjaGVxTHZYdkl3U3ZTM2pFOEdUaXc5U1d4?=
 =?utf-8?B?dzIyanFxb2JDb0lJcDZnbis2MnhzTEpnZ293RHFYQTVMbXdxbFl3UnpwQzJu?=
 =?utf-8?B?dXZlWVRtakVKT2lUb080Uy9vbS95OWRKRkZiYzNnbFJiK3V6SkNvcWlSVWNE?=
 =?utf-8?B?TDFickliZ3kvd2JvNzBidjZDcllWazFKQ2s1Z0l5NW1BdlBlNGZDbTRGUVNG?=
 =?utf-8?B?c2NpaXdGMFJHSEhTYUtpd2ZRUk5NN1VHTkgrd2VCYlV6RnI0L1NIN3lpVzRE?=
 =?utf-8?B?c3dmcENjUmMrNXpFV0VjZjhqY2hrTDM0ZEpuOFpaZFlreFlVV2ptUjgwMXZZ?=
 =?utf-8?B?SGVVQjJqQm9GZmY1a0pQRnNDZDdmd1kyNmhnSXJPZUVuMjNPdjRLNlZKMW5J?=
 =?utf-8?B?TG1nR3dnRTEwTXFqVDMzc2o2TGl6TEc0dHptN2NRbXZiSHhQUzYvWDhvM2lJ?=
 =?utf-8?B?S1I5TGtyczJpTnc0Q0VnOTRhYXpPSW5nZjZuRWdjU0g5N0dIeVNVQVJZOVU5?=
 =?utf-8?B?dGZpMVV6eENiUFhQOFB4b3Vsa2xsUjV1THBsQk1ReENZVEVNWEdMcjlTRURZ?=
 =?utf-8?Q?3H21fu+8BUOBkCKk1SI0trShr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb43a503-514f-436d-531a-08dc1bf0faae
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 08:54:59.4821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RvIpenJiExYE6e0b6teA1WaRXDbaRayDlYTVVOvu0kqOUCcbPqm6ltNmdoLcnTWGwJWNpzkPIInnVyWaLDipNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5750



On 1/22/2024 11:56 PM, Jason Gunthorpe wrote:
> On Mon, Jan 22, 2024 at 03:53:18PM +0530, Vasant Hegde wrote:
>> Jason,
>>
>>
>> On 1/20/2024 1:29 AM, Jason Gunthorpe wrote:
>>> On Tue, Jan 16, 2024 at 04:53:32PM +0000, Vasant Hegde wrote:
>>>
>>>> @@ -1738,22 +1744,22 @@ static int get_gcr3_levels(int pasids)
>>>>  	return levels ? (DIV_ROUND_UP(levels, 9) - 1) : levels;
>>>>  }
>>>>  
>>>> -/* Note: This function expects iommu_domain->lock to be held prior calling the function. */
>>>> -static int setup_gcr3_table(struct protection_domain *domain, int pasids)
>>>> +static int setup_gcr3_table(struct gcr3_tbl_info *gcr3_info,
>>>> +			    int nid, int pasids)
>>>>  {
>>>>  	int levels = get_gcr3_levels(pasids);
>>>>  
>>>>  	if (levels > amd_iommu_max_glx_val)
>>>>  		return -EINVAL;
>>>>  
>>>> -	domain->gcr3_tbl = alloc_pgtable_page(domain->nid, GFP_ATOMIC);
>>>> -	if (domain->gcr3_tbl == NULL)
>>>> -		return -ENOMEM;
>>>> +	if (gcr3_info->gcr3_tbl)
>>>> +		return -EBUSY;
>>>>  
>>>> -	domain->glx      = levels;
>>>> -	domain->flags   |= PD_IOMMUV2_MASK;
>>>> +	gcr3_info->gcr3_tbl = alloc_pgtable_page(nid, GFP_KERNEL);
>>>> +	if (gcr3_info->gcr3_tbl == NULL)
>>>> +		return -ENOMEM;
>>>>  
>>>> -	amd_iommu_domain_update(domain);
>>>> +	gcr3_info->glx = levels;
>>>
>>> I think this patch should also move the domain_id
>>> allocation/deallocation into setup_gcr3_table()/free_gcr3_table()
>>
>> We do domain allocation in device attach path only. But GCR3 table
>> allocation/setup can happen while enabling SVA (like passthrough -> SVA path).
>> Hence I have kept it in attach() path itself.
> 
> Huh? That doesn't sound right. Any time you install a GCR3 table into
> a DTE you need to get a domain_id *for that GCR3 table*. There is no
> other place to get a domain id!?

Its already fixed. If its per-device-domain-ID it comes from dev_data/gcr3_info.
Else it will come from protection_domain->domain_id.

domain_id_is_per_dev() decides how to allocate domain ID. Right now for V2 and
pass through mode we allocate per-device-domain-ID as they can switch to SVA.



> 
> All this logic should be shared between the pasid and rid attach
> paths.>
> The passthrough thing is only an issue of DTE construction.
> 
> If you build a DTE with a GCR3 table and RID=IDENTITY then you set
> some bits, and that is it. Detect that case directly when you build
> the DTE. It should have no effect on what domain ID is used to tag
> translations retrived from a GCR3 table.

We build DTE as soon as we attach device to domain.

Now moving domain ID allocation to setup_gcr3_table complicates things.
  - In attach_device() path we want to allocate domain ID but not GCR3 table
    We can allocate GCR3 table, but if we don't use it its waste of memory.
  - In SVA enablement path we want to allocate GCR3 table
    But by then domain ID should have been allocated. We don't want to allocate
another domain_ID and change ID in SVA enablement path as our domain ID is not
specific to GCR3.



> 
> (I say that with some trepidation because it isn't clear to me how the
> AMD IOMMU caches the DTE entries themselves)
> 
> I've said before the DTE construction should be fixed up before making
> things more complicated :\

We are not making anything complicated here!

> 
>>> It is missing some error handling too
>>
>> Where?
> 
> See my diff I sent, it was error unwinds around gcr3 table failure.

Ok.

>  
>>> And domain_id_is_per_dev() is pretty redundant once you do that. See below
>>
>> We need to handle passthrough as well. It doesn't make sense to allocate and
>> keep GCR3 table when we are not going to use it.
> 
> Then don't, and my diff didn't - but check for the passthrough case
> directly against the attached domain as identity.


We don't want to add condition check that depends on code path:
  like attach_device : allocate domain ID but not GCR3
  SVA path : Allocate GCR3 but not domain ID.

-Vasant


> 
>>> @@ -1902,7 +1911,7 @@ static void set_dte_entry(struct amd_iommu *iommu,
>>>  	struct dev_table_entry *dev_table = get_dev_table(iommu);
>>>  	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
>>>  
>>> -	if (domain_id_is_per_dev(domain))
>>> +	if (gcr3_info && gcr3_info->gcr3_tbl) {
>>>  		domid = dev_data->gcr3_info.domid;
>>>  	else
>>>  		domid = domain->id;
> 
> Because here it already has the (gcr3_info && gcr3_info->gcr3_tbl)
> test below to decide if the gcr3 will be written to the DTE, so of
> course it should be the same test to decide where the domain id comes
> from.
> 
>>> @@ -2018,15 +2027,10 @@ static int do_attach(struct iommu_dev_data *dev_data,
>>>  	domain->dev_iommu[iommu->index] += 1;
>>>  	domain->dev_cnt                 += 1;
>>>  
>>> -	/* Allocate per device domain ID */
>>> -	if (domain_id_is_per_dev(domain))
>>> -		dev_data->gcr3_info.domid = domain_id_alloc();
>>> -
> 
> And this gets moved into this test:
> 
>>>  	/* Init GCR3 table and update device table */
>>>  	if (domain->pd_mode == PD_MODE_V2) {
> 
> Here, which is obviously correct at this point as you only need a GCR3
> table when installing a V2 table on the RID.
> 
>>> @@ -2073,10 +2077,6 @@ static void do_detach(struct iommu_dev_data *dev_data)
>>>  	/* decrease reference counters - needs to happen after the flushes */
>>>  	domain->dev_iommu[iommu->index] -= 1;
>>>  	domain->dev_cnt                 -= 1;
>>> -
>>> -	/* Free per device domain ID */
>>> -	if (domain_id_is_per_dev(domain))
>>> -		domain_id_free(dev_data->gcr3_info.domid);
> 
> And this got moved into the gcr3 free a few lines up that checked the
> pd_mode.
> 
> Jason
