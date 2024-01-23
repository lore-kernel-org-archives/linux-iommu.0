Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD89FBFA
	for <iommu@lists.linux.dev>; Tue, 23 Jan 2024 05:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705987642; cv=fail; b=LEYty7ZvmXNHrTIt2aL1l9TeRM6BgYJvtY0JH3Gy8KNLyHVnF9uRvTI+jZegOCxaPRoB6ncUQ/vUdQOZYPVZRB79pHVxuuzD9P6h9MdWzorlYriC0pkzvF1GxmbJC4wDGKAMqLrnnwdn9FZzqhJm0ez6rQBu/TsTBynouht1CA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705987642; c=relaxed/simple;
	bh=ANLpZyf7xVcZCMwPmj5rU18+F2VPkW96q9bUsi/PQx4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HP0ldb/HQ/FE43KEWJWLsQXqsOR3eCdNe8Hjz+JYIcRkePWabjRVZkQ4eCJ7BH93CQ4wyPo4oO7db6UiWQHUaHjiANp+V/UnewrJw/D3PtlAYz52RAXUnOt1cbPZgJV5vIcK5/Q7X+SV/LNEgnEPhSs2+LSaPG+8yFLosTlwMdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Fx1uOC8J; arc=fail smtp.client-ip=40.107.94.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Fx1uOC8J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IzkNhMfCnEtM9ZavtRsaA9J2l7N34reVg41nwz75R3KiLUrbfdb5Q3lGK1602FmnNKelbJTUq1blD1o4sh0WCVibBCd94rayCCjU8DgP0q4FdhHy8XdVOr/+Q4qV07SIluP+BX+cMMKpHUy5YcT43q+qHVbso7DHxnYHKu7f8qxmpF0ZJa7sPiW5ynoHn76mFcw8/s1a0W5OnMF75QFMB8WyozaJpZtEQVoJv9iXVn10gF+eXmTQNao1m8HAoSlYVba+CHuHqONN+GeV+FaRgRqey8POwHk9Sz0Xiwbvju30+HN9/+oFoxig+rHsYYpLEVmvBftSmuXLVQkPDbZSBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3KAP3if/FXtNpCEL9HCJOOPGmMA//zgXL7x0LY+ZstE=;
 b=Ppb3b46FlZNTF+d3CAF3Yaa26iWNSwC9ytLbUEImCMsdnybM4qyePl+pshDmh4jh/THTiNJhFpxlMfEhHuCjOeUS34yMf9+YfJXPtSvinRb4jRLM4VcV077x2YfMyKJOd0zXGbQL8bQ3kH2WYL2nw/PAyqccZOYDlLSVBZe8khWs3n1Gpj42qKsbRnf3yDKGjemGFAz5YYrY0osCAQRe1dwXE9DPLviVlBGX9w+S9MJglRRyvpq8aejIoEXwen4swyRJ1ccAwD443DPbMf1G9MNdW2FkJ3S9FDzmzO/sBE9zQaT7YA85Vlw/DFRka+Lk2czc+MWBXag+Cq8Ywhji+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3KAP3if/FXtNpCEL9HCJOOPGmMA//zgXL7x0LY+ZstE=;
 b=Fx1uOC8Jlr8US04l5xR8GLED1UODTsvC0Ou2vXW7AAjTSvCXxmpl7w/Z3+csovM9plhQ/SjzMIhW4t1r64akrXyGcEq4NwHbRq7/BvXbTUc20RK+U/uR+RwW1YLnH7Ry1mg5wpP/rXBVW95misjr/7YHm3grksH3k5r5fCtC65s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DM4PR12MB5723.namprd12.prod.outlook.com (2603:10b6:8:5e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.32; Tue, 23 Jan 2024 05:27:18 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb%2]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 05:27:18 +0000
Message-ID: <a28435a1-509d-015d-bce4-563a6c20c59b@amd.com>
Date: Tue, 23 Jan 2024 10:57:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v5 10/17] iommu: Introduce iommu_group_mutex_assert()
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20240116165335.6043-1-vasant.hegde@amd.com>
 <20240116165335.6043-11-vasant.hegde@amd.com>
 <20240119190955.GM50608@ziepe.ca>
 <c5be6a3f-bb45-58b1-a832-82c140299ac3@amd.com>
 <20240122180009.GO50608@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240122180009.GO50608@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0068.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::13) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DM4PR12MB5723:EE_
X-MS-Office365-Filtering-Correlation-Id: e0445e3d-4022-4499-202b-08dc1bd3f6f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MOilSR3tGMCh1q6VyhddDy+UphwEDB5NaRODvxLV2BHdqYGytb7wNVBO9NrXiFWdCUBfMtHZAYGmM5MpoWntEqc6MRVzre310wr881ZmYxQViC0EdVP1I1Wq/Tyhuy/rbFnwlKpsawTInBgHggHYhMPHgYCx3S9NrvJRJE2FEaKCmcOyYPP3YtO1mQi1QFf7VYyaUXo109NBIQSU1sl8K+jtgskD5z4jx4AhunJGxa1D1alNhiyplBsrEyHRJrqX2HyJovgG32WnBzG/eQzLrevdr+wordQkIBkCYbtWQZlLoW36gJq08pzhxUwO00/erpYQ/FQ4LwMu8uihw0zbuxatUT8bjBi6G0WyGyDq1oWXAWC8J6xFxxBH6V51zHAEGJI36icSYKxYamyoiyogMF4ZE1YXdNw2KZaFGfZSJWF4EFfyanVp1Z8nX6HmB0SVc70cfcrUV89cck4cV8rlrdgcAR4fhNUnKomYo/cQ1/aRYj6Xx9X43N7k3rr4LKmCs62bu6UGfUduRfiwN3dEPtuxRvvu6Vyq8dj0/BBb6LEd5mmhtopZLVOf7h4wZhRJgaH/txl+KuzDwpHV8tlUUKoVi0YCEV3wGZXhSGyOww06LidqfTX3E24Lq4XCbIo1xqMeRCQLkD3vrjQ0556VMg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(39860400002)(396003)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(5660300002)(38100700002)(6512007)(478600001)(36756003)(41300700001)(86362001)(31696002)(83380400001)(8676002)(8936002)(6506007)(4326008)(66556008)(6666004)(316002)(66946007)(2906002)(6916009)(26005)(6486002)(66476007)(2616005)(44832011)(53546011)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MEpocjF0RjF4allQd2tjdHUxaXIzMU5sUlR2cVFQMEZadkNtK1IyL1hadWkx?=
 =?utf-8?B?RWVkMmovWjc2VlNtbHpic3NZd25NZlp4OU9MZmdwWGZFdlJRWkI2RnAyUG1a?=
 =?utf-8?B?cmlwVmtmSEErTms0Wll1bFVhVEJ0Mm5OZHVac3V2MDFGTVNGcHkxaWRqTnBE?=
 =?utf-8?B?WWhjUkFFcjRYendSdmdFV212akVjRG1OcnB6UUVXMlJDQXF5OVZ5RFFnSjBT?=
 =?utf-8?B?bnEybnF1QzVGc253S1RocUNVMGVSRVhtak0ycDZzWTMyT0l5VUMrTHllalhy?=
 =?utf-8?B?RFN1bnliMk9xUTc0YWpLY2N2ZEpjbDlxRXRtSGNhd1NoV0FXVkxBRFJqbnVG?=
 =?utf-8?B?YyttQ0FVVlpqN0ExNEhWS1dLVHpDa1VrdGszTWV4UXIrMXFHNHlXakZYb0hq?=
 =?utf-8?B?UUIwbXhkd3dzeU9hZyt2RGVqU0owQ0kyenY2bEZQeEYzVlY0ZHVKanF4L1hp?=
 =?utf-8?B?dnBFMXZEUWNUTkhGOEtUMWFtdSt0aEN1bzN0d2RXNVZPaDZSV3R0clA1RDZJ?=
 =?utf-8?B?QkhGZ0h6OTd5bnRQekhHcHJJZ2JKT3ZNd0Q5K0ZicytTemxRUXVlTHYyOVJl?=
 =?utf-8?B?aFZiS2VrRTYxTFBDanNwOWVZRmRLdFpvR2VuWnFxdVlnNzZLR0JOQ2RoMmxo?=
 =?utf-8?B?dkJFczBkbE9YbHVBdk1Fb2gzdlhPS0R0cmMzYjRkRHNpQVhWWFRYRGxFQ0x5?=
 =?utf-8?B?akFIOGFsdkFWMTZHUVdNUTNpYkJoQ3N2U2dOWnZoTk9XcDBpWTlxa2FtaitG?=
 =?utf-8?B?MjdnZ3RBeThlaHhscjg5REtnckhCNS8ydEFvRHNXWHRVTWorditZRXNpOEJ5?=
 =?utf-8?B?ek5DSGlBNS9VN3laWnQrUm5FaUtMU2R4Nkd6bGkrRDNHNnJ3Wk9NdU9Qd0VG?=
 =?utf-8?B?Q1AvSGN6a3BxT2o5c1MzMGc0TUxDMTM1K0gvekRFaWM0YTc0TTJmVXduL0Zm?=
 =?utf-8?B?SmRzcGEyNmhaa1d5dWtpMzE2UEpxa01zR0lCZTVuWW1KZzJzeDNRejBVa1U1?=
 =?utf-8?B?QUNBeStXNHFtdThRMml3Mk9taHk0WndKOHZaWFdGRlZOOGlBd3Nwa3IvcC9Z?=
 =?utf-8?B?dDJGTUJ5elB3YmZ2TS9pWVR2M2RYT0R6aWZ3SDNwZHZraVJ1Y2VmMlVoQVRD?=
 =?utf-8?B?UHBHZm5iemZrZTNpYlkxNy9wWlRRWlpmelM0RnREdDlaVFFvS1JsNTR5cHdR?=
 =?utf-8?B?MmpzZkpKYlRMT3BmR3dqd2kvQmhhS0I2ZW9OZjdIN0lxbUxXcDNTaHhRUTlP?=
 =?utf-8?B?YWF1WjZOcVN1K2F1RllHWFdTMzZKb2h4YTluZnpTUjZkSW5uOHdKSnZTYmRw?=
 =?utf-8?B?WVZyL2dvNHY1VHJkQlBpSVZReXBRU3BZWHBiZ3JLM2VacEdSSGtuMXUrb1Ru?=
 =?utf-8?B?cnZJcDdNWXFIRUJWUTQ4SWZzVlFESWZKd1Y3YktSemh4SkE2SktmRVBOTGtw?=
 =?utf-8?B?NXU0OTZ0VDNuUmNIRklLQkVsQzh1N3NUNUk2N3JnYnExZU9tdzZUcnpOSnE3?=
 =?utf-8?B?MnBQSnVyS2p1RmhvdjBGVVhGVlhrU1d5NHRIQ2tTNmhBYUNoYnYrRDFBS3Zh?=
 =?utf-8?B?RFNEaWJXblBGVitVNlBFT2VJY1JHVkxtU3lpdS9Rakw2NE5Kc0VsTEpWaGsv?=
 =?utf-8?B?d2F6eGpNU3puTk9zS3VkUlI0MHlUYjZSa01NWTVPTnphZzc3VTRLVVR4T3gy?=
 =?utf-8?B?d3g3TzgvYVptdGJOK0xZbmhuWGJaTmpub3oxSXVRcG0rM0N3eXdyaWFFeDc3?=
 =?utf-8?B?QWMreThCbDVadWhHRGtRK2lFNEttNzNGbERQa1RmMEpkWlZwRlgzWjY1S1Bz?=
 =?utf-8?B?NUE0OW9oNjhzallIb3B4ZWFRRElIYmtCTlJkL1JxRGZTRm5ocDlHRVZxTlc1?=
 =?utf-8?B?eFZKekJtcklGUm1wQjN2aWlUWExNTWNIM2ZmT2RjZWdIYzU0cjkvRHlheWY2?=
 =?utf-8?B?WnlubE9nVXFjL2N3MEFBL2FuVWxMK0JDN0ZuQ1p5OWo5bDl6NFBlM2ROa3BQ?=
 =?utf-8?B?aUxQTnpEajRjekFGV1BKM2tIVTIrdEkrM3pDSzlHdkxpNHlhSGtRZFpwcG53?=
 =?utf-8?B?aDBFYk9MWUxYVEcvdDBjZHNuVWRaTThmbGZ6QzlFbFBFeDNjL2wyUk9CcTc2?=
 =?utf-8?Q?1qv13+a0Clxso1JBzxCT0Afvf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0445e3d-4022-4499-202b-08dc1bd3f6f3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 05:27:17.9223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WFdpROXokrFMp+U+7K3bmVn7B37P6YoRmPpEKIkwbrSF7uqYgIzepgDs8sgEK5soNHwSCnLTgNGLRvG7Jo+j2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5723



On 1/22/2024 11:30 PM, Jason Gunthorpe wrote:
> On Mon, Jan 22, 2024 at 11:54:39AM +0530, Vasant Hegde wrote:
>> Jason,
>>
>>
>> On 1/20/2024 12:39 AM, Jason Gunthorpe wrote:
>>> On Tue, Jan 16, 2024 at 04:53:28PM +0000, Vasant Hegde wrote:
>>>
>>>> +/**
>>>> + * iommu_group_mutex_assert - Check device group mutex lock
>>>> + * @dev: the device that has group param set
>>>> + *
>>>> + * This function is called by an iommu driver to check whether it holds
>>>> + * group mutex lock for the given device or not.
>>>> + *
>>>> + * Note that this function must be called after device group param is set.
>>>> + */
>>>> +void iommu_group_mutex_assert(struct device *dev)
>>>> +{
>>>> +	struct iommu_group *group = dev->iommu_group;
>>>> +
>>>> +	lockdep_assert_held(&group->mutex);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(iommu_group_mutex_assert);
>>>> +
>>>>  static struct device *iommu_group_first_dev(struct iommu_group *group)
>>>>  {
>>>>  	lockdep_assert_held(&group->mutex);
>>>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>>>> index 7f6342bc71c3..c983b6a1ebce 100644
>>>> --- a/include/linux/iommu.h
>>>> +++ b/include/linux/iommu.h
>>>> @@ -751,6 +751,7 @@ extern int iommu_group_set_name(struct iommu_group *group, const char *name);
>>>>  extern int iommu_group_add_device(struct iommu_group *group,
>>>>  				  struct device *dev);
>>>>  extern void iommu_group_remove_device(struct device *dev);
>>>> +extern void iommu_group_mutex_assert(struct device *dev);
>>>
>>> This shouldn't be unconditional. Like this outside the other ifdefs:
>>>
>>> #if IS_ENABLED(CONFIG_LOCKDEP) && IS_ENABLED(CONFIG_IOMMU)
>>
>> This is already covered by `CONFIG_IOMMU_API` check.
>> Also lockdep_assert_held() is already covered by LOCKDEP config check in
>> lockdep.h file.
>>
>> So I think another explicit check in redundant.
>>
>> Is there  any other reason to have explicit check?
> 
> We don't want the out of line function call overhead even when lockdep
> is not turned on.
> 
> The point is that without lockdep the inline stub should be the
> only thing present and the compiler simply does nothing at all.
> 
> What you have here will generate an function call and a stack frame
> push to do nothing.
> 

Ok. Will fix it.

-Vasant

