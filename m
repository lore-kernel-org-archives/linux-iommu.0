From: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [Patch Part3 V6 8/8] pci, ACPI, iommu: Enhance pci_root to
	support DMAR device hotplug
Date: Wed, 24 Sep 2014 12:37:14 -0600
Message-ID: <20140924183714.GE20416@google.com>
References: <1411103935-31301-1-git-send-email-jiang.liu@linux.intel.com>
	<1411103935-31301-9-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1411103935-31301-9-git-send-email-jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "Rafael J . Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-hotplug-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Sep 19, 2014 at 01:18:55PM +0800, Jiang Liu wrote:
> Finally enhance pci_root driver to support DMAR device hotplug when
> hot-plugging PCI host bridges.
> 
> Signed-off-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Reviewed-by: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>

I assume this will be merged via a non-PCI tree, so:

Acked-by: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>

Looks OK to me, but I expect you'll want Rafael's ack as well.

> ---
>  drivers/acpi/pci_root.c |   16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index e6ae603ed1a1..4e177daa18e3 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -33,6 +33,7 @@
>  #include <linux/pci.h>
>  #include <linux/pci-acpi.h>
>  #include <linux/pci-aspm.h>
> +#include <linux/dmar.h>
>  #include <linux/acpi.h>
>  #include <linux/slab.h>
>  #include <acpi/apei.h>	/* for acpi_hest_init() */
> @@ -511,6 +512,7 @@ static int acpi_pci_root_add(struct acpi_device *device,
>  	struct acpi_pci_root *root;
>  	acpi_handle handle = device->handle;
>  	int no_aspm = 0, clear_aspm = 0;
> +	bool hotadd = system_state != SYSTEM_BOOTING;
>  
>  	root = kzalloc(sizeof(struct acpi_pci_root), GFP_KERNEL);
>  	if (!root)
> @@ -557,6 +559,11 @@ static int acpi_pci_root_add(struct acpi_device *device,
>  	strcpy(acpi_device_class(device), ACPI_PCI_ROOT_CLASS);
>  	device->driver_data = root;
>  
> +	if (hotadd && dmar_device_add(handle)) {
> +		result = -ENXIO;
> +		goto end;
> +	}
> +
>  	pr_info(PREFIX "%s [%s] (domain %04x %pR)\n",
>  	       acpi_device_name(device), acpi_device_bid(device),
>  	       root->segment, &root->secondary);
> @@ -583,7 +590,7 @@ static int acpi_pci_root_add(struct acpi_device *device,
>  			root->segment, (unsigned int)root->secondary.start);
>  		device->driver_data = NULL;
>  		result = -ENODEV;
> -		goto end;
> +		goto remove_dmar;
>  	}
>  
>  	if (clear_aspm) {
> @@ -597,7 +604,7 @@ static int acpi_pci_root_add(struct acpi_device *device,
>  	if (device->wakeup.flags.run_wake)
>  		device_set_run_wake(root->bus->bridge, true);
>  
> -	if (system_state != SYSTEM_BOOTING) {
> +	if (hotadd) {
>  		pcibios_resource_survey_bus(root->bus);
>  		pci_assign_unassigned_root_bus_resources(root->bus);
>  	}
> @@ -607,6 +614,9 @@ static int acpi_pci_root_add(struct acpi_device *device,
>  	pci_unlock_rescan_remove();
>  	return 1;
>  
> +remove_dmar:
> +	if (hotadd)
> +		dmar_device_remove(handle);
>  end:
>  	kfree(root);
>  	return result;
> @@ -625,6 +635,8 @@ static void acpi_pci_root_remove(struct acpi_device *device)
>  
>  	pci_remove_root_bus(root->bus);
>  
> +	dmar_device_remove(device->handle);
> +
>  	pci_unlock_rescan_remove();
>  
>  	kfree(root);
> -- 
> 1.7.10.4
> 
