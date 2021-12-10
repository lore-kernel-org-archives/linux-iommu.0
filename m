Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7354C433F5
	for <iommu@archiver.kernel.org>; Fri, 10 Dec 2021 01:23:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5006240A38;
	Fri, 10 Dec 2021 01:23:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7fTlXdEpaH8Z; Fri, 10 Dec 2021 01:23:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B49D440A31;
	Fri, 10 Dec 2021 01:23:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6D909C001E;
	Fri, 10 Dec 2021 01:23:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D23AC0012
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 01:23:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DB4BC60F8A
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 01:23:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 23dt2Dkt3Q-O for <iommu@lists.linux-foundation.org>;
 Fri, 10 Dec 2021 01:23:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2627A60F7E
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 01:23:44 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="235757541"
X-IronPort-AV: E=Sophos;i="5.88,194,1635231600"; d="scan'208";a="235757541"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2021 17:23:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,194,1635231600"; d="scan'208";a="516558392"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 09 Dec 2021 17:23:29 -0800
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
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <b42ffaee-bb96-6db4-8540-b399214f6881@linux.intel.com>
Date: Fri, 10 Dec 2021 09:23:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <c170d215-6aef-ff21-8733-1bae4478e39c@linux.intel.com>
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

SGkgR3JlZywgSmFzb24gYW5kIENocmlzdG9waCwKCk9uIDEyLzkvMjEgOToyMCBBTSwgTHUgQmFv
bHUgd3JvdGU6Cj4gT24gMTIvNy8yMSA5OjE2IFBNLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6Cj4+
IE9uIFR1ZSwgRGVjIDA3LCAyMDIxIGF0IDEwOjU3OjI1QU0gKzA4MDAsIEx1IEJhb2x1IHdyb3Rl
Ogo+Pj4gT24gMTIvNi8yMSAxMTowNiBQTSwgSmFzb24gR3VudGhvcnBlIHdyb3RlOgo+Pj4+IE9u
IE1vbiwgRGVjIDA2LCAyMDIxIGF0IDA2OjM2OjI3QU0gLTA4MDAsIENocmlzdG9waCBIZWxsd2ln
IHdyb3RlOgo+Pj4+PiBJIHJlYWxseSBoYXRlIHRoZSBhbW91bnQgb2YgYm9pbGVycGxhdGUgY29k
ZSB0aGF0IGhhdmluZyB0aGlzIGluIGVhY2gKPj4+Pj4gYnVzIHR5cGUgY2F1c2VzLgo+Pj4+ICsx
Cj4+Pj4KPj4+PiBJIGxpa2VkIHRoZSBmaXJzdCB2ZXJzaW9uIG9mIHRoaXMgc2VyaWVzIGJldHRl
ciB3aXRoIHRoZSBjb2RlIG5lYXIKPj4+PiByZWFsbHlfcHJvYmUoKS4KPj4+Pgo+Pj4+IENhbiB3
ZSBnbyBiYWNrIHRvIHRoYXQgd2l0aCBzb21lIGRldmljZV9jb25maWd1cmVfZG1hKCkgd3JhcHBl
cgo+Pj4+IGNvbmR0aW9uYWxseSBjYWxsZWQgYnkgcmVhbGx5X3Byb2JlIGFzIHdlIGRpc2N1c3Nl
ZD8KClsuLi5dCgo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Jhc2UvZGQuYyBiL2RyaXZlcnMv
YmFzZS9kZC5jCj4gaW5kZXggNjhlYTFmOTQ5ZGFhLi42OGNhNWE1NzllYjEgMTAwNjQ0Cj4gLS0t
IGEvZHJpdmVycy9iYXNlL2RkLmMKPiArKysgYi9kcml2ZXJzL2Jhc2UvZGQuYwo+IEBAIC01Mzgs
NiArNTM4LDMyIEBAIHN0YXRpYyBpbnQgY2FsbF9kcml2ZXJfcHJvYmUoc3RydWN0IGRldmljZSAq
ZGV2LCAKPiBzdHJ1Y3QgZGV2aWNlX2RyaXZlciAqZHJ2KQo+ICDCoMKgwqDCoMKgwqDCoCByZXR1
cm4gcmV0Owo+ICDCoH0KPiAKPiArc3RhdGljIGludCBkZXZpY2VfZG1hX2NvbmZpZ3VyZShzdHJ1
Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCAKPiBkZXZpY2VfZHJpdmVyICpkcnYpCj4gK3sKPiArwqDC
oMKgwqDCoMKgIGludCByZXQ7Cj4gKwo+ICvCoMKgwqDCoMKgwqAgaWYgKCFkZXYtPmJ1cy0+ZG1h
X2NvbmZpZ3VyZSkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsKPiAr
Cj4gK8KgwqDCoMKgwqDCoCByZXQgPSBkZXYtPmJ1cy0+ZG1hX2NvbmZpZ3VyZShkZXYpOwo+ICvC
oMKgwqDCoMKgwqAgaWYgKHJldCkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1
cm4gcmV0Owo+ICsKPiArwqDCoMKgwqDCoMKgIGlmICghZHJ2LT5zdXBwcmVzc19hdXRvX2NsYWlt
X2RtYV9vd25lcikKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSBpb21tdV9k
ZXZpY2Vfc2V0X2RtYV9vd25lcihkZXYsIERNQV9PV05FUl9ETUFfQVBJLCAKPiBOVUxMKTsKPiAr
Cj4gK8KgwqDCoMKgwqDCoCByZXR1cm4gcmV0Owo+ICt9Cj4gKwo+ICtzdGF0aWMgdm9pZCBkZXZp
Y2VfZG1hX2NsZWFudXAoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlX2RyaXZlciAK
PiAqZHJ2KQo+ICt7Cj4gK8KgwqDCoMKgwqDCoCBpZiAoIWRldi0+YnVzLT5kbWFfY29uZmlndXJl
KQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybjsKPiArCj4gK8KgwqDCoMKg
wqDCoCBpZiAoIWRydi0+c3VwcHJlc3NfYXV0b19jbGFpbV9kbWFfb3duZXIpCj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgaW9tbXVfZGV2aWNlX3JlbGVhc2VfZG1hX293bmVyKGRldiwg
RE1BX09XTkVSX0RNQV9BUEksIAo+IE5VTEwpOwo+ICt9Cj4gKwo+ICDCoHN0YXRpYyBpbnQgcmVh
bGx5X3Byb2JlKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmljZV9kcml2ZXIgKmRydikK
PiAgwqB7Cj4gIMKgwqDCoMKgwqDCoMKgIGJvb2wgdGVzdF9yZW1vdmUgPSBJU19FTkFCTEVEKENP
TkZJR19ERUJVR19URVNUX0RSSVZFUl9SRU1PVkUpICYmCj4gQEAgLTU3NCwxMSArNjAwLDggQEAg
c3RhdGljIGludCByZWFsbHlfcHJvYmUoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgCj4gZGV2
aWNlX2RyaXZlciAqZHJ2KQo+ICDCoMKgwqDCoMKgwqDCoCBpZiAocmV0KQo+ICDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBwaW5jdHJsX2JpbmRfZmFpbGVkOwo+IAo+IC3CoMKg
wqDCoMKgwqAgaWYgKGRldi0+YnVzLT5kbWFfY29uZmlndXJlKSB7Cj4gLcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgcmV0ID0gZGV2LT5idXMtPmRtYV9jb25maWd1cmUoZGV2KTsKPiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAocmV0KQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIHByb2JlX2ZhaWxlZDsKPiAtwqDCoMKgwqDC
oMKgIH0KPiArwqDCoMKgwqDCoMKgIGlmIChkZXZpY2VfZG1hX2NvbmZpZ3VyZShkZXYsIGRydikp
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBwaW5jdHJsX2JpbmRfZmFpbGVk
Owo+IAo+ICDCoMKgwqDCoMKgwqDCoCByZXQgPSBkcml2ZXJfc3lzZnNfYWRkKGRldik7Cj4gIMKg
wqDCoMKgwqDCoMKgIGlmIChyZXQpIHsKPiBAQCAtNjYwLDYgKzY4Myw4IEBAIHN0YXRpYyBpbnQg
cmVhbGx5X3Byb2JlKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IAo+IGRldmljZV9kcml2ZXIg
KmRydikKPiAgwqDCoMKgwqDCoMKgwqAgaWYgKGRldi0+YnVzKQo+ICDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgYmxvY2tpbmdfbm90aWZpZXJfY2FsbF9jaGFpbigmZGV2LT5idXMtPnAt
PmJ1c19ub3RpZmllciwKPiAKPiBCVVNfTk9USUZZX0RSSVZFUl9OT1RfQk9VTkQsIGRldik7Cj4g
Kwo+ICvCoMKgwqDCoMKgwqAgZGV2aWNlX2RtYV9jbGVhbnVwKGRldiwgZHJ2KTsKPiAgwqBwaW5j
dHJsX2JpbmRfZmFpbGVkOgo+ICDCoMKgwqDCoMKgwqDCoCBkZXZpY2VfbGlua3Nfbm9fZHJpdmVy
KGRldik7Cj4gIMKgwqDCoMKgwqDCoMKgIGRldnJlc19yZWxlYXNlX2FsbChkZXYpOwo+IEBAIC0x
MjA0LDYgKzEyMjksNyBAQCBzdGF0aWMgdm9pZCBfX2RldmljZV9yZWxlYXNlX2RyaXZlcihzdHJ1
Y3QgZGV2aWNlIAo+ICpkZXYsIHN0cnVjdCBkZXZpY2UgKnBhcmVudCkKPiAgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGVsc2UgaWYgKGRydi0+cmVtb3ZlKQo+ICDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRydi0+cmVtb3ZlKGRldik7Cj4gCj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGV2aWNlX2RtYV9jbGVhbnVwKGRldiwgZHJ2
KTsKPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRldmljZV9saW5rc19kcml2ZXJf
Y2xlYW51cChkZXYpOwo+IAo+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGV2cmVz
X3JlbGVhc2VfYWxsKGRldik7Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvZGV2aWNlL2Ry
aXZlci5oIGIvaW5jbHVkZS9saW51eC9kZXZpY2UvZHJpdmVyLmgKPiBpbmRleCBhNDk4ZWJjZjQ5
OTMuLjM3NGEzYzJjYzEwZCAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2RldmljZS9kcml2
ZXIuaAo+ICsrKyBiL2luY2x1ZGUvbGludXgvZGV2aWNlL2RyaXZlci5oCj4gQEAgLTEwMCw2ICsx
MDAsNyBAQCBzdHJ1Y3QgZGV2aWNlX2RyaXZlciB7Cj4gIMKgwqDCoMKgwqDCoMKgIGNvbnN0IGNo
YXLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqbW9kX25hbWU7wqDCoMKgwqDCoCAvKiB1c2Vk
IGZvciBidWlsdC1pbiAKPiBtb2R1bGVzICovCj4gCj4gIMKgwqDCoMKgwqDCoMKgIGJvb2wgc3Vw
cHJlc3NfYmluZF9hdHRyczvCoMKgwqDCoMKgwqAgLyogZGlzYWJsZXMgYmluZC91bmJpbmQgdmlh
IAo+IHN5c2ZzICovCj4gK8KgwqDCoMKgwqDCoCBib29sIHN1cHByZXNzX2F1dG9fY2xhaW1fZG1h
X293bmVyOwo+ICDCoMKgwqDCoMKgwqDCoCBlbnVtIHByb2JlX3R5cGUgcHJvYmVfdHlwZTsKPiAK
PiAgwqDCoMKgwqDCoMKgwqAgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZMKgwqDCoMKgwqDCoCAq
b2ZfbWF0Y2hfdGFibGU7CgpEb2VzIHRoaXMgd29yayBmb3IgeW91PyBDYW4gSSB3b3JrIHRvd2Fy
ZHMgdGhpcyBpbiB0aGUgbmV4dCB2ZXJzaW9uPwoKQmVzdCByZWdhcmRzLApiYW9sdQpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxp
c3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
