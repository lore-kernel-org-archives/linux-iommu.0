From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 1/5] iommu/arm-smmu: Restrict domain attributes to
	UNMANAGED domains
Date: Thu, 19 Jan 2017 18:41:34 +0000
Message-ID: <89d795b9-a6d7-7f41-705c-b918ee66ebf0@arm.com>
References: <1484849955-1871-1-git-send-email-will.deacon@arm.com>
	<1484849955-1871-2-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1484849955-1871-2-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 19/01/17 18:19, Will Deacon wrote:
> The ARM SMMU drivers provide a DOMAIN_ATTR_NESTING domain attribute,
> which allows callers of the IOMMU API to request that the page table
> for a domain is installed at stage-2, if supported by the hardware.
> 
> Since setting this attribute only makes sense for UNMANAGED domains,
> this patch returns -ENODEV if the domain_{get,set}_attr operations are
> called on other domain types.

For the sake of discussion, would it make sense to enforce this in
domain_set_attr() itself? The intersection of drivers providing these
callbacks and drivers supporting anything other than unmanaged domains
is currently these two below, so it clearly wouldn't break anything to
put this check in core code today. Looking forward, is there likely to
be any plausible situation where users of a managed domain would be
legitimate in mucking about with its attrs, on any platform?

Robin.

> Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/iommu/arm-smmu-v3.c | 6 ++++++
>  drivers/iommu/arm-smmu.c    | 6 ++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 4d6ec444a9d6..c254325b0c7a 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -1839,6 +1839,9 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
>  {
>  	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>  
> +	if (domain->type != IOMMU_DOMAIN_UNMANAGED)
> +		return -ENODEV;
> +
>  	switch (attr) {
>  	case DOMAIN_ATTR_NESTING:
>  		*(int *)data = (smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED);
> @@ -1854,6 +1857,9 @@ static int arm_smmu_domain_set_attr(struct iommu_domain *domain,
>  	int ret = 0;
>  	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>  
> +	if (domain->type != IOMMU_DOMAIN_UNMANAGED)
> +		return -ENODEV;
> +
>  	mutex_lock(&smmu_domain->init_mutex);
>  
>  	switch (attr) {
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index a60cded8a6ed..a328ffb75509 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1497,6 +1497,9 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
>  {
>  	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>  
> +	if (domain->type != IOMMU_DOMAIN_UNMANAGED)
> +		return -ENODEV;
> +
>  	switch (attr) {
>  	case DOMAIN_ATTR_NESTING:
>  		*(int *)data = (smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED);
> @@ -1512,6 +1515,9 @@ static int arm_smmu_domain_set_attr(struct iommu_domain *domain,
>  	int ret = 0;
>  	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>  
> +	if (domain->type != IOMMU_DOMAIN_UNMANAGED)
> +		return -ENODEV;
> +
>  	mutex_lock(&smmu_domain->init_mutex);
>  
>  	switch (attr) {
> 
