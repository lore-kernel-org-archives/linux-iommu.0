From: Yoder Stuart-B08248 <B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RFC:  vfio / iommu driver for hardware with no iommu
Date: Tue, 23 Apr 2013 16:13:00 +0000
Message-ID: <9F6FE96B71CF29479FF1CDC8046E15035BE0A3@039-SN1MPN1-002.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Joerg/Alex,

We have embedded systems where we use QEMU/KVM and have
the requirement to do device assignment, but have no
iommu.  So we would like to get vfio-pci working on
systems like this.

We're aware of the obvious limitations-- no protection,
DMA'able memory must be physically contiguous and will
have no iova->phy translation.  But there are use cases
where all OSes involved are trusted and customers can
live with those limitations.   Virtualization is used
here not to sandbox untrusted code, but to consolidate
multiple OSes.

We would like to get your feedback on the rough idea.  There
are two parts-- iommu driver and vfio-pci.

1.  iommu driver

First, we still need device groups created because vfio
is based on that, so we envision a 'dummy' iommu
driver that implements only  the add/remove device
ops.  Something like:

    static struct iommu_ops fsl_none_ops = {
            .add_device     = fsl_none_add_device,
            .remove_device  = fsl_none_remove_device,
    };
    
    int fsl_iommu_none_init()
    {
            int ret = 0;
    
            ret = iommu_init_mempool();
            if (ret)
                    return ret;
    
            bus_set_iommu(&platform_bus_type, &fsl_none_ops);
            bus_set_iommu(&pci_bus_type, &fsl_none_ops);
    
            return ret;
    }

2.  vfio-pci

For vfio-pci, we would ideally like to keep user space mostly
unchanged.  User space will have to follow the semantics
of mapping only physically contiguous chunks...and iova
will equal phys.

So, we propose to implement a new vfio iommu type,
called VFIO_TYPE_NONE_IOMMU.  This implements
any needed vfio interfaces, but there are no calls
to the iommu layer...e.g. map_dma() is a noop.

Would like your feedback.

Thanks,
Stuart Yoder
