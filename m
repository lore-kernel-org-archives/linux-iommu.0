From: Paul Burton <paul.burton-8NJIiSa5LzA@public.gmane.org>
Subject: Re: [PATCH, for-4.19] dma-mapping: add the missing
	ARCH_HAS_SYNC_DMA_FOR_CPU_ALL declaration
Date: Fri, 21 Sep 2018 19:42:20 +0000
Message-ID: <20180921194218.at7ejkmmiucmawzo@pburton-laptop>
References: <20180911090049.10747-1-hch@lst.de> <20180921061052.GA13705@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180921061052.GA13705-jcswGhMUV9g@public.gmane.org>
Content-Language: en-US
Content-ID: <CFF51622A9D0EB4C959480118C3EFF15-UmvZKMv7CrqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org" <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "robin.murphy-5wv7dgnIgG8@public.gmane.org" <robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Christoph,

On Fri, Sep 21, 2018 at 08:10:52AM +0200, Christoph Hellwig wrote:
> Paul, other mips folks, any comments?
> 
> At this point I'm tempted to just move it to 4.20 and add a stable
> tag given that no one cared so far.

Copying Kevin & Florian as maintainers of the affected BMIPS systems in
case they have anything to add.

> On Tue, Sep 11, 2018 at 11:00:49AM +0200, Christoph Hellwig wrote:
> > The patch adding the infrastructure failed to actually add the symbol
> > declaration, oops..
> > 
> > Fixes: faef87723a ("dma-noncoherent: add a arch_sync_dma_for_cpu_all hook")
> > Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
> > ---
> >  kernel/dma/Kconfig | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> > index 9bd54304446f..1b1d63b3634b 100644
> > --- a/kernel/dma/Kconfig
> > +++ b/kernel/dma/Kconfig
> > @@ -23,6 +23,9 @@ config ARCH_HAS_SYNC_DMA_FOR_CPU
> >  	bool
> >  	select NEED_DMA_MAP_STATE
> >  
> > +config ARCH_HAS_SYNC_DMA_FOR_CPU_ALL
> > +	bool
> > +
> >  config DMA_DIRECT_OPS
> >  	bool
> >  	depends on HAS_DMA

The change looks reasonable to me, so feel free to take your choice of:

    Reviewed-by: Paul Burton <paul.burton-8NJIiSa5LzA@public.gmane.org>
    Acked-by: Paul Burton <paul.burton-8NJIiSa5LzA@public.gmane.org>

My thought would be that it would be ideal to fix in 4.19 since that's
where the breakage is, but having said that I don't have much insight
into how bad the breakage is for the affected systems.

Thanks,
    Paul
