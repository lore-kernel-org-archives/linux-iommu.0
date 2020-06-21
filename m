Return-Path: <SRS0=X07A=AC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7B4C433E0
	for <iommu@archiver.kernel.org>; Sun, 21 Jun 2020 08:35:36 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9113B20732
	for <iommu@archiver.kernel.org>; Sun, 21 Jun 2020 08:35:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9113B20732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 47A3E204D1;
	Sun, 21 Jun 2020 08:35:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vqfta8+25RXa; Sun, 21 Jun 2020 08:35:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 38F0125BDD;
	Sun, 21 Jun 2020 08:35:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18E2AC0891;
	Sun, 21 Jun 2020 08:35:33 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B767EC016F
 for <iommu@lists.linux-foundation.org>; Sun, 21 Jun 2020 08:35:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id ACB5187D24
 for <iommu@lists.linux-foundation.org>; Sun, 21 Jun 2020 08:35:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tdZa6acd2BwQ for <iommu@lists.linux-foundation.org>;
 Sun, 21 Jun 2020 08:35:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com
 [209.85.210.68])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 6444B87D0C
 for <iommu@lists.linux-foundation.org>; Sun, 21 Jun 2020 08:35:30 +0000 (UTC)
Received: by mail-ot1-f68.google.com with SMTP id g5so10671679otg.6
 for <iommu@lists.linux-foundation.org>; Sun, 21 Jun 2020 01:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=hPqD5KPRADuy466IsAAiRxi638VjNc9fQS26UU0hUmk=;
 b=mC7R1D48dmwCbdw31ITPR4Za4RMWtP8MA/eTPYDyaai3prDI0Jd+c5JOXKX8njE7+1
 XyQxkceGVGHZmOUtWJ7wakj0L5/zTmItmILncHsl/XAPtxnk+8tU5RXwh6/CnIDKXjLo
 FHn6QvzKeRXEX2yns2ish0+7F2xTlaAvAD3CUaE+ySnnuXUNBEhqE5JsNzuyDmfAbDPp
 5bPsouUVX0uRefAqoLDEmn3GuVV1yEhwNU5yuXmI9p6Eb4ud5/Hc4iqO456H5Exj9GpX
 0Vif0+rkcGJKHlJF8bF0CoCaeHwt1acyXF/JjsJU9wDfWVR37rkivohoyowX6ikKvAd5
 3r4A==
X-Gm-Message-State: AOAM531VC27RZMQDpIBNseJO8EcjFbpZhoTwhnG6VKorlix6e8RGGye5
 +tJwhghyWyqnqf60f5frJBn42CiXkYUB5zF1j9s=
X-Google-Smtp-Source: ABdhPJyEazFpaahNB3/OkhcB4ZGAQIGHmYndLb0+IkITPgAwA50Mh/46VZdmRMb2aDNtSkqXc093NsdJnwdm2aGrl8c=
X-Received: by 2002:a05:6830:141a:: with SMTP id
 v26mr9756776otp.250.1592728529630; 
 Sun, 21 Jun 2020 01:35:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200608132217.29945-1-geert@linux-m68k.org>
 <20200620200936.GA106151@roeck-us.net>
In-Reply-To: <20200620200936.GA106151@roeck-us.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 21 Jun 2020 10:35:18 +0200
Message-ID: <CAMuHMdX3mBDm9iHk+jhbGfmo+dbix=3tp5z2ewyddWxM1tdqGQ@mail.gmail.com>
Subject: Re: [PATCH v2] dma-pool: Fix too large DMA pools on medium systems
To: Guenter Roeck <linux@roeck-us.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 David Rientjes <rientjes@google.com>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
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

SGkgR8O8bnRlciwKCk9uIFNhdCwgSnVuIDIwLCAyMDIwIGF0IDEwOjA5IFBNIEd1ZW50ZXIgUm9l
Y2sgPGxpbnV4QHJvZWNrLXVzLm5ldD4gd3JvdGU6Cj4gT24gTW9uLCBKdW4gMDgsIDIwMjAgYXQg
MDM6MjI6MTdQTSArMDIwMCwgR2VlcnQgVXl0dGVyaG9ldmVuIHdyb3RlOgo+ID4gT24gc3lzdGVt
cyB3aXRoIGF0IGxlYXN0IDMyIE1pQiwgYnV0IGxlc3MgdGhhbiAzMiBHaUIgb2YgUkFNLCB0aGUg
RE1BCj4gPiBtZW1vcnkgcG9vbHMgYXJlIG11Y2ggbGFyZ2VyIHRoYW4gaW50ZW5kZWQgKGUuZy4g
MiBNaUIgaW5zdGVhZCBvZiAxMjgKPiA+IEtpQiBvbiBhIDI1NiBNaUIgc3lzdGVtKS4KPiA+Cj4g
PiBGaXggdGhpcyBieSBjb3JyZWN0aW5nIHRoZSBjYWxjdWxhdGlvbiBvZiB0aGUgbnVtYmVyIG9m
IEdpQnMgb2YgUkFNIGluCj4gPiB0aGUgc3lzdGVtLiAgSW52ZXJ0IHRoZSBvcmRlciBvZiB0aGUg
bWluL21heCBvcGVyYXRpb25zLCB0byBrZWVwIG9uCj4gPiBjYWxjdWxhdGluZyBpbiBwYWdlcyB1
bnRpbCB0aGUgbGFzdCBzdGVwLCB3aGljaCBhaWRzIHJlYWRhYmlsaXR5Lgo+ID4KPiA+IEZpeGVz
OiAxZDY1OTIzNmZiNDNjNGQyICgiZG1hLXBvb2w6IHNjYWxlIHRoZSBkZWZhdWx0IERNQSBjb2hl
cmVudCBwb29sIHNpemUgd2l0aCBtZW1vcnkgY2FwYWNpdHkiKQo+ID4gU2lnbmVkLW9mZi1ieTog
R2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4KPiA+IEFja2VkLWJ5OiBE
YXZpZCBSaWVudGplcyA8cmllbnRqZXNAZ29vZ2xlLmNvbT4KPgo+IFRoaXMgcGF0Y2ggcmVzdWx0
cyBpbiBhIGJvb3QgZmFpbHVyZSBpbiBzb21lIG9mIG15IHBvd2VycGMgYm9vdCB0ZXN0cywKPiBz
cGVjaWZpY2FsbHkgdGhvc2UgdGVzdGluZyBib290cyBmcm9tIG1wdHNhczEwNjggZGV2aWNlcy4g
RXJyb3IgbWVzc2FnZToKPgo+IG1wdHNhcyAwMDAwOjAwOjAyLjA6IGVuYWJsaW5nIGRldmljZSAo
MDAwMCAtPiAwMDAyKQo+IG1wdGJhc2U6IGlvYzA6IEluaXRpYXRpbmcgYnJpbmd1cAo+IGlvYzA6
IExTSVNBUzEwNjggQTA6IENhcGFiaWxpdGllcz17SW5pdGlhdG9yfQo+IG1wdGJhc2U6IGlvYzA6
IEVSUk9SIC0gVW5hYmxlIHRvIGFsbG9jYXRlIFJlcGx5LCBSZXF1ZXN0LCBDaGFpbiBCdWZmZXJz
IQo+IG1wdGJhc2U6IGlvYzA6IEVSUk9SIC0gZGlkbid0IGluaXRpYWxpemUgcHJvcGVybHkhICgt
MykKPiBtcHRzYXM6IHByb2JlIG9mIDAwMDA6MDA6MDIuMCBmYWlsZWQgd2l0aCBlcnJvciAtMwo+
Cj4gQ29uZmlndXJhdGlvbiBpcyBiYW1ib286NDR4L2JhbWJvb19kZWZjb25maWcgcGx1cyB2YXJp
b3VzIGFkZGVkIGRyaXZlcnMuCj4gUWVtdSBjb21tYW5kIGxpbmUgaXMKPgo+IHFlbXUtc3lzdGVt
LXBwYyAta2VybmVsIHZtbGludXggLU0gYmFtYm9vIFwKPiAgICAgIC1tIDI1NiAtbm8tcmVib290
IC1zbmFwc2hvdCAtZGV2aWNlIG1wdHNhczEwNjgsaWQ9c2NzaSBcCj4gICAgICAtZGV2aWNlIHNj
c2ktaGQsYnVzPXNjc2kuMCxkcml2ZT1kMCx3d249MHg1MDAwYzUwMDE1ZWE3MWFjIC1kcml2ZSBc
Cj4gICAgICBmaWxlPXJvb3Rmcy5leHQyLGZvcm1hdD1yYXcsaWY9bm9uZSxpZD1kMCBcCj4gICAg
ICAtLWFwcGVuZCAicGFuaWM9LTEgc2x1Yl9kZWJ1Zz1GWlBVQSByb290PS9kZXYvc2RhICBtZW09
MjU2TSBjb25zb2xlPXR0eVMwIiBcCj4gICAgICAtbW9uaXRvciBub25lIC1ub2dyYXBoaWMKPgo+
IGNhbnlvbmxhbmRzX2RlZmNvbmZpZyB3aXRoIHNhbTQ2MGV4IG1hY2hpbmUgYW5kIG90aGVyd2lz
ZSBzaW1pbGFyIGNvbW1hbmQgbGluZQo+IGZhaWxzIGFzIHdlbGwuCj4KPiBSZXZlcnRpbmcgdGhp
cyBwYXRjaCBmaXhlcyB0aGUgcHJvYmxlbS4KClRoaXMgbG9va3MgbGlrZSB0aGUgbWluaW11bSB2
YWx1ZSBvZiAxMjggS2lCIGlzIG5vdCBzdWZmaWNpZW50LCBhbmQgdGhlCmJ1ZyBpcyBpbiB0aGUg
aW50ZW50aW9uIG9mIDFkNjU5MjM2ZmI0M2M0ZDIgKCJkbWEtcG9vbDogc2NhbGUgdGhlCmRlZmF1
bHQgRE1BIGNvaGVyZW50IHBvb2wgc2l6ZSB3aXRoIG1lbW9yeSBjYXBhY2l0eSIpPwpCZWZvcmUs
IHRoZXJlIHdhcyBhIHNpbmdsZSBwb29sIG9mIChmaXhlZCkgMjU2IEtpQiBzaXplLCBub3cgdGhl
cmUgYXJlCnVwIHRvIHRocmVlIGNvaGVyZW50IHBvb2xzIChETUEsIERNQTMyLCBhbmQga2VybmVs
KSwgYWxiZWl0IG9mIHNtYWxsZXIKc2l6ZSAoMTI4IEtpQiBlYWNoKS4KCkNhbiB5b3UgcHJpbnQg
dGhlIHJlcXVlc3RlZCBzaXplIGluIGRyaXZlcnMvbWVzc2FnZS9mdXNpb24vbXB0YmFzZS5jOgpQ
cmltZUlvY0ZpZm9zKCk/CkRvZXMgcmVwbGFjaW5nIGFsbCBTWl8xMjhLIGJ5IFNaXzI1NksgaW4g
bXkgcGF0Y2ggaGVscD8KVGhhdCB3b3VsZCB3YXN0ZV5IXkheSF5IXkhhbGxvY2F0ZSAyNTYgS2lC
IG9yIDUxMiBLaUIgbW9yZSwgdGhvdWdoLgoKVGhhbmtzIQoKR3J7b2V0amUsZWV0aW5nfXMsCgog
ICAgICAgICAgICAgICAgICAgICAgICBHZWVydAoKLS0gCkdlZXJ0IFV5dHRlcmhvZXZlbiAtLSBU
aGVyZSdzIGxvdHMgb2YgTGludXggYmV5b25kIGlhMzIgLS0gZ2VlcnRAbGludXgtbTY4ay5vcmcK
CkluIHBlcnNvbmFsIGNvbnZlcnNhdGlvbnMgd2l0aCB0ZWNobmljYWwgcGVvcGxlLCBJIGNhbGwg
bXlzZWxmIGEgaGFja2VyLiBCdXQKd2hlbiBJJ20gdGFsa2luZyB0byBqb3VybmFsaXN0cyBJIGp1
c3Qgc2F5ICJwcm9ncmFtbWVyIiBvciBzb21ldGhpbmcgbGlrZSB0aGF0LgogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIC0tIExpbnVzIFRvcnZhbGRzCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby9pb21tdQ==
