From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v5 17/44] iommu: dma-mapping: Use unsigned long for
 dma_attrs
Date: Tue, 12 Jul 2016 17:08:06 +0200
Message-ID: <20160712150806.GH12639@8bytes.org>
References: <1467275019-30789-1-git-send-email-k.kozlowski@samsung.com>
 <1467275171-6298-1-git-send-email-k.kozlowski@samsung.com>
 <1467275171-6298-17-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1467275171-6298-17-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, hch@infradead.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Jun 30, 2016 at 10:25:44AM +0200, Krzysztof Kozlowski wrote:
> Split out subsystem specific changes for easier reviews. This will be
> squashed with main commit.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  drivers/iommu/amd_iommu.c | 12 ++++++------
>  drivers/iommu/dma-iommu.c |  6 +++---
>  include/linux/dma-iommu.h |  6 +++---
>  3 files changed, 12 insertions(+), 12 deletions(-)

Acked-by: Joerg Roedel <jroedel@suse.de>
