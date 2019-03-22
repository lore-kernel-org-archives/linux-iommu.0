From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2] iommu/iova: Fix tracking of recently failed iova
 address
Date: Fri, 22 Mar 2019 10:31:46 +0100
Message-ID: <20190322093146.GA18669@8bytes.org>
References: <20190315155553.11857-1-rrichter@marvell.com>
 <7515342b-f4b2-9406-5249-93ae7880835a@arm.com>
 <20190320185718.jhr6gvs7jdbn4x3p@rric.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190320185718.jhr6gvs7jdbn4x3p@rric.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Richter <rrichter@marvell.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Ganapatrao Kulkarni <gkulkarni@marvell.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Mar 20, 2019 at 06:57:23PM +0000, Robert Richter wrote:
> From: Robert Richter <rrichter@marvell.com>
> Subject: [PATCH v2] iommu/iova: Fix tracking of recently failed iova address
>  size
> 
> If a 32 bit allocation request is too big to possibly succeed, it
> early exits with a failure and then should never update max32_alloc_
> size. This patch fixes current code, now the size is only updated if
> the slow path failed while walking the tree. Without the fix the
> allocation may enter the slow path again even if there was a failure
> before of a request with the same or a smaller size.
> 
> Cc: <stable@vger.kernel.org> # 4.20+
> Fixes: bee60e94a1e2 ("iommu/iova: Optimise attempts to allocate iova from 32bit address range")
> Signed-off-by: Robert Richter <rrichter@marvell.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Robert Richter <rrichter@marvell.com>
> ---
>  drivers/iommu/iova.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Applied, thanks.
