Return-Path: <SRS0=jIn/=7C=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB15C433DF
	for <iommu@archiver.kernel.org>; Wed, 20 May 2020 05:43:57 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87C2B2075F
	for <iommu@archiver.kernel.org>; Wed, 20 May 2020 05:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MV9LOgk3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87C2B2075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5C810865AB;
	Wed, 20 May 2020 05:43:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TWrCFYrN4Iow; Wed, 20 May 2020 05:43:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id AB15F864C3;
	Wed, 20 May 2020 05:43:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 905C7C0881;
	Wed, 20 May 2020 05:43:54 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 742ACC0176
 for <iommu@lists.linux-foundation.org>; Wed, 20 May 2020 05:43:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 3A59B2001A
 for <iommu@lists.linux-foundation.org>; Wed, 20 May 2020 05:43:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 67j6kPEUn5B6 for <iommu@lists.linux-foundation.org>;
 Wed, 20 May 2020 05:43:52 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 8A67620017
 for <iommu@lists.linux-foundation.org>; Wed, 20 May 2020 05:43:52 +0000 (UTC)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B534C2075F;
 Wed, 20 May 2020 05:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589953432;
 bh=IEc+QC7akchK5eV7/ZYdgqsaG2z+ctbqijAK6mJ6Q98=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MV9LOgk3OXP5XC66veg+cLqTxXmgekS2F0K2Lx1avu81cXlkxReu1me2r75MMQ2b+
 ZE/q6upLQs+FrqRHXAntfRYgsnkgOdGK7p4UiV+dhvyZ4PYwI5dyJMh3rzb1/w81wX
 vLFfMmab6HO3EzfJeRgK37kwsXkaZoBeGIY6dFJs=
Date: Wed, 20 May 2020 07:43:49 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Subject: Re: [PATCH 09/15] device core: Add ability to handle multiple dma
 offsets
Message-ID: <20200520054349.GB2180554@kroah.com>
References: <20200519203419.12369-1-james.quinlan@broadcom.com>
 <20200519203419.12369-10-james.quinlan@broadcom.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200519203419.12369-10-james.quinlan@broadcom.com>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE"
 <devicetree@vger.kernel.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Saravana Kannan <saravanak@google.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Frank Rowand <frowand.list@gmail.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
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

On Tue, May 19, 2020 at 04:34:07PM -0400, Jim Quinlan wrote:
> diff --git a/include/linux/device.h b/include/linux/device.h
> index ac8e37cd716a..6cd916860b5f 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -493,6 +493,8 @@ struct dev_links_info {
>   * @bus_dma_limit: Limit of an upstream bridge or bus which imposes a smaller
>   *		DMA limit than the device itself supports.
>   * @dma_pfn_offset: offset of DMA memory range relatively of RAM
> + * @dma_map:	Like dma_pfn_offset but used when there are multiple
> + *		pfn offsets for multiple dma-ranges.
>   * @dma_parms:	A low level driver may set these to teach IOMMU code about
>   * 		segment limitations.
>   * @dma_pools:	Dma pools (if dma'ble device).
> @@ -578,7 +580,12 @@ struct device {
>  					     allocations such descriptors. */
>  	u64		bus_dma_limit;	/* upstream dma constraint */
>  	unsigned long	dma_pfn_offset;
> -
> +#ifdef CONFIG_DMA_PFN_OFFSET_MAP
> +	const void *dma_offset_map;	/* Like dma_pfn_offset, but for
> +					 * the unlikely case of multiple
> +					 * offsets. If non-null, dma_pfn_offset
> +					 * will be 0. */
> +#endif
>  	struct device_dma_parameters *dma_parms;
>  
>  	struct list_head	dma_pools;	/* dma pools (if dma'ble) */

I'll defer to Christoph here, but I thought we were trying to get rid of
stuff like this from struct device, not add new things to it for dma
apis.  And why is it a void *?

thanks,

greg k-h
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
