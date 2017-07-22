From: Hanjun Guo <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v3 2/2] acpi/iort: numa: Add numa node mapping for smmuv3
	devices
Date: Sat, 22 Jul 2017 11:23:59 +0800
Message-ID: <5972C54F.6030000@huawei.com>
References: <1496897059-8272-1-git-send-email-ganapatrao.kulkarni@cavium.com>
	<1496897059-8272-3-git-send-email-ganapatrao.kulkarni@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1496897059-8272-3-git-send-email-ganapatrao.kulkarni-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Ganapatrao Kulkarni <ganapatrao.kulkarni-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, gpkulkarni-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Will.Deacon-5wv7dgnIgG8@public.gmane.org, jnair-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Ganapat,

On 2017/6/8 12:44, Ganapatrao Kulkarni wrote:
> Add code to parse proximity domain in SMMUv3 IORT table to
> set numa node mapping for smmuv3 devices.
>
> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/acpi/arm64/iort.c | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index bba2b59..e804386 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -882,6 +882,23 @@ static bool __init arm_smmu_v3_is_coherent(struct acpi_iort_node *node)
>  	return smmu->flags & ACPI_IORT_SMMU_V3_COHACC_OVERRIDE;
>  }
>  
> +/*
> + * set numa proximity domain for smmuv3 device
> + */
> +static void  __init arm_smmu_v3_set_proximity(struct acpi_iort_node *node,
> +		struct device *dev)
> +{
> +	struct acpi_iort_smmu_v3 *smmu;
> +
> +	smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
> +	if (smmu->flags & ACPI_IORT_SMMU_V3_PXM_VALID) {
> +		set_dev_node(dev, acpi_map_pxm_to_node(smmu->pxm));
                                                          ^^
Will have compile error in !CONFIG_NUMA, I think we need to introduce
a stub function in acpi_numa.h.

Thanks
Hanjun
