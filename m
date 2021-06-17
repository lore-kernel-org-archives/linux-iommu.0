Return-Path: <SRS0=K0Me=LL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3450C49EBB
	for <iommu@archiver.kernel.org>; Thu, 17 Jun 2021 09:15:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 749386128C
	for <iommu@archiver.kernel.org>; Thu, 17 Jun 2021 09:15:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 749386128C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2E51760670;
	Thu, 17 Jun 2021 09:15:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TGFR9NP9xEzj; Thu, 17 Jun 2021 09:15:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D018A60761;
	Thu, 17 Jun 2021 09:15:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9531DC000E;
	Thu, 17 Jun 2021 09:15:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 24A30C000B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 09:15:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E6D7D83DC5
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 09:15:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vA2oMtvCozTh for <iommu@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 09:15:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com
 [IPv6:2607:f8b0:4864:20::e33])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 89E6F83DC2
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 09:15:02 +0000 (UTC)
Received: by mail-vs1-xe33.google.com with SMTP id q2so2624333vsr.1
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 02:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=NiiU6fiVLbE4syulfvGQUEnbQNZvmtFPXY1KRGZ4VKs=;
 b=tspUddDmWP1nXGb8dYzDapkXukDhtaQZ8yVoZQOykE4MszNmnQ2Jc7pAu3v7qBcemT
 UyLs98rU9nEy8e3wRIJkxsl8g3L8Eb/AvQODxlfCIA8Y+SqSVtbG2msAYvDIZFEizfbY
 20UD8As6h7+oRqO/LBfp1JKzos5qS4bIZn22juJCAEEZOMhbhqM1f/S6KCbcFkkK35Tr
 P7laFgsJQmqhNYip+ALRHKPPvbOtIHBYtRpZR/hgm9hpO06Ne5Y1MzvmGVRytTLSpocX
 +CLKqhQk6OUYMP0R+b/JJQ4/QkH+6e5JGgp8Hm8OfSHuZ6CIo4hVwTpj+jWWd51a3cq+
 7N8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=NiiU6fiVLbE4syulfvGQUEnbQNZvmtFPXY1KRGZ4VKs=;
 b=l97N+sL8SvnjGcR44s6mH95VphRA84dQkWVxxhrXXy3t97854LGtACszaD98BXMrwG
 ++vab9eES+2E9hzGM12+BDQdiqhuIcxF7aOn3JqhfH/6q88A7jx4ILoYPV5KawmK2PNB
 k2sZ+NaqVlUtHjSSs/E9jVz9aI5HQyeslo9p7nAEI1aP+r7wiI3euaVKk8Qg2AkgaqC9
 tyKPHdJ1fzyLSFlY0NaVoJ9hBCnvrS9CsXb4s/9Ja24whR5ZleHBYku/EhgfJ28iZ5iI
 HajH70jAxckoGF05R+gy4izrlE04FgYEAoOZunaG1rnVfVaBfc4j/zHRMYd95V1lZjoc
 caiQ==
X-Gm-Message-State: AOAM5304qjExs+VXtyZkARQPKcH7qfz53mjZdVv/wByy+7JGemmCwt3f
 K72PYFzwfeV1u88uUY8iLijs9AojcmsctevaZ8v6YQ==
X-Google-Smtp-Source: ABdhPJyDDRUn2syWiuy8XigFtL3iDYKz59Ub/6ekAvgFfmAY9tRuxX/nulbHrrDC8J99+RHvCUQeMQ9XnjKDaURJSR4=
X-Received: by 2002:a05:6102:2159:: with SMTP id
 h25mr3349328vsg.19.1623921301368; 
 Thu, 17 Jun 2021 02:15:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210615191543.1043414-1-robh@kernel.org>
In-Reply-To: <20210615191543.1043414-1-robh@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 17 Jun 2021 11:14:25 +0200
Message-ID: <CAPDyKFrY4UOO5CbZ8Bj7AH2+3Wo1PRpUv+Zs96tub=MzGuGrrQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Drop redundant minItems/maxItems
To: Rob Herring <robh@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pwm@vger.kernel.org,
 linux-iio@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, linux-remoteproc@vger.kernel.org,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 dri-devel <dri-devel@lists.freedesktop.org>, linux-ide@vger.kernel.org,
 linux-i2c@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-riscv <linux-riscv@lists.infradead.org>,
 Lee Jones <lee.jones@linaro.org>, linux-clk <linux-clk@vger.kernel.org>,
 linux-rtc@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, Marc Zyngier <maz@kernel.org>,
 Jassi Brar <jassisinghbrar@gmail.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@ti.com>, David Airlie <airlied@linux.ie>,
 linux-serial@vger.kernel.org,
 =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Jakub Kicinski <kuba@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Vivien Didelot <vivien.didelot@gmail.com>,
 Wolfgang Grandegger <wg@grandegger.com>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Ohad Ben-Cohen <ohad@wizery.com>, DTML <devicetree@vger.kernel.org>,
 Albert Ou <aou@eecs.berkeley.edu>, linux-watchdog@vger.kernel.org,
 Linux PM <linux-pm@vger.kernel.org>, linux-can@vger.kernel.org,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>,
 Kamal Dasu <kdasu.kdev@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>, Jens Axboe <axboe@kernel.dk>,
 Alessandro Zummo <a.zummo@towertech.it>, Guenter Roeck <linux@roeck-us.net>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Stephen Boyd <sboyd@kernel.org>,
 netdev <netdev@vger.kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Linux USB List <linux-usb@vger.kernel.org>,
 linux-mmc <linux-mmc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-spi@vger.kernel.org,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, linux-crypto@vger.kernel.org,
 Daniel Vetter <daniel@ffwll.ch>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, dmaengine@vger.kernel.org,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Jonathan Cameron <jic23@kernel.org>
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

T24gVHVlLCAxNSBKdW4gMjAyMSBhdCAyMToxNSwgUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9y
Zz4gd3JvdGU6Cj4KPiBJZiBhIHByb3BlcnR5IGhhcyBhbiAnaXRlbXMnIGxpc3QsIHRoZW4gYSAn
bWluSXRlbXMnIG9yICdtYXhJdGVtcycgd2l0aCB0aGUKPiBzYW1lIHNpemUgYXMgdGhlIGxpc3Qg
aXMgcmVkdW5kYW50IGFuZCBjYW4gYmUgZHJvcHBlZC4gTm90ZSB0aGF0IGlzIERUCj4gc2NoZW1h
IHNwZWNpZmljIGJlaGF2aW9yIGFuZCBub3Qgc3RhbmRhcmQganNvbi1zY2hlbWEgYmVoYXZpb3Iu
IFRoZSB0b29saW5nCj4gd2lsbCBmaXh1cCB0aGUgZmluYWwgc2NoZW1hIGFkZGluZyBhbnkgdW5z
cGVjaWZpZWQgbWluSXRlbXMvbWF4SXRlbXMuCj4KPiBUaGlzIGNvbmRpdGlvbiBpcyBwYXJ0aWFs
bHkgY2hlY2tlZCB3aXRoIHRoZSBtZXRhLXNjaGVtYSBhbHJlYWR5LCBidXQKPiBvbmx5IGlmIGJv
dGggJ21pbkl0ZW1zJyBhbmQgJ21heEl0ZW1zJyBhcmUgZXF1YWwgdG8gdGhlICdpdGVtcycgbGVu
Z3RoLgo+IEFuIGltcHJvdmVkIG1ldGEtc2NoZW1hIGlzIHBlbmRpbmcuCj4KPiBDYzogSmVucyBB
eGJvZSA8YXhib2VAa2VybmVsLmRrPgo+IENjOiBTdGVwaGVuIEJveWQgPHNib3lkQGtlcm5lbC5v
cmc+Cj4gQ2M6IEhlcmJlcnQgWHUgPGhlcmJlcnRAZ29uZG9yLmFwYW5hLm9yZy5hdT4KPiBDYzog
IkRhdmlkIFMuIE1pbGxlciIgPGRhdmVtQGRhdmVtbG9mdC5uZXQ+Cj4gQ2M6IERhdmlkIEFpcmxp
ZSA8YWlybGllZEBsaW51eC5pZT4KPiBDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNo
Pgo+IENjOiBWaW5vZCBLb3VsIDx2a291bEBrZXJuZWwub3JnPgo+IENjOiBCYXJ0b3N6IEdvbGFz
emV3c2tpIDxiZ29sYXN6ZXdza2lAYmF5bGlicmUuY29tPgo+IENjOiBLYW1hbCBEYXN1IDxrZGFz
dS5rZGV2QGdtYWlsLmNvbT4KPiBDYzogSm9uYXRoYW4gQ2FtZXJvbiA8amljMjNAa2VybmVsLm9y
Zz4KPiBDYzogTGFycy1QZXRlciBDbGF1c2VuIDxsYXJzQG1ldGFmb28uZGU+Cj4gQ2M6IFRob21h
cyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPgo+IENjOiBNYXJjIFp5bmdpZXIgPG1hekBr
ZXJuZWwub3JnPgo+IENjOiBKb2VyZyBSb2VkZWwgPGpvcm9AOGJ5dGVzLm9yZz4KPiBDYzogSmFz
c2kgQnJhciA8amFzc2lzaW5naGJyYXJAZ21haWwuY29tPgo+IENjOiBNYXVybyBDYXJ2YWxobyBD
aGVoYWIgPG1jaGVoYWJAa2VybmVsLm9yZz4KPiBDYzogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6
eXN6dG9mLmtvemxvd3NraUBjYW5vbmljYWwuY29tPgo+IENjOiBVbGYgSGFuc3NvbiA8dWxmLmhh
bnNzb25AbGluYXJvLm9yZz4KPiBDYzogSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz4K
PiBDYzogV29sZmdhbmcgR3JhbmRlZ2dlciA8d2dAZ3JhbmRlZ2dlci5jb20+Cj4gQ2M6IE1hcmMg
S2xlaW5lLUJ1ZGRlIDxta2xAcGVuZ3V0cm9uaXguZGU+Cj4gQ2M6IEFuZHJldyBMdW5uIDxhbmRy
ZXdAbHVubi5jaD4KPiBDYzogVml2aWVuIERpZGVsb3QgPHZpdmllbi5kaWRlbG90QGdtYWlsLmNv
bT4KPiBDYzogVmxhZGltaXIgT2x0ZWFuIDxvbHRlYW52QGdtYWlsLmNvbT4KPiBDYzogQmpvcm4g
SGVsZ2FhcyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT4KPiBDYzogS2lzaG9uIFZpamF5IEFicmFoYW0g
SSA8a2lzaG9uQHRpLmNvbT4KPiBDYzogTGludXMgV2FsbGVpaiA8bGludXMud2FsbGVpakBsaW5h
cm8ub3JnPgo+IENjOiAiVXdlIEtsZWluZS1Lw7ZuaWciIDx1LmtsZWluZS1rb2VuaWdAcGVuZ3V0
cm9uaXguZGU+Cj4gQ2M6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Cj4gQ2M6IE9o
YWQgQmVuLUNvaGVuIDxvaGFkQHdpemVyeS5jb20+Cj4gQ2M6IE1hdGhpZXUgUG9pcmllciA8bWF0
aGlldS5wb2lyaWVyQGxpbmFyby5vcmc+Cj4gQ2M6IFBoaWxpcHAgWmFiZWwgPHAuemFiZWxAcGVu
Z3V0cm9uaXguZGU+Cj4gQ2M6IFBhdWwgV2FsbXNsZXkgPHBhdWwud2FsbXNsZXlAc2lmaXZlLmNv
bT4KPiBDYzogUGFsbWVyIERhYmJlbHQgPHBhbG1lckBkYWJiZWx0LmNvbT4KPiBDYzogQWxiZXJ0
IE91IDxhb3VAZWVjcy5iZXJrZWxleS5lZHU+Cj4gQ2M6IEFsZXNzYW5kcm8gWnVtbW8gPGEuenVt
bW9AdG93ZXJ0ZWNoLml0Pgo+IENjOiBBbGV4YW5kcmUgQmVsbG9uaSA8YWxleGFuZHJlLmJlbGxv
bmlAYm9vdGxpbi5jb20+Cj4gQ2M6IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91
bmRhdGlvbi5vcmc+Cj4gQ2M6IE1hcmsgQnJvd24gPGJyb29uaWVAa2VybmVsLm9yZz4KPiBDYzog
WmhhbmcgUnVpIDxydWkuemhhbmdAaW50ZWwuY29tPgo+IENjOiBEYW5pZWwgTGV6Y2FubyA8ZGFu
aWVsLmxlemNhbm9AbGluYXJvLm9yZz4KPiBDYzogV2ltIFZhbiBTZWJyb2VjayA8d2ltQGxpbnV4
LXdhdGNoZG9nLm9yZz4KPiBDYzogR3VlbnRlciBSb2VjayA8bGludXhAcm9lY2stdXMubmV0Pgo+
IFNpZ25lZC1vZmYtYnk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+CgpBY2tlZC1ieTog
VWxmIEhhbnNzb24gPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+ICMgZm9yIE1NQwoKWy4uLl0KCktp
bmQgcmVnYXJkcwpVZmZlCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21t
dQ==
