Return-Path: <SRS0=f2Pc=WY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86718C3A5A1
	for <iommu@archiver.kernel.org>; Wed, 28 Aug 2019 11:51:32 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 559E12189D
	for <iommu@archiver.kernel.org>; Wed, 28 Aug 2019 11:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="FQ5eduxF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 559E12189D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 132E42BE1;
	Wed, 28 Aug 2019 11:51:32 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B21FF2BD3
	for <iommu@lists.linux-foundation.org>;
	Wed, 28 Aug 2019 11:51:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
	[209.85.128.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id BE29388E
	for <iommu@lists.linux-foundation.org>;
	Wed, 28 Aug 2019 11:51:12 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id v15so2475905wml.0
	for <iommu@lists.linux-foundation.org>;
	Wed, 28 Aug 2019 04:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=baylibre-com.20150623.gappssmtp.com; s=20150623;
	h=subject:to:cc:references:from:openpgp:autocrypt:organization
	:message-id:date:user-agent:mime-version:in-reply-to
	:content-language:content-transfer-encoding;
	bh=OPGG8NVnmDSQolWAHMZe0y74WY9A2ARnIE2fM0ThgJ0=;
	b=FQ5eduxFQZF7slMWSH2UtKz0OZ3aobXFmEd6pvkEIfDn9LRsSEnWKZmR+ruHXko9dd
	iGowVaNKOevuupxzVQwYDhzm9AocxkXWbvziztC/1GLwgP9RjiJXS+IutXb5XxyUhEF/
	UJ9xW/n79FTdx//w/oK+OsWhsYM/GHcIEmoH8VMCXuxw8K4leApxsq5CDT2ClSMejUby
	SZq3zbEEg7vktGnON1Rw1KghIE9/1g0BUK/UtmbIn5xVoouc+eIe6TS5wIiD+euaH26/
	uuISBFiE1CC/k3eoxqsR4Habaa9d5Tz7hB+l7/EkAlKOROXKb9IGqpF/A20KMSoNAQ4H
	Z27w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
	:organization:message-id:date:user-agent:mime-version:in-reply-to
	:content-language:content-transfer-encoding;
	bh=OPGG8NVnmDSQolWAHMZe0y74WY9A2ARnIE2fM0ThgJ0=;
	b=MtbrITEJvKnNh6mxbWu3bbZENZ16/1DOcoZrtkcRB6HGwAaj/jMUKuE6y6iTIFOY/T
	l6GWBPmOh0laO3d/GXJ1ivO7AgPTGJTEMxCbYdBZ0lGgqgEdjnmWNa3rP8b46YW3viIW
	31U3d/w1d42pANbVaFG/n4ZrfgbkntquUpnSTybtHhyaS28B96ezIl6gKWVZbnINWdrh
	4C6FGik3iinz+WkEw6b9LwFHJAP0g/xvEJ8hNBS8LhWLoC1J1ox5zdSRaVSlyv0jXUYA
	9jtHCFW5weoex7KjSasmK70Xj2AMkDyXMoBdFWzFGYrATGcSFVWWGa5QMySyFBJtleJf
	sYyA==
X-Gm-Message-State: APjAAAXqbawcgseQxiAd8a35w84uSS94I+Qwu8/py90HtdOcbRMF/A54
	kKB6d0SvH108qxFbzqJPdpKo6A==
X-Google-Smtp-Source: APXvYqw2CeJSkU5OGptxBhQGgOi13P3xb9BZGlAOYl+qYr24GjtB7ejUka0DLoP06U4fNmIMbTJslQ==
X-Received: by 2002:a7b:cbcf:: with SMTP id n15mr4494923wmi.48.1566993071134; 
	Wed, 28 Aug 2019 04:51:11 -0700 (PDT)
Received: from [10.1.3.173] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr.
	[90.63.244.31]) by smtp.gmail.com with ESMTPSA id
	e15sm1608219wrj.74.2019.08.28.04.51.10
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 28 Aug 2019 04:51:10 -0700 (PDT)
Subject: Re: [PATCH v6 0/6] Allwinner H6 Mali GPU support
To: Robin Murphy <robin.murphy@arm.com>,
	Tomeu Vizoso <tomeu.vizoso@collabora.com>
References: <20190521161102.29620-1-peron.clem@gmail.com>
	<CAAObsKD8bij1ANLqX6y11Y6mDEXiymNjrDkmHmvGWiFLKWu_FA@mail.gmail.com>
	<4ff02295-6c34-791b-49f4-6558a92ad7a3@arm.com>
	<CAAObsKBt1tPw9RKGi_Xey=1zy9Tu3N+A=1te2R8=NuJ5tDBqVg@mail.gmail.com>
	<dc3872a4-8cd9-462b-9f73-0d69a810d985@arm.com>
	<92e9b697-ea0d-9b13-5512-b0a16a39df20@baylibre.com>
	<8433455c-3b74-c176-49a1-388b3f085e9e@arm.com>
From: Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
	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
	ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <e44e1160-619d-989d-fbe7-2552b1e3bf88@baylibre.com>
Date: Wed, 28 Aug 2019 13:51:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <8433455c-3b74-c176-49a1-388b3f085e9e@arm.com>
Content-Language: en-US
Cc: Mark Rutland <mark.rutland@arm.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>,
	Linux IOMMU <iommu@lists.linux-foundation.org>,
	David Airlie <airlied@linux.ie>, Will Deacon <will.deacon@arm.com>,
	open list <linux-kernel@vger.kernel.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	Steven Price <steven.price@arm.com>,
	Maxime Ripard <maxime.ripard@bootlin.com>,
	Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
	=?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>
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

T24gMjgvMDgvMjAxOSAxMzo0OSwgUm9iaW4gTXVycGh5IHdyb3RlOgo+IEhpIE5laWwsCj4gCj4g
T24gMjgvMDgvMjAxOSAxMjoyOCwgTmVpbCBBcm1zdHJvbmcgd3JvdGU6Cj4+IEhpIFJvYmluLAo+
PgoKWy4uLl0KPj4+Cj4+PiBPSyAtIHdpdGggdGhlIDMyLWJpdCBoYWNrIHBvaW50ZWQgdG8gdXAt
dGhyZWFkLCBhIHF1aWNrIGttc2N1YmUgdGVzdCBnYXZlIG1lIHRoZSBpbXByZXNzaW9uIHRoYXQg
VDcyMCB3b3JrcyBmaW5lLCBidXQgb24gY2xvc2VyIGluc3BlY3Rpb24gc29tZSBwYXJ0cyBvZiBn
bG1hcmsyIGRvIHNlZW0gdG8gZ28gYSBiaXQgd29ua3kgKGFsdGhvdWdoIEkgc3VzcGVjdCBhdCBs
ZWFzdCBzb21lIG9mIGl0IGlzIGp1c3QgZG93biB0byB0aGUgRlBHQSBzZXR1cCBiZWluZyBib3Ro
IHZlcnkgc2xvdyBhbmQgbGFja2luZyBpbiBtZW1vcnkgYmFuZHdpZHRoKSwgYW5kIHRoZSAibnYx
Mi0xaW1nIiBtb2RlIG9mIGttc2N1YmUgdHVybnMgb3V0IHRvIHJlbmRlciBpbiBzb21lIGRlbGln
aHRmdWxseSB3cm9uZyBjb2xvdXJzLgo+Pj4KPj4+IEknbGwgdHJ5IHRvIGdldCBhICdwcm9wZXIn
IHZlcnNpb24gb2YgdGhlIGlvLXBndGFibGUgcGF0Y2ggcG9zdGVkIHNvb24uCj4+Cj4+IEknbSB0
cnlpbmcgdG8gY29sbGVjdCBhbGwgdGhlIGZpeGVzIG5lZWRlZCB0byBtYWtlIFQ4MjAgd29yayBh
Z2FpbiwgYW5kCj4+IEkgd2FzIHdvbmRlcmluZyBpZiB5b3UgZmluYWxseSBoYXZlIGEgcHJvcGVy
IHBhdGNoIGZvciB0aGlzIGFuZCAiY2ZnLT5pYXMgPiA0OCIKPj4gaGFjayA/IE9yIG9uZSBJIGNh
biB0ZXN0ID8KPiAKPiBJIGRvIGhhdmUgYSBoYW5kZnVsIG9mIGlvLXBndGFibGUgcGF0Y2hlcyB3
cml0dGVuIHVwIGFuZCByZWFkeSB0byBnbywgSSdtIGp1c3QgdHJlYWRpbmcgY2FyZWZ1bGx5IGFu
ZCB3YWl0aW5nIGZvciB0aGUgaW50ZXJuYWwgYXBwcm92YWwgYm94IHRvIGJlIHRpY2tlZCBiZWZv
cmUgSSBzaGFyZSBhbnl0aGluZyA6KAoKR3JlYXQgIQoKTm8gcHJvYmxlbSwgaXQgY2FuIHRvdGFs
bHkgd2FpdCB1bnRpbCBhcHByb3ZhbCwKClRoYW5rcywKTmVpbAoKPiAKPiBSb2Jpbi4KPiAKPj4K
Pj4gVGhhbmtzLAo+PiBOZWlsCj4+Cj4+Pgo+Pj4gVGhhbmtzLAo+Pj4gUm9iaW4uCj4+Pgo+Pj4+
Cj4+Pj4gQ2hlZXJzLAo+Pj4+Cj4+Pj4gVG9tZXUKPj4+Pgo+Pj4+PiBSb2Jpbi4KPj4+Pj4KPj4+
Pj4KPj4+Pj4gLS0tLS0+OC0tLS0tCj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2lv
LXBndGFibGUtYXJtLmMgYi9kcml2ZXJzL2lvbW11L2lvLXBndGFibGUtYXJtLmMKPj4+Pj4gaW5k
ZXggNTQ2OTY4ZDhhMzQ5Li5mMjlkYTZlOGRjMDggMTAwNjQ0Cj4+Pj4+IC0tLSBhL2RyaXZlcnMv
aW9tbXUvaW8tcGd0YWJsZS1hcm0uYwo+Pj4+PiArKysgYi9kcml2ZXJzL2lvbW11L2lvLXBndGFi
bGUtYXJtLmMKPj4+Pj4gQEAgLTEwMjMsMTIgKzEwMjMsMTQgQEAgYXJtX21hbGlfbHBhZV9hbGxv
Y19wZ3RhYmxlKHN0cnVjdAo+Pj4+PiBpb19wZ3RhYmxlX2NmZyAqY2ZnLCB2b2lkICpjb29raWUp
Cj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBpb3AgPSBhcm1fNjRfbHBhZV9hbGxvY19wZ3RhYmxl
X3MxKGNmZywgY29va2llKTsKPj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChpb3ApIHsKPj4+
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1NjQgbWFpciwgdHRicjsKPj4+
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGFybV9scGFlX2lvX3BndGFi
bGUgKmRhdGEgPSBpb19wZ3RhYmxlX29wc190b19kYXRhKCZpb3AtPm9wcyk7Cj4+Pj4+Cj4+Pj4+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRhdGEtPmxldmVscyA9IDQ7Cj4+Pj4+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogQ29weSB2YWx1ZXMgYXMgdW5pb24g
ZmllbGRzIG92ZXJsYXAgKi8KPj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBtYWlyID0gY2ZnLT5hcm1fbHBhZV9zMV9jZmcubWFpclswXTsKPj4+Pj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0dGJyID0gY2ZnLT5hcm1fbHBhZV9zMV9jZmcudHRiclsw
XTsKPj4+Pj4KPj4+Pj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KPj4+Pj4gZHJpLWRldmVsIG1haWxpbmcgbGlzdAo+Pj4+PiBkcmktZGV2ZWxAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCj4+Pj4+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vZHJpLWRldmVsCj4+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vaW9tbXU=
