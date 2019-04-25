From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v2 02/19] iommu: introduce device fault data
Date: Thu, 25 Apr 2019 13:46:43 +0100
Message-ID: <f444a689-4941-524e-1d4b-c090390d5b5d@arm.com>
References: <1556062279-64135-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1556062279-64135-3-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556062279-64135-3-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Eric Auger <eric.auger@redhat.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Christoph Hellwig <hch@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Andriy Shevchenko <andriy.shevchenko@linux.intel.com>, Yi L <yi.l.liu@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

On 24/04/2019 00:31, Jacob Pan wrote:
> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> new file mode 100644
> index 0000000..edcc0dd
> --- /dev/null
> +++ b/include/uapi/linux/iommu.h
> @@ -0,0 +1,115 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * IOMMU user API definitions
> + */
> +
> +#ifndef _UAPI_IOMMU_H
> +#define _UAPI_IOMMU_H
> +
> +#include <linux/types.h>
> +
> +#define IOMMU_FAULT_PERM_WRITE	(1 << 0) /* write */
> +#define IOMMU_FAULT_PERM_EXEC	(1 << 1) /* exec */
> +#define IOMMU_FAULT_PERM_PRIV	(1 << 2) /* privileged */

Could we add IOMMU_FAULT_PERM_READ back? The PRI Page Request has both R
and W fields, and R=W=0 encodes the PASID Stop Markers. Even though the
IOMMU drivers currently filter out the Stop Markers, we may want to
inject them into guests at some point in the future, which wouldn't be
possible with the current API. We could add a
IOMMU_FAULT_PAGE_REQUEST_PERM_VALID bit instead, but I still find it
weird to denote the validity of a bitfield using a separate bit.

Given that three different series now rely on this, how about we send
the fault patches separately for v5.2? I pushed the recoverable fault
support applied on top of this, with the PERM_READ bit and cleaned up
kernel doc, to git://linux-arm.org/linux-jpb.git sva/api

Thanks,
Jean
