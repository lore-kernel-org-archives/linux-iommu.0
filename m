From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH v2 16/22] iommu/tegra: smmu: Get "nvidia,swgroup" from DT
Date: Thu, 18 Jul 2013 14:28:42 -0600
Message-ID: <51E84FFA.8020509@wwwdotorg.org>
References: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com>
	<1373021097-32420-17-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1373021097-32420-17-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 07/05/2013 04:44 AM, Hiroshi Doyu wrote:
> This provides the info about which H/W Accelerators are supported on
> Tegra SoC. This info is passed from DT. This is necessary to have the
> unified SMMU driver among Tegra SoCs. Instead of using platform data,
> DT passes "nvidia,swgroup" now. DT is mandatory in Tegra.

> diff --git a/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt b/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt

> +- nvidia,swgroups: A bitmap of supported HardWare Accelerators(HWA).
> +  Each bit represents one swgroup. The assignments may be found in header
> +  file <dt-bindings/memory/tegra-swgroup.h>.

There needs to be a default for this field if one is not specified so
that existing DTs continue to work without modification.

How many cells big is this property?

Is this really a bitmap of HWAs? Surely it's a bitmap of SMMU client IDs?

>  Example:
> -	smmu {
> +	iommu {

The node name shouldn't be interpreted by anything, so there should be
no need to change it at all. Certainly, it should not be changed by this
patch, since this patch is all about SMMU client IDs.

> +		nvidia,swgroups = TEGRA30_SWGROUP_ALL;

As I mentioned before, macros shouldn't include syntax/structure, just
data values.

> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c

> @@ -265,7 +265,7 @@ struct smmu_client {
>  	struct device		*dev;
>  	struct list_head	list;
>  	struct smmu_as		*as;
> -	u32			hwgrp;
> +	u64			hwgrp;

Why is that "hwgrp" not "swgrp"? Don't they represent the same thing?

> @@ -307,6 +307,8 @@ struct smmu_device {
>  	struct device	*dev;
>  	struct page *avp_vector_page;	/* dummy page shared by all AS's */
>  
> +	u64 swgroup;			/* swgroup ID bitmap */

If that's a bitmap, then it represents multiple things, so "swgroups"?

> @@ -382,10 +384,10 @@ static inline void smmu_write(struct smmu_device *smmu, u32 val, size_t offs)
>   */
>  #define FLUSH_SMMU_REGS(smmu)	smmu_read(smmu, SMMU_CONFIG)
>  
> -#define smmu_client_hwgrp(c) (u32)((c)->dev->platform_data)
> +#define smmu_client_hwgrp(c)	(c->as->smmu->swgroup)

hwgrp-vs-swgrp inconsistency again.

Is this series git bisectable? I worry that by the time patch 14 is
applied, the SMMU starts affecting client devices, whereas none of those
client devices have swgroup values defined as their client data, and
hence without this patch also applied, things might blow up in
interesting ways.

I wonder why the code was ever using dev->platform_data in this way; the
platform data for a device should have its structure/semantics defined
by the driver for that device, not by an SMMU that happens to affect
that device. Ick!

>  static int __smmu_client_set_hwgrp(struct smmu_client *c,
> -				   unsigned long map, int on)
> +				   u64 map, int on)
>  {
>  	int i;
>  	struct smmu_as *as = c->as;
> @@ -398,12 +400,11 @@ static int __smmu_client_set_hwgrp(struct smmu_client *c,
>  	if (!on)
>  		map = smmu_client_hwgrp(c);
>  
> -	for_each_set_bit(i, &map, HWGRP_COUNT) {
> +	for_each_set_bit(i, (unsigned long *)&map,
> +			 sizeof(map) * BITS_PER_BYTE) {

Why change the type if it just forces you to add this cast?

>  		offs = HWGRP_ASID_REG(i);
>  		val = smmu_read(smmu, offs);
>  		if (on) {
> -			if (WARN_ON(val & mask))
> -				goto err_hw_busy;

Why?
