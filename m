From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH 1/2] dma-mapping: Clean up dma_set_*mask() hooks
Date: Fri, 6 Jul 2018 15:20:34 +0100
Message-ID: <33175bb1-d198-a9fd-ff37-e8c4132f47f8@arm.com>
References: <55ac9550c311f056dcfeed9b2c8265375f17b155.1530726467.git.robin.murphy@arm.com>
	<20180705193738.GB28905@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180705193738.GB28905-jcswGhMUV9g@public.gmane.org>
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
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 05/07/18 20:37, Christoph Hellwig wrote:
> On Wed, Jul 04, 2018 at 06:50:11PM +0100, Robin Murphy wrote:
>> Arch-specific implementions for dma_set_{coherent_,}mask() currently
>> rely on an inconsistent mix of arch-defined Kconfig symbols and macro
>> overrides. Now that we have a nice centralised home for DMA API gubbins,
>> let's consolidate these loose ends under consistent config options.
>>
>> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>> ---
>>
>> Here's hoping the buildbot comes by to point out what I've inevitably
>> missed, although I did check a cursory cross-compile of ppc64_defconfig
>> to iron out the obvious howlers.
> 
> The patch looks sensible to me, although I was hoping to get rid of these
> hooks in this or the next merge window as they are a horrible bad idea.
> 
>> The motivation here is that I'm looking at adding set_mask overrides
>> for arm64, and having discovered a bit of a mess it seemed prudent to
>> clean up before ingraining it any more.
> 
> What are you trying to do?  I really don't want to see more users of
> the hooks as they are are a horribly bad idea.

I really need to fix the ongoing problem we have where, due to funky 
integrations, devices suffer some downstream addressing limit (described 
by DT dma-ranges or ACPI IORT/_DMA) which we carefully set up in 
dma_configure(), but then just gets lost when the driver probes and 
innocently calls dma_set_mask() with something wider. I think it's 
effectively the generalised case of the VIA 32-bit quirk, if I 
understand that one correctly.

The approach that seemed to me to be safest is largely based on the one 
proposed in a thread from ages ago[1]; namely to make dma_configure() 
better at distinguishing firmware-specified masks from bus defaults, 
capture the firmware mask in dev->archdata during arch_setup_dma_ops(), 
then use the custom set_mask routines to ensure any subsequent updates 
never exceed that. It doesn't seem possible to make this work robustly 
without storing *some* additional per-device data, and for that archdata 
is a lesser evil than struct device itself. Plus even though it's not 
actually an arch-specific issue it feels like there's such a risk of 
breaking other platforms that I'm reticent to even try handling it 
entirely in generic code.

Robin.

[1] 
https://www.mail-archive.com/linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg1306507.html
