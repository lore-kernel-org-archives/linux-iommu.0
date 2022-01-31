Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51364C433F5
	for <iommu@archiver.kernel.org>; Mon, 31 Jan 2022 15:53:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EB74060797;
	Mon, 31 Jan 2022 15:53:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xwSy_7DrR1zS; Mon, 31 Jan 2022 15:53:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D81F3606A9;
	Mon, 31 Jan 2022 15:53:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BD374C001A;
	Mon, 31 Jan 2022 15:53:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 06BA9C000B
 for <iommu@lists.linux-foundation.org>; Mon, 31 Jan 2022 15:53:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E74FB813C7
 for <iommu@lists.linux-foundation.org>; Mon, 31 Jan 2022 15:53:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id spj9IueyFZs1 for <iommu@lists.linux-foundation.org>;
 Mon, 31 Jan 2022 15:53:29 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2C745812FF
 for <iommu@lists.linux-foundation.org>; Mon, 31 Jan 2022 15:53:29 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 28E494DC; Mon, 31 Jan 2022 16:53:27 +0100 (CET)
Date: Mon, 31 Jan 2022 16:53:25 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 2/2] iommu/vt-d: Fix potential memory leak in
 intel_setup_irq_remapping()
Message-ID: <YfgF9Rl49aS2NNSS@8bytes.org>
References: <20220128031002.2219155-1-baolu.lu@linux.intel.com>
 <20220128031002.2219155-3-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220128031002.2219155-3-baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org, Guoqing Jiang <guoqing.jiang@linux.dev>
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

On Fri, Jan 28, 2022 at 11:10:02AM +0800, Lu Baolu wrote:
> From: Guoqing Jiang <guoqing.jiang@linux.dev>
> 
> After commit e3beca48a45b ("irqdomain/treewide: Keep firmware node
> unconditionally allocated"). For tear down scenario, fn is only freed
> after fail to allocate ir_domain, though it also should be freed in case
> dmar_enable_qi returns error.
> 
> Besides free fn, irq_domain and ir_msi_domain need to be removed as well
> if intel_setup_irq_remapping fails to enable queued invalidation.
> 
> Improve the rewinding path by add out_free_ir_domain and out_free_fwnode
> lables per Baolu's suggestion.
> 
> Fixes: e3beca48a45b ("irqdomain/treewide: Keep firmware node unconditionally allocated")
> Suggested-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> Link: https://lore.kernel.org/r/20220119063640.16864-1-guoqing.jiang@linux.dev
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/irq_remapping.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)

Applied this one, thanks.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
