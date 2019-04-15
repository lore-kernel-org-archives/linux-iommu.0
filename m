From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 1/7] ACPI/IORT: Check ATS capability in root complex
 nodes
Date: Mon, 15 Apr 2019 19:31:18 +0100
Message-ID: <c10c7adb-c7f6-f8c6-05cc-f4f143427a2d@arm.com>
References: <20190409165245.26500-1-jean-philippe.brucker@arm.com>
 <20190409165245.26500-2-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190409165245.26500-2-jean-philippe.brucker@arm.com>
Content-Language: en-GB
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, will.deacon@arm.com
Cc: lorenzo.pieralisi@arm.com, eric.auger@redhat.com, zhongmiao@hisilicon.com, okaya@kernel.org, joro@8bytes.org, rjw@rjwysocki.net, linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org, hanjun.guo@linaro.org, sudeep.holla@arm.com, linux-arm-kernel@lists.infradead.org, lenb@kernel.org
List-Id: iommu@lists.linux-foundation.org

On 09/04/2019 17:52, Jean-Philippe Brucker wrote:
> Root complex node in IORT has a bit telling whether it supports ATS or
> not. Store this bit in the IOMMU fwspec when setting up a device, so it
> can be accessed later by an IOMMU driver.

Hmm, it doesn't feel quite right to store a copy of the same RC/SMMU 
integration property for every endpoint...

It seems like it might be more logical to track this at the SMMU end, 
i.e. only allow ARM_SMMU_FEAT_ATS to be set if all RCs targeting that 
SMMU also support ATS. For the moment that seems sufficiently realistic, 
and unless some wacky topology ever actually shows up in silicon to 
complain, I'm inclined not to care too much about it being potentially 
overly restrictive.

Furthermore, I'm now wondering whether it would make sense to push this 
into the PCI layer as well (or instead), i.e. hook into pci_init_ats() 
or pci_enable_ats() and it the device is untrusted or the topology 
doesn't support ATS, prevent the capability from ever being enabled at 
all, rather than trying to mitigate it later at the SMMU end. What do 
you reckon?

> Use the negative version (NO_ATS) at the moment because it's not clear
> if/how the bit needs to be integrated in other firmware descriptions. The
> SMMU has a feature bit telling if it supports ATS, which might be
> sufficient in most systems for deciding whether or not we should enable
> the ATS capability in endpoints.

I can fairly confidently guarantee that it won't. For instance, MMU-600 
reports IDR0.ATS==1 because MMU-600 implements the SMMUv3 architectural 
ATS support. Actually making use of that support, though, still requires 
an RC capable of generating the appropriate DTI-ATS messages, and that a 
DTI interface is wired up correctly between the two.

> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> ---
>   drivers/acpi/arm64/iort.c | 11 +++++++++++
>   include/linux/iommu.h     |  4 ++++
>   2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index e48894e002ba..7f2c1c9c6b38 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -1028,6 +1028,14 @@ void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
>   	dev_dbg(dev, "dma_pfn_offset(%#08llx)\n", offset);
>   }
>   
> +static bool iort_pci_rc_supports_ats(struct acpi_iort_node *node)
> +{
> +	struct acpi_iort_root_complex *pci_rc;
> +
> +	pci_rc = (struct acpi_iort_root_complex *)node->node_data;
> +	return pci_rc->ats_attribute & ACPI_IORT_ATS_SUPPORTED;
> +}
> +
>   /**
>    * iort_iommu_configure - Set-up IOMMU configuration for a device.
>    *
> @@ -1063,6 +1071,9 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
>   		info.node = node;
>   		err = pci_for_each_dma_alias(to_pci_dev(dev),
>   					     iort_pci_iommu_init, &info);
> +
> +		if (!err && !iort_pci_rc_supports_ats(node))
> +			dev->iommu_fwspec->flags |= IOMMU_FWSPEC_PCI_NO_ATS;
>   	} else {
>   		int i = 0;
>   
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 3dbeb457fb16..ed6738c358ca 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -509,10 +509,14 @@ struct iommu_fwspec {
>   	const struct iommu_ops	*ops;
>   	struct fwnode_handle	*iommu_fwnode;
>   	void			*iommu_priv;
> +	u32			flags;
>   	unsigned int		num_ids;
>   	u32			ids[1];
>   };
>   
> +/* Firmware disabled ATS in the root complex */

More likely firmware is just describing how the hardware was built ;)

Robin.

> +#define IOMMU_FWSPEC_PCI_NO_ATS			(1 << 0)
> +
>   int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
>   		      const struct iommu_ops *ops);
>   void iommu_fwspec_free(struct device *dev);
> 
