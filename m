Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE7CC433EF
	for <iommu@archiver.kernel.org>; Thu, 24 Mar 2022 08:55:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B93EE60ACC;
	Thu, 24 Mar 2022 08:55:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3Bspqe3t-v4K; Thu, 24 Mar 2022 08:55:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 98ABA60A79;
	Thu, 24 Mar 2022 08:55:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F0DFC001A;
	Thu, 24 Mar 2022 08:55:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97F9FC000B
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 08:55:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 77498843B5
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 08:55:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=natalenko.name
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6wO6kzO8Ndz2 for <iommu@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 08:55:53 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from vulcan.natalenko.name (vulcan.natalenko.name
 [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 459C184325
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 08:55:52 +0000 (UTC)
Received: from spock.localnet (unknown [83.148.33.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by vulcan.natalenko.name (Postfix) with ESMTPSA id BB8B5E491E9;
 Thu, 24 Mar 2022 09:55:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
 s=dkim-20170712; t=1648112146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S+woDWFZcPgqPY0chl6IjyANJVAaopdil00T5QCbF7E=;
 b=InO0yzyZU3QaeY3J8ths/cL9YOwpfDv9uIL616GmIlQRjsvz8ItHOgN2zT40/Y8FWsRSgP
 Kppy0V5Ft8HOz3rqo4NleRyvSAa1mMIR41RFSwE19LDUNek97TyGDRKmKZeaTpkkovO202
 1p5wkp/jtBk8rE5/zx6jClPW0qttBkQ=
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [REGRESSION] Recent swiotlb DMA_FROM_DEVICE fixes break
 ath9k-based AP
Date: Thu, 24 Mar 2022 09:55:44 +0100
Message-ID: <5806580.lOV4Wx5bFT@natalenko.name>
In-Reply-To: <CAHk-=wiwz+Z2MaP44h086jeniG-OpK3c=FywLsCwXV7Crvadrg@mail.gmail.com>
References: <1812355.tdWV9SEqCh@natalenko.name>
 <CAHk-=wiwz+Z2MaP44h086jeniG-OpK3c=FywLsCwXV7Crvadrg@mail.gmail.com>
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

SGVsbG8uCgpPbiBzdMWZZWRhIDIzLiBixZllem5hIDIwMjIgMTg6Mjc6MjEgQ0VUIExpbnVzIFRv
cnZhbGRzIHdyb3RlOgo+IE9uIFdlZCwgTWFyIDIzLCAyMDIyIGF0IDEyOjE5IEFNIE9sZWtzYW5k
ciBOYXRhbGVua28KPiA8b2xla3NhbmRyQG5hdGFsZW5rby5uYW1lPiB3cm90ZToKPiA+IFRoZXNl
IGNvbW1pdHMgYXBwZWFyZWQgaW4gdjUuMTcgYW5kIHY1LjE2LjE1LCBhbmQgYm90aCBrZXJuZWxz
IGFyZQo+ID4gYnJva2VuIGZvciBtZS4gSSdtIHByZXR0eSBjb25maWRlbnQgdGhlc2UgY29tbWl0
cyBtYWtlIHRoZSBkaWZmZXJlbmNlCj4gPiBzaW5jZSBJJ3ZlIGJ1aWx0IGJvdGggdjUuMTcgYW5k
IHY1LjE2LjE1IHdpdGhvdXQgdGhlbSwgYW5kIGl0IGZpeGVkCj4gPiB0aGUgaXNzdWUuCj4gCj4g
Q2FuIHlvdSBkb3VibGUtY2hlY2sgKG9yIGp1c3QgZXhwbGljaXRseSBjb25maXJtIGlmIHlvdSBh
bHJlYWR5IGRpZAo+IHRoYXQgdGVzdCkgdGhhdCB5b3UgbmVlZCB0byByZXZlcnQgKmJvdGgqIG9m
IHRob3NlIGNvbW1pdHMsIGFuZCBpdCdzCj4gdGhlIGxhdGVyICJyZXdvcmsiIGZpeCB0aGF0IHRy
aWdnZXJzIGl0PwoKSSBjYW4gY29uZmlybSB0aGF0IGlmIEkgcmV2ZXJ0IGFhNmY4ZGNiYWI0NyBv
bmx5LCBidXQgbGVhdmUgZGRiZDg5ZGViN2QzIGluIHBsYWNlLCBBUCB3b3Jrcy4gU28sIGl0IHNl
ZW1zIHRoYXQgdGhlIGxhdGVzdCAicmV3b3JrIiB0cmlnZ2VycyB0aGUgaXNzdWUgZm9yIG1lLgoK
VGhhbmtzLgoKLS0gCk9sZWtzYW5kciBOYXRhbGVua28gKHBvc3QtZmFjdHVtKQoKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlz
dAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
