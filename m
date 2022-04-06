Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF7CC433F5
	for <iommu@archiver.kernel.org>; Wed,  6 Apr 2022 10:28:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 865DB40303;
	Wed,  6 Apr 2022 10:28:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MvWsJETTP_3d; Wed,  6 Apr 2022 10:28:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1CF4E40598;
	Wed,  6 Apr 2022 10:28:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D6EBCC002C;
	Wed,  6 Apr 2022 10:28:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4327AC0012
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 10:28:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1E48E40598
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 10:28:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zzSVB7MK1p7W for <iommu@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 10:28:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2840C4046D
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 10:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649240890; x=1680776890;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=ga3bmWpFRns3F8dX7fQDF54qJCQGZJAxmilcJLgTgi4=;
 b=fCgEuX3EjwfiO4Sr6qilaIWkBs/x7W8xgUO0QmYrWFHYoQvGj1b7AQSS
 vWdSkcerx/i+EBjyA3/Lf+HHWkw/eSFTRuEFfMN9y3QSEzP4DDiX18wOD
 zofZqBagIdA9KzLHVYokwoJImCFvVc5HnAyLMZZOFEiwxsA4x+Gpv37yT
 cdIXfgRV47Y6Spnzi6O68byXhvusFY303jxl6saA3UT6I6qXdQLkxNyeF
 8JS2MZnDWES6vXYV2qfGsijRkG0o1j5VC6matKPGu/JgM3c19qgyy27Ku
 yFrkdgJrmRF4L6zl3FLBvoGlg9vt+VBmL4SLAebSf4bt0D8NdOSL8XCBN w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="285977031"
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; d="scan'208";a="285977031"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Apr 2022 03:28:08 -0700
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; d="scan'208";a="570453045"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.215.82])
 ([10.254.215.82])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Apr 2022 03:28:04 -0700
Message-ID: <b2bcd37a-08aa-0c49-8181-063beb43fc41@linux.intel.com>
Date: Wed, 6 Apr 2022 18:28:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 2/4] iommu: Add capability for pre-boot DMA protection
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
 andreas.noever@gmail.com, michael.jamet@intel.com,
 mika.westerberg@linux.intel.com, YehezkelShB@gmail.com
References: <cover.1649089693.git.robin.murphy@arm.com>
 <2b5dc62a6325075cb5bd1ceec31ebad1833acf83.1649089693.git.robin.murphy@arm.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <2b5dc62a6325075cb5bd1ceec31ebad1833acf83.1649089693.git.robin.murphy@arm.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, mario.limonciello@amd.com, hch@lst.de
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

On 2022/4/5 18:41, Robin Murphy wrote:
> VT-d's dmar_platform_optin() actually represents a combination of
> properties fairly well standardised by Microsoft as "Pre-boot DMA
> Protection" and "Kernel DMA Protection"[1]. As such, we can provide
> interested consumers with an abstracted capability rather than
> driver-specific interfaces that won't scale. We name it for the former
> aspect since that's what external callers are most likely to be
> interested in; the latter is for the IOMMU layer to handle itself.
> 
> [1] https://docs.microsoft.com/en-us/windows-hardware/design/device-experiences/oem-kernel-dma-protection
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
>   drivers/iommu/intel/iommu.c | 2 ++
>   include/linux/iommu.h       | 2 ++
>   2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 255304eb3b1f..49d552a96098 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4550,6 +4550,8 @@ static bool intel_iommu_capable(struct device *dev, enum iommu_cap cap)
>   		return domain_update_iommu_snooping(NULL);
>   	if (cap == IOMMU_CAP_INTR_REMAP)
>   		return irq_remapping_enabled == 1;
> +	if (cap == IOMMU_CAP_PRE_BOOT_PROTECTION)
> +		return dmar_platform_optin();
>   
>   	return false;
>   }
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 1fa927e6f1c6..64c02f472f7b 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -107,6 +107,8 @@ enum iommu_cap {
>   					   transactions */
>   	IOMMU_CAP_INTR_REMAP,		/* IOMMU supports interrupt isolation */
>   	IOMMU_CAP_NOEXEC,		/* IOMMU_NOEXEC flag */
> +	IOMMU_CAP_PRE_BOOT_PROTECTION,	/* Firmware says it used the IOMMU for
> +					   DMA protection and we should too */
>   };
>   
>   /* These are the possible reserved region types */
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
