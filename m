Return-Path: <SRS0=mUms=NC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C40C4338F
	for <iommu@archiver.kernel.org>; Wed, 11 Aug 2021 13:46:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 691EB60FDA
	for <iommu@archiver.kernel.org>; Wed, 11 Aug 2021 13:46:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 691EB60FDA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0748F4059C;
	Wed, 11 Aug 2021 13:46:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wHl_Ok5XTWfW; Wed, 11 Aug 2021 13:46:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B602C40599;
	Wed, 11 Aug 2021 13:46:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9A45DC0010;
	Wed, 11 Aug 2021 13:46:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AF6CFC000E
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 13:46:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8D5B283A3C
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 13:46:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mB9pflIjbqCj for <iommu@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 13:46:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::603])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8326B839E7
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 13:46:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GBrHUH5VDSG05JdyNtXjSrfcdDNlOgpasLL8xOcLROuXLsiMQI7mC8ONZ6gy+bgxke1olHtajQ1hhNchZtuuPU0Zt3Pcpt2Imi53N9jP2ilY8vQ3dgKgKQIOZjkvluCg6+Msc/+CO8cADe3fNjgpolBuLNYG1kMwby1fgtpYhNwDioNzICciyuOQ5IJpHz/IFPYHMqqwvN7cj51rsorTbyyBeiMOsBAtz8J2HCQXokrLB6XU4fzf2sL5M5uhTPAFPvP5suk5h1FPxG8G0z5ddp0lG2W6OZeJENh5Js3XYJfhvTk3oPJfdlGL+uxINg/CWbno2SPRcMnZRHyZzm5l6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJXhoyIEHdk/nKXnSwu49KMd1tj6KuVkeCgG+CQVAd0=;
 b=D8cYDEpR9cGmKkHb2Zmesr2i1zGR8mSozFp1VyQIMbhxHfkakoTUhNUY2/A5DFT/wtYsHU1HScMbn2TZoV7ZhnhBNVEUd59PQHH41Y7wfw1N16LQxtErcJ9lqJksUJWCwSzkTWmE2BqN7TL/XXf9kba/nBqv9Yuq2vXcT5m+12wPpywz7M7Po1fQkPlugHqhOFKkjhjM8CxquvHKv6A0CFUAV77OqUe4cUM5whWS53s3e5owX5HkoYV+rix5xr9CqQkybfhrTJrF/gQoNscYBb6n1PXtzPoenB3DC8Q6OrlUR4QfjB+SW6pxypdXiuZEm7Tx673sAFU9DObv2l4uJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJXhoyIEHdk/nKXnSwu49KMd1tj6KuVkeCgG+CQVAd0=;
 b=zEVmMtPxwDu7oVzb+d5ynFuhQ4mx8s7goV67pqgIGBWy6V09Ijm0taFxiU5tbjEn+O2q6doT+V+evOsvH7AqYa/DZ+M26IMye/eYe+42mSGO4p/F55cdAADyOrWslZovBZA/7wTO1mT9s4qGQ2ThQcVyTyWuZ1+l5SCE83EgBFs=
Authentication-Results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Wed, 11 Aug
 2021 13:46:29 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418%6]) with mapi id 15.20.4415.016; Wed, 11 Aug 2021
 13:46:29 +0000
Subject: Re: [PATCH RFC 0/2] dma-pool: allow user to disable atomic pool
To: Baoquan He <bhe@redhat.com>, rientjes@google.com
References: <20210624052010.5676-1-bhe@redhat.com>
 <YNQ258KHlzlajqo/@infradead.org> <20210624092930.GA802261@MiWiFi-R3L-srv>
 <8b3d4e02-6e94-ad59-a480-fed8e55c009a@arm.com>
 <20210805065410.GA2051@MiWiFi-R3L-srv>
 <5df93c4e-ffdd-88c5-db4a-1a09826d047a@amd.com>
 <20210811022327.GF23322@MiWiFi-R3L-srv>
Message-ID: <615cfd68-b1c2-f2d0-0c03-1271a913cef2@amd.com>
Date: Wed, 11 Aug 2021 08:46:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210811022327.GF23322@MiWiFi-R3L-srv>
Content-Language: en-US
X-ClientProxiedBy: SN7P222CA0027.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::30) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.241] (165.204.77.1) by
 SN7P222CA0027.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.16 via Frontend Transport; Wed, 11 Aug 2021 13:46:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 312b2569-c0c6-4320-8ca8-08d95cce6c0e
X-MS-TrafficTypeDiagnostic: DM8PR12MB5400:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB54003471DEDC37E7AC082C73ECF89@DM8PR12MB5400.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JxuH8Z62K3sly11p7SF4X4DQ7qBoXAe0U5F2jIpkRVz/BX5ImMY2iOWyM8m9fXo/IWszii904z4Mwj1767v1+hDI1ZfVXJ07Xuqj6LEJ0RLGj6ZHzBa9f5zZIvtQahhsIsrEXiXG6yPEIBdJEcyPsNiZJhjTvNJrIXthRWH6re8K/xcQLq2u5/ISqndXbpnby6ticiKGkdKQStZp5t7KD2Ycrg2CroEKFQuVLvGKBNVxi08AJvSnWKbcO/ZZTTthEguhjYwKfZu0bBgame2dErxYgTJyLmpvMxkyZ6Wn+pHAubCBFsVoX9paqpxFHbczWH6mEEwDf5Ptv4ucdHv3/gCMZQ6kWFwvRp9FO47PApmyufABuebYF0WmI6BD46Vc+oF8gfduaieiire7NqhQznZ55QLYlxl96Jl2MofufMww8r1ZyWWELuBsc2SDjJkDueNqAFkgpzFRg+HuPjF2JhFmUvpI4hbfh3eVYcl0sjT6YNn4IwzzxIm/lIYyc0hh7zcJFiCUDTcYVRsK59bmBdqBupmACaxM61A2XLxNGIkCdXsLaj4oRZoTNCRax4f+yQiVJGN0wxbfzIelnqZT/yoTWJ1KXF+2oIL7cAyKU1Vk8+qJX5j4QFag/GWMGUyCVi+aajIxW2E0D6dfWQFNtNxYDO7hFEOnX7mrze3Zs4EVpqsI0GRKYxtg8FxCKakNLzpL5i7sjDP/fMqjtAui0nnyk0g1HbJZObyITKIT15s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5229.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2616005)(31686004)(54906003)(6486002)(956004)(53546011)(8936002)(66556008)(8676002)(16576012)(5660300002)(66476007)(66946007)(316002)(38100700002)(4326008)(36756003)(83380400001)(26005)(7416002)(508600001)(2906002)(86362001)(31696002)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmdFdnZaaHhiOThUOEhINDlKWVoyQi9pNU5hbWp5WTh2TnFadmJFZHRMT01i?=
 =?utf-8?B?WjNpMHExK1ZlV0VGbUhQOFpycU5QbmFZOUNzR2x4eXloUE5MK3BCZzJZUUx6?=
 =?utf-8?B?UmZteXlGV1hRRjhuMUtGNG9MZTlabEowanR1RXJPNXFKWHlueURTVmxPZm1M?=
 =?utf-8?B?TWR0b2xpNlgwSWp3Rlg2TTkzY3krUUkycjRzWlYvbndlQ0VEOEUxK1RnQWI2?=
 =?utf-8?B?d1BnbGxrMmlXWFFmWTZZcXM3cnVtQkdJeHdhaCtUM3p1L0FsVWlLUDBwTXF4?=
 =?utf-8?B?MXlOSjVlNGZ6L0NBMXpIM3RzVy84WWNGZmk3SGp0NGszb0h4Y0VyRnFuOVhs?=
 =?utf-8?B?NnFOL1JxYjJYREhrb21TV3Vyb0RmZmN5YTY1Vk96OGl2VzBSS3pkdlFtZGVa?=
 =?utf-8?B?RGhma0lHbUpGak43OC9yWGVFWmpEZXFDWjRUb1R5YXladUdCWkpndVRpbzF5?=
 =?utf-8?B?WG4yalBMVnNGdGxwd0pVL0pOUkNvVU1lUUdBN2l1VWo5TDY0Wlp2YWh4SGZr?=
 =?utf-8?B?a3pTNHdqNW15TC81WmZmcW1kT3hNQnpjTndScXMwNTNOazgydmI4WVNFYkVE?=
 =?utf-8?B?ayt1L200emRmZHhITEJId1ViYlBKa081QWd2bk1nN3hhd1VEaXducFJZTU1z?=
 =?utf-8?B?bjhOYmEzNTVGUmJzd3BzNWNKOHVyTkxvQVFPWXR1d1FoQWxuekhkSDhqRlJV?=
 =?utf-8?B?b05lSHhaci8zTC84RGk3ckhnOWM2UGlkNVNvTU81UjdsZnN3ZUxUZEt3ZGlV?=
 =?utf-8?B?ODBSNlNocVU2MWpmN3E1cXZnZUxZZ1M0UytqWFZJakM5Y0QzbTZCWU55eUhE?=
 =?utf-8?B?NHQwaDAweFkranpWdXRnMW9KS2IwMGFvcnIxM2p4QU8ydkxtWmVaTUZKS1Fm?=
 =?utf-8?B?dEd3dHBHQmR2bDZCb3RMdUhPaWR2Z1NkeldCZGU5V21jeWlKRGpXZ0Y2em1m?=
 =?utf-8?B?dGFKNGFYYSttd3BCeDNTYTNZZGwwUmVoRWdKZkFNTUVSMWRLTmhnN05aUVkr?=
 =?utf-8?B?cHdLd3J4SWZwZXVPZjY3eEhFK2IxcWJIdit1Y0pmOUJyb2pER1JMRUxJR1RZ?=
 =?utf-8?B?dGk1c05XRlVJb3V5ODNKbGxULzJVSkh1WENJcSt4bXA2aXprVlZ6UEEyQXN1?=
 =?utf-8?B?MlZHQVBnM05kRHR3VmRKSFNBcVNxci90a0dDWmYyTmtHVDRLS0tpUy9rWDJu?=
 =?utf-8?B?WkJYV3pZWG5EejJxSkl0eW10UENiN0c3dHM5RGRlSE5KenQ2UjBQbUNEVlY3?=
 =?utf-8?B?RGtWSzYxd2hDQmpuNXJNemROZjAxSmI5dWJjczBUK1U5Z3hjUjd6MlhVL1Yy?=
 =?utf-8?B?ZVZUZkxNSCtYdGR1VGl4eVI4NkpPdU9HeDU3eHpJNENOTFpuakpPWEdtaWFq?=
 =?utf-8?B?d0VFMEpaaFNiRnhCSVBwdFF6R2phVUd4cnFZS09PUmN2Szk2dmxqRkIzOGRM?=
 =?utf-8?B?VFdweko0TThVRDVyMk5UT3hpeEVjd0JFQXU1SnB3ZVRkVGw2Z09VeXU1SEU1?=
 =?utf-8?B?by9VcGV6V1gyTW1UaktMcWhSeFl3UEdYeElUUFhtcFpsTDdlZ1pCcXYwLzll?=
 =?utf-8?B?TEQyQUFJUDJhdGNKSnNRZllhSHY5U3lTWUZqaUY0WmtvS1JrU0lSVGZMTXVv?=
 =?utf-8?B?SFBSL3ZQdHJnUXozc0dzUGpXazhkancyN05sMnBXNWFGY0g5c0Y1WFdMOWls?=
 =?utf-8?B?djRLWDBEWFRlMjIwYTh2QUp4ekVTKzFYcGt2OFcrZ3ZPUWwwbGFzdkNmczZu?=
 =?utf-8?Q?MjsNHMNKEdMGbnwKsqCxkhXOt0/EN679zzBhU1t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 312b2569-c0c6-4320-8ca8-08d95cce6c0e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2021 13:46:29.7886 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l6Y8YXp/S9ncWv6l3/L3E1MVa6ZEFju4swoKiN2sfpLOD+H2qYvESgUwIciXYu+m5rFbMELJsxsWC+nGc/Fa2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5400
Cc: brijesh.singh@amd.com, x86@kernel.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, rppt@linux.ibm.com,
 Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>
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

On 8/10/21 9:23 PM, Baoquan He wrote:
> On 08/10/21 at 03:52pm, Tom Lendacky wrote:
>> On 8/5/21 1:54 AM, Baoquan He wrote:
>>> On 06/24/21 at 11:47am, Robin Murphy wrote:
>>>> On 2021-06-24 10:29, Baoquan He wrote:
>>>>> On 06/24/21 at 08:40am, Christoph Hellwig wrote:

...

> Looking at the those related commits, the below one from David tells 
> that atomic dma pool is used when device require non-blocking and
> unencrypted buffer. When I checked the system I borrowed, it's AMD EYPC
> and SME is enabled. And it has many pci devices, as you can see, its 'ls
> pci' outputs 113 lines. But disabling the three atomic pools didn't
> trigger any error on that AMD system. Does it mean only specific devices
> need this atomic pool in SME/SEV enabling case? Should we add more
> details in document or code comment to make clear this? 

It very well could be just the devices being used. Under SME (bare metal),
if a device supports 64-bit DMA, then bounce buffers aren't used and the
DMA can be performed directly to encrypted memory, so there is no need to
issue a set_memory_decrypted() call, so I would assume it likely isn't
using the pool.

Under SEV, however, all DMA has to go through guest un-encrypted memory.
If you pass through a device that does dma_alloc_coherent() calls with
GFP_ATOMIC, then the pool will be needed.

Thanks,
Tom
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
