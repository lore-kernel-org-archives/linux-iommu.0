From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] swiotlb: Make DIRECT_MAPPING_ERROR viable
Date: Tue, 20 Nov 2018 17:07:42 +0100
Message-ID: <20181120160742.GA2492@lst.de>
References: <cover.1542722463.git.robin.murphy@arm.com> <e90da5fbab881c502ac3412fb05c44b26c99f73a.1542722463.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e90da5fbab881c502ac3412fb05c44b26c99f73a.1542722463.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: hch@lst.de, konrad.wilk@oracle.com, m.szyprowski@samsung.com, john.stultz@linaro.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

The subject line should say dma-direct.  This isn't really swiotlb
specific.

> +#define DIRECT_MAPPING_ERROR		~(dma_addr_t)0

Please add braces around the value like the other *MAPPING_ERROR
defintions so that it can be safely used in any context.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
