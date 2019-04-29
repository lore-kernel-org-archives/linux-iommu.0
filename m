From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 0/7] iommu/dma-iommu: Split iommu_dma_map_msi_msg in
 two parts
Date: Mon, 29 Apr 2019 12:35:28 -0700
Message-ID: <20190429193528.GA14274@infradead.org>
References: <20190429144428.29254-1-julien.grall@arm.com>
 <646d035d-e160-a19d-8c3a-e1935cf691b5@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <646d035d-e160-a19d-8c3a-e1935cf691b5@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Julien Grall <julien.grall@arm.com>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, jason@lakedaemon.net, douliyangs@gmail.com, robin.murphy@arm.com, miquel.raynal@bootlin.com, tglx@linutronix.de, logang@deltatee.com, bigeasy@linutronix.de, linux-rt-users@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Apr 29, 2019 at 04:57:20PM +0100, Marc Zyngier wrote:
> Thanks for having reworked this. I'm quite happy with the way this looks
> now (modulo the couple of nits Robin and I mentioned, which I'm to
> address myself).
> 
> Jorg: are you OK with this going via the irq tree?

As-is this has a trivial conflict with my
"implement generic dma_map_ops for IOMMUs" series.  But I can tweak
it a bit to avoid that conflict.
