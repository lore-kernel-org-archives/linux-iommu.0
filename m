Return-Path: <SRS0=wClR=S7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3AAEC43219
	for <iommu@archiver.kernel.org>; Mon, 29 Apr 2019 11:09:19 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF5842087B
	for <iommu@archiver.kernel.org>; Mon, 29 Apr 2019 11:09:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF5842087B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 84AC71F42;
	Mon, 29 Apr 2019 11:09:19 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C66021F08
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Apr 2019 11:06:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 75CD4608
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Apr 2019 11:06:57 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F026280D;
	Mon, 29 Apr 2019 04:06:56 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE03A3F5AF;
	Mon, 29 Apr 2019 04:06:53 -0700 (PDT)
Subject: Re: [PATCH v3 02/10] swiotlb: Factor out slot allocation and free
To: Lu Baolu <baolu.lu@linux.intel.com>, Christoph Hellwig <hch@lst.de>
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
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <90182d27-5764-7676-8ca6-b2773a40cfe1@arm.com>
Date: Mon, 29 Apr 2019 12:06:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <93b3d627-782d-cae0-2175-77a5a8b3fe6e@linux.intel.com>
Content-Language: en-GB
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
Message-ID: <20190429110652.z3PBBh-3uJgcNZJsfTSW1E-GIk43PPKOO0r3ZvA73sg@z>

T24gMjkvMDQvMjAxOSAwNjoxMCwgTHUgQmFvbHUgd3JvdGU6Cj4gSGkgQ2hyaXN0b3BoLAo+IAo+
IE9uIDQvMjYvMTkgMTE6MDQgUE0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+PiBPbiBUaHUs
IEFwciAyNSwgMjAxOSBhdCAxMDowNzoxOUFNICswODAwLCBMdSBCYW9sdSB3cm90ZToKPj4+IFRo
aXMgaXMgbm90IFZULWQgc3BlY2lmaWMuIEl0J3MganVzdCBob3cgZ2VuZXJpYyBJT01NVSB3b3Jr
cy4KPj4+Cj4+PiBOb3JtYWxseSwgSU9NTVUgd29ya3MgaW4gcGFnaW5nIG1vZGUuIFNvIGlmIGEg
ZHJpdmVyIGlzc3VlcyBETUEgd2l0aAo+Pj4gSU9WQcKgIDB4QUFBQTAxMjMsIElPTU1VIGNhbiBy
ZW1hcCBpdCB3aXRoIGEgcGh5c2ljYWwgYWRkcmVzcyAweEJCQkIwMTIzLgo+Pj4gQnV0IHdlIHNo
b3VsZCBuZXZlciBleHBlY3QgSU9NTVUgdG8gcmVtYXAgMHhBQUFBMDEyMyB3aXRoIHBoeXNpY2Fs
Cj4+PiBhZGRyZXNzIG9mIDB4QkJCQjAwMDAuIFRoYXQncyB0aGUgcmVhc29uIHdoeSBJIHNhaWQg
dGhhdCBJT01NVSB3aWxsIG5vdAo+Pj4gd29yayB0aGVyZS4KPj4KPj4gV2VsbCwgd2l0aCB0aGUg
aW9tbXUgaXQgZG9lc24ndCBoYXBwZW4uwqAgV2l0aCBzd2lvdGxiIGl0IG9idmlvc3VseQo+PiBj
YW4gaGFwcGVuLCBzbyBkcml2ZXJzIGFyZSBmaW5lIHdpdGggaXQuwqAgV2h5IHdvdWxkIHRoYXQg
c3VkZGVubHkKPj4gYmVjb21lIGFuIGlzc3VlIHdoZW4gc3dpb3RsYiBpcyBjYWxsZWQgZnJvbSB0
aGUgaW9tbXUgY29kZT8KPj4KPiAKPiBJIHdvdWxkIHNheSBJT01NVSBpcyBETUEgcmVtYXBwaW5n
LCBub3QgRE1BIGVuZ2luZS4gOi0pCgpJJ20gbm90IHN1cmUgSSByZWFsbHkgZm9sbG93IHRoZSBp
c3N1ZSBoZXJlIC0gaWYgd2UncmUgY29weWluZyB0aGUgCmJ1ZmZlciB0byB0aGUgYm91bmNlIHBh
Z2UocykgdGhlcmUncyBubyBjb25jZXB0dWFsIGRpZmZlcmVuY2UgZnJvbSAKY29weWluZyBpdCB0
byBTV0lPVExCIHNsb3QocyksIHNvIHRoZXJlIHNob3VsZCBiZSBubyBuZWVkIHRvIHdvcnJ5IGFi
b3V0IAp0aGUgb3JpZ2luYWwgaW4tcGFnZSBvZmZzZXQuCgogRnJvbSB0aGUgcmVwbHkgdXAtdGhy
ZWFkIEkgZ3Vlc3MgeW91J3JlIHRyeWluZyB0byBpbmNsdWRlIGFuIApvcHRpbWlzYXRpb24gdG8g
b25seSBjb3B5IHRoZSBoZWFkIGFuZCB0YWlsIG9mIHRoZSBidWZmZXIgaWYgaXQgc3BhbnMgCm11
bHRpcGxlIHBhZ2VzLCBhbmQgZGlyZWN0bHkgbWFwIHRoZSBvbmVzIGluIHRoZSBtaWRkbGUsIGJ1
dCBBRkFJQ1MgCnRoYXQncyBnb2luZyB0byB0aWUgeW91IHRvIGFsc28gdXNpbmcgc3RyaWN0IG1v
ZGUgZm9yIFRMQiBtYWludGVuYW5jZSwgCndoaWNoIG1heSBub3QgYmUgYSB3aW4gb3ZlcmFsbCBk
ZXBlbmRpbmcgb24gdGhlIGJhbGFuY2UgYmV0d2VlbiAKaW52YWxpZGF0aW9uIGJhbmR3aWR0aCB2
cy4gbWVtY3B5IGJhbmR3aWR0aC4gQXQgbGVhc3QgaWYgd2UgdXNlIHN0YW5kYXJkIApTV0lPVExC
IGxvZ2ljIHRvIGFsd2F5cyBjb3B5IHRoZSB3aG9sZSB0aGluZywgd2Ugc2hvdWxkIGJlIGFibGUg
dG8gCnJlbGVhc2UgdGhlIGJvdW5jZSBwYWdlcyB2aWEgdGhlIGZsdXNoIHF1ZXVlIHRvIGFsbG93
ICdzYWZlJyBsYXp5IHVubWFwcy4KCkVpdGhlciB3YXkgSSB0aGluayBpdCB3b3VsZCBiZSB3b3J0
aCBqdXN0IGltcGxlbWVudGluZyB0aGUgCnN0cmFpZ2h0Zm9yd2FyZCB2ZXJzaW9uIGZpcnN0LCB0
aGVuIGNvbWluZyBiYWNrIHRvIGNvbnNpZGVyIApvcHRpbWlzYXRpb25zIGxhdGVyLgoKUm9iaW4u
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1h
aWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
