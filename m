From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 1/1] iommu/amd: make sure TLB to be flushed before IOVA
 freed
Date: Fri, 6 Jul 2018 13:21:54 +0200
Message-ID: <20180706112154.hslaptjtlsj5whgy@8bytes.org>
References: <1528251526-11408-1-git-send-email-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1528251526-11408-1-git-send-email-thunder.leizhen@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhen Lei <thunder.leizhen@huawei.com>
Cc: iommu <iommu@lists.linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, Robin Murphy <robin.murphy@arm.com>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jun 06, 2018 at 10:18:46AM +0800, Zhen Lei wrote:
> Although the mapping has already been removed in the page table, it maybe
> still exist in TLB. Suppose the freed IOVAs is reused by others before the
> flush operation completed, the new user can not correctly access to its
> meomory.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/iommu/amd_iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
