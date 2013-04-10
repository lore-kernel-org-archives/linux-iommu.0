From: Shuah Khan <shuahkhan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 8/9] iommu/amd: Don't report firmware bugs with cmd-line
	ivrs overrides
Date: Wed, 10 Apr 2013 09:59:44 -0600
Message-ID: <CAKocOOOQy8us6n2T7=FS4cCq0G7WcJd+G2cvOhmm5QQ9w+ShqA@mail.gmail.com>
References: <1365538384-12426-1-git-send-email-joro@8bytes.org>
	<1365538384-12426-9-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1365538384-12426-9-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Apr 9, 2013 at 2:13 PM, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:
> When the IVRS entries for IOAPIC and HPET are overridden on
> the kernel command line, a problem detected in the check
> function might not be a firmware bug anymore. So disable
> the firmware bug reporting if the user provided valid
> ivrs_ioapic or ivrs_hpet entries on the command line.
>
> Signed-off-by: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
> ---
>  drivers/iommu/amd_iommu_init.c |   19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
> index 030d6ab..9767941 100644
> --- a/drivers/iommu/amd_iommu_init.c
> +++ b/drivers/iommu/amd_iommu_init.c
> @@ -219,6 +219,7 @@ static struct devid_map __initdata early_ioapic_map[EARLY_MAP_SIZE];
>  static struct devid_map __initdata early_hpet_map[EARLY_MAP_SIZE];
>  static int __initdata early_ioapic_map_size;
>  static int __initdata early_hpet_map_size;
> +static bool __initdata cmdline_maps;
>
>  static enum iommu_init_state init_state = IOMMU_START_STATE;
>
> @@ -1686,18 +1687,28 @@ static void __init free_on_init_error(void)
>
>  static bool __init check_ioapic_information(void)
>  {
> +       const char *fw_bug = FW_BUG;
>         bool ret, has_sb_ioapic;
>         int idx;
>
>         has_sb_ioapic = false;
>         ret           = false;
>
> +       /*
> +        * If we have map overrides on the kernel command line the
> +        * messages in this function might not describe firmware bugs
> +        * anymore - so be careful
> +        */
> +       if (cmdline_maps)
> +               fw_bug = "";
> +
>         for (idx = 0; idx < nr_ioapics; idx++) {
>                 int devid, id = mpc_ioapic_id(idx);
>
>                 devid = get_ioapic_devid(id);
>                 if (devid < 0) {
> -                       pr_err(FW_BUG "AMD-Vi: IOAPIC[%d] not in IVRS table\n", id);
> +                       pr_err("%sAMD-Vi: IOAPIC[%d] not in IVRS table\n",
> +                               fw_bug, id);
>                         ret = false;
>                 } else if (devid == IOAPIC_SB_DEVID) {
>                         has_sb_ioapic = true;
> @@ -1714,11 +1725,11 @@ static bool __init check_ioapic_information(void)
>                  * when the BIOS is buggy and provides us the wrong
>                  * device id for the IOAPIC in the system.
>                  */
> -               pr_err(FW_BUG "AMD-Vi: No southbridge IOAPIC found in IVRS table\n");
> +               pr_err("%sAMD-Vi: No southbridge IOAPIC found\n", fw_bug);
>         }
>
>         if (!ret)
> -               pr_err("AMD-Vi: Disabling interrupt remapping due to BIOS Bug(s)\n");
> +               pr_err("AMD-Vi: Disabling interrupt remapping\n");

Can this made conditional on cmdline_maps and keep the original
message in the case of a real BIOS bug? That way it is explicit and
easier to debug.

>
>         return ret;
>  }
> @@ -2166,6 +2177,7 @@ static int __init parse_ivrs_ioapic(char *str)
>
>         devid = ((bus & 0xff) << 8) | ((dev & 0x1f) << 3) | (fn & 0x7);
>
> +       cmdline_maps                    = true;
>         i                               = early_ioapic_map_size++;
>         early_ioapic_map[i].id          = id;
>         early_ioapic_map[i].devid       = devid;
> @@ -2195,6 +2207,7 @@ static int __init parse_ivrs_hpet(char *str)
>
>         devid = ((bus & 0xff) << 8) | ((dev & 0x1f) << 3) | (fn & 0x7);
>
> +       cmdline_maps                    = true;
>         i                               = early_hpet_map_size++;
>         early_hpet_map[i].id            = id;
>         early_hpet_map[i].devid         = devid;
> --
> 1.7.9.5
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
