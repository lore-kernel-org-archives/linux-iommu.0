Return-Path: <SRS0=nNEG=IB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DEA0C433DB
	for <iommu@archiver.kernel.org>; Wed,  3 Mar 2021 05:05:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05BEE64EBA
	for <iommu@archiver.kernel.org>; Wed,  3 Mar 2021 05:05:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05BEE64EBA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9617E43200;
	Wed,  3 Mar 2021 05:05:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QOtx5p1wpmQb; Wed,  3 Mar 2021 05:05:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 86E824321F;
	Wed,  3 Mar 2021 05:05:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F0D2C000A;
	Wed,  3 Mar 2021 05:05:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E84A3C0001
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 05:05:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C91BC6F60C
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 05:05:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OE6RPO9NMQ5t for <iommu@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 05:05:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 235606F5F0
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 05:05:36 +0000 (UTC)
IronPort-SDR: dHqNuJnkhLysNXCd6XfPm9XZ2TS116fWJmq5QSbgpGmcaH041AKK/1tCInydCqobAE4KQbvmRE
 UuixB+BRoWcQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="174224749"
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; d="scan'208";a="174224749"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2021 21:05:35 -0800
IronPort-SDR: 6N2e6t3C0vD1bK+9VPpST7R5y91de6mZdMt1BziH1esbyl/T8rJwFrl5hzdiW7ThZb24DUVddq
 Ibnt9yW1gSFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; d="scan'208";a="428035582"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128])
 ([10.239.159.128])
 by fmsmga004.fm.intel.com with ESMTP; 02 Mar 2021 21:05:33 -0800
Subject: Re: [PATCH v2 1/4] iommu/vt-d: Enable write protect for supervisor SVM
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
References: <1614680040-1989-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1614680040-1989-2-git-send-email-jacob.jun.pan@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <9190a39d-13c2-c288-e8cd-a1c8adb8e600@linux.intel.com>
Date: Wed, 3 Mar 2021 12:56:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1614680040-1989-2-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Sanjay Kumar <sanjay.k.kumar@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
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

On 3/2/21 6:13 PM, Jacob Pan wrote:
> Write protect bit, when set, inhibits supervisor writes to the read-only
> pages. In supervisor shared virtual addressing (SVA), where page tables
> are shared between CPU and DMA, IOMMU PASID entry WPE bit should match
> CR0.WP bit in the CPU.
> This patch sets WPE bit for supervisor PASIDs if CR0.WP is set.
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

Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
