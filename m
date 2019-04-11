From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [RFC patch 28/41] dma/debug: Simplify stracktrace retrieval
Date: Wed, 10 Apr 2019 22:02:01 -0500
Message-ID: <20190411030201.uko3njal44w2ea4b@treble>
References: <20190410102754.387743324@linutronix.de>
 <20190410103646.130022106@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190410103646.130022106@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, Andy Lutomirski <luto@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Alexander Potapenko <glider@google.com>, iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 10, 2019 at 12:28:22PM +0200, Thomas Gleixner wrote:
> Replace the indirection through struct stack_trace with an invocation of
> the storage array based interface.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: iommu@lists.linux-foundation.org
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  kernel/dma/debug.c |   13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> --- a/kernel/dma/debug.c
> +++ b/kernel/dma/debug.c
> @@ -89,8 +89,8 @@ struct dma_debug_entry {
>  	int		 sg_mapped_ents;
>  	enum map_err_types  map_err_type;
>  #ifdef CONFIG_STACKTRACE
> -	struct		 stack_trace stacktrace;
> -	unsigned long	 st_entries[DMA_DEBUG_STACKTRACE_ENTRIES];
> +	unsigned int	st_len;
> +	unsigned long	st_entries[DMA_DEBUG_STACKTRACE_ENTRIES];

nit: st_entries isn't very readable.  Thanks to the magic of compilers,
the characters are free, so why not call them "stacktrace_entries" and
"stacktrace_len".

-- 
Josh
