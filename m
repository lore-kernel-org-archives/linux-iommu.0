Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA14C433EF
	for <iommu@archiver.kernel.org>; Tue, 21 Jun 2022 07:38:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B02744194F;
	Tue, 21 Jun 2022 07:38:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B02744194F
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=fg3yA65Y
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PLhQXqx7QNaZ; Tue, 21 Jun 2022 07:38:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F0E97402D4;
	Tue, 21 Jun 2022 07:38:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F0E97402D4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C6574C0032;
	Tue, 21 Jun 2022 07:38:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C7D18C002D
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 07:38:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A1E4040B2A
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 07:38:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A1E4040B2A
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=fg3yA65Y
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oSqjqkudu0tB for <iommu@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 07:38:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CFBB94023F
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CFBB94023F
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 07:38:15 +0000 (UTC)
Received: by mail-pl1-x62e.google.com with SMTP id m14so11786188plg.5
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 00:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=nk+fdQE93FqPegDOLztKBITezax/oNzcyKzefYaORp8=;
 b=fg3yA65YsHeVetLshPkg44ZoS0+r4kYz2gK82/9ZhWuhbuhVCG8b1IdASjgMLW9F8P
 wo5ttxvpAXD/hkkxsxLIM3+CBiBChOIsQ3RNAzLUsbHjSWRRQ1JoPJeddxJmPypYwIDm
 uLgUOck8sGg5x8fOxEN70TWDH9gWl9Wbnv+6R/mh1fTzZBKh+XeoxxFhRJgG5PZUK9DW
 nqfEtw30mbezb6SjSdTry30MQ96gE3J2Hddk1ntmpTBAhiKYHRFYBolJEKTxUXGTeuu/
 YfE/BdyNZZwSOCsxvcz1u38p0OwiwbgnrM79Hvr5UZyx3obezETo8+t91kh276rwrnYH
 KUvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=nk+fdQE93FqPegDOLztKBITezax/oNzcyKzefYaORp8=;
 b=yzZcQv40IJQiIYpO6jjGN8fs/nY0ICCcqi26nHSTu5T0LKgfWuyfTAi1FX8zlTx8hW
 TDbA2oV1usOo4YPo2uhkQaLQvWh+DAFYP7XzqxdzFgDP919pVzj+6s+YU1WIHi9j20Si
 /U0AfJfYBQ9cd1ZAm5756fMWtcXByNu8IZ8beWw+RPJyQp9WjIzQwg54KYGNDLakuKOv
 FeLtMZ4ZohzpPto/8wut4M2u2d1D75g43goRUmPFTta/J01WGBQXaDsb/MUh2wik0Q/R
 pAR/dcrNs+PI6H+E1mK9e5CvD3ugmrtbLU5MLrbm9KDjDoKEbuAgHFmsq49evCpDpzAk
 3lnA==
X-Gm-Message-State: AJIora8WoJ2GE+Phxi8mgevvJLd4QEmG3a+4dClsQG0ByYqSpyzoNy3d
 DX0Vwasc3eEyJLn35qO9CKf60A==
X-Google-Smtp-Source: AGRyM1tzcOchkt7DypAfKrCwXNSUY5s5v3wBe6Pw1F/TJ4XsfE6hlLD+8GcyGAve96CoC88+Qgh+mw==
X-Received: by 2002:a17:902:728d:b0:168:d0cf:2246 with SMTP id
 d13-20020a170902728d00b00168d0cf2246mr27711694pll.74.1655797095238; 
 Tue, 21 Jun 2022 00:38:15 -0700 (PDT)
Received: from [10.97.0.6] ([199.101.192.33]) by smtp.gmail.com with ESMTPSA id
 z4-20020a17090a66c400b001e345c579d5sm9463008pjl.26.2022.06.21.00.38.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jun 2022 00:38:14 -0700 (PDT)
Subject: Re: [PATCH] uacce: fix concurrency of fops_open and uacce_remove
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20220610123423.27496-1-zhangfei.gao@linaro.org>
 <Yqn3spLZHpAkQ9Us@myrica> <fdc8d8b0-4e04-78f5-1e8a-4cf44c89a37f@linaro.org>
 <YqrmdKNrYTCiS/MC@myrica> <d90e8ea5-2f18-2eda-b4b2-711083aa7ecd@linaro.org>
 <YrB1D9rv9G4h/BYU@myrica> <YrB30M9yAbUbPFrG@kroah.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <b5011dd2-e8ec-a307-1b43-5aff6cbb6891@linaro.org>
Date: Tue, 21 Jun 2022 15:37:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YrB30M9yAbUbPFrG@kroah.com>
Content-Language: en-US
Cc: Yang Shen <shenyang39@huawei.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-crypto@vger.kernel.org,
 linux-accelerators@lists.ozlabs.org
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

CgpPbiAyMDIyLzYvMjAg5LiL5Y2IOTozNiwgR3JlZyBLcm9haC1IYXJ0bWFuIHdyb3RlOgo+IE9u
IE1vbiwgSnVuIDIwLCAyMDIyIGF0IDAyOjI0OjMxUE0gKzAxMDAsIEplYW4tUGhpbGlwcGUgQnJ1
Y2tlciB3cm90ZToKPj4gT24gRnJpLCBKdW4gMTcsIDIwMjIgYXQgMDI6MDU6MjFQTSArMDgwMCwg
WmhhbmdmZWkgR2FvIHdyb3RlOgo+Pj4+IFRoZSByZWZjb3VudCBvbmx5IGVuc3VyZXMgdGhhdCB0
aGUgdWFjY2VfZGV2aWNlIG9iamVjdCBpcyBub3QgZnJlZWQgYXMKPj4+PiBsb25nIGFzIHRoZXJl
IGFyZSBvcGVuIGZkcy4gQnV0IHVhY2NlX3JlbW92ZSgpIGNhbiBydW4gd2hpbGUgdGhlcmUgYXJl
Cj4+Pj4gb3BlbiBmZHMsIG9yIGZkcyBpbiB0aGUgcHJvY2VzcyBvZiBiZWluZyBvcGVuZWQuIEFu
ZCBhdGZlciB1YWNjZV9yZW1vdmUoKQo+Pj4+IHJ1bnMsIHRoZSB1YWNjZV9kZXZpY2Ugb2JqZWN0
IHN0aWxsIGV4aXN0cyBidXQgaXMgbW9zdGx5IHVudXNhYmxlLiBGb3IKPj4+PiBleGFtcGxlIG9u
Y2UgdGhlIG1vZHVsZSBpcyBmcmVlZCwgdWFjY2UtPm9wcyBpcyBub3QgdmFsaWQgYW55bW9yZS4g
QnV0Cj4+Pj4gY3VycmVudGx5IHVhY2NlX2ZvcHNfb3BlbigpIG1heSBkZXJlZmVyZW5jZSB0aGUg
b3BzIGluIHRoaXMgY2FzZToKPj4+Pgo+Pj4+IAl1YWNjZV9mb3BzX29wZW4oKQo+Pj4+IAkgaWYg
KCF1YWNjZS0+cGFyZW50LT5kcml2ZXIpCj4+Pj4gCSAvKiBTdGlsbCB2YWxpZCwga2VlcCBnb2lu
ZyAqLwkJCj4+Pj4gCSAuLi4JCQkJCXJtbW9kCj4+Pj4gCQkJCQkJIHVhY2NlX3JlbW92ZSgpCj4+
Pj4gCSAuLi4JCQkJCSBmcmVlX21vZHVsZSgpCj4+Pj4gCSB1YWNjZS0+b3BzLT5nZXRfcXVldWUo
KSAvKiBCVUcgKi8KPj4+IHVhY2NlX3JlbW92ZSBzaG91bGQgd2FpdCBmb3IgdWFjY2UtPnF1ZXVl
c19sb2NrLCB1bnRpbCBmb3BzX29wZW4gcmVsZWFzZSB0aGUKPj4+IGxvY2suCj4+PiBJZiBvcGVu
IGhhcHBlbiBqdXN0IGFmdGVyIHRoZSB1YWNjZV9yZW1vdmU6IHVubG9jaywgdWFjY2VfYmluZF9x
dWV1ZSBpbiBvcGVuCj4+PiBzaG91bGQgZmFpbC4KPj4gQWggeWVzIHNvcnJ5LCBJIGxvc3Qgc2ln
aHQgb2Ygd2hhdCB0aGlzIHBhdGNoIHdhcyBhZGRpbmcuIEJ1dCB3ZSBjb3VsZAo+PiBoYXZlIHRo
ZSBzYW1lIGlzc3VlIHdpdGggdGhlIHBhdGNoLCBqdXN0IGluIGEgZGlmZmVyZW50IG9yZGVyLCBu
bz8KPj4KPj4gCXVhY2NlX2ZvcHNfb3BlbigpCj4+IAkgdWFjY2UgPSB4YV9sb2FkKCkKPj4gCSAu
Li4JCQkJCXJtbW9kCj4gVW0sIGhvdyBpcyBybW1vZCBjYWxsZWQgaWYgdGhlIGZpbGUgZGVzY3Jp
cHRvciBpcyBvcGVuPwo+Cj4gVGhhdCBzaG91bGQgbm90IGJlIHBvc3NpYmxlIGlmIHRoZSBvd25l
ciBvZiB0aGUgZmlsZSBkZXNjcmlwdG9yIGlzCj4gcHJvcGVybHkgc2V0LiAgUGxlYXNlIGZpeCB0
aGF0IHVwLgpUaGFua3MgR3JlZwoKU2V0IGNkZXYgb3duZXIgb3IgdXNlIG1vZHVsZV9nZXQvcHV0
IGNhbiBibG9jayBybW1vZCBvbmNlIGZvcHNfb3Blbi4KLcKgwqDCoMKgwqDCoCB1YWNjZS0+Y2Rl
di0+b3duZXIgPSBUSElTX01PRFVMRTsKK8KgwqDCoMKgwqDCoCB1YWNjZS0+Y2Rldi0+b3duZXIg
PSB1YWNjZS0+cGFyZW50LT5kcml2ZXItPm93bmVyOwoKSG93ZXZlciwgc3RpbGwgbm90IGZpbmQg
Z29vZCBtZXRob2QgdG8gYmxvY2sgcmVtb3ZpbmcgcGFyZW50IHBjaSBkZXZpY2UuCgokIGVjaG8g
MSA+IC9zeXMvYnVzL3BjaS9kZXZpY2VzLzAwMDA6MDA6MDIuMC9yZW1vdmUgJgoKW8KgwqAgMzIu
NTYzMzUwXcKgIHVhY2NlX3JlbW92ZSsweDZjLzB4MTQ4ClvCoMKgIDMyLjU2MzM1M13CoCBoaXNp
X3FtX3VuaW5pdCsweDEyYy8weDE3OApbwqDCoCAzMi41NjMzNTZdwqAgaGlzaV96aXBfcmVtb3Zl
KzB4YTAvMHhkMCBbaGlzaV96aXBdClvCoMKgIDMyLjU2MzM2MV3CoCBwY2lfZGV2aWNlX3JlbW92
ZSsweDQ0LzB4ZDgKW8KgwqAgMzIuNTYzMzY0XcKgIGRldmljZV9yZW1vdmUrMHg1NC8weDg4ClvC
oMKgIDMyLjU2MzM2N13CoCBkZXZpY2VfcmVsZWFzZV9kcml2ZXJfaW50ZXJuYWwrMHhlYy8weDFh
MApbwqDCoCAzMi41NjMzNzBdwqAgZGV2aWNlX3JlbGVhc2VfZHJpdmVyKzB4MjAvMHgzMApbwqDC
oCAzMi41NjMzNzJdwqAgcGNpX3N0b3BfYnVzX2RldmljZSsweDhjLzB4ZTAKW8KgwqAgMzIuNTYz
Mzc1XcKgIHBjaV9zdG9wX2FuZF9yZW1vdmVfYnVzX2RldmljZV9sb2NrZWQrMHgyOC8weDYwClvC
oMKgIDMyLjU2MzM3OF3CoCByZW1vdmVfc3RvcmUrMHg5Yy8weGIwClvCoMKgIDMyLjU2MzM3OV3C
oCBkZXZfYXR0cl9zdG9yZSsweDIwLzB4MzgKCm11dGV4X2xvY2soJmRldi0+ZGV2aWNlX2xvY2sp
IGNhbiBiZSB1c2VkLCB3aGljaCB1c2VkIGluIApkZXZpY2VfcmVsZWFzZV9kcml2ZXJfaW50ZXJu
YWwuCk9yIHVzZSBpbnRlcm5hbCBtdXRleC4KClRoYW5rcwpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vaW9tbXU=
