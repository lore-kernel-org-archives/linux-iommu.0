Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D781EC433F5
	for <iommu@archiver.kernel.org>; Tue, 26 Apr 2022 12:45:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6FB7440001;
	Tue, 26 Apr 2022 12:45:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Pfa1DsqBIVsP; Tue, 26 Apr 2022 12:45:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0D965401D6;
	Tue, 26 Apr 2022 12:45:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D5FBCC0032;
	Tue, 26 Apr 2022 12:45:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0ED3EC002D
 for <iommu@lists.linux-foundation.org>; Tue, 26 Apr 2022 12:45:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F0A16409BC
 for <iommu@lists.linux-foundation.org>; Tue, 26 Apr 2022 12:45:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2vrZwMGzN7r8 for <iommu@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 12:45:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2868340497
 for <iommu@lists.linux-foundation.org>; Tue, 26 Apr 2022 12:45:31 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id j15so12058325wrb.2
 for <iommu@lists.linux-foundation.org>; Tue, 26 Apr 2022 05:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=6XY1CFv7zi9fHmVGgjW26+q05OYavHaCPW2wRnSaJ2I=;
 b=FeoyY3u0FL1qd49GgjAmM5/jcUqG4P+8F2HyeTurvsgGALutvo2ZMAYQHOw3YVgbut
 5+O50+4KT27EM3c1rSh2eJGoeqSru7r8dfFy8cArJUI1ZBnUnqC2cSUw/h8c5VEfkT78
 MBJJUNc1HBNMD3yI1njHoBaP33I4Y3bQFOs3L8hw4Jd7f+X/fZh51Gd0MOc/puxOLZWE
 GQb9tEZxDGf73ieI8R6oO5CyDvVmO4FqMNT/N/BPY50AVQhmOMQZETOOh9H9E0a7OhmB
 a6aldBgiY9fhD0IkUnQ+T3SDp+oCGAzv6ES+O8sMxR+uzgTNUPtSmo4++HfsdkmUMusN
 nTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=6XY1CFv7zi9fHmVGgjW26+q05OYavHaCPW2wRnSaJ2I=;
 b=Z/9hOy2tVcIlclzrcKsozeYF1wtXyNriaLIm8ptpoR/X5dmXm9nnFyYcd0s6ilaaCH
 hfPcAAqA8NlcyM0luPGQGJFXP+8rnxsJu6+XjrFltef2UnxAgOVZ1B/AEm/4qUZ4y8wB
 5JGtYwH5bDCmT+CTCrwy4pmH8eXx1DKhP4cj44lb73xsDjn8WZXdrhuakCjpvnUnypHJ
 P95KifcqL0LoO29ubT3gxQUrI9SdjPXdJ3/YVFrxEgiGSY9O8va2ukU+YZiX3IRAzJWt
 pYZl6j3J/spGWVdGLgPvPdgMgsYSuTVWOm/oAJM9NKIQIgs5CdPSfLPXrVSJiOttIWiU
 evPQ==
X-Gm-Message-State: AOAM533IZTWB/NgM9QGIlPk6zzgpTeb6SqSnBuiRem+wTTZpobL3duh8
 oo/n7OCPjtdp+1xpf7AnqkSrSQ==
X-Google-Smtp-Source: ABdhPJzG6i/42TyPZyO5FFw2WSwxFFUkQoDXY/Qzigr4xMI28TlASyB4xqvott94KozO5h5Gp+lK8A==
X-Received: by 2002:a5d:6752:0:b0:20a:ce1f:2ceb with SMTP id
 l18-20020a5d6752000000b0020ace1f2cebmr15298075wrw.715.1650977129409; 
 Tue, 26 Apr 2022 05:45:29 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168]) by smtp.gmail.com with ESMTPSA id
 n10-20020a5d588a000000b002052e4aaf89sm11651128wrf.80.2022.04.26.05.45.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Apr 2022 05:45:28 -0700 (PDT)
Date: Tue, 26 Apr 2022 13:45:03 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3-sva: Fix mm use-after-free
Message-ID: <YmfpTzghyITtIK3y@myrica>
References: <20220426100400.147482-1-jean-philippe@linaro.org>
 <tencent_FAED72B58E26A4B4D706CE8EF4C1B408ED07@qq.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <tencent_FAED72B58E26A4B4D706CE8EF4C1B408ED07@qq.com>
Cc: robin.murphy@arm.com, will@kernel.org, iommu@lists.linux-foundation.org,
 zhangfei.gao@linaro.org
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

T24gVHVlLCBBcHIgMjYsIDIwMjIgYXQgMDg6MjA6NTJQTSArMDgwMCwgemhhbmdmZWkuZ2FvQGZv
eG1haWwuY29tIHdyb3RlOgo+IEhpLCBKZWFuCj4gCj4gT24gMjAyMi80LzI2IOS4i+WNiDY6MDQs
IEplYW4tUGhpbGlwcGUgQnJ1Y2tlciB3cm90ZToKPiA+IFdlIGN1cnJlbnRseSBjYWxsIGFybTY0
X21tX2NvbnRleHRfcHV0KCkgd2l0aG91dCBob2xkaW5nIGEgcmVmZXJlbmNlIHRvCj4gPiB0aGUg
bW0sIHdoaWNoIGNhbiByZXN1bHQgaW4gdXNlLWFmdGVyLWZyZWUuIENhbGwgbW1ncmFiKCkvbW1k
cm9wKCkgdG8KPiA+IGVuc3VyZSB0aGUgbW0gb25seSBnZXRzIGZyZWVkIGFmdGVyIHdlIHVucGlu
bmVkIHRoZSBBU0lELgo+ID4gCj4gPiBGaXhlczogMzI3ODRhOTU2MmZiICgiaW9tbXUvYXJtLXNt
bXUtdjM6IEltcGxlbWVudCBpb21tdV9zdmFfYmluZC91bmJpbmQoKSIpCj4gPiBTaWduZWQtb2Zm
LWJ5OiBKZWFuLVBoaWxpcHBlIEJydWNrZXIgPGplYW4tcGhpbGlwcGVAbGluYXJvLm9yZz4KPiA+
IC0tLQo+ID4gICBkcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My1zdmEu
YyB8IDEyICsrKysrKysrKystLQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkKPiBNaXNzaW5nICsjaW5jbHVkZSA8bGludXgvc2NoZWQvbW0uaD4g
Zm9yIGNvbXBpbGUuCgpBaCB0aGFua3MsIEkgc2VudCB0aGUgd3JvbmcgdmVyc2lvbi4KCj4gV2Ug
c3RpbGwgbmVlZCB0aGUgZml4IG1vdmUgbW1fcGFzaWRfZHJvcCBmcm9tIF9fbW1wdXQgdG8gX19t
bWRyb3AsIHJpZ2h0PwoKWWVzLCB0aGF0J3MgRmVuZ2h1YSdzIHBhdGNoCgpUaGFua3MsCkplYW4K
Cj4gCj4gMS4gVGVzdCBPSyB3aXRoIHRoZSBtbV9wYXNpZF9kcm9wIHBhdGNoLgo+IAo+IDIuIFRl
c3QgZmFpbCBpZiByZXZlcnQgdGhlIG1tX3Bhc2lkX2Ryb3AgcGF0Y2gsCj4gdWFjY2VfZm9wc19y
ZWxlYXNlCj4gVW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgcGFnaW5nIHJlcXVlc3QgYXQgdmlydHVh
bCBhZGRyZXNzIGZmZmYwMDA4M2NjNmZmYzAKPiAKPiBCeSB0aGUgd2F5LCB3ZSB1c2UgbW1ncmFi
IGluIGJpbmQgYW5kIG1tcHV0IGluIHVuYmluZCBiZWZvcmUsCj4gdGhlbiB0aGUgZm9wc19yZWxl
YXNlIGlzIG5vdCBiZSBjYWxsZWQgaWYgZXhpdCB3aXRob3V0IGNsb3NlKGZkKS4KPiAKPiBUaGlz
IHBhdGNoIGRvZXMgbm90IGhhdmUgdGhpcyBpc3N1ZSwgc3RpbGwgbm90IHVuZGVyc3RhbmQgd2h5
Lgo+IAo+IFRoYW5rcwo+IAo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1z
bW11LXYzL2FybS1zbW11LXYzLXN2YS5jIGIvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUtdjMv
YXJtLXNtbXUtdjMtc3ZhLmMKPiA+IGluZGV4IDU4MjExNGY5NGRhMC4uYzkzNDc3YTJkN2YxIDEw
MDY0NAo+ID4gLS0tIGEvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMt
c3ZhLmMKPiA+ICsrKyBiL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYz
LXN2YS5jCj4gPiBAQCAtOTgsOSArOTgsMTQgQEAgc3RhdGljIHN0cnVjdCBhcm1fc21tdV9jdHhf
ZGVzYyAqYXJtX3NtbXVfYWxsb2Nfc2hhcmVkX2NkKHN0cnVjdCBtbV9zdHJ1Y3QgKm1tKQo+ID4g
ICAJc3RydWN0IGFybV9zbW11X2N0eF9kZXNjICpjZDsKPiA+ICAgCXN0cnVjdCBhcm1fc21tdV9j
dHhfZGVzYyAqcmV0ID0gTlVMTDsKPiA+ICsJLyogRG9uJ3QgZnJlZSB0aGUgbW0gdW50aWwgd2Ug
cmVsZWFzZSB0aGUgQVNJRCAqLwo+ID4gKwltbWdyYWIobW0pOwo+ID4gKwo+ID4gICAJYXNpZCA9
IGFybTY0X21tX2NvbnRleHRfZ2V0KG1tKTsKPiA+IC0JaWYgKCFhc2lkKQo+ID4gLQkJcmV0dXJu
IEVSUl9QVFIoLUVTUkNIKTsKPiA+ICsJaWYgKCFhc2lkKSB7Cj4gPiArCQllcnIgPSAtRVNSQ0g7
Cj4gPiArCQlnb3RvIG91dF9kcm9wX21tOwo+ID4gKwl9Cj4gPiAgIAljZCA9IGt6YWxsb2Moc2l6
ZW9mKCpjZCksIEdGUF9LRVJORUwpOwo+ID4gICAJaWYgKCFjZCkgewo+ID4gQEAgLTE2Nyw2ICsx
NzIsOCBAQCBzdGF0aWMgc3RydWN0IGFybV9zbW11X2N0eF9kZXNjICphcm1fc21tdV9hbGxvY19z
aGFyZWRfY2Qoc3RydWN0IG1tX3N0cnVjdCAqbW0pCj4gPiAgIAlrZnJlZShjZCk7Cj4gPiAgIG91
dF9wdXRfY29udGV4dDoKPiA+ICAgCWFybTY0X21tX2NvbnRleHRfcHV0KG1tKTsKPiA+ICtvdXRf
ZHJvcF9tbToKPiA+ICsJbW1kcm9wKG1tKTsKPiA+ICAgCXJldHVybiBlcnIgPCAwID8gRVJSX1BU
UihlcnIpIDogcmV0Owo+ID4gICB9Cj4gPiBAQCAtMTc1LDYgKzE4Miw3IEBAIHN0YXRpYyB2b2lk
IGFybV9zbW11X2ZyZWVfc2hhcmVkX2NkKHN0cnVjdCBhcm1fc21tdV9jdHhfZGVzYyAqY2QpCj4g
PiAgIAlpZiAoYXJtX3NtbXVfZnJlZV9hc2lkKGNkKSkgewo+ID4gICAJCS8qIFVucGluIEFTSUQg
Ki8KPiA+ICAgCQlhcm02NF9tbV9jb250ZXh0X3B1dChjZC0+bW0pOwo+ID4gKwkJbW1kcm9wKGNk
LT5tbSk7Cj4gPiAgIAkJa2ZyZWUoY2QpOwo+ID4gICAJfQo+ID4gICB9Cj4gCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdApp
b21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
