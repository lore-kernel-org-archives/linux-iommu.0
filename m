Return-Path: <SRS0=GV0T=MW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C654FC4338F
	for <iommu@archiver.kernel.org>; Fri, 30 Jul 2021 09:30:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67AEC6109D
	for <iommu@archiver.kernel.org>; Fri, 30 Jul 2021 09:30:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 67AEC6109D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 157154024A;
	Fri, 30 Jul 2021 09:30:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aevxMxcg9LM0; Fri, 30 Jul 2021 09:30:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4886E40104;
	Fri, 30 Jul 2021 09:30:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2DA05C001A;
	Fri, 30 Jul 2021 09:30:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 478FAC000E
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 09:30:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2736B6062C
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 09:30:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pKMT2I6t7Ara for <iommu@lists.linux-foundation.org>;
 Fri, 30 Jul 2021 09:30:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CDE5A605F6
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 09:30:00 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id cf5so700252edb.2
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 02:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=yTXTqt76E4GEU0UK9YFMo0iaEiN8YMEQ//FwGWJRdeg=;
 b=C7Xuhg0pbaQmCiRVNt5VksbzD8WVUhyFEf6KeaNTEN+U3PyTN3dpnBfFK3jLX8ZwJp
 ZL2zwsy7erQuGwXn/6N1MZoJlSY9SCfrfMfGfYjKeexYeWWG9lc+kojub516EvyABeEP
 sxB3l+l8nxURaym6t6Bjv2rMHMMrTHZIZLhk34zbBH7kUCe+zp5u0niVEF1OYU7cdoXW
 1rTx1UikZmr81qzeHaNZAA9jgtZWF0/tR7+DuDX8uNx/o48ahUKv8rv0mHhIqcG7iZj9
 6lwDTNRMB5mxbWW997/PixT6YuEqw2SE/sM4iPN29nLO5vsCkj2gpRZb+73tcMLxY3My
 iU3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=yTXTqt76E4GEU0UK9YFMo0iaEiN8YMEQ//FwGWJRdeg=;
 b=YYcbpBSTY2jcP/63jwo3xX4YBnEnpUvmvbcXOZo4QWkZorKplwDmkZsuUYQ/MrjFPy
 bqdEZXhgaOsgcBDG4j27jSB8EL5pU+miOOMFwmkWB/SIPz0thzR5LA9KNRzmd5izjpr1
 J5hUWLjZov/kw5O/INSPBTi67+vvmbY42xcoy7UwbtnVizH2RfVp85aBxXKBT5tOhGm2
 z2VQUExrJ15e/NR0lQMBsjM9H80iGugvd4OY1GRXVDcxIEjB/nvDe2zMkIjPbIZHC0RO
 saDfrtBgP48qnRhRlc7wH0jOKApUYoTlP3TLtK++fZsEpI9T8HBn9Ie/vceWCceFEp+A
 uBJQ==
X-Gm-Message-State: AOAM532Fe8Gkw5GLU/3D+AZwIocLxJtAcpGVU1eUVTPH6wIbU7zMWELS
 1ZjRentPQHs3A/97xUPdM5Q93g==
X-Google-Smtp-Source: ABdhPJzR7h7K0UB04ngaRLs+lx+K56tBTUTPTr94qqq9WbBrSm9ijUbX3qk7TivlvyjJfwpw5LhteQ==
X-Received: by 2002:a50:cf8c:: with SMTP id h12mr1827098edk.360.1627637398976; 
 Fri, 30 Jul 2021 02:29:58 -0700 (PDT)
Received: from myrica (adsl-84-226-111-173.adslplus.ch. [84.226.111.173])
 by smtp.gmail.com with ESMTPSA id c13sm422187edv.93.2021.07.30.02.29.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jul 2021 02:29:58 -0700 (PDT)
Date: Fri, 30 Jul 2021 11:29:38 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 20/24] iommu: Merge strictness and domain type configs
Message-ID: <YQPGgjT5nGdbTYDN@myrica>
References: <cover.1627468308.git.robin.murphy@arm.com>
 <992b2952f0b173411c7b6f221dce82e8e082c0b8.1627468310.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <992b2952f0b173411c7b6f221dce82e8e082c0b8.1627468310.git.robin.murphy@arm.com>
Cc: linux-kernel@vger.kernel.org, dianders@chromium.org,
 iommu@lists.linux-foundation.org, will@kernel.org,
 linux-arm-kernel@lists.infradead.org
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

On Wed, Jul 28, 2021 at 04:58:41PM +0100, Robin Murphy wrote:
> To parallel the sysfs behaviour, merge the new build-time option
> for DMA domain strictness into the default domain type choice.
> 
> Suggested-by: Joerg Roedel <joro@8bytes.org>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

kernel-parameters.txt still refers to the old config options

Otherwise
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  drivers/iommu/Kconfig | 80 +++++++++++++++++++++----------------------
>  drivers/iommu/iommu.c |  2 +-
>  2 files changed, 41 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index c84da8205be7..6e06f876d75a 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -79,55 +79,55 @@ config IOMMU_DEBUGFS
>  	  debug/iommu directory, and then populate a subdirectory with
>  	  entries as required.
>  
> -config IOMMU_DEFAULT_PASSTHROUGH
> -	bool "IOMMU passthrough by default"
> -	depends on IOMMU_API
> -	help
> -	  Enable passthrough by default, removing the need to pass in
> -	  iommu.passthrough=on or iommu=pt through command line. If this
> -	  is enabled, you can still disable with iommu.passthrough=off
> -	  or iommu=nopt depending on the architecture.
> -
> -	  If unsure, say N here.
> -
>  choice
> -	prompt "IOMMU default DMA IOTLB invalidation mode"
> -	depends on IOMMU_DMA
> -
> -	default IOMMU_DEFAULT_LAZY if (AMD_IOMMU || INTEL_IOMMU)
> -	default IOMMU_DEFAULT_STRICT
> +	prompt "IOMMU default domain type"
> +	depends on IOMMU_API
> +	default IOMMU_DEFAULT_DMA_LAZY if AMD_IOMMU || INTEL_IOMMU
> +	default IOMMU_DEFAULT_DMA_STRICT
>  	help
> -	  This option allows an IOMMU DMA IOTLB invalidation mode to be
> -	  chosen at build time, to override the default mode of each ARCH,
> -	  removing the need to pass in kernel parameters through command line.
> -	  It is still possible to provide common boot params to override this
> -	  config.
> +	  Choose the type of IOMMU domain used to manage DMA API usage by
> +	  device drivers. The options here typically represent different
> +	  levels of tradeoff between robustness/security and performance,
> +	  depending on the IOMMU driver. Not all IOMMUs support all options.
> +	  This choice can be overridden at boot via the command line, and for
> +	  some devices also at runtime via sysfs.
>  
>  	  If unsure, keep the default.
>  
> -config IOMMU_DEFAULT_STRICT
> -	bool "strict"
> +config IOMMU_DEFAULT_DMA_STRICT
> +	bool "Translated - Strict"
>  	help
> -	  For every IOMMU DMA unmap operation, the flush operation of IOTLB and
> -	  the free operation of IOVA are guaranteed to be done in the unmap
> -	  function.
> +	  Trusted devices use translation to restrict their access to only
> +	  DMA-mapped pages, with strict TLB invalidation on unmap. Equivalent
> +	  to passing "iommu.passthrough=0 iommu.strict=1" on the command line.
>  
> -config IOMMU_DEFAULT_LAZY
> -	bool "lazy"
> +	  Untrusted devices always use this mode, with an additional layer of
> +	  bounce-buffering such that they cannot gain access to any unrelated
> +	  data within a mapped page.
> +
> +config IOMMU_DEFAULT_DMA_LAZY
> +	bool "Translated - Lazy"
>  	help
> -	  Support lazy mode, where for every IOMMU DMA unmap operation, the
> -	  flush operation of IOTLB and the free operation of IOVA are deferred.
> -	  They are only guaranteed to be done before the related IOVA will be
> -	  reused.
> +	  Trusted devices use translation to restrict their access to only
> +	  DMA-mapped pages, but with "lazy" batched TLB invalidation. This
> +	  mode allows higher performance with some IOMMUs due to reduced TLB
> +	  flushing, but at the cost of reduced isolation since devices may be
> +	  able to access memory for some time after it has been unmapped.
> +	  Equivalent to passing "iommu.passthrough=0 iommu.strict=0" on the
> +	  command line.
>  
> -	  The isolation provided in this mode is not as secure as STRICT mode,
> -	  such that a vulnerable time window may be created between the DMA
> -	  unmap and the mappings cached in the IOMMU IOTLB or device TLB
> -	  finally being invalidated, where the device could still access the
> -	  memory which has already been unmapped by the device driver.
> -	  However this mode may provide better performance in high throughput
> -	  scenarios, and is still considerably more secure than passthrough
> -	  mode or no IOMMU.
> +	  If this mode is not supported by the IOMMU driver, the effective
> +	  runtime default will fall back to IOMMU_DEFAULT_DMA_STRICT.
> +
> +config IOMMU_DEFAULT_PASSTHROUGH
> +	bool "Passthrough"
> +	help
> +	  Trusted devices are identity-mapped, giving them unrestricted access
> +	  to memory with minimal performance overhead. Equivalent to passing
> +	  "iommu.passthrough=1" (historically "iommu=pt") on the command line.
> +
> +	  If this mode is not supported by the IOMMU driver, the effective
> +	  runtime default will fall back to IOMMU_DEFAULT_DMA_STRICT.
>  
>  endchoice
>  
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 5a08e0806cbb..25c1adc1ec67 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -31,7 +31,7 @@ static struct kset *iommu_group_kset;
>  static DEFINE_IDA(iommu_group_ida);
>  
>  static unsigned int iommu_def_domain_type __read_mostly;
> -static bool iommu_dma_strict __read_mostly = IS_ENABLED(CONFIG_IOMMU_DEFAULT_STRICT);
> +static bool iommu_dma_strict __read_mostly = IS_ENABLED(CONFIG_IOMMU_DEFAULT_DMA_STRICT);
>  static u32 iommu_cmd_line __read_mostly;
>  
>  struct iommu_group {
> -- 
> 2.25.1
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
