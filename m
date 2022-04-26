Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 532D9C433F5
	for <iommu@archiver.kernel.org>; Tue, 26 Apr 2022 13:53:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EF6D760EA9;
	Tue, 26 Apr 2022 13:52:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id evx0LZRxZT_D; Tue, 26 Apr 2022 13:52:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C4A4160F9B;
	Tue, 26 Apr 2022 13:52:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98B06C0039;
	Tue, 26 Apr 2022 13:52:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E81B7C002D
 for <iommu@lists.linux-foundation.org>; Tue, 26 Apr 2022 13:52:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CD54260F9B
 for <iommu@lists.linux-foundation.org>; Tue, 26 Apr 2022 13:52:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z0uNCz7G-Xe7 for <iommu@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 13:52:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 07B5F60EA9
 for <iommu@lists.linux-foundation.org>; Tue, 26 Apr 2022 13:52:55 +0000 (UTC)
Received: by mail-pj1-x102c.google.com with SMTP id
 bd19-20020a17090b0b9300b001d98af6dcd1so2240640pjb.4
 for <iommu@lists.linux-foundation.org>; Tue, 26 Apr 2022 06:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=uqaZpBljzoZzdXCykxWiGP7rAFt7o+OxvSikZ6TWlp0=;
 b=QRo5+aMEceoawAqu5WfjfVrACZsEACmr6ImwChCeF1PdQM5x0ZECcVseK61UOnqXWi
 g1QsxgK7znpLpJTi8lwzXUymH2PE1nSBpzwBlHQ4hEqbsjlSg6iBktMzvTHb61HSQ1Ex
 yEHdDYxykdw6FSe97RB1xgKrnfOOtitH0zRwjRuOyzWUksq07ABg2KVNaiEeHBDxhRhV
 SzSXm9X6Wb2A6Bm68Q+RQivNFo0TuqMYKoXgURwGx7KUgY1iobt2+mEvpbZaqywAxUQ3
 hmqx4596HDYiVxCsYkOq/fzw3cxc6kjXYwy/0rOlP2Mc9tjYctjupGjX718vWlM6AwZt
 fT7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=uqaZpBljzoZzdXCykxWiGP7rAFt7o+OxvSikZ6TWlp0=;
 b=0omTlR/Ep28lcobYHSwwB7ay39tbnKHUj8PNt+Kgf0qORZ+2lh1v+VQdKsmHa5igyb
 LVXgSceV76w4RVVj4ZhuwIJqilxoXj7rTiNPa237smJ8CcSgrnCiCoGQ3dAs98PcvxCN
 n3wxv22NRoiYRI4irl607MJ1I6/Ceu6f7lWOhKfFdgIxY2E4mDDRMRVsaP4N/lhObbVK
 JPpjyj5K4BaSn1JgqCrlV26hMwGLbJXtv1uPOd/U3MfGSKspvHeHlFPuXo/vfgB34aNH
 EiyNiBgoAP6tS+1rOwf9xw/HweG/GWxB+/czkhqGu0gketMbvfwZp6PGe8bKqlT10uzH
 JDtg==
X-Gm-Message-State: AOAM531AGHOKh2Ofn3asebsf/eG3fr2PQag4XXCvdLOEqCoAThK26Tpn
 n/Iji3rJAreeoPmO8l+pdZCH2vyOwIJykwrWhF8=
X-Google-Smtp-Source: ABdhPJxFVynlZ1NgQmJwexRkstCJnMMkaENUYHM695DHlT54hcr0HlyNDYSqjN8iGZCoSFpySdsXXg==
X-Received: by 2002:a17:902:eb91:b0:15d:1f88:d993 with SMTP id
 q17-20020a170902eb9100b0015d1f88d993mr7965305plg.17.1650981175127; 
 Tue, 26 Apr 2022 06:52:55 -0700 (PDT)
Received: from [10.28.0.90] ([94.177.118.117])
 by smtp.gmail.com with ESMTPSA id
 p1-20020a056a000a0100b0050ac9c31b7esm16840391pfh.180.2022.04.26.06.52.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Apr 2022 06:52:54 -0700 (PDT)
Subject: Re: [PATCH v2] iommu/arm-smmu-v3-sva: Fix mm use-after-free
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, will@kernel.org,
 robin.murphy@arm.com, joro@8bytes.org
References: <20220426130444.300556-1-jean-philippe@linaro.org>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <198ae560-dbea-2c92-ec27-ca26b36b250e@linaro.org>
Date: Tue, 26 Apr 2022 21:52:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220426130444.300556-1-jean-philippe@linaro.org>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org
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

CgpPbiAyMDIyLzQvMjYg5LiL5Y2IOTowNCwgSmVhbi1QaGlsaXBwZSBCcnVja2VyIHdyb3RlOgo+
IFdlIGN1cnJlbnRseSBjYWxsIGFybTY0X21tX2NvbnRleHRfcHV0KCkgd2l0aG91dCBob2xkaW5n
IGEgcmVmZXJlbmNlIHRvCj4gdGhlIG1tLCB3aGljaCBjYW4gcmVzdWx0IGluIHVzZS1hZnRlci1m
cmVlLiBDYWxsIG1tZ3JhYigpL21tZHJvcCgpIHRvCj4gZW5zdXJlIHRoZSBtbSBvbmx5IGdldHMg
ZnJlZWQgYWZ0ZXIgd2UgdW5waW5uZWQgdGhlIEFTSUQuCj4KPiBGaXhlczogMzI3ODRhOTU2MmZi
ICgiaW9tbXUvYXJtLXNtbXUtdjM6IEltcGxlbWVudCBpb21tdV9zdmFfYmluZC91bmJpbmQoKSIp
Cj4gU2lnbmVkLW9mZi1ieTogSmVhbi1QaGlsaXBwZSBCcnVja2VyIDxqZWFuLXBoaWxpcHBlQGxp
bmFyby5vcmc+CgpUaGFua3MgSmVhbgoKVGVzdGVkLWJ5OiBaaGFuZ2ZlaSBHYW8gPHpoYW5nZmVp
Lmdhb0BsaW5hcm8ub3JnPgoKCj4gLS0tCj4gdjI6IEFkZCBtaXNzaW5nIGluY2x1ZGUKPiAtLS0K
PiAgIGRyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLXN2YS5jIHwgMTMg
KysrKysrKysrKystLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUtdjMv
YXJtLXNtbXUtdjMtc3ZhLmMgYi9kcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0tc21t
dS12My1zdmEuYwo+IGluZGV4IDIyZGRkMDViYmRjZC4uNWQwMjllODdjOGFmIDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLXN2YS5jCj4gKysr
IGIvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMtc3ZhLmMKPiBAQCAt
Niw2ICs2LDcgQEAKPiAgICNpbmNsdWRlIDxsaW51eC9tbS5oPgo+ICAgI2luY2x1ZGUgPGxpbnV4
L21tdV9jb250ZXh0Lmg+Cj4gICAjaW5jbHVkZSA8bGludXgvbW11X25vdGlmaWVyLmg+Cj4gKyNp
bmNsdWRlIDxsaW51eC9zY2hlZC9tbS5oPgo+ICAgI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4KPiAg
IAo+ICAgI2luY2x1ZGUgImFybS1zbW11LXYzLmgiCj4gQEAgLTk2LDkgKzk3LDE0IEBAIHN0YXRp
YyBzdHJ1Y3QgYXJtX3NtbXVfY3R4X2Rlc2MgKmFybV9zbW11X2FsbG9jX3NoYXJlZF9jZChzdHJ1
Y3QgbW1fc3RydWN0ICptbSkKPiAgIAlzdHJ1Y3QgYXJtX3NtbXVfY3R4X2Rlc2MgKmNkOwo+ICAg
CXN0cnVjdCBhcm1fc21tdV9jdHhfZGVzYyAqcmV0ID0gTlVMTDsKPiAgIAo+ICsJLyogRG9uJ3Qg
ZnJlZSB0aGUgbW0gdW50aWwgd2UgcmVsZWFzZSB0aGUgQVNJRCAqLwo+ICsJbW1ncmFiKG1tKTsK
PiArCj4gICAJYXNpZCA9IGFybTY0X21tX2NvbnRleHRfZ2V0KG1tKTsKPiAtCWlmICghYXNpZCkK
PiAtCQlyZXR1cm4gRVJSX1BUUigtRVNSQ0gpOwo+ICsJaWYgKCFhc2lkKSB7Cj4gKwkJZXJyID0g
LUVTUkNIOwo+ICsJCWdvdG8gb3V0X2Ryb3BfbW07Cj4gKwl9Cj4gICAKPiAgIAljZCA9IGt6YWxs
b2Moc2l6ZW9mKCpjZCksIEdGUF9LRVJORUwpOwo+ICAgCWlmICghY2QpIHsKPiBAQCAtMTY1LDYg
KzE3MSw4IEBAIHN0YXRpYyBzdHJ1Y3QgYXJtX3NtbXVfY3R4X2Rlc2MgKmFybV9zbW11X2FsbG9j
X3NoYXJlZF9jZChzdHJ1Y3QgbW1fc3RydWN0ICptbSkKPiAgIAlrZnJlZShjZCk7Cj4gICBvdXRf
cHV0X2NvbnRleHQ6Cj4gICAJYXJtNjRfbW1fY29udGV4dF9wdXQobW0pOwo+ICtvdXRfZHJvcF9t
bToKPiArCW1tZHJvcChtbSk7Cj4gICAJcmV0dXJuIGVyciA8IDAgPyBFUlJfUFRSKGVycikgOiBy
ZXQ7Cj4gICB9Cj4gICAKPiBAQCAtMTczLDYgKzE4MSw3IEBAIHN0YXRpYyB2b2lkIGFybV9zbW11
X2ZyZWVfc2hhcmVkX2NkKHN0cnVjdCBhcm1fc21tdV9jdHhfZGVzYyAqY2QpCj4gICAJaWYgKGFy
bV9zbW11X2ZyZWVfYXNpZChjZCkpIHsKPiAgIAkJLyogVW5waW4gQVNJRCAqLwo+ICAgCQlhcm02
NF9tbV9jb250ZXh0X3B1dChjZC0+bW0pOwo+ICsJCW1tZHJvcChjZC0+bW0pOwo+ICAgCQlrZnJl
ZShjZCk7Cj4gICAJfQo+ICAgfQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2lvbW11
