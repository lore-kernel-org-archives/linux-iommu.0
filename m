Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3C84C433F5
	for <iommu@archiver.kernel.org>; Fri, 25 Mar 2022 19:26:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 93DA3415D9;
	Fri, 25 Mar 2022 19:26:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Hf0m6WyPBJzM; Fri, 25 Mar 2022 19:26:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BB51E41581;
	Fri, 25 Mar 2022 19:26:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89AB3C001D;
	Fri, 25 Mar 2022 19:26:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9EAB3C0012
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 19:26:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 953C3842E2
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 19:26:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=natalenko.name
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ul5SP3sppEN3 for <iommu@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 19:26:26 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from vulcan.natalenko.name (vulcan.natalenko.name
 [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6AABE842DF
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 19:26:25 +0000 (UTC)
Received: from spock.localnet (unknown [83.148.33.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by vulcan.natalenko.name (Postfix) with ESMTPSA id F322EE4E0AB;
 Fri, 25 Mar 2022 20:26:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
 s=dkim-20170712; t=1648236382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gkbNNfeNpPwe6UQ985hZPvn6dllNsvG00WrMvTQUIGI=;
 b=qytSP8fvTZGeblf/fJrh/9X4CD7KyWYpv5y6rjoU67VaEfcJ3Ydlb6dwojwD32wjzVVDfl
 s+Dv0Me0Om7d6cPBtCkFhFC3E1zyeBw/9bAyXDxPWlgwO8bHcblKXGz14vscA7y1cgJZTb
 SNNO2wV88E2F6dyekzSEbtvhTZFIL/U=
To: Maxime Bizon <mbizon@freebox.fr>,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [REGRESSION] Recent swiotlb DMA_FROM_DEVICE fixes break
 ath9k-based AP
Date: Fri, 25 Mar 2022 20:26:20 +0100
Message-ID: <12981608.uLZWGnKmhe@natalenko.name>
In-Reply-To: <CAHk-=wippum+MksdY7ixMfa3i1sZ+nxYPWLLpVMNyXCgmiHbBQ@mail.gmail.com>
References: <1812355.tdWV9SEqCh@natalenko.name>
 <31434708dcad126a8334c99ee056dcce93e507f1.camel@freebox.fr>
 <CAHk-=wippum+MksdY7ixMfa3i1sZ+nxYPWLLpVMNyXCgmiHbBQ@mail.gmail.com>
MIME-Version: 1.0
Cc: Toke =?ISO-8859-1?Q?H=F8iland=2DJ=F8rgensen?= <toke@toke.dk>,
 Netdev <netdev@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 stable <stable@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Halil Pasic <pasic@linux.ibm.com>, iommu <iommu@lists.linux-foundation.org>,
 Olha Cherevyk <olha.cherevyk@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
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

T24gcMOhdGVrIDI1LiBixZllem5hIDIwMjIgMTk6MzA6MjEgQ0VUIExpbnVzIFRvcnZhbGRzIHdy
b3RlOgo+IFRoZSByZWFzb24gdGhlIGF0aDlrIGlzc3VlIHdhcyBmb3VuZCBxdWlja2x5Cj4gaXMg
dmVyeSBsaWtlbHkgKk5PVCogYmVjYXVzZSBhdGg5ayBpcyB0aGUgb25seSB0aGluZyBhZmZlY3Rl
ZC4gTm8sCj4gaXQncyBiZWNhdXNlIGF0aDlrIGlzIHJlbGF0aXZlbHkgY29tbW9uLgoKSW5kZWVk
LiBCdXQgaGF2aW5nIGEgd2lmZSB3aG8gY29tcGxhaW5zIGFib3V0IG5vbi13b3JraW5nIFdpLUZp
IHByaW50ZXIgZGVmaW5pdGVseSBoZWxwcyBpbiBmaW5kaW5nIHRoZSBpc3N1ZSB0b28uCgotLSAK
T2xla3NhbmRyIE5hdGFsZW5rbyAocG9zdC1mYWN0dW0pCgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2lvbW11
