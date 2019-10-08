Return-Path: <SRS0=3Hvu=YB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06808ECE58C
	for <iommu@archiver.kernel.org>; Tue,  8 Oct 2019 20:21:54 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 721CF21871
	for <iommu@archiver.kernel.org>; Tue,  8 Oct 2019 20:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFqMTY83"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 721CF21871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 05E0CC77;
	Tue,  8 Oct 2019 20:21:53 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 06FD949F
	for <iommu@lists.linux-foundation.org>;
	Tue,  8 Oct 2019 20:21:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com
	[209.85.222.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 44CF414D
	for <iommu@lists.linux-foundation.org>;
	Tue,  8 Oct 2019 20:21:51 +0000 (UTC)
Received: by mail-qk1-f193.google.com with SMTP id q203so118592qke.1
	for <iommu@lists.linux-foundation.org>;
	Tue, 08 Oct 2019 13:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=Lb2Je/FVvSIp4JAjesvlduQNxjeyTsmsHcBjn2d15pA=;
	b=gFqMTY83ri1G1Q3a3+d/vgKrQH13AeMQFKA5+3XCUQQ5VxAjg/DDRTj63/JC1oxUmL
	4uQDT9L5LDFglDW/XmySnTbZPbIenfUZeSuWuYPFrKbgXYrLTmz07yXpJ6M2WoS4+rN7
	Tatp7IOPVa/gpWTOfsUsNquL9GOvbj7Z4pLFsEfuR/aUPcOF5xcEdXxVAGn57QsmFgdF
	CFHDapQacOmH2FVH5aD+AK6HgMYYPu3YOBkTJhuf788UfGtQiDFqHrakFGXti/zvMHWu
	ld6WVH/Yp/I0qejzXbHbbVCXef4OY822Z6LC0wOuf0TFCwJ6HmucFyGJqFEfD/DrWzvC
	veMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=Lb2Je/FVvSIp4JAjesvlduQNxjeyTsmsHcBjn2d15pA=;
	b=esRRaSfAi20WPxJrUCwGSvJ32HAz7grLBH2XnrqTi+J61mjT8/sOz+7qNaGjD5sTAp
	mPiS9C1on+te1zezc0oGybMW2aELF2KnCiWnsh+SwlTOp8JTcwR77bSDxVmfmbsyR5Yy
	yIV9RBHh7XFitUwUUGEBhiVAcQZl1XGBbe/UhPfgRP3n7mU98UG5wTDHH70abgr0Fq7o
	UHrs7RGrhUDbJjedzR9H9GSV7yPCtWw4PIWO09CFzY3BuTANoEDumZ1EDDIpmRJIyoSY
	aB25k382ZpzWp+l5oGgd9Y/Eh7n2ruP3f9TQzWhy+h3wHTcqPKCd7kgH72ahlld0xalQ
	VSeg==
X-Gm-Message-State: APjAAAXw3SdqItND/gBJfunmuvTdbNAS8tcHHqVhjGlkYX02zoj3wIN3
	Mx7FSkGJmA/Dw0TNaSECHKg6bxskY9PdPJxADho=
X-Google-Smtp-Source: APXvYqyCME5OyPZ4LEHQGOMvfISR2tdIQhh93r/3wK1dT60Ej4LS72zq2S8E42mYxfOZG12f0ilc0Gnlb3E73t9ysmc=
X-Received: by 2002:a05:620a:15d2:: with SMTP id
	o18mr19079989qkm.341.1570566109995; 
	Tue, 08 Oct 2019 13:21:49 -0700 (PDT)
MIME-Version: 1.0
References: <20191008135843.30640-1-enric.balletbo@collabora.com>
	<3132916.nyj3dfveGU@diego>
In-Reply-To: <3132916.nyj3dfveGU@diego>
From: Enric Balletbo Serra <eballetbo@gmail.com>
Date: Tue, 8 Oct 2019 22:21:39 +0200
Message-ID: <CAFqH_50xbB-+zEffHYPt+NPCVAikQpcWc_uxbkA0a6ppT5OJQA@mail.gmail.com>
Subject: Re: [PATCH] iommu/rockchip: Don't loop until failure to count
	interrupts
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
	Doug Anderson <dianders@chromium.org>,
	"open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
	iommu@lists.linux-foundation.org, Matthias Kaehlcke <mka@chromium.org>,
	Enric Balletbo i Serra <enric.balletbo@collabora.com>,
	Guenter Roeck <groeck@chromium.org>,
	Collabora Kernel ML <kernel@collabora.com>,
	Benson Leung <bleung@chromium.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>
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

SGkgSGVpa28sCgpNaXNzYXRnZSBkZSBIZWlrbyBTdMO8Ym5lciA8aGVpa29Ac250ZWNoLmRlPiBk
ZWwgZGlhIGR0LiwgOCBk4oCZb2N0LiAyMDE5CmEgbGVzIDE5OjU4Ogo+Cj4gSGkgRW5yaWMsCj4K
PiBBbSBEaWVuc3RhZywgOC4gT2t0b2JlciAyMDE5LCAxNTo1ODo0MyBDRVNUIHNjaHJpZWIgRW5y
aWMgQmFsbGV0Ym8gaSBTZXJyYToKPiA+IEFzIHBsYXRmb3JtX2dldF9pcnEoKSBub3cgcHJpbnRz
IGFuIGVycm9yIHdoZW4gdGhlIGludGVycnVwdCBkb2VzIG5vdAo+ID4gZXhpc3QsIGNvdW50aW5n
IGludGVycnVwdHMgYnkgbG9vcGluZyB1bnRpbCBmYWlsdXJlIGNhdXNlcyB0aGUgcHJpbnRpbmcK
PiA+IG9mIHNjYXJ5IG1lc3NhZ2VzIGxpa2U6Cj4gPgo+ID4gIHJrX2lvbW11IGZmOTI0MDAwLmlv
bW11OiBJUlEgaW5kZXggMSBub3QgZm91bmQKPiA+ICBya19pb21tdSBmZjkxNDAwMC5pb21tdTog
SVJRIGluZGV4IDEgbm90IGZvdW5kCj4gPiAgcmtfaW9tbXUgZmY5MDNmMDAuaW9tbXU6IElSUSBp
bmRleCAxIG5vdCBmb3VuZAo+ID4gIHJrX2lvbW11IGZmOGYzZjAwLmlvbW11OiBJUlEgaW5kZXgg
MSBub3QgZm91bmQKPiA+ICBya19pb21tdSBmZjY1MDgwMC5pb21tdTogSVJRIGluZGV4IDEgbm90
IGZvdW5kCj4gPgo+ID4gRml4IHRoaXMgYnkgdXNpbmcgdGhlIHBsYXRmb3JtX2lycV9jb3VudCgp
IGhlbHBlciB0byBhdm9pZCB0b3VjaGluZwo+ID4gbm9uLWV4aXN0ZW50IGludGVycnVwdHMuCj4K
PiBJdCBsb29rcyBsaWtlIHdlIGRpZCB0aGUgc2FtZSBmaXggLi4uIHNlZSBteSBwYXRjaCBmcm9t
IHNlcHRlbWJlciAyNToKPiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzExMTYx
MjIxLwo+CgpIb3cgaW4gdGhlIGhlbGwgSSBkaWRuJ3QgY2F0Y2ggdGhpcyBwYXRjaCEgQW55d2F5
LCBmb3JnZXQgYWJvdXQgdGhpcwpwYXRjaCB0aGVuLCBzb3JyeSBmb3IgdGhlIG5vaXNlLgoKVGhh
bmtzLAogRW5yaWMKCj4KPiA+IEZpeGVzOiA3NzIzZjRjNWVjZGI4ZDgzICgiZHJpdmVyIGNvcmU6
IHBsYXRmb3JtOiBBZGQgYW4gZXJyb3IgbWVzc2FnZSB0byBwbGF0Zm9ybV9nZXRfaXJxKigpIikK
PiA+IFNpZ25lZC1vZmYtYnk6IEVucmljIEJhbGxldGJvIGkgU2VycmEgPGVucmljLmJhbGxldGJv
QGNvbGxhYm9yYS5jb20+Cj4gPiAtLS0KPiA+Cj4gPiAgZHJpdmVycy9pb21tdS9yb2NrY2hpcC1p
b21tdS5jIHwgMzUgKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLQo+ID4gIDEgZmls
ZSBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkKPiA+Cj4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9pb21tdS9yb2NrY2hpcC1pb21tdS5jIGIvZHJpdmVycy9pb21tdS9y
b2NrY2hpcC1pb21tdS5jCj4gPiBpbmRleCAyNjI5MGYzMTBmOTAuLjhjNjMxOGJkMWIzNyAxMDA2
NDQKPiA+IC0tLSBhL2RyaXZlcnMvaW9tbXUvcm9ja2NoaXAtaW9tbXUuYwo+ID4gKysrIGIvZHJp
dmVycy9pb21tdS9yb2NrY2hpcC1pb21tdS5jCj4gPiBAQCAtMTEzNiw3ICsxMTM2LDcgQEAgc3Rh
dGljIGludCBya19pb21tdV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQo+ID4g
ICAgICAgc3RydWN0IHJrX2lvbW11ICppb21tdTsKPiA+ICAgICAgIHN0cnVjdCByZXNvdXJjZSAq
cmVzOwo+ID4gICAgICAgaW50IG51bV9yZXMgPSBwZGV2LT5udW1fcmVzb3VyY2VzOwo+ID4gLSAg
ICAgaW50IGVyciwgaSwgaXJxOwo+ID4gKyAgICAgaW50IGVyciwgaSwgaXJxLCBudW1faXJxczsK
PiA+Cj4gPiAgICAgICBpb21tdSA9IGRldm1fa3phbGxvYyhkZXYsIHNpemVvZigqaW9tbXUpLCBH
RlBfS0VSTkVMKTsKPiA+ICAgICAgIGlmICghaW9tbXUpCj4gPiBAQCAtMTIxOSwyMCArMTIxOSwy
OCBAQCBzdGF0aWMgaW50IHJrX2lvbW11X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBk
ZXYpCj4gPgo+ID4gICAgICAgcG1fcnVudGltZV9lbmFibGUoZGV2KTsKPiA+Cj4gPiAtICAgICBp
ID0gMDsKPiA+IC0gICAgIHdoaWxlICgoaXJxID0gcGxhdGZvcm1fZ2V0X2lycShwZGV2LCBpKysp
KSAhPSAtRU5YSU8pIHsKPiA+IC0gICAgICAgICAgICAgaWYgKGlycSA8IDApCj4gPiAtICAgICAg
ICAgICAgICAgICAgICAgcmV0dXJuIGlycTsKPiA+ICsgICAgIG51bV9pcnFzID0gcGxhdGZvcm1f
aXJxX2NvdW50KHBkZXYpOwo+ID4gKyAgICAgaWYgKG51bV9pcnFzIDwgMCkgewo+ID4gKyAgICAg
ICAgICAgICBlcnIgPSBudW1faXJxczsKPiA+ICsgICAgICAgICAgICAgZ290byBlcnJfZGlzYWJs
ZV9wbV9ydW50aW1lOwo+ID4gKyAgICAgfQo+Cj4gQnkgbW92aW5nIHRoZSBiYXNpYyBpcnEgY291
bnQgYWJvdmUgdGhlIHBtX3J1bnRpbWVfZW5hYmxlCj4geW91IHNhdmUgc29tZSBsaW5lcyBhbmQg
dGhlIHdob2xlIGdvdG8gbG9naWMgLi4uIHNlZSBteSBwYXRjaAo+IGZvciByZWZlcmVuY2UgOi1E
Cj4KPiBIZWlrbwo+Cj4gPiArCj4gPiArICAgICBmb3IgKGkgPSAwOyBpIDwgbnVtX2lycXM7IGkr
Kykgewo+ID4gKyAgICAgICAgICAgICBpcnEgPSBwbGF0Zm9ybV9nZXRfaXJxKHBkZXYsIGkpOwo+
ID4gKyAgICAgICAgICAgICBpZiAoaXJxIDwgMCkgewo+ID4gKyAgICAgICAgICAgICAgICAgICAg
IGVyciA9IGlycTsKPiA+ICsgICAgICAgICAgICAgICAgICAgICBnb3RvIGVycl9kaXNhYmxlX3Bt
X3J1bnRpbWU7Cj4gPiArICAgICAgICAgICAgIH0KPiA+Cj4gPiAgICAgICAgICAgICAgIGVyciA9
IGRldm1fcmVxdWVzdF9pcnEoaW9tbXUtPmRldiwgaXJxLCBya19pb21tdV9pcnEsCj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgSVJRRl9TSEFSRUQsIGRldl9uYW1lKGRl
diksIGlvbW11KTsKPiA+IC0gICAgICAgICAgICAgaWYgKGVycikgewo+ID4gLSAgICAgICAgICAg
ICAgICAgICAgIHBtX3J1bnRpbWVfZGlzYWJsZShkZXYpOwo+ID4gLSAgICAgICAgICAgICAgICAg
ICAgIGdvdG8gZXJyX3JlbW92ZV9zeXNmczsKPiA+IC0gICAgICAgICAgICAgfQo+ID4gKyAgICAg
ICAgICAgICBpZiAoZXJyKQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIGdvdG8gZXJyX2Rpc2Fi
bGVfcG1fcnVudGltZTsKPiA+ICAgICAgIH0KPiA+Cj4gPiAgICAgICByZXR1cm4gMDsKPiA+ICtl
cnJfZGlzYWJsZV9wbV9ydW50aW1lOgo+ID4gKyAgICAgcG1fcnVudGltZV9kaXNhYmxlKGRldik7
Cj4gPiAgZXJyX3JlbW92ZV9zeXNmczoKPiA+ICAgICAgIGlvbW11X2RldmljZV9zeXNmc19yZW1v
dmUoJmlvbW11LT5pb21tdSk7Cj4gPiAgZXJyX3B1dF9ncm91cDoKPiA+IEBAIC0xMjQ1LDEwICsx
MjUzLDE1IEBAIHN0YXRpYyBpbnQgcmtfaW9tbXVfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rldmlj
ZSAqcGRldikKPiA+ICBzdGF0aWMgdm9pZCBya19pb21tdV9zaHV0ZG93bihzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlICpwZGV2KQo+ID4gIHsKPiA+ICAgICAgIHN0cnVjdCBya19pb21tdSAqaW9tbXUg
PSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShwZGV2KTsKPiA+IC0gICAgIGludCBpID0gMCwgaXJxOwo+
ID4gKyAgICAgaW50IGksIGlycSwgbnVtX2lycXM7Cj4gPgo+ID4gLSAgICAgd2hpbGUgKChpcnEg
PSBwbGF0Zm9ybV9nZXRfaXJxKHBkZXYsIGkrKykpICE9IC1FTlhJTykKPiA+ICsgICAgIG51bV9p
cnFzID0gcGxhdGZvcm1faXJxX2NvdW50KHBkZXYpOwo+ID4gKyAgICAgZm9yIChpID0gMDsgaSA8
IG51bV9pcnFzOyBpKyspIHsKPiA+ICsgICAgICAgICAgICAgaXJxID0gcGxhdGZvcm1fZ2V0X2ly
cShwZGV2LCBpKTsKPiA+ICsgICAgICAgICAgICAgaWYgKGlycSA8IDApCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgY29udGludWU7Cj4gPiAgICAgICAgICAgICAgIGRldm1fZnJlZV9pcnEoaW9t
bXUtPmRldiwgaXJxLCBpb21tdSk7Cj4gPiArICAgICB9Cj4gPgo+ID4gICAgICAgcG1fcnVudGlt
ZV9mb3JjZV9zdXNwZW5kKCZwZGV2LT5kZXYpOwo+ID4gIH0KPiA+Cj4KPgo+Cj4KPgo+IF9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gTGludXgtcm9ja2No
aXAgbWFpbGluZyBsaXN0Cj4gTGludXgtcm9ja2NoaXBAbGlzdHMuaW5mcmFkZWFkLm9yZwo+IGh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtcm9ja2NoaXAK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFp
bGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
