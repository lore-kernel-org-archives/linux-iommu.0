Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28751C43334
	for <iommu@archiver.kernel.org>; Thu,  2 Jun 2022 09:23:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8268982B97;
	Thu,  2 Jun 2022 09:22:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XraD0LT66-UC; Thu,  2 Jun 2022 09:22:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0F41F81B17;
	Thu,  2 Jun 2022 09:22:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E22FBC0032;
	Thu,  2 Jun 2022 09:22:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9620CC002D
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jun 2022 08:28:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 76DE283DF1
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jun 2022 08:28:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QUp1fZMqoMjT for <iommu@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 08:27:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 85ED08175C
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jun 2022 08:27:55 +0000 (UTC)
X-UUID: f225be05e0ad4ae19709be6028d247ca-20220602
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:Content-Transfer-Encoding:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:Subject;
 bh=nQ05etCoOFXNcIRC2kQ9W8KshtEOlMRiBcwnyiI2gHI=; 
 b=C/cXPtKzy//u65pvGjPjFHifb6vHezVEal4DSSQcGfm7tPAsL6NSNgZsIszn60pqoZrPcQpQRfbz967c+XWykFtyuyr+hC/Vh3+j6nhcwPE3vl7RZBlNnWVzHrPECk5elVl4OT7g2G7SoLxaok3k1ijeJlMr5saTTKg1ZmVYhpY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5, REQID:6544d012-d7e9-45b9-a5ea-84cee5440326, OB:0,
 LO
 B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
 ON:release,TS:0
X-CID-META: VersionHash:2a19b09, CLOUDID:3609e137-9855-4915-a138-f5705f1f3d02,
 C
 OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
 ,QS:0,BEC:nil
X-UUID: f225be05e0ad4ae19709be6028d247ca-20220602
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by
 mailgw01.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 324604989; Thu, 02 Jun 2022 16:27:46 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3; 
 Thu, 2 Jun 2022 16:27:45 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Thu, 2 Jun 2022 16:27:45 +0800
Subject: Re: [PATCH 1/3] dt-bindings: iommu: mediatek: add binding
 documentation for MT8365 SoC
To: Yong Wu <yong.wu@mediatek.com>, Fabien Parent <fparent@baylibre.com>
References: <20220530180328.845692-1-fparent@baylibre.com>
 <8ac7a6766c635412b408cb5295ddb3da37541140.camel@mediatek.com>
Message-ID: <59cedd50-4141-e589-11ae-b8d1a017eb46@mediatek.com>
Date: Thu, 2 Jun 2022 16:27:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8ac7a6766c635412b408cb5295ddb3da37541140.camel@mediatek.com>
Content-Language: en-US
X-Mailman-Approved-At: Thu, 02 Jun 2022 09:22:50 +0000
Cc: devicetree@vger.kernel.org, Kidd-KW Chen <Kidd-KW.Chen@mediatek.com>,
 Macross Chen <macross.chen@mediatek.com>, linux-kernel@vger.kernel.org,
 Bear Wang <bear.wang@mediatek.com>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Andy Hsieh <Andy.Hsieh@mediatek.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Will Deacon <will@kernel.org>,
 Pablo Sun <pablo.sun@mediatek.com>, linux-arm-kernel@lists.infradead.org
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
From: Macpaul Lin via iommu <iommu@lists.linux-foundation.org>
Reply-To: Macpaul Lin <macpaul.lin@mediatek.com>
Content-Type: multipart/mixed; boundary="===============2655335695138328331=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============2655335695138328331==
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Content-Type: multipart/alternative;
	boundary="__=_Part_Boundary_009_341426681.795335240"

--__=_Part_Boundary_009_341426681.795335240
Content-Type: text/html;
	charset="utf-8"
Content-Transfer-Encoding: base64

PHByZT4NCk9uJiMzMjs2LzIvMjImIzMyOzI6MTgmIzMyO1BNLCYjMzI7WW9uZyYjMzI7V3UmIzMy
O3dyb3RlOg0KJmd0OyYjMzI7T24mIzMyO01vbiwmIzMyOzIwMjItMDUtMzAmIzMyO2F0JiMzMjsy
MDowMyYjMzI7KzAyMDAsJiMzMjtGYWJpZW4mIzMyO1BhcmVudCYjMzI7d3JvdGU6DQomZ3Q7Jmd0
OyYjMzI7QWRkJiMzMjtJT01NVSYjMzI7YmluZGluZyYjMzI7ZG9jdW1lbnRhdGlvbiYjMzI7Zm9y
JiMzMjt0aGUmIzMyO01UODM2NSYjMzI7U29DLg0KJmd0OyZndDsNCiZndDsmZ3Q7JiMzMjtTaWdu
ZWQtb2ZmLWJ5OiYjMzI7RmFiaWVuJiMzMjtQYXJlbnQmIzMyOyZsdDtmcGFyZW50QGJheWxpYnJl
LmNvbSZndDsNCiZndDsmZ3Q7JiMzMjstLS0NCiZndDsmZ3Q7JiMzMjsmIzMyOyYjMzI7Li4uL2Jp
bmRpbmdzL2lvbW11L21lZGlhdGVrLGlvbW11LnlhbWwmIzMyOyYjMzI7JiMzMjsmIzMyOyYjMzI7
JiMzMjsmIzMyOyYjMzI7fCYjMzI7JiMzMjsyJiMzMjsrDQomZ3Q7Jmd0OyYjMzI7JiMzMjsmIzMy
O2luY2x1ZGUvZHQtYmluZGluZ3MvbWVtb3J5L210ODM2NS1sYXJiLXBvcnQuaCYjMzI7fCYjMzI7
OTYNCiZndDsmZ3Q7JiMzMjsrKysrKysrKysrKysrKysrKysrDQomZ3Q7Jmd0OyYjMzI7JiMzMjsm
IzMyOzImIzMyO2ZpbGVzJiMzMjtjaGFuZ2VkLCYjMzI7OTgmIzMyO2luc2VydGlvbnMoKykNCiZn
dDsmZ3Q7JiMzMjsmIzMyOyYjMzI7Y3JlYXRlJiMzMjttb2RlJiMzMjsxMDA2NDQmIzMyO2luY2x1
ZGUvZHQtYmluZGluZ3MvbWVtb3J5L210ODM2NS1sYXJiLXBvcnQuaA0KJmd0OyYjMzI7DQomZ3Q7
JiMzMjtbc25pcC4uLl0NCiZndDsmIzMyOw0KJmd0OyZndDsmIzMyOysjaWZuZGVmJiMzMjtfRFRf
QklORElOR1NfTUVNT1JZX01UODM2NV9MQVJCX1BPUlRfSF8NCiZndDsmZ3Q7JiMzMjsrI2RlZmlu
ZSYjMzI7X0RUX0JJTkRJTkdTX01FTU9SWV9NVDgzNjVfTEFSQl9QT1JUX0hfDQomZ3Q7Jmd0OyYj
MzI7Kw0KJmd0OyZndDsmIzMyOysjaW5jbHVkZSYjMzI7Jmx0O2R0LWJpbmRpbmdzL21lbW9yeS9t
dGstbWVtb3J5LXBvcnQuaCZndDsNCiZndDsmZ3Q7JiMzMjsrDQomZ3Q7Jmd0OyYjMzI7KyNkZWZp
bmUmIzMyO000VV9MQVJCMF9JRDANCiZndDsmZ3Q7JiMzMjsrI2RlZmluZSYjMzI7TTRVX0xBUkIx
X0lEMQ0KJmd0OyZndDsmIzMyOysjZGVmaW5lJiMzMjtNNFVfTEFSQjJfSUQyDQomZ3Q7Jmd0OyYj
MzI7KyNkZWZpbmUmIzMyO000VV9MQVJCM19JRDMNCiZndDsmZ3Q7JiMzMjsrI2RlZmluZSYjMzI7
TTRVX0xBUkI0X0lENA0KJmd0OyZndDsmIzMyOysjZGVmaW5lJiMzMjtNNFVfTEFSQjVfSUQ1DQom
Z3Q7Jmd0OyYjMzI7KyNkZWZpbmUmIzMyO000VV9MQVJCNl9JRDYNCiZndDsmZ3Q7JiMzMjsrI2Rl
ZmluZSYjMzI7TTRVX0xBUkI3X0lENw0KJmd0OyYjMzI7DQomZ3Q7JiMzMjtSZW1vdmUmIzMyO3Ro
ZXNlLiYjMzI7dGhleSYjMzI7YXJlJiMzMjtubyYjMzI7dXNlZCwmIzMyO3JpZ2h0JiM2MzsNCg0K
QUlPVCYjMzI7YW5kJiMzMjtjdXN0b21lcnMmIzMyO2FyZSYjMzI7dXNpbmcmIzMyO3RoZSYjMzI7
bW9kdWxlcyYjMzI7YW5kJiMzMjt0aGVpciYjMzI7cmVsYXRlZCYjMzI7SU9NTVUmIzMyO21vZHVs
ZXMuDQpESVNQMCwmIzMyO1ZFTkMsJiMzMjtWREVDLCYjMzI7SVNQJiMzMjsoQ0FNU1lTKSwmIzMy
O2FuZCYjMzI7QVBVJiMzMjsoYXMmIzMyO2ZhciYjMzI7YXMmIzMyO0kmIzMyO2tub3csJiMzMjt3
aGljaCYjMzI7c2hvdWxkJiMzMjsNCmJlJiMzMjtWUDYmIzYzOykmIzMyO3dlcmUmIzMyO2FsbCYj
MzI7c3VwcG9ydGVkLg0KDQomZ3Q7JiMzMjsNCiZndDsmZ3Q7JiMzMjsrDQomZ3Q7Jmd0OyYjMzI7
Ky8qJiMzMjtsYXJiMCYjMzI7Ki8NCiZndDsmZ3Q7JiMzMjsrI2RlZmluZSYjMzI7TTRVX1BPUlRf
RElTUF9PVkwwTVRLX000VV9JRCgwLCYjMzI7MCkNCiZndDsmZ3Q7JiMzMjsrI2RlZmluZSYjMzI7
TTRVX1BPUlRfRElTUF9PVkwwXzJMTVRLX000VV9JRCgwLCYjMzI7MSkNCiZndDsmIzMyOw0KJmd0
OyYjMzI7Wy4uLl0NCiZndDsmIzMyOw0KJmd0OyZndDsNCiZndDsmZ3Q7JiMzMjsrLyomIzMyO2xh
cmI0JiMzMjsqLw0KJmd0OyZndDsmIzMyOysjZGVmaW5lJiMzMjtNNFVfUE9SVF9BUFVfUkVBRE1U
S19NNFVfSUQoMCwmIzMyOzApDQomZ3Q7Jmd0OyYjMzI7KyNkZWZpbmUmIzMyO000VV9QT1JUX0FQ
VV9XUklURU1US19NNFVfSUQoMCwmIzMyOzEpDQomZ3Q7JiMzMjsNCiZndDsmIzMyO1BsZWFzZSYj
MzI7cmVtb3ZlJiMzMjt0aGVzZSYjMzI7dHdvJiMzMjtBUFUmIzMyO2RlZmluaXRpb25zLiYjMzI7
Y3VycmVudGx5JiMzMjt0aGVzZSYjMzI7YXJlJiMzMjtub3QNCiZndDsmIzMyO3N1cHBvcnRlZC4N
Cg0KS2lkZCwmIzMyO3BsZWFzZSYjMzI7aGVscCYjMzI7dG8mIzMyO2NoZWNrJiMzMjtpZiYjMzI7
QVBVJiMzMjt1c2UmIzMyO3RoZXNlJiMzMjtkZWZpbml0aW9ucyYjMzI7d2l0aCYjMzI7WW9uZy4N
Ckhvd2V2ZXIsJiMzMjtJJiMzMjt0aGluayYjMzI7dGhlc2UmIzMyO2FyZSYjMzI7YWxsJiMzMjth
dmFpbGFibGUmIzMyO3RvJiMzMjt0aGUmIzMyO2N1c3RvbWVycy4NCg0KVGhhbmtzDQpNYWNwYXVs
JiMzMjtMaW4NCjwvcHJlPjwhLS10eXBlOnRleHQtLT48IS0tey0tPjxwcmU+KioqKioqKioqKioq
KiBNRURJQVRFSyBDb25maWRlbnRpYWxpdHkgTm90aWNlDQogKioqKioqKioqKioqKioqKioqKioN
ClRoZSBpbmZvcm1hdGlvbiBjb250YWluZWQgaW4gdGhpcyBlLW1haWwgbWVzc2FnZSAoaW5jbHVk
aW5nIGFueSANCmF0dGFjaG1lbnRzKSBtYXkgYmUgY29uZmlkZW50aWFsLCBwcm9wcmlldGFyeSwg
cHJpdmlsZWdlZCwgb3Igb3RoZXJ3aXNlDQpleGVtcHQgZnJvbSBkaXNjbG9zdXJlIHVuZGVyIGFw
cGxpY2FibGUgbGF3cy4gSXQgaXMgaW50ZW5kZWQgdG8gYmUgDQpjb252ZXllZCBvbmx5IHRvIHRo
ZSBkZXNpZ25hdGVkIHJlY2lwaWVudChzKS4gQW55IHVzZSwgZGlzc2VtaW5hdGlvbiwgDQpkaXN0
cmlidXRpb24sIHByaW50aW5nLCByZXRhaW5pbmcgb3IgY29weWluZyBvZiB0aGlzIGUtbWFpbCAo
aW5jbHVkaW5nIGl0cyANCmF0dGFjaG1lbnRzKSBieSB1bmludGVuZGVkIHJlY2lwaWVudChzKSBp
cyBzdHJpY3RseSBwcm9oaWJpdGVkIGFuZCBtYXkgDQpiZSB1bmxhd2Z1bC4gSWYgeW91IGFyZSBu
b3QgYW4gaW50ZW5kZWQgcmVjaXBpZW50IG9mIHRoaXMgZS1tYWlsLCBvciBiZWxpZXZlDQogDQp0
aGF0IHlvdSBoYXZlIHJlY2VpdmVkIHRoaXMgZS1tYWlsIGluIGVycm9yLCBwbGVhc2Ugbm90aWZ5
IHRoZSBzZW5kZXIgDQppbW1lZGlhdGVseSAoYnkgcmVwbHlpbmcgdG8gdGhpcyBlLW1haWwpLCBk
ZWxldGUgYW55IGFuZCBhbGwgY29waWVzIG9mIA0KdGhpcyBlLW1haWwgKGluY2x1ZGluZyBhbnkg
YXR0YWNobWVudHMpIGZyb20geW91ciBzeXN0ZW0sIGFuZCBkbyBub3QNCmRpc2Nsb3NlIHRoZSBj
b250ZW50IG9mIHRoaXMgZS1tYWlsIHRvIGFueSBvdGhlciBwZXJzb24uIFRoYW5rIHlvdSENCjwv
cHJlPjwhLS19LS0+

--__=_Part_Boundary_009_341426681.795335240
Content-Type: text/plain;
	charset="utf-8";
	format=flowed
Content-Transfer-Encoding: base64

T24gNi8yLzIyIDI6MTggUE0sIFlvbmcgV3Ugd3JvdGU6DQo+IE9uIE1vbiwgMjAyMi0wNS0zMCBh
dCAyMDowMyArMDIwMCwgRmFiaWVuIFBhcmVudCB3cm90ZToNCj4+IEFkZCBJT01NVSBiaW5kaW5n
IGRvY3VtZW50YXRpb24gZm9yIHRoZSBNVDgzNjUgU29DLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6
IEZhYmllbiBQYXJlbnQgPGZwYXJlbnRAYmF5bGlicmUuY29tPg0KPj4gLS0tDQo+PiAgIC4uLi9i
aW5kaW5ncy9pb21tdS9tZWRpYXRlayxpb21tdS55YW1sICAgICAgICB8ICAyICsNCj4+ICAgaW5j
bHVkZS9kdC1iaW5kaW5ncy9tZW1vcnkvbXQ4MzY1LWxhcmItcG9ydC5oIHwgOTYNCj4+ICsrKysr
KysrKysrKysrKysrKysNCj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCA5OCBpbnNlcnRpb25zKCspDQo+
PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2R0LWJpbmRpbmdzL21lbW9yeS9tdDgzNjUt
bGFyYi1wb3J0LmgNCj4gDQo+IFtzbmlwLi4uXQ0KPiANCj4+ICsjaWZuZGVmIF9EVF9CSU5ESU5H
U19NRU1PUllfTVQ4MzY1X0xBUkJfUE9SVF9IXw0KPj4gKyNkZWZpbmUgX0RUX0JJTkRJTkdTX01F
TU9SWV9NVDgzNjVfTEFSQl9QT1JUX0hfDQo+PiArDQo+PiArI2luY2x1ZGUgPGR0LWJpbmRpbmdz
L21lbW9yeS9tdGstbWVtb3J5LXBvcnQuaD4NCj4+ICsNCj4+ICsjZGVmaW5lIE00VV9MQVJCMF9J
RAkJCTANCj4+ICsjZGVmaW5lIE00VV9MQVJCMV9JRAkJCTENCj4+ICsjZGVmaW5lIE00VV9MQVJC
Ml9JRAkJCTINCj4+ICsjZGVmaW5lIE00VV9MQVJCM19JRAkJCTMNCj4+ICsjZGVmaW5lIE00VV9M
QVJCNF9JRAkJCTQNCj4+ICsjZGVmaW5lIE00VV9MQVJCNV9JRAkJCTUNCj4+ICsjZGVmaW5lIE00
VV9MQVJCNl9JRAkJCTYNCj4+ICsjZGVmaW5lIE00VV9MQVJCN19JRAkJCTcNCj4gDQo+IFJlbW92
ZSB0aGVzZS4gdGhleSBhcmUgbm8gdXNlZCwgcmlnaHQ/DQoNCkFJT1QgYW5kIGN1c3RvbWVycyBh
cmUgdXNpbmcgdGhlIG1vZHVsZXMgYW5kIHRoZWlyIHJlbGF0ZWQgSU9NTVUgbW9kdWxlcy4NCkRJ
U1AwLCBWRU5DLCBWREVDLCBJU1AgKENBTVNZUyksIGFuZCBBUFUgKGFzIGZhciBhcyBJIGtub3cs
IHdoaWNoIHNob3VsZCANCmJlIFZQNj8pIHdlcmUgYWxsIHN1cHBvcnRlZC4NCg0KPiANCj4+ICsN
Cj4+ICsvKiBsYXJiMCAqLw0KPj4gKyNkZWZpbmUgTTRVX1BPUlRfRElTUF9PVkwwCQlNVEtfTTRV
X0lEKDAsIDApDQo+PiArI2RlZmluZSBNNFVfUE9SVF9ESVNQX09WTDBfMkwJTVRLX000VV9JRCgw
LCAxKQ0KPiANCj4gWy4uLl0NCj4gDQo+Pg0KPj4gKy8qIGxhcmI0ICovDQo+PiArI2RlZmluZSBN
NFVfUE9SVF9BUFVfUkVBRAkJTVRLX000VV9JRCgwLCAwKQ0KPj4gKyNkZWZpbmUgTTRVX1BPUlRf
QVBVX1dSSVRFCQlNVEtfTTRVX0lEKDAsIDEpDQo+IA0KPiBQbGVhc2UgcmVtb3ZlIHRoZXNlIHR3
byBBUFUgZGVmaW5pdGlvbnMuIGN1cnJlbnRseSB0aGVzZSBhcmUgbm90DQo+IHN1cHBvcnRlZC4N
Cg0KS2lkZCwgcGxlYXNlIGhlbHAgdG8gY2hlY2sgaWYgQVBVIHVzZSB0aGVzZSBkZWZpbml0aW9u
cyB3aXRoIFlvbmcuDQpIb3dldmVyLCBJIHRoaW5rIHRoZXNlIGFyZSBhbGwgYXZhaWxhYmxlIHRv
IHRoZSBjdXN0b21lcnMuDQoNClRoYW5rcw0KTWFjcGF1bCBMaW4=

--__=_Part_Boundary_009_341426681.795335240--


--===============2655335695138328331==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============2655335695138328331==--

