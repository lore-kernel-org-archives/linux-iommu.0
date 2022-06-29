Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74070C43334
	for <iommu@archiver.kernel.org>; Wed, 29 Jun 2022 18:02:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E326F4240C;
	Wed, 29 Jun 2022 18:02:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E326F4240C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jExHUh5ZCwOM; Wed, 29 Jun 2022 18:02:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0542241BE7;
	Wed, 29 Jun 2022 18:02:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0542241BE7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3E5BC0021;
	Wed, 29 Jun 2022 18:02:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7E5ADC0011
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 18:02:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5D22B41BDF
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 18:02:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5D22B41BDF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hXx81WqKSayI for <iommu@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 18:02:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 902D8423F6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 902D8423F6
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 18:02:43 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E21051480;
 Wed, 29 Jun 2022 11:02:42 -0700 (PDT)
Received: from [10.57.85.71] (unknown [10.57.85.71])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 050C53F5A1;
 Wed, 29 Jun 2022 11:02:37 -0700 (PDT)
Message-ID: <d84a0498-3b7f-3d38-2bfd-9a175db4002a@arm.com>
Date: Wed, 29 Jun 2022 19:02:33 +0100
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
 <b56d9b93-c59f-5764-e599-d9718edb42d3@arm.com>
 <c42b5ee3-5d4f-7e44-8885-26b8417208ae@deltatee.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <c42b5ee3-5d4f-7e44-8885-26b8417208ae@deltatee.com>
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

T24gMjAyMi0wNi0yOSAxNjozOSwgTG9nYW4gR3VudGhvcnBlIHdyb3RlOgo+IAo+IAo+IAo+IE9u
IDIwMjItMDYtMjkgMDM6MDUsIFJvYmluIE11cnBoeSB3cm90ZToKPj4gT24gMjAyMi0wNi0xNSAx
NzoxMiwgTG9nYW4gR3VudGhvcnBlIHdyb3RlOgo+Pj4gTWFrZSB1c2Ugb2YgdGhlIHRoaXJkIGZy
ZWUgTFNCIGluIHNjYXR0ZXJsaXN0J3MgcGFnZV9saW5rIG9uIDY0Yml0Cj4+PiBzeXN0ZW1zLgo+
Pj4KPj4+IFRoZSBleHRyYSBiaXQgd2lsbCBiZSB1c2VkIGJ5IGRtYV9bdW5dbWFwX3NnX3AycGRt
YSgpIHRvIGRldGVybWluZSB3aGVuIGEKPj4+IGdpdmVuIFNHTCBzZWdtZW50cyBkbWFfYWRkcmVz
cyBwb2ludHMgdG8gYSBQQ0kgYnVzIGFkZHJlc3MuCj4+PiBkbWFfdW5tYXBfc2dfcDJwZG1hKCkg
d2lsbCBuZWVkIHRvIHBlcmZvcm0gZGlmZmVyZW50IGNsZWFudXAgd2hlbiBhCj4+PiBzZWdtZW50
IGlzIG1hcmtlZCBhcyBhIGJ1cyBhZGRyZXNzLgo+Pj4KPj4+IFRoZSBuZXcgYml0IHdpbGwgb25s
eSBiZSB1c2VkIHdoZW4gQ09ORklHX1BDSV9QMlBETUEgaXMgc2V0OyB0aGlzIG1lYW5zCj4+PiBQ
Q0kgUDJQRE1BIHdpbGwgcmVxdWlyZSBDT05GSUdfNjRCSVQuIFRoaXMgc2hvdWxkIGJlIGFjY2Vw
dGFibGUgYXMgdGhlCj4+PiBtYWpvcml0eSBvZiBQMlBETUEgdXNlIGNhc2VzIGFyZSByZXN0cmlj
dGVkIHRvIG5ld2VyIHJvb3QgY29tcGxleGVzIGFuZAo+Pj4gcm91Z2hseSByZXF1aXJlIHRoZSBl
eHRyYSBhZGRyZXNzIHNwYWNlIGZvciBtZW1vcnkgQkFScyB1c2VkIGluIHRoZQo+Pj4gdHJhbnNh
Y3Rpb25zLgo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IExvZ2FuIEd1bnRob3JwZSA8bG9nYW5nQGRl
bHRhdGVlLmNvbT4KPj4+IFJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlk
aWEuY29tPgo+Pj4gLS0tCj4+PiAgwqAgZHJpdmVycy9wY2kvS2NvbmZpZ8KgwqDCoMKgwqDCoMKg
wqAgfMKgIDUgKysrKysKPj4+ICDCoCBpbmNsdWRlL2xpbnV4L3NjYXR0ZXJsaXN0LmggfCA0NCAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystCj4+PiAgwqAgMiBmaWxlcyBjaGFu
Z2VkLCA0OCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvcGNpL0tjb25maWcgYi9kcml2ZXJzL3BjaS9LY29uZmlnCj4+PiBpbmRleCAxMzNj
NzMyMDc3ODIuLjVjYzdjYmExOTQxZiAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvcGNpL0tjb25m
aWcKPj4+ICsrKyBiL2RyaXZlcnMvcGNpL0tjb25maWcKPj4+IEBAIC0xNjQsNiArMTY0LDExIEBA
IGNvbmZpZyBQQ0lfUEFTSUQKPj4+ICDCoCBjb25maWcgUENJX1AyUERNQQo+Pj4gIMKgwqDCoMKg
wqAgYm9vbCAiUENJIHBlZXItdG8tcGVlciB0cmFuc2ZlciBzdXBwb3J0Igo+Pj4gIMKgwqDCoMKg
wqAgZGVwZW5kcyBvbiBaT05FX0RFVklDRQo+Pj4gK8KgwqDCoCAjCj4+PiArwqDCoMKgICMgVGhl
IG5lZWQgZm9yIHRoZSBzY2F0dGVybGlzdCBETUEgYnVzIGFkZHJlc3MgZmxhZyBtZWFucyBQQ0kg
UDJQRE1BCj4+PiArwqDCoMKgICMgcmVxdWlyZXMgNjRiaXQKPj4+ICvCoMKgwqAgIwo+Pj4gK8Kg
wqDCoCBkZXBlbmRzIG9uIDY0QklUCj4+PiAgwqDCoMKgwqDCoCBzZWxlY3QgR0VORVJJQ19BTExP
Q0FUT1IKPj4+ICDCoMKgwqDCoMKgIGhlbHAKPj4+ICDCoMKgwqDCoMKgwqDCoCBFbmFibGXRlSBk
cml2ZXJzIHRvIGRvIFBDSSBwZWVyLXRvLXBlZXIgdHJhbnNhY3Rpb25zIHRvIGFuZCBmcm9tCj4+
PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zY2F0dGVybGlzdC5oIGIvaW5jbHVkZS9saW51
eC9zY2F0dGVybGlzdC5oCj4+PiBpbmRleCA3ZmY5ZDYzODZjMTIuLjY1NjFjYThhZWFkOCAxMDA2
NDQKPj4+IC0tLSBhL2luY2x1ZGUvbGludXgvc2NhdHRlcmxpc3QuaAo+Pj4gKysrIGIvaW5jbHVk
ZS9saW51eC9zY2F0dGVybGlzdC5oCj4+PiBAQCAtNjQsMTIgKzY0LDI0IEBAIHN0cnVjdCBzZ19h
cHBlbmRfdGFibGUgewo+Pj4gIMKgICNkZWZpbmUgU0dfQ0hBSU7CoMKgwqAgMHgwMVVMCj4+PiAg
wqAgI2RlZmluZSBTR19FTkTCoMKgwqDCoMKgwqDCoCAweDAyVUwKPj4+ICDCoCArLyoKPj4+ICsg
KiBiaXQgMiBpcyB0aGUgdGhpcmQgZnJlZSBiaXQgaW4gdGhlIHBhZ2VfbGluayBvbiA2NGJpdCBz
eXN0ZW1zIHdoaWNoCj4+PiArICogaXMgdXNlZCBieSBkbWFfdW5tYXBfc2coKSB0byBkZXRlcm1p
bmUgaWYgdGhlIGRtYV9hZGRyZXNzIGlzIGEKPj4+ICsgKiBidXMgYWRkcmVzcyB3aGVuIGRvaW5n
IFAyUERNQS4KPj4+ICsgKi8KPj4+ICsjaWZkZWYgQ09ORklHX1BDSV9QMlBETUEKPj4+ICsjZGVm
aW5lIFNHX0RNQV9CVVNfQUREUkVTU8KgwqDCoCAweDA0VUwKPj4+ICtzdGF0aWNfYXNzZXJ0KF9f
YWxpZ25vZl9fKHN0cnVjdCBwYWdlKSA+PSA4KTsKPj4+ICsjZWxzZQo+Pj4gKyNkZWZpbmUgU0df
RE1BX0JVU19BRERSRVNTwqDCoMKgIDB4MDBVTAo+Pj4gKyNlbmRpZgo+Pj4gKwo+Pj4gIMKgIC8q
Cj4+PiAgwqDCoCAqIFdlIG92ZXJsb2FkIHRoZSBMU0Igb2YgdGhlIHBhZ2UgcG9pbnRlciB0byBp
bmRpY2F0ZSB3aGV0aGVyIGl0J3MKPj4+ICDCoMKgICogYSB2YWxpZCBzZyBlbnRyeSwgb3Igd2hl
dGhlciBpdCBwb2ludHMgdG8gdGhlIHN0YXJ0IG9mIGEgbmV3Cj4+PiBzY2F0dGVybGlzdC4KPj4+
ICDCoMKgICogVGhvc2UgbG93IGJpdHMgYXJlIHRoZXJlIGZvciBldmVyeW9uZSEgKHRoYW5rcyBt
YXNvbiA6LSkKPj4+ICDCoMKgICovCj4+PiAtI2RlZmluZSBTR19QQUdFX0xJTktfTUFTSyAoU0df
Q0hBSU4gfCBTR19FTkQpCj4+PiArI2RlZmluZSBTR19QQUdFX0xJTktfTUFTSyAoU0dfQ0hBSU4g
fCBTR19FTkQgfCBTR19ETUFfQlVTX0FERFJFU1MpCj4+PiAgwqAgwqAgc3RhdGljIGlubGluZSB1
bnNpZ25lZCBpbnQgX19zZ19mbGFncyhzdHJ1Y3Qgc2NhdHRlcmxpc3QgKnNnKQo+Pj4gIMKgIHsK
Pj4+IEBAIC05MSw2ICsxMDMsMTEgQEAgc3RhdGljIGlubGluZSBib29sIHNnX2lzX2xhc3Qoc3Ry
dWN0IHNjYXR0ZXJsaXN0ICpzZykKPj4+ICDCoMKgwqDCoMKgIHJldHVybiBfX3NnX2ZsYWdzKHNn
KSAmIFNHX0VORDsKPj4+ICDCoCB9Cj4+PiAgwqAgK3N0YXRpYyBpbmxpbmUgYm9vbCBzZ19pc19k
bWFfYnVzX2FkZHJlc3Moc3RydWN0IHNjYXR0ZXJsaXN0ICpzZykKPj4+ICt7Cj4+PiArwqDCoMKg
IHJldHVybiBfX3NnX2ZsYWdzKHNnKSAmIFNHX0RNQV9CVVNfQUREUkVTUzsKPj4+ICt9Cj4+PiAr
Cj4+PiAgwqAgLyoqCj4+PiAgwqDCoCAqIHNnX2Fzc2lnbl9wYWdlIC0gQXNzaWduIGEgZ2l2ZW4g
cGFnZSB0byBhbiBTRyBlbnRyeQo+Pj4gIMKgwqAgKiBAc2c6wqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBTRyBlbnRyeQo+Pj4gQEAgLTI0NSw2ICsyNjIsMzEgQEAgc3RhdGljIGlubGluZSB2b2lkIHNn
X3VubWFya19lbmQoc3RydWN0Cj4+PiBzY2F0dGVybGlzdCAqc2cpCj4+PiAgwqDCoMKgwqDCoCBz
Zy0+cGFnZV9saW5rICY9IH5TR19FTkQ7Cj4+PiAgwqAgfQo+Pj4gIMKgICsvKioKPj4+ICsgKiBz
Z19kbWFfbWFya19idXMgYWRkcmVzcyAtIE1hcmsgdGhlIHNjYXR0ZXJsaXN0IGVudHJ5IGFzIGEg
YnVzIGFkZHJlc3MKPj4+ICsgKiBAc2c6wqDCoMKgwqDCoMKgwqDCoCBTRyBlbnRyeVNjYXR0ZXJs
aXN0Cj4+Cj4+IGVudHJ5U2NhdHRlcmxpc3Q/Cj4+Cj4+PiArICoKPj4+ICsgKiBEZXNjcmlwdGlv
bjoKPj4+ICsgKsKgwqAgTWFya3MgdGhlIHBhc3NlZCBpbiBzZyBlbnRyeSB0byBpbmRpY2F0ZSB0
aGF0IHRoZSBkbWFfYWRkcmVzcyBpcwo+Pj4gKyAqwqDCoCBhIGJ1cyBhZGRyZXNzIGFuZCBkb2Vz
bid0IG5lZWQgdG8gYmUgdW5tYXBwZWQuCj4+PiArICoqLwo+Pj4gK3N0YXRpYyBpbmxpbmUgdm9p
ZCBzZ19kbWFfbWFya19idXNfYWRkcmVzcyhzdHJ1Y3Qgc2NhdHRlcmxpc3QgKnNnKQo+Pj4gK3sK
Pj4+ICvCoMKgwqAgc2ctPnBhZ2VfbGluayB8PSBTR19ETUFfQlVTX0FERFJFU1M7Cj4+PiArfQo+
Pj4gKwo+Pj4gKy8qKgo+Pj4gKyAqIHNnX3VubWFya19wY2lfcDJwZG1hIC0gVW5tYXJrIHRoZSBz
Y2F0dGVybGlzdCBlbnRyeSBhcyBhIGJ1cyBhZGRyZXNzCj4+PiArICogQHNnOsKgwqDCoMKgwqDC
oMKgwqAgU0cgZW50cnlTY2F0dGVybGlzdAo+Pj4gKyAqCj4+PiArICogRGVzY3JpcHRpb246Cj4+
PiArICrCoMKgIENsZWFycyB0aGUgYnVzIGFkZHJlc3MgbWFyay4KPj4+ICsgKiovCj4+PiArc3Rh
dGljIGlubGluZSB2b2lkIHNnX2RtYV91bm1hcmtfYnVzX2FkZHJlc3Moc3RydWN0IHNjYXR0ZXJs
aXN0ICpzZykKPj4+ICt7Cj4+PiArwqDCoMKgIHNnLT5wYWdlX2xpbmsgJj0gflNHX0RNQV9CVVNf
QUREUkVTUzsKPj4+ICt9Cj4+Cj4+IERvZXMgdGhpcyBzZXJ2ZSBhbnkgdXNlZnVsIHB1cnBvc2U/
IElmIGEgcGFnZSBpcyBkZXRlcm1pbmVkIHRvIGJlIGRldmljZQo+PiBtZW1vcnksIGl0J3Mgbm90
IGdvaW5nIHRvIHN1ZGRlbmx5IHN0b3AgYmVpbmcgZGV2aWNlIG1lbW9yeSwgYW5kIGlmIHRoZQo+
PiB1bmRlcmx5aW5nIHNnIGlzIHJlY3ljbGVkIHRvIHBvaW50IGVsc2V3aGVyZSB0aGVuIHNnX2Fz
c2lnbl9wYWdlKCkgd2lsbAo+PiBzdGlsbCAoY29ycmVjdGx5KSBjbGVhciB0aGlzIGZsYWcgYW55
d2F5LiBUcnlpbmcgdG8gcmVhc29uIGFib3V0IHRoaXMKPj4gYmV5b25kIHN1cGVyZmljaWFsIEFQ
SSBzeW1tZXRyeSAtIGkuZS4gd2h5IGV4YWN0bHkgd291bGQgYSBjYWxsZXIgbmVlZAo+PiB0byBj
YWxsIGl0LCBhbmQgd2hhdCB3b3VsZCB0aGUgaW1wbGljYXRpb25zIGJlIG9mIGZhaWxpbmcgdG8g
ZG8gc28gLQo+PiBzZWVtcyB0byBsZWFkIHN0cmFpZ2h0IHRvIGNvbmZ1c2lvbi4KPj4KPj4gSW4g
ZmFjdCBJJ2QgYmUgaW5jbGluZWQgdG8gaGF2ZSBzZ19hc3NpZ25fcGFnZSgpIGJlIHJlc3BvbnNp
YmxlIGZvcgo+PiBzZXR0aW5nIHRoZSBmbGFnIGF1dG9tYXRpY2FsbHkgYXMgd2VsbCwgYW5kIHRo
dXMgbm90IG5lZWQKPj4gc2dfZG1hX21hcmtfYnVzX2FkZHJlc3MoKSBlaXRoZXIsIGhvd2V2ZXIg
SSBjYW4gc2VlIHRoZSBhcmd1bWVudCBmb3IKPj4gZG9pbmcgaXQgdGhpcyB3YXkgcm91bmQgdG8g
bm90IGVudGFuZ2xlIHRoZSBBUElzIHRvbyBtdWNoLCBzbyBJIGRvbid0Cj4+IGhhdmUgYW55IGdy
ZWF0IG9iamVjdGlvbiB0byB0aGF0Lgo+IAo+IFllcywgSSB0aGluayB5b3UgbWlzdW5kZXJzdGFu
ZCB3aGF0IHRoaXMgaXMgZm9yLiBUaGUgU0dfRE1BX0JVU19BREREUkVTUwo+IGZsYWcgZG9lc24n
dCBtYXJrIHRoZSBzZWdtZW50IGZvciB0aGUgcGFnZSwgYnV0IGZvciB0aGUgZG1hIGFkZHJlc3Mu
IEl0Cj4gY2Fubm90IGJlIHNldCBpbiBzZ19hc3NpZ25fcGFnZSgpIHNlZWluZyBpdCdzIG5vdCBh
IHByb3BlcnR5IG9mIHRoZSBwYWdlCj4gYnV0IGEgcHJvcGVydHkgb2YgdGhlIGRtYV9hZGRyZXNz
IGluIHRoZSBzZ2wuCj4gCj4gSXQncyBub3QgbWVhbnQgZm9yIHVzZSBieSByZWd1bGFyIFNHIHVz
ZXJzLCBpdCdzIG9ubHkgbWVhbnQgZm9yIHVzZQo+IGluc2lkZSBETUEgbWFwcGluZyBpbXBsZW1l
bnRhdGlvbnMuIFRoZSBwdXJwb3NlIGlzIHRvIGtub3cgd2hldGhlciBhCj4gZ2l2ZW4gZG1hX2Fk
ZHJlc3MgaW4gdGhlIFNHTCBpcyBhIGJ1cyBhZGRyZXNzIG9yIHJlZ3VsYXIgbWVtb3J5IGJlY2F1
c2UKPiB0aGUgdHdvIGRpZmZlcmVudCB0eXBlcyBtdXN0IGJlIHVubWFwcGVkIGRpZmZlcmVudGx5
LiBXZSBjYW4ndCByZWx5IG9uCj4gdGhlIHBhZ2UgYmVjYXVzZSwgYXMgeW91IGtub3csIG1hbnkg
ZG1hX21hcF9zZygpIHRoZSBkbWFfYWRkcmVzcyBlbnRyeQo+IGluIHRoZSBzZ2wgZG9lcyBub3Qg
bWFwIHRvIHRoZSBzYW1lIG1lbW9yeSBhcyB0aGUgcGFnZS4gT3IgdG8gcHV0IGl0Cj4gYW5vdGhl
ciB3YXk6IGlzX3BjaV9wMnBkbWFfcGFnZShzZy0+cGFnZSkgZG9lcyBub3QgaW1wbHkgdGhhdAo+
IHNnLT5kbWFfYWRkcmVzcyBwb2ludHMgdG8gYSBidXMgYWRkcmVzcy4KPiAKPiBEb2VzIHRoYXQg
bWFrZSBzZW5zZT8KCkFoLCB5b3UncmUgcXVpdGUgcmlnaHQsIGluIHRyeWluZyB0byB0YWtlIGlu
IHRoZSB3aG9sZSBzZXJpZXMgYXQgb25jZSAKZmlyc3QgdGhpbmcgaW4gdGhlIG1vcm5pbmcgSSBk
aWQgZmFpbCB0byBwcm9wZXJseSBncmFzcCB0aGF0IGRldGFpbCwgc28gCmluZGVlZCB0aGUgc2df
YXNzaWduX3BhZ2UoKSB0aGluZyBjb3VsZG4ndCBwb3NzaWJseSB3b3JrLCBidXQgYXMgSSBzYWlk
IAp0aGF0J3MgZmluZSBhbnl3YXkuIEkgc3RpbGwgdGhpbmsgdGhlIGxpZmVjeWNsZSBtYW5hZ2Vt
ZW50IGlzIGEgYml0IG9mZiAKdGhvdWdoIC0gZXF1aXZhbGVudGx5LCBhIGJ1cyBhZGRyZXNzIGRv
ZXNuJ3Qgc3RvcCBiZWluZyBhIGJ1cyBhZGRyZXNzLCAKc28gaXQgd291bGQgc2VlbSBhcHByb3By
aWF0ZSB0byB1cGRhdGUgdGhpcyBmbGFnIGFwcHJvcHJpYXRlbHkgd2hlbmV2ZXIgCnNnX2RtYV9h
ZGRyZXNzKCkgaXMgYXNzaWduZWQgdG8sIGFuZCBub3Qgd2hlbiBpdCBpc24ndC4KClRoYW5rcywK
Um9iaW4uCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlv
bW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
