From: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [RFC/PATCH 7/7] iommu-api: Add domain attribute to enable
	coherent HTW
Date: Tue, 1 Jul 2014 08:49:21 +0000
Message-ID: <e64e7ca617d64093bbe5dc7caf9283e1@BL2PR03MB468.namprd03.prod.outlook.com>
References: <1404147116-4598-1-git-send-email-ohaugan@codeaurora.org>
	<1404147116-4598-8-git-send-email-ohaugan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1404147116-4598-8-git-send-email-ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
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
To: Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Cc: "linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "vgandhi-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <vgandhi-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org [mailto:iommu-
> bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org] On Behalf Of Olav Haugan
> Sent: Monday, June 30, 2014 10:22 PM
> To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; iommu-cunTk1MwBs/ROKNJybVBZg@public.gmane.org
> foundation.org
> Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; will.deacon-5wv7dgnIgG8@public.gmane.org;
> thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; vgandhi-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
> Subject: [RFC/PATCH 7/7] iommu-api: Add domain attribute to enable
> coherent HTW
> 
> Add a new iommu domain attribute that can be used to enable cache
> coherent hardware table walks (HTW) by the SMMU. HTW might be supported
> by the SMMU HW but depending on the use case and the usage of the SMMU in
> the SoC it might not be always beneficial to always turn on coherent HTW
> for all domains/iommu's.
> 
[Sethi Varun-B16395] Why won't you want to use the coherent table walk feature?

> Signed-off-by: Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> ---
>  drivers/iommu/msm_iommu-v1.c | 16 ++++++++++++++++
>  include/linux/iommu.h        |  1 +
>  2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/iommu/msm_iommu-v1.c b/drivers/iommu/msm_iommu-v1.c
> index 2c574ef..e163ffc 100644
> --- a/drivers/iommu/msm_iommu-v1.c
> +++ b/drivers/iommu/msm_iommu-v1.c
> @@ -1456,8 +1456,16 @@ static int msm_domain_get_attr(struct iommu_domain
> *domain,
>  			       enum iommu_attr attr, void *data)  {
>  	s32 ret = 0;
> +	struct msm_iommu_priv *priv = domain->priv;
> 
>  	switch (attr) {
> +	case DOMAIN_ATTR_COHERENT_HTW:
> +	{
> +		s32 *int_ptr = (s32 *) data;
> +
> +		*int_ptr = priv->pt.redirect;
> +		break;
> +	}
>  	default:
>  		pr_err("Unsupported attribute type\n");
>  		ret = -EINVAL;
> @@ -1471,8 +1479,16 @@ static int msm_domain_set_attr(struct iommu_domain
> *domain,
>  			       enum iommu_attr attr, void *data)  {
>  	s32 ret = 0;
> +	struct msm_iommu_priv *priv = domain->priv;
> 
>  	switch (attr) {
> +	case DOMAIN_ATTR_COHERENT_HTW:
> +	{
> +		s32 *int_ptr = (s32 *) data;
> +
> +		priv->pt.redirect = *int_ptr;
> +		break;
> +	}
>  	default:
>  		pr_err("Unsupported attribute type\n");
>  		ret = -EINVAL;
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h index
> 63dca6d..6d9596d 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -81,6 +81,7 @@ enum iommu_attr {
>  	DOMAIN_ATTR_FSL_PAMU_STASH,
>  	DOMAIN_ATTR_FSL_PAMU_ENABLE,
>  	DOMAIN_ATTR_FSL_PAMUV1,
> +	DOMAIN_ATTR_COHERENT_HTW,
[Sethi Varun-B16395] Would it make sense to represent this as DOMAIN_ATTR_SMMU_COHERENT_HTW? I believe this is specific to SMMU.

-Varun
