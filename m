From: Souptick Joarder <jrdr.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/9] mm: Introduce new vm_insert_range API
Date: Fri, 16 Nov 2018 13:45:48 +0530
Message-ID: <CAFqt6zbL1tu4VWtZ5Wz-BgbOS+M2GJziMj958_h_ri4Th3n9bQ@mail.gmail.com>
References: <20181115154530.GA27872@jordon-HP-15-Notebook-PC>
	<9655a12e-bd3d-aca2-6155-38924028eb5d@infradead.org>
	<CAFqt6zbLjtDab3Bz67trbnQRQdutvgA=YvAFhoW4bxsg657mGQ@mail.gmail.com>
	<20181116064049.GA5320@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181116064049.GA5320-PfSpb0PWhxZc2C7mugBRk2EX/6BAtgUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Matthew Wilcox <willy-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Michal Hocko <mhocko-IBi9RG/b67k@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux-MM <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, linux1394-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>, oleksandr_andrushchenko-uRwfk40T5oI@public.gmane.org, Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, pawel-FA/gS7QP4orQT0dZR+AlfA@public.gmane.org, Rik van Riel <riel-ebMLmSuQjDVBDgjK7y7TUQ@public.gmane.org>, rppt-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, Boris Ostrovsky <boris.ostrovsky-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, iamjoonsoo.kim-Hm3cg6mZ9cc@public.gmane.org, vbabka-AlSwsSmVLrQ@public.gmane.org, Juergen Gross <jgross-IBi9RG/b67k@public.gmane.org>, Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, hjc-TNX95d0MmH7DzftRWevZcw@public.gmane.org, xen-devel-GuqFBffKawuEi8DpZVb4nw@public.gmane.org, Kyungmin
List-Id: iommu@lists.linux-foundation.org

On Fri, Nov 16, 2018 at 12:11 PM Matthew Wilcox <willy-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org> wrote:
>
> On Fri, Nov 16, 2018 at 11:00:30AM +0530, Souptick Joarder wrote:
> > On Thu, Nov 15, 2018 at 11:44 PM Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org> wrote:
> > > On 11/15/18 7:45 AM, Souptick Joarder wrote:
> > > What is the opposite of vm_insert_range() or even of vm_insert_page()?
> > > or is there no need for that?
> >
> > There is no opposite function of vm_insert_range() / vm_insert_page().
> > My understanding is, in case of any error, mmap handlers will return the
> > err to user process and user space will decide the next action. So next
> > time when mmap handler is getting invoked it will map from the beginning.
> > Correct me if I am wrong.
>
> The opposite function, I suppose, is unmap_region().
>
> > > s/no./number/
> >
> > I didn't get it ??
>
> This is a 'sed' expression.  's' is the 'substitute' command; the /
> is a separator, 'no.' is what you wrote, and 'number' is what Randy
> is recommending instead.

Ok. Will change it in v2.
>
> > > > +     for (i = 0; i < page_count; i++) {
> > > > +             ret = vm_insert_page(vma, uaddr, pages[i]);
> > > > +             if (ret < 0)
> > > > +                     return ret;
> > >
> > > For a non-trivial value of page_count:
> > > Is it a problem if vm_insert_page() succeeds for several pages
> > > and then fails?
> >
> > No, it will be considered as total failure and mmap handler will return
> > the err to user space.
>
> I think what Randy means is "What happens to the inserted pages?" and
> the answer is that mmap_region() jumps to the 'unmap_and_free_vma'
> label, which is an accurate name.

Sorry for incorrect understanding of the question.
