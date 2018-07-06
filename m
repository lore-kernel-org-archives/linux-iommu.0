From: Dmitry Safonov <dima@arista.com>
Subject: Re: [RFC 0/3] iommu/iova: Unsafe locking in find_iova()
Date: Fri, 06 Jul 2018 15:10:47 +0100
Message-ID: <1530886247.3205.53.camel@arista.com>
References: <20180621180823.805-1-dima@arista.com>
         <20180706131611.h3w2kdinmjguikgo@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180706131611.h3w2kdinmjguikgo@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org, Dmitry Safonov <0x7f454c46@gmail.com>
List-Id: iommu@lists.linux-foundation.org

On Fri, 2018-07-06 at 15:16 +0200, Joerg Roedel wrote:
> On Thu, Jun 21, 2018 at 07:08:20PM +0100, Dmitry Safonov wrote:
> > find_iova() looks to be using a bad locking practice: it locks the
> > returned iova only for the search time.  And looking in code, the
> > element can be removed from the tree and freed under rbtree lock.
> > That
> > happens during memory hot-unplug and cleanup on module
> > removal.  Here
> > I cleanup users of the function and delete it.
> 
> But this is only a problem if more than one code-path uses tries to
> handle a given iova at the same time, no?

Yes, as far as I can see, there are code-paths which may try to handle
it at the same time:
o memory notifiers for hot-unplug (intel-iommu.c)
o drivers unloading calls free_iova(), which in the result calls
  find_iova()
o I see at least one driver that frees iova during it's normal work
  too: scif_rma.c:scif_free_window_offset()

So, I decided to fix the interface while it's not widely used instead
of all callers.
Looks worth for me even as it's all corner-cases like unplugging the
memory.

Anyway, just found it while some college wrote a debug sysfs interface
for iovas and used find_iova().
So, if you think it's not worth to change - that's fine for me, but I
thought I'll nip this in the bud, preventing other people to misuse it.

-- 
Thanks,
             Dmitry
