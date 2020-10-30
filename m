Return-Path: <SRS0=LARK=EF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B76AC4742C
	for <iommu@archiver.kernel.org>; Fri, 30 Oct 2020 09:48:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C07B02076E
	for <iommu@archiver.kernel.org>; Fri, 30 Oct 2020 09:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="C694Ykux"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C07B02076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 333AD8691C;
	Fri, 30 Oct 2020 09:48:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hrdhn4WTR0R3; Fri, 30 Oct 2020 09:48:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7969E86849;
	Fri, 30 Oct 2020 09:48:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53974C0859;
	Fri, 30 Oct 2020 09:48:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C585C0051
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 09:48:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 601B987343
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 09:48:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vYrUTbiXYzPc for <iommu@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 09:48:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [1.203.163.78])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8841D87327
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 09:48:03 +0000 (UTC)
X-UUID: 21351c4073f648a689c52ab4d4251e96-20201030
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=v8cGljUnErOGyXls/woZ2+6cw4ahT1z+y+mRpzjqOnI=; 
 b=C694Ykuxzy2ImqF2/JEaTZU49tPIxRNp30XHmCvyI15pFtKRWgj+pbKTud44CsquWe9hPIkm3ePAozyvvCglOrwkzzGmn8nFNRo2YujEiYwo/XWMZt7IZQhr6o9RNlf3qvKy9fF4MxCJObVcvZv+M3jkbqRo2RUeLnPilQkgpX4=;
X-UUID: 21351c4073f648a689c52ab4d4251e96-20201030
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1676960176; Fri, 30 Oct 2020 17:47:53 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS32N2.mediatek.inc
 (172.27.4.72) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Fri, 30 Oct 2020 17:47:37 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 30 Oct 2020 17:47:36 +0800
Message-ID: <1604051256.26323.100.camel@mhfsdcap03>
Subject: Re: [PATCH v3 01/24] dt-bindings: iommu: mediatek: Convert IOMMU to
 DT schema
From: Yong Wu <yong.wu@mediatek.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 30 Oct 2020 17:47:36 +0800
In-Reply-To: <20201002105826.GA6888@pi3>
References: <20200930070647.10188-1-yong.wu@mediatek.com>
 <20200930070647.10188-2-yong.wu@mediatek.com> <20201002105826.GA6888@pi3>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 95CB4A984F4C283D3BFAE756878C4CE9815ECFC4A83D1BB7E41AE22707EDB5902000:8
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 Tomasz Figa <tfiga@google.com>, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 Evan Green <evgreen@chromium.org>, chao.hao@mediatek.com,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 anan.sun@mediatek.com, ming-fan.chen@mediatek.com,
 Greg Kroah-Hartman <gregkh@google.com>, kernel-team@android.com,
 linux-arm-kernel@lists.infradead.org
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
Content-Type: multipart/mixed; boundary="===============2518749325757851045=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============2518749325757851045==
Content-Type: multipart/alternative; boundary="=-Ugp5mK5+nYX/zEZyySOE"

--=-Ugp5mK5+nYX/zEZyySOE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

T24gRnJpLCAyMDIwLTEwLTAyIGF0IDEyOjU4ICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KDQo+IE9uIFdlZCwgU2VwIDMwLCAyMDIwIGF0IDAzOjA2OjI0UE0gKzA4MDAsIFlvbmcg
V3Ugd3JvdGU6DQo+ID4gQ29udmVydCBNZWRpYVRlayBJT01NVSB0byBEVCBzY2hlbWEuDQo+ID4g
DQo+ID4gU2lnbmVkLW9mZi1ieTogWW9uZyBXdSA8eW9uZy53dUBtZWRpYXRlay5jb20+DQo+ID4g
LS0tDQo+ID4gIC4uLi9iaW5kaW5ncy9pb21tdS9tZWRpYXRlayxpb21tdS50eHQgICAgICAgICB8
IDEwMyAtLS0tLS0tLS0tLS0NCj4gPiAgLi4uL2JpbmRpbmdzL2lvbW11L21lZGlhdGVrLGlvbW11
LnlhbWwgICAgICAgIHwgMTU0ICsrKysrKysrKysrKysrKysrKw0KPiA+ICAyIGZpbGVzIGNoYW5n
ZWQsIDE1NCBpbnNlcnRpb25zKCspLCAxMDMgZGVsZXRpb25zKC0pDQo+ID4gIGRlbGV0ZSBtb2Rl
IDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaW9tbXUvbWVkaWF0ZWss
aW9tbXUudHh0DQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvaW9tbXUvbWVkaWF0ZWssaW9tbXUueWFtbA0KPiA+IA0KDQoNCi4uLg0KDQoN
Cj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lvbW11
L21lZGlhdGVrLGlvbW11LnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
aW9tbXUvbWVkaWF0ZWssaW9tbXUueWFtbA0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4g
aW5kZXggMDAwMDAwMDAwMDAwLi5lYWU3NzNhZDUzYTMNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4g
KysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lvbW11L21lZGlhdGVrLGlv
bW11LnlhbWwNCj4gPiBAQCAtMCwwICsxLDE1NCBAQA0KPiA+ICsjIFNQRFgtTGljZW5zZS1JZGVu
dGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkNCj4gDQo+IFlvdSByZWxpY2Vu
c2UgR1BMdjIgY29udGVudCBzbyB5b3UgbmVlZCBhY2tzL3NpZ25lZC1vZmZzIGZyb20gZXZlcnkN
Cj4gYXV0aG9yOg0KPiANCj4gIC0gRmFiaWVuIFBhcmVudCA8ZnBhcmVudEBiYXlsaWJyZS5jb20+
DQo+ICAtIENoYW8gSGFvIDxjaGFvLmhhb0BtZWRpYXRlay5jb20+DQo+ICAtIE1hdHRoaWFzIEJy
dWdnZXIgPG1hdHRoaWFzLmJnZ0BnbWFpbC5jb20+DQo+ICAtIEhvbmdodWkgWmhhbmcgPGhvbmdo
dWkuemhhbmdAbWVkaWF0ZWsuY29tPg0KPiAoYXNzdW1pbmcgeW91cnMgaXMgaW1wbGljaXQpLg0K
PiANCj4gUGxlYXNlIHJlc2VuZCBDQy1pbmcgYWxsIHRoZSBwZW9wbGUuDQoNCg0KU29ycnksIEkg
cmVhbGx5IG1pc3NlZCB0aGlzIG1haWwuDQoNCkkgaGF2ZSBzZW50IHY0IG9ubHkgZm9yIHNtaS4g
dGhlIGlvbW11IHBhcnQgc3RpbGwgbmVlZCBzb21lIHRpbWUuDQoNClRoZSBsaWNlbnNlICJHUEwt
Mi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlIiBpcyByZXF1ZXN0ZWQgd2hlbiB3ZSBydW4NCmNoZWNr
X3BhdGNoLiBUaGF0IG1lYW5zIGVhY2ggY29udmVydGluZyBZQU1MIG5lZWQgYWxsIGNvbnRyaWJ1
dG9ycycNCmFjay9Tb0I/IA0KDQpJIGhhdmUgYWRkZWQgdGhlaXIgQ0MgaW4gdjQgc21pIGJpbmRp
bmcgZXhjZXB0IGhvbmdodWkgd2hvc2UgYWRkcmVzcyBpcw0Kbm90IGF2YWxhYmxlIG5vdy4gSSB3
aWxsIGFjdCBmb3IgaGltLg0KDQoNCj4gDQo+IA0KPiA+ICslWUFNTCAxLjINCj4gPiArLS0tDQo+
ID4gKyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvaW9tbXUvbWVkaWF0ZWssaW9t
bXUueWFtbCMNCj4gPiArJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1h
cy9jb3JlLnlhbWwjDQo+ID4gKw0KPiA+ICt0aXRsZTogTWVkaWFUZWsgSU9NTVUgQXJjaGl0ZWN0
dXJlIEltcGxlbWVudGF0aW9uDQo+ID4gKw0KDQoNCltzbmlwLi5dDQoNCg0KPiA+ICsgIG1lZGlh
dGVrLGxhcmJzOg0KPiA+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlv
bnMvcGhhbmRsZS1hcnJheQ0KPiA+ICsgICAgZGVzY3JpcHRpb246IHwNCj4gPiArICAgICAgTGlz
dCBvZiBwaGFuZGxlIHRvIHRoZSBsb2NhbCBhcmJpdGVycyBpbiB0aGUgY3VycmVudCBTb2NzLg0K
PiA+ICsgICAgICBSZWZlciB0byBiaW5kaW5ncy9tZW1vcnktY29udHJvbGxlcnMvbWVkaWF0ZWss
c21pLWxhcmIueWFtbC4gSXQgbXVzdCBzb3J0DQo+ID4gKyAgICAgIGFjY29yZGluZyB0byB0aGUg
bG9jYWwgYXJiaXRlciBpbmRleCwgbGlrZSBsYXJiMCwgbGFyYjEsIGxhcmIyLi4uDQo+IA0KPiBI
b3cgbWFueSBpdGVtcz8NCg0KDQpJIHdpbGwgYWRkIG1heGl0ZW1zIHByb3BlcnR5Lg0KDQpUaGFu
a3MuDQoNCg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4gDQo+IF9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+IExpbnV4LW1lZGlhdGVr
IG1haWxpbmcgbGlzdA0KPiBMaW51eC1tZWRpYXRla0BsaXN0cy5pbmZyYWRlYWQub3JnDQo+IGh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbWVkaWF0ZWsN
Cg0KDQo=

--=-Ugp5mK5+nYX/zEZyySOE
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: base64

PCFET0NUWVBFIEhUTUwgUFVCTElDICItLy9XM0MvL0RURCBIVE1MIDQuMCBUUkFOU0lUSU9OQUwv
L0VOIj4NCjxIVE1MPg0KPEhFQUQ+DQogIDxNRVRBIEhUVFAtRVFVSVY9IkNvbnRlbnQtVHlwZSIg
Q09OVEVOVD0idGV4dC9odG1sOyBDSEFSU0VUPVVURi04Ij4NCiAgPE1FVEEgTkFNRT0iR0VORVJB
VE9SIiBDT05URU5UPSJHdGtIVE1MLzQuNi42Ij4NCjwvSEVBRD4NCjxCT0RZPg0KT24gRnJpLCAy
MDIwLTEwLTAyIGF0IDEyOjU4ICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPEJM
T0NLUVVPVEUgVFlQRT1DSVRFPg0KPFBSRT4NCk9uIFdlZCwgU2VwIDMwLCAyMDIwIGF0IDAzOjA2
OjI0UE0gKzA4MDAsIFlvbmcgV3Ugd3JvdGU6DQo8Rk9OVCBDT0xPUj0iIzczNzM3MyI+Jmd0OyBD
b252ZXJ0IE1lZGlhVGVrIElPTU1VIHRvIERUIHNjaGVtYS48L0ZPTlQ+DQo8Rk9OVCBDT0xPUj0i
IzczNzM3MyI+Jmd0OyA8L0ZPTlQ+DQo8Rk9OVCBDT0xPUj0iIzczNzM3MyI+Jmd0OyBTaWduZWQt
b2ZmLWJ5OiBZb25nIFd1ICZsdDs8QSBIUkVGPSJtYWlsdG86eW9uZy53dUBtZWRpYXRlay5jb20i
Pnlvbmcud3VAbWVkaWF0ZWsuY29tPC9BPiZndDs8L0ZPTlQ+DQo8Rk9OVCBDT0xPUj0iIzczNzM3
MyI+Jmd0OyAtLS08L0ZPTlQ+DQo8Rk9OVCBDT0xPUj0iIzczNzM3MyI+Jmd0OyAgLi4uL2JpbmRp
bmdzL2lvbW11L21lZGlhdGVrLGlvbW11LnR4dCAgICAgICAgIHwgMTAzIC0tLS0tLS0tLS0tLTwv
Rk9OVD4NCjxGT05UIENPTE9SPSIjNzM3MzczIj4mZ3Q7ICAuLi4vYmluZGluZ3MvaW9tbXUvbWVk
aWF0ZWssaW9tbXUueWFtbCAgICAgICAgfCAxNTQgKysrKysrKysrKysrKysrKysrPC9GT05UPg0K
PEZPTlQgQ09MT1I9IiM3MzczNzMiPiZndDsgIDIgZmlsZXMgY2hhbmdlZCwgMTU0IGluc2VydGlv
bnMoKyksIDEwMyBkZWxldGlvbnMoLSk8L0ZPTlQ+DQo8Rk9OVCBDT0xPUj0iIzczNzM3MyI+Jmd0
OyAgZGVsZXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9p
b21tdS9tZWRpYXRlayxpb21tdS50eHQ8L0ZPTlQ+DQo8Rk9OVCBDT0xPUj0iIzczNzM3MyI+Jmd0
OyAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9p
b21tdS9tZWRpYXRlayxpb21tdS55YW1sPC9GT05UPg0KPEZPTlQgQ09MT1I9IiM3MzczNzMiPiZn
dDsgPC9GT05UPg0KPC9QUkU+DQo8L0JMT0NLUVVPVEU+DQo8QlI+DQouLi48QlI+DQo8QlI+DQo8
QkxPQ0tRVU9URSBUWVBFPUNJVEU+DQo8UFJFPg0KPEZPTlQgQ09MT1I9IiM3MzczNzMiPiZndDsg
ZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pb21tdS9tZWRp
YXRlayxpb21tdS55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lvbW11
L21lZGlhdGVrLGlvbW11LnlhbWw8L0ZPTlQ+DQo8Rk9OVCBDT0xPUj0iIzczNzM3MyI+Jmd0OyBu
ZXcgZmlsZSBtb2RlIDEwMDY0NDwvRk9OVD4NCjxGT05UIENPTE9SPSIjNzM3MzczIj4mZ3Q7IGlu
ZGV4IDAwMDAwMDAwMDAwMC4uZWFlNzczYWQ1M2EzPC9GT05UPg0KPEZPTlQgQ09MT1I9IiM3Mzcz
NzMiPiZndDsgLS0tIC9kZXYvbnVsbDwvRk9OVD4NCjxGT05UIENPTE9SPSIjNzM3MzczIj4mZ3Q7
ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pb21tdS9tZWRpYXRlayxp
b21tdS55YW1sPC9GT05UPg0KPEZPTlQgQ09MT1I9IiM3MzczNzMiPiZndDsgQEAgLTAsMCArMSwx
NTQgQEA8L0ZPTlQ+DQo8Rk9OVCBDT0xPUj0iIzczNzM3MyI+Jmd0OyArIyBTUERYLUxpY2Vuc2Ut
SWRlbnRpZmllcjogKEdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1c2UpPC9GT05UPg0KDQpZb3Ug
cmVsaWNlbnNlIEdQTHYyIGNvbnRlbnQgc28geW91IG5lZWQgYWNrcy9zaWduZWQtb2ZmcyBmcm9t
IGV2ZXJ5DQphdXRob3I6DQoNCiAtIEZhYmllbiBQYXJlbnQgJmx0OzxBIEhSRUY9Im1haWx0bzpm
cGFyZW50QGJheWxpYnJlLmNvbSI+ZnBhcmVudEBiYXlsaWJyZS5jb208L0E+Jmd0Ow0KIC0gQ2hh
byBIYW8gJmx0OzxBIEhSRUY9Im1haWx0bzpjaGFvLmhhb0BtZWRpYXRlay5jb20iPmNoYW8uaGFv
QG1lZGlhdGVrLmNvbTwvQT4mZ3Q7DQogLSBNYXR0aGlhcyBCcnVnZ2VyICZsdDs8QSBIUkVGPSJt
YWlsdG86bWF0dGhpYXMuYmdnQGdtYWlsLmNvbSI+bWF0dGhpYXMuYmdnQGdtYWlsLmNvbTwvQT4m
Z3Q7DQogLSBIb25naHVpIFpoYW5nICZsdDs8QSBIUkVGPSJtYWlsdG86aG9uZ2h1aS56aGFuZ0Bt
ZWRpYXRlay5jb20iPmhvbmdodWkuemhhbmdAbWVkaWF0ZWsuY29tPC9BPiZndDsNCihhc3N1bWlu
ZyB5b3VycyBpcyBpbXBsaWNpdCkuDQoNClBsZWFzZSByZXNlbmQgQ0MtaW5nIGFsbCB0aGUgcGVv
cGxlLg0KPC9QUkU+DQo8L0JMT0NLUVVPVEU+DQo8QlI+DQpTb3JyeSwgSSByZWFsbHkgbWlzc2Vk
IHRoaXMgbWFpbC48QlI+DQo8QlI+DQpJIGhhdmUgc2VudCB2NCBvbmx5IGZvciBzbWkuIHRoZSBp
b21tdSBwYXJ0IHN0aWxsIG5lZWQgc29tZSB0aW1lLjxCUj4NCjxCUj4NClRoZSBsaWNlbnNlICZx
dW90O0dQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1c2UmcXVvdDsgaXMgcmVxdWVzdGVkIHdoZW4g
d2UgcnVuIGNoZWNrX3BhdGNoLiBUaGF0IG1lYW5zIGVhY2ggY29udmVydGluZyBZQU1MIG5lZWQg
YWxsIGNvbnRyaWJ1dG9ycycgYWNrL1NvQj8gPEJSPg0KPEJSPg0KSSBoYXZlIGFkZGVkIHRoZWly
IENDIGluIHY0IHNtaSBiaW5kaW5nIGV4Y2VwdCBob25naHVpIHdob3NlIGFkZHJlc3MgaXMgbm90
IGF2YWxhYmxlIG5vdy4gSSB3aWxsIGFjdCBmb3IgaGltLjxCUj4NCjxCUj4NCjxCTE9DS1FVT1RF
IFRZUEU9Q0lURT4NCjxQUkU+DQoNCg0KPEZPTlQgQ09MT1I9IiM3MzczNzMiPiZndDsgKyVZQU1M
IDEuMjwvRk9OVD4NCjxGT05UIENPTE9SPSIjNzM3MzczIj4mZ3Q7ICstLS08L0ZPTlQ+DQo8Rk9O
VCBDT0xPUj0iIzczNzM3MyI+Jmd0OyArJGlkOiA8QSBIUkVGPSJodHRwOi8vZGV2aWNldHJlZS5v
cmcvc2NoZW1hcy9pb21tdS9tZWRpYXRlayxpb21tdS55YW1sIyI+aHR0cDovL2RldmljZXRyZWUu
b3JnL3NjaGVtYXMvaW9tbXUvbWVkaWF0ZWssaW9tbXUueWFtbCM8L0E+PC9GT05UPg0KPEZPTlQg
Q09MT1I9IiM3MzczNzMiPiZndDsgKyRzY2hlbWE6IDxBIEhSRUY9Imh0dHA6Ly9kZXZpY2V0cmVl
Lm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIyI+aHR0cDovL2RldmljZXRyZWUub3JnL21ldGEt
c2NoZW1hcy9jb3JlLnlhbWwjPC9BPjwvRk9OVD4NCjxGT05UIENPTE9SPSIjNzM3MzczIj4mZ3Q7
ICs8L0ZPTlQ+DQo8Rk9OVCBDT0xPUj0iIzczNzM3MyI+Jmd0OyArdGl0bGU6IE1lZGlhVGVrIElP
TU1VIEFyY2hpdGVjdHVyZSBJbXBsZW1lbnRhdGlvbjwvRk9OVD4NCjxGT05UIENPTE9SPSIjNzM3
MzczIj4mZ3Q7ICs8L0ZPTlQ+DQo8L1BSRT4NCjwvQkxPQ0tRVU9URT4NCjxCUj4NCltzbmlwLi5d
PEJSPg0KPEJSPg0KPEJMT0NLUVVPVEUgVFlQRT1DSVRFPg0KPFBSRT4NCjxGT05UIENPTE9SPSIj
NzM3MzczIj4mZ3Q7ICsgIG1lZGlhdGVrLGxhcmJzOjwvRk9OVD4NCjxGT05UIENPTE9SPSIjNzM3
MzczIj4mZ3Q7ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvcGhh
bmRsZS1hcnJheTwvRk9OVD4NCjxGT05UIENPTE9SPSIjNzM3MzczIj4mZ3Q7ICsgICAgZGVzY3Jp
cHRpb246IHw8L0ZPTlQ+DQo8Rk9OVCBDT0xPUj0iIzczNzM3MyI+Jmd0OyArICAgICAgTGlzdCBv
ZiBwaGFuZGxlIHRvIHRoZSBsb2NhbCBhcmJpdGVycyBpbiB0aGUgY3VycmVudCBTb2NzLjwvRk9O
VD4NCjxGT05UIENPTE9SPSIjNzM3MzczIj4mZ3Q7ICsgICAgICBSZWZlciB0byBiaW5kaW5ncy9t
ZW1vcnktY29udHJvbGxlcnMvbWVkaWF0ZWssc21pLWxhcmIueWFtbC4gSXQgbXVzdCBzb3J0PC9G
T05UPg0KPEZPTlQgQ09MT1I9IiM3MzczNzMiPiZndDsgKyAgICAgIGFjY29yZGluZyB0byB0aGUg
bG9jYWwgYXJiaXRlciBpbmRleCwgbGlrZSBsYXJiMCwgbGFyYjEsIGxhcmIyLi4uPC9GT05UPg0K
DQpIb3cgbWFueSBpdGVtcz8NCjwvUFJFPg0KPC9CTE9DS1FVT1RFPg0KPEJSPg0KSSB3aWxsIGFk
ZCBtYXhpdGVtcyBwcm9wZXJ0eS48QlI+DQo8QlI+DQpUaGFua3MuPEJSPg0KPEJSPg0KPEJMT0NL
UVVPVEUgVFlQRT1DSVRFPg0KPFBSRT4NCg0KQmVzdCByZWdhcmRzLA0KS3J6eXN6dG9mDQoNCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQpMaW51eC1tZWRp
YXRlayBtYWlsaW5nIGxpc3QNCjxBIEhSRUY9Im1haWx0bzpMaW51eC1tZWRpYXRla0BsaXN0cy5p
bmZyYWRlYWQub3JnIj5MaW51eC1tZWRpYXRla0BsaXN0cy5pbmZyYWRlYWQub3JnPC9BPg0KPEEg
SFJFRj0iaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1t
ZWRpYXRlayI+aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC1tZWRpYXRlazwvQT4NCjwvUFJFPg0KPC9CTE9DS1FVT1RFPg0KPEJSPg0KPC9CT0RZPg0KPC9I
VE1MPg0K

--=-Ugp5mK5+nYX/zEZyySOE--


--===============2518749325757851045==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============2518749325757851045==--

