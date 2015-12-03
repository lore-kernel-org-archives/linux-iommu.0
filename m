From: Michael Wang <yun.wang@profitbricks.com>
Subject: Re: [RFC PATCH v2] iommu/amd: gray the 'irq_remap_table' object for
 kmemleak
Date: Thu, 3 Dec 2015 09:47:46 +0100
Message-ID: <566001B2.2060701@profitbricks.com>
References: <CAHkRjk5WzPT1gRaa=3qyrp1gcee9ZQKF_rU42FAu0C6ep8JPug@mail.gmail.com>
 <565ED81B.3020606@profitbricks.com> <20151202115142.GD18805@8bytes.org>
 <565EE4AA.4070309@profitbricks.com> <20151202125315.GB3910@pd.tnic>
 <565EEBC3.5050807@profitbricks.com> <20151202131300.GC3910@pd.tnic>
 <565EEFB4.4080108@profitbricks.com> <20151202134047.GE3783@pd.tnic>
 <565EF6BF.6020204@profitbricks.com> <20151202135931.GF3783@pd.tnic>
 <CAHkRjk4DdRE6=tN7VZu67Bsdty_4uT2GSbUff5MwP_nSJ+uj4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHkRjk4DdRE6=tN7VZu67Bsdty_4uT2GSbUff5MwP_nSJ+uj4A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>, Borislav Petkov <bp@alien8.de>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org



On 12/02/2015 06:36 PM, Catalin Marinas wrote:
> On 2 December 2015 at 13:59, Borislav Petkov <bp@alien8.de> wrote:
[snip]
> 
> 1. The sl?b allocators themselves use page allocations, so kmemleak
> could end up detecting the same pointer twice, hiding a potential leak
> 
> 2. Most page allocations do not contain data/pointers relevant to
> kmemleak (e.g. page cache pages), however the randomness of such data
> greatly diminishes kmemleak's ability to detect real leaks
> 
> Arguably, kmemleak could be made to detect both cases above by a
> combination of page flags, additional annotations or specific page
> alloc API. However, this has its own drawbacks in terms of code
> complexity (potentially outside mm/kmemleak.c) and overhead.

Thanks for the very nice explain :-) I used to thought overhead is
the only concern, missing the point regarding allocator it self.

Regards,
Michael Wang

> 
> Regarding a kmemleak_alloc() annotation like in the patch I suggested,
> that's the second one I've seen needed outside alloc APIs (the first
> one is commit f75782e4e067 - "block: kmemleak: Track the page
> allocations for struct request"). If the number of such explicit
> annotations stays small, it's better to keep it this way.
> 
> There are other explicit annotations like kmemleak_not_leak() or
> kmemleak_ignore() but these are for objects kmemleak knows about and
> incorrectly reports them as leaks. Most of the time is because the
> pointers to such objects are stored in a different form (e.g. physical
> address).
> 
> Anyway, kmemleak is not the only tool requiring annotations (take
> spin_lock_nested() for example). If needed, we could do with an
> additional page alloc/free API which informs kmemleak in the process
> but I don't think it's worth it.
> 
