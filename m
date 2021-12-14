Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B696EC433FE
	for <iommu@archiver.kernel.org>; Tue, 14 Dec 2021 08:06:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6B7DA802CF;
	Tue, 14 Dec 2021 08:06:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9CM84KotNhPz; Tue, 14 Dec 2021 08:06:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2EF888136E;
	Tue, 14 Dec 2021 08:06:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EBC5AC001E;
	Tue, 14 Dec 2021 08:05:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AC081C0012
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 08:05:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 997408136E
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 08:05:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YnWWP15SWpNe for <iommu@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 08:05:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 80817802CF
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 08:05:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMMRlNJl2nYT1TQRIGtlHido9zNnokOgMWzLS3ImeL5CBDIFeF8HjGezRiVizD3Gz5aB5ku7FQ04SVCf21I6c2zQ2BqDrCHd1p5My7NYibbHMv/w7cs5dEfgOs+/bQrsrAPDh7/P1Ydu1HCHN3mWOMn4lBimvsix7zNhB2Y9GNmhFkoxGmkwJqbZ7OHAE5U+qf0T1ULWri68ScRu3wXXlrxKuy+5pUkEXQF48hKqJXjPdFjBKEpIzVpfan94Is1Ewgq6NbkjCGHMpub1k1KMRLP7vau+TQY5H28Qv/tDOZGRODN6tqGAv+Hcgb8WN5pCD+rWEr30nX3iBmtPQPUTDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLcmzIxeUTHQv3CLVxBTLK4oXGEcEUu3vNUFF9W/R7Y=;
 b=clatfSfhkMam6SZFVMJlLQdwxYGveVLwHMDE959+92gWe4E3O3o8+M1QJs84d/aLxwcEeygknQdvKoQJMcUuch9pxFlamTDNCmbWeRJEqz4uIaPQxJwN3ieVw0FDKIvZns0yjjBav0OxcdHLml9Pt2Stj4T3x+gBJ710KQ5n7UOhD8YKRud+sDD/EtD7MlWcPlLQ+RPBZv6wmizj3z8XIQHB6jAtJlWvRe3RIxVP0AOOxd8kJVAXFrE3vyz7uZTI4v+Vbdcr4bI+cq4YKyYObcJek1n/cPgPSyTmG7z+gSuFIFcc2fl44jD9a0flfBSFk5nRgqgdUVStK9YRI2JF5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLcmzIxeUTHQv3CLVxBTLK4oXGEcEUu3vNUFF9W/R7Y=;
 b=to1o1ZL7zxkroG+K1btNDmfQuVaDID1YJrpAzWJY84XGglY8uHmsPi43BHvbJQh9xhEELS0lzJD8WdvctuSrbCdMDq2jWJd5vaj1Bh75drIKjOSRHl5LUScWBXI2xlA9xCmMFsvY2KAf4u8iC1hXQgs+VGsQDdJzBL4KFi77ZwbgAqPjWjxOjeWglkCmO5mLFYH1rAojhoojXRxwdXfzDJRCWAWzhYcwIXMCa+5ZDjqA1Ygrxt24OUzC9JflceoQdMyDX+KpMXLtI7x4xzUb4m6y64NVrtlQyXeGaQxIQuAA8KkDIbTJeh/+gpINrtuHUUaqNgZM6fzLDybY3tPlKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 CO6PR12MB5476.namprd12.prod.outlook.com (2603:10b6:303:138::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Tue, 14 Dec
 2021 08:05:54 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ecac:528f:e36c:39d0]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ecac:528f:e36c:39d0%5]) with mapi id 15.20.4755.022; Tue, 14 Dec 2021
 08:05:54 +0000
Subject: Re: [PATCH v2 0/8] Host1x context isolation support
To: joro@8bytes.org, will@kernel.org, robh+dt@kernel.org, robin.murphy@arm.com
References: <20210916143302.2024933-1-mperttunen@nvidia.com>
 <10de82cf-27a5-8890-93a5-0e58c74e5bcc@kapsi.fi>
 <c382fb0e-6b73-5ca0-7f63-d2843351325e@nvidia.com>
Message-ID: <91dddccd-a6c1-21b3-34d6-6a8082a386e7@nvidia.com>
Date: Tue, 14 Dec 2021 08:05:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <c382fb0e-6b73-5ca0-7f63-d2843351325e@nvidia.com>
Content-Language: en-US
X-ClientProxiedBy: LO2P265CA0088.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::28) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
Received: from [IPv6:2a00:23c7:b086:2f00:c7fc:fb79:689a:806f]
 (2a00:23c7:b086:2f00:c7fc:fb79:689a:806f) by
 LO2P265CA0088.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:8::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=) via Frontend Transport;
 Tue, 14 Dec 2021 08:05:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ac27056-e76f-4196-961f-08d9bed88d2c
X-MS-TrafficTypeDiagnostic: CO6PR12MB5476:EE_
X-Microsoft-Antispam-PRVS: <CO6PR12MB54769290039DCBA5F5708A68D9759@CO6PR12MB5476.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S6trM5rUuLPkfKTldYclRGkOtp+QdJ8Whc09GMRLumuJQPZFJFasAG4otZxrHgwWarI99YwGUSxI+shbV4BIsTy0aZBmj8QmAXnAIJpsnofV+obYb1++NPhlH761waBioQfOg2MC3/vRlzifgxsjy9oXFhu56OJVZH71ZCH2GYTPLzBZAOfDSLH2ARTE8sxXqQ49wXFFx8st4QQaH/oMltDEpSnXdRjS5dyZNGOM8on5sbEz6vlwqBHelq8edsRF/pKPzWoVSZxqQ/8PmmQLeVldqGRxZ7kqUHqZB/aJgXUdbGVCjb4Znh34xeifyeq/JsE7LSYVmMu2UEXLfCYJ43RO8rtfDPclrl4ar9Ww+UTFQa7JnlG200M8LbXYgZH5+bEYKXUTDUtJiQ53xnyHg52pKH6Sqt7H4bLxr5rV8cGokdX3bOQq4zzrLGz5fgZnRVJKnNHtETHkMpkxvfkVsD4E7ZRLwc43chXhTsaD9+yCxLoDGS+yOQFtoyiCFcBRKbu31pIpwlykKs8X6WqaGiUKhNC86nzDDbxdIx9MOD9pT4j2t3tFNm7V76q9yIxPLRjy7qqeI6LT1m9EqMpbI1WkUGWQGb78cfOQJqAwgXvXyl/Ukdx7BYqpXvcNnRD1TtV0oifJlygsA6YY1aHLxilWfWCm9N1gaPKf02I6haoxoRvPbYzlHdaIuROzB3vzn8gRgNJG3mBnh/uXWfOGyuwFPMyGv5oKGObUW6+1m2MKsxW1fYnM6aN5VSl2wU03Qbvpb/IEshz5UO1GnTeduvnl92H/JYiIiMkcBbdmbcQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5444.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6666004)(8936002)(31696002)(508600001)(4326008)(316002)(186003)(83380400001)(36756003)(38100700002)(2906002)(2616005)(31686004)(54906003)(8676002)(7416002)(66946007)(6486002)(66556008)(66476007)(86362001)(5660300002)(53546011)(32563001)(43740500002)(45980500001)(357404004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3p6bC80YlBBaDdWTlNmZ2xaZ0tFQ1F6bVJaVE5WYTVRV0gxYmlYMU5RL1d6?=
 =?utf-8?B?TkVWNGdTSm5QUThWNnB3T2k5Q3RENVhUKzNtVXN2NFBaRDNzWTJ5TGRuRVg0?=
 =?utf-8?B?UERMcFhDQXUxNkx4dTVETlozc0xRUE1RZlI5NmNaM2JQUGV1Ty91TnFqUW1m?=
 =?utf-8?B?K3hBZlAzeUV4cTFRTzFwbyszOUxxRHpXVGpjOTdiRzFic0hxOTBDakorVkQz?=
 =?utf-8?B?TjJLVGRSbHFFYkF5TVIrUzZySDltWXk2MWVUKyt1QzZ2UmtsMksvS0FucDU2?=
 =?utf-8?B?VTZmT3dyc1o2bHgzY25ZZzNRRlJqdUxkcHNqMXg3TXY3RjA3ZlRmUVpwMUVq?=
 =?utf-8?B?bExjV21aOXFWb3dSYWVoajFBdi9wQXFTcTBVTDlBTGhOZ0dsdituRDRYbWRz?=
 =?utf-8?B?c3ZEaVdqQ256V0M0ZDFjRkdXaGdRWEFJMWxkaVA0cUtkcDQ2ck1kbTcvVy9R?=
 =?utf-8?B?THdaeU9INFg5Qjh2SFlwMkg3anJmZUZWZ0lDUVNWendoSnBSMEVyQ2RDM2dZ?=
 =?utf-8?B?YUlrSU95c0xpMjVLRUU2M2htWlRKZ2lrcTlMbXVtZGRxcjM5SVQrZWducmhi?=
 =?utf-8?B?ejVTK2t3eFNoenAxVVdSUXFyNXZWRkphbk1VQjE1REhDUE81b1E1bjZ5dHgz?=
 =?utf-8?B?SVFaby9OZk1wZFpRU0FmQWsxZWp5dG1EaXdkc1RaVCtRU04wdXUrZFZzNXFS?=
 =?utf-8?B?SVh1RHlyQThobzVrS1JpWnRlSjU3cDZod1RHdnZJWTdhZUErWjR1aUVTWHdk?=
 =?utf-8?B?MGdFZTE0c0I3MDZURTBzUm1JNEVOU1ltV1d3eFFWV1p5aU45M2NNZ1pYdk12?=
 =?utf-8?B?SEpSR1JtSGlKbEtscU1NT1F2RHl0VFNBaDJQY05qN1FYOUYwRHI1c3NoZ0dN?=
 =?utf-8?B?QnQwRWluVThLYW1iejZhYmNpeFRiRVU3YUtDU1M5akNCKzlScnRTSHBxc29H?=
 =?utf-8?B?dG16NHpRU1JGd3dsNnV4bHlTOFJSa1hRa1E1YWtXNXNJc0dKNGlNMk5RZEhj?=
 =?utf-8?B?V2JPQ3R5SUZrWDZDMVJwZHhOK2pzM0lxR1BDSk5EdkpuaVdQa2JJbTB1NG5W?=
 =?utf-8?B?bmFKakNPZHIxbk9yL2htd3pNaE43TXF4ZjhjTVFuV2xqa1U4ZWFsSklVSVBl?=
 =?utf-8?B?TnhSQzFjK2I0WlZaUVZCYWR2OVJvaDNFTUhuU3JCSmE3cU5OdGpMblV3MEJ3?=
 =?utf-8?B?cWVmK0grc2tZaTRWUWF1K3crMmxjaUxCS0ZWZGxFRHNNTC85N0xqM3VpdEw3?=
 =?utf-8?B?Q0F1b3U2S3VMamdabHZuek1rc1p5VEhCdGwzWDhLUUVUNXowdnBNZ0VEY1Zy?=
 =?utf-8?B?RXBETzdNQTRPUWRlSTBTVE5WbFVNcnQ3c2U1NXVIdzRPdVBmRVcxR0M3UEIz?=
 =?utf-8?B?REhjYTFlUndzelEvejlHWUFnMXltUkZmYUNrTFZmeFFQcXpuOWkrTWVNTTBT?=
 =?utf-8?B?NFBKSUlWTnF6QUx2b1FHWUdIeDU2bXNPaGJ2Vzc0eFQ4VFJ5bElRelpDeWxa?=
 =?utf-8?B?ZDVicTdObm5ncTRyZk04R0RQOHh1Tm4rNm0veTZoQnRqWmtZUzVtdmFNdHh5?=
 =?utf-8?B?a0d1UkdLNzRaMnhaNmVQQW02cEJ2V3N0Y3duL3dzcy9nK0JLM25teHptYW9T?=
 =?utf-8?B?UEdiOWNkR25RVGFJc1NKc09qTFNHVDdzZDcvY1g1OEVNM3o3NXloUG9URnJt?=
 =?utf-8?B?cG5HZTdUZUdhcWUxdG5zUnpSL0pjQU5MeFVybmpFTG5ET3JJYkZEOXpZZmF5?=
 =?utf-8?B?Z2hTSEdtUGNMMlJieEFDY1dtWXFpNWZmWVJ0aXU0ZkwwUHAycnRTWWFCMHNH?=
 =?utf-8?B?eWI2emFmTVBGdmY0QzdUTStzOXJ1bEEwQ0FXUHQrUE1nRFVNWXBoaHlNbE5R?=
 =?utf-8?B?eDhEUTFJcTNXcFY3WjNCMGxuWE9ObDM0MW1yQldtZFZFR3V0QTQvR1VOMnpM?=
 =?utf-8?B?R2g0VEkyTm11T2Y4OXdRdHVQL2xaZ1IyU3UwWnJRN25yelV0RVYrbEpwREtR?=
 =?utf-8?B?blNlck5YVnAzclpKeVp5dmM5V0xnYmhQalFRaW1JOWs4R0hzUWhnMFZtSUpn?=
 =?utf-8?B?TTk3SCtqZGcySEVkb1Ntb1BDSUFqYmUrc0RjUFNZLzJudHk0RHBDd25RZkNQ?=
 =?utf-8?B?Q1BaNEhZRFFhS0Y1dkI1TUpjS1FQcWpROTZOR0ZjdG1MV1hRT251alVRbE1F?=
 =?utf-8?B?T21tUTh2SkJHNk5xQUxLWGdiRHRCVDQ0WmZGd1c2ZmZFV1FXWmZZY0RsaXZT?=
 =?utf-8?Q?lrUX2HJZxZzMFbHvzdqbtWku8D9fx65tli8E5jIUKw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ac27056-e76f-4196-961f-08d9bed88d2c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 08:05:54.5326 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xr/laM2gf2391lqf76QI+Q+ufSyZH1ijF025YSeXUQ0MlmiLVthb6ZfbpeH34ZTNwPwBEAka2SmgVYwX/o8ZpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5476
Cc: devicetree@vger.kernel.org, Mikko Perttunen <cyndis@kapsi.fi>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Mikko Perttunen <mperttunen@nvidia.com>, iommu@lists.linux-foundation.org,
 thierry.reding@gmail.com, linux-tegra@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
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
From: Jon Hunter via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jon Hunter <jonathanh@nvidia.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

SGkgYWxsLAoKU3RpbGwgbm8gcmVzcG9uc2Ugb24gdGhpcyA6LSgKCk9uIDA2LzEyLzIwMjEgMDk6
NTUsIEpvbiBIdW50ZXIgd3JvdGU6Cj4gV2lsbCwgSm9lcmcsIFJvYiwKPiAKPiBPbiAwOC8xMS8y
MDIxIDEwOjM2LCBNaWtrbyBQZXJ0dHVuZW4gd3JvdGU6Cj4+IE9uIDkvMTYvMjEgNTozMiBQTSwg
TWlra28gUGVydHR1bmVuIHdyb3RlOgo+Pj4gSGkgYWxsLAo+Pj4KPj4+ICoqKgo+Pj4gTmV3IGlu
IHYyOgo+Pj4KPj4+IEFkZGVkIHN1cHBvcnQgZm9yIFRlZ3JhMTk0Cj4+PiBVc2Ugc3RhbmRhcmQg
aW9tbXUtbWFwIHByb3BlcnR5IGluc3RlYWQgb2YgY3VzdG9tIG1lY2hhbmlzbQo+Pj4gKioqCj4+
Pgo+Pj4gdGhpcyBzZXJpZXMgYWRkcyBzdXBwb3J0IGZvciBIb3N0MXggJ2NvbnRleHQgaXNvbGF0
aW9uJy4gU2luY2UKPj4+IHdoZW4gcHJvZ3JhbW1pbmcgZW5naW5lcyB0aHJvdWdoIEhvc3QxeCwg
dXNlcnNwYWNlIGNhbiBwcm9ncmFtIGluCj4+PiBhbnkgYWRkcmVzc2VzIGl0IHdhbnRzLCB3ZSBu
ZWVkIHNvbWUgd2F5IHRvIGlzb2xhdGUgdGhlIGVuZ2luZXMnCj4+PiBtZW1vcnkgc3BhY2VzLiBU
cmFkaXRpb25hbGx5IHRoaXMgaGFzIGVpdGhlciBiZWVuIGRvbmUgaW1wZXJmZWN0bHkKPj4+IHdp
dGggYSBzaW5nbGUgc2hhcmVkIElPTU1VIGRvbWFpbiwgb3IgYnkgY29weWluZyBhbmQgdmVyaWZ5
aW5nIHRoZQo+Pj4gcHJvZ3JhbW1pbmcgY29tbWFuZCBzdHJlYW0gYXQgc3VibWl0IHRpbWUgKEhv
c3QxeCBmaXJld2FsbCkuCj4+Pgo+Pj4gU2luY2UgVGVncmExODYgdGhlcmUgaXMgYSBwcml2aWxl
Z2VkIChvbmx5IHVzYWJsZSBieSBrZXJuZWwpCj4+PiBIb3N0MXggb3Bjb2RlIHRoYXQgYWxsb3dz
IHNldHRpbmcgdGhlIHN0cmVhbSBJRCBzZW50IGJ5IHRoZSBlbmdpbmUKPj4+IHRvIHRoZSBTTU1V
LiBTbywgYnkgYWxsb2NhdGluZyBhIG51bWJlciBvZiBjb250ZXh0IGJhbmtzIGFuZCBzdHJlYW0K
Pj4+IElEcyBmb3IgdGhpcyBwdXJwb3NlLCBhbmQgdXNpbmcgdGhpcyBvcGNvZGUgYXQgdGhlIGJl
Z2lubmluZyBvZgo+Pj4gZWFjaCBqb2IsIHdlIGNhbiBpbXBsZW1lbnQgaXNvbGF0aW9uLiBEdWUg
dG8gdGhlIGxpbWl0ZWQgbnVtYmVyIG9mCj4+PiBjb250ZXh0IGJhbmtzIG9ubHkgZWFjaCBwcm9j
ZXNzIGdldHMgaXRzIG93biBjb250ZXh0LCBhbmQgbm90Cj4+PiBlYWNoIGNoYW5uZWwuCj4+Pgo+
Pj4gVGhpcyBmZWF0dXJlIGFsc28gYWxsb3dzIHNoYXJpbmcgZW5naW5lcyBhbW9uZyBtdWx0aXBs
ZSBWTXMgd2hlbgo+Pj4gdXNlZCB3aXRoIEhvc3QxeCdzIGhhcmR3YXJlIHZpcnR1YWxpemF0aW9u
IHN1cHBvcnQgLSB1cCB0byA4IFZNcwo+Pj4gY2FuIGJlIGNvbmZpZ3VyZWQgd2l0aCBhIHN1YnNl
dCBvZiBhbGxvd2VkIHN0cmVhbSBJRHMsIGVuZm9yY2VkCj4+PiBhdCBoYXJkd2FyZSBsZXZlbC4K
Pj4+Cj4+PiBUbyBpbXBsZW1lbnQgdGhpcywgdGhpcyBzZXJpZXMgYWRkcyBhIG5ldyBob3N0MXgg
Y29udGV4dCBidXMsIHdoaWNoCj4+PiB3aWxsIGNvbnRhaW4gdGhlICdzdHJ1Y3QgZGV2aWNlJ3Mg
Y29ycmVzcG9uZGluZyB0byBlYWNoIGNvbnRleHQKPj4+IGJhbmsgLyBzdHJlYW0gSUQsIGNoYW5n
ZXMgdG8gZGV2aWNlIHRyZWUgYW5kIFNNTVUgY29kZSB0byBhbGxvdwo+Pj4gcmVnaXN0ZXJpbmcg
dGhlIGRldmljZXMgYW5kIHVzaW5nIHRoZSBidXMsIGFzIHdlbGwgYXMgdGhlIEhvc3QxeAo+Pj4g
c3RyZWFtIElEIHByb2dyYW1taW5nIGNvZGUgYW5kIHN1cHBvcnQgaW4gVGVncmFEUk0uCj4+Pgo+
Pj4gRGV2aWNlIHRyZWUgYmluZGluZ3MgYXJlIG5vdCB1cGRhdGVkIHlldCBwZW5kaW5nIGNvbnNl
bnN1cyB0aGF0IHRoZQo+Pj4gcHJvcG9zZWQgY2hhbmdlcyBtYWtlIHNlbnNlLgo+Pj4KPj4+IFRo
YW5rcywKPj4+IE1pa2tvCj4+Pgo+Pj4gTWlra28gUGVydHR1bmVuICg4KToKPj4+IMKgwqAgZ3B1
OiBob3N0MXg6IEFkZCBjb250ZXh0IGJ1cwo+Pj4gwqDCoCBncHU6IGhvc3QxeDogQWRkIGNvbnRl
eHQgZGV2aWNlIG1hbmFnZW1lbnQgY29kZQo+Pj4gwqDCoCBncHU6IGhvc3QxeDogUHJvZ3JhbSBj
b250ZXh0IHN0cmVhbSBJRCBvbiBzdWJtaXNzaW9uCj4+PiDCoMKgIGlvbW11L2FybS1zbW11OiBB
dHRhY2ggdG8gaG9zdDF4IGNvbnRleHQgZGV2aWNlIGJ1cwo+Pj4gwqDCoCBhcm02NDogdGVncmE6
IEFkZCBIb3N0MXggY29udGV4dCBzdHJlYW0gSURzIG9uIFRlZ3JhMTg2Kwo+Pj4gwqDCoCBkcm0v
dGVncmE6IGZhbGNvbjogU2V0IERNQUNUWCBmaWVsZCBvbiBETUEgdHJhbnNhY3Rpb25zCj4+PiDC
oMKgIGRybS90ZWdyYTogdmljOiBJbXBsZW1lbnQgZ2V0X3N0cmVhbWlkX29mZnNldAo+Pj4gwqDC
oCBkcm0vdGVncmE6IFN1cHBvcnQgY29udGV4dCBpc29sYXRpb24KPj4+Cj4+PiDCoCBhcmNoL2Fy
bTY0L2Jvb3QvZHRzL252aWRpYS90ZWdyYTE4Ni5kdHNpwqAgfMKgIDEyICsrCj4+PiDCoCBhcmNo
L2FybTY0L2Jvb3QvZHRzL252aWRpYS90ZWdyYTE5NC5kdHNpwqAgfMKgIDEyICsrCj4+PiDCoCBk
cml2ZXJzL2dwdS9NYWtlZmlsZcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB8wqDCoCAzICstCj4+PiDCoCBkcml2ZXJzL2dwdS9kcm0vdGVncmEvZHJtLmjCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDIgKwo+Pj4gwqAgZHJpdmVycy9ncHUvZHJtL3Rl
Z3JhL2ZhbGNvbi5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCA4ICsKPj4+IMKgIGRyaXZl
cnMvZ3B1L2RybS90ZWdyYS9mYWxjb24uaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMSAr
Cj4+PiDCoCBkcml2ZXJzL2dwdS9kcm0vdGVncmEvc3VibWl0LmPCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHzCoCAxMyArKwo+Pj4gwqAgZHJpdmVycy9ncHUvZHJtL3RlZ3JhL3VhcGkuY8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAzNCArKysrLQo+Pj4gwqAgZHJpdmVycy9ncHUvZHJtL3Rl
Z3JhL3ZpYy5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMzggKysrKysKPj4+IMKg
IGRyaXZlcnMvZ3B1L2hvc3QxeC9LY29uZmlnwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHzCoMKgIDUgKwo+Pj4gwqAgZHJpdmVycy9ncHUvaG9zdDF4L01ha2VmaWxlwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAyICsKPj4+IMKgIGRyaXZlcnMvZ3B1L2hvc3QxeC9jb250
ZXh0LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDE3NCArKysrKysrKysrKysrKysrKysr
KysrCj4+PiDCoCBkcml2ZXJzL2dwdS9ob3N0MXgvY29udGV4dC5owqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgfMKgIDI3ICsrKysKPj4+IMKgIGRyaXZlcnMvZ3B1L2hvc3QxeC9jb250ZXh0X2J1
cy5jwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAzMSArKysrCj4+PiDCoCBkcml2ZXJzL2dwdS9ob3N0
MXgvZGV2LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxMiArLQo+Pj4g
wqAgZHJpdmVycy9ncHUvaG9zdDF4L2Rldi5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB8wqDCoCAyICsKPj4+IMKgIGRyaXZlcnMvZ3B1L2hvc3QxeC9ody9jaGFubmVsX2h3LmPC
oMKgwqDCoMKgwqDCoCB8wqAgNTIgKysrKysrLQo+Pj4gwqAgZHJpdmVycy9ncHUvaG9zdDF4L2h3
L2hvc3QxeDA2X2hhcmR3YXJlLmggfMKgIDEwICsrCj4+PiDCoCBkcml2ZXJzL2dwdS9ob3N0MXgv
aHcvaG9zdDF4MDdfaGFyZHdhcmUuaCB8wqAgMTAgKysKPj4+IMKgIGRyaXZlcnMvaW9tbXUvYXJt
L2FybS1zbW11L2FybS1zbW11LmPCoMKgwqDCoCB8wqAgMTMgKysKPj4+IMKgIGluY2x1ZGUvbGlu
dXgvaG9zdDF4LmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMjEg
KysrCj4+PiDCoCBpbmNsdWRlL2xpbnV4L2hvc3QxeF9jb250ZXh0X2J1cy5owqDCoMKgwqDCoMKg
wqAgfMKgIDE1ICsrCj4+PiDCoCAyMiBmaWxlcyBjaGFuZ2VkLCA0ODggaW5zZXJ0aW9ucygrKSwg
OSBkZWxldGlvbnMoLSkKPj4+IMKgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2dwdS9ob3N0
MXgvY29udGV4dC5jCj4+PiDCoCBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9ncHUvaG9zdDF4
L2NvbnRleHQuaAo+Pj4gwqAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvZ3B1L2hvc3QxeC9j
b250ZXh0X2J1cy5jCj4+PiDCoCBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9saW51eC9ob3N0
MXhfY29udGV4dF9idXMuaAo+Pj4KPj4KPj4gSU9NTVUvRFQgZm9sa3MsIGFueSB0aG91Z2h0cyBh
Ym91dCB0aGlzIGFwcHJvYWNoPyBUaGUgcGF0Y2hlcyB0aGF0IGFyZSAKPj4gb2YgaW50ZXJlc3Qg
b3V0c2lkZSBvZiBIb3N0MXgvVGVncmFEUk0gc3BlY2lmaWNzIGFyZSBwYXRjaGVzIDEsIDIsIDQs
IAo+PiBhbmQgNS4KPiAKPiAKPiBBbnkgZmVlZGJhY2sgb24gdGhpcz8KPiAKPiBKb24KPiAKCi0t
IApudnB1YmxpYwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
