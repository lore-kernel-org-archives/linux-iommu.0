From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 7/9] iommu/of: Use helper functions to access
 dev->iommu_fwspec
Date: Thu, 6 Dec 2018 15:16:07 +0100
Message-ID: <20181206141606.GF16835@8bytes.org>
References: <20181204163002.15800-1-joro@8bytes.org>
 <20181204163002.15800-8-joro@8bytes.org>
 <b78ab1d9-1f24-f792-04dd-26958a0739d3@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b78ab1d9-1f24-f792-04dd-26958a0739d3@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Dec 05, 2018 at 05:41:51PM +0000, Robin Murphy wrote:
> Nit: I think it makes sense to put this inside the "if (!err)" condition
> below rather than out here where it may or may not be relevant. The comment
> for that case is already supposed to imply that it's dealing with a fresh
> fwspec.

Right, updated that too.

Thanks,

	Joerg
