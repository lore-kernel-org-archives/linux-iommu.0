From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2 2/4] iommu: Implement common IOMMU ops for DMA mapping
Date: Fri, 19 Jun 2015 09:06:12 +0800
Message-ID: <1434675972.30129.0.camel@mhfsdcap03>
References: <cover.1434036796.git.robin.murphy@arm.com>
	<bf63d80c36533aa4dcc401b5a4b312ba00237e1c.1434036796.git.robin.murphy@arm.com>
	<1434639625.26953.12.camel@mhfsdcap03> <5582F7C5.8060901@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5582F7C5.8060901-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: "laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "yt.shen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <yt.shen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, 2015-06-18 at 17:54 +0100, Robin Murphy wrote:
> On 18/06/15 16:00, Yong Wu wrote:
> > Hi Robin,
> >      while our drm test, we meet a problem while dma-mmap.
> >
> >   On Thu, 2015-06-11 at 16:54 +0100, Robin Murphy wrote:
> >> Taking inspiration from the existing arch/arm code, break out some
> >> generic functions to interface the DMA-API to the IOMMU-API. This will
> >> do the bulk of the heavy lifting for IOMMU-backed dma-mapping.
> >>
> >> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> >> ---
> >>   drivers/iommu/Kconfig     |   7 +
> >>   drivers/iommu/Makefile    |   1 +
> >>   drivers/iommu/dma-iommu.c | 560 ++++++++++++++++++++++++++++++++++++++++++++++
> >>   include/linux/dma-iommu.h |  94 ++++++++
> >>   4 files changed, 662 insertions(+)
> >>   create mode 100644 drivers/iommu/dma-iommu.c
> >>   create mode 100644 include/linux/dma-iommu.h
> >>
> > [snip]
> >> +/**
> >> + * iommu_dma_mmap - Map a buffer into provided user VMA
> >> + * @pages: Array representing buffer from iommu_dma_alloc()
> >> + * @size: Size of buffer in bytes
> >> + * @vma: VMA describing requested userspace mapping
> >> + *
> >> + * Maps the pages of the buffer in @pages into @vma. The caller is responsible
> >> + * for verifying the correct size and protection of @vma beforehand.
> >> + */
> >> +
> >> +int iommu_dma_mmap(struct page **pages, size_t size, struct vm_area_struct *vma)
> >> +{
> >> +	unsigned long uaddr = vma->vm_start;
> >> +	unsigned int i, count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> >> +	int ret = -ENXIO;
> >> +
> >> +	for (i = vma->vm_pgoff; i < count && uaddr < vma->vm_end; i++) {
> > Is it :  for (i = 0; i < count && uaddr < vma->vm_end; i++)
> 
> According to the patches at [1], respecting vma->pgoff is necessary for 
> users who only want to mmap part of the buffer. Does your DRM driver by 
> any chance need the same fix as the Rockchip one?
Thanks. We will try to add it.
> 
> >> +		ret = vm_insert_page(vma, uaddr, pages[i]);
> >> +		if (ret)
> >> +			break;
> >> +		uaddr += PAGE_SIZE;
> >> +	}
> >> +	return ret;
> >> +}
> >> +
> 
> And to save another email:
> 
>  >> +	if (WARN_ON(!area || area->pages))
>  > Is it:    if (WARN_ON(!area || !area->pages))
>  >> +		return -ENXIO;
> 
> You're absolutely right, thanks. I've got a couple more bugfixes in 
> progress too, so I'll try to get an updated branch pushed out soon; I'll 
> hold off posting a v3 to the list until after the upcoming merge window, 
> though.
> 
> Robin.
> 
> [1]:http://thread.gmane.org/gmane.linux.kernel/1932343
> 
