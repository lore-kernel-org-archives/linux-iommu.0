Return-Path: <SRS0=Ln9J=CK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67612C43461
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 23:17:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 316DC206EF
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 23:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZYj8rqV3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 316DC206EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0DE368710C;
	Tue,  1 Sep 2020 23:17:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zaw3KXQhQFvF; Tue,  1 Sep 2020 23:17:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5A06587022;
	Tue,  1 Sep 2020 23:17:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4B9FFC07FF;
	Tue,  1 Sep 2020 23:17:10 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9E603C0051
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 23:17:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 849DC87022
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 23:17:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g8qD81ihhNv7 for <iommu@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 23:17:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 983CC87122
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 23:17:07 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1633B214F1
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 23:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599002227;
 bh=dEzwxEuUgfYnGt8tTDL/A1NPb+fEcrJH6io3xPpZIAI=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=ZYj8rqV3HROpw6CDvgMVd5hZg5rBDjH4RSJIo5SPOM7Ja7YqDakNre623J7KNMdv9
 zpEb0CzMeczKHCD4/DAAOODJN5n6te/K7xaUjswZj03FpVUJmbOxdsGfuH5owN08yV
 Y8JxqXzezZAiQVMZxYJlE3EINQVxw7bVxJS2ykFo=
Received: by mail-ej1-f53.google.com with SMTP id m22so3978236eje.10
 for <iommu@lists.linux-foundation.org>; Tue, 01 Sep 2020 16:17:07 -0700 (PDT)
X-Gm-Message-State: AOAM531LzW6iJw/kyVPaHv+epxz/Vfs+4R6Blse9FlnbR/vhPPFtgjYM
 yBBvwBEZtKnTM2bTvu8PdA2EuU5iCZDBTBdCsA==
X-Google-Smtp-Source: ABdhPJxjGeMplEAO/cPVthJXCGCEi6FG3fNO07cenYqDxG9mxyLxAmv8N/2WWybtiLb8XagSSQ/Sw0SUTCoZ0nSCAFg=
X-Received: by 2002:a17:906:119b:: with SMTP id
 n27mr3661770eja.124.1599002225526; 
 Tue, 01 Sep 2020 16:17:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200826063316.23486-1-m.szyprowski@samsung.com>
 <CGME20200826063534eucas1p2647f5e9679f79f568e184b092f743f8b@eucas1p2.samsung.com>
 <20200826063316.23486-12-m.szyprowski@samsung.com>
 <30f20ad6-783b-89c3-17b5-30c6a2587d23@arm.com>
In-Reply-To: <30f20ad6-783b-89c3-17b5-30c6a2587d23@arm.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Wed, 2 Sep 2020 07:16:54 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9BaFZbiGFYjat4vJ-_kEONXxfgcTRPd6aKoeKJ7xxBww@mail.gmail.com>
Message-ID: <CAAOTY_9BaFZbiGFYjat4vJ-_kEONXxfgcTRPd6aKoeKJ7xxBww@mail.gmail.com>
Subject: Re: [PATCH v9 11/32] drm: mediatek: use common helper for extracting
 pages array
To: Robin Murphy <robin.murphy@arm.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, linux-kernel <linux-kernel@vger.kernel.org>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 linaro-mm-sig@lists.linaro.org, iommu@lists.linux-foundation.org,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
 Christoph Hellwig <hch@lst.de>,
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

Um9iaW4gTXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4g5pa8IDIwMjDlubQ55pyIMuaXpSDp
gLHkuIkg5LiK5Y2IMjo1NeWvq+mBk++8mgo+Cj4gT24gMjAyMC0wOC0yNiAwNzozMiwgTWFyZWsg
U3p5cHJvd3NraSB3cm90ZToKPiA+IFVzZSBjb21tb24gaGVscGVyIGZvciBjb252ZXJ0aW5nIGEg
c2dfdGFibGUgb2JqZWN0IGludG8gc3RydWN0Cj4gPiBwYWdlIHBvaW50ZXIgYXJyYXkuCj4KPiBS
ZXZpZXdlZC1ieTogUm9iaW4gTXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4KPgo+IFNpZGUg
bm90ZTogaXMgbXRrX2RybV9nZW1fcHJpbWVfdm1hcCgpIG1pc3NpbmcgYSBjYWxsIHRvCj4gc2df
ZnJlZV90YWJsZShzZ3QpIGJlZm9yZSBpdHMga2ZyZWUoc2d0KT8KClllcywgd2UgbmVlZCBhbm90
aGVyIHBhdGNoIHRvIGZpeCB0aGF0IGJ1ZywgQnV0IGZvciB0aGlzIHBhdGNoLAoKQWNrZWQtYnk6
IENodW4tS3VhbmcgSHUgPGNodW5rdWFuZy5odUBrZXJuZWwub3JnPgoKPgo+ID4gU2lnbmVkLW9m
Zi1ieTogTWFyZWsgU3p5cHJvd3NraSA8bS5zenlwcm93c2tpQHNhbXN1bmcuY29tPgo+ID4gLS0t
Cj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2dlbS5jIHwgOSArKy0tLS0t
LS0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkK
PiA+Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZ2Vt
LmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9nZW0uYwo+ID4gaW5kZXggMzY1
NGVjNzMyMDI5Li4wNTgzZTU1N2FkMzcgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2RybV9nZW0uYwo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kcm1fZ2VtLmMKPiA+IEBAIC0yMzMsOSArMjMzLDcgQEAgdm9pZCAqbXRrX2RybV9nZW1f
cHJpbWVfdm1hcChzdHJ1Y3QgZHJtX2dlbV9vYmplY3QgKm9iaikKPiA+ICAgewo+ID4gICAgICAg
c3RydWN0IG10a19kcm1fZ2VtX29iaiAqbXRrX2dlbSA9IHRvX210a19nZW1fb2JqKG9iaik7Cj4g
PiAgICAgICBzdHJ1Y3Qgc2dfdGFibGUgKnNndDsKPiA+IC0gICAgIHN0cnVjdCBzZ19wYWdlX2l0
ZXIgaXRlcjsKPiA+ICAgICAgIHVuc2lnbmVkIGludCBucGFnZXM7Cj4gPiAtICAgICB1bnNpZ25l
ZCBpbnQgaSA9IDA7Cj4gPgo+ID4gICAgICAgaWYgKG10a19nZW0tPmt2YWRkcikKPiA+ICAgICAg
ICAgICAgICAgcmV0dXJuIG10a19nZW0tPmt2YWRkcjsKPiA+IEBAIC0yNDksMTEgKzI0Nyw4IEBA
IHZvaWQgKm10a19kcm1fZ2VtX3ByaW1lX3ZtYXAoc3RydWN0IGRybV9nZW1fb2JqZWN0ICpvYmop
Cj4gPiAgICAgICBpZiAoIW10a19nZW0tPnBhZ2VzKQo+ID4gICAgICAgICAgICAgICBnb3RvIG91
dDsKPiA+Cj4gPiAtICAgICBmb3JfZWFjaF9zZ19wYWdlKHNndC0+c2dsLCAmaXRlciwgc2d0LT5v
cmlnX25lbnRzLCAwKSB7Cj4gPiAtICAgICAgICAgICAgIG10a19nZW0tPnBhZ2VzW2krK10gPSBz
Z19wYWdlX2l0ZXJfcGFnZSgmaXRlcik7Cj4gPiAtICAgICAgICAgICAgIGlmIChpID4gbnBhZ2Vz
KQo+ID4gLSAgICAgICAgICAgICAgICAgICAgIGJyZWFrOwo+ID4gLSAgICAgfQo+ID4gKyAgICAg
ZHJtX3ByaW1lX3NnX3RvX3BhZ2VfYWRkcl9hcnJheXMoc2d0LCBtdGtfZ2VtLT5wYWdlcywgTlVM
TCwgbnBhZ2VzKTsKPiA+ICsKPiA+ICAgICAgIG10a19nZW0tPmt2YWRkciA9IHZtYXAobXRrX2dl
bS0+cGFnZXMsIG5wYWdlcywgVk1fTUFQLAo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBwZ3Byb3Rfd3JpdGVjb21iaW5lKFBBR0VfS0VSTkVMKSk7Cj4gPgo+ID4KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0Cmlv
bW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
