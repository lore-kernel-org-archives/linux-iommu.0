Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B729C433EF
	for <iommu@archiver.kernel.org>; Tue,  8 Mar 2022 06:42:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E6C44408D1;
	Tue,  8 Mar 2022 06:42:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lN-ofj06Vz6g; Tue,  8 Mar 2022 06:42:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6DE7C40462;
	Tue,  8 Mar 2022 06:42:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 50ED9C0012;
	Tue,  8 Mar 2022 06:42:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9F69FC000B
 for <iommu@lists.linux-foundation.org>; Tue,  8 Mar 2022 06:42:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 800A660B98
 for <iommu@lists.linux-foundation.org>; Tue,  8 Mar 2022 06:42:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kcOJIwAcHXpT for <iommu@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 06:42:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B7812600B6
 for <iommu@lists.linux-foundation.org>; Tue,  8 Mar 2022 06:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1646721750; x=1678257750;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=uSsImSiLVihQQavFgt4SR/ATlWWTNVvroUOjnmSFYKI=;
 b=CrdpnHaXAnVU74UOpj5Ewgo/ZlBMJHpszaL/U1fTzPxHCPz83kJgi4Z+
 jBx9IX8kmyEd4BmZ7OsOFr4vH8zMGhAi5noYrGhS6LANhqgNCkPDBTznx
 D7oJjpzpwJIBX0BfZKrpRPUMQ3Bqc0EyHzq+GKjiezaF4Tw7mVn9EjX6B
 YHASIQicC7yU31PUYj77i6qlxqhzXfkrHf5JOg8pMhTHXmpFzvILzKBOP
 7Z7wlPzG+tHLCqCJJAXowwfBJanYScpJ/HB9TdWNc2keZ8JMiwZAs/VAY
 mfYzLJFJvO3bUUMKx0xMDhRw8F2atFc0eKao/71meFfqkjTu2bB1CMdKM g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="315324064"
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; d="scan'208";a="315324064"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Mar 2022 22:42:30 -0800
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; d="scan'208";a="711428389"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.209.195])
 ([10.254.209.195])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Mar 2022 22:42:27 -0800
Message-ID: <2cde656d-ad3e-6371-1647-489963ab3c33@linux.intel.com>
Date: Tue, 8 Mar 2022 14:42:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 1/2] agp/intel: Use per device iommu check
Content-Language: en-US
To: David Airlie <airlied@linux.ie>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Chris Wilson <chris@chris-wilson.co.uk>,
 Nathan Myers <ncm@cantrip.org>
References: <20220211030531.2398789-1-baolu.lu@linux.intel.com>
 <20220211030531.2398789-2-baolu.lu@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220211030531.2398789-2-baolu.lu@linux.intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>
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

On 2022/2/11 11:05, Lu Baolu wrote:
> The IOMMU subsystem has already provided an interface to query whether
> the IOMMU hardware is enabled for a specific device. This changes the
> check from Intel specific intel_iommu_gfx_mapped (globally exported by
> the Intel IOMMU driver) to probing the presence of IOMMU on a specific
> device using the generic device_iommu_mapped().
> 
> This follows commit cca084692394a ("drm/i915: Use per device iommu check")
> which converted drm/i915 driver to use device_iommu_mapped().
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>   drivers/char/agp/intel-gtt.c | 17 +++++++----------
>   1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/char/agp/intel-gtt.c b/drivers/char/agp/intel-gtt.c
> index c53cc9868cd8..9631cbc7002e 100644
> --- a/drivers/char/agp/intel-gtt.c
> +++ b/drivers/char/agp/intel-gtt.c
> @@ -20,7 +20,7 @@
>   #include <linux/kernel.h>
>   #include <linux/pagemap.h>
>   #include <linux/agp_backend.h>
> -#include <linux/intel-iommu.h>
> +#include <linux/iommu.h>
>   #include <linux/delay.h>
>   #include <asm/smp.h>
>   #include "agp.h"
> @@ -573,18 +573,15 @@ static void intel_gtt_cleanup(void)
>    */
>   static inline int needs_ilk_vtd_wa(void)
>   {
> -#ifdef CONFIG_INTEL_IOMMU
>   	const unsigned short gpu_devid = intel_private.pcidev->device;
>   
> -	/* Query intel_iommu to see if we need the workaround. Presumably that
> -	 * was loaded first.
> +	/*
> +	 * Query iommu subsystem to see if we need the workaround. Presumably
> +	 * that was loaded first.
>   	 */
> -	if ((gpu_devid == PCI_DEVICE_ID_INTEL_IRONLAKE_D_IG ||
> -	     gpu_devid == PCI_DEVICE_ID_INTEL_IRONLAKE_M_IG) &&
> -	     intel_iommu_gfx_mapped)
> -		return 1;
> -#endif
> -	return 0;
> +	return ((gpu_devid == PCI_DEVICE_ID_INTEL_IRONLAKE_D_IG ||
> +		 gpu_devid == PCI_DEVICE_ID_INTEL_IRONLAKE_M_IG) &&
> +		device_iommu_mapped(&intel_private.pcidev->dev));
>   }
>   
>   static bool intel_gtt_can_wc(void)

A gentle ping ...:-)

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
