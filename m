Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8611C433F5
	for <iommu@archiver.kernel.org>; Sun,  6 Mar 2022 07:59:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 290FB408C0;
	Sun,  6 Mar 2022 07:59:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SrECHN73QYSc; Sun,  6 Mar 2022 07:59:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B001840571;
	Sun,  6 Mar 2022 07:59:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83513C0012;
	Sun,  6 Mar 2022 07:59:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C05D3C000B
 for <iommu@lists.linux-foundation.org>; Sun,  6 Mar 2022 07:59:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 945A660B8A
 for <iommu@lists.linux-foundation.org>; Sun,  6 Mar 2022 07:59:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7qbyv52OBv8f for <iommu@lists.linux-foundation.org>;
 Sun,  6 Mar 2022 07:59:05 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E992D60B73
 for <iommu@lists.linux-foundation.org>; Sun,  6 Mar 2022 07:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
 :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=78SKL0+f0pC+LXR4ZAh8YHlAxTla1xXyOomfINWoXjU=; b=zYHbichC8z1vWDJpvI8si1yGIw
 7gimxtm/Iyvxb/TnmZGztUToDliWvoKMCe2LJhhNGFH+Dv9Wqh3a9RMd2arc3TdFteEA+vF6YTVpS
 V8opH+PAR3VyF3LimokR0xi1qqkTn+YZuN9wzZu2QwdDDuzgai6NfkdyeCfOJma5UHOg7eVAQ8U88
 XK15g5bvrrZaXw4S2ZMWQ+kFnQJ3dxKvbsbRrcsu2Px1JORL/kxXLd5/ItkPGjIIa2b1uZTg7S1GX
 py6MAqk6HcGXr9+Syny0sKTN+StsYHUncWxFxSkhwdazIXbaTrtHeZsW0NiQ2VPiFOEbC/CUZM4BD
 yqjFmGVw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nQlmy-00EISz-1t; Sun, 06 Mar 2022 07:58:48 +0000
Date: Sat, 5 Mar 2022 23:58:48 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 1/1] swiotlb: rework "fix info leak with
 DMA_FROM_DEVICE"
Message-ID: <YiRpuGbjyU2M47pQ@infradead.org>
References: <20220305170714.2043896-1-pasic@linux.ibm.com>
 <CAHk-=wgZ6fNG03pd2pAVw9RtymwPDyHNvTLHr2Q3LX3S0Y1k5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHk-=wgZ6fNG03pd2pAVw9RtymwPDyHNvTLHr2Q3LX3S0Y1k5Q@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Christoph Hellwig <hch@infradead.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 stable <stable@vger.kernel.org>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 iommu <iommu@lists.linux-foundation.org>, Doug Gilbert <dgilbert@interlog.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gU2F0LCBNYXIgMDUsIDIwMjIgYXQgMTE6NDQ6NTFBTSAtMDgwMCwgTGludXMgVG9ydmFsZHMg
d3JvdGU6Cj4gQ2hyaXN0b3BoLCBJIGFtIGFzc3VtaW5nIEknbGwgZ2V0IHRoaXMgZnJvbSB5b3Us
IGJ1dCBpZiB5b3UgaGF2ZQo+IG5vdGhpbmcgZWxzZSBwZW5kaW5nLCBqdXN0IGhvbGxlciBhbmQg
SSBjYW4gdGFrZSBpdCBkaXJlY3RseS4KCkkgaGF2ZSBub3RoaW5nIGVsc2UgcGVuZGluZywgc28g
ZmVlbCBmcmVlIHRvIHRha2UgaXQgZGlyZWN0bHk6CgpSZXZpZXdlZC1ieTogQ2hyaXN0b3BoIEhl
bGx3aWcgPGhjaEBsc3QuZGU+Cgo+IFRoYXQgc2FpZCwgaXQgc2VlbXMgc2FkIHRvIGJvdW5jZSB0
aGUgYnVmZmVyIGp1c3QgaW4gY2FzZSB0aGUgZGV2aWNlCj4gZG9lc24ndCBkbyB3aGF0IHdlIGV4
cGVjdCBpdCB0byBkby4gV291bGRuJ3QgaXQgYmUgYmV0dGVyIHRvIGp1c3QKPiBjbGVhciB0aGUg
YnVmZmVyIGluc3RlYWQgb2YgY29weWluZyB0aGUgb2xkIGRhdGEgaW50byBpdD8KClRoYXQgdW5m
b3J0dW5hdGVseSBkb2VzIG5vdCB3b3JrIGFsd2F5cyB3b3JrLCBhcyB3ZSBoYXZlIGludGVyZmFj
ZXMKd2hlcmUgd2UgZXhwZWN0IGRhdGEgdGhhdCBpcyBub3Qgd3JpdHRlbiB0byBieSB0aGUgZGV2
aWNlIHRvIHJlbWFpbgp1bmNoYW5nZWQsIGFuZCB0aGVyZSBhcmUgbWFueSBjYXNlcyB3aGVyZSB0
aGUgZGV2aWNlIGRvZXMgbm90IHdyaXRlCnRoZSB3aG9sZSBidWZmZXIuICBJbiB2YXJpb3VzIHBs
YWNlcyBsaWtlIFNDU0kgdGhlIGRhdGEgdHJhbnNmZXIKY2FuIGJlIHNtYWxsZXIsIGJ1dCBldmVu
IG1vcmUgY29tbW9uIGlzIHRoZSBjYXNlIG9mIG5vIGRhdGEgdHJhbnNmZXIKYXQgYWxsIGVycm9y
IGNhc2VzLgoKPiBBbHNvLCBwb3NzaWJseSBzdHVwaWQgcXVlc3Rpb24gLSB3aGVuIGlzIHN3aW90
bGIgdXNlZCBpbiBwcmFjdGljZQo+IHRoZXNlIGRheXM/IFdoYXQgYXJlIHRoZSBwZXJmb3JtYW5j
ZSBpbXBsaWNhdGlvbnMgb2YgdGhpcz8gV2lsbCB0aGlzCj4gbWVhbiBjb21wbGV0ZWx5IHVubmVj
ZXNzYXJ5IGNvcGllcyBmb3IgYWxsIG5vcm1hbCBJTyB0aGF0IHdpbGwgYmUKPiBvdmVyd3JpdHRl
biBieSB0aGUgRE1BPyBDYW4ndCB3ZSBsaW1pdCBpdCB0byBqdXN0IFNHX0lPIChvciBpcyBpdAo+
IGFscmVhZHkgZm9yIHNvbWUgcmVhc29uKT8KClRoZXJlIGFyZSB0aHJlZSB1c2UgY2FzZToKIC0g
Ym91bmNlIGJ1ZmZlcmluZyBkdWUgdG8gYWRkcmVzcyBsaW1pdGF0aW9ucyB3aGVuIG5vIElPTU1V
IGlzIHByZXNlbnQKIC0gYm91bmNlIGJ1ZmZlcmluZyBmb3Igbm90IHBhZ2UgYWxpZ25lZCBJL08g
b24gSU9NTVVzIGlmIHRoZSBkZXZpY2UKICAgaXMgY29uc2lkZXJlZCB1bnRydXN0ZWQgKHdoaWNo
IOOCimlnaHQgbm93IG1lYW5zIHRodW5kZXJib2x0IGF0dGFjaGVkKQogLSB1bmNvbmRpdGlvbmFs
IGJvdW5jZSBidWZmZXJpbmcgZm9yIHRydXN0ZWQgaHlwZXJ2aXNvciBzY2hlbWVzCgpBbGwgb2Yg
dGhlZSBhcHBseSB0byBhbGwgSS9PLiAgU0dfSU8gaXMganVzdCBhIHZlY3RvciBoZXJlIGFzIGEK
cGFydGljdWxhcmx5IGJhZGx5IGRlc2lnbmVkIHVzZXJzcGFjZSBpbnRlcmZhY2UgdGhhdCBoYXBw
ZW5zIHRvIGdldCBhCmRlY2VudCB0ZXN0IGNvdmVyYWdlLiAgVGhlcmUgdW5mb3J0dWF0ZWx5IGFy
ZSBwbGVudHkgb2Ygb3RoZXIgd2F5cyB0bwpleHBvc2UgdGhpcyBpc3N1ZSBhcyB3ZWxsLiAgV2Un
cmUgdGhpbmtpbmcgb2YgYnVpbGRpbmcgaW50ZXJmYWNlcyB0bwphdm9pZCB0aGUgb3ZlcmhlYWQg
Zm9yIHdlbGwgZGVzaWduZWQgaW50ZXJmYWNlcywgYnV0IGl0IHdpbGwgdGFrZSBzb21lCnRpbWUu
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1h
aWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
