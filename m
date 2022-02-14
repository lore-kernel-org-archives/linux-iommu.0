Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C018C433EF
	for <iommu@archiver.kernel.org>; Mon, 14 Feb 2022 13:05:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D9BD7813CC;
	Mon, 14 Feb 2022 13:05:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qYgCl0Sc3KKk; Mon, 14 Feb 2022 13:05:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B1BC5813C0;
	Mon, 14 Feb 2022 13:05:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E256C0011;
	Mon, 14 Feb 2022 13:05:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E5C8AC000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 13:05:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C4B0D4015E
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 13:05:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YGdVL6TQdZMR for <iommu@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 13:05:15 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1138B400E0
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 13:05:14 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 18F206BF; Mon, 14 Feb 2022 14:05:12 +0100 (CET)
Date: Mon, 14 Feb 2022 14:05:10 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu: Remove trivial ops->capable implementations
Message-ID: <YgpThrw8QWgc4GuR@8bytes.org>
References: <8413578c6f8a7cf75530b00cba8f10f5b88f8517.1644495614.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8413578c6f8a7cf75530b00cba8f10f5b88f8517.1644495614.git.robin.murphy@arm.com>
Cc: iommu@lists.linux-foundation.org, will@kernel.org,
 linux-kernel@vger.kernel.org
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

On Thu, Feb 10, 2022 at 12:29:05PM +0000, Robin Murphy wrote:
> Implementing ops->capable to always return false is pointless since it's
> the default behaviour anyway. Clean up the unnecessary implementations.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> Spinning this out of my bus ops stuff (currently 30 patches and
> counting...) since it would be better off alongside Baolu's cleanup
> series to avoid conflicts, and I want to depend on those patches for
> dev_iommu_ops() anyway.
> 
>  drivers/iommu/msm_iommu.c  | 6 ------
>  drivers/iommu/tegra-gart.c | 6 ------
>  drivers/iommu/tegra-smmu.c | 6 ------
>  3 files changed, 18 deletions(-)

Applied, thanks Robin.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
