From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v2] devicetree: Add generic IOMMU device tree bindings
Date: Sat, 07 Jun 2014 15:22:13 +0200
Message-ID: <4306568.dZTtF4xhhK@wuerfel>
References: <20140606224542.GA22188@mithrandir>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140606224542.GA22188@mithrandir>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Saturday 07 June 2014 00:45:45 Thierry Reding wrote:
> This is somewhat off-topic, but given the various concepts discussed in
> this thread I'm beginning to wonder how they will be implemented.

I think it's good you raised the question.

> The
> current implementation hooks the IOMMU API into the DMA mapping API, and
> the way this is done is by setting a single IOMMU (or rather a set of
> IOMMU operations) globally per bus type.

I hadn't realized that we have a per-bus iommu_ops pointer. I agree
this will become a limitation as soon as we have a soc with two different
IOMMUs that have platform devices attached, and it has to be moved into
the device or a structure related to that.

If that turns out controversial, we can probably have a set of pseudo
iommu ops that just call into dev->archdata->iommu_ops->function()
for ARM.

> There are two issues that I can see with that: one is that we can't
> support multiple IOMMUs in the system at all, and the other is that
> there is no context associated with the IOMMU ops, and therefore there
> is no way to differentiate between two instances of the same IOMMU. A
> few drivers use global variables to keep track of context information
> but that won't work with multiple instances, unless they keep a global
> list of all instances and then require explicit lookup in each of the
> IOMMU operations. That sounds more like a workaround rather than a
> proper solution to me.

Supporting multiple iommus that share one iommu driver should work
without such hacks, as you can put the per-device information into
dev->device_dma_parameters (this works only for very simple IOMMUs)
or dev->archdata->iommu (we may want to generalize that, I think
someone just posted patches for it).

> Discussion in this thread indicates that both of the above will be
> required at some point. Have I completely missed something or will we
> have to rework (parts of) the IOMMU API to make this work?
> 
> One other thing that I have some difficulty understanding is how we can
> support things like process isolation using the current IOMMU API. Since
> a device will be statically assigned to one IOMMU domain at probe time
> there is no way we can change the address space upon a context switch.

We have just introduced a way to parse dma-ranges in of_dma_configure().

The only way I see this done for platform devices is to do the IOMMU
configuration in the same place: if an iommus property is found there,
we call out to the iommu driver that matches the respective iommu device
and let it configure the master device.

The device already has multiple properties related to iommus:
'struct device_dma_parameters', 'archdata', 'iommu_group', and
pdev_archdata for platform devices. This should be enough to set up
the default iommu dma_map_ops so we can have non-isolated DMA using
dma_map_* and dma_alloc_coherent.

I haven't given much thought to devices that want to use the IOMMU
API directly so they can have multiple domains rather than rely on
the dma-mapping abstraction.

	Arnd
