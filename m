Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B52C433F5
	for <iommu@archiver.kernel.org>; Thu, 28 Apr 2022 05:35:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A19436066D;
	Thu, 28 Apr 2022 05:35:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dFq9UIT7F1CD; Thu, 28 Apr 2022 05:35:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 966BE605BA;
	Thu, 28 Apr 2022 05:35:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7A753C0032;
	Thu, 28 Apr 2022 05:35:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83D3EC002D
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 05:35:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7E898404F9
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 05:35:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HkltsAuxdMea for <iommu@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 05:35:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 46427404A3
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 05:35:28 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id y3so7278464ejo.12
 for <iommu@lists.linux-foundation.org>; Wed, 27 Apr 2022 22:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=n6GB1/WywBgvh+64+Tjj1z6mIuDmSgmvtpDpu9gTFhI=;
 b=Sk9QjBASR1ZDnIiWemIfYQHAyckj3WwUQ0Dk1x8vUbtZKw+Ps2RXC6ddu1yuaUfDpB
 gMi/A8uQw0hEu+F47+bjMp3t0QSCs67/abhdlEHByg/jPyQayH7pn4Niiz8YRh5dR/se
 xln6tUHCH2ERr0czmm5bEvYM2ukGDy9YomaBo1EqTSTx4xoNVJ08d1wBBXiam8xKQTnx
 m2eyYfCopyih6EYsIGG1jf7cGgoW/UdVQ6fuA03CTOCzsi1Xz/KgZtBjOu5G13Jw3OOq
 KE1LJORJpVZYpyh+W5+KQw59PhV/1nUPGPeM7fCd356wan6bL63d95Hnn1EfATYDBxWT
 v/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=n6GB1/WywBgvh+64+Tjj1z6mIuDmSgmvtpDpu9gTFhI=;
 b=HbRaFU4EWFrC5JbELnGR69xV8XXD43qG3TCQQwOM6Qjjbl692XlBG5LgG2i6iBNQOy
 BU7piVpMkCFAYCpV/a/uj9i4frKuSVzYbZcfdedOADVxfSQ6kOhtVUdyWzm6I1xtho4j
 ETl1jDSm8YW+fWNrGInrEYu/pSYUzerbH8R+oQuUEvjjrrV25firYqpZrpEeI5UZ55mB
 oxb9D9XG6JZx9tqTaUyOCCzd7Hb1MfGv/spoWyqmslz9+YJiEJEHYy1j0e8VxQ8TucZ0
 dTajSnrEuo6NXYJOkuLEGSj20esfj2/zIrKJQZnMbblPoYuiiKtvEZRaC1eogBarCN6W
 5fIw==
X-Gm-Message-State: AOAM530ToJdCz+VYLwIZeK0U7wGQZzgZGrvChSDBjkhUG2Ox90sHOFeD
 EJUdqUcPJMoRdN82OD2abGE=
X-Google-Smtp-Source: ABdhPJxOTXVpvT//Cj+0qyGctmcgG8tu4Sgrf5+zvtxXeIcbwKP79h4Ibc/zhuPFP2T8AkYgQw4Smw==
X-Received: by 2002:a17:907:72cd:b0:6f3:a068:a2ce with SMTP id
 du13-20020a17090772cd00b006f3a068a2cemr16041538ejc.563.1651124126336; 
 Wed, 27 Apr 2022 22:35:26 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net.
 [89.212.118.115]) by smtp.gmail.com with ESMTPSA id
 b6-20020aa7cd06000000b0042617ba63a9sm886885edw.51.2022.04.27.22.35.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Apr 2022 22:35:25 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org, Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 5/5] iommu/sun50i: Ensure the IOMMU can be used for DMA
Date: Thu, 28 Apr 2022 07:35:24 +0200
Message-ID: <1762951.8hzESeGDPO@jernej-laptop>
In-Reply-To: <20220428010401.11323-6-samuel@sholland.org>
References: <20220428010401.11323-1-samuel@sholland.org>
 <20220428010401.11323-6-samuel@sholland.org>
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

RG5lIMSNZXRydGVrLCAyOC4gYXByaWwgMjAyMiBvYiAwMzowNDowMCBDRVNUIGplIFNhbXVlbCBI
b2xsYW5kIG5hcGlzYWwoYSk6Cj4gU28gZmFyLCB0aGUgZHJpdmVyIGhhcyByZWxpZWQgb24gYXJj
aC9hcm02NC9LY29uZmlnIHRvIHNlbGVjdCBJT01NVV9ETUEuCj4gVW5zdXJwcmlzaW5nbHksIHRo
aXMgZG9lcyBub3Qgd29yayBvbiBSSVNDLVYsIHNvIHRoZSBkcml2ZXIgbXVzdCBzZWxlY3QKPiBJ
T01NVV9ETUEgaXRzZWxmLgo+IAo+IFNpZ25lZC1vZmYtYnk6IFNhbXVlbCBIb2xsYW5kIDxzYW11
ZWxAc2hvbGxhbmQub3JnPgoKUmV2aWV3ZWQtYnk6IEplcm5laiBTa3JhYmVjIDxqZXJuZWouc2ty
YWJlY0BnbWFpbC5jb20+CgpCZXN0IHJlZ2FyZHMsCkplcm5lagoKPiAtLS0KPiAKPiAgZHJpdmVy
cy9pb21tdS9LY29uZmlnIHwgMSArCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQo+
IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L0tjb25maWcgYi9kcml2ZXJzL2lvbW11L0tj
b25maWcKPiBpbmRleCBjNzlhMGRmMDkwYzAuLjcwYTBiZmE2ZDkwNyAxMDA2NDQKPiAtLS0gYS9k
cml2ZXJzL2lvbW11L0tjb25maWcKPiArKysgYi9kcml2ZXJzL2lvbW11L0tjb25maWcKPiBAQCAt
MjIzLDYgKzIyMyw3IEBAIGNvbmZpZyBTVU41MElfSU9NTVUKPiAgCWRlcGVuZHMgb24gQVJDSF9T
VU5YSSB8fCBDT01QSUxFX1RFU1QKPiAgCXNlbGVjdCBBUk1fRE1BX1VTRV9JT01NVQo+ICAJc2Vs
ZWN0IElPTU1VX0FQSQo+ICsJc2VsZWN0IElPTU1VX0RNQQo+ICAJaGVscAo+ICAJICBTdXBwb3J0
IGZvciB0aGUgSU9NTVUgaW50cm9kdWNlZCBpbiB0aGUgQWxsd2lubmVyIEg2IFNvQ3MuCgoKCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWls
aW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
