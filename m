Return-Path: <SRS0=gpVu=HW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCEFCC433E0
	for <iommu@archiver.kernel.org>; Sat, 20 Feb 2021 02:05:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40BEA64EAF
	for <iommu@archiver.kernel.org>; Sat, 20 Feb 2021 02:05:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40BEA64EAF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DA9116F608
	for <iommu@archiver.kernel.org>; Sat, 20 Feb 2021 02:05:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Hdt-FTLO7Vgt for <iommu@archiver.kernel.org>;
	Sat, 20 Feb 2021 02:05:23 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
	id 6AC176F615; Sat, 20 Feb 2021 02:05:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6DC256F4B0;
	Sat, 20 Feb 2021 02:05:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44789C000B;
	Sat, 20 Feb 2021 02:05:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3271BC0001
 for <iommu@lists.linux-foundation.org>; Sat, 20 Feb 2021 02:05:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0C0F96F4B0
 for <iommu@lists.linux-foundation.org>; Sat, 20 Feb 2021 02:05:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WDwgJYDZsECc for <iommu@lists.linux-foundation.org>;
 Sat, 20 Feb 2021 02:05:19 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
 id 488746F51D; Sat, 20 Feb 2021 02:05:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 98B276F4B8
 for <iommu@lists.linux-foundation.org>; Sat, 20 Feb 2021 02:05:17 +0000 (UTC)
IronPort-SDR: M3vTzahj8ydjtcj44uTz4NX9Kg20w5nSOEqOn2JcO79Rg+yFPaM+hxe6L6XNdMi91iXHcmgf7o
 1qDm0+Y0l3tA==
X-IronPort-AV: E=McAfee;i="6000,8403,9900"; a="268884333"
X-IronPort-AV: E=Sophos;i="5.81,191,1610438400"; d="scan'208";a="268884333"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2021 18:05:16 -0800
IronPort-SDR: L4szXu6McC6DCriW0XNhCH60S6/xZTDzjLsldnupGU/EfYEAErcAU5uQpZ8BIvEu6tgd1F3c8/
 1/nBEFLkwzNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,191,1610438400"; d="scan'208";a="420512454"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128])
 ([10.239.159.128])
 by fmsmga004.fm.intel.com with ESMTP; 19 Feb 2021 18:05:09 -0800
Subject: Re: [PATCH 1/4] iommu/vt-d: Enable write protect for supervisor SVM
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Joerg Roedel <joro@8bytes.org>
References: <1613683878-89946-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1613683878-89946-2-git-send-email-jacob.jun.pan@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <fba522cc-7f34-a090-4669-e7720452033b@linux.intel.com>
Date: Sat, 20 Feb 2021 09:56:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1613683878-89946-2-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Raj Ashok <ashok.raj@intel.com>, Sanjay Kumar <sanjay.k.kumar@intel.com>,
 Yi Sun <yi.y.sun@intel.com>, Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Wu Hao <hao.wu@intel.com>
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

Hi Jacob and Sanjay,

On 2/19/21 5:31 AM, Jacob Pan wrote:
> Write protect bit, when set, inhibits supervisor writes to the read-only
> pages. In supervisor shared virtual addressing (SVA), where page tables
> are shared between CPU and DMA, IOMMU PASID entry WPE bit should match
> CR0.WP bit in the CPU.
> This patch sets WPE bit for supervisor PASIDs if CR0.WP is set.

 From reading the commit message, the intention of this patch is to match
PASID entry WPE bith with CPU CR0.WP if 1) SRE is set (supervisor
pasid); 2) page table is shared between CPU and IOMMU. Do I understand
it right?

But what the real code doing is failing pasid entry setup for first
level translation if CPU CR0.WP is not set. It's not consistent with
what described above.

What I am thinking is that, as long as SRE is set, we should always set
WPE in intel_pasid_setup_first_level(). For supervisor SVA case, we
should check CPU CR0.WP in intel_svm_bind_mm() and abort binding if
CR0.WP is not set.

Thought?

Best regards,
baolu

> 
> Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>   drivers/iommu/intel/pasid.c | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index 0cceaabc3ce6..0b7e0e726ade 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -410,6 +410,15 @@ static inline void pasid_set_sre(struct pasid_entry *pe)
>   	pasid_set_bits(&pe->val[2], 1 << 0, 1);
>   }
>   
> +/*
> + * Setup the WPE(Write Protect Enable) field (Bit 132) of a
> + * scalable mode PASID entry.
> + */
> +static inline void pasid_set_wpe(struct pasid_entry *pe)
> +{
> +	pasid_set_bits(&pe->val[2], 1 << 4, 1 << 4);
> +}
> +
>   /*
>    * Setup the P(Present) field (Bit 0) of a scalable mode PASID
>    * entry.
> @@ -553,6 +562,20 @@ static void pasid_flush_caches(struct intel_iommu *iommu,
>   	}
>   }
>   
> +static inline int pasid_enable_wpe(struct pasid_entry *pte)
> +{
> +	unsigned long cr0 = read_cr0();
> +
> +	/* CR0.WP is normally set but just to be sure */
> +	if (unlikely(!(cr0 & X86_CR0_WP))) {
> +		pr_err_ratelimited("No CPU write protect!\n");
> +		return -EINVAL;
> +	}
> +	pasid_set_wpe(pte);
> +
> +	return 0;
> +};
> +
>   /*
>    * Set up the scalable mode pasid table entry for first only
>    * translation type.
> @@ -584,6 +607,9 @@ int intel_pasid_setup_first_level(struct intel_iommu *iommu,
>   			return -EINVAL;
>   		}
>   		pasid_set_sre(pte);
> +		if (pasid_enable_wpe(pte))
> +			return -EINVAL;
> +
>   	}
>   
>   	if (flags & PASID_FLAG_FL5LP) {
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
