From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2] iommu: fix amd_iommu=force_isolation
Date: Fri, 7 Dec 2018 14:08:34 +0100
Message-ID: <20181207130834.ggpiaersetqot5t2@8bytes.org>
References: <20181204223716.214159-1-yuzhao@google.com>
 <20181206213915.196205-1-yuzhao@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181206213915.196205-1-yuzhao@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yu Zhao <yuzhao@google.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Dec 06, 2018 at 02:39:15PM -0700, Yu Zhao wrote:
> Fixes: aafd8ba0ca74 ("iommu/amd: Implement add_device and remove_device")
> 
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> ---
>  drivers/iommu/amd_iommu.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Applied, thanks.
