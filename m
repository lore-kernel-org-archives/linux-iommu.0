Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E954FC433EF
	for <iommu@archiver.kernel.org>; Mon, 21 Feb 2022 11:35:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8C58B408C5;
	Mon, 21 Feb 2022 11:35:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WvuGEmIroI6g; Mon, 21 Feb 2022 11:35:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4E81A408BF;
	Mon, 21 Feb 2022 11:35:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13426C001A;
	Mon, 21 Feb 2022 11:35:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37525C0011
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 11:35:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 33C9B60E1E
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 11:35:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kapsi.fi
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oVoATMyxBTNY for <iommu@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 11:35:50 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 098B260E17
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 11:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
 s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Sw0I/RylQnKI1uq0FibHj95obK9mnJQpn1pSKABNnu4=; b=gfg8U2QUAXfumrTD8Ej62KBdYt
 iK+1LPPtSoHp2VAEDWfEKsObDjwWMfI+Czo0lPkH4p6lHUhAuxPd9caqhTAAznjJ3A5fOvEvqbiQR
 L0FHlTx6FrJWU6NqoNCo2syRgLj7slWQaQujCc2K9yW/+gC5bzEhMaXq7vIHFTunnnku/WZXmtTuR
 v83CnecZ7mgL7pJaDxOdrS+ByyrKZVMRxQXQ6UvIeBSk7UKhZu7VEV1g7Y8G83O4FfoPYHHi1T94j
 LEIxcin8vZ/W14NsYg4JNUlgPSIiyJF0WjmkPD/k9X0HsElqZ/upiv6Es7KQHF21rinaUXL+byoJe
 m9ommXOQ==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70]
 helo=[192.168.1.10])
 by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.89) (envelope-from <cyndis@kapsi.fi>)
 id 1nM6yb-00021R-0w; Mon, 21 Feb 2022 13:35:33 +0200
Message-ID: <d30291a3-c1d1-5c7d-025f-03cd58eee1ab@kapsi.fi>
Date: Mon, 21 Feb 2022 13:35:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v3 3/9] gpu: host1x: Add context device management code
Content-Language: en-US
To: Dmitry Osipenko <digetx@gmail.com>,
 Mikko Perttunen <mperttunen@nvidia.com>, thierry.reding@gmail.com,
 jonathanh@nvidia.com, joro@8bytes.org, will@kernel.org, robh+dt@kernel.org,
 robin.murphy@arm.com
References: <20220218113952.3077606-1-mperttunen@nvidia.com>
 <20220218113952.3077606-4-mperttunen@nvidia.com>
 <149d4794-90fd-cde3-9d59-39e6488db679@gmail.com>
From: Mikko Perttunen <cyndis@kapsi.fi>
In-Reply-To: <149d4794-90fd-cde3-9d59-39e6488db679@gmail.com>
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

T24gMi8xOS8yMiAxOTo0OCwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+IDE4LjAyLjIwMjIgMTQ6
MzksIE1pa2tvIFBlcnR0dW5lbiDQv9C40YjQtdGCOgo+IC4uLgo+PiArLyoKPj4gKyAqIER1ZSB0
byBhbiBpc3N1ZSB3aXRoIFQxOTQgTlZFTkMsIG9ubHkgMzggYml0cyBjYW4gYmUgdXNlZC4KPj4g
KyAqIEFueXdheSwgMjU2R2lCIG9mIElPVkEgb3VnaHQgdG8gYmUgZW5vdWdoIGZvciBhbnlvbmUu
Cj4+ICsgKi8KPj4gK3N0YXRpYyBkbWFfYWRkcl90IGNvbnRleHRfZGV2aWNlX2RtYV9tYXNrID0g
RE1BX0JJVF9NQVNLKDM4KTsKPiAKPiBzL2RtYV9hZGRyX3QvdTY0LyA/IEFwcGFyZW50bHkgeW91
IHNob3VsZCBnZXQgY29tcGlsYXRpb24gd2FybmluZyBvbiBBUk0zMi4KPiAKPiBodHRwczovL2Vs
aXhpci5ib290bGluLmNvbS9saW51eC92NS4xNy1yYzQvc291cmNlL2luY2x1ZGUvbGludXgvZGV2
aWNlLmgjTDUyNCA+Cj4+ICtpbnQgaG9zdDF4X2NvbnRleHRfbGlzdF9pbml0KHN0cnVjdCBob3N0
MXggKmhvc3QxeCkKPj4gK3sKPj4gKwlzdHJ1Y3QgaG9zdDF4X2NvbnRleHRfbGlzdCAqY2RsID0g
Jmhvc3QxeC0+Y29udGV4dF9saXN0Owo+PiArCXN0cnVjdCBob3N0MXhfY29udGV4dCAqY3R4Owo+
PiArCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbm9kZTsKPj4gKwlpbnQgaW5kZXg7Cj4gCj4gTml0cGlj
azogdW5zaWduZWQgaW50Cj4gCj4gLi4uCj4+ICtkZWxfZGV2aWNlczoKPj4gKwl3aGlsZSAoLS1p
bmRleCA+PSAwKQo+IAo+IE5pdHBpY2s6IHdoaWxlIChpbmRleC0tKQo+IAo+IC4uLiA+PiArdm9p
ZCBob3N0MXhfY29udGV4dF9saXN0X2ZyZWUoc3RydWN0IGhvc3QxeF9jb250ZXh0X2xpc3QgKmNk
bCkKPj4gK3sKPj4gKwlpbnQgaTsKPiAKPiBOaXRwaWNrOiB1bnNpZ25lZCBpbnQKPiAKClRoYW5r
cywgZml4ZWQgYWxsLgoKTWlra28KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2lvbW11
