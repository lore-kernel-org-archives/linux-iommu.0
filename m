Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B15D1C433F5
	for <iommu@archiver.kernel.org>; Tue, 14 Dec 2021 14:53:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 417C960BCB;
	Tue, 14 Dec 2021 14:53:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H1qS5D3C6tEG; Tue, 14 Dec 2021 14:53:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 489E960BBF;
	Tue, 14 Dec 2021 14:53:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 140E5C001E;
	Tue, 14 Dec 2021 14:53:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D349FC0012
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 14:53:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B913740548
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 14:53:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kapsi.fi
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AhOoDcNsXX3m for <iommu@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 14:53:33 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A257740125
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 14:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
 s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QZYhNaGojIhkj+DE3EZypSilzYN2uhm80/kOdf1GbYA=; b=IlPN7dM2SThppX1r0UTulL/Isn
 e+U/mXVxY67CDVx82BzZ2uOGU/otApvyN6778DHwVP2o81j9E6zO+GGobSI5PUNjiaZj+46Tt5Tms
 zYQPfUcnELURQm0aXn2m7WzCu23wzd4oUxEXYZKcv5BgpjSsOIeRjsT8fg8Ynta/tOSyD6IeFZhxa
 nNmcRLipl3uuTZZmONO7kULsoXP+ShRwKgB6FmoswXmpUBbjRv+hZq32V48Y5BWDCLVJyU7k4HNoP
 drdGSCjfNFKpuEcDPHLq75GFb0MlmXDXY8aL2idfIcBmAldsRSH203JE1+Trc22VEgx3+p2j/HCEL
 gzMoJjIg==;
Received: from dsl-hkibng22-54f986-236.dhcp.inet.fi ([84.249.134.236]
 helo=[192.168.1.10])
 by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.89) (envelope-from <cyndis@kapsi.fi>)
 id 1mx9BB-0000zE-4A; Tue, 14 Dec 2021 16:53:21 +0200
Message-ID: <a62602df-91f6-783d-60f3-d9eba10da543@kapsi.fi>
Date: Tue, 14 Dec 2021 16:53:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 0/8] Host1x context isolation support
Content-Language: en-US
To: Dmitry Osipenko <digetx@gmail.com>, Jon Hunter <jonathanh@nvidia.com>,
 joro@8bytes.org, will@kernel.org, robh+dt@kernel.org, robin.murphy@arm.com,
 Mikko Perttunen <mperttunen@nvidia.com>
References: <20210916143302.2024933-1-mperttunen@nvidia.com>
 <10de82cf-27a5-8890-93a5-0e58c74e5bcc@kapsi.fi>
 <c382fb0e-6b73-5ca0-7f63-d2843351325e@nvidia.com>
 <91dddccd-a6c1-21b3-34d6-6a8082a386e7@nvidia.com>
 <a507b10b-395b-1f6d-87b9-7c7c436cab0e@gmail.com>
From: Mikko Perttunen <cyndis@kapsi.fi>
In-Reply-To: <a507b10b-395b-1f6d-87b9-7c7c436cab0e@gmail.com>
X-SA-Exim-Connect-IP: 84.249.134.236
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 thierry.reding@gmail.com, linux-tegra@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
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

T24gMTIvMTQvMjEgMTY6MzUsIERtaXRyeSBPc2lwZW5rbyB3cm90ZToKPiAxNC4xMi4yMDIxIDEx
OjA1LCBKb24gSHVudGVyINC/0LjRiNC10YI6Cj4+IEhpIGFsbCwKPj4KPj4gU3RpbGwgbm8gcmVz
cG9uc2Ugb24gdGhpcyA6LSgKPiAKPiBJIHNlZSBvbmx5IHR3byBwYXRjaGVzIG9uIFRlZ3JhIE1M
IGFuZCBvdGhlcnMgb24gRFJJIE1MLiBNaWdodCBiZSBnb29kCj4gdG8gc3RhcnQgd2l0aCByZS1z
ZW5kaW5nIHRoaXMgd2hvbGUgc2VyaWVzIGFuZCBDQ2luZyBNTHMgcHJvcGVybHkuCj4gCgpBbGwg
cGF0Y2hlcyBzaG91bGQgaGF2ZSBiZWVuIHNlbnQgdG8gdGhlIHNhbWUgc2V0IG9mIGFkZHJlc3Nl
cy4gQXQgbGVhc3QgCkxXTidzIGFyY2hpdmUgc2VlbXMgdG8gYWdyZWUuLgoKTWlra28KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBs
aXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
