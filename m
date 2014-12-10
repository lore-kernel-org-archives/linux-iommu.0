From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v6 6/8] dma-mapping: detect and configure IOMMU in
	of_dma_configure
Date: Wed, 10 Dec 2014 15:54:10 +0000
Message-ID: <54886CA2.3040406@arm.com>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
	<1417453034-21379-7-git-send-email-will.deacon@arm.com>
	<CAF6AEGs6dZauq1QxY_OqBPUs0xHYjjGTi+H7Vm-mNvJtmTAHRA@mail.gmail.com>
	<20141210150853.GH23639@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20141210150853.GH23639-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 10/12/14 15:08, Will Deacon wrote:
> On Wed, Dec 10, 2014 at 02:52:56PM +0000, Rob Clark wrote:
>> On Mon, Dec 1, 2014 at 11:57 AM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
>>> This patch extends of_dma_configure so that it sets up the IOMMU for a
>>> device, as well as the coherent/non-coherent DMA mapping ops.
>>>
>>> Acked-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
>>> Acked-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>>> Tested-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>>> Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
>>> ---
>>>   arch/arm/include/asm/dma-mapping.h |  4 +++-
>>>   drivers/of/platform.c              | 21 ++++++++++++++-------
>>>   include/linux/dma-mapping.h        |  8 +++++++-
>>>   3 files changed, 24 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
>>> index dc3420e77758..f3c0d953f6a2 100644
>>> --- a/arch/arm/include/asm/dma-mapping.h
>>> +++ b/arch/arm/include/asm/dma-mapping.h
>>> @@ -121,7 +121,9 @@ static inline unsigned long dma_max_pfn(struct device *dev)
>>>   }
>>>   #define dma_max_pfn(dev) dma_max_pfn(dev)
>>>
>>> -static inline void arch_setup_dma_ops(struct device *dev, bool coherent)
>>> +static inline void arch_setup_dma_ops(struct device *dev, u64 dma_base,
>>> +                                     u64 size, struct iommu_ops *iommu,
>>> +                                     bool coherent)
>>>   {
>>>          if (coherent)
>>>                  set_dma_ops(dev, &arm_coherent_dma_ops);
>>> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
>>> index ff1f4e9afccb..b89caf8c7586 100644
>>> --- a/drivers/of/platform.c
>>> +++ b/drivers/of/platform.c
>>> @@ -19,6 +19,7 @@
>>>   #include <linux/slab.h>
>>>   #include <linux/of_address.h>
>>>   #include <linux/of_device.h>
>>> +#include <linux/of_iommu.h>
>>>   #include <linux/of_irq.h>
>>>   #include <linux/of_platform.h>
>>>   #include <linux/platform_device.h>
>>> @@ -166,6 +167,7 @@ static void of_dma_configure(struct device *dev)
>>>          int ret;
>>>          bool coherent;
>>>          unsigned long offset;
>>> +       struct iommu_ops *iommu;
>>>
>>>          /*
>>>           * Set default dma-mask to 32 bit. Drivers are expected to setup
>>> @@ -194,7 +196,16 @@ static void of_dma_configure(struct device *dev)
>>>          dev_dbg(dev, "device is%sdma coherent\n",
>>>                  coherent ? " " : " not ");
>>>
>>> -       arch_setup_dma_ops(dev, coherent);
>>> +       iommu = of_iommu_configure(dev);
>>> +       dev_dbg(dev, "device is%sbehind an iommu\n",
>>> +               iommu ? " " : " not ");
>>> +
>>> +       arch_setup_dma_ops(dev, dma_addr, size, iommu, coherent);
>>
>>
>> so, what is the way for a driver that explicitly wants to manage it's
>> own device virtual address space to opt out of this?  I suspect that
>> won't be the common case, but for a gpu, if dma layer all of a sudden
>> thinks it is in control of the gpu's virtual address space, things are
>> going to end in tears..
>
> I think you'll need to detach from the DMA domain, then have the driver
> manage everything itself. As you say, it's not the common case, so you
> may need to add some hooks for detaching from the default domain and
> swizzling your DMA ops.
>

Surely if that's a problem then it's an existing one anyway? If the 
IOMMU driver wants to do its own thing here all it has to do is return 
-ENOTHANKSIDRATHERNOT from its of_xlate call (or be even more boring and 
simply not implement it), and the device gets whatever default DMA ops 
the old of_dma_configure would have given it, with zero impact from this 
series. I only see a potential issue if you have one driver running 
multiple IOMMUs, some of which are happy to pass off control to DMA 
mapping and some not, in which case either you make the driver clever 
enough to identify its clients and handle of_xlate correctly, or work 
around it with the DT representation.

Robin.
