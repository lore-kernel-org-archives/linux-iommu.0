From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: RFC:  vfio / iommu driver for hardware with no iommu
Date: Tue, 23 Apr 2013 10:56:29 -0600
Message-ID: <1366736189.2918.573.camel@bling.home>
References: <9F6FE96B71CF29479FF1CDC8046E15035BE0A3@039-SN1MPN1-002.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <9F6FE96B71CF29479FF1CDC8046E15035BE0A3-TcFNo7jSaXPiTqIcKZ1S2K4g8xLGJsHaLnY5E4hWTkheoWH0uzbU5w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Yoder Stuart-B08248 <B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, 2013-04-23 at 16:13 +0000, Yoder Stuart-B08248 wrote:
> Joerg/Alex,
> 
> We have embedded systems where we use QEMU/KVM and have
> the requirement to do device assignment, but have no
> iommu.  So we would like to get vfio-pci working on
> systems like this.
> 
> We're aware of the obvious limitations-- no protection,
> DMA'able memory must be physically contiguous and will
> have no iova->phy translation.  But there are use cases
> where all OSes involved are trusted and customers can
> live with those limitations.   Virtualization is used
> here not to sandbox untrusted code, but to consolidate
> multiple OSes.
> 
> We would like to get your feedback on the rough idea.  There
> are two parts-- iommu driver and vfio-pci.
> 
> 1.  iommu driver
> 
> First, we still need device groups created because vfio
> is based on that, so we envision a 'dummy' iommu
> driver that implements only  the add/remove device
> ops.  Something like:
> 
>     static struct iommu_ops fsl_none_ops = {
>             .add_device     = fsl_none_add_device,
>             .remove_device  = fsl_none_remove_device,
>     };
>     
>     int fsl_iommu_none_init()
>     {
>             int ret = 0;
>     
>             ret = iommu_init_mempool();
>             if (ret)
>                     return ret;
>     
>             bus_set_iommu(&platform_bus_type, &fsl_none_ops);
>             bus_set_iommu(&pci_bus_type, &fsl_none_ops);
>     
>             return ret;
>     }
> 
> 2.  vfio-pci
> 
> For vfio-pci, we would ideally like to keep user space mostly
> unchanged.  User space will have to follow the semantics
> of mapping only physically contiguous chunks...and iova
> will equal phys.
> 
> So, we propose to implement a new vfio iommu type,
> called VFIO_TYPE_NONE_IOMMU.  This implements
> any needed vfio interfaces, but there are no calls
> to the iommu layer...e.g. map_dma() is a noop.
> 
> Would like your feedback.

My first thought is that this really detracts from vfio and iommu groups
being a secure interface, so somehow this needs to be clearly an
insecure mode that requires an opt-in and maybe taints the kernel.  Any
notion of unprivileged use needs to be blocked and it should test
CAP_COMPROMISE_KERNEL (or whatever it's called now) at critical access
points.  We might even have interfaces exported that would allow this to
be an out-of-tree driver (worth a check).

I would guess that you would probably want to do all the iommu group
setup from the vfio fake-iommu driver.  In other words, that driver both
creates the fake groups and provides the dummy iommu backend for vfio.
That would be a nice way to compartmentalize this as a
vfio-noiommu-special.

Would map/unmap really be no-ops?  Seems like you still want to do page
pinning.  Also, you're using fsl in the example above, but would such a
driver have any platform dependency?  Thanks,

Alex
