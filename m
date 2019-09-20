Return-Path: <SRS0=xPYy=XP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE51C4CEC9
	for <iommu@archiver.kernel.org>; Fri, 20 Sep 2019 19:33:11 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 129C02080F
	for <iommu@archiver.kernel.org>; Fri, 20 Sep 2019 19:33:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 129C02080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D183DBBC;
	Fri, 20 Sep 2019 19:33:10 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 1E960BA0
	for <iommu@lists.linux-foundation.org>;
	Fri, 20 Sep 2019 19:33:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com
	[209.85.160.195])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B083E875
	for <iommu@lists.linux-foundation.org>;
	Fri, 20 Sep 2019 19:33:08 +0000 (UTC)
Received: by mail-qt1-f195.google.com with SMTP id d2so9997261qtr.4
	for <iommu@lists.linux-foundation.org>;
	Fri, 20 Sep 2019 12:33:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=eW5Bek3/qrhSN7Ue9OhcG1dQFZzCZfqK/a8zEZpkGic=;
	b=fXPCoGUj5JvciH6kElz8kf9eIT+xBEm8UML/FmFeCmLggqv7ZE7UNw9JARC039qxWF
	ffw458eyRrCHLKt3bgAyoPG/LzxqSE8aG0i97SMWTmdoHGIra61W3s/GqbAgH1veZnjt
	PUAnp4RDro8NKYGkO8H/OtxtB3Sp3vU+S8fHs9+IG39ot4X0BSCaU/a7azKE1PhWOZLL
	MUHSbd5soeGFM67q+fViFFqGoeuDCijElNfI6V76dvDvPJu81RHtMUa+LUYa6+a0LyqR
	KBqh9jioHDpGPS9w/+3A6J4N9iKfTR3agF364D+1mdrHtl6uiuRU5UVbEqAnQIrump87
	m6TA==
X-Gm-Message-State: APjAAAWXQ5WVKXKPXCAjMdW+5kv4lDLnIjnPmLrO7lafpAUdBslMOKO1
	ptR/FT68kf2JF3Tb42hYo6o8MM4PoTOyX2FcEyg=
X-Google-Smtp-Source: APXvYqym/h2HHN3oASxR0ab7JXUTumeom5UHRPWJfFci8Kj44M6ZMOAgSvcKmbeBpxcHn1UCl/SFotB4KE0LZpDpGWI=
X-Received: by 2002:a0c:8aa1:: with SMTP id 30mr14417394qvv.93.1569007987460; 
	Fri, 20 Sep 2019 12:33:07 -0700 (PDT)
MIME-Version: 1.0
References: <dc354ede-5963-cd7f-ee53-f3df3061d39a@gmail.com>
	<20190725024129.22664-1-yuehaibing@huawei.com>
	<dd547b44-7abb-371f-aeee-a82b96f824e2@gmail.com>
In-Reply-To: <dd547b44-7abb-371f-aeee-a82b96f824e2@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 20 Sep 2019 21:32:51 +0200
Message-ID: <CAK8P3a2Lxv6Wz3jv0eeNc7mfvNzSvh37QEx51W39eUnYPsxaYw@mail.gmail.com>
Subject: Re: [PATCH] media: staging: tegra-vde: Fix build error
To: Dmitry Osipenko <digetx@gmail.com>
Cc: driverdevel <devel@driverdev.osuosl.org>,
	gregkh <gregkh@linuxfoundation.org>, YueHaibing <yuehaibing@huawei.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	"open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	"open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Linux Media Mailing List <linux-media@vger.kernel.org>
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

T24gVGh1LCBKdWwgMjUsIDIwMTkgYXQgMjoyNCBQTSBEbWl0cnkgT3NpcGVua28gPGRpZ2V0eEBn
bWFpbC5jb20+IHdyb3RlOgo+Cj4gMjUuMDcuMjAxOSA1OjQxLCBZdWVIYWliaW5nINC/0LjRiNC1
0YI6Cj4gPiBJZiBJT01NVV9TVVBQT1JUIGlzIG5vdCBzZXQsIGFuZCBDT01QSUxFX1RFU1QgaXMg
eSwKPiA+IElPTU1VX0lPVkEgbWF5IGJlIHNldCB0byBtLiBTbyBidWlsZGluZyB3aWxsIGZhaWxz
Ogo+ID4KPiA+IGRyaXZlcnMvc3RhZ2luZy9tZWRpYS90ZWdyYS12ZGUvaW9tbXUubzogSW4gZnVu
Y3Rpb24gYHRlZ3JhX3ZkZV9pb21tdV9tYXAnOgo+ID4gaW9tbXUuYzooLnRleHQrMHg0MSk6IHVu
ZGVmaW5lZCByZWZlcmVuY2UgdG8gYGFsbG9jX2lvdmEnCj4gPiBpb21tdS5jOigudGV4dCsweDU2
KTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgX19mcmVlX2lvdmEnCj4gPgo+ID4gU2VsZWN0IElP
TU1VX0lPVkEgd2hpbGUgQ09NUElMRV9URVNUIGlzIHNldCB0byBmaXggdGhpcy4KCj4gPiBAQCAt
Myw3ICszLDcgQEAgY29uZmlnIFRFR1JBX1ZERQo+ID4gICAgICAgdHJpc3RhdGUgIk5WSURJQSBU
ZWdyYSBWaWRlbyBEZWNvZGVyIEVuZ2luZSBkcml2ZXIiCj4gPiAgICAgICBkZXBlbmRzIG9uIEFS
Q0hfVEVHUkEgfHwgQ09NUElMRV9URVNUCj4gPiAgICAgICBzZWxlY3QgRE1BX1NIQVJFRF9CVUZG
RVIKPiA+IC0gICAgIHNlbGVjdCBJT01NVV9JT1ZBIGlmIElPTU1VX1NVUFBPUlQKPiA+ICsgICAg
IHNlbGVjdCBJT01NVV9JT1ZBIGlmIChJT01NVV9TVVBQT1JUIHx8IENPTVBJTEVfVEVTVCkKPiA+
ICAgICAgIHNlbGVjdCBTUkFNCj4gPiAgICAgICBoZWxwCj4gPiAgICAgICAgICAgU2F5IFkgaGVy
ZSB0byBlbmFibGUgc3VwcG9ydCBmb3IgdGhlIE5WSURJQSBUZWdyYSB2aWRlbyBkZWNvZGVyCj4g
Pgo+Cj4gVGhpcyByZXN1bHRzIGluIG1pc3NpbmcgdGhlIGNhc2Ugb2YgY29tcGlsZS10ZXN0aW5n
ICFJT01NVV9JT1ZBIGZvciB0aGUKPiBkcml2ZXIsIGJ1dCBwcm9iYWJseSB0aGF0J3Mgbm90IGEg
YmlnIGRlYWwuCj4KPiBBY2tlZC1ieTogRG1pdHJ5IE9zaXBlbmtvIDxkaWdldHhAZ21haWwuY29t
PgoKSSBkb24ndCBrbm93IHdoYXQgaGFwcGVuZWQgaGVyZSwgYnV0IHRoZSBwYXRjaCBmcm9tIFl1
ZUhhaWJpbmcgY2F1c2VkIHRoaXMKZXJyb3IgZm9yIG1lLCB3aGljaCBpcyB2ZXJ5IG11Y2ggbGlr
ZSB0aGUgcHJvYmxlbSBpdCB3YXMgbWVhbnQgdG8gZml4OgoKZHJpdmVycy9ncHUvaG9zdDF4L2Rl
di5vOiBJbiBmdW5jdGlvbiBgaG9zdDF4X3Byb2JlJzoKZGV2LmM6KC50ZXh0KzB4MTczNCk6IHVu
ZGVmaW5lZCByZWZlcmVuY2UgdG8gYHB1dF9pb3ZhX2RvbWFpbicKZGV2LmM6KC50ZXh0KzB4MTc0
NCk6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYGlvdmFfY2FjaGVfcHV0Jwpkcml2ZXJzL2dwdS9o
b3N0MXgvZGV2Lm86IEluIGZ1bmN0aW9uIGBob3N0MXhfcmVtb3ZlJzoKZGV2LmM6KC50ZXh0KzB4
MTg5NCk6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYHB1dF9pb3ZhX2RvbWFpbicKZGV2LmM6KC50
ZXh0KzB4MTg5OCk6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYGlvdmFfY2FjaGVfcHV0Jwpkcml2
ZXJzL2dwdS9ob3N0MXgvY2RtYS5vOiBJbiBmdW5jdGlvbiBgaG9zdDF4X2NkbWFfaW5pdCc6CmNk
bWEuYzooLnRleHQrMHg1ZDApOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBhbGxvY19pb3ZhJwpj
ZG1hLmM6KC50ZXh0KzB4NjFjKTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgX19mcmVlX2lvdmEn
CmRyaXZlcnMvZ3B1L2hvc3QxeC9jZG1hLm86IEluIGZ1bmN0aW9uIGBob3N0MXhfY2RtYV9kZWlu
aXQnOgpjZG1hLmM6KC50ZXh0KzB4NmM4KTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgZnJlZV9p
b3ZhJwpkcml2ZXJzL2dwdS9ob3N0MXgvam9iLm86IEluIGZ1bmN0aW9uIGBob3N0MXhfam9iX3Bp
bic6CmpvYi5jOigudGV4dCsweDUxNCk6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYGFsbG9jX2lv
dmEnCmpvYi5jOigudGV4dCsweDUyOCk6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYF9fZnJlZV9p
b3ZhJwpkcml2ZXJzL2dwdS9ob3N0MXgvam9iLm86IEluIGZ1bmN0aW9uIGBob3N0MXhfam9iX3Vu
cGluJzoKam9iLmM6KC50ZXh0KzB4NWJjKTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgZnJlZV9p
b3ZhJwoKQWZ0ZXIgcmV2ZXJ0aGluZyBjb21taXQgNmIyMjY1OTc1MjM5ICgibWVkaWE6IHN0YWdp
bmc6CnRlZ3JhLXZkZTogRml4IGJ1aWxkIGVycm9yIiksIEkgY2FuIG5vIGxvbmdlciByZXByb2R1
Y2UgdGhlCmlzc3VlLgoKICAgICAgIEFybmQKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2lvbW11
