Return-Path: <SRS0=MPmd=TK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2252C04AB1
	for <iommu@archiver.kernel.org>; Fri, 10 May 2019 03:01:50 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCA6D2182B
	for <iommu@archiver.kernel.org>; Fri, 10 May 2019 03:01:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCA6D2182B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 921DCC5D;
	Fri, 10 May 2019 03:01:50 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 73EE3C3E
	for <iommu@lists.linux-foundation.org>;
	Fri, 10 May 2019 03:01:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 8CCD8709
	for <iommu@lists.linux-foundation.org>;
	Fri, 10 May 2019 03:01:48 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
	by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	09 May 2019 20:01:47 -0700
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
	([10.239.159.136])
	by fmsmga008.fm.intel.com with ESMTP; 09 May 2019 20:01:45 -0700
Subject: Re: [PATCH 3/3] iommu/vt-d: Add debugfs support to show scalable mode
	DMAR table internals
To: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
	iommu@lists.linux-foundation.org
References: <cover.1556762845.git.sai.praneeth.prakhya@intel.com>
	<79a765a7c29a9effb553360004b9b7d829096314.1556762845.git.sai.praneeth.prakhya@intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <644e72f7-b450-b30b-b1eb-b697c1cca1cf@linux.intel.com>
Date: Fri, 10 May 2019 10:55:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <79a765a7c29a9effb553360004b9b7d829096314.1556762845.git.sai.praneeth.prakhya@intel.com>
Content-Language: en-US
Cc: Ashok Raj <ashok.raj@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Development issues for Linux IOMMU support
	<iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi,

On 5/10/19 2:42 AM, Sai Praneeth Prakhya wrote:
> From: Sai Praneeth <sai.praneeth.prakhya@intel.com>
> 
> A DMAR table walk would typically follow the below process.
> 1. Bus number is used to index into root table which points to a context
>     table.
> 2. Device number and Function number are used together to index into
>     context table which then points to a pasid directory.
> 3. PASID[19:6] is used to index into PASID directory which points to a
>     PASID table.
> 4. PASID[5:0] is used to index into PASID table which points to all levels
>     of page tables.
> 
> Whenever a user opens the file
> "/sys/kernel/debug/iommu/intel/dmar_translation_struct", the above
> described DMAR table walk is performed and the contents of the table are
> dumped into the file. The dump could be handy while dealing with devices
> that use PASID.
> 
> Example of such dump:
> cat /sys/kernel/debug/iommu/intel/dmar_translation_struct
> 
> (Please note that because of 80 char limit, entries that should have been
> in the same line are broken into different lines)
> 
> IOMMU dmar0: Root Table Address: 0x436f7c000
> B.D.F	Root_entry				Context_entry
> PASID	PASID_table_entry
> 00:0a.0	0x0000000000000000:0x000000044dd3f001	0x0000000000100000:0x0000000435460e1d
> 0	0x000000044d6e1089:0x0000000000000003:0x0000000000000001
> 00:0a.0	0x0000000000000000:0x000000044dd3f001	0x0000000000100000:0x0000000435460e1d
> 1	0x0000000000000049:0x0000000000000001:0x0000000003c0e001
> 
> Note that the above format is followed even for legacy DMAR table dump
> which doesn't support PASID and hence in such cases PASID is defaulted to
> -1 indicating that PASID and it's related fields are invalid.
> 
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Cc: Sohil Mehta <sohil.mehta@intel.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
> ---
>   drivers/iommu/intel-iommu-debugfs.c | 75 +++++++++++++++++++++++++++++++++++--
>   1 file changed, 71 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu-debugfs.c b/drivers/iommu/intel-iommu-debugfs.c
> index 3f5399b5e6c0..8982e93a50d7 100644
> --- a/drivers/iommu/intel-iommu-debugfs.c
> +++ b/drivers/iommu/intel-iommu-debugfs.c
> @@ -14,11 +14,15 @@
>   
>   #include <asm/irq_remapping.h>
>   
> +#include "intel-pasid.h"
> +
>   struct tbl_walk {
>   	u16 bus;
>   	u16 devfn;
> +	u32 pasid;
>   	struct root_entry *rt_entry;
>   	struct context_entry *ctx_entry;
> +	struct pasid_entry *pasid_tbl_entry;
>   };
>   
>   struct iommu_regset {
> @@ -142,21 +146,77 @@ static inline void print_tbl_walk(struct seq_file *m)
>   {
>   	struct tbl_walk *tbl_wlk = m->private;
>   
> -	seq_printf(m, "%02x:%02x.%x\t0x%016llx:0x%016llx\t0x%016llx:0x%016llx\n",
> +	seq_printf(m, "%02x:%02x.%x\t0x%016llx:0x%016llx\t0x%016llx:0x%016llx\t",
>   		   tbl_wlk->bus, PCI_SLOT(tbl_wlk->devfn),
>   		   PCI_FUNC(tbl_wlk->devfn), tbl_wlk->rt_entry->hi,
>   		   tbl_wlk->rt_entry->lo, tbl_wlk->ctx_entry->hi,
>   		   tbl_wlk->ctx_entry->lo);
> +
> +	/*
> +	 * A legacy mode DMAR doesn't support PASID, hence default it to -1
> +	 * indicating that it's invalid. Also, default all PASID related fields
> +	 * to 0.
> +	 */
> +	if (!tbl_wlk->pasid_tbl_entry)
> +		seq_printf(m, "%-6d\t0x%016llx:0x%016llx:0x%016llx\n", -1,
> +			   (u64)0, (u64)0, (u64)0);
> +	else
> +		seq_printf(m, "%-6d\t0x%016llx:0x%016llx:0x%016llx\n",
> +			   tbl_wlk->pasid, tbl_wlk->pasid_tbl_entry->val[0],
> +			   tbl_wlk->pasid_tbl_entry->val[1],
> +			   tbl_wlk->pasid_tbl_entry->val[2]);
> +}
> +
> +static void pasid_tbl_walk(struct seq_file *m, struct pasid_entry *tbl_entry,
> +			   u16 dir_idx)
> +{
> +	struct tbl_walk *tbl_wlk = m->private;
> +	u8 tbl_idx;
> +
> +	for (tbl_idx = 0; tbl_idx < PASID_TBL_ENTRIES; tbl_idx++) {
> +		if (pasid_pte_is_present(tbl_entry)) {
> +			tbl_wlk->pasid_tbl_entry = tbl_entry;
> +			tbl_wlk->pasid = (dir_idx << PASID_PDE_SHIFT) + tbl_idx;
> +			print_tbl_walk(m);
> +		}
> +
> +		tbl_entry++;
> +	}
> +}
> +
> +static void pasid_dir_walk(struct seq_file *m, u64 pasid_dir_ptr,
> +			   u16 pasid_dir_size)
> +{
> +	struct pasid_dir_entry *dir_entry = phys_to_virt(pasid_dir_ptr);
> +	struct pasid_entry *pasid_tbl;
> +	u16 dir_idx;
> +
> +	for (dir_idx = 0; dir_idx < pasid_dir_size; dir_idx++) {
> +		pasid_tbl = get_pasid_table_from_pde(dir_entry);
> +		if (pasid_tbl)
> +			pasid_tbl_walk(m, pasid_tbl, dir_idx);
> +
> +		dir_entry++;
> +	}
>   }
>   
>   static void ctx_tbl_walk(struct seq_file *m, struct intel_iommu *iommu, u16 bus)
>   {
>   	struct context_entry *context;
> -	u16 devfn;
> +	u16 devfn, pasid_dir_size;
> +	u64 pasid_dir_ptr;
>   
>   	for (devfn = 0; devfn < 256; devfn++) {
>   		struct tbl_walk tbl_wlk = {0};
>   
> +		/*
> +		 * Scalable mode root entry points to upper context table and
> +		 * lower context table. Each scalable mode context table has
> +		 * 128 context entries where as legacy mode context table has
> +		 * 256 context entries. So for scalable mode, devfn > 127 is
> +		 * invalid. But, iommu_context_addr() inherently handles this by

This comment is a bit misleading. :-)

devfn > 127 is also valid for scalable mode. The context entries for
former 128 devices are in the lower scalable-mode context-table,
while the latter 128 devices in upper scalable-mode context-table.
This has been handled in iommu_context_addr(), so the caller don't
need to worry about this.

Other looks good to me.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
Lu Baolu

> +		 * walking upper context table if devfn > 127.
> +		 */
>   		context = iommu_context_addr(iommu, bus, devfn, 0);
>   		if (!context)
>   			return;
> @@ -170,7 +230,14 @@ static void ctx_tbl_walk(struct seq_file *m, struct intel_iommu *iommu, u16 bus)
>   		tbl_wlk.ctx_entry = context;
>   		m->private = &tbl_wlk;
>   
> -		print_tbl_walk(m);
> +		if (!is_pasid_enabled(context)) {
> +			print_tbl_walk(m);
> +			continue;
> +		}
> +
> +		pasid_dir_ptr = context->lo & VTD_PAGE_MASK;
> +		pasid_dir_size = get_pasid_dir_size(context);
> +		pasid_dir_walk(m, pasid_dir_ptr, pasid_dir_size);
>   	}
>   }
>   
> @@ -182,7 +249,7 @@ static void root_tbl_walk(struct seq_file *m, struct intel_iommu *iommu)
>   	spin_lock_irqsave(&iommu->lock, flags);
>   	seq_printf(m, "IOMMU %s: Root Table Address: 0x%llx\n", iommu->name,
>   		   (u64)virt_to_phys(iommu->root_entry));
> -	seq_puts(m, "B.D.F\tRoot_entry\t\t\t\tContext_entry\n");
> +	seq_puts(m, "B.D.F\tRoot_entry\t\t\t\tContext_entry\t\t\t\tPASID\tPASID_table_entry\n");
>   
>   	/*
>   	 * No need to check if the root entry is present or not because
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
