Return-Path: <SRS0=3mOG=IN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3689C433DB
	for <iommu@archiver.kernel.org>; Mon, 15 Mar 2021 18:53:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DC6C64F42
	for <iommu@archiver.kernel.org>; Mon, 15 Mar 2021 18:53:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DC6C64F42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EB01983443;
	Mon, 15 Mar 2021 18:53:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SWJHjdsZaMgo; Mon, 15 Mar 2021 18:53:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id ED79483498;
	Mon, 15 Mar 2021 18:53:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1B13C000B;
	Mon, 15 Mar 2021 18:53:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AAF9EC0001
 for <iommu@lists.linux-foundation.org>; Mon, 15 Mar 2021 18:53:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 82990430E8
 for <iommu@lists.linux-foundation.org>; Mon, 15 Mar 2021 18:53:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6i7uCOPryfV8 for <iommu@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 18:53:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 18EBB430C0
 for <iommu@lists.linux-foundation.org>; Mon, 15 Mar 2021 18:53:13 +0000 (UTC)
Received: by mail-lj1-x234.google.com with SMTP id u4so17531984ljo.6
 for <iommu@lists.linux-foundation.org>; Mon, 15 Mar 2021 11:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=v2HjbGIhGvuWN/p4wjJ96KHLGD4o/ABRVFbl69eEBO8=;
 b=K198jd8GCrMhGQV9zHTqbNijO9zf7hECliU2GYTo/l1yBT48UGhVAoSMrAYZOdidSR
 xL9r3gSdZzY62O/15Jac0+puQ0X4IIdemWdotS5KqAyzXnVFVpyHJDTrEJTNRteemBIh
 cnIFpJzmNnfaOaU2OevoS6zWzDFL20smLwAojHiU4RppLAcatpcpyWrov06OJZPXGrV8
 WkYTND0+aNAxRbUantlOmxsS+ZHgfValm+k5J/rzAxXkO0eEaUrqZsuYiOi0/04vNmKi
 aS6V/tdU0TRbkt4v6vJpR0drVnH04yp3UC6+TB16K6aFlWX0JH0NJLL+1ofkmuXquoiB
 w0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=v2HjbGIhGvuWN/p4wjJ96KHLGD4o/ABRVFbl69eEBO8=;
 b=JgujtS4h2kL31XZkuI+Uk2fHcTyBCWXBoSskRdAkeE+3a0EffnnED89rKGGEIzAwL0
 IEEN6xPwcoMD19DnCOetCqNcj7n8yUBuooTlnNK4yQ5u42NkD7yzHhEq5BJi5/tnoym+
 M8BDPzCFJwsDLnb85A2Zr/rX2C1B/NBk+m9CtrNBDoFXfprSZxLuBO27kC6VRuNm5ch3
 Qmi9Yem3Oi0KYeRjMVYZYMCMMsQpa9RUxI15uzHKD2Xqz4sSY7m2EvWA+USKGKrRYvfK
 SZxJyn932WtjeD6v/gXbaq32EKBnCscfqDItyfeDXrlX8RywH4SM5BQcDghE4c2BNqUG
 +eGA==
X-Gm-Message-State: AOAM533pFTYQ3eX2P1C7JL7XbuRV/Gdc4xucx9phX1DZ9lbmQSa6VLI6
 1FrQodNqXxz8YZx6yBSe3y0=
X-Google-Smtp-Source: ABdhPJy6jYga547W+kZ7ssngsB7IOF5Ki+SxAtWST/8lNgbHXrv8fNeEegpch9MQwzZE9m7KN0eocw==
X-Received: by 2002:a05:651c:339:: with SMTP id
 b25mr263022ljp.406.1615834391036; 
 Mon, 15 Mar 2021 11:53:11 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-52.dynamic.spd-mgts.ru.
 [109.252.193.52])
 by smtp.googlemail.com with ESMTPSA id f9sm2764475lft.242.2021.03.15.11.53.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Mar 2021 11:53:10 -0700 (PDT)
Subject: Re: [PATCH v4] iommu/tegra-smmu: Add pagetable mappings to debugfs
To: Nicolin Chen <nicoleotsuka@gmail.com>, joro@8bytes.org,
 thierry.reding@gmail.com, will@kernel.org
References: <20210315033504.23937-1-nicoleotsuka@gmail.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <c57a805a-cf14-1d78-ae2a-dfce4f643db1@gmail.com>
Date: Mon, 15 Mar 2021 21:53:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210315033504.23937-1-nicoleotsuka@gmail.com>
Content-Language: en-US
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, jonathanh@nvidia.com
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

MTUuMDMuMjAyMSAwNjozNSwgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4gVGhpcyBwYXRjaCBk
dW1wcyBhbGwgYWN0aXZlIG1hcHBpbmcgZW50cmllcyBmcm9tIHBhZ2V0YWJsZQo+IHRvIGEgZGVi
dWdmcyBkaXJlY3RvcnkgbmFtZWQgIm1hcHBpbmdzIi4KPiAKPiBBdGFjaGluZyBhbiBleGFtcGxl
OgoKQXR0YWNoaW5nCgo+IAo+IFNXR1JPVVA6IGhjCj4gQVNJRDogMAo+IHJlZzogMHgyNTAKPiBQ
VEJfQVNJRDogMHhlMDA4MDAwNAo+IGFzLT5wZF9kbWE6IDB4ODAwMDQwMDAKPiB7Cj4gICAgICAg
ICBbMTAyM10gMHhmMDA4MDAwYiAoMSkKPiAgICAgICAgIHsKPiAgICAgICAgICAgICAgICAgUFRF
IFJBTkdFICAgICAgfCBBVFRSIHwgUEhZUyAgICAgICAgICAgICAgIHwgSU9WQSAgICAgICAgICAg
ICAgIHwgU0laRQo+ICAgICAgICAgICAgICAgICBbIzEwMjMsICMxMDIzXSB8IDB4NSAgfCAweDAw
MDAwMDAxMTFhOGQwMDAgfCAweDAwMDAwMDAwZmZmZmYwMDAgfCAweDEwMDAKPiAgICAgICAgIH0K
PiB9Cj4gVG90YWwgUERFIGNvdW50OiAxCj4gVG90YWwgUFRFIGNvdW50OiAxCj4gCj4gU2lnbmVk
LW9mZi1ieTogTmljb2xpbiBDaGVuIDxuaWNvbGVvdHN1a2FAZ21haWwuY29tPgo+IC0tLQoKR29v
ZCB0byBtZSwgdGhhbmtzLgoKVGVzdGVkLWJ5OiBEbWl0cnkgT3NpcGVua28gPGRpZ2V0eEBnbWFp
bC5jb20+ClJldmlld2VkLWJ5OiBEbWl0cnkgT3NpcGVua28gPGRpZ2V0eEBnbWFpbC5jb20+Cgo+
ICsJZm9yIChwZF9pbmRleCA9IDA7IHBkX2luZGV4IDwgU01NVV9OVU1fUERFOyBwZF9pbmRleCsr
KSB7Cj4gKwkJc3RydWN0IHBhZ2UgKnB0X3BhZ2U7Cj4gKwkJdTMyICphZGRyOwo+ICsJCXVuc2ln
bmVkIGludCBpOwoKVW5pbXBvcnRhbnQgbml0OiBJJ2Qga2VlcCBsaW5lcyBhcnJhbmdlZCBieSBs
ZW5ndGggZm9yIGNvbnNpc3RlbmN5IHdpdGgKdGhlIHJlc3Qgb2YgdGhlIGNvZGUuCgouLi4KPiAr
CWdyb3VwX2RlYnVnID0gZGV2bV9rY2FsbG9jKGRldiwgc29jLT5udW1fc3dncm91cHMsIHNpemVv
ZigqZ3JvdXBfZGVidWcpLCBHRlBfS0VSTkVMKTsKCkFub3RoZXIgbml0OiB0aGlzIGlzIGEgbG9u
ZyBsaW5lLCBJJ2Qgc3BsaXQgaXQgaW50byB0d28gbGluZXMgdG8ga2VlcApjb2Rpbmcgc3R5bGUg
Y29uc2lzdGVudCBhbmQgdG8gaW1wcm92ZSByZWFkYWJpbGl0eSBmb3IgdGhvc2Ugd2hvIGhhdmUg
YQpzaWRlLWJ5LXNpZGUgY29kZSB2aWV3aW5nIHNldHVwLgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vaW9tbXU=
