Return-Path: <SRS0=oIyp=GY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30915C433DB
	for <iommu@archiver.kernel.org>; Thu, 21 Jan 2021 02:04:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8F692388B
	for <iommu@archiver.kernel.org>; Thu, 21 Jan 2021 02:04:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8F692388B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id F107086130;
	Thu, 21 Jan 2021 02:04:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id liCFrIiusifT; Thu, 21 Jan 2021 02:04:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 577C686B9E;
	Thu, 21 Jan 2021 02:04:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D0A4C08A1;
	Thu, 21 Jan 2021 02:04:53 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5EB63C013A
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 02:04:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 309BF2050F
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 02:04:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uL0FK5XaBf6w for <iommu@lists.linux-foundation.org>;
 Thu, 21 Jan 2021 02:04:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by silver.osuosl.org (Postfix) with ESMTPS id 43F862050D
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 02:04:47 +0000 (UTC)
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DLm0535L0zj8K4;
 Thu, 21 Jan 2021 10:03:49 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.220) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.498.0;
 Thu, 21 Jan 2021 10:04:32 +0800
Subject: Re: [PATCH 2/2] Revert "iommu/arm-smmu-v3: Don't reserve
 implementation defined register space"
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, "Mark
 Rutland" <mark.rutland@arm.com>, Joerg Roedel <joro@8bytes.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, iommu
 <iommu@lists.linux-foundation.org>, linux-kernel
 <linux-kernel@vger.kernel.org>
References: <20210119015951.1042-1-thunder.leizhen@huawei.com>
 <20210119015951.1042-3-thunder.leizhen@huawei.com>
 <888312dc-85b7-4d5e-f264-bbdd9e3638f6@arm.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <ca469958-179d-02c5-b147-0a0ff951d503@huawei.com>
Date: Thu, 21 Jan 2021 10:04:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <888312dc-85b7-4d5e-f264-bbdd9e3638f6@arm.com>
Content-Language: en-US
X-Originating-IP: [10.174.176.220]
X-CFilter-Loop: Reflected
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Neil Leeder <nleeder@codeaurora.org>
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

CgpPbiAyMDIxLzEvMjAgMjM6MDIsIFJvYmluIE11cnBoeSB3cm90ZToKPiBPbiAyMDIxLTAxLTE5
IDAxOjU5LCBaaGVuIExlaSB3cm90ZToKPj4gVGhpcyByZXZlcnRzIGNvbW1pdCA1MmYzZmFiMDA2
N2Q2ZmE5ZTk5YzFiN2Y2MzI2NWRkNDhjYTc2MDQ2Lgo+Pgo+PiBUaGlzIHByb2JsZW0gaGFzIGJl
ZW4gZml4ZWQgYnkgYW5vdGhlciBwYXRjaC4gVGhlIG9yaWdpbmFsIG1ldGhvZCBoYWQgc2lkZQo+
PiBlZmZlY3RzLCBpdCB3YXMgbm90IG1hcHBlZCB0byB0aGUgdXNlci1zcGVjaWZpZWQgcmVzb3Vy
Y2Ugc2l6ZS4gVGhlIGNvZGUKPj4gd2lsbCBiZWNvbWUgbW9yZSBjb21wbGV4IHdoZW4gRUNNRFEg
aXMgc3VwcG9ydGVkIGxhdGVyLgo+IAo+IEZXSVcgSSBkb24ndCB0aGluayB0aGF0J3MgYSBzaWdu
aWZpY2FudCBpc3N1ZSBlaXRoZXIgd2F5IC0gdGhlcmUgY291bGQgYmUgYW55IG51bWJlciBvZiBp
bXAtZGVmIHBhZ2VzIGJldHdlZW4gU01NVSBwYWdlIDAgYW5kIHRoZSBFQ01EUSBjb250cm9sIHBh
Z2VzLCBzbyBpdCB3aWxsIHN0aWxsIGJlIGxvZ2ljYWwgdG8gbWFwIHRoZW0gYXMgYW5vdGhlciBz
ZXBhcmF0ZSB0aGluZyBhbnl3YXkuCgpZZXMsIHNvIG5vdyBJJ20gdGhpbmtpbmcgb2YgcHJlc2Vy
dmluZyB0aGUgU01NVXYzIHJlc291cmNlcyBhbmQgZWxpbWluYXRpbmcgdGhlIGltcC1kZWYgYXJl
YS4gVGhlbiB1c2UgYW5vdGhlciBkZXZtX2lvcmVtYXAoKSB0byBjb3ZlciB0aGUgZW50aXJlIHJl
c291cmNl77yMYXNzaWduIGl0IHRvIHNtbXUtPmJhc2UuCk90aGVyd2lzZSwgYSBiYXNlIHBvaW50
ZXIgbmVlZHMgdG8gYmUgZGVmaW5lZCBmb3IgZWFjaCBzZXBhcmF0ZWQgcmVnaXN0ZXIgc3BhY2Xv
vIxvciBjYWxsIGEgZnVuY3Rpb24gdG8gY29udmVydCBlYWNoIHRpbWUuCgo+IAo+IFJvYmluLgo+
IAo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuIExlaSA8dGh1bmRlci5sZWl6aGVuQGh1YXdlaS5jb20+
Cj4+IC0tLQo+PiDCoCBkcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My5j
IHwgMzIgKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPj4gwqAgZHJpdmVycy9pb21tdS9h
cm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMuaCB8wqAgMyAtLS0KPj4gwqAgMiBmaWxlcyBjaGFu
Z2VkLCA0IGluc2VydGlvbnMoKyksIDMxIGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMuYyBiL2RyaXZlcnMvaW9t
bXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLmMKPj4gaW5kZXggOGNhNzQxNWQ3ODVkOWJm
Li40NzdmNDczODQyZTUyNzIgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1z
bW11LXYzL2FybS1zbW11LXYzLmMKPj4gKysrIGIvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUt
djMvYXJtLXNtbXUtdjMuYwo+PiBAQCAtOTEsOCArOTEsOSBAQCBzdHJ1Y3QgYXJtX3NtbXVfb3B0
aW9uX3Byb3Agewo+PiDCoCBzdGF0aWMgaW5saW5lIHZvaWQgX19pb21lbSAqYXJtX3NtbXVfcGFn
ZTFfZml4dXAodW5zaWduZWQgbG9uZyBvZmZzZXQsCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGFybV9zbW11X2RldmljZSAqc21t
dSkKPj4gwqAgewo+PiAtwqDCoMKgIGlmIChvZmZzZXQgPiBTWl82NEspCj4+IC3CoMKgwqDCoMKg
wqDCoCByZXR1cm4gc21tdS0+cGFnZTEgKyBvZmZzZXQgLSBTWl82NEs7Cj4+ICvCoMKgwqAgaWYg
KChvZmZzZXQgPiBTWl82NEspICYmCj4+ICvCoMKgwqDCoMKgwqDCoCAoc21tdS0+b3B0aW9ucyAm
IEFSTV9TTU1VX09QVF9QQUdFMF9SRUdTX09OTFkpKQo+PiArwqDCoMKgwqDCoMKgwqAgb2Zmc2V0
IC09IFNaXzY0SzsKPj4gwqAgwqDCoMKgwqDCoCByZXR1cm4gc21tdS0+YmFzZSArIG9mZnNldDsK
Pj4gwqAgfQo+PiBAQCAtMzQ4NiwxOCArMzQ4Nyw2IEBAIHN0YXRpYyBpbnQgYXJtX3NtbXVfc2V0
X2J1c19vcHMoc3RydWN0IGlvbW11X29wcyAqb3BzKQo+PiDCoMKgwqDCoMKgIHJldHVybiBlcnI7
Cj4+IMKgIH0KPj4gwqAgLXN0YXRpYyB2b2lkIF9faW9tZW0gKmFybV9zbW11X2lvcmVtYXAoc3Ry
dWN0IGRldmljZSAqZGV2LCByZXNvdXJjZV9zaXplX3Qgc3RhcnQsCj4+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVzb3VyY2Vfc2l6ZV90IHNpemUpCj4+IC17
Cj4+IC3CoMKgwqAgc3RydWN0IHJlc291cmNlIHJlcyA9IHsKPj4gLcKgwqDCoMKgwqDCoMKgIC5m
bGFncyA9IElPUkVTT1VSQ0VfTUVNLAo+PiAtwqDCoMKgwqDCoMKgwqAgLnN0YXJ0ID0gc3RhcnQs
Cj4+IC3CoMKgwqDCoMKgwqDCoCAuZW5kID0gc3RhcnQgKyBzaXplIC0gMSwKPj4gLcKgwqDCoCB9
Owo+PiAtCj4+IC3CoMKgwqAgcmV0dXJuIGRldm1faW9yZW1hcF9yZXNvdXJjZShkZXYsICZyZXMp
Owo+PiAtfQo+PiAtCj4+IMKgIHN0YXRpYyBpbnQgYXJtX3NtbXVfZGV2aWNlX3Byb2JlKHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCj4+IMKgIHsKPj4gwqDCoMKgwqDCoCBpbnQgaXJxLCBy
ZXQ7Cj4+IEBAIC0zNTMzLDIzICszNTIyLDEwIEBAIHN0YXRpYyBpbnQgYXJtX3NtbXVfZGV2aWNl
X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCj4+IMKgwqDCoMKgwqAgfQo+PiDC
oMKgwqDCoMKgIGlvYWRkciA9IHJlcy0+c3RhcnQ7Cj4+IMKgIC3CoMKgwqAgLyoKPj4gLcKgwqDC
oMKgICogRG9uJ3QgbWFwIHRoZSBJTVBMRU1FTlRBVElPTiBERUZJTkVEIHJlZ2lvbnMsIHNpbmNl
IHRoZXkgbWF5IGNvbnRhaW4KPj4gLcKgwqDCoMKgICogdGhlIFBNQ0cgcmVnaXN0ZXJzIHdoaWNo
IGFyZSByZXNlcnZlZCBieSB0aGUgUE1VIGRyaXZlci4KPj4gLcKgwqDCoMKgICovCj4+IC3CoMKg
wqAgc21tdS0+YmFzZSA9IGFybV9zbW11X2lvcmVtYXAoZGV2LCBpb2FkZHIsIEFSTV9TTU1VX1JF
R19TWik7Cj4+ICvCoMKgwqAgc21tdS0+YmFzZSA9IGRldm1faW9yZW1hcF9yZXNvdXJjZShkZXYs
IHJlcyk7Cj4+IMKgwqDCoMKgwqAgaWYgKElTX0VSUihzbW11LT5iYXNlKSkKPj4gwqDCoMKgwqDC
oMKgwqDCoMKgIHJldHVybiBQVFJfRVJSKHNtbXUtPmJhc2UpOwo+PiDCoCAtwqDCoMKgIGlmIChh
cm1fc21tdV9yZXNvdXJjZV9zaXplKHNtbXUpID4gU1pfNjRLKSB7Cj4+IC3CoMKgwqDCoMKgwqDC
oCBzbW11LT5wYWdlMSA9IGFybV9zbW11X2lvcmVtYXAoZGV2LCBpb2FkZHIgKyBTWl82NEssCj4+
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEFS
TV9TTU1VX1JFR19TWik7Cj4+IC3CoMKgwqDCoMKgwqDCoCBpZiAoSVNfRVJSKHNtbXUtPnBhZ2Ux
KSkKPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIFBUUl9FUlIoc21tdS0+cGFnZTEp
Owo+PiAtwqDCoMKgIH0gZWxzZSB7Cj4+IC3CoMKgwqDCoMKgwqDCoCBzbW11LT5wYWdlMSA9IHNt
bXUtPmJhc2U7Cj4+IC3CoMKgwqAgfQo+PiAtCj4+IMKgwqDCoMKgwqAgLyogSW50ZXJydXB0IGxp
bmVzICovCj4+IMKgIMKgwqDCoMKgwqAgaXJxID0gcGxhdGZvcm1fZ2V0X2lycV9ieW5hbWVfb3B0
aW9uYWwocGRldiwgImNvbWJpbmVkIik7Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2Fy
bS9hcm0tc21tdS12My9hcm0tc21tdS12My5oIGIvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUt
djMvYXJtLXNtbXUtdjMuaAo+PiBpbmRleCA5NmMyZTk1NjVlMDAyODIuLjBjMzA5MGM2MDg0MGMy
MiAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUt
djMuaAo+PiArKysgYi9kcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My5o
Cj4+IEBAIC0xNTIsOCArMTUyLDYgQEAKPj4gwqAgI2RlZmluZSBBUk1fU01NVV9QUklRX0lSUV9D
RkcxwqDCoMKgwqDCoMKgwqAgMHhkOAo+PiDCoCAjZGVmaW5lIEFSTV9TTU1VX1BSSVFfSVJRX0NG
RzLCoMKgwqDCoMKgwqDCoCAweGRjCj4+IMKgIC0jZGVmaW5lIEFSTV9TTU1VX1JFR19TWsKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgMHhlMDAKPj4gLQo+PiDCoCAvKiBDb21tb24gTVNJIGNvbmZpZyBm
aWVsZHMgKi8KPj4gwqAgI2RlZmluZSBNU0lfQ0ZHMF9BRERSX01BU0vCoMKgwqDCoMKgwqDCoCBH
RU5NQVNLX1VMTCg1MSwgMikKPj4gwqAgI2RlZmluZSBNU0lfQ0ZHMl9TSMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgR0VOTUFTSyg1LCA0KQo+PiBAQCAtNTg0LDcgKzU4Miw2IEBAIHN0cnVjdCBhcm1f
c21tdV9zdHJ0YWJfY2ZnIHsKPj4gwqAgc3RydWN0IGFybV9zbW11X2RldmljZSB7Cj4+IMKgwqDC
oMKgwqAgc3RydWN0IGRldmljZcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKmRldjsKPj4gwqDCoMKg
wqDCoCB2b2lkIF9faW9tZW3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgICpiYXNlOwo+PiAtwqDCoMKg
IHZvaWQgX19pb21lbcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKnBhZ2UxOwo+PiDCoCDCoCAjZGVm
aW5lIEFSTV9TTU1VX0ZFQVRfMl9MVkxfU1RSVEFCwqDCoMKgICgxIDw8IDApCj4+IMKgICNkZWZp
bmUgQVJNX1NNTVVfRkVBVF8yX0xWTF9DRFRBQsKgwqDCoCAoMSA8PCAxKQo+Pgo+IAo+IC4KPiAK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1h
aWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
