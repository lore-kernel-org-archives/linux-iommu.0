From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v3] iommu/amd: Add support for fast IOTLB flushing
Date: Tue, 13 Feb 2018 14:29:59 +0100
Message-ID: <20180213132959.kkavgzt37hm7n2tt@8bytes.org>
References: <1517374874-93978-1-git-send-email-suravee.suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1517374874-93978-1-git-send-email-suravee.suthikulpanit@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, jroedel@suse.de
List-Id: iommu@lists.linux-foundation.org

Hi Suravee,

thanks for working on this.

On Wed, Jan 31, 2018 at 12:01:14AM -0500, Suravee Suthikulpanit wrote:
> +static void amd_iommu_iotlb_range_add(struct iommu_domain *domain,
> +				      unsigned long iova, size_t size)
> +{
> +	struct amd_iommu_flush_entries *entry, *p;
> +	unsigned long flags;
> +	bool found = false;
> +
> +	spin_lock_irqsave(&amd_iommu_flush_list_lock, flags);

I am not happy with introducing or using global locks when they are not
necessary. Can this be a per-domain lock?

Besides, did you check it makes sense to actually keep track of the
ranges here? My approach would be to just make iotlb_range_add() an noop
and do a full domain flush in iotlb_sync(). But maybe you did
measurements you can share here to show there is a benefit.



	Joerg
