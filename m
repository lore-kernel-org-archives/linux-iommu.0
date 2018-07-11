From: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v4 1/9] iommu/vt-d: Global PASID name space
Date: Wed, 11 Jul 2018 10:48:43 +0800
Message-ID: <20180711024843.GC2359@xz-mi>
References: <1531113778-28238-1-git-send-email-baolu.lu@linux.intel.com>
 <1531113778-28238-2-git-send-email-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1531113778-28238-2-git-send-email-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com, sanjay.k.kumar@intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, yi.y.sun@intel.com, jacob.jun.pan@intel.com
List-Id: iommu@lists.linux-foundation.org

On Mon, Jul 09, 2018 at 01:22:50PM +0800, Lu Baolu wrote:

[...]

> +#ifndef __INTEL_PASID_H
> +#define __INTEL_PASID_H
> +
> +#define PASID_MIN			0x1
> +#define PASID_MAX			0x20000

Could I ask whether there's a reason to explicitly use 0x20000 for the
max value?  Asked since I saw that the example in the spec gave 20
bits for PASID (please refer to spec ver 3.0 section 3.4.3 figure
3-8).  Also I believe that's what I was told by Kevin.

I saw that the old per-iommu max value is set to 0x20000, though I'm
not sure whether that's still needed since if we're going to have
two-level pasid table then AFAIU we don't need physically continuous
memory any more (though I saw that we don't yet have two-level pasid
table implemented):

	/* Eventually I'm promised we will get a multi-level PASID table
	 * and it won't have to be physically contiguous. Until then,
	 * limit the size because 8MiB contiguous allocations can be hard
	 * to come by. The limit of 0x20000, which is 1MiB for each of
	 * the PASID and PASID-state tables, is somewhat arbitrary. */
	if (iommu->pasid_max > 0x20000)
		iommu->pasid_max = 0x20000;

Thanks,

-- 
Peter Xu
