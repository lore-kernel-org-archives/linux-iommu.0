Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D71A42
	for <iommu@lists.linux.dev>; Wed, 30 Nov 2022 09:03:48 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id r26so21035432edc.10
        for <iommu@lists.linux.dev>; Wed, 30 Nov 2022 01:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zeTiHs5nrID+dCcf9mDpuziSAuWAnR+WAXAJclEol08=;
        b=nE9oszzt6DrdVEiufuzqrSy0hPFnXddp8X+3CWYRgBR/u/T+xgvLfKCQWncjoXAkK6
         dNvVuaUR8vl6tRB18zxnZpAfcoKm+rb/BY2mWx/Q3N/zhviGaD0NIn+m7hYPmYTNA66Q
         b5/K0QjVQsQavK1F0S0+ba8ujiLLRyH0jBvueRjVfMoxiBArpx2VFmxSbjEU2I7z0RiR
         Pe64WhOjYmTq/5nJblrH6C3ZFtJOEl+NcoruKxFkAlNL/xKmNntcSOhFJGQyKW/ItIta
         PPGBsciWLgXhrmNTkTkCG0+364nkHzguEx5hq9TDHK1n4fEa9sj3yUg5tit9h+o5WVAP
         dnAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zeTiHs5nrID+dCcf9mDpuziSAuWAnR+WAXAJclEol08=;
        b=4IWAuRdjp9c+nByvPO4PzqCtglnSdZlF8MngcJpvk3nHsAZBsg3BoTVgZSeXFXxJet
         /SBtpMe1ozYybr0mZJ0qmDk5I2Kt4Nt4lJIfSSgHDn/Rr3rAJeIHrq7/pm/A2ECzVEW5
         Raw+lgnN3eAoJiILjKZq6J7HyA0WaWMQ/MTN72LjzYNhWt5FvzMdyTZlajFB8BzboS/r
         G9EH9FTCwIurlnHY8h9qgCGujpWpzMCtYY8imNvzYxopWvJ8DXBEtVSa0pawdWzC4tQC
         My40XKMjFk90GnMGCZlJpTpY/NaiupXBGYWu4AEBO7CODGH7yLOT0jVG6lCz44EhFiVW
         XZyw==
X-Gm-Message-State: ANoB5pkLKrNmWPWyIww8lP2a0K+5KGkff+mLFi2I3k3XFubr+ek+yjyq
	At7bd3/PutL7NDYo+tp+/cFPD7GZOVowzr/r1Rs=
X-Google-Smtp-Source: AA0mqf4bKR5yAQg6/TCZ/juRRPYRcKTPo7xOOL2Fh+CRyT+jENE5zEN8fSCza9efEYa1UG0MfnIDN/3mX0YsbCL/TSg=
X-Received: by 2002:a05:6402:1768:b0:463:ce05:c00e with SMTP id
 da8-20020a056402176800b00463ce05c00emr54349675edb.46.1669799026668; Wed, 30
 Nov 2022 01:03:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20221128064648.1934720-1-baolu.lu@linux.intel.com> <20221128064648.1934720-9-baolu.lu@linux.intel.com>
In-Reply-To: <20221128064648.1934720-9-baolu.lu@linux.intel.com>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Wed, 30 Nov 2022 17:03:09 +0800
Message-ID: <CAAfSe-uaM8e2ChCpE5eKrKEMUi4o-_par8kKOJrJoaMK+Bar+A@mail.gmail.com>
Subject: Re: [PATCH v3 08/20] iommu/sprd: Remove detach_dev callback
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>, 
	Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Hector Martin <marcan@marcan.st>, 
	Sven Peter <sven@svenpeter.dev>, Rob Clark <robdclark@gmail.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Andy Gross <agross@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Yong Wu <yong.wu@mediatek.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Heiko Stuebner <heiko@sntech.de>, 
	Matthew Rosato <mjrosato@linux.ibm.com>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chen-Yu Tsai <wens@csie.org>, 
	Thierry Reding <thierry.reding@gmail.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 28 Nov 2022 at 14:55, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>
> The IOMMU driver supports default domain, so the detach_dev op will never
> be called. Remove it to avoid dead code.
>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Acked-by: Chunyan Zhang <zhang.lyra@gmail.com>

Thanks,
Chunyan

> ---
>  drivers/iommu/sprd-iommu.c | 16 ----------------
>  1 file changed, 16 deletions(-)
>
> diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
> index 219bfa11f7f4..ae94d74b73f4 100644
> --- a/drivers/iommu/sprd-iommu.c
> +++ b/drivers/iommu/sprd-iommu.c
> @@ -255,21 +255,6 @@ static int sprd_iommu_attach_device(struct iommu_domain *domain,
>         return 0;
>  }
>
> -static void sprd_iommu_detach_device(struct iommu_domain *domain,
> -                                            struct device *dev)
> -{
> -       struct sprd_iommu_domain *dom = to_sprd_domain(domain);
> -       struct sprd_iommu_device *sdev = dom->sdev;
> -       size_t pgt_size = sprd_iommu_pgt_size(domain);
> -
> -       if (!sdev)
> -               return;
> -
> -       dma_free_coherent(sdev->dev, pgt_size, dom->pgt_va, dom->pgt_pa);
> -       sprd_iommu_hw_en(sdev, false);
> -       dom->sdev = NULL;
> -}
> -
>  static int sprd_iommu_map(struct iommu_domain *domain, unsigned long iova,
>                           phys_addr_t paddr, size_t pgsize, size_t pgcount,
>                           int prot, gfp_t gfp, size_t *mapped)
> @@ -414,7 +399,6 @@ static const struct iommu_ops sprd_iommu_ops = {
>         .owner          = THIS_MODULE,
>         .default_domain_ops = &(const struct iommu_domain_ops) {
>                 .attach_dev     = sprd_iommu_attach_device,
> -               .detach_dev     = sprd_iommu_detach_device,
>                 .map_pages      = sprd_iommu_map,
>                 .unmap_pages    = sprd_iommu_unmap,
>                 .iotlb_sync_map = sprd_iommu_sync_map,
> --
> 2.34.1
>
