From: Nate Watterson <nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v2 3/5] iommu/arm-smmu-v3: Make
	arm_smmu_install_ste_for_dev return void
Date: Thu, 16 Mar 2017 12:55:43 -0400
Message-ID: <93c35ad741a3c4572ae9a8ce0057d688@codeaurora.org>
References: <1489178976-15353-1-git-send-email-will.deacon@arm.com>
	<1489178976-15353-4-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1489178976-15353-4-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Will,

On 2017-03-10 15:49, Will Deacon wrote:
> arm_smmu_install_ste_for_dev cannot fail and always returns 0, however
> the fact that it returns int means that callers end up implementing
> redundant error handling code which complicates STE tracking and is
> never executed.
> 
> This patch changes the return type of arm_smmu_install_ste_for_dev
> to avoid, to make it explicit that it cannot fail.
Did you mean "a void" or just "void" instead of "avoid"?

> 
> Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/iommu/arm-smmu-v3.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 3d38e682071a..e18dbcd26f66 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -1579,7 +1579,7 @@ static __le64 *arm_smmu_get_step_for_sid(struct
> arm_smmu_device *smmu, u32 sid)
>  	return step;
>  }
> 
> -static int arm_smmu_install_ste_for_dev(struct iommu_fwspec *fwspec)
> +static void arm_smmu_install_ste_for_dev(struct iommu_fwspec *fwspec)
>  {
>  	int i;
>  	struct arm_smmu_master_data *master = fwspec->iommu_priv;
> @@ -1591,8 +1591,6 @@ static int arm_smmu_install_ste_for_dev(struct
> iommu_fwspec *fwspec)
> 
>  		arm_smmu_write_strtab_ent(smmu, sid, step, &master->ste);
>  	}
> -
> -	return 0;
>  }
> 
>  static void arm_smmu_detach_dev(struct device *dev)
> @@ -1600,8 +1598,7 @@ static void arm_smmu_detach_dev(struct device 
> *dev)
>  	struct arm_smmu_master_data *master = dev->iommu_fwspec->iommu_priv;
> 
>  	master->ste.bypass = true;
> -	if (arm_smmu_install_ste_for_dev(dev->iommu_fwspec) < 0)
> -		dev_warn(dev, "failed to install bypass STE\n");
> +	arm_smmu_install_ste_for_dev(dev->iommu_fwspec);
>  }
> 
>  static int arm_smmu_attach_dev(struct iommu_domain *domain, struct 
> device *dev)
> @@ -1653,10 +1650,7 @@ static int arm_smmu_attach_dev(struct
> iommu_domain *domain, struct device *dev)
>  		ste->s2_cfg = &smmu_domain->s2_cfg;
>  	}
> 
> -	ret = arm_smmu_install_ste_for_dev(dev->iommu_fwspec);
> -	if (ret < 0)
> -		ste->valid = false;
> -
> +	arm_smmu_install_ste_for_dev(dev->iommu_fwspec);
>  out_unlock:
>  	mutex_unlock(&smmu_domain->init_mutex);
>  	return ret;

-- 
Qualcomm Datacenter Technologies, Inc. on behalf of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a 
Linux
Foundation Collaborative Project.
