Return-Path: <SRS0=cSHS=77=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDB1C433E1
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 17:34:22 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B24F208B8
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 17:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="rrebVpn2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B24F208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 0B73626450;
	Thu, 18 Jun 2020 17:34:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5u2DeF57foGx; Thu, 18 Jun 2020 17:34:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 2CD522637C;
	Thu, 18 Jun 2020 17:34:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0CB2EC088C;
	Thu, 18 Jun 2020 17:34:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72965C016E
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 17:28:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 611968890E
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 17:28:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id l5aqvwhbjyyk for <iommu@lists.linux-foundation.org>;
 Thu, 18 Jun 2020 17:28:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by whitealder.osuosl.org (Postfix) with ESMTP id 18759877BF
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 17:28:18 +0000 (UTC)
X-UUID: c343355e2a214cf48d7eee9f142d08e5-20200619
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=yNjyRymIlzIUx/0UrSoiHb16khUEPf/l+Jda96r8vqM=; 
 b=rrebVpn2C7+nZUaEsgCBMuTAm8Fc2nX5D0rwLR57cV7PdMuZNlCtYQl2OTnIfPzPhLe9LahppXwjxaTJ3qtBMS6+2zg1x2Ug9sXqcaIEmqXUNVNOFhsqJLRoWmCJFIY56Wa8un3MIqUgU7fCr2JYnNBD7YNX4Nu1MfOivj8ExtI=;
X-UUID: c343355e2a214cf48d7eee9f142d08e5-20200619
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
 (envelope-from <rick.chang@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
 with ESMTP id 1028672340; Fri, 19 Jun 2020 01:28:16 +0800
Received: from MTKCAS66.mediatek.inc (172.29.193.44) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 19 Jun 2020 01:28:11 +0800
Received: from mussux00 (172.29.97.100) by MTKCAS66.mediatek.inc
 (172.29.193.43) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 18 Jun 2020 10:28:09 -0700
Message-ID: <1592501293.13123.2.camel@mediatek.com>
Subject: Re: [PATCH v4 06/17] media: mtk-jpeg: Get rid of mtk_smi_larb_get/put
From: Rick Chang <rick.chang@mediatek.com>
To: Yong Wu <yong.wu@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>
Date: Thu, 18 Jun 2020 10:28:13 -0700
In-Reply-To: <1592472725.20080.12.camel@mhfsdcap03>
References: <1590826218-23653-1-git-send-email-yong.wu@mediatek.com>
 <1590826218-23653-7-git-send-email-yong.wu@mediatek.com>
 <1592472725.20080.12.camel@mhfsdcap03>
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
MIME-Version: 1.0
X-MTK: N
X-Mailman-Approved-At: Thu, 18 Jun 2020 17:34:17 +0000
Cc: xia.jiang@mediatek.com, Will Deacon <will.deacon@arm.com>,
 youlin.pei@mediatek.com, Nicolas Boichat <drinkcat@chromium.org>, Evan
 Green <evgreen@chromium.org>, eizan@chromium.org, Matthias
 Kaehlcke <mka@chromium.org>, devicetree@vger.kernel.org, cui.zhang@mediatek.com,
 Tomasz Figa <tfiga@google.com>, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, ming-fan.chen@mediatek.com,
 linux-arm-kernel@lists.infradead.org, anan.sun@mediatek.com,
 acourbot@chromium.org, srv_heupstream@mediatek.com,
 linux-kernel@vger.kernel.org, chao.hao@mediatek.com,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>
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

SGkgWW9uZywNCg0KT24gVGh1LCAyMDIwLTA2LTE4IGF0IDE3OjMyICswODAwLCBZb25nIFd1IHdy
b3RlOg0KPiArIFJpY2sNCj4gDQo+IE9uIFNhdCwgMjAyMC0wNS0zMCBhdCAxNjoxMCArMDgwMCwg
WW9uZyBXdSB3cm90ZToNCj4gPiANCj4gPiBNZWRpYVRlayBJT01NVSBoYXMgYWxyZWFkeSBhZGRl
ZCBkZXZpY2VfbGluayBiZXR3ZWVuIHRoZSBjb25zdW1lcg0KPiA+IGFuZCBzbWktbGFyYiBkZXZp
Y2UuIElmIHRoZSBqcGcgZGV2aWNlIGNhbGwgdGhlDQo+ID4gcG1fcnVudGltZV9nZXRfc3luYywN
Cj4gPiB0aGUgc21pLWxhcmIncyBwbV9ydW50aW1lX2dldF9zeW5jIGFsc28gYmUgY2FsbGVkIGF1
dG9tYXRpY2FsbHkuDQo+ID4gDQoNCkFja2VkLWJ5OiBSaWNrIENoYW5nIDxyaWNrLmNoYW5nQG1l
ZGlhdGVrLmNvbT4NCg0KPiA+IENDOiBSaWNrIENoYW5nIDxyaWNrLmNoYW5nQG1lZGlhdGVrLmNv
bT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBZb25nIFd1IDx5b25nLnd1QG1lZGlhdGVrLmNvbT4NCj4g
PiBSZXZpZXdlZC1ieTogRXZhbiBHcmVlbiA8ZXZncmVlbkBjaHJvbWl1bS5vcmc+DQo+ID4gLS0t
DQo+ID4gwqBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL210ay1qcGVnL210a19qcGVnX2NvcmUuYyB8
IDIyIC0tLS0tLS0tLS0tDQo+ID4gLS0tLS0tLS0tLS0NCj4gPiDCoGRyaXZlcnMvbWVkaWEvcGxh
dGZvcm0vbXRrLWpwZWcvbXRrX2pwZWdfY29yZS5oIHzCoMKgMiAtLQ0KPiA+IMKgMiBmaWxlcyBj
aGFuZ2VkLCAyNCBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9t
ZWRpYS9wbGF0Zm9ybS9tdGstanBlZy9tdGtfanBlZ19jb3JlLmMNCj4gPiBiL2RyaXZlcnMvbWVk
aWEvcGxhdGZvcm0vbXRrLWpwZWcvbXRrX2pwZWdfY29yZS5jDQo+ID4gaW5kZXggZjgyYTgxYS4u
MjFmYmE2ZiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL210ay1qcGVn
L210a19qcGVnX2NvcmUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbXRrLWpw
ZWcvbXRrX2pwZWdfY29yZS5jDQo+ID4gQEAgLTIxLDcgKzIxLDYgQEANCj4gPiDCoCNpbmNsdWRl
IDxtZWRpYS92NGwyLWlvY3RsLmg+DQo+ID4gwqAjaW5jbHVkZSA8bWVkaWEvdmlkZW9idWYyLWNv
cmUuaD4NCj4gPiDCoCNpbmNsdWRlIDxtZWRpYS92aWRlb2J1ZjItZG1hLWNvbnRpZy5oPg0KPiA+
IC0jaW5jbHVkZSA8c29jL21lZGlhdGVrL3NtaS5oPg0KPiA+IMKgDQo+ID4gwqAjaW5jbHVkZSAi
bXRrX2pwZWdfaHcuaCINCj4gPiDCoCNpbmNsdWRlICJtdGtfanBlZ19jb3JlLmgiDQo+ID4gQEAg
LTg5MywxMSArODkyLDYgQEAgc3RhdGljIGludCBtdGtfanBlZ19xdWV1ZV9pbml0KHZvaWQgKnBy
aXYsDQo+ID4gc3RydWN0IHZiMl9xdWV1ZSAqc3JjX3ZxLA0KPiA+IMKgDQo+ID4gwqBzdGF0aWMg
dm9pZCBtdGtfanBlZ19jbGtfb24oc3RydWN0IG10a19qcGVnX2RldiAqanBlZykNCj4gPiDCoHsN
Cj4gPiAtCWludCByZXQ7DQo+ID4gLQ0KPiA+IC0JcmV0ID0gbXRrX3NtaV9sYXJiX2dldChqcGVn
LT5sYXJiKTsNCj4gPiAtCWlmIChyZXQpDQo+ID4gLQkJZGV2X2VycihqcGVnLT5kZXYsICJtdGtf
c21pX2xhcmJfZ2V0IGxhcmJ2ZGVjIGZhaWwNCj4gPiAlZFxuIiwgcmV0KTsNCj4gPiDCoAljbGtf
cHJlcGFyZV9lbmFibGUoanBlZy0+Y2xrX2pkZWNfc21pKTsNCj4gPiDCoAljbGtfcHJlcGFyZV9l
bmFibGUoanBlZy0+Y2xrX2pkZWMpOw0KPiA+IMKgfQ0KPiA+IEBAIC05MDYsNyArOTAwLDYgQEAg
c3RhdGljIHZvaWQgbXRrX2pwZWdfY2xrX29mZihzdHJ1Y3QNCj4gPiBtdGtfanBlZ19kZXYgKmpw
ZWcpDQo+ID4gwqB7DQo+ID4gwqAJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGpwZWctPmNsa19qZGVj
KTsNCj4gPiDCoAljbGtfZGlzYWJsZV91bnByZXBhcmUoanBlZy0+Y2xrX2pkZWNfc21pKTsNCj4g
PiAtCW10a19zbWlfbGFyYl9wdXQoanBlZy0+bGFyYik7DQo+ID4gwqB9DQo+ID4gwqANCj4gPiDC
oHN0YXRpYyBpcnFyZXR1cm5fdCBtdGtfanBlZ19kZWNfaXJxKGludCBpcnEsIHZvaWQgKnByaXYp
DQo+ID4gQEAgLTEwNTEsMjEgKzEwNDQsNiBAQCBzdGF0aWMgaW50IG10a19qcGVnX3JlbGVhc2Uo
c3RydWN0IGZpbGUNCj4gPiAqZmlsZSkNCj4gPiDCoA0KPiA+IMKgc3RhdGljIGludCBtdGtfanBl
Z19jbGtfaW5pdChzdHJ1Y3QgbXRrX2pwZWdfZGV2ICpqcGVnKQ0KPiA+IMKgew0KPiA+IC0Jc3Ry
dWN0IGRldmljZV9ub2RlICpub2RlOw0KPiA+IC0Jc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRl
djsNCj4gPiAtDQo+ID4gLQlub2RlID0gb2ZfcGFyc2VfcGhhbmRsZShqcGVnLT5kZXYtPm9mX25v
ZGUsDQo+ID4gIm1lZGlhdGVrLGxhcmIiLCAwKTsNCj4gPiAtCWlmICghbm9kZSkNCj4gPiAtCQly
ZXR1cm4gLUVJTlZBTDsNCj4gPiAtCXBkZXYgPSBvZl9maW5kX2RldmljZV9ieV9ub2RlKG5vZGUp
Ow0KPiA+IC0JaWYgKFdBUk5fT04oIXBkZXYpKSB7DQo+ID4gLQkJb2Zfbm9kZV9wdXQobm9kZSk7
DQo+ID4gLQkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gLQl9DQo+ID4gLQlvZl9ub2RlX3B1dChub2Rl
KTsNCj4gPiAtDQo+ID4gLQlqcGVnLT5sYXJiID0gJnBkZXYtPmRldjsNCj4gPiAtDQo+ID4gwqAJ
anBlZy0+Y2xrX2pkZWMgPSBkZXZtX2Nsa19nZXQoanBlZy0+ZGV2LCAianBnZGVjIik7DQo+ID4g
wqAJaWYgKElTX0VSUihqcGVnLT5jbGtfamRlYykpDQo+ID4gwqAJCXJldHVybiBQVFJfRVJSKGpw
ZWctPmNsa19qZGVjKTsNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9t
dGstanBlZy9tdGtfanBlZ19jb3JlLmgNCj4gPiBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbXRr
LWpwZWcvbXRrX2pwZWdfY29yZS5oDQo+ID4gaW5kZXggOTk5YmQxNC4uODU3OTQ5NCAxMDA2NDQN
Cj4gPiAtLS0gYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL210ay1qcGVnL210a19qcGVnX2NvcmUu
aA0KPiA+ICsrKyBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbXRrLWpwZWcvbXRrX2pwZWdfY29y
ZS5oDQo+ID4gQEAgLTQ3LDcgKzQ3LDYgQEAgZW51bSBtdGtfanBlZ19jdHhfc3RhdGUgew0KPiA+
IMKgICogQGRlY19yZWdfYmFzZToJSlBFRyByZWdpc3RlcnMgbWFwcGluZw0KPiA+IMKgICogQGNs
a19qZGVjOgkJSlBFRyBodyB3b3JraW5nIGNsb2NrDQo+ID4gwqAgKiBAY2xrX2pkZWNfc21pOglK
UEVHIFNNSSBidXMgY2xvY2sNCj4gPiAtICogQGxhcmI6CQlTTUkgZGV2aWNlDQo+ID4gwqAgKi8N
Cj4gPiDCoHN0cnVjdCBtdGtfanBlZ19kZXYgew0KPiA+IMKgCXN0cnVjdCBtdXRleAkJbG9jazsN
Cj4gPiBAQCAtNjEsNyArNjAsNiBAQCBzdHJ1Y3QgbXRrX2pwZWdfZGV2IHsNCj4gPiDCoAl2b2lk
IF9faW9tZW0JCSpkZWNfcmVnX2Jhc2U7DQo+ID4gwqAJc3RydWN0IGNsawkJKmNsa19qZGVjOw0K
PiA+IMKgCXN0cnVjdCBjbGsJCSpjbGtfamRlY19zbWk7DQo+ID4gLQlzdHJ1Y3QgZGV2aWNlCQkq
bGFyYjsNCj4gPiDCoH07DQo+ID4gwqANCj4gPiDCoC8qKg0KPiAKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
