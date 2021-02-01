Return-Path: <SRS0=Rmex=HD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D365C433DB
	for <iommu@archiver.kernel.org>; Mon,  1 Feb 2021 18:55:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D0C964DA8
	for <iommu@archiver.kernel.org>; Mon,  1 Feb 2021 18:55:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D0C964DA8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 674258353B;
	Mon,  1 Feb 2021 18:55:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ef9-DXeAQZgR; Mon,  1 Feb 2021 18:55:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E3F2A81123;
	Mon,  1 Feb 2021 18:55:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CFC6FC0174;
	Mon,  1 Feb 2021 18:55:52 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7C554C013A
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 18:55:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 6914220526
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 18:55:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F7xg080aMDmU for <iommu@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 18:55:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by silver.osuosl.org (Postfix) with ESMTPS id 38E282052A
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 18:55:50 +0000 (UTC)
IronPort-SDR: PfXCtC121tmjxYMGdkviYY4xwG0aahRp/ZLpPe5ekzfpjUuIhibNmWVg4/qd6x2SlyHyC0dNwb
 CUaqdtrYfaRQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="244818198"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; d="scan'208";a="244818198"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Feb 2021 10:55:49 -0800
IronPort-SDR: bO/77yFnFXEOvVyCwMRy9yRPe9Z8Uz08vIlmz+yDqMAbErP+xmmIjp8vozdpxGVV29C+RLOqEn
 iFkP5v0/f/hQ==
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; d="scan'208";a="405865932"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Feb 2021 10:55:44 -0800
Received: from andy by smile with local (Exim 4.94)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1l6eMO-001Czv-JO; Mon, 01 Feb 2021 20:55:40 +0200
Date: Mon, 1 Feb 2021 20:55:40 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jianxiong Gao <jxgao@google.com>
Subject: Re: [PATCH V2 3/3] Adding
 device_dma_parameters->offset_preserve_mask to NVMe driver.
Message-ID: <YBhOrK+kea7PNmXn@smile.fi.intel.com>
References: <20210201183017.3339130-1-jxgao@google.com>
 <20210201183017.3339130-4-jxgao@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210201183017.3339130-4-jxgao@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: axboe@fb.com, heikki.krogerus@linux.intel.com, sagi@grimberg.me,
 saravanak@google.com, konrad.wilk@oracle.com, marcorr@google.com,
 gregkh@linuxfoundation.org, rafael.j.wysocki@intel.com,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, bgolaszewski@baylibre.com, iommu@lists.linux-foundation.org,
 jroedel@suse.de, dan.j.williams@intel.com, robin.murphy@arm.com, hch@lst.de
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

On Mon, Feb 01, 2021 at 10:30:17AM -0800, Jianxiong Gao wrote:
> NVMe driver relies on the address offset to function properly.
> This patch adds the offset preserve mask to NVMe driver when mapping
> via dma_map_sg_attrs and unmapping via nvme_unmap_sg. The mask
> depends on the page size defined by CC.MPS register of NVMe
> controller.

...

>  	if (is_pci_p2pdma_page(sg_page(iod->sg)))
>  		nr_mapped = pci_p2pdma_map_sg_attrs(dev->dev, iod->sg,
>  				iod->nents, rq_dma_dir(req), DMA_ATTR_NO_WARN);
>  	else
>  		nr_mapped = dma_map_sg_attrs(dev->dev, iod->sg, iod->nents,
>  					     rq_dma_dir(req), DMA_ATTR_NO_WARN);
> +
> +	offset_ret = dma_set_min_align_mask(dev->dev, 0);
> +	if (offset_ret) {
> +		dev_warn(dev->dev, "dma_set_min_align_mask failed to reset offset\n");
> +		goto out_free_sg;
> +	}

Seems like rebasing effect which makes empty line goes in the middle of some
other group of code lines.

>  	if (!nr_mapped)
>  		goto out_free_sg;

Perhaps it should be here?

-- 
With Best Regards,
Andy Shevchenko


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
