From: "Zheng, Lv" <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] ACPI / DMAR: Avoid passing NULL to acpi_put_table()
Date: Fri, 6 Jan 2017 01:49:26 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CE21D2D@SHSMSX101.ccr.corp.intel.com>
References: <3112193.PjflRgTHFW@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <3112193.PjflRgTHFW-yvgW3jdyMHm1GS7QM15AGw@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Linux ACPI <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Paul E. McKenney" <paulmck-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Moore,
	Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi, Rafael

> From: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Rafael J.
> Wysocki
> Subject: [PATCH] ACPI / DMAR: Avoid passing NULL to acpi_put_table()
> 
> From: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> 
> Linus reported that commit 174cc7187e6f "ACPICA: Tables: Back port
> acpi_get_table_with_size() and early_acpi_os_unmap_memory() from
> Linux kernel" added a new warning on his desktop system:
> 
>  ACPI Warning: Table ffffffff9fe6c0a0, Validation count is zero before decrement
> 
> which turns out to come from the acpi_put_table() in
> detect_intel_iommu().
> 
> This happens if the DMAR table is not present in which case NULL is
> passed to acpi_put_table() which doesn't check against that and
> attempts to handle it regardless.
> 
> For this reason, check the pointer passed to acpi_put_table()
> before invoking it.
> 
> Reported-by: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
> Fixes: 6b11d1d67713 ("ACPI / osl: Remove acpi_get_table_with_size()/early_acpi_os_unmap_memory()
> users")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Thanks for looking into this issue.
The patch fixes the caller side and thus looks very good from my opinion.
Acked-by: Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Best regards
Lv

> ---
>  drivers/iommu/dmar.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> Index: linux-pm/drivers/iommu/dmar.c
> ===================================================================
> --- linux-pm.orig/drivers/iommu/dmar.c
> +++ linux-pm/drivers/iommu/dmar.c
> @@ -903,8 +903,10 @@ int __init detect_intel_iommu(void)
>  		x86_init.iommu.iommu_init = intel_iommu_init;
>  #endif
> 
> -	acpi_put_table(dmar_tbl);
> -	dmar_tbl = NULL;
> +	if (dmar_tbl) {
> +		acpi_put_table(dmar_tbl);
> +		dmar_tbl = NULL;
> +	}
>  	up_write(&dmar_global_lock);
> 
>  	return ret ? 1 : -ENODEV;
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
