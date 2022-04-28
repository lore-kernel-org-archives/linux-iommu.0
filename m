Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A7FBC433EF
	for <iommu@archiver.kernel.org>; Thu, 28 Apr 2022 05:35:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 62BD460AC9;
	Thu, 28 Apr 2022 05:35:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GrmHIogZzMA4; Thu, 28 Apr 2022 05:35:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 59CE1605BA;
	Thu, 28 Apr 2022 05:35:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3380DC0032;
	Thu, 28 Apr 2022 05:35:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DA07EC002D
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 05:35:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B952360AC9
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 05:35:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7u_Ny-Dyf9yP for <iommu@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 05:35:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0AF336066D
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 05:35:02 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id z99so4230375ede.5
 for <iommu@lists.linux-foundation.org>; Wed, 27 Apr 2022 22:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Q+eUJv9+G15IKxU6f/ds8z9ndhSiLJLYEEsP0KxbxHA=;
 b=ED+2Y6JfSdVUXkpMQIz27N8z4Q5f+APo0eGC7FPjO7L/C6/GDpmhoE4COt0l5gA7ge
 rH7ORahf3k4ZeKalAOKZmYX3t33EqRRDeOYe8Td09u4y7mGAtK+/BYl3i8Hyp6Qwx5HZ
 y7UN625BX4v8/r5BE/7EgXFTPS7T+FGcqiMARQHZcLrMtrIg3tG4UAbvbIJFWmgYFEAA
 AnR/gKZ78siMitch/BVJwDdJMd8e+ftMv/ojheDlyfufWsvfgPYZI49MIOdFVEZsg6FQ
 14VQSJ67DmT2bUWmAG95Yhl2tRx6nTeHMMA7n+3gT0Kk76W6QNFG2psxZZVM760BLUjs
 II2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Q+eUJv9+G15IKxU6f/ds8z9ndhSiLJLYEEsP0KxbxHA=;
 b=0WQUFjlwMvxB85HGiCuPPNAAWfb8HaKBQ5EQ12NWO5DgzsfEG6nFbjCt0B8kzgcd7v
 0W7wW7DRsPR7oGbyI7cNvYpyV3lenhnwlNAdsgQDJIq8xRaKeJ7hVvgNuMs2JSCOS6lr
 u6rKGII3NJH91dILz+Ua4ZlgqIvl1DAhuZ4cnIFV9yGv8ibfrlIectUfgCrKTABiWX2R
 30narU0tbXwPGaXOP8ns5pabodgFgv5expJHjQJy3UpLg+KUB9pcQ8a/Hgc8FBhxgEXw
 QMGjUrVDrwYbxan02zjFP6lk42/H/TdYu/Is01gcZM+bPVFRCbdKDDfLCXqqqEDmuRLG
 uMOg==
X-Gm-Message-State: AOAM531CdjyBWknIr5IzMU1oAsUOQmaiKbe1jvToiKKl/VQRyvDgU/zd
 Vmp0sOIqnN5JrJ831iBeOoc=
X-Google-Smtp-Source: ABdhPJwRmhqGmKmdzX4KIXgkDoCMGASyY4aGra++WokhDjLD8F+KBZu9SF1mTqE2Q+aZ9CJOKTHcUQ==
X-Received: by 2002:a05:6402:5106:b0:425:f733:8d9b with SMTP id
 m6-20020a056402510600b00425f7338d9bmr15264075edd.326.1651124101019; 
 Wed, 27 Apr 2022 22:35:01 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net.
 [89.212.118.115]) by smtp.gmail.com with ESMTPSA id
 s2-20020a1709066c8200b006e4e1b1f875sm7884833ejr.199.2022.04.27.22.34.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Apr 2022 22:35:00 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org, Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 4/5] iommu/sun50i: Add support for the D1 variant
Date: Thu, 28 Apr 2022 07:34:59 +0200
Message-ID: <2752686.88bMQJbFj6@jernej-laptop>
In-Reply-To: <20220428010401.11323-5-samuel@sholland.org>
References: <20220428010401.11323-1-samuel@sholland.org>
 <20220428010401.11323-5-samuel@sholland.org>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
 Samuel Holland <samuel@sholland.org>, linux-kernel@vger.kernel.org,
 Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-riscv@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

RG5lIMSNZXRydGVrLCAyOC4gYXByaWwgMjAyMiBvYiAwMzowMzo1OSBDRVNUIGplIFNhbXVlbCBI
b2xsYW5kIG5hcGlzYWwoYSk6Cj4gRDEgY29udGFpbnMgYW4gSU9NTVUgc2ltaWxhciB0byB0aGUg
b25lIGluIHRoZSBINiBTb0MsIGJ1dCB0aGUgRDEKPiB2YXJpYW50IGhhcyBubyBleHRlcm5hbCBy
ZXNldCBzaWduYWwuIEl0IGFsc28gaGFzIHNvbWUgcmVnaXN0ZXIKPiBkZWZpbml0aW9uIGNoYW5n
ZXMsIGJ1dCBub25lIHRoYXQgYWZmZWN0IHRoZSBjdXJyZW50IGRyaXZlci4KPiAKPiBTaWduZWQt
b2ZmLWJ5OiBTYW11ZWwgSG9sbGFuZCA8c2FtdWVsQHNob2xsYW5kLm9yZz4KClJldmlld2VkLWJ5
OiBKZXJuZWogU2tyYWJlYyA8amVybmVqLnNrcmFiZWNAZ21haWwuY29tPgoKQmVzdCByZWdhcmRz
LApKZXJuZWoKCj4gLS0tCj4gCj4gIGRyaXZlcnMvaW9tbXUvc3VuNTBpLWlvbW11LmMgfCA0ICsr
KysKPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2lvbW11L3N1bjUwaS1pb21tdS5jIGIvZHJpdmVycy9pb21tdS9zdW41MGktaW9tbXUu
Ywo+IGluZGV4IGI5ZTY0NGI5MzYzNy4uMWZiNzA3ZTM3ZmIzIDEwMDY0NAo+IC0tLSBhL2RyaXZl
cnMvaW9tbXUvc3VuNTBpLWlvbW11LmMKPiArKysgYi9kcml2ZXJzL2lvbW11L3N1bjUwaS1pb21t
dS5jCj4gQEAgLTk5OSwxMSArOTk5LDE1IEBAIHN0YXRpYyBpbnQgc3VuNTBpX2lvbW11X3Byb2Jl
KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UKPiAqcGRldikgcmV0dXJuIHJldDsKPiAgfQo+IAo+ICtz
dGF0aWMgY29uc3Qgc3RydWN0IHN1bjUwaV9pb21tdV92YXJpYW50IHN1bjIwaV9kMV9pb21tdSA9
IHsKPiArfTsKPiArCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc3VuNTBpX2lvbW11X3ZhcmlhbnQg
c3VuNTBpX2g2X2lvbW11ID0gewo+ICAJLmhhc19yZXNldCA9IHRydWUsCj4gIH07Cj4gCj4gIHN0
YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIHN1bjUwaV9pb21tdV9kdFtdID0gewo+ICsJ
eyAuY29tcGF0aWJsZSA9ICJhbGx3aW5uZXIsc3VuMjBpLWQxLWlvbW11IiwgLmRhdGEgPSAKJnN1
bjIwaV9kMV9pb21tdSB9LAo+ICAJeyAuY29tcGF0aWJsZSA9ICJhbGx3aW5uZXIsc3VuNTBpLWg2
LWlvbW11IiwgLmRhdGEgPSAKJnN1bjUwaV9oNl9pb21tdSB9LAo+ICAJeyAvKiBzZW50aW5lbCAq
LyB9LAo+ICB9OwoKCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
