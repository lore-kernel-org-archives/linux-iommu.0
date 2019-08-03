Return-Path: <SRS0=gcAa=V7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9D3C433FF
	for <iommu@archiver.kernel.org>; Sat,  3 Aug 2019 06:50:36 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7616E2073D
	for <iommu@archiver.kernel.org>; Sat,  3 Aug 2019 06:50:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7616E2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 455D2186B;
	Sat,  3 Aug 2019 06:50:36 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id AE0221837
	for <iommu@lists.linux-foundation.org>;
	Sat,  3 Aug 2019 06:48:18 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 370D1712
	for <iommu@lists.linux-foundation.org>;
	Sat,  3 Aug 2019 06:48:18 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3208868BFE; Sat,  3 Aug 2019 08:48:13 +0200 (CEST)
Date: Sat, 3 Aug 2019 08:48:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH] dma-mapping: fix page attributes for dma_mmap_*
Message-ID: <20190803064812.GA29746@lst.de>
References: <20190801142118.21225-1-hch@lst.de>
	<20190801142118.21225-2-hch@lst.de>
	<20190801162305.3m32chycsdjmdejk@willie-the-truck>
	<20190801163457.GB26588@lst.de>
	<20190801164411.kmsl4japtfkgvzxe@willie-the-truck>
	<20190802081441.GA9725@lst.de>
	<20190802103803.3qrbhqwxlasojsco@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190802103803.3qrbhqwxlasojsco@willie-the-truck>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Shawn Anastasio <shawn@anastas.io>, Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org, Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
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

T24gRnJpLCBBdWcgMDIsIDIwMTkgYXQgMTE6Mzg6MDNBTSArMDEwMCwgV2lsbCBEZWFjb24gd3Jv
dGU6Cj4gCj4gU28gdGhpcyBib2lscyBkb3duIHRvIGEgdGVybWlub2xvZ3kgbWlzbWF0Y2guIFRo
ZSBBcm0gYXJjaGl0ZWN0dXJlIGRvZXNuJ3QgaGF2ZQo+IGFueXRoaW5nIGNhbGxlZCAid3JpdGUg
Y29tYmluZSIsIHNvIGluIExpbnV4IHdlIGluc3RlYWQgcHJvdmlkZSB3aGF0IHRoZSBBcm0KPiBh
cmNoaXRlY3R1cmUgY2FsbHMgIk5vcm1hbCBub24tY2FjaGVhYmxlIiBtZW1vcnkgZm9yIHBncHJv
dF93cml0ZWNvbWJpbmUoKS4KPiBBbW9uZ3N0IG90aGVyIHRoaW5ncywgdGhpcyBtZW1vcnkgdHlw
ZSBwZXJtaXRzIHNwZWN1bGF0aW9uLCB1bmFsaWduZWQgYWNjZXNzZXMKPiBhbmQgbWVyZ2luZyBv
ZiB3cml0ZXMuIEkgZm91bmQgc29tZXRoaW5nIGluIHRoZSBhcmNoaXRlY3R1cmUgc3BlYyBhYm91
dAo+IG5vbi1jYWNoYWJsZSBtZW1vcnksIGJ1dCBpdCdzIHdyaXR0ZW4gaW4gQXJtZ2xpc2hbMV0u
Cj4gCj4gcGdwcm90X25vbmNhY2hlZCgpLCBvbiB0aGUgb3RoZXIgaGFuZCwgcHJvdmlkZXMgd2hh
dCB0aGUgYXJjaGl0ZWN0dXJlIGNhbGxzCj4gU3Ryb25nbHkgT3JkZXJlZCBvciBEZXZpY2Utbkdu
Um5FIG1lbW9yeS4gVGhpcyBpcyBpbnRlbmRlZCBmb3IgbWFwcGluZyBNTUlPCj4gKGkuZS4gUENJ
IGNvbmZpZyBzcGFjZSkgYW5kIHRoZXJlZm9yZSBmb3JiaWRzIHNwZWN1bGF0aW9uLCBwcmVzZXJ2
ZXMgYWNjZXNzCj4gc2l6ZSwgcmVxdWlyZXMgc3RyaWN0IGFsaWdubWVudCBhbmQgYWxzbyBmb3Jj
ZXMgd3JpdGUgcmVzcG9uc2VzIHRvIGNvbWUgZnJvbQo+IHRoZSBlbmRwb2ludC4KPiAKPiBJIHRo
aW5rIHRoZSBuYW1pbmcgbWlzbWF0Y2ggaXMgaGlzdG9yaWNhbCwgYnV0IG9uIGFybTY0IHdlIHdh
bnRlZCB0byB1c2UgdGhlCj4gc2FtZSBuYW1lcyBhcyBhcm0zMiBzbyB0aGF0IGFueSBkcml2ZXJz
IHVzaW5nIHRoZXNlIHRoaW5ncyBkaXJlY3RseSB3b3VsZCBnZXQKPiB0aGUgc2FtZSBiZWhhdmlv
dXIuCgpUaGF0IGFsbCBtYWtlcyBzZW5zZSwgYnV0IGl0IHRvdGFsbHkgbmVlZHMgYSBjb21tZW50
LiAgSSdsbCB0cnkgdG8gZHJhZnQKb25lIGJhc2VkIG9uIHRoaXMuICBJJ3ZlIGFsc28gbG9va2Vk
IGF0IHRoZSBhcm0zMiBjb2RlIGEgYml0IG1vcmUsIGFuZAppdCBzZWVtcyBhcm0gYWx3YXlzICg/
KSBzdXBwb3J0ZWQgTm9ybWFsIG5vbi1jYWNoZWFibGUgYXR0cmlidXRlLCBidXQKTGludXggb25s
eSBvcHRpb25hbGx5IHVzZXMgaXQgZm9yIGFybSB2NisgYmVjYXVzZSBvZiBmZWFycyBvZiBkcml2
ZXJzCm1pc3NpbmcgYmFycmllcnMuICBUaGUgb3RoZXIgcmVhbGx5IHdlaXJkIHRoaW5ncyBpcyB0
aGF0IGluIGFybTMyCnBncHJvdF9kbWFjb2hlcmVudCBpbmN1ZGVzIHRoZSBMX1BURV9YTiBiaXQs
IHdoaWNoIGZyb20gbXkgdW5kZXJzdGFuZGluZwppcyB0aGUgbm8tZXhlY3R1cmUgYml0LCBidXQg
cGdwcm90X3dyaXRlY29tYmluZSBkb2VzIG5vdC4gIFRoaXMgc2VlbXMgdG8Kbm90IHZlcnkgdW5p
bnRlbnRpb25hbC4gIFNvIG1pbnVzIHRoYXQgdGhlIHdob2xlIERNQV9BVFRSX1dSSVRFX0NPTULQ
hk5FCnNlZW1zIHRvIGJlIGFib3V0IGZsYWdnaW5nIG9sZCBhcm0gc3BlY2lmaWMgZHJpdmVycyBh
cyBoYXZpbmcgdGhlIHByb3BlcgpiYXJyaWVycyBpbiBwbGFjZXMgYW5kIG90aGVyd2lzZSBpcyBh
IG5vLW9wLgoKSGVyZSBpcyBteSB0ZW50YXRpdmUgcGxhbjoKCiAtIHJlc3BpbiB0aGlzIHBhdGNo
IHdpdGggYSBzbWFsbCBmaXggdG8gaGFuZGxlIHRoZQogICBETUFfQVRUUl9OT05fQ09OU0lTVEVO
VCAoYXMgaW4gaWdub3JlIGl0IHVubGVzcyBhY3R1YWxseSBzdXBwb3J0ZWQpLAogICBidXQga2Vl
cCB0aGUgbmFtZSBhcy1pcyB0byBhdm9pZCBjaHVybi4gIFRoaXMgc2hvdWxkIGFsbG93IDUuMwog
ICBpbmNsdXNpb24gYW5kIGJhY2twb3J0cwogLSByZW1vdmUgRE1BX0FUVFJfV1JJVEVfQ09NQklO
RSBzdXBwb3J0IGZyb20gbWlwcywgcHJvYmFibHkgYWxzbyA1LjMKICAgbWF0ZXJpYWwuCiAtIG1v
dmUgYWxsIGFyY2hpdGVjdHVyZXMgYnV0IGFybSBvdmVyIHRvIGp1c3QgZGVmaW5lCiAgIHBncHJv
dF9kbWFjb2hlcmVudCwgaW5jbHVkaW5nIGEgY29tbWVudCB3aXRoIHRoZSBhYm92ZSBleHBsYW5h
dGlvbgogICBmb3IgYXJtNjQuCiAtIG1ha2UgRE1BX0FUVFJfV1JJVEVfQ09NQklORSBhIG5vLW9w
IGFuZCBzY2hlZHVsZSBpdCBmb3IgcmVtb3ZhbCwKICAgdGh1cyByZW1vdmluZyB0aGUgbGFzdCBp
bnN0YW5jZXMgb2YgYXJjaF9kbWFfbW1hcF9wZ3Byb3QKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2lvbW11
