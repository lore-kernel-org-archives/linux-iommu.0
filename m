From: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH 06/26] iommu/fsl: Fix checkpatch type LEADING_SPACE
Date: Fri, 30 Jan 2015 07:15:17 +0000
Message-ID: <BN3PR0301MB1219C9B4ADEADB38433178FCEA310@BN3PR0301MB1219.namprd03.prod.outlook.com>
References: <1422455698-3074-1-git-send-email-Emilian.Medve@Freescale.com>
	<1422455698-3074-7-git-send-email-Emilian.Medve@Freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1422455698-3074-7-git-send-email-Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>
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
> Subject: [PATCH 06/26] iommu/fsl: Fix checkpatch type LEADING_SPACE
> 
> WARNING:LEADING_SPACE: please, no spaces at the start of a line
> +       return __ffs(subwindow_cnt) - 1;$
> 
> WARNING:LEADING_SPACE: please, no spaces at the start of a line
> +                (PAACE_ATM_WINDOW_XLATE | PAACE_ATM_PAGE_XLATE)$
> 
> Signed-off-by: Emil Medve <Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>
> ---
>  drivers/iommu/fsl_pamu.c | 4 ++--
>  drivers/iommu/fsl_pamu.h | 3 +--
>  2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c index
> df6007c..ccdc5e5 100644
> --- a/drivers/iommu/fsl_pamu.c
> +++ b/drivers/iommu/fsl_pamu.c
> @@ -169,8 +169,8 @@ static unsigned int
> map_addrspace_size_to_wse(phys_addr_t addrspace_size)
>  /* Derive the PAACE window count encoding for the subwindow count */
> static unsigned int map_subwindow_cnt_to_wce(u32 subwindow_cnt)  {
> -       /* window count is 2^(WCE+1) bytes */
> -       return __ffs(subwindow_cnt) - 1;
> +	/* window count is 2^(WCE+1) bytes */
> +	return __ffs(subwindow_cnt) - 1;
>  }
> 
>  /*
> diff --git a/drivers/iommu/fsl_pamu.h b/drivers/iommu/fsl_pamu.h index
> a7794b5..52a91af 100644
> --- a/drivers/iommu/fsl_pamu.h
> +++ b/drivers/iommu/fsl_pamu.h
> @@ -200,8 +200,7 @@ struct pamu_mmap_regs {
>  #define PAACE_ATM_NO_XLATE      0x00
>  #define PAACE_ATM_WINDOW_XLATE  0x01
>  #define PAACE_ATM_PAGE_XLATE    0x02
> -#define PAACE_ATM_WIN_PG_XLATE  \
> -                (PAACE_ATM_WINDOW_XLATE | PAACE_ATM_PAGE_XLATE)
> +#define PAACE_ATM_WIN_PG_XLATE  (PAACE_ATM_WINDOW_XLATE |
> +PAACE_ATM_PAGE_XLATE)
>  #define PAACE_OTM_NO_XLATE      0x00
>  #define PAACE_OTM_IMMEDIATE     0x01
>  #define PAACE_OTM_INDEXED       0x02
> --
> 2.2.2
Acked-by: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
