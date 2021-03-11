Return-Path: <SRS0=X4VR=IJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664FBC433DB
	for <iommu@archiver.kernel.org>; Thu, 11 Mar 2021 23:59:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0182A64F86
	for <iommu@archiver.kernel.org>; Thu, 11 Mar 2021 23:59:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0182A64F86
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B80426F844;
	Thu, 11 Mar 2021 23:59:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6WSn8BXYtf08; Thu, 11 Mar 2021 23:59:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 967DA606B3;
	Thu, 11 Mar 2021 23:59:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5C5C1C000B;
	Thu, 11 Mar 2021 23:59:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 63BEEC0001
 for <iommu@lists.linux-foundation.org>; Thu, 11 Mar 2021 23:59:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3E0AE4306A
 for <iommu@lists.linux-foundation.org>; Thu, 11 Mar 2021 23:59:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ziepe.ca
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mQbdDrJ0kyj5 for <iommu@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 23:59:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6EAE84305F
 for <iommu@lists.linux-foundation.org>; Thu, 11 Mar 2021 23:59:46 +0000 (UTC)
Received: by mail-qt1-x82f.google.com with SMTP id x9so2559957qto.8
 for <iommu@lists.linux-foundation.org>; Thu, 11 Mar 2021 15:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=9rzGlCXRuAYzD4FxF8/kX8t+sLM/xQ6RjW+kfB9MHUI=;
 b=Sht35sRAWhjUnG/vlACxlUdN1NXxZ2hn78xSNsQrOQiOnK1nALUmlUGHUAK1T+DYhZ
 MX3lwQI/UxwTrkQv8d3kMYROr1PLyoiqVafUPMi7P056ufFmL/tRZlvShlZxbmxqDyNW
 NLKw5iBy24OxHbW+DCJ1DQJfzdSe8iTc3c8sHbtF9tFwbdZcos5KLgrKfPlUhIrDUvII
 vIew7klGAO8Wn/28Da6K3YhKEWpKl3Z8yXO4c0K2hvWjTBIXhDYwZP0hefzSiur217jB
 Lo+rOwqj5lF4a/tIzhlWfi67C2vz4vtRgSFudHgU/4CmiKi4zEw8bQzulGoxFckdnomp
 ZbNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=9rzGlCXRuAYzD4FxF8/kX8t+sLM/xQ6RjW+kfB9MHUI=;
 b=o2cW8vLW+7hfquXNLlueFCnkZqSIOPJfli5p9T5DMi4pYFFavQr05aaWwJMRWk0gej
 5OCYyhiYLTQPy4Y71oV+iFP7fVgMxR7qNBnScRGrNltY1/5VT2IrZRLAdHYyoLc3GPcI
 c7U8Lw3UlELmy5LaeMtgDtjGsc3AsLOiAN0c1lTjjjCEaGRyRBPHvQOuFr7mfDS078cx
 jfXJ1jUQXSwJqscpO7FQSJaBG2uf3ZwD0OnFlD9U7fdhiZHXAaXm549EHSDCeOwKw5xZ
 Goo/LwH2yoxYEicE0WtMnQUyEboyYiFAajw9goI3OEOZusFh9m6eoSTXAhWYmnVzUfQu
 82IQ==
X-Gm-Message-State: AOAM531Fuk1uHPWFKFypDm+XpmKEGpV0OIgGV7nNStHf0sunnCfH1MuY
 eJYqBn1dC5GWNDQ9UHFuNruFpQ==
X-Google-Smtp-Source: ABdhPJxiCSaM0aAia7Gh2ystvnvxFkgXLtQu1szm+rOtvCsRMIOPRh5BDiwH0XxEbvHajGL8eIa3Yg==
X-Received: by 2002:aed:20cd:: with SMTP id 71mr9996620qtb.346.1615507185328; 
 Thu, 11 Mar 2021 15:59:45 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.115.133])
 by smtp.gmail.com with ESMTPSA id z89sm2953405qtd.5.2021.03.11.15.59.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Mar 2021 15:59:44 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1lKVDT-00BbRW-RG; Thu, 11 Mar 2021 19:59:43 -0400
Date: Thu, 11 Mar 2021 19:59:43 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [RFC PATCH v2 11/11] nvme-pci: Convert to using dma_map_sg for
 p2pdma pages
Message-ID: <20210311235943.GB2710221@ziepe.ca>
References: <20210311233142.7900-1-logang@deltatee.com>
 <20210311233142.7900-12-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210311233142.7900-12-logang@deltatee.com>
Cc: Minturn Dave B <dave.b.minturn@intel.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 linux-pci@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ira Weiny <iweiny@intel.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Stephen Bates <sbates@raithlin.com>, linux-block@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Matthew Wilcox <willy@infradead.org>, Jason Ekstrand <jason@jlekstrand.net>,
 John Hubbard <jhubbard@nvidia.com>, Dan Williams <dan.j.williams@intel.com>,
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

On Thu, Mar 11, 2021 at 04:31:41PM -0700, Logan Gunthorpe wrote:
> Convert to using dma_[un]map_sg() for PCI p2pdma pages.
> 
> This should be equivalent, though support will be somewhat less
> (only dma-direct and dma-iommu are currently supported).
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>  drivers/nvme/host/pci.c | 27 +++++++--------------------
>  1 file changed, 7 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 7d40c6a9e58e..89ca5acf7a62 100644
> +++ b/drivers/nvme/host/pci.c
> @@ -577,17 +577,6 @@ static void nvme_free_sgls(struct nvme_dev *dev, struct request *req)
>  
>  }
>  
> -static void nvme_unmap_sg(struct nvme_dev *dev, struct request *req)
> -{
> -	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> -
> -	if (is_pci_p2pdma_page(sg_page(iod->sg)))
> -		pci_p2pdma_unmap_sg(dev->dev, iod->sg, iod->nents,
> -				    rq_dma_dir(req));
> -	else
> -		dma_unmap_sg(dev->dev, iod->sg, iod->nents, rq_dma_dir(req));
> -}

Can the two other places with this code pattern be changed too?

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
