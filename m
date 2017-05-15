From: Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
Subject: Re: [RFC PATCH 07/30] iommu/arm-smmu-v3: Add second level of context
	descriptor table
Date: Mon, 15 May 2017 14:47:25 +0200
Message-ID: <ef690c27-95cc-c15d-7e70-7e89de7bc08a@semihalf.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
	<20170227195441.5170-8-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170227195441.5170-8-jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Cc: Shanker Donthineni <shankerd-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Sinan Kaya <okaya-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Harv Abdulhamid <harba-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Nate Watterson <nwatters-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Jean,

On 27.02.2017 20:54, Jean-Philippe Brucker wrote:
> @@ -1213,17 +1356,59 @@ static void arm_smmu_free_cd_tables(struct arm_smmu_master_data *master)
>  __maybe_unused
>  static int arm_smmu_alloc_cd(struct arm_smmu_master_data *master)
>  {
> +	int ssid;
> +	int i, ret;
>  	struct arm_smmu_cd_cfg *cfg = &master->ste.cd_cfg;
>
> -	return arm_smmu_bitmap_alloc(cfg->context_map, ilog2(cfg->num_entries));
> +	if (cfg->linear)
> +		return arm_smmu_bitmap_alloc(cfg->table.context_map,
> +					     ilog2(cfg->num_entries));
> +
> +	/* Find first leaf table with an empty slot, or allocate a new leaf */
> +	for (i = cfg->l1.cur_table; i < cfg->num_entries; i++) {
> +		struct arm_smmu_cd_table *table = &cfg->l1.tables[i];
> +
> +		if (!table->cdptr) {
> +			__le64 *l1ptr = cfg->l1.ptr + i * CTXDESC_L1_DESC_DWORD;
> +
> +			ret = arm_smmu_alloc_cd_leaf_table(master->smmu, table,
> +							   CTXDESC_NUM_L2_ENTRIES);
> +			if (ret)
> +				return ret;
> +
> +			arm_smmu_write_cd_l1_desc(l1ptr, table);
> +			arm_smmu_sync_cd(master, i << CTXDESC_SPLIT, false);
> +		}
> +
> +		ssid = arm_smmu_bitmap_alloc(table->context_map, CTXDESC_SPLIT);
> +		if (ssid < 0)
> +			continue;
> +
> +		cfg->l1.cur_table = i;
> +		return i << CTXDESC_SPLIT | ssid;
> +	}
> +
> +	return -ENOSPC;
>  }
>
>  __maybe_unused
>  static void arm_smmu_free_cd(struct arm_smmu_master_data *master, u32 ssid)
>  {
> +	unsigned long l1_idx, idx;
>  	struct arm_smmu_cd_cfg *cfg = &master->ste.cd_cfg;
>
> -	arm_smmu_bitmap_free(cfg->context_map, ssid);
> +	if (cfg->linear) {
> +		arm_smmu_bitmap_free(cfg->table.context_map, ssid);
> +		return;
> +	}
> +
> +	l1_idx = ssid >> CTXDESC_SPLIT;
> +	idx = ssid & ((1 << CTXDESC_SPLIT) - 1);
> +	arm_smmu_bitmap_free(cfg->l1.tables[l1_idx].context_map, idx);
> +
> +	/* Prepare next allocation */
> +	if (cfg->l1.cur_table > idx)
> +		cfg->l1.cur_table = idx;
>  }

I am not sure what is the logic here. idx becomes index of l1.tables in 
arm_smmu_alloc_cd() which in turn may be out of allocated memory. I may 
miss something. Can you please elaborate on this?

Thanks,
Tomasz
