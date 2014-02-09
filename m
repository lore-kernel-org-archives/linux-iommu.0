From: Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>
Subject: Re: [PATCH 04/28] Remove EXYNOS_DEV_SYSMMU
Date: Sun, 09 Feb 2014 21:08:16 +0100
Message-ID: <1391976496.25855.19.camel@x220>
References: <1391971686-9517-1-git-send-email-richard@nod.at>
	<1391971686-9517-5-git-send-email-richard@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1391971686-9517-5-git-send-email-richard-/L3Ra7n9ekc@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>
Cc: "open list:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Sun, 2014-02-09 at 19:47 +0100, Richard Weinberger wrote:
> The symbol is an orphan, get rid of it.
> 
> Signed-off-by: Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>
> ---
>  drivers/iommu/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 79bbc21..20d062d 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -178,7 +178,7 @@ config TEGRA_IOMMU_SMMU
>  
>  config EXYNOS_IOMMU
>  	bool "Exynos IOMMU Support"
> -	depends on ARCH_EXYNOS && EXYNOS_DEV_SYSMMU
> +	depends on ARCH_EXYNOS
>  	select IOMMU_API
>  	help
>  	  Support for the IOMMU(System MMU) of Samsung Exynos application

I noted this one about a year ago (see
https://lkml.org/lkml/2013/3/5/401 ). By now I wonder whether
EXYNOS_IOMMU (and everything depending on it) shouldn't be removed. That
code has been unbuildable for at least a year now  (I have not checked
how much code is involved).


Paul Bolle
