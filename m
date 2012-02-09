From: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 1/3] Device isolation group infrastructure
	(v3)
Date: Thu, 9 Feb 2012 12:40:55 +1100
Message-ID: <20120209014055.GB6992@truffala.fritz.box>
References: <1328071614-8320-1-git-send-email-david@gibson.dropbear.id.au>
	<1328071614-8320-2-git-send-email-david@gibson.dropbear.id.au>
	<20120208152748.GD22598@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
Content-Disposition: inline
In-Reply-To: <20120208152748.GD22598@amd.com>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
To: Joerg Roedel <joerg.roedel@amd.com>
Cc: kvm@vger.kernel.org, aik@ozlabs.ru, alex.williamson@redhat.com, qemu-devel@nongnu.org, iommu@lists.linux-foundation.org, dwmw2@infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Feb 08, 2012 at 04:27:48PM +0100, Joerg Roedel wrote:
> On Wed, Feb 01, 2012 at 03:46:52PM +1100, David Gibson wrote:
> > In order to safely drive a device with a userspace driver, or to pass
> > it through to a guest system, we must first make sure that the device
> > is isolated in such a way that it cannot interfere with other devices
> > on the system.  This isolation is only available on some systems and
> > will generally require an iommu, and might require other support in
> > bridges or other system hardware.
> > 
> > Often, it's not possible to isolate every device from every other
> > device in the system.  For example, certain PCI/PCIe bridge
> > configurations mean that an iommu cannot reliably distinguish which
> > device behind the bridge initiated a DMA transaction.  Similarly some
> > buggy PCI multifunction devices initiate all DMAs as function 0, so
> > the functions cannot be isolated from each other, even if the IOMMU
> > normally allows this.
> > 
> > Therefore, the user, and code to allow userspace drivers or guest
> > passthrough, needs a way to determine which devices can be isolated
> > from which others.  This patch adds infrastructure to handle this by
> > introducing the concept of a "device isolation group" - a group of
> > devices which can, as a unit, be safely isolated from the rest of the
> > system and therefore can be, as a unit, safely assigned to an
> > unprivileged used or guest.  That is, the groups represent the minimum
> > granularity with which devices may be assigned to untrusted
> > components.
> > 
> > This code manages groups, but does not create them or allow use of
> > grouped devices by a guest.  Creating groups would be done by iommu or
> > bridge drivers, using the interface this patch provides.  It's
> > expected that the groups will be used in future by the in-kernel iommu
> > interface, and would also be used by VFIO or other subsystems to allow
> > safe passthrough of devices to userspace or guests.
> > 
> > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  drivers/base/Kconfig             |    3 +
> >  drivers/base/Makefile            |    1 +
> >  drivers/base/base.h              |    3 +
> >  drivers/base/core.c              |    6 ++
> >  drivers/base/device_isolation.c  |  184 ++++++++++++++++++++++++++++++++++++++
> >  drivers/base/init.c              |    2 +
> >  include/linux/device.h           |    5 +
> >  include/linux/device_isolation.h |  100 +++++++++++++++++++++
> 
> Again, device grouping is done by the IOMMU drivers, so this all belongs
> into the generic iommu-code rather than the driver core.
> 
> I think it makes sense to introduce a device->iommu pointer which
> depends on CONFIG_IOMMU_API and put the group information into it.
> This also has the benefit that we can consolidate all the
> device->arch.iommu pointers into device->iommu as well.

Well, not quite.  In the two example setups in the subsequent patches
the grouping is done by the bridge driver, which in these cases is not
IOMMU_API aware.  They probably should become so, but that's another
project - and relies on the IOMMU_API becoming group aware.

Note that although iommus are the main source of group constraints,
they're not necessarily the only one. Bridge error isolation semantics
may also play a part, for one.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
