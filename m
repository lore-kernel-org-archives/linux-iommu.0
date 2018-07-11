From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH 0/4] Stop losing firmware-set DMA masks
Date: Wed, 11 Jul 2018 17:03:33 +0100
Message-ID: <9a54d956-927e-68f7-5c3b-af7cd0616dc2@arm.com>
References: <cover.1531239284.git.robin.murphy@arm.com>
	<CABGGisxVqLMu3TUpbJGWnUFgzUor-8tdyV8KJeU0YT7y=BHrAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CABGGisxVqLMu3TUpbJGWnUFgzUor-8tdyV8KJeU0YT7y=BHrAQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Rob Herring <rob.herring-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 11/07/18 15:40, Rob Herring wrote:
> On Tue, Jul 10, 2018 at 12:43 PM Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
>>
>> Whilst the common firmware code invoked by dma_configure() initialises
>> devices' DMA masks according to limitations described by the respective
>> properties ("dma-ranges" for OF and _DMA/IORT for ACPI), the nature of
>> the dma_set_mask() API leads to that information getting lost when
>> well-behaved drivers probe and set a 64-bit mask, since in general
>> there's no way to tell the difference between a firmware-described mask
>> (which should be respected) and whatever default may have come from the
>> bus code (which should be replaced outright). This can break DMA on
>> systems with certain IOMMU topologies (e.g. [1]) where the IOMMU driver
>> only knows its maximum supported address size, not how many of those
>> address bits might actually be wired up between any of its input
>> interfaces and the associated DMA master devices. Similarly, some PCIe
>> root complexes only have a 32-bit native interface on their host bridge,
>> which leads to the same DMA-address-truncation problem in systems with a
>> larger physical memory map and RAM above 4GB (e.g. [2]).
>>
>> These patches attempt to deal with this in the simplest way possible by
>> generalising the specific quirk for 32-bit bridges into an arbitrary
>> mask which can then also be plumbed into the firmware code. In the
>> interest of being minimally invasive, I've only included a point fix
>> for the IOMMU issue as seen on arm64 - there may be further tweaks
>> needed in DMA ops to catch all possible incarnations of this problem,
>> but this initial RFC is mostly about the impact beyond the dma-mapping
>> subsystem itself.
> 
> Couldn't you set and use the device's parent's dma_mask instead. At
> least for DT, we should always have a parent device representing the
> bus. That would avoid further bloating of struct device.

But then if the parent device did have a non-trivial driver which calls 
dma_set_mask(), we'd be back at square 1 :/

More realistically, I don't think that's viable for ACPI, at least with 
IORT, since the memory address size limit belongs to the endpoint 
itself, thus two devices with the same nominal parent in the Linux 
device model could still have different limits (where in DT you'd have 
to have to insert intermediate simple-bus nodes to model the same 
topology with dma-ranges). Plus either way it seems somewhat fragile for 
PCI where the host bridge may be some distance up the hierarchy.

Robin.
