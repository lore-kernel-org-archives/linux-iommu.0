Return-Path: <SRS0=ss7l=MJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF2AC636C9
	for <iommu@archiver.kernel.org>; Sat, 17 Jul 2021 11:07:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 002F2613C4
	for <iommu@archiver.kernel.org>; Sat, 17 Jul 2021 11:07:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 002F2613C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 99D356071A;
	Sat, 17 Jul 2021 11:07:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VEV5FE5sbx4J; Sat, 17 Jul 2021 11:07:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AAF0760707;
	Sat, 17 Jul 2021 11:07:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7810DC0010;
	Sat, 17 Jul 2021 11:07:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF8C7C000E
 for <iommu@lists.linux-foundation.org>; Sat, 17 Jul 2021 11:07:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C2FC9400C1
 for <iommu@lists.linux-foundation.org>; Sat, 17 Jul 2021 11:07:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NO8YC1xdsA3D for <iommu@lists.linux-foundation.org>;
 Sat, 17 Jul 2021 11:07:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EE2BA400BF
 for <iommu@lists.linux-foundation.org>; Sat, 17 Jul 2021 11:07:15 +0000 (UTC)
Received: by mail-lf1-x12d.google.com with SMTP id g22so8542010lfu.0
 for <iommu@lists.linux-foundation.org>; Sat, 17 Jul 2021 04:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=qMrX7WvYGhD3GqZFeNbtHDq067pHxr3zLsoCTOyMBjM=;
 b=dsijzo4vEj8KZtdurdc114VSsLZXXsuRpxBH/77DKFEgr/0Z0oGC9T3wrbLdgSVVzd
 N0xMxrQHPTgo4YgqNjcmN6CA9NsIVx+zmuDMhE/omHYRa2i4renzGAZUQW0asqFFB2hn
 DzPa3ZJA8HPdcaoxC9NRXJir2+hr0oRBa/hgsCXoIt6ZZ+hszLr7osVGVQLT1PJYBaF0
 v/l9vxMYMHbqW6enlLa5MEG5MfIy8BqJ0//zv6hQHSH/DwG79bCYesgOd1MmRjux3XEO
 eaE4NAMa7yLM8tmFELXnIaTR5QklMLZP82MLcgmQJDvEM5Ysl/DcMspkB0DIfi5MON+2
 xwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qMrX7WvYGhD3GqZFeNbtHDq067pHxr3zLsoCTOyMBjM=;
 b=RzLfzF/bj3Umw3cO7DzClufZpVp4JcYQRSTOSgSVtu4vvMchjmYzWokkEf5zB958ZT
 8pC1/I3PqMXSEzyZB4WH2uzEADG9N1S7anYafMtz9uwzd3N7ZQkD3qRyJkwm0CSWKag/
 qGtbN8Z/LkTXAVsKRMt8+qKx6k2Rj1C60y7TJZuC83WuzNI7RtFC/qJBnDpih7J+Uv67
 235QyKPNhMi32OpQDWVm4n6Zk8vuSLqtY8n0ridBANRQw5PeEAiVnICmNnDhXbImrVwZ
 Osn6Rb4KrYhdBQ+LAMu1jUikOMVX+P745tWojtYp/U4HR5Ll5BkNtWZH65EewOfaEifw
 Sb5g==
X-Gm-Message-State: AOAM531a8FkrKOYcFIhKP4NjyTi5dbnmXoHhdyO59/U5FpsVLP8HUlQs
 uQelryazMWBA3gMNswYYhh0=
X-Google-Smtp-Source: ABdhPJwJP3MZ4dXQV76Rrrje6RXF9KzFJnHPoRcHmpFN8/3gCS4H618y8JDLvB2jlNlyu1FGtCl11g==
X-Received: by 2002:ac2:483b:: with SMTP id 27mr10954908lft.397.1626520033755; 
 Sat, 17 Jul 2021 04:07:13 -0700 (PDT)
Received: from [192.168.2.145] (46-138-17-250.dynamic.spd-mgts.ru.
 [46.138.17.250])
 by smtp.googlemail.com with ESMTPSA id n23sm1224010ljc.23.2021.07.17.04.07.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Jul 2021 04:07:12 -0700 (PDT)
Subject: Re: [PATCH v2 2/5] iommu: Implement of_iommu_get_resv_regions()
To: Rob Herring <robh+dt@kernel.org>
References: <20210423163234.3651547-1-thierry.reding@gmail.com>
 <20210423163234.3651547-3-thierry.reding@gmail.com>
 <bdc42077-d1f3-f561-2e4d-647b5fceb7b6@gmail.com>
 <CAL_Jsq+jSY-OLau3gLPsDL02AYaE_TySOGrd9-tNLFaYvLHZ6A@mail.gmail.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <7f5c8094-6e4f-5a94-2257-1003a78ba92f@gmail.com>
Date: Sat, 17 Jul 2021 14:07:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+jSY-OLau3gLPsDL02AYaE_TySOGrd9-tNLFaYvLHZ6A@mail.gmail.com>
Content-Language: en-US
Cc: devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
 Will Deacon <will@kernel.org>, Linux IOMMU <iommu@lists.linux-foundation.org>,
 Thierry Reding <thierry.reding@gmail.com>, Nicolin Chen <nicolinc@nvidia.com>,
 linux-tegra <linux-tegra@vger.kernel.org>, Robin Murphy <robin.murphy@arm.com>
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

MTYuMDcuMjAyMSAxNzo0MSwgUm9iIEhlcnJpbmcg0L/QuNGI0LXRgjoKPiBPbiBGcmksIEp1bCAy
LCAyMDIxIGF0IDg6MDUgQU0gRG1pdHJ5IE9zaXBlbmtvIDxkaWdldHhAZ21haWwuY29tPiB3cm90
ZToKPj4KPj4gMjMuMDQuMjAyMSAxOTozMiwgVGhpZXJyeSBSZWRpbmcg0L/QuNGI0LXRgjoKPj4+
ICt2b2lkIG9mX2lvbW11X2dldF9yZXN2X3JlZ2lvbnMoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1
Y3QgbGlzdF9oZWFkICpsaXN0KQo+Pj4gK3sKPj4+ICsgICAgIHN0cnVjdCBvZl9waGFuZGxlX2l0
ZXJhdG9yIGl0Owo+Pj4gKyAgICAgaW50IGVycjsKPj4+ICsKPj4+ICsgICAgIG9mX2Zvcl9lYWNo
X3BoYW5kbGUoJml0LCBlcnIsIGRldi0+b2Zfbm9kZSwgIm1lbW9yeS1yZWdpb24iLCAiI21lbW9y
eS1yZWdpb24tY2VsbHMiLCAwKSB7Cj4+PiArICAgICAgICAgICAgIHN0cnVjdCBpb21tdV9yZXN2
X3JlZ2lvbiAqcmVnaW9uOwo+Pj4gKyAgICAgICAgICAgICBzdHJ1Y3Qgb2ZfcGhhbmRsZV9hcmdz
IGFyZ3M7Cj4+PiArICAgICAgICAgICAgIHN0cnVjdCByZXNvdXJjZSByZXM7Cj4+PiArCj4+PiAr
ICAgICAgICAgICAgIGFyZ3MuYXJnc19jb3VudCA9IG9mX3BoYW5kbGVfaXRlcmF0b3JfYXJncygm
aXQsIGFyZ3MuYXJncywgTUFYX1BIQU5ETEVfQVJHUyk7Cj4+PiArCj4+PiArICAgICAgICAgICAg
IGVyciA9IG9mX2FkZHJlc3NfdG9fcmVzb3VyY2UoaXQubm9kZSwgMCwgJnJlcyk7Cj4+PiArICAg
ICAgICAgICAgIGlmIChlcnIgPCAwKSB7Cj4+PiArICAgICAgICAgICAgICAgICAgICAgZGV2X2Vy
cihkZXYsICJmYWlsZWQgdG8gcGFyc2UgbWVtb3J5IHJlZ2lvbiAlcE9GOiAlZFxuIiwKPj4+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGl0Lm5vZGUsIGVycik7Cj4+PiArICAgICAgICAg
ICAgICAgICAgICAgY29udGludWU7Cj4+PiArICAgICAgICAgICAgIH0KPj4+ICsKPj4+ICsgICAg
ICAgICAgICAgaWYgKGFyZ3MuYXJnc19jb3VudCA+IDApIHsKPj4+ICsgICAgICAgICAgICAgICAg
ICAgICAvKgo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAqIEFjdGl2ZSBtZW1vcnkgcmVnaW9u
cyBhcmUgZXhwZWN0ZWQgdG8gYmUgYWNjZXNzZWQgYnkgaGFyZHdhcmUgZHVyaW5nCj4+PiArICAg
ICAgICAgICAgICAgICAgICAgICogYm9vdCBhbmQgbXVzdCB0aGVyZWZvcmUgaGF2ZSBhbiBpZGVu
dGl0eSBtYXBwaW5nIGNyZWF0ZWQgcHJpb3IgdG8gdGhlCj4+PiArICAgICAgICAgICAgICAgICAg
ICAgICogZHJpdmVyIHRha2luZyBjb250cm9sIG9mIHRoZSBoYXJkd2FyZS4gVGhpcyBlbnN1cmVz
IHRoYXQgbm9uLXF1aWVzY2VudAo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAqIGhhcmR3YXJl
IGRvZXNuJ3QgY2F1c2UgSU9NTVUgZmF1bHRzIGR1cmluZyBib290Lgo+Pj4gKyAgICAgICAgICAg
ICAgICAgICAgICAqLwo+Pj4gKyAgICAgICAgICAgICAgICAgICAgIGlmIChhcmdzLmFyZ3NbMF0g
JiBNRU1PUllfUkVHSU9OX0lERU5USVRZX01BUFBJTkcpIHsKPj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHJlZ2lvbiA9IGlvbW11X2FsbG9jX3Jlc3ZfcmVnaW9uKHJlcy5zdGFydCwg
cmVzb3VyY2Vfc2l6ZSgmcmVzKSwKPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIElPTU1VX1JFQUQgfCBJT01NVV9XUklURSwK
Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIElPTU1VX1JFU1ZfRElSRUNUX1JFTEFYQUJMRSk7Cj4+PiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBpZiAoIXJlZ2lvbikKPj4+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgY29udGludWU7Cj4+PiArCj4+PiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBsaXN0X2FkZF90YWlsKCZyZWdpb24tPmxpc3QsIGxpc3QpOwo+Pj4gKyAgICAgICAg
ICAgICAgICAgICAgIH0KPj4+ICsgICAgICAgICAgICAgfQo+Pj4gKyAgICAgfQo+Pj4gK30KPj4+
ICtFWFBPUlRfU1lNQk9MKG9mX2lvbW11X2dldF9yZXN2X3JlZ2lvbnMpOwo+Pgo+PiBBbnkgcmVh
c29uIHdoeSB0aGlzIGlzIG5vdCBFWFBPUlRfU1lNQk9MX0dQTD8gSSdtIGN1cmlvdXMgd2hhdCBp
cyB0aGUKPj4gbG9naWMgYmVoaW5kIHRoZSBPRiBzeW1ib2xzIGluIGdlbmVyYWwgc2luY2UgaXQg
bG9va3MgbGlrZSBoYWxmIG9mIHRoZW0KPj4gYXJlIEdQTC4KPiAKPiBHZW5lcmFsbHksIG5ldyBv
bmVzIGFyZSBfR1BMLiBPbGQgb25lcyBwcm9iYWJseSBwcmVkYXRlIF9HUEwuCj4gCj4gVGhpcyBv
bmUgaXMgdXAgdG8gdGhlIElPTU1VIG1haW50YWluZXJzLgoKVGhhbmsgeW91LgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0
CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
