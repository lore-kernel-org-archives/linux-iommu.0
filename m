Return-Path: <SRS0=nNEG=IB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0A8C433DB
	for <iommu@archiver.kernel.org>; Wed,  3 Mar 2021 16:37:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D15C564E74
	for <iommu@archiver.kernel.org>; Wed,  3 Mar 2021 16:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D15C564E74
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 82E696F950;
	Wed,  3 Mar 2021 16:37:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0ea5Zq46TGeg; Wed,  3 Mar 2021 16:37:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3E4AD6F600;
	Wed,  3 Mar 2021 16:37:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13BCFC000B;
	Wed,  3 Mar 2021 16:37:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C91B9C0001
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 16:37:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B646A400F4
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 16:37:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=nxp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ojo2yv2OjWj3 for <iommu@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 16:37:47 +0000 (UTC)
X-Greylist: delayed 03:38:35 by SQLgrey-1.8.0
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2089.outbound.protection.outlook.com [40.107.21.89])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D2A70400D5
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 16:37:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VH2LYN/+yDDhTR1fQQq5ZuvAd3MNl9/X14UUeZQ6m/FZzpXd3VpqfMsSfHOOPX5xqgTN6oF7Xl2JMPjw4ej0SWcfRHMgKQ4WWKbsglx/IC55YJOmFlZisaSzti6+ndOThg2qEPZ0zgwBKgGbxh4cXm+YKtnLFbMXlPAAGQKgLWnZ0/bRDLsRiYLXMTOMecT4C34IEjDQhbXMhYZByGBdQ1BnO79qMfxfG3tKHpO2qX3rH1aLFHhcxB63HtQILcrWa1B9vVvFuO0ojATINlhElvWTuSZV1ZSpYkqNrVbZtdWaPIo2oQ4XUZk6+99BK/eeSNG9SurtZNvKOwQpdbjoUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXTAyg/vaUOZs3eq4IaQPZq6AQsOJ4fCdlyJrAR/N/c=;
 b=H+D+sbRN8hko8SJEsXl2GItN8N7TZMWQsOfWvfwdfiraYmuEdiRGYmY6AsnDvDWrrBL0cnSU1W3JPGJy+v8jLFJf8OFPoonyhsHWA2QpANaoJooRyO4EzIGskkg57KbZ4KteJwnRAEE813eJTAcfCKq3vZo/liYYE04sDV0WZhj/Xl05rTWTHEnYXgpjAUZdFsAylulTnAHvWXcBBeFMdQrIJWeoGzho/x8ZEnTPkzqI8orI4hRedDKh7QNiU1MbteqE/zz5p6CUKmihtyZ76BAvd8VmCxrM0Za2yOAdHuVp1dX7gQviU60iJ8wbQqGBnW+VStso0ou8OaWDHpU3kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXTAyg/vaUOZs3eq4IaQPZq6AQsOJ4fCdlyJrAR/N/c=;
 b=gY1cs6OwGjF2+/pXYiVwzBFM+6uHRJFan/blZ6b+/N7zx5Zkp7uz9U6hycI0d6EMw/Nx5TeIMDzsEJBsQ7ZlcJPgwF0IIyPNTzReHlQ4E+9rNVcUujPmyfr4AQFFujFPMyTjh0ixXK+5JyYU1/ww126f7y10n1HmtJqrvJpFGXs=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=nxp.com;
Received: from VI1PR04MB4046.eurprd04.prod.outlook.com (2603:10a6:803:4d::29)
 by VI1PR04MB6989.eurprd04.prod.outlook.com (2603:10a6:803:131::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 3 Mar
 2021 16:04:21 +0000
Received: from VI1PR04MB4046.eurprd04.prod.outlook.com
 ([fe80::29a6:a7ec:c1d:47ba]) by VI1PR04MB4046.eurprd04.prod.outlook.com
 ([fe80::29a6:a7ec:c1d:47ba%5]) with mapi id 15.20.3912.017; Wed, 3 Mar 2021
 16:04:21 +0000
Subject: Re: CAAM: kernel BUG at drivers/crypto/caam/jr.c:230! (and
 dma-coherent query)
To: Robin Murphy <robin.murphy@arm.com>, Sascha Hauer <sha@pengutronix.de>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
References: <20210301152231.GC5549@pengutronix.de>
 <a52e0a0f-a784-2430-4b37-fb9fdcf3692b@nxp.com>
 <a5d6cc26-cd23-7c31-f56e-f6d535ea39b0@arm.com>
From: =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>
Message-ID: <a1f8b4db-42e3-3719-070b-7e2143134af1@nxp.com>
Date: Wed, 3 Mar 2021 18:04:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <a5d6cc26-cd23-7c31-f56e-f6d535ea39b0@arm.com>
Content-Language: en-US
X-Originating-IP: [78.97.206.147]
X-ClientProxiedBy: AM0PR01CA0100.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::41) To VI1PR04MB4046.eurprd04.prod.outlook.com
 (2603:10a6:803:4d::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.213] (78.97.206.147) by
 AM0PR01CA0100.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::41) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Wed, 3 Mar 2021 16:04:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 584ee782-a78a-4d50-4aca-08d8de5e019e
X-MS-TrafficTypeDiagnostic: VI1PR04MB6989:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB698923BA1382D7D388EA265C98989@VI1PR04MB6989.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FFH2GoEdreJqImRJgGt5vzwV6xyrmFfZo7sywUamGE4Scc+LCCBxtifYyuKDf79YaaLh/LI8bZt8FIAaYPmUuw1RDeSSbBiwJ62UlAmWcSmgkXm4VoMFP4uo8FG5biyYbKHoOVJnZqjeN326ljzU7EKdPQkJ6axkREdqRA0Kojo5fdmmbGdQ3HfvyNtOWFqCDXJX/yvgE7MowXp9p914wYGVXzp2L/GT5PKEVRhZr2RQtMEDv3TTY9Z73XYPbQVa7NSYeGZ0j8+Nd9F+9VEl7ZUuL9HlSzs+CSNrCpV6bx+DT/yMh2X/JlhiavuXJb2H98/Av+XJLwGCyW/4WMcoa6SpmIbUS+4MCPp1p58Y7/9JKECmtkP3KEGRpmWbHp4i7Nl96V4Nzw1c5nnqQX0PV+PoAhqtK4EKuceTOhy4yTHxdfcqZrNINFpO+RxfjmcIYw8EglVz7elucBI1xfndqXktDLA2/f+E76OrMChqKEF1wMdoMpGaJ74/XK7TWsBPl6ZAX3KzJg40HJWNZz+Ald/IBui9wdsdrRkUp+EcCFMQe1kjAQ8MgM84o5h/BTTfVPzyyMYeNb2J34MRx36KUxnE2bW44GkxsZ+DKFkU29RkTgWxFfJnv7Ul2ehXZwDqdA2eN6fPS3Ns0UujA+LLCyzEkrP8rw8uaIH61lhNRac=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB4046.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(346002)(39860400002)(366004)(83380400001)(45080400002)(54906003)(16576012)(66556008)(66476007)(110136005)(5660300002)(66946007)(316002)(966005)(53546011)(2616005)(16526019)(478600001)(2906002)(186003)(26005)(52116002)(86362001)(31696002)(956004)(8676002)(4326008)(31686004)(8936002)(6486002)(36756003)(7416002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?U3ZnT0Q3dEV5bGdmL3JSci91cDFkN0dXNHA2TU43MjcxQlBBbXlVRmVGd2ZD?=
 =?utf-8?B?USt0eldnS1lkSFVtT3dQdUVCT0YxSVVxOHVoUy8yblRIemFFSlc4akszRXlO?=
 =?utf-8?B?dkQvRmNmWTJIb3ZpM0RRY3RGVTd6UHFKMzg4RWhoSDl2WXJ1UDROcXppTGN1?=
 =?utf-8?B?eGNYbS9MZDA5dmwvdWVjajl1RW11cmtzVk5oMExnK2JIMHdqaWcyVGhXVkFk?=
 =?utf-8?B?MmM3K2hoTktxbVhkS0JxaUtxTHM3bnJiZTErbGd0MWpOQ1hHRkJ0RGVpL0xQ?=
 =?utf-8?B?MFY0VTAzdU5QdyttZGhmWjVyeFpCVTlyaXJ1WmRJK1ZOM1ZzazZCRE1EcVVV?=
 =?utf-8?B?blY5OEJLS0ozdXIyaElyTU00UXRubC93UXBPdDJiSEJGdkxSdmY0N0xzaHZV?=
 =?utf-8?B?RWpkRnJGRG5XcFoyU3ZWTFYxVGVxRFV6S2xrT2JxaGRldG83aUZCRGJWZ2FG?=
 =?utf-8?B?NEpEMVFJbktFanhEOEdPd3dHUkw4bmdTOHQ5ZGRReHRDTTdBM0JIRE1HTTJy?=
 =?utf-8?B?Y3MvYWw2QUJsU1ZrbmZPaEtPdVE1T0taM0VLQ3dRQlNpaHg3MXZrdFNTc2tv?=
 =?utf-8?B?b1p3N25adjUxdldNYk5GUEt1ekxzdkpaazV0bjNudnRjcG1aZTBrYjdTQW05?=
 =?utf-8?B?UThrVnl1N0lLYWVSWVVEQ1Y5MUFuWTVEa281WVNkWi9KNjJvUjB4dllGalZy?=
 =?utf-8?B?ZFF5TTR4c1gwSEVtdDZuaUw3WEhjWHhSMWFmOVhSZGFSRTUvUExhTmRPbzFi?=
 =?utf-8?B?NTlqd0cxT0JjbnFtVnhSM1VyZ016UkRWZFkzNDFuUGNhWUk0VXN6dGw2NXdU?=
 =?utf-8?B?MFpJUjVxSmVDTWpPRERmRFFVQ2RCTDRJc0pEM1BXdzZvM3hDLzQ4MytGK1k3?=
 =?utf-8?B?RllKQkhMcTNKZFF5VmRRb2hLeW5JeFg1N0pESnRYUmxldzV0SnAwK0ZWK3d2?=
 =?utf-8?B?OFIzT1FwSUM2RjRnWnVUbHR0RWdIdnB1M1VhNHAvVkdMcmhCMnpIOVVFSTlT?=
 =?utf-8?B?RTJaUEZJM2lyNUU3cmlQWWc5OXMwWE1yL0RQd3pkMjFIdm9jRFdLUkZET3E0?=
 =?utf-8?B?TzVjbmRHdEpVbEVIN0FDeUxnRDExQ0tKVFd3djBWalcrS2ZrTm9xeFdleWFB?=
 =?utf-8?B?WXpkTFpkUGEyVnZqcnY3bU1zK3RpQmVURUpMN09xMmt2UEhOMThXR3dpR2pS?=
 =?utf-8?B?WU1QVXdJKzEvSkFFQWJqL1VGblg3S1hxY2Z4cUR4V0grVFZ3UGNuTUE4M243?=
 =?utf-8?B?WWk0YnhyTnpwOVBNNCtxLzVqMVMvbU45SUY1T1J3QXZmSUtGZWtCYlZyRFYw?=
 =?utf-8?B?TEJVNExONmdYOFVLd2RvR3J6QkpSd2hEVDg2ajRDOThDVXQyTHNJN2E5K2xi?=
 =?utf-8?B?a1dCbUtBa253Z0pVMWhKZU4wZmVhWFRsSTFrWis1NFZNajZ6bjV0NldhdGUw?=
 =?utf-8?B?dkdjWCtvcjZRczNnYjlabWM4akhKVjk4eVhZV1JXc1lLTFVZdDFvaFI0aE50?=
 =?utf-8?B?UVBycHBndndtSUo5MjFLd0J0U25VQ1ZhWTRIR1cyYmMwbjJIN0hqMFVHTmpW?=
 =?utf-8?B?R1JvYjNhTlVlcGVVWEM1RXlMTU9SVk9ma3g5d1Baa0creFpsMHV1UG5BM1Jj?=
 =?utf-8?B?K0RkRVZicEFaSFJYNGhvUTRmM1pVTkRCR08xQ29WTzkxdlZhNFZ0d3lURDcv?=
 =?utf-8?B?NkE0QmwvVmtXdXJzZWJJRmk1dVlBRmtuNHB1TmNCNHhabXRTaFI5RDZTdkl1?=
 =?utf-8?Q?0JfE2qq3I8nZ/7aQ1C7eMK8IrYtRLVwFJx54lXb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 584ee782-a78a-4d50-4aca-08d8de5e019e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2021 16:04:21.1866 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ShZYSaIkHQPHT1w0mH72he0PUMTpCDj8xElqfc9vGr6UgsHIRNSjXO0xEP9lvpDO0FQw6MrrPhzbEFV4isy92Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6989
Cc: Aymen Sghaier <aymen.sghaier@nxp.com>,
 Russell King <rmk+kernel@armlinux.org.uk>, Christoph Hellwig <hch@lst.de>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Greg Ungerer <gerg@linux-m68k.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gMy8zLzIwMjEgMjowNyBQTSwgUm9iaW4gTXVycGh5IHdyb3RlOgo+IE9uIDIwMjEtMDMtMDMg
MTA6MjYsIEhvcmlhIEdlYW50xIMgd3JvdGU6Cj4+IEFkZGluZyBzb21lIHBlb3BsZSBpbiB0aGUg
bG9vcCwgbWF5YmUgdGhleSBjb3VsZCBoZWxwIGluIHVuZGVyc3RhbmRpbmcKPj4gd2h5IGxhY2sg
b2YgImRtYS1jb2hlcmVudCIgcHJvcGVydHkgZm9yIGEgSFctY29oZXJlbnQgZGV2aWNlIGNvdWxk
IGxlYWQgdG8KPj4gdW5leHBlY3RlZCAvIHN0cmFuZ2Ugc2lkZSBlZmZlY3RzLgo+Pgo+PiBPbiAz
LzEvMjAyMSA1OjIyIFBNLCBTYXNjaGEgSGF1ZXIgd3JvdGU6Cj4+PiBIaSBBbGwsCj4+Pgo+Pj4g
SSBhbSBvbiBhIExheWVyc2NhcGUgTFMxMDQ2YSB1c2luZyBMaW51eC01LjExLiBUaGUgQ0FBTSBk
cml2ZXIgc29tZXRpbWVzCj4+PiBjcmFzaGVzIGR1cmluZyB0aGUgcnVuLXRpbWUgc2VsZiB0ZXN0
cyB3aXRoOgo+Pj4KPj4+PiBrZXJuZWwgQlVHIGF0IGRyaXZlcnMvY3J5cHRvL2NhYW0vanIuYzoy
NDchCj4+Pj4gSW50ZXJuYWwgZXJyb3I6IE9vcHMgLSBCVUc6IDAgWyMxXSBQUkVFTVBUIFNNUAo+
Pj4+IE1vZHVsZXMgbGlua2VkIGluOgo+Pj4+IENQVTogMCBQSUQ6IDAgQ29tbTogc3dhcHBlci8w
IE5vdCB0YWludGVkIDUuMTEuMC0yMDIxMDIyNS0zLTAwMDM5LWc0MzQyMTU5Njg4MTYtZGlydHkg
IzEyCj4+Pj4gSGFyZHdhcmUgbmFtZTogVFEgVFFNTFMxMDQ2QSBTb00gb24gQXJrb25hIEFUMTEz
MCAoQzMwMCkgYm9hcmQgKERUKQo+Pj4+IHBzdGF0ZTogNjAwMDAwMDUgKG5aQ3YgZGFpZiAtUEFO
IC1VQU8gLVRDTyBCVFlQRT0tLSkKPj4+PiBwYyA6IGNhYW1fanJfZGVxdWV1ZSsweDk4LzB4NTdj
Cj4+Pj4gbHIgOiBjYWFtX2pyX2RlcXVldWUrMHg5OC8weDU3Ywo+Pj4+IHNwIDogZmZmZjgwMDAx
MDAwM2Q1MAo+Pj4+IHgyOTogZmZmZjgwMDAxMDAwM2Q1MCB4Mjg6IGZmZmY4MDAwMTE4ZDQwMDAK
Pj4+PiB4Mjc6IGZmZmY4MDAwMTE4ZDQzMjggeDI2OiAwMDAwMDAwMDAwMDAwMWYwCj4+Pj4geDI1
OiBmZmZmMDAwODAyMmJlNDgwIHgyNDogZmZmZjAwMDgwMjJjNjQxMAo+Pj4+IHgyMzogMDAwMDAw
MDAwMDAwMDFmMSB4MjI6IGZmZmY4MDAwMTE4ZDQzMjkKPj4+PiB4MjE6IDAwMDAwMDAwMDAwMDRk
ODAgeDIwOiAwMDAwMDAwMDAwMDAwMWYxCj4+Pj4geDE5OiAwMDAwMDAwMDAwMDAwMDAxIHgxODog
MDAwMDAwMDAwMDAwMDAyMAo+Pj4+IHgxNzogMDAwMDAwMDAwMDAwMDAwMCB4MTY6IDAwMDAwMDAw
MDAwMDAwMTUKPj4+PiB4MTU6IGZmZmY4MDAwMTE2OTAyMzAgeDE0OiAyZTJlMmUyZTJlMmUyZTJl
Cj4+Pj4geDEzOiAyZTJlMmUyZTJlMmUyMDIwIHgxMjogMzAzMDMwMzAzMDMwMzAzMAo+Pj4+IHgx
MTogZmZmZjgwMDAxMTcwMGEzOCB4MTA6IDAwMDAwMDAwZmZmZmYwMDAKPj4+PiB4OSA6IGZmZmY4
MDAwMTAwYWRhMzAgeDggOiBmZmZmODAwMDExNmE4YTM4Cj4+Pj4geDcgOiAwMDAwMDAwMDAwMDAw
MDAxIHg2IDogMDAwMDAwMDAwMDAwMDAwMAo+Pj4+IHg1IDogMDAwMDAwMDAwMDAwMDAwMCB4NCA6
IDAwMDAwMDAwMDAwMDAwMDAKPj4+PiB4MyA6IDAwMDAwMDAwZmZmZmZmZmYgeDIgOiAwMDAwMDAw
MDAwMDAwMDAwCj4+Pj4geDEgOiAwMDAwMDAwMDAwMDAwMDAwIHgwIDogMDAwMDAwMDAwMDAwMTgw
MAo+Pj4+IENhbGwgdHJhY2U6Cj4+Pj4gICBjYWFtX2pyX2RlcXVldWUrMHg5OC8weDU3Ywo+Pj4+
ICAgdGFza2xldF9hY3Rpb25fY29tbW9uLmNvbnN0cHJvcC4wKzB4MTY0LzB4MThjCj4+Pj4gICB0
YXNrbGV0X2FjdGlvbisweDQ0LzB4NTQKPj4+PiAgIF9fZG9fc29mdGlycSsweDE2MC8weDQ1NAo+
Pj4+ICAgX19pcnFfZXhpdF9yY3UrMHgxNjQvMHgxNmMKPj4+PiAgIGlycV9leGl0KzB4MWMvMHgz
MAo+Pj4+ICAgX19oYW5kbGVfZG9tYWluX2lycSsweGMwLzB4MTNjCj4+Pj4gICBnaWNfaGFuZGxl
X2lycSsweDVjLzB4ZjAKPj4+PiAgIGVsMV9pcnErMHhiNC8weDE4MAo+Pj4+ICAgYXJjaF9jcHVf
aWRsZSsweDE4LzB4MzAKPj4+PiAgIGRlZmF1bHRfaWRsZV9jYWxsKzB4M2MvMHgxYzAKPj4+PiAg
IGRvX2lkbGUrMHgyM2MvMHgyNzQKPj4+PiAgIGNwdV9zdGFydHVwX2VudHJ5KzB4MzQvMHg3MAo+
Pj4+ICAgcmVzdF9pbml0KzB4ZGMvMHhlYwo+Pj4+ICAgYXJjaF9jYWxsX3Jlc3RfaW5pdCsweDFj
LzB4MjgKPj4+PiAgIHN0YXJ0X2tlcm5lbCsweDRhYy8weDRlNAo+Pj4+IENvZGU6IDkxMzkyMDIx
IDkxMmMyMDAwIGQzNzdkOGM2IDk3ZjI0ZDk2IChkNDIxMDAwMCkKPj4+Cj4+PiBUaGUgZHJpdmVy
IGl0ZXJhdGVzIG92ZXIgdGhlIGRlc2NyaXB0b3JzIGluIHRoZSBvdXRwdXQgcmluZyBhbmQgbWF0
Y2hlcyB0aGVtCj4+PiB3aXRoIHRoZSBvbmVzIGl0IGhhcyBwcmV2aW91c2x5IHF1ZXVlZC4gSWYg
aXQgZG9lc24ndCBmaW5kIGEgbWF0Y2hpbmcKPj4+IGRlc2NyaXB0b3IgaXQgY29tcGxhaW5zIHdp
dGggdGhlIEJVR19PTigpIHNlZW4gYWJvdmUuIFdoYXQgSSBzZWUgc29tZXRpbWVzIGlzCj4+PiB0
aGF0IHRoZSBhZGRyZXNzIGluIHRoZSBvdXRwdXQgcmluZyBpcyAweDAsIHRoZSBqb2Igc3RhdHVz
IGluIHRoaXMgY2FzZSBpcwo+Pj4gMHg0MDAwMDAwNiAobWVhbmluZyBERUNPIEludmFsaWQgS0VZ
IGNvbW1hbmQpLiBJdCBzZWVtcyB0aGF0IHRoZSBDQUFNIGRvZXNuJ3QKPj4+IHdyaXRlIHRoZSBk
ZXNjcmlwdG9yIGFkZHJlc3MgdG8gdGhlIG91dHB1dCByaW5nIGF0IGxlYXN0IGluIHNvbWUgZXJy
b3IgY2FzZXMuCj4+PiBXaGVuIHdlIGRvbid0IGhhdmUgdGhlIGRlc2NyaXB0b3IgYWRkcmVzcyBv
ZiB0aGUgZmFpbGVkIGRlc2NyaXB0b3Igd2UgaGF2ZSBubwo+Pj4gd2F5IHRvIGZpbmQgaXQgaW4g
dGhlIGxpc3Qgb2YgcXVldWVkIGRlc2NyaXB0b3JzLCB0aHVzIHdlIGFsc28gY2FuJ3QgZmluZCB0
aGUKPj4+IGNhbGxiYWNrIGZvciB0aGF0IGRlc2NyaXB0b3IuIFRoaXMgbG9va3MgdmVyeSB1bmZv
cnR1bmF0ZSwgYW55b25lIGVsc2Ugc2Vlbgo+Pj4gdGhpcyBvciBoYXMgYW4gaWRlYSB3aGF0IHRv
IGRvIGFib3V0IGl0Pwo+Pj4KPj4+IEkgaGF2ZW4ndCBpbnZlc3RpZ2F0ZWQgeWV0IHdoaWNoIGpv
YiBhY3R1YWxseSBmYWlscyBhbmQgd2h5LiBPZiBjb3Vyc2UgdGhhdCB3b3VsZAo+Pj4gYmUgbXkg
dWx0aW1hdGUgZ29hbCB0byBmaW5kIHRoYXQgb3V0Lgo+Pj4KPj4gVGhpcyBsb29rcyB2ZXJ5IHNp
bWlsYXIgdG8gYW4gZWFybGllciByZXBvcnQgZnJvbSBHcmVnLgo+PiBIZSBjb25maXJtZWQgdGhh
dCBhZGRpbmcgImRtYS1jb2hlcmVudCIgcHJvcGVydHkgdG8gdGhlICJjcnlwdG8iIERUIG5vZGUK
Pj4gZml4ZXMgdGhlIGlzc3VlOgo+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1jcnlw
dG8vNzRmNjY0ZjUtNTQzMy1kMzIyLTQ3ODktM2M3OGJkYjgxNGQ4QGtlcm5lbC5vcmcKPj4gUGF0
Y2ggcmViYXNlZCBvbiB2NS4xMSBpcyBhdCB0aGUgYm90dG9tLiBEb2VzIGl0IHdvcmsgZm9yIHlv
dSB0b28/Cj4+Cj4+IFdoYXQgSSBkb24ndCB1bmRlcnN0YW5kIChhbmQgdGhlIHJlYXNvbiBJJ3Zl
IHBvc3Rwb25lZCB1cHN0cmVhbWluZyBpdCkgaXMKPj4gX3doeV8gZXhhY3RseSB0aGlzIHBhdGNo
IGlzIHdvcmtpbmcuCj4+IEkgd291bGQgaGF2ZSBleHBlY3RlZCB0aGF0IGEgSFctY29oZXJlbnQg
ZGV2aWNlIHRvIHdvcmsgZmluZSBldmVuIHdpdGhvdXQKPj4gdGhlICJkbWEtY29oZXJlbnQiIERU
IHByb3BlcnR5IGluIHRoZSBjb3JyZXNwb25kaW5nIG5vZGUuCj4+IEkndmUgZm91bmQgd2hhdCBz
ZWVtcyByZWxhdGVkIGRpc2N1c3Npb25zIGludm9sdmluZyBlU0RIQywgYnV0IHN0aWxsIEkgYW0g
dHJ5aW5nCj4+IHRvIGZpZ3VyZSBvdXQgd2hhdCdzIGhhcHBlbmluZy4gSSdkIHJlYWxseSBhcHBy
ZWNpYXRlIGEgY2xhcmlmaWNhdGlvbiBvbiB3aGF0Cj4+IGNvdWxkIGdvIHdyb25nIChlLmcuIGlu
dGVyYWN0aW9ucyB3aXRoIFNXLWJhc2VkIGNhY2hlIG1hbmFnZW1lbnQgZXRjLik6Cj4+IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LW1tYy8yMDE5MDkxNjE3MTUwOS5HRzI1NzQ1QHNoZWxs
LmFybWxpbnV4Lm9yZy51awo+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMTkxMDEw
MDgzNTAzLjI1MDk0MTg2NkBsaW51eGZvdW5kYXRpb24ub3JnCj4+IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2xpbnV4LW1tYy9BTTdQUjA0TUI2ODg1MDdCNUI0RDg0RUIyNjY3Mzg4OTFGODMyMEBB
TTdQUjA0TUI2ODg1LmV1cnByZDA0LnByb2Qub3V0bG9vay5jb20KPiAKPiBDb25zaWRlciB0aGUg
ZmxvdyBmb3IgYSBub24tY29oZXJlbnQgRE1BX0ZST01fREVWSUNFIHRyYW5zZmVyOgo+IAo+IDE6
IGRtYV9tYXBfcGFnZSgpIC0gY2xlYW5zIGFuZCBpbnZhbGlkYXRlcyBjYWNoZXMgdG8gcHJldmVu
dCBhbnkgZGlydHkgCj4gbGluZXMgYmVpbmcgd3JpdHRlbiBiYWNrIGR1cmluZyB0aGUgdHJhbnNm
ZXIKPiAyOiBDUFUgY2FjaGUgbWF5IHByZWZldGNoIHRoZSBidWZmZXIgYmFjayBpbiBhdCBhbnkg
dGltZSBmcm9tIG5vdyBvbiAKPiAoZS5nLiBpZiBvdGhlciB0aHJlYWRzIGFjY2VzcyBuZWFyYnkg
bWVtb3J5KSwgYnV0IHRoYXQncyBPSyBzaW5jZSB0aGUgCj4gQ1BVIG11c3Qgbm90IGFjdHVhbGx5
IGFjY2VzcyBpdCB1bnRpbCBhZnRlciBzdGVwIDQsIGFuZCBjbGVhbiBsaW5lcyAKPiBkb24ndCBn
ZXQgd3JpdHRlbiBiYWNrCj4gMzogZGV2aWNlIHdyaXRlcyB0byBidWZmZXIgLSBub24tY29oZXJl
bnQgc28gZ29lcyBzdHJhaWdodCB0byBEUkFNCj4gNDogZG1hX3VubWFwX3BhZ2UoKSAtIGludmFs
aWRhdGVzIGNhY2hlcyB0byBkaXNjYXJkIGFueSBjbGVhbiBsaW5lcyAKPiBzcGVjdWxhdGl2ZWx5
IGZldGNoZWQgc2luY2Ugc3RlcCAxCj4gNTogQ1BVIHJlYWRzIGZyb20gYnVmZmVyIC0gZmV0Y2hl
cyBuZXcgZGF0YSBpbnRvIGNhY2hlLCBhbGwgaXMgd2VsbAo+IAo+IE5vdyBjb25zaWRlciB3aGF0
IGNhbiBoYXBwZW4gaWYgdGhlIGRldmljZSBpcyBzZWNyZXRseSBjb2hlcmVudCwgYnV0IHRoZSAK
PiBETUEgQVBJIHN0aWxsIHVzZXMgdGhlIHNhbWUgbm9uLWNvaGVyZW50IGZsb3c6Cj4gCj4gMTog
ZG1hX21hcF9wYWdlKCkgLSBjbGVhbnMgYW5kIGludmFsaWRhdGVzIGNhY2hlcyB0byBwcmV2ZW50
IGFueSBkaXJ0eSAKPiBsaW5lcyBiZWluZyB3cml0dGVuIGJhY2sgZHVyaW5nIHRoZSB0cmFuc2Zl
cgo+IDI6IENQVSBjYWNoZSAqZG9lcyogaGFwcGVuIHRvIHByZWZldGNoIHRoZSBidWZmZXIgYmFj
ayBpbgo+IDM6IGRldmljZSB3cml0ZXMgdG8gYnVmZmVyIC0gd3JpdGUgc25vb3AgaGl0cyBpbiBj
YWNoZSBzbyBkYXRhIGdvZXMgCj4gdGhlcmUgaW5zdGVhZCBvZiBEUkFNCj4gNDogZG1hX3VubWFw
X3BhZ2UoKSAtIGludmFsaWRhdGVzIGNhY2hlcywgdW5rbm93aW5nbHkgZGVzdHJveWluZyBuZXcg
ZGF0YQo+IDU6IENQVSByZWFkcyBmcm9tIHBhZ2UgLSBmZXRjaGVzIHdoYXRldmVyIG9sZCBkYXRh
IHdhcyBjbGVhbmVkIHRvIERSQU0gCj4gaW4gc3RlcCAxLCBoaWxhcml0eSBlbnN1ZXMuCj4gCj4g
Tm90ZSB0aGF0IGl0IHN0aWxsICpjYW4qIHdvcmsgb3V0IE9LIGluIHRoZSAobGlrZWx5KSBjYXNl
IHRoYXQgdGhlIAo+IHByZWZldGNoIGF0IHN0ZXAgMiBkb2Vzbid0IGhhcHBlbiwgc28gaW4gc3Rl
cCAzIHRoZSBzbm9vcCBkb2Vzbid0IGhpdCAKPiBhbmQgdGhlIGRhdGEgZG9lcyBlbmQgdXAgZ29p
bmcgdG8gRFJBTSwgb3IgKGxlc3MgbGlrZWx5KSB0aGUgdXBkYXRlZCAKPiBkaXJ0eSBsaW5lcyBh
cmUgbmF0dXJhbGx5IGV2aWN0ZWQgYW5kIHdyaXR0ZW4gYmFjayBiZXR3ZWVuIHN0ZXBzIDMgYW5k
IDQuCj4gCj4gU2ltaWxhcmx5LCBpZiBhIGJ1ZmZlciBpcyBtbWFwJ2VkIHRvIHVzZXJzcGFjZSAo
b3IgcmVtYXBwZWQgZm9yIGNvaGVyZW50IAo+IERNQSkgd2l0aCBub24tY2FjaGVhYmxlIGF0dHJp
YnV0ZXMgb24gdGhlIGFzc3VtcHRpb24gdGhhdCB0aGUgZGV2aWNlIGlzIAo+IG5vbi1jb2hlcmVu
dCAtIHRoZSBjYWNoZWFibGUgYWxpYXMgZnJvbSB0aGUga2VybmVsIGxpbmVhciBtYXAgY2FuIHN0
aWxsIAo+IGJlIHByZXNlbnQgaW4gY2FjaGVzLCBzbyBjb2hlcmVudCBkZXZpY2UgYWNjZXNzZXMg
Y2FuIHVuZXhwZWN0ZWRseSBoaXQgCj4gdGhhdCBhbmQgZmFpbCB0byBvYnNlcnZlIENQVSByZWFk
cyBhbmQgd3JpdGVzIGdvaW5nIHN0cmFpZ2h0IHRvL2Zyb20gCj4gRFJBTSB2aWEgdGhlIG5vbi1j
YWNoZWFibGUgYWxpYXMuIFdlIGhpdCB0aGlzIGNhc2Ugd2l0aCBQYW5mcm9zdCBvbiBzb21lIAo+
IEFtbG9naWMgcGxhdGZvcm1zIG5vdCB0b28gbG9uZyBhZ28uCj4gCj4gSG9wZSB0aGF0IGhlbHBz
IGNsYXJpZnkgdGhpbmdzLgo+IApUaGFua3MgUm9iaW4uCkluZGVlZCB0aGlzIGV4YW1wbGUgc2hv
d3MgaG93IHRoaW5ncyBjYW4gZ28gYXdyeS4KCkhvcmlhCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby9pb21tdQ==
