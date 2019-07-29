Return-Path: <SRS0=zE+z=V2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C977C433FF
	for <iommu@archiver.kernel.org>; Mon, 29 Jul 2019 18:29:53 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA17F2073F
	for <iommu@archiver.kernel.org>; Mon, 29 Jul 2019 18:29:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA17F2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 65B251D0C;
	Mon, 29 Jul 2019 18:29:39 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 3A1FB16A5
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Jul 2019 16:31:47 +0000 (UTC)
X-Greylist: delayed 00:27:43 by SQLgrey-1.7.6
Received: from inca-roads.misterjones.org (inca-roads.misterjones.org
	[213.251.177.50])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id AD73B5E4
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Jul 2019 16:31:46 +0000 (UTC)
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
	(envelope-from <maz@kernel.org>)
	id 1hs87z-0000vv-BM; Mon, 29 Jul 2019 18:03:59 +0200
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/dma: Handle MSI mappings separately
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Date: Mon, 29 Jul 2019 17:03:59 +0100
From: Marc Zyngier <maz@kernel.org>
In-Reply-To: <2b2595de703c60a772ebcffe248d0cf036143e6a.1564414114.git.robin.murphy@arm.com>
References: <2b2595de703c60a772ebcffe248d0cf036143e6a.1564414114.git.robin.murphy@arm.com>
Message-ID: <c2ff38164489ca24ef4364ab83b10e76@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: robin.murphy@arm.com, joro@8bytes.org,
	iommu@lists.linux-foundation.org,
	linux-arm-kernel@lists.infradead.org,
	shameerali.kolothum.thodi@huawei.com, andre.przywara@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org);
	SAEximRunCond expanded to false
X-Mailman-Approved-At: Mon, 29 Jul 2019 18:26:30 +0000
Cc: Andre Przywara <andre.przywara@arm.com>, iommu@lists.linux-foundation.org,
	linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On 2019-07-29 16:32, Robin Murphy wrote:
> MSI pages must always be mapped into a device's *current* domain, 
> which
> *might* be the default DMA domain, but might instead be a VFIO domain
> with its own MSI cookie. This subtlety got accidentally lost in the
> streamlining of __iommu_dma_map(), but rather than reintroduce more
> complexity and/or special-casing, it turns out neater to just split 
> this
> path out entirely.
>
> Since iommu_dma_get_msi_page() already duplicates much of what
> __iommu_dma_map() does, it can easily just make the allocation and
> mapping calls directly as well. That way we can further streamline 
> the
> helper back to exclusively operating on DMA domains.
>
> Fixes: b61d271e59d7 ("iommu/dma: Move domain lookup into
> __iommu_dma_{map,unmap}")
> Reported-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Reported-by: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

With this patch, my TX2 is back in business with a bnx2x device passed
to a guest. FWIW:

Tested-by: Marc Zyngier <maz@kernel.org>

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
