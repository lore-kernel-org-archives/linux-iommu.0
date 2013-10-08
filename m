From: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/7] powerpc: Add interface to get msi region information
Date: Tue, 8 Oct 2013 17:25:40 -0600
Message-ID: <CAErSpo7+7SHVcOJkHkW5cjb6pN+bqYeRdPBA=MVX0RLz=-pP6Q@mail.gmail.com>
References: <1379575763-2091-1-git-send-email-Bharat.Bhushan@freescale.com>
	<1379575763-2091-2-git-send-email-Bharat.Bhushan@freescale.com>
	<1381273037.7979.298.camel@snotra.buserror.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1381273037.7979.298.camel-88ow+0ZRuxG2UiBs7uKeOtHuzzzSOjJt@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Alexander Graf <agraf-l3A5Bk7waGM@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:INTEL IOMMU (VT-d)" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Bharat Bhushan <r65777-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linuxppc-dev <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

>> -     u32 msiir_offset; /* Offset of MSIIR, relative to start of CCSR */
>> +     dma_addr_t msiir; /* MSIIR Address in CCSR */
>
> Are you sure dma_addr_t is right here, versus phys_addr_t?  It implies
> that it's the output of the DMA API, but I don't think the DMA API is
> used in the MSI driver.  Perhaps it should be, but we still want the raw
> physical address to pass on to VFIO.

I don't know what "msiir" is used for, but if it's an address you
program into a PCI device, then it's a dma_addr_t even if you didn't
get it from the DMA API.  Maybe "bus_addr_t" would have been a more
suggestive name than "dma_addr_t".  That said, I have no idea how this
relates to VFIO.

Bjorn
