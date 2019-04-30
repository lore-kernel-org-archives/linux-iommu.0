Return-Path: <SRS0=Kg+4=TA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30642C43219
	for <iommu@archiver.kernel.org>; Tue, 30 Apr 2019 14:05:35 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAAEF21734
	for <iommu@archiver.kernel.org>; Tue, 30 Apr 2019 14:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arista.com header.i=@arista.com header.b="OA3m6lvC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAAEF21734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id ABF7A19AB;
	Tue, 30 Apr 2019 14:05:34 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 75BEB19A6
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Apr 2019 14:05:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
	[209.85.221.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 93AC7608
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Apr 2019 14:05:08 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id a9so21185592wrp.6
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Apr 2019 07:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=arista.com; s=googlenew;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=k/9wOkFYEcdfe2lDE3RgJ9XrcROImtihW8mQBU1smko=;
	b=OA3m6lvCcq8/juhLoSHA7zp4SBEq74FDRp+bt82WW/O1qduxhlEYloq+dn0azMWtnA
	n3FZy37ln/zhGjGYyzx4onZAxbedE4a+MxlD6pitCmdT7Qh5ChbdLOjK2Bn9FP4P5VXQ
	dJhFXGVFYLTssM/QMhCQE1/HM/y+K1REM05WF4TLZCbLuuWebi+Rja1ORa7yawLDbgJU
	koESfJzTV4QtR5aNCXd9h+a+gQITKLTutgfRGuuZmyf4GInAAfsh1u4xKWmHrPT3gX86
	xnxk0DqFSjm4Xc2yxxXOlvMd78yWIrqoGSZE85ey4WzTI9UAm1clSklJF/uA3/XrN3eX
	ePkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=k/9wOkFYEcdfe2lDE3RgJ9XrcROImtihW8mQBU1smko=;
	b=g0JPwrqRCj7+JNv8bGmklylKsSOcSLSi/kPj7XqnsMicEIXkmDdag1fz7AP9bkLgL4
	r+e+sdydcr4J+7xNt6RKkFG0HMgLcs9cDmjLqato+MnIbiDOjA1ZOCS89r0Flm5ypDGf
	zNQyMdRfO/p+rWuAFWhVw2Axpc+ECogPsUdQrSn/+lkN8XtD4TuTmDwXcdF4n6T719oK
	PrlWFOfbNfyFy6CV8uVKDQciZml3pMPyaIB92ccydfpi/rbR7NDBwE0Q+6bPU4NJAYw0
	KCge3zprPwZdATj93Df/ldNsFTju6W+0YZ2i7mxCSBDNIMXZkgWlhKq56vaCSAfLpiRy
	YJ0A==
X-Gm-Message-State: APjAAAX26ulcoz+RrRDXh5G38diX7V3P7mZRRWjTswAS26KwBIWL3y6a
	8+slkLlKkonbQblfG0R/axOqpI19G5GRCEkkV+Mq9w==
X-Google-Smtp-Source: APXvYqzzIdbUrD0qcyluPgpdlTsVev3ygvx2lD9BOg8bHhMuXmms+vYEjLzdr+qc3EOfM4jIlT0RLX6uxvBgRC84Zvg=
X-Received: by 2002:adf:b68d:: with SMTP id j13mr48305854wre.50.1556633106943; 
	Tue, 30 Apr 2019 07:05:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190430002952.18909-1-tmurphy@arista.com>
	<20190430002952.18909-3-tmurphy@arista.com>
	<2750fa37-a59c-3074-6545-b19046ce3699@arm.com>
In-Reply-To: <2750fa37-a59c-3074-6545-b19046ce3699@arm.com>
Date: Tue, 30 Apr 2019 15:04:55 +0100
Message-ID:
 <CAPL0++4UeWczgmSa+X0L2_27Xr5tsXTU4k_B1JB33Tm=vQAa8Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] iommu/dma-iommu: Handle deferred devices
To: Robin Murphy <robin.murphy@arm.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Will Deacon <will.deacon@arm.com>,
	David Brown <david.brown@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	iommu@lists.linux-foundation.org, Krzysztof Kozlowski <krzk@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>, linux-rockchip@lists.infradead.org,
	Kukjin Kim <kgene@kernel.org>,
	Gerald Schaefer <gerald.schaefer@de.ibm.com>,
	Andy Gross <andy.gross@linaro.org>, linux-tegra@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Tom Murphy <murphyt7@tcd.ie>,
	David Woodhouse <dwmw2@infradead.org>
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
From: Tom Murphy via iommu <iommu@lists.linux-foundation.org>
Reply-To: Tom Murphy <tmurphy@arista.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190430140455.QE2Gpx_ojN1ji8efTqce3nuYcb_8G2QWNXN_N-p0uZw@z>

On Tue, Apr 30, 2019 at 2:42 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 30/04/2019 01:29, Tom Murphy wrote:
> > Handle devices which defer their attach to the iommu in the dma-iommu api
>
> I've just spent a while trying to understand what this is about...
>
> AFAICS it's a kdump thing where the regular default domain attachment
> may lead to ongoing DMA traffic from the crashed kernel raising a fault
> storm, so we put off the "real" attach of a given device until we know
> it's been reset and brought into a sane state, but the only way to
> reliably detect that is to wait until the kdump kernel driver starts
> making new DMA mappings. Is that about right?

That's the impression I got too. The many iterations of the patch
series which contributed this code makes it hard to figure out exactly
why it's doing what it's doing but AFAIK it works how you described
it.

>
> (I note that for SMMUv3 we now handle that situation with the slightly
> more heavy-handed approach of just turning off reporting and letting the
> 'rogue' devices fault silently, but I appreciate that not all IOMMUs may
> have that option)
>
> > Signed-off-by: Tom Murphy <tmurphy@arista.com>
> > ---
> >   drivers/iommu/dma-iommu.c | 30 ++++++++++++++++++++++++++++++
> >   1 file changed, 30 insertions(+)
> >
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index 7a96c2c8f56b..c18f74ad1e8b 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -322,6 +322,17 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
> >       return iova_reserve_iommu_regions(dev, domain);
> >   }
> >
> > +static int handle_deferred_device(struct device *dev)
> > +{
> > +     struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
>
> We don't want iommu_get_domain_for_dev() in fast-paths, as the
> contention on the group refcount has proven to have a surprisingly high
> overhead on some large systems. That's what iommu_get_dma_domain()
> solves, but ideally, can this be wrapped in is_kdump_kernel() such as to
> have no impact at all on the general case?

will do.

>
> > +     const struct iommu_ops *ops = domain->ops;
> > +
> > +     if (ops->is_attach_deferred && ops->is_attach_deferred(domain, dev))
> > +             return iommu_attach_device(domain, dev);
> > +
> > +     return 0;
> > +}
> > +
> >   /**
> >    * dma_info_to_prot - Translate DMA API directions and attributes to IOMMU API
> >    *                    page flags.
> > @@ -835,6 +846,8 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
> >       bool coherent = dev_is_dma_coherent(dev);
> >       dma_addr_t dma_handle;
> >
> > +     handle_deferred_device(dev);
> > +
> >       dma_handle =__iommu_dma_map(dev, phys, size,
> >                       dma_info_to_prot(dir, coherent, attrs),
> >                       iommu_get_dma_domain(dev));
> > @@ -849,6 +862,8 @@ static void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
> >   {
> >       struct iommu_domain *domain = iommu_get_dma_domain(dev);
> >
> > +     handle_deferred_device(dev);
>
> You don't need this - it's completely bogus to make an unmap call
> without having already called the corresponding map function, so we can
> assume it's already been dealt with.
>
> > +
> >       if (!dev_is_dma_coherent(dev) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC)) {
> >               phys_addr_t phys = iommu_iova_to_phys(domain, dma_handle);
> >
> > @@ -873,6 +888,8 @@ static int __finalise_sg(struct device *dev, struct scatterlist *sg, int nents,
> >       unsigned int cur_len = 0, max_len = dma_get_max_seg_size(dev);
> >       int i, count = 0;
> >
> > +     handle_deferred_device(dev);
>
> Hmm, this should be in iommu_dma_map_sg() - that's the guy that needs a
> valid domain, and it's impossible to get to __finalise_sg() without
> having been through there anyway.
>
> > +
> >       for_each_sg(sg, s, nents, i) {
> >               /* Restore this segment's original unaligned fields first */
> >               unsigned int s_iova_off = sg_dma_address(s);
> > @@ -1022,6 +1039,8 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
> >       struct scatterlist *tmp;
> >       int i;
> >
> > +     handle_deferred_device(dev);
>
> Again, not necessary.
>
> > +
> >       if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
> >               iommu_dma_sync_sg_for_cpu(dev, sg, nents, dir);
> >
> > @@ -1042,6 +1061,8 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
> >   static dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
> >               size_t size, enum dma_data_direction dir, unsigned long attrs)
> >   {
> > +     handle_deferred_device(dev);
>
> Ditto.
>
> > +
> >       return __iommu_dma_map(dev, phys, size,
> >                       dma_info_to_prot(dir, false, attrs) | IOMMU_MMIO,
> >                       iommu_get_dma_domain(dev));
> > @@ -1050,12 +1071,15 @@ static dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
> >   static void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
> >               size_t size, enum dma_data_direction dir, unsigned long attrs)
> >   {
> > +     handle_deferred_device(dev);
>
> Ditto.
>
> > +
> >       __iommu_dma_unmap(iommu_get_dma_domain(dev), handle, size);
> >   }
> >
> >   static void *iommu_dma_alloc(struct device *dev, size_t size,
> >               dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
> >   {
> > +     handle_deferred_device(dev);
> >       gfp |= __GFP_ZERO;
> >
> >   #ifdef CONFIG_DMA_DIRECT_REMAP
> > @@ -1076,6 +1100,8 @@ static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
> >   {
> >       struct page *page;
> >
> > +     handle_deferred_device(dev);
>
> Similarly, you can't free anything that hasn't already come from a
> successful call to iommu_dma_alloc()...
>
> > +
> >       /*
> >        * cpu_addr can be one of 4 things depending on how it was allocated:
> >        *
> > @@ -1115,6 +1141,8 @@ static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
> >       unsigned long pfn;
> >       int ret;
> >
> > +     handle_deferred_device(dev);
>
> ...nor can you mmap() it...
>
> > +
> >       vma->vm_page_prot = arch_dma_mmap_pgprot(dev, vma->vm_page_prot, attrs);
> >
> >       if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
> > @@ -1143,6 +1171,8 @@ static int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
> >       struct page *page;
> >       int ret;
> >
> > +     handle_deferred_device(dev);
>
> ...nor attempt to export it.

That all makes sense. Will fix.

>
> Robin.
>
> > +
> >   #ifdef CONFIG_DMA_DIRECT_REMAP
> >       if (is_vmalloc_addr(cpu_addr)) {
> >               if (!(attrs & DMA_ATTR_FORCE_CONTIGUOUS))
> >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
