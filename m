Return-Path: <SRS0=l9dJ=DG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9062C4727C
	for <iommu@archiver.kernel.org>; Tue, 29 Sep 2020 17:41:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B89821974
	for <iommu@archiver.kernel.org>; Tue, 29 Sep 2020 17:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTNWEu8S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B89821974
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 84C908664C;
	Tue, 29 Sep 2020 17:41:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CbdwuqkZ5A30; Tue, 29 Sep 2020 17:41:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 74E7885B6F;
	Tue, 29 Sep 2020 17:41:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F50AC0890;
	Tue, 29 Sep 2020 17:41:56 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D4044C016F
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 17:41:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 951162043B
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 17:41:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SmX1f7SE5obY for <iommu@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 17:41:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com
 [209.85.208.196])
 by silver.osuosl.org (Postfix) with ESMTPS id 449D62040B
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 17:41:53 +0000 (UTC)
Received: by mail-lj1-f196.google.com with SMTP id w3so4725051ljo.5
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 10:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ymf5DYD10J/gVTCAgJb77WubJ0BcbD1SvX37zhc4xHQ=;
 b=UTNWEu8SbvBNm+yTMk4E/UBIu63yOeKo7iE/cZdxuQS8KVZ3Q8fmCHpA2lFIltSDM5
 TIQs/0w4di/n+3R2+zuKEf2NR4Af/gAGbSzUbRr7QXg/9U/m5CV7x6QOJdltuNDtNMkP
 fSKpLY32uiQ8KngfUD3rHRwoBscvlORD5fu2qid+pfubqIezgvfVhenTb3NBfCEbaZY7
 RaMrpPH3loaAlvNQcMtknj1jsUzewl93Cn3Y283ufDGHWHufGkF72MtYhhvQ8OkY4Kwc
 lA2FE/V6ewd+Rl8pN+CIcvH0M11byZ4ggpfI8DSgxjghVYDspQXB6O/DvDQUmbIezxN6
 1C9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ymf5DYD10J/gVTCAgJb77WubJ0BcbD1SvX37zhc4xHQ=;
 b=ZB62RK1bSaPUhXEUp7dsB6wJH5d8NpUrSpRufGKeIdC1fcJHwlID5m6D2g7HVDQLjK
 Eb6I5N9Un02Tn2eNNUdVGdO2+EqXokN8dgspHO7/wFk5r+Qb4uh3pNBvdY+DRvnPKtzK
 STvfyafc+t8VbNgU/Dm8nZyPyIvjrKEwKnXHFaWzJO1XI1WU00WCvQZ9rl8yvnH+reWL
 YGj6UYpVTUOpG+jBvJ4gN6pDFUzr/aYbLfHAluRYqjOhCQ8UZQ8w6URspSGCJTWHQxRx
 yzCHW3BZXDzsetcwOTDqRqXhOLmCgmPcOCbLIDKI7Y1u5tlYckyf5j34pkVHSk1vrc5G
 xh/A==
X-Gm-Message-State: AOAM5315PRZbfz695pdDs7kaNfRqBg1e3sMfFeY4XyVaYSm1WFIyDYlr
 +298AFVF66fd+PncU2DuDhs=
X-Google-Smtp-Source: ABdhPJxgxZwr/emgReyZHJBvOhNw6KNXbB6nWSbYq1wE+ONV0NzfQv3hgDwYmnZeLzriu75KYzgu4w==
X-Received: by 2002:a2e:889a:: with SMTP id k26mr1457792lji.214.1601401311318; 
 Tue, 29 Sep 2020 10:41:51 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru.
 [109.252.170.211])
 by smtp.googlemail.com with ESMTPSA id o17sm3170303lfi.261.2020.09.29.10.41.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2020 10:41:50 -0700 (PDT)
Subject: Re: [PATCH v4 1/2] iommu/tegra-smmu: Unwrap tegra_smmu_group_get
To: Nicolin Chen <nicoleotsuka@gmail.com>, thierry.reding@gmail.com,
 joro@8bytes.org
References: <20200929061325.10197-1-nicoleotsuka@gmail.com>
 <20200929061325.10197-2-nicoleotsuka@gmail.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <35d789ae-7deb-7f8c-0556-98fe73f5999f@gmail.com>
Date: Tue, 29 Sep 2020 20:41:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200929061325.10197-2-nicoleotsuka@gmail.com>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jonathanh@nvidia.com, hch@infradead.org, linux-tegra@vger.kernel.org
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

MjkuMDkuMjAyMCAwOToxMywgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4gVGhlIHRlZ3JhX3Nt
bXVfZ3JvdXBfZ2V0IHdhcyBhZGRlZCB0byBncm91cCBkZXZpY2VzIGluIGRpZmZlcmVudAo+IFNX
R1JPVVBzIGFuZCBpdCdkIHJldHVybiBhIE5VTEwgZ3JvdXAgcG9pbnRlciB1cG9uIGEgbWlzbWF0
Y2ggYXQKPiB0ZWdyYV9zbW11X2ZpbmRfZ3JvdXAoKSwgc28gZm9yIG1vc3Qgb2YgY2xpZW50cy9k
ZXZpY2VzLCBpdCB2ZXJ5Cj4gbGlrZWx5IHdvdWxkIG1pc21hdGNoIGFuZCBuZWVkIGEgZmFsbGJh
Y2sgZ2VuZXJpY19kZXZpY2VfZ3JvdXAoKS4KPiAKPiBCdXQgbm93IHRlZ3JhX3NtbXVfZ3JvdXBf
Z2V0IGhhbmRsZXMgZGV2aWNlcyBpbiBzYW1lIFNXR1JPVVAgdG9vLAo+IHdoaWNoIG1lYW5zIHRo
YXQgaXQgd291bGQgYWxsb2NhdGUgYSBncm91cCBmb3IgZXZlcnkgbmV3IFNXR1JPVVAKPiBvciB3
b3VsZCBkaXJlY3RseSByZXR1cm4gYW4gZXhpc3Rpbmcgb25lIHVwb24gbWF0Y2hpbmcgYSBTV0dS
T1VQLAo+IGkuZS4gYW55IGRldmljZSB3aWxsIGdvIHRocm91Z2ggdGhpcyBmdW5jdGlvbi4KPiAK
PiBTbyBwb3NzaWJpbGl0eSBvZiBoYXZpbmcgYSBOVUxMIGdyb3VwIHBvaW50ZXIgaW4gZGV2aWNl
X2dyb3VwKCkKPiBpcyB1cG9uIGZhaWx1cmUgb2YgZWl0aGVyIGRldm1fa3phbGxvYygpIG9yIGlv
bW11X2dyb3VwX2FsbG9jKCkuCj4gSW4gZWl0aGVyIGNhc2UsIGNhbGxpbmcgZ2VuZXJpY19kZXZp
Y2VfZ3JvdXAoKSBubyBsb25nZXIgbWFrZXMgYQo+IHNlbnNlLiBFc3BlY2lhbGx5IGZvciBkZXZt
X2t6YWxsb2MoKSBmYWlsaW5nIGNhc2UsIGl0J2QgY2F1c2UgYQo+IHByb2JsZW0gaWYgaXQgZmFp
bHMgYXQgZGV2bV9remFsbG9jKCkgeWV0IHN1Y2NlZWRzIGF0IGEgZmFsbGJhY2sKPiBnZW5lcmlj
X2RldmljZV9ncm91cCgpLCBiZWNhdXNlIGl0IGRvZXMgbm90IGNyZWF0ZSBhIGdyb3VwLT5saXN0
Cj4gZm9yIG90aGVyIGRldmljZXMgdG8gbWF0Y2guCj4gCj4gVGhpcyBwYXRjaCBzaW1wbHkgdW53
cmFwcyB0aGUgZnVuY3Rpb24gdG8gY2xlYW4gaXQgdXAuCj4gCj4gU2lnbmVkLW9mZi1ieTogTmlj
b2xpbiBDaGVuIDxuaWNvbGVvdHN1a2FAZ21haWwuY29tPgo+IC0tLQoKUmV2aWV3ZWQtYnk6IERt
aXRyeSBPc2lwZW5rbyA8ZGlnZXR4QGdtYWlsLmNvbT4KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby9pb21tdQ==
