Return-Path: <SRS0=3YoF=JH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AEAC433B4
	for <iommu@archiver.kernel.org>; Sat, 10 Apr 2021 08:17:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41EAF61185
	for <iommu@archiver.kernel.org>; Sat, 10 Apr 2021 08:17:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41EAF61185
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=live.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0805083C33;
	Sat, 10 Apr 2021 08:17:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0AnChGRNKYRq; Sat, 10 Apr 2021 08:17:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1C50B83C34;
	Sat, 10 Apr 2021 08:17:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E4842C000B;
	Sat, 10 Apr 2021 08:17:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15408C000A
 for <iommu@lists.linux-foundation.org>; Sat, 10 Apr 2021 08:17:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EC0D183C34
 for <iommu@lists.linux-foundation.org>; Sat, 10 Apr 2021 08:17:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j7X9tsV9GiGq for <iommu@lists.linux-foundation.org>;
 Sat, 10 Apr 2021 08:17:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-oln040092074029.outbound.protection.outlook.com [40.92.74.29])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A9FD983C33
 for <iommu@lists.linux-foundation.org>; Sat, 10 Apr 2021 08:17:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TnmvuSml9GzQ5BMrDgNDosfMHldSnmo4RX1MjXyurLjcQUJxbGdlayLFsSqdXynbdFpTWEixCW10FAxS86VJ/RxRTG5iYwPaVW6Ce1103PZvqVCzEygevlycDAB0a08BCAjrlP8Q05/bumucHz/uoIII/MLsCBpzNNPuEP39iSL8kmvwVdKA+UMPr2GlHsFVPiib9j5UVbuIv9HqMyS8cUxJcnwuGFzPCIF9sXDUSno4VOphCs12RH5MY5NCpTjYxBB5jvbOjOlsDydKPKeYhR9hrJlSM3NuK8Z2wZ5G3f3l7wXrH5pGB38OrnQuK1rfjDPytLTPKWV/fmBF/2uk+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0OZSPYTLYUxKGz73EOVQZ+RzNGTZJKGo4iDxooyTVnI=;
 b=HYPLMQEwWevyee9TZjGo/LCDFkvfGcS/O8u/aBZEX6r80T7urPV4E4B4Kl1Vie02N3cbQ3nNZ4wonzfW8CY/FitZVNE1rKTwEl6UzE/PlQpwvz2JVi1nPr4sMEShxqmDiECng7Bxd+pIKZQA7RzicxDT1simIUGsgKYiS3QPL4lIgk3g4eKm8WwWMzE+aeqPXRVU9knVy4JIjrPcyO6X8pBdIaitXczCCS3T61RzWHV5W3aEpPoed5E6lRkPrp9pzIKfOPYocUqeFpJFCgnvhuHWJtbFJBS92pMG24TnNxD0TgM+fYpZzeHUQXKAOTVU7hfro26JvsXdxh+LwVl9yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from VI1EUR04FT045.eop-eur04.prod.protection.outlook.com
 (2a01:111:e400:7e0e::4a) by
 VI1EUR04HT214.eop-eur04.prod.protection.outlook.com (2a01:111:e400:7e0e::340)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Sat, 10 Apr
 2021 08:17:33 +0000
Received: from VI1PR09MB2638.eurprd09.prod.outlook.com
 (2a01:111:e400:7e0e::4c) by VI1EUR04FT045.mail.protection.outlook.com
 (2a01:111:e400:7e0e::261) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend
 Transport; Sat, 10 Apr 2021 08:17:33 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:8565501D067E3CF2B9032DD715922D3AA7E8484DDABA94569EA80264D38183F2;
 UpperCasedChecksum:EAE8A138F7694D25DC30288BE2E60D8958BC57E83768A30C7515A284411C0C69;
 SizeAsReceived:9056; Count:48
Received: from VI1PR09MB2638.eurprd09.prod.outlook.com
 ([fe80::948b:987c:566b:198e]) by VI1PR09MB2638.eurprd09.prod.outlook.com
 ([fe80::948b:987c:566b:198e%5]) with mapi id 15.20.4020.021; Sat, 10 Apr 2021
 08:17:33 +0000
Subject: Re: [PATCH 2/2] iommu/amd: Remove performance counter
 pre-initialization test
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
References: <20210409085848.3908-1-suravee.suthikulpanit@amd.com>
 <20210409085848.3908-3-suravee.suthikulpanit@amd.com>
From: David Coe <david.coe@live.co.uk>
Message-ID: <VI1PR09MB2638FACB956277A7CEAAE367C7729@VI1PR09MB2638.eurprd09.prod.outlook.com>
Date: Sat, 10 Apr 2021 09:17:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210409085848.3908-3-suravee.suthikulpanit@amd.com>
Content-Language: en-GB
X-TMN: [rduGy+E+by0qeIukvtM32Bvy+L3Ajqir]
X-ClientProxiedBy: LO2P265CA0046.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::34) To VI1PR09MB2638.eurprd09.prod.outlook.com
 (2603:10a6:803:7b::27)
X-Microsoft-Original-Message-ID: <3cf21069-e4a7-3520-1b93-a198445412f9@live.co.uk>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.6] (90.246.218.100) by
 LO2P265CA0046.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:61::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.21 via Frontend Transport; Sat, 10 Apr 2021 08:17:32 +0000
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 48
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: ef5f3d79-0567-4965-8398-08d8fbf91737
X-MS-TrafficTypeDiagnostic: VI1EUR04HT214:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zMZ26jKp6O9jfyRKLtjGJFI5XNNnJjkuS6joPqr8P9nEeYuv3KPeir60pnY/l22c81UeZWOtYKPYF8S8l9JHmnWJTYp/xgxs6XiBZlIa9NJG9Sfld3i61v2hCI/3Iqu8AkdPL18ADlKzKAqxyTX8YAkBxfwGokdHFxO6SmNQuxAdzj3bzkrvieJzkLQGKa9tu5wKFN8MS6hd0dWzLXwtOIMch1i8xarCv3uk+DzhotowHbMpcrN+GwOBSBFjYNogGXsXKvE4eM+O2EyMCx+Ng97SaZE72bpvUnLWPenkasvjEgN/txrlcIyE7bN3OFl2ktBvblpaAGLv+QbVzO1CV32kfsjSBwMtXZxrD/dIKydM2xxM+bCqSrv18Ay40oaOHE/Lt5WK07OjktoYZCm9BQ==
X-MS-Exchange-AntiSpam-MessageData: L8cyyihZvfgv/iePdLcpzQASoEuYd4fV77RHmkoPCWyyy410MqBjUE0XDeb/Xr3WYpK72mJX+d5sBJtBp90278EqiZsrEZloRz6dq9bQL6SEzFypfFLlrBV8LC2z+JgwXJc2CHPe2eGnkOf5jiTsbQ==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef5f3d79-0567-4965-8398-08d8fbf91737
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2021 08:17:32.9936 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR04FT045.eop-eur04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1EUR04HT214
Cc: pmenzel@molgen.mpg.de, Alexander Monakov <amonakov@ispras.ru>,
 Alex Hung <1917203@bugs.launchpad.net>, Jon.Grimm@amd.com,
 Shuah Khan <skhan@linuxfoundation.org>, Tj <ml.linux@elloe.vision>,
 will@kernel.org
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

V2VsbCwgd2VsbCEgVGhpcyBpcyBhIHByb21pc2luZyBzdGFydCB0byB0aGUgd2Vla2VuZC4gVGhh
bmsgeW91IGJvdGgsIApTdXJhdmVlIGFuZCBQYXVsLgoKUmVzdWx0cyBmb3IgQU1EIFJ5emVuIDQg
MjQwMEcKICAgcnVubmluZyBVYnVudHUgMjEuMDTOsiBrZXJuZWwgNS4xMS4wLTEzIGFuZCBXaW5k
b3dzIDEwIDJIMiB1bmRlciBLVk0KCiQgc3VkbyBkbWVzZyB8IGdyZXAgSU9NTVUKWyAgICAwLjU1
NzcyNV0gcGNpIDAwMDA6MDA6MDAuMjogQU1ELVZpOiBJT01NVSBwZXJmb3JtYW5jZSBjb3VudGVy
cyAKc3VwcG9ydGVkClsgICAgMC41NjE1MzhdIHBjaSAwMDAwOjAwOjAwLjI6IEFNRC1WaTogRm91
bmQgSU9NTVUgY2FwIDB4NDAKWyAgICAwLjU2MjgyOF0gcGVyZi9hbWRfaW9tbXU6IERldGVjdGVk
IEFNRCBJT01NVSAjMCAoMiBiYW5rcywgNCAKY291bnRlcnMvYmFuaykuClsgICAgMC44ODExMDhd
IEFNRC1WaTogQU1EIElPTU1VdjIgZHJpdmVyIGJ5IEpvZXJnIFJvZWRlbCA8anJvZWRlbEBzdXNl
LmRlPgoKJCBzeXN0b29sIC1tIGt2bV9hbWQgLXYKTW9kdWxlID0gImt2bV9hbWQiCgogICBBdHRy
aWJ1dGVzOgogICAgIGNvcmVzaXplICAgICAgICAgICAgPSAiMTE0Njg4IgogICAgIGluaXRzaXpl
ICAgICAgICAgICAgPSAiMCIKICAgICBpbml0c3RhdGUgICAgICAgICAgID0gImxpdmUiCiAgICAg
cmVmY250ICAgICAgICAgICAgICA9ICIwIgogICAgIHNyY3ZlcnNpb24gICAgICAgICAgPSAiNDM3
MUJBMTdBNDE4MjMxMDFGOTA3NjEiCiAgICAgdGFpbnQgICAgICAgICAgICAgICA9ICIiCiAgICAg
dWV2ZW50ICAgICAgICAgICAgICA9IDxzdG9yZSBtZXRob2Qgb25seT4KCiAgIFBhcmFtZXRlcnM6
CiAgICAgYXZpYyAgICAgICAgICAgICAgICA9ICIwIgogICAgIGR1bXBfaW52YWxpZF92bWNiICAg
PSAiTiIKICAgICBuZXN0ZWQgICAgICAgICAgICAgID0gIjEiCiAgICAgbnB0ICAgICAgICAgICAg
ICAgICA9ICIxIgogICAgIG5yaXBzICAgICAgICAgICAgICAgPSAiMSIKICAgICBwYXVzZV9maWx0
ZXJfY291bnRfZ3Jvdz0gIjIiCiAgICAgcGF1c2VfZmlsdGVyX2NvdW50X21heD0gIjY1NTM1Igog
ICAgIHBhdXNlX2ZpbHRlcl9jb3VudF9zaHJpbms9ICIwIgogICAgIHBhdXNlX2ZpbHRlcl9jb3Vu
dCAgPSAiMzAwMCIKICAgICBwYXVzZV9maWx0ZXJfdGhyZXNoID0gIjEyOCIKICAgICBzZXZfZXMg
ICAgICAgICAgICAgID0gIjAiCiAgICAgc2V2ICAgICAgICAgICAgICAgICA9ICIwIgogICAgIHZn
aWYgICAgICAgICAgICAgICAgPSAiMSIKICAgICB2bHMgICAgICAgICAgICAgICAgID0gIjEiCgog
ICBTZWN0aW9uczoKCiQgY29tcGdlbiAtRyAiL3N5cy9rZXJuZWwvaW9tbXVfZ3JvdXBzLyovZGV2
aWNlcy8qIgovc3lzL2tlcm5lbC9pb21tdV9ncm91cHMvOS9kZXZpY2VzLzAwMDA6MDk6MDAuMAov
c3lzL2tlcm5lbC9pb21tdV9ncm91cHMvMC9kZXZpY2VzLzAwMDA6MDA6MDEuMAovc3lzL2tlcm5l
bC9pb21tdV9ncm91cHMvMTAvZGV2aWNlcy8wMDAwOjBhOjAwLjAKL3N5cy9rZXJuZWwvaW9tbXVf
Z3JvdXBzLzIvZGV2aWNlcy8wMDAwOjAwOjAxLjYKL3N5cy9rZXJuZWwvaW9tbXVfZ3JvdXBzLzEy
L2RldmljZXMvMDAwMDowYjowMC4wCi9zeXMva2VybmVsL2lvbW11X2dyb3Vwcy80L2RldmljZXMv
MDAwMDowMDowOC4xCi9zeXMva2VybmVsL2lvbW11X2dyb3Vwcy82L2RldmljZXMvMDAwMDowMDox
NC4wCi9zeXMva2VybmVsL2lvbW11X2dyb3Vwcy82L2RldmljZXMvMDAwMDowMDoxNC4zCi9zeXMv
a2VybmVsL2lvbW11X2dyb3Vwcy84L2RldmljZXMvMDAwMDowMjowNC4wCi9zeXMva2VybmVsL2lv
bW11X2dyb3Vwcy84L2RldmljZXMvMDAwMDowMjowMS4wCi9zeXMva2VybmVsL2lvbW11X2dyb3Vw
cy84L2RldmljZXMvMDAwMDowNDowMC4wCi9zeXMva2VybmVsL2lvbW11X2dyb3Vwcy84L2Rldmlj
ZXMvMDAwMDowMTowMC4xCi9zeXMva2VybmVsL2lvbW11X2dyb3Vwcy84L2RldmljZXMvMDAwMDow
MjowNi4wCi9zeXMva2VybmVsL2lvbW11X2dyb3Vwcy84L2RldmljZXMvMDAwMDowMTowMC4wCi9z
eXMva2VybmVsL2lvbW11X2dyb3Vwcy84L2RldmljZXMvMDAwMDowMTowMC4yCi9zeXMva2VybmVs
L2lvbW11X2dyb3Vwcy84L2RldmljZXMvMDAwMDowODowMC4wCi9zeXMva2VybmVsL2lvbW11X2dy
b3Vwcy84L2RldmljZXMvMDAwMDowMjowMC4wCi9zeXMva2VybmVsL2lvbW11X2dyb3Vwcy84L2Rl
dmljZXMvMDAwMDowMjowNy4wCi9zeXMva2VybmVsL2lvbW11X2dyb3Vwcy84L2RldmljZXMvMDAw
MDowMzowMC4wCi9zeXMva2VybmVsL2lvbW11X2dyb3Vwcy8xL2RldmljZXMvMDAwMDowMDowMS4y
Ci9zeXMva2VybmVsL2lvbW11X2dyb3Vwcy8xMS9kZXZpY2VzLzAwMDA6MGE6MDAuMQovc3lzL2tl
cm5lbC9pb21tdV9ncm91cHMvMTEvZGV2aWNlcy8wMDAwOjBhOjAwLjMKL3N5cy9rZXJuZWwvaW9t
bXVfZ3JvdXBzLzExL2RldmljZXMvMDAwMDowYTowMC4yCi9zeXMva2VybmVsL2lvbW11X2dyb3Vw
cy8xMS9kZXZpY2VzLzAwMDA6MGE6MDAuNAovc3lzL2tlcm5lbC9pb21tdV9ncm91cHMvMTEvZGV2
aWNlcy8wMDAwOjBhOjAwLjYKL3N5cy9rZXJuZWwvaW9tbXVfZ3JvdXBzLzMvZGV2aWNlcy8wMDAw
OjAwOjA4LjAKL3N5cy9rZXJuZWwvaW9tbXVfZ3JvdXBzLzUvZGV2aWNlcy8wMDAwOjAwOjA4LjIK
L3N5cy9rZXJuZWwvaW9tbXVfZ3JvdXBzLzcvZGV2aWNlcy8wMDAwOjAwOjE4LjUKL3N5cy9rZXJu
ZWwvaW9tbXVfZ3JvdXBzLzcvZGV2aWNlcy8wMDAwOjAwOjE4LjcKL3N5cy9rZXJuZWwvaW9tbXVf
Z3JvdXBzLzcvZGV2aWNlcy8wMDAwOjAwOjE4LjAKL3N5cy9rZXJuZWwvaW9tbXVfZ3JvdXBzLzcv
ZGV2aWNlcy8wMDAwOjAwOjE4LjIKL3N5cy9rZXJuZWwvaW9tbXVfZ3JvdXBzLzcvZGV2aWNlcy8w
MDAwOjAwOjE4LjQKL3N5cy9rZXJuZWwvaW9tbXVfZ3JvdXBzLzcvZGV2aWNlcy8wMDAwOjAwOjE4
LjYKL3N5cy9rZXJuZWwvaW9tbXVfZ3JvdXBzLzcvZGV2aWNlcy8wMDAwOjAwOjE4LjEKL3N5cy9r
ZXJuZWwvaW9tbXVfZ3JvdXBzLzcvZGV2aWNlcy8wMDAwOjAwOjE4LjMKCiQgc3VkbyBrdm0tb2sK
SU5GTzogL2Rldi9rdm0gZXhpc3RzCktWTSBhY2NlbGVyYXRpb24gY2FuIGJlIHVzZWQKCiQgc3Vk
byBwZXJmIHN0YXQgLWUgJ2FtZF9pb21tdV8wL2NtZF9wcm9jZXNzZWQvLCAKYW1kX2lvbW11XzAv
Y21kX3Byb2Nlc3NlZF9pbnYvLCBhbWRfaW9tbXVfMC9pZ25fcmRfd3JfbW1pb18xZmY4aC8sIAph
bWRfaW9tbXVfMC9pbnRfZHRlX2hpdC8sIGFtZF9pb21tdV8wL2ludF9kdGVfbWlzLywgCmFtZF9p
b21tdV8wL21lbV9kdGVfaGl0LywgYW1kX2lvbW11XzAvbWVtX2R0ZV9taXMvLCAKYW1kX2lvbW11
XzAvbWVtX2lvbW11X3RsYl9wZGVfaGl0LywgYW1kX2lvbW11XzAvbWVtX2lvbW11X3RsYl9wZGVf
bWlzLywgCmFtZF9pb21tdV8wL21lbV9pb21tdV90bGJfcHRlX2hpdC8sIGFtZF9pb21tdV8wL21l
bV9pb21tdV90bGJfcHRlX21pcy8sIAphbWRfaW9tbXVfMC9tZW1fcGFzc19leGNsLywgYW1kX2lv
bW11XzAvbWVtX3Bhc3NfcHJldHJhbnMvLCAKYW1kX2lvbW11XzAvbWVtX3Bhc3NfdW50cmFucy8s
IGFtZF9pb21tdV8wL21lbV90YXJnZXRfYWJvcnQvLCAKYW1kX2lvbW11XzAvbWVtX3RyYW5zX3Rv
dGFsLywgYW1kX2lvbW11XzAvcGFnZV90YmxfcmVhZF9nc3QvLCAKYW1kX2lvbW11XzAvcGFnZV90
YmxfcmVhZF9uc3QvLCBhbWRfaW9tbXVfMC9wYWdlX3RibF9yZWFkX3RvdC8sIAphbWRfaW9tbXVf
MC9zbWlfYmxrLywgYW1kX2lvbW11XzAvc21pX3JlY3YvLCBhbWRfaW9tbXVfMC90bGJfaW52Lywg
CmFtZF9pb21tdV8wL3ZhcGljX2ludF9ndWVzdC8sIGFtZF9pb21tdV8wL3ZhcGljX2ludF9ub25f
Z3Vlc3QvJyBzbGVlcCAxMAoKUGVyZm9ybWFuY2UgY291bnRlciBzdGF0cyBmb3IgJ3N5c3RlbSB3
aWRlJzoKCiAgICAgICAgICAgICAgICAgICAwICAgICAgIGFtZF9pb21tdV8wL2NtZF9wcm9jZXNz
ZWQvICAgICAgICAgICAgKDMzLjMyJSkKICAgICAgICAgICAgICAgICAgIDIgICAgICAgYW1kX2lv
bW11XzAvY21kX3Byb2Nlc3NlZF9pbnYvICAgICAgICAoMzMuMzUlKQogICAgICAgICAgICAgICAg
ICAgMCAgICAgICBhbWRfaW9tbXVfMC9pZ25fcmRfd3JfbW1pb18xZmY4aC8gICAgICgzMy4zOSUp
CiAgICAgICAgICAgICAgICAgMzQwICAgICAgIGFtZF9pb21tdV8wL2ludF9kdGVfaGl0LyAgICAg
ICAgICAgICAgKDMzLjQzJSkKICAgICAgICAgICAgICAgICAgMjMgICAgICAgYW1kX2lvbW11XzAv
aW50X2R0ZV9taXMvICAgICAgICAgICAgICAoMzMuNDQlKQogICAgICAgICAgICAgICAgIDU1NiAg
ICAgICBhbWRfaW9tbXVfMC9tZW1fZHRlX2hpdC8gICAgICAgICAgICAgICgzMy40NCUpCjg0MSw2
ODksMTUxLDIwMiw5MzkgICAgICAgYW1kX2lvbW11XzAvbWVtX2R0ZV9taXMvICAgICAgICAgICAg
ICAoMzMuNDQlKQogICAgICAgICAgICAgICAgICA3NCAgICAgICBhbWRfaW9tbXVfMC9tZW1faW9t
bXVfdGxiX3BkZV9oaXQvICAgICgzMy40NCUpCiAgICAgICAgICAgICAgICAgNTAyICAgICAgIGFt
ZF9pb21tdV8wL21lbV9pb21tdV90bGJfcGRlX21pcy8gICAgKDMzLjQxJSkKICAgICAgICAgICAg
ICAgMSwxOTUgICAgICAgYW1kX2lvbW11XzAvbWVtX2lvbW11X3RsYl9wdGVfaGl0LyAgICAoMzMu
MzYlKQogICAgICAgICAgICAgICA4LDAxNyAgICAgICBhbWRfaW9tbXVfMC9tZW1faW9tbXVfdGxi
X3B0ZV9taXMvICAgICgzMy4zMyUpCiAgICAgICAgICAgICAgICAgICAwICAgICAgIGFtZF9pb21t
dV8wL21lbV9wYXNzX2V4Y2wvICAgICAgICAgICAgKDMzLjI5JSkKICAgICAgICAgICAgICAgICAg
IDAgICAgICAgYW1kX2lvbW11XzAvbWVtX3Bhc3NfcHJldHJhbnMvICAgICAgICAoMzMuMjglKQog
ICAgICAgICAgICAgIDE2LDUwNCAgICAgICBhbWRfaW9tbXVfMC9tZW1fcGFzc191bnRyYW5zLyAg
ICAgICAgICgzMy4yOCUpCiAgICAgICAgICAgICAgICAgICAwICAgICAgIGFtZF9pb21tdV8wL21l
bV90YXJnZXRfYWJvcnQvICAgICAgICAgKDMzLjI4JSkKICAgICAgICAgICAgICAgMiw4NDIgICAg
ICAgYW1kX2lvbW11XzAvbWVtX3RyYW5zX3RvdGFsLyAgICAgICAgICAoMzMuMjglKQogICAgICAg
ICAgICAgICAgICAgMCAgICAgICBhbWRfaW9tbXVfMC9wYWdlX3RibF9yZWFkX2dzdC8gICAgICAg
ICgzMy4yOCUpCiAgICAgICAgICAgICAgICAgMTExICAgICAgIGFtZF9pb21tdV8wL3BhZ2VfdGJs
X3JlYWRfbnN0LyAgICAgICAgKDMzLjI5JSkKICAgICAgICAgICAgICAgICAxMTEgICAgICAgYW1k
X2lvbW11XzAvcGFnZV90YmxfcmVhZF90b3QvICAgICAgICAoMzMuMjglKQogICAgICAgICAgICAg
ICAgICAgMCAgICAgICBhbWRfaW9tbXVfMC9zbWlfYmxrLyAgICAgICAgICAgICAgICAgICgzMy4y
OCUpCiAgICAgICAgICAgICAgICAgICAwICAgICAgIGFtZF9pb21tdV8wL3NtaV9yZWN2LyAgICAg
ICAgICAgICAgICAgKDMzLjI5JSkKICAgICAgICAgICAgICAgICAgIDAgICAgICAgYW1kX2lvbW11
XzAvdGxiX2ludi8gICAgICAgICAgICAgICAgICAoMzMuMjglKQogICAgICAgICAgICAgICAgICAg
MCAgICAgICBhbWRfaW9tbXVfMC92YXBpY19pbnRfZ3Vlc3QvICAgICAgICAgICgzMy4yOCUpCiAg
ICAgICAgICAgICAgICAgMzQ1ICAgICAgIGFtZF9pb21tdV8wL3ZhcGljX2ludF9ub25fZ3Vlc3Qv
ICAgICAgKDMzLjI5JSkKCiAgICAgICAgMTAuMDAwNzk5MTI4IHNlY29uZHMgdGltZSBlbGFwc2Vk
CgpSZXN1bHRzIGZvciBSeXplbiA3IDQ3MDBVIHRvIGZvbGxvdy4KCi0tIApEYXZpZCBDb2UKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGlu
ZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
