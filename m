Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F8CCCA47C
	for <iommu@archiver.kernel.org>; Wed, 29 Jun 2022 09:05:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4059681A99;
	Wed, 29 Jun 2022 09:05:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4059681A99
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fgh9xTIqF-vY; Wed, 29 Jun 2022 09:05:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D2BA7827AA;
	Wed, 29 Jun 2022 09:05:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D2BA7827AA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90C7CC0032;
	Wed, 29 Jun 2022 09:05:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05FD5C002D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 09:05:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CED3640547
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 09:05:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CED3640547
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7k0r_ZBiOGW3 for <iommu@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 09:05:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8FFDF40105
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8FFDF40105
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 09:05:51 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B53E41477;
 Wed, 29 Jun 2022 02:05:50 -0700 (PDT)
Received: from [10.57.85.71] (unknown [10.57.85.71])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA2B53F792;
 Wed, 29 Jun 2022 02:05:45 -0700 (PDT)
Message-ID: <b56d9b93-c59f-5764-e599-d9718edb42d3@arm.com>
Date: Wed, 29 Jun 2022 10:05:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v7 01/21] lib/scatterlist: add flag for indicating P2PDMA
 segments in an SGL
Content-Language: en-GB
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
References: <20220615161233.17527-1-logang@deltatee.com>
 <20220615161233.17527-2-logang@deltatee.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220615161233.17527-2-logang@deltatee.com>
Cc: Minturn Dave B <dave.b.minturn@intel.com>,
 Ralph Campbell <rcampbell@nvidia.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Jason Ekstrand <jason@jlekstrand.net>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Bjorn Helgaas <helgaas@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Stephen Bates <sbates@raithlin.com>, Ira Weiny <ira.weiny@intel.com>,
 Christoph Hellwig <hch@lst.de>, Xiong Jianxin <jianxin.xiong@intel.com>
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

T24gMjAyMi0wNi0xNSAxNzoxMiwgTG9nYW4gR3VudGhvcnBlIHdyb3RlOgo+IE1ha2UgdXNlIG9m
IHRoZSB0aGlyZCBmcmVlIExTQiBpbiBzY2F0dGVybGlzdCdzIHBhZ2VfbGluayBvbiA2NGJpdCBz
eXN0ZW1zLgo+IAo+IFRoZSBleHRyYSBiaXQgd2lsbCBiZSB1c2VkIGJ5IGRtYV9bdW5dbWFwX3Nn
X3AycGRtYSgpIHRvIGRldGVybWluZSB3aGVuIGEKPiBnaXZlbiBTR0wgc2VnbWVudHMgZG1hX2Fk
ZHJlc3MgcG9pbnRzIHRvIGEgUENJIGJ1cyBhZGRyZXNzLgo+IGRtYV91bm1hcF9zZ19wMnBkbWEo
KSB3aWxsIG5lZWQgdG8gcGVyZm9ybSBkaWZmZXJlbnQgY2xlYW51cCB3aGVuIGEKPiBzZWdtZW50
IGlzIG1hcmtlZCBhcyBhIGJ1cyBhZGRyZXNzLgo+IAo+IFRoZSBuZXcgYml0IHdpbGwgb25seSBi
ZSB1c2VkIHdoZW4gQ09ORklHX1BDSV9QMlBETUEgaXMgc2V0OyB0aGlzIG1lYW5zCj4gUENJIFAy
UERNQSB3aWxsIHJlcXVpcmUgQ09ORklHXzY0QklULiBUaGlzIHNob3VsZCBiZSBhY2NlcHRhYmxl
IGFzIHRoZQo+IG1ham9yaXR5IG9mIFAyUERNQSB1c2UgY2FzZXMgYXJlIHJlc3RyaWN0ZWQgdG8g
bmV3ZXIgcm9vdCBjb21wbGV4ZXMgYW5kCj4gcm91Z2hseSByZXF1aXJlIHRoZSBleHRyYSBhZGRy
ZXNzIHNwYWNlIGZvciBtZW1vcnkgQkFScyB1c2VkIGluIHRoZQo+IHRyYW5zYWN0aW9ucy4KPiAK
PiBTaWduZWQtb2ZmLWJ5OiBMb2dhbiBHdW50aG9ycGUgPGxvZ2FuZ0BkZWx0YXRlZS5jb20+Cj4g
UmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+Cj4gLS0tCj4g
ICBkcml2ZXJzL3BjaS9LY29uZmlnICAgICAgICAgfCAgNSArKysrKwo+ICAgaW5jbHVkZS9saW51
eC9zY2F0dGVybGlzdC5oIHwgNDQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
LQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCA0OCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4g
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL0tjb25maWcgYi9kcml2ZXJzL3BjaS9LY29uZmln
Cj4gaW5kZXggMTMzYzczMjA3NzgyLi41Y2M3Y2JhMTk0MWYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVy
cy9wY2kvS2NvbmZpZwo+ICsrKyBiL2RyaXZlcnMvcGNpL0tjb25maWcKPiBAQCAtMTY0LDYgKzE2
NCwxMSBAQCBjb25maWcgUENJX1BBU0lECj4gICBjb25maWcgUENJX1AyUERNQQo+ICAgCWJvb2wg
IlBDSSBwZWVyLXRvLXBlZXIgdHJhbnNmZXIgc3VwcG9ydCIKPiAgIAlkZXBlbmRzIG9uIFpPTkVf
REVWSUNFCj4gKwkjCj4gKwkjIFRoZSBuZWVkIGZvciB0aGUgc2NhdHRlcmxpc3QgRE1BIGJ1cyBh
ZGRyZXNzIGZsYWcgbWVhbnMgUENJIFAyUERNQQo+ICsJIyByZXF1aXJlcyA2NGJpdAo+ICsJIwo+
ICsJZGVwZW5kcyBvbiA2NEJJVAo+ICAgCXNlbGVjdCBHRU5FUklDX0FMTE9DQVRPUgo+ICAgCWhl
bHAKPiAgIAkgIEVuYWJsZdGVIGRyaXZlcnMgdG8gZG8gUENJIHBlZXItdG8tcGVlciB0cmFuc2Fj
dGlvbnMgdG8gYW5kIGZyb20KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zY2F0dGVybGlz
dC5oIGIvaW5jbHVkZS9saW51eC9zY2F0dGVybGlzdC5oCj4gaW5kZXggN2ZmOWQ2Mzg2YzEyLi42
NTYxY2E4YWVhZDggMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS9saW51eC9zY2F0dGVybGlzdC5oCj4g
KysrIGIvaW5jbHVkZS9saW51eC9zY2F0dGVybGlzdC5oCj4gQEAgLTY0LDEyICs2NCwyNCBAQCBz
dHJ1Y3Qgc2dfYXBwZW5kX3RhYmxlIHsKPiAgICNkZWZpbmUgU0dfQ0hBSU4JMHgwMVVMCj4gICAj
ZGVmaW5lIFNHX0VORAkJMHgwMlVMCj4gICAKPiArLyoKPiArICogYml0IDIgaXMgdGhlIHRoaXJk
IGZyZWUgYml0IGluIHRoZSBwYWdlX2xpbmsgb24gNjRiaXQgc3lzdGVtcyB3aGljaAo+ICsgKiBp
cyB1c2VkIGJ5IGRtYV91bm1hcF9zZygpIHRvIGRldGVybWluZSBpZiB0aGUgZG1hX2FkZHJlc3Mg
aXMgYQo+ICsgKiBidXMgYWRkcmVzcyB3aGVuIGRvaW5nIFAyUERNQS4KPiArICovCj4gKyNpZmRl
ZiBDT05GSUdfUENJX1AyUERNQQo+ICsjZGVmaW5lIFNHX0RNQV9CVVNfQUREUkVTUwkweDA0VUwK
PiArc3RhdGljX2Fzc2VydChfX2FsaWdub2ZfXyhzdHJ1Y3QgcGFnZSkgPj0gOCk7Cj4gKyNlbHNl
Cj4gKyNkZWZpbmUgU0dfRE1BX0JVU19BRERSRVNTCTB4MDBVTAo+ICsjZW5kaWYKPiArCj4gICAv
Kgo+ICAgICogV2Ugb3ZlcmxvYWQgdGhlIExTQiBvZiB0aGUgcGFnZSBwb2ludGVyIHRvIGluZGlj
YXRlIHdoZXRoZXIgaXQncwo+ICAgICogYSB2YWxpZCBzZyBlbnRyeSwgb3Igd2hldGhlciBpdCBw
b2ludHMgdG8gdGhlIHN0YXJ0IG9mIGEgbmV3IHNjYXR0ZXJsaXN0Lgo+ICAgICogVGhvc2UgbG93
IGJpdHMgYXJlIHRoZXJlIGZvciBldmVyeW9uZSEgKHRoYW5rcyBtYXNvbiA6LSkKPiAgICAqLwo+
IC0jZGVmaW5lIFNHX1BBR0VfTElOS19NQVNLIChTR19DSEFJTiB8IFNHX0VORCkKPiArI2RlZmlu
ZSBTR19QQUdFX0xJTktfTUFTSyAoU0dfQ0hBSU4gfCBTR19FTkQgfCBTR19ETUFfQlVTX0FERFJF
U1MpCj4gICAKPiAgIHN0YXRpYyBpbmxpbmUgdW5zaWduZWQgaW50IF9fc2dfZmxhZ3Moc3RydWN0
IHNjYXR0ZXJsaXN0ICpzZykKPiAgIHsKPiBAQCAtOTEsNiArMTAzLDExIEBAIHN0YXRpYyBpbmxp
bmUgYm9vbCBzZ19pc19sYXN0KHN0cnVjdCBzY2F0dGVybGlzdCAqc2cpCj4gICAJcmV0dXJuIF9f
c2dfZmxhZ3Moc2cpICYgU0dfRU5EOwo+ICAgfQo+ICAgCj4gK3N0YXRpYyBpbmxpbmUgYm9vbCBz
Z19pc19kbWFfYnVzX2FkZHJlc3Moc3RydWN0IHNjYXR0ZXJsaXN0ICpzZykKPiArewo+ICsJcmV0
dXJuIF9fc2dfZmxhZ3Moc2cpICYgU0dfRE1BX0JVU19BRERSRVNTOwo+ICt9Cj4gKwo+ICAgLyoq
Cj4gICAgKiBzZ19hc3NpZ25fcGFnZSAtIEFzc2lnbiBhIGdpdmVuIHBhZ2UgdG8gYW4gU0cgZW50
cnkKPiAgICAqIEBzZzoJCSAgICBTRyBlbnRyeQo+IEBAIC0yNDUsNiArMjYyLDMxIEBAIHN0YXRp
YyBpbmxpbmUgdm9pZCBzZ191bm1hcmtfZW5kKHN0cnVjdCBzY2F0dGVybGlzdCAqc2cpCj4gICAJ
c2ctPnBhZ2VfbGluayAmPSB+U0dfRU5EOwo+ICAgfQo+ICAgCj4gKy8qKgo+ICsgKiBzZ19kbWFf
bWFya19idXMgYWRkcmVzcyAtIE1hcmsgdGhlIHNjYXR0ZXJsaXN0IGVudHJ5IGFzIGEgYnVzIGFk
ZHJlc3MKPiArICogQHNnOgkJIFNHIGVudHJ5U2NhdHRlcmxpc3QKCmVudHJ5U2NhdHRlcmxpc3Q/
Cgo+ICsgKgo+ICsgKiBEZXNjcmlwdGlvbjoKPiArICogICBNYXJrcyB0aGUgcGFzc2VkIGluIHNn
IGVudHJ5IHRvIGluZGljYXRlIHRoYXQgdGhlIGRtYV9hZGRyZXNzIGlzCj4gKyAqICAgYSBidXMg
YWRkcmVzcyBhbmQgZG9lc24ndCBuZWVkIHRvIGJlIHVubWFwcGVkLgo+ICsgKiovCj4gK3N0YXRp
YyBpbmxpbmUgdm9pZCBzZ19kbWFfbWFya19idXNfYWRkcmVzcyhzdHJ1Y3Qgc2NhdHRlcmxpc3Qg
KnNnKQo+ICt7Cj4gKwlzZy0+cGFnZV9saW5rIHw9IFNHX0RNQV9CVVNfQUREUkVTUzsKPiArfQo+
ICsKPiArLyoqCj4gKyAqIHNnX3VubWFya19wY2lfcDJwZG1hIC0gVW5tYXJrIHRoZSBzY2F0dGVy
bGlzdCBlbnRyeSBhcyBhIGJ1cyBhZGRyZXNzCj4gKyAqIEBzZzoJCSBTRyBlbnRyeVNjYXR0ZXJs
aXN0Cj4gKyAqCj4gKyAqIERlc2NyaXB0aW9uOgo+ICsgKiAgIENsZWFycyB0aGUgYnVzIGFkZHJl
c3MgbWFyay4KPiArICoqLwo+ICtzdGF0aWMgaW5saW5lIHZvaWQgc2dfZG1hX3VubWFya19idXNf
YWRkcmVzcyhzdHJ1Y3Qgc2NhdHRlcmxpc3QgKnNnKQo+ICt7Cj4gKwlzZy0+cGFnZV9saW5rICY9
IH5TR19ETUFfQlVTX0FERFJFU1M7Cj4gK30KCkRvZXMgdGhpcyBzZXJ2ZSBhbnkgdXNlZnVsIHB1
cnBvc2U/IElmIGEgcGFnZSBpcyBkZXRlcm1pbmVkIHRvIGJlIGRldmljZSAKbWVtb3J5LCBpdCdz
IG5vdCBnb2luZyB0byBzdWRkZW5seSBzdG9wIGJlaW5nIGRldmljZSBtZW1vcnksIGFuZCBpZiB0
aGUgCnVuZGVybHlpbmcgc2cgaXMgcmVjeWNsZWQgdG8gcG9pbnQgZWxzZXdoZXJlIHRoZW4gc2df
YXNzaWduX3BhZ2UoKSB3aWxsIApzdGlsbCAoY29ycmVjdGx5KSBjbGVhciB0aGlzIGZsYWcgYW55
d2F5LiBUcnlpbmcgdG8gcmVhc29uIGFib3V0IHRoaXMgCmJleW9uZCBzdXBlcmZpY2lhbCBBUEkg
c3ltbWV0cnkgLSBpLmUuIHdoeSBleGFjdGx5IHdvdWxkIGEgY2FsbGVyIG5lZWQgCnRvIGNhbGwg
aXQsIGFuZCB3aGF0IHdvdWxkIHRoZSBpbXBsaWNhdGlvbnMgYmUgb2YgZmFpbGluZyB0byBkbyBz
byAtIApzZWVtcyB0byBsZWFkIHN0cmFpZ2h0IHRvIGNvbmZ1c2lvbi4KCkluIGZhY3QgSSdkIGJl
IGluY2xpbmVkIHRvIGhhdmUgc2dfYXNzaWduX3BhZ2UoKSBiZSByZXNwb25zaWJsZSBmb3IgCnNl
dHRpbmcgdGhlIGZsYWcgYXV0b21hdGljYWxseSBhcyB3ZWxsLCBhbmQgdGh1cyBub3QgbmVlZCAK
c2dfZG1hX21hcmtfYnVzX2FkZHJlc3MoKSBlaXRoZXIsIGhvd2V2ZXIgSSBjYW4gc2VlIHRoZSBh
cmd1bWVudCBmb3IgCmRvaW5nIGl0IHRoaXMgd2F5IHJvdW5kIHRvIG5vdCBlbnRhbmdsZSB0aGUg
QVBJcyB0b28gbXVjaCwgc28gSSBkb24ndCAKaGF2ZSBhbnkgZ3JlYXQgb2JqZWN0aW9uIHRvIHRo
YXQuCgpUaGFua3MsClJvYmluLgoKPiArCj4gICAvKioKPiAgICAqIHNnX3BoeXMgLSBSZXR1cm4g
cGh5c2ljYWwgYWRkcmVzcyBvZiBhbiBzZyBlbnRyeQo+ICAgICogQHNnOgkgICAgIFNHIGVudHJ5
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1h
aWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
