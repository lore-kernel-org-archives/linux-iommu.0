From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH] ACPI / DMAR: Avoid passing NULL to acpi_put_table()
Date: Wed, 4 Jan 2017 22:19:57 -0800
Message-ID: <20170105061957.GB3742@linux.vnet.ibm.com>
References: <3112193.PjflRgTHFW@aspire.rjw.lan>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3112193.PjflRgTHFW@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Jan 05, 2017 at 01:24:14AM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org> 
> Fixes: 6b11d1d67713 ("ACPI / osl: Remove acpi_get_table_with_size()/early_acpi_os_unmap_memory() users")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Much better!

Tested-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

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
