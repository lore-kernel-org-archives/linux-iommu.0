From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH v3 02/09] iommu/ipmmu-vmsa: Add optional root device
	feature
Date: Wed, 8 Mar 2017 14:47:09 +0100
Message-ID: <CAMuHMdUGnXiOu5oDJ-DE+KGDZEB11P6cwnwdTPwd1HVBT4TqbA@mail.gmail.com>
References: <148897088333.16106.13237004440297956899.sendpatchset@little-apple>
	<148897090350.16106.1978549972946371705.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <148897090350.16106.1978549972946371705.sendpatchset@little-apple>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Magnus,

On Wed, Mar 8, 2017 at 12:01 PM, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> From: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
>
> Add root device handling to the IPMMU driver by allowing certain
> DT compat strings to enable has_cache_leaf_nodes that in turn will
> support both root devices with interrupts and leaf devices that
> face the actual IPMMU consumer devices.
>
> Signed-off-by: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>

> --- 0011/drivers/iommu/ipmmu-vmsa.c
> +++ work/drivers/iommu/ipmmu-vmsa.c     2017-03-08 17:56:51.770607110 +0900

> @@ -216,6 +219,44 @@ static void set_archdata(struct device *
>  #define IMUASID_ASID0_SHIFT            0
>
>  /* -----------------------------------------------------------------------------
> + * Root device handling
> + */
> +
> +static bool ipmmu_is_root(struct ipmmu_vmsa_device *mmu)
> +{
> +       if (mmu->features->has_cache_leaf_nodes)
> +               return mmu->is_leaf ? false : true;

Expressions using the ternary operator are sometimes hard to read.
In this case, you want negation, so why not use that?

return !mmu->is_leaf;

> +       else

I'd drop the else.

> +               return true; /* older IPMMU hardware treated as single root */
> +}
> +
> +static struct ipmmu_vmsa_device *__ipmmu_find_root(void)
> +{
> +       struct ipmmu_vmsa_device *mmu;
> +       bool found = false;

struct ipmmu_vmsa_device *root = NULL;

> +
> +       spin_lock(&ipmmu_devices_lock);
> +
> +       list_for_each_entry(mmu, &ipmmu_devices, list) {
> +               if (ipmmu_is_root(mmu)) {
> +                       found = true;

root = mmu;

> +                       break;
> +               }
> +       }
> +
> +       spin_unlock(&ipmmu_devices_lock);
> +       return found ? mmu : NULL;

return root;

> +}

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
