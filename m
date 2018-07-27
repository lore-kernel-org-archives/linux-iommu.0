From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 7/7] OF: Don't set default coherent DMA mask
Date: Fri, 27 Jul 2018 20:29:18 +0100
Message-ID: <5b64c3c1-f18d-4db1-e764-d0cbdc8fa326@arm.com>
References: <cover.1532382222.git.robin.murphy@arm.com>
	<66c08e4df2032fde82a2f97544f41fd3a2f24a94.1532382222.git.robin.murphy@arm.com>
	<4ed75bc9-1694-2bcb-2ea9-3f2a04f33f54@ti.com>
	<92d6b010-b5c0-fc59-0668-5b455e26c912@ti.com>
	<c7a9c7ae-1f4a-af9d-df78-1f48bb5c28a5@arm.com>
	<20180727181302.GC17271@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180727181302.GC17271-l+eeeJia6m9URfEZ8mYm6t73F7V6hmMc@public.gmane.org>
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
To: Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, sudeep.holla-5wv7dgnIgG8@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 2018-07-27 7:13 PM, Russell King - ARM Linux wrote:
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

No, I'm just failing to make it clearly enough. Sorry about that.

> When OF creates platform devices, they are created without any DMA masks
> what so ever.  It is only during device probe that dma_configure() gets
> called, which then calls of_dma_configure(), where the DMA mask for any
> DT declared device is setup.

Indeed, because the DMA mask initialisation which was originally part of 
OF platform device creation got factored out into of_dma_configure(), 
then of_dma_configure() got repurposed into a 
non-platform-device-specific helper, then DMA configuration got 
generalised more and moved from device creation to probe time, and it 
now transpires that what looked like an unnecessary vestigial leftover 
was in fact some OF-platform-specific code all along. Which, having now 
made that realisitaion, I've put back where it originally was and 
conceptually should be.

> What this means is that your change has broken all existing DT devices
> that are trying to use DMA, because they now end up with a zero coherent
> DMA mask and/or streaming DMA mask.

All existing DT devices that are trying to use DMA *without first 
calling dma_set_mask() etc. as the API expects* - I could point you at 
lines 166-171 of DMA-API-HOWTO.txt, but given that the last person to 
touch half this stuff was you, that feels almost impolite. It appears 
all the drivers on the machines I boot-tested are well-behaved and do do 
that. In a few hours we'll have a useful datapoint from the kernelci.org 
boot logs about how many aren't and don't. Happy accidents 'n'all...

> Your original idea behind the patch may be a sound one, but since the
> implementation has caused a regression, the implementation is obviously
> broken, and that needs fixing or reworking in some way.

Already done: 
http://git.infradead.org/users/hch/dma-mapping.git/commitdiff/a5516219b10218a87abb3352c82248ce3088e94a

Robin.
