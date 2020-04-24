Return-Path: <SRS0=k0pT=6I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803EDC2BA1A
	for <iommu@archiver.kernel.org>; Fri, 24 Apr 2020 10:05:40 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44C742071E
	for <iommu@archiver.kernel.org>; Fri, 24 Apr 2020 10:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xAChQZOc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44C742071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 9AFBB24BEA;
	Fri, 24 Apr 2020 10:05:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z2cN5BsqbQgl; Fri, 24 Apr 2020 10:05:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id E16552010F;
	Fri, 24 Apr 2020 10:05:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C5356C089E;
	Fri, 24 Apr 2020 10:05:36 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 572A6C0175
 for <iommu@lists.linux-foundation.org>; Fri, 24 Apr 2020 10:05:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3CC4B86C9D
 for <iommu@lists.linux-foundation.org>; Fri, 24 Apr 2020 10:05:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wFDetV0Y1SiX for <iommu@lists.linux-foundation.org>;
 Fri, 24 Apr 2020 10:05:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 409ED860C5
 for <iommu@lists.linux-foundation.org>; Fri, 24 Apr 2020 10:05:32 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id x25so9794351wmc.0
 for <iommu@lists.linux-foundation.org>; Fri, 24 Apr 2020 03:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=9sjFX/xOuzJ1ma+dRdm2U+QjBqHkdZ65sP7ssS65XRA=;
 b=xAChQZOcypsVjlU+KN7lBfFG4SyTb5KqpLWyOQk/HBgA4pxxYLt4W8HT40QHNHXuND
 SswVB8FxgipX++pkVkNaR8M0DfByM4uDfkV53KNc4F5e6gJFsB9XHfb1TFm/2mDjj8Uc
 uHh8BI5lk8qcPlr5pEMiFvBX+jXNaT02cBtzNzPBJPh69OEV+jpcyTHpr4SdOghEoZIU
 v1OlHZN+G+JW/diBuCUtuB14n/P3lLlrOBJwuE9o3XWMMpSmq0ECmhNQ7aW/nWTD5grS
 DligmM3LZkudrG+F/7/ksSB/84dWjDY/jqXCwlo/6VXVr/o9HaXAqcqRhGuBlatN+3ph
 7fIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=9sjFX/xOuzJ1ma+dRdm2U+QjBqHkdZ65sP7ssS65XRA=;
 b=JFLytu7jo0mWltauys+hNdQ7YLF/DyNVo0IkGgdrXjlb+f46+hSB6xBytVxtw8Kt3i
 8AfujIczWlgQwmg7OCsuaVwlILet0SDbVytfSN5VUpm8Z8DavERy6YQBaJcZv/ChPvdv
 PehncQHjCd5qsxmHImajA9th8DlIqcC9n/gHJ1SOMjqQELi2GVtxU2MOdBN/wIQJWkii
 hGc0o/Ozlj55iHLhSo2AG0lO2jVuKXGMnInx4NiHlKPWTC8JadZa1Yrg+FDXh6sqHfen
 g8elRN6i8wP38StGC5/wLKGN+5lyUwe4Ym4oO5m2y5ucZ9mCjHF8SjUDFRznaoB81x3r
 RWkQ==
X-Gm-Message-State: AGi0PuaFwpfatAfhJbWwrci/gN1Q1CP/qkvf9YzOWMXfnlxQl2M5JfYj
 k9mWEBlaPYryH4HELHc4GRu6Rg==
X-Google-Smtp-Source: APiQypJHsUUKYVh/i2dCkEYnnU0IrFg+4nLc/ppXSv5rQqfX7rU+7H/vSQrP81Cv7/oKIMPtXmJABQ==
X-Received: by 2002:a1c:9a81:: with SMTP id c123mr8759385wme.115.1587722730639; 
 Fri, 24 Apr 2020 03:05:30 -0700 (PDT)
Received: from dell ([2.31.163.63])
 by smtp.gmail.com with ESMTPSA id o129sm2310857wme.16.2020.04.24.03.05.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2020 03:05:29 -0700 (PDT)
Date: Fri, 24 Apr 2020 11:05:26 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Hadar Gat <hadar.gat@arm.com>
Subject: Re: [PATCH v3] of_device: removed #include that caused a recursion
 in included headers
Message-ID: <20200424100526.GA8414@dell>
References: <1587395080-15722-1-git-send-email-hadar.gat@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1587395080-15722-1-git-send-email-hadar.gat@arm.com>
Cc: Jose Abreu <joabreu@synopsys.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>, devicetree@vger.kernel.org,
 David Airlie <airlied@linux.ie>, Michael Turquette <mturquette@baylibre.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Stefan Agner <stefan@agner.ch>,
 Nicolas Ferre <nicolas.ferre@microchip.com>, linux-tegra@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>, linux-mtd@lists.infradead.org,
 Miquel Raynal <miquel.raynal@bootlin.com>, sparclinux@vger.kernel.org,
 netdev@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Fabio Estevam <festevam@gmail.com>, linux-clk@vger.kernel.org,
 Vignesh Raghavendra <vigneshr@ti.com>, linux-samsung-soc@vger.kernel.org,
 Frank Rowand <frowand.list@gmail.com>, linux-rockchip@lists.infradead.org,
 Richard Weinberger <richard@nod.at>, Vinod Koul <vkoul@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>,
 Tony Lindgren <tony@atomide.com>,
 Ludovic Desroches <ludovic.desroches@microchip.com>,
 Andy Gross <agross@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Linus Walleij <linus.walleij@linaro.org>, linux-media@vger.kernel.org,
 Kishon Vijay Abraham I <kishon@ti.com>,
 Alexandre Torgue <alexandre.torgue@st.com>, linux-omap@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-arm-msm@vger.kernel.org,
 Sascha Hauer <s.hauer@pengutronix.de>, freedreno@lists.freedesktop.org,
 Maxime Ripard <mripard@kernel.org>, Gilad Ben-Yossef <gilad@benyossef.com>,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 dri-devel@lists.freedesktop.org, Matthias Brugger <matthias.bgg@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
 Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
 Ofir Drang <ofir.drang@arm.com>, Dong Aisheng <aisheng.dong@nxp.com>,
 linux-gpio@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 linux-stm32@st-md-mailman.stormreply.com, Sandy Huang <hjc@rock-chips.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 JC Kuo <jckuo@nvidia.com>, Bjorn Andersson <bjorn.andersson@linaro.org>,
 Kukjin Kim <kgene@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Sudeep Holla <sudeep.holla@arm.com>, dmaengine@vger.kernel.org,
 Shawn Guo <shawnguo@kernel.org>, "David S. Miller" <davem@davemloft.net>,
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

T24gTW9uLCAyMCBBcHIgMjAyMCwgSGFkYXIgR2F0IHdyb3RlOgoKPiBCb3RoIG9mX3BsYXRmb3Jt
LmggYW5kIG9mX2RldmljZS5oIHdlcmUgaW5jbHVkZWQgZWFjaCBvdGhlci4KPiBJbiBvZl9kZXZp
Y2UuaCwgcmVtb3ZlZCB1bm5lZWRlZCAjaW5jbHVkZSB0byBvZl9wbGF0Zm9ybS5oCj4gYW5kIGFk
ZGVkIGluY2x1ZGUgdG8gb2ZfcGxhdGZvcm0uaCBpbiB0aGUgZmlsZXMgdGhhdCBuZWVkcyBpdC4K
PiAKPiBTaWduZWQtb2ZmLWJ5OiBIYWRhciBHYXQgPGhhZGFyLmdhdEBhcm0uY29tPgo+IFJlcG9y
dGVkLWJ5OiBrYnVpbGQgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4KPiBBY2tlZC1ieTogSm9u
YXRoYW4gQ2FtZXJvbiA8Sm9uYXRoYW4uQ2FtZXJvbkBodWF3ZWkuY29tPiAjZm9yLWlpbwo+IEFj
a2VkLWJ5OiBTdGVwaGVuIEJveWQgPHNib3lkQGtlcm5lbC5vcmc+ICMgY2xrCj4gLS0tCj4gdjM6
IGFkZCBpbmNsdWRlIHRvIG9mX3BsYXRmb3JtLmggaW4gbW9yZSBmaWxlcy4gKHJlcG9ydGVkIGR1
ZSBvdGhlciBidWlsZHMpCj4gdjI6IGFkZCBpbmNsdWRlIHRvIG9mX3BsYXRmb3JtLmggaW4gbW9y
ZSBmaWxlcy4gKHJlcG9ydGVkIGR1ZSBvdGhlciBidWlsZHMpCj4gCj4gIGFyY2gvc3BhcmMva2Vy
bmVsL3BjaS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAxICsKPiAgYXJjaC9zcGFyYy9r
ZXJuZWwvcGNpX3NhYnJlLmMgICAgICAgICAgICAgICAgICAgICB8IDEgKwo+ICBhcmNoL3NwYXJj
L2tlcm5lbC9wY2lfc2NoaXpvLmMgICAgICAgICAgICAgICAgICAgIHwgMSArCj4gIGFyY2gvc3Bh
cmMva2VybmVsL3NidXMuYyAgICAgICAgICAgICAgICAgICAgICAgICAgfCAxICsKPiAgYXJjaC9z
cGFyYy9tbS9pby11bml0LmMgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDEgKwo+ICBhcmNo
L3NwYXJjL21tL2lvbW11LmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgMSArCj4gIGRy
aXZlcnMvYmFzZS9wbGF0Zm9ybS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAxICsKPiAg
ZHJpdmVycy9idXMvaW14LXdlaW0uYyAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDEgKwo+
ICBkcml2ZXJzL2J1cy92ZXhwcmVzcy1jb25maWcuYyAgICAgICAgICAgICAgICAgICAgIHwgMSAr
Cj4gIGRyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdDc2MjItYXVkLmMgICAgICAgICAgICAgfCAx
ICsKPiAgZHJpdmVycy9kbWEvYXRfaGRtYWMuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICB8
IDEgKwo+ICBkcml2ZXJzL2RtYS9zdG0zMi1kbWFtdXguYyAgICAgICAgICAgICAgICAgICAgICAg
IHwgMSArCj4gIGRyaXZlcnMvZG1hL3RpL2RtYS1jcm9zc2Jhci5jICAgICAgICAgICAgICAgICAg
ICAgfCAxICsKPiAgZHJpdmVycy9ncHUvZHJtL21zbS9hZHJlbm8vYTZ4eF9nbXUuYyAgICAgICAg
ICAgICB8IDEgKwo+ICBkcml2ZXJzL2dwdS9kcm0vbXNtL2hkbWkvaGRtaS5jICAgICAgICAgICAg
ICAgICAgIHwgMSArCj4gIGRyaXZlcnMvZ3B1L2RybS9tc20vbXNtX2Rydi5jICAgICAgICAgICAg
ICAgICAgICAgfCAxICsKPiAgZHJpdmVycy9ncHUvZHJtL3JvY2tjaGlwL2R3LW1pcGktZHNpLXJv
Y2tjaGlwLmMgICB8IDEgKwo+ICBkcml2ZXJzL2dwdS9kcm0vc3VuNGkvc3VuNGlfdGNvbi5jICAg
ICAgICAgICAgICAgIHwgMSArCj4gIGRyaXZlcnMvaWlvL2FkYy9zdG0zMi1hZGMtY29yZS5jICAg
ICAgICAgICAgICAgICAgfCAxICsKPiAgZHJpdmVycy9paW8vYWRjL3N0bTMyLWRmc2RtLWFkYy5j
ICAgICAgICAgICAgICAgICB8IDEgKwo+ICBkcml2ZXJzL2lpby9hZGMvc3RtMzItZGZzZG0tY29y
ZS5jICAgICAgICAgICAgICAgIHwgMSArCj4gIGRyaXZlcnMvaW9tbXUvdGVncmEtc21tdS5jICAg
ICAgICAgICAgICAgICAgICAgICAgfCAxICsKPiAgZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9jb2Rh
L2NvZGEtY29tbW9uLmMgICAgICAgICB8IDEgKwo+ICBkcml2ZXJzL21lbW9yeS9hdG1lbC1lYmku
YyAgICAgICAgICAgICAgICAgICAgICAgIHwgMSArCgo+ICBkcml2ZXJzL21mZC9wYWxtYXMuYyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgMSArCj4gIGRyaXZlcnMvbWZkL3NzYmkuYyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAxICsKCkFja2VkLWJ5OiBMZWUgSm9uZXMg
PGxlZS5qb25lc0BsaW5hcm8ub3JnPgoKPiAgZHJpdmVycy9tdGQvbmFuZC9yYXcvb21hcDIuYyAg
ICAgICAgICAgICAgICAgICAgICB8IDEgKwo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9zdG1pY3Jv
L3N0bW1hYy9kd21hYy1zdW44aS5jIHwgMSArCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L3RpL2Nw
c3cuYyAgICAgICAgICAgICAgICAgICAgfCAxICsKPiAgZHJpdmVycy9waHkvdGVncmEveHVzYi5j
ICAgICAgICAgICAgICAgICAgICAgICAgICB8IDEgKwo+ICBkcml2ZXJzL3BpbmN0cmwvZnJlZXNj
YWxlL3BpbmN0cmwtaW14MS1jb3JlLmMgICAgIHwgMSArCj4gIGRyaXZlcnMvcGluY3RybC9ub21h
ZGlrL3BpbmN0cmwtbm9tYWRpay5jICAgICAgICAgfCAxICsKPiAgZHJpdmVycy9zb2Mvc2Ftc3Vu
Zy9leHlub3MtcG11LmMgICAgICAgICAgICAgICAgICB8IDEgKwo+ICBkcml2ZXJzL3NvYy9zdW54
aS9zdW54aV9zcmFtLmMgICAgICAgICAgICAgICAgICAgIHwgMSArCj4gIGluY2x1ZGUvbGludXgv
b2ZfZGV2aWNlLmggICAgICAgICAgICAgICAgICAgICAgICAgfCAyIC0tCj4gIGxpYi9nZW5hbGxv
Yy5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAxICsKPiAgMzYgZmlsZXMg
Y2hhbmdlZCwgMzUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCi0tIApMZWUgSm9uZXMg
W+adjueQvOaWr10KTGluYXJvIFNlcnZpY2VzIFRlY2huaWNhbCBMZWFkCkxpbmFyby5vcmcg4pSC
IE9wZW4gc291cmNlIHNvZnR3YXJlIGZvciBBUk0gU29DcwpGb2xsb3cgTGluYXJvOiBGYWNlYm9v
ayB8IFR3aXR0ZXIgfCBCbG9nCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9p
b21tdQ==
