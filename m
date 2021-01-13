Return-Path: <SRS0=lzux=GQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17D5C433DB
	for <iommu@archiver.kernel.org>; Wed, 13 Jan 2021 15:28:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E464233ED
	for <iommu@archiver.kernel.org>; Wed, 13 Jan 2021 15:28:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E464233ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 170B82E0DE;
	Wed, 13 Jan 2021 15:28:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QqKRq8ExtZKd; Wed, 13 Jan 2021 15:27:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id E8F80204F3;
	Wed, 13 Jan 2021 15:27:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA1F4C0893;
	Wed, 13 Jan 2021 15:27:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04DEFC013A
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 15:27:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id DD6178699B
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 15:27:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zcV9oL4qHTrE for <iommu@lists.linux-foundation.org>;
 Wed, 13 Jan 2021 15:27:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6FC3886987
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 15:27:53 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE5B5142F;
 Wed, 13 Jan 2021 07:27:52 -0800 (PST)
Received: from [10.57.56.43] (unknown [10.57.56.43])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D92A83F66E;
 Wed, 13 Jan 2021 07:27:39 -0800 (PST)
Subject: Re: [RFC PATCH v3 2/6] swiotlb: Add restricted DMA pool
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
 Florian Fainelli <f.fainelli@gmail.com>, Claire Chang
 <tientzu@chromium.org>, robh+dt@kernel.org, mpe@ellerman.id.au,
 benh@kernel.crashing.org, paulus@samba.org, joro@8bytes.org,
 will@kernel.org, frowand.list@gmail.com, konrad.wilk@oracle.com,
 boris.ostrovsky@oracle.com, jgross@suse.com, sstabellini@kernel.org,
 hch@lst.de, m.szyprowski@samsung.com
References: <20210106034124.30560-1-tientzu@chromium.org>
 <20210106034124.30560-3-tientzu@chromium.org>
 <95ae9c1e-c1f1-5736-fe86-12ced1f648f9@gmail.com>
 <7ed51025f051f65f3dfe10a88caeb648821994b1.camel@suse.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <4c4989b5-f825-7e04-ca66-038cf6b9d5e9@arm.com>
Date: Wed, 13 Jan 2021 15:27:34 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <7ed51025f051f65f3dfe10a88caeb648821994b1.camel@suse.de>
Content-Language: en-GB
Cc: devicetree@vger.kernel.org, heikki.krogerus@linux.intel.com,
 grant.likely@arm.com, saravanak@google.com, peterz@infradead.org,
 xypron.glpk@gmx.de, rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org,
 treding@nvidia.com, bgolaszewski@baylibre.com,
 iommu@lists.linux-foundation.org, drinkcat@chromium.org, rdunlap@infradead.org,
 gregkh@linuxfoundation.org, xen-devel@lists.xenproject.org,
 dan.j.williams@intel.com, andriy.shevchenko@linux.intel.com,
 linuxppc-dev@lists.ozlabs.org, mingo@kernel.org
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

T24gMjAyMS0wMS0xMyAxMzo1OSwgTmljb2xhcyBTYWVueiBKdWxpZW5uZSB3cm90ZToKPiBIaSBB
bGwsCj4gCj4gT24gVHVlLCAyMDIxLTAxLTEyIGF0IDE2OjAzIC0wODAwLCBGbG9yaWFuIEZhaW5l
bGxpIHdyb3RlOgo+PiBPbiAxLzUvMjEgNzo0MSBQTSwgQ2xhaXJlIENoYW5nIHdyb3RlOgo+Pj4g
QWRkIHRoZSBpbml0aWFsaXphdGlvbiBmdW5jdGlvbiB0byBjcmVhdGUgcmVzdHJpY3RlZCBETUEg
cG9vbHMgZnJvbQo+Pj4gbWF0Y2hpbmcgcmVzZXJ2ZWQtbWVtb3J5IG5vZGVzIGluIHRoZSBkZXZp
Y2UgdHJlZS4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBDbGFpcmUgQ2hhbmcgPHRpZW50enVAY2hy
b21pdW0ub3JnPgo+Pj4gLS0tCj4+PiAgwqBpbmNsdWRlL2xpbnV4L2RldmljZS5oICB8ICAgNCAr
Kwo+Pj4gIMKgaW5jbHVkZS9saW51eC9zd2lvdGxiLmggfCAgIDcgKy0KPj4+ICDCoGtlcm5lbC9k
bWEvS2NvbmZpZyAgICAgIHwgICAxICsKPj4+ICDCoGtlcm5lbC9kbWEvc3dpb3RsYi5jICAgIHwg
MTQ0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0KPj4+ICDCoDQgZmls
ZXMgY2hhbmdlZCwgMTMxIGluc2VydGlvbnMoKyksIDI1IGRlbGV0aW9ucygtKQo+Pj4KPj4+IGRp
ZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2RldmljZS5oIGIvaW5jbHVkZS9saW51eC9kZXZpY2Uu
aAo+Pj4gaW5kZXggODliYjhiODQxNzNlLi5jYTZmNzFlYzg4NzEgMTAwNjQ0Cj4+PiAtLS0gYS9p
bmNsdWRlL2xpbnV4L2RldmljZS5oCj4+PiArKysgYi9pbmNsdWRlL2xpbnV4L2RldmljZS5oCj4+
PiBAQCAtNDEzLDYgKzQxMyw3IEBAIHN0cnVjdCBkZXZfbGlua3NfaW5mbyB7Cj4+PiAgwqDCoCog
QGRtYV9wb29sczoJRG1hIHBvb2xzIChpZiBkbWEnYmxlIGRldmljZSkuCj4+PiAgwqDCoCogQGRt
YV9tZW06CUludGVybmFsIGZvciBjb2hlcmVudCBtZW0gb3ZlcnJpZGUuCj4+PiAgwqDCoCogQGNt
YV9hcmVhOglDb250aWd1b3VzIG1lbW9yeSBhcmVhIGZvciBkbWEgYWxsb2NhdGlvbnMKPj4+ICsg
KiBAZG1hX2lvX3RsYl9tZW06IEludGVybmFsIGZvciBzd2lvdGxiIGlvX3RsYl9tZW0gb3ZlcnJp
ZGUuCj4+PiAgwqDCoCogQGFyY2hkYXRhOglGb3IgYXJjaC1zcGVjaWZpYyBhZGRpdGlvbnMuCj4+
PiAgwqDCoCogQG9mX25vZGU6CUFzc29jaWF0ZWQgZGV2aWNlIHRyZWUgbm9kZS4KPj4+ICDCoMKg
KiBAZndub2RlOglBc3NvY2lhdGVkIGRldmljZSBub2RlIHN1cHBsaWVkIGJ5IHBsYXRmb3JtIGZp
cm13YXJlLgo+Pj4gQEAgLTUxNSw2ICs1MTYsOSBAQCBzdHJ1Y3QgZGV2aWNlIHsKPj4+ICDCoCNp
ZmRlZiBDT05GSUdfRE1BX0NNQQo+Pj4gIMKgCXN0cnVjdCBjbWEgKmNtYV9hcmVhOwkJLyogY29u
dGlndW91cyBtZW1vcnkgYXJlYSBmb3IgZG1hCj4+PiAgwqAJCQkJCSAgIGFsbG9jYXRpb25zICov
Cj4+PiArI2VuZGlmCj4+PiArI2lmZGVmIENPTkZJR19TV0lPVExCCj4+PiArCXN0cnVjdCBpb190
bGJfbWVtCSpkbWFfaW9fdGxiX21lbTsKPj4+ICDCoCNlbmRpZgo+Pj4gIMKgCS8qIGFyY2ggc3Bl
Y2lmaWMgYWRkaXRpb25zICovCj4+PiAgwqAJc3RydWN0IGRldl9hcmNoZGF0YQlhcmNoZGF0YTsK
Pj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3N3aW90bGIuaCBiL2luY2x1ZGUvbGludXgv
c3dpb3RsYi5oCj4+PiBpbmRleCBkZDhlYjU3Y2JiOGYuLmExYmJkNzc4ODg4NSAxMDA2NDQKPj4+
IC0tLSBhL2luY2x1ZGUvbGludXgvc3dpb3RsYi5oCj4+PiArKysgYi9pbmNsdWRlL2xpbnV4L3N3
aW90bGIuaAo+Pj4gQEAgLTc2LDEyICs3NiwxMyBAQCBleHRlcm4gZW51bSBzd2lvdGxiX2ZvcmNl
IHN3aW90bGJfZm9yY2U7Cj4+PiAgwqDCoCoKPj4+ICDCoMKgKiBAc3RhcnQ6CVRoZSBzdGFydCBh
ZGRyZXNzIG9mIHRoZSBzd2lvdGxiIG1lbW9yeSBwb29sLiBVc2VkIHRvIGRvIGEgcXVpY2sKPj4+
ICDCoMKgKgkJcmFuZ2UgY2hlY2sgdG8gc2VlIGlmIHRoZSBtZW1vcnkgd2FzIGluIGZhY3QgYWxs
b2NhdGVkIGJ5IHRoaXMKPj4+IC0gKgkJQVBJLgo+Pj4gKyAqCQlBUEkuIEZvciByZXN0cmljdGVk
IERNQSBwb29sLCB0aGlzIGlzIGRldmljZSB0cmVlIGFkanVzdGFibGUuCj4+Cj4+IE1heWJlIHdy
aXRlIGl0IGFzIHRoaXMgaXMgImZpcm13YXJlIGFkanVzdGFibGUiIHN1Y2ggdGhhdCB3aGVuL2lm
IEFDUEkKPj4gbmVlZHMgc29tZXRoaW5nIGxpa2UgdGhpcywgdGhlIGRlc2NyaXB0aW9uIGRvZXMg
bm90IG5lZWQgdXBkYXRpbmcuCgpUQkggSSByZWFsbHkgZG9uJ3QgdGhpbmsgdGhpcyBuZWVkcyBj
YWxsaW5nIG91dCBhdCBhbGwuIEV2ZW4gaW4gdGhlIApyZWd1bGFyIGNhc2UsIHRoZSBkZXRhaWxz
IG9mIGV4YWN0bHkgaG93IGFuZCB3aGVyZSB0aGUgcG9vbCBpcyBhbGxvY2F0ZWQgCmFyZSBiZXlv
bmQgdGhlIHNjb3BlIG9mIHRoaXMgY29kZSAtIGFyY2hpdGVjdHVyZXMgYWxyZWFkeSBoYXZlIHNl
dmVyYWwgCndheXMgdG8gY29udHJvbCB0aGF0IGFuZCBtYWtlIHRoZWlyIG93biBkZWNpc2lvbnMu
Cgo+Pgo+PiBbc25pcF0KPj4KPj4+ICtzdGF0aWMgaW50IHJtZW1fc3dpb3RsYl9kZXZpY2VfaW5p
dChzdHJ1Y3QgcmVzZXJ2ZWRfbWVtICpybWVtLAo+Pj4gKwkJCQkgICAgc3RydWN0IGRldmljZSAq
ZGV2KQo+Pj4gK3sKPj4+ICsJc3RydWN0IGlvX3RsYl9tZW0gKm1lbSA9IHJtZW0tPnByaXY7Cj4+
PiArCWludCByZXQ7Cj4+PiArCj4+PiArCWlmIChkZXYtPmRtYV9pb190bGJfbWVtKQo+Pj4gKwkJ
cmV0dXJuIC1FQlVTWTsKPj4+ICsKPj4+ICsJaWYgKCFtZW0pIHsKPj4+ICsJCW1lbSA9IGt6YWxs
b2Moc2l6ZW9mKCptZW0pLCBHRlBfS0VSTkVMKTsKPj4+ICsJCWlmICghbWVtKQo+Pj4gKwkJCXJl
dHVybiAtRU5PTUVNOwo+Pj4gKwo+Pj4gKwkJaWYgKCFtZW1yZW1hcChybWVtLT5iYXNlLCBybWVt
LT5zaXplLCBNRU1SRU1BUF9XQikpIHsKPj4KPj4gTUVNUkVNQVBfV0Igc291bmRzIGFwcHJvcHJp
YXRlIGFzIGEgZGVmYXVsdC4KPiAKPiBBcyBwZXIgdGhlIGJpbmRpbmcgJ25vLW1hcCcgaGFzIHRv
IGJlIGRpc2FibGVkIGhlcmUuIFNvIEFGQUlVLCB0aGlzIG1lbW9yeSB3aWxsCj4gYmUgcGFydCBv
ZiB0aGUgbGluZWFyIG1hcHBpbmcuIElzIHRoaXMgcmVhbGx5IG5lZWRlZCB0aGVuPwoKTW9yZSB0
aGFuIHRoYXQsIEknZCBhc3N1bWUgdGhhdCB3ZSAqaGF2ZSogdG8gdXNlIHRoZSBsaW5lYXIvZGly
ZWN0IG1hcCAKYWRkcmVzcyByYXRoZXIgdGhhbiBhbnl0aGluZyB0aGF0IGhhcyBhbnkgcG9zc2li
aWxpdHkgb2YgYmVpbmcgYSB2bWFsbG9jIApyZW1hcCwgb3RoZXJ3aXNlIHdlIGNhbiBubyBsb25n
ZXIgc2FmZWx5IHJlbHkgb24gCnBoeXNfdG9fZG1hL2RtYV90b19waHlzLCBubz8KClRoYXQgc2Fp
ZCwgZ2l2ZW4gdGhhdCB3ZSdyZSBub3QgYWN0dWFsbHkgdXNpbmcgdGhlIHJldHVybmVkIGFkZHJl
c3MsIEknbSAKbm90IGVudGlyZWx5IHN1cmUgd2hhdCB0aGUgcG9pbnQgb2YgdGhpcyBjYWxsIGlz
IGFueXdheS4gSWYgd2UgY2FuIAphc3N1bWUgaXQncyBhbHdheXMgZ29pbmcgdG8gcmV0dXJuIHRo
ZSBsaW5lYXIgbWFwIGFkZHJlc3MgdmlhIAp0cnlfcmFtX3JlbWFwKCkgdGhlbiB3ZSBjYW4gZXF1
YWxseSBqdXN0IGdvIGFoZWFkIGFuZCB1c2UgdGhlIGxpbmVhciBtYXAgCmFkZHJlc3Mgc3RyYWln
aHQgYXdheS4gSSBkb24ndCByZWFsbHkgc2VlIGhvdyB3ZSBjb3VsZCBldmVyIGhpdCB0aGUgCiJp
c19yYW0gPT0gUkVHSU9OX01JWEVEIiBjYXNlIGluIG1lbXJlbWFwKCkgdGhhdCB3b3VsZCByZXR1
cm4gTlVMTCwgaWYgCndlIHBhc3NlZCB0aGUgbWVtYmxvY2sgY2hlY2sgZWFybGllciBpbiBfX3Jl
c2VydmVkX21lbV9hbGxvY19zaXplKCkgc3VjaCAKdGhhdCB0aGlzIHJtZW0gbm9kZSBldmVyIGdv
dCB0byBiZSBpbml0aWFsaXNlZCBhdCBhbGwuCgpSb2Jpbi4KCj4+IERvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9yZXNlcnZlZC1tZW1vcnkvcmFtb29wcy50eHQgZG9lcwo+PiBkZWZp
bmUgYW4gInVuYnVmZmVyZWQiIHByb3BlcnR5IHdoaWNoIGluIHByZW1pc2UgY291bGQgYmUgYXBw
bGllZCB0byB0aGUKPj4gZ2VuZXJpYyByZXNlcnZlZCBtZW1vcnkgYmluZGluZyBhcyB3ZWxsIGFu
ZCB0aGF0IHdlIG1heSBoYXZlIHRvIGJlCj4+IGhvbm9yaW5nIGhlcmUsIGlmIHdlIHdlcmUgdG8g
bWFrZSBpdCBtb3JlIGdlbmVyaWMuIE9oIHdlbGwsIHRoaXMgZG9lcwo+PiBub3QgbmVlZCB0byBi
ZSBhZGRyZXNzZWQgcmlnaHQgbm93IEkgZ3Vlc3MuCj4gCj4gCj4gCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
