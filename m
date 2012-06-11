From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 0/7] IOMMU: Groups support
Date: Mon, 11 Jun 2012 09:37:01 -0600
Message-ID: <1339429021.24037.8.camel@bling.home>
References: <20120530201424.31527.33142.stgit@bling.home>
	<20120606110514.GG757@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20120606110514.GG757-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>, Alexey Kardashevskiy <aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, liuj97-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, 2012-06-06 at 13:05 +0200, Joerg Roedel wrote:
> On Wed, May 30, 2012 at 02:18:29PM -0600, Alex Williamson wrote:
> > v2:
> >  - Trickle down changes from pci_get_dma_source() to better handle
> >    PCI device reference counting in IOMMU driver patches
> 
> Okay, I looked again over the code and looks good for merging to me.

Great, thanks Joerg!

>  The
> IOMMU Groups code depends on changes in the PCI code. We need to work
> out how to merge this.
> 
> Bjorn,
> 
> I need the PCI changes before I can merge the IOMMU Groups code. There
> are two ways that would work for me:
> 
> 	a) You Ack the PCI patch-set from Alex and I put it into my tree
> 	   and merge the IOMMU Group code on-top, or
> 	b) You merge the PCI related patch-set into a seperate branch
> 	   which you can merge into your next-branch and which I can
> 	   pull in to merge IOMMU Groups on-top.
> 
> Please let me know what works best for you.

I also poked Bjorn with a minor v3 spin on his series, no change to this
series.

> What I would also appreciate are a few more Acks from other IOMMU
> maintainers (David W.?) and from the Power side.

Alexey, BenH, can either of you comment on this series from the POWER
side?  I know Alexey has an implementation of VFIO/Qemu device
assignment working on POWER with this series.  David Woodhouse, any
comments?  Thanks,

Alex
