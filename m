Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1475C433EF
	for <iommu@archiver.kernel.org>; Mon, 17 Jan 2022 02:51:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 404E840340;
	Mon, 17 Jan 2022 02:51:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bRS92hK7NhXg; Mon, 17 Jan 2022 02:51:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 26C064031F;
	Mon, 17 Jan 2022 02:51:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F2EF0C0039;
	Mon, 17 Jan 2022 02:51:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C0BCC002F
 for <iommu@lists.linux-foundation.org>; Mon, 17 Jan 2022 02:51:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DFEBD60745
 for <iommu@lists.linux-foundation.org>; Mon, 17 Jan 2022 02:51:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eZ_NEbHR6fjZ for <iommu@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 02:51:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 03F0260615
 for <iommu@lists.linux-foundation.org>; Mon, 17 Jan 2022 02:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1642387900; x=1673923900;
 h=cc:subject:to:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=jg1Tf2dT4jserdB2iUYIPst9dVMzOQwhy5Oj7qFnvvA=;
 b=dVwa6fzrwRXr3aaHx8vZLtVv1TDWg5GFhFGgJIoceL5FzQcIYZ0CW8V4
 beRIi91KSNbxr+dFu3TQawcgNrO2nVh8GDKtiFgBvL+QN1QEA4Q/0Dy2B
 5v44rYHVnSXOG8uptDY0vovW8ggDA0bWW/o4L3FHwOq5HpoOh387V9ok7
 1+CN6weiL49H4zBNrdqYHLBGFLqePY3HkREuP68+4lko5RLMXTT2cSxkN
 ygEgwNAIQf+AZaJ9NQ1YDEtquIzyz1hshotA9ZjBCulCm9PAsFzY+HEt1
 wbDy3X9XBFlG+kW9AphavIHTRCpyyWazljL6rWk8PY8sFnqnN1CuoXx/F g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10229"; a="305273768"
X-IronPort-AV: E=Sophos;i="5.88,294,1635231600"; d="scan'208";a="305273768"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jan 2022 18:51:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,294,1635231600"; d="scan'208";a="531156742"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 16 Jan 2022 18:51:38 -0800
Subject: Re: [PATCH] iommu/intel: Fix potential memory leak in
 intel_setup_irq_remapping
To: Guoqing Jiang <guoqing.jiang@linux.dev>, dwmw2@infradead.org,
 joro@8bytes.org, will@kernel.org
References: <20211229085608.18307-1-guoqing.jiang@linux.dev>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <b44cec90-2d0b-0f49-b1aa-796f847eae70@linux.intel.com>
Date: Mon, 17 Jan 2022 10:50:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211229085608.18307-1-guoqing.jiang@linux.dev>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org
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

On 12/29/21 4:56 PM, Guoqing Jiang wrote:
> Call irq_domain_free_fwnode to free 'fn' if dmar_enable_qi returns
> failure, same as when irq_domain_create_hierarchy returns failure.
> 
> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>

Add a "Fixes" tag if you think this change needs backport.

> ---
>   drivers/iommu/intel/irq_remapping.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
> index f912fe45bea2..6e8362c21fc3 100644
> --- a/drivers/iommu/intel/irq_remapping.c
> +++ b/drivers/iommu/intel/irq_remapping.c
> @@ -594,6 +594,7 @@ static int intel_setup_irq_remapping(struct intel_iommu *iommu)
>   		dmar_disable_qi(iommu);
>   
>   		if (dmar_enable_qi(iommu)) {
> +			irq_domain_free_fwnode(fn);
>   			pr_err("Failed to enable queued invalidation\n");
>   			goto out_free_bitmap;
>   		}
> 

The rewinding paths in intel_setup_irq_remapping() need more
enhancement. How about below changes?

diff --git a/drivers/iommu/intel/irq_remapping.c 
b/drivers/iommu/intel/irq_remapping.c
index f912fe45bea2..89c32bf173ef 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -569,9 +569,8 @@ static int intel_setup_irq_remapping(struct 
intel_iommu *iommu)
                                             fn, &intel_ir_domain_ops,
                                             iommu);
         if (!iommu->ir_domain) {
-               irq_domain_free_fwnode(fn);
                 pr_err("IR%d: failed to allocate irqdomain\n", 
iommu->seq_id);
-               goto out_free_bitmap;
+               goto out_free_fwnode;
         }
         iommu->ir_msi_domain =
                 arch_create_remap_msi_irq_domain(iommu->ir_domain,
@@ -595,7 +594,7 @@ static int intel_setup_irq_remapping(struct 
intel_iommu *iommu)

                 if (dmar_enable_qi(iommu)) {
                         pr_err("Failed to enable queued invalidation\n");
-                       goto out_free_bitmap;
+                       goto out_free_ir_domain;
                 }
         }

@@ -619,6 +618,14 @@ static int intel_setup_irq_remapping(struct 
intel_iommu *iommu)

         return 0;

+out_free_ir_domain:
+       if (iommu->ir_msi_domain)
+               irq_domain_remove(iommu->ir_msi_domain);
+       irq_domain_remove(iommu->ir_domain);
+       iommu->ir_msi_domain = NULL;
+       iommu->ir_domain = NULL;
+out_free_fwnode:
+       irq_domain_free_fwnode(fn);
  out_free_bitmap:
         bitmap_free(bitmap);
  out_free_pages:

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
