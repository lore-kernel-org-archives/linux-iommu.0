From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 12/14] dma-direct: handle the memory encryption bit in
	common code
Date: Mon, 19 Mar 2018 16:55:51 +0000
Message-ID: <20180319165551.GE14916@arm.com>
References: <20180319103826.12853-1-hch@lst.de>
	<20180319103826.12853-13-hch@lst.de>
	<dd05dd14-9969-7985-826e-f440c3fc4c08@arm.com>
	<20180319152442.GA27915@lst.de>
	<5316b479-7e75-d62f-6b17-b6bece55187c@arm.com>
	<20180319154832.GD14916@arm.com> <20180319160343.GA29002@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180319160343.GA29002-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: Tom Lendacky <thomas.lendacky-5C7GfCeVMHo@public.gmane.org>, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Muli Ben-Yehuda <mulix-BzGcCpaT2IbYtjvyW6yDsg@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Mar 19, 2018 at 05:03:43PM +0100, Christoph Hellwig wrote:
> On Mon, Mar 19, 2018 at 03:48:33PM +0000, Will Deacon wrote:
> > Why can't we just resolve the conflict by adding the underscores?
> 
> We can solve the conflict easily that way.  But that's not the point.
> 
> The point is that I've been fighting hard to consolidate dma code
> given that the behavior really is common and not arch specific.  And
> this one is another case like that:  the fact that the non-coherent
> dma boundary is bigger than the exposed size is something that can
> easily happen elsewhere, so there is no need to duplicate a lot
> of code for that.

Fair enough, although I wouldn't say it's a *lot* of code being duplicated.
Are there other architectures working around this issue too? I couldn't
see anything in the other dma-direct.h headers.

> Nevermind that the commit should at least be three different patches:
> 
>  (1) revert the broken original commit
>  (2) increase the dma min alignment
>  (3) put the swiotlb workaround in place

I'd agree with you if this wasn't already queued and sitting in -next.
Reverting what we currently have seems a bit OTT now. Catalin?

Will
