Return-Path: <SRS0=o4oj=NB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2E3C4338F
	for <iommu@archiver.kernel.org>; Tue, 10 Aug 2021 19:49:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01C0760ED8
	for <iommu@archiver.kernel.org>; Tue, 10 Aug 2021 19:49:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 01C0760ED8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B70E5830E3;
	Tue, 10 Aug 2021 19:49:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LzK6QeQFLh-r; Tue, 10 Aug 2021 19:49:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6AF4083123;
	Tue, 10 Aug 2021 19:49:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 391A0C0010;
	Tue, 10 Aug 2021 19:49:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BED8BC000E
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 19:49:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9F3D540332
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 19:49:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TxXfF4xscks2 for <iommu@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 19:49:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::602])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AC923400C6
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 19:49:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZ+3qyej49za+0VS+FD0wQ6mn8leKkX2WPHFmxDsYkJ3C99PZj6HMFOXtTlXIfB59M7CEZs6CxLLDfLbFeE7qYhIeEdozRBnnbstqaA7e2hj6JeFZWue83dfjNO4uX1zXIIP+M1xO3+aSKP7UBdYwFWvxy7dX7qc4VEJvtgzr14bC5kDmcp0hPwOvhiQdeUNknZIqQylUPK9lhmAiEDtAHR8HuMhmWt9b0FSh5hIfeXRXeRIquwBxMoj1QiJ+2I3cn7kfVR7i2tgxjZIuYA/7wxsab52xInwOjsMGNpYSB9w8eJi+AROIRlzyaPkOvLNpVdZAouQN6H367+E2zbuDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zh+wIW78M8BTE50i5ZnMzfjoH3JWoQ2z4zwDegZcjTw=;
 b=KDHD2sKkMdWQ9JMKZSZCWKf9fOX2IjzvRCFn5KIcvJq9QU/vKiHqh1wtOCUdvCyQpmbMoiBcaG7a6xasYRC8oWWtfSFFWIfuqc0WsqWxweIAnNuWaMwZ5Xj3HbAwql752qIijPSazho8hJGhbERZDZ2rA3x1PtP28AqbXaz8vjQuh0wIijsNW+N3WOZnn1/m8B/3+/dac0BaahP9PSXjCWCuK2Sbg0AhAAkZhHVQtsjAbTF+D1mpme4pq0t1OT5otqpqjXKg/uDJh6dXg/MOkm8lYYvR4/V6RIE9CAPKTUA5c//m4abSaAw9ZWnorwyThbnIpWICVfK39nQ+qe/IuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zh+wIW78M8BTE50i5ZnMzfjoH3JWoQ2z4zwDegZcjTw=;
 b=RJ3Whm8Dil40S3MwjVoL8Ot4+SIib44VjBGVtC7vbK9LLgmdSb1XOzN/cOMTjxX+jdQjvpCVBElu3F3/rUUTir1zh9+UGitv4ZF3nm2mepQasce6vsuzSR4DEO6JQLK3W4kGGEjXW9jyUEmkD2JNkkgjbjn75FdHgV+hbHtkPAw=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5213.namprd12.prod.outlook.com (2603:10b6:5:394::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Tue, 10 Aug
 2021 19:48:57 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::73:2581:970b:3208]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::73:2581:970b:3208%3]) with mapi id 15.20.4394.023; Tue, 10 Aug 2021
 19:48:57 +0000
Subject: Re: [PATCH 07/11] treewide: Replace the use of mem_encrypt_active()
 with prot_guest_has()
To: "Kuppuswamy, Sathyanarayanan"
 <sathyanarayanan.kuppuswamy@linux.intel.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
 linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-graphics-maintainer@vmware.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, kexec@lists.infradead.org,
 linux-fsdevel@vger.kernel.org
References: <cover.1627424773.git.thomas.lendacky@amd.com>
 <029791b24c6412f9427cfe6ec598156c64395964.1627424774.git.thomas.lendacky@amd.com>
 <166f30d8-9abb-02de-70d8-6e97f44f85df@linux.intel.com>
Message-ID: <4b885c52-f70a-147e-86bd-c71a8f4ef564@amd.com>
Date: Tue, 10 Aug 2021 14:48:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <166f30d8-9abb-02de-70d8-6e97f44f85df@linux.intel.com>
Content-Language: en-US
X-ClientProxiedBy: SA9PR10CA0003.namprd10.prod.outlook.com
 (2603:10b6:806:a7::8) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.241] (165.204.77.1) by
 SA9PR10CA0003.namprd10.prod.outlook.com (2603:10b6:806:a7::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.14 via Frontend Transport; Tue, 10 Aug 2021 19:48:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7519805-b04f-44e9-0267-08d95c37e478
X-MS-TrafficTypeDiagnostic: DM4PR12MB5213:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5213808E81BF3C9D4453E6ABECF79@DM4PR12MB5213.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dnNi92GSpZMslhiJrfA3rObWOy/Id+q1gKm6thqBC060XYwLZe3GyzbHxgGkUNk+wdDB54v7EICc2ePegDwKUVeIDWdwhvekpABUuvATXrDiMI61I+GaorVEfOjYCHuSMlsA9wDeZL1bLmuTZKQj5IFitAjkp4VMlkr2j+wwsgt88F2tEpfBvkezJV7bb1aA5jWOE68pfUkK/1yK0sSmRc0tWOgDhAJFZsvjpKYvendWlZxekxJMIHfk2V17Redu26emXLnu5ls/D8YeTO1cJG80QslBjpzrgZi03VKK5vkzwUs+WGDYRIjqwEP+tXOVZD2vNT/vAjy9VGPROLEV45Q+OKVJxuQL+uQcvptiOmRxvYeJhvI91mt77eGnYDif0Sfstz9v1mBaglWw397KFtF5JvHE/r+tRZbhPDa+bnMrAmWd3sR6CkI2pruLC+eak1Y2sSM5JPhVwTyGV65WccTsePjRbmXt9kdt717rld973FpbqYxeuAYtPCaoTRh2DhmHCzbA6Y7MPb0XnEHyGD4EzJd51+0p3jb9mXM1eL/zDZv+uiJ8+NjnOrfaG8QnhHX6DD+eLBcbDuMyN4dV11BriDVTj6t5cyPjnE3vlu3DDhVnolDffVc963g9xuGGR/uG5ElqGjGYS7bLialLp230ItD3vgYgjpy4ZqkxpkGM58VL4Fjc0+ffnOn0qfCoRUFv4nlqzIgg63QKSHzxF50VH0SiO9vCVIdhoq0F0ay6XaI4/+X2m/9MNYK24vmA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5229.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4326008)(2906002)(83380400001)(316002)(16576012)(26005)(53546011)(186003)(54906003)(508600001)(66476007)(36756003)(31696002)(86362001)(8936002)(8676002)(66556008)(921005)(66946007)(6486002)(7416002)(38100700002)(5660300002)(31686004)(2616005)(956004)(7406005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R01YRS8ydDdKVjY4QmV4UStDYy94VjVRS1pOeXVleGNkdDBKd0xKM2FlR0xM?=
 =?utf-8?B?cDBMSUIxMHFHSXdURy9UY3JZVFN0VnE0NEt1cTBXU2Y3L3VoUFpVYnpWc0d4?=
 =?utf-8?B?VndNK3FHSytDdTRkbU5YZDRGTTNTNjZzU0pFdGI3TWhPRmhlYXVMREoxSmZi?=
 =?utf-8?B?WHpTSjBpLzFBVFBkdVl2Z0VCalIwc3J3QjB2Q1dkUjV0MFExMmRtSW5EbTUx?=
 =?utf-8?B?cG8rMkdWOGl1TmdVTGkzRE1ZQ09XQm8zWWVxeStnYXBGcTA3NmRGS0hRNzNE?=
 =?utf-8?B?c2w1ZlRjUmZYY1FReTZIcklnUWtGK0w3VjRYYlpYMG1JQ2NlZTEvTkhQY3BL?=
 =?utf-8?B?SVNtU1o1TlllNTZrS3ZrbGNIK25hNXZnSG1XbE9zMk5sUEZJNlB4Z2ZtNHBi?=
 =?utf-8?B?ODVWOGFDREtzdXptS3lvWDFnKzNQTXZubjRodExLQU0vZ05UeG9la2F0ckxi?=
 =?utf-8?B?NXdJSTd3eEhLZEU5Vit1WWdKenVXWjhVL0IybWRnREtUM1VtaEdNNnJGV2lL?=
 =?utf-8?B?UFNNY0ZIdWlRTXBXMzF1TStidjlYL2JHTFNJVm16SWY2OVBvRXZtYmk1djd2?=
 =?utf-8?B?SHJ5cFdGLzg4LytKS0JrcnA5SnhNU0U5MkVXbEVjcXd4MzhPVXNXc0dmaWxX?=
 =?utf-8?B?QWgvNldpVFRta2R0cVpPZ1dQK3U3eWMrTmlaa25MSHR3WDJCc25BL29EdytH?=
 =?utf-8?B?WWlOK3V4UDJMSlk5WGhCRWZDajk3NUlRKzRGRnZVNmdtY2dGRmlOY1NYTlpq?=
 =?utf-8?B?VUp1cEp5dHhjbUdNQUkrR1RpUzBUcmhDaVZLOGlDZVR6MTE3Z0I1M1c3a0t5?=
 =?utf-8?B?Z2NQamt6Ujl1QWlwMURxUVIxdmFteE83eEljMUtFRGdzekdKUi9BMkZnam51?=
 =?utf-8?B?bXViTjlrZWVXTHozcFpKY1lYaHVEZWJ6RVpzeG9zMnBaMHlBanc5Y1JoeCtq?=
 =?utf-8?B?eGJReU4wcTNBbUgrT1lqMllKQ1NKRUg1OVl1UnE4VmdFSjZ4VnVOQkd3aU9W?=
 =?utf-8?B?bkNudHhKSmJnZUVWd2Y0Ri9nc1lySkZHdEovNk1vRTdaMHhIWGU2NFNTTkhr?=
 =?utf-8?B?NlZGNEdEQy8welBLT1cvMmcvUW5ybVIvcitXdkdETlZyc2I1NWd2T1BYbk93?=
 =?utf-8?B?M3h6VnU1dWZnUlNDMXUzOVlOdzhENTZrK1F1bGpONm9YcVN3aWlrSSt2WHFm?=
 =?utf-8?B?REpOSFVLQ2swL1Y2YjdJZlBsby9MVjlSZHI4aE85blBURWVlOVhOY1llSTdp?=
 =?utf-8?B?TTJXdk5xa3JLanlBVEZhdzNTaUtJVzE4VnhORjlEcDVXam9RUmZHTTA1K2hZ?=
 =?utf-8?B?TCtiYklYV05oNGlCNFJteHN0S1d2M0REeXNXNXBHeUNneGdRbWhESDRsNEls?=
 =?utf-8?B?Ymw1SlZTRWoxZjVzMk5JRmxKUjZIQjVsWmZadUN5UjRtYXpzcGNxb1Y5ZElR?=
 =?utf-8?B?Z1l4OE94OWgvSmdEcGNteEJObUFTaW1IWHVBRTkvcThMb0wxaWJBM2FydVdo?=
 =?utf-8?B?UXpIczRZcmhzWjFGanNNbUtuWHl6TGxKSWtHTmZuWDVPTmVXaG8vc1h1VnNo?=
 =?utf-8?B?UC9qcUJPL2tTY0dsYm5tRytaeDhjdndzZmNTZGltdWw0S3N5Q0dkZWZwN01V?=
 =?utf-8?B?MTY0WWV1TmtERHZ6ZnlTZEE1ZitFMXRrQTF5a01WK1hDWHdDYXBOdFdtU2F3?=
 =?utf-8?B?NUVpUFRPTGwxeEI4Ti94V0QwYXJzbEcwUktJSmpuODRGNm1mdG1tM1NqYUNG?=
 =?utf-8?Q?fQ9evLIdYd8zEwDHlrF8On6CF1u6qb8BapODFJ7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7519805-b04f-44e9-0267-08d95c37e478
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 19:48:57.8699 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LkQmC0BMFabM+hD+NZCRsqRDlnlmUWZdnM+SN3S137DV+6ebAPKAIvjN9s/s+GoNlwKXx1Ivo44BngEr7cMMzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5213
Cc: Andi Kleen <ak@linux.intel.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>,
 Daniel Vetter <daniel@ffwll.ch>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@linux.ie>,
 Dave Young <dyoung@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Brijesh Singh <brijesh.singh@amd.com>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gOC8xMC8yMSAxOjQ1IFBNLCBLdXBwdXN3YW15LCBTYXRoeWFuYXJheWFuYW4gd3JvdGU6Cj4g
Cj4gCj4gT24gNy8yNy8yMSAzOjI2IFBNLCBUb20gTGVuZGFja3kgd3JvdGU6Cj4+IGRpZmYgLS1n
aXQgYS9hcmNoL3g4Ni9rZXJuZWwvaGVhZDY0LmMgYi9hcmNoL3g4Ni9rZXJuZWwvaGVhZDY0LmMK
Pj4gaW5kZXggZGUwMTkwM2MzNzM1Li5jYWZlZDY0NTZkNDUgMTAwNjQ0Cj4+IC0tLSBhL2FyY2gv
eDg2L2tlcm5lbC9oZWFkNjQuYwo+PiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvaGVhZDY0LmMKPj4g
QEAgLTE5LDcgKzE5LDcgQEAKPj4gwqAgI2luY2x1ZGUgPGxpbnV4L3N0YXJ0X2tlcm5lbC5oPgo+
PiDCoCAjaW5jbHVkZSA8bGludXgvaW8uaD4KPj4gwqAgI2luY2x1ZGUgPGxpbnV4L21lbWJsb2Nr
Lmg+Cj4+IC0jaW5jbHVkZSA8bGludXgvbWVtX2VuY3J5cHQuaD4KPj4gKyNpbmNsdWRlIDxsaW51
eC9wcm90ZWN0ZWRfZ3Vlc3QuaD4KPj4gwqAgI2luY2x1ZGUgPGxpbnV4L3BndGFibGUuaD4KPj4g
wqAgwqAgI2luY2x1ZGUgPGFzbS9wcm9jZXNzb3IuaD4KPj4gQEAgLTI4NSw3ICsyODUsNyBAQCB1
bnNpZ25lZCBsb25nIF9faGVhZCBfX3N0YXJ0dXBfNjQodW5zaWduZWQgbG9uZwo+PiBwaHlzYWRk
ciwKPj4gwqDCoMKgwqDCoMKgICogdGhlcmUgaXMgbm8gbmVlZCB0byB6ZXJvIGl0IGFmdGVyIGNo
YW5naW5nIHRoZSBtZW1vcnkgZW5jcnlwdGlvbgo+PiDCoMKgwqDCoMKgwqAgKiBhdHRyaWJ1dGUu
Cj4+IMKgwqDCoMKgwqDCoCAqLwo+PiAtwqDCoMKgIGlmIChtZW1fZW5jcnlwdF9hY3RpdmUoKSkg
ewo+PiArwqDCoMKgIGlmIChwcm90X2d1ZXN0X2hhcyhQQVRUUl9NRU1fRU5DUllQVCkpIHsKPj4g
wqDCoMKgwqDCoMKgwqDCoMKgIHZhZGRyID0gKHVuc2lnbmVkIGxvbmcpX19zdGFydF9ic3NfZGVj
cnlwdGVkOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgdmFkZHJfZW5kID0gKHVuc2lnbmVkIGxvbmcp
X19lbmRfYnNzX2RlY3J5cHRlZDsKPiAKPiAKPiBTaW5jZSB0aGlzIGNoYW5nZSBpcyBzcGVjaWZp
YyB0byBBTUQsIGNhbiB5b3UgcmVwbGFjZSBQQVRUUl9NRU1fRU5DUllQVCB3aXRoCj4gcHJvdF9n
dWVzdF9oYXMoUEFUVFJfU01FKSB8fCBwcm90X2d1ZXN0X2hhcyhQQVRUUl9TRVYpLiBJdCBpcyBu
b3QgdXNlZCBpbgo+IFREWC4KClRoaXMgaXMgYSBkaXJlY3QgcmVwbGFjZW1lbnQgZm9yIG5vdy4g
SSB0aGluayB0aGUgY2hhbmdlIHlvdSdyZSByZXF1ZXN0aW5nCnNob3VsZCBiZSBkb25lIGFzIHBh
cnQgb2YgdGhlIFREWCBzdXBwb3J0IHBhdGNoZXMgc28gaXQncyBjbGVhciB3aHkgaXQgaXMKYmVp
bmcgY2hhbmdlZC4KCkJ1dCwgd291bGRuJ3QgVERYIHN0aWxsIG5lZWQgdG8gZG8gc29tZXRoaW5n
IHdpdGggdGhpcyBzaGFyZWQvdW5lbmNyeXB0ZWQKYXJlYSwgdGhvdWdoPyBPciBzaW5jZSBpdCBp
cyBzaGFyZWQsIHRoZXJlJ3MgYWN0dWFsbHkgbm90aGluZyB5b3UgbmVlZCB0bwpkbyAodGhlIGJz
cyBkZWNycHl0ZWQgc2VjdGlvbiBleGlzdHMgZXZlbiBpZiBDT05GSUdfQU1EX01FTV9FTkNSWVBU
IGlzIG5vdApjb25maWd1cmVkKT8KClRoYW5rcywKVG9tCgo+IApfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vaW9tbXU=
