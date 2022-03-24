Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD9D2C433F5
	for <iommu@archiver.kernel.org>; Thu, 24 Mar 2022 14:58:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7FFB0828F7;
	Thu, 24 Mar 2022 14:58:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P-KBT_NdjXfK; Thu, 24 Mar 2022 14:58:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5003F8246F;
	Thu, 24 Mar 2022 14:58:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 36147C001A;
	Thu, 24 Mar 2022 14:58:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE57DC000B
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 14:34:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CDEB24155B
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 14:34:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=toke.dk
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JURJ8o76U37S for <iommu@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 14:34:29 +0000 (UTC)
X-Greylist: delayed 00:06:32 by SQLgrey-1.8.0
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B31054154F
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 14:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
 t=1648132071; bh=tnWUB/odmMKWGyF8he0G98tAGrRwpBch0DMAenM1KqE=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=Nl31SHkGEOpmzbhGTx/T436+jfkG7FgLD/mSjYD7BSj0K+POWTP/XdxPCiodxbxQl
 fs/0XEz6ZSEqIigCk9/SGOf78e9BBUztwbBZDzqH/ljmF35/Ft7SaJ2tb+ZfJ3B82v
 5Ds6VCknje0VtdskIGdvIYT2IP30ry+Tg++Nwx0V4+GwyeAIHvqo5gXJBHda6FCGFN
 qWMkQGe87jzEr6SAA82toe9moP0NlIgQE7lxYyU93qrPdMDq9NoRbCop8YAlmyRwBG
 DCvoBiDd0G923RpGwr8v+jV+hGB48XSTTIsaeMsKUjkspEaeCquR+2Qwv8L3tLcNxb
 xaKx373cf/cWw==
To: Robin Murphy <robin.murphy@arm.com>, Oleksandr Natalenko
 <oleksandr@natalenko.name>, Christoph Hellwig <hch@lst.de>
Subject: Re: [REGRESSION] Recent swiotlb DMA_FROM_DEVICE fixes break
 ath9k-based AP
In-Reply-To: <81ffc753-72aa-6327-b87b-3f11915f2549@arm.com>
References: <1812355.tdWV9SEqCh@natalenko.name>
 <f88ca616-96d1-82dc-1bc8-b17480e937dd@arm.com>
 <20220324055732.GB12078@lst.de> <4386660.LvFx2qVVIh@natalenko.name>
 <81ffc753-72aa-6327-b87b-3f11915f2549@arm.com>
Date: Thu, 24 Mar 2022 15:27:50 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <878rsza0ih.fsf@toke.dk>
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 24 Mar 2022 14:58:37 +0000
Cc: Netdev <netdev@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 stable <stable@vger.kernel.org>, Halil Pasic <pasic@linux.ibm.com>,
 iommu <iommu@lists.linux-foundation.org>,
 Olha Cherevyk <olha.cherevyk@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>
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
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= via iommu
 <iommu@lists.linux-foundation.org>
Reply-To: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Um9iaW4gTXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4gd3JpdGVzOgoKPiBPbiAyMDIyLTAz
LTI0IDEwOjI1LCBPbGVrc2FuZHIgTmF0YWxlbmtvIHdyb3RlOgo+PiBIZWxsby4KPj4gCj4+IE9u
IMSNdHZydGVrIDI0LiBixZllem5hIDIwMjIgNjo1NzozMiBDRVQgQ2hyaXN0b3BoIEhlbGx3aWcg
d3JvdGU6Cj4+PiBPbiBXZWQsIE1hciAyMywgMjAyMiBhdCAwODo1NDowOFBNICswMDAwLCBSb2Jp
biBNdXJwaHkgd3JvdGU6Cj4+Pj4gSSdsbCBhZG1pdCBJIHN0aWxsIG5ldmVyIHF1aXRlIGdyYXNw
ZWQgdGhlIHJlYXNvbiBmb3IgYWxzbyBhZGRpbmcgdGhlCj4+Pj4gb3ZlcnJpZGUgdG8gc3dpb3Rs
Yl9zeW5jX3NpbmdsZV9mb3JfZGV2aWNlKCkgaW4gYWE2ZjhkY2JhYjQ3LCBidXQgSSB0aGluawo+
Pj4+IGJ5IHRoYXQgcG9pbnQgd2Ugd2VyZSBpbmNyZWFzaW5nbHkgdGlyZWQgYW5kIGNvbmZ1c2Vk
IGFuZCBzdGFydGluZyB0bwo+Pj4+IHNlY29uZC1ndWVzcyBvdXJzZWx2ZXMgKHdlbGwsIEkgd2Fz
LCBhdCBsZWFzdCkuIEkgZG9uJ3QgdGhpbmsgaXQncyB3cm9uZwo+Pj4+IHBlciBzZSwgYnV0IGFz
IEkgc2FpZCBJIGRvIHRoaW5rIGl0IGNhbiBiaXRlIGFueW9uZSB3aG8ncyBiZWVuIGRvaW5nCj4+
Pj4gZG1hX3N5bmNfKigpIHdyb25nIGJ1dCBnZXR0aW5nIGF3YXkgd2l0aCBpdCB1bnRpbCBub3cu
IElmIGRkYmQ4OWRlYjdkMwo+Pj4+IGFsb25lIHR1cm5zIG91dCB0byB3b3JrIE9LIHRoZW4gSSdk
IGJlIGluY2xpbmVkIHRvIHRyeSBhIHBhcnRpYWwgcmV2ZXJ0IG9mCj4+Pj4ganVzdCB0aGF0IG9u
ZSBodW5rLgo+Pj4KPj4+IEFncmVlZC4gIExldCdzIHRyeSB0aGF0IGZpcnN0Lgo+Pj4KPj4+IE9s
ZWtzYW5kciwgY2FuIHlvdSB0cnkgdGhlIHBhdGNoIGJlbG93Ogo+Pj4KPj4+Cj4+PiBkaWZmIC0t
Z2l0IGEva2VybmVsL2RtYS9zd2lvdGxiLmMgYi9rZXJuZWwvZG1hL3N3aW90bGIuYwo+Pj4gaW5k
ZXggNmRiMWM0NzVlYzgyNy4uNmMzNTA1NTVlNWExYyAxMDA2NDQKPj4+IC0tLSBhL2tlcm5lbC9k
bWEvc3dpb3RsYi5jCj4+PiArKysgYi9rZXJuZWwvZG1hL3N3aW90bGIuYwo+Pj4gQEAgLTcwMSwx
MyArNzAxLDEwIEBAIHZvaWQgc3dpb3RsYl90YmxfdW5tYXBfc2luZ2xlKHN0cnVjdCBkZXZpY2Ug
KmRldiwgcGh5c19hZGRyX3QgdGxiX2FkZHIsCj4+PiAgIHZvaWQgc3dpb3RsYl9zeW5jX3Npbmds
ZV9mb3JfZGV2aWNlKHN0cnVjdCBkZXZpY2UgKmRldiwgcGh5c19hZGRyX3QgdGxiX2FkZHIsCj4+
PiAgIAkJc2l6ZV90IHNpemUsIGVudW0gZG1hX2RhdGFfZGlyZWN0aW9uIGRpcikKPj4+ICAgewo+
Pj4gLQkvKgo+Pj4gLQkgKiBVbmNvbmRpdGlvbmFsIGJvdW5jZSBpcyBuZWNlc3NhcnkgdG8gYXZv
aWQgY29ycnVwdGlvbiBvbgo+Pj4gLQkgKiBzeW5jXypfZm9yX2NwdSBvciBkbWFfdW1tYXBfKiB3
aGVuIHRoZSBkZXZpY2UgZGlkbid0IG92ZXJ3cml0ZQo+Pj4gLQkgKiB0aGUgd2hvbGUgbGVuZ3Qg
b2YgdGhlIGJvdW5jZSBidWZmZXIuCj4+PiAtCSAqLwo+Pj4gLQlzd2lvdGxiX2JvdW5jZShkZXYs
IHRsYl9hZGRyLCBzaXplLCBETUFfVE9fREVWSUNFKTsKPj4+IC0JQlVHX09OKCF2YWxpZF9kbWFf
ZGlyZWN0aW9uKGRpcikpOwo+Pj4gKwlpZiAoZGlyID09IERNQV9UT19ERVZJQ0UgfHwgZGlyID09
IERNQV9CSURJUkVDVElPTkFMKQo+Pj4gKwkJc3dpb3RsYl9ib3VuY2UoZGV2LCB0bGJfYWRkciwg
c2l6ZSwgRE1BX1RPX0RFVklDRSk7Cj4+PiArCWVsc2UKPj4+ICsJCUJVR19PTihkaXIgIT0gRE1B
X0ZST01fREVWSUNFKTsKPj4+ICAgfQo+Pj4gICAKPj4+ICAgdm9pZCBzd2lvdGxiX3N5bmNfc2lu
Z2xlX2Zvcl9jcHUoc3RydWN0IGRldmljZSAqZGV2LCBwaHlzX2FkZHJfdCB0bGJfYWRkciwKPj4+
Cj4+IAo+PiBXaXRoIHRoaXMgcGF0Y2ggdGhlIEFQIHdvcmtzIGZvciBtZS4KPgo+IENvb2wsIHRo
YW5rcyBmb3IgY29uZmlybWluZy4gU28gSSB0aGluayBhdGg5ayBwcm9iYWJseSBpcyBkb2luZyAK
PiBzb21ldGhpbmcgZG9kZ3kgd2l0aCBkbWFfc3luY18qKCksIGJ1dCBpZiBMaW51cyBwcmVmZXJz
IHRvIG1ha2UgdGhlIAo+IGFib3ZlIGNoYW5nZSByYXRoZXIgdGhhbiB3YWl0IGZvciB0aGF0IHRv
IGdldCBmaWd1cmVkIG91dCwgSSBiZWxpZXZlIAo+IHRoYXQgc2hvdWxkIGJlIGZpbmUuCgpJJ20g
bG9va2luZyBpbnRvIHRoaXM7IGJ1dCBpbiB0aGUgaW50ZXJlc3Qgb2YgYSBzcGVlZHkgcmVzb2x1
dGlvbiBvZiB0aGUKcmVncmVzc2lvbiBJIHdvdWxkIGJlIGluIGZhdm91ciBvZiBtZXJnaW5nIHRo
YXQgcGFydGlhbCByZXZlcnQgYW5kCnJlaW5zdGF0aW5nIGl0IGlmL3doZW4gd2UgaWRlbnRpZnkg
KGFuZCBmaXgpIGFueSBidWdzIGluIGF0aDlrIDopCgotVG9rZQpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vaW9tbXU=
