From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] iommu/s390: Add support for iommu_device handling
Date: Tue, 27 Jun 2017 17:28:06 +0200
Message-ID: <20170627152806.GZ30388@8bytes.org>
References: <1497532312-30470-1-git-send-email-joro@8bytes.org>
	<1497532312-30470-3-git-send-email-joro@8bytes.org>
	<20170619170219.0a8626b6@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170619170219.0a8626b6@thinkpad>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Gerald Schaefer <gerald.schaefer-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org, Sebastian Ott <sebott-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Jun 19, 2017 at 05:02:19PM +0200, Gerald Schaefer wrote:
> On Thu, 15 Jun 2017 15:11:52 +0200
> Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:
> > +	rc = zpci_init_iommu(zdev);
> > +	if (rc)
> > +		goto out_free;
> > +
> 
> After this point, there are two options for failure (zpci_enable_device +
> zpci_scan_bus), but missing error handling with an appropriate call to
> zpci_destroy_iommu().

Right, I'll fix that in the next version.

> I must admit that I do not understand what these sysfs attributes are
> used for, and by whom and when. Is it really necessary/correct to register
> them (including the s390_iommu_ops) _before_ the zpci_dev is registered
> to the bus (zpci_scan_bus -> pci_scan_root_bus/pci_bus_add_devices)?
> 
> What is the expected life cycle for the attributes, and are they already
> needed when a device is still under DMA API access, or even before it is
> added to the PCI bus?

The sysfs attributes are used by user-space for topology detection. A
user-space program using VFIO needs to know which PCI-devices it needs
to assign to the VFIO driver in order to gain access.

On s390 this probably doesn't matter much, as the real PCI topology is
not exposed, but it matters on other architectures. The purpose of this
patch is not so much the sysfs attributes. Its a step to convert all
IOMMU drivers to use the iommu_device_register() interface. Goal is that
the iommu core code knows about individual hardware iommus and the
devices behind it.

When this is implemented in all iommu drivers, we can start moving more
code out of the drivers into the iommu core. This also probably doesn't
matter much for s390, but all iommu drivers need to use this interface
before we can move on. The sysfs-stuff is just a by-product of that.

So to move on with that, it would be good to get an Acked-by on this
patch from you guys once you think I fixed everything :)


Regards,

	Joerg
