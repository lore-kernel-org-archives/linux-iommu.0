Return-Path: <SRS0=LdVQ=KA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A227FC433B4
	for <iommu@archiver.kernel.org>; Wed,  5 May 2021 12:39:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33250608FE
	for <iommu@archiver.kernel.org>; Wed,  5 May 2021 12:39:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33250608FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C9DD160750;
	Wed,  5 May 2021 12:39:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GS0lZCn-Cd4y; Wed,  5 May 2021 12:39:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8A412605DE;
	Wed,  5 May 2021 12:39:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5541FC000D;
	Wed,  5 May 2021 12:39:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 17B28C0001
 for <iommu@lists.linux-foundation.org>; Wed,  5 May 2021 12:39:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F299C835CA
 for <iommu@lists.linux-foundation.org>; Wed,  5 May 2021 12:39:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zZ1lXdpYHm2X for <iommu@lists.linux-foundation.org>;
 Wed,  5 May 2021 12:39:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::60f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 940C2835B1
 for <iommu@lists.linux-foundation.org>; Wed,  5 May 2021 12:39:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZgEGIYtfnG/d+CFJTx7y3tz8VBjDvVp/q0UCsX7ppVwQbPeUEf13UVJsCYcZHhw+Xe0iWTyD1BVWVIJQjws8F332Z/7zNsVlph7emlR99/CQu/2YPSOPYKsGQaX5k1riRMjTU00xr8uZ8gPz1K/eaFg7SJ018Y7ql05MZlqz4H+9MEA6mX4Mk8OSCPm/1fNNbR6bZAb6FZluvyeqE8pjivx6hu5uiChdsioomdbkyyQ/z5ED1uRI08gsC8wfbzTrO+KCsL+SHBS7nAkerKDOtS4Th8FKmemjJcrqAkhF2K5T5A7Gz9e3rGUC3/didEITBRljYldDobB7AvWquPE9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6tZAL7UD4b2YNGseWS2K5gV32JQp9r3Z9OT5Xxr/VA=;
 b=OvGh0srpRYfcThRWjjo698Bvr/aAFjmOY7bFPwDuJF1CxgKUSVyR6aFjEh7DuscIuZrc1g41MtzHexwxFHBgk1gmpc8JSPmuIrOwart6ul8jWhDU2lT9eP0myQNxBXEs3nQDqurfycAZOFT4BWPA72lHs2MP5eM41k5uSl+F3VaHXAiSBPpz/86eCHnSit8FwdgtU8msueAw2wd7/xSi+wQNFBb6yCzwHQL9H3yB+GGKn3CDGcc/w8IJ/8Qdjw+5kiOtglvAtzDYFxBgz54V8HKNbAfumDDUfdEoidLVQ0xNBJXYchn6ppldgUjVRvex1i/WKenSFYrsTP1zPDUUeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6tZAL7UD4b2YNGseWS2K5gV32JQp9r3Z9OT5Xxr/VA=;
 b=PfPriWV2xdycsl2XCUj9E0magKew7HIiAghPGAEZWIsVBMeEIdvfYuCxi2utVLXw3gK8wv09D/BLTLuNdGkFJh0kA3NDd2cdG/HKgwCB1cVZXBxRWYt+nqP26VGZVPQ1uAQzGXqIUYnDZVl9xvP/0DScJ8I39ijOOSJxEBP9Uw8=
Authentication-Results: live.co.uk; dkim=none (message not signed)
 header.d=none;live.co.uk; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 by BY5PR12MB4306.namprd12.prod.outlook.com (2603:10b6:a03:206::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.40; Wed, 5 May
 2021 12:39:37 +0000
Received: from BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::cc86:d78a:bb1d:5109]) by BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::cc86:d78a:bb1d:5109%5]) with mapi id 15.20.4087.044; Wed, 5 May 2021
 12:39:37 +0000
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH] x86/events/amd/iommu: Fix invalid Perf result due to
 IOMMU PMC power-gating
To: Peter Zijlstra <peterz@infradead.org>
References: <20210504065236.4415-1-suravee.suthikulpanit@amd.com>
 <YJEWWbEeDm0rUyC+@hirez.programming.kicks-ass.net>
 <e9769da5-3d2a-6e86-8ebd-feb00b567bba@amd.com>
 <YJE6eCyHtIONCJet@hirez.programming.kicks-ass.net>
Message-ID: <ad67d625-9e59-2216-0f2a-88635a212595@amd.com>
Date: Wed, 5 May 2021 19:39:14 +0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <YJE6eCyHtIONCJet@hirez.programming.kicks-ass.net>
Content-Language: en-US
X-Originating-IP: [165.204.80.7]
X-ClientProxiedBy: KL1P15301CA0039.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:6::27) To BYAPR12MB4597.namprd12.prod.outlook.com
 (2603:10b6:a03:10b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.73.101] (165.204.80.7) by
 KL1P15301CA0039.APCP153.PROD.OUTLOOK.COM (2603:1096:820:6::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.1 via Frontend Transport; Wed, 5 May 2021 12:39:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b214738c-9cf1-4392-0dbb-08d90fc2d825
X-MS-TrafficTypeDiagnostic: BY5PR12MB4306:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB430661564363C5310632591DF3599@BY5PR12MB4306.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 30ePFMuq06FHo1fp4moPb7nazWoXKz5wBvMyyJ8JFm9YokOu95N7lPP9UcF6A+K/m9/1dkiJHfLi4RUfitsd9Kb6OkpkO6MYuUEbbNpGZ0QbHrHgDPLMNjDeRRXwsv8ahzfp6DV3sS3LwBebAiRMp/d6PW0xOeX28phLlBOn+fW/3cIoQ+/nj/s/81Lqt4AiDPogWNKX897ZXVFPazTFL2lVYAh4mUfgqREm4QQVgddgSfuUUnT65H+AGhCf5+aWdfrZzqVkWxV1mrKWooQ7vuq16fm+kjucQd3expNT6007rfl+f86ZNubWITUgGVp1TyqV9J2MdQLMffDlEaDt/sFGKoZk7r+G7Mgasaid+C0uPHMCW/zDbNB50rN3X7gnut057lIl4WkG2s3tIhoXQD3D5Ar0nPkE9bjB3dRLTe92ASS5Y4q45sA9odw9fr5Iyl98SR/+7bxCxJA86wUZ++sEMMNwEOzloGcxquWTQztvPeAfWfOu63LOj6NxV+L+C8ZABVst2sW4cY8WeYufAAqaJk0EZgQapS9HR4OaNbtrG+m8P2nJrijjHUMmaF9CDvGwYQ3TTnewHCKjZs7SiDeopypn7IJhZh3iErMmUDLcwP965DNZRjAeloiuZcvrj8Tid/eXyWBgE92rMea92NwWEDHSe/m0O+KvfVopN10thNhVT4C1/mTUe/RuNhqPtIhZG68lBHTpvaI/PhdHVOLkXdfnDI4qaNuIP5gCwUcBrPvXovWCCYLOXLO8zU7k
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4597.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(39860400002)(346002)(366004)(83380400001)(26005)(5660300002)(34580700001)(186003)(8936002)(16576012)(2906002)(2616005)(31686004)(4326008)(16526019)(52116002)(38350700002)(31696002)(316002)(66946007)(66556008)(6486002)(8676002)(38100700002)(478600001)(6666004)(66476007)(6916009)(36756003)(86362001)(53546011)(956004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?L1JwTmZtVTRoaGJYT252SGVmcjhycVh1YlR1OWl3VXJOVGlJYTJvc0dTQVNE?=
 =?utf-8?B?VnM5Mlhtd0dsRFB0Q0ltaytLZjNUdVVPK2w3b08yRVQrSVpUQkdlT3Z1K1I1?=
 =?utf-8?B?Vm9LUlU2cEsrOGZJVjIxUWNJam41dTBYbDBaK2QwSTV5c1ZacVVFTEtqdGNX?=
 =?utf-8?B?TWtwUWVFYUtkcHRiaHFSc3VXTGdGMFFLcnlhYjhWODlFZ0xhQ0xncmV5L0Nw?=
 =?utf-8?B?cXRNa3l4aEZ6Tlo2SmVsdW5uOTY3bk9ObDhxOFhJRXBNaDhESm5reExmUGpN?=
 =?utf-8?B?YzR4UUNET3VtQnVQWlQ4SWhvdDhxV0dydEpXaEFWQ2JrdWJPVWFHbVdvUTFI?=
 =?utf-8?B?L29Qa1drTVBUZ2pyVHE1dlN4Wms0d2xaRWR2N1RnaHMyalRVQms2TzdGZkp4?=
 =?utf-8?B?OWpBRVZjNW9NZElJcWxubE9JaGdST2w2YTlLNFRrcm81Z0pFUThLNUY4bjZG?=
 =?utf-8?B?bTFsVW5ZWmhZNTNxRnN1K3Qvb21Jd1paaDVEWGVlcUlVL0VwUCtHeGhzLzBP?=
 =?utf-8?B?clpPSS9uODdxVDlMM0VLdWhWVUtXNEEySDR1ejhJYThMaU1GbGs1Q1NLekly?=
 =?utf-8?B?dDZObXZZYTduMjlZRGdHS1hVNFRxNWpBRmg3Y2N2QXVxd2NmVUd0RkZ2cjRU?=
 =?utf-8?B?Z2toRVNZdVFkUnVMSnA5NjM0bFZHQUZ6MW5PREpkNkZhdFAzZHN4MzNtRi9N?=
 =?utf-8?B?V3doUGo2V010S01CNlhZRlNTbEJLL2UwWVViRnZIekUrS1VpMW0zMU5TQ3Mw?=
 =?utf-8?B?VjN1djVPL1ArTEFhWC9FcU0xZmZlTkIvSHNoS3dHMkZmalZaUFR1OVl1QXln?=
 =?utf-8?B?bHFkei8yZVZnSTFnTUR1cThxZzZRRGNKVHhUNnA1emUyUmxQb2lhOHNRcytI?=
 =?utf-8?B?R0I5MDF3bjhnQVlFMktoZzZjeFNPc3IzMS9YbS96aU44ZFpBRFhtZkxtU1Fy?=
 =?utf-8?B?b1J1am1CZEFOd2kzRGwwM3l4WVRhRVlTTzlOYmV0b2I4Z0graXJYb2hUOFVF?=
 =?utf-8?B?eGRFaW5xVDlDSEdBVkVpMnB1SWQzYzg3alRwdEU1VDIxeUE3RWNkOUdvTi9t?=
 =?utf-8?B?RTQyMlQ1SHVhVWZGSTFDenpQK3NqeG5LQ0ZrVlMraXVWeVNDdVQvZzhZMXli?=
 =?utf-8?B?cXUxM1VHdmplZTB3c1Y0bVZnTVRQcEZ2bkViMWd6WTRXRHJjNDR3YUltekh4?=
 =?utf-8?B?MFB1aHRYQ0hCcGRTQlUrNUYwR1JhZFlYblVaNVM0UWsvL1JKUEhLNUNBeEVm?=
 =?utf-8?B?dEl1a21mT0d0RUg2bTQ2YVZ3d3ZVQlBkQzlnQnFBMDhkeXVDb1RnWjcySTFO?=
 =?utf-8?B?ZlFlYWFxVWc1cEh1NUxkeGRmYjZwbEMvSlFodE5HOFo4Q1pHQ3lHTHAzeFFp?=
 =?utf-8?B?U1hleVNpS1V3UUY2RnkxQUZ2aUM5R1hGSFNEYWphMEg5R0ZyVTg5TkowbnVh?=
 =?utf-8?B?akZ2NEVXZkJ5ZTYxUllXV05FMTdDbFVRSmRIL0NTVTlYTEtvL2tudkRHdUd5?=
 =?utf-8?B?dVZiVkpZTXFBelpLMTJTUm9TS3FGQ25KVHpURnpYTkgxbzIza3NsekQ4Y2lz?=
 =?utf-8?B?SURwZnFJcUFyTW5sWHBtT3BoUlVmVFZKZnUwVExvUWNKVXhaMUpZN0RUYmV4?=
 =?utf-8?B?aUFvL3VPY0hRb3g2aTNxVmxGajB2VHRvU2dNZFZPUnRLeWdhb1QwQVBldnVh?=
 =?utf-8?B?QzhqdXd6RWQrblpQa2tyK2dVeHJlSmttSlpnMHR3dTYyeGxTRXk5THZnV0xn?=
 =?utf-8?Q?gftvVOZf3rglV02b8G/HWEEU8PRZyonv7rAIfxg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b214738c-9cf1-4392-0dbb-08d90fc2d825
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 12:39:37.6483 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mW1VF5zwvURU1MOCKs0Zv0PbQPs6lb9uuNYYN0cS7M1VYY8a+c0mubSwyT1NjVMyi8MmjtIEePT6VpxIHy/76w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4306
Cc: David Coe <david.coe@live.co.uk>, amonakov@ispras.ru, Jon.Grimm@amd.com,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 iommu@lists.linux-foundation.org, mingo@redhat.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Peter,

On 5/4/2021 7:13 PM, Peter Zijlstra wrote:
> On Tue, May 04, 2021 at 06:58:29PM +0700, Suthikulpanit, Suravee wrote:
>> Peter,
>>
>> On 5/4/2021 4:39 PM, Peter Zijlstra wrote:
>>> On Tue, May 04, 2021 at 01:52:36AM -0500, Suravee Suthikulpanit wrote:
>>>
>>>> 2. Since AMD IOMMU PMU does not support interrupt mode, the logic
>>>>      can be simplified to always start counting with value zero,
>>>>      and accumulate the counter value when stopping without the need
>>>>      to keep track and reprogram the counter with the previously read
>>>>      counter value.
>>>
>>> This relies on the hardware counter being the full 64bit wide, is it?
>>>
>>
>> The HW counter value is 48-bit. Not sure why it needs to be 64-bit?
>> I might be missing some points here? Could you please describe?
> 
> How do you deal with the 48bit overflow if you don't use the interrupt?

The IOMMU Perf driver does not currently handle counter overflow since the overflow
notification mechanism (i.e. IOMMU creates an EVENT_COUNTER_ZERO event in the IOMMU event log,
and generate an IOMMU MSI interrupt to signal IOMMU driver to process the event.) is not
currently supported. When counter overflows, the counter becomes zero, and Perf
reports value zero for the event.

Alternatively, to detect overflow, we might start counting with value 1 so that
we can detect overflow when the value becomes zero in which case the Perf driver
could generate error message.

Regards,
Suravee
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
