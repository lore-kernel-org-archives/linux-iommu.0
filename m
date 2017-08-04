From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] iommu/of: Fix of_iommu_configure() for disabled IOMMUs
Date: Fri, 4 Aug 2017 13:57:00 +0100
Message-ID: <ea70f400-d94c-685d-e53a-c9ddee11cd19@arm.com>
References: <3841a5f51df422578abf297a9bc426bbe9ac8e01.1501844911.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3841a5f51df422578abf297a9bc426bbe9ac8e01.1501844911.git.robin.murphy@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org



On 04/08/17 12:16, Robin Murphy wrote:
> Sudeep reports that the logic is slightly broken when a PCI iommu-map
> entry targets an IOMMU marked as disabled in DT, since of_pci_map_rid()
> succeeds in following a phandle, and of_iommu_xlate() doesn't return an
> error value, but we miss checking whether ops was actually non-NULL.
> Whilst this could be solved with a point fix in of_pci_iommu_init(), it
> suggests that all the juggling of ERR_PTR values through the ops pointer
> is proving rather too complicated for its own good, so let's instead
> simplify the whole flow (with a side-effect of eliminating the cause of
> the bug).
> 
> The fact that we now rely on iommu_fwspec means that we no longer need
> to pass around an iommu_ops pointer at all - we can simply propagate a
> regular int return value until we know whether we have a viable IOMMU,
> then retrieve the ops from the fwspec if and when we actually need them.
> This makes everything a bit more uniform and certainly easier to follow.
> 
> Reported-by: Sudeep Holla <sudeep.holla@arm.com>

Tested-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
