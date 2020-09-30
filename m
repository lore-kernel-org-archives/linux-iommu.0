Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F78C2D0A8
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 05:59:54 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 338E6206B8
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 05:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPF8llp2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 338E6206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id F0EAB2041A;
	Wed, 30 Sep 2020 05:59:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pJrVazmxaprW; Wed, 30 Sep 2020 05:59:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 4F4C620365;
	Wed, 30 Sep 2020 05:59:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3B8B5C0889;
	Wed, 30 Sep 2020 05:59:52 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DDBD0C0051
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 05:59:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id C4C5220386
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 05:59:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UtnANZbiCZvo for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 05:59:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com
 [209.85.208.193])
 by silver.osuosl.org (Postfix) with ESMTPS id 1556D20365
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 05:59:49 +0000 (UTC)
Received: by mail-lj1-f193.google.com with SMTP id u4so519142ljd.10
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 22:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=zkMB/eTwbcDzYeUwkqLNVNuszypf0t87/4bsgTKRRuU=;
 b=RPF8llp248AgypY2MDIt38FMjCeEktMKGAvFPgRAS74txcADz9b2RB898dHJD+jyUz
 gk3BsWnBugATRj56mpDo7PoS08IV9lhQq3i4uAfkjnq/EJqlQryaXwgizazIO90GbWwZ
 dWKKhae0LLo6fuammyCIHgh6Fs2UmZzPqnpf0dddlgf8bai642B37F9Zwzbtvu/POoPA
 7WOuBvfgTH21Y+zlRvbCA1WXfXp4IPdnvO1+sO0EgtSsuRdxODBCSDa2hQrjMkg8riIb
 Y3Xv1YvM22yDN17EcvSGaffQbiIZ7/HlP0Ste0nwMip2GOTQqnm3r5CMLZPdRq5VDQov
 Xaew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zkMB/eTwbcDzYeUwkqLNVNuszypf0t87/4bsgTKRRuU=;
 b=KXsGmuJvv3F7vMSsz0QbdqOLvCqf+uPHl2jkQeObMFDiwWhwjPQBH8DwakTnJgSVZN
 rjLnwNuagMgCFZwsXKj97240dbYYasdJRSIqEGLvXJ50m2T61gHr+RIWgYPdvfM8nIsv
 41n0Yq1pJ63lJTJE+ovwfSFxRAvuL3aJ2j23zHwzLLhfJPrbPT5fH8L9N9Y1Privxzc1
 hokIFSqvF9IKchCH50Q1LplZZqktV1T1PC9V1QIvPiXxplZHigEJkmfYS2bBlnUyOsJ2
 ZAN6tbAY5O57DCo2GeYxmP4/ObY/ikBe+f+lch3C2xyNZwdVkMS/5MzcjtRj8HvZZ3DB
 azEA==
X-Gm-Message-State: AOAM531+UKYbIpOp5r0gLFFU6R7S++GTp7Y6jZx0QjpjL45kSKvgAjgh
 vo/LsDqHoLJonIsfVPKN6RA=
X-Google-Smtp-Source: ABdhPJxF1455iHEGS/+ljUe+sSI1+drgugHd5KUrICCLN/cqPa5Q80B/1k8DFj9gwt2F7Fj6kfnq3A==
X-Received: by 2002:a2e:8782:: with SMTP id n2mr397178lji.262.1601445586969;
 Tue, 29 Sep 2020 22:59:46 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru.
 [109.252.170.211])
 by smtp.googlemail.com with ESMTPSA id x5sm67196lfd.119.2020.09.29.22.59.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2020 22:59:46 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] iommu/tegra-smmu: Rework .probe_device and
 .attach_dev
To: Nicolin Chen <nicoleotsuka@gmail.com>
References: <20200930003013.31289-1-nicoleotsuka@gmail.com>
 <20200930003013.31289-3-nicoleotsuka@gmail.com>
 <e557a09b-bcc3-11cb-9529-096aafb42051@gmail.com>
 <20200930054119.GE31821@Asurada-Nvidia>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <68c13611-bc3d-5ba6-70ec-29786d69ff9a@gmail.com>
Date: Wed, 30 Sep 2020 08:59:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930054119.GE31821@Asurada-Nvidia>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 krzk@kernel.org, jonathanh@nvidia.com, thierry.reding@gmail.com,
 linux-tegra@vger.kernel.org
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

MzAuMDkuMjAyMCAwODo0MSwgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4gT24gV2VkLCBTZXAg
MzAsIDIwMjAgYXQgMDg6Mzk6NTRBTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+PiAz
MC4wOS4yMDIwIDAzOjMwLCBOaWNvbGluIENoZW4g0L/QuNGI0LXRgjoKPj4+ICBzdGF0aWMgaW50
IHRlZ3JhX3NtbXVfYXR0YWNoX2RldihzdHJ1Y3QgaW9tbXVfZG9tYWluICpkb21haW4sCj4+PiAg
CQkJCSBzdHJ1Y3QgZGV2aWNlICpkZXYpCj4+PiAgewo+Pj4gKwlzdHJ1Y3QgaW9tbXVfZndzcGVj
ICpmd3NwZWMgPSBkZXZfaW9tbXVfZndzcGVjX2dldChkZXYpOwo+Pj4gIAlzdHJ1Y3QgdGVncmFf
c21tdSAqc21tdSA9IGRldl9pb21tdV9wcml2X2dldChkZXYpOwo+Pj4gIAlzdHJ1Y3QgdGVncmFf
c21tdV9hcyAqYXMgPSB0b19zbW11X2FzKGRvbWFpbik7Cj4+PiAtCXN0cnVjdCBkZXZpY2Vfbm9k
ZSAqbnAgPSBkZXYtPm9mX25vZGU7Cj4+PiAtCXN0cnVjdCBvZl9waGFuZGxlX2FyZ3MgYXJnczsK
Pj4+ICAJdW5zaWduZWQgaW50IGluZGV4ID0gMDsKPj4+ICAJaW50IGVyciA9IDA7Cj4+PiAgCj4+
PiAtCXdoaWxlICghb2ZfcGFyc2VfcGhhbmRsZV93aXRoX2FyZ3MobnAsICJpb21tdXMiLCAiI2lv
bW11LWNlbGxzIiwgaW5kZXgsCj4+PiAtCQkJCQkgICAmYXJncykpIHsKPj4+IC0JCXVuc2lnbmVk
IGludCBzd2dyb3VwID0gYXJncy5hcmdzWzBdOwo+Pj4gLQo+Pj4gLQkJaWYgKGFyZ3MubnAgIT0g
c21tdS0+ZGV2LT5vZl9ub2RlKSB7Cj4+PiAtCQkJb2Zfbm9kZV9wdXQoYXJncy5ucCk7Cj4+PiAt
CQkJY29udGludWU7Cj4+PiAtCQl9Cj4+PiAtCj4+PiAtCQlvZl9ub2RlX3B1dChhcmdzLm5wKTsK
Pj4+ICsJaWYgKCFmd3NwZWMgfHwgZndzcGVjLT5vcHMgIT0gJnRlZ3JhX3NtbXVfb3BzKQo+Pj4g
KwkJcmV0dXJuIC1FTk9FTlQ7Cj4+Cj4+IHMvJnRlZ3JhX3NtbXVfb3BzL3NtbXUtPmlvbW11Lm9w
cy8KPj4KPj4gU2Vjb25kbHksIGlzIGl0IGV2ZW4gcG9zc2libGUgdGhhdCBmd3NwZWMgY291bGQg
YmUgTlVMTCBoZXJlIG9yIHRoYXQKPj4gZndzcGVjLT5vcHMgIT0gc21tdS0+b3BzPwo+IAo+IEkg
YW0gZm9sbG93aW5nIHdoYXQncyBpbiB0aGUgYXJtLXNtbXUgZHJpdmVyLCBhcyBJIHRoaW5rIGl0
J2QgYmUKPiBhIGNvbW1vbiBwcmFjdGljZSB0byBkbyBzdWNoIGEgY2hlY2sgaW4gc3VjaCBhIHdh
eS4KPiAKClBsZWFzZSBjaGVjayB3aGV0aGVyIGl0J3MgcmVhbGx5IG5lZWRlZC4gSXQgbG9va3Mg
bGlrZSBpdCB3YXMgbmVlZGVkCnNvbWV0aW1lIGFnbywgYnV0IHRoYXQncyBub3QgdHJ1ZSBhbnlt
b3JlLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21t
dSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
