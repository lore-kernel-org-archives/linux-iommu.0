Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AC23FDD
	for <iommu@lists.linux.dev>; Mon,  6 Feb 2023 13:05:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ScD0gm3USIGLNUXixcHxQMDyuBU11Ru4eFKmOTzIbbHSYPUXitZ+KX0sQP0p4Qnee1DRNnQG64gCXOu9lqMGt159xTBcaqxTIGleHQ+dj0sKOTmAYest/vEsU1BCmMJYL+5p2RONYbZNfuF5kiHX/HRQA08oKXkPfF3zDJs495IgRrU51up/5NMmbcnaR8sEf8s6tG79kA9HBRVsuCYBEf35/JclqQ8yF5sOvAvKUBKuP2/I+1lDeAKJSZTftqaF4+T3wf3XAXo7lItscDK9mxstRtGosju5BtKx4s8Zob+xdIJweccoDnQdEGCc9Mev2qAzxUThvaokMurN9E/yLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0HmHS4sVD3IXgJfjkccoqFfTyHOljIYh8CEc9cZWdjU=;
 b=bB82xI5rC5Qfk8kEHNfyxAIXYCfQqafk35io3S0LllpZrAoOrofXTsJfjbJl/DprVXaFkEaGT8HTq9i72JK16vmJv5jDgjuoZQCbcS/n27ws8G/6SY/UflLgz6VfHPykdbddh6LNPUQt4Plu6p8sFIhQaIvPK6ufhwg5FN495JmxyZK7Dj4ftwpXSxM1T4BYtE8JZHLGbr15kiup2ONFw/AtFDRdc+FrdLUM58i5mc7bnF9jT7rNzdvCRmnCjYiF3Y+91cqQIvUBWjPLsuzHdLs9wxbDbZQB9ctF2ZwHoIeRp5PkzqJ9bSnIKnD02FNdkKUWnwqmXsuTXZRVKrrbIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0HmHS4sVD3IXgJfjkccoqFfTyHOljIYh8CEc9cZWdjU=;
 b=w8ZkS+FOM4kk69PJsp1wNWwm9udFiVaXsb826f7EYZyCAo0Byihw9xA2vFUrmJEgCRgnYoCB0a3Dgw/JET160zS02DKER/Qfoxx1YWOvSRxpQ/w9MnoOHBM2Tzrul8iyV14zJihkwk/qhrv8x0dcR+m5woXiHONObNoEMYv0fRo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CY8PR12MB7561.namprd12.prod.outlook.com (2603:10b6:930:94::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.32; Mon, 6 Feb 2023 13:05:29 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::4014:79ea:392b:b4f6]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::4014:79ea:392b:b4f6%4]) with mapi id 15.20.6064.032; Mon, 6 Feb 2023
 13:05:29 +0000
Message-ID: <fe6ecfd2-3ccc-36e2-0569-323e663a691f@amd.com>
Date: Mon, 6 Feb 2023 18:35:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 1/3] iommu: Attach device group to old domain in error
 path
Content-Language: en-US
To: Baolu Lu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
 joro@8bytes.org
Cc: suravee.suthikulpanit@amd.com, robin.murphy@arm.com, will@kernel.org
References: <20230203173623.18308-1-vasant.hegde@amd.com>
 <f5af1701-1707-23c8-3f62-ad4ffae21387@linux.intel.com>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <f5af1701-1707-23c8-3f62-ad4ffae21387@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0213.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::7) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CY8PR12MB7561:EE_
X-MS-Office365-Filtering-Correlation-Id: 27fa4df9-fdb5-424b-d263-08db0842d218
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	M5s5/6QQCEDOZ85TvlWmLw4jHph8fGAlGtMsawOavui9+xU/cN9l4oDNchiJK9u+XbH1l/CzHy1Aa7U3RdHZIuvEe6hEZfVqOFFMYH1gMEWEM87it81+f0HxuR7l4iTy3KlDoYJ4W4JjWsHcyxU152RVQLx/109V77bGLgb3FRAoy+IGG+LwC6ut9DyNyz7ePWQyCUJvC9+I0nnKxfgzQ9fzNZiY7qOKjnQuxltn735H2tK+m9w5sk7yq8OsUdgUORJHk4vn+sSeF1OEqU8qvgKUpKs9PtOS9Ba7v9aTWtUQ5RgDyO3SrxAaivfPK9Ca+YQi2OIhAy9bUSTtB6Qz9r9IaIcy3kVJgssU88YlTnxDu9sfNxxkINoo8UG8xmsIpbc6nMXyw9oasqCo3aLIn7kwr45WO0zg05rF3bWhNmB+y9ZEM0HSEjjRf32WFm1BP7iFtSXO4EKRqXBsB2VEeY/5pw3iHw6x8GsYst3Vwk8S6SGNnuM0MTcXt19OgeQr+a2beFYMBUVcOfm4ZEspjj3pJLWarUyemdFlZ9hJaMp9aspjVzRqNlLHn+uPJrqrSqJjV22Qe8ubk31OXJafF11gX/KFTvp0xiB3Rt78JeWMGBndi/tNw5pP0sBAAihdF5jMr4PveBWshFsrwvJo1FZticrVay01CZY9e8AnpOMC6ZV12r+zeL0mTVf1TXfGndkGem+3pJ0iW6N/hNM4r8LNyV5VNSrN27EsRspsR0k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199018)(478600001)(2906002)(6486002)(6512007)(26005)(186003)(66946007)(66476007)(6666004)(41300700001)(6506007)(66556008)(8676002)(53546011)(4326008)(316002)(5660300002)(38100700002)(8936002)(36756003)(44832011)(86362001)(83380400001)(31696002)(2616005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aDhMc3g5aHNkU24weFpWZ3IyOTdxNmhSMHpodXFHb2MyTDc1NEdST0xlQWtm?=
 =?utf-8?B?RVBQeHVWUVBONVdZMGVmelJ5MnA1QTRrajV2Qm9lelRTME42VGZ3M0huWE9i?=
 =?utf-8?B?aTB2WlJDWHNMY0RJUEZKaVpPb0p2M0RtazRpT3pFTG1WeG9SWE5YQ1dFK1Jh?=
 =?utf-8?B?M201eWJyRmlrS0ZwU0U0RVVUMnpTZVk1N1BWUyt1TEJQMWhSbllTVUhPQWtq?=
 =?utf-8?B?NzROR3ZLTnVHcUZVak9hRkpGclZpTHpPcWpnS3l4UTdESDY4bGhydDJTb0NX?=
 =?utf-8?B?UENmWDZCTzd0MEdLN2txY0hLM1Z4T01pRjM5ZWJoeXNRZEp0NmVXSDFEbzEz?=
 =?utf-8?B?MTRqNGZQeVBXTjI2MHNjUUI0MElwMHNUekxUWEErK3hsR3l5WFg5TkoxQnlI?=
 =?utf-8?B?Ulh5ZmZhaGIvdWp1MFZqUlBpYUwxNTc0T3pwNDBWQm9OM0c5eVoxcHlaWm1o?=
 =?utf-8?B?czZ1U3BQTTBYZmRGTFFaNzBUeXFPbytJU2diLzN2Y2x4YW5kb3JxN2Q2OTRj?=
 =?utf-8?B?MTZEeUNIbDYveWFHejBSbUtkcFI3ekJEdjFweUlCZEJmaHJYcXVDdkp3amRH?=
 =?utf-8?B?UmorNHF4TTRiQ1VNSGFNam1RTmV4T1FQUzI2cWROSFZDb0xsekp5SklmZit4?=
 =?utf-8?B?VnNDaThKV1pRVGlGcURJU0g2WDF5T2dBTE9SNmNOV0ZnQXp6cGpQSnplQTFE?=
 =?utf-8?B?S29CaWhVcHAyRUZRTWdnZWtkOGYyck1aUWJSV1dsbEhhZ0JBOFNoRUcwSzUv?=
 =?utf-8?B?eUp4UVZ1NFZKdll5S2lRbzNhUFlBNnZHQUVGS1ZNMUpINEpOK3kvbmZ0YTBI?=
 =?utf-8?B?TVgxU2FMWnQxWEtLbVhibzRYUXdWbytRd0dMbkxIUkNIWEVMUTZELzBsbENE?=
 =?utf-8?B?L3ZTSTNVNE93U0dWRlBGcmc1aWp5WGRpRzN3TzFnSURRZXczUjEwcFR2eWJP?=
 =?utf-8?B?czVPRFBLT3I0RnZGeG1VZUZnUW5VanAycmRONVU4VE1DWTBYcXM0OFlsanNr?=
 =?utf-8?B?NkJDWFVGTkMxOUl4TFozcWRsS05DN1k4WVNyVkFZbGZ1TWtubGVEcEpHelNj?=
 =?utf-8?B?QUZ2bitRZTJBSzBJZ0gvWUhsajJxY0JRdDlVOGxieVRnbGJ1NXBtQlhnRTha?=
 =?utf-8?B?OVRMR2hOblFocndXWmc0ZzF3UGcvc2VkdkxnM0MrOUpMNS8vQ1lVdVJwRHU1?=
 =?utf-8?B?TTFiWGhydXZWNm5mMFJuOUpSU2ZkMSsvbHdlbElvYXI3bG1BZFZ4MFpxVy9l?=
 =?utf-8?B?dURNZlJ5bTduTFdrNitGdkQzREYremljRFkyQ1M5THBDRytzbmg1TnM3L3RJ?=
 =?utf-8?B?NXJraHlkYVVFRC84QXlhTU5CVUErenpaN3c3bVl0cXFVak5yS3RteFFHbUFs?=
 =?utf-8?B?YlI2VmZUTFc4ak9XWk44UVNOTDA1d2s5N2svNnBQUzdQL09XeC9ObXdqczMw?=
 =?utf-8?B?VHY0THhXSDR6dytlVHoraHI1cXhpMnF3Q3pjUjFkMFBkcVlmalNDaXEra0tp?=
 =?utf-8?B?L1MvNFJFcHdRZ2hUaGgwS0JLYW9LZ1llMEFMY2NkK0pYT0ZHdS8zOUdKeWFK?=
 =?utf-8?B?ZnNCekFKWGZsMlcxMmsyVURMdlBFTjJGbWpiU3RkaEF4YjN4bVVUVm9GdXpP?=
 =?utf-8?B?NU90dlllS1JSQjRCcHVZQkI4b3RTNTZCdlA2citWZFo1ckZFdnpUM0pQWGNO?=
 =?utf-8?B?N2tyQjJJSjd4b1dGb3BSZUpDNWtPUzJ0NlBCMWxtWklhaklUdnNCUDcvTXli?=
 =?utf-8?B?WjZmTEVxVVdxcTZJWTIrMmdKd2ZRUDJCYlZaTi9IS3dFUW40cW9FSEFsZmtB?=
 =?utf-8?B?bnNKQ1ozb25LL01ucFIyanhVSVF3TkdxRzZ2SFFzT0wzaUJkVjVxTTRkV3U2?=
 =?utf-8?B?eTE3eUtsS01wRzVaN3NCZStPZEFDaklZMlUwUWhZaWlhSFJsQ0tCdnpIZ0xs?=
 =?utf-8?B?VlRCTll1M1ZlNWJaM1NtTUdJR01qWjlNOWttKzlTZEVGVVd0KzZXQ0oxblZp?=
 =?utf-8?B?QURnYVdMTk1jcklrcEVYanNMZ2huUjVaWnNIYXB6d2pqQTFmcHhyaDBjeWpa?=
 =?utf-8?B?Z2lQOUVBdHJNN095WFhYcHRrbHRZdGVHV3JqTDJLNEJ1RUhCZlhpMTd2a3hG?=
 =?utf-8?Q?HICy9fHgLnt7/XflEWDTzJAFi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27fa4df9-fdb5-424b-d263-08db0842d218
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 13:05:29.2512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N7nUVhqmWw4SPVYZH0qxlwsr9xcyQ0dUugE5RuO9xCy0KUmFZ3bFPxuChIUKjlYfRInhr3juBynOyxpJDGRFzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7561

Hi Baolu,


On 2/4/2023 9:07 AM, Baolu Lu wrote:
> On 2023/2/4 1:36, Vasant Hegde wrote:
>> iommu_attach_group() attaches all devices in a group to domain and then
>> sets group domain (group->domain). Current code (__iommu_attach_group())
>> does not handle error path. This creates problem as devices to domain
>> attachment is in inconsistent state.
>>
>> To recover from this situation, we need force attaching all devices back
>> to the old domain. This patch introduces `force` parameter to
>> __iommu_group_set_domain() so that we can attach devices back to old
>> domain.
>>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>>   drivers/iommu/iommu.c | 24 +++++++++++++++++-------
>>   1 file changed, 17 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index de91dd88705b..e58683cd3bf7 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -95,7 +95,8 @@ static int __iommu_attach_device(struct iommu_domain *domain,
>>   static int __iommu_attach_group(struct iommu_domain *domain,
>>                   struct iommu_group *group);
>>   static int __iommu_group_set_domain(struct iommu_group *group,
>> -                    struct iommu_domain *new_domain);
>> +                    struct iommu_domain *new_domain,
>> +                    bool force);
>>   static int iommu_create_device_direct_mappings(struct iommu_group *group,
>>                              struct device *dev);
>>   static struct iommu_group *iommu_group_get_for_dev(struct device *dev);
>> @@ -1974,7 +1975,7 @@ static void __iommu_group_set_core_domain(struct
>> iommu_group *group)
>>       else
>>           new_domain = group->default_domain;
>>   -    ret = __iommu_group_set_domain(group, new_domain);
>> +    ret = __iommu_group_set_domain(group, new_domain, false);
>>       WARN(ret, "iommu driver failed to attach the default/blocking domain");
>>   }
>>   @@ -2124,8 +2125,16 @@ static int __iommu_attach_group(struct iommu_domain
>> *domain,
>>         ret = __iommu_group_for_each_dev(group, domain,
>>                        iommu_group_do_attach_device);
>> -    if (ret == 0)
>> +    if (ret == 0) {
>>           group->domain = domain;
>> +    } else {
>> +        /*
>> +         * To recover from the case when certain device within the
>> +         * group fails to attach to the new domain, we need force
>> +         * attaching all devices back to the old domain.
>> +         */
>> +        __iommu_group_set_domain(group, group->domain, true);
> 
> Adding force parameter to __iommu_group_set_domain() looks strange. Does
> it work if we make above line like below?

Yeah. It should work fine. Will fix it in v3.

-Vasant

