Return-Path: <SRS0=mVMG=CN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96337C433E2
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 14:56:58 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6045A2074D
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 14:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WGIFCYDT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6045A2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2B3332E1AB;
	Fri,  4 Sep 2020 14:56:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3+dUuLotg+CR; Fri,  4 Sep 2020 14:56:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 590E920392;
	Fri,  4 Sep 2020 14:56:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 51B8CC07FF;
	Fri,  4 Sep 2020 14:56:56 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14458C0051
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 14:56:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0392686EB4
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 14:56:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Kh2q6p3LNGx0 for <iommu@lists.linux-foundation.org>;
 Fri,  4 Sep 2020 14:56:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com
 [209.85.167.194])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id BA0D886EAA
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 14:56:53 +0000 (UTC)
Received: by mail-oi1-f194.google.com with SMTP id t76so6748133oif.7
 for <iommu@lists.linux-foundation.org>; Fri, 04 Sep 2020 07:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=0Mo/v5jxgawkurDBpjpN2qi+oLCVBtcMh+QdJRmGmC4=;
 b=WGIFCYDT8CRCtQ34wHex6hXCDluurGCJa3w4AkzyVk0GXJbLwESX/5XbuXcKjvT8N3
 av8bx1MeV/SaQN+ZOlb7qFWHSI0qxIXOkGH5oAomvp176LzBk8EwBco/K4xJ7N2CHPvR
 l78X98kfSWzS8Mb+xbWd6PX4EU1Ln8VoLwUxQRBOuoDb+KsPgPhaT2HK/0FXY5U770sS
 6GEYCWpoUOHwuTVuvcH4H889ef2zYwaFB7ECFgOsJyCSm11Y35uB+UuJxRvdPhqgY6aE
 h5yInJeIAddXfopuwpA+YFS/6Bw6EFCl03h80cqH+/6l3/v+4GBxY7Wtsa92V2R6ldDw
 KQMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=0Mo/v5jxgawkurDBpjpN2qi+oLCVBtcMh+QdJRmGmC4=;
 b=f9BfWSPghebRnpXlpyibAzYGiQuC5OCBvg2w8WwVtAxlVBr0DFQKlAjXLTuo1K4sgK
 K9bZxDuu5QVo1RU+sTz9xOxrqxB10bJzRAgegGPCqbr3cDNfnk3pqkfB4JGEeKffFzeG
 K5JWfneo+zTwIxBopXfYp1MSjev3/3wVWiI1VGJGHFafEP/r7tzl8JteGOhc16clcmqc
 5kzz5LOSOXbDBxPkhpSC9kus7DBDm+syWYucjlwT5sTd9vj3AGZ8mcnPJ5PSiNLVITEQ
 rPMVHWZQlSDYaTY1mt0tnBjHZzJ/pM1aGhymQMvZl2dm23SYOAdTtOrPNCgmGc17pcfR
 I3Yg==
X-Gm-Message-State: AOAM530wQNNTcd+/mtppai7Zp451t9xtYBm0WbLFSWoosAdqgnv8Uj9U
 7tIRKw92VWiIFtOoQozrAg7cLQ==
X-Google-Smtp-Source: ABdhPJw0xU7yFG+isOKSFALWMtnoTpyCMAhFMwZRM1IImZBhy97nf7rrjzCpAyMnItrX18B/OriewQ==
X-Received: by 2002:aca:1a02:: with SMTP id a2mr5751516oia.60.1599231412795;
 Fri, 04 Sep 2020 07:56:52 -0700 (PDT)
Received: from yoga ([2605:6000:e5cb:c100:8898:14ff:fe6d:34e])
 by smtp.gmail.com with ESMTPSA id t7sm272863ooq.0.2020.09.04.07.56.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 07:56:52 -0700 (PDT)
Date: Fri, 4 Sep 2020 09:56:49 -0500
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 2/3] iommu: intel: Drop kerneldoc marker from regular
 comment
Message-ID: <20200904145649.GF3715@yoga>
References: <20200728170859.28143-1-krzk@kernel.org>
 <20200728170859.28143-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200728170859.28143-2-krzk@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>
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

On Tue 28 Jul 12:08 CDT 2020, Krzysztof Kozlowski wrote:

> Fix W=1 compile warnings (invalid kerneldoc):
> 
>     drivers/iommu/intel/dmar.c:389: warning: Function parameter or member 'header' not described in 'dmar_parse_one_drhd'
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/iommu/intel/dmar.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index 93e6345f3414..ba47edf03941 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -380,7 +380,7 @@ dmar_find_dmaru(struct acpi_dmar_hardware_unit *drhd)
>  	return NULL;
>  }
>  
> -/**
> +/*
>   * dmar_parse_one_drhd - parses exactly one DMA remapping hardware definition
>   * structure which uniquely represent one DMA remapping hardware unit
>   * present in the platform
> -- 
> 2.17.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
