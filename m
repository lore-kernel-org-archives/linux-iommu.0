From: Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 1/4] PCI / ACPI: Identify untrusted PCI devices
Date: Mon, 3 Dec 2018 18:28:00 -0600
Message-ID: <20181204002800.GB85090@google.com>
References: <20181129155153.35840-1-mika.westerberg@linux.intel.com>
	<20181129155153.35840-2-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20181129155153.35840-2-mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mario.Limonciello-8PEkshWhKlo@public.gmane.org, Michael Jamet <michael.jamet-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Christian Kellner <ckellner-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Anthony Wong <anthony.wong-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Yehezkel Bernat <YehezkelShB-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>, Jacob jun Pan <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andreas Noever <andreas.noever-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Nov 29, 2018 at 06:51:50PM +0300, Mika Westerberg wrote:
> A malicious PCI device may use DMA to attack the system. An external
> Thunderbolt port is a convenient point to attach such a device. The OS
> may use IOMMU to defend against DMA attacks.
> 
> Recent BIOSes with Thunderbolt ports mark these externally facing root
> ports with this ACPI _DSD [1]:

I'm not 100% comfortable with the "Recent BIOSes" wording because that
suggests that we can rely on the fact that *all* BIOSes newer than
some date X mark these ports.

Since this _DSD usage is Microsoft-specific and not required by either
PCIe or ACPI specs, we can't rely on it.  A BIOS that doesn't
implement it may not be Windows-certified, but it's perfectly
spec-compliant otherwise and we have to keep in mind the possibility
that ports without this _DSD may still be externally visible and may
still be attack vectors.

>   Name (_DSD, Package () {
>       ToUUID ("efcc06cc-73ac-4bc3-bff0-76143807c389"),
>       Package () {
>           Package () {"ExternalFacingPort", 1},
> 	  Package () {"UID", 0 }
>       }
>   })
> 
> If we find such a root port, mark it and all its children as untrusted.
> The rest of the OS may use this information to enable DMA protection
> against malicious devices. For instance the device may be put behind an
> IOMMU to keep it from accessing memory outside of what the driver has
> allocated for it.
> 
> While at it, add a comment on top of prp_guids array explaining the
> possible caveat resulting when these GUIDs are treated equivalent.
> 
> [1] https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-externally-exposed-pcie-root-ports
> 
> Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Acked-by: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>

> ---
>  drivers/acpi/property.c | 11 +++++++++++
>  drivers/pci/pci-acpi.c  | 19 +++++++++++++++++++
>  drivers/pci/probe.c     | 15 +++++++++++++++
>  include/linux/pci.h     |  8 ++++++++
>  4 files changed, 53 insertions(+)
> 
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index 8c7c4583b52d..77abe0ec4043 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -24,6 +24,14 @@ static int acpi_data_get_property_array(const struct acpi_device_data *data,
>  					acpi_object_type type,
>  					const union acpi_object **obj);
>  
> +/*
> + * The GUIDs here are made equivalent to each other in order to avoid extra
> + * complexity in the properties handling code, with the caveat that the
> + * kernel will accept certain combinations of GUID and properties that are
> + * not defined without a warning. For instance if any of the properties
> + * from different GUID appear in a property list of another, it will be
> + * accepted by the kernel. Firmware validation tools should catch these.
> + */
>  static const guid_t prp_guids[] = {
>  	/* ACPI _DSD device properties GUID: daffd814-6eba-4d8c-8a91-bc9bbf4aa301 */
>  	GUID_INIT(0xdaffd814, 0x6eba, 0x4d8c,
> @@ -31,6 +39,9 @@ static const guid_t prp_guids[] = {
>  	/* Hotplug in D3 GUID: 6211e2c0-58a3-4af3-90e1-927a4e0c55a4 */
>  	GUID_INIT(0x6211e2c0, 0x58a3, 0x4af3,
>  		  0x90, 0xe1, 0x92, 0x7a, 0x4e, 0x0c, 0x55, 0xa4),
> +	/* External facing port GUID: efcc06cc-73ac-4bc3-bff0-76143807c389 */
> +	GUID_INIT(0xefcc06cc, 0x73ac, 0x4bc3,
> +		  0xbf, 0xf0, 0x76, 0x14, 0x38, 0x07, 0xc3, 0x89),
>  };
>  
>  static const guid_t ads_guid =
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 921db6f80340..e1949f7efd9c 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -789,6 +789,24 @@ static void pci_acpi_optimize_delay(struct pci_dev *pdev,
>  	ACPI_FREE(obj);
>  }
>  
> +static void pci_acpi_set_untrusted(struct pci_dev *dev)
> +{
> +	u8 val;
> +
> +	if (pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT)
> +		return;
> +	if (device_property_read_u8(&dev->dev, "ExternalFacingPort", &val))
> +		return;
> +
> +	/*
> +	 * These root ports expose PCIe (including DMA) outside of the
> +	 * system so make sure we treat them and everything behind as
> +	 * untrusted.
> +	 */
> +	if (val)
> +		dev->untrusted = 1;
> +}
> +
>  static void pci_acpi_setup(struct device *dev)
>  {
>  	struct pci_dev *pci_dev = to_pci_dev(dev);
> @@ -798,6 +816,7 @@ static void pci_acpi_setup(struct device *dev)
>  		return;
>  
>  	pci_acpi_optimize_delay(pci_dev, adev->handle);
> +	pci_acpi_set_untrusted(pci_dev);
>  
>  	pci_acpi_add_pm_notifier(adev, pci_dev);
>  	if (!adev->wakeup.flags.valid)
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index b1c05b5054a0..257b9f6f2ebb 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1378,6 +1378,19 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
>  	}
>  }
>  
> +static void set_pcie_untrusted(struct pci_dev *dev)
> +{
> +	struct pci_dev *parent;
> +
> +	/*
> +	 * If the upstream bridge is untrusted we treat this device
> +	 * untrusted as well.
> +	 */
> +	parent = pci_upstream_bridge(dev);
> +	if (parent && parent->untrusted)
> +		dev->untrusted = true;
> +}
> +
>  /**
>   * pci_ext_cfg_is_aliased - Is ext config space just an alias of std config?
>   * @dev: PCI device
> @@ -1638,6 +1651,8 @@ int pci_setup_device(struct pci_dev *dev)
>  	/* Need to have dev->cfg_size ready */
>  	set_pcie_thunderbolt(dev);
>  
> +	set_pcie_untrusted(dev);
> +
>  	/* "Unknown power state" */
>  	dev->current_state = PCI_UNKNOWN;
>  
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 11c71c4ecf75..c786a2f27bee 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -396,6 +396,14 @@ struct pci_dev {
>  	unsigned int	is_hotplug_bridge:1;
>  	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
>  	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
> +	/*
> +	 * Devices marked being untrusted are the ones that can potentially
> +	 * execute DMA attacks and similar. They are typically connected
> +	 * through external ports such as Thunderbolt but not limited to
> +	 * that. When an IOMMU is enabled they should be getting full
> +	 * mappings to make sure they cannot access arbitrary memory.
> +	 */
> +	unsigned int	untrusted:1;
>  	unsigned int	__aer_firmware_first_valid:1;
>  	unsigned int	__aer_firmware_first:1;
>  	unsigned int	broken_intx_masking:1;	/* INTx masking can't be used */
> -- 
> 2.19.2
> 
