Return-Path: <SRS0=GIAn=JY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B481C43460
	for <iommu@archiver.kernel.org>; Tue, 27 Apr 2021 19:33:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17A20613FC
	for <iommu@archiver.kernel.org>; Tue, 27 Apr 2021 19:33:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17A20613FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C418B60666;
	Tue, 27 Apr 2021 19:33:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iyCtVIiasI5n; Tue, 27 Apr 2021 19:33:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id AEA05605DA;
	Tue, 27 Apr 2021 19:33:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 74B4DC0022;
	Tue, 27 Apr 2021 19:33:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97078C001C
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 19:33:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9078E402F6
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 19:33:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ziepe.ca
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KX4tOtsOCLSq for <iommu@lists.linux-foundation.org>;
 Tue, 27 Apr 2021 19:33:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A437D40289
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 19:33:54 +0000 (UTC)
Received: by mail-pl1-x62f.google.com with SMTP id p17so5558183plf.12
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 12:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=R+F2zOJdoXavuDhUMY1QiZp/NrhfLweB0na9Qyx1V6M=;
 b=TJz59G9wTmQQcbNbRY6OLyN78TksPOrBEHchyw0NBoPqX7sH+F3GGV9C/CfZW1h60M
 za+EgCvhm5j94fG3EFrSszh3F9AtXSEv6o4v4pzjNzSIPeAEJTXAJgDlK3w7dIOwvVl3
 GDz/9VRq+nxGIFibJgIM4ZDwttw1bZanScMikT8vBhr3hHdh3+D1AMW+87r/3r/WeSeL
 mFN1NYGu0fU/BHLpJfQ111ayxh2eOXs3wIHf4Gc1C7LSKzpmBZACVlSiQZcSoeU7Fukr
 d9IJK8EwTF9bbg0KdJNjSvCfq8EatvIhTdt5V794cL+MA6LlTikeW2O5j+OCr1c9eKX8
 S8Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=R+F2zOJdoXavuDhUMY1QiZp/NrhfLweB0na9Qyx1V6M=;
 b=I+CCCUCb7zoOU5VzlNIIsz9fWLm4x2lQ69rZR678YsSWBFnEHr5KpRrhnmvomwBFrh
 nORxu0r5HE2Vnh1nVz/GcJmvRxDfU/9JMb0N3RuPWB3oePMOGUzQMuZhA3gri2eVzzXR
 o4SM3IJgkoG8VHMSv/7dkgsXtVRZ/+TUcLKrJXBLiwJoXqWXele+UhoGjgE+yefEOg1x
 hFnYN0Xy2QNRElAdwVeQPbzKgXTnD/pSnYDty7F6xLXmHo6GtVxRCYm8Sq7WpznffW2j
 iqK9xa4PN5mAnEkSy2vbmhBWcCJuzGVA9Sziizr+LoFG2t2Z6nZcV/1grxOlYzHpz5Bz
 t4SQ==
X-Gm-Message-State: AOAM532AyIOaa5lK5ZZOJqkurzpgnwgHZyngJJJZFxbzQnN3r4k9YSKB
 yLAWBwUIxOtuK67US656Q5rqDQ==
X-Google-Smtp-Source: ABdhPJwz3MILTFTzWsw6JFNbmAnxbzNG2cgSRXVHlPFwKXyKDZuqS3fiLINQaBtKfebJ6/AT25pPWg==
X-Received: by 2002:a17:902:8a8a:b029:ec:857a:4d51 with SMTP id
 p10-20020a1709028a8ab02900ec857a4d51mr25612392plo.68.1619552034009; 
 Tue, 27 Apr 2021 12:33:54 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
 by smtp.gmail.com with ESMTPSA id o5sm460461pgq.58.2021.04.27.12.33.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Apr 2021 12:33:53 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1lbTSx-00Dgwh-Mo; Tue, 27 Apr 2021 16:33:51 -0300
Date: Tue, 27 Apr 2021 16:33:51 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH 09/16] dma-direct: Support PCI P2PDMA pages in dma-direct
 map_sg
Message-ID: <20210427193351.GR2047089@ziepe.ca>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-10-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210408170123.8788-10-logang@deltatee.com>
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

On Thu, Apr 08, 2021 at 11:01:16AM -0600, Logan Gunthorpe wrote:
> Add PCI P2PDMA support for dma_direct_map_sg() so that it can map
> PCI P2PDMA pages directly without a hack in the callers. This allows
> for heterogeneous SGLs that contain both P2PDMA and regular pages.
> 
> SGL segments that contain PCI bus addresses are marked with
> sg_mark_pci_p2pdma() and are ignored when unmapped.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>  kernel/dma/direct.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 002268262c9a..108dfb4ecbd5 100644
> +++ b/kernel/dma/direct.c
> @@ -13,6 +13,7 @@
>  #include <linux/vmalloc.h>
>  #include <linux/set_memory.h>
>  #include <linux/slab.h>
> +#include <linux/pci-p2pdma.h>
>  #include "direct.h"
>  
>  /*
> @@ -387,19 +388,37 @@ void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
>  	struct scatterlist *sg;
>  	int i;
>  
> -	for_each_sg(sgl, sg, nents, i)
> +	for_each_sg(sgl, sg, nents, i) {
> +		if (sg_is_pci_p2pdma(sg)) {
> +			sg_unmark_pci_p2pdma(sg);

This doesn't seem nice, the DMA layer should only alter the DMA
portion of the SG, not the other portions. Is it necessary?

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
