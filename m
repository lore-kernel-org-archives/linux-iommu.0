Return-Path: <SRS0=gpU2=JR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FB0C433B4
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 05:59:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAA33613AE
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 05:59:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAA33613AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 63BCF607C2;
	Tue, 20 Apr 2021 05:59:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UT16BWP2c7t2; Tue, 20 Apr 2021 05:59:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 719266060D;
	Tue, 20 Apr 2021 05:59:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5568EC000F;
	Tue, 20 Apr 2021 05:59:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CAA1BC000B
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 05:59:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A32DB40420
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 05:59:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ux2oPbWa0afm for <iommu@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 05:59:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4BAF24041A
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 05:59:24 +0000 (UTC)
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FPXy36y6Jz17QkQ;
 Tue, 20 Apr 2021 13:56:59 +0800 (CST)
Received: from [127.0.0.1] (10.40.193.166) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.498.0; Tue, 20 Apr 2021
 13:59:17 +0800
Subject: Re: [RFC PATCH v5 11/15] iommu/io-pgtable-arm: Implement
 arm_lpae_map_pages()
To: "Isaac J. Manjarres" <isaacm@codeaurora.org>,
 <iommu@lists.linux-foundation.org>, <linux-arm-kernel@lists.infradead.org>
References: <20210408171402.12607-1-isaacm@codeaurora.org>
 <20210408171402.12607-12-isaacm@codeaurora.org>
From: "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <ab7e8274-b679-a8da-405d-ad880f189316@hisilicon.com>
Date: Tue, 20 Apr 2021 13:59:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20210408171402.12607-12-isaacm@codeaurora.org>
X-Originating-IP: [10.40.193.166]
X-CFilter-Loop: Reflected
Cc: will@kernel.org, robin.murphy@arm.com, pratikp@codeaurora.org
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

SGkgSXNhYWMsCgoK5ZyoIDIwMjEvNC85IDE6MTMsIElzYWFjIEouIE1hbmphcnJlcyDlhpnpgZM6
Cj4gSW1wbGVtZW50IHRoZSBtYXBfcGFnZXMoKSBjYWxsYmFjayBmb3IgdGhlIEFSTSBMUEFFIGlv
LXBndGFibGUKPiBmb3JtYXQuCj4KPiBTaWduZWQtb2ZmLWJ5OiBJc2FhYyBKLiBNYW5qYXJyZXMg
PGlzYWFjbUBjb2RlYXVyb3JhLm9yZz4KPiAtLS0KPiAgIGRyaXZlcnMvaW9tbXUvaW8tcGd0YWJs
ZS1hcm0uYyB8IDQyICsrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0KPiAgIDEgZmls
ZSBjaGFuZ2VkLCAzMiBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2lvbW11L2lvLXBndGFibGUtYXJtLmMgYi9kcml2ZXJzL2lvbW11L2lvLXBn
dGFibGUtYXJtLmMKPiBpbmRleCAxYjY5MDkxMTk5NWEuLjkyOTc4ZGQ5Yzg4NSAxMDA2NDQKPiAt
LS0gYS9kcml2ZXJzL2lvbW11L2lvLXBndGFibGUtYXJtLmMKPiArKysgYi9kcml2ZXJzL2lvbW11
L2lvLXBndGFibGUtYXJtLmMKPiBAQCAtMzQ0LDIwICszNDQsMzAgQEAgc3RhdGljIGFybV9scGFl
X2lvcHRlIGFybV9scGFlX2luc3RhbGxfdGFibGUoYXJtX2xwYWVfaW9wdGUgKnRhYmxlLAo+ICAg
fQo+ICAgCj4gICBzdGF0aWMgaW50IF9fYXJtX2xwYWVfbWFwKHN0cnVjdCBhcm1fbHBhZV9pb19w
Z3RhYmxlICpkYXRhLCB1bnNpZ25lZCBsb25nIGlvdmEsCj4gLQkJCSAgcGh5c19hZGRyX3QgcGFk
ZHIsIHNpemVfdCBzaXplLCBhcm1fbHBhZV9pb3B0ZSBwcm90LAo+IC0JCQkgIGludCBsdmwsIGFy
bV9scGFlX2lvcHRlICpwdGVwLCBnZnBfdCBnZnApCj4gKwkJCSAgcGh5c19hZGRyX3QgcGFkZHIs
IHNpemVfdCBzaXplLCBzaXplX3QgcGdjb3VudCwKPiArCQkJICBhcm1fbHBhZV9pb3B0ZSBwcm90
LCBpbnQgbHZsLCBhcm1fbHBhZV9pb3B0ZSAqcHRlcCwKPiArCQkJICBnZnBfdCBnZnAsIHNpemVf
dCAqbWFwcGVkKQo+ICAgewo+ICAgCWFybV9scGFlX2lvcHRlICpjcHRlcCwgcHRlOwo+ICAgCXNp
emVfdCBibG9ja19zaXplID0gQVJNX0xQQUVfQkxPQ0tfU0laRShsdmwsIGRhdGEpOwo+ICAgCXNp
emVfdCB0YmxzeiA9IEFSTV9MUEFFX0dSQU5VTEUoZGF0YSk7Cj4gICAJc3RydWN0IGlvX3BndGFi
bGVfY2ZnICpjZmcgPSAmZGF0YS0+aW9wLmNmZzsKPiArCWludCByZXQgPSAwLCBudW1fZW50cmll
cywgbWF4X2VudHJpZXMsIG1hcF9pZHhfc3RhcnQ7Cj4gICAKPiAgIAkvKiBGaW5kIG91ciBlbnRy
eSBhdCB0aGUgY3VycmVudCBsZXZlbCAqLwo+IC0JcHRlcCArPSBBUk1fTFBBRV9MVkxfSURYKGlv
dmEsIGx2bCwgZGF0YSk7Cj4gKwltYXBfaWR4X3N0YXJ0ID0gQVJNX0xQQUVfTFZMX0lEWChpb3Zh
LCBsdmwsIGRhdGEpOwo+ICsJcHRlcCArPSBtYXBfaWR4X3N0YXJ0Owo+ICAgCj4gICAJLyogSWYg
d2UgY2FuIGluc3RhbGwgYSBsZWFmIGVudHJ5IGF0IHRoaXMgbGV2ZWwsIHRoZW4gZG8gc28gKi8K
PiAtCWlmIChzaXplID09IGJsb2NrX3NpemUpCj4gLQkJcmV0dXJuIGFybV9scGFlX2luaXRfcHRl
KGRhdGEsIGlvdmEsIHBhZGRyLCBwcm90LCBsdmwsIDEsIHB0ZXApOwo+ICsJaWYgKHNpemUgPT0g
YmxvY2tfc2l6ZSkgewo+ICsJCW1heF9lbnRyaWVzID0gQVJNX0xQQUVfUFRFU19QRVJfVEFCTEUo
ZGF0YSkgLSBtYXBfaWR4X3N0YXJ0Owo+ICsJCW51bV9lbnRyaWVzID0gbWluX3QoaW50LCBwZ2Nv
dW50LCBtYXhfZW50cmllcyk7Cj4gKwkJcmV0ID0gYXJtX2xwYWVfaW5pdF9wdGUoZGF0YSwgaW92
YSwgcGFkZHIsIHByb3QsIGx2bCwgbnVtX2VudHJpZXMsIHB0ZXApOwo+ICsJCWlmICghcmV0ICYm
IG1hcHBlZCkKPiArCQkJKm1hcHBlZCArPSBudW1fZW50cmllcyAqIHNpemU7Cj4gKwo+ICsJCXJl
dHVybiByZXQ7Cj4gKwl9Cj4gICAKPiAgIAkvKiBXZSBjYW4ndCBhbGxvY2F0ZSB0YWJsZXMgYXQg
dGhlIGZpbmFsIGxldmVsICovCj4gICAJaWYgKFdBUk5fT04obHZsID49IEFSTV9MUEFFX01BWF9M
RVZFTFMgLSAxKSkKPiBAQCAtMzg2LDcgKzM5Niw4IEBAIHN0YXRpYyBpbnQgX19hcm1fbHBhZV9t
YXAoc3RydWN0IGFybV9scGFlX2lvX3BndGFibGUgKmRhdGEsIHVuc2lnbmVkIGxvbmcgaW92YSwK
PiAgIAl9Cj4gICAKPiAgIAkvKiBSaW5zZSwgcmVwZWF0ICovCj4gLQlyZXR1cm4gX19hcm1fbHBh
ZV9tYXAoZGF0YSwgaW92YSwgcGFkZHIsIHNpemUsIHByb3QsIGx2bCArIDEsIGNwdGVwLCBnZnAp
Owo+ICsJcmV0dXJuIF9fYXJtX2xwYWVfbWFwKGRhdGEsIGlvdmEsIHBhZGRyLCBzaXplLCBwZ2Nv
dW50LCBwcm90LCBsdmwgKyAxLAo+ICsJCQkgICAgICBjcHRlcCwgZ2ZwLCBtYXBwZWQpOwo+ICAg
fQo+ICAgCj4gICBzdGF0aWMgYXJtX2xwYWVfaW9wdGUgYXJtX2xwYWVfcHJvdF90b19wdGUoc3Ry
dWN0IGFybV9scGFlX2lvX3BndGFibGUgKmRhdGEsCj4gQEAgLTQ1Myw4ICs0NjQsOSBAQCBzdGF0
aWMgYXJtX2xwYWVfaW9wdGUgYXJtX2xwYWVfcHJvdF90b19wdGUoc3RydWN0IGFybV9scGFlX2lv
X3BndGFibGUgKmRhdGEsCj4gICAJcmV0dXJuIHB0ZTsKPiAgIH0KPiAgIAo+IC1zdGF0aWMgaW50
IGFybV9scGFlX21hcChzdHJ1Y3QgaW9fcGd0YWJsZV9vcHMgKm9wcywgdW5zaWduZWQgbG9uZyBp
b3ZhLAo+IC0JCQlwaHlzX2FkZHJfdCBwYWRkciwgc2l6ZV90IHNpemUsIGludCBpb21tdV9wcm90
LCBnZnBfdCBnZnApCj4gK3N0YXRpYyBpbnQgYXJtX2xwYWVfbWFwX3BhZ2VzKHN0cnVjdCBpb19w
Z3RhYmxlX29wcyAqb3BzLCB1bnNpZ25lZCBsb25nIGlvdmEsCj4gKwkJCSAgICAgIHBoeXNfYWRk
cl90IHBhZGRyLCBzaXplX3QgcGdzaXplLCBzaXplX3QgcGdjb3VudCwKPiArCQkJICAgICAgaW50
IGlvbW11X3Byb3QsIGdmcF90IGdmcCwgc2l6ZV90ICptYXBwZWQpCj4gICB7Cj4gICAJc3RydWN0
IGFybV9scGFlX2lvX3BndGFibGUgKmRhdGEgPSBpb19wZ3RhYmxlX29wc190b19kYXRhKG9wcyk7
Cj4gICAJc3RydWN0IGlvX3BndGFibGVfY2ZnICpjZmcgPSAmZGF0YS0+aW9wLmNmZzsKPiBAQCAt
NDYzLDcgKzQ3NSw3IEBAIHN0YXRpYyBpbnQgYXJtX2xwYWVfbWFwKHN0cnVjdCBpb19wZ3RhYmxl
X29wcyAqb3BzLCB1bnNpZ25lZCBsb25nIGlvdmEsCj4gICAJYXJtX2xwYWVfaW9wdGUgcHJvdDsK
PiAgIAlsb25nIGlhZXh0ID0gKHM2NClpb3ZhID4+IGNmZy0+aWFzOwo+ICAgCj4gLQlpZiAoV0FS
Tl9PTighc2l6ZSB8fCAoc2l6ZSAmIGNmZy0+cGdzaXplX2JpdG1hcCkgIT0gc2l6ZSkpCj4gKwlp
ZiAoV0FSTl9PTighcGdzaXplIHx8IChwZ3NpemUgJiBjZmctPnBnc2l6ZV9iaXRtYXApICE9IHBn
c2l6ZSkpCj4gICAJCXJldHVybiAtRUlOVkFMOwo+ICAgCj4gICAJaWYgKGNmZy0+cXVpcmtzICYg
SU9fUEdUQUJMRV9RVUlSS19BUk1fVFRCUjEpCj4gQEAgLTQ3Niw3ICs0ODgsOCBAQCBzdGF0aWMg
aW50IGFybV9scGFlX21hcChzdHJ1Y3QgaW9fcGd0YWJsZV9vcHMgKm9wcywgdW5zaWduZWQgbG9u
ZyBpb3ZhLAo+ICAgCQlyZXR1cm4gMDsKPiAgIAo+ICAgCXByb3QgPSBhcm1fbHBhZV9wcm90X3Rv
X3B0ZShkYXRhLCBpb21tdV9wcm90KTsKPiAtCXJldCA9IF9fYXJtX2xwYWVfbWFwKGRhdGEsIGlv
dmEsIHBhZGRyLCBzaXplLCBwcm90LCBsdmwsIHB0ZXAsIGdmcCk7Cj4gKwlyZXQgPSBfX2FybV9s
cGFlX21hcChkYXRhLCBpb3ZhLCBwYWRkciwgcGdzaXplLCBwZ2NvdW50LCBwcm90LCBsdmwsCj4g
KwkJCSAgICAgcHRlcCwgZ2ZwLCBOVUxMKTsKClRoZSBsYXN0IGlucHV0IHBhcmFtZXRlciBzaG91
bGQgYmUgbWFwcGVkIGluc3RlYWQgb2YgTlVMTC4KCj4gICAJLyoKPiAgIAkgKiBTeW5jaHJvbmlz
ZSBhbGwgUFRFIHVwZGF0ZXMgZm9yIHRoZSBuZXcgbWFwcGluZyBiZWZvcmUgdGhlcmUncwo+ICAg
CSAqIGEgY2hhbmNlIGZvciBhbnl0aGluZyB0byBraWNrIG9mZiBhIHRhYmxlIHdhbGsgZm9yIHRo
ZSBuZXcgaW92YS4KPiBAQCAtNDg2LDYgKzQ5OSwxNCBAQCBzdGF0aWMgaW50IGFybV9scGFlX21h
cChzdHJ1Y3QgaW9fcGd0YWJsZV9vcHMgKm9wcywgdW5zaWduZWQgbG9uZyBpb3ZhLAo+ICAgCXJl
dHVybiByZXQ7Cj4gICB9Cj4gICAKPiArCj4gK3N0YXRpYyBpbnQgYXJtX2xwYWVfbWFwKHN0cnVj
dCBpb19wZ3RhYmxlX29wcyAqb3BzLCB1bnNpZ25lZCBsb25nIGlvdmEsCj4gKwkJCXBoeXNfYWRk
cl90IHBhZGRyLCBzaXplX3Qgc2l6ZSwgaW50IGlvbW11X3Byb3QsIGdmcF90IGdmcCkKPiArewo+
ICsJcmV0dXJuIGFybV9scGFlX21hcF9wYWdlcyhvcHMsIGlvdmEsIHBhZGRyLCBzaXplLCAxLCBp
b21tdV9wcm90LCBnZnAsCj4gKwkJCQkgIE5VTEwpOwo+ICt9Cj4gKwo+ICAgc3RhdGljIHZvaWQg
X19hcm1fbHBhZV9mcmVlX3BndGFibGUoc3RydWN0IGFybV9scGFlX2lvX3BndGFibGUgKmRhdGEs
IGludCBsdmwsCj4gICAJCQkJICAgIGFybV9scGFlX2lvcHRlICpwdGVwKQo+ICAgewo+IEBAIC03
ODIsNiArODAzLDcgQEAgYXJtX2xwYWVfYWxsb2NfcGd0YWJsZShzdHJ1Y3QgaW9fcGd0YWJsZV9j
ZmcgKmNmZykKPiAgIAo+ICAgCWRhdGEtPmlvcC5vcHMgPSAoc3RydWN0IGlvX3BndGFibGVfb3Bz
KSB7Cj4gICAJCS5tYXAJCT0gYXJtX2xwYWVfbWFwLAo+ICsJCS5tYXBfcGFnZXMJPSBhcm1fbHBh
ZV9tYXBfcGFnZXMsCj4gICAJCS51bm1hcAkJPSBhcm1fbHBhZV91bm1hcCwKPiAgIAkJLnVubWFw
X3BhZ2VzCT0gYXJtX2xwYWVfdW5tYXBfcGFnZXMsCj4gICAJCS5pb3ZhX3RvX3BoeXMJPSBhcm1f
bHBhZV9pb3ZhX3RvX3BoeXMsCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2lvbW11
