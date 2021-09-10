Return-Path: <SRS0=PBOI=OA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A97DC433EF
	for <iommu@archiver.kernel.org>; Fri, 10 Sep 2021 19:23:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CEF7611CC
	for <iommu@archiver.kernel.org>; Fri, 10 Sep 2021 19:23:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7CEF7611CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3A89440218;
	Fri, 10 Sep 2021 19:23:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V11877WybEGw; Fri, 10 Sep 2021 19:23:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0036040255;
	Fri, 10 Sep 2021 19:23:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE5E6C0011;
	Fri, 10 Sep 2021 19:23:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3F5BBC000D
 for <iommu@lists.linux-foundation.org>; Fri, 10 Sep 2021 18:01:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 247D6401D0
 for <iommu@lists.linux-foundation.org>; Fri, 10 Sep 2021 18:01:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CMDW_eR5ksLj for <iommu@lists.linux-foundation.org>;
 Fri, 10 Sep 2021 18:01:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 30B5C402A4
 for <iommu@lists.linux-foundation.org>; Fri, 10 Sep 2021 18:01:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJWt42d6NpgS0OjDrwW2fETODA/aXikD3cIbfmld4WMtrZIscjH+EMyyHItjjHEcQf7FnF5Sf6SRLKqmfN/mNjDc28dbdbBjMHqn/LsVk0clpvTDljqdako1A66Hz3vh0do/XRzpEMtCQq6+REv9VWJf7efHENp2eoUjzvwMJbmdZGqmKlkdlD8r6Lx0qfeDzd5fS8sCElLQl5Fcvyc0PjTa6w09u7l0ChwGErxXyCQGMEnGe3gYI3+LjKr216Yc0n1ygo89s9F6qAOIA5BSdOuoRIajCk7z+vax7xdGinZPcuvhQkjnCsaSKQcSE9piD0FmRVr2v3ms2v4m0/nmjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=dnizlZdNRECzXl8zToQxwEXNj7DrP+Q9wtTOO+bw+CI=;
 b=AIjiz6hBuVyRqCNb9j3OFgk0rms4wV8yF3grLpCWQAZDVkj4VksKKCiSJ9xucSo1ab0zD4lSOIBhnS9Cxl3Q/33Lan69z6MZEDCvJTqIWgAxLo1+m9PnXIsyMV03jK+/lrc+DCk9xh8ghXd+50puxjNpO/yrLgoyHJb8k5a7ACM4glS6YNeGyL/JECb7FdevnlorWZ4s75Ea2vC+VAkE+APFFvbx8uWvVgqncv3THTY7wJ0yfKIj2ddFOHXWsVWmxkS6dO3CWu1ZuB3xFOv3hEXWPnWbWtHlEWOAXPZcjHO9KZBLji08VVdVDCcZga+WbhfyXBJ8Ce6krd7tn/XrVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnizlZdNRECzXl8zToQxwEXNj7DrP+Q9wtTOO+bw+CI=;
 b=r8n91nEedk4wQzWrUe92FUb4X8ME1BmbwQlvguGjk1LzUd/magNKQ2JRtLaLe7eZiVqsQ/A/zL5RQ+1FaE1FNCciUbthzrrQaZSXReHzxr0DliG0+Xrk83vbkuriu7syhxQC81EZkCU2zKqDCsXGg9iyvG6Il1K7DX/ERtbIxkc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB0201.namprd12.prod.outlook.com (2603:10b6:4:5b::21)
 by DM5PR1201MB2490.namprd12.prod.outlook.com (2603:10b6:3:e3::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Fri, 10 Sep
 2021 18:01:13 +0000
Received: from DM5PR1201MB0201.namprd12.prod.outlook.com
 ([fe80::7410:8a22:1bdb:d24d]) by DM5PR1201MB0201.namprd12.prod.outlook.com
 ([fe80::7410:8a22:1bdb:d24d%6]) with mapi id 15.20.4500.017; Fri, 10 Sep 2021
 18:01:13 +0000
Subject: Re: [PATCH 0/3] iommu/amd: Fix unable to handle page fault due to AVIC
To: Joerg Roedel <joro@8bytes.org>,
 "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>,
 "Bowman, Terry" <Terry.bowman@amd.com>
References: <20210820202957.187572-1-suravee.suthikulpanit@amd.com>
 <f2ec4e5c-3bb1-b703-8842-34357e084bad@amd.com> <YTB/jWr9vb6xvTQp@8bytes.org>
 <5c7921f4-70ad-5d14-f44c-22a49c2ac068@amd.com> <YTntZSVDjQ5yb0NQ@8bytes.org>
Message-ID: <5c1d4825-6494-5ea8-6f47-347c4a25f8a1@amd.com>
Date: Fri, 10 Sep 2021 13:01:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YTntZSVDjQ5yb0NQ@8bytes.org>
Content-Language: en-US
X-ClientProxiedBy: SA0PR11CA0181.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::6) To DM5PR1201MB0201.namprd12.prod.outlook.com
 (2603:10b6:4:5b::21)
MIME-Version: 1.0
Received: from [10.236.31.84] (165.204.77.1) by
 SA0PR11CA0181.namprd11.prod.outlook.com (2603:10b6:806:1bc::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14 via Frontend Transport; Fri, 10 Sep 2021 18:01:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76a1197f-23a1-4634-2ce8-08d97484fa27
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2490:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB24909977F3D84B880A75F5C5CFD69@DM5PR1201MB2490.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VTV0V8FH4B8C0LPxzw6DEdxIcAbEJER4JNDZe8tbvJ/BhjBYOnDPYeofK5IP2Hl60eLNy1E6+TDRc/+WCzPfHqbdY6mVyBy1rJiF0A0PDVGkOwoxlRrMWtW49b/rD2a83zpwpKwb6BeqAIIWCElSRojHvAe6X9K7nwBPmWLs7LoZx0zo5UBGz3jaagHAsloCrv0d62Obfg3nzvKRZnZ4YwR/z8AudjxmAlp0q0Vo/RCQ5rXxZEKeldiqXmzxv/u2i9+jQGN0e3BXBGVM7gANCsyN6nHwxjvMDiTgvcYQFQK2LkX1ThS47HGsrX5qEig8LagnLiqP1Q4CJA5OhMTeW2QzIrj6MpAbWgmHrBEYFqMWVyiBAjAJNmIFxJ9Ed1cggm+YxNr46O75NNDFOGyWeehtTqFYZ1SfG9FwIRfG+V06amWq/8nV4zpsHT845K+7XPiqQbhlqhNXp/TQecbqffs4lHmFovBP32SXRq5mAqMKxO0zkYkJLTGcgjyeLmhj+xBHZLKvzAne64FlHSqkdMoaMNjPsY82lC+71rpG4x5ET8vp4rBDVLG7+ylvppW21jkNl03MstnQVFxnWk5LjpAU6eg4fbzXlNJISIn8y2ErPcKHCDfA9gAx+Q/PsHFWJWEoZOrtHYmMZ1Jjs18CU63mj4Hktr7rIvNb6sEHRhQ0WjOf23jRokCxtLsPl197+7GnsibcPgx6GuRSTNrIkfd0ol8uEFQ7LOz/KQSC68aFu1+T05FHtdsH16tZ1QtYyI1Ks5ibvDGAADalWMMETalGVc0uZwtV7F7R/kX6AlLBM+E21OgQcTmAkQp+ssKAM34RNz1wK95GnOGN9dBAVHu+6flNu35G7rZ8jLWgn+9ljzNpmwBXJbXllMXCfYM1OAZHXjkuvU9Jw8U57bkFRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB0201.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(110136005)(6486002)(316002)(8676002)(16576012)(53546011)(2906002)(5660300002)(8936002)(2616005)(956004)(52116002)(478600001)(66556008)(66476007)(26005)(83380400001)(186003)(4326008)(86362001)(31696002)(6636002)(66946007)(966005)(31686004)(38100700002)(38350700002)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzVQMUxrRVg2OTVIbDBiQWpWQzd3ZitDU1IwaW1HNnZLZTl6RHppV3g2VmI1?=
 =?utf-8?B?WnFSNkR2U0EyNmlsTG1WZ004eWtjRkFXczY0UXNPam9OSFZ3R0tQS0t6cEJl?=
 =?utf-8?B?QnVRanM4SVR2M1NJdzNEd3FjQ1l1eE9lL2hvdUlRMTg0MEtYajJpbGhtSVhm?=
 =?utf-8?B?dVRYYm5scEdBSmg4UzFqTTJYMFpuc3hrVmZoUllRc0FKNHBDSFVXMFdKWi9N?=
 =?utf-8?B?RERPL3UyRU5ua2FNZFk3UER2bExuOVluOS85TXFZZCtlWVRwb2FYVDN1cDZ4?=
 =?utf-8?B?bGZ3ZW9hcXFxOSszeno3UUNUVGdSUkxacGJZWSs0UnNjUjZFZXJxKzd2MjlM?=
 =?utf-8?B?bFgxaGZsZURURDA1bnNjcHpHR0lJenZFVTJlOXM0eWl1amxmYnp4cVlkMVBN?=
 =?utf-8?B?U3NOVTJkK2hMN2FRS2l0MlY0RytaS3J1ZzVGVGt6K0ZnVGFTUklHM2F2aEl1?=
 =?utf-8?B?Nll4dHJTNDE4RUNnSThYbEhGa1JwMGlMMFBFRkYwbmoxU2NSeEpzQ3J4MmdM?=
 =?utf-8?B?UkVpZyt4RmJpOVJRRUVnZG5JcVpCYXdRUmp1Uzd3QlBDYjJialNxRTRXSE8y?=
 =?utf-8?B?WUsvY1hYTlZFSnpUMFJ2emU1aFBtTFhxb3hDeXIyMkd1K1FhYjd0NHJzampW?=
 =?utf-8?B?OTJObytUd3poT2ZzMzRzbkw0b0grMnhIMFBCVEVSWkpzT0xsUXJ2YUYvWmJy?=
 =?utf-8?B?VWYrMzlXdjZWNERnRGozcXpka1dlRUFvUkZYOEFyOVNSSU1BcVhjTldtdDEw?=
 =?utf-8?B?Vmc3dytPcENadGxTdjRHalBLbFYrZ01tNDFaVU5wYUczMlJ6ZW5uWXdJUXEy?=
 =?utf-8?B?dzk0bkJTa2dha2xNVWkweGsxSGFyelhVM3FMVldmRW0wUGJjbENrdFdsbEZS?=
 =?utf-8?B?VVNjVzNYU2I4L0RnZDJydm1NOFFrTDdIMXRHeUNiNExxc1Rob1RsZmlHSDFF?=
 =?utf-8?B?bXc5akR1Z1ZxRzQ1bWpOK2tZeEc5TXNSSmRJM3JXalN5cjRCR1poM3FGOWJG?=
 =?utf-8?B?ZnprRFYyMVNGUkJRb0FHREhrRTd0ZlhVdzRnZ0lHMlNPb2drN0Z4LzcyWlRM?=
 =?utf-8?B?REhyWUFOd3lyVk1WZ09Vd0o5Qk54M0JqcDFJQVZLOTZZelJoYlJqeTNxaDZr?=
 =?utf-8?B?R0dHWUhieDRqcWs2ZWN4MXVpVkNIbnFESmZQMmhpTUtFaER0MmY5N0NhbVh3?=
 =?utf-8?B?Q1ZTZ3M5MjBkcHE5c0p2Y3Y2MzZzSmppSXVEMDBxTEhNLzR6enRWenUvTmJN?=
 =?utf-8?B?aDVnbGZBMWY2QWcvQzFOd1JQNjNvMmpCYTZLbGZKNXI5TmtSN3AzR0hOWGds?=
 =?utf-8?B?VkpHbStYTVJvQ0g2blhIZ3l4Y3BGR1ltMkpOR2lIbzNpaEJXczJVeDl1MHF6?=
 =?utf-8?B?NENxalBYVk9rb0pJV2J0dE53aWVEenlsN1Q4dXptTE1BcWJyK0NCUVRKcGxR?=
 =?utf-8?B?N2N6YmVITDlKZ2NzSm1BeGJvNDdXY20zWjF1S1ZSS1Rvb3lvcUY2MkZVdGU4?=
 =?utf-8?B?L3pXMkhjREdERTdZV0trc2MvenBFNzdDSkJPK0p0QlRwdWt5NG5qMDFIN3U3?=
 =?utf-8?B?QjRLWWtNS1c3WU9yNEZsUHFlN292eTNoUXphc0hDN1M3dUJaTXZ1K211dkdE?=
 =?utf-8?B?R2xYY1ZjSjd0NWxLM01UcnNVb1lsSUI4aTJtUjlFc1RwUndMaHRjL0lma1B3?=
 =?utf-8?B?Z0FHY0ZyeFRYSzhKQVVxZ2dkVW1mSnNVSmJ1cE5iTCtxU1FVbGNIVVJHUTVE?=
 =?utf-8?Q?TNuxUkSzXWAdCbZ7OkUhKBxeU5KB95Z5tKFFrVZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76a1197f-23a1-4634-2ce8-08d97484fa27
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 18:01:13.2811 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t/rQtVkPQiNzCAJYg4dTnz8kU1vzRSyE8XuKZUxpq0d/4eKzQhlvQxYHCvKeRrp/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2490
X-Mailman-Approved-At: Fri, 10 Sep 2021 19:23:39 +0000
Cc: iommu@lists.linux-foundation.org, Jon.Grimm@amd.com,
 linux-kernel@vger.kernel.org
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
From: Wei Huang via iommu <iommu@lists.linux-foundation.org>
Reply-To: Wei Huang <wei.huang2@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Thanks. We did verify the correctness of this patch: we didn't see host
crash with guest reboot when this patch is applied.

Tested-by: Terry Bowman <terry.bowman@amd.com>

Thanks,
-Wei

On 9/9/21 6:17 AM, Joerg Roedel wrote:
> Okay, after this triggered a defconfig compile warning, I squashed patch
> 1 and 2 into one and also #ifdef'ed check_feature_on_all_iommus(). The
> result is here:
> 
> From c3811a50addd23b9bb5a36278609ee1638debcf6 Mon Sep 17 00:00:00 2001
> From: Wei Huang <wei.huang2@amd.com>
> Date: Fri, 20 Aug 2021 15:29:55 -0500
> Subject: [PATCH] iommu/amd: Relocate GAMSup check to early_enable_iommus
> 
> Currently, iommu_init_ga() checks and disables IOMMU VAPIC support
> (i.e. AMD AVIC support in IOMMU) when GAMSup feature bit is not set.
> However it forgets to clear IRQ_POSTING_CAP from the previously set
> amd_iommu_irq_ops.capability.
> 
> This triggers an invalid page fault bug during guest VM warm reboot
> if AVIC is enabled since the irq_remapping_cap(IRQ_POSTING_CAP) is
> incorrectly set, and crash the system with the following kernel trace.
> 
>     BUG: unable to handle page fault for address: 0000000000400dd8
>     RIP: 0010:amd_iommu_deactivate_guest_mode+0x19/0xbc
>     Call Trace:
>      svm_set_pi_irte_mode+0x8a/0xc0 [kvm_amd]
>      ? kvm_make_all_cpus_request_except+0x50/0x70 [kvm]
>      kvm_request_apicv_update+0x10c/0x150 [kvm]
>      svm_toggle_avic_for_irq_window+0x52/0x90 [kvm_amd]
>      svm_enable_irq_window+0x26/0xa0 [kvm_amd]
>      vcpu_enter_guest+0xbbe/0x1560 [kvm]
>      ? avic_vcpu_load+0xd5/0x120 [kvm_amd]
>      ? kvm_arch_vcpu_load+0x76/0x240 [kvm]
>      ? svm_get_segment_base+0xa/0x10 [kvm_amd]
>      kvm_arch_vcpu_ioctl_run+0x103/0x590 [kvm]
>      kvm_vcpu_ioctl+0x22a/0x5d0 [kvm]
>      __x64_sys_ioctl+0x84/0xc0
>      do_syscall_64+0x33/0x40
>      entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> Fixes by moving the initializing of AMD IOMMU interrupt remapping mode
> (amd_iommu_guest_ir) earlier before setting up the
> amd_iommu_irq_ops.capability with appropriate IRQ_POSTING_CAP flag.
> 
> [joro:	Squashed the two patches and limited
> 	check_features_on_all_iommus() to CONFIG_IRQ_REMAP
> 	to fix a compile warning.]
> 
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Link: https://lore.kernel.org/r/20210820202957.187572-2-suravee.suthikulpanit@amd.com
> Link: https://lore.kernel.org/r/20210820202957.187572-3-suravee.suthikulpanit@amd.com
> Fixes: 8bda0cfbdc1a ("iommu/amd: Detect and initialize guest vAPIC log")
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/iommu/amd/init.c | 31 ++++++++++++++++++++++++-------
>  1 file changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index bdcf167b4afe..4e753d1860b3 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -297,6 +297,22 @@ int amd_iommu_get_num_iommus(void)
>  	return amd_iommus_present;
>  }
>  
> +#ifdef CONFIG_IRQ_REMAP
> +static bool check_feature_on_all_iommus(u64 mask)
> +{
> +	bool ret = false;
> +	struct amd_iommu *iommu;
> +
> +	for_each_iommu(iommu) {
> +		ret = iommu_feature(iommu, mask);
> +		if (!ret)
> +			return false;
> +	}
> +
> +	return true;
> +}
> +#endif
> +
>  /*
>   * For IVHD type 0x11/0x40, EFR is also available via IVHD.
>   * Default to IVHD EFR since it is available sooner
> @@ -853,13 +869,6 @@ static int iommu_init_ga(struct amd_iommu *iommu)
>  	int ret = 0;
>  
>  #ifdef CONFIG_IRQ_REMAP
> -	/* Note: We have already checked GASup from IVRS table.
> -	 *       Now, we need to make sure that GAMSup is set.
> -	 */
> -	if (AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) &&
> -	    !iommu_feature(iommu, FEATURE_GAM_VAPIC))
> -		amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY_GA;
> -
>  	ret = iommu_init_ga_log(iommu);
>  #endif /* CONFIG_IRQ_REMAP */
>  
> @@ -2479,6 +2488,14 @@ static void early_enable_iommus(void)
>  	}
>  
>  #ifdef CONFIG_IRQ_REMAP
> +	/*
> +	 * Note: We have already checked GASup from IVRS table.
> +	 *       Now, we need to make sure that GAMSup is set.
> +	 */
> +	if (AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) &&
> +	    !check_feature_on_all_iommus(FEATURE_GAM_VAPIC))
> +		amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY_GA;
> +
>  	if (AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir))
>  		amd_iommu_irq_ops.capability |= (1 << IRQ_POSTING_CAP);
>  #endif
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
