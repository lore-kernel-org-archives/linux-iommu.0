Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04ECAC433EF
	for <iommu@archiver.kernel.org>; Mon, 27 Jun 2022 11:50:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7DBBF40C26;
	Mon, 27 Jun 2022 11:50:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7DBBF40C26
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=EnQ3BVtZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yS8cbtXEHQ2S; Mon, 27 Jun 2022 11:50:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 29F5B40A81;
	Mon, 27 Jun 2022 11:50:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 29F5B40A81
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 01648C0039;
	Mon, 27 Jun 2022 11:50:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 139C5C002D
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 11:50:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EE34B4193D
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 11:50:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EE34B4193D
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=EnQ3BVtZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QHiEsHfz63XT for <iommu@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 11:50:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CB41A415A8
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CB41A415A8
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 11:50:46 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id
 m14-20020a17090a668e00b001ee6ece8368so2913287pjj.3
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 04:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=invPJVG0Zi9GIegGywieHIr+1+qNTfD0fpIiT0T0TJY=;
 b=EnQ3BVtZdiJHxixZGRx2668myA1Mxh8MQs/zNoCQ9HcSR0j586iRu9SNsO6dJuuocF
 b4MKKdbdIw+yBIwbyAwg176XD8gJFtxveF9Rm00HQfiLKsgiOXS37V3Us6+8lQjwGeum
 f3m2Oo7paOMHSCndKg4SuWDMCpUbBrRrmbKiufTTx/VnibR87u8TyaplirRr+te9UToF
 GqBJ9tvGAaBGjZ0UlfetFtk1z+jzKoVZNy0IQapVewRWXKIZM7oFnapDSO69G8yZZZ62
 rb+1l5Mw71Y2L5ym26wIN+9C1llMWTr7arYiT04keOcpqlf0PNkvWD7JsRG473916yl0
 fFjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=invPJVG0Zi9GIegGywieHIr+1+qNTfD0fpIiT0T0TJY=;
 b=pxxAI+OfGNCJYUf+NhcObixsp9vl1cVMJYYD82CgklE7P1Gc5O0PIit7N6j43s66Io
 ZDV2EBM7ub3YSgcIh8cvP8PrysdrG3cOGoyRomGKJDZueutNpEgJ5Bqj93V4FICYO5Ty
 tDvx3k8P9VYe9oOdCWccO3dnveIKhjd9wQ6gRbvPP0xGyepARWRQlUqtTyC0t5Bt3JzV
 8jBIaHQFqM672vPsFCd74bj+j0PwlYYw9LFaclcrgF++WHYQtqzxhQxkb6Qx8LEvBw+J
 bjCqP6jlAmldS3dzxn8o1aLf/yl5NVHt110+PcDW1tiA2+CyfzvgXl/SoH74b4csLgH1
 WmgQ==
X-Gm-Message-State: AJIora9yXL+eB0GlmkNCzlIsSm8LiTXvvKJOgh2b7wD44LNTNbWgRLby
 lWcwtyd7kPn9uubLkSS3Jx8erA==
X-Google-Smtp-Source: AGRyM1sGN8A+qrpRYCQMMBpa5Cz99TnCu+ClMzfaatzPThPzWDm1zzPuJ/tGmm4dBwFwR7mB9apK5A==
X-Received: by 2002:a17:90b:c82:b0:1ec:b80a:676 with SMTP id
 o2-20020a17090b0c8200b001ecb80a0676mr20757435pjz.45.1656330646160; 
 Mon, 27 Jun 2022 04:50:46 -0700 (PDT)
Received: from [10.51.0.6] ([199.101.192.62]) by smtp.gmail.com with ESMTPSA id
 d85-20020a621d58000000b0052549cc3416sm7312546pfd.175.2022.06.27.04.50.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jun 2022 04:50:45 -0700 (PDT)
Subject: Re: [PATCH v9 06/11] arm-smmu-v3/sva: Add SVA domain support
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
References: <20220621144353.17547-1-baolu.lu@linux.intel.com>
 <20220621144353.17547-7-baolu.lu@linux.intel.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <9266198d-33fd-4cc5-fdaa-3ba5571543b1@linaro.org>
Date: Mon, 27 Jun 2022 19:50:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220621144353.17547-7-baolu.lu@linux.intel.com>
Content-Language: en-US
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>
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

CgpPbiAyMDIyLzYvMjEg5LiL5Y2IMTA6NDMsIEx1IEJhb2x1IHdyb3RlOgo+IEFkZCBzdXBwb3J0
IGZvciBTVkEgZG9tYWluIGFsbG9jYXRpb24gYW5kIHByb3ZpZGUgYW4gU1ZBLXNwZWNpZmljCj4g
aW9tbXVfZG9tYWluX29wcy4KPgo+IFNpZ25lZC1vZmYtYnk6IEx1IEJhb2x1IDxiYW9sdS5sdUBs
aW51eC5pbnRlbC5jb20+Cj4gUmV2aWV3ZWQtYnk6IEplYW4tUGhpbGlwcGUgQnJ1Y2tlciA8amVh
bi1waGlsaXBwZUBsaW5hcm8ub3JnPgoKVGVzdGVkLWJ5OiBaaGFuZ2ZlaSBHYW8gPHpoYW5nZmVp
Lmdhb0BsaW5hcm8ub3JnPgpIYXZlIHRlc3RlZCB0aGUgc2VyaWVzIG9uIGFhcmNoNjQuCgpUaGFu
a3MKCj4gLS0tCj4gICBkcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My5o
ICAgfCAgNiArKwo+ICAgLi4uL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My1zdmEu
YyAgIHwgNjkgKysrKysrKysrKysrKysrKysrKwo+ICAgZHJpdmVycy9pb21tdS9hcm0vYXJtLXNt
bXUtdjMvYXJtLXNtbXUtdjMuYyAgIHwgIDMgKwo+ICAgMyBmaWxlcyBjaGFuZ2VkLCA3OCBpbnNl
cnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUtdjMv
YXJtLXNtbXUtdjMuaCBiL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYz
LmgKPiBpbmRleCBkMmJhODY0NzBjNDIuLjk2Mzk5ZGQzYTY3YSAxMDA2NDQKPiAtLS0gYS9kcml2
ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My5oCj4gKysrIGIvZHJpdmVycy9p
b21tdS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMuaAo+IEBAIC03NTgsNiArNzU4LDcgQEAg
c3RydWN0IGlvbW11X3N2YSAqYXJtX3NtbXVfc3ZhX2JpbmQoc3RydWN0IGRldmljZSAqZGV2LCBz
dHJ1Y3QgbW1fc3RydWN0ICptbSk7Cj4gICB2b2lkIGFybV9zbW11X3N2YV91bmJpbmQoc3RydWN0
IGlvbW11X3N2YSAqaGFuZGxlKTsKPiAgIHUzMiBhcm1fc21tdV9zdmFfZ2V0X3Bhc2lkKHN0cnVj
dCBpb21tdV9zdmEgKmhhbmRsZSk7Cj4gICB2b2lkIGFybV9zbW11X3N2YV9ub3RpZmllcl9zeW5j
aHJvbml6ZSh2b2lkKTsKPiArc3RydWN0IGlvbW11X2RvbWFpbiAqYXJtX3NtbXVfc3ZhX2RvbWFp
bl9hbGxvYyh2b2lkKTsKPiAgICNlbHNlIC8qIENPTkZJR19BUk1fU01NVV9WM19TVkEgKi8KPiAg
IHN0YXRpYyBpbmxpbmUgYm9vbCBhcm1fc21tdV9zdmFfc3VwcG9ydGVkKHN0cnVjdCBhcm1fc21t
dV9kZXZpY2UgKnNtbXUpCj4gICB7Cj4gQEAgLTgwMyw1ICs4MDQsMTAgQEAgc3RhdGljIGlubGlu
ZSB1MzIgYXJtX3NtbXVfc3ZhX2dldF9wYXNpZChzdHJ1Y3QgaW9tbXVfc3ZhICpoYW5kbGUpCj4g
ICB9Cj4gICAKPiAgIHN0YXRpYyBpbmxpbmUgdm9pZCBhcm1fc21tdV9zdmFfbm90aWZpZXJfc3lu
Y2hyb25pemUodm9pZCkge30KPiArCj4gK3N0YXRpYyBpbmxpbmUgc3RydWN0IGlvbW11X2RvbWFp
biAqYXJtX3NtbXVfc3ZhX2RvbWFpbl9hbGxvYyh2b2lkKQo+ICt7Cj4gKwlyZXR1cm4gTlVMTDsK
PiArfQo+ICAgI2VuZGlmIC8qIENPTkZJR19BUk1fU01NVV9WM19TVkEgKi8KPiAgICNlbmRpZiAv
KiBfQVJNX1NNTVVfVjNfSCAqLwo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2FybS9hcm0t
c21tdS12My9hcm0tc21tdS12My1zdmEuYyBiL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYz
L2FybS1zbW11LXYzLXN2YS5jCj4gaW5kZXggZjE1NWQ0MDZjNWQ1Li5mYzQ1NTVkYWM1YjQgMTAw
NjQ0Cj4gLS0tIGEvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMtc3Zh
LmMKPiArKysgYi9kcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My1zdmEu
Ywo+IEBAIC01NDksMyArNTQ5LDcyIEBAIHZvaWQgYXJtX3NtbXVfc3ZhX25vdGlmaWVyX3N5bmNo
cm9uaXplKHZvaWQpCj4gICAJICovCj4gICAJbW11X25vdGlmaWVyX3N5bmNocm9uaXplKCk7Cj4g
ICB9Cj4gKwo+ICtzdGF0aWMgaW50IGFybV9zbW11X3N2YV9zZXRfZGV2X3Bhc2lkKHN0cnVjdCBp
b21tdV9kb21haW4gKmRvbWFpbiwKPiArCQkJCSAgICAgIHN0cnVjdCBkZXZpY2UgKmRldiwgaW9h
c2lkX3QgaWQpCj4gK3sKPiArCWludCByZXQgPSAwOwo+ICsJc3RydWN0IG1tX3N0cnVjdCAqbW07
Cj4gKwlzdHJ1Y3QgaW9tbXVfc3ZhICpoYW5kbGU7Cj4gKwo+ICsJaWYgKGRvbWFpbi0+dHlwZSAh
PSBJT01NVV9ET01BSU5fU1ZBKQo+ICsJCXJldHVybiAtRUlOVkFMOwo+ICsKPiArCW1tID0gZG9t
YWluLT5tbTsKPiArCWlmIChXQVJOX09OKCFtbSkpCj4gKwkJcmV0dXJuIC1FTk9ERVY7Cj4gKwo+
ICsJbXV0ZXhfbG9jaygmc3ZhX2xvY2spOwo+ICsJaGFuZGxlID0gX19hcm1fc21tdV9zdmFfYmlu
ZChkZXYsIG1tKTsKPiArCWlmIChJU19FUlIoaGFuZGxlKSkKPiArCQlyZXQgPSBQVFJfRVJSKGhh
bmRsZSk7Cj4gKwltdXRleF91bmxvY2soJnN2YV9sb2NrKTsKPiArCj4gKwlyZXR1cm4gcmV0Owo+
ICt9Cj4gKwo+ICtzdGF0aWMgdm9pZCBhcm1fc21tdV9zdmFfYmxvY2tfZGV2X3Bhc2lkKHN0cnVj
dCBpb21tdV9kb21haW4gKmRvbWFpbiwKPiArCQkJCQkgc3RydWN0IGRldmljZSAqZGV2LCBpb2Fz
aWRfdCBpZCkKPiArewo+ICsJc3RydWN0IG1tX3N0cnVjdCAqbW0gPSBkb21haW4tPm1tOwo+ICsJ
c3RydWN0IGFybV9zbW11X2JvbmQgKmJvbmQgPSBOVUxMLCAqdDsKPiArCXN0cnVjdCBhcm1fc21t
dV9tYXN0ZXIgKm1hc3RlciA9IGRldl9pb21tdV9wcml2X2dldChkZXYpOwo+ICsKPiArCW11dGV4
X2xvY2soJnN2YV9sb2NrKTsKPiArCWxpc3RfZm9yX2VhY2hfZW50cnkodCwgJm1hc3Rlci0+Ym9u
ZHMsIGxpc3QpIHsKPiArCQlpZiAodC0+bW0gPT0gbW0pIHsKPiArCQkJYm9uZCA9IHQ7Cj4gKwkJ
CWJyZWFrOwo+ICsJCX0KPiArCX0KPiArCj4gKwlpZiAoIVdBUk5fT04oIWJvbmQpICYmIHJlZmNv
dW50X2RlY19hbmRfdGVzdCgmYm9uZC0+cmVmcykpIHsKPiArCQlsaXN0X2RlbCgmYm9uZC0+bGlz
dCk7Cj4gKwkJYXJtX3NtbXVfbW11X25vdGlmaWVyX3B1dChib25kLT5zbW11X21uKTsKPiArCQlr
ZnJlZShib25kKTsKPiArCX0KPiArCW11dGV4X3VubG9jaygmc3ZhX2xvY2spOwo+ICt9Cj4gKwo+
ICtzdGF0aWMgdm9pZCBhcm1fc21tdV9zdmFfZG9tYWluX2ZyZWUoc3RydWN0IGlvbW11X2RvbWFp
biAqZG9tYWluKQo+ICt7Cj4gKwlrZnJlZShkb21haW4pOwo+ICt9Cj4gKwo+ICtzdGF0aWMgY29u
c3Qgc3RydWN0IGlvbW11X2RvbWFpbl9vcHMgYXJtX3NtbXVfc3ZhX2RvbWFpbl9vcHMgPSB7Cj4g
Kwkuc2V0X2Rldl9wYXNpZAkJPSBhcm1fc21tdV9zdmFfc2V0X2Rldl9wYXNpZCwKPiArCS5ibG9j
a19kZXZfcGFzaWQJPSBhcm1fc21tdV9zdmFfYmxvY2tfZGV2X3Bhc2lkLAo+ICsJLmZyZWUJCQk9
IGFybV9zbW11X3N2YV9kb21haW5fZnJlZSwKPiArfTsKPiArCj4gK3N0cnVjdCBpb21tdV9kb21h
aW4gKmFybV9zbW11X3N2YV9kb21haW5fYWxsb2Modm9pZCkKPiArewo+ICsJc3RydWN0IGlvbW11
X2RvbWFpbiAqZG9tYWluOwo+ICsKPiArCWRvbWFpbiA9IGt6YWxsb2Moc2l6ZW9mKCpkb21haW4p
LCBHRlBfS0VSTkVMKTsKPiArCWlmICghZG9tYWluKQo+ICsJCXJldHVybiBOVUxMOwo+ICsJZG9t
YWluLT5vcHMgPSAmYXJtX3NtbXVfc3ZhX2RvbWFpbl9vcHM7Cj4gKwo+ICsJcmV0dXJuIGRvbWFp
bjsKPiArfQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0t
c21tdS12My5jIGIvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMuYwo+
IGluZGV4IGFlOGVjOGRmNDdjMS4uYTMwYjI1MmUyZjk1IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMv
aW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLmMKPiArKysgYi9kcml2ZXJzL2lvbW11
L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My5jCj4gQEAgLTE5OTksNiArMTk5OSw5IEBAIHN0
YXRpYyBzdHJ1Y3QgaW9tbXVfZG9tYWluICphcm1fc21tdV9kb21haW5fYWxsb2ModW5zaWduZWQg
dHlwZSkKPiAgIHsKPiAgIAlzdHJ1Y3QgYXJtX3NtbXVfZG9tYWluICpzbW11X2RvbWFpbjsKPiAg
IAo+ICsJaWYgKHR5cGUgPT0gSU9NTVVfRE9NQUlOX1NWQSkKPiArCQlyZXR1cm4gYXJtX3NtbXVf
c3ZhX2RvbWFpbl9hbGxvYygpOwo+ICsKPiAgIAlpZiAodHlwZSAhPSBJT01NVV9ET01BSU5fVU5N
QU5BR0VEICYmCj4gICAJICAgIHR5cGUgIT0gSU9NTVVfRE9NQUlOX0RNQSAmJgo+ICAgCSAgICB0
eXBlICE9IElPTU1VX0RPTUFJTl9ETUFfRlEgJiYKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby9pb21tdQ==
