From: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH 1/3] iommu: Disambiguate MSI region types
Date: Mon, 13 Mar 2017 14:08:27 +0100
Message-ID: <a4b012cc-e95d-37af-374a-f06661798168@redhat.com>
References: <1b012c7e82ccef1a34be38d81e82e74f129dfedc.1489088954.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1b012c7e82ccef1a34be38d81e82e74f129dfedc.1489088954.git.robin.murphy@arm.com>
Sender: kvm-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org
Cc: iommu@lists.linux-foundation.org, will.deacon@arm.com, marc.zyngier@arm.com, gabriele.paoloni@huawei.com, john.garry@huawei.com, shameerali.kolothum.thodi@huawei.com, Alex Williamson <alex.williamson@redhat.com>, David Woodhouse <dwmw2@infradead.org>, kvm@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

On 09/03/2017 20:50, Robin Murphy wrote:
> Whilst it doesn't matter much to VFIO at the moment, when parsing
> reserved regions on the host side we really needs to be able to tell
s/needs/need
> the difference between the software-reserved region used to map MSIs
> translated by an IOMMU, and hardware regions for which the write might
> never even reach the IOMMU. In particular, ARM systems assume the former
> topology, but may need to cope with the latter as well, which will
> require rather different handling in the iommu-dma layer.
> 
> For clarity, rename the software-managed type to IOMMU_RESV_SW_MSI, use
> IOMMU_RESV_MSI to describe the hardware type, and document everything a
> little bit. Since the x86 MSI remapping hardware falls squarely under
> this meaning of IOMMU_RESV_MSI, apply that type to their regions as well,
> so that we tell a consistent story to userspace across platforms (and
> have future consistency if those drivers start migrating to iommu-dma).
> 
> Fixes: d30ddcaa7b02 ("iommu: Add a new type field in iommu_resv_region")
does it really fall under the category of fix here?
> CC: Eric Auger <eric.auger@redhat.com>
> CC: Alex Williamson <alex.williamson@redhat.com>
> CC: David Woodhouse <dwmw2@infradead.org>
> CC: kvm@vger.kernel.org
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/amd_iommu.c       | 2 +-
>  drivers/iommu/arm-smmu-v3.c     | 2 +-
>  drivers/iommu/arm-smmu.c        | 2 +-
>  drivers/iommu/intel-iommu.c     | 2 +-
>  drivers/iommu/iommu.c           | 1 +
>  drivers/vfio/vfio_iommu_type1.c | 2 +-
>  include/linux/iommu.h           | 5 +++++
>  7 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index 98940d1392cb..b17536d6e69b 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -3202,7 +3202,7 @@ static void amd_iommu_get_resv_regions(struct device *dev,
>  
>  	region = iommu_alloc_resv_region(MSI_RANGE_START,
>  					 MSI_RANGE_END - MSI_RANGE_START + 1,
> -					 0, IOMMU_RESV_RESERVED);
> +					 0, IOMMU_RESV_MSI);
>  	if (!region)
>  		return;
>  	list_add_tail(&region->list, head);
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 5806a6acc94e..591bb96047c9 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -1888,7 +1888,7 @@ static void arm_smmu_get_resv_regions(struct device *dev,
>  	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
>  
>  	region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
> -					 prot, IOMMU_RESV_MSI);
> +					 prot, IOMMU_RESV_SW_MSI);
>  	if (!region)
>  		return;
>  
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index abf6496843a6..b493c99e17f7 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1608,7 +1608,7 @@ static void arm_smmu_get_resv_regions(struct device *dev,
>  	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
>  
>  	region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
> -					 prot, IOMMU_RESV_MSI);
> +					 prot, IOMMU_RESV_SW_MSI);
>  	if (!region)
>  		return;
>  
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 238ad3447712..f1611fd6f5b0 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -5249,7 +5249,7 @@ static void intel_iommu_get_resv_regions(struct device *device,
>  
>  	reg = iommu_alloc_resv_region(IOAPIC_RANGE_START,
>  				      IOAPIC_RANGE_END - IOAPIC_RANGE_START + 1,
> -				      0, IOMMU_RESV_RESERVED);
> +				      0, IOMMU_RESV_MSI);
>  	if (!reg)
>  		return;
>  	list_add_tail(&reg->list, head);
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 8ea14f41a979..7dbc05f10d5a 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -72,6 +72,7 @@ static const char * const iommu_group_resv_type_string[] = {
>  	[IOMMU_RESV_DIRECT]	= "direct",
>  	[IOMMU_RESV_RESERVED]	= "reserved",
>  	[IOMMU_RESV_MSI]	= "msi",
> +	[IOMMU_RESV_SW_MSI]	= "msi",
>  };
>  
>  #define IOMMU_GROUP_ATTR(_name, _mode, _show, _store)		\
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index c26fa1f3ed86..e32abdebd2df 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -1192,7 +1192,7 @@ static bool vfio_iommu_has_resv_msi(struct iommu_group *group,
Maybe we should change the name of the function into
vfio_iommu_has_resv_sw_msi?

Besides
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric


>  	INIT_LIST_HEAD(&group_resv_regions);
>  	iommu_get_group_resv_regions(group, &group_resv_regions);
>  	list_for_each_entry(region, &group_resv_regions, list) {
> -		if (region->type & IOMMU_RESV_MSI) {
> +		if (region->type & IOMMU_RESV_SW_MSI) {
>  			*base = region->start;
>  			ret = true;
>  			goto out;
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 6a6de187ddc0..fad2c4913be4 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -125,9 +125,14 @@ enum iommu_attr {
>  };
>  
>  /* These are the possible reserved region types */
> +/* Memory regions which must have 1:1 translations present at all times */
>  #define IOMMU_RESV_DIRECT	(1 << 0)
> +/* Arbitrary "never map this or give it to a device" address ranges */
>  #define IOMMU_RESV_RESERVED	(1 << 1)
> +/* Hardware MSI region (untranslated) */
>  #define IOMMU_RESV_MSI		(1 << 2)
> +/* Software-managed MSI translation window */
> +#define IOMMU_RESV_SW_MSI	(1 << 3)
>  
>  /**
>   * struct iommu_resv_region - descriptor for a reserved memory region
> 
