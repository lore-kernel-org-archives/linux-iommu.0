From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v2 0/7] Stop losing firmware-set DMA masks
Date: Mon, 6 Aug 2018 12:01:34 +0200
Message-ID: <CAK8P3a3ZcOeHMR_qFnsBdXED+2X8_AEMKoS5MeAQhbapbGmm9w@mail.gmail.com>
References: <cover.1532382222.git.robin.murphy@arm.com>
	<CAK8P3a3HDJ6svNN_cwvegxu20yNv8+tvc0D1A6Ooeq8agawbFg@mail.gmail.com>
	<1ccccc4b-7d4c-a3ee-23a2-f108916705e9@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1ccccc4b-7d4c-a3ee-23a2-f108916705e9-5wv7dgnIgG8@public.gmane.org>
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
Cc: gregkh <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, the arch/x86 maintainers <x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jul 31, 2018 at 1:30 PM Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
> On 29/07/18 13:32, Arnd Bergmann wrote:
> > On Tue, Jul 24, 2018 at 12:16 AM, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:

> > Thanks a lot for working on this, this has bugged me for many years,
> > and I've discussed possible solutions with lots of people over time.
> >
> > I /think/ all your patches are good, but I'm currently travelling and don't
> > have a chance to review the resulting overall implementation.
> > Could you summarize what happens in the following corner cases of
> > DT dma-ranges after your changes (with a driver not setting a mask,
> > setting a 64-bit mask and setting a 24-bit mask, respectively)?
> >
> > a) a device with no dma-ranges property anywhere in its parents
> > b) a device with with a 64-bit dma-ranges translation in its parent
> >     but none in its grandparent
> > c) a device with no dma-ranges in its parent but a 64-bit mask
> >     in its grandparent
> > d) a device with a 24-bit mask in its parent.
>
> In terms of the actual dma-ranges parsing, nothing should be changed by
> these patches, so the weirdness and inconsistency that I'm pretty sure
> exists for some of those cases will still be there for the moment - I'm
> starting on actually fixing of_dma_get_range() now.

Right, but I'm interested in the combination of of_dma_get_range()
with dma_set_mask(), which is the part that was traditionally broken
on arm64 and should be fixed now.

There are a few subtle corner cases here, in particular in which cases
the new dma_set_mask() behavior on arm64 reports success or
failure when truncating the mask to the bus_dma_mask.

> The effect after these patches is that a device with a "valid" (per the
> current of_dma_get_range() implementation) dma-ranges translation gets
> it bus_dma_mask set to cover the given range, whereas a device with no
> valid dma-ranges effectively gets a 32-bit bus_dma_mask. That's slightly
> different from the ACPI default behaviour, due to subtle spec
> differences, but I think it's in line with what you've proposed before
> for DT, and it's certainly still flexible if anyone has a different
> view. The bus_dma_mask in itself should also be low-impact, since it
> will only currently be enforced in the generic dma-direct and iommu-dma
> paths, so the likes of powerpc shouldn't see any change at all just yet.

Ok.

      Arnd
