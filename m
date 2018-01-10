From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v6 4/5] iommu/vt-d: Add debugfs support to show Pasid
 table contents
Date: Wed, 10 Jan 2018 15:40:48 +0200
Message-ID: <1515591648.7000.867.camel@linux.intel.com>
References: <1515556102-34150-1-git-send-email-sohil.mehta@intel.com>
         <1515556102-34150-5-git-send-email-sohil.mehta@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1515556102-34150-5-git-send-email-sohil.mehta@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sohil Mehta <sohil.mehta@intel.com>, Joerg Roedel <joro@8bytes.org>, Alex Williamson <alex.williamson@redhat.com>
Cc: Ashok Raj <ashok.raj@intel.com>, David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>, Gayatri Kammela <gayatri.kammela@intel.com>, Ravi V Shankar <ravi.v.shankar@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>, Fenghua Yu <fenghua.yu@intel.com>
List-Id: iommu@lists.linux-foundation.org

On Tue, 2018-01-09 at 19:48 -0800, Sohil Mehta wrote:

> Debugfs extension to dump the internals such as pasid table entries
> for
> each IOMMU to the userspace.
> 
> Example of such dump in Kabylake:
> 
> root@OTC-KBLH-01:~# cat
> /sys/kernel/debug/intel_iommu/dmar_translation_struct
> 
> IOMMU dmar0: Extended Root Table Addr:402b9e800
> Extended Root table entries:
> Bus 0 L: 402150001 H: 0
> Lower Context table entries for Bus: 0
> [entry] DID :B :D .F    Low             High
> [80]    0000:00:0a.00   40214fa05       102
> Higher Context table entries for Bus: 0
> [80]    0000:00:0a.00   40260000c       0
> Pasid Table Addr : ffff8e2d42600000
> Pasid table entries for domain 0:
> [Entry]         Contents
> [0]             12c409801
> 

> +#ifdef CONFIG_INTEL_IOMMU_SVM
> +static void pasid_tbl_entry_show(struct seq_file *m, struct
> intel_iommu *iommu)
> +{
> +	int pasid_size = 0, i;
> +

> +	if (ecap_pasid(iommu->ecap)) {

A nit:
if you use negative condition you can reduce indentation level below.

if (!...)
  return;

pasid_size = ...;
...

> +		pasid_size = intel_iommu_get_pts(iommu);
> +

> +	}
> +}
> +#else /* CONFIG_INTEL_IOMMU_SVM */

> +static void pasid_tbl_entry_show(struct seq_file *m, struct
> intel_iommu *iommu)
> +{
> +}

I think is not a big deal if you put all in one line like
static ... {}

> +#endif /* CONFIG_INTEL_IOMMU_SVM */

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
