From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 4/6] dma-mapping: merge direct and noncoherent ops
Date: Thu, 1 Nov 2018 06:13:59 +0100
Message-ID: <20181101051359.GA4164@lst.de>
References: <20180914095808.22202-1-hch@lst.de> <20180914095808.22202-5-hch@lst.de> <alpine.LFD.2.21.1810311414200.20378@eddie.linux-mips.org> <alpine.LFD.2.21.1810311559590.20378@eddie.linux-mips.org> <20181031203206.GA28337@lst.de> <alpine.LFD.2.21.1810312043250.20378@eddie.linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1810312043250.20378@eddie.linux-mips.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Paul Burton <paul.burton@mips.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Oct 31, 2018 at 08:50:53PM +0000, Maciej W. Rozycki wrote:
> On Wed, 31 Oct 2018, Christoph Hellwig wrote:
> 
> > Can you send me your .config?
> 
>  Sure, attached.
> 
>  This is an updated 4.19 defconfig I was going to submit as I tripped over 
> this problem, so just rename it to .config and use `make olddefconfig' to 
> regenerate a full version.

Fails to compile for me with:

cc1: error: ‘-march=r3000’ requires ‘-mfp32’

using the x86_64 corss gcc 8 from Debian testing.

Either way the config looks like we have all the required bits for
non-coherent dma support.  The only guess is that somehow
dma_cache_wback_inv aren't hooked up to the right functions for some
reason, but I can't really think off why.
