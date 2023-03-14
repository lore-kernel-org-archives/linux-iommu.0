Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FFA8F69
	for <iommu@lists.linux.dev>; Tue, 14 Mar 2023 15:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678809031; x=1710345031;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lmj3zKUfjEw3Ftct0JN8uVNOHmN2vSM6YpYHRDqpHk8=;
  b=OUxShvEFKT1LJiRZ4TCDZlU7DYbRj25s+GQqj28QyP5IbWS3BATstAw7
   V6OJEIl7R4Pzvnv3YRqcdYHrcZCePxLLA4dqWcBeSegbVpV0zMvKKap9u
   kBc8TWESFCsyHstxk/vztVDm4gqeKGJL0RgQovD9NK6pjoFLrf264KS1P
   WjH0893PJx8lyRfb+CXV2DeSuHChGxdlisAcyXoY1j52r5NiA+1PYRq/D
   NG+V/Kub3UppNIQ8ROzSzEQ0AcO7d/yciEVqgQLeKL2oC6IH07SR/Nj2H
   OO6uSjB4HqqDHZ5qqNO3+zdVE7muUDoDrQp/dhJdFzi6erPxzcO2bx0Vu
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="339007316"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="339007316"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 08:50:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="709332223"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="709332223"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 08:50:29 -0700
Date: Tue, 14 Mar 2023 08:54:24 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, Will Deacon
 <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Kevin Tian
 <kevin.tian@intel.com>, linux-kernel@vger.kernel.org,
 jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH] iommu/vt-d: Remove unnecessary locking in
 intel_irq_remapping_alloc()
Message-ID: <20230314085424.3e6141d1@jacob-builder>
In-Reply-To: <20230314051836.23817-1-baolu.lu@linux.intel.com>
References: <20230314051836.23817-1-baolu.lu@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi BaoLu,

On Tue, 14 Mar 2023 13:18:36 +0800, Lu Baolu <baolu.lu@linux.intel.com>
wrote:

> The global rwsem dmar_global_lock was introduced by commit 3a5670e8ac932
> ("iommu/vt-d: Introduce a rwsem to protect global data structures"). It
> is used to protect DMAR related global data from DMAR hotplug operations.
> 
> Using dmar_global_lock in intel_irq_remapping_alloc() is unnecessary as
> the DMAR global data structures are not touched there. Remove it to avoid
> below lockdep warning.
> 
>  ======================================================
>  WARNING: possible circular locking dependency detected
>  6.3.0-rc2 #468 Not tainted
>  ------------------------------------------------------
>  swapper/0/1 is trying to acquire lock:
>  ff1db4cb40178698 (&domain->mutex){+.+.}-{3:3},
>    at: __irq_domain_alloc_irqs+0x3b/0xa0
> 
>  but task is already holding lock:
>  ffffffffa0c1cdf0 (dmar_global_lock){++++}-{3:3},
>    at: intel_iommu_init+0x58e/0x880
> 
>  which lock already depends on the new lock.
> 
>  the existing dependency chain (in reverse order) is:
> 
>  -> #1 (dmar_global_lock){++++}-{3:3}:
>         lock_acquire+0xd6/0x320
>         down_read+0x42/0x180
>         intel_irq_remapping_alloc+0xad/0x750
>         mp_irqdomain_alloc+0xb8/0x2b0
>         irq_domain_alloc_irqs_locked+0x12f/0x2d0
>         __irq_domain_alloc_irqs+0x56/0xa0
>         alloc_isa_irq_from_domain.isra.7+0xa0/0xe0
>         mp_map_pin_to_irq+0x1dc/0x330
>         setup_IO_APIC+0x128/0x210
>         apic_intr_mode_init+0x67/0x110
>         x86_late_time_init+0x24/0x40
>         start_kernel+0x41e/0x7e0
>         secondary_startup_64_no_verify+0xe0/0xeb
> 
>  -> #0 (&domain->mutex){+.+.}-{3:3}:
>         check_prevs_add+0x160/0xef0
>         __lock_acquire+0x147d/0x1950
>         lock_acquire+0xd6/0x320
>         __mutex_lock+0x9c/0xfc0
>         __irq_domain_alloc_irqs+0x3b/0xa0
>         dmar_alloc_hwirq+0x9e/0x120
>         iommu_pmu_register+0x11d/0x200
>         intel_iommu_init+0x5de/0x880
>         pci_iommu_init+0x12/0x40
>         do_one_initcall+0x65/0x350
>         kernel_init_freeable+0x3ca/0x610
>         kernel_init+0x1a/0x140
>         ret_from_fork+0x29/0x50
> 
>  other info that might help us debug this:
> 
>  Possible unsafe locking scenario:
> 
>         CPU0                    CPU1
>         ----                    ----
>    lock(dmar_global_lock);
>                                 lock(&domain->mutex);
>                                 lock(dmar_global_lock);
>    lock(&domain->mutex);
> 
>                 *** DEADLOCK ***
> 
> Fixes: 9dbb8e3452ab ("irqdomain: Switch to per-domain locking")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/irq_remapping.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/iommu/intel/irq_remapping.c
> b/drivers/iommu/intel/irq_remapping.c index 6d01fa078c36..df9e261af0b5
> 100644 --- a/drivers/iommu/intel/irq_remapping.c
> +++ b/drivers/iommu/intel/irq_remapping.c
> @@ -311,14 +311,12 @@ static int set_ioapic_sid(struct irte *irte, int
> apic) if (!irte)
>  		return -1;
>  
> -	down_read(&dmar_global_lock);
>  	for (i = 0; i < MAX_IO_APICS; i++) {
>  		if (ir_ioapic[i].iommu && ir_ioapic[i].id == apic) {
>  			sid = (ir_ioapic[i].bus << 8) |
> ir_ioapic[i].devfn; break;
>  		}
>  	}
> -	up_read(&dmar_global_lock);
>  
>  	if (sid == 0) {
>  		pr_warn("Failed to set source-id of IOAPIC (%d)\n",
> apic); @@ -338,14 +336,12 @@ static int set_hpet_sid(struct irte *irte,
> u8 id) if (!irte)
>  		return -1;
>  
> -	down_read(&dmar_global_lock);
>  	for (i = 0; i < MAX_HPET_TBS; i++) {
>  		if (ir_hpet[i].iommu && ir_hpet[i].id == id) {
>  			sid = (ir_hpet[i].bus << 8) | ir_hpet[i].devfn;
>  			break;
>  		}
>  	}
> -	up_read(&dmar_global_lock);
>  
>  	if (sid == 0) {
>  		pr_warn("Failed to set source-id of HPET block (%d)\n",
> id); @@ -1339,9 +1335,7 @@ static int intel_irq_remapping_alloc(struct
> irq_domain *domain, if (!data)
>  		goto out_free_parent;
>  
> -	down_read(&dmar_global_lock);
>  	index = alloc_irte(iommu, &data->irq_2_iommu, nr_irqs);
> -	up_read(&dmar_global_lock);
>  	if (index < 0) {
>  		pr_warn("Failed to allocate IRTE\n");
>  		kfree(data);
Reviewed-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

slightly beyond the scope of this, do we need to take dmar_global_lock
below? shouldn't it be in single threaded context?

	down_write(&dmar_global_lock);
	ret = dmar_dev_scope_init();
	up_write(&dmar_global_lock);

	return ret;
}
rootfs_initcall(ir_dev_scope_init);

Thanks,

Jacob
