From: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH 3/3] iommu/fsl: Sprinkle some __init* annotations
Date: Fri, 23 Jan 2015 06:11:11 +0000
Message-ID: <BN3PR0301MB121949C520B64675EC971F9FEA360@BN3PR0301MB1219.namprd03.prod.outlook.com>
References: <1421938042-22580-1-git-send-email-Emilian.Medve@Freescale.com>
	<1421938042-22580-3-git-send-email-Emilian.Medve@Freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1421938042-22580-3-git-send-email-Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>
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

Thanks Emil, please find my comments inline.

Regards
Varun

> -----Original Message-----
> From: Emil Medve [mailto:Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org]
> Sent: Thursday, January 22, 2015 8:17 PM
> To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; jroedel-l3A5Bk7waGM@public.gmane.org;
> Sethi Varun-B16395
> Cc: Medve Emilian-EMMEDVE1
> Subject: [PATCH 3/3] iommu/fsl: Sprinkle some __init* annotations
> 
> Signed-off-by: Emil Medve <Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>
> ---
>  drivers/iommu/fsl_pamu.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c index
> 113fb7b..db9c1eb 100644
> --- a/drivers/iommu/fsl_pamu.c
> +++ b/drivers/iommu/fsl_pamu.c
> @@ -59,7 +59,7 @@ static struct ome *omt;
>   * SOCs. For the older SOCs "fsl,qoriq-device-config-1.0"
>   * string would be used.
>  */
> -static const struct of_device_id guts_device_ids[] = {
> +static const struct of_device_id guts_device_ids[] __initconst = {
>  	{ .compatible = "fsl,qoriq-device-config-1.0", },
>  	{ .compatible = "fsl,qoriq-device-config-2.0", },
>  	{}
> @@ -187,7 +187,7 @@ static unsigned int map_subwindow_cnt_to_wce(u32
> subwindow_cnt)
>   * Set the PAACE type as primary and set the coherency required domain
>   * attribute
>   */
> -static void pamu_init_ppaace(struct paace *ppaace)
> +static void __init pamu_init_ppaace(struct paace *ppaace)
>  {


[varun]  This shouldn't be in the init section.
