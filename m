From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC v1 7/7] iommu/arm-smmu-v3: Enable ACPI based HiSilicon
 erratum 161010801
Date: Tue, 16 May 2017 14:50:29 +0100
Message-ID: <a4e62cb2-9eb6-99a0-3443-df77ae9af8f8@arm.com>
References: <20170513094731.3676-1-shameerali.kolothum.thodi@huawei.com>
 <20170513094731.3676-8-shameerali.kolothum.thodi@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170513094731.3676-8-shameerali.kolothum.thodi@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
To: shameer <shameerali.kolothum.thodi@huawei.com>, will.deacon@arm.com, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org
Cc: gabriele.paoloni@huawei.com, john.garry@huawei.com, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, devel@acpica.org, linuxarm@huawei.com, wangzhou1@hisilicon.com, guohanjun@huawei.com
List-Id: iommu@lists.linux-foundation.org

On 13/05/17 10:47, shameer wrote:
> The HiSilicon erratum 161010801 describes the limitation of HiSilicon
> platforms Hip06/Hip07 to support the SMMU mappings for MSI transactions.
> 
> On these platforms GICv3 ITS translator is presented with the deviceID
> by extending the MSI payload data to 64 bits to include the deviceID.
> Hence, the PCIe controller on this platforms has to differentiate the
> MSI payload against other DMA payload and has to modify the MSI payload.
> This basically makes it difficult for this platforms to have a SMMU
> translation for MSI.
> 
> This patch implements a ACPI table based quirk to reserve the hw msi
> regions in the smmu-v3 driver which means these address regions will
> not be translated and will be excluded from iova allocations.
> 
> ACPI CSRT vendor specific blobs are used to pass the reserve address
> region info on these platforms. HiSilicon CSRT table contains a resource
> group whose device Id matches with the SMMU device model id defined
> in the IORT spec. This SMMU group will not have the optional Resource
> group shared info.

Lorenzo made a point that it might be relatively straightforward to just
follow the IORT mapping for the SMMU through to the ITS MADT entry and
pull the ITS geometry out of that. It would certainly be nicer to have
such a helper abstracted away in the IORT code than have to go parsing
vendor-specific tables directly in the SMMU driver. I reckon it might be
worth taking that idea a bit further to see how it looks.

> typedef struct {
>   UINT32  Length;
>   UINT32  VendorId;
>   UINT32  SubvendorId;
>   UINT16  DeviceId;      ---->Set to IORT SMMU Model number.
>   UINT16  SubdeviceId;
>   UINT16  Revision;
>   UINT8   Reserved[2];
>   UINT32  SharedInfoLength;  ---->Set to zero.
>   ACPI_CSRT_RESOURCE_DESCRIPTOR RsrcDesc;
> } ACPI_CSRT_RESOURCE_GROUP;
> 
> The resource descriptor associated with this group will have the vendor
> specific section populated to represent the MSI region as below.
> 
> typedef struct {
>   UINT32  Length;
>   UINT16  ResourceType;
>   UINT16  ResourceSubtype;
>   UINT32  UID;
>   /* Vendor defined info */
>   UINT64  Base;        -->Corresponding SMMU node base address.
>   UINT64  MSIResvStart; -----> HW MSI reserve start address.
>   UINT32  MSIResvLen; -------> HW MSI reserve len.
> } ACPI_CSRT_RESOURCE_DESCRIPTOR;
> 
> Signed-off-by: shameer <shameerali.kolothum.thodi@huawei.com>
> ---
>  arch/arm64/Kconfig          | 10 ++++++
>  drivers/iommu/arm-smmu-v3.c | 75 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 85 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 21d61ff..e7ebd97 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig

I think you misspelled Documentation/arm64/silicon-errata.txt there ;)

Robin.

> @@ -516,6 +516,16 @@ config HISILICON_ERRATUM_161010701
>  	  CMD_PREFETCH_CFG. This will skip the prefetch cmd usage.
>  
>  	  If unsure, say Y.
> +config HISILICON_ERRATUM_161010801
> +	bool "HiSilicon erratum 161010801: Reserve HW MSI regions"
> +	default y
> +	help
> +	  On HiSilicon Hip06/Hip07 platforms, the SMMU v3 has to bypass the
> +	  GIC ITS doorbel msi address regions. This will make sure that ITS
> +	  doorbell address regions are reserved and excluded from iova
> +	  allocations.
> +
> +	  If unsure, say Y.
>  
>  endmenu
>  
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index e7a8a50..a33e339 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -663,6 +663,73 @@ void erratum_skip_prefetch_cmd(struct arm_smmu_device *smmu, void *arg)
>  	smmu->options |= ARM_SMMU_OPT_SKIP_PREFETCH;
>  }
>  
> +#ifdef CONFIG_HISILICON_ERRATUM_161010801
> +static void parse_hisi_csrt_msi(struct arm_smmu_device *smmu,
> +		const struct acpi_iort_smmu_v3 *iort)
> +
> +{
> +	struct acpi_csrt_group *grp, *end;
> +	struct acpi_table_csrt *csrt;
> +	acpi_status status;
> +
> +	status = acpi_get_table(ACPI_SIG_CSRT, 0,
> +				(struct acpi_table_header **)&csrt);
> +	if (ACPI_FAILURE(status)) {
> +		dev_warn(smmu->dev, "HiSi CSRT table get failed: 0x%x\n",
> +								status);
> +		return;
> +	}
> +
> +	grp = (struct acpi_csrt_group *)(csrt + 1);
> +	end = (struct acpi_csrt_group *)((void *)csrt + csrt->header.length);
> +
> +	while (grp < end) {
> +		if (grp->device_id == iort->model) {
> +			/*
> +			 * We don't have the optional shared info for this grp
> +			 * and has only one resource descriptor with vendor
> +			 * defined msi region for this group. Go straight to
> +			 * vendor defined info.
> +			 */
> +			struct acpi_csrt_descriptor *desc =
> +					(struct acpi_csrt_descriptor *)&grp[1];
> +
> +			/*
> +			 * HiSilicon CSRT vendor info. First 8 bytes gives smmu
> +			 * node base addr, next 8 bytes HW MSI reserve region
> +			 * addr and the remaining 4 byte the len.
> +			 */
> +			void *vendor = &desc[1];
> +			u64 base = (*(u64 *)vendor);
> +
> +			if (base == iort->base_address && smmu->msi_region) {
> +				/* Replace the default SW msi with HW msi */
> +
> +				smmu->msi_region->start =
> +						*((u64 *)((u64 *)vendor+1));
> +				smmu->msi_region->length =
> +						*((u32 *)((u64 *)vendor+2));
> +				smmu->msi_region->type = IOMMU_RESV_MSI;
> +				dev_info(smmu->dev,
> +					"HiSi msi addr 0x%pa size 0x%zx\n",
> +					&smmu->msi_region->start,
> +					smmu->msi_region->length);
> +				return;
> +			}
> +		}
> +
> +		grp = (struct acpi_csrt_group *)((void *)grp + grp->length);
> +	}
> +
> +}
> +void erratum_hisi_resv_hw_msi(struct arm_smmu_device *smmu, void *arg)
> +{
> +	const struct acpi_iort_smmu_v3 *iort_smmu = arg;
> +
> +	parse_hisi_csrt_msi(smmu, iort_smmu);
> +}
> +#endif
> +
>  struct smmu_erratum_workaround {
>  	enum smmu_erratum_match_type match_type;
>  	const void *id;	/* Indicate the Erratum ID */
> @@ -686,6 +753,14 @@ static const struct smmu_erratum_workaround smmu_workarounds[] = {
>  	},
>  
>  #endif
> +#ifdef CONFIG_HISILICON_ERRATUM_161010801
> +	{
> +		.match_type = se_match_acpi_iort_model,
> +		.id = (void *)ACPI_IORT_SMMU_HISILICON_HI161X,
> +		.desc_str = "HiSilicon erratum 161010801",
> +		.enable = erratum_hisi_resv_hw_msi,
> +	},
> +#endif
>  	{
>  
>  	},
> 

