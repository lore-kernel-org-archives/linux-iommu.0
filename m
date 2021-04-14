Return-Path: <SRS0=7Zqx=JL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A5CC433B4
	for <iommu@archiver.kernel.org>; Wed, 14 Apr 2021 22:18:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B99DF61168
	for <iommu@archiver.kernel.org>; Wed, 14 Apr 2021 22:18:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B99DF61168
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=live.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 696B7824DC;
	Wed, 14 Apr 2021 22:18:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ceJnYm9cGVLG; Wed, 14 Apr 2021 22:18:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3163F83A5F;
	Wed, 14 Apr 2021 22:18:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E8132C000B;
	Wed, 14 Apr 2021 22:18:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 872A0C000A
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 22:18:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6BF8482662
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 22:18:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5qK2NoOd928J for <iommu@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 22:18:06 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04olkn0825.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0d::825])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E45EA824DC
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 22:18:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQO2hpZJVf65MAX7om644cBgr1vdykeunrSoXED/oyojwBbNoAlWtc3/rfsR7uLJNkVF06wgWi7gUL1X5gk1yPHqKVK30QiZq4yHjzj/FYF1D4r/wEYm1/aa2bN9l7MesGpBhVR5DXyPSIvJMXxkBepCFoC6Zn86lk+KwdWe0FgrHEAi9ptIsu5yLnAf21J3K96F9Ijef5/PnHvRZmn+qDzMIXjSFfKnck1Zs0KVRLZ55y4+iRHBvmZt/OraNRtVh+teFa2TvYg90ULEqSJKpVjH1jfZ1SWnZowlga2FrJJy6LYlttjWFyf6VTyaZkiKSfgWiUDkz5V7JspDV+MZlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhcT3dZLj/p9CJ6eN6hxOzdfsepQlnq9NnZXGCJM+k8=;
 b=QPviCX/hEkdLrvfZw+q7O2qhFGturPU0RwWMUN94JCG9gLOSDQJztSqGj0zHMNpe9vZAlJglnNr390xplfwwlttTaPzFVqOa3sSAO7i00heA80ZhGeHd1uhsTtAIku5P1rw8iH1QBHkvj3xSDQIQBO77cq67OVa1hHT0YDl8/YZtRxVDRPoTpoTi/ZtKwgnttYlUjsjC9M5uwh+mUisOxtiWGRStu1Hc+IQKkp5QpRJw5ZaRSxuSB2Ls8j8zCJRauokIrdKd6LCciSnp5h2mNub3LKCBwZxZSKqPTkr+D5SIMG1A48zqozZoGzCy2ItkS3i9jMytUa9/xB82NCaslQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DB3EUR04FT013.eop-eur04.prod.protection.outlook.com
 (2a01:111:e400:7e0c::40) by
 DB3EUR04HT026.eop-eur04.prod.protection.outlook.com (2a01:111:e400:7e0c::316)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Wed, 14 Apr
 2021 22:18:02 +0000
Received: from VI1PR09MB2638.eurprd09.prod.outlook.com
 (2a01:111:e400:7e0c::45) by DB3EUR04FT013.mail.protection.outlook.com
 (2a01:111:e400:7e0c::277) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Wed, 14 Apr 2021 22:18:02 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:B62BCDE701C88EAFDD72F781FADAA687E8AC69FE8825CE5760C3FF450B74CCCB;
 UpperCasedChecksum:B7D2F1CBD8BE753586966D38A4778280E15B5D6820BA3B59CEEE6541ABF1162A;
 SizeAsReceived:9180; Count:47
Received: from VI1PR09MB2638.eurprd09.prod.outlook.com
 ([fe80::948b:987c:566b:198e]) by VI1PR09MB2638.eurprd09.prod.outlook.com
 ([fe80::948b:987c:566b:198e%5]) with mapi id 15.20.4042.018; Wed, 14 Apr 2021
 22:18:02 +0000
Subject: Re: [PATCH 2/2] iommu/amd: Remove performance counter
 pre-initialization test
To: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
References: <20210409085848.3908-1-suravee.suthikulpanit@amd.com>
 <20210409085848.3908-3-suravee.suthikulpanit@amd.com>
 <VI1PR09MB26380EED406F2F08ACB6B5BBC7729@VI1PR09MB2638.eurprd09.prod.outlook.com>
 <add9d575-191e-d7a6-e3e1-dfc7ea7f35c8@amd.com>
From: David Coe <david.coe@live.co.uk>
Message-ID: <VI1PR09MB2638CE523F2E7E2DF4A6B087C74E9@VI1PR09MB2638.eurprd09.prod.outlook.com>
Date: Wed, 14 Apr 2021 23:18:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <add9d575-191e-d7a6-e3e1-dfc7ea7f35c8@amd.com>
Content-Type: multipart/mixed; boundary="------------D7C2E3FC4E03C0F3D4199D22"
Content-Language: en-GB
X-TMN: [5AQtz071NitM55wFWhJjJMULmurJP+6o]
X-ClientProxiedBy: LO4P123CA0297.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::14) To VI1PR09MB2638.eurprd09.prod.outlook.com
 (2603:10a6:803:7b::27)
X-Microsoft-Original-Message-ID: <cbd87524-cecb-1adc-b508-730546aee73e@live.co.uk>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.6] (90.246.218.100) by
 LO4P123CA0297.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:196::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.21 via Frontend Transport; Wed, 14 Apr 2021 22:18:01 +0000
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 47
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: da0c652e-4677-418b-ba96-08d8ff932b03
X-MS-TrafficTypeDiagnostic: DB3EUR04HT026:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rJJ3973SqnIFhKCq2nU5HjP+PQMAQxarTX7CIWGgLZkuQvdfRT3fNbyDv8P+Dcr/vECgXwBId+I8gj7d5sJU1IFbqTCB7gePx9htglsXdL/dRx3NbQKVI7RjFK8Rj4J+mGPwqmyuVGwqMVNrFqWwU9dpNZADN7TneNScPy3AJskoBH+r8cnK7pPoMvpjpdsq5myPBFag5ZYbrGTfXIH+4kyhGxcOQT2ois29vhTrOTGjUmCqM02dEIb8A/nFmqe4vJeFtH/3mWwYJ820bOdnhM0x8Y6VcxlrWKwgiO6dlNyhKi15Y3c10Ssp7nurz89Jn88Jb+DSg2uzZlzgsaPV3FqT9ppyUM58qZfZC8r85evGF2cGeSeko0B2k6Ve40UuAM59iLn8AHnSMF4z/oF0Sw==
X-MS-Exchange-AntiSpam-MessageData: sshzfl07htqrAh7QyPCDVk1ezfQXWkPTXYL182yEA1u+qZO8kNhaolSlmDPUwO7QIyXll93KQEWSI1WV2cz+fD41uMCd4ylwCiGNisyvAcjPTu9ITlat31XpJ2xPII7ihmZM0SZsLbyiJBMTLuEyeA==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da0c652e-4677-418b-ba96-08d8ff932b03
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2021 22:18:02.2653 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: DB3EUR04FT013.eop-eur04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3EUR04HT026
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
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--------------D7C2E3FC4E03C0F3D4199D22
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi again!

For completeness, I'm attaching results for the revert+update patch 
running the Ubuntu 21.04β kernel 5.11.0-14 on a Ryzen 4700U laptop.

The enormous amd_iommu running stats aren't always there, as they nearly 
always are on the the 2400G desktop, but they do turn up (depending on 
what the machine's been doing).

Be very interested in your thoughts on their relevance!

Best regards,

-- 
David

--------------D7C2E3FC4E03C0F3D4199D22
Content-Type: text/plain; charset=UTF-8;
 name="4700U-5.11.0-14.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="4700U-5.11.0-14.txt"

JCBzdWRvIGRtZXNnIHwgZ3JlcCBJT01NVQpbICAgIDAuNDk4NTkzXSBwY2kgMDAwMDowMDowMC4y
OiBBTUQtVmk6IElPTU1VIHBlcmZvcm1hbmNlIGNvdW50ZXJzIHN1cHBvcnRlZApbICAgIDAuNTAw
NTA3XSBwY2kgMDAwMDowMDowMC4yOiBBTUQtVmk6IEZvdW5kIElPTU1VIGNhcCAweDQwClsgICAg
MC41MDIwMTFdIHBlcmYvYW1kX2lvbW11OiBEZXRlY3RlZCBBTUQgSU9NTVUgIzAgKDIgYmFua3Ms
IDQgY291bnRlcnMvYmFuaykuClsgICAgMS4xMTMxOTVdIEFNRC1WaTogQU1EIElPTU1VdjIgZHJp
dmVyIGJ5IEpvZXJnIFJvZWRlbCA8anJvZWRlbEBzdXNlLmRlPgoKCiQgc3VkbyBwZXJmIGxpc3Qg
fCBncmVwIGlvbW11CiAgYW1kX2lvbW11XzAvY21kX3Byb2Nlc3NlZC8gICAgICAgICAgICAgICAg
ICAgICAgICAgW0tlcm5lbCBQTVUgZXZlbnRdCiAgYW1kX2lvbW11XzAvY21kX3Byb2Nlc3NlZF9p
bnYvICAgICAgICAgICAgICAgICAgICAgW0tlcm5lbCBQTVUgZXZlbnRdCiAgYW1kX2lvbW11XzAv
aWduX3JkX3dyX21taW9fMWZmOGgvICAgICAgICAgICAgICAgICAgW0tlcm5lbCBQTVUgZXZlbnRd
CiAgYW1kX2lvbW11XzAvaW50X2R0ZV9oaXQvICAgICAgICAgICAgICAgICAgICAgICAgICAgW0tl
cm5lbCBQTVUgZXZlbnRdCiAgYW1kX2lvbW11XzAvaW50X2R0ZV9taXMvICAgICAgICAgICAgICAg
ICAgICAgICAgICAgW0tlcm5lbCBQTVUgZXZlbnRdCiAgYW1kX2lvbW11XzAvbWVtX2R0ZV9oaXQv
ICAgICAgICAgICAgICAgICAgICAgICAgICAgW0tlcm5lbCBQTVUgZXZlbnRdCiAgYW1kX2lvbW11
XzAvbWVtX2R0ZV9taXMvICAgICAgICAgICAgICAgICAgICAgICAgICAgW0tlcm5lbCBQTVUgZXZl
bnRdCiAgYW1kX2lvbW11XzAvbWVtX2lvbW11X3RsYl9wZGVfaGl0LyAgICAgICAgICAgICAgICAg
W0tlcm5lbCBQTVUgZXZlbnRdCiAgYW1kX2lvbW11XzAvbWVtX2lvbW11X3RsYl9wZGVfbWlzLyAg
ICAgICAgICAgICAgICAgW0tlcm5lbCBQTVUgZXZlbnRdCiAgYW1kX2lvbW11XzAvbWVtX2lvbW11
X3RsYl9wdGVfaGl0LyAgICAgICAgICAgICAgICAgW0tlcm5lbCBQTVUgZXZlbnRdCiAgYW1kX2lv
bW11XzAvbWVtX2lvbW11X3RsYl9wdGVfbWlzLyAgICAgICAgICAgICAgICAgW0tlcm5lbCBQTVUg
ZXZlbnRdCiAgYW1kX2lvbW11XzAvbWVtX3Bhc3NfZXhjbC8gICAgICAgICAgICAgICAgICAgICAg
ICAgW0tlcm5lbCBQTVUgZXZlbnRdCiAgYW1kX2lvbW11XzAvbWVtX3Bhc3NfcHJldHJhbnMvICAg
ICAgICAgICAgICAgICAgICAgW0tlcm5lbCBQTVUgZXZlbnRdCiAgYW1kX2lvbW11XzAvbWVtX3Bh
c3NfdW50cmFucy8gICAgICAgICAgICAgICAgICAgICAgW0tlcm5lbCBQTVUgZXZlbnRdCiAgYW1k
X2lvbW11XzAvbWVtX3RhcmdldF9hYm9ydC8gICAgICAgICAgICAgICAgICAgICAgW0tlcm5lbCBQ
TVUgZXZlbnRdCiAgYW1kX2lvbW11XzAvbWVtX3RyYW5zX3RvdGFsLyAgICAgICAgICAgICAgICAg
ICAgICAgW0tlcm5lbCBQTVUgZXZlbnRdCiAgYW1kX2lvbW11XzAvcGFnZV90YmxfcmVhZF9nc3Qv
ICAgICAgICAgICAgICAgICAgICAgW0tlcm5lbCBQTVUgZXZlbnRdCiAgYW1kX2lvbW11XzAvcGFn
ZV90YmxfcmVhZF9uc3QvICAgICAgICAgICAgICAgICAgICAgW0tlcm5lbCBQTVUgZXZlbnRdCiAg
YW1kX2lvbW11XzAvcGFnZV90YmxfcmVhZF90b3QvICAgICAgICAgICAgICAgICAgICAgW0tlcm5l
bCBQTVUgZXZlbnRdCiAgYW1kX2lvbW11XzAvc21pX2Jsay8gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgW0tlcm5lbCBQTVUgZXZlbnRdCiAgYW1kX2lvbW11XzAvc21pX3JlY3YvICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgW0tlcm5lbCBQTVUgZXZlbnRdCiAgYW1kX2lvbW11XzAv
dGxiX2ludi8gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgW0tlcm5lbCBQTVUgZXZlbnRd
CiAgYW1kX2lvbW11XzAvdmFwaWNfaW50X2d1ZXN0LyAgICAgICAgICAgICAgICAgICAgICAgW0tl
cm5lbCBQTVUgZXZlbnRdCiAgYW1kX2lvbW11XzAvdmFwaWNfaW50X25vbl9ndWVzdC8gICAgICAg
ICAgICAgICAgICAgW0tlcm5lbCBQTVUgZXZlbnRdCiAgaW50ZWxfaW9tbXU6Ym91bmNlX21hcF9z
ZyAgICAgICAgICAgICAgICAgICAgICAgICAgW1RyYWNlcG9pbnQgZXZlbnRdCiAgaW50ZWxfaW9t
bXU6Ym91bmNlX21hcF9zaW5nbGUgICAgICAgICAgICAgICAgICAgICAgW1RyYWNlcG9pbnQgZXZl
bnRdCiAgaW50ZWxfaW9tbXU6Ym91bmNlX3VubWFwX3NpbmdsZSAgICAgICAgICAgICAgICAgICAg
W1RyYWNlcG9pbnQgZXZlbnRdCiAgaW50ZWxfaW9tbXU6bWFwX3NnICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgW1RyYWNlcG9pbnQgZXZlbnRdCiAgaW50ZWxfaW9tbXU6bWFwX3Npbmds
ZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgW1RyYWNlcG9pbnQgZXZlbnRdCiAgaW50ZWxf
aW9tbXU6dW5tYXBfc2cgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgW1RyYWNlcG9pbnQg
ZXZlbnRdCiAgaW50ZWxfaW9tbXU6dW5tYXBfc2luZ2xlICAgICAgICAgICAgICAgICAgICAgICAg
ICAgW1RyYWNlcG9pbnQgZXZlbnRdCiAgaW9tbXU6YWRkX2RldmljZV90b19ncm91cCAgICAgICAg
ICAgICAgICAgICAgICAgICAgW1RyYWNlcG9pbnQgZXZlbnRdCiAgaW9tbXU6YXR0YWNoX2Rldmlj
ZV90b19kb21haW4gICAgICAgICAgICAgICAgICAgICAgW1RyYWNlcG9pbnQgZXZlbnRdCiAgaW9t
bXU6ZGV0YWNoX2RldmljZV9mcm9tX2RvbWFpbiAgICAgICAgICAgICAgICAgICAgW1RyYWNlcG9p
bnQgZXZlbnRdCiAgaW9tbXU6aW9fcGFnZV9mYXVsdCAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgW1RyYWNlcG9pbnQgZXZlbnRdCiAgaW9tbXU6bWFwICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgW1RyYWNlcG9pbnQgZXZlbnRdCiAgaW9tbXU6cmVtb3ZlX2Rl
dmljZV9mcm9tX2dyb3VwICAgICAgICAgICAgICAgICAgICAgW1RyYWNlcG9pbnQgZXZlbnRdCiAg
aW9tbXU6dW5tYXAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgW1RyYWNl
cG9pbnQgZXZlbnRdCgokIHN1ZG8gcGVyZiBzdGF0IC1lICdhbWRfaW9tbXVfMC9jbWRfcHJvY2Vz
c2VkLywgYW1kX2lvbW11XzAvY21kX3Byb2Nlc3NlZF9pbnYvLCBhbWRfaW9tbXVfMC9pZ25fcmRf
d3JfbW1pb18xZmY4aC8sIGFtZF9pb21tdV8wL2ludF9kdGVfaGl0LywgYW1kX2lvbW11XzAvaW50
X2R0ZV9taXMvLCBhbWRfaW9tbXVfMC9tZW1fZHRlX2hpdC8sIGFtZF9pb21tdV8wL21lbV9kdGVf
bWlzLywgYW1kX2lvbW11XzAvbWVtX2lvbW11X3RsYl9wZGVfaGl0LywgYW1kX2lvbW11XzAvbWVt
X2lvbW11X3RsYl9wZGVfbWlzLywgYW1kX2lvbW11XzAvbWVtX2lvbW11X3RsYl9wdGVfaGl0Lywg
YW1kX2lvbW11XzAvbWVtX2lvbW11X3RsYl9wdGVfbWlzLywgYW1kX2lvbW11XzAvbWVtX3Bhc3Nf
ZXhjbC8sIGFtZF9pb21tdV8wL21lbV9wYXNzX3ByZXRyYW5zLywgYW1kX2lvbW11XzAvbWVtX3Bh
c3NfdW50cmFucy8sIGFtZF9pb21tdV8wL21lbV90YXJnZXRfYWJvcnQvLCBhbWRfaW9tbXVfMC9t
ZW1fdHJhbnNfdG90YWwvLCBhbWRfaW9tbXVfMC9wYWdlX3RibF9yZWFkX2dzdC8sIGFtZF9pb21t
dV8wL3BhZ2VfdGJsX3JlYWRfbnN0LywgYW1kX2lvbW11XzAvcGFnZV90YmxfcmVhZF90b3QvLCBh
bWRfaW9tbXVfMC9zbWlfYmxrLywgYW1kX2lvbW11XzAvc21pX3JlY3YvLCBhbWRfaW9tbXVfMC90
bGJfaW52LywgYW1kX2lvbW11XzAvdmFwaWNfaW50X2d1ZXN0LywgYW1kX2lvbW11XzAvdmFwaWNf
aW50X25vbl9ndWVzdC8nIHNsZWVwIDEwCgpQZXJmb3JtYW5jZSBjb3VudGVyIHN0YXRzIGZvciAn
c3lzdGVtIHdpZGUnOgoKICAgICAgICAgICAgICAgIDMwICAgICAgYW1kX2lvbW11XzAvY21kX3By
b2Nlc3NlZC8gICAgICAgICAgICAgKDMzLjMxJSkKICAgICAgICAgICAgICAgIDE3ICAgICAgIGFt
ZF9pb21tdV8wL2NtZF9wcm9jZXNzZWRfaW52LyAgICAgICAgKDMzLjM0JSkKICAgICAgICAgICAg
ICAgICAwICAgICAgIGFtZF9pb21tdV8wL2lnbl9yZF93cl9tbWlvXzFmZjhoLyAgICAgKDMzLjM2
JSkKICAgICAgICAgICAgICAgMzc0ICAgICAgIGFtZF9pb21tdV8wL2ludF9kdGVfaGl0LyAgICAg
ICAgICAgICAgKDMzLjM5JSkKICAgICAgICAgICAgICAgIDI5ICAgICAgIGFtZF9pb21tdV8wL2lu
dF9kdGVfbWlzLyAgICAgICAgICAgICAgKDMzLjQ0JSkKICAgICAgICAgICAgICAgMzk0ICAgICAg
IGFtZF9pb21tdV8wL21lbV9kdGVfaGl0LyAgICAgICAgICAgICAgKDMzLjQ2JSkKICAgICAgICAg
ICAgIDksMTE3ICAgICAgIGFtZF9pb21tdV8wL21lbV9kdGVfbWlzLyAgICAgICAgICAgICAgKDMz
LjQ1JSkKICAgICAgICAgICAgICAgICA1ICAgICAgIGFtZF9pb21tdV8wL21lbV9pb21tdV90bGJf
cGRlX2hpdC8gICAgKDMzLjQ2JSkKICAgICAgICAgICAgICAgODE5ICAgICAgIGFtZF9pb21tdV8w
L21lbV9pb21tdV90bGJfcGRlX21pcy8gICAgKDMzLjQyJSkKICAgICAgICAgICAgICAgICAyICAg
ICAgIGFtZF9pb21tdV8wL21lbV9pb21tdV90bGJfcHRlX2hpdC8gICAgKDMzLjM5JSkKICAgICAg
ICAgICAgIDEsMDEyICAgICAgIGFtZF9pb21tdV8wL21lbV9pb21tdV90bGJfcHRlX21pcy8gICAg
KDMzLjM3JSkKICAgICAgICAgICAgICAgICAwICAgICAgIGFtZF9pb21tdV8wL21lbV9wYXNzX2V4
Y2wvICAgICAgICAgICAgKDMzLjM0JSkKICAgICAgICAgICAgICAgICAwICAgICAgIGFtZF9pb21t
dV8wL21lbV9wYXNzX3ByZXRyYW5zLyAgICAgICAgKDMzLjI5JSkKICAgICAgICAgICAgIDEsNTUz
ICAgICAgIGFtZF9pb21tdV8wL21lbV9wYXNzX3VudHJhbnMvICAgICAgICAgKDMzLjI4JSkKICAg
ICAgICAgICAgICAgICAwICAgICAgIGFtZF9pb21tdV8wL21lbV90YXJnZXRfYWJvcnQvICAgICAg
ICAgKDMzLjI4JSkKICAgICAgICAgICAgMzksMjA3ICAgICAgIGFtZF9pb21tdV8wL21lbV90cmFu
c190b3RhbC8gICAgICAgICAgKDMzLjI3JSkKICAgICAgICAgICAgICAgICAwICAgICAgIGFtZF9p
b21tdV8wL3BhZ2VfdGJsX3JlYWRfZ3N0LyAgICAgICAgKDMzLjI3JSkKICAgICAgICAgICAgIDEs
NjI1ICAgICAgIGFtZF9pb21tdV8wL3BhZ2VfdGJsX3JlYWRfbnN0LyAgICAgICAgKDMzLjI3JSkK
ICAgICAgICAgICAgICAgOTAxICAgICAgIGFtZF9pb21tdV8wL3BhZ2VfdGJsX3JlYWRfdG90LyAg
ICAgICAgKDMzLjI3JSkKICAgICAgICAgICAgICAgICAwICAgICAgIGFtZF9pb21tdV8wL3NtaV9i
bGsvICAgICAgICAgICAgICAgICAgKDMzLjclKQogICAgICAgICAgICAgICAgIDAgICAgICAgYW1k
X2lvbW11XzAvc21pX3JlY3YvICAgICAgICAgICAgICAgICAoMzMuMjglKQogICAgICAgICAgICAg
ICAgIDAgICAgICAgYW1kX2lvbW11XzAvdGxiX2ludi8gICAgICAgICAgICAgICAgICAoMzMuMjcl
KQogICAgICAgICAgICAgICAgIDAgICAgICAgYW1kX2lvbW11XzAvdmFwaWNfaW50X2d1ZXN0LyAg
ICAgICAgICAoMzMuMjclKQogICAgICAgICAgICAgICA0MjAgICAgICAgYW1kX2lvbW11XzAvdmFw
aWNfaW50X25vbl9ndWVzdC8gICAgICAoMzMuMjclKQoKICAgICAgMTAuMDAzMDA0MDk2IHNlY29u
ZHMgdGltZSBlbGFwc2VkCgoK

--------------D7C2E3FC4E03C0F3D4199D22
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--------------D7C2E3FC4E03C0F3D4199D22--
