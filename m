Return-Path: <SRS0=1qmC=NX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE38C432BE
	for <iommu@archiver.kernel.org>; Wed,  1 Sep 2021 13:35:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB93860200
	for <iommu@archiver.kernel.org>; Wed,  1 Sep 2021 13:35:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DB93860200
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A4DA082733;
	Wed,  1 Sep 2021 13:35:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YwnkZqVNreQr; Wed,  1 Sep 2021 13:35:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5213E8274D;
	Wed,  1 Sep 2021 13:35:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 29F99C001A;
	Wed,  1 Sep 2021 13:35:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16413C000E
 for <iommu@lists.linux-foundation.org>; Wed,  1 Sep 2021 13:35:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E77A4402EC
 for <iommu@lists.linux-foundation.org>; Wed,  1 Sep 2021 13:35:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mediatek.com header.b="T71fK+gx";
 dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com
 header.b="kyNqP5Vh"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vdjkjCo4tR2V for <iommu@lists.linux-foundation.org>;
 Wed,  1 Sep 2021 13:34:56 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6FC4840228
 for <iommu@lists.linux-foundation.org>; Wed,  1 Sep 2021 13:34:55 +0000 (UTC)
X-UUID: 97da787bd9ab48a08dfcfac729353af7-20210901
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=s8eianChBOl0tNeanAZCFNSSqNz+AJ1F38ejQ/LieO8=; 
 b=T71fK+gx2GLpT/M6b5beH/dCPD5W6I6uvgasCZsj1NTCy5MykvneLz0n2unStYtixu0FiZPx7Oma5mFR1ft4oeeYaXfoZ+gqbqoCkvcKPwzYNFtewFuTjKDW0HXaGbPbSnQ/3ysCV8SA23EV4f+ZUXtACleq1s1BYb92LVSqAmY=;
X-UUID: 97da787bd9ab48a08dfcfac729353af7-20210901
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1008223032; Wed, 01 Sep 2021 21:34:49 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 1 Sep 2021 21:34:48 +0800
Received: from APC01-PU1-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP
 Server id
 15.2.792.15 via Frontend Transport; Wed, 1 Sep 2021 21:34:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IinmNlIyUDuxfAGrvAIVJubFsA3GmkFDNDf0AnqsgA/ztvptR/eM/k2sHcRkloQLl4PKtsDqE1djPuNkzIH5BLlWRyDkWHCtWG+4znaU3+d5GSPT0W9g7/87/sVIzFJ33sYSWAaEGuq2jx7xlsX9KEUhEmIT6nZQSvy8HOtCadws8WJER/fac3XZzB0MF+toLzHpcJdRVy376llZBp4oDcEL5EQ9JpUonhSl/fbHIRj1pKMlBL/7o4ruYuDybH+PzyjEV5+lbndrMhq8iq/4HOPbd/v/LTjKNz4m1WhwfoMaQLksfrL5ofuawIhQmFxwsVTjOMSoh5YxM8LSlnIULA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=s8eianChBOl0tNeanAZCFNSSqNz+AJ1F38ejQ/LieO8=;
 b=PypzHr909TH6eYk0SCS24kf7aJrxnfl2UFkDtri3ioW+9fA03Md3toAxwTKud60zkpaxVI+qQnukuJjvy4t0SJ99D/+lyUdX+c6ncfzqk4nE0T4fu+S1+BU+x8uMlsBPIgpLbkwa6ZNyzeo/31PZAjMucaWp77/YMtt3+xN/yfm9rhE1ZStQ+M5PW3Ny4DgnvuCVG8cGiWZlvw4/UfsSeuUr9NCz7jDORqndY8a8HS2ISfSX6+AxOmlBO3vQVYiM3+07y/7RCw4Fvlw0UVIRhZyUWIAYEe1DccG61VtZrqLlBaLyoWfgJv7g4Ce7VUQ0mV7siRqRDqMbOiCkivJP8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8eianChBOl0tNeanAZCFNSSqNz+AJ1F38ejQ/LieO8=;
 b=kyNqP5VhWzFn/wQtiskHMivAr0u3m6Y2FFFZ/r7tl0UO99nrvoco7wIqpbXT7PRJya4LZdEP9Y7tHrOt4ojB7omNUKG7A77JMw3nCE9O7x5Xjz66DdzsHW44V5/JwBIMpTXwQQt79MhmlQB/UASb0kxecym7C+nEdbvGHkqupbQ=
Received: from HK0PR03MB3139.apcprd03.prod.outlook.com (2603:1096:203:4b::11)
 by HK0PR03MB3892.apcprd03.prod.outlook.com (2603:1096:203:7c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.14; Wed, 1 Sep
 2021 12:10:40 +0000
Received: from HK0PR03MB3139.apcprd03.prod.outlook.com
 ([fe80::6595:af4e:bda9:801e]) by HK0PR03MB3139.apcprd03.prod.outlook.com
 ([fe80::6595:af4e:bda9:801e%6]) with mapi id 15.20.4478.019; Wed, 1 Sep 2021
 12:10:40 +0000
From: =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
To: "hsinyi@chromium.org" <hsinyi@chromium.org>
Subject: Re: [PATCH v2 11/29] iommu/mediatek: Always pm_runtime_get while tlb
 flush
Thread-Topic: [PATCH v2 11/29] iommu/mediatek: Always pm_runtime_get while tlb
 flush
Thread-Index: AQHXkBCJOXgjCO+qmEuZNYVz7PKI+auCTgcAgAzmkAA=
Date: Wed, 1 Sep 2021 12:10:39 +0000
Message-ID: <e3d8139174e659c07a606122d4a5402ee5e8adca.camel@mediatek.com>
References: <20210813065324.29220-1-yong.wu@mediatek.com>
 <20210813065324.29220-12-yong.wu@mediatek.com>
 <CAJMQK-hkufqh2vaEKcuO+k0v2SzpCHcyZuEqrvJ__rrAek2P0A@mail.gmail.com>
In-Reply-To: <CAJMQK-hkufqh2vaEKcuO+k0v2SzpCHcyZuEqrvJ__rrAek2P0A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d4730a67-5538-4913-a6a7-08d96d4183c6
x-ms-traffictypediagnostic: HK0PR03MB3892:
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0PR03MB3892C3DEFC6E2C4211A1693198CD9@HK0PR03MB3892.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PH0rX98zsjN+Pi7PdQYlnWg/PJnaZCreQpscloZS/YujdCptzfy+4tBWAq+FFIne9IzrZa7wdzuyKdWfkxkX/EZ8AcFok6rNki5R8LCPyw58W0TIXfp8eXneoYIbTSK5TFlJ+dYYND96SzcYS6j8EhvNBEiBMog45PskkCHRJLfNDoPfcryyenWOWSQPt4IGXV076tMtZAPmnL2dnVkmtgZIgFNLe22xAeJ+eO9+JRLOSmdDTOHRz269MZhaBR8dg8PCNucwQhCcKx7M1A+Wzjt9RSLZRHDP8xVjjYNtvw0KKptNoZGiZRccsrkqJ4pIFUJRNC9XsX8pBEmZSInkj85Uh99T7IzNAbUJYoGpbnqR8YqT5xBX6Rjm1U4je75Tmc2lhrfcidy9a/Vlkt1Oxtmub89bNvzGYDs4YGbaEiBDq/PLsMlrItQe1wzCbrAJuo+g/PZRYqnvAK2v//CL4mfcOGxYhQdwhTDs1fK19sviGUqW9yUhDlarYM29R4+uPIxLMYO5qCDtdQ1PPz3pgwUCTyrFVHLhMcKas3sZn7d2vzu7xkHYj+kTiBlX/RaVBTMQwVwDWb0bTwhpdeZ3hcUd5KBNuJgY4vd4nAFipDqsleDHkdi7kwTEKAfoTSr0jOKYbvh/85b2D7zUH3Tf3JRQNWKHrd7JOVVUj+KxyFHhGlVDpwenuXKgJNAn/rZ8/U363ri58lB/ElVt/pHvRTFVRrGSZXxaEWa2naI58Qk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HK0PR03MB3139.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(366004)(376002)(39840400004)(38100700002)(6512007)(6486002)(122000001)(8936002)(186003)(2616005)(8676002)(5660300002)(86362001)(53546011)(54906003)(6506007)(36756003)(38070700005)(316002)(85182001)(66946007)(478600001)(71200400001)(2906002)(4326008)(7416002)(66476007)(66446008)(64756008)(66556008)(76116006)(91956017)(6916009)(83380400001)(26005)(99106002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1I3My9aOGsrL054MXEvZkhBa3dPM2RGdFlmU2VtNnBKb3ozNWVERThENjZJ?=
 =?utf-8?B?Ni9mU1VwRVFHMUgzS1ErZ3QxVnZ2dmVIc3hCYjlMTmk5VzBMR3VJTUM1MjBa?=
 =?utf-8?B?K3RDTk5ZT1NZc1lvQ2hiRWZGQmtHR2xDQmt0UUdUMGVPVStJTHB1Q1FRMXIw?=
 =?utf-8?B?bFA5ZXRLaDZiOWNlWXkzZmxNWm10QjA5eHBFdm12UnZyMHMzTWtUTkVlMUNR?=
 =?utf-8?B?K001OTVvTEJ1K3JlWDkzQ0NVZ2IwaVptWTJ6dkxXL1dUS003bHZsT1lQbTZQ?=
 =?utf-8?B?V0J4OGw5RXFMMklHZkhidUZXdEJTSTA2ZUFYSmtmVXBnR2F4dXZ6cFJuTEdk?=
 =?utf-8?B?bEFweHljZ09sWHVYSEtLOTNzVkwwaGV4RGRGSURCTUdrdU1IUkZqUW0rSk1t?=
 =?utf-8?B?SEtHZ0JnKzBKSzJqWjFDN2dUTlZaU08zWDdadVoxKzJOWjlvek0wSUwxVlBF?=
 =?utf-8?B?MXIyUWM4VXBINFdWV3NMODdjendDUHFCdTFWNmlMKzZyUEQ1dU16U29oM1NJ?=
 =?utf-8?B?UXFTSHAyUXZQVXd6dnNwMis1YVNnNmhrM04xaHpFZVNacWp6VGdHZ1FPaDhn?=
 =?utf-8?B?SFNtOGlZWWhuc0hWM3haZGN3OWU0OWp1OVFVbDNVM2VuUlJkSWw0NnpQR2Fm?=
 =?utf-8?B?VHVKNVlVajBpN0h0SEFGb2NsQllFV0lBVEpLc2RvbDhldE5sNG1LOG13T1h5?=
 =?utf-8?B?S3BEQmNsdHZiT3R2SEVLRGJObzlVZHZJM0pjS2xEYk1BN3orU0JNM0p3cjFU?=
 =?utf-8?B?MS9UWTBaaTRNSWJQOGhKZ2M4MU1MNHhNM0srZ3VObzdCQTZmai9HU1NlbGtI?=
 =?utf-8?B?V1c4bStQVWVlcFVPbVFnbjJYUUZMQXd3c3FYNGRkWThDVC9oWFZMWndiTUJ1?=
 =?utf-8?B?T200ZGZZRUZ5cFRNQ2MwYmZ3ZWVwQWJ2UUJvNUc3K2tMNUdDS3lxK05MSUF1?=
 =?utf-8?B?R2JNSXJNUW40eTltRWFPRjZNT3Z1ck9jTEs5V3dYajZ2R0h1eEF0aFpwSlM3?=
 =?utf-8?B?V0dkcTdDV05UL2k0eG9NSS9CbFhrMGVEZFBSR3loMDZMUkxUYTJ1bmdFUkhO?=
 =?utf-8?B?WTlrc2ovU3FwL2xlUmpDTXlJOHZjMGlldzl1bHZnUkxjeDMzVDdvZTMwaHBs?=
 =?utf-8?B?YU9uSlJJQWdzQWtnM3o1bkZGdW1tYUFIcFd4dDNTaDZ3akFCUDE0ZHgrUEJZ?=
 =?utf-8?B?L25FbmNtSW13R3pBODAzQjJtSEVJQ2lJQ1JlRjM2eG5vZVh6SmZNMHdwUnZC?=
 =?utf-8?B?RHZUTXpkVlZiNmthdWhJK0ZQQ2R4UlBrN3hPN0dEamtQOFRRcUw5U3ZhSjJN?=
 =?utf-8?B?OENOeW1GTjBmdFZmeFBiK05KYmhSbkd0U09CWStIMEhzaFlBN3VxVy82akV0?=
 =?utf-8?B?YUFGSjNISW9MOWR3T21NNHo3TVNYWG1MVUVzNFROMlJSRk84TjFkc05wWXFk?=
 =?utf-8?B?MHRTTmppd1M3c3YzaFVuVzU3bmVXUWF3aEhhc21JN0ZjalZ1WUluU1VlOVY1?=
 =?utf-8?B?Y3l5ZmNnZWJhRURZZDRMcEl4d1RYRmpmcnpDSVFNSk5seUFhY3BHL3hYRFpU?=
 =?utf-8?B?bktMeGREcXVLWVViMTlHWEZha1FhMms3dFlZdXp0OHdTcjl1TWV3UzV5SXNJ?=
 =?utf-8?B?T3pkYlZhem1OekNBVkRjSk1FTzlQcElHT3lHbDZxekIyMmxtL3RFeGplWU5y?=
 =?utf-8?B?TmtPaGtkSTlFd1BZTTFadEs1UDM5UkFaVnB3N3VFZmFnSE9TMnlIQzUxbTRi?=
 =?utf-8?Q?8sNKWS5QYqE7TFbfWtNV+JPNW36FBvPSEKvgtG7?=
Content-ID: <76A6BDE1AF302C4498A0BD862B70BA52@apcprd03.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR03MB3139.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4730a67-5538-4913-a6a7-08d96d4183c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2021 12:10:39.5344 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R6MEKiIJsf+3CmBQlZgtxzZOQDeIXdjJF7m4Swxj1DzZ4XNUYq+X4dA+Ty4aCXoB0QvUNejFOvdUIZ5OWaa0yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR03MB3892
X-MTK: N
Cc: =?utf-8?B?WW91bGluIFBlaSAo6KO05Y+L5p6XKQ==?= <youlin.pei@mediatek.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "drinkcat@chromium.org" <drinkcat@chromium.org>,
 srv_heupstream <srv_heupstream@mediatek.com>,
 =?utf-8?B?Q2hhbyBIYW8gKOmDnei2hSk=?= <Chao.Hao@mediatek.com>,
 "will@kernel.org" <will@kernel.org>,
 "krzysztof.kozlowski@canonical.com" <krzysztof.kozlowski@canonical.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "evgreen@chromium.org" <evgreen@chromium.org>,
 "tfiga@google.com" <tfiga@google.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 =?utf-8?B?QW5hbiBTdW4gKOWtmeWuieWuiSk=?= <Anan.Sun@mediatek.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Tue, 2021-08-24 at 15:10 +0800, Hsin-Yi Wang wrote:
> On Fri, Aug 13, 2021 at 2:57 PM Yong Wu <yong.wu@mediatek.com> wrote:
> > 
> > Prepare for 2 HWs that sharing pgtable in different power-domains.
> > 
> > The previous SoC don't have PM. Only mt8192 has power-domain,
> > and it is display's power-domain which nearly always is enabled.
> > 
> > When there are 2 M4U HWs, it may has problem.
> > In this function, we get the pm_status via the m4u dev, but it
> > don't
> > reflect the real power-domain status of the HW since there may be
> > other
> > HW also use that power-domain.
> > 
> > Currently we could not get the real power-domain status, thus
> > always
> > pm_runtime_get here.
> > 
> > Prepare for mt8195, thus, no need fix tags here.
> > 
> > This patch may drop the performance, we expect the user could
> > pm_runtime_get_sync before dma_alloc_attrs which need tlb ops.
> 
> Can you check if there are existing users that need to add this
> change?

The issue may exist in our most users. Our users mainly are in v4l2.
normally their flow like this:
a) VIDIOC_REQBUFS: call dma_alloc_attrs or dma_buf_map_attachment.
b) VIDIOC_STREAMON. 
c) VIDIOC_QBUF: device_run: pm_runtime_get_sync.

Requesting they call pm_runtime_get before dma_alloc_attrs looks not
reasonable. It seems that they should not care about this.

This patch mainly make sure the flow is right. Locally I have a TODO to
try get the real power-domain status here, the sample code like below:

static struct notifier_block mtk_penpd_notifier;

/* Register the genpd notifier. */
mtk_penpd_notifier.notifier_call = mtk_iommu_pd_callback;
ret = dev_pm_genpd_add_notifier(dev, &mtk_penpd_notifier);

/* Then get the real power domain status in the notifier */
 static int mtk_iommu_pd_callback(struct notifier_block *nb,
                        unsigned long flags, void *data) 
 {
       if (flags == GENPD_NOTIFY_ON)
           /* the real power domain is power on */
       else if (flags == GENPD_NOTIFY_PRE_OFF)
           /* the real power domain are going to power off. Take it as
power off.
            * Skip the tlb ops after receivice this flag.
            */
 }
 
 How about this? or any other suggestion to get the real power-domain
rather than the iommu device's power domain status.
 Thanks.

> 
> 
> > 
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> 
> <snip>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
