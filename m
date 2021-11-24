Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 564F5C433F5
	for <iommu@archiver.kernel.org>; Wed, 24 Nov 2021 14:05:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DC74B40197;
	Wed, 24 Nov 2021 14:05:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Iybg-Ns9K1pH; Wed, 24 Nov 2021 14:05:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CD42140235;
	Wed, 24 Nov 2021 14:05:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9DB2AC001E;
	Wed, 24 Nov 2021 14:05:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14171C0012
 for <iommu@lists.linux-foundation.org>; Wed, 24 Nov 2021 14:05:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E71B340476
 for <iommu@lists.linux-foundation.org>; Wed, 24 Nov 2021 14:05:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J1rxpQj9yx2Q for <iommu@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 14:05:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 92F3C401CF
 for <iommu@lists.linux-foundation.org>; Wed, 24 Nov 2021 14:05:21 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3873ED1;
 Wed, 24 Nov 2021 06:05:20 -0800 (PST)
Received: from [10.57.56.56] (unknown [10.57.56.56])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 66E5D3F73B;
 Wed, 24 Nov 2021 06:05:19 -0800 (PST)
Message-ID: <0dfb2ee7-e6ec-f085-ed16-650e646d24d7@arm.com>
Date: Wed, 24 Nov 2021 14:05:15 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 1/9] gpu: host1x: Add missing DMA API include
Content-Language: en-GB
From: Robin Murphy <robin.murphy@arm.com>
To: Thierry Reding <thierry.reding@gmail.com>,
 Mikko Perttunen <mperttunen@nvidia.com>
References: <cover.1637671820.git.robin.murphy@arm.com>
 <d7bc49bfda25a7ea19dc574f8e212cd9e42bf2e2.1637671820.git.robin.murphy@arm.com>
In-Reply-To: <d7bc49bfda25a7ea19dc574f8e212cd9e42bf2e2.1637671820.git.robin.murphy@arm.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 iommu@lists.linux-foundation.org, willy@infradead.org,
 linux-tegra@vger.kernel.org, will@kernel.org
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

On 2021-11-23 14:10, Robin Murphy wrote:
> Host1x seems to be relying on picking up dma-mapping.h transitively from
> iova.h, which has no reason to include it in the first place. Fix the
> former issue before we totally break things by fixing the latter one.
> 
> CC: Thierry Reding <thierry.reding@gmail.com>
> CC: Mikko Perttunen <mperttunen@nvidia.com>
> CC: dri-devel@lists.freedesktop.org
> CC: linux-tegra@vger.kernel.org
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> Feel free to pick this into drm-misc-next or drm-misc-fixes straight
> away if that suits - it's only to avoid a build breakage once the rest
> of the series gets queued.

Bah, seems like tegra-vic needs the same treatment too, but wasn't in my 
local config. Should I squash that into a respin of this patch on the 
grounds of being vaguely related, or would you prefer it separate?

(Either way I'll wait a little while to see if the buildbots uncover any 
more...)

Cheers,
Robin.

>   drivers/gpu/host1x/bus.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/host1x/bus.c b/drivers/gpu/host1x/bus.c
> index 218e3718fd68..881fad5c3307 100644
> --- a/drivers/gpu/host1x/bus.c
> +++ b/drivers/gpu/host1x/bus.c
> @@ -5,6 +5,7 @@
>    */
>   
>   #include <linux/debugfs.h>
> +#include <linux/dma-mapping.h>
>   #include <linux/host1x.h>
>   #include <linux/of.h>
>   #include <linux/seq_file.h>
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
