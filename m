Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C49F3C433EF
	for <iommu@archiver.kernel.org>; Thu, 28 Apr 2022 05:34:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 602A2605BA;
	Thu, 28 Apr 2022 05:34:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fk7HVdVHeSJk; Thu, 28 Apr 2022 05:34:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 27B0F6066D;
	Thu, 28 Apr 2022 05:34:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ED9D9C0032;
	Thu, 28 Apr 2022 05:34:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8CB03C002D
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 05:34:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7A4E46066D
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 05:34:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BWSBLnd1vtJi for <iommu@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 05:34:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AC5D1605BA
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 05:34:26 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id d6so4223232ede.8
 for <iommu@lists.linux-foundation.org>; Wed, 27 Apr 2022 22:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XBSM19WHQrA/ZYWGbJg75BNh3CcfAodaxAUNqq255NU=;
 b=plM7dwWhPQ3jZth62O5SXqLdvRYEn6LJLnS3SMhG1knXt6I4K6PCNUPn/2U4RXzJEK
 /SaMHSqP+YKIfABjIGivVyyZqTVUJ0c+qgHonmvt6ey8B8Hvj+bvxKjmMtfLkykMPVI4
 QJabxuuaZskVSwthx9T7QEIarzSu46DwLY+0vv1lX1vjswWCp1yXwdkOx4uolexbFo1e
 9O5L4mZsrRsUgiqouHlw41R0nlcJAzcMcnW6G2vz52BWuKlLhZziycMXmWIWYFpH27QB
 59cU6+Oaz2XenKYd3FdRR4kzqchxMpCk/8r7eqvEGZx6OYWPnQxXX7oxHXmI6K8uWSFs
 o3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XBSM19WHQrA/ZYWGbJg75BNh3CcfAodaxAUNqq255NU=;
 b=X+so8Ipgv+fG5hPzjgNXiBmge4tSD7TCeD6TEQqjyDZbuuAr4g5Ss5H6ExINt38FCU
 bsFphMuWLXA8yxXtlXXyE5sLVznjq1KdxkSNYUD2fhrZHvCQ0TLeDRTl999sV3ymfIBZ
 FNZIONHnh0jjpq9EIrh+5+lpNQiHizc7dKom6d475bvBiHamEf/Hce5pb7Bpb976f1vS
 rvstaFPWRxp24IlRmVVXbuEPwHSbgdoP3/f8T/SUK0vMr6EQ3HqgEG5a7kfcW5rZfU+q
 GgdMHbYoyWfSWPXmL47eYbXm3X9sCICX3XCTDik8eYcNRQSN//oNqjNoTfPdwqygFE2R
 AdaQ==
X-Gm-Message-State: AOAM531pmktsCAtf4K7UHvO4AJUgbDGMRGyALncRZMAFCPdD4MoLQcZp
 bpi2WPl/QenN7jecyMNHJl0=
X-Google-Smtp-Source: ABdhPJxuFhdJ38I6OmBPpApX2mQq7HJRP4HXdI9BJ7CWtg4F08MfhnU+6wRqgvj5ZOzfkTlg3smYQw==
X-Received: by 2002:a50:e696:0:b0:419:998d:5feb with SMTP id
 z22-20020a50e696000000b00419998d5febmr34607475edm.122.1651124064815; 
 Wed, 27 Apr 2022 22:34:24 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net.
 [89.212.118.115]) by smtp.gmail.com with ESMTPSA id
 j27-20020a170906255b00b006f379c4323bsm6303285ejb.60.2022.04.27.22.34.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Apr 2022 22:34:24 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org, Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 2/5] iommu/sun50i: Support variants without an external
 reset
Date: Thu, 28 Apr 2022 07:34:22 +0200
Message-ID: <2857429.VdNmn5OnKV@jernej-laptop>
In-Reply-To: <20220428010401.11323-3-samuel@sholland.org>
References: <20220428010401.11323-1-samuel@sholland.org>
 <20220428010401.11323-3-samuel@sholland.org>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
 Samuel Holland <samuel@sholland.org>, linux-kernel@vger.kernel.org,
 Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-riscv@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org
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

RG5lIMSNZXRydGVrLCAyOC4gYXByaWwgMjAyMiBvYiAwMzowMzo1NyBDRVNUIGplIFNhbXVlbCBI
b2xsYW5kIG5hcGlzYWwoYSk6Cj4gVGhlIElPTU1VIGluIHRoZSBBbGx3aW5uZXIgRDEgU29DIGRv
ZXMgbm90IGhhdmUgYW4gZXh0ZXJuYWwgcmVzZXQgbGluZS4KPiAKPiBPbmx5IGF0dGVtcHQgdG8g
Z2V0IHRoZSByZXNldCBvbiBoYXJkd2FyZSB2YXJpYW50cyB3aGljaCBzaG91bGQgaGF2ZSBvbmUK
PiBhY2NvcmRpbmcgdG8gdGhlIGJpbmRpbmcuIEFuZCBzd2l0Y2ggZnJvbSB0aGUgZGVwcmVjYXRl
ZCBmdW5jdGlvbiB0byB0aGUKPiBleHBsaWNpdCAiZXhjbHVzaXZlIiB2YXJpYW50Lgo+IAo+IFNp
Z25lZC1vZmYtYnk6IFNhbXVlbCBIb2xsYW5kIDxzYW11ZWxAc2hvbGxhbmQub3JnPgoKUmV2aWV3
ZWQtYnk6IEplcm5laiBTa3JhYmVjIDxqZXJuZWouc2tyYWJlY0BnbWFpbC5jb20+CgpCZXN0IHJl
Z2FyZHMsCkplcm5lagoKPiAtLS0KPiAKPiAgZHJpdmVycy9pb21tdS9zdW41MGktaW9tbXUuYyB8
IDE4ICsrKysrKysrKysrKysrKystLQo+ICAxIGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9zdW41MGkt
aW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvc3VuNTBpLWlvbW11LmMKPiBpbmRleCBjNTRhYjQ3N2I4
ZmQuLmVjMDdiNjAwMTZkMyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2lvbW11L3N1bjUwaS1pb21t
dS5jCj4gKysrIGIvZHJpdmVycy9pb21tdS9zdW41MGktaW9tbXUuYwo+IEBAIC05Miw2ICs5Miwx
MCBAQAo+ICAjZGVmaW5lIE5VTV9QVF9FTlRSSUVTCQkJMjU2Cj4gICNkZWZpbmUgUFRfU0laRQkJ
CQkoTlVNX1BUX0VOVFJJRVMgKiAKUFRfRU5UUllfU0laRSkKPiAKPiArc3RydWN0IHN1bjUwaV9p
b21tdV92YXJpYW50IHsKPiArCWJvb2wgaGFzX3Jlc2V0Owo+ICt9Owo+ICsKPiAgc3RydWN0IHN1
bjUwaV9pb21tdSB7Cj4gIAlzdHJ1Y3QgaW9tbXVfZGV2aWNlIGlvbW11Owo+IAo+IEBAIC05MDUs
OSArOTA5LDE0IEBAIHN0YXRpYyBpcnFyZXR1cm5fdCBzdW41MGlfaW9tbXVfaXJxKGludCBpcnEs
IHZvaWQKPiAqZGV2X2lkKQo+IAo+ICBzdGF0aWMgaW50IHN1bjUwaV9pb21tdV9wcm9iZShzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQo+ICB7Cj4gKwljb25zdCBzdHJ1Y3Qgc3VuNTBpX2lv
bW11X3ZhcmlhbnQgKnZhcmlhbnQ7Cj4gIAlzdHJ1Y3Qgc3VuNTBpX2lvbW11ICppb21tdTsKPiAg
CWludCByZXQsIGlycTsKPiAKPiArCXZhcmlhbnQgPSBvZl9kZXZpY2VfZ2V0X21hdGNoX2RhdGEo
JnBkZXYtPmRldik7Cj4gKwlpZiAoIXZhcmlhbnQpCj4gKwkJcmV0dXJuIC1FSU5WQUw7Cj4gKwo+
ICAJaW9tbXUgPSBkZXZtX2t6YWxsb2MoJnBkZXYtPmRldiwgc2l6ZW9mKCppb21tdSksIEdGUF9L
RVJORUwpOwo+ICAJaWYgKCFpb21tdSkKPiAgCQlyZXR1cm4gLUVOT01FTTsKPiBAQCAtOTQ3LDcg
Kzk1Niw4IEBAIHN0YXRpYyBpbnQgc3VuNTBpX2lvbW11X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UKPiAqcGRldikgZ290byBlcnJfZnJlZV9ncm91cDsKPiAgCX0KPiAKPiAtCWlvbW11LT5y
ZXNldCA9IGRldm1fcmVzZXRfY29udHJvbF9nZXQoJnBkZXYtPmRldiwgTlVMTCk7Cj4gKwlpZiAo
dmFyaWFudC0+aGFzX3Jlc2V0KQo+ICsJCWlvbW11LT5yZXNldCA9IGRldm1fcmVzZXRfY29udHJv
bF9nZXRfZXhjbHVzaXZlKCZwZGV2LQo+ZGV2LCBOVUxMKTsKPiAgCWlmIChJU19FUlIoaW9tbXUt
PnJlc2V0KSkgewo+ICAJCWRldl9lcnIoJnBkZXYtPmRldiwgIkNvdWxkbid0IGdldCBvdXIgcmVz
ZXQgbGluZS5cbiIpOwo+ICAJCXJldCA9IFBUUl9FUlIoaW9tbXUtPnJlc2V0KTsKPiBAQCAtOTg3
LDggKzk5NywxMiBAQCBzdGF0aWMgaW50IHN1bjUwaV9pb21tdV9wcm9iZShzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlCj4gKnBkZXYpIHJldHVybiByZXQ7Cj4gIH0KPiAKPiArc3RhdGljIGNvbnN0IHN0
cnVjdCBzdW41MGlfaW9tbXVfdmFyaWFudCBzdW41MGlfaDZfaW9tbXUgPSB7Cj4gKwkuaGFzX3Jl
c2V0ID0gdHJ1ZSwKPiArfTsKPiArCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lk
IHN1bjUwaV9pb21tdV9kdFtdID0gewo+IC0JeyAuY29tcGF0aWJsZSA9ICJhbGx3aW5uZXIsc3Vu
NTBpLWg2LWlvbW11IiwgfSwKPiArCXsgLmNvbXBhdGlibGUgPSAiYWxsd2lubmVyLHN1bjUwaS1o
Ni1pb21tdSIsIC5kYXRhID0gCiZzdW41MGlfaDZfaW9tbXUgfSwKPiAgCXsgLyogc2VudGluZWwg
Ki8gfSwKPiAgfTsKPiAgTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgc3VuNTBpX2lvbW11X2R0KTsK
CgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11
IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
