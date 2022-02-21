Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F16F0C433EF
	for <iommu@archiver.kernel.org>; Mon, 21 Feb 2022 11:38:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 928DA60E1E;
	Mon, 21 Feb 2022 11:38:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2HTb7MXOXN0Z; Mon, 21 Feb 2022 11:38:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9274060E35;
	Mon, 21 Feb 2022 11:38:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77B56C001A;
	Mon, 21 Feb 2022 11:38:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 848CFC0011
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 11:38:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6244060E35
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 11:38:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eEJimowYscvE for <iommu@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 11:38:07 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C496960E33
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 11:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
 s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=k++dA0QZ/l0Udf5bpYqTGcUCwXaoUM28Erkwayg30Jc=; b=DjFpUsSjsqvQ/gdEZdw8Rwa5Qo
 9bXoOF1KTGBZPvp/rgZaf8yjzzKLP/CnTfXLXHxNahmNv+N3orhjP30d45zXNSyVNLdhnYAfKwb4Z
 RdZDWWyx5V+p2DZX1qChy8TvuoqPeByQau/37fzk1n2ruNUWTV+klAJ0okIv3AqAd/re6huAOP/Cs
 Z3al4naD7nxzxQhO5ec1AdRE8qA0HgbWtD/xEGMtJdjmIAer25KKsinCjvChQ/QbnHc9hgoI0UObV
 MtWELb4j25Syy6af3x6augoBrkrIZbIX1nPAE9ui+L3bLUFM7FwBo4yvzXLF5HNwa8VteE/Kid7IW
 ikdpDZ2A==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70]
 helo=[192.168.1.10])
 by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.89) (envelope-from <cyndis@kapsi.fi>)
 id 1nM70t-0002ZP-Mh; Mon, 21 Feb 2022 13:37:55 +0200
Message-ID: <8a1387e5-b68f-db90-9ab5-0b8606ca8841@kapsi.fi>
Date: Mon, 21 Feb 2022 13:37:54 +0200
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
 <2605a614-0a2c-85ac-576a-048f38f9d366@gmail.com>
From: Mikko Perttunen <cyndis@kapsi.fi>
In-Reply-To: <2605a614-0a2c-85ac-576a-048f38f9d366@gmail.com>
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

T24gMi8xOS8yMiAxOTo1MiwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+IDE4LjAyLjIwMjIgMTQ6
MzksIE1pa2tvIFBlcnR0dW5lbiDQv9C40YjQtdGCOgo+PiArCWZvciAoaW5kZXggPSAwOyBpbmRl
eCA8IGNkbC0+bGVuOyBpbmRleCsrKSB7Cj4+ICsJCXN0cnVjdCBpb21tdV9md3NwZWMgKmZ3c3Bl
YzsKPj4gKwo+PiArCQljdHggPSAmY2RsLT5kZXZzW2luZGV4XTsKPj4gKwo+PiArCQljdHgtPmhv
c3QgPSBob3N0MXg7Cj4+ICsKPj4gKwkJZGV2aWNlX2luaXRpYWxpemUoJmN0eC0+ZGV2KTsKPj4g
Kwo+PiArCQljdHgtPmRldi5kbWFfbWFzayA9ICZjb250ZXh0X2RldmljZV9kbWFfbWFzazsKPj4g
KwkJY3R4LT5kZXYuY29oZXJlbnRfZG1hX21hc2sgPSBjb250ZXh0X2RldmljZV9kbWFfbWFzazsK
Pj4gKwkJZGV2X3NldF9uYW1lKCZjdHgtPmRldiwgImhvc3QxeC1jdHguJWQiLCBpbmRleCk7Cj4+
ICsJCWN0eC0+ZGV2LmJ1cyA9ICZob3N0MXhfY29udGV4dF9kZXZpY2VfYnVzX3R5cGU7Cj4gCj4g
aG9zdDF4X2NvbnRleHRfZGV2aWNlX2J1c190eXBlIHdpbGwgYmUgYW4gdW5kZWZpbmVkIHN5bWJv
bCBpZgo+IENPTkZJR19URUdSQV9IT1NUMVhfQ09OVEVYVF9CVVM9bj8gUGxlYXNlIGNvbXBpbGUg
YW5kIHRlc3QgYWxsIGNvbWJpbmF0aW9ucy4KCkJ1dCB0aGlzIGZpbGUgaXMgb25seSBidWlsdCBp
ZiBDT05GSUdfSE9TVDFYLCB3aGljaCBzZWxlY3RzIApDT05GSUdfVEVHUkFfSE9TVDFYX0NPTlRF
WFRfQlVTPwoKTWlra28KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
