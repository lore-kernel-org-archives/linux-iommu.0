Return-Path: <SRS0=GIAn=JY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53AA4C433B4
	for <iommu@archiver.kernel.org>; Tue, 27 Apr 2021 19:48:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE431613F6
	for <iommu@archiver.kernel.org>; Tue, 27 Apr 2021 19:48:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE431613F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A3CD9404D0;
	Tue, 27 Apr 2021 19:48:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EvZvA27m5tWU; Tue, 27 Apr 2021 19:48:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id DEBFD403DC;
	Tue, 27 Apr 2021 19:47:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC903C0022;
	Tue, 27 Apr 2021 19:47:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 70E02C001C
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 19:47:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5F40383DA0
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 19:47:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ziepe.ca
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HD4mEroZWrEE for <iommu@lists.linux-foundation.org>;
 Tue, 27 Apr 2021 19:47:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1977483D99
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 19:47:56 +0000 (UTC)
Received: by mail-qk1-x72c.google.com with SMTP id q127so2072524qkb.1
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 12:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=AjrAoCiFehNYhoJcuGAEBZrhhpGrqdOWIeMvT8fZfQE=;
 b=graEdUl6h9bRI6879DOV+jpvit1zfjy1sguqq286DV1F/2+gigtoCBWC3FM8vofgQl
 frU5tmA5Yo5liP+gMHQyrmUq7cN1npCBY2bA3DqaAxH06CuLnP0NWeNuc8kjlvuN1iJn
 RdKbTcJWt7HM17bR6iMbdLR+Jh0BXdc3dZvBEz4QmXJ6kQmenIxZg2f5iyAHzEGw5iRb
 rqTOz8C5voOg+HeAyWzUJQcZ/iGz5ZMG+AB4pgyf8vAxm5rXA349KgOhQxhfMCafKqsg
 8i7gUoB/5zWgVNo8NelgGibkEKBeWRzNqnyj5N71rIYwMTksaYGDH0BittbK3OmOjGkd
 CYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=AjrAoCiFehNYhoJcuGAEBZrhhpGrqdOWIeMvT8fZfQE=;
 b=qb9bAIhgeTDHDC1xulmOT8ga+AYjNfgalN0k9BBPaNCJhvSQK3PyUrs1Ti36mlGi7C
 e84YbvNUlrtIJokNlbLMJ7sKcvQVePN3riM61fG46lE8GvbA8Z+XTkqyuPDuANnL9ys4
 MuK9sNA7Ugng99Q5pvIyWT0O7IxucX72IRQc6yBw/om2VWokBdKHKXwE0+W7dSSj0RQL
 qCIYEZPS2tW+atglJ/kJ64BfcDZGRx/laN3fOE7xgatQnSll+BmV3WYQKqPeBOYIRQa7
 l+f1aeiv5U5L+XEhtUHq/eYffML2FtcKn7DFRgs8P+xNSA/2f6mEFNezx5erhfGHFT7Z
 cQ3Q==
X-Gm-Message-State: AOAM533knzJ0IcgwHjz1Jt/RAY/r2AaAJFUzTd5OQ++I57v8qC/YHreE
 gEUj+00cei7NgOgeloZaZZd5RA==
X-Google-Smtp-Source: ABdhPJw/yRbsqLsGFNvUPkPPJ1aCygnt+iyVESC5mkhFcaOFoCh8V5g49hIvCNxFvRyeXQBLFWfZKw==
X-Received: by 2002:a37:41ce:: with SMTP id
 o197mr25280932qka.122.1619552875839; 
 Tue, 27 Apr 2021 12:47:55 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
 by smtp.gmail.com with ESMTPSA id d19sm625708qtd.29.2021.04.27.12.47.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Apr 2021 12:47:55 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1lbTgX-00DhBD-OP; Tue, 27 Apr 2021 16:47:53 -0300
Date: Tue, 27 Apr 2021 16:47:53 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH 14/16] nvme-rdma: Ensure dma support when using p2pdma
Message-ID: <20210427194753.GU2047089@ziepe.ca>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-15-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210408170123.8788-15-logang@deltatee.com>
Cc: linux-pci@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-mm@kvack.org, Jason Ekstrand <jason@jlekstrand.net>,
 Ira Weiny <ira.weiny@intel.com>, Christoph Hellwig <hch@lst.de>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, John Hubbard <jhubbard@nvidia.com>,
 linux-block@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
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

On Thu, Apr 08, 2021 at 11:01:21AM -0600, Logan Gunthorpe wrote:
> Ensure the dma operations support p2pdma before using the RDMA
> device for P2PDMA. This allows switching the RDMA driver from
> pci_p2pdma_map_sg() to dma_map_sg_p2pdma().
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>  drivers/nvme/target/rdma.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index 6c1f3ab7649c..3ec7e77e5416 100644
> +++ b/drivers/nvme/target/rdma.c
> @@ -414,7 +414,8 @@ static int nvmet_rdma_alloc_rsp(struct nvmet_rdma_device *ndev,
>  	if (ib_dma_mapping_error(ndev->device, r->send_sge.addr))
>  		goto out_free_rsp;
>  
> -	if (!ib_uses_virt_dma(ndev->device))
> +	if (!ib_uses_virt_dma(ndev->device) &&
> +	    dma_pci_p2pdma_supported(&ndev->device->dev))

ib_uses_virt_dma() should not be called by nvme and this is using the
wrong device pointer to query for DMA related properties.

I suspect this wants a ib_dma_pci_p2p_dma_supported() wrapper like
everything else.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
