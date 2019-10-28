Return-Path: <SRS0=Xx/3=YV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E88CA9EC0
	for <iommu@archiver.kernel.org>; Mon, 28 Oct 2019 11:59:12 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A5C8214D9
	for <iommu@archiver.kernel.org>; Mon, 28 Oct 2019 11:59:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A5C8214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E5D84105B;
	Mon, 28 Oct 2019 11:59:11 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 267971059
	for <iommu@lists.linux-foundation.org>;
	Mon, 28 Oct 2019 11:59:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 89B0614D
	for <iommu@lists.linux-foundation.org>;
	Mon, 28 Oct 2019 11:59:10 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D77B21F1;
	Mon, 28 Oct 2019 04:59:09 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B53003F6C4;
	Mon, 28 Oct 2019 04:59:08 -0700 (PDT)
Subject: Re: [PATCH] iommu/dma: Add support for DMA_ATTR_SYS_CACHE
To: Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <1572050616-6143-1-git-send-email-isaacm@codeaurora.org>
	<20191026053026.GA14545@lst.de>
	<e5fe861d7d506eb41c23f3fc047efdfa@codeaurora.org>
	<20191028074156.GB20443@lst.de>
	<20191028112457.GB4122@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <c1b37c8d-7bdc-eb81-19c2-29f50568150a@arm.com>
Date: Mon, 28 Oct 2019 11:59:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191028112457.GB4122@willie-the-truck>
Content-Language: en-GB
Cc: isaacm@codeaurora.org, linux-kernel@vger.kernel.org, lmark@codeaurora.org,
	iommu@lists.linux-foundation.org, pratikp@codeaurora.org
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
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

T24gMjgvMTAvMjAxOSAxMToyNCwgV2lsbCBEZWFjb24gd3JvdGU6Cj4gSGkgQ2hyaXN0b3BoLAo+
IAo+IE9uIE1vbiwgT2N0IDI4LCAyMDE5IGF0IDA4OjQxOjU2QU0gKzAxMDAsIENocmlzdG9waCBI
ZWxsd2lnIHdyb3RlOgo+PiBPbiBTYXQsIE9jdCAyNiwgMjAxOSBhdCAwMzoxMjo1N0FNIC0wNzAw
LCBpc2FhY21AY29kZWF1cm9yYS5vcmcgd3JvdGU6Cj4+PiBPbiAyMDE5LTEwLTI1IDIyOjMwLCBD
aHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPj4+PiBUaGUgZGVmaW5pdGlvbiBtYWtlcyB2ZXJ5IGxp
dHRsZSBzZW5zZS4KPj4+IENhbiB5b3UgcGxlYXNlIGNsYXJpZnkgd2hhdCBwYXJ0IGRvZXNu4oCZ
dCBtYWtlIHNlbnNlLCBhbmQgd2h5Pwo+Pgo+PiBJdCBsb29rcyBsaWtlIGNvbXBsZXRlIGdhcmJh
Z2UgdG8gbWUuICBUaGF0IG1pZ2h0IGp1c3QgYmUgYmVjYXVzZSBpdAo+PiB1c2VzIHRvbnMgb2Yg
dGVybXMgSSd2ZSBuZXZlciBoZWFyZCBvZiBvZiBhbmQgd2hpY2ggYXJlbid0IHVzZWQgYW55d2hl
cmUKPj4gaW4gdGhlIERNQSBBUEkuICBJdCBhbHNvIG1pZ2h0IGJlIGJlY2F1c2UgaXQgZG9lc24n
dCBleHBsYWluIGhvdyB0aGUKPj4gZmxhZyBtaWdodCBhY3R1YWxseSBiZSBwcmFjdGljYWxseSB1
c2VmdWwuCj4gCj4gQWdyZWVkLiBUaGUgd2F5IEkgL3RoaW5rLyBpdCB3b3JrcyBpcyB0aGF0IG9u
IG1hbnkgU29DcyB0aGVyZSBpcyBhCj4gc3lzdGVtL2xhc3QtbGV2ZWwgY2FjaGUgKExMQykgd2hp
Y2ggZWZmZWN0aXZlbHkgc2l0cyBpbiBmcm9udCBvZiBtZW1vcnkgZm9yCj4gYWxsIG1hc3RlcnMu
IEV2ZW4gaWYgYSBkZXZpY2UgaXNuJ3QgY29oZXJlbnQgd2l0aCB0aGUgQ1BVIGNhY2hlcywgd2Ug
c3RpbGwKPiB3YW50IHRvIGJlIGFibGUgdG8gYWxsb2NhdGUgaW50byB0aGUgTExDLiBXaHkgdGhp
cyBkb2Vzbid0IGhhcHBlbgo+IGF1dG9tYXRpY2FsbHkgaXMgYmV5b25kIG1lLCBidXQgaXQgYXBw
ZWFycyB0aGF0IG9uIHRoZXNlIFF1YWxjb21tIGRlc2lnbnMKPiB5b3UgYWN0dWFsbHkgaGF2ZSB0
byBzZXQgdGhlIG1lbW9yeSBhdHRyaWJ1dGVzIHVwIGluIHRoZSBwYWdlLXRhYmxlIHRvCj4gZW5z
dXJlIHRoYXQgdGhlIHJlc3VsdGluZyBtZW1vcnkgdHJhbnNhY3Rpb25zIGFyZSBub24tY2FjaGVh
YmxlIGZvciB0aGUgQ1BVCj4gYnV0IGNhY2hlYWJsZSBmb3IgdGhlIExMQy4gV2l0aG91dCBhbnkg
Y2hhbmdlcywgdGhlIHRyYW5zYWN0aW9ucyBhcmUKPiBub24tY2FjaGVhYmxlIGluIGJvdGggb2Yg
dGhlbSB3aGljaCBhc3N1bWVkbHkgaGFzIGEgcGVyZm9ybWFuY2UgY29zdC4KPiAKPiBCdXQgeW91
IGNhbiBzZWUgdGhhdCBJJ20gcGllY2luZyB0aGluZ3MgdG9nZXRoZXIgbXlzZWxmIGhlcmUuIElz
YWFjPwoKRldJVywgdGhhdCdzIHByZXR0eSBtdWNoIGhvdyBQcmF0aWsgYW5kIEpvcmRhbiBleHBs
YWluZWQgaXQgdG8gbWUgLSB0aGUgCkxMQyBzaXRzIGRpcmVjdGx5IGluIGZyb250IG9mIG1lbW9y
eSBhbmQgaXMgbW9yZSBvciBsZXNzIHRyYW5zcGFyZW50LCAKYWx0aG91Z2ggaXQgbWlnaHQgdHJl
YXQgQ1BVIGFuZCBkZXZpY2UgYWNjZXNzZXMgc2xpZ2h0bHkgZGlmZmVyZW50bHkgKEkgCmRvbid0
IHJlbWVtYmVyIGV4YWN0bHkgaG93IHRoZSBpbm5lciBjYWNoZWFibGlsaXR5IGF0dHJpYnV0ZSBp
bnRlcmFjdHMpLiAKQ2VydGFpbiBkZXZpY2VzIGRvbid0IGdldCBtdWNoIGJlbmVmaXQgZnJvbSB0
aGUgTExDLCBoZW5jZSB0aGUgZGVzaXJlIApmb3IgZmluZXItZ3JhaW5lZCBjb250cm9sIG9mIHRo
ZWlyIG91dGVyIGFsbG9jYXRpb24gcG9saWN5IHRvIGF2b2lkIG1vcmUgCnRocmFzaGluZyB0aGFu
IG5lY2Vzc2FyeS4gRnVydGhlcm1vcmUsIGZvciBzdHVmZiBpbiB0aGUgCnZpZGVvL0dQVS9kaXNw
bGF5IGFyZWEgY2VydGFpbiBqb2JzIGJlbmVmaXQgbW9yZSB0aGFuIG90aGVycywgaGVuY2UgdGhl
IApkZXNpcmUgdG8gZ28gZXZlbiBmaW5lci1ncmFpbmVkIHRoYW4gYSBwZXItZGV2aWNlIGNvbnRy
b2wgaW4gb3JkZXIgdG8gCm1heGltaXNlIExMQyBlZmZlY3RpdmVuZXNzLgoKUm9iaW4uCgo+Pj4g
VGhpcyBpcwo+Pj4gcmVhbGx5IGp1c3QgYW4gZXh0ZW5zaW9uIG9mIHRoaXMgcGF0Y2ggdGhhdCBn
b3QgbWFpbmxpbmVkLCBzbyB0aGF0IGNsaWVudHMKPj4+IHRoYXQgdXNlIHRoZSBETUEgQVBJIGNh
biB1c2UgSU9NTVVfUUNPTV9TWVNfQ0FDSEUgYXMgd2VsbDoKPj4+IGh0dHBzOi8vcGF0Y2h3b3Jr
Lmtlcm5lbC5vcmcvcGF0Y2gvMTA5NDYwOTkvCj4+Pj4gICBBbnkgd2l0aG91dCBhIHVzZXIgaW4g
dGhlIHNhbWUgc2VyaWVzIGl0IGlzIGEgY29tcGxldGUgbm8tZ28gYW55d2F5Lgo+Pj4gSU9NTVVf
UUNPTV9TWVNfQ0FDSEUgZG9lcyBub3QgaGF2ZSBhbnkgY3VycmVudCB1c2VycyBpbiB0aGUgbWFp
bmxpbmUsIG5vcgo+Pj4gZGlkIGl0IGhhdmUgaXQgaW4gdGhlIHBhdGNoIHNlcmllcyBpbiB3aGlj
aCBpdCBnb3QgbWVyZ2VkLCB5ZXQgaXQgaXMgc3RpbGwKPj4+IHByZXNlbnQ/IEZ1cnRoZXJtb3Jl
LCB0aGVyZSBhcmUgcGxhbnMgdG8gdXBzdHJlYW0gc3VwcG9ydCBmb3Igb25lIG9mIG91cgo+Pj4g
U29DcyB0aGF0IG1heSBiZW5lZml0IGZyb20gdGhpcywgYXMgc2VlbiBoZXJlOgo+Pj4gaHR0cHM6
Ly93d3cuc3Bpbmljcy5uZXQvbGlzdHMvaW9tbXUvbXNnMzk2MDguaHRtbC4KPj4KPj4gV2hpY2gg
bWVhbnMgaXQgc2hvdWxkIGhhdmUgbmV2ZXIgYmVlbiBtZXJnZWQuICBBcyBhIGdlbmVyYWwgcG9s
aWN5IHdlIGRvCj4+IG5vdCBhZGQgY29kZSB0byB0aGUgTGludXgga2VybmVsIHdpdGhvdXQgYWN0
dWFsIHVzZXJzLgo+IAo+IFllcywgaW4gdGhpcyBjYXNlIEkgd2FzIGhvcGluZyBhIHVzZXIgd291
bGQgbWF0ZXJpYWxpc2UgdmlhIGEgZGlmZmVyZW50Cj4gdHJlZSwgYnV0IGl0IGRpZG4ndCBoYXBw
ZW4sIGhlbmNlIG15IHBvc3QgbGFzdCB3ZWVrIGFib3V0IHJlbW92aW5nIHRoaXMKPiBhbHRvZ2V0
aGVyOgo+IAo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWlvbW11LzIwMTkxMDI0MTUz
ODMyLkdBNzk2NkBqY3JvdXNlMS1sbngucXVhbGNvbW0uY29tL1QvI3QKPiAKPiB3aGljaCBJIHN1
c3BlY3QgcHJvbXB0ZWQgdGhpcyBwYXRjaCB0aGF0IHVuZm9ydHVuYXRlbHkgZmFpbHMgdG8gc29s
dmUgdGhlCj4gcHJvYmxlbS4KPiAKPiBXaWxsCj4gCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby9pb21tdQ==
