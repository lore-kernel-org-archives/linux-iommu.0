Return-Path: <SRS0=Ln9J=CK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19B2C433E2
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 22:59:31 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A03082071B
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 22:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="w3AXvs40"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A03082071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 5F6922051B;
	Tue,  1 Sep 2020 22:59:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e3lmQdO8qKED; Tue,  1 Sep 2020 22:59:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 48352204DB;
	Tue,  1 Sep 2020 22:59:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C696C0052;
	Tue,  1 Sep 2020 22:59:30 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3B5FC0051
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 22:59:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A0A0185CA8
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 22:59:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vQeTQ3mlL6d4 for <iommu@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 22:59:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id BB64885A67
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 22:59:27 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3457E21532
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 22:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599001167;
 bh=6+prf8hd/dD/hqUCmuKJ8TIy6p+8/B1mAtJifqlir+A=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=w3AXvs40WAjhXqbXqQI1GI9Yf7hMmKxb/eEPBdI1ctXxmiKOG5KwrJHt7sbbu9Re4
 4sgXHSx9tWBEQYbqv9Pjkq506kssAi0Zcp7Cv+il7ZTLRd/z6hHjzlDnpX/M0hpjIY
 EmThNZ/vhzh/HMmvip5IgkrHvzr7gvSKWbKBXIAc=
Received: by mail-ej1-f48.google.com with SMTP id e23so3971147eja.3
 for <iommu@lists.linux-foundation.org>; Tue, 01 Sep 2020 15:59:27 -0700 (PDT)
X-Gm-Message-State: AOAM532LYn6iHOuANJgk5UgKZb3GQRwNdB4VY0sA6eyfbP4DS4pIfToE
 CkjqRfURYOpR75yasctWQgypJJKwm1dJwCEttg==
X-Google-Smtp-Source: ABdhPJzjHDOXSGz7glhl+6OiZP2SWKZjyjWU9LL5WqhptcI1ntuiSPhKiGIOKRXMhN7HiiRtHc6HA76qv/dWjb/Q6CM=
X-Received: by 2002:a17:906:7492:: with SMTP id
 e18mr3598885ejl.375.1599001165547; 
 Tue, 01 Sep 2020 15:59:25 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200826063533eucas1p1fad2f2afb117b026081468d2d840ab0f@eucas1p1.samsung.com>
 <20200826063316.23486-1-m.szyprowski@samsung.com>
 <20200826063316.23486-11-m.szyprowski@samsung.com>
In-Reply-To: <20200826063316.23486-11-m.szyprowski@samsung.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Wed, 2 Sep 2020 06:59:14 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9=GFMW2QQKjxWHeZLYTDo3+=j=wZ62t9LrSkfD79ji9A@mail.gmail.com>
Message-ID: <CAAOTY_9=GFMW2QQKjxWHeZLYTDo3+=j=wZ62t9LrSkfD79ji9A@mail.gmail.com>
Subject: Re: [PATCH v9 10/32] drm: mediatek: use common helper for a
 scatterlist contiguity check
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, linux-kernel <linux-kernel@vger.kernel.org>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 linaro-mm-sig@lists.linaro.org, iommu@lists.linux-foundation.org,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
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

SGksIE1hcmVrOgoKTWFyZWsgU3p5cHJvd3NraSA8bS5zenlwcm93c2tpQHNhbXN1bmcuY29tPiDm
lrwgMjAyMOW5tDjmnIgyNuaXpSDpgLHkuIkg5LiL5Y2IMjozNeWvq+mBk++8mgo+Cj4gVXNlIGNv
bW1vbiBoZWxwZXIgZm9yIGNoZWNraW5nIHRoZSBjb250aWd1aXR5IG9mIHRoZSBpbXBvcnRlZCBk
bWEtYnVmIGFuZAo+IGRvIHRoaXMgY2hlY2sgYmVmb3JlIGFsbG9jYXRpbmcgcmVzb3VyY2VzLCBz
byB0aGUgZXJyb3IgcGF0aCBpcyBzaW1wbGVyLgo+CgpBY2tlZC1ieTogQ2h1bi1LdWFuZyBIdSA8
Y2h1bmt1YW5nLmh1QGtlcm5lbC5vcmc+Cgo+IFNpZ25lZC1vZmYtYnk6IE1hcmVrIFN6eXByb3dz
a2kgPG0uc3p5cHJvd3NraUBzYW1zdW5nLmNvbT4KPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kcm1fZ2VtLmMgfCAyOCArKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLQo+ICAx
IGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAyMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9nZW0uYyBiL2RyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2dlbS5jCj4gaW5kZXggNjE5MGNjM2I3YjBkLi4zNjU0
ZWM3MzIwMjkgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1f
Z2VtLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9nZW0uYwo+IEBA
IC0yMTIsMzcgKzIxMiwyMSBAQCBzdHJ1Y3QgZHJtX2dlbV9vYmplY3QgKm10a19nZW1fcHJpbWVf
aW1wb3J0X3NnX3RhYmxlKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgc3RydWN0IGRtYV9idWZfYXR0YWNobWVudCAqYXR0YWNoLCBzdHJ1Y3Qgc2dfdGFi
bGUgKnNnKQo+ICB7Cj4gICAgICAgICBzdHJ1Y3QgbXRrX2RybV9nZW1fb2JqICptdGtfZ2VtOwo+
IC0gICAgICAgaW50IHJldDsKPiAtICAgICAgIHN0cnVjdCBzY2F0dGVybGlzdCAqczsKPiAtICAg
ICAgIHVuc2lnbmVkIGludCBpOwo+IC0gICAgICAgZG1hX2FkZHJfdCBleHBlY3RlZDsKPgo+IC0g
ICAgICAgbXRrX2dlbSA9IG10a19kcm1fZ2VtX2luaXQoZGV2LCBhdHRhY2gtPmRtYWJ1Zi0+c2l6
ZSk7Cj4gKyAgICAgICAvKiBjaGVjayBpZiB0aGUgZW50cmllcyBpbiB0aGUgc2dfdGFibGUgYXJl
IGNvbnRpZ3VvdXMgKi8KPiArICAgICAgIGlmIChkcm1fcHJpbWVfZ2V0X2NvbnRpZ3VvdXNfc2l6
ZShzZykgPCBhdHRhY2gtPmRtYWJ1Zi0+c2l6ZSkgewo+ICsgICAgICAgICAgICAgICBEUk1fRVJS
T1IoInNnX3RhYmxlIGlzIG5vdCBjb250aWd1b3VzIik7Cj4gKyAgICAgICAgICAgICAgIHJldHVy
biBFUlJfUFRSKC1FSU5WQUwpOwo+ICsgICAgICAgfQo+Cj4gKyAgICAgICBtdGtfZ2VtID0gbXRr
X2RybV9nZW1faW5pdChkZXYsIGF0dGFjaC0+ZG1hYnVmLT5zaXplKTsKPiAgICAgICAgIGlmIChJ
U19FUlIobXRrX2dlbSkpCj4gICAgICAgICAgICAgICAgIHJldHVybiBFUlJfQ0FTVChtdGtfZ2Vt
KTsKPgo+IC0gICAgICAgZXhwZWN0ZWQgPSBzZ19kbWFfYWRkcmVzcyhzZy0+c2dsKTsKPiAtICAg
ICAgIGZvcl9lYWNoX3NnKHNnLT5zZ2wsIHMsIHNnLT5uZW50cywgaSkgewo+IC0gICAgICAgICAg
ICAgICBpZiAoIXNnX2RtYV9sZW4ocykpCj4gLSAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7
Cj4gLQo+IC0gICAgICAgICAgICAgICBpZiAoc2dfZG1hX2FkZHJlc3MocykgIT0gZXhwZWN0ZWQp
IHsKPiAtICAgICAgICAgICAgICAgICAgICAgICBEUk1fRVJST1IoInNnX3RhYmxlIGlzIG5vdCBj
b250aWd1b3VzIik7Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgcmV0ID0gLUVJTlZBTDsKPiAt
ICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGVycl9nZW1fZnJlZTsKPiAtICAgICAgICAgICAg
ICAgfQo+IC0gICAgICAgICAgICAgICBleHBlY3RlZCA9IHNnX2RtYV9hZGRyZXNzKHMpICsgc2df
ZG1hX2xlbihzKTsKPiAtICAgICAgIH0KPiAtCj4gICAgICAgICBtdGtfZ2VtLT5kbWFfYWRkciA9
IHNnX2RtYV9hZGRyZXNzKHNnLT5zZ2wpOwo+ICAgICAgICAgbXRrX2dlbS0+c2cgPSBzZzsKPgo+
ICAgICAgICAgcmV0dXJuICZtdGtfZ2VtLT5iYXNlOwo+IC0KPiAtZXJyX2dlbV9mcmVlOgo+IC0g
ICAgICAga2ZyZWUobXRrX2dlbSk7Cj4gLSAgICAgICByZXR1cm4gRVJSX1BUUihyZXQpOwo+ICB9
Cj4KPiAgdm9pZCAqbXRrX2RybV9nZW1fcHJpbWVfdm1hcChzdHJ1Y3QgZHJtX2dlbV9vYmplY3Qg
Km9iaikKPiAtLQo+IDIuMTcuMQo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by9pb21tdQ==
