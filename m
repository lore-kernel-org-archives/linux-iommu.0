From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: [PATCH v3] dma-debug: fix incorrect pfn calculation
Date: Tue, 3 Oct 2017 09:07:52 +0200
Message-ID: <20171003070752.GA18928@lst.de>
References: <1506484087-1177-1-git-send-email-miles.chen@mediatek.com>
	<273077fd-c5ad-82c8-60aa-cde89355e5e8@arm.com>
	<20171001080449.GB11843@lst.de>
	<1506940241.28397.36.camel@mtkswgap22>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1506940241.28397.36.camel@mtkswgap22>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Miles Chen <miles.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: wsd_upstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Oct 02, 2017 at 06:30:41PM +0800, Miles Chen wrote:
> ARCHs like metag and xtensa define their mappings (non-vmalloc and
> non-linear) for dma allocation.

metag basically is a reimplementation of the vmalloc map mechanism
that should be easy to consolidate into the common one :(  xtensa
has a weird remapping into a different segment, something that I
vaguely remember mips used to support as well.

> These mapping types are architecture-dependent and should not be used
> outside arch folders. So it is hard to check the mappings and convert
> a virtual address to a correct pfn in lib/dam-debug.c
> 
> How about recording only vmalloc (by is_vmalloc_addr()) and linear
> address (by virt_addr_valid()) in lib/dma-debug? Since current 
> implementation is not correct for those ARCHs.
> 
> if (!is_vmalloc_addr(addr) && !virt_addr_valid(addr))
>     return;
> 
> or

This looks like a good start, although I'm not sure I'd trust
virt_addr_valid on every little arch.  In the worse case we'll
have to exclude offenders from supporting dma debug, so let's go
with that version.

> > > > +	entry->pfn	 = is_vmalloc_addr(virt) ? vmalloc_to_pfn(virt) :
> > > > +						page_to_pfn(virt_to_page(virt));
> > 
> > Please use normal if/else conditionsals:
> 
> Is this for better readability? I'll send another patch for this.

Yes.
