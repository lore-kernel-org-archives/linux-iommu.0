Return-Path: <SRS0=IJZW=OS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D501DC433FE
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 18:56:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 752756124A
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 18:56:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 752756124A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3CBCB80E22;
	Tue, 28 Sep 2021 18:56:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gVWAdtt_Ijtc; Tue, 28 Sep 2021 18:55:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E35BD80D85;
	Tue, 28 Sep 2021 18:55:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C72ECC0011;
	Tue, 28 Sep 2021 18:55:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D8597C000D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 18:55:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B969D4042D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 18:55:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ziepe.ca
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kbaYUH-MUi57 for <iommu@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 18:55:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 90AB940105
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 18:55:55 +0000 (UTC)
Received: by mail-qt1-x82a.google.com with SMTP id r16so20838164qtw.11
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 11:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=ebZlYMj5MQ2pOTOwk0j9IKlcwdjsdmrFMDz+5vItq+c=;
 b=QmduZpNQDgW0HX/nW9RkW9k4dvojdWvu6yI+Y+rCA9o9oH5bVLI6TsHunUzrSn1qan
 PHU5+AW3MXramsIkU+ZDSrxmYZBvYuQYjMJ8ZK3HTUAC/kk+ABbFI4PQo0l6PK6M7nRv
 n9Qd+JTkspzOmRVuSE1NXDvXPcxu9E655NnWfHIdpbSyUqeZ7AB0M+jzXvboydl8/4mW
 Q+dh5+5Bb8TwSQyJYjXU55dzd2f6hLFNFMramZxQUeiowu7DX/YyaxsNVUfw6W0sCx/t
 RtayIzeJe4Z2LkvZb8z0oxWAhpakBOql79f7LUXTsyzSQH6U2cnhDUwgm442Ri1+Tm5t
 65Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ebZlYMj5MQ2pOTOwk0j9IKlcwdjsdmrFMDz+5vItq+c=;
 b=Pu0eNPQkZ+8eyOcnyTnz384zcrHXAVwky3qjs364hJO02pI7MiuFZLoNkKnetcD9k7
 0b1Hp57V1J8cSVecW0a1woLNr0Cb9g/uu8w1/REa7Uye94pO9QlfvLAje9hor/pKO1X2
 SK0wOI7a63FxXRF2jrFVeVAs/NXClGnZky7joRoaQ47e6QKwuqt7nAZUKLXdKzYlohaM
 rOZbxHrF2vKErzbDC55bX+mWdR0Yx80V2kYrLC112n1E/x907JAUGG3QBKz7rVkE1Ruw
 mQyjNU3akFokdFN0ybIghg86k8xVfsveJiruwIpTkRnXXpW6hT22wKr3zq78/wepjwq3
 P8MA==
X-Gm-Message-State: AOAM532L9A2cU4nhq3K7VAeYDRhhrD1+Rb8Mj1b42Q0wlKYLY4G4WnSN
 dMwC9GWJApM9zaK5dnGvbRASmg==
X-Google-Smtp-Source: ABdhPJzc93AKyHeS6K7zWxJdqrv7pkOmkEPKPPpfQfpspxPiIl8jo/No84ral2c1mS98kp4huyOz7g==
X-Received: by 2002:ac8:7eee:: with SMTP id r14mr7427193qtc.56.1632855354397; 
 Tue, 28 Sep 2021 11:55:54 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
 by smtp.gmail.com with ESMTPSA id bm27sm15284065qkb.6.2021.09.28.11.55.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Sep 2021 11:55:53 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1mVIGe-007Fgc-Tq; Tue, 28 Sep 2021 15:55:52 -0300
Date: Tue, 28 Sep 2021 15:55:52 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v3 04/20] PCI/P2PDMA: introduce helpers for dma_map_sg
 implementations
Message-ID: <20210928185552.GL3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-5-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210916234100.122368-5-logang@deltatee.com>
Cc: linux-pci@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-mm@kvack.org, Jason Ekstrand <jason@jlekstrand.net>,
 Ira Weiny <ira.weiny@intel.com>, Christoph Hellwig <hch@lst.de>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Matthew Wilcox <willy@infradead.org>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 John Hubbard <jhubbard@nvidia.com>, linux-block@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
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

On Thu, Sep 16, 2021 at 05:40:44PM -0600, Logan Gunthorpe wrote:
> Add pci_p2pdma_map_segment() as a helper for simple dma_map_sg()
> implementations. It takes an scatterlist segment that must point to a
> pci_p2pdma struct page and will map it if the mapping requires a bus
> address.
> 
> The return value indicates whether the mapping required a bus address
> or whether the caller still needs to map the segment normally. If the
> segment should not be mapped, -EREMOTEIO is returned.
> 
> This helper uses a state structure to track the changes to the
> pgmap across calls and avoid needing to lookup into the xarray for
> every page.
> 
> Also add pci_p2pdma_map_bus_segment() which is useful for IOMMU
> dma_map_sg() implementations where the sg segment containing the page
> differs from the sg segment containing the DMA address.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>  drivers/pci/p2pdma.c       | 59 ++++++++++++++++++++++++++++++++++++++
>  include/linux/pci-p2pdma.h | 21 ++++++++++++++
>  2 files changed, 80 insertions(+)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index b656d8c801a7..58c34f1f1473 100644
> +++ b/drivers/pci/p2pdma.c
> @@ -943,6 +943,65 @@ void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
>  }
>  EXPORT_SYMBOL_GPL(pci_p2pdma_unmap_sg_attrs);
>  
> +/**
> + * pci_p2pdma_map_segment - map an sg segment determining the mapping type
> + * @state: State structure that should be declared outside of the for_each_sg()
> + *	loop and initialized to zero.
> + * @dev: DMA device that's doing the mapping operation
> + * @sg: scatterlist segment to map
> + *
> + * This is a helper to be used by non-iommu dma_map_sg() implementations where
> + * the sg segment is the same for the page_link and the dma_address.
> + *
> + * Attempt to map a single segment in an SGL with the PCI bus address.
> + * The segment must point to a PCI P2PDMA page and thus must be
> + * wrapped in a is_pci_p2pdma_page(sg_page(sg)) check.
> + *
> + * Returns the type of mapping used and maps the page if the type is
> + * PCI_P2PDMA_MAP_BUS_ADDR.
> + */
> +enum pci_p2pdma_map_type
> +pci_p2pdma_map_segment(struct pci_p2pdma_map_state *state, struct device *dev,
> +		       struct scatterlist *sg)
> +{
> +	if (state->pgmap != sg_page(sg)->pgmap) {
> +		state->pgmap = sg_page(sg)->pgmap;
> +		state->map = pci_p2pdma_map_type(state->pgmap, dev);
> +		state->bus_off = to_p2p_pgmap(state->pgmap)->bus_offset;
> +	}

Is this safe? I was just talking with Joao about this,

 https://lore.kernel.org/r/20210928180150.GI3544071@ziepe.ca

API wise I absolutely think this should be safe as written, but is it
really?

Does pgmap ensure that a positive refcount struct page always has a
valid pgmap pointer (and thus the mess in gup can be deleted) or does
this need to get the pgmap as well to keep it alive?

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
