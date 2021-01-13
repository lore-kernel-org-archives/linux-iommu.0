Return-Path: <SRS0=lzux=GQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B63C433DB
	for <iommu@archiver.kernel.org>; Wed, 13 Jan 2021 18:03:38 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D67521534
	for <iommu@archiver.kernel.org>; Wed, 13 Jan 2021 18:03:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D67521534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 612CC8734E;
	Wed, 13 Jan 2021 18:03:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X6DtXom4RGpS; Wed, 13 Jan 2021 18:03:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D633C87351;
	Wed, 13 Jan 2021 18:03:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A0FF2C0893;
	Wed, 13 Jan 2021 18:03:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D745AC013A
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 18:03:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C140D86958
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 18:03:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 29CF5S74Qwck for <iommu@lists.linux-foundation.org>;
 Wed, 13 Jan 2021 18:03:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 60AE186948
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 18:03:28 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1C051FB;
 Wed, 13 Jan 2021 10:03:27 -0800 (PST)
Received: from [10.57.56.43] (unknown [10.57.56.43])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D66F23F66E;
 Wed, 13 Jan 2021 10:03:18 -0800 (PST)
Subject: Re: [RFC PATCH v3 2/6] swiotlb: Add restricted DMA pool
To: Florian Fainelli <f.fainelli@gmail.com>,
 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
 Claire Chang <tientzu@chromium.org>, robh+dt@kernel.org, mpe@ellerman.id.au,
 benh@kernel.crashing.org, paulus@samba.org, joro@8bytes.org,
 will@kernel.org, frowand.list@gmail.com, konrad.wilk@oracle.com,
 boris.ostrovsky@oracle.com, jgross@suse.com, sstabellini@kernel.org,
 hch@lst.de, m.szyprowski@samsung.com
References: <20210106034124.30560-1-tientzu@chromium.org>
 <20210106034124.30560-3-tientzu@chromium.org>
 <95ae9c1e-c1f1-5736-fe86-12ced1f648f9@gmail.com>
 <7ed51025f051f65f3dfe10a88caeb648821994b1.camel@suse.de>
 <4c4989b5-f825-7e04-ca66-038cf6b9d5e9@arm.com>
 <9b4fe35f-a880-fcea-0591-b65406abbfa8@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <7cb70e95-f352-5fde-cc0a-b2a65b07ef29@arm.com>
Date: Wed, 13 Jan 2021 18:03:16 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <9b4fe35f-a880-fcea-0591-b65406abbfa8@gmail.com>
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

T24gMjAyMS0wMS0xMyAxNzo0MywgRmxvcmlhbiBGYWluZWxsaSB3cm90ZToKPiBPbiAxLzEzLzIx
IDc6MjcgQU0sIFJvYmluIE11cnBoeSB3cm90ZToKPj4gT24gMjAyMS0wMS0xMyAxMzo1OSwgTmlj
b2xhcyBTYWVueiBKdWxpZW5uZSB3cm90ZToKPj4+IEhpIEFsbCwKPj4+Cj4+PiBPbiBUdWUsIDIw
MjEtMDEtMTIgYXQgMTY6MDMgLTA4MDAsIEZsb3JpYW4gRmFpbmVsbGkgd3JvdGU6Cj4+Pj4gT24g
MS81LzIxIDc6NDEgUE0sIENsYWlyZSBDaGFuZyB3cm90ZToKPj4+Pj4gQWRkIHRoZSBpbml0aWFs
aXphdGlvbiBmdW5jdGlvbiB0byBjcmVhdGUgcmVzdHJpY3RlZCBETUEgcG9vbHMgZnJvbQo+Pj4+
PiBtYXRjaGluZyByZXNlcnZlZC1tZW1vcnkgbm9kZXMgaW4gdGhlIGRldmljZSB0cmVlLgo+Pj4+
Pgo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBDbGFpcmUgQ2hhbmcgPHRpZW50enVAY2hyb21pdW0ub3Jn
Pgo+Pj4+PiAtLS0KPj4+Pj4gIMKgwqBpbmNsdWRlL2xpbnV4L2RldmljZS5owqAgfMKgwqAgNCAr
Kwo+Pj4+PiAgwqDCoGluY2x1ZGUvbGludXgvc3dpb3RsYi5oIHzCoMKgIDcgKy0KPj4+Pj4gIMKg
wqBrZXJuZWwvZG1hL0tjb25maWfCoMKgwqDCoMKgIHzCoMKgIDEgKwo+Pj4+PiAgwqDCoGtlcm5l
bC9kbWEvc3dpb3RsYi5jwqDCoMKgIHwgMTQ0Cj4+Pj4+ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKystLS0tLS0KPj4+Pj4gIMKgwqA0IGZpbGVzIGNoYW5nZWQsIDEzMSBpbnNlcnRp
b25zKCspLCAyNSBkZWxldGlvbnMoLSkKPj4+Pj4KPj4+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUv
bGludXgvZGV2aWNlLmggYi9pbmNsdWRlL2xpbnV4L2RldmljZS5oCj4+Pj4+IGluZGV4IDg5YmI4
Yjg0MTczZS4uY2E2ZjcxZWM4ODcxIDEwMDY0NAo+Pj4+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L2Rl
dmljZS5oCj4+Pj4+ICsrKyBiL2luY2x1ZGUvbGludXgvZGV2aWNlLmgKPj4+Pj4gQEAgLTQxMyw2
ICs0MTMsNyBAQCBzdHJ1Y3QgZGV2X2xpbmtzX2luZm8gewo+Pj4+PiAgwqDCoMKgKiBAZG1hX3Bv
b2xzOsKgwqDCoCBEbWEgcG9vbHMgKGlmIGRtYSdibGUgZGV2aWNlKS4KPj4+Pj4gIMKgwqDCoCog
QGRtYV9tZW06wqDCoMKgIEludGVybmFsIGZvciBjb2hlcmVudCBtZW0gb3ZlcnJpZGUuCj4+Pj4+
ICDCoMKgwqAqIEBjbWFfYXJlYTrCoMKgwqAgQ29udGlndW91cyBtZW1vcnkgYXJlYSBmb3IgZG1h
IGFsbG9jYXRpb25zCj4+Pj4+ICsgKiBAZG1hX2lvX3RsYl9tZW06IEludGVybmFsIGZvciBzd2lv
dGxiIGlvX3RsYl9tZW0gb3ZlcnJpZGUuCj4+Pj4+ICDCoMKgwqAqIEBhcmNoZGF0YTrCoMKgwqAg
Rm9yIGFyY2gtc3BlY2lmaWMgYWRkaXRpb25zLgo+Pj4+PiAgwqDCoMKgKiBAb2Zfbm9kZTrCoMKg
wqAgQXNzb2NpYXRlZCBkZXZpY2UgdHJlZSBub2RlLgo+Pj4+PiAgwqDCoMKgKiBAZndub2RlOsKg
wqDCoCBBc3NvY2lhdGVkIGRldmljZSBub2RlIHN1cHBsaWVkIGJ5IHBsYXRmb3JtIGZpcm13YXJl
Lgo+Pj4+PiBAQCAtNTE1LDYgKzUxNiw5IEBAIHN0cnVjdCBkZXZpY2Ugewo+Pj4+PiAgwqDCoCNp
ZmRlZiBDT05GSUdfRE1BX0NNQQo+Pj4+PiAgwqDCoMKgwqDCoCBzdHJ1Y3QgY21hICpjbWFfYXJl
YTvCoMKgwqDCoMKgwqDCoCAvKiBjb250aWd1b3VzIG1lbW9yeSBhcmVhIGZvciBkbWEKPj4+Pj4g
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhbGxvY2F0
aW9ucyAqLwo+Pj4+PiArI2VuZGlmCj4+Pj4+ICsjaWZkZWYgQ09ORklHX1NXSU9UTEIKPj4+Pj4g
K8KgwqDCoCBzdHJ1Y3QgaW9fdGxiX21lbcKgwqDCoCAqZG1hX2lvX3RsYl9tZW07Cj4+Pj4+ICDC
oMKgI2VuZGlmCj4+Pj4+ICDCoMKgwqDCoMKgIC8qIGFyY2ggc3BlY2lmaWMgYWRkaXRpb25zICov
Cj4+Pj4+ICDCoMKgwqDCoMKgIHN0cnVjdCBkZXZfYXJjaGRhdGHCoMKgwqAgYXJjaGRhdGE7Cj4+
Pj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3N3aW90bGIuaCBiL2luY2x1ZGUvbGludXgv
c3dpb3RsYi5oCj4+Pj4+IGluZGV4IGRkOGViNTdjYmI4Zi4uYTFiYmQ3Nzg4ODg1IDEwMDY0NAo+
Pj4+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L3N3aW90bGIuaAo+Pj4+PiArKysgYi9pbmNsdWRlL2xp
bnV4L3N3aW90bGIuaAo+Pj4+PiBAQCAtNzYsMTIgKzc2LDEzIEBAIGV4dGVybiBlbnVtIHN3aW90
bGJfZm9yY2Ugc3dpb3RsYl9mb3JjZTsKPj4+Pj4gIMKgwqDCoCoKPj4+Pj4gIMKgwqDCoCogQHN0
YXJ0OsKgwqDCoCBUaGUgc3RhcnQgYWRkcmVzcyBvZiB0aGUgc3dpb3RsYiBtZW1vcnkgcG9vbC4g
VXNlZAo+Pj4+PiB0byBkbyBhIHF1aWNrCj4+Pj4+ICDCoMKgwqAqwqDCoMKgwqDCoMKgwqAgcmFu
Z2UgY2hlY2sgdG8gc2VlIGlmIHRoZSBtZW1vcnkgd2FzIGluIGZhY3QgYWxsb2NhdGVkCj4+Pj4+
IGJ5IHRoaXMKPj4+Pj4gLSAqwqDCoMKgwqDCoMKgwqAgQVBJLgo+Pj4+PiArICrCoMKgwqDCoMKg
wqDCoCBBUEkuIEZvciByZXN0cmljdGVkIERNQSBwb29sLCB0aGlzIGlzIGRldmljZSB0cmVlCj4+
Pj4+IGFkanVzdGFibGUuCj4+Pj4KPj4+PiBNYXliZSB3cml0ZSBpdCBhcyB0aGlzIGlzICJmaXJt
d2FyZSBhZGp1c3RhYmxlIiBzdWNoIHRoYXQgd2hlbi9pZiBBQ1BJCj4+Pj4gbmVlZHMgc29tZXRo
aW5nIGxpa2UgdGhpcywgdGhlIGRlc2NyaXB0aW9uIGRvZXMgbm90IG5lZWQgdXBkYXRpbmcuCj4+
Cj4+IFRCSCBJIHJlYWxseSBkb24ndCB0aGluayB0aGlzIG5lZWRzIGNhbGxpbmcgb3V0IGF0IGFs
bC4gRXZlbiBpbiB0aGUKPj4gcmVndWxhciBjYXNlLCB0aGUgZGV0YWlscyBvZiBleGFjdGx5IGhv
dyBhbmQgd2hlcmUgdGhlIHBvb2wgaXMgYWxsb2NhdGVkCj4+IGFyZSBiZXlvbmQgdGhlIHNjb3Bl
IG9mIHRoaXMgY29kZSAtIGFyY2hpdGVjdHVyZXMgYWxyZWFkeSBoYXZlIHNldmVyYWwKPj4gd2F5
cyB0byBjb250cm9sIHRoYXQgYW5kIG1ha2UgdGhlaXIgb3duIGRlY2lzaW9ucy4KPj4KPj4+Pgo+
Pj4+IFtzbmlwXQo+Pj4+Cj4+Pj4+ICtzdGF0aWMgaW50IHJtZW1fc3dpb3RsYl9kZXZpY2VfaW5p
dChzdHJ1Y3QgcmVzZXJ2ZWRfbWVtICpybWVtLAo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGRldmljZSAqZGV2KQo+Pj4+PiArewo+Pj4+PiArwqDC
oMKgIHN0cnVjdCBpb190bGJfbWVtICptZW0gPSBybWVtLT5wcml2Owo+Pj4+PiArwqDCoMKgIGlu
dCByZXQ7Cj4+Pj4+ICsKPj4+Pj4gK8KgwqDCoCBpZiAoZGV2LT5kbWFfaW9fdGxiX21lbSkKPj4+
Pj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiAtRUJVU1k7Cj4+Pj4+ICsKPj4+Pj4gK8KgwqDCoCBp
ZiAoIW1lbSkgewo+Pj4+PiArwqDCoMKgwqDCoMKgwqAgbWVtID0ga3phbGxvYyhzaXplb2YoKm1l
bSksIEdGUF9LRVJORUwpOwo+Pj4+PiArwqDCoMKgwqDCoMKgwqAgaWYgKCFtZW0pCj4+Pj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRU5PTUVNOwo+Pj4+PiArCj4+Pj4+ICvCoMKg
wqDCoMKgwqDCoCBpZiAoIW1lbXJlbWFwKHJtZW0tPmJhc2UsIHJtZW0tPnNpemUsIE1FTVJFTUFQ
X1dCKSkgewo+Pj4+Cj4+Pj4gTUVNUkVNQVBfV0Igc291bmRzIGFwcHJvcHJpYXRlIGFzIGEgZGVm
YXVsdC4KPj4+Cj4+PiBBcyBwZXIgdGhlIGJpbmRpbmcgJ25vLW1hcCcgaGFzIHRvIGJlIGRpc2Fi
bGVkIGhlcmUuIFNvIEFGQUlVLCB0aGlzCj4+PiBtZW1vcnkgd2lsbAo+Pj4gYmUgcGFydCBvZiB0
aGUgbGluZWFyIG1hcHBpbmcuIElzIHRoaXMgcmVhbGx5IG5lZWRlZCB0aGVuPwo+Pgo+PiBNb3Jl
IHRoYW4gdGhhdCwgSSdkIGFzc3VtZSB0aGF0IHdlICpoYXZlKiB0byB1c2UgdGhlIGxpbmVhci9k
aXJlY3QgbWFwCj4+IGFkZHJlc3MgcmF0aGVyIHRoYW4gYW55dGhpbmcgdGhhdCBoYXMgYW55IHBv
c3NpYmlsaXR5IG9mIGJlaW5nIGEgdm1hbGxvYwo+PiByZW1hcCwgb3RoZXJ3aXNlIHdlIGNhbiBu
byBsb25nZXIgc2FmZWx5IHJlbHkgb24KPj4gcGh5c190b19kbWEvZG1hX3RvX3BoeXMsIG5vPwo+
IAo+IEkgYmVsaWV2ZSB5b3UgYXJlIHJpZ2h0LCB3aGljaCBtZWFucyB0aGF0IGlmIHdlIHdhbnQg
dG8gbWFrZSB1c2Ugb2YgdGhlCj4gcmVzdHJpY3RlZCBETUEgcG9vbCBvbiBhIDMyLWJpdCBhcmNo
aXRlY3R1cmUgKGFuZCB3ZSBkbywgYXQgbGVhc3QsIEkgZG8pCj4gd2Ugc2hvdWxkIHByb2JhYmx5
IGFkZCBzb21lIGVycm9yIGNoZWNraW5nL3dhcm5pbmcgdG8gZW5zdXJlIHRoZQo+IHJlc3RyaWN0
ZWQgRE1BIHBvb2wgZmFsbHMgd2l0aGluIHRoZSBsaW5lYXIgbWFwLgoKT2gsIGdvb2QgcG9pbnQg
LSBJJ20gc28gdXNlZCB0byA2NC1iaXQgdGhhdCBJIGluc3RpbmN0aXZlbHkganVzdCBibGFua2Vk
IApvdXQgdGhlICFQYWdlSGlnaE1lbSgpIGNvbmRpdGlvbiBpbiB0cnlfcmFtX3JlbWFwKCkuIFNv
IG1heWJlIHRoZSAKb3JpZ2luYWwgaW50ZW50IGhlcmUgKndhcyogdG8gZWZmZWN0aXZlbHkganVz
dCBpbXBsZW1lbnQgdGhhdCBjaGVjaywgYnV0IAppZiBzbyBpdCBjb3VsZCBzdGlsbCBkbyB3aXRo
IGJlaW5nIGEgbG90IG1vcmUgZXhwbGljaXQuCgpDaGVlcnMsClJvYmluLgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9t
bXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
