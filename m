Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1921A171A4
	for <iommu@lists.linux.dev>; Mon,  5 Feb 2024 10:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707128588; cv=fail; b=slkcUU7f6t5IXLhrASjV2idTbjZ0mxNTrjWzN8JZrVhDwMpMZId6vLKANNUv7RN7iYDPoT+QRtnU38QWIBWEOFSajIkDkYPMcoJi4Q4dqr3MTN8Dxalhl/L1tHMcFBlg5WU0RryTom+IAHaDFweo3/KWBa1kkgd21jhpulzsZZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707128588; c=relaxed/simple;
	bh=I7RGhEDwzJoFoLFd5cE5C23/C8wVJ+LwMSf4/ZSfxBk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T+MUqxYLZI9vz5+vN8O0yY6U531RzNyrm+SEPSOUBXd+ABiJx9ia7D4BR49JDRksRQplr/npJNN2dphQwgQ90hlJDTkepSEgQWAQf/vui1I5EWttFlBkbgUsed9hkSlHew22XRVmQLSJsIFLktZjFdf1nPaRT/eXyROxQj2wrOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RpkDI4O2; arc=fail smtp.client-ip=40.107.237.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RpkDI4O2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lqi19NgsSDB5gJ5f59n/xN+fJQ2OjQ6nwLYE3MuaQuMb2Hlb4lKreSyGhIN7lGvrL2Uq8ESTAgsiK0G3v1NLZUYP8/J8XqeCxVvXgvgZ7rpY9JKn/IYj/3rIFr5elVf+0KTfK8xEhkKwE3osgbKWFGr3uQQMpD2WKForkB3zDFGcRNN/o2lT65guDPa8py1TGqK+1YCg1KPIf02JfrjhQNb+UswgAIo7/XjsItEju9Q2zCpghmsLAbUryuvZ3MiYncorwPhFrErL2OseguHTHHSrq1IoePm4R4KM3ZzJvGdQ4F51BJXWkfLvXg+KVaC/6TMVQh+BG1ZA4h0RZILazQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cRcDeaK3Fm5Wr7PUBctTY/o69SZCwEgir26BZVKwSQs=;
 b=lsaTMWqHGVc79Te9wB8oOVIU5inl3xe9+HUSQmXENpInYp80B2DKozz5zjE8XOcgyE1jvzr4ipxYc+kj1vyLiQ005xdrlQnjW00qfB9XV2jzQMYBo0SQs7IZSev+L3+j7GmBLZLgIXG+WvVM9sbNQKQRDJhg4zyyzg8+WeYAvOyreRPgEV+6dmF1PFbOCa3AVO8llBFau1bjS8RFEIYDWmxpKT/yIJ/AlxpPpOddwQP3pQdNHzwlEjB1d4Wy+hTWqcCWTytq5nAFRNmwcdDJhMzvpPyWw9m7lV93+635GyC5e1NT1o5hXAA0n2OurglQ51LSzul6uHbbzqalSt9D/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRcDeaK3Fm5Wr7PUBctTY/o69SZCwEgir26BZVKwSQs=;
 b=RpkDI4O2HnqZ0QY7rqV4vL6aAvj5xzZROPb67Qgx9IAfNA3+PMveoC1aWSDB8znbFYjvWYgdczLaoRWChLtRqp8lNSkDYNJMYO4TZHI8usmJoa7fSWK/7jLO1qPRGqr9eCvluNg9sAFQ7DxScebVBmmrqcvKu8ksA597k8ESZgU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CY5PR12MB6057.namprd12.prod.outlook.com (2603:10b6:930:2e::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7270.17; Mon, 5 Feb 2024 10:23:04 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb%2]) with mapi id 15.20.7270.012; Mon, 5 Feb 2024
 10:23:04 +0000
Message-ID: <582591e3-c925-a700-24d0-121c66a06d21@amd.com>
Date: Mon, 5 Feb 2024 15:52:57 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v6 10/17] iommu/amd: Refactor helper function for setting
 / clearing GCR3
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20240125121135.8217-1-vasant.hegde@amd.com>
 <20240125121135.8217-11-vasant.hegde@amd.com>
 <20240201173544.GK50608@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240201173544.GK50608@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0131.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::18) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CY5PR12MB6057:EE_
X-MS-Office365-Filtering-Correlation-Id: eacab13b-7792-4c4d-1ac2-08dc26346fe4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8mXPwSDVfAnJN3o0SbUyBCpzS36MPT9OkGpmO8seRtt6H/Wt798oQktHwG99rE5nDq/oS1aXITBpb/ovsxIKCe6C9VrYOYyegtDC49/MDHiib9N+cIZ/PdR/HofDp16XbJJreMcBSFh559GW6hhvLIoOlOqtX3j24mkK11IACA7j3QbHfPMVlO5MYPwJKIV6vZ/ta1LHGfh1ebp7EmWNqza9CBhVdeM5qOdz2fa6YJMHcvECA+3FM/7s4CAknlXIRGN9xkQnmHJoWJUEyVOkP77qSMYwD6ZsPdABRC+dA+wD1/z3WBC7FzMiL0mS4YkMwuoc6Qzuxmmf7FGXUPoF76UMykHnlqqW2TPoNJJunhLBufPthjYILwcJGj9BVUvAN/C2gVjT8Vmzct0thSziY1NOYcJ2Q5scikr0XrZqG+zKggdxgLNeyTIkkqmLTCLyspxPmboN2By7B+b+MUkysFJZk0dZ5JYaBuG9DwIBiCGje4oMHl35h+RfXqzoYkfnXAqTHrl2sGpWcQm8YMc7IPnuluoiXG86xpThiWI/cEJKyCL8ZCa33oDKmXddstXHotP8srCIH4SY6ANjCyGE4Rz1aKNPxV3iezGx9q5iGf0AiXpprVRWajRbCK+LI8Oxyvejsv14B+QusCRACk1Now==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(366004)(346002)(376002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(6512007)(83380400001)(26005)(86362001)(53546011)(6506007)(478600001)(31696002)(6486002)(2616005)(66946007)(66476007)(66556008)(4326008)(6916009)(316002)(8936002)(8676002)(31686004)(6666004)(38100700002)(44832011)(36756003)(41300700001)(2906002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y0pjMzlSZFBIWmFSbTY3NW12c3lid2JCUkV6TWF3cTM4bHFiTGhXOEx5OUdZ?=
 =?utf-8?B?UWdnY3NsSThoWGVYRVJoeG91TWRxRFp6T2trMUw1cjNhZWM4ei93UUVSZXVk?=
 =?utf-8?B?UUliM2xIMmpBTUw5bnhtaHRjSFFWT1lYbTR5djNhb2xXc0ZCMWo3VmFnSCtz?=
 =?utf-8?B?SEM2WERrMVpjN01mNDB6VDVIWGdvR1B2Vk1IS2VXaWNVZHlaM3VrUGtVbjhD?=
 =?utf-8?B?RkFxYUE2VjBLVHE4ZnI1Zy8ydk9oejQzUDNha0pFcnA5dTIwWVkwdFh0eTdZ?=
 =?utf-8?B?ZUxGSmpiYzVXM3AwNytsUmh1d3llMFVLT3JrTDFjYWptT2dVdW1qMXp3WlY1?=
 =?utf-8?B?dnpIbFdvSnZ4ZmxodDlXSnhlZU53ZzFtWWF2RUpldWt5emtEaWoyRmFxNWtQ?=
 =?utf-8?B?d0FhUktTT2hLd1ZVMTZoTGRyU0UweTJnNnRxR0dLWlJrOVd0STFXNGxSN2Nk?=
 =?utf-8?B?dzNJd3c4elZZMTVoWTlEUEErbHpNTXNTLzExMGxDOE90Y1RuT3FhL0ZEY1VV?=
 =?utf-8?B?MEZKdjlRTStOMFdtODFnK3lBVlBWSnM1U0ZvVkY2NjdOSEV1WWFYN2h6SE1N?=
 =?utf-8?B?U29LYlBUUVplMy9BZXhKWHdGY3NQdUl1T1llNWVhR2VRdFFLVnJPM083YVhC?=
 =?utf-8?B?M0U4TkxjWG5PN2E2dUswbHkrY3R3ZFRrZ0Z1aUMrS3ZPcUhYK0hFcXU3Rkdl?=
 =?utf-8?B?dkFzTUNkNDI1b3lqdU1kZWgwb0NqcXZkaWhlQzNxMzNyQVJhcHkvMWxpRVVo?=
 =?utf-8?B?Mk0wOGxMVHh5YXEwS2RkbXJIREJ3VE5pWkZEMzU2eGgwbG8yalZIcXp1dGdH?=
 =?utf-8?B?Sy9YNmZhN1VhTGVIZWlYUEg4blk0MTlJNU96YW1Kdi9TTmVOY24zV253LzBo?=
 =?utf-8?B?dlpKeXdlNDQwcnVsOTFYa2JCNktXVWhLaXdpd0wvNnl2NFBiQ3hoaUVwZDNk?=
 =?utf-8?B?RTkzOEozb3VTZUhYdmJnc3hEbi8vWG9PdmpZU0prTWlscnJvOHJWZFFJSEdX?=
 =?utf-8?B?cWRVQmsyV1diczR6STJubDhmTitORW1wSmFscWFwbWEwNTJUNnRZYWNzc0hX?=
 =?utf-8?B?cmwyaUg3M2pSZDhHWUVQYkx2SC9HVVR6Ynl5WW1HbVFUM0t1SFYwejFPM3k1?=
 =?utf-8?B?U3hHYWxJemFvNENoaStvVzFXRzVXM0RNdEpXZTlCaVR2ZXBuUXZuWDRnNjFw?=
 =?utf-8?B?cFEvTHl0UmNhM1JFdzZYNkhQcUJmWlZkWkluVytUeksyWjh2blg3MHZ5SUh4?=
 =?utf-8?B?VkZ5OWFEajNVbURnNi9wdWt2MWxrNGhqaVV4N3lpYlNOS2wvd21OWmExbVlB?=
 =?utf-8?B?cmkxWlE0WCs1WU91N2o2Q05mVkRRQlZpSE9hMTZNaU1xM28wTGxWTDNYMVNs?=
 =?utf-8?B?R3dHTkZZRCs4S0lHNWI4NHFKS3Jrb0k0Z3QrYkxxYldhNldaa3o1M0xTZzgx?=
 =?utf-8?B?WndzMFlmR0NoV1ptUlJ5anZnL2JFUnVaaEtVaFpjNHpRU2ZMQ0FvbGpjaStE?=
 =?utf-8?B?bGp4dnc0U1I0ZUg2MzZmRVdKdDMxMEpMMFI2b0lnekU4NVdkdjhpdExuN2Vw?=
 =?utf-8?B?YlNRWlROUWIxSE8ySEtqQm80NWVXODYwMEtNWmNvVWRqakU5ZHdoNUJWbTkv?=
 =?utf-8?B?a1l1MWh5ZXBLOXhDM1JuMExsa0VCdElTZ0dLSkUwdkxWZ1FkRlNuUlJ6YWV4?=
 =?utf-8?B?aFI4NGJHS2tlOXZPSkVWb0h5T1RoSUlOUW1WellKZmNpNXY5Q0hjWnBjSE1u?=
 =?utf-8?B?MkF2eEJVVVhGYllDQnF0dHZCODltNlFJY2dMQTNCUWZRdUxnYUFpVlFnWG5D?=
 =?utf-8?B?K1hPTVJmV25BYnBGWk0zcEo3WDVoUTdoZDNWRGczNVJJRHNaZk13eGZwTXlh?=
 =?utf-8?B?SHR3ZFhsWWFMZmYreUhQaEZoWG9lV05Dc1RyUy83UW1RckVGNTNTZ1JmL1Br?=
 =?utf-8?B?RXdSYlpCcURjZERmM29ZQ3ZYc09EZG9CYmtqTG0rcHNwTG1lcUo5MDhYZ2lr?=
 =?utf-8?B?cXBFVGhvNTg4SWdmOVFmbFd3UzB1dSs3ZE1leTByZzBtaStPS20xNDBhVVd4?=
 =?utf-8?B?OHdxOGloUHdZTTM0cUJnNzlVV3I3UXNIVFBmRVhCcDhsSnBISzNNbnhKSWFI?=
 =?utf-8?Q?13bV+IWMxkik7t/eecFwmJZ19?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eacab13b-7792-4c4d-1ac2-08dc26346fe4
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 10:23:04.0471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7mE/qvoZtr8cZbKHqmOJCnAd9qBYGTfs9G98yQLgq2VWjBr4mciK4jxScgrDWowzt+pNMyZgauXG6SUUWck02A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6057



On 2/1/2024 11:05 PM, Jason Gunthorpe wrote:
> On Thu, Jan 25, 2024 at 12:11:28PM +0000, Vasant Hegde wrote:
>> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>>
>> Refactor GCR3 helper functions in preparation to use per device
>> GCR3 table.
>>   * Add new function update_gcr3 to update per device GCR3 table
>>
>>   * Remove per domain default GCR3 setup during v2 page table allocation.
>>     Subsequent patch will add support to setup default gcr3 while
>>     attaching device to domain.
>>
>>   * Remove amd_iommu_domain_update() from V2 page table path as device
>>     detach path will take care of updating the domain.
>>
>>   * Consolidate GCR3 table related code in one place so that its easy
>>     to maintain.
>>
>>   * Rename functions to reflect its usage.
>>
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>>  drivers/iommu/amd/amd_iommu.h     |   8 ++-
>>  drivers/iommu/amd/io_pgtable_v2.c |  21 +-----
>>  drivers/iommu/amd/iommu.c         | 113 ++++++++++++++----------------
>>  3 files changed, 59 insertions(+), 83 deletions(-)
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
>> +int amd_iommu_set_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid,
>> +		       unsigned long gcr3)
>> +{
>> +	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
>> +	int ret;
>> +
>> +	iommu_group_mutex_assert(dev_data->dev);
>> +
>> +	ret = update_gcr3(dev_data, pasid, gcr3, true);
>> +	if (!ret)
>> +		gcr3_info->pasid_cnt++;
>> +
>> +	return ret;
> 
> Try to follow success-oriented-flow when possible:
> 
> if (ret)
>    return ret;
> gcr3_info->pasid_cnt++;
> return 0;

Fixed in v7.

-Vasant
