Return-Path: <SRS0=V2Kg=P5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A742DC433F5
	for <iommu@archiver.kernel.org>; Wed, 10 Nov 2021 20:19:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51EE461248
	for <iommu@archiver.kernel.org>; Wed, 10 Nov 2021 20:19:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 51EE461248
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2D63D404B7;
	Wed, 10 Nov 2021 20:19:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZUzfjuG89Sok; Wed, 10 Nov 2021 20:19:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 27EF3401D5;
	Wed, 10 Nov 2021 20:19:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0EB37C0033;
	Wed, 10 Nov 2021 20:19:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B0549C001E
 for <iommu@lists.linux-foundation.org>; Wed, 10 Nov 2021 20:19:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 940B980E25
 for <iommu@lists.linux-foundation.org>; Wed, 10 Nov 2021 20:19:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XYGwVJ4ihbhU for <iommu@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 20:19:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E741C80C5C
 for <iommu@lists.linux-foundation.org>; Wed, 10 Nov 2021 20:19:19 +0000 (UTC)
Received: by mail-lf1-x134.google.com with SMTP id bu18so8914065lfb.0
 for <iommu@lists.linux-foundation.org>; Wed, 10 Nov 2021 12:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=sfkLEyAh2f0FnZgoyr5ZOnaxpuprPl9HQyaWcoACmR8=;
 b=sqjWIl2uzMEK2g5GksLYcz/qLHpXgLzH13UQB3j1AUlei4YSIvbgoY5o/k2+vT7Wg+
 VyCIULycAv3lK5CmoVpP+rVNfmeUqzrp7Wb32G8OzooVp1VJQhgghC3VbkRyp+Je7Emh
 fjc8RFf0NZEGOOFa7AGURqpR+wFVOLhPvpVq+i/TQxQhd3MBY4Hasd5OuCVJWfUZEpce
 TYvr/rZz2A347yMu2gkQEcknY6LmUYJTvR78OlfQUS6A1xFzVTV55SC0YkyoSpxPG3Gz
 63RCKroXx6LgLISkyWb2bMemYWJcxVO+nxgTKx2Gov3SlpN+rgtdmkwrBJKg6Y8zrp0m
 G6CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=sfkLEyAh2f0FnZgoyr5ZOnaxpuprPl9HQyaWcoACmR8=;
 b=wbuycyquoP0hVWHogJpZPBZtheE4DMpgKkxgOWDwOomVij9GgrjoDxNjfrFtKuWDfI
 wcEO+FXqFIaiARe1dJ56tbGhAAfFlVm2KbW+FrkMeE/TyEOWjLxc6dtA2BiKcXRELbSg
 LWJDh82zwnH1xXdi68fSarVCheuT2vnt1Upxy1Fd975qbcy+83QFr8NUuNqxV4KxdhJH
 NLFfCtAIJ3xUhDcubB5j3oQ4UwCMumYmoCY1FqGNvdoVYeM5UNOmtVIeMrXMyXe5y7tm
 nOntMU37GzsiUkzwY0SLWNyUySLXSiBB4JH1/dmgjnemYGVAf/S1PrybBv3vU2cEdWtQ
 /ZLQ==
X-Gm-Message-State: AOAM532fKMOdHTS3y9C1vDWVyfHcDL2+1Yvh7JLxybhLcVnNhlTX6dKM
 Wev3zGNO3d9J6jTPje2J8nNwmv+QMIqCUc2FMCwJLw==
X-Google-Smtp-Source: ABdhPJxqn/www7tIhoKSEkqyNjE2zOFSoBeoIMJ138IF8vw8u0UOPO9GEH/e0CpTKJg2Xjx8Ov1vhkFgbm43fEr/eoY=
X-Received: by 2002:ac2:4d19:: with SMTP id r25mr1658265lfi.82.1636575557693; 
 Wed, 10 Nov 2021 12:19:17 -0800 (PST)
MIME-Version: 1.0
References: <YYhY7GqlrcTZlzuA@fedora>
In-Reply-To: <YYhY7GqlrcTZlzuA@fedora>
Date: Wed, 10 Nov 2021 12:19:06 -0800
Message-ID: <CAKwvOd=SsrCy=aG_t2=58YFymR-j6Rp-Jxb_RDfFwX3Lfy8E2g@mail.gmail.com>
Subject: Re: [PATCH] iommu/vt-d: Remove unused dma_to_mm_pfn function
To: =?UTF-8?B?TWHDrXJhIENhbmFs?= <maira.canal@usp.br>
Cc: dwmw2@infradead.org, llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
 nathan@kernel.org, iommu@lists.linux-foundation.org, will@kernel.org
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
From: Nick Desaulniers via iommu <iommu@lists.linux-foundation.org>
Reply-To: Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gU3VuLCBOb3YgNywgMjAyMSBhdCAyOjUzIFBNIE1hw61yYSBDYW5hbCA8bWFpcmEuY2FuYWxA
dXNwLmJyPiB3cm90ZToKPgo+IFJlbW92ZSBkbWFfdG9fYnVmX3BmbiBmdW5jdGlvbiwgd2hpY2gg
aXMgbm90IHVzZWQgaW4gdGhlIGNvZGViYXNlLgo+Cj4gVGhpcyB3YXMgcG9pbnRlZCBieSBjbGFu
ZyB3aXRoIHRoZSBmb2xsb3dpbmcgd2FybmluZzoKPgo+IGRyaXZlcnMvaW9tbXUvaW50ZWwvaW9t
bXUuYzoxMzY6Mjk6IHdhcm5pbmc6IHVudXNlZCBmdW5jdGlvbgo+ICdkbWFfdG9fbW1fcGZuJyBb
LVd1bnVzZWQtZnVuY3Rpb25dCj4gc3RhdGljIGlubGluZSB1bnNpZ25lZCBsb25nIGRtYV90b19t
bV9wZm4odW5zaWduZWQgbG9uZyBkbWFfcGZuKQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBeCgpUaGFua3MgZm9yIHRoZSBwYXRjaCEKRml4ZXM6IGRkNGU4MzE5NjBlNGYgKCJpbnRlbC1p
b21tdTogQ2hhbmdlIGRtYV9zZXRfcHRlX2FkZHIoKSB0bwpkbWFfc2V0X3B0ZV9wZm4oKSIpClJl
dmlld2VkLWJ5OiBOaWNrIERlc2F1bG5pZXJzIDxuZGVzYXVsbmllcnNAZ29vZ2xlLmNvbT4KCj4K
PiBTaWduZWQtb2ZmLWJ5OiBNYcOtcmEgQ2FuYWwgPG1haXJhLmNhbmFsQHVzcC5icj4KPiAtLS0K
PiAgZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jIHwgNSAtLS0tLQo+ICAxIGZpbGUgY2hhbmdl
ZCwgNSBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2ludGVsL2lv
bW11LmMgYi9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMKPiBpbmRleCAwYmRlMGM4YjQxMjYu
LjM1MzAwYjViNjlmNyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMK
PiArKysgYi9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMKPiBAQCAtMTMzLDExICsxMzMsNiBA
QCBzdGF0aWMgaW5saW5lIHVuc2lnbmVkIGxvbmcgbHZsX3RvX25yX3BhZ2VzKHVuc2lnbmVkIGlu
dCBsdmwpCj4KPiAgLyogVlQtZCBwYWdlcyBtdXN0IGFsd2F5cyBiZSBfc21hbGxlcl8gdGhhbiBN
TSBwYWdlcy4gT3RoZXJ3aXNlIHRoaW5ncwo+ICAgICBhcmUgbmV2ZXIgZ29pbmcgdG8gd29yay4g
Ki8KPiAtc3RhdGljIGlubGluZSB1bnNpZ25lZCBsb25nIGRtYV90b19tbV9wZm4odW5zaWduZWQg
bG9uZyBkbWFfcGZuKQo+IC17Cj4gLSAgICAgICByZXR1cm4gZG1hX3BmbiA+PiAoUEFHRV9TSElG
VCAtIFZURF9QQUdFX1NISUZUKTsKPiAtfQo+IC0KPiAgc3RhdGljIGlubGluZSB1bnNpZ25lZCBs
b25nIG1tX3RvX2RtYV9wZm4odW5zaWduZWQgbG9uZyBtbV9wZm4pCj4gIHsKPiAgICAgICAgIHJl
dHVybiBtbV9wZm4gPDwgKFBBR0VfU0hJRlQgLSBWVERfUEFHRV9TSElGVCk7Cj4gLS0KPiAyLjMx
LjEKPgoKCi0tIApUaGFua3MsCn5OaWNrIERlc2F1bG5pZXJzCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby9pb21tdQ==
