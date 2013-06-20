From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] amd_iommu: Fix leak in free_pagetable()
Date: Thu, 20 Jun 2013 21:26:38 +0200
Message-ID: <20130620192638.GD11309@8bytes.org>
References: <20130618014459.20440.73844.stgit@bling.home>
	<20130618015116.20711.90269.stgit@bling.home>
	<20130620182808.GC11309@8bytes.org>
	<1371755280.30572.4.camel@ul30vt.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1371755280.30572.4.camel-85EaTFmN5p//9pzu0YdTqQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Jun 20, 2013 at 01:08:00PM -0600, Alex Williamson wrote:
> On Thu, 2013-06-20 at 20:28 +0200, Joerg Roedel wrote:
> > Hmm, actually a recursive version would make more sense here. But since
> > recursion is a bad idea in the kernel, how about this approach instead:
> 
> It's a fixed maximum depth of recursion though, is it really that taboo?

Well, a recursive version would be better here because it has lower icache
impact than my patch. But the risk is if there is a bug in recursive
code and it goes on forever it will overwrite random kernel memory, with
undefined, potentially very bad, results (like data corruption, killed
filesystems and so on).

So in my opinion it is better to not take that risk whenever possible.

> > The IOMMU pagetables can have up to 3 levels, but the code
> 
> s/3/6/

Right, thanks.

> Seems like it should do the right thing

Ok, I also gave it some testing (started a vm, assigned and de-assigned
a device), so it should work as expected.

> Reviewed-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Thanks,

	Joerg
