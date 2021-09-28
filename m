Return-Path: <SRS0=IJZW=OS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F6DC433EF
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 19:15:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5910E6135E
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 19:15:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5910E6135E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 24E3B80F57;
	Tue, 28 Sep 2021 19:15:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Lq4xv5ZmP2Yi; Tue, 28 Sep 2021 19:15:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5BE1280F44;
	Tue, 28 Sep 2021 19:15:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32AA9C000F;
	Tue, 28 Sep 2021 19:15:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9C703C000D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 19:15:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8AFE480F57
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 19:15:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id peNtXqCNHPPq for <iommu@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 19:15:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 99B2280F44
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 19:15:49 +0000 (UTC)
Received: by mail-qv1-xf32.google.com with SMTP id 11so14100324qvd.11
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 12:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=tcyMivDSSj98xjcYfl0Ss83FFw70+B/UboxWuutjjDI=;
 b=ZXqOBoW2zcRY/XCsYnDKUJm0jeVb6g6QynSlK5Ml/gYsHIPYVyWznW28IH/m39nrRs
 rG+j+z/VkkqSaLLAsjs0lqXyt+KgS2pwIFFxGvKOTpp6OskwVnUll7c0SZ88LW5r3udd
 0x2by8/0zgW10HXmR0atwW5ZveJ3LbAJ7dsEEUr2Gu8vBnEg7aKaIp30t+n3dbCJEhXZ
 2aFI7yDiqqERTNEfaySqTNHIuhyRB286ED8KYrDS7lbzOda3vmUboyfsyK3esMfGV4a8
 lPty5Chcgd6dyRXlzNl6IVGzK8Mh2KFiv4dYejeXY92N3QfzHRKzIOavZpEbU+UISfzK
 CNNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tcyMivDSSj98xjcYfl0Ss83FFw70+B/UboxWuutjjDI=;
 b=Jr33pHuplxXRJGubwRECpO7Ya1YIyYDxKtuMMqd+jU0zpeQs9ju2qjX/lxsvu5Yc3r
 c+wOdPSoWTA0GhugTkeB5HlW/0AT/6yy5nIeS0ZuDVy4+ap7DOErF6MwiF7Ey2qstwMa
 A6g182h73eT0UvL+Dd1JrnGuAhN5DsNyTXoSNbed9J/YmUwlPLowmKIvu9g+NP+viSkJ
 +pDJndiW/ug6/OZqP6ZbilqtUG1lNzcx7JdU0QFx6AWHZBzF4PHogsl72lkoJFn3cKVP
 L0TEb3F67H7aDu+WPS4GLWhxtg0q10vBrm/ak9r9CUD1yHea8RJPlNWWng9PJcHF5enX
 aLfw==
X-Gm-Message-State: AOAM532cuCx7GsVtR1YP7LoWo7ulFausU4It02lsx/rsGW7yar0VfbCH
 zxHTWwbrK7d8DNko7cv+Nj/kGg==
X-Google-Smtp-Source: ABdhPJwurJl1S4rZ2pOn1DTdiP6TavgJzB4eTygZmyEB+s55pljNt5t0RfW6XCRuHe8/1mcYm0z9gQ==
X-Received: by 2002:a0c:dd92:: with SMTP id v18mr7551030qvk.41.1632856548504; 
 Tue, 28 Sep 2021 12:15:48 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
 by smtp.gmail.com with ESMTPSA id p9sm6469qkm.23.2021.09.28.12.15.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Sep 2021 12:15:48 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1mVIZv-007G30-3V; Tue, 28 Sep 2021 16:15:47 -0300
Date: Tue, 28 Sep 2021 16:15:47 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v3 08/20] iommu/dma: support PCI P2PDMA pages in
 dma-iommu map_sg
Message-ID: <20210928191547.GP3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-9-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210916234100.122368-9-logang@deltatee.com>
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

On Thu, Sep 16, 2021 at 05:40:48PM -0600, Logan Gunthorpe wrote:
> When a PCI P2PDMA page is seen, set the IOVA length of the segment
> to zero so that it is not mapped into the IOVA. Then, in finalise_sg(),
> apply the appropriate bus address to the segment. The IOVA is not
> created if the scatterlist only consists of P2PDMA pages.
> 
> A P2PDMA page may have three possible outcomes when being mapped:
>   1) If the data path between the two devices doesn't go through
>      the root port, then it should be mapped with a PCI bus address
>   2) If the data path goes through the host bridge, it should be mapped
>      normally with an IOMMU IOVA.
>   3) It is not possible for the two devices to communicate and thus
>      the mapping operation should fail (and it will return -EREMOTEIO).
> 
> Similar to dma-direct, the sg_dma_mark_pci_p2pdma() flag is used to
> indicate bus address segments. On unmap, P2PDMA segments are skipped
> over when determining the start and end IOVA addresses.
> 
> With this change, the flags variable in the dma_map_ops is set to
> DMA_F_PCI_P2PDMA_SUPPORTED to indicate support for P2PDMA pages.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/iommu/dma-iommu.c | 68 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 61 insertions(+), 7 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
