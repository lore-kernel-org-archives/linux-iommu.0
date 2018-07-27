From: Grygorii Strashko via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: [PATCH v2 7/7] OF: Don't set default coherent DMA mask
Date: Fri, 27 Jul 2018 13:45:26 -0500
Message-ID: <affa2718-5f3a-7439-db25-ce171a99414a@ti.com>
References: <cover.1532382222.git.robin.murphy@arm.com>
	<66c08e4df2032fde82a2f97544f41fd3a2f24a94.1532382222.git.robin.murphy@arm.com>
	<4ed75bc9-1694-2bcb-2ea9-3f2a04f33f54@ti.com>
	<92d6b010-b5c0-fc59-0668-5b455e26c912@ti.com>
	<c7a9c7ae-1f4a-af9d-df78-1f48bb5c28a5@arm.com>
	<20180727181302.GC17271@n2100.armlinux.org.uk>
Reply-To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180727181302.GC17271-l+eeeJia6m9URfEZ8mYm6t73F7V6hmMc@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org



On 07/27/2018 01:13 PM, Russell King - ARM Linux wrote:
> On Fri, Jul 27, 2018 at 12:36:00PM +0100, Robin Murphy wrote:
>> That is intentional. Consider a 32-bit device on a bus with an upstream DMA
>> range of 40 bits (which could easily happen with e.g. PCI). If the firmware
>> code gives that device 40-bit DMA masks and the driver doesn't change them,
>> then DMA is not going to work correctly. Therefore the firmware code cannot
>> safely make {coherent_}dma_mask larger than the default value passed in, and
>> if the default is 0 then that should be fixed in whatever code created the
>> device, not worked around later.
> 
> I think you're missing the point.
> 
> When OF creates platform devices, they are created without any DMA masks
> what so ever.  It is only during device probe that dma_configure() gets
> called, which then calls of_dma_configure(), where the DMA mask for any
> DT declared device is setup.
> 
> What this means is that your change has broken all existing DT devices
> that are trying to use DMA, because they now end up with a zero coherent
> DMA mask and/or streaming DMA mask.
> 
> Your original idea behind the patch may be a sound one, but since the
> implementation has caused a regression, the implementation is obviously
> broken, and that needs fixing or reworking in some way.
> 

There was additional patch [1] which fixes an issue.

But I have a question to all:
- The patch [1] sets default DMA mask to DMA_BIT_MASK(32)
+	dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
+	if (!dev->dev.dma_mask)
+		dev->dev.dma_mask = &dev->dev.coherent_dma_mask;

this will also work the same way for ARM64

- But of_dma_configure() still have code which does:
	dev->coherent_dma_mask &= mask;
	*dev->dma_mask &= mask;

As result, DMA mask supplied from DT will always be truncated
 to 32 bit for platform devices. for example:

soc0: soc0 {
        compatible = "simple-bus";
        #address-cells = <2>;
        #size-cells = <2>;
        ranges;
+        dma-ranges = <0 0 0 0 0x10000 0>; 

^ 48 bit DMA mask expected to be generated and assigned.

But real mask will be DMA_BIT_MASK(32). As result, any 
DMA capable driver will have be modified to do dma_set_xxx_mask(),
which disregards DT DMA configuration (especially for HW modules
which are used on ARM32 and ARM64).

Could it be considered to do one the changes below?

1) assign mask in case of dt
diff --git a/drivers/of/device.c b/drivers/of/device.c
index 5957cd4..f7dc121 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -150,8 +150,8 @@ int of_dma_configure(struct device *dev, struct device_node *np, bool force_dma)
         */
        mask = DMA_BIT_MASK(ilog2(dma_addr + size - 1) + 1);
        dev->bus_dma_mask = mask;
-       dev->coherent_dma_mask &= mask;
-       *dev->dma_mask &= mask;
+       dev->coherent_dma_mask = mask;
+       *dev->dma_mask = mask;
 
        coherent = of_dma_is_coherent(np);

2) use BITS_PER_LONG for default DMA mask for of_platform devices

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 7ba90c2..3f326e2 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -185,7 +185,7 @@ static struct platform_device *of_platform_device_create_pdata(
        if (!dev)
                goto err_clear_flag;
 
-       dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
+       dev->dev.coherent_dma_mask = DMA_BIT_MASK(BITS_PER_LONG);
        if (!dev->dev.dma_mask)
                dev->dev.dma_mask = &dev->dev.coherent_dma_mask;

3) ...

[1] https://www.spinics.net/lists/arm-kernel/msg668934.html
-- 
regards,
-grygorii
