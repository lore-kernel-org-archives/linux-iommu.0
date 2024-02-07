Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E0B20DCC
	for <iommu@lists.linux.dev>; Wed,  7 Feb 2024 09:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707298296; cv=fail; b=BVu/Njfg/fXV2pdmpIGLeaEuJk7JNr3owu32N5PLtZk52/pGu5RBHVhknZ4fZ7tjsxTZ/cueYnxx4A4UjRnBCRoKVVy45kH9SCdPd4HS2wNqdeWOJWsvyc1ffHhckyFOt6A1O4j+dLReVFFH6NkX3vA5Jd2qtf+jfKSq9y2X8qU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707298296; c=relaxed/simple;
	bh=RsR0oJRxo1HzsSRF0RzOEMKkwLlXYohc9flesXki0JE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dIsRTzLDkk/ZKaTjFadWNFyhh4bMzFtv7AvJaERvoPmrVBl33HRhAhoiX91AxKTpl3SvOJun88KUmi5AgsYQk3UqGdOJEInP5m4UGFOXKCw1/aS6umHZAjjswfeQaCpsAa0Fqbkul3SHUBo6+SkAMO8vEEggytITs7x8sdEZfbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a82U3C10; arc=fail smtp.client-ip=40.107.244.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a82U3C10"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lu6vWk0YrV262BsES25LLmVSMDPDcy7go/fmhFTCGUiWs3h+DRFWKWcN5fn1MJvdif04jjyozdioHaAfmJYC84XGxH2vvIxnAovgOhrdGsrkAFoWQMA0xDNSftWLYucflqrNJI553B1lxxATXB+E+a3SqVJC6VprbEB8ON8VzDqECrvPf+4XO6/5+Tx6xrIrLIw3rMkJs9/7UB1mX6Ek9M++zwdD3FAd/ZAnZFp5GG4WBQH44fiuWNpl6lCEw5MJJeOI6xyp4KLiFzee6ovzJL3KlG+Chn9wpY141o3ejX/NIzeAGssy2c9qiXQ7+CYxjB2u/cKBgM3AlvVGPL1zng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rEbEPFdnd7ga9I1qw7tVf9gy8nw+9FRJUqar3FMyczo=;
 b=D/D8CfPuGsYF/WdJMPdUPVnfE2AQgZyXtenl/iW6O2DYxZwnNVvie85BB30E2+9sz+8rCa9TtGqhwH2WhD8CW9L9K2Ww2EJTG9W36vYWUi2MoM02KMwOxY01aOX7+OYx26S0qP5asp1daIGQeV4y3sYDbzreuTwZ5xog1qThfxfWo4tVBwWSS4BPKTF+qHZQFlGgA0AT6B1VApKrho82Y5HJnB4xsPXd7qS9nMG+aa7DEjgBHcaqaBHb6NfvG6uWGqNNxSlImFo4GNdlvJU/rt7qn2Iz6n1NnLchIFVdaIDILB2VLS4+8P+nOe+rImK2IoPsQbpDUbFcDmo0QLufiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEbEPFdnd7ga9I1qw7tVf9gy8nw+9FRJUqar3FMyczo=;
 b=a82U3C107nZyDglBEsx847xVcYcf6Mvpf8Mat4b2vKlKY2S9LQ11spQuHbj/j0sp7bwU8/Zwib5nNheKxHfEMVITn6/mR8C4yRehHn8raFkMmzxkvQqk+kP0PrNeArgKlZC0rrBo0jnBe+LWYG/u5N3uIbBtIoOsLs9twwbt7mw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 IA0PR12MB7749.namprd12.prod.outlook.com (2603:10b6:208:432::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Wed, 7 Feb
 2024 09:31:31 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb%2]) with mapi id 15.20.7270.012; Wed, 7 Feb 2024
 09:31:30 +0000
Message-ID: <0af9b44f-c78a-7e79-5c10-fe8d6e92f5bc@amd.com>
Date: Wed, 7 Feb 2024 15:01:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v5 12/14] iommu/amd: Initial SVA support for AMD IOMMU
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20240118073339.6978-1-vasant.hegde@amd.com>
 <20240118073339.6978-13-vasant.hegde@amd.com>
 <20240202152524.GA2606743@ziepe.ca>
 <f36ea0af-23db-7653-32e0-0a7b3941f801@amd.com>
 <20240206173457.GH31743@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240206173457.GH31743@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0090.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::30) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|IA0PR12MB7749:EE_
X-MS-Office365-Filtering-Correlation-Id: fad6f201-ddcd-4622-3f27-08dc27bf90f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	onMcJPOjbsnkcqUy659ZunucHvsTaUnrKH3LFuYXUsCe2B3BRQWErVXInRtW1GBFBo6NILfciEPRqMmlgEyerbKXRcacnD1QGnlM0rcyfwNfxC7WgbEbxnQQA0nn89OPu8ghK3HYaydMTBGVg3KKjMPIGoObqeL4J9zyand4L0zuuhFqGtARCC1fvIg0KCA/v46hIX+59N6Ewi9DRoBOJ+Q5JWAs+qjG7Mu9Rk5JGxKfCv7zAeY5Moo/L0FMnZwX3dtlOoQfcSq0ae0TXXlLxGIdobqygEVK6X6/9iCnokXULTZFk5cX/sZwIGRXxsI73WBdnOm6HOFrYFvJ0WmCd29tvPvsP0HhtOlURJa9CzGgpjVCOicV/yRh8iMoUlQS31s8/T5QPlFxwvlgNL7a1w2RDtfv8zKNxv89SeSLKyN2cpga8fvTKbllIY+GXlFR5FTdqkCqhOsBSieZl1ol01sVscYRl4sVyBcgAZ24C/8WvrGJEI8eHpqA9Pvvmdri/ZVaBzc1e0aBzlj/JzdStL0kRwvRpfuGZjjLLqzM0pe+1rn08gVwc+009I3QH8vM0lhUUbuuIbrYlPMZJCI4P9vlWjaVQgl1M8RZr8B4nf+nYP6JK/9S0lpgVDjd2MJXH9hxLKHTGv661pWul/Cayg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(39860400002)(366004)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(38100700002)(31686004)(41300700001)(6506007)(6666004)(26005)(53546011)(2906002)(6512007)(83380400001)(36756003)(2616005)(6486002)(44832011)(5660300002)(66946007)(86362001)(66476007)(316002)(6916009)(66556008)(478600001)(8936002)(8676002)(4326008)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmRBSEF2RjJ5Tis3UzhONUVwcFZlNlZXYUhXYVhLakJDb05tRXZjbmhCeEE1?=
 =?utf-8?B?N0FQOTNDMnJzeFE1R3VybUc3SC9GOEtQQ2NkOWxNdCtJU0s4UTBtSUJxVlQw?=
 =?utf-8?B?bUZiYW83RTdlUkFmc2Y2VVZWejRHRW5vUmNaS3BPL09sdjZxaDgxV3pteWpi?=
 =?utf-8?B?N1JPLzZQeWVVR3JCb1hjbDkrQXNMdVgzTXVNOWJWdWxBbkpGakFuSllqTWll?=
 =?utf-8?B?ZDBoN1dDMEhjekpwVXlUSnJxbjZPeUJIamFpMkIrRURvcUV6eTVDcG5PUVg5?=
 =?utf-8?B?K21lM1FmZVg5eHU2b2dCc2pBVVdEeHN0SEhXVHRkay8xMVdnRzBzYnIvSitP?=
 =?utf-8?B?UlRjb0RTb3JOTGZHbzBXaHQyQXNGc1A2ZjJqNXk3dVRBMFpubzR2S1F1MGNT?=
 =?utf-8?B?aHkwdG50bEV2UjRnTjlMOWJDTXRvTUhXdzFXUnlZUjh4eG5hRVFBenFPMi9Y?=
 =?utf-8?B?Y0xBOERLUk54c3JVenluWW16WE9sQzRrRFJpMHFzNUxQdEw3Rkc0NHlaSzA5?=
 =?utf-8?B?dG9qUjVZUWwwN2xETCtlNkp3VkFxWkppbk5EaHlsL0ZJYnk0QjNQaFpteTBZ?=
 =?utf-8?B?NmFnak5iNTdNOGs1S0huRjBqK0ErOW9RaklwMmZ4VmRFNno4bExuUHhZc2dR?=
 =?utf-8?B?QU1WdnVFSzY4Yi9jZk8wTnM3TktVakpJWCtFbE1VV1c1Vk54WTZ3U1NkMkNm?=
 =?utf-8?B?ejVaQ2lpQ241V01JckdUU0NETXdGaCtBRmVZdkJES3VIWk5EY1Z0V212S3Bv?=
 =?utf-8?B?QkxuNUFSUDNBS3RGNGpmQXFXcGc3c3JTWlZDSW1SNGwyWEN0SjJqM0NCME8r?=
 =?utf-8?B?Mi9BTWZKU1NkY0UvMHRJZzNnNUNObzNSTjNkQ1ZRMk04bXUzTU0zOXpUbDZT?=
 =?utf-8?B?aCtPcEpPUC94SVJiQ05hWU1SbVhlbXArbHRlblp2bDlRcWJhczF6MVdvdzQw?=
 =?utf-8?B?SlYwclBNWExNR3UrU1p6YStlV0lGbERpb2ZsdlJTTmxFQ0ZBZGswVWVVS1Vv?=
 =?utf-8?B?OGhwWGJHRXlUN1VEUXRsL2pMUlJWblNrNnlYc29SMi8rTm5vcFJyMGdyY3F2?=
 =?utf-8?B?RkN0UlVPNDZmSkJCMUZJVGZlbytRaTRBeENoa2VxT2FaRFgxUWFwZm1vb2RJ?=
 =?utf-8?B?NFc5TnJ1dGhwRm5pR0pLV2ZnRzFTUk1LRFo1M0tQdWduTDZGMjNCV2R1Nnhx?=
 =?utf-8?B?amkxNVNCbkFtamVuTTgrVytCbkhKdTFRWE1NU1llQXBBTmJ2Y1VOcmMwVDFZ?=
 =?utf-8?B?SjA4TktSWm9sa0hLNzVuaEZFS0lXV2NrbVhSdkgyRlZqZEhQL3QzSUcrMVZ6?=
 =?utf-8?B?WVZ0Yk5VSzlRZmlpUS8yNVhxNFA0YTgzQjUyeHdOeHNSU0RFdkppZGhiSlVr?=
 =?utf-8?B?QU00TnpkL3NUZTdieDM3K2wyNU9WV2I0ZkxUVmxvU2hZUGFiUlArdlpIQ2tP?=
 =?utf-8?B?clV6d3NNL0hRUGdpcnZsb1R6S0JvTjlDYXgvUy9HeklhWVMwNTNUUWVUc3VT?=
 =?utf-8?B?elNmdUNNWkt1QTFGUFdvbFFicHJUQVlvNUlUckc5U1VGK2E0L2NsTnpJMkZL?=
 =?utf-8?B?RUE4MVhSZWQ5bW5LMU01WnRFL2QxdEJYUFlhNEt3VDl6UGt2cmRCM2p6MkRn?=
 =?utf-8?B?dXozVkV2VzA5b1ZVYmp2R1RkandMdVgrNkgyNmR4WnBJQXF3a3VuWWlZcGhT?=
 =?utf-8?B?WjYxVHdiT2lHQnVYWXc1OU5ySmUvMnBxRUNCNmxtamltMVJCV1ozeHNxeGpT?=
 =?utf-8?B?NVlFTytiRjB1a2dra3dJVVFldGFoc04zOGZ5ajlwUElMWVgvdnUrSTQ2MkY2?=
 =?utf-8?B?N1hoK1VlSStQVmtVcTdnckF4VUV3WndRUWdVMm5kNmlFTTZWUGpPdXJuTW5L?=
 =?utf-8?B?VEVjNXZtb2d1TkJGUVFXdWEwaVFkV29FWXdRVnZCU0U5b0xIYnQ2Z3V1dzVk?=
 =?utf-8?B?R2RhQkVqS3pHQ2N2WkJEdkpaSVNrTURrYTFZRWNoazBudGx2eUtRdURJSER2?=
 =?utf-8?B?dVcybXpuR0JEbUJKTklmUHJDSXgrNmY3S2dYS1Byak1wQitsaWp2bi9xODVY?=
 =?utf-8?B?ZlVoQ0lpSEQwdVUvcldOZkFOMEZGbUg4SlBRQzJ5KzJOczA4RzZqTmJONW9s?=
 =?utf-8?Q?Ix8qNrphk44ZJZsDlCG0S04Rd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fad6f201-ddcd-4622-3f27-08dc27bf90f4
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 09:31:30.7251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yYbBgYivIehDdCxNvWgD9oew6ONbcIZd7yFD4xVN1G6Tf1keYFW79tNBBHBp+kFi3B2jBG/x6UPq2J6AUvwAvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7749

Jason,


On 2/6/2024 11:04 PM, Jason Gunthorpe wrote:
> On Tue, Feb 06, 2024 at 10:46:58PM +0530, Vasant Hegde wrote:
>> Jason,
>>
>>
>> On 2/2/2024 8:55 PM, Jason Gunthorpe wrote:
>>> On Thu, Jan 18, 2024 at 07:33:37AM +0000, Vasant Hegde wrote:
>>>
>>>> +static int iommu_pasid_enable(struct iommu_dev_data *dev_data)
>>>> +{
>>>> +	struct device *dev = dev_data->dev;
>>>> +	int ret = 0;
>>>> +
>>>> +	spin_lock(&dev_data->lock);
>>>> +
>>>> +	if (is_pasid_enabled(dev_data))
>>>> +		goto out;
>>>> +
>>>> +	if (!amd_iommu_pasid_supported()) {
>>>> +		ret = -ENODEV;
>>>> +		goto out;
>>>> +	}
>>>> +
>>>> +	/* attach_device path enables device PASID feature */
>>>> +	if (!dev_data->pasid_enabled) {
>>>
>>> How many times are we testing for this? Just check if the gcr3 table
>>> is installed once
>>
>> One time for IOMMU capability (amd_iommu_pasid_supported()) and one time for
>> device capability.
> 
> Again I think this whole thing is out of sequence. The main focus
> should be on the gcr3 table. You should dirctly know if it has been
> installed or not via some direct means. Test all this stuff when you
> go to install it the first time.

We are doing 1 SVA domain : 1 PASID : N devices model. That means we need to
check all these things while attaching *first* PASID to device. (That's what we
had discussed sometime back when I had all these things in feature_enable(SVA)
path).

Ex: If device is in domain with V1 page table tries to attach PASID it should fail
   If device is in domain of PT mode, then we should setup gcr3.

So I don't see how we can infer these things unless we have something like
enable_feature(PASID).. which would have taken care of setting up things.


> 
>> is_pasid_enabled() is checked twice (once without lock, so that we can avoid
>> lock in most cases and one inside lock to be sure no one else entered and
>> enabled gcr3).
> 
> That never works, don't do that.
> 

It does work as second one is lock protected. And the intention was to avoid
locking for attaching second PASID onwards. Only for first time attaching PASID
to device we will have check for two times.


>>
>>>
>>>> +		ret = -EINVAL;
>>>> +		goto out;
>>>> +	}
>>>> +
>>>> +	ret = amd_iommu_gcr3_init(dev_data, dev->iommu->max_pasids);
>>>> +
>>>> +out:
>>>> +	spin_unlock(&dev_data->lock);
>>>> +	return ret;
>>>> +}
>>>
>>> This seems like too much, and it doesn't need to be in a function..
>>>
>>> 1) Check directly if the gcr3 table is installed otherwise try to
>>> install it. That might be a usefull function
>>
>> We need other checks to make sure both IOMMU and device is capable of PASID.
>> Hence its a separate function.
> 
> That should be done at probe time and cached in the per-device max
> pasid valid. It is 0 if there is no pasid support.

Ok. Yet another variable!

> 
>>> 2) Precompute the max pasids during device probe and store it in
>>> iommu_dev_data. Just check if PASID >= max_pasid and fail
>>
>> This is not required .. as set_dev_pasid() can directly check
>> dev->iommu->max_pasids.
> 
> That is not the same thing, dev->iommu->max_pasids is the PCI/DT
> capability only.

Its min of PCI device and corresponding IOMMU (see dev_iommu_get_max_pasids()).

> 
> The driver still has to keep its own internal limit.
> 
> It is goofy and we should probably merge the driver limit and the core
> limit at some point - until then it is better to follow the pattern
> and keep a driver limit in the driver, doing all the work at probe
> time not during attach.
> 
>>>> +static void remove_dev_pasid(struct pdom_dev_data *pdom_dev_data)
>>>> +{
>>>> +	/* Update GCR3 table and flush IOTLB */
>>>> +	amd_iommu_clear_gcr3(pdom_dev_data->dev_data, pdom_dev_data->pasid);
>>>
>>> This is in the wrong place, there is only one DTE/GCR3 remove_dev is
>>> touching. The list iteration below is just to clean up the tracking
>>> list it should not touch HW. Move this up into
>>> amd_iommu_remove_dev_pasid.
>>
>> This is used in remove_dev_pasid and sva_mn_release path.
>>
>> This just clears GCR3[pasid] entry. Its not updating DTE.
> 
> Same argument, it should not be iterating, there is only ever one.

We can have N device in same SVA domain. So we need to iterate to find the right
entry in the list. So the flow is :
   remove_dev_pasid()
	// iterate over dev_data_list to find dev/pasid combination
	// Update gcr3[pasid]
	// remove entry from the list

I can take out 'update gcr3[pasid]' from remove_dev_pasid() and put it in
sva_mn_release() and amd_iommu_remove_dev_pasid().. Just that its duplicate code!


> 
> The release path is not removing the PASID, it is just disabling the
> GCR3 entry. The domain is still logically connected to that PASID as
> far as everything else is concerned.

Right.. But for device side we need to clear the entry.

> 
>>> And these functions related to the tracking list should be more
>>> general and called in more places. Just the tracking list itself
>>> should have a few patches to create it and situate it generically in
>>> the driver. Even the RID should be using the same mechanism.
>>
>> That's after reworking protection domain structure. Not in this series.
> 
> :( I wish you'd get this stuff cleaned up properly first instead of
> building more mess on top of the wrong design.
>  
>>>> +	/* Setup GCR3 table */
>>>> +	ret = amd_iommu_set_gcr3(dev_data, pasid,
>>>> +				 iommu_virt_to_phys(domain->mm->pgd));
>>>> +	if (ret) {
>>>> +		kfree(pdom_dev_data);
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	spin_lock_irqsave(&sva_pdom->lock, flags);
>>>> +	list_add(&pdom_dev_data->list, &sva_pdom->dev_data_list);
>>>> +	spin_unlock_irqrestore(&sva_pdom->lock, flags);
>>>
>>> This doesn't seem right? The tracking list should be loaded before any
>>> change is made visible to the HW, or at least under the same lock.
>>
>> Ok. I can move that up and then have error handler path to remove it.
> 
> Because, like this shows, it is hard to get it all right and it is
> even harder when everything is not consistent and there are two
> versions of the same flows.

Ok.

-Vasant
