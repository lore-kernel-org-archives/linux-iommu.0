Return-Path: <SRS0=X4VR=IJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BCCC433E0
	for <iommu@archiver.kernel.org>; Thu, 11 Mar 2021 14:04:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58D4164FAD
	for <iommu@archiver.kernel.org>; Thu, 11 Mar 2021 14:04:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58D4164FAD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E72574ECA2;
	Thu, 11 Mar 2021 14:04:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GqTCk6_GRp86; Thu, 11 Mar 2021 14:04:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id AED854EBF6;
	Thu, 11 Mar 2021 14:04:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 910EBC000C;
	Thu, 11 Mar 2021 14:04:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B6AB1C000A
 for <iommu@lists.linux-foundation.org>; Thu, 11 Mar 2021 14:04:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 97E466F902
 for <iommu@lists.linux-foundation.org>; Thu, 11 Mar 2021 14:04:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wcJ7pWDKvpJS for <iommu@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 14:04:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DBFF96F919
 for <iommu@lists.linux-foundation.org>; Thu, 11 Mar 2021 14:04:09 +0000 (UTC)
Received: by mail-lf1-x12e.google.com with SMTP id v2so26915482lft.9
 for <iommu@lists.linux-foundation.org>; Thu, 11 Mar 2021 06:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=2UesuILRMkJp+y650j/Dw0uM34OpGLZWWhm2dKKedNQ=;
 b=UFMbxZOZED8Bchitddb1CJ9fL8l6YKL401dy/6N1Dthp5O4IhZrywTARWyMH45gIVY
 gODDAX1amriEQ1Nc6fSZucwE/+mrrbB+WMgB4MRoR3Nw7hqwKxjzSJNkZjpd5r1aXAD8
 27wC+1wXaLvCmByvmDVxeNHbA4owoWM2WGaTvoXhEjQEHuMWPP2slX4lcev3qUIrbhqx
 EiF3UO1ItI5qXrvXEFer7O3vCn1AIDgKnwPEQysbhoyURPqZJnxS7uAF/9oHy0z5NAeu
 czkRcDVdXnOKWhuwFVhZ2mnOAefIOeBosT7n7PQ2e2l/ddtAwgDujEAbI+Z8KH6yJ4jf
 HgfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2UesuILRMkJp+y650j/Dw0uM34OpGLZWWhm2dKKedNQ=;
 b=PWIL65Y4VtS4r9GyJHsm8WOz/Lv7ssubrbLz3gHdME+ONv1QF/iIrhkiyoVv/e9H4t
 /tRR99ciWVQmu9JqXV+PM9c/mxk9XM5XWYhigkj5E4vYQHWoJSLzuUchGxR6aGZ5MUz9
 jS0M9ufV9XI1ggXJ157tG0RyDqAIePNLemj2mbnw71oLba7SVsow+k7yBKIFQFiC06qz
 SF9L9o1iik2NL6psvr0+u+QhccHSlg3+l/VKkSjDQfaOGj0QykoR/eTQoBXJ806FbGdJ
 67hWzscqfSaFbOLtfep3H0Iq6CJFruZ8a7w0bMtPtmRyCzgcu6w0t3Z35NzCM9qdbSAa
 MB/w==
X-Gm-Message-State: AOAM533pZIsoKFwQiBz3MRz/AZrAc4+jpFqdDsp6gLw4rTPcZHebfsaj
 RWquhMKrY28zb3euzGiOhJc=
X-Google-Smtp-Source: ABdhPJx7rWrfxe+wQBUJ1aOKDv4Dtqhyz/wJAmnzjCKqA/kXqTJLW+hcKBUSEJmdM9Lg0gtq6AvdHQ==
X-Received: by 2002:a05:6512:405:: with SMTP id
 u5mr2307855lfk.574.1615471447614; 
 Thu, 11 Mar 2021 06:04:07 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-52.dynamic.spd-mgts.ru.
 [109.252.193.52])
 by smtp.googlemail.com with ESMTPSA id f8sm874153lfs.143.2021.03.11.06.04.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Mar 2021 06:04:07 -0800 (PST)
Subject: Re: [PATCH v2] iommu/tegra-smmu: Add pagetable mappings to debugfs
To: Nicolin Chen <nicoleotsuka@gmail.com>, joro@8bytes.org,
 thierry.reding@gmail.com, will@kernel.org
References: <20210310033614.16772-1-nicoleotsuka@gmail.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <abcedfa6-fbad-b34d-fba1-d3a778fbf5b4@gmail.com>
Date: Thu, 11 Mar 2021 17:04:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20210310033614.16772-1-nicoleotsuka@gmail.com>
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

MTAuMDMuMjAyMSAwNjozNiwgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Ci4uLgo+ICtzdGF0aWMg
aW50IHRlZ3JhX3NtbXVfbWFwcGluZ3Nfc2hvdyhzdHJ1Y3Qgc2VxX2ZpbGUgKnMsIHZvaWQgKmRh
dGEpCj4gK3sKPiArCXN0cnVjdCB0ZWdyYV9zbW11X2dyb3VwX2RlYnVnICpncm91cF9kZWJ1ZyA9
IHMtPnByaXZhdGU7Cj4gKwljb25zdCBzdHJ1Y3QgdGVncmFfc21tdV9zd2dyb3VwICpncm91cDsK
PiArCXN0cnVjdCB0ZWdyYV9zbW11X2FzICphczsKPiArCXN0cnVjdCB0ZWdyYV9zbW11ICpzbW11
Owo+ICsJaW50IHBkX2luZGV4LCBwdF9pbmRleDsKCj4gK0RFRklORV9TSE9XX0FUVFJJQlVURSh0
ZWdyYV9zbW11X21hcHBpbmdzKTsKPiArCj4gIHN0YXRpYyB2b2lkIHRlZ3JhX3NtbXVfZGVidWdm
c19pbml0KHN0cnVjdCB0ZWdyYV9zbW11ICpzbW11KQo+ICB7Cj4gKwljb25zdCBzdHJ1Y3QgdGVn
cmFfc21tdV9zb2MgKnNvYyA9IHNtbXUtPnNvYzsKPiArCXN0cnVjdCB0ZWdyYV9zbW11X2dyb3Vw
X2RlYnVnICpncm91cF9kZWJ1ZzsKPiArCXN0cnVjdCBkZXZpY2UgKmRldiA9IHNtbXUtPmRldjsK
PiArCXN0cnVjdCBkZW50cnkgKmQ7Cj4gKwlpbnQgaTsKCllvdSBzaG91bGQgdXNlIHVuc2lnbmVk
IHR5cGVzIGZvciBldmVyeXRoaW5nIHRoYXQgaXNuJ3Qgc2lnbmVkLgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVA
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
