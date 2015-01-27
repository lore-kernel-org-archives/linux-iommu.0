From: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v4 6/6] arm: dma-mapping: updates to limit dma_mask and
	iommu mapping size
Date: Tue, 27 Jan 2015 11:34:16 +0000
Message-ID: <20150127113416.GB3226@e104818-lin.cambridge.arm.com>
References: <1422052359-12384-1-git-send-email-m-karicheri2@ti.com>
	<1422052359-12384-7-git-send-email-m-karicheri2@ti.com>
	<54C772A0.2000203@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54C772A0.2000203-5wv7dgnIgG8@public.gmane.org>
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
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jan 27, 2015 at 11:12:32AM +0000, Robin Murphy wrote:
> On 23/01/15 22:32, Murali Karicheri wrote:
> > Limit the dma_mask to minimum of dma_mask and dma_base + size - 1.
> >
> > Also arm_iommu_create_mapping() has size parameter of size_t and
> > arm_setup_iommu_dma_ops() can take a value higher than that. So
> > limit the size to SIZE_MAX.
> >
> > Signed-off-by: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
> > ---
> >   arch/arm/mm/dma-mapping.c |   10 ++++++++++
> >   1 file changed, 10 insertions(+)
> >
> > diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> > index 7864797..a1f9030 100644
> > --- a/arch/arm/mm/dma-mapping.c
> > +++ b/arch/arm/mm/dma-mapping.c
> > @@ -2004,6 +2004,13 @@ static bool arm_setup_iommu_dma_ops(struct device *dev, u64 dma_base, u64 size,
> >   	if (!iommu)
> >   		return false;
> >
> > +	/*
> > +	 * currently arm_iommu_create_mapping() takes a max of size_t
> > +	 * for size param. So check this limit for now.
> > +	 */
> > +	if (size > SIZE_MAX)
> > +		return false;
> > +
> >   	mapping = arm_iommu_create_mapping(dev->bus, dma_base, size);
> >   	if (IS_ERR(mapping)) {
> >   		pr_warn("Failed to create %llu-byte IOMMU mapping for device %s\n",
> > @@ -2053,6 +2060,9 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> >   {
> >   	struct dma_map_ops *dma_ops;
> >
> > +	/* limit dma_mask to the lower of the two values */
> > +	*dev->dma_mask = min((*dev->dma_mask), (dma_base + size - 1));
> > +
> 
> Is there any reason not to do this in of_dma_configure? It seems like 
> something everyone could benefit from - I'd cooked up a dodgy workaround 
> for the same issue in my arm64 IOMMU code, but handling it generically 
> in common code would be much nicer.

I agree. I started something here:

http://article.gmane.org/gmane.linux.kernel/1835096

but I don't remember to have got to a clear conclusion.

-- 
Catalin
