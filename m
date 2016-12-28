From: "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: possible dmar_init_reserved_ranges() error
Date: Tue, 27 Dec 2016 19:21:39 -0800
Message-ID: <20161228032139.GA254916@otc-nc-03>
References: <20161219212044.GA21774@bhelgaas-glaptop.roam.corp.google.com>
	<20161227234417.GA24366@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161227234417.GA24366-1RhO1Y9PlrlHTL0Zs8A6p5iNqAH0jzoTYJqu5kTmcBRl57MIdRCFDg@public.gmane.org>
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
Cc: g@bhelgaas-glaptop.roam.corp.google.com, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rwright-ZPxbGqLxI0U@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Bjorn,

On Tue, Dec 27, 2016 at 05:44:17PM -0600, Bjorn Helgaas wrote:
> 
>   dmar_init_reserved_ranges()
>   {
>     ...
>     for_each_pci_dev(pdev) {
>       for (i = 0; i < PCI_NUM_RESOURCES; i++) {
>         r = &pdev->resource[i];
>         reserve_iova(r)
> 
> But I assume it's possible to have more than one IOTLB in a system,

You meant IOMMU?  

> so you could have some PCI devices under one IOTLB and others under a
> different IOTLB.  So it seems like we should reserve only the IOVA
> space used by the devices under *this* IOTLB.

Yes, it seems we are aggressive reserving all pci devices bars's when 
potentially you need to only reserve ranges for the IOMMU under which 
this pci device exist. We also need to make sure devices under the
INCLUDE_ALL is handled correctly. 
> 
> Also, we may hot-add a device under the IOTLB, and I don't see where
> we reserve the IOVA space it uses.
> 
> I think the best thing to do would be to reserve the host bridge
> apertures related to each IOTLB.  That would resolve both questions.
> It looks like iova_reserve_pci_windows() does this in the
> iommu_dma_init_domain() path.

This sounds reasonable, if we can reserve from the host bridge apertures 
it should take care of hot-plug cases as well, and should simply how the
reservation is made.

Cheers,
Ashok
