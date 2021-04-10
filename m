Return-Path: <SRS0=3YoF=JH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB98C433B4
	for <iommu@archiver.kernel.org>; Sat, 10 Apr 2021 10:03:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA405610C8
	for <iommu@archiver.kernel.org>; Sat, 10 Apr 2021 10:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA405610C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=live.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7ECD540207;
	Sat, 10 Apr 2021 10:03:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RUJC0RsUjZz8; Sat, 10 Apr 2021 10:03:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1BBB34016C;
	Sat, 10 Apr 2021 10:03:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D170AC000B;
	Sat, 10 Apr 2021 10:03:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2D76FC000A
 for <iommu@lists.linux-foundation.org>; Sat, 10 Apr 2021 10:03:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0B6D440567
 for <iommu@lists.linux-foundation.org>; Sat, 10 Apr 2021 10:03:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VJ3lBQ_OP35E for <iommu@lists.linux-foundation.org>;
 Sat, 10 Apr 2021 10:03:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05olkn2080d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::80d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 67C37404F1
 for <iommu@lists.linux-foundation.org>; Sat, 10 Apr 2021 10:03:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krOqFH/xLnHSsmyx1t0WyE0mtJONezqvyTeWW8sq8tQ4IhSZSIiH+9TuKdFt6EZJhe8NjPFwHGZ0Rn94nMekAlg+vu3/Fq4H42eEcm1jV9tTlIvnmf5ZxU++d649iiIcWxQzeK66SgzvSvIsehRRiAJ6gRs4T87idB/TBZdImneiONLAqlzXnvGtES4cuE8YbXUeIcijELIBoI9tifSmlnEcFiuNNVA7OE2AtOuO5yI3DvoTjrK/BPblUmsNIApIeIaQI0FDyvGBcH2ZZoGilhUedP8gUtFnTyQoifwjuEPhLlkPUor+BwJvFLQzxvzg+Pgqpm/yqUUT/PI0F8MATw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDnUlChrho7yHV6JOw6lUCa3PY0pPe4BnBGolyQi8eQ=;
 b=f/dfoN//+b3/lL7+hsSOMGDQUEAy21iaCTbnQEUdMaME37MdH6Vwfdw5mtHXOv8ZcdoIZ/06GjZ9++A/JW/N4Gyh4BOII6BFBn+zT8YKbRRUoLrToksePUweghWXwIpbAU+xjm9r06vkWSnJ2PgDJ/AIbNSjWIda6cipxbPWKcT6pnenjFkgiQIOYMQ3x6iU0fPpF4kxOXv4aXAhiYhlf7CWGtztR72Ylo7kyg+mO98IyrQPVLkSfn5rcb+25vjt6LScxoUmVh3N0pi/0DZtqdHBTisFoC0rQTdOD5kGnaEIGk4RbOXvjJuzvJAQA+JVCseLM9m64t8tuSzlfI1i9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DB8EUR05FT008.eop-eur05.prod.protection.outlook.com
 (2a01:111:e400:fc0f::49) by
 DB8EUR05HT198.eop-eur05.prod.protection.outlook.com (2a01:111:e400:fc0f::92)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Sat, 10 Apr
 2021 10:03:15 +0000
Received: from VI1PR09MB2638.eurprd09.prod.outlook.com
 (2a01:111:e400:fc0f::41) by DB8EUR05FT008.mail.protection.outlook.com
 (2a01:111:e400:fc0f::145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend
 Transport; Sat, 10 Apr 2021 10:03:15 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:3D429122883A1A381F31F9DB8541E933EA070DAD7ABC5A1B76A0C76EED30ED83;
 UpperCasedChecksum:257E4EEBA0E5BA1E131C11DAD20DA03B7130794192F44CB78960041E76B131FA;
 SizeAsReceived:9052; Count:48
Received: from VI1PR09MB2638.eurprd09.prod.outlook.com
 ([fe80::948b:987c:566b:198e]) by VI1PR09MB2638.eurprd09.prod.outlook.com
 ([fe80::948b:987c:566b:198e%5]) with mapi id 15.20.4020.021; Sat, 10 Apr 2021
 10:03:15 +0000
Subject: Re: [PATCH 2/2] iommu/amd: Remove performance counter
 pre-initialization test
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
References: <20210409085848.3908-1-suravee.suthikulpanit@amd.com>
 <20210409085848.3908-3-suravee.suthikulpanit@amd.com>
From: David Coe <david.coe@live.co.uk>
Message-ID: <VI1PR09MB26380EED406F2F08ACB6B5BBC7729@VI1PR09MB2638.eurprd09.prod.outlook.com>
Date: Sat, 10 Apr 2021 11:03:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210409085848.3908-3-suravee.suthikulpanit@amd.com>
Content-Language: en-GB
X-TMN: [66HEW8I0e7s6Qu0OI8NDwvgvK/W7qqng]
X-ClientProxiedBy: LO3P265CA0001.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::6) To VI1PR09MB2638.eurprd09.prod.outlook.com
 (2603:10a6:803:7b::27)
X-Microsoft-Original-Message-ID: <1789d605-bbf4-9963-d97a-653ee8ba2b9f@live.co.uk>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.6] (90.246.218.100) by
 LO3P265CA0001.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:bb::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.21 via Frontend Transport; Sat, 10 Apr 2021 10:03:14 +0000
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 48
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: c4ba8055-1e59-4426-1116-08d8fc07db69
X-MS-TrafficTypeDiagnostic: DB8EUR05HT198:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8sOo7KviSg5bQB7l+b/aYBOQbnCQFg+IdGewtlJIB4qw/NHM9hFFDS4hliZsfe6+grxa0CNtMfUUJBuxr8/Myudeb4OXpdPdRvlzZ8Mj3mRpwar0+l21qzs5lW75WP27ZbgDGbXNXOR3XWgEk6t/qBfDAyG9gi62JkCp415AlkxlmBg/xTj1tisiai1uLVPEBIvbA7lwRXoDDTUBd+X6jqZmHms5WPpsh9sC07SyNwqpcG6QnMhzw49RuJLeCWi6X/lFmsDuvOvzQs7+McCFuHpRygnpXDo/SMcl71AdNH9e5mc8LhleXaIKFSc7+YNWsfXCU8FenyYphoAm42+XckMe4/gQW6923fe2B4uDJCr2U6+jVfwEhx1RX7SFXGYc
X-MS-Exchange-AntiSpam-MessageData: EjtzUb0JhDqu5AXhYh9ZCV4mj1EdKApyba7cH3/rcbrQ1G8Vlo4pYgpnRbC9ehD9JZXhFs8zNgaZYgHwIAQVJO45uCSBOeTt1Zb1sE2rLJGISAas9ZH2V1PfG3NYSf1+HNoZfh+vlmOeM8Nc/KJvzA==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ba8055-1e59-4426-1116-08d8fc07db69
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2021 10:03:15.1050 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: DB8EUR05FT008.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8EUR05HT198
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

UmVzdWx0cyBmb3IgQU1EIFJ5emVuIDQ3MDBVIHJ1bm5pbmcgVWJ1bnR1IDIxLjA0zrIga2VybmVs
IDUuMTEuMC0xMwoKJCBzdWRvIGRtZXNnIHwgZ3JlcCBJT01NVQpbICAgIDAuNDkwMzUyXSBwY2kg
MDAwMDowMDowMC4yOiBBTUQtVmk6IElPTU1VIHBlcmZvcm1hbmNlIGNvdW50ZXJzIApzdXBwb3J0
ZWQKWyAgICAwLjQ5MTk4NV0gcGNpIDAwMDA6MDA6MDAuMjogQU1ELVZpOiBGb3VuZCBJT01NVSBj
YXAgMHg0MApbICAgIDAuNDkzNzMyXSBwZXJmL2FtZF9pb21tdTogRGV0ZWN0ZWQgQU1EIElPTU1V
ICMwICgyIGJhbmtzLCA0IApjb3VudGVycy9iYW5rKS4KWyAgICAwLjc5MzI1OV0gQU1ELVZpOiBB
TUQgSU9NTVV2MiBkcml2ZXIgYnkgSm9lcmcgUm9lZGVsIDxqcm9lZGVsQHN1c2UuZGU+CgokIHN5
c3Rvb2wgLW0ga3ZtX2FtZCAtdgpNb2R1bGUgPSAia3ZtX2FtZCIKCiAgIEF0dHJpYnV0ZXM6CiAg
ICAgY29yZXNpemUgICAgICAgICAgICA9ICIxMTQ2ODgiCiAgICAgaW5pdHNpemUgICAgICAgICAg
ICA9ICIwIgogICAgIGluaXRzdGF0ZSAgICAgICAgICAgPSAibGl2ZSIKICAgICByZWZjbnQgICAg
ICAgICAgICAgID0gIjAiCiAgICAgc3JjdmVyc2lvbiAgICAgICAgICA9ICI0MzcxQkExN0E0MTgy
MzEwMUY5MDc2MSIKICAgICB0YWludCAgICAgICAgICAgICAgID0gIiIKICAgICB1ZXZlbnQgICAg
ICAgICAgICAgID0gPHN0b3JlIG1ldGhvZCBvbmx5PgoKICAgUGFyYW1ldGVyczoKICAgICBhdmlj
ICAgICAgICAgICAgICAgID0gIjAiCiAgICAgZHVtcF9pbnZhbGlkX3ZtY2IgICA9ICJOIgogICAg
IG5lc3RlZCAgICAgICAgICAgICAgPSAiMSIKICAgICBucHQgICAgICAgICAgICAgICAgID0gIjEi
CiAgICAgbnJpcHMgICAgICAgICAgICAgICA9ICIxIgogICAgIHBhdXNlX2ZpbHRlcl9jb3VudF9n
cm93PSAiMiIKICAgICBwYXVzZV9maWx0ZXJfY291bnRfbWF4PSAiNjU1MzUiCiAgICAgcGF1c2Vf
ZmlsdGVyX2NvdW50X3Nocmluaz0gIjAiCiAgICAgcGF1c2VfZmlsdGVyX2NvdW50ICA9ICIzMDAw
IgogICAgIHBhdXNlX2ZpbHRlcl90aHJlc2ggPSAiMTI4IgogICAgIHNldl9lcyAgICAgICAgICAg
ICAgPSAiMCIKICAgICBzZXYgICAgICAgICAgICAgICAgID0gIjAiCiAgICAgdmdpZiAgICAgICAg
ICAgICAgICA9ICIxIgogICAgIHZscyAgICAgICAgICAgICAgICAgPSAiMSIKCiAgIFNlY3Rpb25z
OgoKJCBjb21wZ2VuIC1HICIvc3lzL2tlcm5lbC9pb21tdV9ncm91cHMvKi9kZXZpY2VzLyoiCi9z
eXMva2VybmVsL2lvbW11X2dyb3Vwcy8wL2RldmljZXMvMDAwMDowMDowMS4wCi9zeXMva2VybmVs
L2lvbW11X2dyb3Vwcy8yL2RldmljZXMvMDAwMDowMDowMi4yCi9zeXMva2VybmVsL2lvbW11X2dy
b3Vwcy80L2RldmljZXMvMDAwMDowMDowOC4yCi9zeXMva2VybmVsL2lvbW11X2dyb3Vwcy80L2Rl
dmljZXMvMDAwMDowMzowMC4yCi9zeXMva2VybmVsL2lvbW11X2dyb3Vwcy80L2RldmljZXMvMDAw
MDowNDowMC4wCi9zeXMva2VybmVsL2lvbW11X2dyb3Vwcy80L2RldmljZXMvMDAwMDowMzowMC40
Ci9zeXMva2VybmVsL2lvbW11X2dyb3Vwcy80L2RldmljZXMvMDAwMDowMzowMC42Ci9zeXMva2Vy
bmVsL2lvbW11X2dyb3Vwcy80L2RldmljZXMvMDAwMDowMDowOC4xCi9zeXMva2VybmVsL2lvbW11
X2dyb3Vwcy80L2RldmljZXMvMDAwMDowMzowMC4xCi9zeXMva2VybmVsL2lvbW11X2dyb3Vwcy80
L2RldmljZXMvMDAwMDowMzowMC4zCi9zeXMva2VybmVsL2lvbW11X2dyb3Vwcy80L2RldmljZXMv
MDAwMDowNDowMC4xCi9zeXMva2VybmVsL2lvbW11X2dyb3Vwcy80L2RldmljZXMvMDAwMDowMzow
MC41Ci9zeXMva2VybmVsL2lvbW11X2dyb3Vwcy80L2RldmljZXMvMDAwMDowMDowOC4wCi9zeXMv
a2VybmVsL2lvbW11X2dyb3Vwcy80L2RldmljZXMvMDAwMDowMzowMC4wCi9zeXMva2VybmVsL2lv
bW11X2dyb3Vwcy82L2RldmljZXMvMDAwMDowMDoxOC41Ci9zeXMva2VybmVsL2lvbW11X2dyb3Vw
cy82L2RldmljZXMvMDAwMDowMDoxOC43Ci9zeXMva2VybmVsL2lvbW11X2dyb3Vwcy82L2Rldmlj
ZXMvMDAwMDowMDoxOC4wCi9zeXMva2VybmVsL2lvbW11X2dyb3Vwcy82L2RldmljZXMvMDAwMDow
MDoxOC4yCi9zeXMva2VybmVsL2lvbW11X2dyb3Vwcy82L2RldmljZXMvMDAwMDowMDoxOC40Ci9z
eXMva2VybmVsL2lvbW11X2dyb3Vwcy82L2RldmljZXMvMDAwMDowMDoxOC42Ci9zeXMva2VybmVs
L2lvbW11X2dyb3Vwcy82L2RldmljZXMvMDAwMDowMDoxOC4xCi9zeXMva2VybmVsL2lvbW11X2dy
b3Vwcy82L2RldmljZXMvMDAwMDowMDoxOC4zCi9zeXMva2VybmVsL2lvbW11X2dyb3Vwcy84L2Rl
dmljZXMvMDAwMDowMjowMC4wCi9zeXMva2VybmVsL2lvbW11X2dyb3Vwcy8xL2RldmljZXMvMDAw
MDowMDowMi4wCi9zeXMva2VybmVsL2lvbW11X2dyb3Vwcy8zL2RldmljZXMvMDAwMDowMDowMi40
Ci9zeXMva2VybmVsL2lvbW11X2dyb3Vwcy81L2RldmljZXMvMDAwMDowMDoxNC4wCi9zeXMva2Vy
bmVsL2lvbW11X2dyb3Vwcy81L2RldmljZXMvMDAwMDowMDoxNC4zCi9zeXMva2VybmVsL2lvbW11
X2dyb3Vwcy83L2RldmljZXMvMDAwMDowMTowMC4wCgokIHN1ZG8gcGVyZiBzdGF0IC1lICdhbWRf
aW9tbXVfMC9jbWRfcHJvY2Vzc2VkLywgCmFtZF9pb21tdV8wL2NtZF9wcm9jZXNzZWRfaW52Lywg
YW1kX2lvbW11XzAvaWduX3JkX3dyX21taW9fMWZmOGgvLCAKYW1kX2lvbW11XzAvaW50X2R0ZV9o
aXQvLCBhbWRfaW9tbXVfMC9pbnRfZHRlX21pcy8sIAphbWRfaW9tbXVfMC9tZW1fZHRlX2hpdC8s
IGFtZF9pb21tdV8wL21lbV9kdGVfbWlzLywgCmFtZF9pb21tdV8wL21lbV9pb21tdV90bGJfcGRl
X2hpdC8sIGFtZF9pb21tdV8wL21lbV9pb21tdV90bGJfcGRlX21pcy8sIAphbWRfaW9tbXVfMC9t
ZW1faW9tbXVfdGxiX3B0ZV9oaXQvLCBhbWRfaW9tbXVfMC9tZW1faW9tbXVfdGxiX3B0ZV9taXMv
LCAKYW1kX2lvbW11XzAvbWVtX3Bhc3NfZXhjbC8sIGFtZF9pb21tdV8wL21lbV9wYXNzX3ByZXRy
YW5zLywgCmFtZF9pb21tdV8wL21lbV9wYXNzX3VudHJhbnMvLCBhbWRfaW9tbXVfMC9tZW1fdGFy
Z2V0X2Fib3J0LywgCmFtZF9pb21tdV8wL21lbV90cmFuc190b3RhbC8sIGFtZF9pb21tdV8wL3Bh
Z2VfdGJsX3JlYWRfZ3N0LywgCmFtZF9pb21tdV8wL3BhZ2VfdGJsX3JlYWRfbnN0LywgYW1kX2lv
bW11XzAvcGFnZV90YmxfcmVhZF90b3QvLCAKYW1kX2lvbW11XzAvc21pX2Jsay8sIGFtZF9pb21t
dV8wL3NtaV9yZWN2LywgYW1kX2lvbW11XzAvdGxiX2ludi8sIAphbWRfaW9tbXVfMC92YXBpY19p
bnRfZ3Vlc3QvLCBhbWRfaW9tbXVfMC92YXBpY19pbnRfbm9uX2d1ZXN0Lycgc2xlZXAgMTAKClBl
cmZvcm1hbmNlIGNvdW50ZXIgc3RhdHMgZm9yICdzeXN0ZW0gd2lkZSc6CgogICAgICAgICAgICAg
ICAgIDEyICAgICAgYW1kX2lvbW11XzAvY21kX3Byb2Nlc3NlZC8gICAgICAgICAgICAgKDMzLjI4
JSkKICAgICAgICAgICAgICAgICAgNiAgICAgICBhbWRfaW9tbXVfMC9jbWRfcHJvY2Vzc2VkX2lu
di8gICAgICAgICgzMy4zMiUpCiAgICAgICAgICAgICAgICAgIDAgICAgICAgYW1kX2lvbW11XzAv
aWduX3JkX3dyX21taW9fMWZmOGgvICAgICAoMzMuMzYlKQogICAgICAgICAgICAgICAgMjkwICAg
ICAgIGFtZF9pb21tdV8wL2ludF9kdGVfaGl0LyAgICAgICAgICAgICAgKDMzLjQwJSkKICAgICAg
ICAgICAgICAgICAyMCAgICAgICBhbWRfaW9tbXVfMC9pbnRfZHRlX21pcy8gICAgICAgICAgICAg
ICgzMy40NiUpCiAgICAgICAgICAgICAgICAzOTEgICAgICAgYW1kX2lvbW11XzAvbWVtX2R0ZV9o
aXQvICAgICAgICAgICAgICAoMzMuNDklKQogICAgICAgICAgICAgIDMsNzIwICAgICAgIGFtZF9p
b21tdV8wL21lbV9kdGVfbWlzLyAgICAgICAgICAgICAgKDMzLjQ5JSkKICAgICAgICAgICAgICAg
ICA0NCAgICAgICBhbWRfaW9tbXVfMC9tZW1faW9tbXVfdGxiX3BkZV9oaXQvICAgICgzMy40NiUp
CiAgICAgICAgICAgICAgICA4MTAgICAgICAgYW1kX2lvbW11XzAvbWVtX2lvbW11X3RsYl9wZGVf
bWlzLyAgICAoMzMuNDUlKQogICAgICAgICAgICAgICAgIDM1ICAgICAgIGFtZF9pb21tdV8wL21l
bV9pb21tdV90bGJfcHRlX2hpdC8gICAgKDMzLjQxJSkKICAgICAgICAgICAgICAgIDc0NiAgICAg
ICBhbWRfaW9tbXVfMC9tZW1faW9tbXVfdGxiX3B0ZV9taXMvICAgICgzMy4zNyUpCiAgICAgICAg
ICAgICAgICAgIDAgICAgICAgYW1kX2lvbW11XzAvbWVtX3Bhc3NfZXhjbC8gICAgICAgICAgICAo
MzMuMzIlKQogICAgICAgICAgICAgICAgICAwICAgICAgIGFtZF9pb21tdV8wL21lbV9wYXNzX3By
ZXRyYW5zLyAgICAgICAgKDMzLjI4JSkKICAgICAgICAgICAgICAgICAgMCAgICAgICBhbWRfaW9t
bXVfMC9tZW1fcGFzc191bnRyYW5zLyAgICAgICAgICgzMy4yOCUpCiAgICAgICAgICAgICAgICAg
IDAgICAgICAgYW1kX2lvbW11XzAvbWVtX3RhcmdldF9hYm9ydC8gICAgICAgICAoMzMuMjclKQog
ICAgICAgICAgICAgICAgNzE1ICAgICAgIGFtZF9pb21tdV8wL21lbV90cmFuc190b3RhbC8gICAg
ICAgICAgKDMzLjI3JSkKICAgICAgICAgICAgICAgICAgMCAgICAgICBhbWRfaW9tbXVfMC9wYWdl
X3RibF9yZWFkX2dzdC8gICAgICAgICgzMy4yOCUpCiAgICAgICAgICAgICAgICAgMzYgICAgICAg
YW1kX2lvbW11XzAvcGFnZV90YmxfcmVhZF9uc3QvICAgICAgICAoMzMuMjclKQogICAgICAgICAg
ICAgICAgIDM2ICAgICAgIGFtZF9pb21tdV8wL3BhZ2VfdGJsX3JlYWRfdG90LyAgICAgICAgKDMz
LjI3JSkKICAgICAgICAgICAgICAgICAgMCAgICAgICBhbWRfaW9tbXVfMC9zbWlfYmxrLyAgICAg
ICAgICAgICAgICAgICgzMy4yOCUpCiAgICAgICAgICAgICAgICAgIDAgICAgICAgYW1kX2lvbW11
XzAvc21pX3JlY3YvICAgICAgICAgICAgICAgICAoMzMuMjYlKQogICAgICAgICAgICAgICAgICAw
ICAgICAgIGFtZF9pb21tdV8wL3RsYl9pbnYvICAgICAgICAgICAgICAgICAgKDMzLjIzJSkKICAg
ICAgICAgICAgICAgICAgMCAgICAgICBhbWRfaW9tbXVfMC92YXBpY19pbnRfZ3Vlc3QvICAgICAg
ICAgICgzMy4yNCUpCiAgICAgICAgICAgICAgICAzNjYgICAgICAgYW1kX2lvbW11XzAvdmFwaWNf
aW50X25vbl9ndWVzdC8gICAgICAoMzMuMjclKQoKVGhlIGltbWVkaWF0ZWx5IG9idmlvdXMgZGlm
ZmVyZW5jZSBpcyB0aGUgd2l0aCB0aGUgZW5vcm1vdXMgY291bnQgc2VlbiAKb24gbWVtX2R0ZV9t
aXMgb24gdGhlIG9sZGVyIFJ5emVuIDI0MDBHLiBXaWxsIGRvIHNvbWUgUlRGTSBidXQgYW55b25l
IAp3aXRoIGNvbW1lbnRzIGFuZCBpbnNpZ2h0PwoKODQxLDY4OSwxNTEsMjAyLDkzOSAgICAgICBh
bWRfaW9tbXVfMC9tZW1fZHRlX21pcy8gICAgICAgICAgICAgICgzMy40NCUpCgpPdGhlcndpc2Us
IGFsbCBzZWVtcyB0byBydW5uaW5nIHNtb290aGx5IChlc3BlY2lhbGx5IGZvciBhIGRpc3RyaWJ1
dGlvbiAKc3RpbGwgaW4gzrIpLiBCcmF2byBhbmQgbWFueSB0aGFua3MgYWxsIQoKLS0gCkRhdmlk
IENvZQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21t
dSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
