Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F4A7E
	for <iommu@lists.linux.dev>; Fri,  9 Dec 2022 02:20:51 +0000 (UTC)
X-UUID: f9dd1bba2476427dbbc439bf69a24004-20221209
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=6Oc379NGhFn6t3UbSyLq/O+Q2uKxvfv+H+I7F/5C3O4=;
	b=j3OpelQ5rZJLXUSV/LMdUBiGxRBGpsQZRiR8OqHY8+rtmNLaKhMRrH9j+5wOlmIZnq+AtZ4Clz3b2UapBvPGY/EoPGED7PoDMaFXIdEygp2lz3vPel1q/qKQegKAtFbHhIYxwzgoZvopnHe0e3fXJyFVduyHFP1lEHIOi1/BJwc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:39e6217a-e966-4473-9ee5-7e0f006259bf,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:89c5be24-4387-4253-a41d-4f6f2296b154,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: f9dd1bba2476427dbbc439bf69a24004-20221209
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
	(envelope-from <yong.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
	with ESMTP id 1807061752; Fri, 09 Dec 2022 10:20:40 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 9 Dec 2022 10:20:38 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 9 Dec 2022 10:20:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gqAR9RPEMuvFwrulloozS8KSoPbFdeVL1itfmRZind8lojmtSdtdwpubiWeSgCxPP/l3xWLr8MRYE6jqtGR7mlNNSgbw05QJAWsZaH5jl22D60NZqUqfoQoqS59m6yPNMlKUTj4CD4kwzMZ8VrmNzRRODD8K07S2TmLVc91AYPHNIcNmKeOozbKpy9KbUkoYxSGHnxfKVpKxvRjlHmea9EMy3aOB05ObSutSf+DKT2buDQSWklkZb6Y+ME+D5+faX1KtecmcIr/V6NkRKrDiw+5S+EBsPLltagbVLt253+21sToFvlTe+LsNh2fIyS4B3/ARlRsy27w+QUU9QMWOiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Oc379NGhFn6t3UbSyLq/O+Q2uKxvfv+H+I7F/5C3O4=;
 b=Wc7y+WhyLwkxSXP6u/El+EBx5122S7+WPbu9frLYWityCez0Hw5vwH334NMv9n0C3yl/qCa1YF5PUA/LmFlNGYq+2hCwBPIFXsF8khVqyoDEsvVFpocLpnuOdZ92chlHZ8TtKkOeYqbAljLnqvgYk3I9h2Q+IphFRE5gOPNlweXcFaC7xqCrlk5TcTZg4FCIkJbSiTGrYp+5HAE4+SIWctbWtfXBQe85qmOO2UO4Xfi/Hx79mdLKRwPPPmztdZus/7XOexBusHMFUTPQmY/0KRIOjjZgPrV8EwO9uJWrc0p2+ekiHpGcNPVCUflx+Vg6yZ+oKD0rqUvl+h0QFCBL0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Oc379NGhFn6t3UbSyLq/O+Q2uKxvfv+H+I7F/5C3O4=;
 b=Kggrg42sWgGXawEhTywRc4f2nP3DoveVA0PYoO6/in9jsutYyZQcLhPzGx23LM8m7kd+qbRJLpHTQaHIzVa1E/k7PFVaZaMVZHzNwshdbwNE/+6EBuoKfKtYo809IG39BQrRKwwyNJXPiQD4ywyjMOJ4Uvb4sTev5snRGdF3CJ0=
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com (2603:1096:4:142::7) by
 TY0PR03MB6630.apcprd03.prod.outlook.com (2603:1096:400:207::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.16; Fri, 9 Dec 2022 02:20:36 +0000
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::4139:bb22:3bf9:f1e3]) by SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::4139:bb22:3bf9:f1e3%5]) with mapi id 15.20.5880.016; Fri, 9 Dec 2022
 02:20:36 +0000
From: =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
To: "joro@8bytes.org" <joro@8bytes.org>, "error27@gmail.com"
	<error27@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>
CC: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "kernelci-results@groups.io"
	<kernelci-results@groups.io>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "will@kernel.org"
	<will@kernel.org>
Subject: Re: [PATCH] iommu/mediatek: Fix forever loop in error handling
Thread-Topic: [PATCH] iommu/mediatek: Fix forever loop in error handling
Thread-Index: AQHZClR35l3j06HsUku5hjWhbvtgVK5jLdWAgAGnI4A=
Date: Fri, 9 Dec 2022 02:20:36 +0000
Message-ID: <b28e0163c75e320b2dc1b9fe7007277d1847bb56.camel@mediatek.com>
References: <Y5C3mTam2nkbaz6o@kili>
	 <68cb1ee26fc61a290a9e69b15234848ec8a02b8c.camel@mediatek.com>
In-Reply-To: <68cb1ee26fc61a290a9e69b15234848ec8a02b8c.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5885:EE_|TY0PR03MB6630:EE_
x-ms-office365-filtering-correlation-id: ee3f16df-bb86-470c-55a5-08dad98bf53c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yRghHc4ZwZw7naRwdxJkRqKHjR2HPXbe9klG+6xLvyaCVCzNxRcSWonpapPVeCg/nrODb7lLFl3lFj5va4D03wjN2o7fiLhcUcbbGUhZawLzTVFFzM2LCTosdpGlzT+I0nKNPJn+LLW8VKLveRWnVdnlfqvE4g61GIgCsawKY/rCucowjpJJf6f6s9nSeSrYnzOOTGaAZ6VP3HnI1rN7I5Cy1dlJeXQQKjVFWK4ryUj+XgZ/WJKwQXzUCFo5zI0VdCn/CXlgFmth2l7J18zLG5MF0NlAfRV0ieTLeR6hLtRLSAOEHcRo/LEjMlBbS25RKRAbux/rub0JV+OOpRkJy51Zui9jIhwiy8AKC4eHbxz8wFyV9AC7B1sA1HaKCF/XmpIE/or85kzJeWNW8aAYAxrbj4VnVoiPhhgznZJ/vuQe5Mxn7dGpiH4YF6Xoqs5VNs6fUFXV42HruSdKAvaBwksKkPORH5ildw0oK60W6UBQX6U63w2p1VXL0jBZjhan1yWlIMYT+5aNXNvddXztMbgAIEonSOSKIWrXlDYHVY7BGFO8WQ+ez71P8Xp+5nKD8hTmSG7pK17G+sU9Lkmzrsc5deufQ35l+D22tD3mHCqS7HAPE2+S7lWqZFQy2okNX+Fws89in+Mg9C8ce8p5dhbkgGAuy6qriAO5WBGdiRrTpeUDR0k/eAA72KxuRVekwEXsSTY3IpQuDRR/y0GpIpDzSMqIg02rnMu6QvGcsm9JVeOYD1i1vlox8N8MQkfI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5885.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(396003)(376002)(366004)(451199015)(316002)(6506007)(71200400001)(186003)(76116006)(66446008)(26005)(36756003)(85182001)(54906003)(6512007)(2616005)(2906002)(83380400001)(38070700005)(38100700002)(122000001)(66556008)(4326008)(66476007)(8676002)(66946007)(64756008)(5660300002)(8936002)(7416002)(86362001)(41300700001)(478600001)(966005)(6486002)(110136005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bm16aG5QWFJvTUw3WEI5Z0l5dmU4bVJKbThmR1JVQW5tRHlZT0dkSHl1SDc3?=
 =?utf-8?B?ODdRODc2NTVyQkZiWjRhd2JPVG9GRzlTU1I0amV6bmJabCtBSVJkSzFHZ3JB?=
 =?utf-8?B?akRYTTR3WXdoOGJjMEZtOEpXWjlYaCszTW5kQVdrd2RTT2NDUytqRHJvM3BC?=
 =?utf-8?B?emh1VGFsWDNzOUxQYlpGdEhYVXp4MHU1cm04b1lOc0xHa0Z6MitEUE5MT0dm?=
 =?utf-8?B?dFVPMWxsSXhTZUlJZ1YySDNVbFUyT0xTOEFjUnE3NzZCc3VrajR5VzF4azJw?=
 =?utf-8?B?ZWJaMTZSQldaYkFEK3J1QmlEQXNNcm5hSmdmdmZVMWFTMFE1dzEvSWtBU09w?=
 =?utf-8?B?cDkrb3FTS2Jqb0lGVEVJbXJaQnZlODFmeFNBT0NjU2UrekVMTEJ0Q2xJaURU?=
 =?utf-8?B?d0dxdTVaWHR4NEYxRnQvWU9VUGZpaHl0eVZrWGIrUmRHcFFQenhzK0VqUXJ1?=
 =?utf-8?B?cW9jM2RHT2c3bGQrbTJ3M3JvdTRHZ255M0h3SlVxeEhIVndkbWpSYnJQcTlS?=
 =?utf-8?B?c0VKdjc1Qmp3a0xxNFEwS0wxMWJneTRyb1VuZFBBN3BBYTI5VzgycTljWUhv?=
 =?utf-8?B?bEVwSFVVbmpvYXk3cGoxZGFOamltTTJPTjMwQmttSitJd2RSME5rNGFucWp1?=
 =?utf-8?B?eWczaWo4a0xrTlJ2Nkt1emVHWHZUaDd2OCtxL3lDR042Z3pzRmpYT1RNa21o?=
 =?utf-8?B?SFo2cVZuWW1HUGhVMlFJRW9rT05xQTlsOHlzYTBEM0V3eEtFM1pvNm8zalAx?=
 =?utf-8?B?NG9wWWxKMzlpZnV1Z0sxalkxbWR3WHFSUmJHRnhSNXJYRGV1Y29HOUtDVldy?=
 =?utf-8?B?Q3dON2ErRHpKR0hYREwxTCsvV2thcnVzSUVJUG1tN3dsc1JOTDNGM29aZ0dW?=
 =?utf-8?B?VFExMkFHL2QxSEVmRzZwZ2xkL0V3RWVNYTRZWTcxWHR6WE1wUitGM1pCV2Nh?=
 =?utf-8?B?TTQrR2tCSmFPZ0c4VjZNL01Wb2YzelpHK0ZjTWdCQVBLOFREbUxQTkh1aDdT?=
 =?utf-8?B?eEYvU1lkZHcwMzJGSXYrM3lSc0pJWXArRFB3L3EyMy9yeDhvWmlINWg3cGxw?=
 =?utf-8?B?TElXR0FJZE92b3N3T0w4c3VOUFZjMmoxeVgwam9XSkEzcTJ2ODJxT0xCeWs3?=
 =?utf-8?B?c3U4Zmg1bWpXQ1V1OW1WOWZpOG1vcjNrdkFoaENXamFMbzFaVjQzNlZrTnhh?=
 =?utf-8?B?VDhUMDk4Wk94ZUxXbUlRdHliMjZUak9BLzg3MU5rcktRVXN6dlZCT1pPQ0Er?=
 =?utf-8?B?MVJNZUQ5d3lUeno4dW85T0ZheThaWDlQQW1sWDVZZW5KRGc2K25XaVo4eElv?=
 =?utf-8?B?Uk5XN0FhYUdLdjBOa3NYakpCSHNCM3dkREdMRldHY0JZRUxtdEJPQkY4aEFn?=
 =?utf-8?B?WXZ5WkhQRVlWZ1NWWVVkYmJMaHhiRytlbHp2b05IdFNnNnlZSmVhaDN0d3E0?=
 =?utf-8?B?WE16cnJPeHRqa1pHMmJ1VkxIcW9qdzcvTTA3WXZUb3h4QTI0WTBNVkN2T1M5?=
 =?utf-8?B?ODYvcDRGU1hmOU8xTzdwbkNURVZ4dm91UFJRRXB4OXFOSDVGcEl3WktVbGNa?=
 =?utf-8?B?amkzS3ozR29ENFlBSVkzWEhKK1NXUVh3WExwcmpKR0VQeDJDc2NkaDhIMnRI?=
 =?utf-8?B?ZFN4bDdRS0gwUDZkMmlUaVlQNHhkQUVQWGVWbXJ0ajRkNmcybFl0WlNUYzRE?=
 =?utf-8?B?WjdCS1VqbVBrRmJmalVOeVJGRkpiekxuc2Q2OGtCSS9reDVldGZ6TVlKSk4w?=
 =?utf-8?B?eTRsVTM2b29pRUpXUllMTEQ2RW1xLzJCNmRnd0RXd0RBRXViQktJMVMwdU9G?=
 =?utf-8?B?K0lidHM5ZWY1aVNtb245T0xRM0ZsazBJcnIwVDJQQW54U3RIWUxJbmVyRXBN?=
 =?utf-8?B?NEh5THIreU93WkpMT3FwZ1lCS0xsNUpnRjVuaEFUUktBU2s0V1U3aHdUZ1Zi?=
 =?utf-8?B?VXN3RG9KSDM3dnJlK2lOY0VCTVVCRnNReVJmMmVkSHlJQ0JkK3YzWXBhUnc3?=
 =?utf-8?B?M2xVdytNaUpvRHYvYUQ2N3ZwMnJCTGhDV21GcE1HSy9mM0J3ZnFTajZJWnVK?=
 =?utf-8?B?STBPQ2FHZU5vcFBVT2VRUEpnaFR4cXNaMDlpL2UrTjlOdjAzYVowMGZSQndE?=
 =?utf-8?B?MTMrSHZBZTBsYmZkM2p3Sk4zM21sMmUyQWFCZ1paS3p1c3ZMR21FYlEyUnNu?=
 =?utf-8?B?bkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AEB31AA82CFF4F47BE5895BB551B59BC@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5885.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee3f16df-bb86-470c-55a5-08dad98bf53c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2022 02:20:36.3930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aE63Crc0ZlpK5BFbCk00cjdIgWgp5yOkOzZqGfNxO8/b7VhC+sSrBg5jQkpPgiCcln5Rdw5RrfWwImCjH2N96A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6630
X-MTK: N

SGkgSm9lcmcsDQoNCk9uIFRodSwgMjAyMi0xMi0wOCBhdCAwOTowNiArMDgwMCwgWW9uZ1d1IHdy
b3RlOg0KPiBPbiBXZWQsIDIwMjItMTItMDcgYXQgMTg6NTYgKzAzMDAsIERhbiBDYXJwZW50ZXIg
d3JvdGU6DQo+ID4gVGhlcmUgaXMgYSB0eXBvIHNvIHRoaXMgbG9vcCBkb2VzIGkrKyB3aGVyZSBp
LS0gd2FzIGludGVuZGVkLiAgSXQNCj4gPiB3aWxsDQo+ID4gcmVzdWx0IGluIGxvb3BpbmcgdW50
aWwgdGhlIGtlcm5lbCBjcmFzaGVzLg0KPiA+IA0KPiA+IEZpeGVzOiAyNjU5MzkyODU2NGMgKCJp
b21tdS9tZWRpYXRlazogQWRkIGVycm9yIHBhdGggZm9yIGxvb3Agb2YNCj4gPiBtbV9kdHNfcGFy
c2UiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IERhbiBDYXJwZW50ZXIgPGVycm9yMjdAZ21haWwuY29t
Pg0KPiANCj4gU29ycnkgZm9yIHRoaXMuDQo+IA0KPiBSZXZpZXdlZC1ieTogWW9uZyBXdSA8eW9u
Zy53dUBtZWRpYXRlay5jb20+DQo+IA0KPiBUaGFua3MgRGFuLg0KDQpDb3VsZCB5b3UgaGVscCBh
cHBseSB0aGlzPw0KDQpJIHJlcHJvZHVjZWQgdGhpcyBiZWxvdyBpc3N1ZSwgYW5kIGl0IGNvdWxk
IGJlIGZpeGVkIGJ5IHRoaXMgcGF0Y2guDQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4
LW1lZGlhdGVrL1k1SHJJaEVmdUVnR0t1TUJAc2lyZW5hLm9yZy51ay8NCg0KVGhhbmtzLg0KDQo+
IA0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2lvbW11L210a19pb21tdS5jIHwgMyArLS0NCj4gPiAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jIGIvZHJpdmVycy9pb21tdS9t
dGtfaW9tbXUuYw0KPiA+IGluZGV4IDNlNDZiYzhiMDcxNC4uMmJhZGQ2YWNmYjIzIDEwMDY0NA0K
PiA+IC0tLSBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCj4gPiArKysgYi9kcml2ZXJzL2lv
bW11L210a19pb21tdS5jDQo+ID4gQEAgLTExNjAsOCArMTE2MCw3IEBAIHN0YXRpYyBpbnQgbXRr
X2lvbW11X21tX2R0c19wYXJzZShzdHJ1Y3QNCj4gPiBkZXZpY2UNCj4gPiAqZGV2LCBzdHJ1Y3Qg
Y29tcG9uZW50X21hdGNoICoqbQ0KPiA+ICAJcmV0dXJuIDA7DQo+ID4gIA0KPiA+ICBlcnJfbGFy
YmRldl9wdXQ6DQo+ID4gLQkvKiBpZCBtYXkgYmUgbm90IGxpbmVhciBtYXBwaW5nLCBsb29wIHdo
b2xlIHRoZSBhcnJheSAqLw0KPiA+IC0JZm9yIChpID0gTVRLX0xBUkJfTlJfTUFYIC0gMTsgaSA+
PSAwOyBpKyspIHsNCj4gPiArCWZvciAoaSA9IE1US19MQVJCX05SX01BWCAtIDE7IGkgPj0gMDsg
aS0tKSB7DQo+ID4gIAkJaWYgKCFkYXRhLT5sYXJiX2ltdVtpXS5kZXYpDQo+ID4gIAkJCWNvbnRp
bnVlOw0KPiA+ICAJCXB1dF9kZXZpY2UoZGF0YS0+bGFyYl9pbXVbaV0uZGV2KTsNCg==
