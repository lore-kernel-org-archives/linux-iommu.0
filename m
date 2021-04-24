Return-Path: <SRS0=1UcA=JV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8094C433B4
	for <iommu@archiver.kernel.org>; Sat, 24 Apr 2021 20:41:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35C9861288
	for <iommu@archiver.kernel.org>; Sat, 24 Apr 2021 20:41:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35C9861288
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EF61D4015F;
	Sat, 24 Apr 2021 20:41:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R68yr-x0qitm; Sat, 24 Apr 2021 20:41:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9604E400E4;
	Sat, 24 Apr 2021 20:41:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7ADA1C000F;
	Sat, 24 Apr 2021 20:41:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 419D9C000B
 for <iommu@lists.linux-foundation.org>; Sat, 24 Apr 2021 20:41:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1BD35607B6
 for <iommu@lists.linux-foundation.org>; Sat, 24 Apr 2021 20:41:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d95JO3sKZ1Pr for <iommu@lists.linux-foundation.org>;
 Sat, 24 Apr 2021 20:41:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ED16060781
 for <iommu@lists.linux-foundation.org>; Sat, 24 Apr 2021 20:41:40 +0000 (UTC)
Received: by mail-lj1-x230.google.com with SMTP id d15so8241829ljo.12
 for <iommu@lists.linux-foundation.org>; Sat, 24 Apr 2021 13:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+1w4/EfG2NVLy0uONKd/2OiGALGE5gFQWsXVLjMDOAo=;
 b=EL7bK8xcrPxcKnDmwEjfGYX21XIsEFsytGfH/nvjPmXkJXqQQopGQdk5qitnk5mdE+
 f4Aj4RBvB0HwI6tgo9tsOizajc79Vi5x0hCGlO2IOXPJ4Y21jZwajf7uw9l2/3ux7DO7
 wdpqheqURswL2lwWGXUdmvOd+A78tcJ1iUgN/wgdDQM4i8+KGdcfsJJF+5e3j8u1U/+x
 zqiZ37t0FBE/JNwiNJ04NL3p8ewrpaaBTw3uyOzrRoV1QexYluA9Mzstr+cCKWd7il+S
 0tL3+Ckj9px4P1RVG4D3WHN0oyk/wt0BlD4VJNeIc60UpqLPQPDszqSwLceSegebk6Mw
 8SEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+1w4/EfG2NVLy0uONKd/2OiGALGE5gFQWsXVLjMDOAo=;
 b=dogLfpkOAUSqY6q9isljOIWjIBt/ROHlI4S408hIbcfqbb91MO3SxgrY4ErOLfHcHG
 FkRpFceRJGxdvNF+fA9axlznC8Sa5d128ynwtK33A0R1aqxu5+tJzdwPMiY5tsKzJ9gI
 ZzYzB51RX168jcpnx96A/aOrWMNkkYE5GBstKIQ89rpXK46FbGZ7aqdUZKDU+9APSQlY
 5/W0AtHG93aGm/z4HbFkiUSWjKLPtHCTrzMgbBvAKKSkckNFv4NhUdo7I+I8Ojq+mYKp
 +KP1uFo9urlEH/yzmAPAPm0HjnyLu1XXfM29j4kMXbJIzoKvEk1Pnyp9g9TQeDGmj495
 P4HQ==
X-Gm-Message-State: AOAM531PzNLu6MSYucboxG5OKxE/sYBEx5ZoyMgStg0dpWvImTcGcGvN
 3PnqQJpPQIAxCsC2+UtvNTE=
X-Google-Smtp-Source: ABdhPJwgVWDrKKfbrQbvcjS5p9JaoHpUD+13JpDm4ldDsZblLQeeaFql5RvD0p6EQubJyVkINg9i5Q==
X-Received: by 2002:a2e:9ec5:: with SMTP id h5mr7312620ljk.169.1619296898914; 
 Sat, 24 Apr 2021 13:41:38 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-103.dynamic.spd-mgts.ru.
 [109.252.193.103])
 by smtp.googlemail.com with ESMTPSA id z18sm17325lft.57.2021.04.24.13.41.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Apr 2021 13:41:38 -0700 (PDT)
Subject: Re: [PATCH v1 2/2] iommu/tegra-smmu: Revert workaround that was
 needed for Nyan Big Chromebook
From: Dmitry Osipenko <digetx@gmail.com>
To: Guillaume Tucker <guillaume.tucker@collabora.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>,
 Thierry Reding <thierry.reding@gmail.com>
References: <20210328233256.20494-1-digetx@gmail.com>
 <20210328233256.20494-2-digetx@gmail.com>
 <20210401085549.GA31146@Asurada-Nvidia>
 <50a7e4c7-0e72-534a-a317-366e455213c1@gmail.com>
 <d01ccde4-5fa9-2aa7-c28b-b3899cc54c54@collabora.com>
 <724e683f-5317-cdf7-7351-fcfd42b7b607@gmail.com>
 <5ec2be61-a70e-e3b1-9267-414793c32a04@gmail.com>
Message-ID: <4b1eb3d5-6489-6553-ba88-df485323e6e8@gmail.com>
Date: Sat, 24 Apr 2021 23:41:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <5ec2be61-a70e-e3b1-9267-414793c32a04@gmail.com>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
 Will Deacon <will@kernel.org>
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

MjQuMDQuMjAyMSAyMzoyNywgRG1pdHJ5IE9zaXBlbmtvINC/0LjRiNC10YI6Cj4gMjMuMDQuMjAy
MSAxODoyMywgRG1pdHJ5IE9zaXBlbmtvINC/0LjRiNC10YI6Cj4+IDIzLjA0LjIwMjEgMTg6MDEs
IEd1aWxsYXVtZSBUdWNrZXIg0L/QuNGI0LXRgjoKPj4+IE9uIDAyLzA0LzIwMjEgMTU6NDAsIERt
aXRyeSBPc2lwZW5rbyB3cm90ZToKPj4+PiAwMS4wNC4yMDIxIDExOjU1LCBOaWNvbGluIENoZW4g
0L/QuNGI0LXRgjoKPj4+Pj4gT24gTW9uLCBNYXIgMjksIDIwMjEgYXQgMDI6MzI6NTZBTSArMDMw
MCwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+Pj4+Pj4gVGhlIHByZXZpb3VzIGNvbW1pdCBmaXhl
cyBwcm9ibGVtIHdoZXJlIGRpc3BsYXkgY2xpZW50IHdhcyBhdHRhY2hpbmcgdG9vCj4+Pj4+PiBl
YXJseSB0byBJT01NVSBkdXJpbmcga2VybmVsIGJvb3QgaW4gYSBtdWx0aS1wbGF0Zm9ybSBrZXJu
ZWwgY29uZmlndXJhdGlvbgo+Pj4+Pj4gd2hpY2ggZW5hYmxlcyBDT05GSUdfQVJNX0RNQV9VU0Vf
SU9NTVU9eS4gVGhlIHdvcmthcm91bmQgdGhhdCBoZWxwZWQgdG8KPj4+Pj4+IGRlZmVyIHRoZSBJ
T01NVSBhdHRhY2htZW50IGZvciBOeWFuIEJpZyBDaHJvbWVib29rIGlzbid0IG5lZWRlZCBhbnlt
b3JlLAo+Pj4+Pj4gcmV2ZXJ0IGl0Lgo+Pj4+Pgo+Pj4+PiBTb3JyeSBmb3IgdGhlIGxhdGUgcmVw
bHkuIEkgaGF2ZSBiZWVuIGJ1c3kgd2l0aCBkb3duc3RyZWFtIHRhc2tzLgo+Pj4+Pgo+Pj4+PiBJ
IHdpbGwgZ2l2ZSB0aGVtIGEgdHJ5IGJ5IHRoZSBlbmQgb2YgdGhlIHdlZWsuIFlldCwgcHJvYmFi
bHkgaXQnZAo+Pj4+PiBiZSBiZXR0ZXIgdG8gaW5jbHVkZSBHdWlsbGF1bWUgYWxzbyBhcyBoZSBo
YXMgdGhlIE55YW4gcGxhdGZvcm0uCj4+Pj4+Cj4+Pj4KPj4+PiBJbmRlZWQsIHRoYW5rcy4gQWx0
aG91Z2gsIEknbSBwcmV0dHkgc3VyZSB0aGF0IGl0J3MgdGhlIHNhbWUgaXNzdWUgd2hpY2gKPj4+
PiBJIHJlcHJvZHVjZWQgb24gTmV4dXMgNy4KPj4+Pgo+Pj4+IEd1aWxsYXVtZSwgY291bGQgeW91
IHBsZWFzZSBnaXZlIGEgdGVzdCB0byB0aGVzZSBwYXRjaGVzIG9uIE55YW4gQmlnPwo+Pj4+IFRo
ZXJlIHNob3VsZCBiZSBubyBFTUVNIGVycm9ycyBpbiB0aGUga2VybmVsIGxvZyB3aXRoIHRoaXMg
cGF0Y2hlcy4KPj4+Pgo+Pj4+IGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcHJvamVjdC9s
aW51eC10ZWdyYS9saXN0Lz9zZXJpZXM9MjM2MjE1Cj4+Pgo+Pj4gU28gc29ycnkgZm9yIHRoZSB2
ZXJ5IGxhdGUgcmVwbHkuICBJIGhhdmUgdHJpZWQgdGhlIHBhdGNoZXMgYnV0Cj4+PiBoaXQgc29t
ZSBpc3N1ZXMgb24gbGludXgtbmV4dCwgaXQncyBub3QgcmVhY2hpbmcgYSBsb2dpbiBwcm9tcHQK
Pj4+IHdpdGggbmV4dC0yMDIxMDQyMi4gIFNvIEkgdGhlbiB0cmllZCB3aXRoIG5leHQtMjAyMTA0
MTkgd2hpY2gKPj4+IGRvZXMgYm9vdCBidXQgc2hvd3MgdGhlIElPTU1VIGVycm9yOgo+Pj4KPj4+
IDw2PlsgICAgMi45OTUzNDFdIHRlZ3JhLWRjIDU0MjAwMDAwLmRjOiBBZGRpbmcgdG8gaW9tbXUg
Z3JvdXAgMQo+Pj4gPDQ+WyAgICAzLjAwMTA3MF0gRmFpbGVkIHRvIGF0dGFjaGVkIGRldmljZSA1
NDIwMDAwMC5kYyB0byBJT01NVV9tYXBwaW5nICAKPj4+Cj4+PiAgIGh0dHBzOi8vbGF2YS5jb2xs
YWJvcmEuY28udWsvc2NoZWR1bGVyL2pvYi8zNTcwMDUyI0wxMTIwCj4+Pgo+Pj4gVGhlIGJyYW5j
aCBJJ20gdXNpbmcgd2l0aCB0aGUgcGF0Y2hlcyBhcHBsaWVkIGNhbiBiZSBmb3VuZCBoZXJlOgo+
Pj4KPj4+ICAgaHR0cHM6Ly9naXRsYWIuY29sbGFib3JhLmNvbS9ndHVja2VyL2xpbnV4Ly0vY29t
bWl0cy9uZXh0LTIwMjEwNDE5LW55YW4tYmlnLWRybS1yZWFkLwo+Pj4KPj4+IEhvcGUgdGhpcyBo
ZWxwcywgbGV0IG1lIGtub3cgaWYgeW91IG5lZWQgYW55dGhpbmcgZWxzZSB0byBiZQo+Pj4gdGVz
dGVkLgo+Pgo+Pgo+PiBIZWxsbyBHdWlsbGF1bWUsCj4+Cj4+IFRoZSBjdXJyZW50IGxpbnV4LW5l
eHQgZG9lc24ndCBib290IG9uIGFsbCBBUk0gKEFGQUlLKSwgdGhlIG9sZGVyCj4+IG5leHQtMjAy
MTA0MTMgd29ya3MuIFRoZSBhYm92ZSBtZXNzYWdlIHNob3VsZCBiZSB1bnJlbGF0ZWQgdG8gdGhl
IGJvb3QKPj4gcHJvYmxlbS4gSXQgc2hvdWxkIGJlIG9rYXkgdG8gaWdub3JlIHRoYXQgbWVzc2Fn
ZSBhcyBpdCBzaG91bGQgYmUKPj4gaGFybWxlc3MgaW4geW91cnMgY2FzZS4KPj4KPiAKPiBBbHRo
b3VnaCwgdGhlIDIwMjEwNDE5IHNob3VsZCBiZSBnb29kLgo+IAo+IFRoaWVycnksIGRvIHlvdSBr
bm93IHdoYXQgdGhvc2UgU09SIGFuZCBOb3V2ZWF1IGlzc3VlcyBhcmUgYWJvdXQ/Cj4gCgpJIGRv
bid0IHNlZSBEUk0gZHJpdmVyIGJlaW5nIGxvYWRlZCBhdCBhbGwgYW5kIG5vIGVycm9ycyByZWxh
dGVkIHRvIGl0CmluIHRoZSBsb2cuIFRoaXMgbWVhbnMgdGhhdCBsaWtlbHkgc29tZSBvZiB0aGUg
RFJNIHN1Yi1kcml2ZXJzIGlzIHN0dWNrCmluIGRlZmVycmVkIHByb2JlLgoKR3VpbGxhdW1lLCBj
b3VsZCB5b3UgcGxlYXNlIHNob3cgY29udGVudHMgb2YKL3N5cy9rZXJuZWwvZGVidWcvZGV2aWNl
c19kZWZlcnJlZCA/CgpUaGVzZSBtZXNzYWdlcyBhbHNvIGRvbid0IGxvb2sgZ29vZDoKCnRlZ3Jh
LXh1c2ItcGFkY3RsIDcwMDlmMDAwLnBhZGN0bDogZmFpbGVkIHRvIHNldHVwIFhVU0IgcG9ydHM6
IC0yMgp0ZWdyYS14dXNiLXBhZGN0bDogcHJvYmUgb2YgNzAwOWYwMDAucGFkY3RsIGZhaWxlZCB3
aXRoIGVycm9yIC0yMgoKSSBkb24ndCBoYXZlIFQxMjQgYW5kIGFsbCB0aGVzZSBwcm9ibGVtcyBz
aG91bGQgYmUgc3BlY2lmaWMgdG8gdGhlIFQxMjQKcGxhdGZvcm0uIFNvbWVib2R5IHdpdGggYSBk
aXJlY3QgYWNjZXNzIHRvIGhhcmR3YXJlIHNob3VsZCBsb29rIGludG8gaXQuCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdApp
b21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
