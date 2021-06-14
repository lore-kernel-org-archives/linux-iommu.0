Return-Path: <SRS0=DplC=LI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6197AC2B9F4
	for <iommu@archiver.kernel.org>; Mon, 14 Jun 2021 16:25:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 056BD61378
	for <iommu@archiver.kernel.org>; Mon, 14 Jun 2021 16:25:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 056BD61378
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C5A9140189;
	Mon, 14 Jun 2021 16:25:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sJXlGAacc-TO; Mon, 14 Jun 2021 16:25:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B477C400C3;
	Mon, 14 Jun 2021 16:25:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8166BC000E;
	Mon, 14 Jun 2021 16:25:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D36C6C000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 16:25:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A717883ACA
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 16:25:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mfCE1dPd2zqI for <iommu@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 16:25:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 68C9F83AC5
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 16:25:17 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A6F71FB;
 Mon, 14 Jun 2021 09:25:16 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B7B23F70D;
 Mon, 14 Jun 2021 09:25:14 -0700 (PDT)
Subject: Re: [PATCH v12 5/5] iommu: Remove mode argument from
 iommu_set_dma_strict()
To: John Garry <john.garry@huawei.com>, joro@8bytes.org, will@kernel.org,
 dwmw2@infradead.org, baolu.lu@linux.intel.com
References: <1623414043-40745-1-git-send-email-john.garry@huawei.com>
 <1623414043-40745-6-git-send-email-john.garry@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <868374d4-e816-b607-82de-7e7c27a4c66b@arm.com>
Date: Mon, 14 Jun 2021 17:25:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <1623414043-40745-6-git-send-email-john.garry@huawei.com>
Content-Language: en-GB
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 linuxarm@huawei.com
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

On 2021-06-11 13:20, John Garry wrote:
> We only ever now set strict mode enabled in iommu_set_dma_strict(), so
> just remove the argument.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   drivers/iommu/amd/init.c    | 2 +-
>   drivers/iommu/intel/iommu.c | 6 +++---
>   drivers/iommu/iommu.c       | 5 ++---
>   include/linux/iommu.h       | 2 +-
>   4 files changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 0e6ae6d68f14..27e9677ec303 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -3098,7 +3098,7 @@ static int __init parse_amd_iommu_options(char *str)
>   {
>   	for (; *str; ++str) {
>   		if (strncmp(str, "fullflush", 9) == 0)
> -			iommu_set_dma_strict(true);
> +			iommu_set_dma_strict();
>   		if (strncmp(str, "force_enable", 12) == 0)
>   			amd_iommu_force_enable = true;
>   		if (strncmp(str, "off", 3) == 0)
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 6763e516362c..e77b8b6e7838 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -452,7 +452,7 @@ static int __init intel_iommu_setup(char *str)
>   			pr_warn("intel_iommu=forcedac deprecated; use iommu.forcedac instead\n");
>   			iommu_dma_forcedac = true;
>   		} else if (!strncmp(str, "strict", 6)) {
> -			iommu_set_dma_strict(true);
> +			iommu_set_dma_strict();
>   		} else if (!strncmp(str, "sp_off", 6)) {
>   			pr_info("Disable supported super page\n");
>   			intel_iommu_superpage = 0;
> @@ -4392,7 +4392,7 @@ int __init intel_iommu_init(void)
>   		 */
>   		if (cap_caching_mode(iommu->cap)) {
>   			pr_warn("IOMMU batching disallowed due to virtualization\n");
> -			iommu_set_dma_strict(true);
> +			iommu_set_dma_strict();
>   		}
>   		iommu_device_sysfs_add(&iommu->iommu, NULL,
>   				       intel_iommu_groups,
> @@ -5663,7 +5663,7 @@ static void quirk_calpella_no_shadow_gtt(struct pci_dev *dev)
>   	} else if (dmar_map_gfx) {
>   		/* we have to ensure the gfx device is idle before we flush */
>   		pci_info(dev, "Disabling batched IOTLB flush on Ironlake\n");
> -		iommu_set_dma_strict(true);
> +		iommu_set_dma_strict();
>   	}
>   }
>   DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0040, quirk_calpella_no_shadow_gtt);
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index ccbd5d4c1a50..146cb71c7441 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -350,10 +350,9 @@ static int __init iommu_dma_setup(char *str)
>   }
>   early_param("iommu.strict", iommu_dma_setup);
>   
> -void iommu_set_dma_strict(bool strict)
> +void iommu_set_dma_strict(void)
>   {
> -	if (strict || !(iommu_cmd_line & IOMMU_CMD_LINE_STRICT))

We shouldn't need to keep IOMMU_CMD_LINE_STRICT at all now, since it was 
only to prevent a driver's "default lazy" setting passed in here from 
downgrading an explicitly-set strict mode.

With that cleaned up too,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Thanks,
Robin.

> -		iommu_dma_strict = strict;
> +		iommu_dma_strict = true;
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
