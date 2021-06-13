Return-Path: <SRS0=zQ8X=LH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF99C48BDF
	for <iommu@archiver.kernel.org>; Sun, 13 Jun 2021 07:55:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0BEB61222
	for <iommu@archiver.kernel.org>; Sun, 13 Jun 2021 07:55:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0BEB61222
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 72298607B4;
	Sun, 13 Jun 2021 07:55:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Sh6k5i8fVXiO; Sun, 13 Jun 2021 07:55:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 54C2C607D1;
	Sun, 13 Jun 2021 07:55:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2D89BC000D;
	Sun, 13 Jun 2021 07:55:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5C576C000B
 for <iommu@lists.linux-foundation.org>; Sun, 13 Jun 2021 06:30:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3A815400B8
 for <iommu@lists.linux-foundation.org>; Sun, 13 Jun 2021 06:30:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pKw3DXU0lzJj for <iommu@lists.linux-foundation.org>;
 Sun, 13 Jun 2021 06:29:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3E42F400AE
 for <iommu@lists.linux-foundation.org>; Sun, 13 Jun 2021 06:29:57 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id he7so10890900ejc.13
 for <iommu@lists.linux-foundation.org>; Sat, 12 Jun 2021 23:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=nownNaLyh+w2Hh2hW4XMdkpyjXZowhZ5hjX6G051lLE=;
 b=lwzDq4P822FD7x7i1tDBpyVYCy/giWAHWZxhe3KDt4Og2Ld+UYFPvzQJYbufImNACE
 MbeMajFChJylYVz2YzhzmJmMZsH5yMaNgMYmNVLfDBsNtKkRtzGaKNp1kU4hqNETa6LK
 mice6EaId4gnYzYXacc5bAec3HAT03HlN39y0nQw4YxL5/wBc4t/OeKZft/m9BK7d4At
 8TRpiRrAUWyFoMYP83wNu19oga0SgH6TzsC0k0cFD0fFbbsZpbZb9gRAUYo+JQNj1W4R
 zd9vPqZ3/POWxNWhTSJr5vQnXr12VTGp3B06uaGX+t+mYUHgZP3IRXNGr+poq8D6bTtS
 UU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to;
 bh=nownNaLyh+w2Hh2hW4XMdkpyjXZowhZ5hjX6G051lLE=;
 b=KtI5qbqkSzdfaN10UHseqbKG74Wz4HCKDmgTMiUOQRXJr7q0Q8o/UIal9gJ15wRbmT
 5qzC/7ToBskj+LKlp57ueAZlbTlpgxa3Z1NinXA1K1l4QxykZcrMbob/E/nqUU+JhdkS
 WqY73D2bzOc+QjFFZa4kvpzrs2YB26tNJ2BT7kr28hxL9GJOEukMplAIjrP1/AVagzO1
 q8RNsabOSkoJdy4gGMntzWxTo+vK+jHPbb5jLLhGfdFt9Feq8+jEU8HHto0GUkAukz+0
 whHxI2j4S7r+fJztNT+54ylJ9mST/zVsJM7UP8+ciylfDtQg4597VZutFgDqS7r2ha1X
 Q4eQ==
X-Gm-Message-State: AOAM532pLkx2cyKqrW7P0IZD33QdGR3s9yC4hcdTlWKwP/r5Aox6iC+2
 CtvbabIiWikmJQ3eR2caGUk=
X-Google-Smtp-Source: ABdhPJyCZLvVBZwnmjVV9bW3wGTKBQLXrnDE4vdwzq3ihX/PNWK29zGPP6lAzW4+QKO3OLlfuXpc4Q==
X-Received: by 2002:a17:906:4e91:: with SMTP id
 v17mr10641608eju.119.1623565795327; 
 Sat, 12 Jun 2021 23:29:55 -0700 (PDT)
Received: from eldamar (80-218-24-251.dclient.hispeed.ch. [80.218.24.251])
 by smtp.gmail.com with ESMTPSA id bh2sm4076028ejb.80.2021.06.12.23.29.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Jun 2021 23:29:54 -0700 (PDT)
Date: Sun, 13 Jun 2021 08:29:53 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: =?utf-8?B?5bCP5aSq?= <nospam@kota.moe>,
 Jianxiong Gao <jxgao@google.com>, Christoph Hellwig <hch@lst.de>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, xen-devel@lists.xenproject.org
Subject: Regression in at least 5.10.y and mainline: Firewire audio interface
 fails to work properly (when booted under Xen)
Message-ID: <YMWl4UnFBAVRDnys@eldamar.lan>
References: <162352833546.2353.230557992597997974.reportbug@home.kota.moe>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <162352833546.2353.230557992597997974.reportbug@home.kota.moe>
X-Mailman-Approved-At: Sun, 13 Jun 2021 07:55:15 +0000
Cc: 989778-maintonly@bugs.debian.org
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

SGksCgpPbiBTdW4sIEp1biAxMywgMjAyMSBhdCAwNjowNTozN0FNICsxMDAwLCDlsI/lpKogd3Jv
dGU6Cj4gUGFja2FnZTogc3JjOmxpbnV4Cj4gVmVyc2lvbjogNS4xMC40MC0xCj4gU2V2ZXJpdHk6
IG5vcm1hbAo+IFRhZ3M6IHVwc3RyZWFtCj4gWC1EZWJidWdzLUNjOiBub3NwYW1Aa290YS5tb2UK
PiAKPiBBZnRlciB1cGRhdGluZyBmcm9tIGxpbnV4LWltYWdlLTUuMTAuMC02LWFtZDY0LCBqYWNr
ZCBub3cgZmFpbHMgdG8gc3luYyB0byBteQo+IERJQ0UtY29tcGF0aWJsZSBmaXJld2lyZSBhdWRp
byBpbnRlcmZhY2UgKFByb2ZpcmUgNjEwKSwgd2l0aCB0aGUgZm9sbG93aW5nCj4gZXJyb3IgbWVz
c2FnZXMgKGZ1bGwgbG9nIGF0dGFjaGVkKToKPiAKPiA+ICQgamFja2QgLWQgZmlyZXdpcmUgLXYK
PiA+IGphY2tkbXAgMS45LjEyCj4gPiAuLi5zbmlwLi4uCj4gPiAwMDMwMTA1Njc2MTogV2Fybmlu
ZyAoU3RyZWFtUHJvY2Vzc29yTWFuYWdlci5jcHApWyA5MTNdIGFsaWduUmVjZWl2ZWRTdHJlYW1z
Ogo+IHhydW4gd2hpbGUgYWxpZ25pbmcgc3RyZWFtcy4uLgo+ID4gMDAzMDEwNTY3OTM6IEVycm9y
IChTdHJlYW1Qcm9jZXNzb3JNYW5hZ2VyLmNwcClbIDg3N10gc3luY1N0YXJ0QWxsOiBDb3VsZCBu
b3QKPiBhbGlnbiBzdHJlYW1zLi4uCj4gPiAwMDMwMTA1NjgyOTogRmF0YWwgKFN0cmVhbVByb2Nl
c3Nvck1hbmFnZXIuY3BwKVsxMDI1XSBzdGFydDogQ291bGQgbm90Cj4gc3luY1N0YXJ0QWxsLi4u
Cj4gPiAwMDMwMTQwMDYyNjogV2FybmluZyAoVGltZXN0YW1wZWRCdWZmZXIuY3BwKVsgMjQ4XSBj
YWxjdWxhdGVSYXRlOiAoMHgxZmE1YTIwKQo+IHJhdGUgKCA3MDguMTg3MTMpIG1vcmUgdGhhdCAx
MCUgb2ZmIG5vbWluYWwgKHJhdGU9IDUxMi4wMDAwMCwgZGlmZj0KPiA1NjY1LjQ5NywgdXBkYXRl
X3BlcmlvZD04KQo+ID4gMDAzMDE0MTY2NDI6IFdhcm5pbmcgKFRpbWVzdGFtcGVkQnVmZmVyLmNw
cClbIDI0OF0gY2FsY3VsYXRlUmF0ZTogKDB4MWZhNWEyMCkKPiByYXRlICggNjg2LjQ5MDExKSBt
b3JlIHRoYXQgMTAlIG9mZiBub21pbmFsIChyYXRlPSA1MTIuMDAwMDAsIGRpZmY9Cj4gNTQ5MS45
MjEsIHVwZGF0ZV9wZXJpb2Q9OCkKPiA+IDAwMzAxNDE2OTI1OiBXYXJuaW5nIChkZXZpY2VtYW5h
Z2VyLmNwcClbIDkyNV0gc3RhcnRTdHJlYW1pbmc6IEZhaWxlZCB0bwo+IHN0YXJ0IFNQTSEKPiA+
IGZpcmV3aXJlIEVSUjogQ291bGQgbm90IHN0YXJ0IHN0cmVhbWluZyB0aHJlYWRzCj4gPiBDYW5u
b3Qgc3RhcnQgZHJpdmVyCj4gPiBKYWNrU2VydmVyOjpTdGFydCgpIGZhaWxlZCB3aXRoIC0xCj4g
PiAwMDMwMTQyNDMyOTogV2FybmluZyAoaWVlZTEzOTRzZXJ2aWNlLmNwcClbMTUwOV0gZnJlZUlz
b0NoYW5uZWw6ICBDaGFubmVsIDEKPiBub3QgcmVnaXN0ZXJlZAo+ID4gMDAzMDE0MjQzNjA6IEVy
cm9yIChkaWNlX2F2ZGV2aWNlLmNwcClbMTQ0MF0gc3RhcnRzdG9wU3RyZWFtQnlJbmRleDogQ291
bGQKPiBub3QgZGVhbGxvY2F0ZSBpc28gY2hhbm5lbCBmb3IgU1AgMSAoQVJYIDApCj4gPiAwMDMw
MTQyNDM5NzogV2FybmluZyAoZGV2aWNlbWFuYWdlci5jcHApWyA5NTldIHN0b3BTdHJlYW1pbmdP
bkRldmljZTogQ291bGQKPiBub3Qgc3RvcCBzdHJlYW0gMSBvZiBkZXZpY2UgMHgxZjZlNjAwCj4g
PiAwMDMwMTQyNDQwNjogV2FybmluZyAoZGV2aWNlbWFuYWdlci5jcHApWyA5MzFdIHN0YXJ0U3Ry
ZWFtaW5nOiBDb3VsZCBub3Qgc3RvcAo+IHN0cmVhbWluZyBvbiBkZXZpY2UgMHgxZjZlNjAwIQo+
ID4gMDAzMDE0MjQ0Mjk6IEZhdGFsIChmZmFkby5jcHApWyAyMjBdIGZmYWRvX3N0cmVhbWluZ19z
dGFydDogQ291bGQgbm90IHN0YXJ0Cj4gdGhlIHN0cmVhbWluZyBzeXN0ZW0KPiA+IEZhaWxlZCB0
byBzdGFydCBzZXJ2ZXIKPiA+IG5vIG1lc3NhZ2UgYnVmZmVyIG92ZXJydW5zCj4gCj4gQWRkaXRp
b25hbGx5LCBJIGFsc28gdHJpZWQgdXNpbmcgdGhlIHNuZC1kaWNlIGRyaXZlciB0byBleHBvc2Ug
dGhlIGF1ZGlvCj4gaW50ZXJmYWNlIGRpcmVjdGx5IGluIEFMU0EuIFdoaWxlIHRoZSBpbnRlcmZh
Y2UgZGlkIGFwcGVhciBhbmQgd2FzIHVzYWJsZQo+IHRoZXJlLCBhbGwgaW5wdXRzIGNhbWUgb3V0
IG9mIG15IHNwZWFrZXJzIGhpZ2hseSBkaXN0b3J0ZWQsIHdpdGggY2hhbm5lbHMKPiBibGVlZGlu
ZyBpbnRvIGVhY2ggb3RoZXIgLSBwcmFjdGljYWxseSB1bnVzYWJsZS4KPiAKPiBJJ3ZlIHJlcHJv
ZHVjZWQgdGhlIGlzc3VlIG9uIHVwc3RyZWFtIGtlcm5lbCB2ZXJzaW9uIHY1LjEzLXJjNSsKPiAo
YWQzNDdhYmU0YTk4NzZiMWY2NWY0MDhhYjQ2NzEzN2U4OGY3N2ViNCksIGFuZCBiaXNlY3RlZCB0
aGUgZmlyc3QgYmFkIGNvbW1pdAo+IGRvd24gdG8gODVhNWE2ODc1Y2E5M2RjNGVmYmYyMGRmOTQy
YmE0MWQyN2E5MTdlMy4KPiAKPiBUbyBkb3VibGUgY2hlY2sgY29tbWl0IDg1YTVhNjg3NWNhOTNk
YzRlZmJmMjBkZjk0MmJhNDFkMjdhOTE3ZTMgd2FzIGluZGVlZCB0aGUKPiBpc3N1ZSwgSSBidWls
dCB0aGUgbGF0ZXN0IHY1LjEwIGtlcm5lbCB2NS4xMC40MyB3aXRoIHRoZSBjb21taXQgcmV2ZXJ0
ZWQsIGFuZAo+IGluZGVlZCB0aGUgaXNzdWUgd2VudCBhd2F5Lgo+IFVuZm9ydHVuYXRlbHksIHRo
ZSByZXZlcnNlIHBhdGNoIHdvdWxkIG5vdCBhcHBseSB0byB2NS4xMy1yYzUrLCBzaW5jZSBpdCBz
ZWVtcwo+IGxpa2UgdGhlIGZpbGUgaGFzIGNoYW5nZWQgdG9vIG11Y2guCgpBIHVzZXIgaW4gRGVi
aWFuIHJlcG9ydGVkIHRoZSBhYm92ZSBpc3N1ZSwgd2hpY2ggd2FzIHJlcHJvZHVjaWJsZSB3aXRo
CjUuMTMtcmM1IGFuZCA1LjEwLnkgYXMgcGFja2FnZWQgaW4gRGViaWFuIGFuZCBmb3VuZCB0aGF0
IDg1YTVhNjg3NWNhOQooInN3aW90bGI6IGRvbid0IG1vZGlmeSBvcmlnX2FkZHIgaW4gc3dpb3Rs
Yl90Ymxfc3luY19zaW5nbGUiKSB0aGF0CmludHJvZHVjZWQgdGhlIGlzc3VlLgoKVGhlIGZ1bGwg
YnVnIGxvZyBpcyBhdCBodHRwczovL2J1Z3MuZGViaWFuLm9yZy85ODk3NzgKCkknbSBDQydpbmcg
YXMgd2VsbCB0aGUgeGVuLWRldmVsIGxpc3QsIGFzIGl0IGFwcGVhcnMgZnJvbQpodHRwczovL2J1
Z3MuZGViaWFuLm9yZy85ODk3NzgjMTAgdGhhdCB0aGUgaXNzdWUgaXMgb25seSBleHBvc2VkIHdo
ZW4gYm9vdGluZwp1bmRlciBYZW4uCgpBbnkgaWRlYXM/CgpSZWdhcmRzLApTYWx2YXRvcmUKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGlu
ZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
