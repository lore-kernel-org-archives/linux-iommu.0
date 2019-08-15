Return-Path: <SRS0=B4OP=WL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD58C433FF
	for <iommu@archiver.kernel.org>; Thu, 15 Aug 2019 06:56:47 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E1C12084D
	for <iommu@archiver.kernel.org>; Thu, 15 Aug 2019 06:56:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E1C12084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 0E4897F6;
	Thu, 15 Aug 2019 06:56:47 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 3730F7F6
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 06:56:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C42B567F
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 06:56:44 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
	by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	14 Aug 2019 23:56:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,388,1559545200"; d="scan'208";a="171034750"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
	([10.239.159.136])
	by orsmga008.jf.intel.com with ESMTP; 14 Aug 2019 23:56:40 -0700
Subject: Re: [PATCH 08/10] iommu: Set default domain type at runtime
To: Joerg Roedel <joro@8bytes.org>
References: <20190814133841.7095-1-joro@8bytes.org>
	<20190814133841.7095-9-joro@8bytes.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <a8e804dd-a8ae-2e0d-6b3c-698fbc96bf75@linux.intel.com>
Date: Thu, 15 Aug 2019 14:55:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190814133841.7095-9-joro@8bytes.org>
Content-Language: en-US
Cc: fenghua.yu@intel.com, tony.luck@intel.com, linux-ia64@vger.kernel.org,
	corbet@lwn.net, Joerg Roedel <jroedel@suse.de>, x86@kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, mingo@redhat.com, bp@alien8.de,
	Thomas.Lendacky@amd.com, hpa@zytor.com, tglx@linutronix.de
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi,

On 8/14/19 9:38 PM, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Set the default domain-type at runtime, not at compile-time.
> This keeps default domain type setting in one place when we
> have to change it at runtime.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>   drivers/iommu/iommu.c | 23 +++++++++++++++--------
>   1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 233bc22b487e..96cc7cc8ab21 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -26,11 +26,8 @@
>   
>   static struct kset *iommu_group_kset;
>   static DEFINE_IDA(iommu_group_ida);
> -#ifdef CONFIG_IOMMU_DEFAULT_PASSTHROUGH
> -static unsigned int iommu_def_domain_type = IOMMU_DOMAIN_IDENTITY;
> -#else
> -static unsigned int iommu_def_domain_type = IOMMU_DOMAIN_DMA;
> -#endif
> +
> +static unsigned int iommu_def_domain_type __read_mostly;
>   static bool iommu_dma_strict __read_mostly = true;
>   static u32 iommu_cmd_line __read_mostly;
>   
> @@ -76,7 +73,7 @@ static void iommu_set_cmd_line_dma_api(void)
>   	iommu_cmd_line |= IOMMU_CMD_LINE_DMA_API;
>   }
>   
> -static bool __maybe_unused iommu_cmd_line_dma_api(void)
> +static bool iommu_cmd_line_dma_api(void)
>   {
>   	return !!(iommu_cmd_line & IOMMU_CMD_LINE_DMA_API);
>   }
> @@ -115,8 +112,18 @@ static const char *iommu_domain_type_str(unsigned int t)
>   
>   static int __init iommu_subsys_init(void)
>   {
> -	pr_info("Default domain type: %s\n",
> -		iommu_domain_type_str(iommu_def_domain_type));
> +	bool cmd_line = iommu_cmd_line_dma_api();
> +
> +	if (!cmd_line) {
> +		if (IS_ENABLED(CONFIG_IOMMU_DEFAULT_PASSTHROUGH))
> +			iommu_set_default_passthrough();
> +		else
> +			iommu_set_default_translated();

This overrides kernel parameters parsed in iommu_setup(), for example,
iommu=pt won't work anymore.

Best regards,
Lu Baolu

> +	}
> +
> +	pr_info("Default domain type: %s %s\n",
> +		iommu_domain_type_str(iommu_def_domain_type),
> +		cmd_line ? "(set via kernel command line)" : "");
>   
>   	return 0;
>   }
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
