From: Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: IOAT DMA w/IOMMU
Date: Thu, 9 Aug 2018 13:43:31 -0500
Message-ID: <20180809184331.GB113140@bhelgaas-glaptop.roam.corp.google.com>
References: <CAOQPn8soxubJxb=vp7kz+AM6LbPH5y+_Nx0Vzv7rjV_nMMqEmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOQPn8soxubJxb=vp7kz+AM6LbPH5y+_Nx0Vzv7rjV_nMMqEmA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Eric Pilmore <epilmore-Op3I1peydIbQT0dZR+AlfA@public.gmane.org>
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Logan Gunthorpe <logang-OTvnGxWRz7hWk0Htik3J/w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

[+cc David, Logan, Alex, iommu list]

On Thu, Aug 09, 2018 at 11:14:13AM -0700, Eric Pilmore wrote:
> Didn't get any response on the IRC channel so trying here.
> 
> Was wondering if anybody here has used IOAT DMA engines with an
> IOMMU turned on (Xeon based system)? My specific question is really
> whether it is possible to DMA (w/IOAT) to a PCI BAR address as the
> destination without having to map that address to the IOVA space of
> the DMA engine first (assuming the IOMMU is on)?

So is this a peer-to-peer DMA scenario?  You mention DMA, which would
be a transaction initiated by a PCI device, to a PCI BAR address, so
it doesn't sound like system memory is involved.

I copied some folks who know a lot more about this than I do.

> I am encountering issues where I see PTE Errors reported from DMAR
> in this scenario, but I do not if I use a different DMA engine
> that's sitting downstream off the PCI tree. I'm wondering if the
> IOAT DMA failure is some artifact of these engines sitting behind
> the Host Bridge.
> 
> Thanks in advance!
> Eric
