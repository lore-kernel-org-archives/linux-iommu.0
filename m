Return-Path: <SRS0=lYZf=IL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_RED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D439DC433DB
	for <iommu@archiver.kernel.org>; Sat, 13 Mar 2021 02:32:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E07764F6A
	for <iommu@archiver.kernel.org>; Sat, 13 Mar 2021 02:32:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E07764F6A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0D59042C2C;
	Sat, 13 Mar 2021 02:32:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LAlChQEkg8hF; Sat, 13 Mar 2021 02:32:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id F3B5E41566;
	Sat, 13 Mar 2021 02:32:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A0FECC000B;
	Sat, 13 Mar 2021 02:32:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D671FC0001
 for <iommu@lists.linux-foundation.org>; Sat, 13 Mar 2021 02:32:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B6ED342C2C
 for <iommu@lists.linux-foundation.org>; Sat, 13 Mar 2021 02:32:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tDNKo2vnSz86 for <iommu@lists.linux-foundation.org>;
 Sat, 13 Mar 2021 02:32:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 74EBC41566
 for <iommu@lists.linux-foundation.org>; Sat, 13 Mar 2021 02:32:22 +0000 (UTC)
IronPort-SDR: mRCwiuEFe1uPIYlGk1syJxdlX3GmXmLwBMnZG+veMfbI06L1Ez5UyAIfOvFt9/jCmPaX7hzoTE
 aY7jMmw7cNkQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="252931310"
X-IronPort-AV: E=Sophos;i="5.81,245,1610438400"; d="scan'208";a="252931310"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2021 18:32:20 -0800
IronPort-SDR: BWPKoNFrC0CbvFbvqC7bofsQvJCNTBhJDT+7AoC9cufX1+KLu6FM5vOz8SA4xWlBa1sCU5vqVL
 Ls62JjUfG9ug==
X-IronPort-AV: E=Sophos;i="5.81,245,1610438400"; d="scan'208";a="448805796"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2021 18:32:20 -0800
Date: Fri, 12 Mar 2021 18:32:20 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [RFC PATCH v2 04/11] PCI/P2PDMA: Introduce
 pci_p2pdma_should_map_bus() and pci_p2pdma_bus_offset()
Message-ID: <20210313023220.GB3402637@iweiny-DESK2.sc.intel.com>
References: <20210311233142.7900-1-logang@deltatee.com>
 <20210311233142.7900-5-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210311233142.7900-5-logang@deltatee.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Cc: Minturn Dave B <dave.b.minturn@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-pci@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ira Weiny <iweiny@intel.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Stephen Bates <sbates@raithlin.com>, linux-block@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Jason Ekstrand <jason@jlekstrand.net>, John Hubbard <jhubbard@nvidia.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>, Christoph Hellwig <hch@lst.de>,
 Xiong Jianxin <jianxin.xiong@intel.com>
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

On Thu, Mar 11, 2021 at 04:31:34PM -0700, Logan Gunthorpe wrote:
> Introduce pci_p2pdma_should_map_bus() which is meant to be called by
            ^^^^^^^^^^^^^^^^^^^^^^^^^
	    pci_p2pdma_dma_map_type() ???

FWIW I find this name confusing with pci_p2pdma_map_type() and looking at the
implementation I'm not clear why pci_p2pdma_dma_map_type() needs to exist?

Ira

[snip]

> +
> +/**
> + * pci_p2pdma_dma_map_type - determine if a DMA mapping should use the
> + *	bus address, be mapped normally or fail
> + * @dev: device doing the DMA request
> + * @pgmap: dev_pagemap structure for the mapping
> + *
> + * Returns:
> + *    1 - if the page should be mapped with a bus address,
> + *    0 - if the page should be mapped normally through an IOMMU mapping or
> + *        physical address; or
> + *   -1 - if the device should not map the pages and an error should be
> + *        returned
> + */
> +int pci_p2pdma_dma_map_type(struct device *dev, struct dev_pagemap *pgmap)
> +{
> +	struct pci_p2pdma_pagemap *p2p_pgmap = to_p2p_pgmap(pgmap);
> +	struct pci_dev *client;
> +
> +	if (!dev_is_pci(dev))
> +		return -1;
> +
> +	client = to_pci_dev(dev);
> +
> +	switch (pci_p2pdma_map_type(p2p_pgmap->provider, client)) {
> +	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
> +		return 0;
> +	case PCI_P2PDMA_MAP_BUS_ADDR:
> +		return 1;
> +	default:
> +		return -1;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(pci_p2pdma_dma_map_type);

I guess the main point here is to export this to the DMA layer?

Ira
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
