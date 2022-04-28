Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E82C433F5
	for <iommu@archiver.kernel.org>; Thu, 28 Apr 2022 05:43:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BA2344027F;
	Thu, 28 Apr 2022 05:43:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SP_b4Eo5TT02; Thu, 28 Apr 2022 05:43:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8F9E7400FB;
	Thu, 28 Apr 2022 05:43:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7075FC0032;
	Thu, 28 Apr 2022 05:43:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D3C1DC002D
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 05:43:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CFB8560AAD
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 05:43:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JXZ404xshpwQ for <iommu@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 05:43:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C3DD260AA3
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 05:43:28 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id l18so7331760ejc.7
 for <iommu@lists.linux-foundation.org>; Wed, 27 Apr 2022 22:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=s07a0DsY9s52QkJmiJ36LrahFkWV2t9AjkvfZr/kSYU=;
 b=AoSWjN4/5ia3sJysWSlpJKDFdG/NXjaAcfPIzWtpSV7VXYWAH+TaL+n47Sj1nuCQPi
 J56q+vUiECCLwu3kys9q/Jv1pOUc4MpmGNGfLPbRGLnRnQlsR6GqQZzTdDvhd/Qawh92
 /7oYX4g5gnXixje6OV1O6PG2hG6BTfY8TDrf+zL6dHFRjBtRiDNo5fmZgSzurmzXkvWU
 6bV3KbvuIPI5CN1bqS2frjrHr0uwIWKYxkXFhDlOkezxthjM5PGtwoolbM86cIje0lKr
 vTVdQTiCDjE8/E/f1AI0sSkqNPpeBQsbiI2JxkXRLOf+TlWZzylSoDuwScGjfY10IK+2
 M4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=s07a0DsY9s52QkJmiJ36LrahFkWV2t9AjkvfZr/kSYU=;
 b=zBuS6+6fPaKnsrprlxE4ni88CSBzwol9rMqMLv1KaJ10gXSHQZRzSa2zIoVaEEi1Ic
 o7Qh42sO/+dG1ZCtQYNEcI5hu70AxmZGflSXudLE2lkESYdTFDNMTn38h3ZfDaAeevMo
 UuMT9PzeL0G2YjiA/SmQi+woHJBnGRlN9++SROUgqGCWUMrYhJdKkwg/nrxe6mRFReT4
 NQgKZlGd1VzCgiCWhcbdqAkdtR731GgBUuFFZCCqp3q8gO97nsq3Xj6f3A/Z/X9Zpx+k
 Wj8BXiPTlqeiMb71jYVLlRWXnyLb84wsMyiFRBjVX/caE2qp0PwY81w7VOgXe3i1Embe
 hvWA==
X-Gm-Message-State: AOAM531rYq2FOxRafuLGOJJnrenhpsc75DcBsX5qvvqYOs6DZ1ch+nhq
 gPC76fQmCSbZ0fPwp1uWWnjZ29TXmAxBcA==
X-Google-Smtp-Source: ABdhPJzWJjNdXgo+WbHDrSQuq/2nYg4TWpvGFaOwbQshU+cXykP4HIK3zWEPoWCTdp5k14/cBAAWdw==
X-Received: by 2002:a17:906:1841:b0:6e8:872d:8999 with SMTP id
 w1-20020a170906184100b006e8872d8999mr29426739eje.492.1651124607032; 
 Wed, 27 Apr 2022 22:43:27 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net.
 [89.212.118.115]) by smtp.gmail.com with ESMTPSA id
 s25-20020a170906285900b006f3c813f51fsm2227173ejc.128.2022.04.27.22.43.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Apr 2022 22:43:26 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org, Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 3/5] iommu/sun50i: Ensure bypass is disabled
Date: Thu, 28 Apr 2022 07:43:25 +0200
Message-ID: <1922960.8hb0ThOEGa@jernej-laptop>
In-Reply-To: <20220428010401.11323-4-samuel@sholland.org>
References: <20220428010401.11323-1-samuel@sholland.org>
 <20220428010401.11323-4-samuel@sholland.org>
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

RG5lIMSNZXRydGVrLCAyOC4gYXByaWwgMjAyMiBvYiAwMzowMzo1OCBDRVNUIGplIFNhbXVlbCBI
b2xsYW5kIG5hcGlzYWwoYSk6Cj4gVGhlIEg2IHZhcmlhbnQgb2YgdGhlIGhhcmR3YXJlIGRpc2Fi
bGVzIGJ5cGFzcyBieSBkZWZhdWx0LiBUaGUgRDEKPiB2YXJpYW50IG9mIHRoZSBoYXJkd2FyZSBl
bmFibGVzIGJ5cGFzcyBmb3IgYWxsIG1hc3RlcnMgYnkgZGVmYXVsdC4KPiAKPiBTaW5jZSB0aGUg
ZHJpdmVyIGV4cGVjdHMgYnlwYXNzIHRvIGJlIGRpc2FibGVkLCBlbnN1cmUgdGhhdCBpcyB0aGUg
Y2FzZS4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBTYW11ZWwgSG9sbGFuZCA8c2FtdWVsQHNob2xsYW5k
Lm9yZz4KCkFjdHVhbGx5LCBpdCB3b3VsZCBiZSBiZXR0ZXIgdG8gc2V0IGJ5cGFzcyB0byAweGZm
IGFuZCBpbiAKc3VuNTBpX2lvbW11X2F0dGFjaF9kZXZpY2UoKSBjbGVhciBieXBhc3MgYml0IGZv
ciB0aGF0IHBhcnRpY3VsYXIgZGV2aWNlLiBBcyAKeW91IG1pZ2h0IG5vdGljZSwgaW5kZXggaW4g
cGhhbmRsZSBpcyBjdXJyZW50bHkgbm90IHVzZWQuIFRoaXMgd291bGQgYWxzbyBoZWxwIApleHBv
c2UgYnVncywgbGlrZSBtaXNzaW5nIHNlY29uZCBpb21tdSBjaGFubmVsIGZvciBDZWRydXMgb24g
SDYsIGJ1dCB0aGF0J3MgCmVhc3kgdG8gZml4LgoKQmVzdCByZWdhcmRzLApKZXJuZWoKCj4gLS0t
Cj4gCj4gIGRyaXZlcnMvaW9tbXUvc3VuNTBpLWlvbW11LmMgfCAyICsrCj4gIDEgZmlsZSBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9zdW41
MGktaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvc3VuNTBpLWlvbW11LmMKPiBpbmRleCBlYzA3YjYw
MDE2ZDMuLmI5ZTY0NGI5MzYzNyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2lvbW11L3N1bjUwaS1p
b21tdS5jCj4gKysrIGIvZHJpdmVycy9pb21tdS9zdW41MGktaW9tbXUuYwo+IEBAIC0zNzQsNiAr
Mzc0LDggQEAgc3RhdGljIGludCBzdW41MGlfaW9tbXVfZW5hYmxlKHN0cnVjdCBzdW41MGlfaW9t
bXUKPiAqaW9tbXUpCj4gCj4gIAlzcGluX2xvY2tfaXJxc2F2ZSgmaW9tbXUtPmlvbW11X2xvY2ss
IGZsYWdzKTsKPiAKPiArCWlvbW11X3dyaXRlKGlvbW11LCBJT01NVV9CWVBBU1NfUkVHLCAwKTsK
PiArCj4gIAlpb21tdV93cml0ZShpb21tdSwgSU9NTVVfVFRCX1JFRywgc3VuNTBpX2RvbWFpbi0+
ZHRfZG1hKTsKPiAgCWlvbW11X3dyaXRlKGlvbW11LCBJT01NVV9UTEJfUFJFRkVUQ0hfUkVHLAo+
ICAJCSAgICBJT01NVV9UTEJfUFJFRkVUQ0hfTUFTVEVSX0VOQUJMRSgwKSB8CgoKCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxp
c3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
