From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH/RFC 0/4] Probe deferral for IOMMU DT integration
Date: Wed, 04 Mar 2015 10:20:36 +0100
Message-ID: <54F6CE64.8040503@samsung.com>
References: <1423182722-16646-1-git-send-email-lauraa@codeaurora.org>
	<1519819.qZaXvuQI61@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <1519819.qZaXvuQI61@avalon>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Laura Abbott <lauraa-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hello,

On 2015-02-16 17:14, Laurent Pinchart wrote:
> Hi Laura and all,
>
> On Thursday 05 February 2015 16:31:58 Laura Abbott wrote:
>> Hi,
>>
>> On the heels of Exynos integrating SMMU in to the DT for probing,
>> this series attempts to add support to make SMMU drivers work with
>> deferred probing. This has been referenced before[1] but this is
>> some actual code to use as a starting point for discussion.
>>
>> The requirement for this is based on a previous patch to add clock
>> support to the ARM SMMU driver[2]. Once we have clock support, it's
>> possible that the driver itself may need to be defered which breaks
>> a bunch of assumptions about how SMMU probing is supposed to work.
>> The concept here is to have the driver call of_dma_configure which
>> may return -EPROBE_DEFER. of_dma_configure could possibly be moved
>> up to probe level. The existing method of initialization still needs
>> to be done as well which might mean we have the worst of both worlds.
>>
>> Open questions:
>> - This still doesn't really address Arnd's concerns[3] about disabling
>> IOMMUs
> Arnd, Will and I have discussed IOMMU probe deferral last week. Here's a
> summary of the discussion, before the details blur away.
>
> The discussion covered both higher level concepts and lower level details, in
> various directions. I'll try to make the summary clear by filling the gaps
> between pieces where needed, so some of the information below might not be a
> direct result of the discussions. Arnd and Will, please feel free to correct
> me.
>
> The first question we've discussed was whether probe deferral for IOMMUs is
> really needed. Various dependencies between IOMMU devices and other devices
> exist, in particular on clocks (as you have mentioned above) and on power
> domains (as mentioned by Marek in http://lists.infradead.org/pipermail/linux-arm-kernel/2015-February/323238.html). While there are mechanism to handle
> some of them with probe deferral (for instance by using the OF_DECLARE macros
> to register clock drivers), generalizing those mechanisms would essentially
> recreate a probe ordering mechanism similar to link order probe ordering and
> couldn't really scale.
>
> Additionally, IOMMUs could also be present hot-pluggable devices and depend on
> resources that are thus hot-plugged. OF_DECLARE wouldn't help in that case.
> For all those reasons we have concluded that probe deferral for IOMMUs is
> desired if it can be implemented cleanly.
>
> The second question we've discussed was how to implement probe deferral
> cleanly :-)
>
> The current implementation configures DMA at device creation time and sets the
> following properties:
>
> - dma_map_ops (IOMMU, SWIOTLB, linear mapping)
> - initial DMA mask
> - DMA offset
> - DMA coherency
>
> Additionally the IOMMU group (when an IOMMU is present) will also be
> configured at the same time (patches are under review).
>
> The base idea is to defer probing of bus master devices when their IOMMU isn't
> present. Three cases need to be handled.
>
> 1. No IOMMU is declared by the firmware (through DT, ACPI, ...) for the bus
> master device. The bus master device probe doesn't need to be deferred due to
> the IOMMU. dma_map_ops must be set to SWIOTLB or linear mapping (the later
> should likely be implemented through SWIOTLB).
>
> 2. An IOMMU is declared for the bus master device and the IOMMU has been
> successfully probed and registered. The bus master device probe doesn't need
> to be deferred due to the IOMMU. dma_map_ops must be set to IOMMU ops.
>
> 3. An IOMMU is declared for the bus master device but the IOMMU isn't
> registered. This can be caused by different reasons:
>
> - a. No driver is loaded for this IOMMU (for instance because DT describes the
> IOMMU connection, but the IOMMU driver hasn't been developed yet, or an older
> kernel is used). If the IOMMU is optional the bus master device probe should
> succeed, and dma_map_ops should be set to linear. If the IOMMU is mandatory
> the bus master device probe should fail.
>
> Note that, as we require IOMMU drivers to be compiled in, we don't need to
> handle the case of loadable IOMMU drivers that haven't been loaded yet.
>
> - b. A driver is loaded for this IOMMU but the IOMMU hasn't been probed yet,
> or its probe has been deferred. The bus master device probe should be
> deferred.
>
> - c. A driver is loaded for this IOMMU but the IOMMU probe has failed
> permanently. It's not clear at the moment whether we should try to recover
> from this automatically using the same mechanism as case 3.a, or if we can
> considered this as an abnormal failure and disable the bus master device.
>
> Assuming that we should try to recover from such an error, we can't predict
> this case when the device is instantiated (even if IOMMUs are registered
> before bus master devices are added, for instance using the OF_DECLARE
> mechanism that Will has implemented). We thus need to setup the dma_map_ops
> and IOMMU group at bus master device probe time.
>
> Furthermore, we can't distinguish cases 3.a and 3.b at bus master probe time
> without early registration of IOMMU drivers. Case 3.a would instead be
> considered as 3.b, leading to infinite probe deferral of bus master devices.
>
> For those reasons we have concluded that IOMMU probe deferral needs to be
> implemented with a combination of several mechanisms. The following steps
> should happen at bus master device probe time.
>
> 1. The IOMMU device referenced by the firmware with the bus master device is
> looked up. On DT-based systems, this will be the IOMMU DT node referenced by
> the iommus property. If no IOMMU device is associated, dma_map_ops will be set
> to linear mapping or SWIOTLB and device probe will continue.
>
> 2. An IOMMU device is referenced for the bus master device.
>
> The corresponding IOMMU instance is looked up. This requires a new IOMMU
> registration system. IOMMU drivers will create IOMMU instances at probe time
> and register them with the IOMMU core.
>
> If an IOMMU instance is found for the referenced IOMMU device, the IOMMU
> instance's of_xlate function will be called to setup the IOMMU.
>
> If the of_xlate call succeeds dma_map_ops will be set to IOMMU ops and device
> probe will continue. If the call fails we can either fail the bus master
> device probe, or fall back to non-IOMMU dma_map_ops (to be discussed).
>
> 3. The IOMMU device referenced for the bus master device isn't present, due to
> the IOMMU device probe not having been performed yet, having been deferred, or
> having failed.
>
> The IOMMU driver associated with the IOMMU device is looked up. This was
> initially thought to require an early registration mechanism for IOMMU drivers
> (using an OF_DECLARE mechanism for DT-based systems for instance), but on
> second thought it might be possible to implement this based on normal driver
> registration (to be researched).
>
> If an IOMMU driver is found for the referenced IOMMU device, a callback
> function of the IOMMU driver is called to check whether an IOMMU instance is
> expected to be registered later (most IOMMU drivers will just return true, so
> we could skip this callback function until an IOMMU driver requires it). If an
> IOMMU instance is expected to be registered later the bus master device probe
> is deferred. Otherwise dma_map_ops will be set to linear mapping/SWIOTLB and
> device probe will continue.
>
>
> The initial DMA mask and the DMA offset can still be configured at device
> instantiation time if desired.

I'm sorry for not participating in the discussions, I was terribly busy 
with our
internal stuff. The approach you have described looks fine although I 
would like
also to know a bit more about the roadmap of development. The IOMMU 
integration
is being discussed for over 2 years and right now we are STILL discussing.

Do you plan to post any patches implementing this approach? I would 
really like
to merge something simple, maybe not fully optimized and then resolve 
all the
corner cases and possible integration details.

>
>> - Currently tested where we knew the driver was going to be deferring.
>> Probably need some logic for calling of_dma_configure again.
>>
>> This is based on Robin Murphy's work for dma mapping[4] and a few
>> patches from Murali Kaicheri[5] for of_dma_configure.
>>
>>
>> [1]
>> http://lists.linuxfoundation.org/pipermail/iommu/2015-January/011764.html
>> [2]
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-August/279036.ht
>> ml [3]
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/311579.
>> html [4]
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/315459.h
>> tml [5]
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/319390.h
>> tml
>>
>> Laura Abbott (3):
>>    dma-mapping: Make arch_setup_dma_ops return an error code
>>    of: Return error codes from of_dma_configure
>>    iommu/arm-smmu: Support deferred probing
>>
>> Mitchel Humpherys (1):
>>    iommu/arm-smmu: add support for specifying clocks
>>
>>   arch/arm/include/asm/dma-mapping.h   |   2 +-
>>   arch/arm/mm/dma-mapping.c            |   4 +-
>>   arch/arm64/include/asm/dma-mapping.h |   2 +-
>>   arch/arm64/mm/dma-mapping.c          |  16 +--
>>   drivers/iommu/arm-smmu.c             | 186 ++++++++++++++++++++++++++++++--
>>   drivers/iommu/iommu.c                |  49 ++++++++-
>>   drivers/iommu/of_iommu.c             |  14 ++-
>>   drivers/of/device.c                  |   9 +-
>>   include/linux/dma-mapping.h          |   7 +-
>>   include/linux/iommu.h                |   2 +
>>   include/linux/of_device.h            |   4 +-
>>   11 files changed, 268 insertions(+), 27 deletions(-)

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
