From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 1/5] iommu/arm-smmu: Introduce driver option handling
Date: Tue, 8 Oct 2013 16:06:13 +0100
Message-ID: <20131008150613.GC21189@mudshark.cambridge.arm.com>
References: <1381224444-27303-1-git-send-email-andreas.herrmann@calxeda.com>
	<1381224444-27303-2-git-send-email-andreas.herrmann@calxeda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1381224444-27303-2-git-send-email-andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Oct 08, 2013 at 10:27:20AM +0100, Andreas Herrmann wrote:
> Introduce handling of driver options. Options are set based on DT
> information when probing an SMMU device. The first option introduced
> is "arm,smmu-isolate-devices". (It will be used in the bus notifier
> block.)
> 
> Signed-off-by: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/iommu/arm-smmu.c |   49 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index b632bcd..b127f0f 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -348,6 +348,7 @@ struct arm_smmu_device {
>  #define ARM_SMMU_FEAT_TRANS_S2		(1 << 3)
>  #define ARM_SMMU_FEAT_TRANS_NESTED	(1 << 4)
>  	u32				features;
> +	u32				options;

This should be enum arm_smmu_option. Also, we should probably be consistent
between the options and features (i.e. either use an enum for each of them,
or just stick to #defines for both).

>  	int				version;
>  
>  	u32				num_context_banks;
> @@ -398,6 +399,52 @@ struct arm_smmu_domain {
>  static DEFINE_SPINLOCK(arm_smmu_devices_lock);
>  static LIST_HEAD(arm_smmu_devices);
>  
> +/* driver options */
> +enum arm_smmu_option {
> +	ISOLATE_DEVICES = 0,
> +	OPTION_MAX,
> +};
> +
> +struct arm_smmu_option_prop {
> +	enum arm_smmu_option opt;
> +	const char *prop;
> +};
> +
> +static struct arm_smmu_option_prop arm_smmu_options [] = {
> +	{ ISOLATE_DEVICES, "arm,smmu-isolate-devices" },
> +	{ OPTION_MAX, NULL},
> +};
> +
> +static inline int arm_smmu_has_option(struct arm_smmu_device *smmu,
> +				enum arm_smmu_option opt)
> +{
> +	return (smmu->options & (1 << opt));
> +}
> +
> +static inline void arm_smmu_set_option(struct arm_smmu_device *smmu,
> +				enum arm_smmu_option opt)
> +{
> +	smmu->options |= (1 << opt);
> +}
> +
> +static inline void arm_smmu_clear_option(struct arm_smmu_device *smmu,
> +				enum arm_smmu_option opt)
> +{
> +	smmu->options &= ~(1 << opt);
> +}

These three functions are a bit over-engineered! We have things like
__set_bit if you really want to use helpers.

Will
