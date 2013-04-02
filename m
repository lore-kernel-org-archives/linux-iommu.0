From: Pat Erley <pat-lkml-Jx9fsTfDDR3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH v4] Quirk for buggy dma source tags with Intel IOMMU.
Date: Tue, 02 Apr 2013 03:36:53 -0400
Message-ID: <515A8A95.1080806@erley.org>
References: <1362710133-25168-1-git-send-email-acooks@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1362710133-25168-1-git-send-email-acooks-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Andrew Cooks <acooks-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: open-PxS6QbICe4xqbv67lBd7PQ@public.gmane.org, PCI SUBSYSTEM <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:INTEL IOMMU (VT-d)" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, list-PxS6QbICe4xqbv67lBd7PQ@public.gmane.org, jpiszcz-BP4nVm5VUdNhbmWW9KSYcQ@public.gmane.org, gaudenz-Pp/UeI/YXckUgOneFgkt3A@public.gmane.org, "Bjorn Helgaas (supporter:PCI SUBSYSTEM)" <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "David Woodhouse (supporter:INTEL IOMMU (VT-d))" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 03/07/2013 09:35 PM, Andrew Cooks wrote:
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> +/* Table of multiple (ghost) source functions. This is similar to the
> + * translated sources above, but with the following differences:
> + * 1. the device may use multiple functions as DMA sources,
> + * 2. these functions cannot be assumed to be actual devices, they're simply
> + * incorrect DMA tags.
> + * 3. the specific ghost function for a request can not always be predicted.
> + * For example, the actual device could be xx:yy.1 and it could use
> + * both 0 and 1 for different requests, with no obvious way to tell when
> + * DMA will be tagged as comming from xx.yy.0 and and when it will be tagged
> + * as comming from xx.yy.1.
> + * The bitmap contains all of the functions used in DMA tags, including the
> + * actual device.
> + * See  https://bugzilla.redhat.com/show_bug.cgi?id=757166,
> + * https://bugzilla.kernel.org/show_bug.cgi?id=42679
> + * https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1089768
> + */
> +static const struct pci_dev_dma_multi_func_sources {
> +	u16 vendor;
> +	u16 device;
> +	u8 func_map;	/* bit map. lsb is fn 0. */
> +} pci_dev_dma_multi_func_sources[] = {
> +	{ PCI_VENDOR_ID_MARVELL_2, 0x9123, (1<<0)|(1<<1)},
> +	{ PCI_VENDOR_ID_MARVELL_2, 0x9125, (1<<0)|(1<<1)},
> +	{ PCI_VENDOR_ID_MARVELL_2, 0x9128, (1<<0)|(1<<1)},
> +	{ PCI_VENDOR_ID_MARVELL_2, 0x9130, (1<<0)|(1<<1)},
> +	{ PCI_VENDOR_ID_MARVELL_2, 0x9143, (1<<0)|(1<<1)},
> +	{ PCI_VENDOR_ID_MARVELL_2, 0x9172, (1<<0)|(1<<1)},
> +	{ 0 }
> +};

Adding another buggy device.  I have a Ricoh multifunction device:

17:00.0 SD Host controller: Ricoh Co Ltd MMC/SD Host Controller (rev 01)
17:00.3 FireWire (IEEE 1394): Ricoh Co Ltd R5C832 PCIe IEEE 1394
         Controller (rev 01)

17:00.0 0805: 1180:e822 (rev 01)
17:00.3 0c00: 1180:e832 (rev 01)

that adding entries for also fixed booting.  I don't have any SD cards 
or firewire devices handy to test that they work, but the system now 
boots, which was not the case without your patch and IOMMU/DMAR enabled. 
  Here's a previous patch used for similar hardware that may also be 
fixed by this:

http://lists.fedoraproject.org/pipermail/scm-commits/2010-October/510785.html

and another thread/bug report this may solve:

https://bugzilla.redhat.com/show_bug.cgi?id=605888

Feel free to include me in any future iterations of this patch you'd 
like tested.

Tested-By: Pat Erley <pat-lkml-Jx9fsTfDDR3YtjvyW6yDsg@public.gmane.org>
