Return-Path: <SRS0=K0Me=LL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB1DC2B9F4
	for <iommu@archiver.kernel.org>; Thu, 17 Jun 2021 07:38:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C193613D5
	for <iommu@archiver.kernel.org>; Thu, 17 Jun 2021 07:38:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C193613D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 084BF40150;
	Thu, 17 Jun 2021 07:38:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 82BwmKhCsm7F; Thu, 17 Jun 2021 07:38:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 925F440570;
	Thu, 17 Jun 2021 07:38:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6726FC000E;
	Thu, 17 Jun 2021 07:38:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 567EEC000B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 07:38:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3846F83D9B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 07:38:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H16N7-yIX6la for <iommu@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 07:38:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6A2DE83D94
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 07:38:28 +0000 (UTC)
IronPort-SDR: aMvq+HVHHdqruRpKJjVA6Stvj7bmjg1w34FbyKL8vqJanraBBlO+NIdzdEWkrVVEPi+4IK/h4+
 goyNrrLyVYWg==
X-IronPort-AV: E=McAfee;i="6200,9189,10017"; a="206276190"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; d="scan'208";a="206276190"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2021 00:38:27 -0700
IronPort-SDR: 136uuNiQtSsp9UVMNfU0hELOyo7dqnGjHU3/mznhhTdIWs+Ee7LEbb4kX22PvK+SCfQsddUAHv
 VgYhkuJeAACw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; d="scan'208";a="472331510"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga004.fm.intel.com with ESMTP; 17 Jun 2021 00:38:22 -0700
Subject: Re: [PATCH v13 6/6] iommu: Remove mode argument from
 iommu_set_dma_strict()
To: John Garry <john.garry@huawei.com>, joro@8bytes.org, will@kernel.org,
 dwmw2@infradead.org, robin.murphy@arm.com, corbet@lwn.net
References: <1623841437-211832-1-git-send-email-john.garry@huawei.com>
 <1623841437-211832-7-git-send-email-john.garry@huawei.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <de6a2874-3d6d-ed2a-78f5-fb1fb0195228@linux.intel.com>
Date: Thu, 17 Jun 2021 15:36:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1623841437-211832-7-git-send-email-john.garry@huawei.com>
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

On 6/16/21 7:03 PM, John Garry wrote:
> We only ever now set strict mode enabled in iommu_set_dma_strict(), so
> just remove the argument.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   drivers/iommu/amd/init.c    | 2 +-
>   drivers/iommu/intel/iommu.c | 6 +++---
>   drivers/iommu/iommu.c       | 5 ++---
>   include/linux/iommu.h       | 2 +-
>   4 files changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index fb3618af643b..7bc460052678 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -3099,7 +3099,7 @@ static int __init parse_amd_iommu_options(char *str)
>   	for (; *str; ++str) {
>   		if (strncmp(str, "fullflush", 9) == 0) {
>   			pr_warn("amd_iommu=fullflush deprecated; use iommu.strict instead\n");
> -			iommu_set_dma_strict(true);
> +			iommu_set_dma_strict();
>   		}
>   		if (strncmp(str, "force_enable", 12) == 0)
>   			amd_iommu_force_enable = true;
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index d586990fa751..0618c35cfb51 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -454,7 +454,7 @@ static int __init intel_iommu_setup(char *str)
>   			iommu_dma_forcedac = true;
>   		} else if (!strncmp(str, "strict", 6)) {
>   			pr_warn("intel_iommu=strict deprecated; use iommu.strict instead\n");
> -			iommu_set_dma_strict(true);
> +			iommu_set_dma_strict();
>   		} else if (!strncmp(str, "sp_off", 6)) {
>   			pr_info("Disable supported super page\n");
>   			intel_iommu_superpage = 0;
> @@ -4382,7 +4382,7 @@ int __init intel_iommu_init(void)
>   		 */
>   		if (cap_caching_mode(iommu->cap)) {
>   			pr_warn("IOMMU batching disallowed due to virtualization\n");
> -			iommu_set_dma_strict(true);
> +			iommu_set_dma_strict();
>   		}
>   		iommu_device_sysfs_add(&iommu->iommu, NULL,
>   				       intel_iommu_groups,
> @@ -5699,7 +5699,7 @@ static void quirk_calpella_no_shadow_gtt(struct pci_dev *dev)
>   	} else if (dmar_map_gfx) {
>   		/* we have to ensure the gfx device is idle before we flush */
>   		pci_info(dev, "Disabling batched IOTLB flush on Ironlake\n");
> -		iommu_set_dma_strict(true);
> +		iommu_set_dma_strict();
>   	}
>   }
>   DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0040, quirk_calpella_no_shadow_gtt);
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 60b1ec42e73b..ff221d3ddcbc 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -349,10 +349,9 @@ static int __init iommu_dma_setup(char *str)
>   }
>   early_param("iommu.strict", iommu_dma_setup);
>   
> -void iommu_set_dma_strict(bool strict)
> +void iommu_set_dma_strict(void)
>   {
> -	if (strict || !(iommu_cmd_line & IOMMU_CMD_LINE_STRICT))
> -		iommu_dma_strict = strict;
> +	iommu_dma_strict = true;

Sorry, I still can't get how iommu.strict kernel option works.

static int __init iommu_dma_setup(char *str)
{
         int ret = kstrtobool(str, &iommu_dma_strict);

         if (!ret)
                 iommu_cmd_line |= IOMMU_CMD_LINE_STRICT;
         return ret;
}
early_param("iommu.strict", iommu_dma_setup);

The bit IOMMU_CMD_LINE_STRICT is only set, but not used anywhere. Hence,
I am wondering how could it work? A bug or I missed anything?

Best regards,
baolu

>   }
>   
>   bool iommu_get_dma_strict(struct iommu_domain *domain)
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 32d448050bf7..754f67d6dd90 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -476,7 +476,7 @@ int iommu_enable_nesting(struct iommu_domain *domain);
>   int iommu_set_pgtable_quirks(struct iommu_domain *domain,
>   		unsigned long quirks);
>   
> -void iommu_set_dma_strict(bool val);
> +void iommu_set_dma_strict(void);
>   bool iommu_get_dma_strict(struct iommu_domain *domain);
>   
>   extern int report_iommu_fault(struct iommu_domain *domain, struct device *dev,
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
