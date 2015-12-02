From: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [RFC PATCH v2] iommu/amd: gray the 'irq_remap_table' object for
	kmemleak
Date: Wed, 2 Dec 2015 19:40:10 +0100
Message-ID: <20151202184009.GI3783@pd.tnic>
References: <20151202115142.GD18805@8bytes.org>
	<565EE4AA.4070309@profitbricks.com> <20151202125315.GB3910@pd.tnic>
	<565EEBC3.5050807@profitbricks.com> <20151202131300.GC3910@pd.tnic>
	<565EEFB4.4080108@profitbricks.com> <20151202134047.GE3783@pd.tnic>
	<565EF6BF.6020204@profitbricks.com> <20151202135931.GF3783@pd.tnic>
	<CAHkRjk4DdRE6=tN7VZu67Bsdty_4uT2GSbUff5MwP_nSJ+uj4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAHkRjk4DdRE6=tN7VZu67Bsdty_4uT2GSbUff5MwP_nSJ+uj4A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Catalin Marinas <catalin.marinas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Michael Wang <yun.wang-EIkl63zCoXaH+58JC4qpiA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Dec 02, 2015 at 05:36:32PM +0000, Catalin Marinas wrote:
> Defending kmemleak here ;).

Oh sure, by all means. I'm also assuming it comes across that I wasn't
attacking kmemleak. I had the same arguments with KASAN and other stuff
in the past.

> Tracking page allocations in kmemleak by intercepting
> __get_free_pages() has significant implications on false negatives for
> two main reasons:
> 
> 1. The sl?b allocators themselves use page allocations, so kmemleak
> could end up detecting the same pointer twice, hiding a potential leak
> 
> 2. Most page allocations do not contain data/pointers relevant to
> kmemleak (e.g. page cache pages), however the randomness of such data
> greatly diminishes kmemleak's ability to detect real leaks

Yeah, so can you teach kmemleak to ignore pointers from
__get_free_pages()? Since it cannot track them properly and it causes
false positives and all. Now it invites people to add annotation which
makes unrelated code obscure.

> Arguably, kmemleak could be made to detect both cases above by a
> combination of page flags, additional annotations or specific page
> alloc API. However, this has its own drawbacks in terms of code
> complexity (potentially outside mm/kmemleak.c) and overhead.
> 
> Regarding a kmemleak_alloc() annotation like in the patch I suggested,
> that's the second one I've seen needed outside alloc APIs (the first
> one is commit f75782e4e067 - "block: kmemleak: Track the page
> allocations for struct request"). If the number of such explicit
> annotations stays small, it's better to keep it this way.

Well, how do you define "small"? When is it ok and when do we say, no
more?

> There are other explicit annotations like kmemleak_not_leak() or
> kmemleak_ignore() but these are for objects kmemleak knows about and
> incorrectly reports them as leaks. Most of the time is because the
> pointers to such objects are stored in a different form (e.g. physical
> address).
> 
> Anyway, kmemleak is not the only tool requiring annotations (take
> spin_lock_nested() for example).

Yeah, and it doesn't look great. I know, it helps a lot and yadda
yadda...

> If needed, we could do with an additional page alloc/free API which
> informs kmemleak in the process but I don't think it's worth it.

Well, I think it is a big win if it gets to keep the code clean. And we
don't care about performance with kmemleak - it is a performance hit
anyway but we take that hit for a reason.

Again, I'm not attacking kmemleak or any other tool for that matter -
I just want for tools to be honest: if kmemleak cannot classify that
pointer and until it is able to do so, it should be quiet about it
because, well, honestly, it doesn't really know.

All that annotation coming with every new tool is simply annoying and
obscures the code so perhaps we should aim at keeping it close to 0. I
hope you're catching my drift exactly as I intended. If not, I'll gladly
reiterate.

Thanks.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
