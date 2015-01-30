From: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH 03/26] iommu/fsl: Remove unused/extra includes
Date: Fri, 30 Jan 2015 07:10:27 +0000
Message-ID: <BN3PR0301MB121904D98B98BBF15CD5EF25EA310@BN3PR0301MB1219.namprd03.prod.outlook.com>
References: <1422455698-3074-1-git-send-email-Emilian.Medve@Freescale.com>
	<1422455698-3074-4-git-send-email-Emilian.Medve@Freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1422455698-3074-4-git-send-email-Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>
Cc: Emilian Medve <Emilian.Medve-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Emil Medve [mailto:Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org]
> Sent: Wednesday, January 28, 2015 8:05 PM
> To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; jroedel-l3A5Bk7waGM@public.gmane.org;
> Sethi Varun-B16395
> Cc: Medve Emilian-EMMEDVE1
> Subject: [PATCH 03/26] iommu/fsl: Remove unused/extra includes
> 
> linux/modules.h		- drivers can't be a module
> linux/bootmem.h		- no boot time memory allocator is used
> linux/notifier.h	- not used
> etc.
> 
> Factorize common includes into fsl_pamu.h
> 
> Signed-off-by: Emil Medve <Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>
> ---
>  drivers/iommu/fsl_pamu.c        | 16 +++-------------
>  drivers/iommu/fsl_pamu.h        |  2 ++
>  drivers/iommu/fsl_pamu_domain.c | 20 ++------------------
>  3 files changed, 7 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c index
> 7d9f8a0..d3a9fff 100644
> --- a/drivers/iommu/fsl_pamu.c
> +++ b/drivers/iommu/fsl_pamu.c
> @@ -18,24 +18,14 @@
> 
>  #define pr_fmt(fmt)    "fsl-pamu: %s: " fmt, __func__
> 
> -#include <linux/init.h>
> -#include <linux/iommu.h>
> -#include <linux/slab.h>
> -#include <linux/module.h>
> -#include <linux/types.h>
> -#include <linux/mm.h>
> +#include "fsl_pamu.h"
> +
>  #include <linux/interrupt.h>
> -#include <linux/device.h>
> -#include <linux/of_platform.h>
> -#include <linux/bootmem.h>
>  #include <linux/genalloc.h>
> -#include <asm/io.h>
> -#include <asm/bitops.h>
> +
>  #include <asm/mpc85xx.h>
>  #include <asm/fsl_guts.h>
> 
> -#include "fsl_pamu.h"
> -
>  /* define indexes for each operation mapping scenario */
>  #define OMI_QMAN        0x00
>  #define OMI_FMAN        0x01
> diff --git a/drivers/iommu/fsl_pamu.h b/drivers/iommu/fsl_pamu.h index
> 8fc1a12..a7794b5 100644
> --- a/drivers/iommu/fsl_pamu.h
> +++ b/drivers/iommu/fsl_pamu.h
> @@ -19,6 +19,8 @@
>  #ifndef __FSL_PAMU_H
>  #define __FSL_PAMU_H
> 
> +#include <linux/iommu.h>
> +
>  #include <asm/fsl_pamu_stash.h>
> 
>  /* Bit Field macros
> diff --git a/drivers/iommu/fsl_pamu_domain.c
> b/drivers/iommu/fsl_pamu_domain.c index 48a72b3..7ea93ae 100644
> --- a/drivers/iommu/fsl_pamu_domain.c
> +++ b/drivers/iommu/fsl_pamu_domain.c
> @@ -19,26 +19,10 @@
> 
>  #define pr_fmt(fmt)    "fsl-pamu-domain: %s: " fmt, __func__
> 
> -#include <linux/init.h>
> -#include <linux/iommu.h>
> -#include <linux/notifier.h>
> -#include <linux/slab.h>
> -#include <linux/module.h>
> -#include <linux/types.h>
> -#include <linux/mm.h>
> -#include <linux/interrupt.h>
> -#include <linux/device.h>
> -#include <linux/of_platform.h>
> -#include <linux/bootmem.h>
> -#include <linux/err.h>
> -#include <asm/io.h>
> -#include <asm/bitops.h>
> -
> -#include <asm/pci-bridge.h>
> -#include <sysdev/fsl_pci.h>
> -
>  #include "fsl_pamu_domain.h"
> 
> +#include <sysdev/fsl_pci.h>
> +
>  /*
>   * Global spinlock that needs to be held while
>   * configuring PAMU.
> --
> 2.2.2
Acked-by: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
