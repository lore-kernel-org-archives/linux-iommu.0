From: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v3] iommu/arm-smmu: avoid calling request_irq in atomic
	context
Date: Wed, 30 Jul 2014 09:51:48 -0700
Message-ID: <vnkwd2cmbxi3.fsf@mitchelh-linux.qualcomm.com>
References: <1406657475-1232-1-git-send-email-mitchelh@codeaurora.org>
	<20140730153114.GG8989@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140730153114.GG8989-5wv7dgnIgG8@public.gmane.org> (Will Deacon's message of "Wed,
	30 Jul 2014 16:31:14 +0100")
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jul 30 2014 at 08:31:14 AM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> Hey Mitch,
>
> On Tue, Jul 29, 2014 at 07:11:15PM +0100, Mitchel Humpherys wrote:
>> request_irq shouldn't be called from atomic context since it might
>> sleep, but we're calling it with a spinlock held, resulting in:
>> 
>>     [    9.172202] BUG: sleeping function called from invalid context at kernel/mm/slub.c:926
>>     [    9.182989] in_atomic(): 1, irqs_disabled(): 128, pid: 1, name: swapper/0
>>     [    9.189762] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W    3.10.40-gbc1b510b-38437-g55831d3bd9-dirty #97
>>     [    9.199757] [<c020c448>] (unwind_backtrace+0x0/0x11c) from [<c02097d0>] (show_stack+0x10/0x14)
>>     [    9.208346] [<c02097d0>] (show_stack+0x10/0x14) from [<c0301d74>] (kmem_cache_alloc_trace+0x3c/0x210)
>>     [    9.217543] [<c0301d74>] (kmem_cache_alloc_trace+0x3c/0x210) from [<c0276a48>] (request_threaded_irq+0x88/0x11c)
>>     [    9.227702] [<c0276a48>] (request_threaded_irq+0x88/0x11c) from [<c0931ca4>] (arm_smmu_attach_dev+0x188/0x858)
>>     [    9.237686] [<c0931ca4>] (arm_smmu_attach_dev+0x188/0x858) from [<c0212cd8>] (arm_iommu_attach_device+0x18/0xd0)
>>     [    9.247837] [<c0212cd8>] (arm_iommu_attach_device+0x18/0xd0) from [<c093314c>] (arm_smmu_test_probe+0x68/0xd4)
>>     [    9.257823] [<c093314c>] (arm_smmu_test_probe+0x68/0xd4) from [<c05aadd0>] (driver_probe_device+0x12c/0x330)
>>     [    9.267629] [<c05aadd0>] (driver_probe_device+0x12c/0x330) from [<c05ab080>] (__driver_attach+0x68/0x8c)
>>     [    9.277090] [<c05ab080>] (__driver_attach+0x68/0x8c) from [<c05a92d4>] (bus_for_each_dev+0x70/0x84)
>>     [    9.286118] [<c05a92d4>] (bus_for_each_dev+0x70/0x84) from [<c05aa3b0>] (bus_add_driver+0x100/0x244)
>>     [    9.295233] [<c05aa3b0>] (bus_add_driver+0x100/0x244) from [<c05ab5d0>] (driver_register+0x9c/0x124)
>>     [    9.304347] [<c05ab5d0>] (driver_register+0x9c/0x124) from [<c0933088>] (arm_smmu_test_init+0x14/0x38)
>>     [    9.313635] [<c0933088>] (arm_smmu_test_init+0x14/0x38) from [<c0200618>] (do_one_initcall+0xb8/0x160)
>>     [    9.322926] [<c0200618>] (do_one_initcall+0xb8/0x160) from [<c1200b7c>] (kernel_init_freeable+0x108/0x1cc)
>>     [    9.332564] [<c1200b7c>] (kernel_init_freeable+0x108/0x1cc) from [<c0b924b0>] (kernel_init+0xc/0xe4)
>>     [    9.341675] [<c0b924b0>] (kernel_init+0xc/0xe4) from [<c0205e38>] (ret_from_fork+0x14/0x3c)
>> 
>> Fix this by moving the request_irq out of the critical section. This
>> should be okay since smmu_domain->smmu is still being protected by the
>> critical section. Also, we still don't program the Stream Match Register
>> until after registering our interrupt handler so we shouldn't be missing
>> any interrupts.
>> 
>> Signed-off-by: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> ---
>> Changelog:
>> 
>>   - v3: rework irq request code to avoid requesting the irq every
>>         time a master is added to the domain
>>   - v2: return error code from request_irq on failure
>> ---
>>  drivers/iommu/arm-smmu.c | 73 +++++++++++++++++++++++++++---------------------
>>  1 file changed, 41 insertions(+), 32 deletions(-)
>
> I think this is correct, but we can do some cleanup now that you've moved
> all the locking into the conditional. Messy diff below, which would be much
> nicer sqaushed into your patch.
>
> What do you reckon?

Much cleaner, thanks. Just one question below.

>
> Will
>
> --->8
>
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 572f5579d38b..e33df1a676ec 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -868,10 +868,15 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)
>  static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>  					struct arm_smmu_device *smmu)
>  {
> -	int ret, start;
> +	int irq, start, ret = 0;
> +	unsigned long flags;
>  	struct arm_smmu_domain *smmu_domain = domain->priv;
>  	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
>  
> +	spin_lock_irqsave(&smmu_domain->lock, flags);
> +	if (smmu_domain->smmu)
> +		goto out_unlock;
> +
>  	if (smmu->features & ARM_SMMU_FEAT_TRANS_NESTED) {
>  		/*
>  		 * We will likely want to change this if/when KVM gets
> @@ -890,7 +895,7 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>  	ret = __arm_smmu_alloc_bitmap(smmu->context_map, start,
>  				      smmu->num_context_banks);
>  	if (IS_ERR_VALUE(ret))
> -		return ret;
> +		goto out_unlock;
>  
>  	cfg->cbndx = ret;
>  	if (smmu->version == 1) {
> @@ -902,7 +907,22 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>  
>  	ACCESS_ONCE(smmu_domain->smmu) = smmu;
>  	arm_smmu_init_context_bank(smmu_domain);
> +	spin_unlock_irqrestore(&smmu_domain->lock, flags);
> +
> +	irq = smmu->irqs[smmu->num_global_irqs + cfg->irptndx];
> +	ret = request_irq(irq, arm_smmu_context_fault, IRQF_SHARED,
> +			  "arm-smmu-context-fault", smmu_domain);
> +	if (IS_ERR_VALUE(ret)) {
> +		dev_err(smmu->dev, "failed to request context IRQ %d (%u)\n",
> +			cfg->irptndx, irq);
> +		cfg->irptndx = INVALID_IRPTNDX;

We want to return ret here due to the request_irq failure, right?

> +	}
> +
>  	return 0;
> +
> +out_unlock:
> +	spin_unlock_irqrestore(&smmu_domain->lock, flags);
> +	return ret;
>  }



-Mitch

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
