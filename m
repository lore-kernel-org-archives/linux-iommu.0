From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 0/3] iommu: Avoid DMA ops domain refcount contention
Date: Fri, 17 Aug 2018 00:24:15 -0700
Message-ID: <20180817072415.GA22241@infradead.org>
References: <cover.1534250425.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <cover.1534250425.git.robin.murphy@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: catalin.marinas@arm.com, joro@8bytes.org, will.deacon@arm.com, linuxarm@huawei.com, iommu@lists.linux-foundation.org, guohanjun@huawei.com, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

I plan to make the arm iommu dma ops generic and move them to
drivers/iommu for the 4.20 merge window.  Because of that it would
be great to create a stable branch or even pull this in through
the dma-mapping tree entirely.
