From: Oza Oza via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: [PATCH v6 1/3] of/pci/dma: fix DMA configuration for PCI masters
Date: Fri, 19 May 2017 07:07:21 +0530
Message-ID: <CAMSpPPeOadKogPNra7OxCTe59tfFV5JYd8w+GYkSpz91tRv6rw@mail.gmail.com>
References: <1494912127-12890-1-git-send-email-oza.oza@broadcom.com>
	<1494912127-12890-2-git-send-email-oza.oza@broadcom.com>
	<20170517171016.GE31462@bhelgaas-glaptop.roam.corp.google.com>
Reply-To: Oza Oza <oza.oza-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170517171016.GE31462-1RhO1Y9PlrlHTL0Zs8A6p5iNqAH0jzoTYJqu5kTmcBRl57MIdRCFDg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Oza Pawandeep <oza.pawandeep-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, BCM Kernel Feedback <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, May 17, 2017 at 10:40 PM, Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Tue, May 16, 2017 at 10:52:05AM +0530, Oza Pawandeep wrote:
>> current device framework and OF framework integration assumes
>
> s/current/The current/
>
>> dma-ranges in a way where memory-mapped devices define their
>> dma-ranges. (child-bus-address, parent-bus-address, length).
>>
>> of_dma_configure is specifically written to take care of memory
>> mapped devices. but no implementation exists for pci to take
>> care of pcie based memory ranges.
>
> s/pci/PCI/      (also other occurrences below)
> s/pcie/PCIe/
>
> I don't see how PCIe is relevant here.  The bridge might support PCIe,
> but I don't think anything here is actually specific to PCIe.  If
> that's the case, I think it's confusing to mention PCIe.

It attempts to fix of_dma_get_range for PCI master,
because it currently it is returning *size as 0 (to the caller of_dma_configure)
resulting into largest dma_mask which would be 64-bit mask on armv8.
which usually has worked so far, because any other SOC's PCI RC, do not
have the limitations as of Broadcom iproc based PCI RC.
our RC will drop 64bit IOVAs, because it is not capable of addressing
entire 64bit range.

infact there are 2 real problems, please allow me to explain.
please refer to my next mail in reply to Arnd Bergmann,

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
>> for e.g.
>> dma-ranges = <0x43000000 0x00 0x00 0x00 0x00 0x80 0x00>;
>> we should get dev->coherent_dma_mask=0x7fffffffff.
>>
>> 3) this patch handles multiple inbound windows and dma-ranges.
>> it is left to the caller, how it wants to use them.
>> the new function returns the resources in a standard and unform way
>>
>> 4) this way the callers of for e.g. of_dma_get_ranges
>> does not need to change.
>
> Please start sentences with a capital letter.

will take care of your comments.
Thanks,
Oza.
