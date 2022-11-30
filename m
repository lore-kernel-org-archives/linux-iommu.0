Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23C9A42
	for <iommu@lists.linux.dev>; Wed, 30 Nov 2022 09:02:50 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id vv4so39731726ejc.2
        for <iommu@lists.linux.dev>; Wed, 30 Nov 2022 01:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bvCkSPWWXEisBKO+mE/xfJ0iMceCkypfEF6PFvX87bk=;
        b=LjLp7O13cRq+xDrs1MAO2ZcpkbECDNbMAGdmn1nST/EMEngSM+h+F7Iae4N0CyzhT3
         asYogNfUqIBeeN8Bxf7Fb9LYfuHCYzJMQA09Ydkei5tkdlJsKYWvPz9zcyr+Fe0Y6Jtn
         IGNVsq7PheOygDpPiAPN3kT/GVTyJ+Lvy1znjQP81zgEve2NFF8J16qwk1HKWU2m+BjW
         ZXmR7rZQUrFFk4ybAylMqu4qumJ1bqog4E7SLmHvDSTRMCw8DRC/8u3GKRvcJWsvgtXa
         zMFhcu6DVwm9JwN9SaZqEMMkiNsGeXea9pVSbqVeNaZpcu1xzniXMJq6RDcaiILC/3wh
         EPZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bvCkSPWWXEisBKO+mE/xfJ0iMceCkypfEF6PFvX87bk=;
        b=0AGQTyINzZPNLLcu+0PFk3t7edRMZHozZubjYusYw/iZJXQBgyh6H70FyGC6UKSWcf
         SZ2SEvLf5wVKANrpDCVDzh2JgBT42Bu5hRg7hgJUDdNbMsbxHGR+K+pvNR0f8eW06ELI
         usL5d37RH/hj042bs+cKrIFs7JCyIPTo880g5TatdoPqRlONi4akSSpMs1CV5rtbrekA
         fIL/6B5QrE5ECGAhkSJBvNnjLQl8fOAahOMvLyV7uU9VkeH/t3EQITYdy/5tTkqe6A6c
         9jaylMKjYZc+wIZAenkJ+PfB4I1K0Tuw3pP8yKnDXsa2HV5ASKBff0+fn1TIB0uyMxox
         opBg==
X-Gm-Message-State: ANoB5pliRPWGogv4ENVk9TwwbP1nzKZwMeA20tgTc9oaHQd752xHAgLk
	7xBEpaUqxyycG3V0XQqrICmX2SAw5+KKBpE0kPQ=
X-Google-Smtp-Source: AA0mqf4/GBvpR8BDs7aXcNHCJIURnlX8+Q4URsljIZcfS/jf5Ko1DXgZkiwT07uqHCIh2Z7p4zHN0wKVOWUvDZPbXKA=
X-Received: by 2002:a17:906:9c8a:b0:7bf:6698:d444 with SMTP id
 fj10-20020a1709069c8a00b007bf6698d444mr12679921ejc.548.1669798968899; Wed, 30
 Nov 2022 01:02:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20221128064648.1934720-1-baolu.lu@linux.intel.com>
 <20221128064648.1934720-9-baolu.lu@linux.intel.com> <BL1PR11MB5271FF59EEAC72D3C4A04E538C129@BL1PR11MB5271.namprd11.prod.outlook.com>
In-Reply-To: <BL1PR11MB5271FF59EEAC72D3C4A04E538C129@BL1PR11MB5271.namprd11.prod.outlook.com>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Wed, 30 Nov 2022 17:02:11 +0800
Message-ID: <CAAfSe-vZEAVS05GUPQ0qf1hW20LyCGhgyHu+K5EueU=_FJRF=g@mail.gmail.com>
Subject: Re: [PATCH v3 08/20] iommu/sprd: Remove detach_dev callback
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, 
	Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Hector Martin <marcan@marcan.st>, 
	Sven Peter <sven@svenpeter.dev>, Rob Clark <robdclark@gmail.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Andy Gross <agross@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Yong Wu <yong.wu@mediatek.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Heiko Stuebner <heiko@sntech.de>, 
	Matthew Rosato <mjrosato@linux.ibm.com>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chen-Yu Tsai <wens@csie.org>, 
	Thierry Reding <thierry.reding@gmail.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 29 Nov 2022 at 11:35, Tian, Kevin <kevin.tian@intel.com> wrote:
>
> > From: Lu Baolu <baolu.lu@linux.intel.com>
> > Sent: Monday, November 28, 2022 2:47 PM
> >
> > The IOMMU driver supports default domain, so the detach_dev op will never
> > be called. Remove it to avoid dead code.
> >
> > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> > ---
> >  drivers/iommu/sprd-iommu.c | 16 ----------------
> >  1 file changed, 16 deletions(-)
> >
> > diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
> > index 219bfa11f7f4..ae94d74b73f4 100644
> > --- a/drivers/iommu/sprd-iommu.c
> > +++ b/drivers/iommu/sprd-iommu.c
> > @@ -255,21 +255,6 @@ static int sprd_iommu_attach_device(struct
> > iommu_domain *domain,
> >       return 0;
> >  }
> >
> > -static void sprd_iommu_detach_device(struct iommu_domain *domain,
> > -                                          struct device *dev)
> > -{
> > -     struct sprd_iommu_domain *dom = to_sprd_domain(domain);
> > -     struct sprd_iommu_device *sdev = dom->sdev;
> > -     size_t pgt_size = sprd_iommu_pgt_size(domain);
> > -
> > -     if (!sdev)
> > -             return;
> > -
> > -     dma_free_coherent(sdev->dev, pgt_size, dom->pgt_va, dom-
> > >pgt_pa);
> > -     sprd_iommu_hw_en(sdev, false);
> > -     dom->sdev = NULL;
> > -}
> > -
>
> Looks this reveals a bug in this driver (not caused by this removal).
>
> sprd_iommu_attach_device() doesn't check whether the device has
> been already attached to a domain and do auto detach.
>
> It's written in a way that .detach_dev() must be called to free the
> dma buffer but ignores the fact that it's not called when default
> domain support is claimed.
>
> Then the dma buffer allocated for the previous domain was left
> unhandled, causing memory leak.

I'll look into the issue, thanks for pointing this out.

Chunyan
