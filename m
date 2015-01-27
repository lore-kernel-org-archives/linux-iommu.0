From: Emil Medve <Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH 4/4] iommu/fsl: Use %pa to print phys_addr_t
Date: Tue, 27 Jan 2015 04:40:35 -0600
Message-ID: <54C76B23.3010809@Freescale.com>
References: <1422316230-18893-1-git-send-email-joro@8bytes.org>
	<1422316230-18893-5-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1422316230-18893-5-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: Sethi Varun-B16395 <Varun.Sethi-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hello Joerg,


On 01/26/2015 05:50 PM, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel-l3A5Bk7waGM-XMD5yJDbdMReXY1tMh2IBg@public.gmane.org>
> 
> Fix two compile warnings.
> 
> Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM-XMD5yJDbdMReXY1tMh2IBg@public.gmane.org>
> ---
>  drivers/iommu/fsl_pamu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
> index 80ac68d..e63904b 100644
> --- a/drivers/iommu/fsl_pamu.c
> +++ b/drivers/iommu/fsl_pamu.c
> @@ -352,7 +352,7 @@ int pamu_config_ppaace(int liodn, phys_addr_t win_addr, phys_addr_t win_size,
>  	unsigned long fspi;
>  
>  	if ((win_size & (win_size - 1)) || win_size < PAMU_PAGE_SIZE) {
> -		pr_debug("window size too small or not a power of two %llx\n", win_size);
> +		pr_debug("window size too small or not a power of two %pa\n", &win_size);
>  		return -EINVAL;
>  	}

Somewhere around line 1124 there another opportunity for this fix:

>    1124         dev_dbg(&pdev->dev, "ppaact virt=%p phys=0x%llx\n", ppaact,
>    1125                 (unsigned long long) ppaact_phys);


Cheers,


> @@ -1138,7 +1138,7 @@ static int __init fsl_pamu_probe(struct platform_device *pdev)
>  
>  	if (csd_port_id) {
>  		dev_dbg(&pdev->dev, "creating coherency subdomain at address "
> -			"0x%llx, size %zu, port id 0x%08x", ppaact_phys,
> +			"%pa, size %zu, port id 0x%08x", &ppaact_phys,
>  			mem_size, csd_port_id);
>  
>  		ret = create_csd(ppaact_phys, mem_size, csd_port_id);
