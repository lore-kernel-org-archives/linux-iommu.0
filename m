From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/amd: print reason for iommu_map_page failure in
 map_sg
Date: Wed, 30 Jan 2019 17:26:53 +0100
Message-ID: <20190130162653.ji6megm3al3uf6zt@8bytes.org>
References: <20190129005937.32487-1-jsnitsel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190129005937.32487-1-jsnitsel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerry Snitselaar <jsnitsel@redhat.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Jan 28, 2019 at 05:59:37PM -0700, Jerry Snitselaar wrote:
> Since there are multiple possible failures in iommu_map_page
> it would be useful to know which case is being hit when the
> error message is printed in map_sg. While here, fix up checkpatch
> complaint about using function name in a string instead of
> __func__.
> 
> Cc: Joerg Roedel <joro@8bytes.org>
> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>

Applied, thanks.
