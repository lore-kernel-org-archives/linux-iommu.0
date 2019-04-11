From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v3 1/1] iommu: Bind process address spaces to devices
Date: Thu, 11 Apr 2019 17:28:03 +0200
Message-ID: <20190411152803.GB29810@8bytes.org>
References: <20190410151516.47754-1-jean-philippe.brucker@arm.com>
 <20190410151516.47754-2-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190410151516.47754-2-jean-philippe.brucker@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, christian.koenig@amd.com, kevin.tian@intel.com, jacob.jun.pan@linux.intel.com, ashok.raj@intel.com, baolu.lu@linux.intel.com, zhangfei.gao@foxmail.com
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 10, 2019 at 04:15:16PM +0100, Jean-Philippe Brucker wrote:
>  drivers/iommu/iommu.c | 104 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/iommu.h |  70 ++++++++++++++++++++++++++++
>  2 files changed, 174 insertions(+)

Applied to the api-features branch for now, thanks Jean-Philippe!

'for now' because I have a question below.

> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index ed6738c358ca..87fe1cddd817 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -51,10 +51,13 @@ struct device;
>  struct iommu_domain;
>  struct notifier_block;
>  struct iommu_fault_event;
> +struct iommu_sva;

The iommu_fault_event doesn't yet exist in my tree, is this patch based
on something else I need besided Lu Baolus work? I got quite some
conflicts while applying the patch because of this.

> + * @sva_set_ops: Set ops for a SVA handle

I also removed this line.

Regards,

	Joerg
