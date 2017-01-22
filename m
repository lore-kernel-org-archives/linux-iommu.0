From: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH v8 6/9] perf/amd/iommu: Modify
	amd_iommu_pc_get_set_reg_val() API to allow specifying IOMMU index
Date: Sun, 22 Jan 2017 20:53:34 +0100
Message-ID: <20170122195334.c54elbsnbdyscd4n@pd.tnic>
References: <1484551416-5440-1-git-send-email-Suravee.Suthikulpanit@amd.com>
	<1484551416-5440-7-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1484551416-5440-7-git-send-email-Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
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

On Mon, Jan 16, 2017 at 01:23:33AM -0600, Suravee Suthikulpanit wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
> 
> The current amd_iommu_pc_get_set_reg_val() cannot support multiple IOMMUs
> It is also confusing since it is trying to support set and get in
> one function.
> 
> So break it down to amd_iommu_pc_[get|set]_reg(),
> and modifies them to allow callers to specify IOMMU index. This prepares

  and modify

> the driver for supporting multi-IOMMU in subsequent patch.
> 
> Also remove unnecessary function declarations in amd_iommu_proto.h.
> 
> Cc: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
> Cc: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
> Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
> ---
>  arch/x86/events/amd/iommu.c     | 34 ++++++++++----------------
>  arch/x86/events/amd/iommu.h     |  7 ++++--
>  drivers/iommu/amd_iommu_init.c  | 53 ++++++++++++++++++++++++++---------------
>  drivers/iommu/amd_iommu_proto.h |  5 ----
>  4 files changed, 52 insertions(+), 47 deletions(-)

...

> diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
> index ed21307d..5b7fb6c 100644
> --- a/drivers/iommu/amd_iommu_init.c
> +++ b/drivers/iommu/amd_iommu_init.c
> @@ -253,10 +253,6 @@ enum iommu_init_state {
>  static int __init iommu_go_to_state(enum iommu_init_state state);
>  static void init_device_table_dma(void);
>  
> -static int iommu_pc_get_set_reg_val(struct amd_iommu *iommu,
> -				    u8 bank, u8 cntr, u8 fxn,
> -				    u64 *value, bool is_write);
> -
>  static inline void update_last_devid(u16 devid)
>  {
>  	if (devid > amd_iommu_last_bdf)
> @@ -1481,6 +1477,14 @@ static int __init init_iommu_all(struct acpi_table_header *table)
>  	return 0;
>  }
>  
> +#define iommu_pc_get_reg(i, b, c, f, v) \
> +	iommu_pc_get_set_reg(i, b, c, f, v, false)
> +
> +#define iommu_pc_set_reg(i, b, c, f, v) \
> +	iommu_pc_get_set_reg(i, b, c, f, v, true)


Those are completely useless indirection. Just call
iommu_pc_get_set_reg() directly.

> +
> +static int iommu_pc_get_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
> +				u8 fxn, u64 *value, bool is_write);
>  
>  static void init_iommu_perf_ctr(struct amd_iommu *iommu)
>  {


-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
