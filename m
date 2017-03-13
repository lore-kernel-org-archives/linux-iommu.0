From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH 1/3] iommu: Disambiguate MSI region types
Date: Mon, 13 Mar 2017 11:41:28 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA8174E0531@lhreml504-mbx>
References: <1b012c7e82ccef1a34be38d81e82e74f129dfedc.1489088954.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1b012c7e82ccef1a34be38d81e82e74f129dfedc.1489088954.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Gabriele Paoloni <gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "marc.zyngier-5wv7dgnIgG8@public.gmane.org" <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

> -----Original Message-----
> From: Robin Murphy [mailto:robin.murphy-5wv7dgnIgG8@public.gmane.org]
> Sent: Thursday, March 09, 2017 7:51 PM
> To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
> Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; will.deacon-5wv7dgnIgG8@public.gmane.org;
> marc.zyngier-5wv7dgnIgG8@public.gmane.org; Gabriele Paoloni; John Garry; Shameerali Kolothum
> Thodi; Eric Auger; Alex Williamson; David Woodhouse;
> kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: [PATCH 1/3] iommu: Disambiguate MSI region types
> 
> Whilst it doesn't matter much to VFIO at the moment, when parsing
> reserved regions on the host side we really needs to be able to tell
> the difference between the software-reserved region used to map MSIs
> translated by an IOMMU, and hardware regions for which the write might
> never even reach the IOMMU. In particular, ARM systems assume the
> former topology, but may need to cope with the latter as well, which
> will require rather different handling in the iommu-dma layer.
> 
> For clarity, rename the software-managed type to IOMMU_RESV_SW_MSI, use
> IOMMU_RESV_MSI to describe the hardware type, and document everything a
> little bit. Since the x86 MSI remapping hardware falls squarely under
> this meaning of IOMMU_RESV_MSI, apply that type to their regions as
> well, so that we tell a consistent story to userspace across platforms
> (and have future consistency if those drivers start migrating to iommu-
> dma).
> 
> Fixes: d30ddcaa7b02 ("iommu: Add a new type field in
> iommu_resv_region")
> CC: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> CC: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> CC: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
> CC: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
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
> @@ -3202,7 +3202,7 @@ static void amd_iommu_get_resv_regions(struct
> device *dev,
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
> @@ -1888,7 +1888,7 @@ static void arm_smmu_get_resv_regions(struct
> device *dev,
>  	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
> 
>  	region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
> -					 prot, IOMMU_RESV_MSI);
> +					 prot, IOMMU_RESV_SW_MSI);

I have verified this patch series on D05 by modifying the smmuV3 code to 
reserve a HW_MSI_IOVA range corresponds to D05 ITS doorbell. It works. 
Thanks for these patches.

The next step looks like is to define a DT binding to get this in SMMU
Driver and also for ACPI possibly IORT node data updated to reflect the
HW MSI range if any. I will take a look into it and have discussions 
started to get this included in the IORT spec. Please let me know if you
have any other thoughts/ideas on this.

Many thanks,
Shameer
