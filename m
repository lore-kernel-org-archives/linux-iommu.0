Return-Path: <SRS0=soV1=JQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0565C433ED
	for <iommu@archiver.kernel.org>; Mon, 19 Apr 2021 07:07:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EA946102A
	for <iommu@archiver.kernel.org>; Mon, 19 Apr 2021 07:07:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EA946102A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F16C8607AB;
	Mon, 19 Apr 2021 07:07:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MYS_LYmoqHBj; Mon, 19 Apr 2021 07:07:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id A62E96060D;
	Mon, 19 Apr 2021 07:07:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71231C000E;
	Mon, 19 Apr 2021 07:07:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5E51AC000B
 for <iommu@lists.linux-foundation.org>; Mon, 19 Apr 2021 04:27:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3647340132
 for <iommu@lists.linux-foundation.org>; Mon, 19 Apr 2021 04:27:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=nxp1.onmicrosoft.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r2SpWdF4mbCV for <iommu@lists.linux-foundation.org>;
 Mon, 19 Apr 2021 04:27:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02on0602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe07::602])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 283EF400C0
 for <iommu@lists.linux-foundation.org>; Mon, 19 Apr 2021 04:27:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BIfUylbF1u6g42Ih0vw50xP6D7xRSLWW2I9zIv8xpPfI+8QTA+Yvqs8rcEhgkShhN1F5VCTfikyuN00lU7MYQpLyAi61zSBXde+lBtKtZ91KF4JkDryrkKImQc4jtArTgkvv22rGSlWBi+316rG07ozzVX8yH+lrNaB4Y76q0iQ4zUQW6K3d9JzIJkWsU1QsvjfqMy2v6XzsDlch5VnExSBZi1Fditx7GwrKrLI7E/sfpEmjrnivx/IpLa9EXSocY6lD/yML7X4WAKNF1EY300fyMYpWitucXgZ/XL8CLbbwDx1OQw7Fi2QoTb2TSXTWyC1GIFPgb1qOvwl4cLPWlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGsFEeNS52w1ZRf0E7RmTdDzsa/XGegT9oBy+olcLfY=;
 b=hGFFrgJo2nl82ALdcCWukVL33RkUM6iFcTbkS0Q6cbKM62pdvYnFsqLLOtlF+2o2VdYauLw4dwP2SOeHtc3aZK7MlLjtddm7LhJTrWTkIj6VkevHMcvevTOm0Iaa1xW8T6J+3i8PR8ODJ/vsRcMpNN5h52SiwRYematUkUoYYgadgMtAVfcWh/leBm2L8Tg51aG1SFFROj7+y2jsXIW81DOM/gOKW31vHMKMqX6qmnynX8F75iYwa4zb9oeycrCf1V0DNBxu5cGiiQ81HZj1l4KbQ6UDlERn6Pd76e3un4zKWXsAtWQNRqdFc0IAvJ55fTvey3xfXI4mXsOkubJDog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGsFEeNS52w1ZRf0E7RmTdDzsa/XGegT9oBy+olcLfY=;
 b=j+dOYrXfIk7Kfa0Fobi8pj2zSP1kRkdYvZPRfIcM8F+/XY2p5O6m146Lg8uw11qr8f1XCxfgzTkNhGiUBKIwzqfro+IOGzrsiOB/EFGQjxCT+tmokcK5gMw090mHbYn4cAawbUShERe9QsYw1J905qk2uPKxj/G1mOjHNwIbMt4=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=oss.nxp.com;
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AS8PR04MB7912.eurprd04.prod.outlook.com (2603:10a6:20b:2ae::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Mon, 19 Apr
 2021 04:27:06 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::b034:690:56aa:7b18]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::b034:690:56aa:7b18%4]) with mapi id 15.20.4042.024; Mon, 19 Apr 2021
 04:26:59 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: gregkh@linuxfoundation.org, rafael@kernel.org, horia.geanta@nxp.com,
 aymen.sghaier@nxp.com, herbert@gondor.apana.org.au, davem@davemloft.net,
 tony@atomide.com, geert+renesas@glider.be, mturquette@baylibre.com,
 sboyd@kernel.org, vkoul@kernel.org, peter.ujfalusi@gmail.com,
 a.hajda@samsung.com, narmstrong@baylibre.com, robert.foss@linaro.org,
 airlied@linux.ie, daniel@ffwll.ch, khilman@baylibre.com, tomba@kernel.org,
 jyri.sarha@iki.fi, joro@8bytes.org, will@kernel.org, mchehab@kernel.org,
 ulf.hansson@linaro.org, adrian.hunter@intel.com, kishon@ti.com,
 kuba@kernel.org, linus.walleij@linaro.org, Roy.Pledge@nxp.com,
 leoyang.li@nxp.com, ssantosh@kernel.org, matthias.bgg@gmail.com,
 edubezval@gmail.com, j-keerthy@ti.com, balbi@kernel.org,
 linux@prisktech.co.nz, stern@rowland.harvard.edu, wim@linux-watchdog.org,
 linux@roeck-us.net
Subject: [RFC v1 PATCH 0/3] support soc_device_match to return -EPROBE_DEFER
Date: Mon, 19 Apr 2021 12:27:19 +0800
Message-Id: <20210419042722.27554-1-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: AM0PR02CA0207.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::14) To AM6PR04MB6053.eurprd04.prod.outlook.com
 (2603:10a6:20b:b9::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxf55104-OptiPlex-7060.ap.freescale.net (119.31.174.71) by
 AM0PR02CA0207.eurprd02.prod.outlook.com (2603:10a6:20b:28f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19 via Frontend
 Transport; Mon, 19 Apr 2021 04:26:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9896ff12-c5b4-421f-f9a1-08d902eb5f30
X-MS-TrafficTypeDiagnostic: AS8PR04MB7912:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR04MB7912513CE4C6A5F1A16187D3A3499@AS8PR04MB7912.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AK1XnEs7EIU/2ApqujL4ENEsdD7cfE1FbgcvAaPgea6Hbv0vJgmkFlrJQc9Zwe0hRvg6ODWJqw7DeYSJRkwBUI6Dg9CvBg76tQsc/zECgFN9N0rU1PraAub2z1SmPXooxUEKWedxX5mry6PHesrXtLa56siBXEvmuwr/ay92Ty2P7nHxHjCjlwvncBhFzscBGAd2Tlz6ly4vsWI7jjwFt5zemq9s1tZzujO+pRaFFN0jLicObMUjXbOCYpNjld7qp3nLx4wkcfdipmjFsCJXiTk+x7LXtjQ3SFz3tJFe1/gciMsGU9oMwC2wF7hUdL1RdpiZLDgJVep6zFnA56/ISZh0nJOUfxYyH5cueA1KZK3QNB6PMI7kZ0ex8+hoQL0dXjtTG6c4tOkauz1CuRnqiQ/2rBiwXb+SekuC44XZa1J4ady1C9t8Mg9honhFO5TtLtkNxiEbL90A14r7TxjM2Q61qy6OxOtFSpF1+lPl2Gkvxu+yivq0TNugxczd2YY6WAE1PONiwqP0D3oJlk28nEJrxZ1QsCEJrWIDpRmBdvt7cHDmn2IGnX0rbRNtHwm5Vj50Bwo2EmrqFvgMs/NwPESfADARD49yW+UCIFJAQxRl681Nbj7s55lka7wcQkZinoUggVYz1CbaryPIzm2Z/V/Nb1WtEpnxWWjL8aF5R7M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR04MB6053.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(1076003)(66946007)(7406005)(478600001)(52116002)(66556008)(66476007)(2906002)(7366002)(7416002)(8936002)(921005)(8676002)(4326008)(5660300002)(16526019)(26005)(38100700002)(83380400001)(956004)(2616005)(38350700002)(6486002)(6666004)(6506007)(6512007)(186003)(316002)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aVdtSGVXV002Y2NaaDlsL2RhYzBTbFFsLzI0RnNqcmI3U2hjTTg1LzQvMEFx?=
 =?utf-8?B?VE0ySXJiSmRSNEVPMG9SZ1p4OUxzb3hSbGkwK1VuZmJzcExSUkVXbmp1dUR1?=
 =?utf-8?B?WlNoVFVCdmFpdEZ5KzNjV3ZhdkwrUG10L3IzQ3ViMndabVJPMHVjTUlLb210?=
 =?utf-8?B?OTdnNFhLVUd6TEpwajVpdzdFaFRzVTVaTXUvMWFwa1J3V0RuS3FBalV6bkMw?=
 =?utf-8?B?REtXbEh0RGR4cGlxMHpxN1ZmNFBmT3dBR285Q2k2QjZUSU9mUDZ4VzgvelpR?=
 =?utf-8?B?bVhwVGZsT0hITTdha09TVnoyYnZCWVQvdUFhemJibnB4UXp1UTd3Z21xWHNO?=
 =?utf-8?B?S2VDRm1oandzWHpTVjc0Qks2NFpuYmsxaUpRRlMyTTVhVHNvTXVJN0cvZURD?=
 =?utf-8?B?c294ODZVaDdHb2ZRaVRNQXV4N1B4dmgxcHM5NXh4UFRVYWlGdTRmeTYwVjRX?=
 =?utf-8?B?elpNU3VUMzNud2UrNFlxRFpQUytHVmorOFRRb2N6dlVMQ0t4Vmdua2lVQy80?=
 =?utf-8?B?dWRZMDBJdWNZRjJZRlVRWlZKczdaK1hPSFlxOWJ0cC94aFo0eEk4czhkZDA2?=
 =?utf-8?B?Q0NCdExiWXFGb1B3U3YyeXFRYjZjdmpTM1RJYTZIaVhiY1JTRDFVcXNobUIr?=
 =?utf-8?B?Q3dDS2xHTHNZd1A5dy9rS29Jc0MvSVhMeU9LeFU1WllrSi9ZVFNoQWJvcHNw?=
 =?utf-8?B?NlpKOFZXdnd1Y2YzcEJoOW1JYTVMRFhwcjdJQUlKRUp1S1RPUmd5L0R5cXAz?=
 =?utf-8?B?WVRSbnRsNmZUM2hTeVRHdFdpdCtIMkJkZ0x2aitSdTJPVjNCTVRaU0w1dzBR?=
 =?utf-8?B?SnNqZHBVREdVb25lVHVzTlpZSFcxMjRGb2JZNFhvU1hjc0tXWHk3clJMTEt5?=
 =?utf-8?B?YVdqNEp0NENmT0RTcTNFZ3dWUjc4Z0UwUkdTSGdKeUNXRi94ZEI0RFQrTTdW?=
 =?utf-8?B?UVVZY1pTSVpyMkg5VEZVM1hMUmdXTWF4WDJ3UTN3dEZzRmpEQUhrMTNtY2tM?=
 =?utf-8?B?dHVOSitKdWpYWWcybmprNUl1N2Eyclp1T29rUlRsVnNIdzJmeVBSdjloTVhN?=
 =?utf-8?B?RXk2cXZIR2RsQ2pBMHRreUw1TnBLYUZOWENzSGtTUXlnZlFnSDJUNXR1QzVV?=
 =?utf-8?B?YVJlbXZFMFVFTXZjOVRtQlJlMkJXTzNad0NPRjlkRGd5UzlXdGRMd2FEdUFk?=
 =?utf-8?B?bTJSVGVueTk1Q290MmFSN1dkSzlCYWxhVnhqZUdYb3Q1RTQ1eldkbkdVa1N6?=
 =?utf-8?B?TXovZERmclBxY0xjemkrbUNHVjRNMU1GOW4vMXFjc3pnR0wrd201dmpqSllU?=
 =?utf-8?B?SVIxV2Y2MlhaU2svdzVvMldRcUdyK2hRVitkUUpPeVd1S2hNNlRxMkpSUDE1?=
 =?utf-8?B?OUY0UEFoUmNEMWVCdS9aeUFURG56bngrYWVSMUJoTFhSMmVqdjAvM05mblVn?=
 =?utf-8?B?bVYxYm5LeWNXbWNGeHFZQXdBZlZHd2JXbTFhWVNWR2taTzZnQTZQV2hVOFhJ?=
 =?utf-8?B?QjMyYXNTcy9ab0x3eHdhS3lUd2pQUkJZWXFocU14Q2tTTGFwY3ZvZWlzYkpk?=
 =?utf-8?B?ZkFwMXI0VHlxRXZ5SkdtZW1iMW04blZWTlVuWWRtV1MydkdTYUp4UDF0ZkVq?=
 =?utf-8?B?V3hJSm1UQ0Jqc2xqSkNXZ2ZWT05JdVBKQStUVzI5RWRwU2dvRVcybXh5cWFy?=
 =?utf-8?B?TllJSDNqVENVSExBZmVSd3g0NzJvenVsUUZVU3dpbGhISjd6WmlmYytnNEpN?=
 =?utf-8?Q?QGHOnxCgvOAwMkAbgHRHefjr/WYqcT969phCLa9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9896ff12-c5b4-421f-f9a1-08d902eb5f30
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2021 04:26:59.4616 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1IYHRUj96ZFPUGM224m5kKukwj6GivUjSaU/anOesbfoQxqSi1R6BEaAG0+PdVaFc474JX9J+PecEtTuEmLjOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7912
X-Mailman-Approved-At: Mon, 19 Apr 2021 07:07:20 +0000
Cc: linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org,
 linux-gpio@vger.kernel.org, netdev@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-renesas-soc@vger.kernel.org, linux-phy@lists.infradead.org,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-omap@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
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

RnJvbTogQWxpY2UgR3VvIDxhbGljZS5ndW9AbnhwLmNvbT4KCkluIHBhdGNoICJzb2M6IGlteDht
OiBjaGFuZ2UgdG8gdXNlIHBsYXRmb3JtIGRyaXZlciIsIGNoYW5nZSBzb2MtaW14OG0uYyB0byB1
c2UKbW9kdWxlIHBsYXRmb3JtIGRyaXZlciBhbmQgdXNlIE5WTUVNIEFQSXMgdG8gb2NvdHAgcmVn
aXN0ZXIsIHRoZSByZWFzb24gaXMgdGhhdApkaXJlY3RseSByZWFkaW5nIG9jb3RwIGVnaXN0ZXIg
Y2F1c2VzIGtleGVjIGtlcm5lbCBoYW5nIGJlY2F1c2Uga2VybmVsIHdpbGwKZGlzYWJsZSB1bnVz
ZWQgY2xrcyBhZnRlciBrZXJuZWwgYm9vdHMgdXAuIFRoaXMgcGF0Y2ggbWFrZXMgdGhlIFNvQyBk
cml2ZXIKcmVhZHkuIFRoaXMgcGF0Y2ggbWFrZXMgdGhlIFNvQyBkcml2ZXIgcmVhZHkgbGF0ZXIg
dGhhbiBiZWZvcmUsIGFuZCBjYXVzZXMgZGV2aWNlCmRlcGVuZHMgb24gc29jX2RldmljZV9tYXRj
aCgpIGZvciBpbml0aWFsaXphdGlvbiBhcmUgYWZmZWN0ZWQsIHJlc3VsdGluZyBpbgprZXJuZWwg
Ym9vdCBlcnJvci4KCkNBQU0gZHJpdmVyIGlzIG9uZSBvZiB0aGVzZSBhZmZlY3RlZCBkcml2ZXJz
LiBJdCB1c2VzIHNvY19kZXZpY2VfbWF0Y2goKSB0byBmaW5kCnRoZSBmaXJzdCBtYXRjaGluZyBl
bnRyeSBvZiBjYWFtX2lteF9zb2NfdGFibGUsIGlmIG5vbmUgb2YgdGhlbSBtYXRjaCwgdGhlIG5l
eHQKaW5zdHJ1Y3Rpb24gd2lsbCBiZSBleGVjdXRlZCB3aXRob3V0IGFueSBwcm9jZXNzaW5nIGJl
Y2F1c2UgQ0FBTSBkcml2ZXIgaXMgdXNlZApub3Qgb25seSBvbiBpLk1YIGFuZCBMUywgYnV0IGFs
c28gUFBDIGFuZCBWeWJyaWQuIFdlIGhvcGUgdGhhdApzb2NfZGV2aWNlX21hdGNoKCkgY291bGQg
c3VwcG9ydCB0byByZXR1cm4gLUVQUk9CRV9ERUZFUihvciBzb21lIG90aGVyIGVycm9yCmNvZGUs
IGUuZy4gLUVOT0RFViwgYnV0IG5vdCBOVUxMKSBpbiBjYXNlIG9mIOKAnG5vIFNvQyBkZXZpY2Ug
cmVnaXN0ZXJlZOKAnSB0byBTb0MKYnVzLiBXZSB0cmllZCBpdCBhbmQgdXBkYXRlZCBhbGwgdGhl
IGNvZGUgdGhhdCBpcyB1c2luZyBzb2NfZGV2aWNlX21hdGNoKCkKdGhyb3VnaG91dCB0aGUgdHJl
ZS4KCkFsaWNlIEd1byAoMyk6CiAgZHJpdmVyczogc29jOiBhZGQgc3VwcG9ydCBmb3Igc29jX2Rl
dmljZV9tYXRjaCByZXR1cm5pbmcgLUVQUk9CRV9ERUZFUgogIGNhYW06IGFkZCBkZWZlciBwcm9i
ZSB3aGVuIHRoZSBjYWFtIGRyaXZlciBjYW5ub3QgaWRlbnRpZnkgU29DCiAgZHJpdmVyOiB1cGRh
dGUgYWxsIHRoZSBjb2RlIHRoYXQgdXNlIHNvY19kZXZpY2VfbWF0Y2gKCiBkcml2ZXJzL2Jhc2Uv
c29jLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgNSArKysrKwogZHJpdmVycy9idXMv
dGktc3lzYy5jICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDIgKy0KIGRyaXZlcnMvY2xrL3Jl
bmVzYXMvcjhhNzc5NS1jcGctbXNzci5jICAgICAgICB8ICA0ICsrKy0KIGRyaXZlcnMvY2xrL3Jl
bmVzYXMvcmNhci1nZW4yLWNwZy5jICAgICAgICAgICB8ICAyICstCiBkcml2ZXJzL2Nsay9yZW5l
c2FzL3JjYXItZ2VuMy1jcGcuYyAgICAgICAgICAgfCAgMiArLQogZHJpdmVycy9jcnlwdG8vY2Fh
bS9jdHJsLmMgICAgICAgICAgICAgICAgICAgIHwgIDMgKysrCiBkcml2ZXJzL2RtYS9mc2wtZHBh
YTItcWRtYS9kcGFhMi1xZG1hLmMgICAgICAgfCAgNyArKysrKystCiBkcml2ZXJzL2RtYS90aS9r
My1wc2lsLmMgICAgICAgICAgICAgICAgICAgICAgfCAgMyArKysKIGRyaXZlcnMvZG1hL3RpL2sz
LXVkbWEuYyAgICAgICAgICAgICAgICAgICAgICB8ICAyICstCiBkcml2ZXJzL2dwdS9kcm0vYnJp
ZGdlL253bC1kc2kuYyAgICAgICAgICAgICAgfCAgMiArLQogZHJpdmVycy9ncHUvZHJtL21lc29u
L21lc29uX2Rydi5jICAgICAgICAgICAgIHwgIDQgKysrLQogZHJpdmVycy9ncHUvZHJtL29tYXBk
cm0vZHNzL2Rpc3BjLmMgICAgICAgICAgIHwgIDIgKy0KIGRyaXZlcnMvZ3B1L2RybS9vbWFwZHJt
L2Rzcy9kcGkuYyAgICAgICAgICAgICB8ICA0ICsrKy0KIGRyaXZlcnMvZ3B1L2RybS9vbWFwZHJt
L2Rzcy9kc2kuYyAgICAgICAgICAgICB8ICAzICsrKwogZHJpdmVycy9ncHUvZHJtL29tYXBkcm0v
ZHNzL2Rzcy5jICAgICAgICAgICAgIHwgIDMgKysrCiBkcml2ZXJzL2dwdS9kcm0vb21hcGRybS9k
c3MvaGRtaTRfY29yZS5jICAgICAgfCAgMyArKysKIGRyaXZlcnMvZ3B1L2RybS9vbWFwZHJtL2Rz
cy92ZW5jLmMgICAgICAgICAgICB8ICA0ICsrKy0KIGRyaXZlcnMvZ3B1L2RybS9vbWFwZHJtL29t
YXBfZHJ2LmMgICAgICAgICAgICB8ICAzICsrKwogZHJpdmVycy9ncHUvZHJtL3JjYXItZHUvcmNh
cl9kdV9jcnRjLmMgICAgICAgIHwgIDQgKysrLQogZHJpdmVycy9ncHUvZHJtL3JjYXItZHUvcmNh
cl9sdmRzLmMgICAgICAgICAgIHwgIDIgKy0KIGRyaXZlcnMvZ3B1L2RybS90aWRzcy90aWRzc19k
aXNwYy5jICAgICAgICAgICB8ICA0ICsrKy0KIGRyaXZlcnMvaW9tbXUvaXBtbXUtdm1zYS5jICAg
ICAgICAgICAgICAgICAgICB8ICA3ICsrKysrLS0KIGRyaXZlcnMvbWVkaWEvcGxhdGZvcm0vcmNh
ci12aW4vcmNhci1jb3JlLmMgICB8ICAyICstCiBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL3JjYXIt
dmluL3JjYXItY3NpMi5jICAgfCAgMiArLQogZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS92c3AxL3Zz
cDFfdWlmLmMgICAgICAgIHwgIDQgKysrLQogZHJpdmVycy9tbWMvaG9zdC9yZW5lc2FzX3NkaGlf
Y29yZS5jICAgICAgICAgIHwgIDIgKy0KIGRyaXZlcnMvbW1jL2hvc3QvcmVuZXNhc19zZGhpX2lu
dGVybmFsX2RtYWMuYyB8ICAyICstCiBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLW9mLWVzZGhjLmMg
ICAgICAgICAgICAgfCAyMSArKysrKysrKysrKysrKy0tLS0tCiBkcml2ZXJzL21tYy9ob3N0L3Nk
aGNpLW9tYXAuYyAgICAgICAgICAgICAgICAgfCAgMiArLQogZHJpdmVycy9tbWMvaG9zdC9zZGhj
aV9hbTY1NC5jICAgICAgICAgICAgICAgIHwgIDIgKy0KIGRyaXZlcnMvbmV0L2V0aGVybmV0L3Jl
bmVzYXMvcmF2Yl9tYWluLmMgICAgICB8ICA0ICsrKy0KIGRyaXZlcnMvbmV0L2V0aGVybmV0L3Rp
L2FtNjUtY3Bzdy1udXNzLmMgICAgICB8ICAyICstCiBkcml2ZXJzL25ldC9ldGhlcm5ldC90aS9j
cHN3LmMgICAgICAgICAgICAgICAgfCAgMiArLQogZHJpdmVycy9uZXQvZXRoZXJuZXQvdGkvY3Bz
d19uZXcuYyAgICAgICAgICAgIHwgIDIgKy0KIGRyaXZlcnMvcGh5L3RpL3BoeS1vbWFwLXVzYjIu
YyAgICAgICAgICAgICAgICB8ICA0ICsrKy0KIGRyaXZlcnMvcGluY3RybC9yZW5lc2FzL2NvcmUu
YyAgICAgICAgICAgICAgICB8ICAyICstCiBkcml2ZXJzL3BpbmN0cmwvcmVuZXNhcy9wZmMtcjhh
Nzc5MC5jICAgICAgICAgfCAgNSArKysrLQogZHJpdmVycy9waW5jdHJsL3JlbmVzYXMvcGZjLXI4
YTc3OTQuYyAgICAgICAgIHwgIDUgKysrKy0KIGRyaXZlcnMvc29jL2ZzbC9kcGlvL2RwaW8tZHJp
dmVyLmMgICAgICAgICAgICB8IDEzICsrKysrKysrLS0tLQogZHJpdmVycy9zb2MvcmVuZXNhcy9y
OGE3NzRjMC1zeXNjLmMgICAgICAgICAgIHwgIDUgKysrKy0KIGRyaXZlcnMvc29jL3JlbmVzYXMv
cjhhNzc5NS1zeXNjLmMgICAgICAgICAgICB8ICAyICstCiBkcml2ZXJzL3NvYy9yZW5lc2FzL3I4
YTc3OTkwLXN5c2MuYyAgICAgICAgICAgfCAgNSArKysrLQogZHJpdmVycy9zb2MvdGkvazMtcmlu
Z2FjYy5jICAgICAgICAgICAgICAgICAgIHwgIDIgKy0KIGRyaXZlcnMvc3RhZ2luZy9tdDc2MjEt
cGNpL3BjaS1tdDc2MjEuYyAgICAgICB8ICAyICstCiBkcml2ZXJzL3RoZXJtYWwvcmNhcl9nZW4z
X3RoZXJtYWwuYyAgICAgICAgICAgfCAgNCArKystCiBkcml2ZXJzL3RoZXJtYWwvdGktc29jLXRo
ZXJtYWwvdGktYmFuZGdhcC5jICAgfCAxMCArKysrKysrLS0KIGRyaXZlcnMvdXNiL2dhZGdldC91
ZGMvcmVuZXNhc191c2IzLmMgICAgICAgICB8ICAyICstCiBkcml2ZXJzL3VzYi9ob3N0L2VoY2kt
cGxhdGZvcm0uYyAgICAgICAgICAgICAgfCAgNCArKystCiBkcml2ZXJzL3VzYi9ob3N0L3hoY2kt
cmNhci5jICAgICAgICAgICAgICAgICAgfCAgMiArLQogZHJpdmVycy93YXRjaGRvZy9yZW5lc2Fz
X3dkdC5jICAgICAgICAgICAgICAgIHwgIDIgKy0KIDUwIGZpbGVzIGNoYW5nZWQsIDEzOSBpbnNl
cnRpb25zKCspLCA1MiBkZWxldGlvbnMoLSkKCi0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
