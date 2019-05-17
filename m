Return-Path: <SRS0=WrXO=TR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32ADC04AB4
	for <iommu@archiver.kernel.org>; Fri, 17 May 2019 22:08:36 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A29872133D
	for <iommu@archiver.kernel.org>; Fri, 17 May 2019 22:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYUgiQf/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A29872133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 61475DDE;
	Fri, 17 May 2019 22:08:36 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A9D09DD6
	for <iommu@lists.linux-foundation.org>;
	Fri, 17 May 2019 22:08:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-yw1-f66.google.com (mail-yw1-f66.google.com
	[209.85.161.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 433C2710
	for <iommu@lists.linux-foundation.org>;
	Fri, 17 May 2019 22:08:35 +0000 (UTC)
Received: by mail-yw1-f66.google.com with SMTP id o65so3311901ywd.8
	for <iommu@lists.linux-foundation.org>;
	Fri, 17 May 2019 15:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=jft35/5eu7LfpLWAoZ01uRn8po613JLoj7AyHoG1GXA=;
	b=NYUgiQf/XO3wfHvPfBK9JqBrKKj3Wmowkwt6/vjOgQkCDK/v6jvW0oo1OZnPmZfOd6
	gXIM2YU1dxM65gHmFxomQBCOUKQV3zVEh6vSfVBe+5Nw1XhNUuyzAv724hOrXXhgW8Cn
	VQkWNIdZVzet1VOC/zC6hyJHTH5bUEGREk5GN72T5tLuAz7M2PAc55Z2kxM6tQ5SMraJ
	VZtkn8qK6YLUjTu/4tr0kcNDMPH4zIjSprh5Iy1oYW+ZozjdEZzHGQPDCltQ3I55Bt0/
	elMkVF9psPDUj7MHeBzCfsRcjwvVTi/HiUpy5OLdflq0g+ead+zvm2UIv6NzBHoYmvym
	E5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=jft35/5eu7LfpLWAoZ01uRn8po613JLoj7AyHoG1GXA=;
	b=Wo0zeejbIXXHpNs4lrQhiK6EX2uMAU9rV5E1H77u02AxwZXWeMj6Ry4NNZVxj7pBqR
	jxa5Z5xxQ4riRmMTJI+nmdN63QzNnYPyWgJNTomBIAIqCHfCOJ0JvhkQTUC4yz+zINrv
	KQPvMudoKqcGFkCoR3oYn+dNZeg5NNmDqcGD/XzDAWdUtRXZlasRwnTeyBjzUJSoSgIu
	NVdB4EFgXSwLqBA8wHVHgnrP36iiaApBE+rYn6K56WWVzO57j8lkMV21rbXxw/E8RZmv
	OsFojKUgIsXhWVnA4cYiphH2Fq2AuAQUKcmPGIa6en97bjCRN09JbGTRTX5beGL8iiBn
	TM2Q==
X-Gm-Message-State: APjAAAXgUimRzOSZhQsaakFkEaCAqW0RKac+t6eXJO+uI3VdhmkZNG4N
	TZqrTu3aN1v00dCKN1rt1JJzO6byTs3vEvivQqI=
X-Google-Smtp-Source: APXvYqxcSNmzU/oyHvSUYVr+deObwpxqKqFM5P2fsb0esZnQS0M5F0CXJpjeTYUlAVM4uj0CwId57+uwvLalM45wrhw=
X-Received: by 2002:a81:9a4b:: with SMTP id r72mr5190935ywg.422.1558130914303; 
	Fri, 17 May 2019 15:08:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190517184659.18828-1-peron.clem@gmail.com>
	<20190517184659.18828-2-peron.clem@gmail.com>
	<CAL_JsqKPazGn+g1zS4NMwvQZ_6GcAm0tgcOTqyQA0dz0+2dp3g@mail.gmail.com>
In-Reply-To: <CAL_JsqKPazGn+g1zS4NMwvQZ_6GcAm0tgcOTqyQA0dz0+2dp3g@mail.gmail.com>
From: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date: Sat, 18 May 2019 00:08:22 +0200
Message-ID: <CAJiuCcdMxXAXYk=QpRwsvBUW0tvBVMqXvgx0Y7fAKP=ouyBnKQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] drm: panfrost: add optional bus_clock
To: Rob Herring <robh+dt@kernel.org>
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

SGkgUm9iLAoKT24gRnJpLCAxNyBNYXkgMjAxOSBhdCAyMjowNywgUm9iIEhlcnJpbmcgPHJvYmgr
ZHRAa2VybmVsLm9yZz4gd3JvdGU6Cj4KPiBPbiBGcmksIE1heSAxNywgMjAxOSBhdCAxOjQ3IFBN
IENsw6ltZW50IFDDqXJvbiA8cGVyb24uY2xlbUBnbWFpbC5jb20+IHdyb3RlOgo+ID4KPiA+IEFs
bHdpbm5lciBINiBoYXMgYW4gQVJNIE1hbGktVDcyMCBNUDIgd2hpY2ggcmVxdWlyZWQgYSBidXNf
Y2xvY2suCj4gPgo+ID4gQWRkIGFuIG9wdGlvbmFsIGJ1c19jbG9jayBhdCB0aGUgaW5pdCBvZiB0
aGUgcGFuZnJvc3QgZHJpdmVyLgo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IENsw6ltZW50IFDDqXJv
biA8cGVyb24uY2xlbUBnbWFpbC5jb20+Cj4gPiAtLS0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vcGFu
ZnJvc3QvcGFuZnJvc3RfZGV2aWNlLmMgfCAyNSArKysrKysrKysrKysrKysrKysrKystCj4gPiAg
ZHJpdmVycy9ncHUvZHJtL3BhbmZyb3N0L3BhbmZyb3N0X2RldmljZS5oIHwgIDEgKwo+ID4gIDIg
ZmlsZXMgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+ID4KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcGFuZnJvc3QvcGFuZnJvc3RfZGV2aWNlLmMgYi9k
cml2ZXJzL2dwdS9kcm0vcGFuZnJvc3QvcGFuZnJvc3RfZGV2aWNlLmMKPiA+IGluZGV4IDNiMmJj
ZWQxYjAxNS4uOGRhNmU2MTJkMzg0IDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3Bh
bmZyb3N0L3BhbmZyb3N0X2RldmljZS5jCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vcGFuZnJv
c3QvcGFuZnJvc3RfZGV2aWNlLmMKPiA+IEBAIC00NCw3ICs0NCw4IEBAIHN0YXRpYyBpbnQgcGFu
ZnJvc3RfY2xrX2luaXQoc3RydWN0IHBhbmZyb3N0X2RldmljZSAqcGZkZXYpCj4gPgo+ID4gICAg
ICAgICBwZmRldi0+Y2xvY2sgPSBkZXZtX2Nsa19nZXQocGZkZXYtPmRldiwgTlVMTCk7Cj4gPiAg
ICAgICAgIGlmIChJU19FUlIocGZkZXYtPmNsb2NrKSkgewo+ID4gLSAgICAgICAgICAgICAgIGRl
dl9lcnIocGZkZXYtPmRldiwgImdldCBjbG9jayBmYWlsZWQgJWxkXG4iLCBQVFJfRVJSKHBmZGV2
LT5jbG9jaykpOwo+ID4gKyAgICAgICAgICAgICAgIGRldl9lcnIocGZkZXYtPmRldiwgImdldCBj
bG9jayBmYWlsZWQgJWxkXG4iLAo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgUFRSX0VSUihw
ZmRldi0+Y2xvY2spKTsKPgo+IFBsZWFzZSBkcm9wIHRoaXMgd2hpdGVzcGFjZSBjaGFuZ2UuCgpT
b3JyeSwgSSB0aG91Z2h0IGl0IHdhcyBvbmx5IGEgbWlzdGFrZSBoZXJlLCBJIHdpbGwgZHJvcCBp
dC4KV2h5IGFyZSB0aGV5IHNvIG1hbnkgbGluZXMgb3ZlciA4MCBjaGFyYWN0ZXJzPwpJcyB0aGVy
ZSBhIHNwZWNpZmljIGNvZGluZyBzdHlsZSB0byBmb2xsb3cgPwoKVGhhbmtzLApDbGVtZW50Cgo+
Cj4gPiAgICAgICAgICAgICAgICAgcmV0dXJuIFBUUl9FUlIocGZkZXYtPmNsb2NrKTsKPiA+ICAg
ICAgICAgfQo+ID4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
