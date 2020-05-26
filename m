Return-Path: <SRS0=1lY2=7I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60869C433DF
	for <iommu@archiver.kernel.org>; Tue, 26 May 2020 07:19:18 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2082E2053B
	for <iommu@archiver.kernel.org>; Tue, 26 May 2020 07:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="fzC6PYZa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2082E2053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id D8268882B5;
	Tue, 26 May 2020 07:19:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QyDSWB325uoG; Tue, 26 May 2020 07:19:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D42AE87D75;
	Tue, 26 May 2020 07:19:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B8EE5C0888;
	Tue, 26 May 2020 07:19:16 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A33CC016F
 for <iommu@lists.linux-foundation.org>; Tue, 26 May 2020 07:19:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id F3E3A851C0
 for <iommu@lists.linux-foundation.org>; Tue, 26 May 2020 07:19:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HU-SSHAAojYb for <iommu@lists.linux-foundation.org>;
 Tue, 26 May 2020 07:19:13 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail26.static.mailgun.info (mail26.static.mailgun.info
 [104.130.122.26])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E9D04849F0
 for <iommu@lists.linux-foundation.org>; Tue, 26 May 2020 07:19:12 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1590477553; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=t71fVS7j/WcPCfl6939ZO5sEbx5ADmDSJSpSKaYbIN4=;
 b=fzC6PYZahE8T3sVnMW7Apz3ExO5L6uK6Yc5qSgqeJy4+Kks3R93+JCstO0w8hQzL8VeSQ/qF
 Vd8vi+yd931IUZbjLhHLqz6ZocBGHUhZOyawjEGYcKThH+X4534bxnj2ByTkgaJ6FpLFpTy6
 1d5bPIwGckWhI8spjE2nXmg0kmw=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5eccc2efb65440fdba6e8cee (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 26 May 2020 07:19:11
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 6B713C43387; Tue, 26 May 2020 07:19:10 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested) (Authenticated sender: guptap)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id B5261C433C6;
 Tue, 26 May 2020 07:19:09 +0000 (UTC)
MIME-Version: 1.0
Date: Tue, 26 May 2020 12:49:09 +0530
From: guptap@codeaurora.org
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/dma: limit iova free size to unmmaped iova
In-Reply-To: <2d873ab9-ebb9-3c2d-f129-55a036ab47d0@arm.com>
References: <20200521113004.12438-1-guptap@codeaurora.org>
 <7aaa8dcc-6a47-f256-431d-2a1b034b4076@arm.com>
 <90662ef3123dbf2e93f9718ee5cc14a7@codeaurora.org>
 <2d873ab9-ebb9-3c2d-f129-55a036ab47d0@arm.com>
Message-ID: <4ba082d3bb965524157704ea1ffb1ff4@codeaurora.org>
X-Sender: guptap@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: mhocko@suse.com, owner-linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Andrew Morton <akpm@linux-foundation.org>
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

T24gMjAyMC0wNS0yMiAxNDo1NCwgUm9iaW4gTXVycGh5IHdyb3RlOgo+IE9uIDIwMjAtMDUtMjIg
MDc6MjUsIGd1cHRhcEBjb2RlYXVyb3JhLm9yZyB3cm90ZToKPj4gT24gMjAyMC0wNS0yMiAwMTo0
NiwgUm9iaW4gTXVycGh5IHdyb3RlOgo+Pj4gT24gMjAyMC0wNS0yMSAxMjozMCwgUHJha2FzaCBH
dXB0YSB3cm90ZToKPj4gSSBhZ3JlZSwgd2Ugc2hvdWxkbid0IGJlIGZyZWVpbmcgdGhlIHBhcnRp
YWwgaW92YS4gSW5zdGVhZCBqdXN0IG1ha2luZwo+PiBzdXJlIGlmIHVubWFwIHdhcyBzdWNjZXNz
ZnVsIHNob3VsZCBiZSBzdWZmaWNpZW50IGJlZm9yZSBmcmVlaW5nIGlvdmEuIAo+PiBTbyBjaGFu
Z2UKPj4gY2FuIGluc3RlYWQgYmUgc29tZXRoaW5nIGxpa2UgdGhpczoKPj4gCj4+IC3CoMKgwqAg
aW9tbXVfZG1hX2ZyZWVfaW92YShjb29raWUsIGRtYV9hZGRyLCBzaXplKTsKPj4gK8KgwqDCoCBp
ZiAodW5tYXBwZWQpCj4+ICvCoMKgwqDCoMKgwqDCoCBpb21tdV9kbWFfZnJlZV9pb3ZhKGNvb2tp
ZSwgZG1hX2FkZHIsIHNpemUpOwo+PiAKPj4+IFRCSCBteSBndXQgZmVlbGluZyBoZXJlIGlzIHRo
YXQgeW91J3JlIHJlYWxseSBqdXN0IHRyeWluZyB0byB0cmVhdCBhCj4+PiBzeW1wdG9tIG9mIGFu
b3RoZXIgYnVnIGVsc2V3aGVyZSwgbmFtZWx5IHNvbWUgZHJpdmVyIGNhbGxpbmcKPj4+IGRtYV91
bm1hcF8qIG9yIGRtYV9mcmVlXyogd2l0aCB0aGUgd3JvbmcgYWRkcmVzcyBvciBzaXplIGluIHRo
ZSBmaXJzdAo+Pj4gcGxhY2UuCj4+PiAKPj4gVGhpcyBjb25kaXRpb24gd291bGQgYXJpc2Ugb25s
eSBpZiBkcml2ZXIgY2FsbGluZyBkbWFfdW5tYXAvZnJlZV8qIAo+PiB3aXRoIDAKPj4gaW92YV9w
Zm4uIFRoaXMgd2lsbCBiZSBmbGFnZ2VkIHdpdGggYSB3YXJuaW5nIGR1cmluZyB1bm1hcCBidXQg
d2lsbCAKPj4gdHJpZ2dlcgo+PiBwYW5pYyBsYXRlciBvbiB3aGlsZSBkb2luZyB1bnJlbGF0ZWQg
ZG1hX21hcC91bm1hcF8qLiBJZiB1bm1hcHBlZCBoYXMgCj4+IGFscmVhZHkKPj4gZmFpbGVkIGZv
ciBpbnZhbGlkIGlvdmEsIHRoZXJlIGlzIG5vIHJlYXNvbiB3ZSBzaG91bGQgY29uc2lkZXIgdGhp
cyBhcyAKPj4gdmFsaWQKPj4gaW92YSBhbmQgZnJlZS4gVGhpcyBwYXJ0IHNob3VsZCBiZSBmaXhl
ZC4KPiAKPiBJIGRpc2FncmVlLiBJbiBnZW5lcmFsLCBpZiBkcml2ZXJzIGNhbGwgdGhlIERNQSBB
UEkgaW5jb3JyZWN0bHkgaXQgaXMKPiBsaWFibGUgdG8gbGVhZCB0byBkYXRhIGxvc3MsIG1lbW9y
eSBjb3JydXB0aW9uLCBhbmQgdmFyaW91cyBvdGhlcgo+IHVucGxlYXNhbnQgbWlzYmVoYXZpb3Vy
IC0gaXQgaXMgbm90IHRoZSBETUEgbGF5ZXIncyBqb2IgdG8gYXR0ZW1wdCB0bwo+IHBhcGVyIG92
ZXIgZHJpdmVyIGJ1Z3MuCj4gCj4gVGhlcmUgKmlzKiBhbiBhcmd1bWVudCBmb3IgZG93bmdyYWRp
bmcgdGhlIEJVR19PTigpIGluCj4gaW92YV9tYWdhemluZV9mcmVlX3BmbnMoKSB0byBhIFdBUk5f
T04oKSwgc2luY2UgZnJhbmtseSBpdCBpc24ndCBhCj4gc3VmZmljaWVudGx5IHNlcmlvdXMgY29u
ZGl0aW9uIHRvIGp1c3RpZnkga2lsbGluZyB0aGUgd2hvbGUgbWFjaGluZQo+IGltbWVkaWF0ZWx5
LCBidXQgTkFLIHRvIGJvZGdpbmcgdGhlIGlvbW11LWRtYSBtaWQtbGF5ZXIgdG8gImZpeCIgdGhh
dC4KPiBBIHNlcmlvdXMgYnVnIGFscmVhZHkgaGFwcGVuZWQgZWxzZXdoZXJlLCBzbyB0cnlpbmcg
dG8gaGlkZSB0aGUKPiBmYWxsb3V0IHJlYWxseSBkb2Vzbid0IGhlbHAgYW55b25lLgo+IApTb3Jy
eSBmb3IgZGVsYXllZCByZXNwb25zZSwgaXQgd2FzIGEgbG9uZyB3ZWVrZW5kLgpJIGFncmVlIHRo
YXQgaW52YWxpZCBETUEgQVBJIGNhbGwgY2FuIHJlc3VsdCBpbiB1bmV4cGVjdGVkIGlzc3VlcyBh
bmQgCmNsaWVudApzaG91bGQgZml4IGl0LCBidXQgdGhlbiB0aGUgcHJlc2VudCBiZWhhdmlvciBt
YWtlcyBpdCBkaWZmaWN1bHQgdG8gY2F0Y2ggCmNhc2VzCndoZW4gZHJpdmVyIGlzIG1ha2luZyB3
cm9uZyBETUEgQVBJIGNhbGxzLiBXaGVuIGludmFsaWQgaW92YSBwZm4gaXMgCnBhc3NlZCBpdApk
b2Vzbid0IGZhaWwgdGhlbiBhbmQgdGhlcmUsIHRob3VnaCBETUEgbGF5ZXIgaXMgYXdhcmUgb2Yg
aW92YSBiZWluZyAKaW52YWxpZC4gSXQKZmFpbHMgbXVjaCBhZnRlciB0aGF0IGluIHRoZSBjb250
ZXh0IG9mIGFuIHZhbGlkIG1hcC91bm1hcCwgd2l0aCAKQlVHX09OKCkuCgpEb3duZ3JhZGluZyBC
VUdfT04oKSB0byBXQVJOX09OKCkgaW4gaW92YV9tYWdhemluZV9mcmVlX3BmbnMoKSB3aWxsIG5v
dCAKaGVscAptdWNoIGFzIGludmFsaWQgaW92YSB3aWxsIGNhdXNlIE5VTEwgcG9pbnRlciBkZXJl
ZmVyZW5jZS4KCkkgc2VlIG5vIHJlYXNvbiB3aHkgRE1BIGxheWVyIHdhbnRzIHRvIGZyZWUgYW4g
aW92YSBmb3Igd2hpY2ggdW5tYXBwZWQgCmZhaWxlZC4KSU1ITyBxdWV1aW5nIGFuIGludmFsaWQg
aW92YSAod2hpY2ggYWxyZWFkeSBmYWlsZWQgdW5tYXApIHRvIHJjYWNoZSAKd2hpY2gKZXZlbnR1
YWxseSBnb2luZyB0byBjcmFzaCB0aGUgc3lzdGVtIGxvb2tzIGxpa2UgaW9tbXUtZG1hIGxheWVy
IGlzc3VlLgoKVGhhbmtzLApQcmFrYXNoCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby9pb21tdQ==
