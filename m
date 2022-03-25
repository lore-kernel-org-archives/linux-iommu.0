Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D70C433F5
	for <iommu@archiver.kernel.org>; Fri, 25 Mar 2022 18:42:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 86A0B60BAA;
	Fri, 25 Mar 2022 18:42:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GJGCbX_s_i8O; Fri, 25 Mar 2022 18:42:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6D37360BB0;
	Fri, 25 Mar 2022 18:42:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43E02C002C;
	Fri, 25 Mar 2022 18:42:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 82D98C0012
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 18:42:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 71AA060BB0
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 18:42:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DEvtyKxmsLnD for <iommu@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 18:42:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id C52D160BAA
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 18:42:26 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1AF313D5;
 Fri, 25 Mar 2022 11:42:25 -0700 (PDT)
Received: from [10.57.41.19] (unknown [10.57.41.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F0FCD3F73D;
 Fri, 25 Mar 2022 11:42:22 -0700 (PDT)
Message-ID: <e077b229-c92b-c9a6-3581-61329c4b4a4b@arm.com>
Date: Fri, 25 Mar 2022 18:42:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [REGRESSION] Recent swiotlb DMA_FROM_DEVICE fixes break
 ath9k-based AP
Content-Language: en-GB
To: =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@toke.dk>,
 Christoph Hellwig <hch@lst.de>, Halil Pasic <pasic@linux.ibm.com>
References: <1812355.tdWV9SEqCh@natalenko.name>
 <CAHk-=wiwz+Z2MaP44h086jeniG-OpK3c=FywLsCwXV7Crvadrg@mail.gmail.com>
 <27b5a287-7a33-9a8b-ad6d-04746735fb0c@arm.com>
 <CAHk-=wip7TCD_+2STTepuEZvGMg6wcz+o=kyFUvHjuKziTMixw@mail.gmail.com>
 <f88ca616-96d1-82dc-1bc8-b17480e937dd@arm.com>
 <20220324190216.0efa067f.pasic@linux.ibm.com> <20220325163204.GB16426@lst.de>
 <87y20x7vaz.fsf@toke.dk>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <87y20x7vaz.fsf@toke.dk>
Cc: Netdev <netdev@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Oleksandr Natalenko <oleksandr@natalenko.name>,
 stable <stable@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gMjAyMi0wMy0yNSAxODoxNSwgVG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2VuIHdyb3RlOgo+IENo
cmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPiB3cml0ZXM6Cj4gCj4+IE9uIFRodSwgTWFyIDI0
LCAyMDIyIGF0IDA3OjAyOjE2UE0gKzAxMDAsIEhhbGlsIFBhc2ljIHdyb3RlOgo+Pj4+IElmCj4+
Pj4gZGRiZDg5ZGViN2QzIGFsb25lIHR1cm5zIG91dCB0byB3b3JrIE9LIHRoZW4gSSdkIGJlIGlu
Y2xpbmVkIHRvIHRyeSBhCj4+Pj4gcGFydGlhbCByZXZlcnQgb2YganVzdCB0aGF0IG9uZSBodW5r
Lgo+Pj4+Cj4+Pgo+Pj4gSSdtIG5vdCBhZ2FpbnN0IGJlaW5nIHByYWdtYXRpYyBhbmQgZG9pbmcg
dGhlIHBhcnRpYWwgcmV2ZXJ0LiBCdXQgYXMKPj4+IGV4cGxhaW5lZCBhYm92ZSwgSSBkbyBiZWxp
ZXZlIGZvciBjb3JyZWN0bmVzcyBvZiBzd2lvdGxiIHdlIHVsdGltYXRlbHkKPj4+IGRvIG5lZWQg
dGhhdCBjaGFuZ2UuIFNvIGlmIHRoZSByZXZlcnQgaXMgdGhlIHNob3J0IHRlcm0gc29sdXRpb24s
Cj4+PiB3aGF0IHNob3VsZCBiZSBvdXIgbWlkLXRlcm0gcm9hZC1tYXA/Cj4+Cj4+IFVubGVzcyBJ
J20gbWlzdW5kZXJzdGFuZGluZyB0aGlzIHRocmVhZCB3ZSBmb3VuZCB0aGUgYnVnIGluIGF0aDlr
Cj4+IGFuZCBoYXZlIGEgZml4IGZvciB0aGF0IG5vdz8KPiAKPiBBY2NvcmRpbmcgdG8gTWF4aW0n
cyBjb21tZW50IG9uIHRoZSBvdGhlciBzdWJ0aHJlYWQsIHRoYXQgYXRoOWsgcGF0Y2gKPiB3b3Vs
ZG4ndCB3b3JrIG9uIGFsbCBwbGF0Zm9ybXMgKGFuZCBjb25zdGl0dXRlcyBhIGJpdCBvZiBhIHZp
b2xhdGlvbiBvZgo+IHRoZSBETUEgQVBJIG93bmVyc2hpcCBhYnN0cmFjdGlvbikuIFNvIG5vdCBx
dWl0ZSwgSSB0aGluaz8KCkluZGVlZCwgaXQgd291bGQgcG90ZW50aWFsbHkgc3RhbmQgdG8gcG9z
ZSB0aGUgc2FtZSBwcm9ibGVtIGFzIHRoZSAKU1dJT1RMQiBjaGFuZ2UsIGJ1dCBvbiB0aGUgc2Nh
bGUgb2YgaW5kaXZpZHVhbCBjYWNoZSBsaW5lcyB0b3VjaGVkIGJ5IAphdGg5a19od19wcm9jZXNz
X3J4ZGVzY19lZG1hKCkgcmF0aGVyIHRoYW4gdGhlIHdob2xlIGJ1ZmZlci4gSG93ZXZlciwgCnRo
YXQgbWlnaHQgcmVwcmVzZW50IGEgbGVzcyBzZXZlcmUgaW1wYWN0IG9uIGEgc21hbGxlciBudW1i
ZXIgb2YgdXNlcnMgCihtYXliZSB0aGUgTUlQUyBzeXN0ZW1zPyBJJ20gbm90IHN1cmUuLi4pIHNv
IHBlcmhhcHMgaXQncyBhbiBhY2NlcHRhYmxlIAp0b3VybmlxdWV0PyBOb3RlIHRoYXQgdGhlIGN1
cnJlbnQgY29kZSBpcyBhbHJlYWR5IGEgdmlvbGF0aW9uIG9mIHRoZSBETUEgCkFQSSAoYmVjYXVz
ZSB0aGUgZGV2aWNlIGtlZXBzIHdyaXRpbmcgZXZlbiB3aGVuIGl0IGRvZXNuJ3QgaGF2ZSAKb3du
ZXJzaGlwKSwgc28gdGhlcmUncyBub3QgYSB2ZXJ5IHN0cm9uZyBhcmd1bWVudCBpbiB0aGF0IHJl
Z2FyZC4KClRoYW5rcywKUm9iaW4uCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by9pb21tdQ==
