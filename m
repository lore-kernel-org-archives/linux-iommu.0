From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] iommu/arm-smmu: wire up map_sg for arm-smmu-v3
Date: Mon, 13 Jun 2016 11:01:44 +0200
Message-ID: <20160613090144.GB29948@suse.de>
References: <1464951030-14044-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1464951030-14044-1-git-send-email-will.deacon@arm.com>
Sender: stable-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, stable@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Jun 03, 2016 at 11:50:30AM +0100, Will Deacon wrote:
> From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> 
> The map_sg callback is missing from arm_smmu_ops, but is required by
> iommu.h. Similarly to most other IOMMU drivers, connect it to
> default_iommu_map_sg.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
> 
> Joerg -- this is the only fix I have queued, so could you pick it up
> directly, please?

Queued, thanks Will.
