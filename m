Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D92AAC4332F
	for <iommu@archiver.kernel.org>; Thu, 24 Mar 2022 11:05:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 78F4160E13;
	Thu, 24 Mar 2022 11:05:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DUtjgu5VEIYH; Thu, 24 Mar 2022 11:05:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 56BF360087;
	Thu, 24 Mar 2022 11:05:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2FC3CC001A;
	Thu, 24 Mar 2022 11:05:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB69AC000B
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 11:05:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B8E17841DF
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 11:05:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id moPu1o3T1ZjN for <iommu@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 11:05:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id EBDA58418D
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 11:05:17 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3FD11515;
 Thu, 24 Mar 2022 04:05:16 -0700 (PDT)
Received: from [10.57.43.230] (unknown [10.57.43.230])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E8DC3F73D;
 Thu, 24 Mar 2022 04:05:13 -0700 (PDT)
Message-ID: <81ffc753-72aa-6327-b87b-3f11915f2549@arm.com>
Date: Thu, 24 Mar 2022 11:05:08 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [REGRESSION] Recent swiotlb DMA_FROM_DEVICE fixes break
 ath9k-based AP
Content-Language: en-GB
To: Oleksandr Natalenko <oleksandr@natalenko.name>,
 Christoph Hellwig <hch@lst.de>
References: <1812355.tdWV9SEqCh@natalenko.name>
 <f88ca616-96d1-82dc-1bc8-b17480e937dd@arm.com>
 <20220324055732.GB12078@lst.de> <4386660.LvFx2qVVIh@natalenko.name>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <4386660.LvFx2qVVIh@natalenko.name>
Cc: =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@toke.dk>,
 Netdev <netdev@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 stable <stable@vger.kernel.org>, Halil Pasic <pasic@linux.ibm.com>,
 iommu <iommu@lists.linux-foundation.org>,
 Olha Cherevyk <olha.cherevyk@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>
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

T24gMjAyMi0wMy0yNCAxMDoyNSwgT2xla3NhbmRyIE5hdGFsZW5rbyB3cm90ZToKPiBIZWxsby4K
PiAKPiBPbiDEjXR2cnRlayAyNC4gYsWZZXpuYSAyMDIyIDY6NTc6MzIgQ0VUIENocmlzdG9waCBI
ZWxsd2lnIHdyb3RlOgo+PiBPbiBXZWQsIE1hciAyMywgMjAyMiBhdCAwODo1NDowOFBNICswMDAw
LCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4+PiBJJ2xsIGFkbWl0IEkgc3RpbGwgbmV2ZXIgcXVpdGUg
Z3Jhc3BlZCB0aGUgcmVhc29uIGZvciBhbHNvIGFkZGluZyB0aGUKPj4+IG92ZXJyaWRlIHRvIHN3
aW90bGJfc3luY19zaW5nbGVfZm9yX2RldmljZSgpIGluIGFhNmY4ZGNiYWI0NywgYnV0IEkgdGhp
bmsKPj4+IGJ5IHRoYXQgcG9pbnQgd2Ugd2VyZSBpbmNyZWFzaW5nbHkgdGlyZWQgYW5kIGNvbmZ1
c2VkIGFuZCBzdGFydGluZyB0bwo+Pj4gc2Vjb25kLWd1ZXNzIG91cnNlbHZlcyAod2VsbCwgSSB3
YXMsIGF0IGxlYXN0KS4gSSBkb24ndCB0aGluayBpdCdzIHdyb25nCj4+PiBwZXIgc2UsIGJ1dCBh
cyBJIHNhaWQgSSBkbyB0aGluayBpdCBjYW4gYml0ZSBhbnlvbmUgd2hvJ3MgYmVlbiBkb2luZwo+
Pj4gZG1hX3N5bmNfKigpIHdyb25nIGJ1dCBnZXR0aW5nIGF3YXkgd2l0aCBpdCB1bnRpbCBub3cu
IElmIGRkYmQ4OWRlYjdkMwo+Pj4gYWxvbmUgdHVybnMgb3V0IHRvIHdvcmsgT0sgdGhlbiBJJ2Qg
YmUgaW5jbGluZWQgdG8gdHJ5IGEgcGFydGlhbCByZXZlcnQgb2YKPj4+IGp1c3QgdGhhdCBvbmUg
aHVuay4KPj4KPj4gQWdyZWVkLiAgTGV0J3MgdHJ5IHRoYXQgZmlyc3QuCj4+Cj4+IE9sZWtzYW5k
ciwgY2FuIHlvdSB0cnkgdGhlIHBhdGNoIGJlbG93Ogo+Pgo+Pgo+PiBkaWZmIC0tZ2l0IGEva2Vy
bmVsL2RtYS9zd2lvdGxiLmMgYi9rZXJuZWwvZG1hL3N3aW90bGIuYwo+PiBpbmRleCA2ZGIxYzQ3
NWVjODI3Li42YzM1MDU1NWU1YTFjIDEwMDY0NAo+PiAtLS0gYS9rZXJuZWwvZG1hL3N3aW90bGIu
Ywo+PiArKysgYi9rZXJuZWwvZG1hL3N3aW90bGIuYwo+PiBAQCAtNzAxLDEzICs3MDEsMTAgQEAg
dm9pZCBzd2lvdGxiX3RibF91bm1hcF9zaW5nbGUoc3RydWN0IGRldmljZSAqZGV2LCBwaHlzX2Fk
ZHJfdCB0bGJfYWRkciwKPj4gICB2b2lkIHN3aW90bGJfc3luY19zaW5nbGVfZm9yX2RldmljZShz
dHJ1Y3QgZGV2aWNlICpkZXYsIHBoeXNfYWRkcl90IHRsYl9hZGRyLAo+PiAgIAkJc2l6ZV90IHNp
emUsIGVudW0gZG1hX2RhdGFfZGlyZWN0aW9uIGRpcikKPj4gICB7Cj4+IC0JLyoKPj4gLQkgKiBV
bmNvbmRpdGlvbmFsIGJvdW5jZSBpcyBuZWNlc3NhcnkgdG8gYXZvaWQgY29ycnVwdGlvbiBvbgo+
PiAtCSAqIHN5bmNfKl9mb3JfY3B1IG9yIGRtYV91bW1hcF8qIHdoZW4gdGhlIGRldmljZSBkaWRu
J3Qgb3ZlcndyaXRlCj4+IC0JICogdGhlIHdob2xlIGxlbmd0IG9mIHRoZSBib3VuY2UgYnVmZmVy
Lgo+PiAtCSAqLwo+PiAtCXN3aW90bGJfYm91bmNlKGRldiwgdGxiX2FkZHIsIHNpemUsIERNQV9U
T19ERVZJQ0UpOwo+PiAtCUJVR19PTighdmFsaWRfZG1hX2RpcmVjdGlvbihkaXIpKTsKPj4gKwlp
ZiAoZGlyID09IERNQV9UT19ERVZJQ0UgfHwgZGlyID09IERNQV9CSURJUkVDVElPTkFMKQo+PiAr
CQlzd2lvdGxiX2JvdW5jZShkZXYsIHRsYl9hZGRyLCBzaXplLCBETUFfVE9fREVWSUNFKTsKPj4g
KwllbHNlCj4+ICsJCUJVR19PTihkaXIgIT0gRE1BX0ZST01fREVWSUNFKTsKPj4gICB9Cj4+ICAg
Cj4+ICAgdm9pZCBzd2lvdGxiX3N5bmNfc2luZ2xlX2Zvcl9jcHUoc3RydWN0IGRldmljZSAqZGV2
LCBwaHlzX2FkZHJfdCB0bGJfYWRkciwKPj4KPiAKPiBXaXRoIHRoaXMgcGF0Y2ggdGhlIEFQIHdv
cmtzIGZvciBtZS4KCkNvb2wsIHRoYW5rcyBmb3IgY29uZmlybWluZy4gU28gSSB0aGluayBhdGg5
ayBwcm9iYWJseSBpcyBkb2luZyAKc29tZXRoaW5nIGRvZGd5IHdpdGggZG1hX3N5bmNfKigpLCBi
dXQgaWYgTGludXMgcHJlZmVycyB0byBtYWtlIHRoZSAKYWJvdmUgY2hhbmdlIHJhdGhlciB0aGFu
IHdhaXQgZm9yIHRoYXQgdG8gZ2V0IGZpZ3VyZWQgb3V0LCBJIGJlbGlldmUgCnRoYXQgc2hvdWxk
IGJlIGZpbmUuCgpUaGUgY3J1Y2lhbCBwYXJ0IG9mIHRoZSAicmV3b3JrIiBwYXRjaCBpcyB0aGF0
IHdlJ2xsIHVuY29uZGl0aW9uYWxseSAKaW5pdGlhbGlzZSB0aGUgU1dJT1RMQiBib3VuY2Ugc2xv
dCBhcyBpdCdzIGFsbG9jYXRlZCBpbiAKc3dpb3RsYl90YmxfbWFwX3NpbmdsZSgpLCByZWdhcmRs
ZXNzIG9mIERNQV9BVFRSX1NLSVBfQ1BVX1NZTkMuIEFzIGxvbmcgCmFzIHRoYXQgaGFwcGVucywg
d2UncmUgc2FmZSBpbiB0ZXJtcyBvZiBsZWFraW5nIGRhdGEgZnJvbSBwcmV2aW91cyAKbWFwcGlu
Z3MsIGFuZCBhbnkgcG9zc2liaWxpdHkgZm9yIGluY29ycmVjdCBzeW5jIHVzYWdlIHRvIGxvc2Ug
Cm5ld2x5LXdyaXR0ZW4gRE1BIGRhdGEgaXMgYXQgbGVhc3Qgbm8gd29yc2UgdGhhbiBpdCBhbHdh
eXMgaGFzIGJlZW4uIFRoZSAKbW9zdCBjb25mdXNpb24gd2FzIGFyb3VuZCBob3cgdGhlIHByb3Bv
c2VkIERNQV9BVFRSX09WRVJXUklURSBhdHRyaWJ1dGUgCndvdWxkIG5lZWQgdG8gaW50ZXJhY3Qg
d2l0aCBETUFfQVRUUl9TS0lQX0NQVV9TWU5DIHRvIHJlbWFpbiBzYWZlIGJ1dCAKc3RpbGwgaGF2
ZSBhbnkgdXNlZnVsIGFkdmFudGFnZSwgc28gdW5sZXNzIGFuZCB1bnRpbCBhbnlvbmUgd2FudHMg
dG8gCnJldmlzaXQgdGhhdCwgdGhpcyBzaG91bGQgcmVtYWluIGNvbXBhcmF0aXZlbHkgc2ltcGxl
IHRvIHJlYXNvbiBhYm91dC4KCkNoZWVycywKUm9iaW4uCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby9pb21tdQ==
