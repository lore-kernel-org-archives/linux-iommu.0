From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] drm/msm: Fix link error with !MSM_IOMMU
Date: Tue, 7 Jan 2014 23:53:45 +0100
Message-ID: <20140107225345.GE29041@8bytes.org>
References: <1389134846-1000-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1389134846-1000-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jan 07, 2014 at 11:47:26PM +0100, Joerg Roedel wrote:
> The DRM driver for MSM depends on symbols from the MSM
> IOMMU driver. Add this dependency to the Kconfig file.
> 
> Fixes this comile error:
> 
>   Kernel: arch/arm/boot/zImage is ready
>   ERROR: "msm_iommu_get_ctx" [drivers/gpu/drm/msm/msm.ko]
>   undefined!
>   make[2]: *** [__modpost] Error 1
> 
> Cc: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
> ---
>  drivers/gpu/drm/msm/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
> index f39ab75..d3de8e1 100644
> --- a/drivers/gpu/drm/msm/Kconfig
> +++ b/drivers/gpu/drm/msm/Kconfig
> @@ -4,6 +4,7 @@ config DRM_MSM
>  	depends on DRM
>  	depends on ARCH_MSM
>  	depends on ARCH_MSM8960
> +	depends on MSM_IOMMU
>  	select DRM_KMS_HELPER
>  	select SHMEM
>  	select TMPFS

FYI, I put the patch to my arm/msm branch meanwhile to get the build
error fixed. Please let me know when there is another solution merged
and I will drop it.


	Joerg
