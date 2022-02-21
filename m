Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 127CCC43219
	for <iommu@archiver.kernel.org>; Mon, 21 Feb 2022 11:44:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C14A760E35;
	Mon, 21 Feb 2022 11:44:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tFP9ldo_WxFZ; Mon, 21 Feb 2022 11:44:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AE7F060AD2;
	Mon, 21 Feb 2022 11:44:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89C17C001A;
	Mon, 21 Feb 2022 11:44:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF7C1C0011
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 11:44:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DAF2D4025F
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 11:44:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kapsi.fi
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id agrA8f7B_kGA for <iommu@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 11:44:39 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3E9EB4022A
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 11:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
 s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1NO9ODjqcIpFwr4c+SwXrmtjZPwEE+Ho+Rm0iiAPZyk=; b=ltlJ6oqpzZfDZZpM5E7jwuYZYf
 LKiDxa/KysRWN/yC3XV7t7SitKMQav4x0qO1o2l8kSprsgH6uINegAmPkius7bdHj7KdhmZDFs1Oy
 vhgS4ZQPTX4aIo5snwtlgLJDeK8HIKg1HSmupKaUjCEsJnY6Ycmqua69rHfV3DpT+wfDZfEE5UT4u
 2Ldu99oOnoZGcCuZf4pL/Pq3NYuFJQcjGdOASfTw1Fa1c6LpnWdZRAhzYQFrybMVRcvlskFF47ka3
 0BC3ydM6R61myM7Hl9uU8MA6hAmv9Rd2ssw1DibR7BjdRnKyC8vQ5oKyrwzjroyUYsO/ta3aQEWCk
 6Lw+KhBA==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70]
 helo=[192.168.1.10])
 by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.89) (envelope-from <cyndis@kapsi.fi>)
 id 1nM77D-0004LU-51; Mon, 21 Feb 2022 13:44:27 +0200
Message-ID: <5d1b6e82-2c9d-8388-697f-0d7305a1206f@kapsi.fi>
Date: Mon, 21 Feb 2022 13:44:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v3 8/9] drm/tegra: vic: Implement get_streamid_offset
Content-Language: en-US
To: Dmitry Osipenko <digetx@gmail.com>,
 Mikko Perttunen <mperttunen@nvidia.com>, thierry.reding@gmail.com,
 jonathanh@nvidia.com, joro@8bytes.org, will@kernel.org, robh+dt@kernel.org,
 robin.murphy@arm.com
References: <20220218113952.3077606-1-mperttunen@nvidia.com>
 <20220218113952.3077606-9-mperttunen@nvidia.com>
 <b1df816b-6838-c435-1a23-5029144e4cfe@gmail.com>
 <7f4e4c47-59f1-1def-36bf-a2ded912f76d@gmail.com>
From: Mikko Perttunen <cyndis@kapsi.fi>
In-Reply-To: <7f4e4c47-59f1-1def-36bf-a2ded912f76d@gmail.com>
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

T24gMi8xOS8yMiAyMDo1NCwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+IDE5LjAyLjIwMjIgMjE6
NDksIERtaXRyeSBPc2lwZW5rbyDQv9C40YjQtdGCOgo+PiAxOC4wMi4yMDIyIDE0OjM5LCBNaWtr
byBQZXJ0dHVuZW4g0L/QuNGI0LXRgjoKPj4+ICtzdGF0aWMgaW50IHZpY19nZXRfc3RyZWFtaWRf
b2Zmc2V0KHN0cnVjdCB0ZWdyYV9kcm1fY2xpZW50ICpjbGllbnQpCj4+PiArewo+Pj4gKwlzdHJ1
Y3QgdmljICp2aWMgPSB0b192aWMoY2xpZW50KTsKPj4+ICsJaW50IGVycjsKPj4+ICsKPj4+ICsJ
ZXJyID0gdmljX2xvYWRfZmlybXdhcmUodmljKTsKPj4KPj4gWW91IGNhbid0IGludm9rZSB2aWNf
bG9hZF9maXJtd2FyZSgpIHdoaWxlIFJQTSBpcyBzdXNwZW5kZWQuIEVpdGhlcgo+PiByZXBsYWNl
IHRoaXMgd2l0aCBSUE0gZ2V0L3B1dCBvciBkbyBzb21ldGhpbmcgZWxzZS4KCldoeSBub3QsIEkn
bSBub3Qgc2VlaW5nIGFueSBIVyBhY2Nlc3NlcyBpbiB2aWNfbG9hZF9maXJtd2FyZT8gQWx0aG91
Z2ggCml0IGxvb2tzIGxpa2UgaXQgbWlnaHQgcmFjZSB3aXRoIHRoZSB2aWNfbG9hZF9maXJtd2Fy
ZSBjYWxsIGluIAp2aWNfcnVudGltZV9yZXN1bWUgd2hpY2ggcHJvYmFibHkgbmVlZHMgdG8gYmUg
Zml4ZWQuCgo+Pgo+Pj4gKwlpZiAoZXJyIDwgMCkKPj4+ICsJCXJldHVybiBlcnI7Cj4+PiArCj4+
PiArCWlmICh2aWMtPmNhbl91c2VfY29udGV4dCkKPj4+ICsJCXJldHVybiAweDMwOwo+Pj4gKwll
bHNlCj4+PiArCQlyZXR1cm4gLUVOT1RTVVBQOwo+Pgo+PiBJZiAoIXZpYy0+Y2FuX3VzZV9jb250
ZXh0KQo+PiAJcmV0dXJuIC1FTk9UU1VQUDsKPj4KPj4gcmV0dXJuIDB4MzA7Cj4gCj4gYW5kIHMv
RU5PVFNVUFAvRU9QTk9UU1VQUC8KCk9rLgoKTWlra28KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2lvbW11
