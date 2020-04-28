Return-Path: <SRS0=7g3a=6M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818DBC83009
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 15:15:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5372E206D7
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 15:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/rDYXyV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5372E206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2E9838748A;
	Tue, 28 Apr 2020 15:15:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U1Z9lFJSqRBJ; Tue, 28 Apr 2020 15:15:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5025186DF4;
	Tue, 28 Apr 2020 15:15:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45206C0863;
	Tue, 28 Apr 2020 15:15:22 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11E88C0172
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 15:15:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D70AD227B1
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 15:15:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id syvuF9JjEo0x for <iommu@lists.linux-foundation.org>;
 Tue, 28 Apr 2020 15:15:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by silver.osuosl.org (Postfix) with ESMTPS id BA52820462
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 15:15:19 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id y24so3291410wma.4
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 08:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=6RQa3/Ivl+erv2MC5JIerdVHsjcRsy5jElt25/tvg/I=;
 b=c/rDYXyVx+iz8SQtNmdLLH9jiyFcXnPbgx93UfB9RgZOLHKZjwmjlrpMpBrqvtv6Fw
 e3pdYB7gxw+aEHxM30rDVR+kHPY1rl9jcotFrTRSnlHN/Sy7vvx+LPXJNZwgEggzcTWB
 LuNAmn0HSFJVT70SwHLf3sgYl/Kx3gKsWpMIEQtqM8k0x9ytKRe8td2LPY1rCkMV3dw7
 psiw49gPvhkuxILNWN08yqhHImHmiI27uI55UfLBdsWcku7ZE2NvnEY2pv3lxOw5UkS9
 RV6DV8J10tXn4Za5fUe0JvrTCtHazLo7gOx6UIJnFQwRYybjgD3lh2zZDTK0vKtWyWpe
 IJqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=6RQa3/Ivl+erv2MC5JIerdVHsjcRsy5jElt25/tvg/I=;
 b=pCkzT8NxMeHjTZ0f+u1sPSkJsNYr2bSs2oBAmr5YQ67fE+HC9zm+ObVZihAYYMrzbE
 XsXjaC351gU04MYdyhE1E4iZs45eTDD9f9zDmaupf40+bq850pmysJa7Y3ujVUskz4SN
 BYX9Ab0PUBcJuHxSYkEZ7NKluojuoJXF+11q1lKZbrGi1XvDbhv3SDO9CcqRHDmuB254
 d7iVDI7reEjT+4XvvqCzIo0LRoF8gIyx2jNfv8Wi36taXgruKrryH5J5phuoANKGp7eq
 ML7eXBXMOO7Z3084sljCLX8Klkez5uWzl+yBIKCdSlfd4xHz47Rj5ruhAdp/wvEVcTip
 wbTw==
X-Gm-Message-State: AGi0PuaCXrY5Seaibc8v9USa/YmLLYQpvAPMr6byRurOrIKzNBYzKAzH
 qhCWm5WX9CLbwsjvq9AnNOY=
X-Google-Smtp-Source: APiQypJXqdagbY7C95ErpdLoYp1uRYumNOUPPDPTkG1JE8zcrJsSYL5DCZa3nXGytS0h2Vy2ksxDbg==
X-Received: by 2002:a7b:c5d4:: with SMTP id n20mr5373467wmk.92.1588086918255; 
 Tue, 28 Apr 2020 08:15:18 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id 74sm26988379wrk.30.2020.04.28.08.15.17
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 28 Apr 2020 08:15:17 -0700 (PDT)
Subject: Re: [RFC 10/17] drm: radeon: fix sg_table nents vs. orig_nents misuse
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20200428132005.21424-1-m.szyprowski@samsung.com>
 <CGME20200428132028eucas1p155a84ab14c6a6820b4c8240f01e98905@eucas1p1.samsung.com>
 <20200428132005.21424-11-m.szyprowski@samsung.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <94c45ded-6544-a922-7177-8255b44c4cfa@gmail.com>
Date: Tue, 28 Apr 2020 17:15:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200428132005.21424-11-m.szyprowski@samsung.com>
Content-Language: en-US
Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, Sumit Semwal <sumit.semwal@linaro.org>,
 Daniel Vetter <daniel@ffwll.ch>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org
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
Reply-To: christian.koenig@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

QW0gMjguMDQuMjAgdW0gMTU6MTkgc2NocmllYiBNYXJlayBTenlwcm93c2tpOgo+IFRoZSBEb2N1
bWVudGF0aW9uL0RNQS1BUEktSE9XVE8udHh0IHN0YXRlcyB0aGF0IGRtYV9tYXBfc2cgcmV0dXJu
cyB0aGUKPiBudW1lciBvZiB0aGUgY3JlYXRlZCBlbnRyaWVzIGluIHRoZSBETUEgYWRkcmVzcyBz
cGFjZS4gSG93ZXZlciB0aGUKPiBzdWJzZXF1ZW50IGNhbGxzIHRvIGRtYV9zeW5jX3NnX2Zvcl97
ZGV2aWNlLGNwdX0gYW5kIGRtYV91bm1hcF9zZyBtdXN0IGJlCj4gY2FsbGVkIHdpdGggdGhlIG9y
aWdpbmFsIG51bWJlciBvZiBlbnRyaWVzIHBhc3NlZCB0byBkbWFfbWFwX3NnLiBUaGUKPiBzZ190
YWJsZS0+bmVudHMgaW4gdHVybiBob2xkcyB0aGUgcmVzdWx0IG9mIHRoZSBkbWFfbWFwX3NnIGNh
bGwgYXMgc3RhdGVkCj4gaW4gaW5jbHVkZS9saW51eC9zY2F0dGVybGlzdC5oLiBBZGFwdCB0aGUg
Y29kZSB0byBvYmV5IHRob3NlIHJ1bGVzLgo+Cj4gU2lnbmVkLW9mZi1ieTogTWFyZWsgU3p5cHJv
d3NraSA8bS5zenlwcm93c2tpQHNhbXN1bmcuY29tPgoKUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBL
w7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9k
cm0vcmFkZW9uL3JhZGVvbl90dG0uYyB8IDEwICsrKysrLS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2Vk
LCA1IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fdHRtLmMgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3Jh
ZGVvbl90dG0uYwo+IGluZGV4IDVkNTBjOWUuLjQ3NzA4ODAgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fdHRtLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFk
ZW9uL3JhZGVvbl90dG0uYwo+IEBAIC00ODEsNyArNDgxLDcgQEAgc3RhdGljIGludCByYWRlb25f
dHRtX3R0X3Bpbl91c2VycHRyKHN0cnVjdCB0dG1fdHQgKnR0bSkKPiAgIHsKPiAgIAlzdHJ1Y3Qg
cmFkZW9uX2RldmljZSAqcmRldiA9IHJhZGVvbl9nZXRfcmRldih0dG0tPmJkZXYpOwo+ICAgCXN0
cnVjdCByYWRlb25fdHRtX3R0ICpndHQgPSAodm9pZCAqKXR0bTsKPiAtCXVuc2lnbmVkIHBpbm5l
ZCA9IDAsIG5lbnRzOwo+ICsJdW5zaWduZWQgcGlubmVkID0gMDsKPiAgIAlpbnQgcjsKPiAgIAo+
ICAgCWludCB3cml0ZSA9ICEoZ3R0LT51c2VyZmxhZ3MgJiBSQURFT05fR0VNX1VTRVJQVFJfUkVB
RE9OTFkpOwo+IEBAIC01MjIsOCArNTIyLDggQEAgc3RhdGljIGludCByYWRlb25fdHRtX3R0X3Bp
bl91c2VycHRyKHN0cnVjdCB0dG1fdHQgKnR0bSkKPiAgIAkJZ290byByZWxlYXNlX3NnOwo+ICAg
Cj4gICAJciA9IC1FTk9NRU07Cj4gLQluZW50cyA9IGRtYV9tYXBfc2cocmRldi0+ZGV2LCB0dG0t
PnNnLT5zZ2wsIHR0bS0+c2ctPm5lbnRzLCBkaXJlY3Rpb24pOwo+IC0JaWYgKG5lbnRzID09IDAp
Cj4gKwl0dG0tPnNnLT5uZW50cyA9IGRtYV9tYXBfc2cocmRldi0+ZGV2LCB0dG0tPnNnLT5zZ2ws
Cj4gKwlpZiAodHRtLT5zZy0+bmVudHMgPT0gMCkKPiAgIAkJZ290byByZWxlYXNlX3NnOwo+ICAg
Cj4gICAJZHJtX3ByaW1lX3NnX3RvX3BhZ2VfYWRkcl9hcnJheXModHRtLT5zZywgdHRtLT5wYWdl
cywKPiBAQCAtNTU0LDkgKzU1NCw5IEBAIHN0YXRpYyB2b2lkIHJhZGVvbl90dG1fdHRfdW5waW5f
dXNlcnB0cihzdHJ1Y3QgdHRtX3R0ICp0dG0pCj4gICAJCXJldHVybjsKPiAgIAo+ICAgCS8qIGZy
ZWUgdGhlIHNnIHRhYmxlIGFuZCBwYWdlcyBhZ2FpbiAqLwo+IC0JZG1hX3VubWFwX3NnKHJkZXYt
PmRldiwgdHRtLT5zZy0+c2dsLCB0dG0tPnNnLT5uZW50cywgZGlyZWN0aW9uKTsKPiArCWRtYV91
bm1hcF9zZyhyZGV2LT5kZXYsIHR0bS0+c2ctPnNnbCwgdHRtLT5zZy0+b3JpZ19uZW50cywgZGly
ZWN0aW9uKTsKPiAgIAo+IC0JZm9yX2VhY2hfc2dfcGFnZSh0dG0tPnNnLT5zZ2wsICZzZ19pdGVy
LCB0dG0tPnNnLT5uZW50cywgMCkgewo+ICsJZm9yX2VhY2hfc2dfcGFnZSh0dG0tPnNnLT5zZ2ws
ICZzZ19pdGVyLCB0dG0tPnNnLT5vcmlnX25lbnRzLCAwKSB7Cj4gICAJCXN0cnVjdCBwYWdlICpw
YWdlID0gc2dfcGFnZV9pdGVyX3BhZ2UoJnNnX2l0ZXIpOwo+ICAgCQlpZiAoIShndHQtPnVzZXJm
bGFncyAmIFJBREVPTl9HRU1fVVNFUlBUUl9SRUFET05MWSkpCj4gICAJCQlzZXRfcGFnZV9kaXJ0
eShwYWdlKTsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
