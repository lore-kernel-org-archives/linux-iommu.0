Return-Path: <SRS0=sMz+=LM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F83BC48BE8
	for <iommu@archiver.kernel.org>; Fri, 18 Jun 2021 13:12:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A729613EB
	for <iommu@archiver.kernel.org>; Fri, 18 Jun 2021 13:12:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A729613EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C0B89403CB;
	Fri, 18 Jun 2021 13:12:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Gjf3S1mOKReP; Fri, 18 Jun 2021 13:12:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D9F80403B4;
	Fri, 18 Jun 2021 13:12:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA5B5C000D;
	Fri, 18 Jun 2021 13:12:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D843C000B
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 13:12:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6C7F6400EA
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 13:12:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Lyj8nSpt6iBd for <iommu@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 13:12:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 98F37400DF
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 13:12:50 +0000 (UTC)
IronPort-SDR: OAWEtUrQDsIxtTqcxZ2Uv9ea27H75AGvwfouc0ms337IzfRpxd5OohgTXUsKHDLOf+8jem2+FP
 0ZgIKqhOBoBQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="270398922"
X-IronPort-AV: E=Sophos;i="5.83,283,1616482800"; d="scan'208";a="270398922"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2021 06:12:48 -0700
IronPort-SDR: HoZxFEQod0VKcin9iZGxkCwHY2CBQcNur3HHKhv223Slcfm07jcUGAzBZBs7z+NrXFIWIsG7X9
 XkOLz7xf7HFw==
X-IronPort-AV: E=Sophos;i="5.83,283,1616482800"; d="scan'208";a="485684621"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.212.157])
 ([10.254.212.157])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2021 06:12:45 -0700
Subject: Re: [PATCH v14 4/6] iommu/vt-d: Add support for IOMMU default DMA
 mode build options
To: John Garry <john.garry@huawei.com>, joro@8bytes.org, will@kernel.org,
 dwmw2@infradead.org, robin.murphy@arm.com, corbet@lwn.net
References: <1624016058-189713-1-git-send-email-john.garry@huawei.com>
 <1624016058-189713-5-git-send-email-john.garry@huawei.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <dd20c637-1837-4ca2-8360-64d2a8d265d3@linux.intel.com>
Date: Fri, 18 Jun 2021 21:12:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1624016058-189713-5-git-send-email-john.garry@huawei.com>
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
> Make IOMMU_DEFAULT_LAZY default for when INTEL_IOMMU config is set,
> as is current behaviour.
> 
> Also delete global flag intel_iommu_strict:
> - In intel_iommu_setup(), call iommu_set_dma_strict(true) directly. Also
>    remove the print, as iommu_subsys_init() prints the mode and we have
>    already marked this param as deprecated.
> 
> - For cap_caching_mode() check in intel_iommu_setup(), call
>    iommu_set_dma_strict(true) directly; also reword the accompanying print
>    with a level downgrade and also add the missing '\n'.
> 
> - For Ironlake GPU, again call iommu_set_dma_strict(true) directly and
>    keep the accompanying print.
> 
> [jpg: Remove intel_iommu_strict]
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   drivers/iommu/Kconfig       |  1 +
>   drivers/iommu/intel/iommu.c | 15 ++++++---------
>   2 files changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 0327a942fdb7..c214a36eb2dc 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -94,6 +94,7 @@ choice
>   	prompt "IOMMU default DMA IOTLB invalidation mode"
>   	depends on IOMMU_DMA
>   
> +	default IOMMU_DEFAULT_LAZY if INTEL_IOMMU
>   	default IOMMU_DEFAULT_STRICT
>   	help
>   	  This option allows an IOMMU DMA IOTLB invalidation mode to be
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 29497113d748..06666f9d8116 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -361,7 +361,6 @@ int intel_iommu_enabled = 0;
>   EXPORT_SYMBOL_GPL(intel_iommu_enabled);
>   
>   static int dmar_map_gfx = 1;
> -static int intel_iommu_strict;
>   static int intel_iommu_superpage = 1;
>   static int iommu_identity_mapping;
>   static int iommu_skip_te_disable;
> @@ -455,8 +454,7 @@ static int __init intel_iommu_setup(char *str)
>   			iommu_dma_forcedac = true;
>   		} else if (!strncmp(str, "strict", 6)) {
>   			pr_warn("intel_iommu=strict deprecated; use iommu.strict=1 instead\n");
> -			pr_info("Disable batched IOTLB flush\n");
> -			intel_iommu_strict = 1;
> +			iommu_set_dma_strict(true);
>   		} else if (!strncmp(str, "sp_off", 6)) {
>   			pr_info("Disable supported super page\n");
>   			intel_iommu_superpage = 0;
> @@ -4382,9 +4380,9 @@ int __init intel_iommu_init(void)
>   		 * is likely to be much lower than the overhead of synchronizing
>   		 * the virtual and physical IOMMU page-tables.
>   		 */
> -		if (!intel_iommu_strict && cap_caching_mode(iommu->cap)) {
> -			pr_warn("IOMMU batching is disabled due to virtualization");
> -			intel_iommu_strict = 1;
> +		if (cap_caching_mode(iommu->cap)) {
> +			pr_info_once("IOMMU batching disallowed due to virtualization\n");
> +			iommu_set_dma_strict(true);
>   		}
>   		iommu_device_sysfs_add(&iommu->iommu, NULL,
>   				       intel_iommu_groups,
> @@ -4393,7 +4391,6 @@ int __init intel_iommu_init(void)
>   	}
>   	up_read(&dmar_global_lock);
>   
> -	iommu_set_dma_strict(intel_iommu_strict);
>   	bus_set_iommu(&pci_bus_type, &intel_iommu_ops);
>   	if (si_domain && !hw_pass_through)
>   		register_memory_notifier(&intel_iommu_memory_nb);
> @@ -5702,8 +5699,8 @@ static void quirk_calpella_no_shadow_gtt(struct pci_dev *dev)
>   	} else if (dmar_map_gfx) {
>   		/* we have to ensure the gfx device is idle before we flush */
>   		pci_info(dev, "Disabling batched IOTLB flush on Ironlake\n");
> -		intel_iommu_strict = 1;
> -       }
> +		iommu_set_dma_strict(true);
> +	}
>   }
>   DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0040, quirk_calpella_no_shadow_gtt);
>   DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0044, quirk_calpella_no_shadow_gtt);
> 

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
