Return-Path: <SRS0=1UcA=JV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A10C433ED
	for <iommu@archiver.kernel.org>; Sat, 24 Apr 2021 20:27:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48187611CB
	for <iommu@archiver.kernel.org>; Sat, 24 Apr 2021 20:27:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48187611CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0DD2F400E4;
	Sat, 24 Apr 2021 20:27:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9eETCtHRrfXx; Sat, 24 Apr 2021 20:27:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id E9E42400AB;
	Sat, 24 Apr 2021 20:27:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1751C000F;
	Sat, 24 Apr 2021 20:27:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07A09C000B
 for <iommu@lists.linux-foundation.org>; Sat, 24 Apr 2021 20:27:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EE2D4403F8
 for <iommu@lists.linux-foundation.org>; Sat, 24 Apr 2021 20:27:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vGgTUR_8aXlo for <iommu@lists.linux-foundation.org>;
 Sat, 24 Apr 2021 20:27:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 87BE8403F7
 for <iommu@lists.linux-foundation.org>; Sat, 24 Apr 2021 20:27:13 +0000 (UTC)
Received: by mail-lj1-x229.google.com with SMTP id z23so12995386lji.4
 for <iommu@lists.linux-foundation.org>; Sat, 24 Apr 2021 13:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=akaFyjlJawcZhlN19BfOzYv3nfkA3HMJk9vvTeGaZDE=;
 b=KnWdVZ27vn/9TonspL6cS/l0i7OahlQ7Vgk3cqUAx9ic3LEkRs256To8zXcyC9PNvl
 CzLaGM9heWk5QUs/yR7Q/+lEX/mHuxo99EIt0/TkdxSqxotrUyARQ7ln7EogwISFGXzC
 DDi4AooQ1cnPBVDvWPxDCCLlPqh8e6E3bDEsCs1u5s8hDfAGTWOiKJxnEYeAEHIicfhI
 kUKx5v/n0I+1O3HBYREvY9CzFF8qI+6qH63LecgR7zR4Chvwrbm/zlmTXv6niwxF9g/b
 QhWXMzxXMQmf21uudddtdil1IFRdqxe/9YsRl65HyMzbC/8Rx2wsZBV7Dp5niMHn6kjv
 9bpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=akaFyjlJawcZhlN19BfOzYv3nfkA3HMJk9vvTeGaZDE=;
 b=dAD5gbMLB97voHWUKbZsd8DQekh5lTWBWxugZgSJQnIPHWYUt5x5nvSBNZ3Hvv8s2f
 EUKkX68s2ynjzukw2wGug6TqUVe6NK6VXR6HKwKHtuYTYxnh4FqUnBGDF2NyzOUND2qu
 4PaS8UTXD1YuvICcTTNdp6njyOyIsm1v+npw44nRNNk4Vjwt1OuRyAKPLPR04jXAyd6I
 wAcAdCWxlhL/rt+wqjutADsWpGsP/P9anzKquWsjYVCvwnB/8WUhbhKLQbn2+6Scav4Y
 zDL+pNCAnyY2PS+uJhGOljVpM9a3cjDe7TtcJ8JLmFgme3QDWjwqZK4spYDqlk/Wzg0e
 sHgw==
X-Gm-Message-State: AOAM532llfCAEOCSW4faHHLY9NcTWNjG6X4JpFxgV7GDD61A6Vd0YqYq
 dadKtX05xsdypfbNWINg1sY=
X-Google-Smtp-Source: ABdhPJyTXOXVdWtPeJpKdv3M/Hf7CSGsvwvwmmNuIjKxmGoNq6aa/Iog4SIz+cgrfVekK/A6PrfZLQ==
X-Received: by 2002:a2e:b6c4:: with SMTP id m4mr6989287ljo.185.1619296031440; 
 Sat, 24 Apr 2021 13:27:11 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-103.dynamic.spd-mgts.ru.
 [109.252.193.103])
 by smtp.googlemail.com with ESMTPSA id y16sm938774ljh.13.2021.04.24.13.27.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Apr 2021 13:27:11 -0700 (PDT)
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
Message-ID: <5ec2be61-a70e-e3b1-9267-414793c32a04@gmail.com>
Date: Sat, 24 Apr 2021 23:27:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <724e683f-5317-cdf7-7351-fcfd42b7b607@gmail.com>
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

MjMuMDQuMjAyMSAxODoyMywgRG1pdHJ5IE9zaXBlbmtvINC/0LjRiNC10YI6Cj4gMjMuMDQuMjAy
MSAxODowMSwgR3VpbGxhdW1lIFR1Y2tlciDQv9C40YjQtdGCOgo+PiBPbiAwMi8wNC8yMDIxIDE1
OjQwLCBEbWl0cnkgT3NpcGVua28gd3JvdGU6Cj4+PiAwMS4wNC4yMDIxIDExOjU1LCBOaWNvbGlu
IENoZW4g0L/QuNGI0LXRgjoKPj4+PiBPbiBNb24sIE1hciAyOSwgMjAyMSBhdCAwMjozMjo1NkFN
ICswMzAwLCBEbWl0cnkgT3NpcGVua28gd3JvdGU6Cj4+Pj4+IFRoZSBwcmV2aW91cyBjb21taXQg
Zml4ZXMgcHJvYmxlbSB3aGVyZSBkaXNwbGF5IGNsaWVudCB3YXMgYXR0YWNoaW5nIHRvbwo+Pj4+
PiBlYXJseSB0byBJT01NVSBkdXJpbmcga2VybmVsIGJvb3QgaW4gYSBtdWx0aS1wbGF0Zm9ybSBr
ZXJuZWwgY29uZmlndXJhdGlvbgo+Pj4+PiB3aGljaCBlbmFibGVzIENPTkZJR19BUk1fRE1BX1VT
RV9JT01NVT15LiBUaGUgd29ya2Fyb3VuZCB0aGF0IGhlbHBlZCB0bwo+Pj4+PiBkZWZlciB0aGUg
SU9NTVUgYXR0YWNobWVudCBmb3IgTnlhbiBCaWcgQ2hyb21lYm9vayBpc24ndCBuZWVkZWQgYW55
bW9yZSwKPj4+Pj4gcmV2ZXJ0IGl0Lgo+Pj4+Cj4+Pj4gU29ycnkgZm9yIHRoZSBsYXRlIHJlcGx5
LiBJIGhhdmUgYmVlbiBidXN5IHdpdGggZG93bnN0cmVhbSB0YXNrcy4KPj4+Pgo+Pj4+IEkgd2ls
bCBnaXZlIHRoZW0gYSB0cnkgYnkgdGhlIGVuZCBvZiB0aGUgd2Vlay4gWWV0LCBwcm9iYWJseSBp
dCdkCj4+Pj4gYmUgYmV0dGVyIHRvIGluY2x1ZGUgR3VpbGxhdW1lIGFsc28gYXMgaGUgaGFzIHRo
ZSBOeWFuIHBsYXRmb3JtLgo+Pj4+Cj4+Pgo+Pj4gSW5kZWVkLCB0aGFua3MuIEFsdGhvdWdoLCBJ
J20gcHJldHR5IHN1cmUgdGhhdCBpdCdzIHRoZSBzYW1lIGlzc3VlIHdoaWNoCj4+PiBJIHJlcHJv
ZHVjZWQgb24gTmV4dXMgNy4KPj4+Cj4+PiBHdWlsbGF1bWUsIGNvdWxkIHlvdSBwbGVhc2UgZ2l2
ZSBhIHRlc3QgdG8gdGhlc2UgcGF0Y2hlcyBvbiBOeWFuIEJpZz8KPj4+IFRoZXJlIHNob3VsZCBi
ZSBubyBFTUVNIGVycm9ycyBpbiB0aGUga2VybmVsIGxvZyB3aXRoIHRoaXMgcGF0Y2hlcy4KPj4+
Cj4+PiBodHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3Byb2plY3QvbGludXgtdGVncmEvbGlz
dC8/c2VyaWVzPTIzNjIxNQo+Pgo+PiBTbyBzb3JyeSBmb3IgdGhlIHZlcnkgbGF0ZSByZXBseS4g
IEkgaGF2ZSB0cmllZCB0aGUgcGF0Y2hlcyBidXQKPj4gaGl0IHNvbWUgaXNzdWVzIG9uIGxpbnV4
LW5leHQsIGl0J3Mgbm90IHJlYWNoaW5nIGEgbG9naW4gcHJvbXB0Cj4+IHdpdGggbmV4dC0yMDIx
MDQyMi4gIFNvIEkgdGhlbiB0cmllZCB3aXRoIG5leHQtMjAyMTA0MTkgd2hpY2gKPj4gZG9lcyBi
b290IGJ1dCBzaG93cyB0aGUgSU9NTVUgZXJyb3I6Cj4+Cj4+IDw2PlsgICAgMi45OTUzNDFdIHRl
Z3JhLWRjIDU0MjAwMDAwLmRjOiBBZGRpbmcgdG8gaW9tbXUgZ3JvdXAgMQo+PiA8ND5bICAgIDMu
MDAxMDcwXSBGYWlsZWQgdG8gYXR0YWNoZWQgZGV2aWNlIDU0MjAwMDAwLmRjIHRvIElPTU1VX21h
cHBpbmcgIAo+Pgo+PiAgIGh0dHBzOi8vbGF2YS5jb2xsYWJvcmEuY28udWsvc2NoZWR1bGVyL2pv
Yi8zNTcwMDUyI0wxMTIwCj4+Cj4+IFRoZSBicmFuY2ggSSdtIHVzaW5nIHdpdGggdGhlIHBhdGNo
ZXMgYXBwbGllZCBjYW4gYmUgZm91bmQgaGVyZToKPj4KPj4gICBodHRwczovL2dpdGxhYi5jb2xs
YWJvcmEuY29tL2d0dWNrZXIvbGludXgvLS9jb21taXRzL25leHQtMjAyMTA0MTktbnlhbi1iaWct
ZHJtLXJlYWQvCj4+Cj4+IEhvcGUgdGhpcyBoZWxwcywgbGV0IG1lIGtub3cgaWYgeW91IG5lZWQg
YW55dGhpbmcgZWxzZSB0byBiZQo+PiB0ZXN0ZWQuCj4gCj4gCj4gSGVsbG8gR3VpbGxhdW1lLAo+
IAo+IFRoZSBjdXJyZW50IGxpbnV4LW5leHQgZG9lc24ndCBib290IG9uIGFsbCBBUk0gKEFGQUlL
KSwgdGhlIG9sZGVyCj4gbmV4dC0yMDIxMDQxMyB3b3Jrcy4gVGhlIGFib3ZlIG1lc3NhZ2Ugc2hv
dWxkIGJlIHVucmVsYXRlZCB0byB0aGUgYm9vdAo+IHByb2JsZW0uIEl0IHNob3VsZCBiZSBva2F5
IHRvIGlnbm9yZSB0aGF0IG1lc3NhZ2UgYXMgaXQgc2hvdWxkIGJlCj4gaGFybWxlc3MgaW4geW91
cnMgY2FzZS4KPiAKCkFsdGhvdWdoLCB0aGUgMjAyMTA0MTkgc2hvdWxkIGJlIGdvb2QuCgpUaGll
cnJ5LCBkbyB5b3Uga25vdyB3aGF0IHRob3NlIFNPUiBhbmQgTm91dmVhdSBpc3N1ZXMgYXJlIGFi
b3V0PwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21t
dSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
