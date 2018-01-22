From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] ARM-SMMU: Delete error messages for a failed memory
	allocation in three functions
Date: Mon, 22 Jan 2018 11:47:13 +0000
Message-ID: <ac171b23-624d-2df3-d1d1-8e9479ae03bc@arm.com>
References: <c3e91414-dd5b-2889-d86c-b19aff56571b@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <c3e91414-dd5b-2889-d86c-b19aff56571b-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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
To: SF Markus Elfring <elfring-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 20/01/18 14:36, SF Markus Elfring wrote:
> From: Markus Elfring <elfring-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
> Date: Sat, 20 Jan 2018 15:30:17 +0100
> 
> Omit extra messages for a memory allocation failure in these functions.

Why?

It's your job as patch author to convince reviewers and maintainers why 
your change is a good thing and they should spend their time looking at 
it, much less consider merging it. This may as well be "delete some 
stuff because I feel like it".

Do bear in mind the nature of these drivers; Arm SMMUs are not something 
you find in microcontrollers. On systems using these drivers, it will 
make no difference whatsoever to anyone if the many-megabyte kernel 
image is 47 bytes (or whatever) smaller.

> This issue was detected by using the Coccinelle software.

I think I'm going to have to start treating mention of Coccinelle as a 
potential disclaimer saying "I haven't attempted to understand the code 
I'm changing" :(

> Signed-off-by: Markus Elfring <elfring-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
> ---
>   drivers/iommu/arm-smmu-v3.c | 9 +++------
>   drivers/iommu/arm-smmu.c    | 9 +++------
>   2 files changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index f122071688fd..5c2a7103d494 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -2134,10 +2134,8 @@ static int arm_smmu_init_l1_strtab(struct arm_smmu_device *smmu)
>   	void *strtab = smmu->strtab_cfg.strtab;
>   
>   	cfg->l1_desc = devm_kzalloc(smmu->dev, size, GFP_KERNEL);
> -	if (!cfg->l1_desc) {
> -		dev_err(smmu->dev, "failed to allocate l1 stream table desc\n");

OK, I'll stop playing *completely* dumb; I do know you would get a splat 
if kmalloc() ever did fail. But what you're removing isn't 
printk("failed to allocate memory\n"), it's a message which says exactly 
what allocation failed *for which device*. Can you clarify how I'm going 
to diagnose this particular problem from the generic splat when all I 
have is en email from a customer with a dmesg dump?

> +	if (!cfg->l1_desc)
>   		return -ENOMEM;
> -	}
>   
>   	for (i = 0; i < cfg->num_l1_ents; ++i) {
>   		arm_smmu_write_strtab_l1_desc(strtab, &cfg->l1_desc[i]);
> @@ -2828,10 +2826,9 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>   	bool bypass;
>   
>   	smmu = devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
> -	if (!smmu) {
> -		dev_err(dev, "failed to allocate arm_smmu_device\n");
> +	if (!smmu)
>   		return -ENOMEM;
> -	}
> +
>   	smmu->dev = dev;
>   
>   	if (dev->of_node) {
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 78d4c6b8f1ba..a4da4a870a2e 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -2048,10 +2048,9 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>   	int num_irqs, i, err;
>   
>   	smmu = devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
> -	if (!smmu) {
> -		dev_err(dev, "failed to allocate arm_smmu_device\n");
> +	if (!smmu)
>   		return -ENOMEM;
> -	}
> +
>   	smmu->dev = dev;
>   
>   	if (dev->of_node)
> @@ -2084,10 +2083,8 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>   
>   	smmu->irqs = devm_kzalloc(dev, sizeof(*smmu->irqs) * num_irqs,
>   				  GFP_KERNEL);
> -	if (!smmu->irqs) {
> -		dev_err(dev, "failed to allocate %d irqs\n", num_irqs);

This more than any other is removing potentially useful information: 
"failed to allocate 37890756 irqs", for instance, would indicate a bug 
which is very much *not* an out-of-memory condition.

Robin.

> +	if (!smmu->irqs)
>   		return -ENOMEM;
> -	}
>   
>   	for (i = 0; i < num_irqs; ++i) {
>   		int irq = platform_get_irq(pdev, i);
> 
