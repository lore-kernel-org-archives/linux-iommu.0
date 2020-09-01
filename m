Return-Path: <SRS0=Ln9J=CK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F590C433E6
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 05:21:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFD7C2098B
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 05:21:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFD7C2098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8A59386CBA;
	Tue,  1 Sep 2020 05:21:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yspb3EykhPxE; Tue,  1 Sep 2020 05:21:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 42C4986CAF;
	Tue,  1 Sep 2020 05:21:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 27AF5C088B;
	Tue,  1 Sep 2020 05:21:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EFC4DC0052
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 05:21:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E2F342E11B
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 05:21:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7sOBOwc9i374 for <iommu@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 05:21:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by silver.osuosl.org (Postfix) with ESMTPS id 590D92E6C3
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 05:07:14 +0000 (UTC)
IronPort-SDR: pE/eqxPiOkQOHOszs4xoaIyvXTjdGeDrblUYQiRh6eHIQgqowcNFcbeXuLr7Y94fBilG17dfYq
 P8KMHRqH8f/Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9730"; a="156365283"
X-IronPort-AV: E=Sophos;i="5.76,378,1592895600"; d="scan'208";a="156365283"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2020 22:07:13 -0700
IronPort-SDR: 5BrF89Ds56JAWzIPrEEZmlupmHJC7RcnAmgHBryoMQ/RHDWLrAw0mSwK4luS59h7SpNQkTgV2g
 Ewe6pQi4EbPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,378,1592895600"; d="scan'208";a="325201343"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139])
 ([10.239.159.139])
 by fmsmga004.fm.intel.com with ESMTP; 31 Aug 2020 22:07:12 -0700
Subject: Re: [PATCH v1] iommu/vt-d: Move intel_iommu_gfx_mapped to Intel IOMMU
 header
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, David Woodhouse <dwmw2@infradead.org>,
 iommu@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>
References: <20200828161212.71294-1-andriy.shevchenko@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <5e9fef6a-7f75-d781-a39b-5cedbc08f3e2@linux.intel.com>
Date: Tue, 1 Sep 2020 13:01:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200828161212.71294-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
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

Hi Andy,

On 8/29/20 12:12 AM, Andy Shevchenko wrote:
> Static analyzer is not happy about intel_iommu_gfx_mapped declaration:
> 
> .../drivers/iommu/intel/iommu.c:364:5: warning: symbol 'intel_iommu_gfx_mapped' was not declared. Should it be static?
> 
> Move its declaration to Intel IOMMU header file.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   include/drm/intel-gtt.h     | 5 +----
>   include/linux/intel-iommu.h | 1 +
>   2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/include/drm/intel-gtt.h b/include/drm/intel-gtt.h
> index 71d81923e6b0..abfefaaf897a 100644
> --- a/include/drm/intel-gtt.h
> +++ b/include/drm/intel-gtt.h
> @@ -5,6 +5,7 @@
>   #define	_DRM_INTEL_GTT_H
>   
>   #include <linux/agp_backend.h>
> +#include <linux/intel-iommu.h>
>   #include <linux/kernel.h>
>   
>   void intel_gtt_get(u64 *gtt_total,
> @@ -33,8 +34,4 @@ void intel_gtt_clear_range(unsigned int first_entry, unsigned int num_entries);
>   /* flag for GFDT type */
>   #define AGP_USER_CACHED_MEMORY_GFDT (1 << 3)
>   
> -#ifdef CONFIG_INTEL_IOMMU
> -extern int intel_iommu_gfx_mapped;
> -#endif
> -
>   #endif
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 64fa5c56c825..fbd3bb64649b 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -794,6 +794,7 @@ extern int iommu_calculate_max_sagaw(struct intel_iommu *iommu);
>   extern int dmar_disabled;
>   extern int intel_iommu_enabled;
>   extern int intel_iommu_tboot_noforce;
> +extern int intel_iommu_gfx_mapped;
>   #else
>   static inline int iommu_calculate_agaw(struct intel_iommu *iommu)
>   {
> 

Looks good to me.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
