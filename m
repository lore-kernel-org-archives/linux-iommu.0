Return-Path: <SRS0=jhW9=O6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4129C433EF
	for <iommu@archiver.kernel.org>; Sun, 10 Oct 2021 04:34:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 726FB60F57
	for <iommu@archiver.kernel.org>; Sun, 10 Oct 2021 04:34:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 726FB60F57
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kali.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3620080EDE;
	Sun, 10 Oct 2021 04:34:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KvEu48Ed7NL6; Sun, 10 Oct 2021 04:34:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1A3CC80EC5;
	Sun, 10 Oct 2021 04:34:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F30D7C0011;
	Sun, 10 Oct 2021 04:34:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 77E74C000D
 for <iommu@lists.linux-foundation.org>; Sun, 10 Oct 2021 04:34:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6762080EC5
 for <iommu@lists.linux-foundation.org>; Sun, 10 Oct 2021 04:34:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HR4uNn0xgiA4 for <iommu@lists.linux-foundation.org>;
 Sun, 10 Oct 2021 04:34:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4C43E80E8E
 for <iommu@lists.linux-foundation.org>; Sun, 10 Oct 2021 04:34:13 +0000 (UTC)
Received: by mail-oo1-xc2f.google.com with SMTP id
 s4-20020a4aad44000000b002b6aa5b6999so2656131oon.2
 for <iommu@lists.linux-foundation.org>; Sat, 09 Oct 2021 21:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kali.org; s=google;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=oS3/7Iu8XaPwbDFyRTMleM8YCizK9D6llJsSxGhaoZk=;
 b=SEDuDwvxsH2QVF7SHxwlWidbjjslBC9HcB3wX9ErK+x+/nEFa2IyjzOhtAu1kLxXet
 buQvB5yR3jH4Q+FPja2FK8Vux56XYLiMAQyXzqeUjb0PKQmCpimI+LPw4KDEmycjRKop
 lkK/5Zv3g7COM7QSep84giDmz4EviwuZcExXjSdXPK9xDCT4LzulXS3XavDIAhklXGDG
 +BGXHHzpl2hNhnxOnyHV/0Tk95v4FJ/K1PBY0/ClBvjBMhYJp3yiqvrMXjQMX8k+RVvO
 z6InxZihbD8YYZ+EoHjwvjh4Y/J+n61Veqk129gbKC6lCs5BRQa9QSInnB4HWyjyY2Bg
 RGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=oS3/7Iu8XaPwbDFyRTMleM8YCizK9D6llJsSxGhaoZk=;
 b=XbmpL8Hv2tbJSpIzbke5DeEGd+Bta6ItWDh6Pqw9V3brAtLZfadlBSoaBzkfds3DKY
 QuNiFkTizo+2MobCzIqqCfNuZWm145JRlQJrPKlIADHBk9J8+TSgTN1rMaaWA9Gv8npq
 Omk8omciIs+aR6r54kreUrACgHncfJy09CyKzy+3DVcT6EmODN59muqLXAfR2xVFMgs7
 bJlXL3d2BylAECcKgE8Sw3dIojdUTMrONAQreM16uy8g1uGstE/uWBkpS8iJ6QVxuFks
 sQdSOwTv8SEfF2LKT5XuXI5TWJuT1y5MZtQ8grI8ffdAIVchzQDhO4TAhhsY/WMboq1D
 7G4A==
X-Gm-Message-State: AOAM530LmI6T6SD5ro9Y3H/CdYxKpEdVpXz1xE5F4hYR+KR/jJZrKyXV
 QhNOiXPfLIJsKwIixPSZX2wD6w==
X-Google-Smtp-Source: ABdhPJzrwmeoXn6Y5xr6p12gTvhnt86mUjAglqoTyIVyPu75x5wt5v/wozGrKV4qeXn1YjW2BaTrBw==
X-Received: by 2002:a4a:b64b:: with SMTP id f11mr14083092ooo.18.1633840452285; 
 Sat, 09 Oct 2021 21:34:12 -0700 (PDT)
Received: from [192.168.11.48] (cpe-173-173-107-246.satx.res.rr.com.
 [173.173.107.246])
 by smtp.gmail.com with ESMTPSA id n7sm899946oij.46.2021.10.09.21.34.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Oct 2021 21:34:11 -0700 (PDT)
Message-ID: <defac383-4a87-9a1c-86f1-4dde49dd9d2f@kali.org>
Date: Sat, 9 Oct 2021 23:34:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.2
Subject: Re: [PATCH] iommu: fix ARM_SMMU vs QCOM_SCM compilation
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kalle Valo <kvalo@codeaurora.org>,
 Arnd Bergmann <arnd@arndb.de>, Thierry Reding <treding@nvidia.com>
References: <20211010023350.978638-1-dmitry.baryshkov@linaro.org>
From: Steev Klimaszewski <steev@kali.org>
In-Reply-To: <20211010023350.978638-1-dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Andy Gross <agross@kernel.org>, linux-arm-kernel@lists.infradead.org
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

Ck9uIDEwLzkvMjEgOTozMyBQTSwgRG1pdHJ5IEJhcnlzaGtvdiB3cm90ZToKPiBBZnRlciBjb21t
aXQgNDI0OTUzY2YzYzY2ICgicWNvbV9zY206IGhpZGUgS2NvbmZpZyBzeW1ib2wiKSBhcm0tc21t
dSBnb3QKPiBxY29tX3NtbXVfaW1wbF9pbml0KCkgY2FsbCBndWFyZGVkIGJ5IElTX0VOQUJMRUQo
Q09ORklHX0FSTV9TTU1VX1FDT00pLgo+IEhvd2V2ZXIgdGhlIENPTkZJR19BUk1fU01NVV9RQ09N
IEtjb25maWcgZW50cnkgZG9lcyBub3QgZXhpc3QsIHNvIHRoZQo+IHFjb21fc21tdV9pbXBsX2lu
aXQoKSBpcyBuZXZlciBjYWxsZWQuCj4KPiBTbywgbGV0J3MgZml4IHRoaXMgYnkgYWx3YXlzIGNh
bGxpbmcgcWNvbV9zbW11X2ltcGxfaW5pdCgpLiBJdCBkb2VzIG5vdAo+IHRvdWNoIHRoZSBzbW11
IHBhc3NlZCB1bmxlc3MgdGhlIGRldmljZSBpcyBhIG5vbi1RdWFsY29tbSBvbmUuIE1ha2UKPiBB
Uk1fU01NVSBzZWxlY3QgUUNPTV9TQ00gZm9yIEFSQ0hfUUNPTS4KPgo+IEZpeGVzOiA0MjQ5NTNj
ZjNjNjYgKCJxY29tX3NjbTogaGlkZSBLY29uZmlnIHN5bWJvbCIpCj4gQ2M6IEFybmQgQmVyZ21h
bm4gPGFybmRAYXJuZGIuZGU+Cj4gUmVwb3J0ZWQtYnk6IERhbmllbCBMZXpjYW5vIDxkYW5pZWwu
bGV6Y2Fub0BsaW5hcm8ub3JnPgo+IFNpZ25lZC1vZmYtYnk6IERtaXRyeSBCYXJ5c2hrb3YgPGRt
aXRyeS5iYXJ5c2hrb3ZAbGluYXJvLm9yZz4KPiAtLS0KPiAgIGRyaXZlcnMvaW9tbXUvS2NvbmZp
ZyAgICAgICAgICAgICAgICAgICAgICB8IDEgKwo+ICAgZHJpdmVycy9pb21tdS9hcm0vYXJtLXNt
bXUvTWFrZWZpbGUgICAgICAgIHwgMyArLS0KPiAgIGRyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11
L2FybS1zbW11LWltcGwuYyB8IDkgKysrKysrKy0tCj4gICAzIGZpbGVzIGNoYW5nZWQsIDkgaW5z
ZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11
L0tjb25maWcgYi9kcml2ZXJzL2lvbW11L0tjb25maWcKPiBpbmRleCBjNWM3MWI3YWI3ZTguLmE0
NTkzZTUzZmU3ZCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2lvbW11L0tjb25maWcKPiArKysgYi9k
cml2ZXJzL2lvbW11L0tjb25maWcKPiBAQCAtMzA5LDYgKzMwOSw3IEBAIGNvbmZpZyBBUk1fU01N
VQo+ICAgCXRyaXN0YXRlICJBUk0gTHRkLiBTeXN0ZW0gTU1VIChTTU1VKSBTdXBwb3J0Igo+ICAg
CWRlcGVuZHMgb24gQVJNNjQgfHwgQVJNIHx8IChDT01QSUxFX1RFU1QgJiYgIUdFTkVSSUNfQVRP
TUlDNjQpCj4gICAJc2VsZWN0IElPTU1VX0FQSQo+ICsJc2VsZWN0IFFDT01fU0NNCj4gICAJc2Vs
ZWN0IElPTU1VX0lPX1BHVEFCTEVfTFBBRQo+ICAgCXNlbGVjdCBBUk1fRE1BX1VTRV9JT01NVSBp
ZiBBUk0KPiAgIAloZWxwCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11
L01ha2VmaWxlIGIvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUvTWFrZWZpbGUKPiBpbmRleCBi
MGNjMDFhYTIwYzkuLmUyNDBhN2JjZjMxMCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2lvbW11L2Fy
bS9hcm0tc21tdS9NYWtlZmlsZQo+ICsrKyBiL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11L01h
a2VmaWxlCj4gQEAgLTEsNSArMSw0IEBACj4gICAjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBH
UEwtMi4wCj4gICBvYmotJChDT05GSUdfUUNPTV9JT01NVSkgKz0gcWNvbV9pb21tdS5vCj4gICBv
YmotJChDT05GSUdfQVJNX1NNTVUpICs9IGFybV9zbW11Lm8KPiAtYXJtX3NtbXUtb2JqcyArPSBh
cm0tc21tdS5vIGFybS1zbW11LWltcGwubyBhcm0tc21tdS1udmlkaWEubwo+IC1hcm1fc21tdS0k
KENPTkZJR19BUk1fU01NVV9RQ09NKSArPSBhcm0tc21tdS1xY29tLm8KPiArYXJtX3NtbXUtb2Jq
cyArPSBhcm0tc21tdS5vIGFybS1zbW11LWltcGwubyBhcm0tc21tdS1udmlkaWEubyBhcm0tc21t
dS1xY29tLm8KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUvYXJtLXNt
bXUtaW1wbC5jIGIvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUvYXJtLXNtbXUtaW1wbC5jCj4g
aW5kZXggMmMyNWNjZTM4MDYwLi44MTk5MTg1ZGQyNjIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9p
b21tdS9hcm0vYXJtLXNtbXUvYXJtLXNtbXUtaW1wbC5jCj4gKysrIGIvZHJpdmVycy9pb21tdS9h
cm0vYXJtLXNtbXUvYXJtLXNtbXUtaW1wbC5jCj4gQEAgLTIxNSw4ICsyMTUsMTMgQEAgc3RydWN0
IGFybV9zbW11X2RldmljZSAqYXJtX3NtbXVfaW1wbF9pbml0KHN0cnVjdCBhcm1fc21tdV9kZXZp
Y2UgKnNtbXUpCj4gICAJICAgIG9mX2RldmljZV9pc19jb21wYXRpYmxlKG5wLCAibnZpZGlhLHRl
Z3JhMTg2LXNtbXUiKSkKPiAgIAkJcmV0dXJuIG52aWRpYV9zbW11X2ltcGxfaW5pdChzbW11KTsK
PiAgIAo+IC0JaWYgKElTX0VOQUJMRUQoQ09ORklHX0FSTV9TTU1VX1FDT00pKQo+IC0JCXNtbXUg
PSBxY29tX3NtbXVfaW1wbF9pbml0KHNtbXUpOwo+ICsJLyoKPiArCSAqIHFjb21fc21tdV9pbXBs
X2luaXQoKSB3aWxsIG5vdCB0b3VjaCBzbW11IGlmIHRoZSBkZXZpY2UgaXMgbm90Cj4gKwkgKiBh
IFF1YWxjb21tIG9uZS4KPiArCSAqLwo+ICsJc21tdSA9IHFjb21fc21tdV9pbXBsX2luaXQoc21t
dSk7Cj4gKwlpZiAoSVNfRVJSKHNtbXUpKQo+ICsJCXJldHVybiBzbW11Owo+ICAgCj4gICAJaWYg
KG9mX2RldmljZV9pc19jb21wYXRpYmxlKG5wLCAibWFydmVsbCxhcDgwNi1zbW11LTUwMCIpKQo+
ICAgCQlzbW11LT5pbXBsID0gJm1ydmxfbW11NTAwX2ltcGw7CgpXaXRob3V0IHRoaXMgYXBwbGll
ZCwgbXkgTGVub3ZvIFlvZ2EgQzYzMCBqdXN0IGJvb3QgbG9vcHMgd2l0aCAKNDI0OTUzY2YzYzY2
IGFwcGxpZWQgd2hlbiBpdCBnZXRzIHRvIHRoZSBzbW11LsKgIFRoaXMgZml4ZXMgaXQuCgpUZXN0
ZWQtQnk6IFN0ZWV2IEtsaW1hc3pld3NraSA8c3RlZXZAa2FsaS5vcmc+CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9t
bXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
