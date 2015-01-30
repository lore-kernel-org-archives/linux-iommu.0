From: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH 02/26] iommu/fsl: Use SVR_* instead of magic numbers
Date: Fri, 30 Jan 2015 06:57:55 +0000
Message-ID: <BN3PR0301MB121951752636406F0B810A9AEA310@BN3PR0301MB1219.namprd03.prod.outlook.com>
References: <1422455698-3074-1-git-send-email-Emilian.Medve@Freescale.com>
	<1422455698-3074-3-git-send-email-Emilian.Medve@Freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1422455698-3074-3-git-send-email-Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>
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
> Subject: [PATCH 02/26] iommu/fsl: Use SVR_* instead of magic numbers
> 
> Signed-off-by: Emil Medve <Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>
> ---
>  drivers/iommu/fsl_pamu.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c index
> 652c34d..7d9f8a0 100644
> --- a/drivers/iommu/fsl_pamu.c
> +++ b/drivers/iommu/fsl_pamu.c
> @@ -31,6 +31,7 @@
>  #include <linux/genalloc.h>
>  #include <asm/io.h>
>  #include <asm/bitops.h>
> +#include <asm/mpc85xx.h>
>  #include <asm/fsl_guts.h>
> 
>  #include "fsl_pamu.h"
> @@ -999,19 +1000,19 @@ static const struct {
>  	u32 svr;
>  	u32 port_id;
>  } port_id_map[] __initconst = {
> -	{0x82100010, 0xFF000000},	/* P2040 1.0 */
> -	{0x82100011, 0xFF000000},	/* P2040 1.1 */
> -	{0x82100110, 0xFF000000},	/* P2041 1.0 */
> -	{0x82100111, 0xFF000000},	/* P2041 1.1 */
> -	{0x82110310, 0xFF000000},	/* P3041 1.0 */
> -	{0x82110311, 0xFF000000},	/* P3041 1.1 */
> -	{0x82010020, 0xFFF80000},	/* P4040 2.0 */
> -	{0x82000020, 0xFFF80000},	/* P4080 2.0 */
> -	{0x82210010, 0xFC000000},       /* P5010 1.0 */
> -	{0x82210020, 0xFC000000},       /* P5010 2.0 */
> -	{0x82200010, 0xFC000000},	/* P5020 1.0 */
> -	{0x82050010, 0xFF800000},	/* P5021 1.0 */
> -	{0x82040010, 0xFF800000},	/* P5040 1.0 */
> +	{(SVR_P2040 << 8) | 0x10, 0xFF000000},	/* P2040 1.0 */
> +	{(SVR_P2040 << 8) | 0x11, 0xFF000000},	/* P2040 1.1 */
> +	{(SVR_P2041 << 8) | 0x10, 0xFF000000},	/* P2041 1.0 */
> +	{(SVR_P2041 << 8) | 0x11, 0xFF000000},	/* P2041 1.1 */
> +	{(SVR_P3041 << 8) | 0x10, 0xFF000000},	/* P3041 1.0 */
> +	{(SVR_P3041 << 8) | 0x11, 0xFF000000},	/* P3041 1.1 */
> +	{(SVR_P4040 << 8) | 0x20, 0xFFF80000},	/* P4040 2.0 */
> +	{(SVR_P4080 << 8) | 0x20, 0xFFF80000},	/* P4080 2.0 */
> +	{(SVR_P5010 << 8) | 0x10, 0xFC000000},	/* P5010 1.0 */
> +	{(SVR_P5010 << 8) | 0x20, 0xFC000000},	/* P5010 2.0 */
> +	{(SVR_P5020 << 8) | 0x10, 0xFC000000},	/* P5020 1.0 */
> +	{(SVR_P5021 << 8) | 0x10, 0xFF800000},	/* P5021 1.0 */
> +	{(SVR_P5040 << 8) | 0x10, 0xFF800000},	/* P5040 1.0 */
>  };
> 
>  #define SVR_SECURITY	0x80000	/* The Security (E) bit */
> --
> 2.2.2
Acked-by: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
