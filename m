Return-Path: <SRS0=NDwq=TC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355CBC43219
	for <iommu@archiver.kernel.org>; Thu,  2 May 2019 01:54:44 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D0AE206DF
	for <iommu@archiver.kernel.org>; Thu,  2 May 2019 01:54:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D0AE206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C73A12DA1;
	Thu,  2 May 2019 01:54:43 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C38C92DA1
	for <iommu@lists.linux-foundation.org>;
	Thu,  2 May 2019 01:54:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 53FC987
	for <iommu@lists.linux-foundation.org>;
	Thu,  2 May 2019 01:54:16 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
	by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	01 May 2019 18:54:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,419,1549958400"; d="scan'208";a="145299326"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
	([10.239.159.136])
	by fmsmga008.fm.intel.com with ESMTP; 01 May 2019 18:54:12 -0700
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
	<1361b6ab-c3cf-d8ab-5f6b-9d9b7797bf02@linux.intel.com>
	<c044c51a-d348-ca37-3eaa-5475e3fec6c9@arm.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <998eadf0-0435-1a6b-7234-71554d95bb70@linux.intel.com>
Date: Thu, 2 May 2019 09:47:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c044c51a-d348-ca37-3eaa-5475e3fec6c9@arm.com>
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
Message-ID: <20190502014753.MckuGR0UNL-76KWNZA0ZYi6s2tmAd8-h_3IV2ALiddY@z>

SGkgUm9iaW4sCgpPbiA0LzMwLzE5IDU6NTMgUE0sIFJvYmluIE11cnBoeSB3cm90ZToKPiBPbiAz
MC8wNC8yMDE5IDAzOjAyLCBMdSBCYW9sdSB3cm90ZToKPj4gSGkgUm9iaW4sCj4+Cj4+IE9uIDQv
MjkvMTkgNzowNiBQTSwgUm9iaW4gTXVycGh5IHdyb3RlOgo+Pj4gT24gMjkvMDQvMjAxOSAwNjox
MCwgTHUgQmFvbHUgd3JvdGU6Cj4+Pj4gSGkgQ2hyaXN0b3BoLAo+Pj4+Cj4+Pj4gT24gNC8yNi8x
OSAxMTowNCBQTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4+Pj4+IE9uIFRodSwgQXByIDI1
LCAyMDE5IGF0IDEwOjA3OjE5QU0gKzA4MDAsIEx1IEJhb2x1IHdyb3RlOgo+Pj4+Pj4gVGhpcyBp
cyBub3QgVlQtZCBzcGVjaWZpYy4gSXQncyBqdXN0IGhvdyBnZW5lcmljIElPTU1VIHdvcmtzLgo+
Pj4+Pj4KPj4+Pj4+IE5vcm1hbGx5LCBJT01NVSB3b3JrcyBpbiBwYWdpbmcgbW9kZS4gU28gaWYg
YSBkcml2ZXIgaXNzdWVzIERNQSB3aXRoCj4+Pj4+PiBJT1ZBwqAgMHhBQUFBMDEyMywgSU9NTVUg
Y2FuIHJlbWFwIGl0IHdpdGggYSBwaHlzaWNhbCBhZGRyZXNzIAo+Pj4+Pj4gMHhCQkJCMDEyMy4K
Pj4+Pj4+IEJ1dCB3ZSBzaG91bGQgbmV2ZXIgZXhwZWN0IElPTU1VIHRvIHJlbWFwIDB4QUFBQTAx
MjMgd2l0aCBwaHlzaWNhbAo+Pj4+Pj4gYWRkcmVzcyBvZiAweEJCQkIwMDAwLiBUaGF0J3MgdGhl
IHJlYXNvbiB3aHkgSSBzYWlkIHRoYXQgSU9NTVUgCj4+Pj4+PiB3aWxsIG5vdAo+Pj4+Pj4gd29y
ayB0aGVyZS4KPj4+Pj4KPj4+Pj4gV2VsbCwgd2l0aCB0aGUgaW9tbXUgaXQgZG9lc24ndCBoYXBw
ZW4uwqAgV2l0aCBzd2lvdGxiIGl0IG9idmlvc3VseQo+Pj4+PiBjYW4gaGFwcGVuLCBzbyBkcml2
ZXJzIGFyZSBmaW5lIHdpdGggaXQuwqAgV2h5IHdvdWxkIHRoYXQgc3VkZGVubHkKPj4+Pj4gYmVj
b21lIGFuIGlzc3VlIHdoZW4gc3dpb3RsYiBpcyBjYWxsZWQgZnJvbSB0aGUgaW9tbXUgY29kZT8K
Pj4+Pj4KPj4+Pgo+Pj4+IEkgd291bGQgc2F5IElPTU1VIGlzIERNQSByZW1hcHBpbmcsIG5vdCBE
TUEgZW5naW5lLiA6LSkKPj4+Cj4+PiBJJ20gbm90IHN1cmUgSSByZWFsbHkgZm9sbG93IHRoZSBp
c3N1ZSBoZXJlIC0gaWYgd2UncmUgY29weWluZyB0aGUgCj4+PiBidWZmZXIgdG8gdGhlIGJvdW5j
ZSBwYWdlKHMpIHRoZXJlJ3Mgbm8gY29uY2VwdHVhbCBkaWZmZXJlbmNlIGZyb20gCj4+PiBjb3B5
aW5nIGl0IHRvIFNXSU9UTEIgc2xvdChzKSwgc28gdGhlcmUgc2hvdWxkIGJlIG5vIG5lZWQgdG8g
d29ycnkgCj4+PiBhYm91dCB0aGUgb3JpZ2luYWwgaW4tcGFnZSBvZmZzZXQuCj4+Pgo+Pj4gwqBG
cm9tIHRoZSByZXBseSB1cC10aHJlYWQgSSBndWVzcyB5b3UncmUgdHJ5aW5nIHRvIGluY2x1ZGUg
YW4gCj4+PiBvcHRpbWlzYXRpb24gdG8gb25seSBjb3B5IHRoZSBoZWFkIGFuZCB0YWlsIG9mIHRo
ZSBidWZmZXIgaWYgaXQgc3BhbnMgCj4+PiBtdWx0aXBsZSBwYWdlcywgYW5kIGRpcmVjdGx5IG1h
cCB0aGUgb25lcyBpbiB0aGUgbWlkZGxlLCBidXQgQUZBSUNTIAo+Pj4gdGhhdCdzIGdvaW5nIHRv
IHRpZSB5b3UgdG8gYWxzbyB1c2luZyBzdHJpY3QgbW9kZSBmb3IgVExCIAo+Pj4gbWFpbnRlbmFu
Y2UsIHdoaWNoIG1heSBub3QgYmUgYSB3aW4gb3ZlcmFsbCBkZXBlbmRpbmcgb24gdGhlIGJhbGFu
Y2UgCj4+PiBiZXR3ZWVuIGludmFsaWRhdGlvbiBiYW5kd2lkdGggdnMuIG1lbWNweSBiYW5kd2lk
dGguIEF0IGxlYXN0IGlmIHdlIAo+Pj4gdXNlIHN0YW5kYXJkIFNXSU9UTEIgbG9naWMgdG8gYWx3
YXlzIGNvcHkgdGhlIHdob2xlIHRoaW5nLCB3ZSBzaG91bGQgCj4+PiBiZSBhYmxlIHRvIHJlbGVh
c2UgdGhlIGJvdW5jZSBwYWdlcyB2aWEgdGhlIGZsdXNoIHF1ZXVlIHRvIGFsbG93IAo+Pj4gJ3Nh
ZmUnIGxhenkgdW5tYXBzLgo+Pj4KPj4KPj4gV2l0aCByZXNwZWN0LCBldmVuIHdlIHVzZSB0aGUg
c3RhbmRhcmQgU1dJT1RMQiBsb2dpYywgd2UgbmVlZCB0byB1c2UKPj4gdGhlIHN0cmljdCBtb2Rl
IGZvciBUTEIgbWFpbnRlbmFuY2UuCj4+Cj4+IFNheSwgc29tZSBzd2lvdGJsIHNsb3RzIGFyZSB1
c2VkIGJ5IHVudHJ1c3RlZCBkZXZpY2UgZm9yIGJvdW5jZSBwYWdlCj4+IHB1cnBvc2UuIFdoZW4g
dGhlIGRldmljZSBkcml2ZXIgdW5tYXBzIHRoZSBJT1ZBLCB0aGUgc2xvdHMgYXJlIGZyZWVkIGJ1
dAo+PiB0aGUgbWFwcGluZyBpcyBzdGlsbCBjYWNoZWQgaW4gSU9UTEIsIGhlbmNlIHRoZSB1bnRy
dXN0ZWQgZGV2aWNlIGlzIAo+PiBzdGlsbCBhYmxlIHRvIGFjY2VzcyB0aGUgc2xvdHMuIFRoZW4g
dGhlIHNsb3RzIGFyZSBhbGxvY2F0ZWQgdG8gb3RoZXIKPj4gZGV2aWNlcy4gVGhpcyBtYWtlcyBp
dCBwb3NzaWJsZSBmb3IgdGhlIHVudHJ1c3RlZCBkZXZpY2UgdG8gYWNjZXNzCj4+IHRoZSBkYXRh
IGJ1ZmZlciBvZiBvdGhlciBkZXZpY2VzLgo+IAo+IFN1cmUsIHRoYXQncyBpbmRlZWQgaG93IGl0
IHdvdWxkIHdvcmsgcmlnaHQgbm93IC0gaG93ZXZlciBzaW5jZSB0aGUgCj4gYm91bmNlIHBhZ2Vz
IHdpbGwgYmUgZnJlZWQgYW5kIHJldXNlZCBieSB0aGUgRE1BIEFQSSBsYXllciBpdHNlbGYgKGF0
IAo+IHRoZSBzYW1lIGxldmVsIGFzIHRoZSBJT1ZBcykgSSBzZWUgbm8gdGVjaG5pY2FsIHJlYXNv
biB3aHkgd2UgY291bGRuJ3QgCj4gaW52ZXN0aWdhdGUgZGVmZXJyZWQgZnJlZWluZyBhcyBhIGZ1
dHVyZSBvcHRpbWlzYXRpb24uCgpZZXMsIGFncmVlZC4KCkJlc3QgcmVnYXJkcywKTHUgQmFvbHUK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFp
bGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
