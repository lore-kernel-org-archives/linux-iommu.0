Return-Path: <SRS0=o4oj=NB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E73C4338F
	for <iommu@archiver.kernel.org>; Tue, 10 Aug 2021 20:52:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF353610A3
	for <iommu@archiver.kernel.org>; Tue, 10 Aug 2021 20:52:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AF353610A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 79FB940398;
	Tue, 10 Aug 2021 20:52:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5gqgTinJYP7X; Tue, 10 Aug 2021 20:52:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 333C24029B;
	Tue, 10 Aug 2021 20:52:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 03FFDC001A;
	Tue, 10 Aug 2021 20:52:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 28A94C000E
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 20:52:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 17D7A82894
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 20:52:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3mOiPWrPzf_x for <iommu@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 20:52:30 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1174582883
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 20:52:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y+SmW7Y/UcjRoEk/eC+qseDiVjDIgwvGnU6r2uiQVzlUpwcx7uLkRInPBwP8QvpqJFfBVh1p94f5Kz8JAdudJb6DkhugBoTXIDIR/l6FA/Io60L8LXWSHBVu+K+L6DIDE62AdRzliLvg11CUMV6PG6edd50XsqK0HwJUOJDU37Xz2P/tee+F2ZXlavMbamLjR2b0udy5F/CZirAMDLZESh3p1FrQyjPxp32KhaHIKpV2pVpKp5P6/IlxDWhI/11oz5W3mnJG2bVBfQmg6D0MS7NrvQQbDNokBKvySoMN6HXV8u8bdLJ8Aa4KRqB4+2OgNUcE6CKl+1tWNpebVmI6UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5K3Qa5+OV8hQbfze5VHUqY3Nqkkk/hQWB/pZSx6rem0=;
 b=mWEwcphXrjr6biDwgdwA0e29DuxX3oltnpD1cpGv++mld6YQ/0Mk2hlsfbbIbBupKXj/47DKiqd5mkgfuZE0mQWYyJW2k9ZlrZdL7ehh2aR397lGW3qe1iRYTNnKIT4OsBz3hNA3AfOvtCJnFYyJuBBSYFxnoSeshezaJ60NxyXC1sfzi3Z7u9WVPVTU3lV8sczbv/iq2pQy9neAdPtRqC28aHoS6CCgqkFrlZkMxb0c1AW369mWmgyfwpqiZemB5CXOTBOekDNmHKWd1Jm7daGiStf0FZrayQikaW8zq1wPDahgVqtpAOziLMz4Np37cZKbqRubpHCqFMP8UuMujg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5K3Qa5+OV8hQbfze5VHUqY3Nqkkk/hQWB/pZSx6rem0=;
 b=INqUbqcjOvoyjdpjwfm5vlW5vQJdOBQpP0yRYmH5kDeHpbOckkwRPErJlc9zwV4MAyVMizmH8oZI0kG1NHkIgkUdQaH3Ore4oNoh2PayGMrBWdnXS4nunpUMVMVT0/oViQdDu30paNtO/cNpzT4Z0uVUOuYGboWMyMywwnUF0XA=
Authentication-Results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5261.namprd12.prod.outlook.com (2603:10b6:5:398::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.18; Tue, 10 Aug
 2021 20:52:28 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::73:2581:970b:3208]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::73:2581:970b:3208%3]) with mapi id 15.20.4394.023; Tue, 10 Aug 2021
 20:52:28 +0000
Subject: Re: [PATCH RFC 0/2] dma-pool: allow user to disable atomic pool
To: Baoquan He <bhe@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@infradead.org>
References: <20210624052010.5676-1-bhe@redhat.com>
 <YNQ258KHlzlajqo/@infradead.org> <20210624092930.GA802261@MiWiFi-R3L-srv>
 <8b3d4e02-6e94-ad59-a480-fed8e55c009a@arm.com>
 <20210805065410.GA2051@MiWiFi-R3L-srv>
Message-ID: <5df93c4e-ffdd-88c5-db4a-1a09826d047a@amd.com>
Date: Tue, 10 Aug 2021 15:52:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210805065410.GA2051@MiWiFi-R3L-srv>
Content-Language: en-US
X-ClientProxiedBy: SA0PR11CA0205.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::30) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.241] (165.204.77.1) by
 SA0PR11CA0205.namprd11.prod.outlook.com (2603:10b6:806:1bc::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17 via Frontend
 Transport; Tue, 10 Aug 2021 20:52:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a7ed625-4ef6-45fc-7fa9-08d95c40c3b8
X-MS-TrafficTypeDiagnostic: DM4PR12MB5261:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5261B1ADE5AB944B54D215FDECF79@DM4PR12MB5261.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: croOIHbMl3TjdEhvQS9hu0pxkOJEW61JhUh7DDpxXmvgbzVo+KHk6i/JHZOq/doVvLDMZb54uHQ+QLBjPnDAUzoLxNOfsvwMT/6hOXO3AM9Ojs9uNTdetE8mSBSMCVZy6f2KgeJ3H72Dc/AGGrXqwW/m+yKMXcmdc9aMHOd627BtznH7/Vw6/a6rJWP2xoNk1OsYGZ1w5yxUYYbG22P/0Y4KWSzsLr1liI6vP3jNucbSTldkeiHiUC574qcxq142C9jHbgvKGkU2HbbvrQTIZkLPrrYOAuTXcLB9L9/il+Iu91O4xG2mWLO0sPvXjfdLF5+8DCNBDsen3NHFTNtW5CobtGgHdah5TKgjShYxaC74EwatyQD2xX06nJv0uq2bfeW3JXuiepAmb7INkDEQksZIIXQNwMD5XAKw3NyJup23BwUDmHiNOxDD6N/bW1rhFSBfl+yjZkSnFKQbyBflpYFT1Vk7D0e1WNLM/xbioEOZH5wzb4jDg8GeAMXm4/4ABBzDnr4iv4vU32jjSyxJr+nvvQ7H3YOrL5y3HvUDa4X2vk2IPhWvesFHSyiDPeGWykTMcNGmc0qfDCXWZC0zPjtfsxciboKK1y742YsDI7ziQPw1EG7iLMgT9Sl0qyFcuA/q5dd+U7zk8s4NvJyLK9l20safS2cALVvIs4PWNh3tfGXBfoCHgjBg7EZQySSXhX5YKcvvySVAbOMJjjmui4rYXoH17QG4h6HhajwEJaU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5229.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(396003)(136003)(346002)(366004)(4326008)(8936002)(86362001)(5660300002)(16576012)(2616005)(316002)(110136005)(6486002)(26005)(956004)(38100700002)(2906002)(7416002)(53546011)(31686004)(478600001)(8676002)(36756003)(31696002)(186003)(66476007)(66946007)(66556008)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlErMk5KQVdyZmRTVkYxZSt3OVBxZVg0cFpoZXJqUnJ5T2R0UGhVdVYzMWVB?=
 =?utf-8?B?VHI5NXRudTdWT2xBVFRucUg3NDF5YWFwc2U2ZTdhbytVcTNITmp3UURIY3dM?=
 =?utf-8?B?Qi9PMWtPTWRLTE9WSGxvODU1cWVUT05YRC9uaWNpcktxVm1BTTJBb2cwa3hq?=
 =?utf-8?B?QjlVWkxKU1VWWXQzK0lxU3h2S2pJSHpjSEVtVnFZQTZpYWF1VWljYmpCdzBa?=
 =?utf-8?B?WTMwSzhtOU13YkFpWHBIdFNjYVVlUmtPLzkza29mS0wvSmVwZEI3SjUva2R3?=
 =?utf-8?B?WVUwQUt3TkZybGh5ZlZEM05SdURDblhNODN4Q2UvNThhaUlTbU1iOU1SczhR?=
 =?utf-8?B?ZTV0RFA2MlBUQnQ5UVZ5TktOeHF1Mnh4d0xCWng2QzdMSUNrU242MnN1VG1k?=
 =?utf-8?B?RzV1aG1maWlSL2RTUTIzM1RIYVVWaEZHdkxBVXV0VjhnMFN1VmZucCtZc243?=
 =?utf-8?B?eW5laWpGaFVmQ2RLYm9BaklzZEFvTDRFVURoSzNwQ2dqY2JXalBhaDNEdFRL?=
 =?utf-8?B?WDR2OUVpeWdEQS9QdUJyeDQ4aE5aeVdWM2YwOE9CYk41bkwzTkdlM3FKREFW?=
 =?utf-8?B?QVcrYkFXQTVPOFU1RGE2SXZnZDdwVzhDbDE0MEdVa2xHbkdkam1sNytweER3?=
 =?utf-8?B?ZFBYa3JmaFU3cFVNNkxDVkpDMmZpVFFyd1N5cTJwTGFEVmFpYVBhU1pwdFNw?=
 =?utf-8?B?ek53Rkt6YURiUjhYZzB1TEt0VEpHNU9ObGJHNHBXWFJwdEtDT0xFYk4zVUFG?=
 =?utf-8?B?Wm9ZTExLOUM4TWN4OWhJZWNUSjgwQWJYeTJZS2hLRi92YXVJU3N0OEdmcHJL?=
 =?utf-8?B?L0hVRnozWnhpZU5jT29kTUIyaW1NeHdmSU5aN1RDZjI0SUJ4Y3FDZ1FnVFdp?=
 =?utf-8?B?OVAyemVKVDJHakdSeEpYL2FrdTRhYi85dUdOKzh6NDMyRjl3NllyRlRsakpF?=
 =?utf-8?B?bG5xdjgxL1QyMmk1bGZFNWFtbEs5L0ZFTnRJTTZiVTdrbnVxbzVDMEV4QjVo?=
 =?utf-8?B?SGlVc1hXSVdyWTVNc0NPMndnZGtKRFkwV0c2VXVKRjc0ckpEbmNsZjBBRGJC?=
 =?utf-8?B?a3BMR0pndEhGZnRtZXJ5b1YzSkllRnJQYy93aG9DZGtRRTNHd1dRTXlZbTdy?=
 =?utf-8?B?THBqbGM2bVR3dVhyNTdSOGtRanIrUFVhNUtMbjJrUUZqVzdNQ3Rsb1cxdDVs?=
 =?utf-8?B?V2xXcWh1bXRYa09zeTVKQWNvbk9jN0pQMkFpTzJWNGk0dzZ2djdFODRZVzBW?=
 =?utf-8?B?bXA5QUcrUVdNZjI1TkNYcUcvVFZIZ25MeFZZNmNUWExzdWZ0QlZTcWZQbzNI?=
 =?utf-8?B?cWJkdE9ZU203NEFUSlBPUllhNFpZNVdPRTBtQS92ZHpkU2FSc24vTVppMWI1?=
 =?utf-8?B?dWRtVTNFUTNXeFN6SjU4NXBoYnVURkdqMlVWQ1hJc2VqUGdnUEpDT2wra3pJ?=
 =?utf-8?B?ekNYSXp6Y3hRS1ppcytOeWNvQmNMZkk4eHNZc1RNN0w0ZDlSdzNkVWVkSC82?=
 =?utf-8?B?ZTZvVkd6SFdXMWdaNEwyZFkvVm0rYUlQWE5VbjNHbElCMWpUb3FCM3NqZzJS?=
 =?utf-8?B?WHlvRW43Z0RROW9NdjRxOFZXMjkwdk9YODJoVVhxT2NsaWxlWHh1SWlKelk3?=
 =?utf-8?B?OUJCZ00yeUtXOFgvNE1zWWE4Ukx5U3p3azM2aU5rdW1HeHo5ZTBIYTBCQWQ0?=
 =?utf-8?B?RXNvbWRDTFN6bEJ3RGhRNVdlWGkyUlBJMGdjUGlKOXdkb0RwZkthUmJSK2Z0?=
 =?utf-8?Q?Qqr3uCb+GWQxYV3JatMtz/SZvdVpNYW1Nv6cgqR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a7ed625-4ef6-45fc-7fa9-08d95c40c3b8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 20:52:28.1892 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n3y2f6IxTbtTp2uh4uB+f+KwyiIHh7CpFTA7vj5q2qDRtjNXYkCmp/HT503JqrkGzDuXuEfu2kECeJs0PEXmIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5261
Cc: brijesh.singh@amd.com, x86@kernel.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, rppt@linux.ibm.com, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, rientjes@google.com
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
From: Tom Lendacky via iommu <iommu@lists.linux-foundation.org>
Reply-To: Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 8/5/21 1:54 AM, Baoquan He wrote:
> On 06/24/21 at 11:47am, Robin Murphy wrote:
>> On 2021-06-24 10:29, Baoquan He wrote:
>>> On 06/24/21 at 08:40am, Christoph Hellwig wrote:
>>>> So reduce the amount allocated.  But the pool is needed for proper
>>>> operation on systems with memory encryption.  And please add the right
>>>> maintainer or at least mailing list for the code you're touching next
>>>> time.
>>>
>>> Oh, I thoutht it's memory issue only, should have run
>>> ./scripts/get_maintainer.pl. sorry.
>>>
>>> About reducing the amount allocated, it may not help. Because on x86_64,
>>> kdump kernel doesn't put any page of memory into buddy allocator of DMA
>>> zone. Means it will defenitely OOM for atomic_pool_dma initialization.
>>>
>>> Wondering in which case or on which device the atomic pool is needed on
>>> AMD system with mem encrytion enabled. As we can see, the OOM will
>>> happen too in kdump kernel on Intel system, even though it's not
>>> necessary.
> 
> Sorry for very late response, and thank both for your comments.
> 
>>
>> Hmm, I think the Kconfig reshuffle has actually left a slight wrinkle here.
>> For DMA_DIRECT_REMAP=y we can assume an atomic pool is always needed, since
>> that was the original behaviour anyway. However the implications of
>> AMD_MEM_ENCRYPT=y are different - even if support is enabled, it still
>> should only be relevant if mem_encrypt_active(), so it probably does make
>> sense to have an additional runtime gate on that.
> 
>>
>> From a quick scan, use of dma_alloc_from_pool() already depends on
>> force_dma_unencrypted() so that's probably fine already, but I think we'd
>> need a bit of extra protection around dma_free_from_pool() to prevent
>> gen_pool_has_addr() dereferencing NULL if the pools are uninitialised, even
>> with your proposed patch as it is. Presumably nothing actually called
>> dma_direct_free() when you tested this?
> 
> Yes, enforcing the conditional check of force_dma_unencrypted() around
> dma_free_from_pool sounds reasonable, just as we have done in
> dma_alloc_from_pool().
> 
> I have tested this patchset on normal x86_64 systems and one amd system
> with SME support, disabling atomic pool can fix the issue that there's no
> managed pages in dma zone then requesting page from dma zone will cause
> allocation failure. And even disabling atomic pool in 1st kernel didn't
> cause any problem on one AMD EPYC system which supports SME. I am not
> expert of DMA area, wondering how atomic pool is supposed to do in
> SME/SEV system. 

I think the atomic pool is used by the NVMe driver. My understanding is
that driver will do a dma_alloc_coherent() from interrupt context, so it
needs to use GFP_ATOMIC. The pool was created because dma_alloc_coherent()
would perform a set_memory_decrypted() call, which can sleep. The pool
eliminates that issue (David can correct me if I got that wrong).

Thanks,
Tom

> 
> Besides, even though atomic pool is disabled, slub page for allocation
> of dma-kmalloc also triggers page allocation failure. So I change to
> take another way to fix them, please check v2 post. The atomic pool
> disabling an be a good to have change.
> 
> Thanks
> Baoquan
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
