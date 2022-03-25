Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A04C8C433EF
	for <iommu@archiver.kernel.org>; Fri, 25 Mar 2022 18:13:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3801A400D9;
	Fri, 25 Mar 2022 18:13:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mNtwLw19XfeY; Fri, 25 Mar 2022 18:13:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8E89540327;
	Fri, 25 Mar 2022 18:13:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3E5EBC002C;
	Fri, 25 Mar 2022 18:13:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74E23C0012
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 18:13:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5230140327
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 18:13:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5fy9Y-GBX_3H for <iommu@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 18:13:53 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.toke.dk (mail.toke.dk [IPv6:2a0c:4d80:42:2001::664])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C861F400D9
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 18:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
 t=1648232029; bh=2/6Vw2ASBAiN11k5yojKv5+vCVhPImMu3UVtt56378s=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=u6q8TNoDqnTn5TUskazRYnwgeG+FCVCycn+e4KdE8c61ipZ71vDDXvjHlHXaTSufc
 /7zUjA3cna3B1x8HpC7xOnRsqbkf3oxSIjhlvc2TBhwwVaooYqMMVK90FuenhMHD/2
 QS79/isfJKz7ViC1uu+Wdx+J3znSWRwUjvnqrUahIJiVwHX51aJj1/gj9kScR5ZAJe
 SUnOve0P5jpqAuBha431w1dhO5VMokHhVBKZvf300guwM7zTQJRRqrDCikWFvCLTNy
 weUjZRns/h9tE3SQyZ1YXoNzvSRKC+ij1BEfuTN4pybtBu+xQp3jtpNx0kJHo92MC0
 9CDkrzVDsS39Q==
To: Robin Murphy <robin.murphy@arm.com>, mbizon@freebox.fr, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: Re: [REGRESSION] Recent swiotlb DMA_FROM_DEVICE fixes break
 ath9k-based AP
In-Reply-To: <f4224721-4578-61d3-69a7-9a3a76c50529@arm.com>
References: <1812355.tdWV9SEqCh@natalenko.name>
 <f88ca616-96d1-82dc-1bc8-b17480e937dd@arm.com>
 <20220324055732.GB12078@lst.de> <4386660.LvFx2qVVIh@natalenko.name>
 <81ffc753-72aa-6327-b87b-3f11915f2549@arm.com> <878rsza0ih.fsf@toke.dk>
 <4be26f5d8725cdb016c6fdd9d05cfeb69cdd9e09.camel@freebox.fr>
 <20220324163132.GB26098@lst.de>
 <d8a1cbf4-a521-78ec-1560-28d855e0913e@arm.com> <871qyr9t4e.fsf@toke.dk>
 <CAHk-=whUQCCaQXJt3KUeQ8mtnLeVXEScNXCp+_DYh2SNY7EcEA@mail.gmail.com>
 <31434708dcad126a8334c99ee056dcce93e507f1.camel@freebox.fr>
 <87a6de80em.fsf@toke.dk> <f4224721-4578-61d3-69a7-9a3a76c50529@arm.com>
Date: Fri, 25 Mar 2022 19:13:49 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <871qyp99ya.fsf@toke.dk>
MIME-Version: 1.0
Cc: Netdev <netdev@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Oleksandr Natalenko <oleksandr@natalenko.name>,
 stable <stable@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Halil Pasic <pasic@linux.ibm.com>, iommu <iommu@lists.linux-foundation.org>,
 Olha Cherevyk <olha.cherevyk@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Christoph Hellwig <hch@lst.de>,
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

Um9iaW4gTXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4gd3JpdGVzOgoKPiBPbiAyMDIyLTAz
LTI1IDE2OjI1LCBUb2tlIEjDuGlsYW5kLUrDuHJnZW5zZW4gd3JvdGU6Cj4+IE1heGltZSBCaXpv
biA8bWJpem9uQGZyZWVib3guZnI+IHdyaXRlczoKPj4gCj4+PiBPbiBUaHUsIDIwMjItMDMtMjQg
YXQgMTI6MjYgLTA3MDAsIExpbnVzIFRvcnZhbGRzIHdyb3RlOgo+Pj4KPj4+Pgo+Pj4+IEl0J3Mg
YWN0dWFsbHkgdmVyeSBuYXR1cmFsIGluIHRoYXQgc2l0dWF0aW9uIHRvIGZsdXNoIHRoZSBjYWNo
ZXMgZnJvbQo+Pj4+IHRoZSBDUFUgc2lkZSBhZ2Fpbi4gQW5kIHNvIGRtYV9zeW5jX3NpbmdsZV9m
b3JfZGV2aWNlKCkgaXMgYSBmYWlybHkKPj4+PiByZWFzb25hYmxlIHRoaW5nIHRvIGRvIGluIHRo
YXQgc2l0dWF0aW9uLgo+Pj4+Cj4+Pgo+Pj4gSW4gdGhlIG5vbi1jYWNoZS1jb2hlcmVudCBzY2Vu
YXJpbywgYW5kIGFzc3VtaW5nIGRtYV9tYXAoKSBkaWQgYW4KPj4+IGluaXRpYWwgY2FjaGUgaW52
YWxpZGF0aW9uLCB5b3UgY2FuIHdyaXRlIHRoaXM6Cj4+Pgo+Pj4gcnhfYnVmZmVyX2NvbXBsZXRl
XzEoYnVmKQo+Pj4gewo+Pj4gCWludmFsaWRhdGVfY2FjaGUoYnVmLCBzaXplKQo+Pj4gCWlmICgh
aXNfcmVhZHkoYnVmKSkKPj4+IAkJcmV0dXJuOwo+Pj4gCTxwcm9jZWVkIHdpdGggcmVjZWl2ZT4K
Pj4+IH0KPj4+Cj4+PiBvcgo+Pj4KPj4+IHJ4X2J1ZmZlcl9jb21wbGV0ZV8yKGJ1ZikKPj4+IHsK
Pj4+IAlpZiAoIWlzX3JlYWR5KGJ1ZikpIHsKPj4+IAkJaW52YWxpZGF0ZV9jYWNoZShidWYsIHNp
emUpCj4+PiAJCXJldHVybjsKPj4+IAl9Cj4+PiAJPHByb2NlZWQgd2l0aCByZWNlaXZlPgo+Pj4g
fQo+Pj4KPj4+IFRoZSBsYXR0ZXIgaXMgcHJlZmVycmVkIGZvciBwZXJmb3JtYW5jZSBiZWNhdXNl
IGRtYV9tYXAoKSBkaWQgdGhlCj4+PiBpbml0aWFsIGludmFsaWRhdGUuCj4+Pgo+Pj4gT2YgY291
cnNlIHlvdSBjb3VsZCB3cml0ZToKPj4+Cj4+PiByeF9idWZmZXJfY29tcGxldGVfMyhidWYpCj4+
PiB7Cj4+PiAJaW52YWxpZGF0ZV9jYWNoZShidWYsIHNpemUpCj4+PiAJaWYKPj4+ICghaXNfcmVh
ZHkoYnVmKSkgewo+Pj4gCQlpbnZhbGlkYXRlX2NhY2hlKGJ1Ziwgc2l6ZSkKPj4+IAkJcmV0dXJu
Owo+Pj4gCX0KPj4+IAkKPj4+IDxwcm9jZWVkIHdpdGggcmVjZWl2ZT4KPj4+IH0KPj4+Cj4+Pgo+
Pj4gYnV0IGl0J3MgYSB3YXN0ZSBvZiBDUFUgY3ljbGVzCj4+Pgo+Pj4gU28gSSdkIGJlIHZlcnkg
Y2F1dGlvdXMgYXNzdW1pbmcgc3luY19mb3JfY3B1KCkgYW5kIHN5bmNfZm9yX2RldmljZSgpCj4+
PiBhcmUgYm90aCBkb2luZyBpbnZhbGlkYXRpb24gaW4gZXhpc3RpbmcgaW1wbGVtZW50YXRpb24g
b2YgYXJjaCBETUEgb3BzLAo+Pj4gaW1wbGVtZW50ZXJzIG1heSBoYXZlIHRha2VuIHNvbWUgbGli
ZXJ0eSBhcm91bmQgRE1BLUFQSSB0byBhdm9pZAo+Pj4gdW5uZWNlc3NhcnkgY2FjaGUgb3BlcmF0
aW9uIChub3QgdG8gYmxhbWUgdGhlbSkuCj4+IAo+PiBJIHNlbnNlIGFuIGltcGxpY2l0ICJhbmQg
dGhlIGRyaXZlciBjYW4ndCAob3Igc2hvdWxkbid0KSBpbmZsdWVuY2UKPj4gdGhpcyIgaGVyZSwg
cmlnaHQ/Cj4KPiBSaWdodCwgZHJpdmVycyBkb24ndCBnZXQgYSBjaG9pY2Ugb2YgaG93IGEgZ2l2
ZW4gRE1BIEFQSSBpbXBsZW1lbnRhdGlvbiAKPiB3b3Jrcy4KPgo+Pj4gRm9yIGV4YW1wbGUgbG9v
a2luZyBhdCBhcmNoL2FybS9tbS9kbWEtbWFwcGluZy5jLCBmb3IgRE1BX0ZST01fREVWSUNFCj4+
Pgo+Pj4gc3luY19zaW5nbGVfZm9yX2RldmljZSgpCj4+PiAgICA9PiBfX2RtYV9wYWdlX2NwdV90
b19kZXYoKQo+Pj4gICAgICA9PiBkbWFfY2FjaGVfbWFpbnRfcGFnZShvcD1kbWFjX21hcF9hcmVh
KQo+Pj4gICAgICAgID0+IGNwdV9jYWNoZS5kbWFfbWFwX2FyZWEoKQo+Pj4KPj4+IHN5bmNfc2lu
Z2xlX2Zvcl9jcHUoKQo+Pj4gICAgPT4gX19kbWFfcGFnZV9kZXZfdG9fY3B1KCkKPj4+ICAgICAg
PT4KPj4+IF9fZG1hX3BhZ2VfY3B1X3RvX2RldihvcD1kbWFjX3VubWFwX2FyZWEpCj4+PiAgICAg
ICAgPT4KPj4+IGNwdV9jYWNoZS5kbWFfdW5tYXBfYXJlYSgpCj4+Pgo+Pj4gZG1hX21hcF9hcmVh
KCkgYWx3YXlzIGRvZXMgY2FjaGUgaW52YWxpZGF0ZS4KPj4+Cj4+PiBCdXQgZm9yIGEgY291cGxl
IG9mIENQVSB2YXJpYW50LCBkbWFfdW5tYXBfYXJlYSgpIGlzIGEgbm9vcCwgc28KPj4+IHN5bmNf
Zm9yX2NwdSgpIGRvZXMgbm90aGluZy4KPj4+Cj4+PiBUb2tlJ3MgcGF0Y2ggd2lsbCBicmVhayBh
dGg5ayBvbiB0aG9zZSBwbGF0Zm9ybXMgKG1vc3RseSBzaWxlbnQKPj4+IGJyZWFrYWdlLCByeCBj
b3JydXB0aW9uIGxlYWRpbmcgdG8gYmFkIHBlcmZvcm1hbmNlKQo+PiAKPj4gT2theSwgc28gdGhh
dCB3b3VsZCBiZSBiYWQgb2J2aW91c2x5LiBTbyBpZiBJJ20gcmVhZGluZyB5b3UgY29ycmVjdGx5
Cj4+IChjZiBteSBxdWVzdGlvbiBhYm92ZSksIHdlIGNhbid0IGZpeCB0aGlzIHByb3Blcmx5IGZy
b20gdGhlIGRyaXZlciBzaWRlLAo+PiBhbmQgd2Ugc2hvdWxkIGdvIHdpdGggdGhlIHBhcnRpYWwg
U1dJT1RMQiByZXZlcnQgaW5zdGVhZD8KPgo+IERvIHlvdSBoYXZlIGFueSBvdGhlciB3YXkgb2Yg
dGVsbGluZyBpZiBETUEgaXMgaWRsZSwgb3IgdGVtcG9yYXJpbHkKPiBwYXVzaW5nIGl0IGJlZm9y
ZSB0aGUgc3luY19mb3JfY3B1LCBzdWNoIHRoYXQgeW91IGNvdWxkIGhvbm91ciB0aGUKPiBub3Rp
b24gb2Ygb3duZXJzaGlwIHRyYW5zZmVyIHByb3Blcmx5PwoKSSdsbCBnbyBjaGVjayB3aXRoIHNv
bWVvbmUgd2hvIGhhcyBhIGJldHRlciBncmFzcCBvZiBob3cgdGhlIGhhcmR3YXJlCndvcmtzLCBi
dXQgSSBkb24ndCB0aGluayBzby4uLgoKPiBBcyBtZW50aW9uZWQgZWxzZXdoZXJlIEkgc3VzcGVj
dCB0aGUgb25seSAicmVhbCIgZml4IGlmIHlvdSByZWFsbHkgZG8KPiBuZWVkIHRvIGFsbG93IGNv
bmN1cnJlbnQgYWNjZXNzIGlzIHRvIHVzZSB0aGUgY29oZXJlbnQgRE1BIEFQSSBmb3IKPiBidWZm
ZXJzIHJhdGhlciB0aGFuIHN0cmVhbWluZyBtYXBwaW5ncywgYnV0IHRoYXQncyBvYnZpb3VzbHkg
c29tZSBmYXIKPiBtb3JlIHNpZ25pZmljYW50IHN1cmdlcnkuCgpUaGF0IHdvdWxkIGltcGx5IGNv
cHlpbmcgdGhlIHBhY2tldCBkYXRhIG91dCBvZiB0aGF0IChwZXJzaXN0ZW50KQpjb2hlcmVudCBt
YXBwaW5nIGVhY2ggdGltZSB3ZSBkbyBhIHJlY3Ygb3BlcmF0aW9uLCB0aG91Z2gsIHJpZ2h0PyBU
aGF0CndvdWxkIGJlIHF1aXRlIGEgcGVyZm9ybWFuY2UgaGl0Li4uCgpJZiBhbGwgd2UgbmVlZCBp
cyBhIHdheSB0byBtYWtlIGRtYV9zeW5jX3NpbmdsZV9mb3JfY3B1KCkgZ3VhcmFudGVlIGEKY2Fj
aGUgaW52YWxpZGF0aW9uLCB3aHkgY2FuJ3Qgd2UganVzdCBhZGQgYSBzZXBhcmF0ZSB2ZXJzaW9u
IHRoYXQgZG9lcwp0aGF0IChkbWFfc3luY19zaW5nbGVfZm9yX2NwdV9wZWVrKCkgb3Igc29tZXRo
aW5nKT8gVXNpbmcgdGhhdCB3aXRoIHRoZQpwYXRjaCBJIHBvc3RlZCBlYXJsaWVyIHNob3VsZCBi
ZSBlbm91Z2ggdG8gcmVzb2x2ZSB0aGUgaXNzdWUsIEFGQUlDVD8KCi1Ub2tlCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdApp
b21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
