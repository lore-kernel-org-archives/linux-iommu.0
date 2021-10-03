Return-Path: <SRS0=4wUA=OX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D5BC433F5
	for <iommu@archiver.kernel.org>; Sun,  3 Oct 2021 01:10:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E14F61AFE
	for <iommu@archiver.kernel.org>; Sun,  3 Oct 2021 01:10:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5E14F61AFE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 142FB4043F;
	Sun,  3 Oct 2021 01:10:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gJuSVkqO64v5; Sun,  3 Oct 2021 01:10:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A800A401FC;
	Sun,  3 Oct 2021 01:10:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 662C0C0011;
	Sun,  3 Oct 2021 01:10:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1BD5EC000D
 for <iommu@lists.linux-foundation.org>; Sun,  3 Oct 2021 01:10:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 11E794031E
 for <iommu@lists.linux-foundation.org>; Sun,  3 Oct 2021 01:10:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Waf_3av4qShn for <iommu@lists.linux-foundation.org>;
 Sun,  3 Oct 2021 01:09:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1AAE140303
 for <iommu@lists.linux-foundation.org>; Sun,  3 Oct 2021 01:09:59 +0000 (UTC)
Received: by mail-lf1-x131.google.com with SMTP id e15so54935715lfr.10
 for <iommu@lists.linux-foundation.org>; Sat, 02 Oct 2021 18:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=KL2m0atW+MByUv6kMnNyCu2PrRqSFhE88TBSkVne3g4=;
 b=ChvU3NevUHYp7Y8UvD1/YwslSDB0USOcafs2NG0qcs0FpxQuNdFGz1nVXMZWpNLhpz
 1ETJ9zEEj7fq1pZXwDLifCWR/uxcSA39Tsh1GxWAqsLP+MNIddW+/MDnzFqXomviuWsH
 NOpUhwL9sSTaCAeTqbWqoEXhq1wbT01JeUFDgKO+JKCHxDhm1YbLwPA79miL8tcLx4XQ
 6t3YbqavHseHzxD5lNX1lH2WgKpxpzb+gR3ixffWDGzRzv17itPMXW0Ukn2sDRHWp+qe
 cBeF9+NH8IZqgUq3+Rg7ApzjBncnM4Hq3fAEe1Jte/4UbBMhvdqDyx4G/sr5ZE9OOqRr
 IuqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KL2m0atW+MByUv6kMnNyCu2PrRqSFhE88TBSkVne3g4=;
 b=4qtqgTim4RXbcY2oBdCXRcqE74ElVmbCnVGfHlAvQP6d595odplHQFU6hw9XgvS4iT
 xZX3RC/iahmuIarUJWrVS/TIASEp3zN9pnVdJImWl4QZyLrC3eGIhP0h0kFIRZVkjOLI
 1lyCnRnShAxWHhoW/SP4XS/h5mRB1MQGTctg1D5JDAiLcfdavnrwnExSgpFp3MRI5irF
 7NPMEDP50NnqOiEtX8ByWU04DrkMFWe34G0IrMRZOAexDO64tn3z3wJ+mh7sCZkKfkR3
 mFbLHiNZo+QrSG5/PJ11KEBCftQkJuyAv02bfSXyvE+08hdWR1ypeeleXq6Mn1n45Wv8
 hwGg==
X-Gm-Message-State: AOAM533x8814tbb5/rW+2MrLrtw/tqeB02BZQs0tfd5AkxsiGNbS8rBa
 kpAFfuNfI7Omyg27Pb2DLG4=
X-Google-Smtp-Source: ABdhPJyWhowAQ6wydaGMvlQZlA4N9YwldP5r8sEgUQMxAi5EEVbL8nzqF95qboSgC/QiWNHvCUt+ig==
X-Received: by 2002:a05:6512:238b:: with SMTP id
 c11mr6305581lfv.321.1633223397122; 
 Sat, 02 Oct 2021 18:09:57 -0700 (PDT)
Received: from [192.168.2.145] (94-29-54-195.dynamic.spd-mgts.ru.
 [94.29.54.195])
 by smtp.googlemail.com with ESMTPSA id n22sm1087665lji.139.2021.10.02.18.09.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Oct 2021 18:09:56 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] iommu: Support identity mappings of
 reserved-memory regions
To: Thierry Reding <thierry.reding@gmail.com>, Joerg Roedel
 <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>
References: <20210423163234.3651547-1-thierry.reding@gmail.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <95e4c23e-4700-ef7e-d8ae-17693b65e121@gmail.com>
Date: Sun, 3 Oct 2021 04:09:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210423163234.3651547-1-thierry.reding@gmail.com>
Content-Language: en-US
Cc: devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>
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

MjMuMDQuMjAyMSAxOTozMiwgVGhpZXJyeSBSZWRpbmcg0L/QuNGI0LXRgjoKPiBJJ3ZlIG1hZGUg
Y29ycmVzcG9uZGluZyBjaGFuZ2VzIGluIHRoZSBwcm9wcmlldGFyeSBib290bG9hZGVyLCBhZGRl
ZCBhCj4gY29tcGF0aWJpbGl0eSBzaGltIGluIFUtQm9vdCAod2hpY2ggZm9yd2FyZHMgaW5mb3Jt
YXRpb24gY3JlYXRlZCBieSB0aGUKPiBwcm9wcmlldGFyeSBib290bG9hZGVyIHRvIHRoZSBrZXJu
ZWwpIGFuZCB0aGUgYXR0YWNoZWQgcGF0Y2hlcyB0byB0ZXN0Cj4gdGhpcyBvbiBKZXRzb24gVFgx
LCBKZXRzb24gVFgyIGFuZCBKZXRzb24gQUdYIFhhdmllci4KCkNvdWxkIHlvdSBwbGVhc2UgdGVs
bCB3aGF0IGRvd25zdHJlYW0ga2VybmVsIGRvZXMgZm9yIGNvcGluZyB3aXRoIHRoZQppZGVudGl0
eSBtYXBwaW5ncyBpbiBjb25qdW5jdGlvbiB3aXRoIHRoZSBvcmlnaW5hbCBwcm9wcmlldGFyeSBi
b290bG9hZGVyPwoKSWYgdGhlcmUgaXMgc29tZSBvdGhlciBtZXRob2Qgb2YgcGFzc2luZyBtYXBw
aW5ncyB0byBrZXJuZWwsIGNvdWxkIGl0IGJlCnN1cHBvcnRlZCBieSB1cHN0cmVhbT8gUHV0dGlu
ZyBidXJkZW4gb24gdXNlcnMgdG8gdXBncmFkZSBib290bG9hZGVyCmZlZWxzIGEgYml0IGluY29u
dmVuaWVudC4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
aW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
