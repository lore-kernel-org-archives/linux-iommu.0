From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2] iommu: iova: Consolidate code for adding new node to
 iovad domain rbtree
Date: Tue, 21 Mar 2017 14:59:29 +0100
Message-ID: <20170321135928.GA29659@8bytes.org>
References: <CGME20170224111346eucas1p2039e4d85e34f2a4cdd3adc298e2a1b6f@eucas1p2.samsung.com>
 <1487934817-11725-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1487934817-11725-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Robin Murphy <robin.murphy@arm.com>
List-Id: iommu@lists.linux-foundation.org

On Fri, Feb 24, 2017 at 12:13:37PM +0100, Marek Szyprowski wrote:
> This patch consolidates almost the same code used in iova_insert_rbtree()
> and __alloc_and_insert_iova_range() functions. While touching this code,
> replace BUG() with WARN_ON(1) to avoid taking down the whole system in
> case of corrupted iova tree or incorrect calls.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> v2:
> - replaced BUG() with WARN_ON(1) as suggested by Robin Murphy
> 
> v1:
> - initial version

Applied, thanks.
