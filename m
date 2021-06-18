Return-Path: <SRS0=sMz+=LM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B50C48BE8
	for <iommu@archiver.kernel.org>; Fri, 18 Jun 2021 13:12:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4712A613D1
	for <iommu@archiver.kernel.org>; Fri, 18 Jun 2021 13:12:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4712A613D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 15D44403BE;
	Fri, 18 Jun 2021 13:12:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9fdh3ljwOuj5; Fri, 18 Jun 2021 13:12:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8783D403B4;
	Fri, 18 Jun 2021 13:12:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6C32AC000D;
	Fri, 18 Jun 2021 13:12:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E7E3C000B
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 13:12:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F17F5403CB
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 13:11:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BB5fsyIqvWzg for <iommu@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 13:11:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CFC8A403BE
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 13:11:57 +0000 (UTC)
IronPort-SDR: XvIgFqx8YpV/4hb6vpu/ZcTclLULUSdg9bR3vKB9MYNk2hFcDyWXnYpxSfE+XU7kFIHrHGhw7L
 jBQR/P4eSI0g==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="206502042"
X-IronPort-AV: E=Sophos;i="5.83,283,1616482800"; d="scan'208";a="206502042"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2021 06:11:56 -0700
IronPort-SDR: fUXp1eNyFe8UHrCwz/mApMUTcrdnOKODGqLQOfQ62eLnCaWEHWd9I2KQ/oYkSldHOKvWhTQkSW
 5d8xDSpzz37w==
X-IronPort-AV: E=Sophos;i="5.83,283,1616482800"; d="scan'208";a="485684332"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.212.157])
 ([10.254.212.157])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2021 06:11:52 -0700
Subject: Re: [PATCH v14 3/6] iommu: Enhance IOMMU default DMA mode build
 options
To: John Garry <john.garry@huawei.com>, joro@8bytes.org, will@kernel.org,
 dwmw2@infradead.org, robin.murphy@arm.com, corbet@lwn.net
References: <1624016058-189713-1-git-send-email-john.garry@huawei.com>
 <1624016058-189713-4-git-send-email-john.garry@huawei.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <4bd4b850-720e-bd02-c04d-01013be49456@linux.intel.com>
Date: Fri, 18 Jun 2021 21:11:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1624016058-189713-4-git-send-email-john.garry@huawei.com>
Content-Language: en-US
Cc: linux-doc@vger.kernel.org, linuxarm@huawei.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
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

On 2021/6/18 19:34, John Garry wrote:
> From: Zhen Lei <thunder.leizhen@huawei.com>
> 
> First, add build options IOMMU_DEFAULT_{LAZY|STRICT}, so that we have the
> opportunity to set {lazy|strict} mode as default at build time. Then put
> the two config options in an choice, as they are mutually exclusive.
> 
> [jpg: Make choice between strict and lazy only (and not passthrough)]
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> Signed-off-by: John Garry <john.garry@huawei.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   .../admin-guide/kernel-parameters.txt         |  3 +-
>   drivers/iommu/Kconfig                         | 40 +++++++++++++++++++
>   drivers/iommu/iommu.c                         |  2 +-
>   3 files changed, 43 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 673952379900..a1b7c8526bb5 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2046,9 +2046,10 @@
>   			  throughput at the cost of reduced device isolation.
>   			  Will fall back to strict mode if not supported by
>   			  the relevant IOMMU driver.
> -			1 - Strict mode (default).
> +			1 - Strict mode.
>   			  DMA unmap operations invalidate IOMMU hardware TLBs
>   			  synchronously.
> +			unset - Use value of CONFIG_IOMMU_DEFAULT_{LAZY,STRICT}.
>   			Note: on x86, the default behaviour depends on the
>   			equivalent driver-specific parameters, but a strict
>   			mode explicitly specified by either method takes
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 1f111b399bca..0327a942fdb7 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -90,6 +90,46 @@ config IOMMU_DEFAULT_PASSTHROUGH
>   
>   	  If unsure, say N here.
>   
> +choice
> +	prompt "IOMMU default DMA IOTLB invalidation mode"
> +	depends on IOMMU_DMA
> +
> +	default IOMMU_DEFAULT_STRICT
> +	help
> +	  This option allows an IOMMU DMA IOTLB invalidation mode to be
> +	  chosen at build time, to override the default mode of each ARCH,
> +	  removing the need to pass in kernel parameters through command line.
> +	  It is still possible to provide common boot params to override this
> +	  config.
> +
> +	  If unsure, keep the default.
> +
> +config IOMMU_DEFAULT_STRICT
> +	bool "strict"
> +	help
> +	  For every IOMMU DMA unmap operation, the flush operation of IOTLB and
> +	  the free operation of IOVA are guaranteed to be done in the unmap
> +	  function.
> +
> +config IOMMU_DEFAULT_LAZY
> +	bool "lazy"
> +	help
> +	  Support lazy mode, where for every IOMMU DMA unmap operation, the
> +	  flush operation of IOTLB and the free operation of IOVA are deferred.
> +	  They are only guaranteed to be done before the related IOVA will be
> +	  reused.
> +
> +	  The isolation provided in this mode is not as secure as STRICT mode,
> +	  such that a vulnerable time window may be created between the DMA
> +	  unmap and the mappings cached in the IOMMU IOTLB or device TLB
> +	  finally being invalidated, where the device could still access the
> +	  memory which has already been unmapped by the device driver.
> +	  However this mode may provide better performance in high throughput
> +	  scenarios, and is still considerably more secure than passthrough
> +	  mode or no IOMMU.
> +
> +endchoice
> +
>   config OF_IOMMU
>   	def_bool y
>   	depends on OF && IOMMU_API
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index cf58949cc2f3..60b1ec42e73b 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -29,7 +29,7 @@ static struct kset *iommu_group_kset;
>   static DEFINE_IDA(iommu_group_ida);
>   
>   static unsigned int iommu_def_domain_type __read_mostly;
> -static bool iommu_dma_strict __read_mostly = true;
> +static bool iommu_dma_strict __read_mostly = IS_ENABLED(CONFIG_IOMMU_DEFAULT_STRICT);
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
