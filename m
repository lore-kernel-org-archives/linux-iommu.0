From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: [PATCH 4/5] sh: split arch/sh/mm/consistent.c
Date: Tue, 24 Jul 2018 13:43:34 +0200
Message-ID: <20180724114334.GA21973@lst.de>
References: <20180719130516.1989-1-hch@lst.de>
	<20180719130516.1989-5-hch@lst.de> <20180723084207.GI6784@w540>
	<CAMuHMdX=b0iAnDw1=85MXNBSMD=MxZb27QrO3rEWHYq0vB+3ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdX=b0iAnDw1=85MXNBSMD=MxZb27QrO3rEWHYq0vB+3ow-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jacopo Mondi <jacopo-AW8dsiIh9cEdnm+yROfE0A@public.gmane.org>, Rich Felker <dalias-8zAoT0mYgF4@public.gmane.org>, lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Yoshinori Sato <ysato-Rn4VEauK+AKRv+LV9MX5uooqe+aC9MnS@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Jacopo Mondi <jacopo+renesas-AW8dsiIh9cEdnm+yROfE0A@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Jul 23, 2018 at 10:49:39AM +0200, Geert Uytterhoeven wrote:
> > > +     *dma_handle = virt_to_phys(ret);
> > > +     if (!WARN_ON(!dev))
> > > +             *dma_handle - PFN_PHYS(dev->dma_pfn_offset);
> > vs
> > > -     *dma_handle = virt_to_phys(ret);
> > > -     if (!WARN_ON(!dev))
> > > -             *dma_handle -= PFN_PHYS(dev->dma_pfn_offset);
> 
> Doesn't look right to me, neither.
> 
> No complaints for 0day? My gcc says:
> 
>     error: statement with no effect [-Werror=unused-value]

For some reason 0day has failed me multiple times for sh.  Does the
0day bot even cover sh at all?
