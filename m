From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 01/13] driver core: Add iommu_group tracking to struct
	device
Date: Fri, 11 May 2012 17:58:01 -0600
Message-ID: <1336780681.12477.198.camel@bling.home>
References: <20120511222148.30496.68571.stgit@bling.home>
	<20120511225534.30496.54563.stgit@bling.home>
	<20120511233821.GA9335@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20120511233821.GA9335-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org, aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, agraf-l3A5Bk7waGM@public.gmane.org, qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org, chrisw-69jw2NvuJkxg9hUCZPvPmw@public.gmane.org, B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, avi-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, benve-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, 2012-05-11 at 16:38 -0700, Greg KH wrote:
> On Fri, May 11, 2012 at 04:55:35PM -0600, Alex Williamson wrote:
> > IOMMU groups allow IOMMU drivers to represent DMA visibility
> > and isolation of devices.  Multiple devices may be grouped
> > together for the purposes of DMA.  Placing a pointer on
> > struct device enable easy access for things like streaming
> > DMA programming and drivers like VFIO.
> > 
> > Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> 
> Can't you get this today from the iommu_ops pointer that is on the bus
> that the device is associated with?  Or can devices on a bus have
> different iommu_group pointers?

The latter, each device on a bus might be it's own group.  This is often
the case on x86 unless PCIe-to-PCI bridges obscure the device
visibility.  Thanks,

Alex
