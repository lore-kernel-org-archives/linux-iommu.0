From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/2] IOMMU/AMD: Adding IOMMU PC resource management
Date: Tue, 14 May 2013 09:09:24 +0200
Message-ID: <20130514070924.GA15942@dyad.programming.kicks-ass.net>
References: <1368481424-5626-1-git-send-email-steven.kinney@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1368481424-5626-1-git-send-email-steven.kinney@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: steven.kinney@amd.com
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, iommu@lists.linux-foundation.org, joro@8bytes.org, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
List-Id: iommu@lists.linux-foundation.org

On Mon, May 13, 2013 at 04:43:44PM -0500, steven.kinney@amd.com wrote:
> +static void init_iommu_perf_ctr(struct amd_iommu *iommu)
> +{
> +	u32 val = 0xabcd, val2 = 0;
> +
> +	if (!iommu_feature(iommu, FEATURE_PC))
> +		return;
> +
> +	amd_iommu_pc_present = true;
> +
> +	/* Check if the performance counters can be written to */
> +	if ((0 != amd_iommu_pc_get_set_reg_val(0, 0, 0, 0, &val, true)) ||
> +	    (0 != amd_iommu_pc_get_set_reg_val(0, 0, 0, 0, &val2, false)) ||
> +	    (val != val2)) {
> +		pr_err("AMD-Vi: Unable to write to IOMMU perf counter.\n");

Would it make sense to clear amd_iommu_pc_present here?

> +		return;
> +	}
> +
> +	pr_info("AMD-Vi: IOMMU performance counters " "supported\n");
> +
> +	val = readl(iommu->mmio_base + MMIO_CNTR_CONF_OFFSET);
> +	iommu->max_banks = (u8) ((val >> 12) & 0x3f);
> +	iommu->max_counters = (u8) ((val >> 7) & 0xf);
> +}
