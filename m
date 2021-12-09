Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D3CDC433FE
	for <iommu@archiver.kernel.org>; Thu,  9 Dec 2021 14:49:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3C1AC40FE3;
	Thu,  9 Dec 2021 14:49:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u5jAnyIRN16D; Thu,  9 Dec 2021 14:49:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1FAB040FDF;
	Thu,  9 Dec 2021 14:49:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 07A44C002F;
	Thu,  9 Dec 2021 14:49:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8CD74C0012
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 14:49:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6D39884CB8
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 14:49:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ou7NZ_5psVH9 for <iommu@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 14:49:12 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8DCCF84C89
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 14:49:12 +0000 (UTC)
Received: by mail-lf1-x136.google.com with SMTP id m6so615963lfu.1
 for <iommu@lists.linux-foundation.org>; Thu, 09 Dec 2021 06:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=iZsjpEQisLwXWoTUZrMGpEP/rg7ykKTtHEohB5VlKjo=;
 b=N5KjOh0h/gLmW6AEoNGbcGu0XY6tfmxd2fVt19IudyLQZCPO23kvIhHZjj9RgVCzyK
 PFGRZ85o8bF7psna2RyZOBS2hzIbsJYXHYD8AH6ZNCGCEa5mYwmN9FWKuMDxJQqrHXQM
 743HfXGZ9R/aAXXd9IW+jzuB/Jlcmu4Iqe1S3OG+vG1ha27rCfLQJR7BYPCwGaPlg09+
 wuLAjWxSuPZTlb5vZtDbCv2ZCLHgI4mxCRsMsMI11tzS88TP6qnRdT5dtbYtbMW4ff/H
 eZe17X/svYezyTqC/NlXCrsyNNjQynURycwCmoL0GZhAksKqbIxdnr1B9O61yUsShwNU
 rbXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iZsjpEQisLwXWoTUZrMGpEP/rg7ykKTtHEohB5VlKjo=;
 b=7imJXRNwLoI+KUHrotywvwre/d3UYj9kW7y0trRCgr4oOvmIrDmRmcR8Box2oXbUrb
 yTQVGSz18KPWl++4uzZU9rBRvN502ERjkfQ9xkhcAsHEEw1vNqPQgIVdr9qcUrk7D4iC
 R4CRDq3DHhjCHsq5sINs2zE+KZAqCjQVEmtOFVXFmxr/4v17dKdPCsoSoLFowgjSX+YA
 m36USCxQgPMDakGHUROs6pooSFFeSJp4PBm+3zr5P1UzcsjXYDvb8SRoBPHmsZ/MIGoU
 8TF1IZfy/9tR5rkys4+i40Tf0xk0iun4TIKzDzF+Tf02wN1qH56wjNxobRQYMZTWRqsA
 ZF2Q==
X-Gm-Message-State: AOAM533Iu6OY1ehxRSyQ4ThPVfNp8T1y61wtf9+7pq9NeCDuRVaujCiY
 MKEiESc/bGk/vWFwyVEZcGw=
X-Google-Smtp-Source: ABdhPJypck+AA6tuc9nKMOs2vH1DUNXy2B1oE3nA2AC6Mpu9/HK1zrngQhEiSxB38uM0iykfpGgPAA==
X-Received: by 2002:ac2:52b5:: with SMTP id r21mr6236723lfm.127.1639061350601; 
 Thu, 09 Dec 2021 06:49:10 -0800 (PST)
Received: from [192.168.2.145] (94-29-46-111.dynamic.spd-mgts.ru.
 [94.29.46.111])
 by smtp.googlemail.com with ESMTPSA id b6sm1834ljr.103.2021.12.09.06.49.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Dec 2021 06:49:10 -0800 (PST)
Subject: Re: [PATCH v8 6/6] iommu/tegra-smmu: Add pagetable mappings to debugfs
To: Nicolin Chen <nicolinc@nvidia.com>, thierry.reding@gmail.com,
 joro@8bytes.org, will@kernel.org
References: <20211209073822.26728-1-nicolinc@nvidia.com>
 <20211209073822.26728-7-nicolinc@nvidia.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <63b4c2e2-0e55-5701-4c45-70684c7e058e@gmail.com>
Date: Thu, 9 Dec 2021 17:49:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211209073822.26728-7-nicolinc@nvidia.com>
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

MDkuMTIuMjAyMSAxMDozOCwgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4gK3N0YXRpYyB1bnNp
Z25lZCBsb25nIHBkX3B0X2luZGV4X2lvdmEodW5zaWduZWQgaW50IHBkX2luZGV4LCB1bnNpZ25l
ZCBpbnQgcHRfaW5kZXgpCj4gK3sKPiArCXJldHVybiAocGRfaW5kZXggJiAoU01NVV9OVU1fUERF
IC0gMSkpIDw8IFNNTVVfUERFX1NISUZUIHwKPiArCSAgICAgICAocHRfaW5kZXggJiAoU01NVV9O
VU1fUFRFIC0gMSkpIDw8IFNNTVVfUFRFX1NISUZUOwo+ICt9CgpJJ2QgY2hhbmdlIHRoZSByZXR1
cm4gdHlwZSB0byB1MzIgaGVyZSwgZm9yIGNvbnNpc3RlbmN5LgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vaW9tbXU=
