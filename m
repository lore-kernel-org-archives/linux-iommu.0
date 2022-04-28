Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFFDDC433EF
	for <iommu@archiver.kernel.org>; Thu, 28 Apr 2022 05:45:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7DD7F4171F;
	Thu, 28 Apr 2022 05:45:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yq9HSAIxzUgW; Thu, 28 Apr 2022 05:45:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 09E204175D;
	Thu, 28 Apr 2022 05:45:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CDFD5C0032;
	Thu, 28 Apr 2022 05:45:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B5F9CC002D
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 05:45:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 915FA60AA3
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 05:45:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PwPZbkbaiBSt for <iommu@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 05:45:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A2D2E607FF
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 05:45:36 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id k27so4254669edk.4
 for <iommu@lists.linux-foundation.org>; Wed, 27 Apr 2022 22:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bu1Am+mfc3RBLLJSWrxdM96hFXnw6XnAcu5xdCKTnQI=;
 b=U8hjzI4Jj09EF12s/5KD7XD/HAE5Z7zNZb7gWS9RHKNUrA2CWF+gTT/vZIv/5/mhc8
 4CJxJzlpSuKkDLHXEFMJRhg5iJCgsDrfAdB73ODHYREydYyubRYogza60y9tDwkqlHBy
 SAktsXiJBe+UBiaDkVc07s13Q/ReWDb0YAepyD0q6JPZc/mM+DuZhxVMk6wAXXFpXeIU
 GHGAyDXMSXzV/NlvvE/4Lk43zpBEXxm/LGkQVW16movp2IxXsMjwLSHD5rRbgP640tbP
 f0jsF/V5y+V4YOhKhPSv2HTyEacDMCqakP2v9tx9Obee8bSz44ZVXJf/94aed8paCPST
 5pxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bu1Am+mfc3RBLLJSWrxdM96hFXnw6XnAcu5xdCKTnQI=;
 b=E0ar7TYXknZpSTC0JgtJWmmGe7IeO501eh3kw2d5ZQWrw47T/o3cW3Q3fYnZZ3naqc
 O5XqSsOyGGuI5bGXRNxlkzbzuNiIXxkxfKukb40zaE9wJ0ZUs0DSt+PTfijAc8TmPLqy
 IBSpHkU5xoTgsjru7O1cHf55oJQPBv6m9WyT8u3IiRGgpJN8kqNi+aybGH76EFEEX5X+
 v44yksQiCqKwhilUSV5vbD19LaMhY4GFqE7YX9vLtqzl8vMH9BKYMiw75qiuVmow+jcs
 n9Di1WYImHqIpGXTuCsBE0S55IihGZ4kYpxVEyK6SzIDLwPO9oUzKEuPDTpxBRkb3pHA
 H74A==
X-Gm-Message-State: AOAM5321bFCyjzf3H4j5VPH70N6vum6N2R4iH8ehtbC/IFng56qXmFTa
 Viz0HPHBPySqDDSiD1vT+q4=
X-Google-Smtp-Source: ABdhPJxIesueP7mEJQ7cfZ1GF83jwnUH9gcTViGICL1YvhcSy1woJt6erlqveaurraCCU9ukUVTVCw==
X-Received: by 2002:a50:d79a:0:b0:425:e577:c71a with SMTP id
 w26-20020a50d79a000000b00425e577c71amr20815339edi.188.1651124734847; 
 Wed, 27 Apr 2022 22:45:34 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net.
 [89.212.118.115]) by smtp.gmail.com with ESMTPSA id
 z14-20020a170906944e00b006f38c33b6e3sm5970246ejx.68.2022.04.27.22.45.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Apr 2022 22:45:34 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org, Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 0/5] iommu/sun50i: Allwinner D1 support
Date: Thu, 28 Apr 2022 07:45:33 +0200
Message-ID: <1849776.IobQ9Gjlxr@jernej-laptop>
In-Reply-To: <20220428010401.11323-1-samuel@sholland.org>
References: <20220428010401.11323-1-samuel@sholland.org>
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

SGkgU2FtdWVsIQoKRG5lIMSNZXRydGVrLCAyOC4gYXByaWwgMjAyMiBvYiAwMzowMzo1NSBDRVNU
IGplIFNhbXVlbCBIb2xsYW5kIG5hcGlzYWwoYSk6Cj4gRDEgaXMgYSBSSVNDLVYgU29DIGZyb20g
QWxsd2lubmVyJ3Mgc3VueGkgZmFtaWx5LiBUaGlzIHNlcmllcyBhZGRzIElPTU1VCj4gYmluZGlu
ZyBhbmQgZHJpdmVyIHN1cHBvcnQuCj4gCj4gT25lIHBpZWNlIGlzIHN0aWxsIG1pc3NpbmcgdG8g
dXNlIHRoZSBJT01NVSBmb3IgRE1BIGFsbG9jYXRpb25zOiBhIGNhbGwKPiB0byBpb21tdV9zZXR1
cF9kbWFfb3BzKCkuIE9uIEFSTTY0IHRoaXMgaXMgaGFuZGxlZCBieSB0aGUgYXJjaGl0ZWN0dXJl
J3MKPiBjb2RlLiBSSVNDLVYgZG9lcyBub3QgY3VycmVudGx5IHNlbGVjdCBBUkNIX0hBU19TRVRV
UF9ETUFfT1BTLCBidXQgaXQKPiB3aWxsIG9uY2UgWmljYm9tIHN1cHBvcnRbMV0gaXMgbWVyZ2Vk
Lgo+IAo+IFsxXTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIyMDMwNzIyNDYyMC4x
OTMzMDYxLTItaGVpa29Ac250ZWNoLmRlLwo+IAo+IFNvIEkgY2Fubm90IGZvbGxvdyB2aXJ0aW8t
aW9tbXUuYyBhbmQgY2FsbCBpb21tdV9zZXR1cF9kbWFfb3BzKCkgd2hlbgo+IEFSQ0hfSEFTX1NF
VFVQX0RNQV9PUFM9bi4gSG93ZXZlciwgaWYgSSBhcHBseSB0aGUgZm9sbG93aW5nIHBhdGNoIG9u
IHRvcAo+IG9mIEhlaWtvJ3Mgbm9uLWNvaGVyZW50IERNQSBzZXJpZXMsIHRoZSBkaXNwbGF5IGVu
Z2luZSBzdWNjZXNzZnVsbHkgdXNlcwo+IHRoZSBJT01NVSB0byBhbGxvY2F0ZSBpdHMgZnJhbWVi
dWZmZXI6CgpEaWQgeW91IHRlc3QgdGhpcyBvbiBhbnkgb3RoZXIgZGV2aWNlIHRoYW4gZGlzcGxh
eSBwaXBlbGluZT8gSXQgc2hvdWxkIGJlIApzdXBwb3J0ZWQgYnkgQ2VkcnVzIHRvbywgcmlnaHQ/
IEkgdGhpbmsgdGhlcmUgYXJlIHN0aWxsIHNvbWUgY29ybmVyIGNhc2VzIHRvIApmaXggb24gQ2Vk
cnVzIGJlZm9yZSBJT01NVSBmdWxseSB3b3Jrcy4KCkJlc3QgcmVnYXJkcywKSmVybmVqCgo+IAo+
IC0tLSBhL2FyY2gvcmlzY3YvbW0vZG1hLW5vbmNvaGVyZW50LmMKPiArKysgYi9hcmNoL3Jpc2N2
L21tL2RtYS1ub25jb2hlcmVudC5jCj4gQEAgLTYsNiArNiw3IEBACj4gICAqLwo+IAo+ICAjaW5j
bHVkZSA8bGludXgvZG1hLWRpcmVjdC5oPgo+ICsjaW5jbHVkZSA8bGludXgvZG1hLWlvbW11Lmg+
Cj4gICNpbmNsdWRlIDxsaW51eC9kbWEtbWFwLW9wcy5oPgo+ICAjaW5jbHVkZSA8bGludXgvbW0u
aD4KPiAKPiBAQCAtNTMsNCArNTQsNyBAQAo+ICB7Cj4gIAkvKiBJZiBhIHNwZWNpZmljIGRldmlj
ZSBpcyBkbWEtY29oZXJlbnQsIHNldCBpdCBoZXJlICovCj4gIAlkZXYtPmRtYV9jb2hlcmVudCA9
IGNvaGVyZW50Owo+ICsKPiArCWlmIChpb21tdSkKPiArCQlpb21tdV9zZXR1cF9kbWFfb3BzKGRl
diwgZG1hX2Jhc2UsIGRtYV9iYXNlICsgc2l6ZSAtIDEpOwo+ICB9Cj4gCj4gCj4gU2FtdWVsIEhv
bGxhbmQgKDUpOgo+ICAgZHQtYmluZGluZ3M6IGlvbW11OiBzdW41MGk6IEFkZCBjb21wYXRpYmxl
IGZvciBBbGx3aW5uZXIgRDEKPiAgIGlvbW11L3N1bjUwaTogU3VwcG9ydCB2YXJpYW50cyB3aXRo
b3V0IGFuIGV4dGVybmFsIHJlc2V0Cj4gICBpb21tdS9zdW41MGk6IEVuc3VyZSBieXBhc3MgaXMg
ZGlzYWJsZWQKPiAgIGlvbW11L3N1bjUwaTogQWRkIHN1cHBvcnQgZm9yIHRoZSBEMSB2YXJpYW50
Cj4gICBpb21tdS9zdW41MGk6IEVuc3VyZSB0aGUgSU9NTVUgY2FuIGJlIHVzZWQgZm9yIERNQQo+
IAo+ICAuLi4vaW9tbXUvYWxsd2lubmVyLHN1bjUwaS1oNi1pb21tdS55YW1sICAgICAgfCAxNiAr
KysrKysrKysrKy0tCj4gIGRyaXZlcnMvaW9tbXUvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAg
ICAgICB8ICAxICsKPiAgZHJpdmVycy9pb21tdS9zdW41MGktaW9tbXUuYyAgICAgICAgICAgICAg
ICAgIHwgMjQgKysrKysrKysrKysrKysrKystLQo+ICAzIGZpbGVzIGNoYW5nZWQsIDM3IGluc2Vy
dGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vaW9tbXU=
