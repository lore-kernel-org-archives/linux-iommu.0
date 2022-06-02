Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E144BC433EF
	for <iommu@archiver.kernel.org>; Thu,  2 Jun 2022 09:22:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7BB8E60E92;
	Thu,  2 Jun 2022 09:22:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IWVXKOYaYJ2V; Thu,  2 Jun 2022 09:22:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9676560BE8;
	Thu,  2 Jun 2022 09:22:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2860EC0082;
	Thu,  2 Jun 2022 09:22:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D764C002D
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jun 2022 08:42:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4E5A782470
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jun 2022 08:42:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mediatek.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PlHocA_xLKCJ for <iommu@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 08:42:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 16A7E82451
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jun 2022 08:42:31 +0000 (UTC)
X-UUID: 660864278db546d39d1af92858f96de0-20220602
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:Content-Transfer-Encoding:In-Reply-To:MIME-Version:Date:Message-ID:References:CC:To:From:Subject;
 bh=/4d85SXehcaW6cWBUgT/hyB/uBk+fpmEvgp1jQPQDJs=; 
 b=XJJ6aA+ToQ0zXl0DVH30p0/0ByWTZP/3vUm3N47Us2IGJ7IDHEaf67fgRu8NPrqXP0R3p2zvrxyk+TYRItVAnVsKW9WLD9n6VsZyyTiUOazUY+crQCIS3SmppMekhTe83yKzWXiydlJOyXfV83pmsuCzxY3hphqWgzZmssctJ2Y=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5, REQID:bff07ae6-c046-4059-9d2d-ef2339e0fb32, OB:0,
 LO
 B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
 ON:release,TS:0
X-CID-META: VersionHash:2a19b09, CLOUDID:2db4e137-9855-4915-a138-f5705f1f3d02,
 C
 OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
 ,QS:0,BEC:nil
X-UUID: 660864278db546d39d1af92858f96de0-20220602
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by
 mailgw02.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1887507329; Thu, 02 Jun 2022 16:42:26 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3; 
 Thu, 2 Jun 2022 16:42:24 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Thu, 2 Jun 2022 16:42:24 +0800
Subject: Re: [PATCH 1/3] dt-bindings: iommu: mediatek: add binding
 documentation for MT8365 SoC
To: Yong Wu <yong.wu@mediatek.com>, Fabien Parent <fparent@baylibre.com>
References: <20220530180328.845692-1-fparent@baylibre.com>
 <8ac7a6766c635412b408cb5295ddb3da37541140.camel@mediatek.com>
 <59cedd50-4141-e589-11ae-b8d1a017eb46@mediatek.com>
Message-ID: <6b6c4cfc-6f20-0eda-4a0d-31d993341ae8@mediatek.com>
Date: Thu, 2 Jun 2022 16:42:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <59cedd50-4141-e589-11ae-b8d1a017eb46@mediatek.com>
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
Content-Type: multipart/mixed; boundary="===============7399170019339297395=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============7399170019339297395==
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Content-Type: multipart/alternative;
	boundary="__=_Part_Boundary_001_1526666424.1104228596"

--__=_Part_Boundary_001_1526666424.1104228596
Content-Type: text/html;
	charset="utf-8"
Content-Transfer-Encoding: base64

PHByZT4NCk9uJiMzMjs2LzIvMjImIzMyOzQ6MjcmIzMyO1BNLCYjMzI7TWFjcGF1bCYjMzI7TGlu
JiMzMjt3cm90ZToNCiZndDsmIzMyO09uJiMzMjs2LzIvMjImIzMyOzI6MTgmIzMyO1BNLCYjMzI7
WW9uZyYjMzI7V3UmIzMyO3dyb3RlOg0KJmd0OyZndDsmIzMyO09uJiMzMjtNb24sJiMzMjsyMDIy
LTA1LTMwJiMzMjthdCYjMzI7MjA6MDMmIzMyOyswMjAwLCYjMzI7RmFiaWVuJiMzMjtQYXJlbnQm
IzMyO3dyb3RlOg0KJmd0OyZndDsmZ3Q7JiMzMjtBZGQmIzMyO0lPTU1VJiMzMjtiaW5kaW5nJiMz
Mjtkb2N1bWVudGF0aW9uJiMzMjtmb3ImIzMyO3RoZSYjMzI7TVQ4MzY1JiMzMjtTb0MuDQomZ3Q7
Jmd0OyZndDsNCiZndDsmZ3Q7Jmd0OyYjMzI7U2lnbmVkLW9mZi1ieTomIzMyO0ZhYmllbiYjMzI7
UGFyZW50JiMzMjsmbHQ7ZnBhcmVudEBiYXlsaWJyZS5jb20mZ3Q7DQomZ3Q7Jmd0OyZndDsmIzMy
Oy0tLQ0KJmd0OyZndDsmZ3Q7JiMzMjsmIzE2MDsmIzMyOy4uLi9iaW5kaW5ncy9pb21tdS9tZWRp
YXRlayxpb21tdS55YW1sJiMxNjA7JiMxNjA7JiMxNjA7JiMxNjA7JiMxNjA7JiMxNjA7JiMxNjA7
JiMzMjt8JiMxNjA7JiMzMjsyJiMzMjsrDQomZ3Q7Jmd0OyZndDsmIzMyOyYjMTYwOyYjMzI7aW5j
bHVkZS9kdC1iaW5kaW5ncy9tZW1vcnkvbXQ4MzY1LWxhcmItcG9ydC5oJiMzMjt8JiMzMjs5Ng0K
Jmd0OyZndDsmZ3Q7JiMzMjsrKysrKysrKysrKysrKysrKysrDQomZ3Q7Jmd0OyZndDsmIzMyOyYj
MTYwOyYjMzI7MiYjMzI7ZmlsZXMmIzMyO2NoYW5nZWQsJiMzMjs5OCYjMzI7aW5zZXJ0aW9ucygr
KQ0KJmd0OyZndDsmZ3Q7JiMzMjsmIzE2MDsmIzMyO2NyZWF0ZSYjMzI7bW9kZSYjMzI7MTAwNjQ0
JiMzMjtpbmNsdWRlL2R0LWJpbmRpbmdzL21lbW9yeS9tdDgzNjUtbGFyYi1wb3J0LmgNCiZndDsm
Z3Q7DQomZ3Q7Jmd0OyYjMzI7W3NuaXAuLi5dDQomZ3Q7Jmd0Ow0KJmd0OyZndDsmZ3Q7JiMzMjsr
I2lmbmRlZiYjMzI7X0RUX0JJTkRJTkdTX01FTU9SWV9NVDgzNjVfTEFSQl9QT1JUX0hfDQomZ3Q7
Jmd0OyZndDsmIzMyOysjZGVmaW5lJiMzMjtfRFRfQklORElOR1NfTUVNT1JZX01UODM2NV9MQVJC
X1BPUlRfSF8NCiZndDsmZ3Q7Jmd0OyYjMzI7Kw0KJmd0OyZndDsmZ3Q7JiMzMjsrI2luY2x1ZGUm
IzMyOyZsdDtkdC1iaW5kaW5ncy9tZW1vcnkvbXRrLW1lbW9yeS1wb3J0LmgmZ3Q7DQomZ3Q7Jmd0
OyZndDsmIzMyOysNCiZndDsmZ3Q7Jmd0OyYjMzI7KyNkZWZpbmUmIzMyO000VV9MQVJCMF9JRCYj
MTYwOyYjMTYwOyYjMTYwOyYjMTYwOyYjMTYwOyYjMTYwOyYjMTYwOyYjMTYwOyYjMTYwOyYjMTYw
OyYjMTYwOyYjMzI7MA0KJmd0OyZndDsmZ3Q7JiMzMjsrI2RlZmluZSYjMzI7TTRVX0xBUkIxX0lE
JiMxNjA7JiMxNjA7JiMxNjA7JiMxNjA7JiMxNjA7JiMxNjA7JiMxNjA7JiMxNjA7JiMxNjA7JiMx
NjA7JiMxNjA7JiMzMjsxDQomZ3Q7Jmd0OyZndDsmIzMyOysjZGVmaW5lJiMzMjtNNFVfTEFSQjJf
SUQmIzE2MDsmIzE2MDsmIzE2MDsmIzE2MDsmIzE2MDsmIzE2MDsmIzE2MDsmIzE2MDsmIzE2MDsm
IzE2MDsmIzE2MDsmIzMyOzINCiZndDsmZ3Q7Jmd0OyYjMzI7KyNkZWZpbmUmIzMyO000VV9MQVJC
M19JRCYjMTYwOyYjMTYwOyYjMTYwOyYjMTYwOyYjMTYwOyYjMTYwOyYjMTYwOyYjMTYwOyYjMTYw
OyYjMTYwOyYjMTYwOyYjMzI7Mw0KJmd0OyZndDsmZ3Q7JiMzMjsrI2RlZmluZSYjMzI7TTRVX0xB
UkI0X0lEJiMxNjA7JiMxNjA7JiMxNjA7JiMxNjA7JiMxNjA7JiMxNjA7JiMxNjA7JiMxNjA7JiMx
NjA7JiMxNjA7JiMxNjA7JiMzMjs0DQomZ3Q7Jmd0OyZndDsmIzMyOysjZGVmaW5lJiMzMjtNNFVf
TEFSQjVfSUQmIzE2MDsmIzE2MDsmIzE2MDsmIzE2MDsmIzE2MDsmIzE2MDsmIzE2MDsmIzE2MDsm
IzE2MDsmIzE2MDsmIzE2MDsmIzMyOzUNCiZndDsmZ3Q7Jmd0OyYjMzI7KyNkZWZpbmUmIzMyO000
VV9MQVJCNl9JRCYjMTYwOyYjMTYwOyYjMTYwOyYjMTYwOyYjMTYwOyYjMTYwOyYjMTYwOyYjMTYw
OyYjMTYwOyYjMTYwOyYjMTYwOyYjMzI7Ng0KJmd0OyZndDsmZ3Q7JiMzMjsrI2RlZmluZSYjMzI7
TTRVX0xBUkI3X0lEJiMxNjA7JiMxNjA7JiMxNjA7JiMxNjA7JiMxNjA7JiMxNjA7JiMxNjA7JiMx
NjA7JiMxNjA7JiMxNjA7JiMxNjA7JiMzMjs3DQomZ3Q7Jmd0Ow0KJmd0OyZndDsmIzMyO1JlbW92
ZSYjMzI7dGhlc2UuJiMzMjt0aGV5JiMzMjthcmUmIzMyO25vJiMzMjt1c2VkLCYjMzI7cmlnaHQm
IzYzOw0KJmd0OyYjMzI7DQomZ3Q7JiMzMjtBSU9UJiMzMjthbmQmIzMyO2N1c3RvbWVycyYjMzI7
YXJlJiMzMjt1c2luZyYjMzI7dGhlJiMzMjttb2R1bGVzJiMzMjthbmQmIzMyO3RoZWlyJiMzMjty
ZWxhdGVkJiMzMjtJT01NVSYjMzI7bW9kdWxlcy4NCiZndDsmIzMyO0RJU1AwLCYjMzI7VkVOQywm
IzMyO1ZERUMsJiMzMjtJU1AmIzMyOyhDQU1TWVMpLCYjMzI7YW5kJiMzMjtBUFUmIzMyOyhhcyYj
MzI7ZmFyJiMzMjthcyYjMzI7SSYjMzI7a25vdywmIzMyO3doaWNoJiMzMjtzaG91bGQmIzMyOw0K
Jmd0OyYjMzI7YmUmIzMyO1ZQNiYjNjM7KSYjMzI7d2VyZSYjMzI7YWxsJiMzMjtzdXBwb3J0ZWQu
DQoNCkRlYXImIzMyO1lvbmcsDQpIb3cmIzMyO2Fib3V0JiMzMjt0byYjMzI7cmVwbGFjZSYjMzI7
dGhlJiMzMjtmb2xsb3dpbmcmIzMyO2RlZmluaXRpb25zJiM2MzsNCg0KRm9yJiMzMjtleGFtcGxl
LCYjMzI7cmVwbGFjZQ0KI2RlZmluZSYjMzI7TTRVX1BPUlRfRElTUF9PVkwwTVRLX000VV9JRCgw
LCYjMzI7MCkNCnRvDQojZGVmaW5lJiMzMjtNNFVfUE9SVF9ESVNQX09WTDAmIzMyOyYjMzI7JiMz
MjsmIzMyOyYjMzI7JiMzMjsmIzMyOyYjMzI7JiMzMjsmIzMyOyYjMzI7JiMzMjsmIzMyOyYjMzI7
TVRLX000VV9JRChNNFVfTEFSQjBfSUQmIzMyOywmIzMyOzApDQoNCiZndDsmZ3Q7DQomZ3Q7Jmd0
OyZndDsmIzMyOysNCiZndDsmZ3Q7Jmd0OyYjMzI7Ky8qJiMzMjtsYXJiMCYjMzI7Ki8NCiZndDsm
Z3Q7Jmd0OyYjMzI7KyNkZWZpbmUmIzMyO000VV9QT1JUX0RJU1BfT1ZMMCYjMTYwOyYjMTYwOyYj
MTYwOyYjMTYwOyYjMTYwOyYjMTYwOyYjMTYwOyYjMzI7TVRLX000VV9JRCgwLCYjMzI7MCkNCiZn
dDsmZ3Q7Jmd0OyYjMzI7KyNkZWZpbmUmIzMyO000VV9QT1JUX0RJU1BfT1ZMMF8yTCYjMTYwOyYj
MTYwOyYjMTYwOyYjMzI7TVRLX000VV9JRCgwLCYjMzI7MSkNCiZndDsmZ3Q7DQomZ3Q7Jmd0OyYj
MzI7Wy4uLl0NCiZndDsmZ3Q7DQomZ3Q7Jmd0OyZndDsNCiZndDsmZ3Q7Jmd0OyYjMzI7Ky8qJiMz
MjtsYXJiNCYjMzI7Ki8NCiZndDsmZ3Q7Jmd0OyYjMzI7KyNkZWZpbmUmIzMyO000VV9QT1JUX0FQ
VV9SRUFEJiMxNjA7JiMxNjA7JiMxNjA7JiMxNjA7JiMxNjA7JiMxNjA7JiMxNjA7JiMzMjtNVEtf
TTRVX0lEKDAsJiMzMjswKQ0KJmd0OyZndDsmZ3Q7JiMzMjsrI2RlZmluZSYjMzI7TTRVX1BPUlRf
QVBVX1dSSVRFJiMxNjA7JiMxNjA7JiMxNjA7JiMxNjA7JiMxNjA7JiMxNjA7JiMxNjA7JiMzMjtN
VEtfTTRVX0lEKDAsJiMzMjsxKQ0KJmd0OyZndDsNCiZndDsmZ3Q7JiMzMjtQbGVhc2UmIzMyO3Jl
bW92ZSYjMzI7dGhlc2UmIzMyO3R3byYjMzI7QVBVJiMzMjtkZWZpbml0aW9ucy4mIzMyO2N1cnJl
bnRseSYjMzI7dGhlc2UmIzMyO2FyZSYjMzI7bm90DQomZ3Q7Jmd0OyYjMzI7c3VwcG9ydGVkLg0K
Jmd0OyYjMzI7DQomZ3Q7JiMzMjtLaWRkLCYjMzI7cGxlYXNlJiMzMjtoZWxwJiMzMjt0byYjMzI7
Y2hlY2smIzMyO2lmJiMzMjtBUFUmIzMyO3VzZSYjMzI7dGhlc2UmIzMyO2RlZmluaXRpb25zJiMz
Mjt3aXRoJiMzMjtZb25nLg0KJmd0OyYjMzI7SG93ZXZlciwmIzMyO0kmIzMyO3RoaW5rJiMzMjt0
aGVzZSYjMzI7YXJlJiMzMjthbGwmIzMyO2F2YWlsYWJsZSYjMzI7dG8mIzMyO3RoZSYjMzI7Y3Vz
dG9tZXJzLg0KJmd0OyYjMzI7DQomZ3Q7JiMzMjtUaGFua3MNCiZndDsmIzMyO01hY3BhdWwmIzMy
O0xpbg0KDQpUaGFua3MNCk1hY3BhdWwmIzMyO0xpbg0KPC9wcmU+PCEtLXR5cGU6dGV4dC0tPjwh
LS17LS0+PHByZT4qKioqKioqKioqKioqIE1FRElBVEVLIENvbmZpZGVudGlhbGl0eSBOb3RpY2UN
CiAqKioqKioqKioqKioqKioqKioqKg0KVGhlIGluZm9ybWF0aW9uIGNvbnRhaW5lZCBpbiB0aGlz
IGUtbWFpbCBtZXNzYWdlIChpbmNsdWRpbmcgYW55IA0KYXR0YWNobWVudHMpIG1heSBiZSBjb25m
aWRlbnRpYWwsIHByb3ByaWV0YXJ5LCBwcml2aWxlZ2VkLCBvciBvdGhlcndpc2UNCmV4ZW1wdCBm
cm9tIGRpc2Nsb3N1cmUgdW5kZXIgYXBwbGljYWJsZSBsYXdzLiBJdCBpcyBpbnRlbmRlZCB0byBi
ZSANCmNvbnZleWVkIG9ubHkgdG8gdGhlIGRlc2lnbmF0ZWQgcmVjaXBpZW50KHMpLiBBbnkgdXNl
LCBkaXNzZW1pbmF0aW9uLCANCmRpc3RyaWJ1dGlvbiwgcHJpbnRpbmcsIHJldGFpbmluZyBvciBj
b3B5aW5nIG9mIHRoaXMgZS1tYWlsIChpbmNsdWRpbmcgaXRzIA0KYXR0YWNobWVudHMpIGJ5IHVu
aW50ZW5kZWQgcmVjaXBpZW50KHMpIGlzIHN0cmljdGx5IHByb2hpYml0ZWQgYW5kIG1heSANCmJl
IHVubGF3ZnVsLiBJZiB5b3UgYXJlIG5vdCBhbiBpbnRlbmRlZCByZWNpcGllbnQgb2YgdGhpcyBl
LW1haWwsIG9yIGJlbGlldmUNCiANCnRoYXQgeW91IGhhdmUgcmVjZWl2ZWQgdGhpcyBlLW1haWwg
aW4gZXJyb3IsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciANCmltbWVkaWF0ZWx5IChieSByZXBs
eWluZyB0byB0aGlzIGUtbWFpbCksIGRlbGV0ZSBhbnkgYW5kIGFsbCBjb3BpZXMgb2YgDQp0aGlz
IGUtbWFpbCAoaW5jbHVkaW5nIGFueSBhdHRhY2htZW50cykgZnJvbSB5b3VyIHN5c3RlbSwgYW5k
IGRvIG5vdA0KZGlzY2xvc2UgdGhlIGNvbnRlbnQgb2YgdGhpcyBlLW1haWwgdG8gYW55IG90aGVy
IHBlcnNvbi4gVGhhbmsgeW91IQ0KPC9wcmU+PCEtLX0tLT4=

--__=_Part_Boundary_001_1526666424.1104228596
Content-Type: text/plain;
	charset="utf-8";
	format=flowed
Content-Transfer-Encoding: base64

T24gNi8yLzIyIDQ6MjcgUE0sIE1hY3BhdWwgTGluIHdyb3RlOg0KPiBPbiA2LzIvMjIgMjoxOCBQ
TSwgWW9uZyBXdSB3cm90ZToNCj4+IE9uIE1vbiwgMjAyMi0wNS0zMCBhdCAyMDowMyArMDIwMCwg
RmFiaWVuIFBhcmVudCB3cm90ZToNCj4+PiBBZGQgSU9NTVUgYmluZGluZyBkb2N1bWVudGF0aW9u
IGZvciB0aGUgTVQ4MzY1IFNvQy4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IEZhYmllbiBQYXJl
bnQgPGZwYXJlbnRAYmF5bGlicmUuY29tPg0KPj4+IC0tLQ0KPj4+IMKgIC4uLi9iaW5kaW5ncy9p
b21tdS9tZWRpYXRlayxpb21tdS55YW1swqDCoMKgwqDCoMKgwqAgfMKgIDIgKw0KPj4+IMKgIGlu
Y2x1ZGUvZHQtYmluZGluZ3MvbWVtb3J5L210ODM2NS1sYXJiLXBvcnQuaCB8IDk2DQo+Pj4gKysr
KysrKysrKysrKysrKysrKw0KPj4+IMKgIDIgZmlsZXMgY2hhbmdlZCwgOTggaW5zZXJ0aW9ucygr
KQ0KPj4+IMKgIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2R0LWJpbmRpbmdzL21lbW9yeS9t
dDgzNjUtbGFyYi1wb3J0LmgNCj4+DQo+PiBbc25pcC4uLl0NCj4+DQo+Pj4gKyNpZm5kZWYgX0RU
X0JJTkRJTkdTX01FTU9SWV9NVDgzNjVfTEFSQl9QT1JUX0hfDQo+Pj4gKyNkZWZpbmUgX0RUX0JJ
TkRJTkdTX01FTU9SWV9NVDgzNjVfTEFSQl9QT1JUX0hfDQo+Pj4gKw0KPj4+ICsjaW5jbHVkZSA8
ZHQtYmluZGluZ3MvbWVtb3J5L210ay1tZW1vcnktcG9ydC5oPg0KPj4+ICsNCj4+PiArI2RlZmlu
ZSBNNFVfTEFSQjBfSUTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDANCj4+PiArI2RlZmluZSBNNFVf
TEFSQjFfSUTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDENCj4+PiArI2RlZmluZSBNNFVfTEFSQjJf
SUTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDINCj4+PiArI2RlZmluZSBNNFVfTEFSQjNfSUTCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIDMNCj4+PiArI2RlZmluZSBNNFVfTEFSQjRfSUTCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIDQNCj4+PiArI2RlZmluZSBNNFVfTEFSQjVfSUTCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIDUNCj4+PiArI2RlZmluZSBNNFVfTEFSQjZfSUTCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IDYNCj4+PiArI2RlZmluZSBNNFVfTEFSQjdfSUTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDcNCj4+
DQo+PiBSZW1vdmUgdGhlc2UuIHRoZXkgYXJlIG5vIHVzZWQsIHJpZ2h0Pw0KPiANCj4gQUlPVCBh
bmQgY3VzdG9tZXJzIGFyZSB1c2luZyB0aGUgbW9kdWxlcyBhbmQgdGhlaXIgcmVsYXRlZCBJT01N
VSBtb2R1bGVzLg0KPiBESVNQMCwgVkVOQywgVkRFQywgSVNQIChDQU1TWVMpLCBhbmQgQVBVIChh
cyBmYXIgYXMgSSBrbm93LCB3aGljaCBzaG91bGQgDQo+IGJlIFZQNj8pIHdlcmUgYWxsIHN1cHBv
cnRlZC4NCg0KRGVhciBZb25nLA0KSG93IGFib3V0IHRvIHJlcGxhY2UgdGhlIGZvbGxvd2luZyBk
ZWZpbml0aW9ucz8NCg0KRm9yIGV4YW1wbGUsIHJlcGxhY2UNCiNkZWZpbmUgTTRVX1BPUlRfRElT
UF9PVkwwCQlNVEtfTTRVX0lEKDAsIDApDQp0bw0KI2RlZmluZSBNNFVfUE9SVF9ESVNQX09WTDAg
ICAgICAgICAgICAgIE1US19NNFVfSUQoTTRVX0xBUkIwX0lEICwgMCkNCg0KPj4NCj4+PiArDQo+
Pj4gKy8qIGxhcmIwICovDQo+Pj4gKyNkZWZpbmUgTTRVX1BPUlRfRElTUF9PVkwwwqDCoMKgwqDC
oMKgwqAgTVRLX000VV9JRCgwLCAwKQ0KPj4+ICsjZGVmaW5lIE00VV9QT1JUX0RJU1BfT1ZMMF8y
TMKgwqDCoCBNVEtfTTRVX0lEKDAsIDEpDQo+Pg0KPj4gWy4uLl0NCj4+DQo+Pj4NCj4+PiArLyog
bGFyYjQgKi8NCj4+PiArI2RlZmluZSBNNFVfUE9SVF9BUFVfUkVBRMKgwqDCoMKgwqDCoMKgIE1U
S19NNFVfSUQoMCwgMCkNCj4+PiArI2RlZmluZSBNNFVfUE9SVF9BUFVfV1JJVEXCoMKgwqDCoMKg
wqDCoCBNVEtfTTRVX0lEKDAsIDEpDQo+Pg0KPj4gUGxlYXNlIHJlbW92ZSB0aGVzZSB0d28gQVBV
IGRlZmluaXRpb25zLiBjdXJyZW50bHkgdGhlc2UgYXJlIG5vdA0KPj4gc3VwcG9ydGVkLg0KPiAN
Cj4gS2lkZCwgcGxlYXNlIGhlbHAgdG8gY2hlY2sgaWYgQVBVIHVzZSB0aGVzZSBkZWZpbml0aW9u
cyB3aXRoIFlvbmcuDQo+IEhvd2V2ZXIsIEkgdGhpbmsgdGhlc2UgYXJlIGFsbCBhdmFpbGFibGUg
dG8gdGhlIGN1c3RvbWVycy4NCj4gDQo+IFRoYW5rcw0KPiBNYWNwYXVsIExpbg0KDQpUaGFua3MN
Ck1hY3BhdWwgTGlu

--__=_Part_Boundary_001_1526666424.1104228596--


--===============7399170019339297395==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============7399170019339297395==--

