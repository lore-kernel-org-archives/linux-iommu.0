Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B9FC433EF
	for <iommu@archiver.kernel.org>; Wed, 15 Dec 2021 12:25:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CFF4A60E30;
	Wed, 15 Dec 2021 12:25:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JLKBVtSg9Zg8; Wed, 15 Dec 2021 12:25:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 98AFB60BAF;
	Wed, 15 Dec 2021 12:25:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 648EFC002F;
	Wed, 15 Dec 2021 12:25:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 90C6DC0012
 for <iommu@lists.linux-foundation.org>; Wed, 15 Dec 2021 12:25:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 69D0181A6A
 for <iommu@lists.linux-foundation.org>; Wed, 15 Dec 2021 12:25:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qSLMqp7-ZHNp for <iommu@lists.linux-foundation.org>;
 Wed, 15 Dec 2021 12:25:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3528481A3B
 for <iommu@lists.linux-foundation.org>; Wed, 15 Dec 2021 12:25:03 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10198"; a="325494545"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; d="scan'208";a="325494545"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2021 04:25:02 -0800
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; d="scan'208";a="518749567"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.215.57])
 ([10.254.215.57])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2021 04:24:55 -0800
Message-ID: <faa67db1-cba7-cc23-2a36-7dd716a1f7e3@linux.intel.com>
Date: Wed, 15 Dec 2021 20:24:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 04/18] driver core: platform: Add driver dma ownership
 management
Content-Language: en-US
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
 <5d537286-2cb3-cf91-c0de-019355110aa1@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <5d537286-2cb3-cf91-c0de-019355110aa1@linux.intel.com>
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

SGkgR3JlZywKCk9uIDIwMjEvMTIvMTMgODo1MCwgTHUgQmFvbHUgd3JvdGU6Cj4gT24gMTIvMTAv
MjEgOToyMyBBTSwgTHUgQmFvbHUgd3JvdGU6Cj4+IEhpIEdyZWcsIEphc29uIGFuZCBDaHJpc3Rv
cGgsCj4+Cj4+IE9uIDEyLzkvMjEgOToyMCBBTSwgTHUgQmFvbHUgd3JvdGU6Cj4+PiBPbiAxMi83
LzIxIDk6MTYgUE0sIEphc29uIEd1bnRob3JwZSB3cm90ZToKPj4+PiBPbiBUdWUsIERlYyAwNywg
MjAyMSBhdCAxMDo1NzoyNUFNICswODAwLCBMdSBCYW9sdSB3cm90ZToKPj4+Pj4gT24gMTIvNi8y
MSAxMTowNiBQTSwgSmFzb24gR3VudGhvcnBlIHdyb3RlOgo+Pj4+Pj4gT24gTW9uLCBEZWMgMDYs
IDIwMjEgYXQgMDY6MzY6MjdBTSAtMDgwMCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4+Pj4+
Pj4gSSByZWFsbHkgaGF0ZSB0aGUgYW1vdW50IG9mIGJvaWxlcnBsYXRlIGNvZGUgdGhhdCBoYXZp
bmcgdGhpcyBpbiAKPj4+Pj4+PiBlYWNoCj4+Pj4+Pj4gYnVzIHR5cGUgY2F1c2VzLgo+Pj4+Pj4g
KzEKPj4+Pj4+Cj4+Pj4+PiBJIGxpa2VkIHRoZSBmaXJzdCB2ZXJzaW9uIG9mIHRoaXMgc2VyaWVz
IGJldHRlciB3aXRoIHRoZSBjb2RlIG5lYXIKPj4+Pj4+IHJlYWxseV9wcm9iZSgpLgo+Pj4+Pj4K
Pj4+Pj4+IENhbiB3ZSBnbyBiYWNrIHRvIHRoYXQgd2l0aCBzb21lIGRldmljZV9jb25maWd1cmVf
ZG1hKCkgd3JhcHBlcgo+Pj4+Pj4gY29uZHRpb25hbGx5IGNhbGxlZCBieSByZWFsbHlfcHJvYmUg
YXMgd2UgZGlzY3Vzc2VkPwo+Pgo+PiBbLi4uXQo+Pgo+Pj4KPj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2Jhc2UvZGQuYyBiL2RyaXZlcnMvYmFzZS9kZC5jCj4+PiBpbmRleCA2OGVhMWY5NDlkYWEu
LjY4Y2E1YTU3OWViMSAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvYmFzZS9kZC5jCj4+PiArKysg
Yi9kcml2ZXJzL2Jhc2UvZGQuYwo+Pj4gQEAgLTUzOCw2ICs1MzgsMzIgQEAgc3RhdGljIGludCBj
YWxsX2RyaXZlcl9wcm9iZShzdHJ1Y3QgZGV2aWNlICpkZXYsIAo+Pj4gc3RydWN0IGRldmljZV9k
cml2ZXIgKmRydikKPj4+IMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHJldDsKPj4+IMKgwqB9Cj4+
Pgo+Pj4gK3N0YXRpYyBpbnQgZGV2aWNlX2RtYV9jb25maWd1cmUoc3RydWN0IGRldmljZSAqZGV2
LCBzdHJ1Y3QgCj4+PiBkZXZpY2VfZHJpdmVyICpkcnYpCj4+PiArewo+Pj4gK8KgwqDCoMKgwqDC
oCBpbnQgcmV0Owo+Pj4gKwo+Pj4gK8KgwqDCoMKgwqDCoCBpZiAoIWRldi0+YnVzLT5kbWFfY29u
ZmlndXJlKQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIDA7Cj4+PiAr
Cj4+PiArwqDCoMKgwqDCoMKgIHJldCA9IGRldi0+YnVzLT5kbWFfY29uZmlndXJlKGRldik7Cj4+
PiArwqDCoMKgwqDCoMKgIGlmIChyZXQpCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCByZXR1cm4gcmV0Owo+Pj4gKwo+Pj4gK8KgwqDCoMKgwqDCoCBpZiAoIWRydi0+c3VwcHJlc3Nf
YXV0b19jbGFpbV9kbWFfb3duZXIpCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBy
ZXQgPSBpb21tdV9kZXZpY2Vfc2V0X2RtYV9vd25lcihkZXYsIAo+Pj4gRE1BX09XTkVSX0RNQV9B
UEksIE5VTEwpOwo+Pj4gKwo+Pj4gK8KgwqDCoMKgwqDCoCByZXR1cm4gcmV0Owo+Pj4gK30KPj4+
ICsKPj4+ICtzdGF0aWMgdm9pZCBkZXZpY2VfZG1hX2NsZWFudXAoc3RydWN0IGRldmljZSAqZGV2
LCBzdHJ1Y3QgCj4+PiBkZXZpY2VfZHJpdmVyICpkcnYpCj4+PiArewo+Pj4gK8KgwqDCoMKgwqDC
oCBpZiAoIWRldi0+YnVzLT5kbWFfY29uZmlndXJlKQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcmV0dXJuOwo+Pj4gKwo+Pj4gK8KgwqDCoMKgwqDCoCBpZiAoIWRydi0+c3VwcHJl
c3NfYXV0b19jbGFpbV9kbWFfb3duZXIpCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBpb21tdV9kZXZpY2VfcmVsZWFzZV9kbWFfb3duZXIoZGV2LCBETUFfT1dORVJfRE1BX0FQSSk7
Cj4+PiArfQo+Pj4gKwo+Pj4gwqDCoHN0YXRpYyBpbnQgcmVhbGx5X3Byb2JlKHN0cnVjdCBkZXZp
Y2UgKmRldiwgc3RydWN0IGRldmljZV9kcml2ZXIgKmRydikKPj4+IMKgwqB7Cj4+PiDCoMKgwqDC
oMKgwqDCoMKgIGJvb2wgdGVzdF9yZW1vdmUgPSAKPj4+IElTX0VOQUJMRUQoQ09ORklHX0RFQlVH
X1RFU1RfRFJJVkVSX1JFTU9WRSkgJiYKPj4+IEBAIC01NzQsMTEgKzYwMCw4IEBAIHN0YXRpYyBp
bnQgcmVhbGx5X3Byb2JlKHN0cnVjdCBkZXZpY2UgKmRldiwgCj4+PiBzdHJ1Y3QgZGV2aWNlX2Ry
aXZlciAqZHJ2KQo+Pj4gwqDCoMKgwqDCoMKgwqDCoCBpZiAocmV0KQo+Pj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBwaW5jdHJsX2JpbmRfZmFpbGVkOwo+Pj4KPj4+IC3C
oMKgwqDCoMKgwqAgaWYgKGRldi0+YnVzLT5kbWFfY29uZmlndXJlKSB7Cj4+PiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSBkZXYtPmJ1cy0+ZG1hX2NvbmZpZ3VyZShkZXYpOwo+
Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHJldCkKPj4+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIHByb2JlX2ZhaWxlZDsKPj4+
IC3CoMKgwqDCoMKgwqAgfQo+Pj4gK8KgwqDCoMKgwqDCoCBpZiAoZGV2aWNlX2RtYV9jb25maWd1
cmUoZGV2LCBkcnYpKQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBwaW5j
dHJsX2JpbmRfZmFpbGVkOwo+Pj4KPj4+IMKgwqDCoMKgwqDCoMKgwqAgcmV0ID0gZHJpdmVyX3N5
c2ZzX2FkZChkZXYpOwo+Pj4gwqDCoMKgwqDCoMKgwqDCoCBpZiAocmV0KSB7Cj4+PiBAQCAtNjYw
LDYgKzY4Myw4IEBAIHN0YXRpYyBpbnQgcmVhbGx5X3Byb2JlKHN0cnVjdCBkZXZpY2UgKmRldiwg
Cj4+PiBzdHJ1Y3QgZGV2aWNlX2RyaXZlciAqZHJ2KQo+Pj4gwqDCoMKgwqDCoMKgwqDCoCBpZiAo
ZGV2LT5idXMpCj4+PiAgICAgICAgICAgICAgICAgIAo+Pj4gYmxvY2tpbmdfbm90aWZpZXJfY2Fs
bF9jaGFpbigmZGV2LT5idXMtPnAtPmJ1c19ub3RpZmllciwKPj4+Cj4+PiBCVVNfTk9USUZZX0RS
SVZFUl9OT1RfQk9VTkQsIGRldik7Cj4+PiArCj4+PiArwqDCoMKgwqDCoMKgIGRldmljZV9kbWFf
Y2xlYW51cChkZXYsIGRydik7Cj4+PiDCoMKgcGluY3RybF9iaW5kX2ZhaWxlZDoKPj4+IMKgwqDC
oMKgwqDCoMKgwqAgZGV2aWNlX2xpbmtzX25vX2RyaXZlcihkZXYpOwo+Pj4gwqDCoMKgwqDCoMKg
wqDCoCBkZXZyZXNfcmVsZWFzZV9hbGwoZGV2KTsKPj4+IEBAIC0xMjA0LDYgKzEyMjksNyBAQCBz
dGF0aWMgdm9pZCBfX2RldmljZV9yZWxlYXNlX2RyaXZlcihzdHJ1Y3QgCj4+PiBkZXZpY2UgKmRl
diwgc3RydWN0IGRldmljZSAqcGFyZW50KQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgZWxzZSBpZiAoZHJ2LT5yZW1vdmUpCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZHJ2LT5yZW1vdmUoZGV2KTsKPj4+Cj4+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZXZpY2VfZG1hX2NsZWFudXAoZGV2LCBkcnYpOwo+Pj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGV2aWNlX2xpbmtzX2RyaXZlcl9jbGVh
bnVwKGRldik7Cj4+Pgo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGV2cmVz
X3JlbGVhc2VfYWxsKGRldik7Cj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9kZXZpY2Uv
ZHJpdmVyLmggCj4+PiBiL2luY2x1ZGUvbGludXgvZGV2aWNlL2RyaXZlci5oCj4+PiBpbmRleCBh
NDk4ZWJjZjQ5OTMuLjM3NGEzYzJjYzEwZCAxMDA2NDQKPj4+IC0tLSBhL2luY2x1ZGUvbGludXgv
ZGV2aWNlL2RyaXZlci5oCj4+PiArKysgYi9pbmNsdWRlL2xpbnV4L2RldmljZS9kcml2ZXIuaAo+
Pj4gQEAgLTEwMCw2ICsxMDAsNyBAQCBzdHJ1Y3QgZGV2aWNlX2RyaXZlciB7Cj4+PiDCoMKgwqDC
oMKgwqDCoMKgIGNvbnN0IGNoYXLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqbW9kX25hbWU7
wqDCoMKgwqDCoCAvKiB1c2VkIGZvciBidWlsdC1pbiAKPj4+IG1vZHVsZXMgKi8KPj4+Cj4+PiDC
oMKgwqDCoMKgwqDCoMKgIGJvb2wgc3VwcHJlc3NfYmluZF9hdHRyczvCoMKgwqDCoMKgwqAgLyog
ZGlzYWJsZXMgYmluZC91bmJpbmQgdmlhIAo+Pj4gc3lzZnMgKi8KPj4+ICvCoMKgwqDCoMKgwqAg
Ym9vbCBzdXBwcmVzc19hdXRvX2NsYWltX2RtYV9vd25lcjsKPj4+IMKgwqDCoMKgwqDCoMKgwqAg
ZW51bSBwcm9iZV90eXBlIHByb2JlX3R5cGU7Cj4+Pgo+Pj4gwqDCoMKgwqDCoMKgwqDCoCBjb25z
dCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkwqDCoMKgwqDCoMKgICpvZl9tYXRjaF90YWJsZTsKPj4KPj4g
RG9lcyB0aGlzIHdvcmsgZm9yIHlvdT8gQ2FuIEkgd29yayB0b3dhcmRzIHRoaXMgaW4gdGhlIG5l
eHQgdmVyc2lvbj8KPiAKPiBBIGtpbmRseSBwaW5nIC4uLiBJcyB0aGlzIGhlYWRpbmcgdGhlIHJp
Z2h0IGRpcmVjdGlvbj8gSSBuZWVkIHlvdXIKPiBhZHZpY2UgdG8gbW92ZSBhaGVhZC4gOi0pCgpD
YW4gSSBkbyBpdCBsaWtlIHRoaXM/IDotKQoKQmVzdCByZWdhcmRzLApiYW9sdQpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QK
aW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
