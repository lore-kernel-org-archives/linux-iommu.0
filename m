From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH RESEND] dma-mapping: tidy up dma_parms default handling
Date: Fri, 09 Jan 2015 20:45:49 +0100
Message-ID: <2031542.TLqIP3YVGc@wuerfel>
References: <ffdc5455d698d2525f2d126d0adabf9418fd76b1.1418990609.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ffdc5455d698d2525f2d126d0adabf9418fd76b1.1418990609.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: will.deacon@arm.com, m.szyprowski@samsung.com, bhelgaas@google.com, joro@8bytes.org, gregkh@linuxfoundation.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On Friday 09 January 2015 16:56:03 Robin Murphy wrote:
> 
> This one's a bit tricky to find a home for - I think technically it's 
> probably an IOMMU patch, but then the long-underlying problem doesn't
> seem to have blown up anything until arm64, and my motivation is to
> make bits of Juno work, which seems to nudge it towards arm64/arm-soc
> territory. Could anyone suggest which tree is most appropriate?

I have a set of patches touching various dma-mapping.h related bits
across architectures and in ARM in particular. Your patch fits into
that series, and I guess we could either have it in my asm-generic
tree or in Andrew Morton's mm tree. Possibly also arm-soc for practical
reasons, although it really doesn't belong in there.

	Arnd
