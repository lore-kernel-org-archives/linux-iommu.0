Return-Path: <SRS0=WrXO=TR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787E1C04AB4
	for <iommu@archiver.kernel.org>; Fri, 17 May 2019 20:08:36 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4588D2087E
	for <iommu@archiver.kernel.org>; Fri, 17 May 2019 20:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7KoCjgN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4588D2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 125DFDD6;
	Fri, 17 May 2019 20:07:50 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 79365CA6
	for <iommu@lists.linux-foundation.org>;
	Fri, 17 May 2019 20:07:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 1BBDB5E4
	for <iommu@lists.linux-foundation.org>;
	Fri, 17 May 2019 20:07:47 +0000 (UTC)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com
	[209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id B090E2177B
	for <iommu@lists.linux-foundation.org>;
	Fri, 17 May 2019 20:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558123666;
	bh=IkVGNrM3mkdkCp1ruLguz7iPAsoAAPm6bhm62l6C0l4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=D7KoCjgNCYuzAKFnaeZMIowcKdNjhe/bHfunIg0phnFQGUNm7Si+IswAnpAuc8H6I
	6Juv7ClQ+lDWVypoiyNPgrHPlYddKlyshbbCP2el4CrhQiWah4/LMWx6fgC/bWtuFU
	E4aSZreYUPIbR5Wj7iA7bqvpJU7ENIrsynXOu2+M=
Received: by mail-qt1-f169.google.com with SMTP id d13so9462202qth.5
	for <iommu@lists.linux-foundation.org>;
	Fri, 17 May 2019 13:07:46 -0700 (PDT)
X-Gm-Message-State: APjAAAUCPFRlZ64msUPmsWfKMFT/RUXOsjSqXTFbet0WP1HfAvdDzOcG
	OH4uUvd4d2jVSSLlQO8jPXBExROIrMo7AHIF5g==
X-Google-Smtp-Source: APXvYqyorKmxc+J4KVhOQBHBImhJm18kRJeWl2YZpK+ASt7DMCb593EYeTOi8eZBw90uGhvevJaQVOjh6CpzEWMWRDg=
X-Received: by 2002:ac8:2d48:: with SMTP id o8mr50643532qta.136.1558123665768; 
	Fri, 17 May 2019 13:07:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190517184659.18828-1-peron.clem@gmail.com>
	<20190517184659.18828-2-peron.clem@gmail.com>
In-Reply-To: <20190517184659.18828-2-peron.clem@gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Fri, 17 May 2019 15:07:32 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKPazGn+g1zS4NMwvQZ_6GcAm0tgcOTqyQA0dz0+2dp3g@mail.gmail.com>
Message-ID: <CAL_JsqKPazGn+g1zS4NMwvQZ_6GcAm0tgcOTqyQA0dz0+2dp3g@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] drm: panfrost: add optional bus_clock
To: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
	Tomeu Vizoso <tomeu.vizoso@collabora.com>,
	Neil Armstrong <narmstrong@baylibre.com>, David Airlie <airlied@linux.ie>,
	Will Deacon <will.deacon@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	Steven Price <steven.price@arm.com>,
	Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
	Linux IOMMU <iommu@lists.linux-foundation.org>,
	Daniel Vetter <daniel@ffwll.ch>, Robin Murphy <robin.murphy@arm.com>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

T24gRnJpLCBNYXkgMTcsIDIwMTkgYXQgMTo0NyBQTSBDbMOpbWVudCBQw6lyb24gPHBlcm9uLmNs
ZW1AZ21haWwuY29tPiB3cm90ZToKPgo+IEFsbHdpbm5lciBINiBoYXMgYW4gQVJNIE1hbGktVDcy
MCBNUDIgd2hpY2ggcmVxdWlyZWQgYSBidXNfY2xvY2suCj4KPiBBZGQgYW4gb3B0aW9uYWwgYnVz
X2Nsb2NrIGF0IHRoZSBpbml0IG9mIHRoZSBwYW5mcm9zdCBkcml2ZXIuCj4KPiBTaWduZWQtb2Zm
LWJ5OiBDbMOpbWVudCBQw6lyb24gPHBlcm9uLmNsZW1AZ21haWwuY29tPgo+IC0tLQo+ICBkcml2
ZXJzL2dwdS9kcm0vcGFuZnJvc3QvcGFuZnJvc3RfZGV2aWNlLmMgfCAyNSArKysrKysrKysrKysr
KysrKysrKystCj4gIGRyaXZlcnMvZ3B1L2RybS9wYW5mcm9zdC9wYW5mcm9zdF9kZXZpY2UuaCB8
ICAxICsKPiAgMiBmaWxlcyBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
Cj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3BhbmZyb3N0L3BhbmZyb3N0X2Rldmlj
ZS5jIGIvZHJpdmVycy9ncHUvZHJtL3BhbmZyb3N0L3BhbmZyb3N0X2RldmljZS5jCj4gaW5kZXgg
M2IyYmNlZDFiMDE1Li44ZGE2ZTYxMmQzODQgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L3BhbmZyb3N0L3BhbmZyb3N0X2RldmljZS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3BhbmZy
b3N0L3BhbmZyb3N0X2RldmljZS5jCj4gQEAgLTQ0LDcgKzQ0LDggQEAgc3RhdGljIGludCBwYW5m
cm9zdF9jbGtfaW5pdChzdHJ1Y3QgcGFuZnJvc3RfZGV2aWNlICpwZmRldikKPgo+ICAgICAgICAg
cGZkZXYtPmNsb2NrID0gZGV2bV9jbGtfZ2V0KHBmZGV2LT5kZXYsIE5VTEwpOwo+ICAgICAgICAg
aWYgKElTX0VSUihwZmRldi0+Y2xvY2spKSB7Cj4gLSAgICAgICAgICAgICAgIGRldl9lcnIocGZk
ZXYtPmRldiwgImdldCBjbG9jayBmYWlsZWQgJWxkXG4iLCBQVFJfRVJSKHBmZGV2LT5jbG9jaykp
Owo+ICsgICAgICAgICAgICAgICBkZXZfZXJyKHBmZGV2LT5kZXYsICJnZXQgY2xvY2sgZmFpbGVk
ICVsZFxuIiwKPiArICAgICAgICAgICAgICAgICAgICAgICBQVFJfRVJSKHBmZGV2LT5jbG9jaykp
OwoKUGxlYXNlIGRyb3AgdGhpcyB3aGl0ZXNwYWNlIGNoYW5nZS4KCj4gICAgICAgICAgICAgICAg
IHJldHVybiBQVFJfRVJSKHBmZGV2LT5jbG9jayk7Cj4gICAgICAgICB9Cj4KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0Cmlv
bW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
