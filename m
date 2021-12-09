Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABBDEC433FE
	for <iommu@archiver.kernel.org>; Thu,  9 Dec 2021 14:47:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 29C1C61239;
	Thu,  9 Dec 2021 14:47:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uYJWp0IpvYPM; Thu,  9 Dec 2021 14:47:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D54EF61230;
	Thu,  9 Dec 2021 14:47:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 890CAC002F;
	Thu,  9 Dec 2021 14:47:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 372ADC0012
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 14:47:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0FC1F40FDA
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 14:47:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xayIInJ7j57c for <iommu@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 14:47:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2E19D40FD8
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 14:47:22 +0000 (UTC)
Received: by mail-lf1-x136.google.com with SMTP id t26so12396885lfk.9
 for <iommu@lists.linux-foundation.org>; Thu, 09 Dec 2021 06:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=FB6FkU9Ub0Mnerpu4sSrMAvDQxD5IPFH9I0yMO2mX38=;
 b=ieFcHWWy/CcJtGSE1jtUOV3ItL81dg7fmRKEZi7xPPzBFVY37Mp6ZMUpOsyem/Wa1L
 4D4U4oVgSexf+ACjuCpwQ0Qmnznp/8q0+kK3x7FxotxnrxQh/StEHGke17yfozYMT1Mo
 EAe2tFhpaaQErTzUjYC3d/SKpxXlk0bVlyrACaLWq9/F3p4kdjzpUmoYV6BtL10B1yjF
 /EHLqO0jr8eiFFMv+SA4FPnh8uKHXom8x2dMpWb73xsOxfqo6kV/QEczMhUhV3AoJ2jz
 G5XfUKQOKCl5auzTYHyvPYZcYHbw371aVIIDtmGmF+CASWk+4wudcSV5wduxw162QWQq
 RJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FB6FkU9Ub0Mnerpu4sSrMAvDQxD5IPFH9I0yMO2mX38=;
 b=C8mlFuM3hzz/82JAu5p96y9P4khOOwSUE30toPxAAOthEuryI6UYxzkxK84IV8OT/X
 sHLt7/+K6xkSK49wnaBz1vozaC0tQmlnO6Uk/1Sif+87FUa0FjOIE3jFqQm93XRqk8AU
 KZ/5PIa592UrxK+TtdBD+1QargIQ53jJLZNd5ytTEkoTHy+blwRgTnp2NoIP81ZPa54r
 lSDnIgbs2+a+uOArtpl270ojXJF/RljET/SNVb3b5DYkheBAYbyPQWnXHn7QcgOw5H+F
 1sZJkoJNn7deCASOYbr783gSdemY1UEzIVmyfjSYK7L/7DyU/+szQ55gI6/sTanzlCbz
 Q5ZA==
X-Gm-Message-State: AOAM531leLXRRtwHjNLymUN0x3nxnGFEgilLy0jPkcyMS18P8DCaNQVH
 djwNz65idfjrNnsbLPgUlR4=
X-Google-Smtp-Source: ABdhPJwDEOi37hF+qJvO27fOFsc4jz56KQd1J7cFcn4v7akIUINwKPqpT4s1QxBIu4a9QLxlC8Z74g==
X-Received: by 2002:a05:6512:31d1:: with SMTP id
 j17mr6262758lfe.395.1639061240018; 
 Thu, 09 Dec 2021 06:47:20 -0800 (PST)
Received: from [192.168.2.145] (94-29-46-111.dynamic.spd-mgts.ru.
 [94.29.46.111])
 by smtp.googlemail.com with ESMTPSA id c25sm3292lja.38.2021.12.09.06.47.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Dec 2021 06:47:19 -0800 (PST)
Subject: Re: [PATCH v8 6/6] iommu/tegra-smmu: Add pagetable mappings to debugfs
To: Nicolin Chen <nicolinc@nvidia.com>, thierry.reding@gmail.com,
 joro@8bytes.org, will@kernel.org
References: <20211209073822.26728-1-nicolinc@nvidia.com>
 <20211209073822.26728-7-nicolinc@nvidia.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <5713902d-823b-63ca-00c9-aa6c64c1af41@gmail.com>
Date: Thu, 9 Dec 2021 17:47:18 +0300
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

MDkuMTIuMjAyMSAxMDozOCwgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4gQEAgLTU0NSw2ICs3
MTksMTUgQEAgc3RhdGljIHZvaWQgdGVncmFfc21tdV9kZXRhY2hfYXMoc3RydWN0IHRlZ3JhX3Nt
bXUgKnNtbXUsCj4gIAkJaWYgKGdyb3VwLT5zd2dycCAhPSBzd2dycCkKPiAgCQkJY29udGludWU7
Cj4gIAkJZ3JvdXAtPmFzID0gTlVMTDsKPiArCj4gKwkJaWYgKHNtbXUtPmRlYnVnZnNfbWFwcGlu
Z3MpIHsKCkRvIHdlIHJlYWxseSBuZWVkIHRoaXMgY2hlY2s/CgpMb29rcyBsaWtlIGFsbCBkZWJ1
Z2ZzX2NyZWF0ZV9kaXIoKSB1c2FnZXMgaW4gdGhpcyBkcml2ZXIgYXJlIGluY29ycmVjdCwKdGhh
dCBmdW5jdGlvbiBuZXZlciByZXR1cm5zIE5VTEwuIFBsZWFzZSBmaXggdGhpcy4KCj4gKwkJCXN0
cnVjdCBkZW50cnkgKmQ7CgpUaGUgZmlsZSBuYW1lIGlzIHdyb25nIGhlcmUuCgoJCQlpZiAoZ3Jv
dXAtPnNvYykKCQkJCW5hbWUgPSBncm91cC0+c29jLT5uYW1lOwoJCQllbHNlCgkJCQluYW1lID0g
Z3JvdXAtPnN3Z3JwLT5uYW1lOwoKPiArCQkJZCA9IGRlYnVnZnNfbG9va3VwKGdyb3VwLT5zd2dy
cC0+bmFtZSwKPiArCQkJCQkgICBzbW11LT5kZWJ1Z2ZzX21hcHBpbmdzKTsKPiArCQkJZGVidWdm
c19yZW1vdmUoZCk7Cj4gKwkJfQoKVGhpcyBub3cgbG9va3MgcHJvYmxlbWF0aWMgdG8gbWUuIFlv
dSBjcmVhdGVkIGRlYnVnZnMgZmlsZSB3aGVuIHRoZQpmaXJzdCBtZW1iZXIgb2YgdGhlIHNoYXJl
ZCBncm91cCB3YXMgYXR0YWNoZWQgdG8gQVMsIG5vdyB5b3UgcmVtb3ZlIHRoaXMKZmlsZSB3aGVu
IGFueSBkZXZpY2UgaXMgZGV0YWNoZWQuIFRoZSBzaGFyZWQgZGVidWdmcyBmaWxlIHNob3VsZCBi
ZQpyZWZjb3VudGVkIG9yIHNvbWV0aGluZy4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2lvbW11
