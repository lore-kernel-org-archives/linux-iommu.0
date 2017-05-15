From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [patch 10/18] iommu/vt-d: Adjust system_state checks
Date: Mon, 15 May 2017 16:42:39 +0200
Message-ID: <20170515144239.GD14127@8bytes.org>
References: <20170514182716.347236777@linutronix.de>
 <20170514183613.238367369@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170514183613.238367369@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Mark Rutland <mark.rutland@arm.com>, David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On Sun, May 14, 2017 at 08:27:26PM +0200, Thomas Gleixner wrote:
> To enable smp_processor_id() and might_sleep() debug checks earlier, it's
> required to add system states between SYSTEM_BOOTING and SYSTEM_RUNNING.
> 
> Adjust the system_state checks in dmar_parse_one_atsr() and
> dmar_iommu_notify_scope_dev() to handle the extra states.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: iommu@lists.linux-foundation.org
> ---
>  drivers/iommu/intel-iommu.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Joerg Roedel <jroedel@suse.de>

> 
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -4312,7 +4312,7 @@ int dmar_parse_one_atsr(struct acpi_dmar
>  	struct acpi_dmar_atsr *atsr;
>  	struct dmar_atsr_unit *atsru;
>  
> -	if (system_state != SYSTEM_BOOTING && !intel_iommu_enabled)
> +	if (system_state >= SYSTEM_RUNNING && !intel_iommu_enabled)
>  		return 0;
>  
>  	atsr = container_of(hdr, struct acpi_dmar_atsr, header);
> @@ -4562,7 +4562,7 @@ int dmar_iommu_notify_scope_dev(struct d
>  	struct acpi_dmar_atsr *atsr;
>  	struct acpi_dmar_reserved_memory *rmrr;
>  
> -	if (!intel_iommu_enabled && system_state != SYSTEM_BOOTING)
> +	if (!intel_iommu_enabled && system_state >= SYSTEM_RUNNING)
>  		return 0;
>  
>  	list_for_each_entry(rmrru, &dmar_rmrr_units, list) {
> 
