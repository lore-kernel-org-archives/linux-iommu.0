From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v9 4/4] PCI: hisi: blacklist hip06/hip07 controllers
 behind SMMUv3
Date: Mon, 9 Oct 2017 18:54:52 -0500
Message-ID: <20171009235452.GP25517@bhelgaas-glaptop.roam.corp.google.com>
References: <20171006140450.89652-1-shameerali.kolothum.thodi@huawei.com>
 <20171006140450.89652-5-shameerali.kolothum.thodi@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171006140450.89652-5-shameerali.kolothum.thodi@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: lorenzo.pieralisi@arm.com, marc.zyngier@arm.com, sudeep.holla@arm.com, will.deacon@arm.com, robin.murphy@arm.com, joro@8bytes.org, bhelgaas@google.com, gabriele.paoloni@huawei.com, john.garry@huawei.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, devel@acpica.org, linuxarm@huawei.com, wangzhou1@hisilicon.com, guohanjun@huawei.com
List-Id: iommu@lists.linux-foundation.org

Please change subject line:

-  PCI: hisi: blacklist hip06/hip07 controllers behind SMMUv3
+  PCI: hisi: Blacklist hip06/hip07 controllers behind SMMUv3

On Fri, Oct 06, 2017 at 03:04:50PM +0100, Shameer Kolothum wrote:
> The HiSilicon erratum 161010801 describes the limitation of
> HiSilicon platforms hip06/hip07 to support the SMMUv3 mappings
> for MSI transactions.

I don't suppose there's a URL for this erratum, is there?

> PCIe controller on these platforms has to differentiate the MSI
> payload against other DMA payload and has to modify the MSI
> payload. This basically makes it difficult for this platforms to
> have a SMMU translation for MSI. In order to workaround this, ARM
> SMMUv3 driver requires a quirk to treat the MSI regions separately.
> Such a quirk is currently missing for DT based systems and therefore
> we need to blacklist the hip06/hip07 PCIe controllers.

I don't understand the DT connection here.  If this is a hardware
erratum, I assume the a quirk would be required whether the system
uses DT, ACPI, etc.

> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

I assume this will go via some non-PCI tree.  If I were applying this,
I would look for an ack from Zhou or Gabriele in addition to mine.

> ---
>  drivers/pci/dwc/pcie-hisi.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/pci/dwc/pcie-hisi.c b/drivers/pci/dwc/pcie-hisi.c
> index a201791..6800747 100644
> --- a/drivers/pci/dwc/pcie-hisi.c
> +++ b/drivers/pci/dwc/pcie-hisi.c
> @@ -270,6 +270,12 @@ static int hisi_pcie_probe(struct platform_device *pdev)
>  	struct resource *reg;
>  	int ret;
>  
> +	if ((IS_BUILTIN(CONFIG_ARM_SMMU_V3)) &&
> +			of_property_read_bool(dev->of_node, "iommu-map")) {

Does the presence of "iommu-map" tell you this is an SMMUv3?  Could it
have a different type of IOMMU?  I can't tell from reading
Documentation/devicetree/bindings/pci/pci-iommu.txt.

Why do you care whether CONFIG_ARM_SMMU_V3 is set?  Does MSI work
correctly if SMMUv3 is present but not used?

Is it really necessary to ignore the PCIe controller completely?
Could you use the devices below it as long as you disable MSI for
them?  I know there are probably devices that require MSI, so maybe
it's easier to just ignore everything than to respond to reports of
"my device doesn't work because it requires MSI."

> +		dev_warn(dev, "HiSilicon erratum 161010801: blacklisting PCIe controllers behind SMMUv3\n");
> +		return -ENODEV;
> +	}
> +
>  	hisi_pcie = devm_kzalloc(dev, sizeof(*hisi_pcie), GFP_KERNEL);
>  	if (!hisi_pcie)
>  		return -ENOMEM;
> @@ -340,6 +346,12 @@ static int hisi_pcie_almost_ecam_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct pci_ecam_ops *ops;
>  
> +	if ((IS_BUILTIN(CONFIG_ARM_SMMU_V3)) &&
> +			of_property_read_bool(dev->of_node, "iommu-map")) {
> +		dev_warn(dev, "HiSilicon erratum 161010801: blacklisting PCIe controllers behind SMMUv3\n");
> +		return -ENODEV;
> +	}
> +
>  	ops = (struct pci_ecam_ops *)of_device_get_match_data(dev);
>  	return pci_host_common_probe(pdev, ops);
>  }
> -- 
> 1.9.1
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
