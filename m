From: Wan Zongshun <vw@iommu.org>
Subject: Re: [Patch v4 6/9] iommu/amd: Add function copy_dev_tables
Date: Sat, 28 May 2016 21:08:34 +0800
Message-ID: <80e8478c-3797-df49-3bf9-e3c5d6879c8b@iommu.org>
References: <1464157735-8865-1-git-send-email-bhe@redhat.com>
 <1464157735-8865-7-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464157735-8865-7-git-send-email-bhe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Baoquan He <bhe@redhat.com>, joro@8bytes.org
Cc: linux-kernel@vger.kernel.org, vincent.wan@amd.com, iommu@lists.linux-foundation.org, dyoung@redhat.com
List-Id: iommu@lists.linux-foundation.org



-------- Original Message --------
> Add function copy_dev_tables to copy old DTE of the 1st kernel to
> the new DTE table. Since all iommu share the same DTE table the
> copy only need be done once as long as the physical address of
> old DTE table is retrieved from iommu reg. Besides the old domain
> id occupied in 1st kernel need be reserved in order to avoid touch
> the old translation tables.
>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  drivers/iommu/amd_iommu.c       |  2 +-
>  drivers/iommu/amd_iommu_init.c  | 38 ++++++++++++++++++++++++++++++++++++++
>  drivers/iommu/amd_iommu_types.h |  1 +
>  3 files changed, 40 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index 1c916cc..f3bd7fd 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -2081,7 +2081,7 @@ static void set_dte_entry(u16 devid, struct protection_domain *domain, bool ats)
>  		flags    |= tmp;
>  	}
>
> -	flags &= ~(0xffffUL);
> +	flags &= ~DEV_DOMID_MASK;
>  	flags |= domain->id;
>
>  	amd_iommu_dev_table[devid].data[1]  = flags;
> diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
> index 9c1aa54..71c7ac9 100644
> --- a/drivers/iommu/amd_iommu_init.c
> +++ b/drivers/iommu/amd_iommu_init.c
> @@ -664,6 +664,44 @@ static int get_dev_entry_bit(u16 devid, u8 bit)
>  }
>
>
> +static int copy_dev_tables(void)
> +{
> +	u64 entry;
> +	u32 lo, hi, devid;
> +	phys_addr_t old_devtb_phys;
> +	struct dev_table_entry *old_devtb;
> +	u16 dom_id, dte_v;
> +	struct amd_iommu *iommu;
> +	static int copied;
> +
> +        for_each_iommu(iommu) {
> +		if (!translation_pre_enabled()) {
> +			pr_err("IOMMU:%d is not pre-enabled!/n", iommu->index);
> +			return -1;
> +		}

If one iommu is not pre-enabled, all iommus will be exit the copy.

> +
> +		if (copied)
> +			continue;
> +
> +                lo = readl(iommu->mmio_base + MMIO_DEV_TABLE_OFFSET);
> +                hi = readl(iommu->mmio_base + MMIO_DEV_TABLE_OFFSET + 4);
> +                entry = (((u64) hi) << 32) + lo;
> +                old_devtb_phys = entry & PAGE_MASK;
> +                old_devtb = memremap(old_devtb_phys, dev_table_size, MEMREMAP_WB);
> +                for (devid = 0; devid <= amd_iommu_last_bdf; ++devid) {
> +                        amd_iommu_dev_table[devid] = old_devtb[devid];
> +                        dom_id = amd_iommu_dev_table[devid].data[1] & DEV_DOMID_MASK;
> +			dte_v = amd_iommu_dev_table[devid].data[0] & DTE_FLAG_V;
> +			if (!dte_v)
> +				continue;
> +                        __set_bit(dom_id, amd_iommu_pd_alloc_bitmap);
> +                }
> +		memunmap(old_devtb);
> +		copied = 1;
> +        }
> +	return 0;
> +}
> +
>  void amd_iommu_apply_erratum_63(u16 devid)
>  {
>  	int sysmgt;
> diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
> index 7796edf..34acd73 100644
> --- a/drivers/iommu/amd_iommu_types.h
> +++ b/drivers/iommu/amd_iommu_types.h
> @@ -311,6 +311,7 @@
>  #define DTE_FLAG_MASK	(0x3ffULL << 32)
>  #define DTE_GLX_SHIFT	(56)
>  #define DTE_GLX_MASK	(3)
> +#define DEV_DOMID_MASK 	0xffffULL
>
>  #define DTE_GCR3_VAL_A(x)	(((x) >> 12) & 0x00007ULL)
>  #define DTE_GCR3_VAL_B(x)	(((x) >> 15) & 0x0ffffULL)
>
