Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C08EC43334
	for <iommu@archiver.kernel.org>; Mon, 20 Jun 2022 13:26:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 00E1040AB6;
	Mon, 20 Jun 2022 13:26:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 00E1040AB6
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=vf/iYq9D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 64A-gt9RHwTl; Mon, 20 Jun 2022 13:26:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A754E4015E;
	Mon, 20 Jun 2022 13:26:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A754E4015E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E781C0039;
	Mon, 20 Jun 2022 13:26:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A6304C002D
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jun 2022 13:26:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7B6EE41870
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jun 2022 13:26:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7B6EE41870
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=vf/iYq9D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8m3_Mmpzx3QC for <iommu@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 13:26:06 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B8CD14186A
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B8CD14186A
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jun 2022 13:26:05 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id g25so21076426ejh.9
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jun 2022 06:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=bpkWVggJ3SSUB8ub063CuI93Ce8O0+lE1lmNavRnw/U=;
 b=vf/iYq9DpWz4A9mtQbIq4dg+t8LKJf93XXM3RhHu/GHf8CYhssYFp7miEDq8W3c0Fl
 ao9NKWI8A9jq+Wqb9JkOCjf8/oHc586a8exo/yPyJOIAJYRswYbEIVrewpvjuMlRtcvv
 CR2QfMue63UCqJArO6q+SMYpJU29d83H0Y4S3k4lRaNiJfkVVV+UQKz+CexOvxuCeTG4
 J2cmK7WlOvb3TKiyEKJPwCvZfsJf16/vT1Q/NVQxUA/mGWCtzshY4I4coUYNN45IWdZB
 txhWZkWbpQZVWpTXCWROu1N2Z/L2MPY552xGOi2ehwrJs2e5+4AwlYX3UwATMOxwmph/
 PQOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=bpkWVggJ3SSUB8ub063CuI93Ce8O0+lE1lmNavRnw/U=;
 b=DiLOnjqS77Gp7apvqwpYRlzMxsPkbLFyFbpgv+4Wd4o3hTMna5VzWTid/R5g8hxiDc
 tbV1Pp67uYbJzoM0viuIz701BMpUj+cQd6qykm6T8qL4/5iQZ1SRbgOj1wd6r2WFl9Ln
 Wn/xhIKpL2ltzK7Dmta5q30Fgo82aRRZWtwGM2LbJDHk3BxdOeue0pjoAnosPcbpv28T
 tiEFx6YalXPA7OLsVirK4/5PkVmLIGNmRkon7NuTUBMhHaSXLVGZBbHhwD6tVP39kPgN
 RUEVByc/RLQQgEAtyPsA+sUsWzjMERNzwWq6QDCG9f1niiWswT3iGyb3Lkq6EYsH1sZL
 IoKQ==
X-Gm-Message-State: AJIora/igSKnPN1xuOIAdlw2V9rU2nMqiQ99ykzwj6xXiadWw32UIGV3
 jmZQX6O86x/otXW2tSvVkZctAA==
X-Google-Smtp-Source: AGRyM1tYluEdJ+vnziL1SXQxMswnUz9oRFxNhv0bgVtToC+Hn6byz6Ji9EoyHK15pGGwLp0yY3CCvA==
X-Received: by 2002:a17:907:97c9:b0:71d:67ea:42ca with SMTP id
 js9-20020a17090797c900b0071d67ea42camr13845804ejc.7.1655731563861; 
 Mon, 20 Jun 2022 06:26:03 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168]) by smtp.gmail.com with ESMTPSA id
 h7-20020a17090634c700b006febce7081esm6063456ejb.177.2022.06.20.06.26.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jun 2022 06:26:03 -0700 (PDT)
Date: Mon, 20 Jun 2022 14:25:39 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: Re: [PATCH] uacce: fix concurrency of fops_open and uacce_remove
Message-ID: <YrB1U29QVHcKV3g8@myrica>
References: <20220610123423.27496-1-zhangfei.gao@linaro.org>
 <Yqn3spLZHpAkQ9Us@myrica>
 <fdc8d8b0-4e04-78f5-1e8a-4cf44c89a37f@linaro.org>
 <YqrmdKNrYTCiS/MC@myrica>
 <d90e8ea5-2f18-2eda-b4b2-711083aa7ecd@linaro.org>
 <53b9acef-ad32-d0aa-fa1b-a7cb77a0d088@linaro.org>
 <1fab1f9a-5c6c-8190-829b-4bacf15eb306@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1fab1f9a-5c6c-8190-829b-4bacf15eb306@linaro.org>
Cc: Yang Shen <shenyang39@huawei.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-crypto@vger.kernel.org, linux-accelerators@lists.ozlabs.org
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

T24gRnJpLCBKdW4gMTcsIDIwMjIgYXQgMTA6MjM6MTNQTSArMDgwMCwgWmhhbmdmZWkgR2FvIHdy
b3RlOgo+IEBAIC0zMTIsMTIgKzM0NSwyMCBAQCBzdGF0aWMgc3NpemVfdCBhdmFpbGFibGVfaW5z
dGFuY2VzX3Nob3coc3RydWN0IGRldmljZQo+ICpkZXYsCj4gwqDCoMKgwqAgwqDCoMKgIMKgwqDC
oCDCoMKgwqAgwqDCoMKgIGNoYXIgKmJ1ZikKPiDCoHsKPiDCoMKgwqDCoCBzdHJ1Y3QgdWFjY2Vf
ZGV2aWNlICp1YWNjZSA9IHRvX3VhY2NlX2RldmljZShkZXYpOwo+ICvCoMKgwqAgc3NpemVfdCBy
ZXQ7Cj4gCj4gLcKgwqDCoCBpZiAoIXVhY2NlLT5vcHMtPmdldF9hdmFpbGFibGVfaW5zdGFuY2Vz
KQo+IC3CoMKgwqAgwqDCoMKgIHJldHVybiAtRU5PREVWOwo+ICvCoMKgwqAgbXV0ZXhfbG9jaygm
dWFjY2VfbXV0ZXgpOwo+ICvCoMKgwqAgaWYgKCF1YWNjZS0+b3BzIHx8ICF1YWNjZS0+b3BzLT5n
ZXRfYXZhaWxhYmxlX2luc3RhbmNlcykgewoKRG9lc24ndCB0aGUgc3lzZnMgZ3JvdXAgZ28gYXdh
eSB3aXRoIHVhY2NlX3JlbW92ZSgpPyAgV2Ugc2hvdWxkbid0IG5lZWQKdGhpcyBjaGVjawoKVGhh
bmtzLApKZWFuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
