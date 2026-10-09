Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3763F39F1
	for <iommu@lists.linux.dev>; Fri,  9 Oct 2026 09:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=58.251.27.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791536640; cv=none; b=mh6QxybGg4Ul65jYfqyQuwcFnj4fphdyg/xlgZGP+vSR3C3PcyU7fPYCwmWDAedK3yMtLHy/Azmn2hccCp/eUt4RMS3F3mDRzNO1+PzD4oHslqPKnb8wTC3vlBZ9krpf6MEOEzL0eS3caQ133z/OmBA01/+8okF+OfV+h8FxUrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791536640; c=relaxed/simple;
	bh=bDasQCtCqawYHR5WmsBVPRY4Zck+TCPL4qbLxeKp9QI=;
	h=Message-Id:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=dnrZN0BA0T3j/Z1g3D1/l2KuD0uaa/QquNZs0yPyoJ+PHiKG5+k93NfF1VF3D6RsirV2qD4KUtsIO+u3vNrXjLOruMthwE/tyHWlnwwq8lglCoMK3w5MYevnXt6+RLGZBhb3RImp6ScAPrpUJO/ggDtw8QIysWWze7V+9XjRxoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn; spf=pass smtp.mailfrom=sanechips.com.cn; arc=none smtp.client-ip=58.251.27.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sanechips.com.cn
Received: from mxde.zte.com.cn (unknown [10.35.20.121])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4j1LJV1sZWzYCP
	for <iommu@lists.linux.dev>; Fri, 09 Oct 2026 16:54:18 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxde.zte.com.cn (FangMail) with ESMTPS id 4j1LJJ1KSvzBQkJq
	for <iommu@lists.linux.dev>; Fri, 09 Oct 2026 16:54:08 +0800 (CST)
Received: from mse-db.zte.com.cn (unknown [10.5.228.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4j1LJ540MDz8Xrr9;
	Fri, 09 Oct 2026 16:53:57 +0800 (CST)
Received: (from root@localhost)
	by mse-db.zte.com.cn id 6998rsRH081065;
	Fri, 9 Oct 2026 16:53:54 +0800 (+08)
	(envelope-from gong.shuai@sanechips.com.cn)
Message-Id: <202610090853.6998rsRH081065@mse-db.zte.com.cn>
Received: from szxlzmapp02.zte.com.cn ([10.5.231.79])
	by mse-fl2.zte.com.cn with SMTP id 6998oxoV057114;
	Fri, 9 Oct 2026 16:50:59 +0800 (+08)
	(envelope-from gong.shuai@sanechips.com.cn)
Received: from localhost.localdomain (unknown [10.230.214.35])
	by smtp (Zmail) with SMTP;
	Fri, 9 Oct 2026 16:51:02 +0800
X-Zmail-TransId: 3e816ac8aacf022-c0e61
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: gong.shuai@sanechips.com.cn
From: Gong Shuai <gong.shuai@sanechips.com.cn>
To: fangyu.yu@linux.alibaba.com
Cc: alex@ghiti.fr, andrew.jones@oss.qualcomm.com, aou@eecs.berkeley.edu,
        guoren@kernel.org, iommu@lists.linux.dev, jgg@nvidia.com, jgg@ziepe.ca,
        joro@8bytes.org, jroedel@suse.de, kvm-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, pjw@kernel.org, robin.murphy@arm.com,
        tomasz.jeznach@linux.dev, will@kernel.org, zong.li@sifive.com,
        gong.shuai@sanechips.com.cn, gsh517025@gmail.com
Subject: Re: [RFC PATCH 1/3] iommu/riscv: Add guest IMSIC GPA mapping helpers
Date: Fri,  9 Oct 2026 16:50:23 +0800
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261008140001.94508-2-fangyu.yu@linux.alibaba.com>
References: <20261008140001.94508-2-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
Content-Transfer-Encoding: 8bit
X-MAIL:mse-db.zte.com.cn 6998rsRH081065
X-MSS: AUDITRELEASE@mse-db.zte.com.cn
X-TLS: YES
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SOURCE-IP: 10.35.20.121 unknown Fri, 09 Oct 2026 16:54:18 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AC8ABB8.000/4j1LJV1sZWzYCP

Hi Fangyu,

> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> 
> IOMMU implementations without the MSI_FLAT capability translate MSI
> writes through the second-stage page table, so IRQ forwarding on them
> will need guest IMSIC pages mapped into the second-stage domain.
> 
> Add an xarray to the MSI table that tracks the HPA installed for each
> mapped guest IMSIC GPA, and two helpers for use with the MSI table lock
> held: riscv_iommu_msi_table_map_gpa() installs the initial 4 KiB
> mapping, and riscv_iommu_msi_table_replace_gpa_leaf() atomically swaps
> the leaf PTE's PFN when a vCPU's VS-file host page moves, rejecting
> leaves that do not map the expected old HPA.
> 
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> ---
>  drivers/iommu/riscv/iommu.c | 94 +++++++++++++++++++++++++++++++++++++
>  drivers/iommu/riscv/iommu.h | 12 +++++
>  2 files changed, 106 insertions(+)
> 
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index e2e77469ea3c..48fc57d6409c 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -24,6 +24,7 @@
>  #include <linux/moduleparam.h>
>  #include <linux/mutex.h>
>  #include <linux/pci.h>
> +#include <linux/pgtable.h>
>  #include <linux/generic_pt/iommu.h>
>  
>  #include "../dma-iommu.h"
> @@ -1217,6 +1218,92 @@ void riscv_iommu_msi_table_inval_all(struct riscv_iommu_msi_table *msi_table)
>  	riscv_iommu_iotlb_inval(domain, &gather);
>  }
>  
> +int riscv_iommu_msi_table_map_gpa(struct riscv_iommu_msi_table *msi_table,
> +				  dma_addr_t gpa, phys_addr_t hpa)
> +{
> +	struct riscv_iommu_domain *domain =
> +		container_of(msi_table, struct riscv_iommu_domain, msi_table);
> +	const int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
> +
> +	/* Guest IMSIC GPA mapping only exists in second-stage translations. */
> +	if (!domain->gscid)
> +		return -EOPNOTSUPP;
> +
> +	return iommu_map(&domain->domain, gpa, hpa, IMSIC_MMIO_PAGE_SZ, prot,
> +			 GFP_ATOMIC);
> +}
> +
> +int riscv_iommu_msi_table_replace_gpa_leaf(struct riscv_iommu_msi_table *msi_table,
> +					   dma_addr_t gpa, phys_addr_t old_hpa,
> +					   phys_addr_t new_hpa)


This might fit better inside generic_pt rather than in the driver,
since it walks the page tables on its own and duplicates things
the library already owns, like the per-level index widths, the
x4 root size, and the PTE layout.

I recently tried something very similar, and doing this inside
generic_pt turned out to be quite feasible (only a quick experiment,
not cleaned up for posting).

Thanks,
Shuai


> +{
> +	struct riscv_iommu_domain *domain =
> +		container_of(msi_table, struct riscv_iommu_domain, msi_table);
> +	struct pt_iommu_riscv_64_hw_info pt_info;
> +	u64 *root, *table, *ptep;
> +	u64 old, new;
> +	int top_level, level;
> +
> +	if (!IS_ALIGNED(gpa | old_hpa | new_hpa, PAGE_SIZE))
> +		return -EINVAL;
> +	if (!domain->gscid)
> +		return -EOPNOTSUPP;
> +
> +	pt_iommu_riscv_64_hw_info(&domain->riscvpt, &pt_info);
> +	switch (pt_info.iohgatp_mode) {
> +	case RISCV_IOMMU_DC_IOHGATP_MODE_SV39X4:
> +		top_level = 2;
> +		break;
> +	case RISCV_IOMMU_DC_IOHGATP_MODE_SV48X4:
> +		top_level = 3;
> +		break;
> +	case RISCV_IOMMU_DC_IOHGATP_MODE_SV57X4:
> +		top_level = 4;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	root = phys_to_virt(pt_info.ppn << PAGE_SHIFT);
> +	for (;;) {
> +		table = root;
> +		for (level = top_level; level >= 0; level--) {
> +			unsigned int shift = PAGE_SHIFT + level * 9;
> +			unsigned int index = gpa >> shift;
> +
> +			if (level == top_level)
> +				index &= GENMASK(10, 0);
> +			else
> +				index &= GENMASK(8, 0);
> +			ptep = &table[index];
> +			old = READ_ONCE(*ptep);
> +
> +			if (level) {
> +				/* A valid non-leaf PTE has R/W/X clear. */
> +				if ((old & (_PAGE_PRESENT | _PAGE_LEAF)) !=
> +				    _PAGE_PRESENT)
> +					return -EADDRINUSE;
> +				table = phys_to_virt(FIELD_GET(_PAGE_PFN_MASK,
> +							       old) << PAGE_SHIFT);
> +				continue;
> +			}
> +
> +			/* Replace only the L0 leaf previously installed for this GPA. */
> +			if (!(old & _PAGE_PRESENT) || !(old & _PAGE_LEAF) ||
> +			    FIELD_GET(_PAGE_PFN_MASK, old) !=
> +			    old_hpa >> PAGE_SHIFT)
> +				return -EADDRINUSE;
> +
> +			new = (old & ~_PAGE_PFN_MASK) |
> +			      FIELD_PREP(_PAGE_PFN_MASK,
> +					 new_hpa >> PAGE_SHIFT);
> +			if (cmpxchg64(ptep, old, new) == old)
> +				return 0;
> +			break;
> +		}
> +	}
> +}
> +
>  #define RISCV_IOMMU_FSC_BARE 0
>  /*
>   * This function sends IOTINVAL commands as required by the RISC-V
> @@ -1425,6 +1512,8 @@ static void riscv_iommu_iotlb_sync(struct iommu_domain *iommu_domain,
>  static void riscv_iommu_free_paging_domain(struct iommu_domain *iommu_domain)
>  {
>  	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
> +	struct riscv_iommu_noflat_imsic *imsic;
> +	unsigned long index;
>  
>  	WARN_ON(!list_empty(&domain->bonds));
>  
> @@ -1435,6 +1524,10 @@ static void riscv_iommu_free_paging_domain(struct iommu_domain *iommu_domain)
>  	if (domain->gscid > 0)
>  		ida_free(&riscv_iommu_gscids, domain->gscid);
>  
> +	xa_for_each(&domain->msi_table.noflat_imsics, index, imsic)
> +		kfree(imsic);
> +	xa_destroy(&domain->msi_table.noflat_imsics);
> +
>  	pt_iommu_deinit(&domain->riscvpt.iommu);
>  	iommu_free_pages(domain->msi_table.root);
>  	kfree(domain);
> @@ -1676,6 +1769,7 @@ riscv_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
>  	INIT_LIST_HEAD_RCU(&domain->bonds);
>  	raw_spin_lock_init(&domain->lock);
>  	raw_spin_lock_init(&domain->msi_table.lock);
> +	xa_init(&domain->msi_table.noflat_imsics);
>  	mutex_init(&domain->mutex);
>  	iommu = dev_to_iommu(dev);
>  	cfg.common.hw_max_oasz_lg2 = 56;
> diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
> index 9852962e245b..53a368fbbdf2 100644
> --- a/drivers/iommu/riscv/iommu.h
> +++ b/drivers/iommu/riscv/iommu.h
> @@ -18,6 +18,7 @@
>  #include <linux/irqdomain.h>
>  #include <linux/rcupdate.h>
>  #include <linux/sizes.h>
> +#include <linux/xarray.h>
>  
>  #include "iommu-bits.h"
>  
> @@ -74,6 +75,11 @@ struct riscv_iommu_device {
>  	struct irq_domain *irqdomain;
>  };
>  
> +/* Tracks a guest IMSIC GPA mapped into an S2 domain on IOMMUs without MSI_FLAT. */
> +struct riscv_iommu_noflat_imsic {
> +	phys_addr_t hpa;
> +};
> +
>  struct riscv_iommu_msi_table {
>  	/* Protects attachment, interrupt forwarding state, and MSI PTE updates. */
>  	raw_spinlock_t lock;
> @@ -84,6 +90,7 @@ struct riscv_iommu_msi_table {
>  	u64 msi_addr_pattern;
>  	const void *owner;
>  	u64 required_caps; /* RISCV_IOMMU_CAPABILITIES_* required by active MSI PTEs */
> +	struct xarray noflat_imsics;
>  };
>  
>  /* Private IOMMU data for managed devices, dev_iommu_priv_* */
> @@ -109,6 +116,11 @@ bool riscv_iommu_msi_table_check_caps(struct riscv_iommu_msi_table *msi_table, u
>  void riscv_iommu_msi_table_inval(struct riscv_iommu_msi_table *msi_table, unsigned long addr);
>  void riscv_iommu_msi_table_inval_all(struct riscv_iommu_msi_table *msi_table);
>  void riscv_iommu_msi_table_update(struct riscv_iommu_msi_table *msi_table, bool activate);
> +int riscv_iommu_msi_table_map_gpa(struct riscv_iommu_msi_table *msi_table,
> +				  dma_addr_t gpa, phys_addr_t hpa);
> +int riscv_iommu_msi_table_replace_gpa_leaf(struct riscv_iommu_msi_table *msi_table,
> +					   dma_addr_t gpa, phys_addr_t old_hpa,
> +					   phys_addr_t new_hpa);
>  
>  #ifdef CONFIG_RISCV_IMSIC
>  void riscv_iommu_ir_irq_domain_remove(struct riscv_iommu_device *iommu);
> -- 
> 2.50.1
