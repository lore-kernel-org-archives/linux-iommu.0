From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 2/8] dma-debug: Expose nr_total_entries in debugfs
Date: Thu, 6 Dec 2018 15:14:34 +0100
Message-ID: <20181206141434.GA24408@lst.de>
References: <cover.1544037783.git.robin.murphy@arm.com> <6740cfb143a084e8f5851b760bf99121a7ad6c67.1544037783.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6740cfb143a084e8f5851b760bf99121a7ad6c67.1544037783.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: hch@lst.de, m.szyprowski@samsung.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, cai@gmx.us, salil.mehta@huawei.com, john.garry@huawei.com
List-Id: iommu@lists.linux-foundation.org

On Wed, Dec 05, 2018 at 07:56:51PM +0000, Robin Murphy wrote:
> Expose nr_total_entries in debugfs, so that {num,min}_free_entries
> become even more meaningful to users interested in current/maximum
> utilisation. This becomes even more relevant once nr_total_entries
> may change at runtime beyond just the existing AMD GART debug code.
> 
> Suggested-by: John Garry <john.garry@huawei.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
