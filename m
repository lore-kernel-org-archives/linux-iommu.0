Return-Path: <SRS0=v3bm=TS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD6DC072A4
	for <iommu@archiver.kernel.org>; Sat, 18 May 2019 14:45:30 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1302020882
	for <iommu@archiver.kernel.org>; Sat, 18 May 2019 14:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdfBwGcW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1302020882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C90CCA7A;
	Sat, 18 May 2019 14:45:29 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D692E9BA
	for <iommu@lists.linux-foundation.org>;
	Sat, 18 May 2019 14:45:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-yb1-f195.google.com (mail-yb1-f195.google.com
	[209.85.219.195])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 5F002879
	for <iommu@lists.linux-foundation.org>;
	Sat, 18 May 2019 14:45:28 +0000 (UTC)
Received: by mail-yb1-f195.google.com with SMTP id p134so3852860ybc.4
	for <iommu@lists.linux-foundation.org>;
	Sat, 18 May 2019 07:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=77OQ/lkmsml6JIGkNy6mI1RRxZHIM2FsvrIfk0LDVxY=;
	b=AdfBwGcWiRp4t6iFzrle+NFQHOHvRbIYZrm7PG3CY9l5UcF25lNq5vlnLeAfP2591b
	G/yZTVDvUCuwq4ZxuLok25gP1xkPMFYYLWfKQ1D9Ehx09f3Lhk6tXhAU3tQNo083NFB8
	qnyP08CcF7XzMcjiJclm7q90np3/pNgT8uzZYfUzrqk6hfmiYU292fvtjB5dyI2OHe86
	4GGnQgRt88WUNSzckjwnDrhZlDw8p47U/U1Idw1JUZ0BjkFWXKO5HM9IUQsLOkKeXyrT
	rr809uMQ85jA3zuC2J0S6ZMZJ4KwFrgUE/dPyY8t8Eo+S/Z9710uagbZD2xSt4Cp5RP2
	WJQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=77OQ/lkmsml6JIGkNy6mI1RRxZHIM2FsvrIfk0LDVxY=;
	b=sLqNfTkbdztQ7G9n1r/4vjv6pSIuyWx4RI8axykQH+1QgOLLSyUbdIH4kmNyMRcY3H
	kkm/m4/gnVMbmqfT2nvzQjlw374aZO7NXpqOR7Yw5aDGNqG8qNL/ilvlY9gD0nfNgSKb
	paSrEtIXg9MSId/7hKORzFOXg5A3Zja/1MCDkps8s3GLq9ibcUg1Kz3fQgGR12kEBJYQ
	anncfPad9p3e+NFpC8AifpVc2FyO5p/ydQG26UCR9isZlW8b+nq/3kXIEPhmIWp9NW/z
	CO5K0acQnfZZKiBIPVuDpHDAPE5tshIYiuecMM9DYlPBO/y1ZwLbHk8HKCwpo8tg/RSb
	lCnA==
X-Gm-Message-State: APjAAAVnhjxnCJjIwavhqG3NVLJI7yHyoXP7NA0VRsjsSOOf0EaW0WEI
	mh362HbRm65lZMactw9PKp/09I2LebkWPrBKXJ8=
X-Google-Smtp-Source: APXvYqz8Ud0fDXY9JxGkS+dy5NJLMTqLdeb9pIIxVKprfYnVIb0d0/+pRo/C+qYP+AaKVJMDPptDy2GlVYMckN6N6oE=
X-Received: by 2002:a25:b10f:: with SMTP id g15mr10782445ybj.82.1558190727257; 
	Sat, 18 May 2019 07:45:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190517184659.18828-1-peron.clem@gmail.com>
	<20190517184659.18828-2-peron.clem@gmail.com>
	<CAL_JsqKPazGn+g1zS4NMwvQZ_6GcAm0tgcOTqyQA0dz0+2dp3g@mail.gmail.com>
	<CAJiuCcdMxXAXYk=QpRwsvBUW0tvBVMqXvgx0Y7fAKP=ouyBnKQ@mail.gmail.com>
	<CAL_JsqJgo8NpK00ApBcdtYGW24yuqU=4EMna+r_07=dqceZyyg@mail.gmail.com>
In-Reply-To: <CAL_JsqJgo8NpK00ApBcdtYGW24yuqU=4EMna+r_07=dqceZyyg@mail.gmail.com>
From: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date: Sat, 18 May 2019 16:45:10 +0200
Message-ID: <CAJiuCcfjEqS8BdYdwD22W4hhD27TTs7DPsiEErF_Xt+5Gdkewg@mail.gmail.com>
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

SGksCgpPbiBTYXQsIDE4IE1heSAyMDE5IGF0IDAwOjE3LCBSb2IgSGVycmluZyA8cm9iaCtkdEBr
ZXJuZWwub3JnPiB3cm90ZToKPgo+IE9uIEZyaSwgTWF5IDE3LCAyMDE5IGF0IDU6MDggUE0gQ2zD
qW1lbnQgUMOpcm9uIDxwZXJvbi5jbGVtQGdtYWlsLmNvbT4gd3JvdGU6Cj4gPgo+ID4gSGkgUm9i
LAo+ID4KPiA+IE9uIEZyaSwgMTcgTWF5IDIwMTkgYXQgMjI6MDcsIFJvYiBIZXJyaW5nIDxyb2Jo
K2R0QGtlcm5lbC5vcmc+IHdyb3RlOgo+ID4gPgo+ID4gPiBPbiBGcmksIE1heSAxNywgMjAxOSBh
dCAxOjQ3IFBNIENsw6ltZW50IFDDqXJvbiA8cGVyb24uY2xlbUBnbWFpbC5jb20+IHdyb3RlOgo+
ID4gPiA+Cj4gPiA+ID4gQWxsd2lubmVyIEg2IGhhcyBhbiBBUk0gTWFsaS1UNzIwIE1QMiB3aGlj
aCByZXF1aXJlZCBhIGJ1c19jbG9jay4KPiA+ID4gPgo+ID4gPiA+IEFkZCBhbiBvcHRpb25hbCBi
dXNfY2xvY2sgYXQgdGhlIGluaXQgb2YgdGhlIHBhbmZyb3N0IGRyaXZlci4KPiA+ID4gPgo+ID4g
PiA+IFNpZ25lZC1vZmYtYnk6IENsw6ltZW50IFDDqXJvbiA8cGVyb24uY2xlbUBnbWFpbC5jb20+
Cj4gPiA+ID4gLS0tCj4gPiA+ID4gIGRyaXZlcnMvZ3B1L2RybS9wYW5mcm9zdC9wYW5mcm9zdF9k
ZXZpY2UuYyB8IDI1ICsrKysrKysrKysrKysrKysrKysrKy0KPiA+ID4gPiAgZHJpdmVycy9ncHUv
ZHJtL3BhbmZyb3N0L3BhbmZyb3N0X2RldmljZS5oIHwgIDEgKwo+ID4gPiA+ICAyIGZpbGVzIGNo
YW5nZWQsIDI1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPiA+ID4gPgo+ID4gPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcGFuZnJvc3QvcGFuZnJvc3RfZGV2aWNlLmMgYi9k
cml2ZXJzL2dwdS9kcm0vcGFuZnJvc3QvcGFuZnJvc3RfZGV2aWNlLmMKPiA+ID4gPiBpbmRleCAz
YjJiY2VkMWIwMTUuLjhkYTZlNjEyZDM4NCAxMDA2NDQKPiA+ID4gPiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vcGFuZnJvc3QvcGFuZnJvc3RfZGV2aWNlLmMKPiA+ID4gPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vcGFuZnJvc3QvcGFuZnJvc3RfZGV2aWNlLmMKPiA+ID4gPiBAQCAtNDQsNyArNDQsOCBA
QCBzdGF0aWMgaW50IHBhbmZyb3N0X2Nsa19pbml0KHN0cnVjdCBwYW5mcm9zdF9kZXZpY2UgKnBm
ZGV2KQo+ID4gPiA+Cj4gPiA+ID4gICAgICAgICBwZmRldi0+Y2xvY2sgPSBkZXZtX2Nsa19nZXQo
cGZkZXYtPmRldiwgTlVMTCk7Cj4gPiA+ID4gICAgICAgICBpZiAoSVNfRVJSKHBmZGV2LT5jbG9j
aykpIHsKPiA+ID4gPiAtICAgICAgICAgICAgICAgZGV2X2VycihwZmRldi0+ZGV2LCAiZ2V0IGNs
b2NrIGZhaWxlZCAlbGRcbiIsIFBUUl9FUlIocGZkZXYtPmNsb2NrKSk7Cj4gPiA+ID4gKyAgICAg
ICAgICAgICAgIGRldl9lcnIocGZkZXYtPmRldiwgImdldCBjbG9jayBmYWlsZWQgJWxkXG4iLAo+
ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIFBUUl9FUlIocGZkZXYtPmNsb2NrKSk7Cj4g
PiA+Cj4gPiA+IFBsZWFzZSBkcm9wIHRoaXMgd2hpdGVzcGFjZSBjaGFuZ2UuCj4gPgo+ID4gU29y
cnksIEkgdGhvdWdodCBpdCB3YXMgb25seSBhIG1pc3Rha2UgaGVyZSwgSSB3aWxsIGRyb3AgaXQu
Cj4gPiBXaHkgYXJlIHRoZXkgc28gbWFueSBsaW5lcyBvdmVyIDgwIGNoYXJhY3RlcnM/Cj4KPiBJ
J2QgZ3Vlc3MgbW9zdCBhcmUgcHJpbnRzIGFuZC9vciBqdXN0IHNsaWdodGx5IG92ZXIuCj4KPiA+
IElzIHRoZXJlIGEgc3BlY2lmaWMgY29kaW5nIHN0eWxlIHRvIGZvbGxvdyA/Cj4KPiBZZXMsIGJ1
dCBnZW5lcmFsbHkgdGhlIDgwIGNoYXJhY3RlciB0aGluZyBpcyBtb3JlIGEgZ3VpZGFuY2UuIE5v
dAo+IGhhdmluZyB1bnJlbGF0ZWQgY2hhbmdlcyBpbiBhIHNpbmdsZSBjb21taXQgaXMgbW9yZSBv
ZiBhIGhhcmQgcnVsZS4KCk9rLCB0aGFua3MgZm9yIHRoZSBjbGFyaWZpY2F0aW9uLgoKQ2zDqW1l
bnQKCj4KPiBSb2IKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
