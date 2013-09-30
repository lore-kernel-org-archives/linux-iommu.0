From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 6/7] VFIO: Update documentation for VFIO_IOMMU_TYPE1 driver
Date: Mon, 30 Sep 2013 11:39:26 -0600
Message-ID: <1380562766.2674.176.camel@ul30vt.home>
References: <1380554923-17818-1-git-send-email-a.motakis@virtualopensystems.com>
	<1380554923-17818-7-git-send-email-a.motakis@virtualopensystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1380554923-17818-7-git-send-email-a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, agraf-l3A5Bk7waGM@public.gmane.org, B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, 2013-09-30 at 17:28 +0200, Antonios Motakis wrote:
> The VFIO documentation is slightly out of date. This minor correction
> replaces references to VFIO_IOMMU_X86 with the correct reference to
> VFIO_IOMMU_TYPE1
> 
> Signed-off-by: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
> ---
>  Documentation/vfio.txt | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/vfio.txt b/Documentation/vfio.txt
> index 8eda363..b4eafa6 100644
> --- a/Documentation/vfio.txt
> +++ b/Documentation/vfio.txt
> @@ -167,8 +167,8 @@ group and can access them as follows:
>  	int container, group, device, i;
>  	struct vfio_group_status group_status =
>  					{ .argsz = sizeof(group_status) };
> -	struct vfio_iommu_x86_info iommu_info = { .argsz = sizeof(iommu_info) };
> -	struct vfio_iommu_x86_dma_map dma_map = { .argsz = sizeof(dma_map) };
> +	struct vfio_iommu_type1_info iommu_info = { .argsz = sizeof(iommu_info) };
> +	struct vfio_iommu_type1_dma_map dma_map = { .argsz = sizeof(dma_map) };
>  	struct vfio_device_info device_info = { .argsz = sizeof(device_info) };
>  
>  	/* Create a new container */
> @@ -177,7 +177,7 @@ group and can access them as follows:
>  	if (ioctl(container, VFIO_GET_API_VERSION) != VFIO_API_VERSION)
>  		/* Unknown API version */
>  
> -	if (!ioctl(container, VFIO_CHECK_EXTENSION, VFIO_X86_IOMMU))
> +	if (!ioctl(container, VFIO_CHECK_EXTENSION, VFIO_TYPE1_IOMMU))
>  		/* Doesn't support the IOMMU driver we want. */
>  
>  	/* Open the group */
> @@ -193,7 +193,7 @@ group and can access them as follows:
>  	ioctl(group, VFIO_GROUP_SET_CONTAINER, &container);
>  
>  	/* Enable the IOMMU model we want */
> -	ioctl(container, VFIO_SET_IOMMU, VFIO_X86_IOMMU)
> +	ioctl(container, VFIO_SET_IOMMU, VFIO_TYPE1_IOMMU)
>  
>  	/* Get addition IOMMU info */
>  	ioctl(container, VFIO_IOMMU_GET_INFO, &iommu_info);


Your tree seems out of date, we've already got these:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/Documentation/vfio.txt?id=dac09b57c0ff57e55dd6fa5109076c8af0468a75
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/Documentation/vfio.txt?id=b0e59b85abd42f8a525ff032d5063457e1378808
