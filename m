Return-Path: <SRS0=g+Up=LD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC77C48BCD
	for <iommu@archiver.kernel.org>; Wed,  9 Jun 2021 15:03:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CB97613B6
	for <iommu@archiver.kernel.org>; Wed,  9 Jun 2021 15:03:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CB97613B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D4996404E0;
	Wed,  9 Jun 2021 15:03:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yAGiAUjKxKYr; Wed,  9 Jun 2021 15:03:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3C96C40582;
	Wed,  9 Jun 2021 15:03:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F1B21C000D;
	Wed,  9 Jun 2021 15:03:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC550C000B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 15:03:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BE40E40277
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 15:03:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SwZfdIxxEATC for <iommu@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 15:03:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 80026400CB
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 15:03:09 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A01F1D6E;
 Wed,  9 Jun 2021 08:03:08 -0700 (PDT)
Received: from [10.57.6.115] (unknown [10.57.6.115])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 45D713F73D;
 Wed,  9 Jun 2021 08:03:07 -0700 (PDT)
Subject: Re: [PATCH v11 1/3] iommu: Enhance IOMMU default DMA mode build
 options
To: John Garry <john.garry@huawei.com>, joro@8bytes.org, will@kernel.org,
 dwmw2@infradead.org, baolu.lu@linux.intel.com
References: <1623158308-180604-1-git-send-email-john.garry@huawei.com>
 <1623158308-180604-2-git-send-email-john.garry@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <b9575a44-24c7-a05b-6f02-0495e95a4cec@arm.com>
Date: Wed, 9 Jun 2021 16:03:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <1623158308-180604-2-git-send-email-john.garry@huawei.com>
Content-Language: en-GB
Cc: iommu@lists.linux-foundation.org, rdunlap@infradead.org,
 linux-kernel@vger.kernel.org, linuxarm@huawei.com
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

On 2021-06-08 14:18, John Garry wrote:
> From: Zhen Lei <thunder.leizhen@huawei.com>
> 
> First, add build options IOMMU_DEFAULT_{LAZY|STRICT}, so that we have the
> opportunity to set {lazy|strict} mode as default at build time. Then put
> the two config options in a choice, as they are mutually exclusive.
> 
> [jpg: Make choice between strict and lazy only (and not passthrough)]
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   drivers/iommu/Kconfig | 35 +++++++++++++++++++++++++++++++++++
>   drivers/iommu/iommu.c |  3 ++-
>   2 files changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 1f111b399bca..369a3af9e5bf 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -90,6 +90,41 @@ config IOMMU_DEFAULT_PASSTHROUGH
>   
>   	  If unsure, say N here.
>   
> +choice
> +	prompt "IOMMU default DMA mode"
> +	depends on IOMMU_API
> +	depends on X86 || IA64 || X86_64 || ARM || ARM64

Simply "depends on IOMMU_DMA" should suffice, since that's now the only 
place where flush queues matter.

> +
> +	default IOMMU_DEFAULT_STRICT
> +	help
> +	  This option allows an IOMMU DMA mode to be chosen at build time, to
> +	  override the default DMA mode of each ARCH, removing the need to
> +	  pass in kernel parameters through command line. It is still possible
> +	  to provide ARCH-specific or common boot options to override this
> +	  option.
> +
> +	  If unsure, keep the default.
> +
> +config IOMMU_DEFAULT_LAZY
> +	bool "lazy"
> +	help
> +	  Support lazy mode, where for every IOMMU DMA unmap operation, the
> +	  flush operation of IOTLB and the free operation of IOVA are deferred.
> +	  They are only guaranteed to be done before the related IOVA will be
> +	  reused.
> +
> +config IOMMU_DEFAULT_STRICT
> +	bool "strict"
> +	help
> +	  For every IOMMU DMA unmap operation, the flush operation of IOTLB and
> +	  the free operation of IOVA are guaranteed to be done in the unmap
> +	  function.
> +
> +	  This mode is safer than lazy mode, but it may be slower in some high
> +	  performance scenarios.

FWIW, as an end user who doesn't care much about the implementation 
details I'd probably appreciate the actual implications being clearer, 
i.e. what does "safer" mean in practice and what is it relative to?

Robin.

> +
> +endchoice
> +
>   config OF_IOMMU
>   	def_bool y
>   	depends on OF && IOMMU_API
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 966426a96520..177b0dafc535 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -29,7 +29,8 @@ static struct kset *iommu_group_kset;
>   static DEFINE_IDA(iommu_group_ida);
>   
>   static unsigned int iommu_def_domain_type __read_mostly;
> -static bool iommu_dma_strict __read_mostly = true;
> +static bool iommu_dma_strict __read_mostly =
> +			IS_ENABLED(CONFIG_IOMMU_DEFAULT_STRICT);
>   static u32 iommu_cmd_line __read_mostly;
>   
>   struct iommu_group {
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
