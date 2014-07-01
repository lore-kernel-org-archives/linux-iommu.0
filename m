From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH 1/3] iommu: introduce IOMMU_DOMAIN_HYP domain type
	for hypervisor allocation
Date: Tue, 01 Jul 2014 11:42:33 -0600
Message-ID: <1404236553.3225.93.camel@ul30vt.home>
References: <1404231017-10856-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1404231017-10856-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, 2014-07-01 at 17:10 +0100, Will Deacon wrote:
> Some IOMMUs, such as the ARM SMMU, support two stages of translation.
> The idea behind such a scheme is to allow a guest operating system to
> use the IOMMU for DMA mappings in the first stage of translation, with
> the hypervisor then installing mappings in the second stage to provide
> isolation of the DMA to the physical range assigned to that virtual
> machine.
> 
> In order to allow IOMMU domains to be allocated for second-stage
> translation, this patch extends iommu_domain_alloc (and the associated
> ->domain_init callback on struct iommu) to take a type parameter
> indicating the intended purpose for the domain. The only supported types
> at present are IOMMU_DOMAIN_DMA (i.e. what we have at the moment) and
> IOMMU_DOMAIN_HYP, which instructs the backend driver to allocate and
> initialise a second-stage domain, if possible.
> 
> All IOMMU drivers are updated to take the new type parameter, but it is
> ignored at present. All callers of iommu_domain_alloc are also updated
> to pass IOMMU_DOMAIN_DMA as the type parameter, apart from
> kvm_iommu_map_guest, which passes the new IOMMU_DOMAIN_HYP flag.
> 
> Finally, a new IOMMU capability, IOMMU_CAP_HYP_MAPPING, is added so that
> it is possible to check whether or not a domain is able to make use of
> nested translation.

Why is this necessarily related to HYPervisor use?  It seems like this
new domain type is effectively just a normal domain that supports some
sort of fault handler that can call out to attempt to create missing
mappings.  IOMMUs supporting PCI PRI (Page Request Interface) could
potentially make use of something like that on bare metal or under
hypervisor control.  If that's true, then could this be some sort of
iommu_domain_set_l2_handler() that happens after the domain is
allocated?

For this patch, I don't understand why legacy KVM assignment would
allocate a HYP domain while VFIO would use a DMA domain.  It seems like
you're just counting on x86 never making the distinction between the
two.

> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -49,6 +49,10 @@ struct iommu_domain_geometry {
>  	bool force_aperture;       /* DMA only allowed in mappable range? */
>  };
>  
> +/* iommu domain types */
> +#define IOMMU_DOMAIN_DMA	0x0
> +#define IOMMU_DOMAIN_HYP	0x1
> +
>  struct iommu_domain {
>  	struct iommu_ops *ops;
>  	void *priv;
> @@ -59,6 +63,7 @@ struct iommu_domain {
>  
>  #define IOMMU_CAP_CACHE_COHERENCY	0x1
>  #define IOMMU_CAP_INTR_REMAP		0x2	/* isolates device intrs */
> +#define IOMMU_CAP_HYP_MAPPING		0x3	/* isolates guest DMA */

This makes no sense, it's exactly what we do with a "DMA" domain.  I
think the code needs to focus on what is really different about this
domain, not what is the expected use case.  Thanks,

Alex
