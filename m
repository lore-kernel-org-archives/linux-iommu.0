From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/7] genirq/msi: Add a new field in msi_desc to store an
 IOMMU cookie
Date: Thu, 18 Apr 2019 21:28:12 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1904182126540.3174@nanos.tec.linutronix.de>
References: <20190418172611.21561-1-julien.grall@arm.com> <20190418172611.21561-2-julien.grall@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190418172611.21561-2-julien.grall@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Julien Grall <julien.grall@arm.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, logang@deltatee.com, douliyangs@gmail.com, miquel.raynal@bootlin.com, marc.zyngier@arm.com, jason@lakedaemon.net, joro@8bytes.org, robin.murphy@arm.com, bigeasy@linutronix.de, linux-rt-users@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Thu, 18 Apr 2019, Julien Grall wrote:

> When an MSI doorbell is located downstream of an IOMMU, it is required
> to swizzle the physical address with an appropriately-mapped IOVA for any
> device attached to one of our DMA ops domain.
> 
> At the moment, the allocation of the mapping may be done when composing
> the message. However, the composing may be done in non-preemtible
> context while the allocation requires to be called from preemptible
> context.
> 
> A follow-up patch will split the current logic in two functions
> requiring to keep an IOMMU cookie per MSI.
> 
> This patch introduces a new field in msi_desc to store an IOMMU cookie
> when CONFIG_IOMMU_DMA is selected.

# git grep 'This patch' Documentation/process/

Applied to the whole series.

Thanks

	tglx
