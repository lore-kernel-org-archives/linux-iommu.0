Return-Path: <SRS0=qbNH=NK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D21C4338F
	for <iommu@archiver.kernel.org>; Thu, 19 Aug 2021 05:35:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01A0361106
	for <iommu@archiver.kernel.org>; Thu, 19 Aug 2021 05:35:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 01A0361106
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B91E5405D2;
	Thu, 19 Aug 2021 05:35:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NN0PPGBDPjsW; Thu, 19 Aug 2021 05:35:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4B56A402A6;
	Thu, 19 Aug 2021 05:35:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 09FBBC001A;
	Thu, 19 Aug 2021 05:35:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5E74BC000E
 for <iommu@lists.linux-foundation.org>; Thu, 19 Aug 2021 05:35:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 52397401E3
 for <iommu@lists.linux-foundation.org>; Thu, 19 Aug 2021 05:35:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mediatek.com header.b="Y8Vwpj/g";
 dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com
 header.b="TAI8Z448"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s9ViWNap3OWI for <iommu@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 05:34:57 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 89A0940183
 for <iommu@lists.linux-foundation.org>; Thu, 19 Aug 2021 05:34:56 +0000 (UTC)
X-UUID: 84bc1639523c4645bacce2ecfc530a5f-20210819
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=m9bp4O6+k9Tk1a0NJEL/0pD/rptC2O9OYRXyH59LgPw=; 
 b=Y8Vwpj/ggPH5K38W7cSFBsiBxj8STgB98XJxMPadVUR7KXlM+sGQ0Ot3RlVbHxyEjOV4qOG4TVWwEuwKBRAnCde6r+LNQSO004Q8Q8olpyKSHXC57KGXemny0ONNO7n9L6LRmaoZrKdVquqA5RMFzyXWbI4kr0lEkOkHKzq9Xd4=;
X-UUID: 84bc1639523c4645bacce2ecfc530a5f-20210819
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by
 mailgw02.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 2073319112; Thu, 19 Aug 2021 13:34:49 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 19 Aug 2021 13:34:48 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP
 Server id
 15.2.792.15 via Frontend Transport; Thu, 19 Aug 2021 13:34:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qx7FsEpcJz6HtX4B+l2V8QSiaAk6rIT2snVz0pueT4WlXI/lcDjtCWvUNyjg52GBj5/UEmFiVU5cvz9D91NOU+afccomWGbxZGjFl+I0Up4IsXPtgUNzEzptZnkJd+si/ll2hkdWq1JtxYCSUiXeLtMijYqKUg52Mf1nw8OJWlRbxIT4IXsPInzsLy/fYb0sW2MZsy5HpMrOlyigBHqYAQBWyQYteBJqWnM/iUEl1AKT+8F7uqkYeEY2mWBcNlLa8bU2WGVv4cP0PcjH2gESMnzdSuKCyygJWAcsScShck6MDIXbqr0MTNV9vANu7JuEQVRrFhwWNJ0D/Dk0CozEzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9bp4O6+k9Tk1a0NJEL/0pD/rptC2O9OYRXyH59LgPw=;
 b=B9u7Iq0LwhVkZmtKDMXeNoZPaBg+S425LhqE4RxYk3S+iw8XGa7pzDS8p4NAV6ksb9crj7KInT4woVBZf1FJifDL4xAVwVgE2yW8SyQIJhwPlLzNQ4do5bOlHltAKHYccXqoGiUFsyhegHFj8AN2u9z+WKMG6+dBaiYSC0L9mERNBI+zxzgzaA0y3jC6fPn468XM5T1+smgBtgROS5F9/ZudajH2v8uU+TpWGv09s899oLBV/5HgJs6Ku+Ln/Owa+vG2aHdRI/KnJ/iNYpk90q3oGik5Vs7GNlNgELd55wcDEuxLaKroaLWcCJKsJ8SQJPZbA57KUUYdf2TNhbngEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9bp4O6+k9Tk1a0NJEL/0pD/rptC2O9OYRXyH59LgPw=;
 b=TAI8Z448en9IoXU6Vpj1OQviLVDa6+M2jxQ6eOw/hUdjCa6TKm6zmBywxukq2W5vNIZ88Z8k4lvNwM1fG01QQJNPSvhAqHtpcBuu9f5puAiCTNjshkdAwjG9HxDNC+MTxWCXFRsHbjbIigBuaxBm1bB/EOvx7pEwmG5s1cTw34s=
Received: from HK0PR03MB3139.apcprd03.prod.outlook.com (2603:1096:203:4b::11)
 by HK2PR0302MB2499.apcprd03.prod.outlook.com (2603:1096:202:3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.15; Thu, 19 Aug
 2021 05:34:34 +0000
Received: from HK0PR03MB3139.apcprd03.prod.outlook.com
 ([fe80::9108:efd1:31ac:c6b0]) by HK0PR03MB3139.apcprd03.prod.outlook.com
 ([fe80::9108:efd1:31ac:c6b0%7]) with mapi id 15.20.4436.018; Thu, 19 Aug 2021
 05:34:34 +0000
From: =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
To: "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "krzysztof.kozlowski@canonical.com" <krzysztof.kozlowski@canonical.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH v3 00/13] MT8195 SMI support
Thread-Topic: [PATCH v3 00/13] MT8195 SMI support
Thread-Index: AQHXjb8Hll+XizX+WEmkps1CcJVtHKt5x2YAgACU4IA=
Date: Thu, 19 Aug 2021 05:34:34 +0000
Message-ID: <5f4c25b27f347a1ae0e2941ab3e3584730a9970a.camel@mediatek.com>
References: <20210810080859.29511-1-yong.wu@mediatek.com>
 <1a160afd-ceeb-04a3-8213-fe781ec18e30@canonical.com>
In-Reply-To: <1a160afd-ceeb-04a3-8213-fe781ec18e30@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fbc40bb0-fe2f-4c25-b69c-08d962d3071d
x-ms-traffictypediagnostic: HK2PR0302MB2499:
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK2PR0302MB24991E45028B5617BF5557D598C09@HK2PR0302MB2499.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sydXY7e5t8B/F7mHOhSUynyn5v+h+XGNj4xvaLmwjtGNUI6TDfyGGZxhue+iaBjP7XhAIQZtXQrPcP4BT+EWmaWpLCgEls+thwuVGRXjTNSNbKLAHl5V2wcK0Tr2N7naRkeiK1bK9Z1VdOMwrKosh8Fdjfiy+3/RqXLH8mtXNbd2ujw3I40OVECqzKYBKPlVHn9Wj+/WpLbRorOjgq4RXNl1t8K2G0j8bY5Vp37un3zBtRabkar8/Y+ENirGCSZUZ3jRU+KaPZ0E1/gq1C6gSRiJ8KGykfJZzUYigLos7xWbSddq3jlndfVO9mnY8pv+dzLuqZ5fVrVU7wlOrhsDsPVm1vy6sMbswaDCVBRWdk8UhhevpLexjhX7tghMvF14ZEiulBw27dLjWXYV0wVMoaW+c5B6dG6c9kJpHezeD2DmHGdQDQ4rhbCUhv9tM0bYom2tOwqsakjqzF4i1baO4A5LQM5+k2FwcH+vgol495+pnlaMietj48V9dskB++AKXHoHhvCKYRNow1dGwEQCkYaGS3LkNFXja+byGufibxNARinWo3xt6DT9k0Na+xj5ycQ3HMrPe/5tUet9xwKYz1a7VK1Xi5c034SvTRZXr30/PDqQx2QuQtOdXcJrKzFlUBJONa1BrZOwO7uP2M3P2bxyJcbJhtAavKmgSPnr3aacYXwcuZHXiIy8qCH4tB+2iv62DsxHpyV8Tzcn3sVLjDtP5OcopubOjFlE9RGOJ38=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HK0PR03MB3139.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(6506007)(8936002)(4326008)(36756003)(5660300002)(7416002)(64756008)(26005)(8676002)(110136005)(316002)(2906002)(186003)(38100700002)(6512007)(76116006)(53546011)(2616005)(85182001)(6486002)(71200400001)(54906003)(122000001)(508600001)(83380400001)(38070700005)(66556008)(66476007)(66446008)(66946007)(99106002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZE1KSW00dzAweG4rOFArTkxtYklEUVdrM3hJTmFZOGljQWxjdHJPcVhOU0hL?=
 =?utf-8?B?dHlxZnU5TnpCVm5RNStBYkJKWk9CUzl6VGRrRVFKUVdvcC9yYXNFam1SNkxH?=
 =?utf-8?B?VWJ5MzNnanlmZ2wya1ZkMzdDZFA2NzlybUFWSGt6eHJhcW5sQjYwdzQ1Tk9K?=
 =?utf-8?B?QWJraTNrVGxuUjJtRUQ4amNTNWIzWkNRSklGemRpdWtsVUlOM090b0lJZ2lJ?=
 =?utf-8?B?N1F4bWZCMEhIdWlFaHRtWEJRbFhpVkJpaWhhNUY0eUhnVXhtYnZBK1g5a3V0?=
 =?utf-8?B?SU1yamY0N3Z5UXVqU3JmdXFSSHFkbnlwQmxyZWZKTkhVYnhtamR4a2hmMG1J?=
 =?utf-8?B?bVltUUZHemNtMkVxMHhNVzdpWGRCaHc1R2dSYlIrZENPZk9ZczMzUVlGcDM2?=
 =?utf-8?B?V0tGYmpyb1NCaStvNGRFUGpTelJKWUtVR2N3emJqTXBoRTBKbm9XRFJYRDRz?=
 =?utf-8?B?RmNMWHVXcHRkT1I1d2o1Q2RQUDYrMEpqWXNmOERHTHlJT3kwN1pwbkxHaW83?=
 =?utf-8?B?V3lGZXJmMU1YYUdwa21KZ3hRUEx5T1AvdEkxS2J1dkJxSFY3dE5zTmZGbEZC?=
 =?utf-8?B?TG1NQW1tS2VTODdSZGs4aVpDd1VCcDVSd1BYNC9GMFczYUR3N3ozSUgrNUlJ?=
 =?utf-8?B?d28yMnBQb1pxQXBqcTIxeDlDK2JTcUxLcjlPWjU4bXVuZER3YmRVMnRpSVpK?=
 =?utf-8?B?V2RqU29MQmk3WWptaXJSV3gzdUZRejh2SGw5ZUNNNHVGL3B2SnI4dExZeGFj?=
 =?utf-8?B?azhhWGVsVW5LdEFOVHBISVY5WG1qYlYxWHhNVlRrUDZ0UG1IWkxDMnVGeldB?=
 =?utf-8?B?VGYxZ2VzQ3F5SXVDVVN0TGk5QmF3T2pwSjE4c3ZabjJqTEc4Zi9MUFhPeGF4?=
 =?utf-8?B?N1pITUZ3amJKQUp5RVJmWStlZktVcEJqdjdveXVMR2pQRnkwYmsvOUpTMkdk?=
 =?utf-8?B?TnB2OVNJUkJWbUg1ZHBmMjRhUTBtQVMrTnpWRCtrZGtIVVdLaGh0UGwxN1Ra?=
 =?utf-8?B?V0NScDFKZGdaTnNpNmJoUnUwWnZYWCtoZU5SQVk0SHBGeXdMV1Ftd0NTKytC?=
 =?utf-8?B?djNoVDIwRnNrbFVLaVlnck96UWxIc1krZjNmVSt6TjNFUVhadnlsVHRxY2w2?=
 =?utf-8?B?WitpMmE4azlyZmpUR1hEaWdYQUNJbE9TWGQvL1RNUi85djdJcGwrU05raUdF?=
 =?utf-8?B?ZnM2RHJ0YWE2WmszYkhJMDhIcnlWK0MxQndJWnNIZjd2UUFxVUdtTXcxYXN1?=
 =?utf-8?B?WG5XVnFoaG5qYWVJMFhZMXc1KzFuTG5aRkRCL2lTMHVkUURKNzdCYWJTVXE4?=
 =?utf-8?B?UnFQUkU5QnhwbUREMTMrMVhFQmZrQUwzZUJKakZVY0g3WDRjL1FrdStsMUM1?=
 =?utf-8?B?L0pxWG5IblN0dkdoRjVhRjVTK0R0d1NvZFRLa05VUUN0eUljVG84YUVDMGZx?=
 =?utf-8?B?R2dyLzZ0S3AxS0JIVys5aVVieUt1WFlxdE8vdno2cEFxOTRUUTNnWGU1MzU3?=
 =?utf-8?B?TUR6Q1BoTXNiTVZaWjNVN0RxYTU2Yll0WnV2VWI0QW5MQkc1M01XZEVnNCth?=
 =?utf-8?B?QWJtbUhidWpYTHg1aWdaY3JJam9HRjdpaktTdG9DVmUwVGh2Y3BUaW5rVHBo?=
 =?utf-8?B?UUZjeG85dWcvMENGeFd6VDMvSEpLbTJBYVNhOEljRE1uUDBsSWNDRnZHL0kr?=
 =?utf-8?B?Uzk0a1l0Y0lQY0NiY2gwQmlWZ1pQQlE4eks0R0o4UEFYRnphSEd0bVUxVGF5?=
 =?utf-8?Q?qIFxWq2sCrJRtvvC+ZxUKKfFriLP1dZCQ7Ke/gX?=
Content-ID: <3F805D9607951246BE421B3EF4D3E1A1@apcprd03.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR03MB3139.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc40bb0-fe2f-4c25-b69c-08d962d3071d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2021 05:34:34.5915 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kxegxedq2MzOIRd7FYu7LDx5ENlqBQ7ybOrRNzFswpOLBj1Ce6XqadWt6FLbgxzPOLjDKhN2I+iT9gOvFNyUaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR0302MB2499
X-MTK: N
Cc: =?utf-8?B?WW91bGluIFBlaSAo6KO05Y+L5p6XKQ==?= <youlin.pei@mediatek.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 srv_heupstream <srv_heupstream@mediatek.com>,
 "will@kernel.org" <will@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "krzk@kernel.org" <krzk@kernel.org>,
 =?utf-8?B?WWkgS3VvICjpg63mh78p?= <Yi.Kuo@mediatek.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 =?utf-8?B?QW50aG9ueSBIdWFuZyAo6buD5bu65ZiJKQ==?= <Anthony.Huang@mediatek.com>,
 =?utf-8?B?QW5hbiBTdW4gKOWtmeWuieWuiSk=?= <Anan.Sun@mediatek.com>,
 =?utf-8?B?TWluZy1GYW4gQ2hlbiAo6Zmz5piO5rGOKQ==?= <Ming-Fan.Chen@mediatek.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "ikjn@chromium.org" <ikjn@chromium.org>,
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

On Wed, 2021-08-18 at 22:41 +0200, Krzysztof Kozlowski wrote:
> On 10/08/2021 10:08, Yong Wu wrote:
> > This patchset mainly adds SMI support for mt8195.
> > 
> > Comparing with the previous version, add two new functions:
> > a) add smi sub common
> > b) add initial setting for smi-common and smi-larb.
> > 
> > Change note:
> > v3:1) In the dt-binding:
> >        a. Change mediatek,smi type from phandle-array to phandle
> > from Rob.
> >        b. Add a new bool property (mediatek,smi_sub_common)
> >           to indicate if this is smi-sub-common.
> >    2) Change the clock using bulk parting.
> >       keep the smi-common's has_gals flag. more strict.
> >    3) More comment about larb initial setting.
> >    4) Add a maintain patch
> 
> The patchset looks good to me but I saw now comments from Rob, so I
> expect a resend. Therefore there is also time for additional review -
> maybe continued by Ikjoon Jang?
> 
> If you sent a v4 with fixes rather soon and get ack from Rob, I could
> still try to get it into next merge window. After this weekend I
> won't
> be taking patches for this cycle and it will wait for the merge
> window
> to finish.

Hi Krzysztof,

Thanks very much for your information.

It looks the time is too short to get Rob's ack in this weekend. I will
wait for one or two weeks to see if there is other comments, then
resend.

> 
> 
> Best regards,
> Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
