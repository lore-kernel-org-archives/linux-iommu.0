Return-Path: <SRS0=GV0T=MW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92079C432BE
	for <iommu@archiver.kernel.org>; Fri, 30 Jul 2021 06:13:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5849C61042
	for <iommu@archiver.kernel.org>; Fri, 30 Jul 2021 06:13:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5849C61042
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 32B14606EB;
	Fri, 30 Jul 2021 06:13:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eM3PFLHQ_B2o; Fri, 30 Jul 2021 06:13:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 049DF60A53;
	Fri, 30 Jul 2021 06:13:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0872C001A;
	Fri, 30 Jul 2021 06:13:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 02DF1C000E
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 06:13:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D8050414B9
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 06:13:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YZSvYz57rvB0 for <iommu@lists.linux-foundation.org>;
 Fri, 30 Jul 2021 06:13:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1D25B414B8
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 06:13:09 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10060"; a="212763768"
X-IronPort-AV: E=Sophos;i="5.84,281,1620716400"; d="scan'208";a="212763768"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2021 23:13:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,281,1620716400"; d="scan'208";a="465345218"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 29 Jul 2021 23:13:06 -0700
Subject: Re: [PATCH v2 20/24] iommu: Merge strictness and domain type configs
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org
References: <cover.1627468308.git.robin.murphy@arm.com>
 <992b2952f0b173411c7b6f221dce82e8e082c0b8.1627468310.git.robin.murphy@arm.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <2c714d77-1852-fe0f-7dcf-aabe09726619@linux.intel.com>
Date: Fri, 30 Jul 2021 14:10:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <992b2952f0b173411c7b6f221dce82e8e082c0b8.1627468310.git.robin.murphy@arm.com>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, dianders@chromium.org,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 7/28/21 11:58 PM, Robin Murphy wrote:
> To parallel the sysfs behaviour, merge the new build-time option
> for DMA domain strictness into the default domain type choice.
> 
> Suggested-by: Joerg Roedel <joro@8bytes.org>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   drivers/iommu/Kconfig | 80 +++++++++++++++++++++----------------------
>   drivers/iommu/iommu.c |  2 +-
>   2 files changed, 41 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index c84da8205be7..6e06f876d75a 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -79,55 +79,55 @@ config IOMMU_DEBUGFS
>   	  debug/iommu directory, and then populate a subdirectory with
>   	  entries as required.
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
>   choice
> -	prompt "IOMMU default DMA IOTLB invalidation mode"
> -	depends on IOMMU_DMA
> -
> -	default IOMMU_DEFAULT_LAZY if (AMD_IOMMU || INTEL_IOMMU)
> -	default IOMMU_DEFAULT_STRICT
> +	prompt "IOMMU default domain type"
> +	depends on IOMMU_API
> +	default IOMMU_DEFAULT_DMA_LAZY if AMD_IOMMU || INTEL_IOMMU
> +	default IOMMU_DEFAULT_DMA_STRICT
>   	help
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
>   	  If unsure, keep the default.
>   
> -config IOMMU_DEFAULT_STRICT
> -	bool "strict"
> +config IOMMU_DEFAULT_DMA_STRICT
> +	bool "Translated - Strict"
>   	help
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
>   	help
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
>   endchoice
>   
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 5a08e0806cbb..25c1adc1ec67 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -31,7 +31,7 @@ static struct kset *iommu_group_kset;
>   static DEFINE_IDA(iommu_group_ida);
>   
>   static unsigned int iommu_def_domain_type __read_mostly;
> -static bool iommu_dma_strict __read_mostly = IS_ENABLED(CONFIG_IOMMU_DEFAULT_STRICT);
> +static bool iommu_dma_strict __read_mostly = IS_ENABLED(CONFIG_IOMMU_DEFAULT_DMA_STRICT);
>   static u32 iommu_cmd_line __read_mostly;
>   
>   struct iommu_group {
> 


Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
