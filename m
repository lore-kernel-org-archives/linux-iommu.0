Return-Path: <SRS0=QBaT=OR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903A3C433F5
	for <iommu@archiver.kernel.org>; Mon, 27 Sep 2021 18:50:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E4B06101A
	for <iommu@archiver.kernel.org>; Mon, 27 Sep 2021 18:50:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4E4B06101A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2203B60873;
	Mon, 27 Sep 2021 18:50:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id scxCzwGzjJjc; Mon, 27 Sep 2021 18:50:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A5F4A608BB;
	Mon, 27 Sep 2021 18:50:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82204C001C;
	Mon, 27 Sep 2021 18:50:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46499C000F
 for <iommu@lists.linux-foundation.org>; Mon, 27 Sep 2021 18:50:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EE4FA608A5
 for <iommu@lists.linux-foundation.org>; Mon, 27 Sep 2021 18:50:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZMYhr2wv6fzf for <iommu@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 18:50:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6F10F6080A
 for <iommu@lists.linux-foundation.org>; Mon, 27 Sep 2021 18:50:38 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id CDAE961058;
 Mon, 27 Sep 2021 18:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632768638;
 bh=C5XC6h6Q1qc5Qf6BQUNRzYX2mM+5Ej8TnIc335MIf3Y=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=sxhqG2OwJcmYiPbgyuP+0xu6/gEhxQlRDh6b0Q4SBqBqsN4nn+REtn//Bigm2XegR
 ltuanBZSrm5Dt6GJFsiwiA23f1AVvAUrGESKtat3QIvJZJcdHhUShJO+a3JDGkAcOZ
 hBm+bbjGjp1eJ3L8+BW1Hvy5k/t+DXjcmafsp4Qwiq5fz+FPcHdN7cSv1nVdS+iH5j
 4+kUSasJvEa4tLbjzHFbG61XTE6v9SW+4inMLS7Rk3O6gACDrFD9x0m5Kg3tADTBv7
 oK+UBQkgmZxlMMOwZ7wxWruTgiS8aySMoZgqahsIPVSzl9H8IY1XOu/MeIQNBzPO5O
 hg5kqidrgvEnw==
Date: Mon, 27 Sep 2021 13:50:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v3 02/20] PCI/P2PDMA: attempt to set map_type if it has
 not been set
Message-ID: <20210927185036.GA668115@bhelgaas>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210916234100.122368-3-logang@deltatee.com>
Cc: linux-pci@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-mm@kvack.org, Jason Ekstrand <jason@jlekstrand.net>,
 Ira Weiny <ira.weiny@intel.com>, Christoph Hellwig <hch@lst.de>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, John Hubbard <jhubbard@nvidia.com>,
 linux-block@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
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

On Thu, Sep 16, 2021 at 05:40:42PM -0600, Logan Gunthorpe wrote:
> Attempt to find the mapping type for P2PDMA pages on the first
> DMA map attempt if it has not been done ahead of time.
> 
> Previously, the mapping type was expected to be calculated ahead of
> time, but if pages are to come from userspace then there's no
> way to ensure the path was checked ahead of time.
> 
> With this change it's no longer invalid to call pci_p2pdma_map_sg()
> before the mapping type is calculated so drop the WARN_ON when that
> is the case.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Capitalize subject line.

> ---
>  drivers/pci/p2pdma.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 50cdde3e9a8b..1192c465ba6d 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -848,6 +848,7 @@ static enum pci_p2pdma_map_type pci_p2pdma_map_type(struct dev_pagemap *pgmap,
>  	struct pci_dev *provider = to_p2p_pgmap(pgmap)->provider;
>  	struct pci_dev *client;
>  	struct pci_p2pdma *p2pdma;
> +	int dist;
>  
>  	if (!provider->p2pdma)
>  		return PCI_P2PDMA_MAP_NOT_SUPPORTED;
> @@ -864,6 +865,10 @@ static enum pci_p2pdma_map_type pci_p2pdma_map_type(struct dev_pagemap *pgmap,
>  		type = xa_to_value(xa_load(&p2pdma->map_types,
>  					   map_types_idx(client)));
>  	rcu_read_unlock();
> +
> +	if (type == PCI_P2PDMA_MAP_UNKNOWN)
> +		return calc_map_type_and_dist(provider, client, &dist, false);
> +
>  	return type;
>  }
>  
> @@ -906,7 +911,6 @@ int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
>  	case PCI_P2PDMA_MAP_BUS_ADDR:
>  		return __pci_p2pdma_map_sg(p2p_pgmap, dev, sg, nents);
>  	default:
> -		WARN_ON_ONCE(1);
>  		return 0;
>  	}
>  }
> -- 
> 2.30.2
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
