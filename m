From: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [RFC] avoid indirect calls for DMA direct mappings
Date: Thu, 6 Dec 2018 10:51:33 -0800
Message-ID: <CAHk-=wh=aLuvLu++ZcehjDLgZfSqOVK+whecEq_-JP12VQ96sg@mail.gmail.com>
References: <20181206153720.10702-1-hch@lst.de>
	<CAHk-=wgz6PFCm+XMWN31dRHzA3JcNP0x0Y-z5NMMw3dHhrDXAw@mail.gmail.com>
	<20181206184330.GB30039@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181206184330.GB30039-jcswGhMUV9g@public.gmane.org>
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
Cc: toke-LJ9M9ZcSy1A@public.gmane.org, ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Linux List Kernel Mailing <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, brouer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, tariqt-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Dec 6, 2018 at 10:43 AM Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org> wrote:
>
> >
> >  (a) the dma_is_direct() function/macro uses "likely()" for the test
>
> I'm a little worried about that.  Yes, for the common case it is
> likely.  But if you run a setup where you say always have an iommu
> it is not, in fact it is never called in that case, but we only know
> that at runtime.

Note that "likely()" doesn't have any really huge overhead - it just
makes the compiler move the unlikely case out-of-line.

Compared to the overhead of the indirect branch, it's simply not a
huge deal, it's more a mispredict and cache layout issue.

So marking something "likely()" when it isn't doesn't really penalize
things too much. It's not like an exception or anything like that,
it's really just a marker for better code layout.

                  Linus
