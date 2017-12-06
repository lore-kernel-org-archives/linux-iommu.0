From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v3 3/6] iommu/vt-d: Add Intel IOMMU debugfs to show
 extended context internals
Date: Wed, 6 Dec 2017 16:17:55 +0800
Message-ID: <5A27A7B3.1080108@linux.intel.com>
References: <1512531807-24268-1-git-send-email-sohil.mehta@intel.com>
 <1512531807-24268-4-git-send-email-sohil.mehta@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1512531807-24268-4-git-send-email-sohil.mehta@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sohil Mehta <sohil.mehta@intel.com>, Joerg Roedel <joro@8bytes.org>, Alex Williamson <alex.williamson@redhat.com>
Cc: Ravi V Shankar <ravi.v.shankar@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, David Woodhouse <dwmw2@infradead.org>, Gayatri Kammela <gayatri.kammela@intel.com>, Andriy Shevchenko <andriy.shevchenko@intel.com>
List-Id: iommu@lists.linux-foundation.org

Hi,

On 12/06/2017 11:43 AM, Sohil Mehta wrote:
> From: Gayatri Kammela <gayatri.kammela@intel.com>
>
> Debugfs extension to dump internals such as extended context table
> entries for each IOMMU to the userspace.
>
> root@OTC-KBLH-01:~# cat
> /sys/kernel/debug/intel_iommu/dmar_translation_struct
>
> IOMMU dmar1: Extended Root Table Addr:4558a1800
> Extended Root tbl entries:
> Bus 0 L: 4558a6001 H: 0
> Lower Context table entries for Bus: 0
> [entry] DID :B :D .F    Low             High
> [16]    0000:00:02.00   4558a5005       102
> Higher Context tbl entries for Bus: 0
> [16]    0000:00:02.00   401b0000c       401400000
>
> IOMMU dmar0: Extended Root Table Addr:4558a2800
> Extended Root tbl entries:
> Bus 0 L: 4016f4001 H: 0
> Lower Context table entries for Bus: 0
> [entry] DID :B :D .F    Low             High
> [80]    0000:00:0a.00   4016f3a05       102
> Higher Context tbl entries for Bus: 0

Do you mind changing "tbl entries" to "table entries" so that
it could be consistent with above lower one?

Best regards,
Lu Baolu

> [80]    0000:00:0a.00   40150000c       671b80000000
>
> Cc: Sohil Mehta <sohil.mehta@intel.com>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Ashok Raj <ashok.raj@intel.com>
> Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
> ---
>
> v3: No change
>
> v2: No change
>
>  drivers/iommu/intel-iommu-debug.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/drivers/iommu/intel-iommu-debug.c b/drivers/iommu/intel-iommu-debug.c
> index 8ae0c4d..8e7f5d2 100644
> --- a/drivers/iommu/intel-iommu-debug.c
> +++ b/drivers/iommu/intel-iommu-debug.c
> @@ -46,6 +46,38 @@ static const struct file_operations __name ## _fops =			\
>  	.owner		= THIS_MODULE,					\
>  }
>  
> +#ifdef CONFIG_INTEL_IOMMU_SVM
> +static void ext_ctx_tbl_entry_show(struct seq_file *m, void *unused,
> +				   struct intel_iommu *iommu, int bus, int ctx,
> +				   struct context_entry *context, bool new_ext)
> +{
> +	u64 ctx_lo;
> +
> +	if (new_ext) {
> +		seq_printf(m, "Higher Context tbl entries for Bus: %d\n", bus);
> +		ctx_lo = context[0].lo;
> +
> +		if (!(ctx_lo & CONTEXT_PASIDE)) {
> +			context[1].hi = (u64)virt_to_phys(
> +					iommu->pasid_state_table);
> +			context[1].lo = (u64)virt_to_phys(iommu->pasid_table) |
> +					intel_iommu_get_pts(iommu);
> +		}
> +
> +		seq_printf(m, "[%d]\t%04x:%02x:%02x.%02x\t%llx\t%llx\n", ctx,
> +			   iommu->segment, bus, PCI_SLOT(ctx), PCI_FUNC(ctx),
> +			   context[1].lo, context[1].hi);
> +	}
> +}
> +#else /* CONFIG_INTEL_IOMMU_SVM */
> +static void ext_ctx_tbl_entry_show(struct seq_file *m, void *unused,
> +				   struct intel_iommu *iommu, int bus, int ctx,
> +				   struct context_entry *context, bool new_ext)
> +{
> +	return;
> +}
> +#endif /* CONFIG_INTEL_IOMMU_SVM */
> +
>  static void ctx_tbl_entry_show(struct seq_file *m, void *unused,
>  			       struct intel_iommu *iommu, int bus, bool ext,
>  			       bool new_ext)
> @@ -69,6 +101,9 @@ static void ctx_tbl_entry_show(struct seq_file *m, void *unused,
>  			seq_printf(m, "[%d]\t%04x:%02x:%02x.%02x\t%llx\t%llx\n",
>  				   ctx, iommu->segment, bus, PCI_SLOT(ctx),
>  				   PCI_FUNC(ctx), context[0].lo, context[0].hi);
> +
> +			ext_ctx_tbl_entry_show(m, unused, iommu, bus, ctx,
> +					       context, new_ext);
>  		}
>  	}
>  out:
