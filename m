Return-Path: <SRS0=mVMG=CN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B65C43461
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 14:57:24 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BBB320722
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 14:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fztru+Ac"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BBB320722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 302EE8754F;
	Fri,  4 Sep 2020 14:57:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y3U7hroI4uGu; Fri,  4 Sep 2020 14:57:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id AF61487275;
	Fri,  4 Sep 2020 14:57:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D55AC07FF;
	Fri,  4 Sep 2020 14:57:23 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1E714C0051
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 14:57:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1A0F08753C
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 14:57:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LHQEbL+ywAo0 for <iommu@lists.linux-foundation.org>;
 Fri,  4 Sep 2020 14:57:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com
 [209.85.167.195])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8839D87275
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 14:57:21 +0000 (UTC)
Received: by mail-oi1-f195.google.com with SMTP id 185so6733923oie.11
 for <iommu@lists.linux-foundation.org>; Fri, 04 Sep 2020 07:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=qwFik1VzdKihmwo9cBFiJu4/LHOZM7jcNFKIFxCkxKI=;
 b=Fztru+AcSdmnH4CC8rxLvREYY+3FnzSn/ADUlvE9QHLdsNufk+8airPBlRopYAXGZi
 WCWOp+fAniCaCE9hnf4aHgTv4nxT3TalwNn/was1jOdR4nMkqkj7JPDUw2oyjJVvVIZF
 OWez32qjH0GG49gsNb2e3JfUKu3s5t/t4LYTcdecijZ5TU/gEN/3Sl3LV7QRzlr+vUO6
 OEQ7lmcX2ZS8UR0zTom9PODEWA5BYGsdR0quvf6xHlRjQeRh0IH8Zv8Da2nW70zXxphz
 DSAnBe7FBH+aaAIXpSkGvQDzUh8cseeGaUhyo4fm0SkedJjh0eAgLE2XLKp3BTcbqdXW
 0tkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=qwFik1VzdKihmwo9cBFiJu4/LHOZM7jcNFKIFxCkxKI=;
 b=L1rVOITr2dYgH5OBzIhWi4wex114fVAWHEK3XjzLPE0tTRiBSSvL+0FDBK3Nuh/pQK
 BSwljMWxA7WIbtziHEZW8mOvZfcb3NLBtexu7KlIl8qzOLkeelUciyps7E7xz3/3EIYz
 tFwk8+MEfwAO75YJd5ntdRgzKwLtBni8s1Y89jo8IoKNYb4NlY7eFb8Hk4DRK6zS102F
 QMMuxzO7M1QIKzwBbqvi6gGj4w3VrIWq2TCbwrZOs6JuOH1ari/77TnbWV4nB6cjdiIq
 LO8GFAV5Byb0kcp/RqrKl65OdZYGH2/ZMmmL3t8m0o7ol9DITb9hY49Ub9AEp776AC5u
 E12g==
X-Gm-Message-State: AOAM532dT0Zb3P6f4Eel20A5vIVoZw4ZvcsQiUtmDfixueYjmqIJsfM8
 hduoc75UMDRj6RRNVNnvUa8mwQ==
X-Google-Smtp-Source: ABdhPJzzr7V6Q+NFlUzi14ObzhGd5ZRKlNLTeyLYhw4G1XLnZ9tYm6XUMbNPBt9t8yqwGyX7v7ttqQ==
X-Received: by 2002:aca:5e82:: with SMTP id s124mr5266539oib.168.1599231440721; 
 Fri, 04 Sep 2020 07:57:20 -0700 (PDT)
Received: from yoga ([2605:6000:e5cb:c100:8898:14ff:fe6d:34e])
 by smtp.gmail.com with ESMTPSA id n61sm1227108otn.34.2020.09.04.07.57.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 07:57:20 -0700 (PDT)
Date: Fri, 4 Sep 2020 09:57:17 -0500
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 1/3] iommu: amd: Fix kerneldoc
Message-ID: <20200904145717.GG3715@yoga>
References: <20200728170859.28143-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200728170859.28143-1-krzk@kernel.org>
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
>     drivers/iommu/amd/init.c:1586: warning: Function parameter or member 'ivrs' not described in 'get_highest_supported_ivhd_type'
>     drivers/iommu/amd/init.c:1938: warning: Function parameter or member 'iommu' not described in 'iommu_update_intcapxt'
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/iommu/amd/init.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 958050c213f9..4a37169b1b1b 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -1578,7 +1578,7 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
>  
>  /**
>   * get_highest_supported_ivhd_type - Look up the appropriate IVHD type
> - * @ivrs          Pointer to the IVRS header
> + * @ivrs: Pointer to the IVRS header
>   *
>   * This function search through all IVDB of the maximum supported IVHD
>   */
> @@ -1929,7 +1929,7 @@ static int iommu_setup_msi(struct amd_iommu *iommu)
>  #define XT_INT_VEC(x)		(((x) & 0xFFULL) << 32)
>  #define XT_INT_DEST_HI(x)	((((x) >> 24) & 0xFFULL) << 56)
>  
> -/**
> +/*
>   * Setup the IntCapXT registers with interrupt routing information
>   * based on the PCI MSI capability block registers, accessed via
>   * MMIO MSI address low/hi and MSI data registers.
> -- 
> 2.17.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
