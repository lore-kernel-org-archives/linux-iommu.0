Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0171C43334
	for <iommu@archiver.kernel.org>; Thu, 30 Jun 2022 14:57:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 02AF6423EB;
	Thu, 30 Jun 2022 14:57:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 02AF6423EB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RLqxiREdqQpQ; Thu, 30 Jun 2022 14:57:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 618BA423E8;
	Thu, 30 Jun 2022 14:57:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 618BA423E8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 23C73C0021;
	Thu, 30 Jun 2022 14:57:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9B193C0011
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 14:57:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7574760ABE
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 14:57:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7574760ABE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R2TMelui6Yl9 for <iommu@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 14:57:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 56D7460797
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 56D7460797
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 14:57:06 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7FC61063;
 Thu, 30 Jun 2022 07:57:05 -0700 (PDT)
Received: from [10.57.85.25] (unknown [10.57.85.25])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C8C5A3F66F;
 Thu, 30 Jun 2022 07:57:01 -0700 (PDT)
Message-ID: <f9c1e41b-d2a8-61fe-0888-4f0f988912a7@arm.com>
Date: Thu, 30 Jun 2022 15:56:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v7 08/21] iommu/dma: support PCI P2PDMA pages in dma-iommu
 map_sg
Content-Language: en-GB
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
References: <20220615161233.17527-1-logang@deltatee.com>
 <20220615161233.17527-9-logang@deltatee.com>
 <feecc6fe-a16e-11f2-33c8-3de7c96b9ad5@arm.com>
 <f56181fb-7035-a775-22b1-77f97d6ec52c@deltatee.com>
 <7f0673e1-433b-65fb-1d2b-c3e4adeebf87@arm.com>
 <626de61d-e85e-bc9f-9e3d-836a408c859f@deltatee.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <626de61d-e85e-bc9f-9e3d-836a408c859f@deltatee.com>
Cc: Minturn Dave B <dave.b.minturn@intel.com>,
 Ralph Campbell <rcampbell@nvidia.com>, Jason Ekstrand <jason@jlekstrand.net>,
 Christoph Hellwig <hch@lst.de>, John Hubbard <jhubbard@nvidia.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Matthew Wilcox <willy@infradead.org>, Stephen Bates <sbates@raithlin.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>
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

T24gMjAyMi0wNi0yOSAyMzo0MSwgTG9nYW4gR3VudGhvcnBlIHdyb3RlOgo+IAo+IAo+IE9uIDIw
MjItMDYtMjkgMTM6MTUsIFJvYmluIE11cnBoeSB3cm90ZToKPj4gT24gMjAyMi0wNi0yOSAxNjo1
NywgTG9nYW4gR3VudGhvcnBlIHdyb3RlOgo+Pj4KPj4+Cj4+Pgo+Pj4gT24gMjAyMi0wNi0yOSAw
NjowNywgUm9iaW4gTXVycGh5IHdyb3RlOgo+Pj4+IE9uIDIwMjItMDYtMTUgMTc6MTIsIExvZ2Fu
IEd1bnRob3JwZSB3cm90ZToKPj4+Pj4gV2hlbiBhIFBDSSBQMlBETUEgcGFnZSBpcyBzZWVuLCBz
ZXQgdGhlIElPVkEgbGVuZ3RoIG9mIHRoZSBzZWdtZW50Cj4+Pj4+IHRvIHplcm8gc28gdGhhdCBp
dCBpcyBub3QgbWFwcGVkIGludG8gdGhlIElPVkEuIFRoZW4sIGluIGZpbmFsaXNlX3NnKCksCj4+
Pj4+IGFwcGx5IHRoZSBhcHByb3ByaWF0ZSBidXMgYWRkcmVzcyB0byB0aGUgc2VnbWVudC4gVGhl
IElPVkEgaXMgbm90Cj4+Pj4+IGNyZWF0ZWQgaWYgdGhlIHNjYXR0ZXJsaXN0IG9ubHkgY29uc2lz
dHMgb2YgUDJQRE1BIHBhZ2VzLgo+Pj4+Pgo+Pj4+PiBBIFAyUERNQSBwYWdlIG1heSBoYXZlIHRo
cmVlIHBvc3NpYmxlIG91dGNvbWVzIHdoZW4gYmVpbmcgbWFwcGVkOgo+Pj4+PiAgwqDCoMKgIDEp
IElmIHRoZSBkYXRhIHBhdGggYmV0d2VlbiB0aGUgdHdvIGRldmljZXMgZG9lc24ndCBnbyB0aHJv
dWdoCj4+Pj4+ICDCoMKgwqDCoMKgwqAgdGhlIHJvb3QgcG9ydCwgdGhlbiBpdCBzaG91bGQgYmUg
bWFwcGVkIHdpdGggYSBQQ0kgYnVzIGFkZHJlc3MKPj4+Pj4gIMKgwqDCoCAyKSBJZiB0aGUgZGF0
YSBwYXRoIGdvZXMgdGhyb3VnaCB0aGUgaG9zdCBicmlkZ2UsIGl0IHNob3VsZCBiZQo+Pj4+PiBt
YXBwZWQKPj4+Pj4gIMKgwqDCoMKgwqDCoCBub3JtYWxseSB3aXRoIGFuIElPTU1VIElPVkEuCj4+
Pj4+ICDCoMKgwqAgMykgSXQgaXMgbm90IHBvc3NpYmxlIGZvciB0aGUgdHdvIGRldmljZXMgdG8g
Y29tbXVuaWNhdGUgYW5kIHRodXMKPj4+Pj4gIMKgwqDCoMKgwqDCoCB0aGUgbWFwcGluZyBvcGVy
YXRpb24gc2hvdWxkIGZhaWwgKGFuZCBpdCB3aWxsIHJldHVybgo+Pj4+PiAtRVJFTU9URUlPKS4K
Pj4+Pj4KPj4+Pj4gU2ltaWxhciB0byBkbWEtZGlyZWN0LCB0aGUgc2dfZG1hX21hcmtfcGNpX3Ay
cGRtYSgpIGZsYWcgaXMgdXNlZCB0bwo+Pj4+PiBpbmRpY2F0ZSBidXMgYWRkcmVzcyBzZWdtZW50
cy4gT24gdW5tYXAsIFAyUERNQSBzZWdtZW50cyBhcmUgc2tpcHBlZAo+Pj4+PiBvdmVyIHdoZW4g
ZGV0ZXJtaW5pbmcgdGhlIHN0YXJ0IGFuZCBlbmQgSU9WQSBhZGRyZXNzZXMuCj4+Pj4+Cj4+Pj4+
IFdpdGggdGhpcyBjaGFuZ2UsIHRoZSBmbGFncyB2YXJpYWJsZSBpbiB0aGUgZG1hX21hcF9vcHMg
aXMgc2V0IHRvCj4+Pj4+IERNQV9GX1BDSV9QMlBETUFfU1VQUE9SVEVEIHRvIGluZGljYXRlIHN1
cHBvcnQgZm9yIFAyUERNQSBwYWdlcy4KPj4+Pj4KPj4+Pj4gU2lnbmVkLW9mZi1ieTogTG9nYW4g
R3VudGhvcnBlIDxsb2dhbmdAZGVsdGF0ZWUuY29tPgo+Pj4+PiBSZXZpZXdlZC1ieTogSmFzb24g
R3VudGhvcnBlIDxqZ2dAbnZpZGlhLmNvbT4KPj4+Pj4gLS0tCj4+Pj4+ICDCoMKgIGRyaXZlcnMv
aW9tbXUvZG1hLWlvbW11LmMgfCA2OAo+Pj4+PiArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKy0tLS0KPj4+Pj4gIMKgwqAgMSBmaWxlIGNoYW5nZWQsIDYxIGluc2VydGlvbnMoKyks
IDcgZGVsZXRpb25zKC0pCj4+Pj4+Cj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2Rt
YS1pb21tdS5jIGIvZHJpdmVycy9pb21tdS9kbWEtaW9tbXUuYwo+Pj4+PiBpbmRleCBmOTAyNTE1
NzJhNWQuLmIwMWNhMGM2YTdhYiAxMDA2NDQKPj4+Pj4gLS0tIGEvZHJpdmVycy9pb21tdS9kbWEt
aW9tbXUuYwo+Pj4+PiArKysgYi9kcml2ZXJzL2lvbW11L2RtYS1pb21tdS5jCj4+Pj4+IEBAIC0y
MSw2ICsyMSw3IEBACj4+Pj4+ICDCoMKgICNpbmNsdWRlIDxsaW51eC9pb3ZhLmg+Cj4+Pj4+ICDC
oMKgICNpbmNsdWRlIDxsaW51eC9pcnEuaD4KPj4+Pj4gIMKgwqAgI2luY2x1ZGUgPGxpbnV4L2xp
c3Rfc29ydC5oPgo+Pj4+PiArI2luY2x1ZGUgPGxpbnV4L21lbXJlbWFwLmg+Cj4+Pj4+ICDCoMKg
ICNpbmNsdWRlIDxsaW51eC9tbS5oPgo+Pj4+PiAgwqDCoCAjaW5jbHVkZSA8bGludXgvbXV0ZXgu
aD4KPj4+Pj4gIMKgwqAgI2luY2x1ZGUgPGxpbnV4L3BjaS5oPgo+Pj4+PiBAQCAtMTA2Miw2ICsx
MDYzLDE2IEBAIHN0YXRpYyBpbnQgX19maW5hbGlzZV9zZyhzdHJ1Y3QgZGV2aWNlICpkZXYsCj4+
Pj4+IHN0cnVjdCBzY2F0dGVybGlzdCAqc2csIGludCBuZW50cywKPj4+Pj4gIMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHNnX2RtYV9hZGRyZXNzKHMpID0gRE1BX01BUFBJTkdfRVJST1I7Cj4+Pj4+ICDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBzZ19kbWFfbGVuKHMpID0gMDsKPj4+Pj4gIMKgwqAgK8KgwqDC
oMKgwqDCoMKgIGlmIChpc19wY2lfcDJwZG1hX3BhZ2Uoc2dfcGFnZShzKSkgJiYgIXNfaW92YV9s
ZW4pIHsKPj4+Pgo+Pj4+IExvZ2ljYWxseSwgc2hvdWxkIHdlIG5vdCBiZSBhYmxlIHRvIHVzZSBz
Z19pc19kbWFfYnVzX2FkZHJlc3MoKSBoZXJlPyBJCj4+Pj4gdGhpbmsgaXQgc2hvdWxkIGJlIGZl
YXNpYmxlLCBhbmQgc2ltcGxlciwgdG8gcHJlcGFyZSB0aGUgcDJwIHNlZ21lbnRzCj4+Pj4gdXAt
ZnJvbnQsIHN1Y2ggdGhhdCBhdCB0aGlzIHBvaW50IGFsbCB3ZSBuZWVkIHRvIGRvIGlzIHJlc3Rv
cmUgdGhlCj4+Pj4gb3JpZ2luYWwgbGVuZ3RoIChpZiBldmVuIHRoYXQsIHNlZSBiZWxvdykuCj4+
Pgo+Pj4gUGVyIG15IHByZXZpb3VzIGVtYWlsLCBubywgYmVjYXVzZSBzZ19pc19kbWFfYnVzX2Fk
ZHJlc3MoKSBpcyBub3Qgc2V0Cj4+PiB5ZXQgYW5kIG5vdCBtZWFudCB0byB0ZWxsIHlvdSBzb21l
dGhpbmcgYWJvdXQgdGhlIHBhZ2UuIFRoYXQgZmxhZyB3aWxsCj4+PiBiZSBzZXQgYmVsb3cgYnkg
cGNpX3AycGRtYV9tYXBfYnVzX3NlZ21lbnQoKSBhbmQgdGhlbiBjaGVja2QgaW4KPj4+IGlvbW11
X2RtYV91bm1hcF9zZygpIHRvIGRldGVybWluZSBpZiB0aGUgZG1hX2FkZHJlc3MgaW4gdGhlIHNl
Z21lbnQKPj4+IG5lZWRzIHRvIGJlIHVubWFwcGVkLgo+Pgo+PiBJIGtub3cgaXQncyBub3Qgc2V0
IHlldCBhcy1pczsgSSdtIHN1Z2dlc3RpbmcgdGhpbmdzIHNob3VsZCBiZQo+PiByZXN0cnVjdHVy
ZWQgc28gdGhhdCBpdCAqd291bGQgYmUqLiBJbiB0aGUgbG9naWNhbCBkZXNpZ24gb2YgdGhpcyBj
b2RlLAo+PiB0aGUgRE1BIGFkZHJlc3NlcyBhcmUgZWZmZWN0aXZlbHkgZGV0ZXJtaW5lZCBpbiBp
b21tdV9kbWFfbWFwX3NnKCksIGFuZAo+PiBfX2ZpbmFsaXNlX3NnKCkgbWVyZWx5IGNvbnZlcnRz
IHRoZW0gZnJvbSBhIHJlbGF0aXZlIHRvIGFuIGFic29sdXRlIGZvcm0KPj4gKGFsb25nIHdpdGgg
dW5kb2luZyB0aGUgb3RoZXIgdHJpY2tlcnkpLiBUaHVzIHRoZSBjYWxsIHRvCj4+IHBjaV9wMnBk
bWFfbWFwX2J1c19zZWdtZW50KCkgYWJzb2x1dGVseSBiZWxvbmdzIGluIHRoZSBtYWluCj4+IGlv
bW11X21hcF9zZygpIGxvb3AuCj4gCj4gSSBkb24ndCBzZWUgaG93IHRoYXQgY2FuIHdvcms6IF9f
ZmluYWxpc2Vfc2coKSBkb2VzIG1vcmUgdGhhbiBjb252ZXJ0Cj4gdGhlbSBmcm9tIHJlbGF0aXZl
IHRvIGFic29sdXRlLCBpdCBhbHNvIGZpZ3VyZXMgb3V0IHdoaWNoIFNHIGVudHJ5IHdpbGwKPiBj
b250YWluIHdoaWNoIGRtYV9hZGRyZXNzIHNlZ21lbnQuIFdoaWNoIHNlZ21lbnQgYSBQMlBETUEg
YWRkcmVzcyBuZWVkcwo+IHRvIGJlIHByb2dyYW1tZWQgaW50byBkZXBlbmRzIG9uIHRoZSBob3cg
J2N1cicgaXMgY2FsY3VsYXRlZCB3aGljaCBpbgo+IHR1cm4gZGVwZW5kcyBvbiB0aGluZ3MgbGlr
ZSBzZWdfbWFzayBhbmQgbWF4X2xlbi4gVGhpcyBjYWxjdWxhdGlvbiBpcwo+IG5vdCBkb25lIGlu
IGlvbW11X2RtYV9tYXBfc2coKSBzbyBJIGRvbid0IHNlZSBob3cgdGhlcmUncyBhbnkgaG9wZSBv
Zgo+IGFzc2lnbmluZyB0aGUgYnVzIGFkZHJlc3MgZm9yIHRoZSBQMlAgc2VnbWVudHMgaW4gdGhh
dCBmdW5jdGlvbi4KPiAKPiBJZiB0aGVyZSdzIGEgd2F5IHRvIHJlc3RydWN0dXJlIHRoaW5ncyBz
byB0aGF0J3MgcG9zc2libGUgdGhhdCBJJ20gbm90Cj4gc2VlaW5nLCBJJ20gb3BlbiB0byBpdCBi
dXQgaXQncyBjZXJ0YWlubHkgbm90IGltbWVkaWF0ZWx5IG9idmlvdXMuCgpIdWg/IEl0J3Mgc3Rp
bGwgdmlydHVhbGx5IHRoZSBzYW1lIHRoaW5nOyBpb21tdV9kbWFfbWFwX3NnKCkgY2FsbHMgCnBj
aV9wMnBkbWFfbWFwX2J1c19zZWdtZW50KHMpIGFuZCBzZXRzIHMtPmxlbmd0aCB0byAwIGlmIApQ
Q0lfUDJQRE1BX01BUF9CVVNfQUREUiwgdGhlbiBfX2ZpbmFsaXNlX3NnKCkgY2FuIHVzZSAKc2df
aXNfZG1hX2J1c19hZGRyZXNzKHMpIGluIHBsYWNlIG9mIGlzX3BjaV9wMnBkbWFfcGFnZShzZ19w
YWdlKHMpKSwgYW5kIApqdXN0IHByb3BhZ2F0ZSB0aGUgRE1BIGFkZHJlc3MgYW5kIG9yaWdpbmFs
IGxlbmd0aCBmcm9tIHMgdG8gY3VyLgoKSGVyZSB5b3UndmUgd3JpdHRlbiBhIHBhdGNoIHdoaWNo
IGxvb2tzIHRvIGNvcnJlY3RseSBpbnRlcnJ1cHQgYW55IApvbmdvaW5nIGNvbmNhdGVuYXRpb24g
c3RhdGUgYW5kIGNvbnZleSBzb21lIGRhdGEgZnJvbSB0aGUgZ2l2ZW4gaW5wdXQgCnNlZ21lbnQg
dG8gdGhlIGFwcHJvcHJpYXRlIG91dHB1dCBzZWdtZW50LCBzbyBJJ20gYmFmZmxlZCBieSB3aHkg
eW91J2QgCnRoaW5rIHlvdSBjb3VsZG4ndCBkbyB3aGF0IHlvdSd2ZSBhbHJlYWR5IGRvbmUuCgpU
aGFua3MsClJvYmluLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
