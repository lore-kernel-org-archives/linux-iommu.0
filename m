From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2] drivers/vfio: Allow type-1 IOMMU instantiation with
	all ARM/ARM64 IOMMUs
Date: Thu, 13 Sep 2018 14:24:52 +0100
Message-ID: <79eb4c6c-8c9a-a4a9-b41e-9f27b4b11117@arm.com>
References: <20180913131529.11837-1-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180913131529.11837-1-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Cc: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 13/09/18 14:15, Geert Uytterhoeven wrote:
> Currently the type-1 IOMMU instantiation depends on "ARM_SMMU ||
> ARM_SMMU_V3", while it applies to other ARM/ARM64 platforms with an
> IOMMU (e.g. Renesas VMSA-compatible IPMMUs).
> 
> Instead of extending the list of IOMMU types on ARM platforms, replace
> the list by "ARM || ARM64", like other architectures do.  The feature is
> still restricted to ARM/ARM64 platforms with an IOMMU by the dependency
> on IOMMU_API.

Reviewed-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

> Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
> ---
> Tested with sata_rcar on Renesas R-Car H3 ES2.0.
> 
> This causes a trivial merge conflict with commit c01eaa95ad30897b ("Make
> anon_inodes unconditional") in vfs/for-next.
> 
> v2:
>    - Make the feature just depend on ARM || ARM64, instead of adding yet
>      another IPMMU_VMSA dependency, as suggested by Robin Murphy
>      <robin.murphy-5wv7dgnIgG8@public.gmane.org>.
> ---
>   drivers/vfio/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
> index c84333eb5eb59bef..9de5ed38da830a91 100644
> --- a/drivers/vfio/Kconfig
> +++ b/drivers/vfio/Kconfig
> @@ -21,7 +21,7 @@ config VFIO_VIRQFD
>   menuconfig VFIO
>   	tristate "VFIO Non-Privileged userspace driver framework"
>   	depends on IOMMU_API
> -	select VFIO_IOMMU_TYPE1 if (X86 || S390 || ARM_SMMU || ARM_SMMU_V3)
> +	select VFIO_IOMMU_TYPE1 if (X86 || S390 || ARM || ARM64)
>   	select ANON_INODES
>   	help
>   	  VFIO provides a framework for secure userspace device drivers.
> 
