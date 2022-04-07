Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F735C433EF
	for <iommu@archiver.kernel.org>; Thu,  7 Apr 2022 05:39:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 01CAA83E7A;
	Thu,  7 Apr 2022 05:39:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G3hMEsZeCrAN; Thu,  7 Apr 2022 05:39:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D40BD83E4A;
	Thu,  7 Apr 2022 05:39:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3641C001D;
	Thu,  7 Apr 2022 05:39:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 85851C0012
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 05:39:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5D69C4188C
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 05:39:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nfS7P3-ewtHG for <iommu@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 05:39:08 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from muru.com (muru.com [72.249.23.125])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1B1D341867
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 05:39:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 18A668138;
 Thu,  7 Apr 2022 05:36:44 +0000 (UTC)
Date: Thu, 7 Apr 2022 08:39:05 +0300
From: Tony Lindgren <tony@atomide.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH] iommu/omap: Fix regression in probe for NULL pointer
 dereference
Message-ID: <Yk54+S0iaMueWN63@atomide.com>
References: <20220331062301.24269-1-tony@atomide.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220331062301.24269-1-tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Drew Fustini <dfustini@baylibre.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi,

* Tony Lindgren <tony@atomide.com> [220331 09:21]:
> Commit 3f6634d997db ("iommu: Use right way to retrieve iommu_ops") started
> triggering a NULL pointer dereference for some omap variants:
> 
> __iommu_probe_device from probe_iommu_group+0x2c/0x38
> probe_iommu_group from bus_for_each_dev+0x74/0xbc
> bus_for_each_dev from bus_iommu_probe+0x34/0x2e8
> bus_iommu_probe from bus_set_iommu+0x80/0xc8
> bus_set_iommu from omap_iommu_init+0x88/0xcc
> omap_iommu_init from do_one_initcall+0x44/0x24
> 
> This is caused by omap iommu probe returning 0 instead of ERR_PTR(-ENODEV)
> as noted by Jason Gunthorpe <jgg@ziepe.ca>.
> 
> Looks like the regression already happened with an earlier commit
> 6785eb9105e3 ("iommu/omap: Convert to probe/release_device() call-backs")
> that changed the function return type and missed converting one place.

Can you guys please get this fix into the -rc series? Or ack it so
I can pick it up into my fixes branch?

Without this fix booting is failing for a bunch of devices.

Regards,

Tony


> Cc: Drew Fustini <dfustini@baylibre.com>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Cc: Suman Anna <s-anna@ti.com>
> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> Fixes: 6785eb9105e3 ("iommu/omap: Convert to probe/release_device() call-backs")
> Fixes: 3f6634d997db ("iommu: Use right way to retrieve iommu_ops")
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/iommu/omap-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
> --- a/drivers/iommu/omap-iommu.c
> +++ b/drivers/iommu/omap-iommu.c
> @@ -1661,7 +1661,7 @@ static struct iommu_device *omap_iommu_probe_device(struct device *dev)
>  	num_iommus = of_property_count_elems_of_size(dev->of_node, "iommus",
>  						     sizeof(phandle));
>  	if (num_iommus < 0)
> -		return 0;
> +		return ERR_PTR(-ENODEV);
>  
>  	arch_data = kcalloc(num_iommus + 1, sizeof(*arch_data), GFP_KERNEL);
>  	if (!arch_data)
> -- 
> 2.35.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
