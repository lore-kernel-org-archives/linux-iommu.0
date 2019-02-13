From: Christoph Hellwig <hch@lst.de>
Subject: Re: add config symbols for arch_{setup,teardown}_dma_ops
Date: Wed, 13 Feb 2019 19:13:19 +0100
Message-ID: <20190213181319.GB19606@lst.de>
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

Thanks Catalin and Paul.  I've merged this into the dma-mapping
for-next branch.
