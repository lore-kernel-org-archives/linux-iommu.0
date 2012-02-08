From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/3] Device isolation group infrastructure (v3)
Date: Wed, 8 Feb 2012 16:27:48 +0100
Message-ID: <20120208152748.GD22598@amd.com>
References: <1328071614-8320-1-git-send-email-david@gibson.dropbear.id.au>
	<1328071614-8320-2-git-send-email-david@gibson.dropbear.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1328071614-8320-2-git-send-email-david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: David Gibson <david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org>
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Feb 01, 2012 at 03:46:52PM +1100, David Gibson wrote:
> In order to safely drive a device with a userspace driver, or to pass
> it through to a guest system, we must first make sure that the device
> is isolated in such a way that it cannot interfere with other devices
> on the system.  This isolation is only available on some systems and
> will generally require an iommu, and might require other support in
> bridges or other system hardware.
> 
> Often, it's not possible to isolate every device from every other
> device in the system.  For example, certain PCI/PCIe bridge
> configurations mean that an iommu cannot reliably distinguish which
> device behind the bridge initiated a DMA transaction.  Similarly some
> buggy PCI multifunction devices initiate all DMAs as function 0, so
> the functions cannot be isolated from each other, even if the IOMMU
> normally allows this.
> 
> Therefore, the user, and code to allow userspace drivers or guest
> passthrough, needs a way to determine which devices can be isolated
> from which others.  This patch adds infrastructure to handle this by
> introducing the concept of a "device isolation group" - a group of
> devices which can, as a unit, be safely isolated from the rest of the
> system and therefore can be, as a unit, safely assigned to an
> unprivileged used or guest.  That is, the groups represent the minimum
> granularity with which devices may be assigned to untrusted
> components.
> 
> This code manages groups, but does not create them or allow use of
> grouped devices by a guest.  Creating groups would be done by iommu or
> bridge drivers, using the interface this patch provides.  It's
> expected that the groups will be used in future by the in-kernel iommu
> interface, and would also be used by VFIO or other subsystems to allow
> safe passthrough of devices to userspace or guests.
> 
> Signed-off-by: Alexey Kardashevskiy <aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org>
> Signed-off-by: David Gibson <david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org>
> ---
>  drivers/base/Kconfig             |    3 +
>  drivers/base/Makefile            |    1 +
>  drivers/base/base.h              |    3 +
>  drivers/base/core.c              |    6 ++
>  drivers/base/device_isolation.c  |  184 ++++++++++++++++++++++++++++++++++++++
>  drivers/base/init.c              |    2 +
>  include/linux/device.h           |    5 +
>  include/linux/device_isolation.h |  100 +++++++++++++++++++++

Again, device grouping is done by the IOMMU drivers, so this all belongs
into the generic iommu-code rather than the driver core.

I think it makes sense to introduce a device->iommu pointer which
depends on CONFIG_IOMMU_API and put the group information into it.
This also has the benefit that we can consolidate all the
device->arch.iommu pointers into device->iommu as well.


>  8 files changed, 304 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/base/device_isolation.c
>  create mode 100644 include/linux/device_isolation.h
> 
> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> index 7be9f79..a52f2db 100644
> --- a/drivers/base/Kconfig
> +++ b/drivers/base/Kconfig
> @@ -189,4 +189,7 @@ config DMA_SHARED_BUFFER
>  	  APIs extension; the file's descriptor can then be passed on to other
>  	  driver.
>  
> +config DEVICE_ISOLATION
> +	bool "Enable isolating devices for safe pass-through to guests or user space."
> +

No need for a config option. When IOMMU drivers are enabled we also want
the group code to be active.


	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
