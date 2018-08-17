From: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 1/3] iommu: Add fast hook for getting DMA domains
Date: Fri, 17 Aug 2018 10:36:05 +0100
Message-ID: <d31ca4b3-5cb3-8ba3-485b-3fee58807cae@huawei.com>
References: <cover.1534250425.git.robin.murphy@arm.com>
 <4d50587e62c16f7b5cfc45dee808d774655155cf.1534250425.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4d50587e62c16f7b5cfc45dee808d774655155cf.1534250425.git.robin.murphy@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will.deacon@arm.com, catalin.marinas@arm.com
Cc: thunder.leizhen@huawei.com, linuxarm@huawei.com, iommu@lists.linux-foundation.org, liudongdong3@huawei.com, guohanjun@huawei.com, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On 14/08/2018 14:04, Robin Murphy wrote:
> While iommu_get_domain_for_dev() is the robust way for arbitrary IOMMU
> API callers to retrieve the domain pointer, for DMA ops domains it
> doesn't scale well for large systems and multi-queue devices, since the
> momentary refcount adjustment will lead to exclusive cacheline contention
> when multiple CPUs are operating in parallel on different mappings for
> the same device.
>
> In the case of DMA ops domains, however, this refcounting is actually
> unnecessary, since they already imply that the group exists and is
> managed by platform code and IOMMU internals (by virtue of
> iommu_group_get_for_dev()) such that a reference will already be held
> for the lifetime of the device. Thus we can avoid the bottleneck by
> providing a fast lookup specifically for the DMA code to retrieve the
> default domain it already knows it has set up - a simple read-only
> dereference plays much nicer with cache-coherency protocols.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/iommu.c | 9 +++++++++
>  include/linux/iommu.h | 1 +
>  2 files changed, 10 insertions(+)
>
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 63b37563db7e..63c586875df5 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1379,6 +1379,15 @@ struct iommu_domain *iommu_get_domain_for_dev(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(iommu_get_domain_for_dev);
>
> +/*
> + * For IOMMU_DOMAIN_DMA implementations which already provide their own
> + * guarantees that the group and its default domain are valid and correct.
> + */
> +struct iommu_domain *iommu_get_dma_domain(struct device *dev)
> +{
> +	return dev->iommu_group->default_domain;
> +}
> +
>  /*
>   * IOMMU groups are really the natrual working unit of the IOMMU, but
>   * the IOMMU API works on domains and devices.  Bridge that gap by
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 19938ee6eb31..16f2172698e5 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -297,6 +297,7 @@ extern int iommu_attach_device(struct iommu_domain *domain,
>  extern void iommu_detach_device(struct iommu_domain *domain,
>  				struct device *dev);
>  extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
> +extern struct iommu_domain *iommu_get_dma_domain(struct device *dev);

Hi Robin,

I was wondering whether it's standard to provide a stubbed version of 
this function for !CONFIG_IOMMU_API?

Cheers,
John

>  extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
>  		     phys_addr_t paddr, size_t size, int prot);
>  extern size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova,
>
