From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC PATCH v2 2/7] dma-mapping: replace set_arch_dma_coherent_ops
	with arch_setup_dma_ops
Date: Tue, 9 Sep 2014 17:15:58 +0300
Message-ID: <540F0B9E.5060505@ti.com>
References: <1409680587-29818-1-git-send-email-will.deacon@arm.com>
	<1409680587-29818-3-git-send-email-will.deacon@arm.com>
	<5409D8C5.9010804@ti.com> <20140908103129.GC26030@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140908103129.GC26030-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Will,

On 09/08/2014 01:31 PM, Will Deacon wrote:
> On Fri, Sep 05, 2014 at 04:37:41PM +0100, Grygorii Strashko wrote:
> 
>> On 09/02/2014 08:56 PM, Will Deacon wrote:
>>> set_arch_dma_coherent_ops is called from of_dma_configure in order to
>>> swizzle the architectural dma-mapping functions over to a cache-coherent
>>> implementation. This is currently implemented only for ARM.
>>>
>>> In anticipation of re-using this mechanism for IOMMU-backed dma-mapping
>>> ops too, this patch replaces the function with a broader
>>> arch_setup_dma_ops callback which is also responsible for setting the
>>> DMA mask and offset as well as selecting the correct mapping functions.
>>>
>>> A further advantage of this split is that it nicely isolates the
>>> of-specific code from the dma-mapping code, allowing potential reuse by
>>> other buses (e.g. PCI) in the future.
>>
>> I think this patch can introduce a regression if it will be used as is :(
>>
>> When this code was initially created there ware a lot of discussion about
>> and finally it was decided to configure all common (for all arches) DMA
>> specific parameters for devices in common code, while strictly arch
>> specific things using arch specific APIs/callbacks.
>>
>> The following parameters are common now:
>> dev->coherent_dma_mask	= mask;
>> dev->dma_mask		= &dev->coherent_dma_mask;
>> dev->dma_pfn_offset	= offset;
>>
>> and they need to be set always, otherwise it will affect on other
>> DT-based arches.
> 
> Ok, in which case we can either configure the struct device in
> of_dma_configure before calling arch_setup_dma_ops, or we can do the work
> in a generic version of arch_setup_dma_ops (that I haven't added yet).

Just think that it would more simpler to add arch-API:
  arch_setup_iommu(struct device *dev, struct iommu_dma_mapping *iommu)

and call it at the end of of_dma_configure() as following:

  arch_setup_iommu(dev, of_iommu_configure(dev));

so it will setup IOMMU parameters for device and overwrite DMA
parameters respectively.

if IOMMU is not present/disabled arch_setup_iommu() will be a NOP and 
system will roll back to default (old) behavior.

Also it will simplify ARM dma-mapping changes -
 only IOMMU code will need to be added.

Best regards,
-grygorii
