From: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v4 3/6] of: fix size when dma-range is not used
Date: Wed, 28 Jan 2015 11:05:23 +0000
Message-ID: <20150128110523.GC6646@e104818-lin.cambridge.arm.com>
References: <1422052359-12384-1-git-send-email-m-karicheri2@ti.com>
	<1422052359-12384-4-git-send-email-m-karicheri2@ti.com>
	<54C77616.80301@arm.com> <54C7DF13.20402@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54C7DF13.20402-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jan 27, 2015 at 06:55:15PM +0000, Murali Karicheri wrote:
> On 01/27/2015 06:27 AM, Robin Murphy wrote:
> > On 23/01/15 22:32, Murali Karicheri wrote:
> >> Fix the dma-range size when the DT attribute is missing. i.e set size to
> >> dev->coherent_dma_mask + 1 instead of dev->coherent_dma_mask. To detect
> >> overflow when mask is set to max of u64, add a check, log error and
> >> return.
> >> Some platform use mask format for size in DTS. So add a work around to
> >> catch this and fix.
> >>
> >> Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
> >> Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> >> Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> >> Cc: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
> >> Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> >> Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
> >> Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
> >> Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
> >>
> >> Signed-off-by: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
> >> ---
> >> drivers/of/device.c | 14 +++++++++++++-
> >> 1 file changed, 13 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/of/device.c b/drivers/of/device.c
> >> index 2de320d..0a5ff54 100644
> >> --- a/drivers/of/device.c
> >> +++ b/drivers/of/device.c
> >> @@ -105,12 +105,24 @@ void of_dma_configure(struct device *dev, struct
> >> device_node *np)
> >> ret = of_dma_get_range(np, &dma_addr, &paddr, &size);
> >> if (ret < 0) {
> >> dma_addr = offset = 0;
> >> - size = dev->coherent_dma_mask;
> >> + size = dev->coherent_dma_mask + 1;
> >> } else {
> >> offset = PFN_DOWN(paddr - dma_addr);
> >> + /*
> >> + * Add a work around to treat the size as mask + 1 in case
> >> + * it is defined in DT as a mask.
> >> + */
> >> + if (size & 1)
> >> + size = size + 1;
> >> dev_dbg(dev, "dma_pfn_offset(%#08lx)\n", offset);
> >> }
> >>
> >> + /* if size is 0, we have an overflow of u64 */
> >> + if (!size) {
> >> + dev_err(dev, "invalid size\n");
> >> + return;
> >> + }
> >> +
> >
> > This seems potentially fragile to dodgy DTs given that we might also be
> > using size to make a mask later. Would it make sense to double-up a
> > sanity check as mask-format detection? Something like:
> >
> > if is_power_of_2(size)
> > // use size
> > else if is_power_of_2(size + 1)
> > // use size + 1
> > else
> > // cry
> 
> How about having the logic like this?
> 
> 	ret = of_dma_get_range(np, &dma_addr, &paddr, &size);
> 	if (ret < 0) {
> 		dma_addr = offset = 0;
> 		size = dev->coherent_dma_mask + 1;
> 	} else {
> 		offset = PFN_DOWN(paddr - dma_addr);
> 		dev_dbg(dev, "dma_pfn_offset(%#08lx)\n", offset);
> 	}
> 
> 	if (is_power_of_2(size + 1))
> 		size = size + 1;
> 	else if (!is_power_of_2(size))
> 	{
> 		dev_err(dev, "invalid size\n");
> 		return;
> 	}

In of_dma_configure(), we currently assume that the default coherent
mask is 32-bit. In this thread:

http://article.gmane.org/gmane.linux.kernel/1835096

we talked about setting the coherent mask based on size automatically.
I'm not sure about the size but I think we can assume is 32-bit mask + 1
if it is not specified in the DT. Instead of just assuming a default
mask, let's assume a default size and create the mask based on this
(untested):

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 5b33c6a21807..9ff8d1286b44 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -170,10 +170,10 @@ static void of_dma_configure(struct device *dev)
 	struct iommu_ops *iommu;
 
 	/*
-	 * Set default dma-mask to 32 bit. Drivers are expected to setup
-	 * the correct supported dma_mask.
+	 * Set default size to cover the 32-bit. Drivers are expected to setup
+	 * the correct size and dma_mask.
 	 */
-	dev->coherent_dma_mask = DMA_BIT_MASK(32);
+	size = 1ULL << 32;
 
 	/*
 	 * Set it to coherent_dma_mask by default if the architecture
@@ -185,13 +185,24 @@ static void of_dma_configure(struct device *dev)
 	ret = of_dma_get_range(dev->of_node, &dma_addr, &paddr, &size);
 	if (ret < 0) {
 		dma_addr = offset = 0;
-		size = dev->coherent_dma_mask;
 	} else {
 		offset = PFN_DOWN(paddr - dma_addr);
 		dev_dbg(dev, "dma_pfn_offset(%#08lx)\n", dev->dma_pfn_offset);
 	}
 	dev->dma_pfn_offset = offset;
 
+	/*
+	 * Workaround for DTs setting the size to a mask or 0.
+	 */
+	if (is_power_of_2(size + 1))
+		size += 1;
+
+	/*
+	 * Coherent DMA masks larger than 32-bit must be explicitly set by the
+	 * driver.
+	 */
+	dev->coherent_dma_mask = min(DMA_BIT_MASK(32), DMA_BIT_MASK(ilog2(size)));
+
 	coherent = of_dma_is_coherent(dev->of_node);
 	dev_dbg(dev, "device is%sdma coherent\n",
 		coherent ? " " : " not ");

-- 
Catalin
