Return-Path: <SRS0=WrXO=TR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE417C04E87
	for <iommu@archiver.kernel.org>; Fri, 17 May 2019 22:17:05 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EF482087E
	for <iommu@archiver.kernel.org>; Fri, 17 May 2019 22:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GlQ47fje"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EF482087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 333F2E31;
	Fri, 17 May 2019 22:17:05 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 4BA84E27
	for <iommu@lists.linux-foundation.org>;
	Fri, 17 May 2019 22:17:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 80D9387B
	for <iommu@lists.linux-foundation.org>;
	Fri, 17 May 2019 22:17:02 +0000 (UTC)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com
	[209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 288A0217D8
	for <iommu@lists.linux-foundation.org>;
	Fri, 17 May 2019 22:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558131422;
	bh=Ub9ywDgQMywBRcVcnaiqdLyL6nucWm3LLTrW2H19UiE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GlQ47fjelVwOIBUNPfQPVtZRplhCOXFbklJArqlwOt3X8cNAekcwtl4ovf9ekowFT
	rxpRgSRuXfWsJi3oreP7IxF7trBEOA8EwhrlnBkfayec6e1QgrAOOIVTLxn0iIO7Tg
	lW21oFAasHZtJPuV4K/PqeO4ZKdt5jwVfXM6iDII=
Received: by mail-qt1-f179.google.com with SMTP id z19so9748584qtz.13
	for <iommu@lists.linux-foundation.org>;
	Fri, 17 May 2019 15:17:02 -0700 (PDT)
X-Gm-Message-State: APjAAAXZUH0yt7f6lOpvwtwoa02eYUKIlSXCr64yX+61S9kze0TT1TXG
	xbzYqFddniOLlW4TCqF22iwZuUFnQ43wg3O1CA==
X-Google-Smtp-Source: APXvYqwEyGCXsMdPpd1yKLh5mRTBHM7bqH+ylSdbW3LBM0kM6/GbLYmB3yx3l3fr7fSVgCiND3V4w1ysUhkmpeQirXM=
X-Received: by 2002:a0c:8aad:: with SMTP id 42mr48554064qvv.200.1558131421268; 
	Fri, 17 May 2019 15:17:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190517184659.18828-1-peron.clem@gmail.com>
	<20190517184659.18828-2-peron.clem@gmail.com>
	<CAL_JsqKPazGn+g1zS4NMwvQZ_6GcAm0tgcOTqyQA0dz0+2dp3g@mail.gmail.com>
	<CAJiuCcdMxXAXYk=QpRwsvBUW0tvBVMqXvgx0Y7fAKP=ouyBnKQ@mail.gmail.com>
In-Reply-To: <CAJiuCcdMxXAXYk=QpRwsvBUW0tvBVMqXvgx0Y7fAKP=ouyBnKQ@mail.gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Fri, 17 May 2019 17:16:49 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJgo8NpK00ApBcdtYGW24yuqU=4EMna+r_07=dqceZyyg@mail.gmail.com>
Message-ID: <CAL_JsqJgo8NpK00ApBcdtYGW24yuqU=4EMna+r_07=dqceZyyg@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] drm: panfrost: add optional bus_clock
To: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	devicetree <devicetree@vger.kernel.org>,
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

T24gRnJpLCBNYXkgMTcsIDIwMTkgYXQgNTowOCBQTSBDbMOpbWVudCBQw6lyb24gPHBlcm9uLmNs
ZW1AZ21haWwuY29tPiB3cm90ZToKPgo+IEhpIFJvYiwKPgo+IE9uIEZyaSwgMTcgTWF5IDIwMTkg
YXQgMjI6MDcsIFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+IHdyb3RlOgo+ID4KPiA+
IE9uIEZyaSwgTWF5IDE3LCAyMDE5IGF0IDE6NDcgUE0gQ2zDqW1lbnQgUMOpcm9uIDxwZXJvbi5j
bGVtQGdtYWlsLmNvbT4gd3JvdGU6Cj4gPiA+Cj4gPiA+IEFsbHdpbm5lciBINiBoYXMgYW4gQVJN
IE1hbGktVDcyMCBNUDIgd2hpY2ggcmVxdWlyZWQgYSBidXNfY2xvY2suCj4gPiA+Cj4gPiA+IEFk
ZCBhbiBvcHRpb25hbCBidXNfY2xvY2sgYXQgdGhlIGluaXQgb2YgdGhlIHBhbmZyb3N0IGRyaXZl
ci4KPiA+ID4KPiA+ID4gU2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgUMOpcm9uIDxwZXJvbi5jbGVt
QGdtYWlsLmNvbT4KPiA+ID4gLS0tCj4gPiA+ICBkcml2ZXJzL2dwdS9kcm0vcGFuZnJvc3QvcGFu
ZnJvc3RfZGV2aWNlLmMgfCAyNSArKysrKysrKysrKysrKysrKysrKystCj4gPiA+ICBkcml2ZXJz
L2dwdS9kcm0vcGFuZnJvc3QvcGFuZnJvc3RfZGV2aWNlLmggfCAgMSArCj4gPiA+ICAyIGZpbGVz
IGNoYW5nZWQsIDI1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPiA+ID4KPiA+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9wYW5mcm9zdC9wYW5mcm9zdF9kZXZpY2UuYyBiL2Ry
aXZlcnMvZ3B1L2RybS9wYW5mcm9zdC9wYW5mcm9zdF9kZXZpY2UuYwo+ID4gPiBpbmRleCAzYjJi
Y2VkMWIwMTUuLjhkYTZlNjEyZDM4NCAxMDA2NDQKPiA+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L3BhbmZyb3N0L3BhbmZyb3N0X2RldmljZS5jCj4gPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9w
YW5mcm9zdC9wYW5mcm9zdF9kZXZpY2UuYwo+ID4gPiBAQCAtNDQsNyArNDQsOCBAQCBzdGF0aWMg
aW50IHBhbmZyb3N0X2Nsa19pbml0KHN0cnVjdCBwYW5mcm9zdF9kZXZpY2UgKnBmZGV2KQo+ID4g
Pgo+ID4gPiAgICAgICAgIHBmZGV2LT5jbG9jayA9IGRldm1fY2xrX2dldChwZmRldi0+ZGV2LCBO
VUxMKTsKPiA+ID4gICAgICAgICBpZiAoSVNfRVJSKHBmZGV2LT5jbG9jaykpIHsKPiA+ID4gLSAg
ICAgICAgICAgICAgIGRldl9lcnIocGZkZXYtPmRldiwgImdldCBjbG9jayBmYWlsZWQgJWxkXG4i
LCBQVFJfRVJSKHBmZGV2LT5jbG9jaykpOwo+ID4gPiArICAgICAgICAgICAgICAgZGV2X2Vycihw
ZmRldi0+ZGV2LCAiZ2V0IGNsb2NrIGZhaWxlZCAlbGRcbiIsCj4gPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgIFBUUl9FUlIocGZkZXYtPmNsb2NrKSk7Cj4gPgo+ID4gUGxlYXNlIGRyb3AgdGhp
cyB3aGl0ZXNwYWNlIGNoYW5nZS4KPgo+IFNvcnJ5LCBJIHRob3VnaHQgaXQgd2FzIG9ubHkgYSBt
aXN0YWtlIGhlcmUsIEkgd2lsbCBkcm9wIGl0Lgo+IFdoeSBhcmUgdGhleSBzbyBtYW55IGxpbmVz
IG92ZXIgODAgY2hhcmFjdGVycz8KCkknZCBndWVzcyBtb3N0IGFyZSBwcmludHMgYW5kL29yIGp1
c3Qgc2xpZ2h0bHkgb3Zlci4KCj4gSXMgdGhlcmUgYSBzcGVjaWZpYyBjb2Rpbmcgc3R5bGUgdG8g
Zm9sbG93ID8KClllcywgYnV0IGdlbmVyYWxseSB0aGUgODAgY2hhcmFjdGVyIHRoaW5nIGlzIG1v
cmUgYSBndWlkYW5jZS4gTm90CmhhdmluZyB1bnJlbGF0ZWQgY2hhbmdlcyBpbiBhIHNpbmdsZSBj
b21taXQgaXMgbW9yZSBvZiBhIGhhcmQgcnVsZS4KClJvYgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vaW9tbXU=
