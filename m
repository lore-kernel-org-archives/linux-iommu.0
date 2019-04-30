Return-Path: <SRS0=Kg+4=TA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9457C43219
	for <iommu@archiver.kernel.org>; Tue, 30 Apr 2019 02:08:56 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6738121655
	for <iommu@archiver.kernel.org>; Tue, 30 Apr 2019 02:08:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6738121655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 3C19AD9C;
	Tue, 30 Apr 2019 02:08:56 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A98FAD1A
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Apr 2019 02:08:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 0108E756
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Apr 2019 02:08:21 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
	by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	29 Apr 2019 19:08:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,412,1549958400"; d="scan'208";a="295649533"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
	([10.239.159.136])
	by orsmga004.jf.intel.com with ESMTP; 29 Apr 2019 19:08:18 -0700
Subject: Re: [PATCH v3 02/10] swiotlb: Factor out slot allocation and free
To: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
References: <20190421011719.14909-1-baolu.lu@linux.intel.com>
	<20190421011719.14909-3-baolu.lu@linux.intel.com>
	<20190422164555.GA31181@lst.de>
	<0c6e5983-312b-0d6b-92f5-64861cd6804d@linux.intel.com>
	<20190423061232.GB12762@lst.de>
	<dff50b2c-5e31-8b4a-7fdf-99d17852746b@linux.intel.com>
	<20190424144532.GA21480@lst.de>
	<a189444b-15c9-8069-901d-8cdf9af7fc3c@linux.intel.com>
	<20190426150433.GA19930@lst.de>
	<93b3d627-782d-cae0-2175-77a5a8b3fe6e@linux.intel.com>
	<90182d27-5764-7676-8ca6-b2773a40cfe1@arm.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <1361b6ab-c3cf-d8ab-5f6b-9d9b7797bf02@linux.intel.com>
Date: Tue, 30 Apr 2019 10:02:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <90182d27-5764-7676-8ca6-b2773a40cfe1@arm.com>
Content-Language: en-US
Cc: kevin.tian@intel.com, mika.westerberg@linux.intel.com, ashok.raj@intel.com,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	alan.cox@intel.com, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, pengfei.xu@intel.com,
	jacob.jun.pan@intel.com, David Woodhouse <dwmw2@infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190430020200.x4-XZKkV0iRKRBgKtb63OwC0BHgqeKiqnS98S3RwQyw@z>

SGkgUm9iaW4sCgpPbiA0LzI5LzE5IDc6MDYgUE0sIFJvYmluIE11cnBoeSB3cm90ZToKPiBPbiAy
OS8wNC8yMDE5IDA2OjEwLCBMdSBCYW9sdSB3cm90ZToKPj4gSGkgQ2hyaXN0b3BoLAo+Pgo+PiBP
biA0LzI2LzE5IDExOjA0IFBNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPj4+IE9uIFRodSwg
QXByIDI1LCAyMDE5IGF0IDEwOjA3OjE5QU0gKzA4MDAsIEx1IEJhb2x1IHdyb3RlOgo+Pj4+IFRo
aXMgaXMgbm90IFZULWQgc3BlY2lmaWMuIEl0J3MganVzdCBob3cgZ2VuZXJpYyBJT01NVSB3b3Jr
cy4KPj4+Pgo+Pj4+IE5vcm1hbGx5LCBJT01NVSB3b3JrcyBpbiBwYWdpbmcgbW9kZS4gU28gaWYg
YSBkcml2ZXIgaXNzdWVzIERNQSB3aXRoCj4+Pj4gSU9WQcKgIDB4QUFBQTAxMjMsIElPTU1VIGNh
biByZW1hcCBpdCB3aXRoIGEgcGh5c2ljYWwgYWRkcmVzcyAKPj4+PiAweEJCQkIwMTIzLgo+Pj4+
IEJ1dCB3ZSBzaG91bGQgbmV2ZXIgZXhwZWN0IElPTU1VIHRvIHJlbWFwIDB4QUFBQTAxMjMgd2l0
aCBwaHlzaWNhbAo+Pj4+IGFkZHJlc3Mgb2YgMHhCQkJCMDAwMC4gVGhhdCdzIHRoZSByZWFzb24g
d2h5IEkgc2FpZCB0aGF0IElPTU1VIHdpbGwgbm90Cj4+Pj4gd29yayB0aGVyZS4KPj4+Cj4+PiBX
ZWxsLCB3aXRoIHRoZSBpb21tdSBpdCBkb2Vzbid0IGhhcHBlbi7CoCBXaXRoIHN3aW90bGIgaXQg
b2J2aW9zdWx5Cj4+PiBjYW4gaGFwcGVuLCBzbyBkcml2ZXJzIGFyZSBmaW5lIHdpdGggaXQuwqAg
V2h5IHdvdWxkIHRoYXQgc3VkZGVubHkKPj4+IGJlY29tZSBhbiBpc3N1ZSB3aGVuIHN3aW90bGIg
aXMgY2FsbGVkIGZyb20gdGhlIGlvbW11IGNvZGU/Cj4+Pgo+Pgo+PiBJIHdvdWxkIHNheSBJT01N
VSBpcyBETUEgcmVtYXBwaW5nLCBub3QgRE1BIGVuZ2luZS4gOi0pCj4gCj4gSSdtIG5vdCBzdXJl
IEkgcmVhbGx5IGZvbGxvdyB0aGUgaXNzdWUgaGVyZSAtIGlmIHdlJ3JlIGNvcHlpbmcgdGhlIAo+
IGJ1ZmZlciB0byB0aGUgYm91bmNlIHBhZ2UocykgdGhlcmUncyBubyBjb25jZXB0dWFsIGRpZmZl
cmVuY2UgZnJvbSAKPiBjb3B5aW5nIGl0IHRvIFNXSU9UTEIgc2xvdChzKSwgc28gdGhlcmUgc2hv
dWxkIGJlIG5vIG5lZWQgdG8gd29ycnkgYWJvdXQgCj4gdGhlIG9yaWdpbmFsIGluLXBhZ2Ugb2Zm
c2V0Lgo+IAo+ICBGcm9tIHRoZSByZXBseSB1cC10aHJlYWQgSSBndWVzcyB5b3UncmUgdHJ5aW5n
IHRvIGluY2x1ZGUgYW4gCj4gb3B0aW1pc2F0aW9uIHRvIG9ubHkgY29weSB0aGUgaGVhZCBhbmQg
dGFpbCBvZiB0aGUgYnVmZmVyIGlmIGl0IHNwYW5zIAo+IG11bHRpcGxlIHBhZ2VzLCBhbmQgZGly
ZWN0bHkgbWFwIHRoZSBvbmVzIGluIHRoZSBtaWRkbGUsIGJ1dCBBRkFJQ1MgCj4gdGhhdCdzIGdv
aW5nIHRvIHRpZSB5b3UgdG8gYWxzbyB1c2luZyBzdHJpY3QgbW9kZSBmb3IgVExCIG1haW50ZW5h
bmNlLCAKPiB3aGljaCBtYXkgbm90IGJlIGEgd2luIG92ZXJhbGwgZGVwZW5kaW5nIG9uIHRoZSBi
YWxhbmNlIGJldHdlZW4gCj4gaW52YWxpZGF0aW9uIGJhbmR3aWR0aCB2cy4gbWVtY3B5IGJhbmR3
aWR0aC4gQXQgbGVhc3QgaWYgd2UgdXNlIHN0YW5kYXJkIAo+IFNXSU9UTEIgbG9naWMgdG8gYWx3
YXlzIGNvcHkgdGhlIHdob2xlIHRoaW5nLCB3ZSBzaG91bGQgYmUgYWJsZSB0byAKPiByZWxlYXNl
IHRoZSBib3VuY2UgcGFnZXMgdmlhIHRoZSBmbHVzaCBxdWV1ZSB0byBhbGxvdyAnc2FmZScgbGF6
eSB1bm1hcHMuCj4KCldpdGggcmVzcGVjdCwgZXZlbiB3ZSB1c2UgdGhlIHN0YW5kYXJkIFNXSU9U
TEIgbG9naWMsIHdlIG5lZWQgdG8gdXNlCnRoZSBzdHJpY3QgbW9kZSBmb3IgVExCIG1haW50ZW5h
bmNlLgoKU2F5LCBzb21lIHN3aW90Ymwgc2xvdHMgYXJlIHVzZWQgYnkgdW50cnVzdGVkIGRldmlj
ZSBmb3IgYm91bmNlIHBhZ2UKcHVycG9zZS4gV2hlbiB0aGUgZGV2aWNlIGRyaXZlciB1bm1hcHMg
dGhlIElPVkEsIHRoZSBzbG90cyBhcmUgZnJlZWQgYnV0CnRoZSBtYXBwaW5nIGlzIHN0aWxsIGNh
Y2hlZCBpbiBJT1RMQiwgaGVuY2UgdGhlIHVudHJ1c3RlZCBkZXZpY2UgaXMgCnN0aWxsIGFibGUg
dG8gYWNjZXNzIHRoZSBzbG90cy4gVGhlbiB0aGUgc2xvdHMgYXJlIGFsbG9jYXRlZCB0byBvdGhl
cgpkZXZpY2VzLiBUaGlzIG1ha2VzIGl0IHBvc3NpYmxlIGZvciB0aGUgdW50cnVzdGVkIGRldmlj
ZSB0byBhY2Nlc3MKdGhlIGRhdGEgYnVmZmVyIG9mIG90aGVyIGRldmljZXMuCgpCZXN0IHJlZ2Fy
ZHMsCkx1IEJhb2x1Cgo+IEVpdGhlciB3YXkgSSB0aGluayBpdCB3b3VsZCBiZSB3b3J0aCBqdXN0
IGltcGxlbWVudGluZyB0aGUgCj4gc3RyYWlnaHRmb3J3YXJkIHZlcnNpb24gZmlyc3QsIHRoZW4g
Y29taW5nIGJhY2sgdG8gY29uc2lkZXIgCj4gb3B0aW1pc2F0aW9ucyBsYXRlci4KCgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBs
aXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
