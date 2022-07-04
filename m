Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C74EBC43334
	for <iommu@archiver.kernel.org>; Mon,  4 Jul 2022 15:08:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 58DE2817A3;
	Mon,  4 Jul 2022 15:08:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 58DE2817A3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Is1MZnuVMIPz; Mon,  4 Jul 2022 15:08:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 19AB3813AD;
	Mon,  4 Jul 2022 15:08:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 19AB3813AD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EE3FCC0032;
	Mon,  4 Jul 2022 15:08:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6923EC002D
 for <iommu@lists.linux-foundation.org>; Mon,  4 Jul 2022 15:08:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3472540904
 for <iommu@lists.linux-foundation.org>; Mon,  4 Jul 2022 15:08:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3472540904
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lDYPn0CCGITH for <iommu@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 15:08:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A85BD40879
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id A85BD40879
 for <iommu@lists.linux-foundation.org>; Mon,  4 Jul 2022 15:08:46 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03A6F23A;
 Mon,  4 Jul 2022 08:08:46 -0700 (PDT)
Received: from [10.57.86.91] (unknown [10.57.86.91])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B9C583F792;
 Mon,  4 Jul 2022 08:08:41 -0700 (PDT)
Message-ID: <2be62742-4737-bb3c-5467-011a26edfcea@arm.com>
Date: Mon, 4 Jul 2022 16:08:37 +0100
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
ZXNzIHNwYWNlIGZvciBtZW1vcnkgQkFScyB1c2VkIGluIHRoZQo+IHRyYW5zYWN0aW9ucy4KCkFu
b3RoZXIgdGhvdWdodCB0aGF0J3MgaGl0IG1lIHNsaWdodGx5IGxhdGU7IGRlcGVuZGluZyBvbiBD
T05GSUdfNjRCSVQgCmFsc28gbWVhbnMgdGhhdCB3ZSd2ZSBnb3QgYSB3aG9sZSA0IGJ5dGVzIG9m
IHBhZGRpbmcgaW4gc3RydWN0IApzY2F0dGVybGlzdCB0byBwbGF5IHdpdGgsIHNvIGF0IHRoYXQg
cG9pbnQgbWF5YmUgaXQncyB3b3J0aCBjb25zaWRlcmluZyAKY2FycnlpbmcgbmV3IGV4dHJhIERN
QSBtYXBwaW5nIHByb3BlcnRpZXMgaW4gdGhlaXIgb3duIGZpZWxkKHMpLiBGb3IgCmluc3RhbmNl
IGl0IHdvdWxkIGFsc28gYmUgcmVhbGx5IGhlbHBmdWwgdG8gZmxhZyB3aGV0aGVyIGEgc2VnbWVu
dCBpcyAKYm91bmNlLWJ1ZmZlcmVkIG9yIG5vdC4KClJvYmluLgoKPiBTaWduZWQtb2ZmLWJ5OiBM
b2dhbiBHdW50aG9ycGUgPGxvZ2FuZ0BkZWx0YXRlZS5jb20+Cj4gUmV2aWV3ZWQtYnk6IENoYWl0
YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL3BjaS9LY29u
ZmlnICAgICAgICAgfCAgNSArKysrKwo+ICAgaW5jbHVkZS9saW51eC9zY2F0dGVybGlzdC5oIHwg
NDQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQo+ICAgMiBmaWxlcyBjaGFu
Z2VkLCA0OCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvcGNpL0tjb25maWcgYi9kcml2ZXJzL3BjaS9LY29uZmlnCj4gaW5kZXggMTMzYzczMjA3
NzgyLi41Y2M3Y2JhMTk0MWYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9wY2kvS2NvbmZpZwo+ICsr
KyBiL2RyaXZlcnMvcGNpL0tjb25maWcKPiBAQCAtMTY0LDYgKzE2NCwxMSBAQCBjb25maWcgUENJ
X1BBU0lECj4gICBjb25maWcgUENJX1AyUERNQQo+ICAgCWJvb2wgIlBDSSBwZWVyLXRvLXBlZXIg
dHJhbnNmZXIgc3VwcG9ydCIKPiAgIAlkZXBlbmRzIG9uIFpPTkVfREVWSUNFCj4gKwkjCj4gKwkj
IFRoZSBuZWVkIGZvciB0aGUgc2NhdHRlcmxpc3QgRE1BIGJ1cyBhZGRyZXNzIGZsYWcgbWVhbnMg
UENJIFAyUERNQQo+ICsJIyByZXF1aXJlcyA2NGJpdAo+ICsJIwo+ICsJZGVwZW5kcyBvbiA2NEJJ
VAo+ICAgCXNlbGVjdCBHRU5FUklDX0FMTE9DQVRPUgo+ICAgCWhlbHAKPiAgIAkgIEVuYWJsZdGV
IGRyaXZlcnMgdG8gZG8gUENJIHBlZXItdG8tcGVlciB0cmFuc2FjdGlvbnMgdG8gYW5kIGZyb20K
PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zY2F0dGVybGlzdC5oIGIvaW5jbHVkZS9saW51
eC9zY2F0dGVybGlzdC5oCj4gaW5kZXggN2ZmOWQ2Mzg2YzEyLi42NTYxY2E4YWVhZDggMTAwNjQ0
Cj4gLS0tIGEvaW5jbHVkZS9saW51eC9zY2F0dGVybGlzdC5oCj4gKysrIGIvaW5jbHVkZS9saW51
eC9zY2F0dGVybGlzdC5oCj4gQEAgLTY0LDEyICs2NCwyNCBAQCBzdHJ1Y3Qgc2dfYXBwZW5kX3Rh
YmxlIHsKPiAgICNkZWZpbmUgU0dfQ0hBSU4JMHgwMVVMCj4gICAjZGVmaW5lIFNHX0VORAkJMHgw
MlVMCj4gICAKPiArLyoKPiArICogYml0IDIgaXMgdGhlIHRoaXJkIGZyZWUgYml0IGluIHRoZSBw
YWdlX2xpbmsgb24gNjRiaXQgc3lzdGVtcyB3aGljaAo+ICsgKiBpcyB1c2VkIGJ5IGRtYV91bm1h
cF9zZygpIHRvIGRldGVybWluZSBpZiB0aGUgZG1hX2FkZHJlc3MgaXMgYQo+ICsgKiBidXMgYWRk
cmVzcyB3aGVuIGRvaW5nIFAyUERNQS4KPiArICovCj4gKyNpZmRlZiBDT05GSUdfUENJX1AyUERN
QQo+ICsjZGVmaW5lIFNHX0RNQV9CVVNfQUREUkVTUwkweDA0VUwKPiArc3RhdGljX2Fzc2VydChf
X2FsaWdub2ZfXyhzdHJ1Y3QgcGFnZSkgPj0gOCk7Cj4gKyNlbHNlCj4gKyNkZWZpbmUgU0dfRE1B
X0JVU19BRERSRVNTCTB4MDBVTAo+ICsjZW5kaWYKPiArCj4gICAvKgo+ICAgICogV2Ugb3Zlcmxv
YWQgdGhlIExTQiBvZiB0aGUgcGFnZSBwb2ludGVyIHRvIGluZGljYXRlIHdoZXRoZXIgaXQncwo+
ICAgICogYSB2YWxpZCBzZyBlbnRyeSwgb3Igd2hldGhlciBpdCBwb2ludHMgdG8gdGhlIHN0YXJ0
IG9mIGEgbmV3IHNjYXR0ZXJsaXN0Lgo+ICAgICogVGhvc2UgbG93IGJpdHMgYXJlIHRoZXJlIGZv
ciBldmVyeW9uZSEgKHRoYW5rcyBtYXNvbiA6LSkKPiAgICAqLwo+IC0jZGVmaW5lIFNHX1BBR0Vf
TElOS19NQVNLIChTR19DSEFJTiB8IFNHX0VORCkKPiArI2RlZmluZSBTR19QQUdFX0xJTktfTUFT
SyAoU0dfQ0hBSU4gfCBTR19FTkQgfCBTR19ETUFfQlVTX0FERFJFU1MpCj4gICAKPiAgIHN0YXRp
YyBpbmxpbmUgdW5zaWduZWQgaW50IF9fc2dfZmxhZ3Moc3RydWN0IHNjYXR0ZXJsaXN0ICpzZykK
PiAgIHsKPiBAQCAtOTEsNiArMTAzLDExIEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBzZ19pc19sYXN0
KHN0cnVjdCBzY2F0dGVybGlzdCAqc2cpCj4gICAJcmV0dXJuIF9fc2dfZmxhZ3Moc2cpICYgU0df
RU5EOwo+ICAgfQo+ICAgCj4gK3N0YXRpYyBpbmxpbmUgYm9vbCBzZ19pc19kbWFfYnVzX2FkZHJl
c3Moc3RydWN0IHNjYXR0ZXJsaXN0ICpzZykKPiArewo+ICsJcmV0dXJuIF9fc2dfZmxhZ3Moc2cp
ICYgU0dfRE1BX0JVU19BRERSRVNTOwo+ICt9Cj4gKwo+ICAgLyoqCj4gICAgKiBzZ19hc3NpZ25f
cGFnZSAtIEFzc2lnbiBhIGdpdmVuIHBhZ2UgdG8gYW4gU0cgZW50cnkKPiAgICAqIEBzZzoJCSAg
ICBTRyBlbnRyeQo+IEBAIC0yNDUsNiArMjYyLDMxIEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBzZ191
bm1hcmtfZW5kKHN0cnVjdCBzY2F0dGVybGlzdCAqc2cpCj4gICAJc2ctPnBhZ2VfbGluayAmPSB+
U0dfRU5EOwo+ICAgfQo+ICAgCj4gKy8qKgo+ICsgKiBzZ19kbWFfbWFya19idXMgYWRkcmVzcyAt
IE1hcmsgdGhlIHNjYXR0ZXJsaXN0IGVudHJ5IGFzIGEgYnVzIGFkZHJlc3MKPiArICogQHNnOgkJ
IFNHIGVudHJ5U2NhdHRlcmxpc3QKPiArICoKPiArICogRGVzY3JpcHRpb246Cj4gKyAqICAgTWFy
a3MgdGhlIHBhc3NlZCBpbiBzZyBlbnRyeSB0byBpbmRpY2F0ZSB0aGF0IHRoZSBkbWFfYWRkcmVz
cyBpcwo+ICsgKiAgIGEgYnVzIGFkZHJlc3MgYW5kIGRvZXNuJ3QgbmVlZCB0byBiZSB1bm1hcHBl
ZC4KPiArICoqLwo+ICtzdGF0aWMgaW5saW5lIHZvaWQgc2dfZG1hX21hcmtfYnVzX2FkZHJlc3Mo
c3RydWN0IHNjYXR0ZXJsaXN0ICpzZykKPiArewo+ICsJc2ctPnBhZ2VfbGluayB8PSBTR19ETUFf
QlVTX0FERFJFU1M7Cj4gK30KPiArCj4gKy8qKgo+ICsgKiBzZ191bm1hcmtfcGNpX3AycGRtYSAt
IFVubWFyayB0aGUgc2NhdHRlcmxpc3QgZW50cnkgYXMgYSBidXMgYWRkcmVzcwo+ICsgKiBAc2c6
CQkgU0cgZW50cnlTY2F0dGVybGlzdAo+ICsgKgo+ICsgKiBEZXNjcmlwdGlvbjoKPiArICogICBD
bGVhcnMgdGhlIGJ1cyBhZGRyZXNzIG1hcmsuCj4gKyAqKi8KPiArc3RhdGljIGlubGluZSB2b2lk
IHNnX2RtYV91bm1hcmtfYnVzX2FkZHJlc3Moc3RydWN0IHNjYXR0ZXJsaXN0ICpzZykKPiArewo+
ICsJc2ctPnBhZ2VfbGluayAmPSB+U0dfRE1BX0JVU19BRERSRVNTOwo+ICt9Cj4gKwo+ICAgLyoq
Cj4gICAgKiBzZ19waHlzIC0gUmV0dXJuIHBoeXNpY2FsIGFkZHJlc3Mgb2YgYW4gc2cgZW50cnkK
PiAgICAqIEBzZzoJICAgICBTRyBlbnRyeQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vaW9tbXU=
