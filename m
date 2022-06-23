Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF31C43334
	for <iommu@archiver.kernel.org>; Thu, 23 Jun 2022 12:21:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7DEBC84750;
	Thu, 23 Jun 2022 12:21:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7DEBC84750
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=gaobzrSr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6v3mip436fH3; Thu, 23 Jun 2022 12:21:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4AC578474E;
	Thu, 23 Jun 2022 12:21:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4AC578474E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 23FF8C0032;
	Thu, 23 Jun 2022 12:21:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 499D6C002D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 12:21:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0B9E660AEF
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 12:21:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0B9E660AEF
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=gaobzrSr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A8KREvRjDQTv for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 12:21:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C614E60AE5
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C614E60AE5
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 12:21:33 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id mf9so20353795ejb.0
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 05:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=CF10f0ecvbdInB3GUcNTSF1y8JSwtBGEciNW4EE0dK8=;
 b=gaobzrSrpC2xdZDpleiXlNd2FBo6JR22uQbVkvpXYWYKegwMJRX7PeS5ODpj1VGlY3
 6xtpPUBemnAyYVKj2RJLiO2gngBiXqVNOpnw73OoOOEJutz1ztO1yZLvyPs4Q1H0de98
 0L5dcSkYjkqW4d6yKDRjIqji7NsI08pw7ZaVLftegLv7WcNrfZND1ShPARO22RpFZQv4
 VUI5Rrr3sHE8kV5/SVrim6kvUL2D0QOcsvzyVCFuyA/8PRkrg8+F85hlcErTOzzyoAZw
 3+lLBc1mx1UdY1GeLQ+5tdJ/7veyAGgtEYXzPisiFxVkGMKa5P5PzDqgUSdGXLKFcopp
 dNMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=CF10f0ecvbdInB3GUcNTSF1y8JSwtBGEciNW4EE0dK8=;
 b=uH8I0NLbjISTcgg/ldgS/c4ToJ33+tz7d7LaFwohRSIPer/QUhr/Wqigkwru7IR4Lw
 VXUuKwg+9XFPY6OxUO/vQoacPwjentIweL4Afjj5a1PDwhhRagl5q6tBw80IZyhuyfqP
 N6OwotaQmQbjlMkgBFSkXqXWkcFyyqWl3AD3ZonkF58FDsGUFHZszcLGEbAgs58t+THM
 2voyjYp8vDYCJQuhnRowikBcmR3QXOJsw0z6loaq2bpFkxewoERDjX+gJRCMAvzF/lSx
 SV0PwOvlxq6uMOZom6TircvQfIVGVsKGgcqsV59sO9l0CG8JxWaeoUcr34/U6KpXIM6u
 0LUA==
X-Gm-Message-State: AJIora8INAfKw273bidy7ZMqlovw+9Poe6gcGnoVgBfQgnRV2S9exP9d
 Gy6fpFwsEeSOC1jeDfa9F8gn8A==
X-Google-Smtp-Source: AGRyM1t2pNvOPxF7Q5oGostXduXnge+3FBXoXKQdcE70QOKBIqRxava7lid7GUXIOAiCUXIfV2jFDw==
X-Received: by 2002:a17:907:3e92:b0:711:d26c:f91 with SMTP id
 hs18-20020a1709073e9200b00711d26c0f91mr7643642ejc.283.1655986891856; 
 Thu, 23 Jun 2022 05:21:31 -0700 (PDT)
Received: from [192.168.0.230] (xdsl-188-155-176-92.adslplus.ch.
 [188.155.176.92]) by smtp.gmail.com with ESMTPSA id
 a14-20020a170906368e00b00705f6dab05bsm10715789ejc.183.2022.06.23.05.21.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jun 2022 05:21:31 -0700 (PDT)
Message-ID: <b45c6b1f-4e2f-ddec-f1e4-8e183d01ea9f@linaro.org>
Date: Thu, 23 Jun 2022 14:21:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] iommu/exynos: Make driver independent of the system page
 size
Content-Language: en-US
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org
References: <CGME20220623093641eucas1p11732bf2c875960f7a2bb1d6fe053bc81@eucas1p1.samsung.com>
 <20220623093629.32178-1-m.szyprowski@samsung.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220623093629.32178-1-m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 23/06/2022 11:36, Marek Szyprowski wrote:
> PAGE_{SIZE,SHIFT} macros depend on the configured kernel's page size, but
> the driver expects values calculated as for 4KB pages. Fix this.
> 
> Reported-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> Untested, because Exynos based boards I have doesn't boot with non-4KB
> page size for other reasons.
> ---
>  drivers/iommu/exynos-iommu.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
