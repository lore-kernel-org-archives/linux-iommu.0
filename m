Return-Path: <SRS0=gU7u=JK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160D1C433B4
	for <iommu@archiver.kernel.org>; Tue, 13 Apr 2021 09:38:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ED5D6121E
	for <iommu@archiver.kernel.org>; Tue, 13 Apr 2021 09:38:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ED5D6121E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=live.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 621D840678;
	Tue, 13 Apr 2021 09:38:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id du4i4ZsRoe9k; Tue, 13 Apr 2021 09:38:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0BA354061D;
	Tue, 13 Apr 2021 09:38:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2F10C000B;
	Tue, 13 Apr 2021 09:38:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5E4C3C000A
 for <iommu@lists.linux-foundation.org>; Tue, 13 Apr 2021 09:38:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 36DDB4061F
 for <iommu@lists.linux-foundation.org>; Tue, 13 Apr 2021 09:38:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w982QhjO7PeJ for <iommu@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 09:38:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-oln040092064102.outbound.protection.outlook.com [40.92.64.102])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BDEEB4061D
 for <iommu@lists.linux-foundation.org>; Tue, 13 Apr 2021 09:38:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BwRrUU0F3yQRMWDKp8C22wqJwgjfDdpe9wPCrR7mDs+406REc3lfOzXeOKHEAAYfMCep6X7b2zqJCGBlFb39IEENaIGY9z+FO8vD5kEd3ahkYoB9cdB2no9N2v1Vvc4cnAOoloPghZ5JywFFjATgDZTw+nCPh34IihTrwJajM45xcd3s8uJ7wnjfJavMeWZUfVUIKob/y2dWTLgRizmFqIv5LqVv6V0H1EW3IoyAk9LdJnGwT7ruvRQWp/u4pcfZ+Cd/q7NilS+9cgfPd+hn2e2llvTxHWCSXP+E1pZJrbxzZOy3oiDJkjAdJb7BG0Fhmh+42Ga/DDcb/Sqove8fUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UtA868Cy6H/+QOpEN6Gk+NoOxwBGJGkmrCIHd0qfa/o=;
 b=JbPb4SzTxDKzDW2/AVVGIGazLSIQrH+9UZ0do+mTy3/wo8usriUkSu8pNV9LgrWkE2M36tQvWCoQ1SnRYoE7nyLY/ZSI1nXGrxW0h0Y1FdMYnUq4Dz2xpbHUp4G6QqusqndgDF8b7XHM53EZGcEL8JaL4T6SoljC37yKA5A4Her+KE8I0x/ySCilCVmHVyV136bo+LbmaLST7eOUb/x3UMZ2zxQ1HuBLO8jFNdsbj95aUac54HBVIQul7bl06gG8jL1O5DmTRaEmbwZdUA31G/lH06NFcAVIitlHcy3/p2xKAZIEeXKeIp6AJiSkuJodq+en79QXgOSLerj9b+zJCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DB5EUR01FT013.eop-EUR01.prod.protection.outlook.com
 (2a01:111:e400:7e1a::44) by
 DB5EUR01HT089.eop-EUR01.prod.protection.outlook.com (2a01:111:e400:7e1a::269)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Tue, 13 Apr
 2021 09:38:04 +0000
Received: from VI1PR09MB2638.eurprd09.prod.outlook.com
 (2a01:111:e400:7e1a::53) by DB5EUR01FT013.mail.protection.outlook.com
 (2a01:111:e400:7e1a::239) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend
 Transport; Tue, 13 Apr 2021 09:38:04 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:5BB13109A7AF8E32FD3B084969A2F35ADB25557391B64C692E7EB5FACE296EAF;
 UpperCasedChecksum:356E1DEA4B4AE7AE8695E728B6CBC514D2B06DC32C12A4EF1856530CB262A58C;
 SizeAsReceived:9051; Count:48
Received: from VI1PR09MB2638.eurprd09.prod.outlook.com
 ([fe80::948b:987c:566b:198e]) by VI1PR09MB2638.eurprd09.prod.outlook.com
 ([fe80::948b:987c:566b:198e%5]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 09:38:04 +0000
Subject: Re: [PATCH 2/2] iommu/amd: Remove performance counter
 pre-initialization test
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
References: <20210409085848.3908-1-suravee.suthikulpanit@amd.com>
 <20210409085848.3908-3-suravee.suthikulpanit@amd.com>
From: David Coe <david.coe@live.co.uk>
Message-ID: <VI1PR09MB263861ABB6D5CB6A000CD6F8C74F9@VI1PR09MB2638.eurprd09.prod.outlook.com>
Date: Tue, 13 Apr 2021 10:38:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210409085848.3908-3-suravee.suthikulpanit@amd.com>
Content-Language: en-GB
X-TMN: [nyP/018UJNi/J2HPxxZ8jv22RUs0pvps]
X-ClientProxiedBy: LO2P265CA0156.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::24) To VI1PR09MB2638.eurprd09.prod.outlook.com
 (2603:10a6:803:7b::27)
X-Microsoft-Original-Message-ID: <03d0e57c-9a90-2605-cddd-cd619439e138@live.co.uk>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.6] (90.246.218.100) by
 LO2P265CA0156.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:9::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.21 via Frontend Transport; Tue, 13 Apr 2021 09:38:03 +0000
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 48
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: c6442614-959c-476c-b807-08d8fe5fd62a
X-MS-TrafficTypeDiagnostic: DB5EUR01HT089:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FRqcERWRBgofHi1M3rjDvvEJO+KS7iDksvjjknwbtQweZj92OjcwS8IOH9fIgDoIu4XbUQ8kN49oSlgQkMe5JVQU8BqWSCh7mslBsPdZZPiQMiP+5vG8e5Uwy6G8QfKzGhaEZ4NlbJADFC2FRtNxC1xeq/Omt0mnR0nTGb3CGAOdFyP7Ph3FvMLlBcWMIbTQbPdLwBv9Hu5iE7OxxYG4TIcKmmUdqhWGv9jQNWI5N6vk4sw+ivTzO9piYAkqPqSit5GvLb5gHmCX5Y2zuMZbv4byG9YrI8V07bU4w0Yl7VavSGEpzcPI+tJhrShfNaKApuFSLXqaZMLPsAKCsVVejN1TcQDw9UFgQoS2dEFsdjUqVGioNE0Ep/JJdezyDTHEkNqv4UwXIJ03pqFbrJbqxg==
X-MS-Exchange-AntiSpam-MessageData: p4WVkVd12/9+i0TP/PjUAjlYGg/fAMZ2mlU0QfXelWER7Lnl+kJRx3qWF8w1GjQIzyrhAkKw2h4wHl1bB3eFTiltwfDWbshE3cO36m2PN2Dn1efjItqYLBocoHqXeuUjEJsyNKG5Cj8vAK9jSOdLVA==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6442614-959c-476c-b807-08d8fe5fd62a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 09:38:04.4835 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT013.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5EUR01HT089
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

SGkgU3VyYXZlZSEKCkp1c3QgaW4gY2FzZSAoISksIEkndmUgcnVuIHlvdXIgcmV2ZXJ0K3VwZGF0
ZSBwYXRjaCBvbiBrZXJuZWwgNS4xMS4wLTEzLCAKVWJ1bnR1IDIxLjA0zrIgcnVubmluZyBvbiBh
biBBTUQgRlgtODM1MCAocHJlIFplbiBhbmQgSU9NTVV2MikuIEFzIHdpdGggCnRoZSBBTUQgUnl6
ZW4gMjQwMEcgYW5kIDQ3MDBVLCBJJ20gZmluZGluZyBubyBvYnZpb3VzIGlzc3Vlcy4KCgokIHN1
ZG8gZG1lc2cgfCBncmVwIElPTU1VClsgICAgMC45NDg4OTBdIHBjaSAwMDAwOjAwOjAwLjI6IEFN
RC1WaTogRm91bmQgSU9NTVUgY2FwIDB4NDAKWyAgICA0LjM5Mzc3M10gQU1ELVZpOiBBTUQgSU9N
TVV2MiBkcml2ZXIgYnkgSm9lcmcgUm9lZGVsIDxqcm9lZGVsQHN1c2UuZGU+ClsgICAgNC4zOTM3
NzZdIEFNRC1WaTogQU1EIElPTU1VdjIgZnVuY3Rpb25hbGl0eSBub3QgYXZhaWxhYmxlIG9uIHRo
aXMgCnN5c3RlbQoKCiQgc3lzdG9vbCAtbSBrdm1fYW1kIC12Ck1vZHVsZSA9ICJrdm1fYW1kIgoK
ICAgQXR0cmlidXRlczoKICAgICBjb3Jlc2l6ZSAgICAgICAgICAgID0gIjExNDY4OCIKICAgICBp
bml0c2l6ZSAgICAgICAgICAgID0gIjAiCiAgICAgaW5pdHN0YXRlICAgICAgICAgICA9ICJsaXZl
IgogICAgIHJlZmNudCAgICAgICAgICAgICAgPSAiMCIKICAgICBzcmN2ZXJzaW9uICAgICAgICAg
ID0gIjQzNzFCQTE3QTQxODIzMTAxRjkwNzYxIgogICAgIHRhaW50ICAgICAgICAgICAgICAgPSAi
IgogICAgIHVldmVudCAgICAgICAgICAgICAgPSA8c3RvcmUgbWV0aG9kIG9ubHk+CgogICBQYXJh
bWV0ZXJzOgogICAgIGF2aWMgICAgICAgICAgICAgICAgPSAiMCIKICAgICBkdW1wX2ludmFsaWRf
dm1jYiAgID0gIk4iCiAgICAgbmVzdGVkICAgICAgICAgICAgICA9ICIxIgogICAgIG5wdCAgICAg
ICAgICAgICAgICAgPSAiMSIKICAgICBucmlwcyAgICAgICAgICAgICAgID0gIjEiCiAgICAgcGF1
c2VfZmlsdGVyX2NvdW50X2dyb3c9ICIyIgogICAgIHBhdXNlX2ZpbHRlcl9jb3VudF9tYXg9ICI2
NTUzNSIKICAgICBwYXVzZV9maWx0ZXJfY291bnRfc2hyaW5rPSAiMCIKICAgICBwYXVzZV9maWx0
ZXJfY291bnQgID0gIjMwMDAiCiAgICAgcGF1c2VfZmlsdGVyX3RocmVzaCA9ICIxMjgiCiAgICAg
c2V2X2VzICAgICAgICAgICAgICA9ICIwIgogICAgIHNldiAgICAgICAgICAgICAgICAgPSAiMCIK
ICAgICB2Z2lmICAgICAgICAgICAgICAgID0gIjAiCiAgICAgdmxzICAgICAgICAgICAgICAgICA9
ICIwIgoKICAgU2VjdGlvbnM6CgoKJCBjb21wZ2VuIC1HICIvc3lzL2tlcm5lbC9pb21tdV9ncm91
cHMvKi9kZXZpY2VzLyoiCi9zeXMva2VybmVsL2lvbW11X2dyb3Vwcy85L2RldmljZXMvMDAwMDow
MDoxNC4yCi9zeXMva2VybmVsL2lvbW11X2dyb3Vwcy8wL2RldmljZXMvMDAwMDowMDowMC4wCi9z
eXMva2VybmVsL2lvbW11X2dyb3Vwcy8xMC9kZXZpY2VzLzAwMDA6MDA6MTQuMwovc3lzL2tlcm5l
bC9pb21tdV9ncm91cHMvMi9kZXZpY2VzLzAwMDA6MDA6MDQuMAovc3lzL2tlcm5lbC9pb21tdV9n
cm91cHMvMTIvZGV2aWNlcy8wMDAwOjAwOjE0LjUKL3N5cy9rZXJuZWwvaW9tbXVfZ3JvdXBzLzQv
ZGV2aWNlcy8wMDAwOjAwOjBkLjAKL3N5cy9rZXJuZWwvaW9tbXVfZ3JvdXBzLzE0L2RldmljZXMv
MDAwMDowMDoxNi4wCi9zeXMva2VybmVsL2lvbW11X2dyb3Vwcy8xNC9kZXZpY2VzLzAwMDA6MDA6
MTYuMgovc3lzL2tlcm5lbC9pb21tdV9ncm91cHMvNi9kZXZpY2VzLzAwMDA6MDA6MTIuMAovc3lz
L2tlcm5lbC9pb21tdV9ncm91cHMvNi9kZXZpY2VzLzAwMDA6MDA6MTIuMgovc3lzL2tlcm5lbC9p
b21tdV9ncm91cHMvMTYvZGV2aWNlcy8wMDAwOjAyOjAwLjAKL3N5cy9rZXJuZWwvaW9tbXVfZ3Jv
dXBzLzgvZGV2aWNlcy8wMDAwOjAwOjE0LjAKL3N5cy9rZXJuZWwvaW9tbXVfZ3JvdXBzLzEvZGV2
aWNlcy8wMDAwOjAwOjAyLjAKL3N5cy9rZXJuZWwvaW9tbXVfZ3JvdXBzLzExL2RldmljZXMvMDAw
MDowMDoxNC40Ci9zeXMva2VybmVsL2lvbW11X2dyb3Vwcy8zL2RldmljZXMvMDAwMDowMDowYi4w
Ci9zeXMva2VybmVsL2lvbW11X2dyb3Vwcy8xMy9kZXZpY2VzLzAwMDA6MDA6MTUuMwovc3lzL2tl
cm5lbC9pb21tdV9ncm91cHMvMTMvZGV2aWNlcy8wMDAwOjAwOjE1LjAKL3N5cy9rZXJuZWwvaW9t
bXVfZ3JvdXBzLzEzL2RldmljZXMvMDAwMDowNjowMC4wCi9zeXMva2VybmVsL2lvbW11X2dyb3Vw
cy8xMy9kZXZpY2VzLzAwMDA6MDA6MTUuMgovc3lzL2tlcm5lbC9pb21tdV9ncm91cHMvMTMvZGV2
aWNlcy8wMDAwOjA3OjAwLjAKL3N5cy9rZXJuZWwvaW9tbXVfZ3JvdXBzLzEzL2RldmljZXMvMDAw
MDowODowMC4wCi9zeXMva2VybmVsL2lvbW11X2dyb3Vwcy8xMy9kZXZpY2VzLzAwMDA6MDA6MTUu
MQovc3lzL2tlcm5lbC9pb21tdV9ncm91cHMvMTMvZGV2aWNlcy8wMDAwOjA5OjAwLjAKL3N5cy9r
ZXJuZWwvaW9tbXVfZ3JvdXBzLzUvZGV2aWNlcy8wMDAwOjAwOjExLjAKL3N5cy9rZXJuZWwvaW9t
bXVfZ3JvdXBzLzE1L2RldmljZXMvMDAwMDowMTowMC4xCi9zeXMva2VybmVsL2lvbW11X2dyb3Vw
cy8xNS9kZXZpY2VzLzAwMDA6MDE6MDAuMAovc3lzL2tlcm5lbC9pb21tdV9ncm91cHMvNy9kZXZp
Y2VzLzAwMDA6MDA6MTMuMAovc3lzL2tlcm5lbC9pb21tdV9ncm91cHMvNy9kZXZpY2VzLzAwMDA6
MDA6MTMuMgovc3lzL2tlcm5lbC9pb21tdV9ncm91cHMvMTcvZGV2aWNlcy8wMDAwOjA0OjAwLjAK
CgokIHN1ZG8ga3ZtLW9rCklORk86IC9kZXYva3ZtIGV4aXN0cwpLVk0gYWNjZWxlcmF0aW9uIGNh
biBiZSB1c2VkCgoKJCBwZXJmIGxpc3QgfCBncmVwIGlvbW11Ck5vIGFtZF9pb21tdSBldmVudHMK
CkJlc3QgcmVnYXJkcyBhbmQgbWFueSB0aGFua3MuCgotLSAKRGF2aWQgQ29lCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QK
aW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
