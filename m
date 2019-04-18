From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v3 3/9] ACPI/IORT: Check ATS capability in root complex
 nodes
Date: Thu, 18 Apr 2019 12:20:29 +0100
Message-ID: <20190418112018.GA20470@red-moon>
References: <20190417182448.12382-1-jean-philippe.brucker@arm.com>
 <20190417182448.12382-4-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190417182448.12382-4-jean-philippe.brucker@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: eric.auger@redhat.com, zhongmiao@hisilicon.com, rjw@rjwysocki.net, joro@8bytes.org, will.deacon@arm.com, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org, hanjun.guo@linaro.org, sudeep.holla@arm.com, bhelgaas@google.com, okaya@kernel.org, robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, lenb@kernel.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 17, 2019 at 07:24:42PM +0100, Jean-Philippe Brucker wrote:
> Root complex node in IORT has a bit telling whether it supports ATS or
> not. Store this bit in the IOMMU fwspec when setting up a device, so it
> can be accessed later by an IOMMU driver. In the future we'll probably
> want to store this bit at the host bridge or SMMU rather than in each
> endpoint.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> ---
>  drivers/acpi/arm64/iort.c | 11 +++++++++++
>  include/linux/iommu.h     |  4 ++++
>  2 files changed, 15 insertions(+)

For the IORT portion:

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index e48894e002ba..4000902e57f0 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -1028,6 +1028,14 @@ void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
>  	dev_dbg(dev, "dma_pfn_offset(%#08llx)\n", offset);
>  }
>  
> +static bool iort_pci_rc_supports_ats(struct acpi_iort_node *node)
> +{
> +	struct acpi_iort_root_complex *pci_rc;
> +
> +	pci_rc = (struct acpi_iort_root_complex *)node->node_data;
> +	return pci_rc->ats_attribute & ACPI_IORT_ATS_SUPPORTED;
> +}
> +
>  /**
>   * iort_iommu_configure - Set-up IOMMU configuration for a device.
>   *
> @@ -1063,6 +1071,9 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
>  		info.node = node;
>  		err = pci_for_each_dma_alias(to_pci_dev(dev),
>  					     iort_pci_iommu_init, &info);
> +
> +		if (!err && iort_pci_rc_supports_ats(node))
> +			dev->iommu_fwspec->flags |= IOMMU_FWSPEC_PCI_RC_ATS;
>  	} else {
>  		int i = 0;
>  
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 480921dfbadf..51ab006d348e 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -446,6 +446,7 @@ struct iommu_fwspec {
>  	const struct iommu_ops	*ops;
>  	struct fwnode_handle	*iommu_fwnode;
>  	void			*iommu_priv;
> +	u32			flags;
>  	unsigned int		num_ids;
>  	u32			ids[1];
>  };
> @@ -458,6 +459,9 @@ struct iommu_sva {
>  	const struct iommu_sva_ops	*ops;
>  };
>  
> +/* ATS is supported */
> +#define IOMMU_FWSPEC_PCI_RC_ATS			(1 << 0)
> +
>  int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
>  		      const struct iommu_ops *ops);
>  void iommu_fwspec_free(struct device *dev);
> -- 
> 2.21.0
> 
