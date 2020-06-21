Return-Path: <SRS0=X07A=AC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0993C433E1
	for <iommu@archiver.kernel.org>; Sun, 21 Jun 2020 13:11:36 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3A542333E
	for <iommu@archiver.kernel.org>; Sun, 21 Jun 2020 13:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajr+lcAh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3A542333E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7D0DA870E5;
	Sun, 21 Jun 2020 13:11:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dy6fojiMhC4c; Sun, 21 Jun 2020 13:11:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D15E086FB3;
	Sun, 21 Jun 2020 13:11:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B41DDC07FF;
	Sun, 21 Jun 2020 13:11:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DA56CC016F
 for <iommu@lists.linux-foundation.org>; Sun, 21 Jun 2020 13:11:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C705588ACF
 for <iommu@lists.linux-foundation.org>; Sun, 21 Jun 2020 13:11:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kBpp9nuc72mj for <iommu@lists.linux-foundation.org>;
 Sun, 21 Jun 2020 13:11:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com
 [209.85.216.68])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 063D288ACE
 for <iommu@lists.linux-foundation.org>; Sun, 21 Jun 2020 13:11:34 +0000 (UTC)
Received: by mail-pj1-f68.google.com with SMTP id u14so1393593pjj.2
 for <iommu@lists.linux-foundation.org>; Sun, 21 Jun 2020 06:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IkUGdQWMXK+kOz7YHBuqdTcLCfEzkHSPew/c4ZoAYIk=;
 b=ajr+lcAhyDq9MPdPbrMwTbTTH+zjhMpGwfMVO0yR/5wICP92yFw/c7bp6W62Q/gUG3
 b9c+GVPgsaiVuALC44jEwUPxCXYfK8di21S1Q5BrAEhPWhgBAcMa1GyRX+WgiDiMJhYO
 rieZ7eX4lxQP1QvSSHbW9SiTpWpUB1W/XmZBuUAKSnIXpM0E3oqxRlm+q5r1hJBvXAxj
 ewTgQ27yQdDVmzCGmebwYFMZNPzye98bwxU2C/FDdq6CexZoYhUeeUap8nmj+cqqNAtC
 uSdxRCoz1u5zXlMOle7mswb6H2gwfN0VR30WZGN+v0XXEeUf+/9v9NU/YXuAtpIf9Jtm
 SXKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=IkUGdQWMXK+kOz7YHBuqdTcLCfEzkHSPew/c4ZoAYIk=;
 b=HCHNJOXZoDPRSvntd4MMq8hRoGFu+XxIr1GRSWcJPrZGFBVShWqne0NHuGcYBixz2N
 0jiRBCoe1bhyTVoYYwSAUhURYMFRfSvTP2J75fsPlUaSIeH+IbWTTuBAv7OxF+V2nGCd
 noZFhH919n9gq7G39vVF1CX0Pc3WTVnhv1ASXfvrKrtoxnok88yf6goK3Tj5CrIQ8Dou
 QYHwG7NVsQu0a57ODnZrmJtdv9UYKeSXG1ny238d9bsklw8/iRfH7gYR+04dDqBDHJxY
 SI/7czWHuk0dKEMNKH1qyMmzR5ogFclDMabJdCtj4gr8eMKDrG/DauA14zDrQhGKU2I6
 LK5g==
X-Gm-Message-State: AOAM5313akz7XXPjRELaHHtHJIo9mbwu0rz3HLu82np5xWKj6GqDDkv4
 WZv8pBNatM048RmfiXlKfRc=
X-Google-Smtp-Source: ABdhPJwv5b2lA1PMqNRi4I9Xn3bUtVBg/2c3rD2g6rNXwVK2NgkB0j7u7V6FMvpYHKOTSDReArKqUA==
X-Received: by 2002:a17:90a:247:: with SMTP id
 t7mr13142876pje.33.1592745092569; 
 Sun, 21 Jun 2020 06:11:32 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 m9sm8554036pgq.61.2020.06.21.06.11.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Jun 2020 06:11:31 -0700 (PDT)
Subject: Re: [PATCH v2] dma-pool: Fix too large DMA pools on medium systems
To: Geert Uytterhoeven <geert@linux-m68k.org>
References: <20200608132217.29945-1-geert@linux-m68k.org>
 <20200620200936.GA106151@roeck-us.net>
 <CAMuHMdX3mBDm9iHk+jhbGfmo+dbix=3tp5z2ewyddWxM1tdqGQ@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <c0889f5c-34ae-2314-6530-a9240e0901f2@roeck-us.net>
Date: Sun, 21 Jun 2020 06:11:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdX3mBDm9iHk+jhbGfmo+dbix=3tp5z2ewyddWxM1tdqGQ@mail.gmail.com>
Content-Language: en-US
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

T24gNi8yMS8yMCAxOjM1IEFNLCBHZWVydCBVeXR0ZXJob2V2ZW4gd3JvdGU6Cj4gSGkgR8O8bnRl
ciwKPiAKPiBPbiBTYXQsIEp1biAyMCwgMjAyMCBhdCAxMDowOSBQTSBHdWVudGVyIFJvZWNrIDxs
aW51eEByb2Vjay11cy5uZXQ+IHdyb3RlOgo+PiBPbiBNb24sIEp1biAwOCwgMjAyMCBhdCAwMzoy
MjoxN1BNICswMjAwLCBHZWVydCBVeXR0ZXJob2V2ZW4gd3JvdGU6Cj4+PiBPbiBzeXN0ZW1zIHdp
dGggYXQgbGVhc3QgMzIgTWlCLCBidXQgbGVzcyB0aGFuIDMyIEdpQiBvZiBSQU0sIHRoZSBETUEK
Pj4+IG1lbW9yeSBwb29scyBhcmUgbXVjaCBsYXJnZXIgdGhhbiBpbnRlbmRlZCAoZS5nLiAyIE1p
QiBpbnN0ZWFkIG9mIDEyOAo+Pj4gS2lCIG9uIGEgMjU2IE1pQiBzeXN0ZW0pLgo+Pj4KPj4+IEZp
eCB0aGlzIGJ5IGNvcnJlY3RpbmcgdGhlIGNhbGN1bGF0aW9uIG9mIHRoZSBudW1iZXIgb2YgR2lC
cyBvZiBSQU0gaW4KPj4+IHRoZSBzeXN0ZW0uICBJbnZlcnQgdGhlIG9yZGVyIG9mIHRoZSBtaW4v
bWF4IG9wZXJhdGlvbnMsIHRvIGtlZXAgb24KPj4+IGNhbGN1bGF0aW5nIGluIHBhZ2VzIHVudGls
IHRoZSBsYXN0IHN0ZXAsIHdoaWNoIGFpZHMgcmVhZGFiaWxpdHkuCj4+Pgo+Pj4gRml4ZXM6IDFk
NjU5MjM2ZmI0M2M0ZDIgKCJkbWEtcG9vbDogc2NhbGUgdGhlIGRlZmF1bHQgRE1BIGNvaGVyZW50
IHBvb2wgc2l6ZSB3aXRoIG1lbW9yeSBjYXBhY2l0eSIpCj4+PiBTaWduZWQtb2ZmLWJ5OiBHZWVy
dCBVeXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02OGsub3JnPgo+Pj4gQWNrZWQtYnk6IERhdmlk
IFJpZW50amVzIDxyaWVudGplc0Bnb29nbGUuY29tPgo+Pgo+PiBUaGlzIHBhdGNoIHJlc3VsdHMg
aW4gYSBib290IGZhaWx1cmUgaW4gc29tZSBvZiBteSBwb3dlcnBjIGJvb3QgdGVzdHMsCj4+IHNw
ZWNpZmljYWxseSB0aG9zZSB0ZXN0aW5nIGJvb3RzIGZyb20gbXB0c2FzMTA2OCBkZXZpY2VzLiBF
cnJvciBtZXNzYWdlOgo+Pgo+PiBtcHRzYXMgMDAwMDowMDowMi4wOiBlbmFibGluZyBkZXZpY2Ug
KDAwMDAgLT4gMDAwMikKPj4gbXB0YmFzZTogaW9jMDogSW5pdGlhdGluZyBicmluZ3VwCj4+IGlv
YzA6IExTSVNBUzEwNjggQTA6IENhcGFiaWxpdGllcz17SW5pdGlhdG9yfQo+PiBtcHRiYXNlOiBp
b2MwOiBFUlJPUiAtIFVuYWJsZSB0byBhbGxvY2F0ZSBSZXBseSwgUmVxdWVzdCwgQ2hhaW4gQnVm
ZmVycyEKPj4gbXB0YmFzZTogaW9jMDogRVJST1IgLSBkaWRuJ3QgaW5pdGlhbGl6ZSBwcm9wZXJs
eSEgKC0zKQo+PiBtcHRzYXM6IHByb2JlIG9mIDAwMDA6MDA6MDIuMCBmYWlsZWQgd2l0aCBlcnJv
ciAtMwo+Pgo+PiBDb25maWd1cmF0aW9uIGlzIGJhbWJvbzo0NHgvYmFtYm9vX2RlZmNvbmZpZyBw
bHVzIHZhcmlvdXMgYWRkZWQgZHJpdmVycy4KPj4gUWVtdSBjb21tYW5kIGxpbmUgaXMKPj4KPj4g
cWVtdS1zeXN0ZW0tcHBjIC1rZXJuZWwgdm1saW51eCAtTSBiYW1ib28gXAo+PiAgICAgIC1tIDI1
NiAtbm8tcmVib290IC1zbmFwc2hvdCAtZGV2aWNlIG1wdHNhczEwNjgsaWQ9c2NzaSBcCj4+ICAg
ICAgLWRldmljZSBzY3NpLWhkLGJ1cz1zY3NpLjAsZHJpdmU9ZDAsd3duPTB4NTAwMGM1MDAxNWVh
NzFhYyAtZHJpdmUgXAo+PiAgICAgIGZpbGU9cm9vdGZzLmV4dDIsZm9ybWF0PXJhdyxpZj1ub25l
LGlkPWQwIFwKPj4gICAgICAtLWFwcGVuZCAicGFuaWM9LTEgc2x1Yl9kZWJ1Zz1GWlBVQSByb290
PS9kZXYvc2RhICBtZW09MjU2TSBjb25zb2xlPXR0eVMwIiBcCj4+ICAgICAgLW1vbml0b3Igbm9u
ZSAtbm9ncmFwaGljCj4+Cj4+IGNhbnlvbmxhbmRzX2RlZmNvbmZpZyB3aXRoIHNhbTQ2MGV4IG1h
Y2hpbmUgYW5kIG90aGVyd2lzZSBzaW1pbGFyIGNvbW1hbmQgbGluZQo+PiBmYWlscyBhcyB3ZWxs
Lgo+Pgo+PiBSZXZlcnRpbmcgdGhpcyBwYXRjaCBmaXhlcyB0aGUgcHJvYmxlbS4KPiAKPiBUaGlz
IGxvb2tzIGxpa2UgdGhlIG1pbmltdW0gdmFsdWUgb2YgMTI4IEtpQiBpcyBub3Qgc3VmZmljaWVu
dCwgYW5kIHRoZQo+IGJ1ZyBpcyBpbiB0aGUgaW50ZW50aW9uIG9mIDFkNjU5MjM2ZmI0M2M0ZDIg
KCJkbWEtcG9vbDogc2NhbGUgdGhlCj4gZGVmYXVsdCBETUEgY29oZXJlbnQgcG9vbCBzaXplIHdp
dGggbWVtb3J5IGNhcGFjaXR5Iik/Cj4gQmVmb3JlLCB0aGVyZSB3YXMgYSBzaW5nbGUgcG9vbCBv
ZiAoZml4ZWQpIDI1NiBLaUIgc2l6ZSwgbm93IHRoZXJlIGFyZQo+IHVwIHRvIHRocmVlIGNvaGVy
ZW50IHBvb2xzIChETUEsIERNQTMyLCBhbmQga2VybmVsKSwgYWxiZWl0IG9mIHNtYWxsZXIKPiBz
aXplICgxMjggS2lCIGVhY2gpLgo+IAo+IENhbiB5b3UgcHJpbnQgdGhlIHJlcXVlc3RlZCBzaXpl
IGluIGRyaXZlcnMvbWVzc2FnZS9mdXNpb24vbXB0YmFzZS5jOgo+IFByaW1lSW9jRmlmb3MoKT8K
CjE3MjkyOCBieXRlcwoKPiBEb2VzIHJlcGxhY2luZyBhbGwgU1pfMTI4SyBieSBTWl8yNTZLIGlu
IG15IHBhdGNoIGhlbHA/CgpZZXMsIGl0IGRvZXMuCgpHdWVudGVyCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
