Return-Path: <SRS0=nNEG=IB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D74C433E0
	for <iommu@archiver.kernel.org>; Wed,  3 Mar 2021 05:06:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8250B64EBA
	for <iommu@archiver.kernel.org>; Wed,  3 Mar 2021 05:06:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8250B64EBA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 19B334EBCF;
	Wed,  3 Mar 2021 05:06:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K1TaUDgcLE_0; Wed,  3 Mar 2021 05:06:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id BFBFB4D500;
	Wed,  3 Mar 2021 05:06:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9ED75C000B;
	Wed,  3 Mar 2021 05:06:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 655E3C0001
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 05:06:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 53F2F4D4F1
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 05:06:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KMoQGyP3Nswm for <iommu@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 05:06:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 67FBC4D19D
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 05:06:16 +0000 (UTC)
IronPort-SDR: R3qDICCNzVjR976vHMIK0AYVcDivXWKz9RG4k7e0kilw9ZHvk2SlsSlvP//7H6KrDj6n21th/U
 0Wi8jhftlf+w==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="174739076"
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; d="scan'208";a="174739076"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2021 21:06:15 -0800
IronPort-SDR: 2c4Ag05Xnpus+ArzV0OBxfdEX2R3S3Eys+j+1+/KFIAcsKXGg+NAnCCBddEDDi0oAUmGqDRUnh
 RvU1nazkV9PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; d="scan'208";a="428035702"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128])
 ([10.239.159.128])
 by fmsmga004.fm.intel.com with ESMTP; 02 Mar 2021 21:06:12 -0800
Subject: Re: [PATCH v2 2/4] iommu/vt-d: Enable write protect propagation from
 guest
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
References: <1614680040-1989-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1614680040-1989-3-git-send-email-jacob.jun.pan@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <ed71158c-d906-f503-3372-dd7936a992ba@linux.intel.com>
Date: Wed, 3 Mar 2021 12:57:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1614680040-1989-3-git-send-email-jacob.jun.pan@linux.intel.com>
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
> pages. In guest supervisor shared virtual addressing (SVA), write-protect
> should be honored upon guest bind supervisor PASID request.
> 
> This patch extends the VT-d portion of the IOMMU UAPI to include WP bit.
> WPE bit of the  supervisor PASID entry will be set to match CPU CR0.WP bit.
> 
> Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>   drivers/iommu/intel/pasid.c | 3 +++
>   include/uapi/linux/iommu.h  | 3 ++-
>   2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index 0b7e0e726ade..b7e39239f539 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -763,6 +763,9 @@ intel_pasid_setup_bind_data(struct intel_iommu *iommu, struct pasid_entry *pte,
>   			return -EINVAL;
>   		}
>   		pasid_set_sre(pte);
> +		/* Enable write protect WP if guest requested */
> +		if (pasid_data->flags & IOMMU_SVA_VTD_GPASID_WPE)
> +			pasid_set_wpe(pte);
>   	}
>   
>   	if (pasid_data->flags & IOMMU_SVA_VTD_GPASID_EAFE) {
> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> index 35d48843acd8..3a9164cc9937 100644
> --- a/include/uapi/linux/iommu.h
> +++ b/include/uapi/linux/iommu.h
> @@ -288,7 +288,8 @@ struct iommu_gpasid_bind_data_vtd {
>   #define IOMMU_SVA_VTD_GPASID_PWT	(1 << 3) /* page-level write through */
>   #define IOMMU_SVA_VTD_GPASID_EMTE	(1 << 4) /* extended mem type enable */
>   #define IOMMU_SVA_VTD_GPASID_CD		(1 << 5) /* PASID-level cache disable */
> -#define IOMMU_SVA_VTD_GPASID_LAST	(1 << 6)
> +#define IOMMU_SVA_VTD_GPASID_WPE	(1 << 6) /* Write protect enable */
> +#define IOMMU_SVA_VTD_GPASID_LAST	(1 << 7)
>   	__u64 flags;
>   	__u32 pat;
>   	__u32 emt;
> 

Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
