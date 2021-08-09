Return-Path: <SRS0=YfIy=NA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43442C4338F
	for <iommu@archiver.kernel.org>; Mon,  9 Aug 2021 08:01:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAE2D6054F
	for <iommu@archiver.kernel.org>; Mon,  9 Aug 2021 08:01:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CAE2D6054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8E331606DE;
	Mon,  9 Aug 2021 08:01:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lco3Srd5zB80; Mon,  9 Aug 2021 08:01:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 41B6E60680;
	Mon,  9 Aug 2021 08:01:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18E68C001A;
	Mon,  9 Aug 2021 08:01:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22723C000E
 for <iommu@lists.linux-foundation.org>; Mon,  9 Aug 2021 08:01:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0EBC0400C8
 for <iommu@lists.linux-foundation.org>; Mon,  9 Aug 2021 08:01:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mediatek.com header.b="JGwy9P3J";
 dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com
 header.b="G+FqQlcw"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EVEx6zoQRxSj for <iommu@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 08:00:56 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 652E2401D9
 for <iommu@lists.linux-foundation.org>; Mon,  9 Aug 2021 08:00:55 +0000 (UTC)
X-UUID: 140924844d034f5e8fc273a7d88dafef-20210809
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=XcvOaLGk1HRjq5y310SuiImxziSOynrhvclPBysCIiY=; 
 b=JGwy9P3J8UYTQynq1hPRFOIwMcNBTDqi/o7teXFFHfGcKhYgxRQ9iTVl6QL7UhnEE1JszmKEq4iFL0OHDm2+9oHb4JJtB5pMNtG676Yz2AvENAqTP2R7+nFuckuYDK5kei780nXuEFH+0JWHvFrKfb9dbX/Dothj+VL+yaPU43M=;
X-UUID: 140924844d034f5e8fc273a7d88dafef-20210809
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw01.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 392432069; Mon, 09 Aug 2021 16:00:49 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 9 Aug 2021 16:00:48 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP
 Server id
 15.2.792.15 via Frontend Transport; Mon, 9 Aug 2021 16:00:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bf7GWp2FVvb03zb0Hy5rTGScPUBu53uXJWXrMVM0p19Lm6snWKewkwV5LyaMG1eJR6B7Jn9GQyjM5lUpZDCo80D2QklqMsVnuWM7xCLmUAN/XXt8cyVINRNgOLv/YUZS08Z0mZKM78VAIZPRNeickTc9u/yBhx2ftu0Q7skXigXBZUbEbLHpg9yJovBPmMDyeOCaNp75G5m/sjbuzGxEGDaPHYt2rqkx34/40LYnNhk/EQivmIIP4AMsqu1Ig/mZ63AoQXLuLXIfE0w2ZQ/ch7MwprNxtotgn4oS4qIoq9H8YMCv+oJQLg8dHmgO+tXFF1yAEnUbTLka/14JlLgF9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcvOaLGk1HRjq5y310SuiImxziSOynrhvclPBysCIiY=;
 b=eXtfCaFpePSdCklDdZq/QyTKXBk4+7u5XkLtBdSKS9/JBJhby5pI7hfyzeHVyenZ8q8Jjhig+opVWXsewRtOsxbUHY2+EYEg8hY3w46kxD9M6YCbVfuAF1HffP6deih+KiuzbXvVqCTOhhSkmzMCSWb+QFxnUiWBcKU8YpOYgbKZn2FOwfpPjQUc5/NaTUNAREwfg4B6hc0kltSbViFykSJJuaD3Wt8WwL8oLmK29X40EF0FQtHuHEuvyAG9AxvQifYz4K1uHxRtkDmTI0uip+kMKpK6QhJzAeluX3SAwGCOSUDUM21YR/BCI4GgIuDZFn0kwzp+UV5kYtUS2YvaYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcvOaLGk1HRjq5y310SuiImxziSOynrhvclPBysCIiY=;
 b=G+FqQlcwz+ULO6WrpdhXGMIkZAvYXVa7zfKZ3wmj7HUbGDDOKw/lSTM7Cu5Zq6nW8qFzRt2UzkWid3cmSVkyTinWLs2/q7KcZl8BUPlG33gVOC2aRDrsXibv9AecH1LhxExjyYTLZh8yH3jWmuOhJ+FX2/lvUjMYE9W9tN3P59U=
Received: from HK0PR03MB3139.apcprd03.prod.outlook.com (2603:1096:203:4b::11)
 by HK0PR03MB3938.apcprd03.prod.outlook.com (2603:1096:203:9f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.10; Mon, 9 Aug
 2021 08:00:35 +0000
Received: from HK0PR03MB3139.apcprd03.prod.outlook.com
 ([fe80::7c68:5b77:53c1:50de]) by HK0PR03MB3139.apcprd03.prod.outlook.com
 ([fe80::7c68:5b77:53c1:50de%5]) with mapi id 15.20.4415.012; Mon, 9 Aug 2021
 08:00:34 +0000
From: =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
To: "dafna.hirschfeld@collabora.com" <dafna.hirschfeld@collabora.com>,
 =?utf-8?B?SXJ1aSBXYW5nICjnjovnkZ4p?= <Irui.Wang@mediatek.com>
Subject: Re: [PATCH v7 04/12] iommu/mediatek: Add device_link between the
 consumer and the larb devices
Thread-Topic: [PATCH v7 04/12] iommu/mediatek: Add device_link between the
 consumer and the larb devices
Thread-Index: AQHXhO54JLI6FpzFKkWqO43jK2lQk6tk7+WAgAXveQA=
Date: Mon, 9 Aug 2021 08:00:34 +0000
Message-ID: <1bea58ed853eab23d4af8829538ab9aa22cbd340.camel@mediatek.com>
References: <20210730025238.22456-1-yong.wu@mediatek.com>
 <20210730025238.22456-5-yong.wu@mediatek.com>
 <3f359c03-df44-2410-3172-2f17e620cada@collabora.com>
In-Reply-To: <3f359c03-df44-2410-3172-2f17e620cada@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: collabora.com; dkim=none (message not signed)
 header.d=none; collabora.com; dmarc=none action=none header.from=mediatek.com; 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f4451291-a746-4ec5-885a-08d95b0bc47d
x-ms-traffictypediagnostic: HK0PR03MB3938:
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0PR03MB393839F65113BCB2BD94048E98F69@HK0PR03MB3938.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aOLdGaQfQHbBDaLegFyQRrhQMMKaGgTGrFIX2E+Y7W2tuM0gPSl/MLBOEglqa6JHnjMauKJDQt0nQEvHJ25Ow0W+Sn05JOZKUsFdpmA+inAvubYWqVlYenSU0DTkLmjDfq25yRPId/+91s3em8BbMi9loO0Y8M9fZ2dUxZiu8V3yRT0ShWOCeSYcXH9XPyJbC8OHLFwCh3fF6EKUiwigT8lf0P5BQpxaJSgkntXypJmxC3ovf8ranGKDlOZLDo18JIOdz3WSYFClisAYXquNLugf1uCpNhzve2OMKxJGLsFYK3QfjZhvf36Toe4amjS5iROV24WPqep0k3jU0HEoCXFz+5LBHQOi21+8kpBvN9ZzEL/0ncNa7BMyHc/6EBgil/IcAK2C6a7tCoxrP6DnpNN7PxJvpt7SRNS6vX21QoW3DK9CaHM3a7alHvoS28RqaG+Caw+/bBVQt0qdwILZsG7JGbeY2nESKa9Bar4Xj3/x9TMpWf5d57FwQjTf0GRH9mi4yRovBQxhw5STO0MmmG2rEBHWBk5b1KT201cLtp5iL323qyseuB2SWbJSUiajnxebBkImlmyNoVxc3oUgiUZZpOt5p2NivUd6NtBq93CblQ+DvYgHaQ2ZNNhit/pBa0O/txIm8JN01Q1gQZ2T5gPqDaT/Sve6kzNh12mLW3QeTMQDtZwEADYkIlolD4/X6SRH0dXes0L77ME0Swf3AbnX4gOHNJ++MWMMQAhpzq8AMX1/OFqtP1aIFdDehPrdYXF5av2pCdbWG1gfvpY+IjwX+a6lZ25OGO64j7ItS0L4TtdrXoWXh2Vev6dWjDrdQB+9EhOSqAFPyIdUJbBLZdqBDKUo4Sc2V22UngpCLgY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HK0PR03MB3139.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(26005)(186003)(6506007)(122000001)(38070700005)(53546011)(85182001)(83380400001)(36756003)(86362001)(38100700002)(110136005)(4326008)(6512007)(5660300002)(966005)(7416002)(2906002)(8676002)(6636002)(6486002)(2616005)(66946007)(66556008)(64756008)(66446008)(316002)(54906003)(508600001)(76116006)(66476007)(71200400001)(8936002)(99106002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dmZIWGk4aVhSVnpRWXM4VS83bk4rOXBBOUZYU3ZvLytteFg2TCthdklCL3Rk?=
 =?utf-8?B?ZnhLRmxmS2lTZTdwbjdEL2FtaXFIaWR1eW9FaW4vNHIwY3NadXdWNXJnTm9P?=
 =?utf-8?B?V0N4THJzazlpL21hZmtxbVZhYWk4M2Qvb0kyNG5vQnUwWWZoRy9JTGg5UDJl?=
 =?utf-8?B?b0VjZERUYTRCS0NrakcxWm5hdkkwakZRNjNLdDZjcWxhbzlaZWZKelBJU3lt?=
 =?utf-8?B?YmxwKytTTm1ldElCZzV5c1ZDaVArZGRXajBrUVJkK2ZBUEgvZnhtMzFQYVFL?=
 =?utf-8?B?T055bXNjR0ZoQ3RxcHVvQ0EzTGs4cTlnNmRZcGJCOFFnRENrK1JZSlFTTk8y?=
 =?utf-8?B?M1YxVmxaTmY5VUtHUzJET3UzL1JaakZwS2kySDVqcG91dUN2MnhHcFplQ2F5?=
 =?utf-8?B?TjNOWTZkdTUvTDdFWTRXRVUyVnpndEYwZTlHU0pxSEQvRjB5Yi9XNG4rZ05h?=
 =?utf-8?B?ZjZsSUg1c0RqMnN5NjNxN0lCYkYxSDZLMW1pdFFsUit6QURnU1hCOElWT1JP?=
 =?utf-8?B?QnpSSVpSY3JGODlzdFR0ZVVzeW1PODFTcW9WYVlTVzhuSmlHSG9KKzlTdVM5?=
 =?utf-8?B?aXM5eUdtRGk2bGpvU0htRmtOaDR2ZmFiWmltSU43S2RzSm1YVFdEWVY2ODli?=
 =?utf-8?B?dlhheEwzYUMrY0s5UzVVaTNLSUp0WVlwZmFqTURKdjVYc3pHMmdLN1FWeVZQ?=
 =?utf-8?B?blV6MkdINSt0Z1pUcnFHNkhsS1JqOG01ekxHOUljNzJVeHZkcnhwY1Z0Z2hk?=
 =?utf-8?B?cUNsL2ZsM2thSXlnZ2x3SlVzRGFBdFE1VDN6d0tMVVE5TTEwTUlQSDF0MFI5?=
 =?utf-8?B?MngyTWV1MTRvdlBENDF5cmhodnNrTWExRzVxT2x2VmRybXRCQnUzRUI0MWFa?=
 =?utf-8?B?bHo3TzZKZm5WOWpNV2laU0xEa2tTd0hTeE9IWjYwSjI1SWVvcWVDYTBVVXh2?=
 =?utf-8?B?cU5GM25iaTQxMFlhVWNOUndGckJJQ25WVHhYOG5ZOHhWZEJ5VHJWeE4zeWZZ?=
 =?utf-8?B?VCtTL0hOYktFUHI3V2xDYkR3RXdXUjN4VjhMT3J4RnpheEltMEdmWEY3aVRJ?=
 =?utf-8?B?VHJvWnU1emRYVzU1R2RPVWowS1h4RVprVlFxMEttWEhlTm5MTjJvZTc2d1BB?=
 =?utf-8?B?enRHQ3lEaVJ0U1FkNkZSaUx0ZTNGOFRZQUpFNXJHOFFmT2lEaU9JMnh2Z3c0?=
 =?utf-8?B?N3lObklOYUxBaUg0c3lVVFFjUUVtNlRReXhzQmk0QTZaUUlBZEdSZlF1NW4y?=
 =?utf-8?B?eisrVG5NbTRRVlZxMExtMnZaZWtScm5tR1hhbUdyYlRBbGxTdzFVMXNOa3pp?=
 =?utf-8?B?cFJ0ZGVDczduV211TC9GUEw5bkNvTGp2bmdtZkE2R2MvUVlGcWtkdEczYkFU?=
 =?utf-8?B?WGh2UldUazBGOTZZVVlaaFg0VlQ2a1FMNU5rZnV1VXVoeDVvVytoaW1RQVRI?=
 =?utf-8?B?dmEvK2JWbVJ3cDV4U05jWk8zZkR2MXluRHFWaXVGVEp6Y1I4WGpYKzFGeWk4?=
 =?utf-8?B?bU1tV0NnU3MrZEVydm9vMHhSZ3ZYbzlGb2F1d0k0a04rNi9nSXFCMDFVS3Fi?=
 =?utf-8?B?WE1GT0gyVEZDSFF1TWZyWVhnSnNlRGFZdUFMZFY3OUsyRWQvOUs1MFgyclhY?=
 =?utf-8?B?dGRiVlFaSGtaZld6dW1Qand0Z3lTd3RRL05xVkxjMTZwN2hYVE9VZTMxZmdo?=
 =?utf-8?B?NVdaMmlpZlZFZ2hYbkcxVXJFeW5yWkwzOHJaaFZZT1ZDTDB1RittMWhKVWFp?=
 =?utf-8?Q?DGiwnjqixOM2rBPhZHXmVW61ztYax0LHkTX4dpl?=
Content-ID: <3A9BCFF786BBC44AB1A9BB11E6DB8F5A@apcprd03.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR03MB3139.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4451291-a746-4ec5-885a-08d95b0bc47d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2021 08:00:34.5696 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eNlfgnuNU3IMJ0V8DPMtRBxJ3Qf9dTsv40hElQLD89UfLWfMlHS5VlRwiXLSYrTG9A9soFGo0SMjPSchIW6YTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR03MB3938
X-MTK: N
Cc: =?utf-8?B?WGlhIEppYW5nICjmsZ/pnJ4p?= <Xia.Jiang@mediatek.com>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
 "airlied@linux.ie" <airlied@linux.ie>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 =?utf-8?B?QW50aG9ueSBIdWFuZyAo6buD5bu65ZiJKQ==?= <Anthony.Huang@mediatek.com>,
 "kernel@collabora.com" <kernel@collabora.com>,
 =?utf-8?B?WW91bGluIFBlaSAo6KO05Y+L5p6XKQ==?= <youlin.pei@mediatek.com>,
 "drinkcat@chromium.org" <drinkcat@chromium.org>,
 "krzysztof.kozlowski@canonical.com" <krzysztof.kozlowski@canonical.com>,
 "evgreen@chromium.org" <evgreen@chromium.org>,
 "eizan@chromium.org" <eizan@chromium.org>,
 "mka@chromium.org" <mka@chromium.org>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "frank-w@public-files.de" <frank-w@public-files.de>,
 "mchehab@kernel.org" <mchehab@kernel.org>,
 =?utf-8?B?WWkgS3VvICjpg63mh78p?= <Yi.Kuo@mediatek.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "hsinyi@chromium.org" <hsinyi@chromium.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 =?utf-8?B?TWluZy1GYW4gQ2hlbiAo6Zmz5piO5rGOKQ==?= <Ming-Fan.Chen@mediatek.com>,
 =?utf-8?B?VGlmZmFueSBMaW4gKOael+aFp+ePiik=?= <tiffany.lin@mediatek.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 =?utf-8?B?QW5hbiBTdW4gKOWtmeWuieWuiSk=?= <Anan.Sun@mediatek.com>,
 "acourbot@chromium.org" <acourbot@chromium.org>,
 srv_heupstream <srv_heupstream@mediatek.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "daniel@ffwll.ch" <daniel@ffwll.ch>,
 "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, 2021-08-05 at 15:22 +0200, Dafna Hirschfeld wrote:
> 
> On 30.07.21 04:52, Yong Wu wrote:
> > MediaTek IOMMU-SMI diagram is like below. all the consumer connect
> > with
> > smi-larb, then connect with smi-common.
> > 
> >          M4U
> >           |
> >      smi-common
> >           |
> >    -------------
> >    |         |    ...
> >    |         |
> > larb1     larb2
> >    |         |
> > vdec       venc
> > 
> > When the consumer works, it should enable the smi-larb's power
> > which
> > also need enable the smi-common's power firstly.
> > 
> > Thus, First of all, use the device link connect the consumer and
> > the
> > smi-larbs. then add device link between the smi-larb and smi-
> > common.
> > 
> > This patch adds device_link between the consumer and the larbs.
> > 
> > When device_link_add, I add the flag DL_FLAG_STATELESS to avoid
> > calling
> > pm_runtime_xx to keep the original status of clocks. It can avoid
> > two
> > issues:
> > 1) Display HW show fastlogo abnormally reported in [1]. At the
> > beggining,
> > all the clocks are enabled before entering kernel, but the clocks
> > for
> > display HW(always in larb0) will be gated after clk_enable and
> > clk_disable
> > called from device_link_add(->pm_runtime_resume) and rpm_idle. The
> > clock
> > operation happened before display driver probe. At that time, the
> > display
> > HW will be abnormal.
> > 
> > 2) A deadlock issue reported in [2]. Use DL_FLAG_STATELESS to skip
> > pm_runtime_xx to avoid the deadlock.
> > 
> > Corresponding, DL_FLAG_AUTOREMOVE_CONSUMER can't be added, then
> > device_link_removed should be added explicitly.
> > 
> > [1] 
> > https://lore.kernel.org/linux-mediatek/1564213888.22908.4.camel@mhfsdcap03/
> > [2] https://lore.kernel.org/patchwork/patch/1086569/
> > 
> > Suggested-by: Tomasz Figa <tfiga@chromium.org>
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > Tested-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com> # on
> > mt8173
> 
> Hi, unfortunately, I have to take back the Tested-by tag.

sorry for inconvenience you.

(and sorry for reply late, there is something wrong about my local mail
server.)

> I am now testing the mtk-vcodec with latest kernel + patches sent
> from the mailing list:
> 
https://gitlab.collabora.com/eballetbo/linux/-/commits/topic/chromeos/chromeos-5.14
> which includes this patchset.
> 
> On chromeos I open a video conference with googl-meet which cause the
> mtk-vcodec vp8 encoder to run.
> If I kill it with `killall -9 chrome` I get some page fault messages
> from the iommu:

Does the "git bisect" point to this patch?

If you don't kill it, Does it also have these error below?

I don't know what happen about "killall -9 chrome', Does it cause
freeing some buffer?

> 
> [  837.255952] mtk-iommu 10205000.iommu: fault type=0x5
> iova=0xfcff0001 pa=0x0 larb=0 port=0 layer=1 read

This means "larb0 port0" translation fault. 

If I am not wrong, you work at mt8173, from [0], this is DISP_OVL0.

May be "killall -9 chrome" free the buffer(iova:0xfcff0000) that
DISP_OVL is accessing, then iommu complain it is not a valid iova.

[0] 
https://elixir.bootlin.com/linux/v5.14-rc1/source/include/dt-bindings/memory/mt8173-larb-port.h#L19

> [  837.265696] mtk-iommu 10205000.iommu: fault type=0x5
> iova=0xfcff0001 pa=0x0 larb=0 port=0 layer=1 read
> [  837.282367] mtk-iommu 10205000.iommu: fault type=0x5
> iova=0xfcff0001 pa=0x0 larb=0 port=0 layer=1 read
> [  837.299028] mtk-iommu 10205000.iommu: fault type=0x5
> iova=0xfcff0001 pa=0x0 larb=0 port=0 layer=1 read
> [  837.315683] mtk-iommu 10205000.iommu: fault type=0x5
> iova=0xfcff0001 pa=0x0 larb=0 port=0 layer=1 read
> [  837.332345] mtk-iommu 10205000.iommu: fault type=0x5
> iova=0xfcff0001 pa=0x0 larb=0 port=0 layer=1 read
> [  837.349004] mtk-iommu 10205000.iommu: fault type=0x5
> iova=0xfcff0001 pa=0x0 larb=0 port=0 layer=1 read
> [  837.365665] mtk-iommu 10205000.iommu: fault type=0x5
> iova=0xfcff0001 pa=0x0 larb=0 port=0 layer=1 read
> [  837.382329] mtk-iommu 10205000.iommu: fault type=0x5
> iova=0xfcff0001 pa=0x0 larb=0 port=0 layer=1 read
> [  837.400002] mtk-iommu 10205000.iommu: fault type=0x5
> iova=0xfcff0001 pa=0x0 larb=0 port=0 layer=1 read
> 
> In addition, running the encoder tests from the shell:
> 
> sudo --user=#1000 /usr/local/libexec/chrome-binary-
> tests/video_encode_accelerator_tests --
> gtest_filter=VideoEncoderTest.FlushAtEndOfStream_Multiple*  
> --codec=vp8
> /usr/local/share/tast/data/chromiumos/tast/local/bundles/cros/video/d
> ata/tulip2-320x180.yuv --disable_validator
> 
> At some point it fails with the error
> 
> [ 5472.161821] [MTK_V4L2][ERROR] mtk_vcodec_wait_for_done_ctx:32:
> [290] ctx->type=1, cmd=1, wait_event_interruptible_timeout
> time=1000ms out 0 0!
> [ 5472.174678] [MTK_VCODEC][ERROR][290]: vp8_enc_encode_frame()
> irq_status=0 failed
> [ 5472.182687] [MTK_V4L2][ERROR] mtk_venc_worker:1239: venc_if_encode
> failed=-5

+our venc guy Irui.

This looks VENC HW don't start to work. Does this caused by this
patchset?  this patchset only change the flow of power.

I guess we should check if the power/clock for venc here is enable or
not?

> 
> 
> If you have any idea of what might be the problem or how to debug?
> 
> Thanks,
> Dafna
> 
> > --
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
