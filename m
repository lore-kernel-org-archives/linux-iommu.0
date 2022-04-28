Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABF6EC433EF
	for <iommu@archiver.kernel.org>; Thu, 28 Apr 2022 09:32:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 35BA2400C1;
	Thu, 28 Apr 2022 09:32:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NtHnA3LRvUZ7; Thu, 28 Apr 2022 09:32:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1BC38401A4;
	Thu, 28 Apr 2022 09:32:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2637C0039;
	Thu, 28 Apr 2022 09:32:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6266AC002D
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 09:32:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3FF6581326
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 09:32:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kWQSHKIDfPEF for <iommu@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 09:32:08 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0141F81318
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 09:32:07 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id CCD492FB; Thu, 28 Apr 2022 11:32:05 +0200 (CEST)
Date: Thu, 28 Apr 2022 11:32:04 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [RESEND PATCH v8 00/11] Fix BUG_ON in vfio_iommu_group_notifier()
Message-ID: <YmpfFA1iIQyGBipX@8bytes.org>
References: <20220418005000.897664-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220418005000.897664-1-baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux-foundation.org,
 Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org
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

On Mon, Apr 18, 2022 at 08:49:49AM +0800, Lu Baolu wrote:
> Lu Baolu (10):
>   iommu: Add DMA ownership management interfaces
>   driver core: Add dma_cleanup callback in bus_type
>   amba: Stop sharing platform_dma_configure()
>   bus: platform,amba,fsl-mc,PCI: Add device DMA ownership management
>   PCI: pci_stub: Set driver_managed_dma
>   PCI: portdrv: Set driver_managed_dma
>   vfio: Set DMA ownership for VFIO devices
>   vfio: Remove use of vfio_group_viable()
>   vfio: Remove iommu group notifier
>   iommu: Remove iommu group changes notifier

Applied to core branch, thanks Baolu.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
