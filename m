Return-Path: <SRS0=REuq=G4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C8BC433DB
	for <iommu@archiver.kernel.org>; Mon, 25 Jan 2021 22:21:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76E6E20756
	for <iommu@archiver.kernel.org>; Mon, 25 Jan 2021 22:21:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76E6E20756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 163E085764;
	Mon, 25 Jan 2021 22:21:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ix7JsQUtkPTV; Mon, 25 Jan 2021 22:21:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 752CD85277;
	Mon, 25 Jan 2021 22:21:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F084C08A1;
	Mon, 25 Jan 2021 22:21:23 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A1941C013A
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 22:21:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8918D85277
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 22:21:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S10dlpdIebBA for <iommu@lists.linux-foundation.org>;
 Mon, 25 Jan 2021 22:21:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id AD6A485259
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 22:21:19 +0000 (UTC)
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.56])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4DPknF0Jh8z5KT1;
 Tue, 26 Jan 2021 06:19:45 +0800 (CST)
Received: from dggpemm100010.china.huawei.com (7.185.36.24) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Tue, 26 Jan 2021 06:21:15 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggpemm100010.china.huawei.com (7.185.36.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Tue, 26 Jan 2021 06:21:14 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.006;
 Tue, 26 Jan 2021 06:21:14 +0800
From: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, "Wangzhou (B)" <wangzhou1@hisilicon.com>
Subject: RE: [RFC PATCH v2] uacce: Add uacce_ctrl misc device
Thread-Topic: [RFC PATCH v2] uacce: Add uacce_ctrl misc device
Thread-Index: AQHW8vWniUnMS+RFOU2UJJCa8sDlvKo39q+AgADtcaA=
Date: Mon, 25 Jan 2021 22:21:14 +0000
Message-ID: <96b655ade2534a65974a378bb68383ee@hisilicon.com>
References: <1611563696-235269-1-git-send-email-wangzhou1@hisilicon.com>
 <20210125154717.GW4605@ziepe.ca>
In-Reply-To: <20210125154717.GW4605@ziepe.ca>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.203.227]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "chensihang \(A\)" <chensihang1@hisilicon.com>,
 Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Zhangfei Gao <zhangfei.gao@linaro.org>,
 "Liguozhu \(Kenneth\)" <liguozhu@hisilicon.com>,
 "linux-accelerators@lists.ozlabs.org" <linux-accelerators@lists.ozlabs.org>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFzb24gR3VudGhvcnBl
IFttYWlsdG86amdnQHppZXBlLmNhXQ0KPiBTZW50OiBUdWVzZGF5LCBKYW51YXJ5IDI2LCAyMDIx
IDQ6NDcgQU0NCj4gVG86IFdhbmd6aG91IChCKSA8d2FuZ3pob3UxQGhpc2lsaWNvbi5jb20+DQo+
IENjOiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPjsgQXJu
ZCBCZXJnbWFubg0KPiA8YXJuZEBhcm5kYi5kZT47IFpoYW5nZmVpIEdhbyA8emhhbmdmZWkuZ2Fv
QGxpbmFyby5vcmc+Ow0KPiBsaW51eC1hY2NlbGVyYXRvcnNAbGlzdHMub3psYWJzLm9yZzsgbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmc7IGxpbnV4LW1tQGt2YWNrLm9yZzsgU29uZyBCYW8gSHVhIChCYXJyeSBTb25nKQ0KPiA8
c29uZy5iYW8uaHVhQGhpc2lsaWNvbi5jb20+OyBMaWd1b3podSAoS2VubmV0aCkgPGxpZ3Vvemh1
QGhpc2lsaWNvbi5jb20+Ow0KPiBjaGVuc2loYW5nIChBKSA8Y2hlbnNpaGFuZzFAaGlzaWxpY29u
LmNvbT4NCj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggdjJdIHVhY2NlOiBBZGQgdWFjY2VfY3Ry
bCBtaXNjIGRldmljZQ0KPiANCj4gT24gTW9uLCBKYW4gMjUsIDIwMjEgYXQgMDQ6MzQ6NTZQTSAr
MDgwMCwgWmhvdSBXYW5nIHdyb3RlOg0KPiANCj4gPiArc3RhdGljIGludCB1YWNjZV9waW5fcGFn
ZShzdHJ1Y3QgdWFjY2VfcGluX2NvbnRhaW5lciAqcHJpdiwNCj4gPiArCQkJICBzdHJ1Y3QgdWFj
Y2VfcGluX2FkZHJlc3MgKmFkZHIpDQo+ID4gK3sNCj4gPiArCXVuc2lnbmVkIGludCBmbGFncyA9
IEZPTExfRk9SQ0UgfCBGT0xMX1dSSVRFOw0KPiA+ICsJdW5zaWduZWQgbG9uZyBmaXJzdCwgbGFz
dCwgbnJfcGFnZXM7DQo+ID4gKwlzdHJ1Y3QgcGFnZSAqKnBhZ2VzOw0KPiA+ICsJc3RydWN0IHBp
bl9wYWdlcyAqcDsNCj4gPiArCWludCByZXQ7DQo+ID4gKw0KPiA+ICsJZmlyc3QgPSAoYWRkci0+
YWRkciAmIFBBR0VfTUFTSykgPj4gUEFHRV9TSElGVDsNCj4gPiArCWxhc3QgPSAoKGFkZHItPmFk
ZHIgKyBhZGRyLT5zaXplIC0gMSkgJiBQQUdFX01BU0spID4+IFBBR0VfU0hJRlQ7DQo+ID4gKwlu
cl9wYWdlcyA9IGxhc3QgLSBmaXJzdCArIDE7DQo+ID4gKw0KPiA+ICsJcGFnZXMgPSB2bWFsbG9j
KG5yX3BhZ2VzICogc2l6ZW9mKHN0cnVjdCBwYWdlICopKTsNCj4gPiArCWlmICghcGFnZXMpDQo+
ID4gKwkJcmV0dXJuIC1FTk9NRU07DQo+ID4gKw0KPiA+ICsJcCA9IGt6YWxsb2Moc2l6ZW9mKCpw
KSwgR0ZQX0tFUk5FTCk7DQo+ID4gKwlpZiAoIXApIHsNCj4gPiArCQlyZXQgPSAtRU5PTUVNOw0K
PiA+ICsJCWdvdG8gZnJlZTsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlyZXQgPSBwaW5fdXNlcl9w
YWdlc19mYXN0KGFkZHItPmFkZHIgJiBQQUdFX01BU0ssIG5yX3BhZ2VzLA0KPiA+ICsJCQkJICBm
bGFncyB8IEZPTExfTE9OR1RFUk0sIHBhZ2VzKTsNCj4gDQo+IFRoaXMgbmVlZHMgdG8gY29weSB0
aGUgUkxJTUlUX01FTUxPQ0sgYW5kIGNhbl9kb19tbG9jaygpIHN0dWZmIGZyb20NCj4gb3RoZXIg
cGxhY2VzLCBsaWtlIGliX3VtZW1fZ2V0DQo+IA0KPiA+ICsJcmV0ID0geGFfZXJyKHhhX3N0b3Jl
KCZwcml2LT5hcnJheSwgcC0+Zmlyc3QsIHAsIEdGUF9LRVJORUwpKTsNCj4gDQo+IEFuZCB0aGlz
IGlzIHJlYWxseSB3ZWlyZCwgSSBkb24ndCB0aGluayBpdCBtYWtlcyBzZW5zZSB0byBtYWtlIGhh
bmRsZXMNCj4gZm9yIERNQSBiYXNlZCBvbiB0aGUgc3RhcnRpbmcgVkEuDQo+IA0KPiA+ICtzdGF0
aWMgaW50IHVhY2NlX3VucGluX3BhZ2Uoc3RydWN0IHVhY2NlX3Bpbl9jb250YWluZXIgKnByaXYs
DQo+ID4gKwkJCSAgICBzdHJ1Y3QgdWFjY2VfcGluX2FkZHJlc3MgKmFkZHIpDQo+ID4gK3sNCj4g
PiArCXVuc2lnbmVkIGxvbmcgZmlyc3QsIGxhc3QsIG5yX3BhZ2VzOw0KPiA+ICsJc3RydWN0IHBp
bl9wYWdlcyAqcDsNCj4gPiArDQo+ID4gKwlmaXJzdCA9IChhZGRyLT5hZGRyICYgUEFHRV9NQVNL
KSA+PiBQQUdFX1NISUZUOw0KPiA+ICsJbGFzdCA9ICgoYWRkci0+YWRkciArIGFkZHItPnNpemUg
LSAxKSAmIFBBR0VfTUFTSykgPj4gUEFHRV9TSElGVDsNCj4gPiArCW5yX3BhZ2VzID0gbGFzdCAt
IGZpcnN0ICsgMTsNCj4gPiArDQo+ID4gKwkvKiBmaW5kIHBpbl9wYWdlcyAqLw0KPiA+ICsJcCA9
IHhhX2xvYWQoJnByaXYtPmFycmF5LCBmaXJzdCk7DQo+ID4gKwlpZiAoIXApDQo+ID4gKwkJcmV0
dXJuIC1FTk9ERVY7DQo+ID4gKw0KPiA+ICsJaWYgKHAtPm5yX3BhZ2VzICE9IG5yX3BhZ2VzKQ0K
PiA+ICsJCXJldHVybiAtRUlOVkFMOw0KPiA+ICsNCj4gPiArCS8qIHVucGluICovDQo+ID4gKwl1
bnBpbl91c2VyX3BhZ2VzKHAtPnBhZ2VzLCBwLT5ucl9wYWdlcyk7DQo+IA0KPiBBbmQgdW5waW5u
aW5nIHdpdGhvdXQgZ3VhcmFudGVlaW5nIHRoZXJlIGlzIG5vIG9uZ29pbmcgRE1BIGlzIHJlYWxs
eQ0KPiB3ZWlyZA0KDQpJbiBTVkEgY2FzZSwga2VybmVsIGhhcyBubyBpZGVhIGlmIGFjY2VsZXJh
dG9ycyBhcmUgYWNjZXNzaW5nDQp0aGUgbWVtb3J5IHNvIEkgd291bGQgYXNzdW1lIFNWQSBoYXMg
YSBtZXRob2QgdG8gcHJldmVudA0KdGhlIHBhZ2VzIGJlaW5nIHRyYW5zZmVycmVkIGZyb20gbWln
cmF0aW9uIG9yIHJlbGVhc2UuIE90aGVyd2lzZSwNClNWQSB3aWxsIGNyYXNoIGVhc2lseSBpbiBh
IHN5c3RlbSB3aXRoIGhpZ2ggbWVtb3J5IHByZXNzdXJlLg0KDQpBbnl3YXksIFRoaXMgaXMgYSBw
cm9ibGVtIHdvcnRoIGZ1cnRoZXIgaW52ZXN0aWdhdGluZy4NCg0KPiANCj4gQXJlIHlvdSBhYnVz
aW5nIHRoaXMgaW4gY29uanVuY3Rpb24gd2l0aCBhIFNWQSBzY2hlbWUganVzdCB0byBwcmV2ZW50
DQo+IHBhZ2UgbW90aW9uPyBXaHkgd2Fzbid0IG1sb2NrIGdvb2QgZW5vdWdoPw0KDQpQYWdlIG1p
Z3JhdGlvbiB3b24ndCBjYXVzZSBhbnkgZGlzZnVuY3Rpb24gaW4gU1ZBIGNhc2UgYXMgSU8gcGFn
ZQ0KZmF1bHQgd2lsbCBnZXQgYSB2YWxpZCBwYWdlIGFnYWluLiBJdCBpcyBvbmx5IGEgcGVyZm9y
bWFuY2UgaXNzdWUNCmFzIElPIHBhZ2UgZmF1bHQgaGFzIGxhcmdlciBsYXRlbmN5IHRoYW4gdGhl
IHVzdWFsIHBhZ2UgZmF1bHQsDQp3b3VsZCBiZSAzLTgw74K0c2xvd2VyIHRoYW4gcGFnZSBmYXVs
dFsxXQ0KDQptbG9jaywgd2hpbGUgY2VydGFpbmx5IGJlIGFibGUgdG8gcHJldmVudCBzd2FwcGlu
ZyBvdXQsIGl0IHdvbid0DQpiZSBhYmxlIHRvIHN0b3AgcGFnZSBtb3ZpbmcgZHVlIHRvOg0KKiBt
ZW1vcnkgY29tcGFjdGlvbiBpbiBhbGxvY19wYWdlcygpDQoqIG1ha2luZyBodWdlIHBhZ2VzDQoq
IG51bWEgYmFsYW5jZQ0KKiBtZW1vcnkgY29tcGFjdGlvbiBpbiBDTUENCmV0Yy4NCg0KWzFdIGh0
dHBzOi8vaWVlZXhwbG9yZS5pZWVlLm9yZy9zdGFtcC9zdGFtcC5qc3A/dHA9JmFybnVtYmVyPTc0
ODIwOTEmdGFnPTENCj4gDQo+IEphc29uDQoNClRoYW5rcw0KQmFycnkNCg0KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0Cmlv
bW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
