Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB22C433F5
	for <iommu@archiver.kernel.org>; Mon, 13 Dec 2021 00:50:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B5D1C4096A;
	Mon, 13 Dec 2021 00:50:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Byl-RG3NLZqh; Mon, 13 Dec 2021 00:50:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 46D82400D2;
	Mon, 13 Dec 2021 00:50:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0FE2DC002F;
	Mon, 13 Dec 2021 00:50:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 26041C0012
 for <iommu@lists.linux-foundation.org>; Mon, 13 Dec 2021 00:50:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 11DDC4094F
 for <iommu@lists.linux-foundation.org>; Mon, 13 Dec 2021 00:50:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n3vGlNOOUidb for <iommu@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 00:50:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 05535400D2
 for <iommu@lists.linux-foundation.org>; Mon, 13 Dec 2021 00:50:26 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10195"; a="219320593"
X-IronPort-AV: E=Sophos;i="5.88,201,1635231600"; d="scan'208";a="219320593"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2021 16:50:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,201,1635231600"; d="scan'208";a="517543569"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 12 Dec 2021 16:50:18 -0800
Subject: Re: [PATCH v3 04/18] driver core: platform: Add driver dma ownership
 management
To: Jason Gunthorpe <jgg@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Christoph Hellwig <hch@infradead.org>
References: <20211206015903.88687-1-baolu.lu@linux.intel.com>
 <20211206015903.88687-5-baolu.lu@linux.intel.com>
 <Ya4f662Af+8kE2F/@infradead.org> <20211206150647.GE4670@nvidia.com>
 <56a63776-48ca-0d6e-c25c-016dc016e0d5@linux.intel.com>
 <20211207131627.GA6385@nvidia.com>
 <c170d215-6aef-ff21-8733-1bae4478e39c@linux.intel.com>
 <b42ffaee-bb96-6db4-8540-b399214f6881@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <5d537286-2cb3-cf91-c0de-019355110aa1@linux.intel.com>
Date: Mon, 13 Dec 2021 08:50:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <b42ffaee-bb96-6db4-8540-b399214f6881@linux.intel.com>
Content-Language: en-US
Cc: Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Li Yang <leoyang.li@nxp.com>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
 Robin Murphy <robin.murphy@arm.com>
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

T24gMTIvMTAvMjEgOToyMyBBTSwgTHUgQmFvbHUgd3JvdGU6Cj4gSGkgR3JlZywgSmFzb24gYW5k
IENocmlzdG9waCwKPiAKPiBPbiAxMi85LzIxIDk6MjAgQU0sIEx1IEJhb2x1IHdyb3RlOgo+PiBP
biAxMi83LzIxIDk6MTYgUE0sIEphc29uIEd1bnRob3JwZSB3cm90ZToKPj4+IE9uIFR1ZSwgRGVj
IDA3LCAyMDIxIGF0IDEwOjU3OjI1QU0gKzA4MDAsIEx1IEJhb2x1IHdyb3RlOgo+Pj4+IE9uIDEy
LzYvMjEgMTE6MDYgUE0sIEphc29uIEd1bnRob3JwZSB3cm90ZToKPj4+Pj4gT24gTW9uLCBEZWMg
MDYsIDIwMjEgYXQgMDY6MzY6MjdBTSAtMDgwMCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4+
Pj4+PiBJIHJlYWxseSBoYXRlIHRoZSBhbW91bnQgb2YgYm9pbGVycGxhdGUgY29kZSB0aGF0IGhh
dmluZyB0aGlzIGluIGVhY2gKPj4+Pj4+IGJ1cyB0eXBlIGNhdXNlcy4KPj4+Pj4gKzEKPj4+Pj4K
Pj4+Pj4gSSBsaWtlZCB0aGUgZmlyc3QgdmVyc2lvbiBvZiB0aGlzIHNlcmllcyBiZXR0ZXIgd2l0
aCB0aGUgY29kZSBuZWFyCj4+Pj4+IHJlYWxseV9wcm9iZSgpLgo+Pj4+Pgo+Pj4+PiBDYW4gd2Ug
Z28gYmFjayB0byB0aGF0IHdpdGggc29tZSBkZXZpY2VfY29uZmlndXJlX2RtYSgpIHdyYXBwZXIK
Pj4+Pj4gY29uZHRpb25hbGx5IGNhbGxlZCBieSByZWFsbHlfcHJvYmUgYXMgd2UgZGlzY3Vzc2Vk
Pwo+IAo+IFsuLi5dCj4gCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Jhc2UvZGQuYyBiL2Ry
aXZlcnMvYmFzZS9kZC5jCj4+IGluZGV4IDY4ZWExZjk0OWRhYS4uNjhjYTVhNTc5ZWIxIDEwMDY0
NAo+PiAtLS0gYS9kcml2ZXJzL2Jhc2UvZGQuYwo+PiArKysgYi9kcml2ZXJzL2Jhc2UvZGQuYwo+
PiBAQCAtNTM4LDYgKzUzOCwzMiBAQCBzdGF0aWMgaW50IGNhbGxfZHJpdmVyX3Byb2JlKHN0cnVj
dCBkZXZpY2UgKmRldiwgCj4+IHN0cnVjdCBkZXZpY2VfZHJpdmVyICpkcnYpCj4+IMKgwqDCoMKg
wqDCoMKgwqAgcmV0dXJuIHJldDsKPj4gwqDCoH0KPj4KPj4gK3N0YXRpYyBpbnQgZGV2aWNlX2Rt
YV9jb25maWd1cmUoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgCj4+IGRldmljZV9kcml2ZXIg
KmRydikKPj4gK3sKPj4gK8KgwqDCoMKgwqDCoCBpbnQgcmV0Owo+PiArCj4+ICvCoMKgwqDCoMKg
wqAgaWYgKCFkZXYtPmJ1cy0+ZG1hX2NvbmZpZ3VyZSkKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcmV0dXJuIDA7Cj4+ICsKPj4gK8KgwqDCoMKgwqDCoCByZXQgPSBkZXYtPmJ1cy0+
ZG1hX2NvbmZpZ3VyZShkZXYpOwo+PiArwqDCoMKgwqDCoMKgIGlmIChyZXQpCj4+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiByZXQ7Cj4+ICsKPj4gK8KgwqDCoMKgwqDCoCBp
ZiAoIWRydi0+c3VwcHJlc3NfYXV0b19jbGFpbV9kbWFfb3duZXIpCj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHJldCA9IGlvbW11X2RldmljZV9zZXRfZG1hX293bmVyKGRldiwgCj4+
IERNQV9PV05FUl9ETUFfQVBJLCBOVUxMKTsKPj4gKwo+PiArwqDCoMKgwqDCoMKgIHJldHVybiBy
ZXQ7Cj4+ICt9Cj4+ICsKPj4gK3N0YXRpYyB2b2lkIGRldmljZV9kbWFfY2xlYW51cChzdHJ1Y3Qg
ZGV2aWNlICpkZXYsIHN0cnVjdCAKPj4gZGV2aWNlX2RyaXZlciAqZHJ2KQo+PiArewo+PiArwqDC
oMKgwqDCoMKgIGlmICghZGV2LT5idXMtPmRtYV9jb25maWd1cmUpCj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHJldHVybjsKPj4gKwo+PiArwqDCoMKgwqDCoMKgIGlmICghZHJ2LT5z
dXBwcmVzc19hdXRvX2NsYWltX2RtYV9vd25lcikKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgaW9tbXVfZGV2aWNlX3JlbGVhc2VfZG1hX293bmVyKGRldiwgRE1BX09XTkVSX0RNQV9B
UEkpOwo+PiArfQo+PiArCj4+IMKgwqBzdGF0aWMgaW50IHJlYWxseV9wcm9iZShzdHJ1Y3QgZGV2
aWNlICpkZXYsIHN0cnVjdCBkZXZpY2VfZHJpdmVyICpkcnYpCj4+IMKgwqB7Cj4+IMKgwqDCoMKg
wqDCoMKgwqAgYm9vbCB0ZXN0X3JlbW92ZSA9IAo+PiBJU19FTkFCTEVEKENPTkZJR19ERUJVR19U
RVNUX0RSSVZFUl9SRU1PVkUpICYmCj4+IEBAIC01NzQsMTEgKzYwMCw4IEBAIHN0YXRpYyBpbnQg
cmVhbGx5X3Byb2JlKHN0cnVjdCBkZXZpY2UgKmRldiwgCj4+IHN0cnVjdCBkZXZpY2VfZHJpdmVy
ICpkcnYpCj4+IMKgwqDCoMKgwqDCoMKgwqAgaWYgKHJldCkKPj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgZ290byBwaW5jdHJsX2JpbmRfZmFpbGVkOwo+Pgo+PiAtwqDCoMKgwqDC
oMKgIGlmIChkZXYtPmJ1cy0+ZG1hX2NvbmZpZ3VyZSkgewo+PiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCByZXQgPSBkZXYtPmJ1cy0+ZG1hX2NvbmZpZ3VyZShkZXYpOwo+PiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAocmV0KQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBwcm9iZV9mYWlsZWQ7Cj4+IC3CoMKgwqDCoMKg
wqAgfQo+PiArwqDCoMKgwqDCoMKgIGlmIChkZXZpY2VfZG1hX2NvbmZpZ3VyZShkZXYsIGRydikp
Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gcGluY3RybF9iaW5kX2ZhaWxl
ZDsKPj4KPj4gwqDCoMKgwqDCoMKgwqDCoCByZXQgPSBkcml2ZXJfc3lzZnNfYWRkKGRldik7Cj4+
IMKgwqDCoMKgwqDCoMKgwqAgaWYgKHJldCkgewo+PiBAQCAtNjYwLDYgKzY4Myw4IEBAIHN0YXRp
YyBpbnQgcmVhbGx5X3Byb2JlKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IAo+PiBkZXZpY2Vf
ZHJpdmVyICpkcnYpCj4+IMKgwqDCoMKgwqDCoMKgwqAgaWYgKGRldi0+YnVzKQo+PiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBibG9ja2luZ19ub3RpZmllcl9jYWxsX2NoYWluKCZk
ZXYtPmJ1cy0+cC0+YnVzX25vdGlmaWVyLAo+Pgo+PiBCVVNfTk9USUZZX0RSSVZFUl9OT1RfQk9V
TkQsIGRldik7Cj4+ICsKPj4gK8KgwqDCoMKgwqDCoCBkZXZpY2VfZG1hX2NsZWFudXAoZGV2LCBk
cnYpOwo+PiDCoMKgcGluY3RybF9iaW5kX2ZhaWxlZDoKPj4gwqDCoMKgwqDCoMKgwqDCoCBkZXZp
Y2VfbGlua3Nfbm9fZHJpdmVyKGRldik7Cj4+IMKgwqDCoMKgwqDCoMKgwqAgZGV2cmVzX3JlbGVh
c2VfYWxsKGRldik7Cj4+IEBAIC0xMjA0LDYgKzEyMjksNyBAQCBzdGF0aWMgdm9pZCBfX2Rldmlj
ZV9yZWxlYXNlX2RyaXZlcihzdHJ1Y3QgCj4+IGRldmljZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlICpw
YXJlbnQpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVsc2UgaWYgKGRydi0+
cmVtb3ZlKQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgZHJ2LT5yZW1vdmUoZGV2KTsKPj4KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
ZGV2aWNlX2RtYV9jbGVhbnVwKGRldiwgZHJ2KTsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgZGV2aWNlX2xpbmtzX2RyaXZlcl9jbGVhbnVwKGRldik7Cj4+Cj4+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRldnJlc19yZWxlYXNlX2FsbChkZXYpOwo+PiBkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9saW51eC9kZXZpY2UvZHJpdmVyLmggCj4+IGIvaW5jbHVkZS9saW51
eC9kZXZpY2UvZHJpdmVyLmgKPj4gaW5kZXggYTQ5OGViY2Y0OTkzLi4zNzRhM2MyY2MxMGQgMTAw
NjQ0Cj4+IC0tLSBhL2luY2x1ZGUvbGludXgvZGV2aWNlL2RyaXZlci5oCj4+ICsrKyBiL2luY2x1
ZGUvbGludXgvZGV2aWNlL2RyaXZlci5oCj4+IEBAIC0xMDAsNiArMTAwLDcgQEAgc3RydWN0IGRl
dmljZV9kcml2ZXIgewo+PiDCoMKgwqDCoMKgwqDCoMKgIGNvbnN0IGNoYXLCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAqbW9kX25hbWU7wqDCoMKgwqDCoCAvKiB1c2VkIGZvciBidWlsdC1pbiAK
Pj4gbW9kdWxlcyAqLwo+Pgo+PiDCoMKgwqDCoMKgwqDCoMKgIGJvb2wgc3VwcHJlc3NfYmluZF9h
dHRyczvCoMKgwqDCoMKgwqAgLyogZGlzYWJsZXMgYmluZC91bmJpbmQgdmlhIAo+PiBzeXNmcyAq
Lwo+PiArwqDCoMKgwqDCoMKgIGJvb2wgc3VwcHJlc3NfYXV0b19jbGFpbV9kbWFfb3duZXI7Cj4+
IMKgwqDCoMKgwqDCoMKgwqAgZW51bSBwcm9iZV90eXBlIHByb2JlX3R5cGU7Cj4+Cj4+IMKgwqDC
oMKgwqDCoMKgwqAgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZMKgwqDCoMKgwqDCoCAqb2ZfbWF0
Y2hfdGFibGU7Cj4gCj4gRG9lcyB0aGlzIHdvcmsgZm9yIHlvdT8gQ2FuIEkgd29yayB0b3dhcmRz
IHRoaXMgaW4gdGhlIG5leHQgdmVyc2lvbj8KCkEga2luZGx5IHBpbmcgLi4uIElzIHRoaXMgaGVh
ZGluZyB0aGUgcmlnaHQgZGlyZWN0aW9uPyBJIG5lZWQgeW91cgphZHZpY2UgdG8gbW92ZSBhaGVh
ZC4gOi0pCgpCZXN0IHJlZ2FyZHMsCmJhb2x1Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby9pb21tdQ==
