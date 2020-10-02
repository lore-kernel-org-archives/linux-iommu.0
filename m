Return-Path: <SRS0=Fz8+=DJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2582C4363D
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 16:00:50 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 244DE206FA
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 16:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXu+ildL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 244DE206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 97DEB20031;
	Fri,  2 Oct 2020 16:00:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mEgRGhxdjuyI; Fri,  2 Oct 2020 16:00:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 1D7F32035E;
	Fri,  2 Oct 2020 16:00:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 03F73C0889;
	Fri,  2 Oct 2020 16:00:45 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CECE2C0051
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 16:00:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id B4705866A9
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 16:00:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k6_719UnNFsl for <iommu@lists.linux-foundation.org>;
 Fri,  2 Oct 2020 16:00:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com
 [209.85.167.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id B6DA586670
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 16:00:42 +0000 (UTC)
Received: by mail-lf1-f67.google.com with SMTP id y17so2464803lfa.8
 for <iommu@lists.linux-foundation.org>; Fri, 02 Oct 2020 09:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=dhAnoeBmyK6BcDynuK2zNHQZ6hj5tN6P0kpEIveLp7o=;
 b=nXu+ildLgsM+jM4sHHMNh0wFhYRfaWZHOdLXwZqCOlY2OZHI/Dm+eJ5/CYCwVG1kkO
 cYSVGx++koKfLEFTUKyzRiMc+I8PK8AwieXpXgVRMlQHzCa5lCkhFsoQxv5diGNFmGqv
 YQkcDhpNom+wSzGwwuK82ux7g/5CY91Qr5RqOnplESiTEiNxOMpJKrOL3f1UNoXrBugh
 U09J6ogbQmK6SB66V7OVywERPMovoTvsJtKO+1qpBcWqNktXct1E5MGwp34pb3aRn1HU
 3N1S99scbj3lx0gLgLSrk2SgXvoYVTEGwSWhvRSIdkgKqo6seBUJKg4Ws908X5hHR2y7
 ZEpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dhAnoeBmyK6BcDynuK2zNHQZ6hj5tN6P0kpEIveLp7o=;
 b=bwp/0+g7I2ieObZraB3OjUksP8qzGRQQA3MGjXunCcMP+nUa3dtV60Xwm0OBWJt03Y
 swaa+46IL0Eyaeo9GcfhshctatQ9+LX6xd2y94hnLuX52Bzfx9kArDOdqe9sp0K3tEjw
 /IjCqPxECu8fBHXVM83VxmozchbZpN/KD/VXkxN5QmeqvBx+moQ6JmEhwzI2JXseHPDs
 B6E6S0FaXc3RexTOV/la+xobQtxP7POyWbyq7r1CLZngDOVJtBh54W+fHuZ8ibDaiEUh
 sQTnajeLHhhR142FTO0jpd09Af9fjPUS2y4KRxAk935B64Kha41u7SVF5tUFBU4bi/iy
 ADkg==
X-Gm-Message-State: AOAM533V9KbqNlJf7TC+yZQuihY9Kc3rnsHed7vmDAc4YTtq27YWKlk1
 0/0mznLpgIoom88BnrC4UIQ=
X-Google-Smtp-Source: ABdhPJyKXMN6R1NYll2+WowzuwnckGYlpVU9Os1T9IYfDnZEzGs+9eU0RcBb7JTcu3S3Hz75KsG2+w==
X-Received: by 2002:ac2:5e2b:: with SMTP id o11mr1137547lfg.24.1601654441028; 
 Fri, 02 Oct 2020 09:00:41 -0700 (PDT)
Received: from [192.168.2.145] (109-252-91-252.nat.spd-mgts.ru.
 [109.252.91.252])
 by smtp.googlemail.com with ESMTPSA id x15sm276743ljd.93.2020.10.02.09.00.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2020 09:00:40 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] iommu/tegra-smmu: Rework tegra_smmu_probe_device()
From: Dmitry Osipenko <digetx@gmail.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>, thierry.reding@gmail.com,
 joro@8bytes.org, Maxime Ripard <maxime@cerno.tech>
References: <20201002060807.32138-1-nicoleotsuka@gmail.com>
 <20201002060807.32138-3-nicoleotsuka@gmail.com>
 <99d322d0-efb5-8a34-ee83-b907b785ced3@gmail.com>
Message-ID: <3ecfe9ae-fa32-8384-c912-4e17ff5fede7@gmail.com>
Date: Fri, 2 Oct 2020 19:00:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <99d322d0-efb5-8a34-ee83-b907b785ced3@gmail.com>
Content-Language: en-US
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, jonathanh@nvidia.com
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

MDIuMTAuMjAyMCAxODoyMywgRG1pdHJ5IE9zaXBlbmtvINC/0LjRiNC10YI6Cj4gMDIuMTAuMjAy
MCAwOTowOCwgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4+IFRoZW4gd2hlbiBhIGNsaWVudCBn
ZXRzIHByb2JlZCwgb2ZfaW9tbXVfY29uZmlndXJlKCkgaW4KPj4gaW9tbXUgY29yZSB3aWxsIHNl
YXJjaCBEVEIgZm9yIHN3Z3JvdXAgSUQgYW5kIGNhbGwgLT5vZl94bGF0ZSgpCj4+IHRvIHByZXBh
cmUgYW4gZndzcGVjLCBzaW1pbGFyIHRvIHRlZ3JhX3NtbXVfcHJvYmVfZGV2aWNlKCkgYW5kCj4+
IHRlZ3JhX3NtbXVfY29uZmlndXJlKCkuIFRoZW4gaXQnbGwgY2FsbCB0ZWdyYV9zbW11X3Byb2Jl
X2RldmljZSgpCj4+IGFnYWluLCBhbmQgdGhpcyB0aW1lIHdlIHNoYWxsIHJldHVybiBzbW11LT5p
b21tdSBwb2ludGVyIHByb3Blcmx5Lgo+IAo+IEkgZG9uJ3QgcXVpdGUgc2VlIHdoZXJlIElPTU1V
IGNvcmUgY2FsbHMgb2ZfeGxhdGUoKS4KPiAKPiBIYXZlIHRyaWVkIHRvIGF0IGxlYXN0IGJvb3Qt
dGVzdCB0aGlzIHBhdGNoPwo+IAoKSSBkb24ndCBzZWUgaG93IGl0IGV2ZXIgY291bGQgd29yayBi
ZWNhdXNlIG9mX3hsYXRlKCkgaXMgb25seSBpbnZva2VkIGZyb206Cgpmc2xfbWNfZG1hX2NvbmZp
Z3VyZSgpLT5vZl9kbWFfY29uZmlndXJlX2lkKCktPm9mX2lvbW11X2NvbmZpZ3VyZSgpCgpMb29r
cyBsaWtlIHRoZSB0ZWdyYV9zbW11X2NvbmZpZ3VyZSgpIGlzIHN0aWxsIG5lZWRlZC4KCkkgZG9u
J3Qga25vdyBob3cgc3VuNTBpIGRyaXZlciBjb3VsZCB3b3JrIHRvIGJlIGhvbmVzdC4gU2VlbXMg
SU9NTVUgaXMKYnJva2VuIG9uIHN1bjUwaSwgYnV0IG1heWJlIEknbSBtaXNzaW5nIHNvbWV0aGlu
Zy4KCkkgYWRkZWQgTWF4aW1lIFJpcGFyZCB0byB0aGlzIHRocmVhZCwgd2hvIGlzIHRoZSBhdXRo
b3Igb2YgdGhlCnN1bjUwaS1pb21tdSBkcml2ZXIuCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby9pb21tdQ==
