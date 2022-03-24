Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E1C2C433EF
	for <iommu@archiver.kernel.org>; Thu, 24 Mar 2022 16:40:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2E3EC41C26;
	Thu, 24 Mar 2022 16:40:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lQAvGF7IqYqk; Thu, 24 Mar 2022 16:40:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 10A6E41C30;
	Thu, 24 Mar 2022 16:40:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD75DC0012;
	Thu, 24 Mar 2022 16:40:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1E0CBC000B
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 16:39:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EFEC460BB1
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 16:39:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C0uMLqyHInQ8 for <iommu@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 16:39:18 +0000 (UTC)
X-Greylist: delayed 00:10:03 by SQLgrey-1.8.0
Received: from ns.iliad.fr (ns.iliad.fr [212.27.33.1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6677260B0A
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 16:39:18 +0000 (UTC)
Received: from ns.iliad.fr (localhost [127.0.0.1])
 by ns.iliad.fr (Postfix) with ESMTP id 7668D208CF;
 Thu, 24 Mar 2022 17:29:12 +0100 (CET)
Received: from sakura (freebox.vlq16.iliad.fr [213.36.7.13])
 by ns.iliad.fr (Postfix) with ESMTP id 6FAA6208C9;
 Thu, 24 Mar 2022 17:29:12 +0100 (CET)
Message-ID: <4be26f5d8725cdb016c6fdd9d05cfeb69cdd9e09.camel@freebox.fr>
Subject: Re: [REGRESSION] Recent swiotlb DMA_FROM_DEVICE fixes break
 ath9k-based AP
From: Maxime Bizon <mbizon@freebox.fr>
To: Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>, Robin Murphy
 <robin.murphy@arm.com>, Oleksandr Natalenko <oleksandr@natalenko.name>, 
 Christoph Hellwig <hch@lst.de>
Date: Thu, 24 Mar 2022 17:29:12 +0100
In-Reply-To: <878rsza0ih.fsf@toke.dk>
References: <1812355.tdWV9SEqCh@natalenko.name>
 <f88ca616-96d1-82dc-1bc8-b17480e937dd@arm.com>
 <20220324055732.GB12078@lst.de> <4386660.LvFx2qVVIh@natalenko.name>
 <81ffc753-72aa-6327-b87b-3f11915f2549@arm.com> <878rsza0ih.fsf@toke.dk>
Organization: Freebox
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ;
 Thu Mar 24 17:29:12 2022 +0100 (CET)
X-Mailman-Approved-At: Thu, 24 Mar 2022 16:40:06 +0000
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
Reply-To: mbizon@freebox.fr
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Ck9uIFRodSwgMjAyMi0wMy0yNCBhdCAxNToyNyArMDEwMCwgVG9rZSBIw7hpbGFuZC1Kw7hyZ2Vu
c2VuIHdyb3RlOgoKPiAKPiBJJ20gbG9va2luZyBpbnRvIHRoaXM7IGJ1dCBpbiB0aGUgaW50ZXJl
c3Qgb2YgYSBzcGVlZHkgcmVzb2x1dGlvbiBvZgo+IHRoZSByZWdyZXNzaW9uIEkgd291bGQgYmUg
aW4gZmF2b3VyIG9mIG1lcmdpbmcgdGhhdCBwYXJ0aWFsIHJldmVydAo+IGFuZCByZWluc3RhdGlu
ZyBpdCBpZi93aGVuIHdlIGlkZW50aWZ5IChhbmQgZml4KSBhbnkgYnVncyBpbiBhdGg5ayA6KQoK
VGhpcyBsb29rcyBmaXNoeToKCmF0aDlrL3JlY3YuYwoKICAgICAgICAgICAgICAgIC8qIFdlIHdp
bGwgbm93IGdpdmUgaGFyZHdhcmUgb3VyIHNoaW55IG5ldyBhbGxvY2F0ZWQgc2tiICovCiAgICAg
ICAgICAgICAgICBuZXdfYnVmX2FkZHIgPSBkbWFfbWFwX3NpbmdsZShzYy0+ZGV2LCByZXF1ZXVl
X3NrYi0+ZGF0YSwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGNvbW1vbi0+cnhfYnVmc2l6ZSwgZG1hX3R5cGUpOwogICAgICAgICAgICAgICAgaWYgKHVubGlr
ZWx5KGRtYV9tYXBwaW5nX2Vycm9yKHNjLT5kZXYsIG5ld19idWZfYWRkcikpKSB7CiAgICAgICAg
ICAgICAgICAgICAgICAgIGRldl9rZnJlZV9za2JfYW55KHJlcXVldWVfc2tiKTsKICAgICAgICAg
ICAgICAgICAgICAgICAgZ290byByZXF1ZXVlX2Ryb3BfZnJhZzsKICAgICAgICAgICAgICAgIH0K
CiAgICAgICAgICAgICAgICAvKiBVbm1hcCB0aGUgZnJhbWUgKi8KICAgICAgICAgICAgICAgIGRt
YV91bm1hcF9zaW5nbGUoc2MtPmRldiwgYmYtPmJmX2J1Zl9hZGRyLAogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBjb21tb24tPnJ4X2J1ZnNpemUsIGRtYV90eXBlKTsKCiAgICAgICAg
ICAgICAgICBiZi0+YmZfbXBkdSA9IHJlcXVldWVfc2tiOwogICAgICAgICAgICAgICAgYmYtPmJm
X2J1Zl9hZGRyID0gbmV3X2J1Zl9hZGRyOwoKLS0gCk1heGltZQoKCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVA
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
