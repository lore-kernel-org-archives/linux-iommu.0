From: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH AUTOSEL 5.0 008/262] swiotlb: add checks for the return
 value of memblock_alloc*()
Date: Thu, 28 Mar 2019 07:55:20 +0200
Message-ID: <20190328055520.GA14864@rapoport-lnx>
References: <20190327180158.10245-1-sashal@kernel.org>
 <20190327180158.10245-8-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190327180158.10245-8-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Christoph Hellwig <hch@lst.de>, "David S. Miller" <davem@davemloft.net>, Dennis Zhou <dennis@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Greentime Hu <green.hu@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guan Xuetao <gxt@pku.edu.cn>, Guo Ren <guoren@kernel.org>, Guo Ren <ren_guo@c-sky.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Juergen Gross <jgross@suse.com>, Mark Salter <msalter@redhat.com>, Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>, Paul Burton <paul.burton@mips.com>
List-Id: iommu@lists.linux-foundation.org

Hi,

On Wed, Mar 27, 2019 at 01:57:43PM -0400, Sasha Levin wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> [ Upstream commit a0bf842e89a3842162aa8514b9bf4611c86fee10 ]
> 
> Add panic() calls if memblock_alloc() returns NULL.
> 
> The panic() format duplicates the one used by memblock itself and in
> order to avoid explosion with long parameters list replace open coded
> allocation size calculations with a local variable.

This patch is a part of a series that removes panic() calls from memblock
allocators rather than a fix.
 
> Link: http://lkml.kernel.org/r/1548057848-15136-19-git-send-email-rppt@linux.ibm.com
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Dennis Zhou <dennis@kernel.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Greentime Hu <green.hu@gmail.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Guan Xuetao <gxt@pku.edu.cn>
> Cc: Guo Ren <guoren@kernel.org>
> Cc: Guo Ren <ren_guo@c-sky.com>				[c-sky]
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Juergen Gross <jgross@suse.com>			[Xen]
> Cc: Mark Salter <msalter@redhat.com>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Michal Simek <monstr@monstr.eu>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Rich Felker <dalias@libc.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Vineet Gupta <vgupta@synopsys.com>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  kernel/dma/swiotlb.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index c873f9cc2146..41224f0ec40e 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -191,6 +191,7 @@ void __init swiotlb_update_mem_attributes(void)
>  int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
>  {
>  	unsigned long i, bytes;
> +	size_t alloc_size;
>  
>  	bytes = nslabs << IO_TLB_SHIFT;
>  
> @@ -203,12 +204,18 @@ int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
>  	 * to find contiguous free memory regions of size up to IO_TLB_SEGSIZE
>  	 * between io_tlb_start and io_tlb_end.
>  	 */
> -	io_tlb_list = memblock_alloc(
> -				PAGE_ALIGN(io_tlb_nslabs * sizeof(int)),
> -				PAGE_SIZE);
> -	io_tlb_orig_addr = memblock_alloc(
> -				PAGE_ALIGN(io_tlb_nslabs * sizeof(phys_addr_t)),
> -				PAGE_SIZE);
> +	alloc_size = PAGE_ALIGN(io_tlb_nslabs * sizeof(int));
> +	io_tlb_list = memblock_alloc(alloc_size, PAGE_SIZE);
> +	if (!io_tlb_list)
> +		panic("%s: Failed to allocate %lu bytes align=0x%lx\n",
> +		      __func__, alloc_size, PAGE_SIZE);
> +
> +	alloc_size = PAGE_ALIGN(io_tlb_nslabs * sizeof(phys_addr_t));
> +	io_tlb_orig_addr = memblock_alloc(alloc_size, PAGE_SIZE);
> +	if (!io_tlb_orig_addr)
> +		panic("%s: Failed to allocate %lu bytes align=0x%lx\n",
> +		      __func__, alloc_size, PAGE_SIZE);
> +
>  	for (i = 0; i < io_tlb_nslabs; i++) {
>  		io_tlb_list[i] = IO_TLB_SEGSIZE - OFFSET(i, IO_TLB_SEGSIZE);
>  		io_tlb_orig_addr[i] = INVALID_PHYS_ADDR;
> -- 
> 2.19.1
> 

-- 
Sincerely yours,
Mike.
