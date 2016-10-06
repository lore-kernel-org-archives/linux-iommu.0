From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v13 02/15] iommu/arm-smmu: Initialize the msi geometry
Date: Thu, 6 Oct 2016 14:16:48 -0600
Message-ID: <20161006141648.0eda1648@t450s.home>
References: <1475743531-4780-1-git-send-email-eric.auger@redhat.com>
	<1475743531-4780-3-git-send-email-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1475743531-4780-3-git-send-email-eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, p.fedin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, Manish.Jaggi-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu,  6 Oct 2016 08:45:18 +0000
Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> On ARM, MSI write transactions also are translated by the smmu.
> Let's report that specificity by setting the iommu_msi_supported
> field to true. A valid aperture window will need to be provided.
> 
> Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> 
> ---
> v12 -> v13:
> - reword the commit message
> 
> v8 -> v9:
> - reword the title and patch description
> 
> v7 -> v8:
> - use DOMAIN_ATTR_MSI_GEOMETRY
> 
> v4 -> v5:
> - don't handle fsl_pamu_domain anymore
> - handle arm-smmu-v3
> ---
>  drivers/iommu/arm-smmu-v3.c | 2 ++
>  drivers/iommu/arm-smmu.c    | 3 +++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 15c01c3..f82eec3 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -1382,6 +1382,7 @@ static bool arm_smmu_capable(enum iommu_cap cap)
>  static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
>  {
>  	struct arm_smmu_domain *smmu_domain;
> +	struct iommu_domain_msi_geometry msi_geometry = {0, 0, true};

nit, this initialization makes it difficult to search for who sets
iommu_msi_supported, could we perhaps be more explicit in the
initialization, ie.
	{
		.aperture_start = 0,
		.aperture_end = 0,
		.iommu_msi_supported = true
	};

No change to the compiled version, but easier to find in the source.

>  
>  	if (type != IOMMU_DOMAIN_UNMANAGED && type != IOMMU_DOMAIN_DMA)
>  		return NULL;
> @@ -1400,6 +1401,7 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
>  		kfree(smmu_domain);
>  		return NULL;
>  	}
> +	smmu_domain->domain.msi_geometry = msi_geometry;
>  
>  	mutex_init(&smmu_domain->init_mutex);
>  	spin_lock_init(&smmu_domain->pgtbl_lock);
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index ac4aab9..97ff1b4 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1002,6 +1002,7 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
>  static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
>  {
>  	struct arm_smmu_domain *smmu_domain;
> +	struct iommu_domain_msi_geometry msi_geometry = {0, 0, true};
>  
>  	if (type != IOMMU_DOMAIN_UNMANAGED && type != IOMMU_DOMAIN_DMA)
>  		return NULL;
> @@ -1020,6 +1021,8 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
>  		return NULL;
>  	}
>  
> +	smmu_domain->domain.msi_geometry = msi_geometry;
> +
>  	mutex_init(&smmu_domain->init_mutex);
>  	spin_lock_init(&smmu_domain->pgtbl_lock);
>  
