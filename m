Return-Path: <SRS0=sMz+=LM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B56FC49361
	for <iommu@archiver.kernel.org>; Fri, 18 Jun 2021 13:09:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E640B613D1
	for <iommu@archiver.kernel.org>; Fri, 18 Jun 2021 13:09:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E640B613D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B3C5F400DF;
	Fri, 18 Jun 2021 13:09:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PwgRVKr0I6oP; Fri, 18 Jun 2021 13:09:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 00DBD400DB;
	Fri, 18 Jun 2021 13:09:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9EDFAC000D;
	Fri, 18 Jun 2021 13:09:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B58D8C000B
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 13:09:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 969BB605DD
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 13:09:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fzIsHIEfsSj2 for <iommu@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 13:09:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 149D1605D8
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 13:09:46 +0000 (UTC)
IronPort-SDR: 2HbLIbYN82ScfXAygKjJeUttvAIFy7nVzOJJrk4YnAOOeLYwSh4SoTmm5imkfkYyCwDEYms4RB
 YddkLc8wGSxw==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="193863324"
X-IronPort-AV: E=Sophos;i="5.83,283,1616482800"; d="scan'208";a="193863324"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2021 06:09:46 -0700
IronPort-SDR: k0VNKFgc6/+ZCs+/29CFEINWXy8j5ryxt4Kiuk5WVmtQSAapGGKzOhEQiK4osW6tBDtXBMXpFP
 /enHauR5gPDQ==
X-IronPort-AV: E=Sophos;i="5.83,283,1616482800"; d="scan'208";a="485683414"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.212.157])
 ([10.254.212.157])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2021 06:09:42 -0700
Subject: Re: [PATCH v14 1/6] iommu: Deprecate Intel and AMD cmdline methods to
 enable strict mode
To: John Garry <john.garry@huawei.com>, joro@8bytes.org, will@kernel.org,
 dwmw2@infradead.org, robin.murphy@arm.com, corbet@lwn.net
References: <1624016058-189713-1-git-send-email-john.garry@huawei.com>
 <1624016058-189713-2-git-send-email-john.garry@huawei.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <31d7ec79-79e8-4ae9-6705-e08c1256f432@linux.intel.com>
Date: Fri, 18 Jun 2021 21:09:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1624016058-189713-2-git-send-email-john.garry@huawei.com>
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
> Now that the x86 drivers support iommu.strict, deprecate the custom
> methods.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> Acked-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   Documentation/admin-guide/kernel-parameters.txt | 9 ++-------
>   drivers/iommu/amd/init.c                        | 4 +++-
>   drivers/iommu/intel/iommu.c                     | 1 +
>   3 files changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 30e9dd52464e..673952379900 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -290,10 +290,7 @@
>   	amd_iommu=	[HW,X86-64]
>   			Pass parameters to the AMD IOMMU driver in the system.
>   			Possible values are:
> -			fullflush - enable flushing of IO/TLB entries when
> -				    they are unmapped. Otherwise they are
> -				    flushed before they will be reused, which
> -				    is a lot of faster
> +			fullflush - Deprecated, equivalent to iommu.strict=1
>   			off	  - do not initialize any AMD IOMMU found in
>   				    the system
>   			force_isolation - Force device isolation for all
> @@ -1948,9 +1945,7 @@
>   			this case, gfx device will use physical address for
>   			DMA.
>   		strict [Default Off]
> -			With this option on every unmap_single operation will
> -			result in a hardware IOTLB flush operation as opposed
> -			to batching them for performance.
> +			Deprecated, equivalent to iommu.strict=1.
>   		sp_off [Default Off]
>   			By default, super page will be supported if Intel IOMMU
>   			has the capability. With this option, super page will
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 46280e6e1535..3a2fb805f11e 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -3098,8 +3098,10 @@ static int __init parse_amd_iommu_intr(char *str)
>   static int __init parse_amd_iommu_options(char *str)
>   {
>   	for (; *str; ++str) {
> -		if (strncmp(str, "fullflush", 9) == 0)
> +		if (strncmp(str, "fullflush", 9) == 0) {
> +			pr_warn("amd_iommu=fullflush deprecated; use iommu.strict=1 instead\n");
>   			amd_iommu_unmap_flush = true;
> +		}
>   		if (strncmp(str, "force_enable", 12) == 0)
>   			amd_iommu_force_enable = true;
>   		if (strncmp(str, "off", 3) == 0)
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index bd93c7ec879e..29497113d748 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -454,6 +454,7 @@ static int __init intel_iommu_setup(char *str)
>   			pr_warn("intel_iommu=forcedac deprecated; use iommu.forcedac instead\n");
>   			iommu_dma_forcedac = true;
>   		} else if (!strncmp(str, "strict", 6)) {
> +			pr_warn("intel_iommu=strict deprecated; use iommu.strict=1 instead\n");
>   			pr_info("Disable batched IOTLB flush\n");
>   			intel_iommu_strict = 1;
>   		} else if (!strncmp(str, "sp_off", 6)) {
> 

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
