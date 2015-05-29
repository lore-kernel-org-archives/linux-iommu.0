From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 2/3] iommu/arm-smmu: Add initial driver support for ARM
	SMMUv3 devices
Date: Fri, 29 May 2015 12:35:56 +0100
Message-ID: <55684F1C.3050702@arm.com>
References: <1431108046-9675-1-git-send-email-will.deacon@arm.com>
	<1431108046-9675-3-git-send-email-will.deacon@arm.com>
	<20150519152435.GL20611@8bytes.org>
	<20150520170926.GI11498@arm.com>
	<20150529064337.GN20611@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150529064337.GN20611-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On 29/05/15 07:43, Joerg Roedel wrote:
> Hi Will,
>
> On Wed, May 20, 2015 at 06:09:26PM +0100, Will Deacon wrote:
>> On Tue, May 19, 2015 at 04:24:35PM +0100, Joerg Roedel wrote:
>>>> +	/* Page sizes */
>>>> +	if (reg & IDR5_GRAN64K)
>>>> +		pgsize_bitmap |= SZ_64K | SZ_512M;
>>>> +	if (reg & IDR5_GRAN16K)
>>>> +		pgsize_bitmap |= SZ_16K | SZ_32M;
>>>> +	if (reg & IDR5_GRAN4K)
>>>> +		pgsize_bitmap |= SZ_4K | SZ_2M | SZ_1G;
>>>> +
>>>> +	arm_smmu_ops.pgsize_bitmap &= pgsize_bitmap;
>>>
>>> So this could effictivly lead to a zero pgsize_bitmap when there are
>>> SMMUs in the system with support for different page sizes, no?
>>
>> Indeed, if there is no common page size then we end up not being able to
>> support any. I tried to resolve this by moving the bitmap out of the
>> iommu_ops and into the iommu_domain, but you weren't fond of that idea ;)
>
> Well, what you could do (and what I think the core should do at some
> point) is to build the resulting page-size bitmap by taking the biggest
> minimum page-size from all iommus and OR the page-size bigger than that
> together. For a system with 3 SMMUs supporting all of the above
> pgsize_bitmaps the resulting bitmap would look like this:
>
> 	SZ_64K | SZ_32M | SZ_2M | SZ_512M | SZ_1G;
>
> With the biggest minimum page-size all of the bigger page-sizes can be
> emulated.  But that is not necessary for this patch-set, just a
> suggestion for future work.

The trouble with this is, what about the CPU page size? Say you have 
some multimedia subsystem with its own integrated SMMU and for that 
they've only implemented the 16K granule scheme because it works best 
for the video hardware (and the GPU driver is making direct IOMMU API 
calls to remap carved-out RAM rather than using DMA-mapping). Now, the 
SMMU on the compute side of the SoC serving the general peripherals will 
be rendered useless by bumping the system-wide minimum page size up to 
16K, because it then can't map that scatterlist of discontiguous 4K 
pages that the USB controller needs...

I think this really represents another push to get away from (or at 
least around) the page-at-a-time paradigm - if the IOMMU API itself 
wasn't too fussed about page sizes and could let drivers handle the full 
map/unmap requests however they see fit, I think we could bypass a lot 
of these issues. We've already got the Intel IOMMU driver doing horrible 
hacks with the pgsize_bitmap to cheat the system, I'm sure we don't want 
to add any more of that. How about something like the below diff as a 
first step?

Robin.

---8<---

From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Date: Fri, 29 May 2015 12:05:58 +0100
Subject: [PATCH] iommu: Allow drivers to support arbitrary map/unmap 
requests

In certain situations, the page-at-a-time operation of the IOMMU API
becomes problematic. For instance, IOMMUs which can support different
page sizes per domain confound the use of a single pgsize_bitmap, and
more generally it can be horribly inefficient for large operations
(such as tearing down VFIO domains).

To resolve this, allow drivers to expose their own low-level map/unmap
handlers, in the manner of iommu_map_sg, which may bypass this
restriction as necessary. The existing callbacks are renamed to better
reflect their page-oriented nature.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
  drivers/iommu/amd_iommu.c      |  4 ++--
  drivers/iommu/arm-smmu.c       |  4 ++--
  drivers/iommu/exynos-iommu.c   |  4 ++--
  drivers/iommu/intel-iommu.c    |  4 ++--
  drivers/iommu/iommu.c          | 14 ++++++++++----
  drivers/iommu/ipmmu-vmsa.c     |  4 ++--
  drivers/iommu/msm_iommu.c      |  4 ++--
  drivers/iommu/omap-iommu.c     |  4 ++--
  drivers/iommu/rockchip-iommu.c |  4 ++--
  drivers/iommu/shmobile-iommu.c |  4 ++--
  drivers/iommu/tegra-gart.c     |  4 ++--
  drivers/iommu/tegra-smmu.c     |  4 ++--
  include/linux/iommu.h          |  8 +++++++-
  13 files changed, 39 insertions(+), 27 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index e43d489..13e94ae 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3418,8 +3418,8 @@ static const struct iommu_ops amd_iommu_ops = {
  	.domain_free  = amd_iommu_domain_free,
  	.attach_dev = amd_iommu_attach_device,
  	.detach_dev = amd_iommu_detach_device,
-	.map = amd_iommu_map,
-	.unmap = amd_iommu_unmap,
+	.map_page = amd_iommu_map,
+	.unmap_page = amd_iommu_unmap,
  	.map_sg = default_iommu_map_sg,
  	.iova_to_phys = amd_iommu_iova_to_phys,
  	.pgsize_bitmap	= AMD_IOMMU_PGSIZES,
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 66a803b..427ae40 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1447,8 +1447,8 @@ static struct iommu_ops arm_smmu_ops = {
  	.domain_free		= arm_smmu_domain_free,
  	.attach_dev		= arm_smmu_attach_dev,
  	.detach_dev		= arm_smmu_detach_dev,
-	.map			= arm_smmu_map,
-	.unmap			= arm_smmu_unmap,
+	.map_page		= arm_smmu_map,
+	.unmap_page		= arm_smmu_unmap,
  	.map_sg			= default_iommu_map_sg,
  	.iova_to_phys		= arm_smmu_iova_to_phys,
  	.add_device		= arm_smmu_add_device,
diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 3e89850..9edf14a 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -1182,8 +1182,8 @@ static const struct iommu_ops exynos_iommu_ops = {
  	.domain_free = exynos_iommu_domain_free,
  	.attach_dev = exynos_iommu_attach_device,
  	.detach_dev = exynos_iommu_detach_device,
-	.map = exynos_iommu_map,
-	.unmap = exynos_iommu_unmap,
+	.map_page = exynos_iommu_map,
+	.unmap_page = exynos_iommu_unmap,
  	.map_sg = default_iommu_map_sg,
  	.iova_to_phys = exynos_iommu_iova_to_phys,
  	.add_device = exynos_iommu_add_device,
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 68d43be..67de73d 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4597,8 +4597,8 @@ static const struct iommu_ops intel_iommu_ops = {
  	.domain_free	= intel_iommu_domain_free,
  	.attach_dev	= intel_iommu_attach_device,
  	.detach_dev	= intel_iommu_detach_device,
-	.map		= intel_iommu_map,
-	.unmap		= intel_iommu_unmap,
+	.map_page	= intel_iommu_map,
+	.unmap_page	= intel_iommu_unmap,
  	.map_sg		= default_iommu_map_sg,
  	.iova_to_phys	= intel_iommu_iova_to_phys,
  	.add_device	= intel_iommu_add_device,
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d4f527e..7312623 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1033,7 +1033,10 @@ int iommu_map(struct iommu_domain *domain, 
unsigned long iova,
  	size_t orig_size = size;
  	int ret = 0;

-	if (unlikely(domain->ops->map == NULL ||
+	if (domain->ops->map)
+		return domain->ops->map(domain, iova, paddr, size, prot);
+
+	if (unlikely(domain->ops->map_page == NULL ||
  		     domain->ops->pgsize_bitmap == 0UL))
  		return -ENODEV;

@@ -1062,7 +1065,7 @@ int iommu_map(struct iommu_domain *domain, 
unsigned long iova,
  		pr_debug("mapping: iova 0x%lx pa %pa pgsize 0x%zx\n",
  			 iova, &paddr, pgsize);

-		ret = domain->ops->map(domain, iova, paddr, pgsize, prot);
+		ret = domain->ops->map_page(domain, iova, paddr, pgsize, prot);
  		if (ret)
  			break;

@@ -1087,7 +1090,10 @@ size_t iommu_unmap(struct iommu_domain *domain, 
unsigned long iova, size_t size)
  	unsigned int min_pagesz;
  	unsigned long orig_iova = iova;

-	if (unlikely(domain->ops->unmap == NULL ||
+	if (domain->ops->unmap)
+		return domain->ops->unmap(domain, iova, size);
+
+	if (unlikely(domain->ops->unmap_page == NULL ||
  		     domain->ops->pgsize_bitmap == 0UL))
  		return -ENODEV;

@@ -1117,7 +1123,7 @@ size_t iommu_unmap(struct iommu_domain *domain, 
unsigned long iova, size_t size)
  	while (unmapped < size) {
  		size_t pgsize = iommu_pgsize(domain, iova, size - unmapped);

-		unmapped_page = domain->ops->unmap(domain, iova, pgsize);
+		unmapped_page = domain->ops->unmap_page(domain, iova, pgsize);
  		if (!unmapped_page)
  			break;

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 1a67c53..1db3486 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -746,8 +746,8 @@ static const struct iommu_ops ipmmu_ops = {
  	.domain_free = ipmmu_domain_free,
  	.attach_dev = ipmmu_attach_device,
  	.detach_dev = ipmmu_detach_device,
-	.map = ipmmu_map,
-	.unmap = ipmmu_unmap,
+	.map_page = ipmmu_map,
+	.unmap_page = ipmmu_unmap,
  	.map_sg = default_iommu_map_sg,
  	.iova_to_phys = ipmmu_iova_to_phys,
  	.add_device = ipmmu_add_device,
diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 15a2063..ea40c86 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -677,8 +677,8 @@ static const struct iommu_ops msm_iommu_ops = {
  	.domain_free = msm_iommu_domain_free,
  	.attach_dev = msm_iommu_attach_dev,
  	.detach_dev = msm_iommu_detach_dev,
-	.map = msm_iommu_map,
-	.unmap = msm_iommu_unmap,
+	.map_page = msm_iommu_map,
+	.unmap_page = msm_iommu_unmap,
  	.map_sg = default_iommu_map_sg,
  	.iova_to_phys = msm_iommu_iova_to_phys,
  	.pgsize_bitmap = MSM_IOMMU_PGSIZES,
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index a22c33d..784d29c 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1371,8 +1371,8 @@ static const struct iommu_ops omap_iommu_ops = {
  	.domain_free	= omap_iommu_domain_free,
  	.attach_dev	= omap_iommu_attach_dev,
  	.detach_dev	= omap_iommu_detach_dev,
-	.map		= omap_iommu_map,
-	.unmap		= omap_iommu_unmap,
+	.map_page	= omap_iommu_map,
+	.unmap_page	= omap_iommu_unmap,
  	.map_sg		= default_iommu_map_sg,
  	.iova_to_phys	= omap_iommu_iova_to_phys,
  	.add_device	= omap_iommu_add_device,
diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index cab2145..b10d5b2 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -964,8 +964,8 @@ static const struct iommu_ops rk_iommu_ops = {
  	.domain_free = rk_iommu_domain_free,
  	.attach_dev = rk_iommu_attach_device,
  	.detach_dev = rk_iommu_detach_device,
-	.map = rk_iommu_map,
-	.unmap = rk_iommu_unmap,
+	.map_page = rk_iommu_map,
+	.unmap_page = rk_iommu_unmap,
  	.add_device = rk_iommu_add_device,
  	.remove_device = rk_iommu_remove_device,
  	.iova_to_phys = rk_iommu_iova_to_phys,
diff --git a/drivers/iommu/shmobile-iommu.c b/drivers/iommu/shmobile-iommu.c
index a028751..f587313 100644
--- a/drivers/iommu/shmobile-iommu.c
+++ b/drivers/iommu/shmobile-iommu.c
@@ -366,8 +366,8 @@ static const struct iommu_ops shmobile_iommu_ops = {
  	.domain_free = shmobile_iommu_domain_free,
  	.attach_dev = shmobile_iommu_attach_device,
  	.detach_dev = shmobile_iommu_detach_device,
-	.map = shmobile_iommu_map,
-	.unmap = shmobile_iommu_unmap,
+	.map_page = shmobile_iommu_map,
+	.unmap_page = shmobile_iommu_unmap,
  	.map_sg = default_iommu_map_sg,
  	.iova_to_phys = shmobile_iommu_iova_to_phys,
  	.add_device = shmobile_iommu_add_device,
diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 37e708f..8e4d6f1 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -340,9 +340,9 @@ static const struct iommu_ops gart_iommu_ops = {
  	.domain_free	= gart_iommu_domain_free,
  	.attach_dev	= gart_iommu_attach_dev,
  	.detach_dev	= gart_iommu_detach_dev,
-	.map		= gart_iommu_map,
+	.map_page	= gart_iommu_map,
  	.map_sg		= default_iommu_map_sg,
-	.unmap		= gart_iommu_unmap,
+	.unmap_page	= gart_iommu_unmap,
  	.iova_to_phys	= gart_iommu_iova_to_phys,
  	.pgsize_bitmap	= GART_IOMMU_PGSIZES,
  };
diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index c845d99..38915fc 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -650,8 +650,8 @@ static const struct iommu_ops tegra_smmu_ops = {
  	.detach_dev = tegra_smmu_detach_dev,
  	.add_device = tegra_smmu_add_device,
  	.remove_device = tegra_smmu_remove_device,
-	.map = tegra_smmu_map,
-	.unmap = tegra_smmu_unmap,
+	.map_page = tegra_smmu_map,
+	.unmap_page = tegra_smmu_unmap,
  	.map_sg = default_iommu_map_sg,
  	.iova_to_phys = tegra_smmu_iova_to_phys,

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 0546b87..5857bd6 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -124,6 +124,8 @@ enum iommu_attr {
   * @detach_dev: detach device from an iommu domain
   * @map: map a physically contiguous memory region to an iommu domain
   * @unmap: unmap a physically contiguous memory region from an iommu 
domain
+ * @map_page: map a physical region corresponding to a single iommu page
+ * @unmap_page: unmap a physical region corresponding to a single iommu 
page
   * @map_sg: map a scatter-gather list of physically contiguous memory 
chunks
   * to an iommu domain
   * @iova_to_phys: translate iova to physical address
@@ -147,7 +149,11 @@ struct iommu_ops {
  	int (*map)(struct iommu_domain *domain, unsigned long iova,
  		   phys_addr_t paddr, size_t size, int prot);
  	size_t (*unmap)(struct iommu_domain *domain, unsigned long iova,
-		     size_t size);
+			size_t size);
+	int (*map_page)(struct iommu_domain *domain, unsigned long iova,
+			phys_addr_t paddr, size_t size, int prot);
+	size_t (*unmap_page)(struct iommu_domain *domain, unsigned long iova,
+			     size_t size);
  	size_t (*map_sg)(struct iommu_domain *domain, unsigned long iova,
  			 struct scatterlist *sg, unsigned int nents, int prot);
  	phys_addr_t (*iova_to_phys)(struct iommu_domain *domain, dma_addr_t 
iova);
