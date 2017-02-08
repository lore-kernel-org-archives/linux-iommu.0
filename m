From: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH v9 6/8] perf/amd/iommu: Modify
	amd_iommu_pc_get_set_reg_val() to allow specifying IOMMU
Date: Wed, 8 Feb 2017 20:32:33 +0100
Message-ID: <20170208193233.qp53skb7cjhqwdut@pd.tnic>
References: <1486456836-17428-1-git-send-email-Suravee.Suthikulpanit@amd.com>
	<1486456836-17428-7-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1486456836-17428-7-git-send-email-Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Cc: peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Feb 07, 2017 at 02:40:34AM -0600, Suravee Suthikulpanit wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
> 
> The current amd_iommu_pc_get_set_reg_val() cannot support multiple IOMMUs.
> So, modify it to allow callers to specify IOMMU. This prepares the driver
> for supporting multi-IOMMU in subsequent patch.
> 
> Cc: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
> Cc: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
> Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
> ---

...

> @@ -2765,48 +2763,58 @@ u8 amd_iommu_pc_get_max_counters(unsigned int idx)
>  }
>  EXPORT_SYMBOL(amd_iommu_pc_get_max_counters);
>  
> -static int iommu_pc_get_set_reg_val(struct amd_iommu *iommu,
> -				    u8 bank, u8 cntr, u8 fxn,
> -				    u64 *value, bool is_write)
> +static int iommu_pc_get_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
> +				u8 fxn, u64 *value, bool is_write)
>  {

...

>  	if (is_write) {
> -		writel((u32)*value, iommu->mmio_base + offset);
> -		writel((*value >> 32), iommu->mmio_base + offset + 4);
> +		u64 val = *value & GENMASK_ULL(47, 0);
> +
> +		writel((u32)val, iommu->mmio_base + offset);
> +		writel((val >> 32), iommu->mmio_base + offset + 4);
>  	} else {
>  		*value = readl(iommu->mmio_base + offset + 4);
>  		*value <<= 32;
> -		*value = readl(iommu->mmio_base + offset);
> +		*value |= readl(iommu->mmio_base + offset);
> +		*value &= GENMASK_ULL(47, 0);
>  	}
>  

This is an unrelated cleanup - please put in a separate patch.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
