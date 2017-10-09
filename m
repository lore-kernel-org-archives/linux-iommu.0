From: Zhou Wang <wangzhou1@hisilicon.com>
Subject: Re: [PATCH v9 4/4] PCI: hisi: blacklist hip06/hip07 controllers
 behind SMMUv3
Date: Mon, 9 Oct 2017 16:32:15 +0800
Message-ID: <59DB340F.3010906@hisilicon.com>
References: <20171006140450.89652-1-shameerali.kolothum.thodi@huawei.com>
 <20171006140450.89652-5-shameerali.kolothum.thodi@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20171006140450.89652-5-shameerali.kolothum.thodi@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, lorenzo.pieralisi@arm.com, marc.zyngier@arm.com, sudeep.holla@arm.com, will.deacon@arm.com, robin.murphy@arm.com, joro@8bytes.org, bhelgaas@google.com, gabriele.paoloni@huawei.com
Cc: john.garry@huawei.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, devel@acpica.org, linuxarm@huawei.com, guohanjun@huawei.com
List-Id: iommu@lists.linux-foundation.org

On 2017/10/6 22:04, Shameer Kolothum wrote:
> The HiSilicon erratum 161010801 describes the limitation of
> HiSilicon platforms hip06/hip07 to support the SMMUv3 mappings
> for MSI transactions.
> 
> PCIe controller on these platforms has to differentiate the MSI
> payload against other DMA payload and has to modify the MSI
> payload. This basically makes it difficult for this platforms to
> have a SMMU translation for MSI. In order to workaround this, ARM
> SMMUv3 driver requires a quirk to treat the MSI regions separately.
> Such a quirk is currently missing for DT based systems and therefore
> we need to blacklist the hip06/hip07 PCIe controllers.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
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
>

Acked-by: Zhou Wang <wangzhou1@hisilicon.com>

Thanks,
Zhou



