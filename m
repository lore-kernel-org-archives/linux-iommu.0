Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7691DC433EF
	for <iommu@archiver.kernel.org>; Thu, 24 Mar 2022 21:14:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 294ED84499;
	Thu, 24 Mar 2022 21:14:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M4xsUSv1CTwl; Thu, 24 Mar 2022 21:14:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0802A843BA;
	Thu, 24 Mar 2022 21:14:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CB349C0012;
	Thu, 24 Mar 2022 21:14:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AD7B3C000B
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 21:14:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 977494035D
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 21:14:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=toke.dk
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bhu5pxJN2g09 for <iommu@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 21:14:31 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7595240350
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 21:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
 t=1648156468; bh=10YpchtIHtcZ8NSl6ZT7uwLuFlfFgJXa9Oolkv8NtQg=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=bgzPaBmGHN+bnivn53/b7ZIz9/UwYFmY03s5yT9g1LzfZvAJ3uIC7ce11QS/c9gDk
 R+EyTlbehDyeBvELCV6f+pU+CmP91zr7lx482udUYxg9jrlR/ovTm9K8oIjoB/rEha
 koK3I9RsZ9nIP/hbajSqIVn+Bk0NpwJEeSXvuQ3T1G3hO5g+mSdwUwK93gKKp92h+F
 OmmTJoRUd4/LgjWY01urisinyN5elIPMT5iEkPrjHSSPHnq9iwLcPxdf+NOnHNHk0j
 L5ovl1Ohbmz8Q5MEpZ3NdLlM2L2Qx85IIHFm9o24PgoAXbuYmLr7yHvHkB7jVoVtj+
 eFDzUyYMP1/pw==
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [REGRESSION] Recent swiotlb DMA_FROM_DEVICE fixes break
 ath9k-based AP
In-Reply-To: <CAHk-=whUQCCaQXJt3KUeQ8mtnLeVXEScNXCp+_DYh2SNY7EcEA@mail.gmail.com>
References: <1812355.tdWV9SEqCh@natalenko.name>
 <f88ca616-96d1-82dc-1bc8-b17480e937dd@arm.com>
 <20220324055732.GB12078@lst.de> <4386660.LvFx2qVVIh@natalenko.name>
 <81ffc753-72aa-6327-b87b-3f11915f2549@arm.com> <878rsza0ih.fsf@toke.dk>
 <4be26f5d8725cdb016c6fdd9d05cfeb69cdd9e09.camel@freebox.fr>
 <20220324163132.GB26098@lst.de>
 <d8a1cbf4-a521-78ec-1560-28d855e0913e@arm.com> <871qyr9t4e.fsf@toke.dk>
 <CAHk-=whUQCCaQXJt3KUeQ8mtnLeVXEScNXCp+_DYh2SNY7EcEA@mail.gmail.com>
Date: Thu, 24 Mar 2022 22:14:28 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87r16r834b.fsf@toke.dk>
MIME-Version: 1.0
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Netdev <netdev@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Oleksandr Natalenko <oleksandr@natalenko.name>,
 stable <stable@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Halil Pasic <pasic@linux.ibm.com>, iommu <iommu@lists.linux-foundation.org>,
 Olha Cherevyk <olha.cherevyk@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Maxime Bizon <mbizon@freebox.fr>, Paolo Abeni <pabeni@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

TGludXMgVG9ydmFsZHMgPHRvcnZhbGRzQGxpbnV4LWZvdW5kYXRpb24ub3JnPiB3cml0ZXM6Cgo+
IE9uIFRodSwgTWFyIDI0LCAyMDIyIGF0IDEwOjA3IEFNIFRva2UgSMO4aWxhbmQtSsO4cmdlbnNl
biA8dG9rZUB0b2tlLmRrPiB3cm90ZToKPj4KPj4gUmlnaHQsIGJ1dCBpcyB0aGF0IHN5bmNfZm9y
X2RldmljZSBjYWxsIHJlYWxseSBuZWVkZWQ/Cj4KPiBXZWxsLCBpbWFnaW5lIHRoYXQgeW91IGhh
dmUgYSBub24tY2FjaGUtY29oZXJlbnQgRE1BIChub3QgYm91bmNlCj4gYnVmZmVycyAtIGp1c3Qg
YmFkIGhhcmR3YXJlKS4uLgo+Cj4gU28gdGhlIGRyaXZlciBmaXJzdCBkb2VzIHRoYXQgZG1hX3N5
bmNfc2luZ2xlX2Zvcl9jcHUoKSBmb3IgdGhlIENQVQo+IHNlZSB0aGUgY3VycmVudCBzdGF0ZSAo
Zm9yIHRoZSBub24tY2FjaGUtY29oZXJlbnQgY2FzZSBpdCB3b3VsZCBqdXN0Cj4gaW52YWxpZGF0
ZSBjYWNoZXMpLgo+Cj4gVGhlIGRyaXZlciB0aGVuIGV4YW1pbmVzIHRoZSBjb21tYW5kIGJ1ZmZl
ciBzdGF0ZSwgc2VlcyB0aGF0IGl0J3MKPiBzdGlsbCBpbiBwcm9ncmVzcywgYW5kIGRvZXMgdGhh
dCByZXR1cm4gLUVJTlBST0dSRVNTLgo+Cj4gSXQncyBhY3R1YWxseSB2ZXJ5IG5hdHVyYWwgaW4g
dGhhdCBzaXR1YXRpb24gdG8gZmx1c2ggdGhlIGNhY2hlcyBmcm9tCj4gdGhlIENQVSBzaWRlIGFn
YWluLiBBbmQgc28gZG1hX3N5bmNfc2luZ2xlX2Zvcl9kZXZpY2UoKSBpcyBhIGZhaXJseQo+IHJl
YXNvbmFibGUgdGhpbmcgdG8gZG8gaW4gdGhhdCBzaXR1YXRpb24uCj4KPiBCdXQgaXQgZG9lc24n
dCBzZWVtICpyZXF1aXJlZCosIG5vLiBUaGUgQ1BVIGNhY2hlcyBvbmx5IGhhdmUgYSBjb3B5IG9m
Cj4gdGhlIGRhdGEgaW4gdGhlbSwgbm8gd3JpdGViYWNrIG5lZWRlZCAoYW5kIHdyaXRlYmFjayB3
b3VsZG4ndCB3b3JrCj4gc2luY2UgRE1BIGZyb20gdGhlIGRldmljZSBtYXkgYmUgaW4gcHJvZ3Jl
c3MpLgo+Cj4gU28gSSBkb24ndCB0aGluayB0aGUgZG1hX3N5bmNfc2luZ2xlX2Zvcl9kZXZpY2Uo
KSBpcyAqd3JvbmcqIHBlciBzZSwKPiBiZWNhdXNlIHRoZSBDUFUgZGlkbid0IGFjdHVhbGx5IGRv
IGFueSBtb2RpZmljYXRpb25zLgo+Cj4gQnV0IHllcywgSSB0aGluayBpdCdzIHVubmVjZXNzYXJ5
IC0gYmVjYXVzZSBhbnkgbGF0ZXIgQ1BVIGFjY2Vzc2VzCj4gd291bGQgbmVlZCB0aGF0IGRtYV9z
eW5jX3NpbmdsZV9mb3JfY3B1KCkgYW55d2F5LCB3aGljaCBzaG91bGQKPiBpbnZhbGlkYXRlIGFu
eSBzdGFsZSBjYWNoZXMuCgpPSywgdGhlIGFib3ZlIHdhcyBiYXNpY2FsbHkgaG93IEkgdW5kZXJz
dG9vZCBpdC4gVGhhbmsgeW91IGZvcgpjb25maXJtaW5nIQoKPiBBbmQgaXQgY2xlYXJseSBkb2Vz
bid0IHdvcmsgaW4gYSBib3VuY2UtYnVmZmVyIHNpdHVhdGlvbiwgYnV0IGhvbmVzdGx5Cj4gSSBk
b24ndCB0aGluayBhICJDUFUgbW9kaWZpZWQgYnVmZmVycyBjb25jdXJyZW50bHkgd2l0aCBETUEi
IGNhbgo+ICpldmVyKiB3b3JrIGluIHRoYXQgc2l0dWF0aW9uLCBzbyBJIHRoaW5rIGl0J3Mgd3Jv
bmcgZm9yIGEgYm91bmNlCj4gYnVmZmVyIG1vZGVsIHRvIGV2ZXIgZG8gYW55dGhpbmcgaW4gdGhl
IGRtYV9zeW5jX3NpbmdsZV9mb3JfZGV2aWNlKCkKPiBzaXR1YXRpb24uCgpSaWdodC4KCj4gRG9l
cyByZW1vdmluZyB0aGF0IGRtYV9zeW5jX3NpbmdsZV9mb3JfZGV2aWNlKCkgYWN0dWFsbHkgZml4
IHRoZQo+IHByb2JsZW0gZm9yIHRoZSBhdGggZHJpdmVyPwoKSSBhbSBob3BpbmcgT2xla3NhbmRy
IGNhbiBoZWxwIGFuc3dlciB0aGF0IHNpbmNlIG15IG93biBhdGg5ayBoYXJkd2FyZQppcyBjdXJy
ZW50bHkgb24gc3RyaWtlIDooCgotVG9rZQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vaW9tbXU=
