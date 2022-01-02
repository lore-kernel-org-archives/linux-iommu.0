Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3AF7C433EF
	for <iommu@archiver.kernel.org>; Sun,  2 Jan 2022 16:23:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3ED78402BA;
	Sun,  2 Jan 2022 16:23:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id muf6s_9nYPx6; Sun,  2 Jan 2022 16:23:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1DF7240217;
	Sun,  2 Jan 2022 16:23:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E5F8FC0030;
	Sun,  2 Jan 2022 16:23:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AFE80C001E
 for <iommu@lists.linux-foundation.org>; Sun,  2 Jan 2022 16:23:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8ED9C60B05
 for <iommu@lists.linux-foundation.org>; Sun,  2 Jan 2022 16:23:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tSdxsMLQzLoU for <iommu@lists.linux-foundation.org>;
 Sun,  2 Jan 2022 16:23:12 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F2EE060A99
 for <iommu@lists.linux-foundation.org>; Sun,  2 Jan 2022 16:23:11 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id d9so65655860wrb.0
 for <iommu@lists.linux-foundation.org>; Sun, 02 Jan 2022 08:23:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=syRxK/WihK0W8cM9Lo7IEl7ax9RwmDt1BjblnKABupk=;
 b=RdlyIurDnZBA8BibcXRRRS2jCOPM840+4SlimChHj4xHvJzsxM2KEsJwNIMIdWSQP/
 X+9RJ8Bwn4ezObJlXSQ63GSqPQNAt1ITRgiv3l6/jteXgNjqYhJhJT0CCEOuiJwHL00Y
 S88fmLlnLVgbeZT8uuQVkkoLJBYMYF4Aj7Y00ycrY3rjXFhamtatuhooYwxXN2t3fIiD
 na6oyl2RI0eKxOSyzI1rhdy6sQV4uf2Jp/EHwqyS+yMvSuoXaYjG+cgU8CXquyiMNH7V
 5dMmPUcyOyrtlOg+VG0umdePRLGYJzXB0V9FjqklZYMsbit+IAp+zU0/eZPZwcCVQ6W1
 1tqg==
X-Gm-Message-State: AOAM532xIlNfWzfew+g7dYXZw4RTAdqr85ZPlscADIzW5d+AacRpwhUv
 Ig7yLb9nXNgLhRkJc5AFUWE=
X-Google-Smtp-Source: ABdhPJzXbMjog73caxBAxZ+vqfoRaLf7wB2/iqS1Zv8pzijdM+2Cav527ULesBUorK4v9MROCfkR4A==
X-Received: by 2002:a05:6000:144f:: with SMTP id
 v15mr35274705wrx.400.1641140590197; 
 Sun, 02 Jan 2022 08:23:10 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
 by smtp.gmail.com with ESMTPSA id b5sm2234326wrr.19.2022.01.02.08.23.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Jan 2022 08:23:09 -0800 (PST)
Date: Sun, 2 Jan 2022 16:23:08 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Tianyu Lan <ltykernel@gmail.com>
Subject: Re: [PATCH] Swiotlb: Add CONFIG_HAS_IOMEM check around memremap() in
 the swiotlb_mem_remap()
Message-ID: <20220102162308.msbzlzm4oz5jvabp@liuwe-devbox-debian-v2>
References: <20211231165640.1245751-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211231165640.1245751-1-ltykernel@gmail.com>
Cc: parri.andrea@gmail.com, michael.h.kelley@microsoft.com, wei.liu@kernel.org,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, kernel test robot <lkp@intel.com>,
 konrad.wilk@oracle.com, linux-kernel@vger.kernel.org, hch@infradead.org,
 iommu@lists.linux-foundation.org, thomas.lendacky@amd.com,
 brijesh.singh@amd.com, vkuznets@redhat.com, kys@microsoft.com,
 robin.murphy@arm.com, hch@lst.de
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

On Fri, Dec 31, 2021 at 11:56:40AM -0500, Tianyu Lan wrote:
> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
> 
> HAS_IOMEM option may not be selected on some platforms(e.g, s390) and this
> will cause compile error due to miss memremap() implementation. Fix it via

miss -> missingk

> adding HAS_IOMEM check around memremap() in the swiotlb.c.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>

Hi Christoph

Are you happy with this fix?

Thanks,
Wei.

> ---
>  kernel/dma/swiotlb.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index b36c1cdd0c4f..3de651ba38cc 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -167,6 +167,7 @@ static void *swiotlb_mem_remap(struct io_tlb_mem *mem, unsigned long bytes)
>  {
>  	void *vaddr = NULL;
>  
> +#ifdef CONFIG_HAS_IOMEM
>  	if (swiotlb_unencrypted_base) {
>  		phys_addr_t paddr = mem->start + swiotlb_unencrypted_base;
>  
> @@ -175,6 +176,7 @@ static void *swiotlb_mem_remap(struct io_tlb_mem *mem, unsigned long bytes)
>  			pr_err("Failed to map the unencrypted memory %pa size %lx.\n",
>  			       &paddr, bytes);
>  	}
> +#endif
>  
>  	return vaddr;
>  }
> -- 
> 2.25.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
