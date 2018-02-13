From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 1/1] iommu/io-pgtable: use size_t return type for all
 foo_unmap
Date: Tue, 13 Feb 2018 19:33:30 +0100
Message-ID: <20180213183330.6su6gc3uctpvaa2e@8bytes.org>
References: <1517853559-5869-1-git-send-email-vivek.gautam@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1517853559-5869-1-git-send-email-vivek.gautam@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: will.deacon@arm.com, robin.murphy@arm.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Feb 05, 2018 at 11:29:19PM +0530, Vivek Gautam wrote:
> Unmap returns a size_t all throughout the IOMMU framework.
> Make io-pgtable match this convention.
> Moreover, there isn't a need to have a signed int return type
> as we return 0 in case of failures.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> ---
>  drivers/iommu/io-pgtable-arm-v7s.c | 21 +++++++++++----------
>  drivers/iommu/io-pgtable-arm.c     | 24 ++++++++++++------------
>  drivers/iommu/io-pgtable.h         |  4 ++--
>  3 files changed, 25 insertions(+), 24 deletions(-)

Applied, thanks.
