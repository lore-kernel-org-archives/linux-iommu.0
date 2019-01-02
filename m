From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH 1/1] iova: Allow compiling the library without IOMMU
	support
Date: Thu, 03 Jan 2019 00:52:00 +0200
Message-ID: <12009133.IFJkWA3Ofo@avalon>
References: <20190102211657.13192-1-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190102211657.13192-1-sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, hans.verkuil-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org, bingbu.cao-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, rajmohan.mani-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, yong.zhi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, tian.shu.qiu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Sakari,

Thank you for the patch.

On Wednesday, 2 January 2019 23:16:57 EET Sakari Ailus wrote:
> Drivers such as the Intel IPU3 ImgU driver use the IOVA library to manage
> the device's own virtual address space while not implementing the IOMMU
> API.

Why is that ? Could the IPU3 IOMMU be implemented as an IOMMU driver ?

> Currently the IOVA library is only compiled if the IOMMU support is
> enabled, resulting into a failure during linking due to missing symbols.
> 
> Fix this by defining IOVA library Kconfig bits independently of IOMMU
> support configuration, and descending to the iommu directory
> unconditionally during the build.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>  drivers/Makefile      | 2 +-
>  drivers/iommu/Kconfig | 7 ++++---
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/Makefile b/drivers/Makefile
> index 578f469f72fb..d9c469983592 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -56,7 +56,7 @@ obj-y				+= tty/
>  obj-y				+= char/
> 
>  # iommu/ comes before gpu as gpu are using iommu controllers
> -obj-$(CONFIG_IOMMU_SUPPORT)	+= iommu/
> +obj-y				+= iommu/
> 
>  # gpu/ comes after char for AGP vs DRM startup and after iommu
>  obj-y				+= gpu/
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index d9a25715650e..d2c83e62873d 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -1,3 +1,7 @@
> +# The IOVA library may also be used by non-IOMMU_API users
> +config IOMMU_IOVA
> +	tristate
> +
>  # IOMMU_API always gets selected by whoever wants it.
>  config IOMMU_API
>  	bool
> @@ -81,9 +85,6 @@ config IOMMU_DEFAULT_PASSTHROUGH
> 
>  	  If unsure, say N here.
> 
> -config IOMMU_IOVA
> -	tristate
> -
>  config OF_IOMMU
>         def_bool y
>         depends on OF && IOMMU_API


-- 
Regards,

Laurent Pinchart
