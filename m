Return-Path: <SRS0=Kr6o=WN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D928AC3A59E
	for <iommu@archiver.kernel.org>; Sat, 17 Aug 2019 07:20:08 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C1742173B
	for <iommu@archiver.kernel.org>; Sat, 17 Aug 2019 07:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tcd-ie.20150623.gappssmtp.com header.i=@tcd-ie.20150623.gappssmtp.com header.b="iuaKaoZk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C1742173B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tcd.ie
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6517841C;
	Sat, 17 Aug 2019 07:20:08 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9EE24265
	for <iommu@lists.linux-foundation.org>;
	Sat, 17 Aug 2019 07:20:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-io1-f67.google.com (mail-io1-f67.google.com
	[209.85.166.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id DE75363D
	for <iommu@lists.linux-foundation.org>;
	Sat, 17 Aug 2019 07:20:06 +0000 (UTC)
Received: by mail-io1-f67.google.com with SMTP id i22so10777012ioh.2
	for <iommu@lists.linux-foundation.org>;
	Sat, 17 Aug 2019 00:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=tcd-ie.20150623.gappssmtp.com; s=20150623;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=3gnS0PBpeFma+nR0/93xLJSxk0RZjywB6TYlsGP6x54=;
	b=iuaKaoZkqD3jS65GkFRQXUesr+iHDQw7qZXVp3ez2fmCt49N//RMqfebteueaUoH+p
	97zi714OqDL373xaRAuH3dX8FyF/Ggim5AtCytyMJbs8OW1HRJxUvrBWziOojWSjQyyv
	N8V4gNN86Fa2SkaukvBfzPcjbRwF05BDdxAP0vXBWYtOD0SIpiwB1xkPByOxsAsX+9h1
	04BQeNXJdFWKxBekEW+jFClh2sgwRA/Wjk7i3VyRYr7XND2lelrmJe56TnoW4qN1h7sB
	KsNL/98KtTPtlpVSTykKF2Hed4ptAKREhBRKgytLAlnBDShNx9anmljZsQvOgXkrjk/s
	f08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=3gnS0PBpeFma+nR0/93xLJSxk0RZjywB6TYlsGP6x54=;
	b=t8zwaE2X0+6m+fiJG5NKolECACi9ZmUY1nVyVZTMSyH8mutFNvxlqnpg8M5ia/OWjt
	L6S+Bmy+GVQvrvkSdf6KtO15PGZkLtnQdk/GVxszScikWiIus7mT8zg+qkyJQznbyJ8P
	jA4qpWctGutalPMy4LJbl29VXiNX8taoJymGTYiZ8DpoXsjs8+jtgeNDpQwMb+aHRgLS
	j9nF4PuSBGUWHZBGF2hmiVSD/F8+5Oil1/npsOK/zLosEZIdN6cCGP/xJsDBF8FPJCbB
	91iA0WnzwOPAZSg3cDQrXQ+6v4V11WvS178/Q+eAALZGs9EoweVDUHwXQqeKiJsb/6cO
	Q16Q==
X-Gm-Message-State: APjAAAUlV+DRPmOOcmf2CSZfp29NczE1S7H5vVVS8YeBvfXbJEcSpfA8
	RT1hLpirdJlOL7XSSxy1QA/whWnWDe0wnj9zHQJo/w==
X-Google-Smtp-Source: APXvYqzi3uE7FL/BNaGBwf9NcctQEJa1uqSCgIDdI7X8T4a271+rNn6qVr2H/9WkS8ckRMiROhEplUC0qpc0vOhpjPg=
X-Received: by 2002:a02:a18e:: with SMTP id n14mr15977616jah.84.1566026405753; 
	Sat, 17 Aug 2019 00:20:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190815110944.3579-1-murphyt7@tcd.ie>
	<20190817033914.4812-1-hdanton@sina.com>
In-Reply-To: <20190817033914.4812-1-hdanton@sina.com>
From: Tom Murphy <murphyt7@tcd.ie>
Date: Sat, 17 Aug 2019 08:19:33 +0100
Message-ID: <CALQxJut_0bjojiFza9bZF26n0+9Vjq8QFqsxgd5Rxag+Qx609Q@mail.gmail.com>
Subject: Re: [PATCH V5 3/5] iommu/dma-iommu: Handle deferred devices
To: Hillf Danton <hdanton@sina.com>
Cc: Heiko Stuebner <heiko@sntech.de>, virtualization@lists.linux-foundation.org,
	linux-tegra@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
	Will Deacon <will@kernel.org>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>, linux-rockchip@lists.infradead.org,
	Andy Gross <agross@kernel.org>,
	Gerald Schaefer <gerald.schaefer@de.ibm.com>,
	linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	David Woodhouse <dwmw2@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Kukjin Kim <kgene@kernel.org>, Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Sat, 17 Aug 2019 at 04:39, Hillf Danton <hdanton@sina.com> wrote:
>
>
> On Thu, 15 Aug 2019 12:09:41 +0100 Tom Murphy wrote:
> >
> > Handle devices which defer their attach to the iommu in the dma-iommu api
> >
> > Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
> > ---
> >  drivers/iommu/dma-iommu.c | 27 ++++++++++++++++++++++++++-
> >  1 file changed, 26 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index 2712fbc68b28..906b7fa14d3c 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -22,6 +22,7 @@
> >  #include <linux/pci.h>
> >  #include <linux/scatterlist.h>
> >  #include <linux/vmalloc.h>
> > +#include <linux/crash_dump.h>
> >
> >  struct iommu_dma_msi_page {
> >       struct list_head        list;
> > @@ -351,6 +352,21 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
> >       return iova_reserve_iommu_regions(dev, domain);
> >  }
> >
> > +static int handle_deferred_device(struct device *dev,
> > +     struct iommu_domain *domain)
> > +{
> > +     const struct iommu_ops *ops = domain->ops;
> > +
> > +     if (!is_kdump_kernel())
> > +             return 0;
> > +
> > +     if (unlikely(ops->is_attach_deferred &&
> > +             ops->is_attach_deferred(domain, dev)))
> > +             return iommu_attach_device(domain, dev);
> > +
> > +     return 0;
> > +}
> > +
> >  /**
> >   * dma_info_to_prot - Translate DMA API directions and attributes to IOMMU API
> >   *                    page flags.
> > @@ -463,6 +479,9 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
> >       size_t iova_off = iova_offset(iovad, phys);
> >       dma_addr_t iova;
> >
> > +     if (unlikely(handle_deferred_device(dev, domain)))
> > +             return DMA_MAPPING_ERROR;
> > +
> >       size = iova_align(iovad, size + iova_off);
> >
> >       iova = iommu_dma_alloc_iova(domain, size, dma_get_mask(dev), dev);
>
> iommu_map_atomic() is applied to __iommu_dma_map() in 2/5.
> Is it an atomic context currently given the mutex_lock() in
> iommu_attach_device()?

I don't see your point here. __iommu_dma_map isn't called from
iommu_attach_device, why would we care about a mutex in
iommu_attach_device?

__iommu_dma_map can be called from an atomic context (it isn't always
but it does happen). __iommu_dma_map is called by iommu_dma_alloc
which implements the iommu_dma_ops::alloc function which by design
needs to be callable from an atomic context. Does that answer your
question?

>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
