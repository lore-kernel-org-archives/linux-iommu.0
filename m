Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA8BC433F5
	for <iommu@archiver.kernel.org>; Fri, 25 Mar 2022 19:35:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4926C40308;
	Fri, 25 Mar 2022 19:35:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qOfp5Hd1PQhN; Fri, 25 Mar 2022 19:35:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2EDB840271;
	Fri, 25 Mar 2022 19:35:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EDD1BC001D;
	Fri, 25 Mar 2022 19:35:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CAE5DC0012
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 19:35:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B94E36076A
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 19:35:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=natalenko.name
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HtyZGMVlg9hc for <iommu@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 19:35:46 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from vulcan.natalenko.name (vulcan.natalenko.name
 [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 29AE260759
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 19:35:45 +0000 (UTC)
Received: from spock.localnet (unknown [83.148.33.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by vulcan.natalenko.name (Postfix) with ESMTPSA id 41693E4E0DF;
 Fri, 25 Mar 2022 20:35:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
 s=dkim-20170712; t=1648236939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rLBMSUPo6jXDs4paj/eaDyrCRojZ9mFIvvnloZAG8yk=;
 b=HUri9bxCSlCyLJBpNkF4S2td2orUeRbu4l9z0J7Xc9HyZ3cTxDHCexUPIjSPSVKHAxd0mQ
 eQqW/2wjFoLwJYc7WDKU32po5DIGbENZn/lgaQvSZ/smVjpzYo1MRMfVsmMNRcsr6NANnJ
 4ibaaxojQmf/jlSzVt/jSOoWS3lQYjI=
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [REGRESSION] Recent swiotlb DMA_FROM_DEVICE fixes break
 ath9k-based AP
Date: Fri, 25 Mar 2022 20:35:37 +0100
Message-ID: <8043549.T7Z3S40VBb@natalenko.name>
In-Reply-To: <CAHk-=wghZ3c4G2xjy3pR7txmdCnau21z_tidjfU2w0HO-90=sw@mail.gmail.com>
References: <1812355.tdWV9SEqCh@natalenko.name>
 <12981608.uLZWGnKmhe@natalenko.name>
 <CAHk-=wghZ3c4G2xjy3pR7txmdCnau21z_tidjfU2w0HO-90=sw@mail.gmail.com>
MIME-Version: 1.0
Cc: Toke =?ISO-8859-1?Q?H=F8iland=2DJ=F8rgensen?= <toke@toke.dk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Netdev <netdev@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 stable <stable@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Halil Pasic <pasic@linux.ibm.com>, iommu <iommu@lists.linux-foundation.org>,
 Olha Cherevyk <olha.cherevyk@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Maxime Bizon <mbizon@freebox.fr>, Paolo Abeni <pabeni@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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
From: Oleksandr Natalenko via iommu <iommu@lists.linux-foundation.org>
Reply-To: Oleksandr Natalenko <oleksandr@natalenko.name>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gcMOhdGVrIDI1LiBixZllem5hIDIwMjIgMjA6Mjc6NDMgQ0VUIExpbnVzIFRvcnZhbGRzIHdy
b3RlOgo+IE9uIEZyaSwgTWFyIDI1LCAyMDIyIGF0IDEyOjI2IFBNIE9sZWtzYW5kciBOYXRhbGVu
a28KPiA8b2xla3NhbmRyQG5hdGFsZW5rby5uYW1lPiB3cm90ZToKPiA+Cj4gPiBPbiBww6F0ZWsg
MjUuIGLFmWV6bmEgMjAyMiAxOTozMDoyMSBDRVQgTGludXMgVG9ydmFsZHMgd3JvdGU6Cj4gPiA+
IFRoZSByZWFzb24gdGhlIGF0aDlrIGlzc3VlIHdhcyBmb3VuZCBxdWlja2x5Cj4gPiA+IGlzIHZl
cnkgbGlrZWx5ICpOT1QqIGJlY2F1c2UgYXRoOWsgaXMgdGhlIG9ubHkgdGhpbmcgYWZmZWN0ZWQu
IE5vLAo+ID4gPiBpdCdzIGJlY2F1c2UgYXRoOWsgaXMgcmVsYXRpdmVseSBjb21tb24uCj4gPgo+
ID4gSW5kZWVkLiBCdXQgaGF2aW5nIGEgd2lmZSB3aG8gY29tcGxhaW5zIGFib3V0IG5vbi13b3Jr
aW5nIFdpLUZpIHByaW50ZXIgZGVmaW5pdGVseSBoZWxwcyBpbiBmaW5kaW5nIHRoZSBpc3N1ZSB0
b28uCj4gCj4gV2VsbCwgbWF5YmUgd2Ugc2hvdWxkIGNyZWRpdCBoZXIgaW4gdGhlIGV2ZW50dWFs
IHJlc29sdXRpb24gKHdoYXRldmVyCj4gaXQgZW5kcyB1cCBiZWluZykuCj4gCj4gQWx0aG91Z2gg
cHJvYmFibHkgbm90IHVzaW5nIHRoYXQgZXhhY3Qgd29yZGluZy4KCldoaWxlIE9saGEgaGFzIGFs
cmVhZHkgYmVlbiBDYydlZCBoZXJlLCBJIGNhbiBkZWZpbml0ZWx5IGVuY291cmFnZSBoZXIgaW4g
cGVyc29uIHRvIHByb3ZpZGUgUmVwb3J0ZWQtYnkvVGVzdGVkLWJ5IGlmIG5lZWRlZCA6KS4KCi0t
IApPbGVrc2FuZHIgTmF0YWxlbmtvIChwb3N0LWZhY3R1bSkKCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vaW9tbXU=
