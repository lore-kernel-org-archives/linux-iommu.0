From: "Wu, Feng" <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH v9 12/18] vfio: Register/unregister irq_bypass_producer
Date: Mon, 21 Sep 2015 08:56:11 +0000
Message-ID: <E959C4978C3B6342920538CF579893F00272346C@SHSMSX104.ccr.corp.intel.com>
References: <1442586596-5920-1-git-send-email-feng.wu@intel.com>
	<1442586596-5920-13-git-send-email-feng.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1442586596-5920-13-git-send-email-feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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
To: "pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "mtosatti-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <mtosatti-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Paolo & Alex,

I find that there is a build error in the following two cases:
- KVM is configured as 'M' and VFIO as 'Y'
The reason is the build of irqbypass manager is triggered in
arch/x86/kvm/Makefile, and VFIO is built before KVM, hence
it cannot find the symbols in irqbypass manager.

- Disable KVM and enable VFIO in .config
The reason is similar with the above one, the irqbypass manager
is not built since KVM is not configured.

I think the point is that we cannot trigger the build of irqbypass
manager inside KVM or VFIO, we need trigger the build at a high
level and it should be built before VFIO and KVM. Any ideas?

Thanks,
Feng

> -----Original Message-----
> From: Wu, Feng
> Sent: Friday, September 18, 2015 10:30 PM
> To: pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org;
> mtosatti-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
> Cc: eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org; kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Wu, Feng
> Subject: [PATCH v9 12/18] vfio: Register/unregister irq_bypass_producer
> 
> This patch adds the registration/unregistration of an
> irq_bypass_producer for MSI/MSIx on vfio pci devices.
> 
> Signed-off-by: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
> v8:
> - Merge "[PATCH v7 08/17] vfio: Select IRQ_BYPASS_MANAGER for vfio PCI
> devices"
>   into this patch.
> 
> v6:
> - Make the add_consumer and del_consumer callbacks static
> - Remove pointless INIT_LIST_HEAD to 'vdev->ctx[vector].producer.node)'
> - Use dev_info instead of WARN_ON() when irq_bypass_register_producer fails
> - Remove optional dummy callbacks for irq producer
> 
>  drivers/vfio/pci/Kconfig            | 1 +
>  drivers/vfio/pci/vfio_pci_intrs.c   | 9 +++++++++
>  drivers/vfio/pci/vfio_pci_private.h | 2 ++
>  3 files changed, 12 insertions(+)
> 
> diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
> index 579d83b..02912f1 100644
> --- a/drivers/vfio/pci/Kconfig
> +++ b/drivers/vfio/pci/Kconfig
> @@ -2,6 +2,7 @@ config VFIO_PCI
>  	tristate "VFIO support for PCI devices"
>  	depends on VFIO && PCI && EVENTFD
>  	select VFIO_VIRQFD
> +	select IRQ_BYPASS_MANAGER
>  	help
>  	  Support for the PCI VFIO bus driver.  This is required to make
>  	  use of PCI drivers using the VFIO framework.
> diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
> index 1f577b4..c65299d 100644
> --- a/drivers/vfio/pci/vfio_pci_intrs.c
> +++ b/drivers/vfio/pci/vfio_pci_intrs.c
> @@ -319,6 +319,7 @@ static int vfio_msi_set_vector_signal(struct
> vfio_pci_device *vdev,
> 
>  	if (vdev->ctx[vector].trigger) {
>  		free_irq(irq, vdev->ctx[vector].trigger);
> +		irq_bypass_unregister_producer(&vdev->ctx[vector].producer);
>  		kfree(vdev->ctx[vector].name);
>  		eventfd_ctx_put(vdev->ctx[vector].trigger);
>  		vdev->ctx[vector].trigger = NULL;
> @@ -360,6 +361,14 @@ static int vfio_msi_set_vector_signal(struct
> vfio_pci_device *vdev,
>  		return ret;
>  	}
> 
> +	vdev->ctx[vector].producer.token = trigger;
> +	vdev->ctx[vector].producer.irq = irq;
> +	ret = irq_bypass_register_producer(&vdev->ctx[vector].producer);
> +	if (unlikely(ret))
> +		dev_info(&pdev->dev,
> +		"irq bypass producer (token %p) registeration fails: %d\n",
> +		vdev->ctx[vector].producer.token, ret);
> +
>  	vdev->ctx[vector].trigger = trigger;
> 
>  	return 0;
> diff --git a/drivers/vfio/pci/vfio_pci_private.h
> b/drivers/vfio/pci/vfio_pci_private.h
> index ae0e1b4..0e7394f 100644
> --- a/drivers/vfio/pci/vfio_pci_private.h
> +++ b/drivers/vfio/pci/vfio_pci_private.h
> @@ -13,6 +13,7 @@
> 
>  #include <linux/mutex.h>
>  #include <linux/pci.h>
> +#include <linux/irqbypass.h>
> 
>  #ifndef VFIO_PCI_PRIVATE_H
>  #define VFIO_PCI_PRIVATE_H
> @@ -29,6 +30,7 @@ struct vfio_pci_irq_ctx {
>  	struct virqfd		*mask;
>  	char			*name;
>  	bool			masked;
> +	struct irq_bypass_producer	producer;
>  };
> 
>  struct vfio_pci_device {
> --
> 2.1.0
