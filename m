Return-Path: <SRS0=SOau=JM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E369C433ED
	for <iommu@archiver.kernel.org>; Thu, 15 Apr 2021 09:28:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B08B561222
	for <iommu@archiver.kernel.org>; Thu, 15 Apr 2021 09:28:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B08B561222
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6A8E660884;
	Thu, 15 Apr 2021 09:28:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7_p0erS9ClK6; Thu, 15 Apr 2021 09:28:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 50CE060657;
	Thu, 15 Apr 2021 09:28:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 09D10C000B;
	Thu, 15 Apr 2021 09:28:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E3F8C000A
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 09:28:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2749240ED5
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 09:28:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xE5nVPeqD29v for <iommu@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 09:28:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::618])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2EB1540ED0
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 09:28:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5jPGFO7BkyP666kjDoX/jJ59leIolLYzVpM+Mvw6jqeFV5CVQ6tOlEvc37f2B3mr0i/iLL3lKODaqQoz+FTEeFQGfm5rBrQatvMRdjkEbEYZ7JzgtNDSwy00OdrSlNsNT2ewxbWiKn1qYYT+mDkXPDioiHF7cnLX0a552RjyQqgVrRnieMgN8McDgKJP2YefnqviTQfm/ypX0OWHSONkrRAH2fhA5yjaZBkdR/UORLhYi4UeVIvawMY6VMd0Hx/38oGft6R1yMVz0lWCAXTlZSZ+7dtx0duvLjq69g1N+iM4JYjhWrsT6IkTSShIS2J1UVtb7pCEeT6ZWKtiUIoFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+VdX6R5INdoMDTv62BL+kDWYPE8wnuEv2FF0PfCCe1k=;
 b=YTz2cpPCZwRViKgmHjVX99JWewJpZ5iS4HyU1wIaDAj0v4HqL/TF3OcSyia5nsaaRsfM5y7mKFxcBuY28a0xjC/K3HABetyf1VUkDDhUE5ltss7YnNvyUZ30hdashdPnpbTXI3DHTgqR21iHIyqMfakmbfXw8RblXTM/rusAGxZORQ6L7TJJH3HQTSo2ARDLTJE1SkqFeBmKXPaeGgtkdz22tAfALwxyCywIfDkmH7bHUrIvfttDZZGhCS7PeUPSeeUdlPSCmB+jfB9OQU11QZ3k/S9x1UmWjj05yEBFod8YVWl0q7a3lNFNARP3CPeWqqUJsgfzGw8EIbqCbOC0AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+VdX6R5INdoMDTv62BL+kDWYPE8wnuEv2FF0PfCCe1k=;
 b=AHLkddk/QG77bKkDqu2izDuuoOVraajW0QSnbpMtkoiltT3V9Te2b5OGdqasn5o8iKBuQUXTnxmlewoVzh9P2h6hORBhKzcU+V4UHe3Fb8usvujJfK5CiC/BY/o9DUYFXANFdghPS/dFhAxrSNB6S1NiyyqhlOuBYu4+WSnbVMA=
Authentication-Results: bugs.launchpad.net; dkim=none (message not signed)
 header.d=none; bugs.launchpad.net; dmarc=none action=none header.from=amd.com; 
Received: from BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 by BYAPR12MB3127.namprd12.prod.outlook.com (2603:10b6:a03:d8::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Thu, 15 Apr
 2021 09:28:27 +0000
Received: from BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::cc86:d78a:bb1d:5109]) by BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::cc86:d78a:bb1d:5109%5]) with mapi id 15.20.4042.018; Thu, 15 Apr 2021
 09:28:27 +0000
Subject: Re: [PATCH 2/2] iommu/amd: Remove performance counter
 pre-initialization test
To: David Coe <david.coe@live.co.uk>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org
References: <20210409085848.3908-1-suravee.suthikulpanit@amd.com>
 <20210409085848.3908-3-suravee.suthikulpanit@amd.com>
 <VI1PR09MB26380EED406F2F08ACB6B5BBC7729@VI1PR09MB2638.eurprd09.prod.outlook.com>
 <add9d575-191e-d7a6-e3e1-dfc7ea7f35c8@amd.com>
 <VI1PR09MB2638289727E1854B5CE7A3AAC74E9@VI1PR09MB2638.eurprd09.prod.outlook.com>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Message-ID: <df6c8363-baac-5d97-5b06-4bcd3163f83d@amd.com>
Date: Thu, 15 Apr 2021 16:28:16 +0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
In-Reply-To: <VI1PR09MB2638289727E1854B5CE7A3AAC74E9@VI1PR09MB2638.eurprd09.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [165.204.80.7]
X-ClientProxiedBy: KL1PR0302CA0019.apcprd03.prod.outlook.com
 (2603:1096:802::29) To BYAPR12MB4597.namprd12.prod.outlook.com
 (2603:10b6:a03:10b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.73.101] (165.204.80.7) by
 KL1PR0302CA0019.apcprd03.prod.outlook.com (2603:1096:802::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.6 via Frontend Transport; Thu, 15 Apr 2021 09:28:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad363763-dc14-45e0-34b5-08d8fff0d2fe
X-MS-TrafficTypeDiagnostic: BYAPR12MB3127:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB312781E4EE222BA100C47C12F34D9@BYAPR12MB3127.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6ev0vHDstD17iTGL0tVACRu/IBK5US5kn1kL+NEl6afg26XtgI3QUwi7po1tcev21emB9wZRlNnfIUkGZsEFR3lMRYNKczfIPVzkXktwDgxDwkldRyX69Cr8yGBNp1sWV1zD+Q/2kM24/yoFWbC9imoiJWO+pjeIM4p7qGU8jMe2g80aXbGT3GU0ee1bw3WacC/QX5+eBeFhcPSi3HSCaUKjV/FQoKIyvpEhXzPlgH4wlwms2HGpanOMX9mu+Qg4i0fEdWq/a6w4JwXjbd3jqzoXlWRZjFCMVdCmdr5dVagOqD+4J5s0iOUGOZQhg0K1VHqeRgEathdyaKLAqwSAguUJ0git7R8swcRk4wW6LI2HTpwPLPz8XMziQtkWla4NzbpvQ7/jyuajf5Jt6an5I/spFp8WXoMSkxYospdSgMU8C4Ywk51v1Vpky6DyN8lGr5H0RRkDQYJjsEAo9Iiseo9O73bJEEZZV0Vnayiy4SEaLA+ls2FLsiEDsXlcJjfbLXsZlwMwXiBU1Ds9I2clrfI3P29jhfMvdv+GA7bKlKdOaSwr3ZRFoKgvHhghXtEcjblHOAoZXALdsNynxpHWL3RLP2dnP8hclozdPVIJCZVwBbbmt6KVT0tSwXquZkgLgIEdKDeNQc8CLLJ62MQ7DagQhDRhaM9ryDBxmvmAcaqGRP6qZNVgwsohsqRXT96NEXKouhEvRgrWIs8R8/QaqxTlbkgPYIyl4jgwxSANg86e4O5dzKDcSPGXYI92PRlZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4597.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(7416002)(8676002)(54906003)(86362001)(186003)(4326008)(53546011)(478600001)(316002)(16576012)(83380400001)(6666004)(2616005)(2906002)(36756003)(6486002)(956004)(8936002)(66556008)(38100700002)(16526019)(31696002)(5660300002)(52116002)(38350700002)(31686004)(66946007)(66476007)(26005)(34580700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TXcybkZQRjVib3JMbzF6VnlFUnBDUnhJQ3VxUnRiWDhuamgyT01tZjBjZ1dv?=
 =?utf-8?B?aFhnbUV5ZytRalBVWHY5dlZXZ1lOdU04d1h1am8rRllxSXdNc0RTNzBCZTdH?=
 =?utf-8?B?RXh2TjB0UTUrU1A2SDAxMWcxeEpVQVRZWE1vbHBRVlU2amdRNTUzbGYzUXJK?=
 =?utf-8?B?MTBOckFWdGtZeVd4ek1WNzB5MkMwSzlMbXhiTEZnSk9oYi9ybysrc010bFl3?=
 =?utf-8?B?eGVqQTF2SWhSeWFjeXlaMGozVUo0ZTZWS3ZHa0J2alY0Tk56MGQ3cnRPeVho?=
 =?utf-8?B?TGJuOS9BbFZzSS8wQmhacXYrZ2VURDVrSU1FdXZhYTBxTjEvS3ZoQTZzSVFu?=
 =?utf-8?B?eXA1ZldJbm5iTEUydCtuTlVpSi8wSEJjajNhbndUeUpFck53ZHF0SGljM25l?=
 =?utf-8?B?WWFvNVVndXl0QTNuOVdneW5XM2IzNzBUUXlSUDFWbS9mam5xMGJJRGY0Titj?=
 =?utf-8?B?M2o1Vk5ldFdScGZJWjY3MGx4NUdUYmZxRWRYaXZhdmZVUHNCQm02WndTUk5z?=
 =?utf-8?B?ZTR4SmpKYW00eWpqWmxRZmo4ZXdTdDRrSUV2c0FDUHpPdWVuSGU2R080K2x5?=
 =?utf-8?B?cStVcXRHNDNiamNKWHpsN1hacVlLRlIvaFFJUjdJWjJQZDhDV1NSMW1OUnhE?=
 =?utf-8?B?cGg2c1NvUmVOai9KeDJGaVJyc3V0aFJvczd0WElKTllJU1o2d01kUnp0cWQw?=
 =?utf-8?B?YVcxZTdKSElzeUozaWdKSWtldDd6UXY2czdrNGJkSVRCWlVacjVOSE1Ya1gz?=
 =?utf-8?B?aEdLbS8wcmJ5TTNkeWwvUUoreEhZcnE3bWs1SHlqOFdIWXVXNVJNVC9tZUNh?=
 =?utf-8?B?VzlwV1JTbjRvNm0yQjBMNWxhT1hPaHhWakljQitKVG92bmgwVzdkaEsrS0M1?=
 =?utf-8?B?dHB5REpjcENlTkJxWmtla29nTlE1SFBzc0xLd1FON3UzYUlWd3NQU09OWVJi?=
 =?utf-8?B?TVVsN2RDZEJRS3BMSmFXUzhZbXgxNS8yUm51anltckZqT0ZydTlScllqWks3?=
 =?utf-8?B?bWFURk9sdnlLR3dUT1pMOWJmSDhjazJ2UDNEanpUZ0FRcTVONFY2aUx0RzNm?=
 =?utf-8?B?dEZTbDhjOUhIMXhwMnFZU0FaNDd4cnBaKzMyRWYwTVBKb0FrZEdxbFlSbDc3?=
 =?utf-8?B?OEFKby8xKzUxOTAvLy9jYVNUZFdHU2ttMWlUcWh4TUxsZEZsVWxhRDVYdFhH?=
 =?utf-8?B?ci8vcU04eTVjdnNPN1FLSVcxMFY5SVBTNjJ4bmtQemRVYzIrSUVJSkEzRS9U?=
 =?utf-8?B?a0hJaW9LUGQwOFMzRno4Z0pjQVE1Skw0QkgyQ3ZWc0NjMlRrWjBpY3BpaXJX?=
 =?utf-8?B?YWxPeWJ4L0RjeUFMVm9pUXl1WjY0dC95QkZoZDgzLytsclg5WUdLZFFlTVg1?=
 =?utf-8?B?S0ZHT2craUlOUmpDYjJrM1BmNmMwcEFiYnM0eVlPWEZvU0tnM0piNXhhaU5k?=
 =?utf-8?B?MW8xQ1dOajJOS00rMEQ1cUtONm1uRWxUVEtJUjZyMnEwcElweG01dTJ2clpH?=
 =?utf-8?B?NVpIWStqWG1TemVwWGhnVXYvWmhxRnRnWWJpVGkraGUwaXI3UmlMOFZEbEU5?=
 =?utf-8?B?Y2IwTVJuKzZMd290UjkyN0JWcGtxNTVQUnVIRVBTcVRMcUhPRFI1UDl5S1Vm?=
 =?utf-8?B?QVd3aEhFblczc0FMczJLTDJZM3Z3Q2xHZG40eTU2UUl2UmxvdWhiWWNkSzRv?=
 =?utf-8?B?dy9IR2IxU3RuZkNiT1FCdFM2TW9ydmtoLzcxVVpDWUJkU1BUQXpZcmh2Q2No?=
 =?utf-8?Q?/nFsKHVFYFYcVF3SQfpZak8CJM4+yPDCsIsSj89?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad363763-dc14-45e0-34b5-08d8fff0d2fe
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2021 09:28:27.3112 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7BL9XppsCZ1dNKqySx1KS9K1HewcVAqT5jx3W28fyPGcK3o2D1xTZ2lol/ToWNIfHdSFfmjkVFLgcdXp61KVaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3127
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

RGF2aWQsCgpPbiA0LzE0LzIwMjEgMTA6MzMgUE0sIERhdmlkIENvZSB3cm90ZToKPiBIaSBTdXJh
dmVlIQo+IAo+IEkndmUgcmUtcnVuIHlvdXIgcmV2ZXJ0K3VwZGF0ZSBwYXRjaCBvbiBVYnVudHUn
cyBsYXRlc3Qga2VybmVsIDUuMTEuMC0xNCBwYXJ0bHkgdG8gY2hlY2sgbXkgbWFpbGVyJ3MgJ21h
bmdsaW5nJyBoYWRuJ3QgYWxzbyByZWFjaGVkIHRoZSBjb2RlIQo+IAo+IFRoZXJlIGFyZSAzIHNl
dHMgb2YgcmVzdWx0cyBpbiB0aGUgYXR0YWNobWVudCwgYWxsIGZvciB0aGUgUnl6ZW4gMjQwMEcu
IFRoZSBhcy1kaXN0cmlidXRlZCBrZXJuZWwgYWxyZWFkeSBpbmNvcnBvcmF0ZXMgeW91ciBJT01N
VSBSRkN2MyBwYXRjaC4KPiAKPiBBLiBBcy1kaXN0cmlidXRlZCBrZXJuZWwgKGNvbGQgYm9vdCkK
PiAgwqDCoCA+NSByZXRyaWVzLCBzbyBubyBJT01NVSByZWFkL3dyaXRlIGNhcGFiaWxpdHksIG5v
IGFtZF9pb21tdSBldmVudHMuCj4gCj4gQi4gQXMtZGlzdHJpYnV0ZWQga2VybmVsICh3YXJtIGJv
b3QpCj4gIMKgwqAgPDUgcmV0cmllcywgYW1kX2lvbW11IHJ1bm5pbmcgc3RhdHMgc2hvdyBsYXJn
ZSBudW1iZXJzIGFzIGJlZm9yZS4KPiAKPiBDLiBSZXZlcnQrVXBkYXRlIGtlcm5lbAo+ICDCoMKg
IGFtZF9pb21tdSBldmVudHMgbGlzdGVkIGFuZCBhbHNvIHNob3cgbGFyZ2UgaGl0L21pc3MgbnVt
YmVycy4KPiAKPiBJbiBkdWUgY291cnNlLCBJJ2xsIGxvYWQgdGhlIG5ldyAocmV2ZXJ0K3VwZGF0
ZSkga2VybmVsIG9uIHRoZSA0NzAwRyBidXQgd29uJ3Qgb3ZlcmxvYWQgeW91ciBtYWlsLWJveCB1
bmxlc3Mgc29tZXRoaW5nIHVudXN1YWwgdHVybnMgdXAuCj4gCj4gQmVzdCByZWdhcmRzLAo+IAoK
Rm9yIHRoZSBSeXplbiAyNDAwRywgY291bGQgeW91IHBsZWFzZSB0cnkgd2l0aDoKLSAxIGV2ZW50
IGF0IGEgdGltZQotIE5vdCBtb3JlIHRoYW4gOCBldmVudHMgKE9uIHlvdXIgc3lzdGVtLCBpdCBo
YXMgMiBiYW5rcyB4IDQgY291bnRlcnMvYmFuay4KSSBhbSB0cnlpbmcgdG8gc2VlIGlmIHRoaXMg
aXNzdWUgbWlnaHQgYmUgcmVsYXRlZCB0byB0aGUgY291bnRlcnMgbXVsdGlwbGV4aW5nKS4KClRo
YW5rcywKU3VyYXZlZQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
