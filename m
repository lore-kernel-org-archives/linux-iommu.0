From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH 1/2] iommu: move pgsize_bitmap from struct iommu_ops to
	struct iommu_domain
Date: Fri, 06 Mar 2015 13:57:58 +0200
Message-ID: <1973968.aLfySGl5av@avalon>
References: <1425641688-26438-1-git-send-email-will.deacon@arm.com>
	<1425641688-26438-2-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1425641688-26438-2-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
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
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Will,

On Friday 06 March 2015 11:34:47 Will Deacon wrote:
> struct iommu_ops contains function pointers for IOMMU driver callbacks
> in order to implement the core IOMMU API. Amongst these pointers is
> an unsigned long pgsize_bitmap field, which is problematic because the
> set of supported page sizes is not necessarily the same across all
> instances of a given IOMMU type in the system. Furthermore, the set of
> supported page sizes may be restricted following domain initialisation
> when a particular page table format is chosen for the domain.
> 
> This patch moves the field from iommu_ops into the iommu_domain and
> updates all users accordingly.
> 
> Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/iommu/amd_iommu.c       |  2 +-
>  drivers/iommu/arm-smmu.c        | 12 +++++-------
>  drivers/iommu/exynos-iommu.c    |  3 ++-
>  drivers/iommu/intel-iommu.c     |  2 +-
>  drivers/iommu/iommu.c           | 16 ++++++++--------
>  drivers/iommu/ipmmu-vmsa.c      |  2 +-
>  drivers/iommu/msm_iommu.c       |  3 ++-
>  drivers/iommu/omap-iommu.c      |  3 ++-
>  drivers/iommu/rockchip-iommu.c  |  2 +-
>  drivers/iommu/shmobile-iommu.c  |  2 +-
>  drivers/iommu/tegra-gart.c      |  2 +-
>  drivers/iommu/tegra-smmu.c      |  3 +--
>  drivers/vfio/vfio_iommu_type1.c |  2 +-
>  include/linux/iommu.h           |  6 +-----
>  14 files changed, 28 insertions(+), 32 deletions(-)

[snip]

> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 38daa453f2e5..baa05c09ca1b 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -53,6 +53,7 @@ struct iommu_domain_geometry {
> 
>  struct iommu_domain {
>  	const struct iommu_ops *ops;
> +	unsigned long pgsize_bitmap;	/* Bitmap of supported page sizes */
>  	void *priv;
>  	iommu_fault_handler_t handler;
>  	void *handler_token;
> @@ -108,8 +109,6 @@ enum iommu_attr {
>   * @domain_get_attr: Query domain attributes
>   * @domain_set_attr: Change domain attributes
>   * @of_xlate: add OF master IDs to iommu grouping
> - * @pgsize_bitmap: bitmap of supported page sizes
> - * @priv: per-instance data private to the iommu driver
>   */
>  struct iommu_ops {
>  	bool (*capable)(enum iommu_cap);
> @@ -144,9 +143,6 @@ struct iommu_ops {
>  #ifdef CONFIG_OF_IOMMU
>  	int (*of_xlate)(struct device *dev, struct of_phandle_args *args);
>  #endif
> -
> -	unsigned long pgsize_bitmap;
> -	void *priv;

The commit message doesn't mention the removal of the priv field.

>  };
> 
>  #define IOMMU_GROUP_NOTIFY_ADD_DEVICE		1 /* Device added */

-- 
Regards,

Laurent Pinchart
