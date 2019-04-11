From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/iova: Separate atomic variables to improve
 performance
Date: Thu, 11 Apr 2019 15:43:12 +0200
Message-ID: <20190411134312.GC4518@8bytes.org>
References: <1554280521-18375-1-git-send-email-zhangshaokun@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1554280521-18375-1-git-send-email-zhangshaokun@hisilicon.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Jinyu Qi <jinyuqi@huawei.com>
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 03, 2019 at 04:35:21PM +0800, Shaokun Zhang wrote:
> From: Jinyu Qi <jinyuqi@huawei.com> 
> 
> In struct iova_domain, there are three atomic variables, the former two
> are about TLB flush counters which use atomic_add operation, anoter is
> used to flush timer that use cmpxhg operation.
> These variables are in the same cache line, so it will cause some
> performance loss under the condition that many cores call queue_iova
> function, Let's isolate the two type atomic variables to different
> cache line to reduce cache line conflict.
> 
> Cc: Joerg Roedel <joro@8bytes.org>
> Signed-off-by: Jinyu Qi <jinyuqi@huawei.com>
> ---
>  include/linux/iova.h | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Applied, thanks.
