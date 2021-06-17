Return-Path: <SRS0=K0Me=LL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2640DC48BE5
	for <iommu@archiver.kernel.org>; Thu, 17 Jun 2021 19:02:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCB3060BBB
	for <iommu@archiver.kernel.org>; Thu, 17 Jun 2021 19:02:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCB3060BBB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7E334404C9;
	Thu, 17 Jun 2021 19:02:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 50F-Auk7oJrN; Thu, 17 Jun 2021 19:02:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 15C0340361;
	Thu, 17 Jun 2021 19:02:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C02C2C000D;
	Thu, 17 Jun 2021 19:02:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8829AC000B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 19:02:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5FFA2404A8
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 19:02:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wLM1qFyARSth for <iommu@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 19:02:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 530BB40361
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 19:02:06 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CFC013A1;
 Thu, 17 Jun 2021 12:02:05 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 683143F694;
 Thu, 17 Jun 2021 12:02:03 -0700 (PDT)
Subject: Re: [PATCH v13 1/6] iommu: Deprecate Intel and AMD cmdline methods to
 enable strict mode
To: John Garry <john.garry@huawei.com>, joro@8bytes.org, will@kernel.org,
 dwmw2@infradead.org, baolu.lu@linux.intel.com, corbet@lwn.net
References: <1623841437-211832-1-git-send-email-john.garry@huawei.com>
 <1623841437-211832-2-git-send-email-john.garry@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <f95252ce-f834-103b-f96d-7e35fa59d5ec@arm.com>
Date: Thu, 17 Jun 2021 20:01:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <1623841437-211832-2-git-send-email-john.garry@huawei.com>
Content-Language: en-GB
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxarm@huawei.com, iommu@lists.linux-foundation.org
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

On 2021-06-16 12:03, John Garry wrote:
> Now that the x86 drivers support iommu.strict, deprecate the custom
> methods.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   Documentation/admin-guide/kernel-parameters.txt | 5 +++--
>   drivers/iommu/amd/init.c                        | 4 +++-
>   drivers/iommu/intel/iommu.c                     | 1 +
>   3 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 30e9dd52464e..fcbb36d6eea7 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -290,7 +290,8 @@
>   	amd_iommu=	[HW,X86-64]
>   			Pass parameters to the AMD IOMMU driver in the system.
>   			Possible values are:
> -			fullflush - enable flushing of IO/TLB entries when
> +			fullflush   [Deprecated, use iommu.strict instead]
> +				  - enable flushing of IO/TLB entries when
>   				    they are unmapped. Otherwise they are
>   				    flushed before they will be reused, which
>   				    is a lot of faster
> @@ -1947,7 +1948,7 @@
>   			bypassed by not enabling DMAR with this option. In
>   			this case, gfx device will use physical address for
>   			DMA.
> -		strict [Default Off]
> +		strict [Default Off] [Deprecated, use iommu.strict instead]
>   			With this option on every unmap_single operation will
>   			result in a hardware IOTLB flush operation as opposed
>   			to batching them for performance.

FWIW I'd be inclined to replace both whole descriptions with just 
something like "Deprecated, equivalent to iommu.strict=1".

> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 46280e6e1535..9f3096d650aa 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -3098,8 +3098,10 @@ static int __init parse_amd_iommu_intr(char *str)
>   static int __init parse_amd_iommu_options(char *str)
>   {
>   	for (; *str; ++str) {
> -		if (strncmp(str, "fullflush", 9) == 0)
> +		if (strncmp(str, "fullflush", 9) == 0) {
> +			pr_warn("amd_iommu=fullflush deprecated; use iommu.strict instead\n");

Nit: maybe we should spell out "...use <option>=1 instead" in all of 
these messages just in case anyone takes them literally? (I'm not sure 
the options parse correctly with no argument)

Either way,

Acked-by: Robin Murphy <robin.murphy@arm.com>

Thanks,
Robin.

>   			amd_iommu_unmap_flush = true;
> +		}
>   		if (strncmp(str, "force_enable", 12) == 0)
>   			amd_iommu_force_enable = true;
>   		if (strncmp(str, "off", 3) == 0)
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index bd93c7ec879e..821d8227a4e6 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -454,6 +454,7 @@ static int __init intel_iommu_setup(char *str)
>   			pr_warn("intel_iommu=forcedac deprecated; use iommu.forcedac instead\n");
>   			iommu_dma_forcedac = true;
>   		} else if (!strncmp(str, "strict", 6)) {
> +			pr_warn("intel_iommu=strict deprecated; use iommu.strict instead\n");
>   			pr_info("Disable batched IOTLB flush\n");
>   			intel_iommu_strict = 1;
>   		} else if (!strncmp(str, "sp_off", 6)) {
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
