Return-Path: <SRS0=Xx/3=YV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25ABECA9EC0
	for <iommu@archiver.kernel.org>; Mon, 28 Oct 2019 11:25:05 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7C68214D9
	for <iommu@archiver.kernel.org>; Mon, 28 Oct 2019 11:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQe5GHkf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7C68214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D1D861094;
	Mon, 28 Oct 2019 11:25:04 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 02267108A
	for <iommu@lists.linux-foundation.org>;
	Mon, 28 Oct 2019 11:25:03 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 80D0C42D
	for <iommu@lists.linux-foundation.org>;
	Mon, 28 Oct 2019 11:25:03 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 891692086D;
	Mon, 28 Oct 2019 11:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572261903;
	bh=uIJQi/xVzH0ESZKekPUQxJmUM83EGRAVC0wB5kU/siI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QQe5GHkfEvuKJNrCByV/qt4ubTUJPa5HvnNSdzA8Coiq+mGHE2JneqDRdBlJUeKEt
	fc3QlteFbO+2MRHqlDpmCFrOlK+X5Vo8iD6mcMVX+kVr/8iI9CZ7LCfXA6uZte3vOi
	A/VF/+J94ncgU2R2BBzUZIOKXk20sOYmsN9m+jFo=
Date: Mon, 28 Oct 2019 11:24:58 +0000
From: Will Deacon <will@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] iommu/dma: Add support for DMA_ATTR_SYS_CACHE
Message-ID: <20191028112457.GB4122@willie-the-truck>
References: <1572050616-6143-1-git-send-email-isaacm@codeaurora.org>
	<20191026053026.GA14545@lst.de>
	<e5fe861d7d506eb41c23f3fc047efdfa@codeaurora.org>
	<20191028074156.GB20443@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191028074156.GB20443@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: isaacm@codeaurora.org, pratikp@codeaurora.org, linux-kernel@vger.kernel.org,
	lmark@codeaurora.org, iommu@lists.linux-foundation.org,
	robin.murphy@arm.com
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

SGkgQ2hyaXN0b3BoLAoKT24gTW9uLCBPY3QgMjgsIDIwMTkgYXQgMDg6NDE6NTZBTSArMDEwMCwg
Q2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4gT24gU2F0LCBPY3QgMjYsIDIwMTkgYXQgMDM6MTI6
NTdBTSAtMDcwMCwgaXNhYWNtQGNvZGVhdXJvcmEub3JnIHdyb3RlOgo+ID4gT24gMjAxOS0xMC0y
NSAyMjozMCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4gPj4gVGhlIGRlZmluaXRpb24gbWFr
ZXMgdmVyeSBsaXR0bGUgc2Vuc2UuCj4gPiBDYW4geW91IHBsZWFzZSBjbGFyaWZ5IHdoYXQgcGFy
dCBkb2VzbuKAmXQgbWFrZSBzZW5zZSwgYW5kIHdoeT8KPiAKPiBJdCBsb29rcyBsaWtlIGNvbXBs
ZXRlIGdhcmJhZ2UgdG8gbWUuICBUaGF0IG1pZ2h0IGp1c3QgYmUgYmVjYXVzZSBpdAo+IHVzZXMg
dG9ucyBvZiB0ZXJtcyBJJ3ZlIG5ldmVyIGhlYXJkIG9mIG9mIGFuZCB3aGljaCBhcmVuJ3QgdXNl
ZCBhbnl3aGVyZQo+IGluIHRoZSBETUEgQVBJLiAgSXQgYWxzbyBtaWdodCBiZSBiZWNhdXNlIGl0
IGRvZXNuJ3QgZXhwbGFpbiBob3cgdGhlCj4gZmxhZyBtaWdodCBhY3R1YWxseSBiZSBwcmFjdGlj
YWxseSB1c2VmdWwuCgpBZ3JlZWQuIFRoZSB3YXkgSSAvdGhpbmsvIGl0IHdvcmtzIGlzIHRoYXQg
b24gbWFueSBTb0NzIHRoZXJlIGlzIGEKc3lzdGVtL2xhc3QtbGV2ZWwgY2FjaGUgKExMQykgd2hp
Y2ggZWZmZWN0aXZlbHkgc2l0cyBpbiBmcm9udCBvZiBtZW1vcnkgZm9yCmFsbCBtYXN0ZXJzLiBF
dmVuIGlmIGEgZGV2aWNlIGlzbid0IGNvaGVyZW50IHdpdGggdGhlIENQVSBjYWNoZXMsIHdlIHN0
aWxsCndhbnQgdG8gYmUgYWJsZSB0byBhbGxvY2F0ZSBpbnRvIHRoZSBMTEMuIFdoeSB0aGlzIGRv
ZXNuJ3QgaGFwcGVuCmF1dG9tYXRpY2FsbHkgaXMgYmV5b25kIG1lLCBidXQgaXQgYXBwZWFycyB0
aGF0IG9uIHRoZXNlIFF1YWxjb21tIGRlc2lnbnMKeW91IGFjdHVhbGx5IGhhdmUgdG8gc2V0IHRo
ZSBtZW1vcnkgYXR0cmlidXRlcyB1cCBpbiB0aGUgcGFnZS10YWJsZSB0bwplbnN1cmUgdGhhdCB0
aGUgcmVzdWx0aW5nIG1lbW9yeSB0cmFuc2FjdGlvbnMgYXJlIG5vbi1jYWNoZWFibGUgZm9yIHRo
ZSBDUFUKYnV0IGNhY2hlYWJsZSBmb3IgdGhlIExMQy4gV2l0aG91dCBhbnkgY2hhbmdlcywgdGhl
IHRyYW5zYWN0aW9ucyBhcmUKbm9uLWNhY2hlYWJsZSBpbiBib3RoIG9mIHRoZW0gd2hpY2ggYXNz
dW1lZGx5IGhhcyBhIHBlcmZvcm1hbmNlIGNvc3QuCgpCdXQgeW91IGNhbiBzZWUgdGhhdCBJJ20g
cGllY2luZyB0aGluZ3MgdG9nZXRoZXIgbXlzZWxmIGhlcmUuIElzYWFjPwoKPiA+IFRoaXMgaXMg
Cj4gPiByZWFsbHkganVzdCBhbiBleHRlbnNpb24gb2YgdGhpcyBwYXRjaCB0aGF0IGdvdCBtYWlu
bGluZWQsIHNvIHRoYXQgY2xpZW50cyAKPiA+IHRoYXQgdXNlIHRoZSBETUEgQVBJIGNhbiB1c2Ug
SU9NTVVfUUNPTV9TWVNfQ0FDSEUgYXMgd2VsbDogCj4gPiBodHRwczovL3BhdGNod29yay5rZXJu
ZWwub3JnL3BhdGNoLzEwOTQ2MDk5Lwo+ID4+ICBBbnkgd2l0aG91dCBhIHVzZXIgaW4gdGhlIHNh
bWUgc2VyaWVzIGl0IGlzIGEgY29tcGxldGUgbm8tZ28gYW55d2F5Lgo+ID4gSU9NTVVfUUNPTV9T
WVNfQ0FDSEUgZG9lcyBub3QgaGF2ZSBhbnkgY3VycmVudCB1c2VycyBpbiB0aGUgbWFpbmxpbmUs
IG5vciAKPiA+IGRpZCBpdCBoYXZlIGl0IGluIHRoZSBwYXRjaCBzZXJpZXMgaW4gd2hpY2ggaXQg
Z290IG1lcmdlZCwgeWV0IGl0IGlzIHN0aWxsIAo+ID4gcHJlc2VudD8gRnVydGhlcm1vcmUsIHRo
ZXJlIGFyZSBwbGFucyB0byB1cHN0cmVhbSBzdXBwb3J0IGZvciBvbmUgb2Ygb3VyIAo+ID4gU29D
cyB0aGF0IG1heSBiZW5lZml0IGZyb20gdGhpcywgYXMgc2VlbiBoZXJlOiAKPiA+IGh0dHBzOi8v
d3d3LnNwaW5pY3MubmV0L2xpc3RzL2lvbW11L21zZzM5NjA4Lmh0bWwuCj4gCj4gV2hpY2ggbWVh
bnMgaXQgc2hvdWxkIGhhdmUgbmV2ZXIgYmVlbiBtZXJnZWQuICBBcyBhIGdlbmVyYWwgcG9saWN5
IHdlIGRvCj4gbm90IGFkZCBjb2RlIHRvIHRoZSBMaW51eCBrZXJuZWwgd2l0aG91dCBhY3R1YWwg
dXNlcnMuCgpZZXMsIGluIHRoaXMgY2FzZSBJIHdhcyBob3BpbmcgYSB1c2VyIHdvdWxkIG1hdGVy
aWFsaXNlIHZpYSBhIGRpZmZlcmVudAp0cmVlLCBidXQgaXQgZGlkbid0IGhhcHBlbiwgaGVuY2Ug
bXkgcG9zdCBsYXN0IHdlZWsgYWJvdXQgcmVtb3ZpbmcgdGhpcwphbHRvZ2V0aGVyOgoKaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtaW9tbXUvMjAxOTEwMjQxNTM4MzIuR0E3OTY2QGpjcm91
c2UxLWxueC5xdWFsY29tbS5jb20vVC8jdAoKd2hpY2ggSSBzdXNwZWN0IHByb21wdGVkIHRoaXMg
cGF0Y2ggdGhhdCB1bmZvcnR1bmF0ZWx5IGZhaWxzIHRvIHNvbHZlIHRoZQpwcm9ibGVtLgoKV2ls
bApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBt
YWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
