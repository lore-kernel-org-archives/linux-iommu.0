Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AABEA0
	for <iommu@lists.linux.dev>; Wed, 26 Oct 2022 02:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666750627; x=1698286627;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=q5vZaUQzObbh+klypbyZ+vnkhYrchFqnLIGSsqPK6sk=;
  b=PmsGtjhbaXnmOHB2N2ip8vR1qW1OXAWEUhSniX4CSXQyO2YGCkgi4uOa
   UUPIWXmlrWo9FMN5nCeVohrMeFBy/BU4B5DhBQ95tJkthPEq3uvtykz03
   HcjkSnjL5yxdkSuGfoTIm04mx5J0iCvBqQ/tyDDmfYV49OT4qTZinkk3h
   yQPabtp0ajm++mnQknisrNp+gPUcW0ZzdUYiGm8xgr6Q5VQTMPZx04j1I
   Qcz6LTvqQKRpRKOb+fBVQFnNVe0+R1Af6DfHpPOc/X7nBkTS7LkN0tzbJ
   /YZxCBSIboKo5UxL3wWg7PtMhIkO2/2WG5Wox4gIbMzWuZsjOPJuunQsT
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="308933849"
X-IronPort-AV: E=Sophos;i="5.95,213,1661842800"; 
   d="scan'208";a="308933849"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 19:17:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="695189722"
X-IronPort-AV: E=Sophos;i="5.95,213,1661842800"; 
   d="scan'208";a="695189722"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by fmsmga008.fm.intel.com with ESMTP; 25 Oct 2022 19:17:04 -0700
Message-ID: <028e2c63-939b-af31-88b9-b479b41ce67c@linux.intel.com>
Date: Wed, 26 Oct 2022 10:10:29 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH,RFC] iommu/vt-d: Convert dmar_fault IRQ to a threaded IRQ
Content-Language: en-US
To: Lennert Buytenhek <buytenh@wantstofly.org>,
 David Woodhouse <dwmw2@infradead.org>
References: <Y1eZbXKdJDoS8loC@wantstofly.org>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Y1eZbXKdJDoS8loC@wantstofly.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/25/22 4:08 PM, Lennert Buytenhek wrote:
> Under a high enough I/O page fault load, the dmar_fault hardirq handler
> can end up starving other tasks that wanted to run on the CPU that the
> IRQ is being routed to.  On an i7-6700 CPU this seems to happen at
> around 2.5 million I/O page faults per second, and at a fraction of
> that rate on some of the lower-end CPUs that we use.
> 
> An I/O page fault rate of 2.5 million per second may seem like a very
> high number, but when we get an I/O page fault for every cache line
> touched by a DMA operation, this I/O page fault rate can be the result
> of a confused PCIe device DMAing to RAM at 2.5 * 64 = 160 MB/sec, which
> is not an unlikely rate to be DMAing things to RAM at.  And, in fact,
> when we do see PCIe devices getting confused like this, this sort of
> I/O page fault rate is not uncommon.
> 
> A peripheral device continuously DMAing to RAM at 160 MB/s is
> inarguably a bug, either in the kernel driver for the device or in the
> firmware for the device, and should be fixed there, but it's the sort
> of bug that iommu/vt-d could be handling better than it currently does,
> and there is a fairly simple way to achieve that.
> 
> This patch changes the dmar_fault IRQ handler to be a threaded IRQ
> handler.  This is a pretty minimal code change, and comes with the
> advantage that Intel IOMMU I/O page fault handling work is now subject
> to RT throttling, which allows it to be kept under control using the
> sched_rt_period_us / sched_rt_runtime_us parameters.

Thanks for the patch! I like it, but also have some concerns.

If you look at the commit history, you will find that the opposite
change took place 10+ years ago.

commit 477694e71113fd0694b6bb0bcc2d006b8ac62691
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Tue Jul 19 16:25:42 2011 +0200

     x86, iommu: Mark DMAR IRQ as non-threaded

     Mark this lowlevel IRQ handler as non-threaded. This prevents a boot
     crash when "threadirqs" is on the kernel commandline. Also the
     interrupt handler is handling hardware critical events which should
     not be delayed into a thread.

     Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
     Cc: stable@kernel.org
     Signed-off-by: Ingo Molnar <mingo@kernel.org>

I am not sure whether the "boot crash" mentioned above is due to that
"trying to setup a threaded IRQ handler before kthreadd is started".

> 
> iommu/amd already uses a threaded IRQ handler for its I/O page fault
> reporting, and so it already has this advantage.
> 
> When IRQ remapping is enabled, iommu/vt-d will try to set up its
> dmar_fault IRQ handler from start_kernel() -> x86_late_time_init()
> -> apic_intr_mode_init() -> apic_bsp_setup() ->
> irq_remap_enable_fault_handling() -> enable_drhd_fault_handling(),
> which happens before kthreadd is started, and trying to set up a
> threaded IRQ handler this early on will oops.  However, there
> doesn't seem to be a reason why iommu/vt-d needs to set up its fault
> reporting IRQ handler this early, and if we remove the IRQ setup code
> from enable_drhd_fault_handling(), the IRQ will be registered instead
> from pci_iommu_init() -> intel_iommu_init() -> init_dmars(), which
> seems to work just fine.

At present, we cannot do so. Because the VT-d interrupt remapping and
DMA remapping can be independently enabled. In another words, it's a
possible case where interrupt remapping is enabled while DMA remapping
is not.

> 
> Suggested-by: Scarlett Gourley <scarlett@arista.com>
> Suggested-by: James Sewart <jamessewart@arista.com>
> Suggested-by: Jack O'Sullivan <jack@arista.com>
> Signed-off-by: Lennert Buytenhek <buytenh@arista.com>
> ---
>   drivers/iommu/intel/dmar.c | 27 ++-------------------------
>   1 file changed, 2 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index 5a8f780e7ffd..d0871fe9d04d 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -2043,7 +2043,8 @@ int dmar_set_interrupt(struct intel_iommu *iommu)
>   		return -EINVAL;
>   	}
>   
> -	ret = request_irq(irq, dmar_fault, IRQF_NO_THREAD, iommu->name, iommu);
> +	ret = request_threaded_irq(irq, NULL, dmar_fault, IRQF_ONESHOT,
> +				   iommu->name, iommu);
>   	if (ret)
>   		pr_err("Can't request irq\n");
>   	return ret;
> @@ -2051,30 +2052,6 @@ int dmar_set_interrupt(struct intel_iommu *iommu)
>   
>   int __init enable_drhd_fault_handling(void)
>   {
> -	struct dmar_drhd_unit *drhd;
> -	struct intel_iommu *iommu;
> -
> -	/*
> -	 * Enable fault control interrupt.
> -	 */
> -	for_each_iommu(iommu, drhd) {
> -		u32 fault_status;
> -		int ret = dmar_set_interrupt(iommu);
> -
> -		if (ret) {
> -			pr_err("DRHD %Lx: failed to enable fault, interrupt, ret %d\n",
> -			       (unsigned long long)drhd->reg_base_addr, ret);
> -			return -1;
> -		}
> -
> -		/*
> -		 * Clear any previous faults.
> -		 */
> -		dmar_fault(iommu->irq, iommu);
> -		fault_status = readl(iommu->reg + DMAR_FSTS_REG);
> -		writel(fault_status, iommu->reg + DMAR_FSTS_REG);
> -	}
> -
>   	return 0;
>   }
>   

Best regards,
baolu
