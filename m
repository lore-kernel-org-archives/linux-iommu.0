Return-Path: <SRS0=/9Qc=AB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2C3C433E0
	for <iommu@archiver.kernel.org>; Sat, 20 Jun 2020 02:11:28 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCCBF2242B
	for <iommu@archiver.kernel.org>; Sat, 20 Jun 2020 02:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="oX88Snpb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCCBF2242B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9E5F589B98;
	Sat, 20 Jun 2020 02:11:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 486jFnOrZeuJ; Sat, 20 Jun 2020 02:11:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 882F589B96;
	Sat, 20 Jun 2020 02:11:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 708D7C0865;
	Sat, 20 Jun 2020 02:11:25 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7057CC016E
 for <iommu@lists.linux-foundation.org>; Sat, 20 Jun 2020 02:11:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5487E88FB8
 for <iommu@lists.linux-foundation.org>; Sat, 20 Jun 2020 02:11:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P66U6nj4jmew for <iommu@lists.linux-foundation.org>;
 Sat, 20 Jun 2020 02:11:22 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [1.203.163.81])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5CE5788FA1
 for <iommu@lists.linux-foundation.org>; Sat, 20 Jun 2020 02:11:20 +0000 (UTC)
X-UUID: 32450ac669ec4a88908d6d50a7930554-20200620
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=awrtxgVTzouXk/cF6JOJADBU37rA5VHg1Qw540Ln8EI=; 
 b=oX88Snpbqwuisf0d4fJGKZpJgTyX65R28XOYnA9QsTazAQ6Zk5aCTqebH21k0LgMlgauPn7RCsaKQPNN/cW43527CmuZmX9+5w3kCt07n6v5QYwUKxyL9/XRPWoegQJ7VIErmA4NTsfLuz1aXVrs78FfmzZYc3GtG/PuxYolHkw=;
X-UUID: 32450ac669ec4a88908d6d50a7930554-20200620
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLS)
 with ESMTP id 1283716764; Sat, 20 Jun 2020 10:06:11 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS32N2.mediatek.inc
 (172.27.4.72) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Sat, 20 Jun 2020 10:06:10 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 20 Jun 2020 10:06:09 +0800
Message-ID: <1592618616.3951.12.camel@mhfsdcap03>
Subject: Re: [PATCH v4 3/7] iommu/mediatek: Set MISC_CTRL register
From: Yong Wu <yong.wu@mediatek.com>
To: chao hao <Chao.Hao@mediatek.com>
Date: Sat, 20 Jun 2020 10:03:36 +0800
In-Reply-To: <1592480963.12647.5.camel@mbjsdccf07>
References: <20200617030029.4082-1-chao.hao@mediatek.com>
 <20200617030029.4082-4-chao.hao@mediatek.com>
 <aaf422f5-2ac8-252d-a064-0c1246e09acc@gmail.com>
 <1592480963.12647.5.camel@mbjsdccf07>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: F538ED2E300F6E34F45690925A9306CEA22640E304BB45FEF2F480481BF0F5CC2000:8
X-MTK: N
Cc: devicetree@vger.kernel.org, FY Yang <fy.yang@mediatek.com>,
 wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
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
Content-Type: multipart/mixed; boundary="===============4883335373133253670=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============4883335373133253670==
Content-Type: multipart/alternative; boundary="=-YAhMcfN9HcRZ88rbUCGT"

--=-YAhMcfN9HcRZ88rbUCGT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

SGkgQ2hhbywNCg0KT24gVGh1LCAyMDIwLTA2LTE4IGF0IDE5OjQ5ICswODAwLCBjaGFvIGhhbyB3
cm90ZToNCg0KPiBPbiBXZWQsIDIwMjAtMDYtMTcgYXQgMTE6MzQgKzAyMDAsIE1hdHRoaWFzIEJy
dWdnZXIgd3JvdGU6DQoNCg0KW3NuaXBdDQoNCg0KPiA+ID4gIA0KPiA+ID4gICNkZWZpbmUgUkVH
X01NVV9NSVNDX0NUUkwJCQkweDA0OA0KPiA+ID4gKyNkZWZpbmUgRl9NTVVfSU5fT1JERVJfV1Jf
RU4JCQkoQklUKDEpIHwgQklUKDE3KSkNCj4gPiA+ICsjZGVmaW5lIEZfTU1VX1NUQU5EQVJEX0FY
SV9NT0RFX0JJVAkJKEJJVCgzKSB8IEJJVCgxOSkpDQo+ID4gPiArDQo+ID4gPiAgI2RlZmluZSBS
RUdfTU1VX0RDTV9ESVMJCQkJMHgwNTANCj4gPiA+ICANCj4gPiA+ICAjZGVmaW5lIFJFR19NTVVf
Q1RSTF9SRUcJCQkweDExMA0KPiA+ID4gQEAgLTU3OCw2ICs1ODEsMTQgQEAgc3RhdGljIGludCBt
dGtfaW9tbXVfaHdfaW5pdChjb25zdCBzdHJ1Y3QgbXRrX2lvbW11X2RhdGEgKmRhdGEpDQo+ID4g
PiAgCQl3cml0ZWxfcmVsYXhlZCgwLCBkYXRhLT5iYXNlICsgUkVHX01NVV9NSVNDX0NUUkwpOw0K
PiA+ID4gIAl9DQo+ID4gPiAgDQo+ID4gPiArCWlmIChkYXRhLT5wbGF0X2RhdGEtPmhhc19taXNj
X2N0cmwpIHsNCj4gPiANCj4gPiBUaGF0J3MgY29uZnVzaW5nLiBXZSByZW5hbWVkIHRoZSByZWdp
c3RlciB0byBtaXNjX2N0cmwsIGJ1dCBpdCdzIHByZXNlbnQgaW4gYWxsDQo+ID4gU29Dcy4gV2Ug
c2hvdWxkIGZpbmQgYSBiZXR0ZXIgbmFtZSBmb3IgdGhpcyBmbGFnIHRvIGRlc2NyaWJlIHdoYXQg
dGhlIGhhcmR3YXJlDQo+ID4gc3VwcG9ydHMuDQo+ID4gDQo+IA0KPiBvaywgdGhhbmtzIGZvciB5
b3UgYWR2aWNlLCBJIHdpbGwgcmVuYW1lIGl0IGluIG5leHQgdmVyc2lvbi4NCj4gZXg6aGFzX3Bl
cmZfcmVxKGhhcyBwZXJmb3JtYW5jZSByZXF1aXJlbWVudCkNCj4gDQo+IA0KPiA+IFJlZ2FyZHMs
DQo+ID4gTWF0dGhpYXMNCj4gPiANCj4gPiA+ICsJCS8qIEZvciBtbV9pb21tdSwgaXQgY2FuIGlt
cHJvdmUgcGVyZm9ybWFuY2UgYnkgdGhlIHNldHRpbmcgKi8NCj4gPiA+ICsJCXJlZ3ZhbCA9IHJl
YWRsX3JlbGF4ZWQoZGF0YS0+YmFzZSArIFJFR19NTVVfTUlTQ19DVFJMKTsNCj4gPiA+ICsJCXJl
Z3ZhbCAmPSB+Rl9NTVVfU1RBTkRBUkRfQVhJX01PREVfQklUOw0KPiA+ID4gKwkJcmVndmFsICY9
IH5GX01NVV9JTl9PUkRFUl9XUl9FTjsNCg0KDQpOb3RlOiBtdDI3MTIgYWxzbyBpcyBNSVNDX0NU
UkwgcmVnaXN0ZXIsIGJ1dCBpdCBkb24ndCB1c2UgdGhpcyBpbl9vcmRlcg0Kc2V0dGluZy4NCg0K
QXMgY29tbWVudGVkIGluIHYzLiAweDQ4IGlzIGVpdGhlciBTVEFOREFSRF9BWElfTU9ERSBvciBN
SVNDX0NUUkwNCnJlZ2lzdGVyLiBObyBuZWVkIHR3byBmbGFncyhyZXNldF9heGkvaGFzX3h4KSBm
b3IgaXQuDQoNCnNvbWV0aGluZyBsaWtlOg0KDQpyZWd2YWwgPSByZWFkbF9yZWxheGVkKGRhdGEt
PmJhc2UgKyBSRUdfTU1VX01JU0NfQ1RSTCk7DQppZiAocmVzZXRfYXhpKSB7DQoJcmVndmFsID0g
MDsNCn0gZWxzZSB7ICAgLyogTUlTQ19DVFJMICovDQoJaWYgKCFhcHVbMV0pDQoJCXJlZ3ZhbCAm
PSB+Rl9NTVVfU1RBTkRBUkRfQVhJX01PREVfQklUOw0KCWlmIChvdXRfb3JkZXJfZW4pDQoJCXJl
Z3ZhbCAmPSB+Rl9NTVVfSU5fT1JERVJfV1JfRU47DQp9DQp3cml0ZWxfcmVsYXhlZChyZWd2YWws
IGRhdGEtPmJhc2UgKyBSRUdfTU1VX01JU0NfQ1RSTCk7DQoNCg0KWzFdIFlvdXIgY3VycmVudCBw
YXRjaCBkb2Vzbid0IHN1cHBvcnQgYXB1LWlvbW11LCB0aHVzLCBhZGQgaXQgd2hlbg0KbmVjZXNz
YXJ5Lg0KDQoNCj4gPiA+ICsJCXdyaXRlbF9yZWxheGVkKHJlZ3ZhbCwgZGF0YS0+YmFzZSArIFJF
R19NTVVfTUlTQ19DVFJMKTsNCj4gPiA+ICsJfQ0KPiA+ID4gKw0KPiA+ID4gIAlpZiAoZGV2bV9y
ZXF1ZXN0X2lycShkYXRhLT5kZXYsIGRhdGEtPmlycSwgbXRrX2lvbW11X2lzciwgMCwNCj4gPiA+
ICAJCQkgICAgIGRldl9uYW1lKGRhdGEtPmRldiksICh2b2lkICopZGF0YSkpIHsNCj4gPiA+ICAJ
CXdyaXRlbF9yZWxheGVkKDAsIGRhdGEtPmJhc2UgKyBSRUdfTU1VX1BUX0JBU0VfQUREUik7DQo+
ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaCBiL2RyaXZlcnMvaW9t
bXUvbXRrX2lvbW11LmgNCj4gPiA+IGluZGV4IDFiNmVhODM5YjkyYy4uZDcxMWFjNjMwMDM3IDEw
MDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaA0KPiA+ID4gKysrIGIv
ZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaA0KPiA+ID4gQEAgLTQwLDYgKzQwLDcgQEAgc3RydWN0
IG10a19pb21tdV9wbGF0X2RhdGEgew0KPiA+ID4gIA0KPiA+ID4gIAkvKiBIVyB3aWxsIHVzZSB0
aGUgRU1JIGNsb2NrIGlmIHRoZXJlIGlzbid0IHRoZSAiYmNsayIuICovDQo+ID4gPiAgCWJvb2wg
ICAgICAgICAgICAgICAgaGFzX2JjbGs7DQo+ID4gPiArCWJvb2wJCSAgICBoYXNfbWlzY19jdHJs
Ow0KPiA+ID4gIAlib29sICAgICAgICAgICAgICAgIGhhc192bGRfcGFfcm5nOw0KPiA+ID4gIAli
b29sICAgICAgICAgICAgICAgIHJlc2V0X2F4aTsNCj4gPiA+ICAJdW5zaWduZWQgY2hhciAgICAg
ICBsYXJiaWRfcmVtYXBbTVRLX0xBUkJfTlJfTUFYXTsNCj4gPiA+IA0KPiANCj4gDQoNCg0K

--=-YAhMcfN9HcRZ88rbUCGT
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: base64

PCFET0NUWVBFIEhUTUwgUFVCTElDICItLy9XM0MvL0RURCBIVE1MIDQuMCBUUkFOU0lUSU9OQUwv
L0VOIj4NCjxIVE1MPg0KPEhFQUQ+DQogIDxNRVRBIEhUVFAtRVFVSVY9IkNvbnRlbnQtVHlwZSIg
Q09OVEVOVD0idGV4dC9odG1sOyBDSEFSU0VUPVVURi04Ij4NCiAgPE1FVEEgTkFNRT0iR0VORVJB
VE9SIiBDT05URU5UPSJHdGtIVE1MLzQuNi42Ij4NCjwvSEVBRD4NCjxCT0RZPg0KSGkgQ2hhbyw8
QlI+DQo8QlI+DQpPbiBUaHUsIDIwMjAtMDYtMTggYXQgMTk6NDkgKzA4MDAsIGNoYW8gaGFvIHdy
b3RlOg0KPEJMT0NLUVVPVEUgVFlQRT1DSVRFPg0KPFBSRT4NCk9uIFdlZCwgMjAyMC0wNi0xNyBh
dCAxMTozNCArMDIwMCwgTWF0dGhpYXMgQnJ1Z2dlciB3cm90ZToNCjwvUFJFPg0KPC9CTE9DS1FV
T1RFPg0KPEJSPg0KW3NuaXBdPEJSPg0KPEJSPg0KPEJMT0NLUVVPVEUgVFlQRT1DSVRFPg0KPFBS
RT4NCjxGT05UIENPTE9SPSIjNzM3MzczIj4mZ3Q7ICZndDsgIDwvRk9OVD4NCjxGT05UIENPTE9S
PSIjNzM3MzczIj4mZ3Q7ICZndDsgICNkZWZpbmUgUkVHX01NVV9NSVNDX0NUUkwJCQkweDA0ODwv
Rk9OVD4NCjxGT05UIENPTE9SPSIjNzM3MzczIj4mZ3Q7ICZndDsgKyNkZWZpbmUgRl9NTVVfSU5f
T1JERVJfV1JfRU4JCQkoQklUKDEpIHwgQklUKDE3KSk8L0ZPTlQ+DQo8Rk9OVCBDT0xPUj0iIzcz
NzM3MyI+Jmd0OyAmZ3Q7ICsjZGVmaW5lIEZfTU1VX1NUQU5EQVJEX0FYSV9NT0RFX0JJVAkJKEJJ
VCgzKSB8IEJJVCgxOSkpPC9GT05UPg0KPEZPTlQgQ09MT1I9IiM3MzczNzMiPiZndDsgJmd0OyAr
PC9GT05UPg0KPEZPTlQgQ09MT1I9IiM3MzczNzMiPiZndDsgJmd0OyAgI2RlZmluZSBSRUdfTU1V
X0RDTV9ESVMJCQkJMHgwNTA8L0ZPTlQ+DQo8Rk9OVCBDT0xPUj0iIzczNzM3MyI+Jmd0OyAmZ3Q7
ICA8L0ZPTlQ+DQo8Rk9OVCBDT0xPUj0iIzczNzM3MyI+Jmd0OyAmZ3Q7ICAjZGVmaW5lIFJFR19N
TVVfQ1RSTF9SRUcJCQkweDExMDwvRk9OVD4NCjxGT05UIENPTE9SPSIjNzM3MzczIj4mZ3Q7ICZn
dDsgQEAgLTU3OCw2ICs1ODEsMTQgQEAgc3RhdGljIGludCBtdGtfaW9tbXVfaHdfaW5pdChjb25z
dCBzdHJ1Y3QgbXRrX2lvbW11X2RhdGEgKmRhdGEpPC9GT05UPg0KPEZPTlQgQ09MT1I9IiM3Mzcz
NzMiPiZndDsgJmd0OyAgCQl3cml0ZWxfcmVsYXhlZCgwLCBkYXRhLSZndDtiYXNlICsgUkVHX01N
VV9NSVNDX0NUUkwpOzwvRk9OVD4NCjxGT05UIENPTE9SPSIjNzM3MzczIj4mZ3Q7ICZndDsgIAl9
PC9GT05UPg0KPEZPTlQgQ09MT1I9IiM3MzczNzMiPiZndDsgJmd0OyAgPC9GT05UPg0KPEZPTlQg
Q09MT1I9IiM3MzczNzMiPiZndDsgJmd0OyArCWlmIChkYXRhLSZndDtwbGF0X2RhdGEtJmd0O2hh
c19taXNjX2N0cmwpIHs8L0ZPTlQ+DQo8Rk9OVCBDT0xPUj0iIzczNzM3MyI+Jmd0OyA8L0ZPTlQ+
DQo8Rk9OVCBDT0xPUj0iIzczNzM3MyI+Jmd0OyBUaGF0J3MgY29uZnVzaW5nLiBXZSByZW5hbWVk
IHRoZSByZWdpc3RlciB0byBtaXNjX2N0cmwsIGJ1dCBpdCdzIHByZXNlbnQgaW4gYWxsPC9GT05U
Pg0KPEZPTlQgQ09MT1I9IiM3MzczNzMiPiZndDsgU29Dcy4gV2Ugc2hvdWxkIGZpbmQgYSBiZXR0
ZXIgbmFtZSBmb3IgdGhpcyBmbGFnIHRvIGRlc2NyaWJlIHdoYXQgdGhlIGhhcmR3YXJlPC9GT05U
Pg0KPEZPTlQgQ09MT1I9IiM3MzczNzMiPiZndDsgc3VwcG9ydHMuPC9GT05UPg0KPEZPTlQgQ09M
T1I9IiM3MzczNzMiPiZndDsgPC9GT05UPg0KDQpvaywgdGhhbmtzIGZvciB5b3UgYWR2aWNlLCBJ
IHdpbGwgcmVuYW1lIGl0IGluIG5leHQgdmVyc2lvbi4NCmV4Omhhc19wZXJmX3JlcShoYXMgcGVy
Zm9ybWFuY2UgcmVxdWlyZW1lbnQpDQoNCg0KPEZPTlQgQ09MT1I9IiM3MzczNzMiPiZndDsgUmVn
YXJkcyw8L0ZPTlQ+DQo8Rk9OVCBDT0xPUj0iIzczNzM3MyI+Jmd0OyBNYXR0aGlhczwvRk9OVD4N
CjxGT05UIENPTE9SPSIjNzM3MzczIj4mZ3Q7IDwvRk9OVD4NCjxGT05UIENPTE9SPSIjNzM3Mzcz
Ij4mZ3Q7ICZndDsgKwkJLyogRm9yIG1tX2lvbW11LCBpdCBjYW4gaW1wcm92ZSBwZXJmb3JtYW5j
ZSBieSB0aGUgc2V0dGluZyAqLzwvRk9OVD4NCjxGT05UIENPTE9SPSIjNzM3MzczIj4mZ3Q7ICZn
dDsgKwkJcmVndmFsID0gcmVhZGxfcmVsYXhlZChkYXRhLSZndDtiYXNlICsgUkVHX01NVV9NSVND
X0NUUkwpOzwvRk9OVD4NCjxGT05UIENPTE9SPSIjNzM3MzczIj4mZ3Q7ICZndDsgKwkJcmVndmFs
ICZhbXA7PSB+Rl9NTVVfU1RBTkRBUkRfQVhJX01PREVfQklUOzwvRk9OVD4NCjxGT05UIENPTE9S
PSIjNzM3MzczIj4mZ3Q7ICZndDsgKwkJcmVndmFsICZhbXA7PSB+Rl9NTVVfSU5fT1JERVJfV1Jf
RU47PC9GT05UPg0KPC9QUkU+DQo8L0JMT0NLUVVPVEU+DQo8QlI+DQpOb3RlOiBtdDI3MTIgYWxz
byBpcyBNSVNDX0NUUkwgcmVnaXN0ZXIsIGJ1dCBpdCBkb24ndCB1c2UgdGhpcyBpbl9vcmRlciBz
ZXR0aW5nLjxCUj4NCjxCUj4NCkFzIGNvbW1lbnRlZCBpbiB2My4gMHg0OCBpcyBlaXRoZXIgU1RB
TkRBUkRfQVhJX01PREUgb3IgTUlTQ19DVFJMIHJlZ2lzdGVyLiBObyBuZWVkIHR3byBmbGFncyhy
ZXNldF9heGkvaGFzX3h4KSBmb3IgaXQuPEJSPg0KPEJSPg0Kc29tZXRoaW5nIGxpa2U6PEJSPg0K
PEJSPg0KcmVndmFsID0gcmVhZGxfcmVsYXhlZChkYXRhLSZndDtiYXNlICsgUkVHX01NVV9NSVND
X0NUUkwpOzxCUj4NCmlmIChyZXNldF9heGkpIHs8QlI+DQoJcmVndmFsID0gMDs8QlI+DQp9IGVs
c2UgeyZuYnNwOyZuYnNwOyAvKiBNSVNDX0NUUkwgKi88QlI+DQoJaWYgKCFhcHVbMV0pPEJSPg0K
CQlyZWd2YWwgJmFtcDs9IH5GX01NVV9TVEFOREFSRF9BWElfTU9ERV9CSVQ7PEJSPg0KCWlmIChv
dXRfb3JkZXJfZW4pPEJSPg0KCQlyZWd2YWwgJmFtcDs9IH5GX01NVV9JTl9PUkRFUl9XUl9FTjs8
QlI+DQp9PEJSPg0Kd3JpdGVsX3JlbGF4ZWQocmVndmFsLCBkYXRhLSZndDtiYXNlICsgUkVHX01N
VV9NSVNDX0NUUkwpOzxCUj4NCjxCUj4NCjxCUj4NClsxXSBZb3VyIGN1cnJlbnQgcGF0Y2ggZG9l
c24ndCBzdXBwb3J0IGFwdS1pb21tdSwgdGh1cywgYWRkIGl0IHdoZW4gbmVjZXNzYXJ5LjxCUj4N
CjxCUj4NCjxCTE9DS1FVT1RFIFRZUEU9Q0lURT4NCjxQUkU+DQo8Rk9OVCBDT0xPUj0iIzczNzM3
MyI+Jmd0OyAmZ3Q7ICsJCXdyaXRlbF9yZWxheGVkKHJlZ3ZhbCwgZGF0YS0mZ3Q7YmFzZSArIFJF
R19NTVVfTUlTQ19DVFJMKTs8L0ZPTlQ+DQo8Rk9OVCBDT0xPUj0iIzczNzM3MyI+Jmd0OyAmZ3Q7
ICsJfTwvRk9OVD4NCjxGT05UIENPTE9SPSIjNzM3MzczIj4mZ3Q7ICZndDsgKzwvRk9OVD4NCjxG
T05UIENPTE9SPSIjNzM3MzczIj4mZ3Q7ICZndDsgIAlpZiAoZGV2bV9yZXF1ZXN0X2lycShkYXRh
LSZndDtkZXYsIGRhdGEtJmd0O2lycSwgbXRrX2lvbW11X2lzciwgMCw8L0ZPTlQ+DQo8Rk9OVCBD
T0xPUj0iIzczNzM3MyI+Jmd0OyAmZ3Q7ICAJCQkgICAgIGRldl9uYW1lKGRhdGEtJmd0O2Rldiks
ICh2b2lkICopZGF0YSkpIHs8L0ZPTlQ+DQo8Rk9OVCBDT0xPUj0iIzczNzM3MyI+Jmd0OyAmZ3Q7
ICAJCXdyaXRlbF9yZWxheGVkKDAsIGRhdGEtJmd0O2Jhc2UgKyBSRUdfTU1VX1BUX0JBU0VfQURE
Uik7PC9GT05UPg0KPEZPTlQgQ09MT1I9IiM3MzczNzMiPiZndDsgJmd0OyBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaCBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11Lmg8L0ZP
TlQ+DQo8Rk9OVCBDT0xPUj0iIzczNzM3MyI+Jmd0OyAmZ3Q7IGluZGV4IDFiNmVhODM5YjkyYy4u
ZDcxMWFjNjMwMDM3IDEwMDY0NDwvRk9OVD4NCjxGT05UIENPTE9SPSIjNzM3MzczIj4mZ3Q7ICZn
dDsgLS0tIGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaDwvRk9OVD4NCjxGT05UIENPTE9SPSIj
NzM3MzczIj4mZ3Q7ICZndDsgKysrIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaDwvRk9OVD4N
CjxGT05UIENPTE9SPSIjNzM3MzczIj4mZ3Q7ICZndDsgQEAgLTQwLDYgKzQwLDcgQEAgc3RydWN0
IG10a19pb21tdV9wbGF0X2RhdGEgezwvRk9OVD4NCjxGT05UIENPTE9SPSIjNzM3MzczIj4mZ3Q7
ICZndDsgIDwvRk9OVD4NCjxGT05UIENPTE9SPSIjNzM3MzczIj4mZ3Q7ICZndDsgIAkvKiBIVyB3
aWxsIHVzZSB0aGUgRU1JIGNsb2NrIGlmIHRoZXJlIGlzbid0IHRoZSAmcXVvdDtiY2xrJnF1b3Q7
LiAqLzwvRk9OVD4NCjxGT05UIENPTE9SPSIjNzM3MzczIj4mZ3Q7ICZndDsgIAlib29sICAgICAg
ICAgICAgICAgIGhhc19iY2xrOzwvRk9OVD4NCjxGT05UIENPTE9SPSIjNzM3MzczIj4mZ3Q7ICZn
dDsgKwlib29sCQkgICAgaGFzX21pc2NfY3RybDs8L0ZPTlQ+DQo8Rk9OVCBDT0xPUj0iIzczNzM3
MyI+Jmd0OyAmZ3Q7ICAJYm9vbCAgICAgICAgICAgICAgICBoYXNfdmxkX3BhX3JuZzs8L0ZPTlQ+
DQo8Rk9OVCBDT0xPUj0iIzczNzM3MyI+Jmd0OyAmZ3Q7ICAJYm9vbCAgICAgICAgICAgICAgICBy
ZXNldF9heGk7PC9GT05UPg0KPEZPTlQgQ09MT1I9IiM3MzczNzMiPiZndDsgJmd0OyAgCXVuc2ln
bmVkIGNoYXIgICAgICAgbGFyYmlkX3JlbWFwW01US19MQVJCX05SX01BWF07PC9GT05UPg0KPEZP
TlQgQ09MT1I9IiM3MzczNzMiPiZndDsgJmd0OyA8L0ZPTlQ+DQoNCg0KPC9QUkU+DQo8L0JMT0NL
UVVPVEU+DQo8QlI+DQo8L0JPRFk+DQo8L0hUTUw+DQo=

--=-YAhMcfN9HcRZ88rbUCGT--


--===============4883335373133253670==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============4883335373133253670==--

