Return-Path: <SRS0=at/m=D5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E792FC388F9
	for <iommu@archiver.kernel.org>; Thu, 22 Oct 2020 21:10:12 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA2E220874
	for <iommu@archiver.kernel.org>; Thu, 22 Oct 2020 21:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kali.org header.i=@kali.org header.b="Cv/UfUS2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA2E220874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kali.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 5881E20396;
	Thu, 22 Oct 2020 21:10:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0KJ0aNpmFjR0; Thu, 22 Oct 2020 21:10:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id EFFD12036E;
	Thu, 22 Oct 2020 21:10:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E10B5C08A1;
	Thu, 22 Oct 2020 21:10:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E490BC0051
 for <iommu@lists.linux-foundation.org>; Thu, 22 Oct 2020 17:21:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id CB9C086B7B
 for <iommu@lists.linux-foundation.org>; Thu, 22 Oct 2020 17:21:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0FLvSmqnaFPy for <iommu@lists.linux-foundation.org>;
 Thu, 22 Oct 2020 17:21:58 +0000 (UTC)
X-Greylist: delayed 00:07:18 by SQLgrey-1.7.6
Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com
 [209.85.167.193])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 604E086B10
 for <iommu@lists.linux-foundation.org>; Thu, 22 Oct 2020 17:21:58 +0000 (UTC)
Received: by mail-oi1-f193.google.com with SMTP id k27so2513667oij.11
 for <iommu@lists.linux-foundation.org>; Thu, 22 Oct 2020 10:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kali.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=WJ8I14wf262ZPiivnyQQ+MbWvOKiYpS8eHcxbP0dKhU=;
 b=Cv/UfUS2m8S022aQfxyLpzkNxoSNuyCiqVOSYEMnDmqJ+bAyotuK5ClUvp+29FFeX4
 8ohCnv1IdAQ/GNFX7aaWVX+JL7JQjTo1Svl5gfjJT0T1hVj73KDoOwJGKoEIB1rZyvo1
 A+DkALDz1k8ys/LNmSOIKG6R2BEj0NkW4zSXwFHbRx2CcB9MiiI5dDBrfFPrTgsjY3Rt
 EEFmwJLK+IoclWuWtP+3aFxj5mjM9sgCcJk/Se2XXybCyIQgwuO3RZO4jdyBWql+/4MG
 1ReSp5+e8sKlC2KNfpjd/kRjS/5Uz+eCPbe4TP8c2kpQPYOf2+CnFEcZsdf880Vil8r2
 EY3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=WJ8I14wf262ZPiivnyQQ+MbWvOKiYpS8eHcxbP0dKhU=;
 b=cL3vY+LSg7lNyb8N0iKn1pHBfKG2uWpcLVyKH1WS4lwi9566hcPKHwWVaTVknptfUY
 b9Vb+kEh8IAEc9A63Vq6OUvH/vkPwquWeCf/fF79Lopx+ViaoZEViAoOzEYL8YaliH3h
 S5TA3yoiwWfnJwEeaokzzEEqWg6uqqgWO7jFjmsC0zOPr/QxsA4W8R3EUltgi8GKBsVs
 Uenhglxm5qAPbrb3WAIHoTo4DcxHUkRbsoToHJIo3OTaLVLUUjwGanSz4l3tMQttt0p6
 j7NSkYFgIDC8gR/ZR2Yj15v4wvPXhLPr/UI9ivaygVm7CvbeGYdQP6Vd0OiRMhYJm8A+
 sFdQ==
X-Gm-Message-State: AOAM532ewPZQAPco8XIf+TzeURbzfYCuWuncAjCGjJKu0VIb+D9LBcMY
 SE9CcBACDRZid/Q0rH6wROQqrXtkX4V/stWO
X-Google-Smtp-Source: ABdhPJzyrldG0EAOpS5mzfx05qjQMb07bP9ln6Ug2CmF2ns8x1lus0gf3gV2Hw+JIM4TWr7SZqRqJg==
X-Received: by 2002:a05:6808:9b8:: with SMTP id
 e24mr2313226oig.97.1603386879819; 
 Thu, 22 Oct 2020 10:14:39 -0700 (PDT)
Received: from Steevs-MBP.hackershack.net (cpe-173-175-113-3.satx.res.rr.com.
 [173.175.113.3])
 by smtp.gmail.com with ESMTPSA id t84sm589024oih.35.2020.10.22.10.14.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2020 10:14:39 -0700 (PDT)
Subject: Re: [PATCH v5 0/3] iommu/arm-smmu-qcom: Support maintaining
 bootloader mappings
To: Bjorn Andersson <bjorn.andersson@linaro.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>,
 Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Jordan Crouse <jcrouse@codeaurora.org>, Thierry Reding <treding@nvidia.com>,
 Rob Clark <robdclark@chromium.org>
References: <20201019182323.3162386-1-bjorn.andersson@linaro.org>
From: Steev Klimaszewski <steev@kali.org>
Message-ID: <fc462189-d5de-bb8d-31b5-6fb87a6edbdb@kali.org>
Date: Thu, 22 Oct 2020 12:14:38 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201019182323.3162386-1-bjorn.andersson@linaro.org>
Content-Language: en-US
X-Mailman-Approved-At: Thu, 22 Oct 2020 21:10:08 +0000
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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


On 10/19/20 1:23 PM, Bjorn Andersson wrote:
> This is the revised fourth attempt of inheriting the stream mapping for
> the framebuffer on many Qualcomm platforms, in order to not hit
> catastrophic faults during arm-smmu initialization.
>
> The new approach does, based on Robin's suggestion, take a much more
> direct approach with the allocation of a context bank for bypass
> emulation and use of this context bank pretty much isolated to the
> Qualcomm specific implementation.
>
> The patchset has been tested to boot DB845c and RB5 (with splash screen)
> and Lenovo Yoga C630 (with EFI framebuffer).
>
> Bjorn Andersson (3):
>   iommu/arm-smmu: Allow implementation specific write_s2cr
>   iommu/arm-smmu-qcom: Read back stream mappings
>   iommu/arm-smmu-qcom: Implement S2CR quirk
>
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 90 ++++++++++++++++++++++
>  drivers/iommu/arm/arm-smmu/arm-smmu.c      | 13 +++-
>  drivers/iommu/arm/arm-smmu/arm-smmu.h      |  1 +
>  3 files changed, 101 insertions(+), 3 deletions(-)
>
Tested series here on my Lenovo C630.

Tested-by: Steev Klimaszewski <steev@kali.org>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
