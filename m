Return-Path: <SRS0=TgA1=WD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201D0C19759
	for <iommu@archiver.kernel.org>; Wed,  7 Aug 2019 06:14:09 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00F472199C
	for <iommu@archiver.kernel.org>; Wed,  7 Aug 2019 06:14:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00F472199C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id CADEFC52;
	Wed,  7 Aug 2019 06:14:08 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 418A1AE0
	for <iommu@lists.linux-foundation.org>;
	Wed,  7 Aug 2019 06:14:07 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 204527D2
	for <iommu@lists.linux-foundation.org>;
	Wed,  7 Aug 2019 06:14:06 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 55DB268B05; Wed,  7 Aug 2019 08:14:02 +0200 (CEST)
Date: Wed, 7 Aug 2019 08:14:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH] dma-mapping: fix page attributes for dma_mmap_*
Message-ID: <20190807061402.GE6627@lst.de>
References: <20190801142118.21225-1-hch@lst.de>
	<20190801142118.21225-2-hch@lst.de>
	<20190801162305.3m32chycsdjmdejk@willie-the-truck>
	<20190801163457.GB26588@lst.de>
	<20190801164411.kmsl4japtfkgvzxe@willie-the-truck>
	<20190802081441.GA9725@lst.de>
	<20190802103803.3qrbhqwxlasojsco@willie-the-truck>
	<20190803064812.GA29746@lst.de>
	<20190806160854.htk67msiyadlrl4m@willie-the-truck>
	<20190806164503.GD1330@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190806164503.GD1330@shell.armlinux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Shawn Anastasio <shawn@anastas.io>,
	Catalin Marinas <catalin.marinas@arm.com>, linuxppc-dev@lists.ozlabs.org,
	Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
	linux-arm-kernel@lists.infradead.org
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

T24gVHVlLCBBdWcgMDYsIDIwMTkgYXQgMDU6NDU6MDNQTSArMDEwMCwgUnVzc2VsbCBLaW5nIC0g
QVJNIExpbnV4IGFkbWluIHdyb3RlOgo+IFdlIGNvdWxkIGhhdmUgdXNlZCBhIGRpZmZlcmVudCBh
cHByb2FjaCwgbWFraW5nIGFsbCBJTyB3cml0ZXMgY29udGFpbgo+IGEgImRyYWluIHdyaXRlIGJ1
ZmZlciIgaW5zdHJ1Y3Rpb24sIGFuZCBtYXAgRE1BIG1lbW9yeSBhcyAiYnVmZmVyZWQiLAo+IGJ1
dCBhcyB0aGVyZSB3ZXJlIG5vIExpbnV4IGJhcnJpZXJzIGRlZmluZWQgdG8gb3JkZXIgbWVtb3J5
IGFjY2Vzc2VzCj4gdG8gRE1BIG1lbW9yeSAoc28sIGZvciBleGFtcGxlLCByaW5nIGJ1ZmZlcnMg
Y2FuIGJlIHVwZGF0ZWQgaW4gdGhlCj4gY29ycmVjdCBvcmRlcikgYmFjayBpbiB0aG9zZSBkYXlz
LCB1c2luZyB0aGUgdW5jYWNoZWQvdW5idWZmZXJlZCBtb2RlCj4gd2FzIHRoZSBzYW5lc3QgYW5k
IG1vc3QgcmVsaWFibGUgc29sdXRpb24uCgpBYnNvbHV0ZWx5IG1ha2VzIHNlbnNlIHNvIGZhci4K
Cj4gPiA+IFRoZSBvdGhlciByZWFsbHkgd2VpcmQgdGhpbmdzIGlzIHRoYXQgaW4gYXJtMzIKPiA+
ID4gcGdwcm90X2RtYWNvaGVyZW50IGluY3VkZXMgdGhlIExfUFRFX1hOIGJpdCwgd2hpY2ggZnJv
bSBteSB1bmRlcnN0YW5kaW5nCj4gPiA+IGlzIHRoZSBuby1leGVjdHVyZSBiaXQsIGJ1dCBwZ3By
b3Rfd3JpdGVjb21iaW5lIGRvZXMgbm90LiAgVGhpcyBzZWVtcyB0bwo+ID4gPiBub3QgdmVyeSB1
bmludGVudGlvbmFsLiAgU28gbWludXMgdGhhdCB0aGUgd2hvbGUgRE1BX0FUVFJfV1JJVEVfQ09N
QtCGTkUKPiA+ID4gc2VlbXMgdG8gYmUgYWJvdXQgZmxhZ2dpbmcgb2xkIGFybSBzcGVjaWZpYyBk
cml2ZXJzIGFzIGhhdmluZyB0aGUgcHJvcGVyCj4gPiA+IGJhcnJpZXJzIGluIHBsYWNlcyBhbmQg
b3RoZXJ3aXNlIGlzIGEgbm8tb3AuCj4gPiAKPiA+IEkgdGhpbmsgaXQgb25seSBtYXR0ZXJzIGZv
ciBBcm12NyBDUFVzLCBidXQgeWVzLCB3ZSBzaG91bGQgcHJvYmFibHkgYmUKPiA+IHNldHRpbmcg
TF9QVEVfWE4gZm9yIGJvdGggb2YgdGhlc2UgbWVtb3J5IHR5cGVzLgo+IAo+IENvbnZlbnRpb25h
bGx5LCBwZ3Byb3Rfd3JpdGVjb21iaW5lKCkgaGFzIG9ubHkgYmVlbiB1c2VkIHRvIGNoYW5nZQo+
IHRoZSBtZW1vcnkgdHlwZSBhbmQgbm90IHRoZSBwZXJtaXNzaW9ucy4gIFNpbmNlIHdyaXRlY29t
YmluZSBtZW1vcnkKPiBpcyBzdGlsbCBjYXBhYmxlIG9mIGJlaW5nIGV4ZWN1dGVkLCBJIGRvbid0
IHNlZSBhbnkgcmVhc29uIHRvIHNldCBYTgo+IGZvciBpdC4KPiAKPiBJZiB0aGUgdXNlciB3aXNo
ZXMgdG8gbW1hcCgpIHVzaW5nIFBST1RfUkVBRHxQUk9UX0VYRUMsIHRoZW4gaXMgdGhlcmUKPiBy
ZWFsbHkgYSByZWFzb24gZm9yIHdyaXRlY29tYmluZSB0byBzZXQgWE4gb3ZlcnJpZGluZyB0aGUg
dXNlcj8KPiAKPiBUaGF0IHNhaWQsIHBncHJvdF93cml0ZWNvbWJpbmUoKSBpcyBtb3N0bHkgdXNl
ZCBmb3IgZnJhbWVidWZmZXJzLCB3aGljaAo+IGFyZ3VhYmx5IHNob3VsZG4ndCBiZSBleGVjdXRh
YmxlIGFueXdheSAtIGJ1dCB3aG8nZCB3YW50IHRvIG1tYXAoKSB0aGUKPiBmcmFtZWJ1ZmZlciB3
aXRoIFBST1RfRVhFQz8KCldlbGwsIEkgd2FzIG1vc3RseSB0YWtpbmcgYWJvdXQgRE1BX0FUVFJf
V1JJVEVfQ09NQklORSwgd2hpY2ggcmVhbGx5CnNob3VsZCBpbmNsdWRlIHRoZSBOWCBiaXQgZXZl
biBpZiBwZ3Byb3Rfd3JpdGVjb21iaW5lIGRvZXNuJ3QsIHJpZ2h0PwoKPiA+ID4gIC0gbWFrZSBE
TUFfQVRUUl9XUklURV9DT01CSU5FIGEgbm8tb3AgYW5kIHNjaGVkdWxlIGl0IGZvciByZW1vdmFs
LAo+ID4gPiAgICB0aHVzIHJlbW92aW5nIHRoZSBsYXN0IGluc3RhbmNlcyBvZiBhcmNoX2RtYV9t
bWFwX3BncHJvdAo+ID4gCj4gPiBBbGwgc291bmRzIGdvb2QgdG8gbWUsIGFsdGhvdWdoIEkgc3Vw
cG9zZSAzMi1iaXQgQXJtIHBsYXRmb3JtcyB3aXRob3V0Cj4gPiBDT05GSUdfQVJNX0RNQV9NRU1f
QlVGRkVSQUJMRSBtYXkgcnVuIGludG8gaXNzdWVzIGlmIERNQV9BVFRSX1dSSVRFX0NPTUJJTkUK
PiA+IGRpc2FwcGVhcnMuIE9ubHkgb25lIHdheSB0byBmaW5kIG91dC4uLgo+IAo+IExvb2tpbmcg
YXQgdGhlIHJlc3VsdHMgb2YgZ3JlcCwgSSB0aGluayBvbmx5IE9NQVAyKyBhbmQgRXh5bm9zIG1h
eSBiZQo+IGFmZmVjdGVkLgoKQXMgeW91IG1lbnRpb25lZCBsYXRlciB3ZSBhbHNvIGhhdmUgdGhl
IGRtYV9hbGxvY193YyB3cmFwcGVyLCBhbmQgYQpzaW5nbGUgaW5zdGFuY2Ugb2YgZG1hX2FsbG9j
X3dyaXRlY29tYmluZS4KCkV4eW5vcyBsb29rcyBsaWtlIHB1cmVseSBBUk0gdjcgZnJvbSBLY29u
ZmlnLCBzbyBpdCBzaG91bGRuJ3QgZXZlbiBiZQphZmZlY3RlZC4KCj4gSG93ZXZlciwgcmVtb3Zp
bmcgd3JpdGVjb21iaW5lIHN1cHBvcnQgZnJvbSB0aGUgRE1BIEFQSSBpcyBnb2luZyB0bwo+IGhh
dmUgYSBodWdlIGltcGFjdCBmb3IgZnJhbWVidWZmZXJzIG9uIGVhcmxpZXIgQVJNcyAtIHRoYXQn
cyB3aGVyZSB3ZQo+IGRvIGV4cGVjdCBmcmFtZWJ1ZmZlcnMgdG8gYmUgbWFwcGVkICJ1bmNhY2hl
ZC9idWZmZXJlZCIgZm9yIHBlcmZvcm1hbmNlCj4gcmVhc29ucyBhbmQgbm90ICJ1bmNhY2hlZC91
bmJ1ZmZlcmVkIi4gIEl0J3MgcXVpdGUgbGl0ZXJhbGx5IHRoZQo+IGRpZmZlcmVuY2UgYmV0d2Vl
biBjb25zb2xlIHNjcm9sbGluZyBiZWluZyB1c2FibGUgYW5kIHRvdGFsbHkgdW51c2FibGUuCj4g
Cj4gR2l2ZW4gd2hhdCBJJ3ZlIHNhaWQgYWJvdmUsIHN3aXRjaGluZyB0byB1c2luZyBidWZmZXJl
ZCBtb2RlIGZvciBub3JtYWwKPiBETUEgbWFwcGluZ3MgaXMgZGF0YS1jb3JydXB0aW5nIHJpc2t5
IC0gYXMgaW4geW91ciBmaWxlc3lzdGVtIGNvdWxkIGdldAo+IGZyaWVkLiAgSSBkb24ndCB0aGlu
ayB3ZSBzaG91bGQgcGxheSBmYXN0IGFuZCBsb29zZSB3aXRoIHBlb3BsZSdzIGRhdGEKPiBieSBy
YW5kb21seSBjaGFuZ2luZyB0aGF0ICJiZWNhdXNlIHdlJ2QgbGlrZSB0byIsIGFuZCBJIGRvbid0
IHNlZSB0aGF0Cj4gc2NyZXdpbmcgdGhlIGNvbnNvbGUgaXMgcmVhbGx5IGFuIG9wdGlvbiBlaXRo
ZXIuCgpPaCB3ZWxsLiAgIElmIHdlIGNhbid0IG1ha2UgZG1hX2FsbG9jX3djIGdlbmVyYWxseSBz
YWZlIEkgZmVhciB3ZSdsbApoYXZlIHRvIGtlZXAgaXQsIGJ1dCBtYXliZSBsaXRlcmFsbHkgbGlt
aXQgaXQgdG8gdGhlIHByZSBBUk0gdjYKcGxhdGZvcm1zLiAgV2hpbGUgcHJldHR5IG11Y2ggYWxs
IGNhbGxlcnMgc2VlbXMgcGxhdGZvcm0gc3BlY2lmaWMsCnRoZXJlIGFjdHVhbGx5IGFyZSBhIGRl
Y2VudCBudW1iZXIgdGhhdCBjYW4gb25seSB3b3JrIG9uIEFSTSB2NyBvcgphcm02NC4KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBs
aXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
