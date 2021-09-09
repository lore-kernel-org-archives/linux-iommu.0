Return-Path: <SRS0=9mGv=N7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5397C433EF
	for <iommu@archiver.kernel.org>; Thu,  9 Sep 2021 13:02:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5168E61051
	for <iommu@archiver.kernel.org>; Thu,  9 Sep 2021 13:02:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5168E61051
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1335960B0B;
	Thu,  9 Sep 2021 13:02:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J4lfYZE1k2gp; Thu,  9 Sep 2021 13:02:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6E6B060AEB;
	Thu,  9 Sep 2021 13:02:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35823C0011;
	Thu,  9 Sep 2021 13:02:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B8526C000D
 for <iommu@lists.linux-foundation.org>; Thu,  9 Sep 2021 13:01:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 98F0140351
 for <iommu@lists.linux-foundation.org>; Thu,  9 Sep 2021 13:01:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gN-UYrE2k5qz for <iommu@lists.linux-foundation.org>;
 Thu,  9 Sep 2021 13:01:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::622])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F13354034D
 for <iommu@lists.linux-foundation.org>; Thu,  9 Sep 2021 13:01:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WH17hFuqA/pi1Nimz1Ntx6N00PEtOii7EZs+Zv5MP8R5NLJGSvQQ2t3DRJnARQ8JOcg77SB0Iia4qNEA0OpGdZ0WYSqAPYqivQczh+ZtbqvIsEa0DEW/Qkwf/vzgaX4YsCFt0/uXQsC0XKGzIrpZ5VVXbszd+TCIZXV0CVyp3/Un7Jzfb1moxIb9LNbcSt8iXc1xqhKQR2SxGbk/oxTChfSushlj8k6k+7Z9yB8N26QIkalgQnllmoMYScOtBrRgdvs2ErZSDyQEFjlS54JQefRNQadiX4YS7D9i8QkEmlf3UTGFW1iP/Aqi0YaGw/g6uBUzuTypL34S8J8Td8PLqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=rpX1a5tQN2dEESee31DyPmnXlFmmvSJK9zaC52ovp4g=;
 b=f9S9paFC6lSOURgkLUZPpjSxJrH1OhzpNWJnu65tGJrOHptLOpHRyRof6MD5mO7aI2FyQPfUMlBeXyqb+rQoA5XaAYYigb9fUdlsEs4YrOpihQeS3401IsqV52qfU8joY/pYEpvzQUwlyy5QP3HlGUMb5YFP0JPQW3tyPCbdYN7PbGtEqUaU1QeK6EEhc0mZ30zN7Q7YCRnWfzLrM52lIowOwEzRyc6M0ctx8feDSfgO5eUoVwVOS2rE74TNmxAJfEuW2091Blbn18PNQyPUbIZ/5Vpke4lPQv1S1zcAvf3tChTjS9/Wc/7ao24EYFg5xnc3GadKU+NzfqQ7yqOa/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpX1a5tQN2dEESee31DyPmnXlFmmvSJK9zaC52ovp4g=;
 b=h9uGzwAc3cTh9S3704Q30Tf+Ioad9/+0fooTbx8TGO6YP/enaEu4Xv5DTFgIIkT3TnwSejHm70nuR7U+G2E55eQh0wME4Il5a7jOQeaLk07JpMpqP8U5K9tJT4bIxgEFCJgLysGkeLz5QYkYQzRX1NVVwLuc3QDMQappXJPRkjY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5279.namprd12.prod.outlook.com (2603:10b6:5:39f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Thu, 9 Sep
 2021 13:01:54 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418%6]) with mapi id 15.20.4500.017; Thu, 9 Sep 2021
 13:01:54 +0000
Subject: Re: [PATCH v3 0/8] Implement generic cc_platform_has() helper function
To: Christian Borntraeger <borntraeger@de.ibm.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org,
 kvm@vger.kernel.org, linux-efi@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, linux-graphics-maintainer@vmware.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org
References: <cover.1631141919.git.thomas.lendacky@amd.com>
 <bde05ba8-c1b7-5df7-4147-44c38f4f3acf@de.ibm.com>
Message-ID: <9b343e40-d892-b556-c5e6-fa46fae61079@amd.com>
Date: Thu, 9 Sep 2021 08:01:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <bde05ba8-c1b7-5df7-4147-44c38f4f3acf@de.ibm.com>
Content-Language: en-US
X-ClientProxiedBy: SN6PR2101CA0004.namprd21.prod.outlook.com
 (2603:10b6:805:106::14) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
Received: from [10.236.30.241] (165.204.77.1) by
 SN6PR2101CA0004.namprd21.prod.outlook.com (2603:10b6:805:106::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.3 via Frontend
 Transport; Thu, 9 Sep 2021 13:01:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fbe46845-74d6-47a5-a65c-08d97391ff27
X-MS-TrafficTypeDiagnostic: DM4PR12MB5279:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5279A7D3B874B087A509A87FECD59@DM4PR12MB5279.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8azszEYDBgIcFSiw1oNOvgD7E1IhXES5E6w2h5NgETx64gpCnDg9zvbnQB9qkb4yQd19JI14VVRqKEWfjnYsHpKemszYNEDyq/9cQ4X9py2ZoMa5iuDLYA3Os+QHnOp9T8hK2a+UdOIMyWH6S4ARpJxa7RR8edpOCCDaglO+UcKLOJsHoDrw/6sKsnoDpDLWF2uHtUPEQzXrJNXlICAJfG6mGNQi8vQcXdd4kjegt0nKOsLZVrS5KZqF4SSCmJYiOugNe6YZLG4c7Y9F+dvyltd7gt2agYFH7Y9hObsDhtki1SSoG+TK0ckBmZfZ34UIQ+rP6gb3TuwOydJrSbSYlzAJQ17DGg16NS+9oQocedMY9wHwR4DaVZfrED2IOaTaV9ueHCUkEnPiUcU9PP5DyvGXmSofkJn9pcBrMES9/Bxm3pRgZyGchK/Ncy3cR1crCLICHnfECzwXM6Jio1DSYdDSW1BwYINArbeKe0ok54Ny3Pe69K77UbgvYcQeFQkjghksiYpP2+TGiyqfmiHfjjwzIE4EEkOEaDvPag+JFxeZASGherqFGZStf42rr2/RWI9xFv0FSI9Gomcgg9JQi3P5tLw7MejxAi0xlCCM0MINvwmKuR8rzF/xD5IQS8e5y+4EpKqJmoTVS3cZxzAq9kvMdAZ+dvbhpZjhdgoXGAFr7und1HYPk9AOk1HDn6xkN57pgEfGxwfVOSjO1YlOmQH1pEp5Jrca+puHMOh8HZP3JL1gHPjvMPSOoezRv09Z92FGPa5gMtvI2XrO0yAXFUtHYttFZY4gYifuQPRffBkt2AcFqQ0WoKrQNbhTzcaJgQjZe9KmAYLSJktWn/EVEQFit2seosGRO5S5LOk6ppQrP9w+DXnuOeu6CZaYyy6Lno7thwqlcagGienEwrB2wA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5229.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(136003)(366004)(376002)(31696002)(31686004)(86362001)(66556008)(66476007)(66946007)(8936002)(921005)(38100700002)(54906003)(83380400001)(36756003)(316002)(53546011)(2906002)(16576012)(956004)(2616005)(26005)(186003)(5660300002)(45080400002)(8676002)(966005)(4326008)(7416002)(7406005)(478600001)(6486002)(41533002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1NCenA2RzlrWm14QW9qN0dENUJsZmFuQ1ZqN3NtT1dEcHh0eEhRUURtVUpx?=
 =?utf-8?B?Q2JHZ0wyS05wN3JOZmlUUXdqNkJ4cWlZU3hGSENBbnR6L01SbWNpMXNlS1Vw?=
 =?utf-8?B?RHg2YldiWDduV2RpdmlZaTZHU2x6WGowM2FELzlNK0V0TjVCcTlmamZCMUo3?=
 =?utf-8?B?ZWI1dXBGd09LQjBpTU9JTHZrSSsxaGxobkFnZ0pxM0NZRGthSVpyZGhWZzNI?=
 =?utf-8?B?NGpPTnY1V0pGTzdJanIycThsMTNWaS9XYnZWWk8vU0ZldkIxVW5nMEl5NkNL?=
 =?utf-8?B?SWw3L3hIZXJLTFo5NUN3ZWFYMnFYbXhONUd1WDNaMnZjSUh5bWtYcUJ3WlpR?=
 =?utf-8?B?QnYxelNtQlU1UkxIQjJGYUh0Y0h0YWR6QU9nWHpYN3hXTmJ1dThKNFEwOVRK?=
 =?utf-8?B?dm1YN3dOMVRpOFkxWG9vN3pZb2JkOXFwL09ia1M1Q0JacWVDK082bWVvSnVq?=
 =?utf-8?B?MGxjbzRXTWFVak1OWk5pbVRZL0ZCUWRmR2dkNmhwRW12VUFTeUtCU3gvNUlN?=
 =?utf-8?B?ZXl2YnFkRGNteWFmMWdRNHlVa1N2akxXQ1EyQXY2alRLOW1FeFFCbTZsYjJl?=
 =?utf-8?B?bzZ3alNPYXVPVEhMTXFPb3kzVmV6aTJGSGw2NE5sZ1RxbFUxNnArWVpDWmJt?=
 =?utf-8?B?UWhoOVBESldRSjdGZEZTRjZvYno4V2JyWFVNNXh1UjNzOXZ0TzZvTjFqQk9E?=
 =?utf-8?B?b1d1MnAvU3lwTGVQZlIvalpkMmxrdUJvdXBvR05UMDd5RXBRNVJxQnI4VFA3?=
 =?utf-8?B?OUh2L2NmOE03TnU3V2cweCthQUhYN2tyY3BqNXArU0EzbjVkQUozb3o5K3Jr?=
 =?utf-8?B?WGZrQUkzVEpqcy9lUHl4ejB6dk9CODNJdUwzVUpvTHpEMFF1VlpZTlBuU3lh?=
 =?utf-8?B?cWUvc1pLR25vcXoxbEowVmNUNTRkSWNQWWVIbWVSbll0N2lBcHIzS2UrcVE3?=
 =?utf-8?B?NWJQRVg0MnA1SFczUzEyTkVoZWNrNmhnb29BRWx6OVkrUUNUcUZCd1RaaTF4?=
 =?utf-8?B?MFdIbFZxb3VKV1dmdUpmaldPYjNON1UwcGx5OWdKSWFwdGdWdU4xTWJzT2t0?=
 =?utf-8?B?QzdkenltODY3MjhUVVNrZzZxRGkwdW5CYWdDdUhiTDRnVFJyMFVlZFBMVXVI?=
 =?utf-8?B?d095R2xENm5oM0NYbnI4SEUxOFVjOFN2TzZmcEN0Q2wyQnBvSmNFMk9iWVdX?=
 =?utf-8?B?Nk14TTl0TFJiM1NmOElmOXVMVXhIbXhldGdydDNaNTRNMTloU0crQ0RrYjRx?=
 =?utf-8?B?QjJJdEhpTjZ2SWgrK2xYUFplTlJQUHliUFkwRUhZK0EyVUFnYjJMY1FLcCs0?=
 =?utf-8?B?OWdLam8xWjcxbXZ2NWVoT0UyZE93aUZ3aTkwU3pyaFlmWHJRMyt1UmVSQ3lT?=
 =?utf-8?B?aXhHWjlOckhTRng5R1BTNGFUNysxd3ZzZ0JBbHNUUUllYVFLcmU3OXU0QkdQ?=
 =?utf-8?B?TGxCR0VMMnRGdXp4bkhrV0YzK3VZK0RCWDlUdlRVNS95UnIzRC9tSmd6N0hO?=
 =?utf-8?B?ekRQQXlpckJVZlo4ZUxTRmpBRDErcmh2bDFOWFcvVytxL3Z2WnZXR2Y5OXJv?=
 =?utf-8?B?a1djcERWSGpFQ3hZTkU3d1dhcmVRN25nZmY5a3VnSGlaeU9jRENxeEVsSjd4?=
 =?utf-8?B?dlBIL3RqNVNKeHhoNnJOclRKVHF1NWwweGNqamxpOUhIN3o2YXErbVhRSkZC?=
 =?utf-8?B?L1FaQVl4bTJ1N0pENko0RXZCWXp4S0FOWEtBWXE4YTRVMHRJMnpHdXg0d1dC?=
 =?utf-8?Q?A2M+sJAvQGlm+uPvsG27j3t3H/XfZPzqwDPzML/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe46845-74d6-47a5-a65c-08d97391ff27
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 13:01:54.0365 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ANZ57FOLue2D/RaeIjmO2WoLtLG51gGpPVQrrA3t7YDPLPRVgfHokrCbZywnjveuP8+/ExrGdyKOWUbE4yoOag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5279
Cc: Brijesh Singh <brijesh.singh@amd.com>, David Airlie <airlied@linux.ie>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Paul Mackerras <paulus@samba.org>,
 Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Andi Kleen <ak@linux.intel.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Christoph Hellwig <hch@infradead.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Dave Young <dyoung@redhat.com>,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Daniel Vetter <daniel@ffwll.ch>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gOS85LzIxIDI6MzIgQU0sIENocmlzdGlhbiBCb3JudHJhZWdlciB3cm90ZToKPiAKPiAKPiBP
biAwOS4wOS4yMSAwMDo1OCwgVG9tIExlbmRhY2t5IHdyb3RlOgo+PiBUaGlzIHBhdGNoIHNlcmll
cyBwcm92aWRlcyBhIGdlbmVyaWMgaGVscGVyIGZ1bmN0aW9uLCBjY19wbGF0Zm9ybV9oYXMoKSwK
Pj4gdG8gcmVwbGFjZSB0aGUgc21lX2FjdGl2ZSgpLCBzZXZfYWN0aXZlKCksIHNldl9lc19hY3Rp
dmUoKSBhbmQKPj4gbWVtX2VuY3J5cHRfYWN0aXZlKCkgZnVuY3Rpb25zLgo+Pgo+PiBJdCBpcyBl
eHBlY3RlZCB0aGF0IGFzIG5ldyBjb25maWRlbnRpYWwgY29tcHV0aW5nIHRlY2hub2xvZ2llcyBh
cmUKPj4gYWRkZWQgdG8gdGhlIGtlcm5lbCwgdGhleSBjYW4gYWxsIGJlIGNvdmVyZWQgYnkgYSBz
aW5nbGUgZnVuY3Rpb24gY2FsbAo+PiBpbnN0ZWFkIG9mIGEgY29sbGVjdGlvbiBvZiBzcGVjaWZp
YyBmdW5jdGlvbiBjYWxscyBhbGwgY2FsbGVkIGZyb20gdGhlCj4+IHNhbWUgbG9jYXRpb25zLgo+
Pgo+PiBUaGUgcG93ZXJwYyBhbmQgczM5MCBwYXRjaGVzIGhhdmUgYmVlbiBjb21waWxlIHRlc3Rl
ZCBvbmx5LiBDYW4gdGhlCj4+IGZvbGtzIGNvcGllZCBvbiB0aGlzIHNlcmllcyB2ZXJpZnkgdGhh
dCBub3RoaW5nIGJyZWFrcyBmb3IgdGhlbS4KPiAKPiBJcyB0aGVyZSBhIHRyZWUgc29tZXdoZXJl
PwoKSSBwdXNoZWQgaXQgdXAgdG8gZ2l0aHViOgoKaHR0cHM6Ly9naXRodWIuY29tL0FNREVTRS9s
aW51eC90cmVlL3Byb3QtZ3Vlc3QtaGFzLXYzCgpUaGFua3MsClRvbQoKPiAKPiAgwqBBbHNvLAo+
PiBhIG5ldyBmaWxlLCBhcmNoL3Bvd2VycGMvcGxhdGZvcm1zL3BzZXJpZXMvY2NfcGxhdGZvcm0u
YywgaGFzIGJlZW4KPj4gY3JlYXRlZCBmb3IgcG93ZXJwYyB0byBob2xkIHRoZSBvdXQgb2YgbGlu
ZSBmdW5jdGlvbi4KPj4KPj4gQ2M6IEFuZGkgS2xlZW4gPGFrQGxpbnV4LmludGVsLmNvbT4KPj4g
Q2M6IEFuZHkgTHV0b21pcnNraSA8bHV0b0BrZXJuZWwub3JnPgo+PiBDYzogQXJkIEJpZXNoZXV2
ZWwgPGFyZGJAa2VybmVsLm9yZz4KPj4gQ2M6IEJhb3F1YW4gSGUgPGJoZUByZWRoYXQuY29tPgo+
PiBDYzogQmVuamFtaW4gSGVycmVuc2NobWlkdCA8YmVuaEBrZXJuZWwuY3Jhc2hpbmcub3JnPgo+
PiBDYzogQm9yaXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+Cj4+IENjOiBDaHJpc3RpYW4gQm9y
bnRyYWVnZXIgPGJvcm50cmFlZ2VyQGRlLmlibS5jb20+Cj4+IENjOiBEYW5pZWwgVmV0dGVyIDxk
YW5pZWxAZmZ3bGwuY2g+Cj4+IENjOiBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5AbGludXguaW50
ZWwuY29tPgo+PiBDYzogRGF2ZSBZb3VuZyA8ZHlvdW5nQHJlZGhhdC5jb20+Cj4+IENjOiBEYXZp
ZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+Cj4+IENjOiBIZWlrbyBDYXJzdGVucyA8aGNhQGxp
bnV4LmlibS5jb20+Cj4+IENjOiBJbmdvIE1vbG5hciA8bWluZ29AcmVkaGF0LmNvbT4KPj4gQ2M6
IEpvZXJnIFJvZWRlbCA8am9yb0A4Ynl0ZXMub3JnPgo+PiBDYzogTWFhcnRlbiBMYW5raG9yc3Qg
PG1hYXJ0ZW4ubGFua2hvcnN0QGxpbnV4LmludGVsLmNvbT4KPj4gQ2M6IE1heGltZSBSaXBhcmQg
PG1yaXBhcmRAa2VybmVsLm9yZz4KPj4gQ2M6IE1pY2hhZWwgRWxsZXJtYW4gPG1wZUBlbGxlcm1h
bi5pZC5hdT4KPj4gQ2M6IFBhdWwgTWFja2VycmFzIDxwYXVsdXNAc2FtYmEub3JnPgo+PiBDYzog
UGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3JnPgo+PiBDYzogVGhvbWFzIEdsZWl4
bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+Cj4+IENjOiBUaG9tYXMgWmltbWVybWFubiA8dHppbW1l
cm1hbm5Ac3VzZS5kZT4KPj4gQ2M6IFZhc2lseSBHb3JiaWsgPGdvckBsaW51eC5pYm0uY29tPgo+
PiBDYzogVk13YXJlIEdyYXBoaWNzIDxsaW51eC1ncmFwaGljcy1tYWludGFpbmVyQHZtd2FyZS5j
b20+Cj4+IENjOiBXaWxsIERlYWNvbiA8d2lsbEBrZXJuZWwub3JnPgo+PiBDYzogQ2hyaXN0b3Bo
IEhlbGx3aWcgPGhjaEBpbmZyYWRlYWQub3JnPgo+Pgo+PiAtLS0KPj4KPj4gUGF0Y2hlcyBiYXNl
ZCBvbjoKPj4gICAgCj4+IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9v
ay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmdpdC5rZXJuZWwub3JnJTJGcHViJTJGc2NtJTJGbGlu
dXglMkZrZXJuZWwlMkZnaXQlMkZ0b3J2YWxkcyUyRmxpbnV4LmdpdCZhbXA7ZGF0YT0wNCU3QzAx
JTdDdGhvbWFzLmxlbmRhY2t5JTQwYW1kLmNvbSU3QzVjZDcxZWYyYzJjZTRiOTAwNjA3MDhkOTcz
NjQwMzU4JTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzY2
NzY5NTY1NzEyMTQzMiU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TURB
aUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MxMDAwJmFt
cDtzZGF0YT1GVm5nclBTeENDUkt1dEFhSU10VTJOazhXQXJGUUIxZEVFMndON3Y4UmdBJTNEJmFt
cDtyZXNlcnZlZD0wIAo+PiBtYXN0ZXIKPj4gwqDCoCA0YjkzYzU0NGU5MGUgKCJ0aHVuZGVyYm9s
dDogdGVzdDogc3BsaXQgdXAgdGVzdCBjYXNlcyBpbiAKPj4gdGJfdGVzdF9jcmVkaXRfYWxsb2Nf
YWxsIikKPj4KPj4gQ2hhbmdlcyBzaW5jZSB2MjoKPj4gLSBDaGFuZ2VkIHRoZSBuYW1lIGZyb20g
cHJvdF9ndWVzdF9oYXMoKSB0byBjY19wbGF0Zm9ybV9oYXMoKQo+PiAtIFRvb2sgdGhlIGNjX3Bs
YXRmb3JtX2hhcygpIGZ1bmN0aW9uIG91dCBvZiBsaW5lLiBDcmVhdGVkIHR3byBuZXcgZmlsZXMs
Cj4+IMKgwqAgY2NfcGxhdGZvcm0uYywgaW4gYm90aCB4ODYgYW5kIHBwYyB0byBpbXBsbWVudCB0
aGUgZnVuY3Rpb24uIEFzIGEKPj4gwqDCoCByZXN1bHQsIGFsc28gY2hhbmdlZCB0aGUgYXR0cmli
dXRlIGRlZmluZXMgaW50byBlbnVtcy4KPj4gLSBSZW1vdmVkIGFueSByZWNlaXZlZCBSZXZpZXdl
ZC1ieSdzIGFuZCBBY2tlZC1ieSdzIGdpdmVuIGNoYW5nZXMgaW4gdGhpcwo+PiDCoMKgIHZlcnNp
b24uCj4+IC0gQWRkZWQgcmVtb3ZhbCBvZiBuZXcgaW5zdGFuY2VzIG9mIG1lbV9lbmNyeXB0X2Fj
dGl2ZSgpIHVzYWdlIGluIHBvd2VycGMKPj4gwqDCoCBhcmNoLgo+PiAtIEJhc2VkIG9uIGxhdGVz
dCBMaW51eCB0cmVlIHRvIHBpY2sgdXAgcG93ZXJwYyBjaGFuZ2VzIHJlbGF0ZWQgdG8gdGhlCj4+
IMKgwqAgbWVtX2VuY3J5cHRfYWN0aXZlKCkgZnVuY3Rpb24uCj4+Cj4+IENoYW5nZXMgc2luY2Ug
djE6Cj4+IC0gTW92ZWQgc29tZSBhcmNoIGlvcmVtYXAgZnVuY3Rpb25zIHdpdGhpbiAjaWZkZWYg
Q09ORklHX0FNRF9NRU1fRU5DUllQVAo+PiDCoMKgIGluIHByZXAgZm9yIHVzZSBvZiBwcm90X2d1
ZXN0X2hhcygpIGJ5IFREWC4KPj4gLSBBZGRlZCB0eXBlIGluY2x1ZGVzIHRvIHRoZSB0aGUgcHJv
dGVjdGVkX2d1ZXN0LmggaGVhZGVyIGZpbGUgdG8gcHJldmVudAo+PiDCoMKgIGJ1aWxkIGVycm9y
cyBvdXRzaWRlIG9mIHg4Ni4KPj4gLSBNYWRlIGFtZF9wcm90X2d1ZXN0X2hhcygpIEVYUE9SVF9T
WU1CT0xfR1BMCj4+IC0gVXNlZCBhbWRfcHJvdF9ndWVzdF9oYXMoKSBpbiBwbGFjZSBvZiBjaGVj
a2luZyBzbWVfbWVfbWFzayBpbiB0aGUKPj4gwqDCoCBhcmNoL3g4Ni9tbS9tZW1fZW5jcnlwdC5j
IGZpbGUuCj4+Cj4+IFRvbSBMZW5kYWNreSAoOCk6Cj4+IMKgwqAgeDg2L2lvcmVtYXA6IFNlbGVj
dGl2ZWx5IGJ1aWxkIGFyY2ggb3ZlcnJpZGUgZW5jcnlwdGlvbiBmdW5jdGlvbnMKPj4gwqDCoCBt
bTogSW50cm9kdWNlIGEgZnVuY3Rpb24gdG8gY2hlY2sgZm9yIGNvbmZpZGVudGlhbCBjb21wdXRp
bmcgZmVhdHVyZXMKPj4gwqDCoCB4ODYvc2V2OiBBZGQgYW4geDg2IHZlcnNpb24gb2YgY2NfcGxh
dGZvcm1faGFzKCkKPj4gwqDCoCBwb3dlcnBjL3BzZXJpZXMvc3ZtOiBBZGQgYSBwb3dlcnBjIHZl
cnNpb24gb2YgY2NfcGxhdGZvcm1faGFzKCkKPj4gwqDCoCB4ODYvc21lOiBSZXBsYWNlIG9jY3Vy
cmVuY2VzIG9mIHNtZV9hY3RpdmUoKSB3aXRoIGNjX3BsYXRmb3JtX2hhcygpCj4+IMKgwqAgeDg2
L3NldjogUmVwbGFjZSBvY2N1cnJlbmNlcyBvZiBzZXZfYWN0aXZlKCkgd2l0aCBjY19wbGF0Zm9y
bV9oYXMoKQo+PiDCoMKgIHg4Ni9zZXY6IFJlcGxhY2Ugb2NjdXJyZW5jZXMgb2Ygc2V2X2VzX2Fj
dGl2ZSgpIHdpdGggY2NfcGxhdGZvcm1faGFzKCkKPj4gwqDCoCB0cmVld2lkZTogUmVwbGFjZSB0
aGUgdXNlIG9mIG1lbV9lbmNyeXB0X2FjdGl2ZSgpIHdpdGgKPj4gwqDCoMKgwqAgY2NfcGxhdGZv
cm1faGFzKCkKPj4KPj4gwqAgYXJjaC9LY29uZmlnwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMyArCj4+IMKgIGFyY2gv
cG93ZXJwYy9pbmNsdWRlL2FzbS9tZW1fZW5jcnlwdC5owqDCoMKgwqDCoMKgIHzCoCA1IC0tCj4+
IMKgIGFyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvcHNlcmllcy9LY29uZmlnwqDCoMKgwqDCoMKgIHzC
oCAxICsKPj4gwqAgYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9wc2VyaWVzL01ha2VmaWxlwqDCoMKg
wqDCoCB8wqAgMiArCj4+IMKgIGFyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvcHNlcmllcy9jY19wbGF0
Zm9ybS5jIHwgMjYgKysrKysrCj4+IMKgIGFyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvcHNlcmllcy9z
dm0uY8KgwqDCoMKgwqDCoMKgwqAgfMKgIDUgKy0KPj4gwqAgYXJjaC9zMzkwL2luY2x1ZGUvYXNt
L21lbV9lbmNyeXB0LmjCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDIgLQo+PiDCoCBhcmNoL3g4Ni9L
Y29uZmlnwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfMKgIDEgKwo+PiDCoCBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9pby5owqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDggKysKPj4gwqAgYXJjaC94ODYvaW5jbHVk
ZS9hc20va2V4ZWMuaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAyICstCj4+
IMKgIGFyY2gveDg2L2luY2x1ZGUvYXNtL21lbV9lbmNyeXB0LmjCoMKgwqDCoMKgwqDCoMKgwqDC
oCB8IDE0ICstLS0KPj4gwqAgYXJjaC94ODYva2VybmVsL01ha2VmaWxlwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMyArCj4+IMKgIGFyY2gveDg2L2tlcm5lbC9j
Y19wbGF0Zm9ybS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMjEgKysrKysKPj4g
wqAgYXJjaC94ODYva2VybmVsL2NyYXNoX2R1bXBfNjQuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHzCoCA0ICstCj4+IMKgIGFyY2gveDg2L2tlcm5lbC9oZWFkNjQuY8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDQgKy0KPj4gwqAgYXJjaC94ODYva2VybmVs
L2t2bS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAg
MyArLQo+PiDCoCBhcmNoL3g4Ni9rZXJuZWwva3ZtY2xvY2suY8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB8wqAgNCArLQo+PiDCoCBhcmNoL3g4Ni9rZXJuZWwvbWFjaGluZV9r
ZXhlY182NC5jwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAxOSArKystLQo+PiDCoCBhcmNoL3g4Ni9r
ZXJuZWwvcGNpLXN3aW90bGIuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgOSAr
LQo+PiDCoCBhcmNoL3g4Ni9rZXJuZWwvcmVsb2NhdGVfa2VybmVsXzY0LlPCoMKgwqDCoMKgwqDC
oMKgIHzCoCAyICstCj4+IMKgIGFyY2gveDg2L2tlcm5lbC9zZXYuY8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDYgKy0KPj4gwqAgYXJjaC94ODYva3Zt
L3N2bS9zdm0uY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzC
oCAzICstCj4+IMKgIGFyY2gveDg2L21tL2lvcmVtYXAuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAxOCArKy0tCj4+IMKgIGFyY2gveDg2L21tL21lbV9l
bmNyeXB0LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDU3ICsrKysr
KystLS0tLS0KPj4gwqAgYXJjaC94ODYvbW0vbWVtX2VuY3J5cHRfaWRlbnRpdHkuY8KgwqDCoMKg
wqDCoMKgwqDCoMKgIHzCoCAzICstCj4+IMKgIGFyY2gveDg2L21tL3BhdC9zZXRfbWVtb3J5LmPC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMyArLQo+PiDCoCBhcmNoL3g4Ni9w
bGF0Zm9ybS9lZmkvZWZpXzY0LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCA5ICst
Cj4+IMKgIGFyY2gveDg2L3JlYWxtb2RlL2luaXQuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfMKgIDggKy0KPj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2Rydi5jwqDCoMKgwqDCoCB8wqAgNCArLQo+PiDCoCBkcml2ZXJzL2dwdS9kcm0vZHJt
X2NhY2hlLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCA0ICstCj4+IMKg
IGRyaXZlcnMvZ3B1L2RybS92bXdnZngvdm13Z2Z4X2Rydi5jwqDCoMKgwqDCoMKgwqDCoMKgIHzC
oCA0ICstCj4+IMKgIGRyaXZlcnMvZ3B1L2RybS92bXdnZngvdm13Z2Z4X21zZy5jwqDCoMKgwqDC
oMKgwqDCoMKgIHzCoCA2ICstCj4+IMKgIGRyaXZlcnMvaW9tbXUvYW1kL2luaXQuY8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDcgKy0KPj4gwqAgZHJpdmVycy9p
b21tdS9hbWQvaW9tbXUuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzC
oCAzICstCj4+IMKgIGRyaXZlcnMvaW9tbXUvYW1kL2lvbW11X3YyLmPCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB8wqAgMyArLQo+PiDCoCBkcml2ZXJzL2lvbW11L2lvbW11LmPCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAzICstCj4+IMKg
IGZzL3Byb2Mvdm1jb3JlLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB8wqAgNiArLQo+PiDCoCBpbmNsdWRlL2xpbnV4L2NjX3BsYXRmb3Jt
LmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgODggKysrKysrKysrKysrKysr
KysrKysKPj4gwqAgaW5jbHVkZS9saW51eC9tZW1fZW5jcnlwdC5owqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB8wqAgNCAtCj4+IMKgIGtlcm5lbC9kbWEvc3dpb3RsYi5jwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCA0ICstCj4+IMKg
IDQwIGZpbGVzIGNoYW5nZWQsIDI2NyBpbnNlcnRpb25zKCspLCAxMTQgZGVsZXRpb25zKC0pCj4+
IMKgIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL3Bvd2VycGMvcGxhdGZvcm1zL3BzZXJpZXMvY2Nf
cGxhdGZvcm0uYwo+PiDCoCBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC94ODYva2VybmVsL2NjX3Bs
YXRmb3JtLmMKPj4gwqAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvbGludXgvY2NfcGxhdGZv
cm0uaAo+Pgo+Pgo+PiBiYXNlLWNvbW1pdDogNGI5M2M1NDRlOTBlMmIyODMyNjE4MmQzMWVlMDA4
ZWI4MGUwMjA3NAo+PgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
