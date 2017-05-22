From: Oza Oza via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: [PATCH v6 1/3] of/pci/dma: fix DMA configuration for PCI masters
Date: Mon, 22 May 2017 22:12:43 +0530
Message-ID: <CAMSpPPeF6c5exM5cs2Gr85gWNpMmq2aG33oh81H00Y1n=+XdhA@mail.gmail.com>
References: <1494912127-12890-1-git-send-email-oza.oza@broadcom.com>
	<1494912127-12890-2-git-send-email-oza.oza@broadcom.com>
	<CAK8P3a3hoeCET5Z+KUJDCHgGEJUmLF49bDozEE0ra5jcbjvoXQ@mail.gmail.com>
Reply-To: Oza Oza <oza.oza-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAK8P3a3hoeCET5Z+KUJDCHgGEJUmLF49bDozEE0ra5jcbjvoXQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Oza Pawandeep <oza.pawandeep-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pci <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, bcm-kernel-feedback-list <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, May 18, 2017 at 12:43 AM, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
> On Tue, May 16, 2017 at 7:22 AM, Oza Pawandeep <oza.oza-dY08KVG/lbpWk0Htik3J/w@public.gmane.org> wrote:
>> current device framework and OF framework integration assumes
>> dma-ranges in a way where memory-mapped devices define their
>> dma-ranges. (child-bus-address, parent-bus-address, length).
>>
>> of_dma_configure is specifically written to take care of memory
>> mapped devices. but no implementation exists for pci to take
>> care of pcie based memory ranges.
>
> Hi Oza,
>
> I'm trying to make sense of this, but am still rather puzzled. I have
> no idea what the distinction between memory-mapped devices and
> pcie based devices is in your description, as PCIe is usually memory
> mapped, and Linux doesn't actually support other kinds of PCIe
> devices on most architectures.
>
>> for e.g. iproc based SOCs and other SOCs(suc as rcar) have PCI
>> world dma-ranges.
>> dma-ranges = <0x43000000 0x00 0x00 0x00 0x00 0x80 0x00>;
>>
>> this patch serves following:
>>
>> 1) exposes interface to the pci host driver for their
>> inbound memory ranges
>>
>> 2) provide an interface to callers such as of_dma_get_ranges.
>> so then the returned size get best possible (largest) dma_mask.
>> because PCI RC drivers do not call APIs such as
>> dma_set_coherent_mask() and hence rather it shows its addressing
>> capabilities based on dma-ranges.
>>
>> for e.g.
>> dma-ranges = <0x43000000 0x00 0x00 0x00 0x00 0x80 0x00>;
>> we should get dev->coherent_dma_mask=0x7fffffffff.
>
> do you mean the coherent_dma_mask of the PCI host bridge
> or an attached device here?
>
> If you require PCI devices to come up with an initial
> coherent_dma_mask other than 0xffffffffff, there are other
> problems involved. In particular, you will need to use
> swiotlb, which is not supported on arm32 at the moment,
> and the dma_set_mask()/dma_set_coherent_mask()
> functions need to be modified.
>
>> +       while (1) {
>> +               dma_ranges = of_get_property(node, "dma-ranges", &rlen);
>> +
>> +               /* Ignore empty ranges, they imply no translation required. */
>> +               if (dma_ranges && rlen > 0)
>> +                       break;
>> +
>> +               /* no dma-ranges, they imply no translation required. */
>> +               if (!dma_ranges)
>> +                       break;
>
> A missing parent dma-ranges property here should really indicate that there
> is no valid translation. If we have existing cases where this happens
> in DT files, we may treat it as allowing only 32-bit DMA (as we already
> do for having no dma-ranges at all), but treating it the same way
> as an empty dma-ranges property sounds wrong.
>
>      Arnd


Hi Arnd and Bjorn,

Can you please have a look at PATCH v7 ?
It addresses problem2 alone.

Regards,
Oza
