From: Christoph Hellwig <hch@lst.de>
Subject: Re: add config symbols for arch_{setup,teardown}_dma_ops
Date: Mon, 11 Feb 2019 14:21:56 +0100
Message-ID: <20190211132156.GA22265@lst.de>
References: <20190204081420.15083-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190204081420.15083-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Paul Burton <paul.burton@mips.com>
Cc: iommu@lists.linux-foundation.org, linux-snps-arc@lists.infradead.org, linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Any chance to get a quick review on this small series?

On Mon, Feb 04, 2019 at 09:14:18AM +0100, Christoph Hellwig wrote:
> Hi all,
> 
> this series adds kconfig symbols to indicate that the architecture
> provides the arch_setup_dma_ops and arch_teardown_dma_ops hooks.
> 
> This avoids polluting dma-mapping.h which is included by just about
> every driver with implementation details, and also removes some
> clutter.
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
---end quoted text---
