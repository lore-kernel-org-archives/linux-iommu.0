From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH/RFC] drivers/vfio: Allow type-1 IOMMU instantiation with
	Renesas IPMMU-VMSA
Date: Wed, 25 Jul 2018 14:48:23 +0100
Message-ID: <a0128032-9df5-2326-508b-57f02f4d0b74@arm.com>
References: <20180725133451.7083-1-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180725133451.7083-1-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
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
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Geert,

On 25/07/18 14:34, Geert Uytterhoeven wrote:
> The Renesas IPMMU-VMSA driver is compatible with the notion of a type-1
> IOMMU in VFIO.
> 
> This patch allows guests to use the VFIO_IOMMU_TYPE1 API on hosts
> equipped with a Renesas VMSA-compatible IPMMU.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
> ---
> Lightly tested with sata_rcar on Renesas R-Car H3 ES2.0.
> 
> For testing, this patch and all prerequisites are available in the
> topic/rcar3-virt-gpio-passthrough-v3 branch of my git repository at
> git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git.
> ---
>   drivers/vfio/Kconfig | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
> index c84333eb5eb59bef..a3e21e7c066596d7 100644
> --- a/drivers/vfio/Kconfig
> +++ b/drivers/vfio/Kconfig
> @@ -21,7 +21,8 @@ config VFIO_VIRQFD
>   menuconfig VFIO
>   	tristate "VFIO Non-Privileged userspace driver framework"
>   	depends on IOMMU_API
> -	select VFIO_IOMMU_TYPE1 if (X86 || S390 || ARM_SMMU || ARM_SMMU_V3)
> +	select VFIO_IOMMU_TYPE1 if (X86 || S390 || ARM_SMMU || ARM_SMMU_V3 || \
> +				    IPMMU_VMSA)

I recall this came up in the context of virtio-iommu too[1], wherein we 
decided that listing individual drivers was actually a bit silly and 
this should simply have ARM || ARM64 for consistency. Looks like there's 
even more justification now :)

Robin.

[1] https://www.mail-archive.com/kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org/msg16235.html

>   	select ANON_INODES
>   	help
>   	  VFIO provides a framework for secure userspace device drivers.
> 
