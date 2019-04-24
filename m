From: Tom Murphy via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: [PATCH] iommu/amd: flush not present cache in iommu_map_page
Date: Wed, 24 Apr 2019 15:47:39 +0100
Message-ID: <CAPL0++7w0wR+hid=0XkGtH2wR0qvL1oNheEMQOM=8CtyhNLmag@mail.gmail.com>
References: <20190424141900.8883-1-tmurphy@arista.com>
	<20190424143246.GA24079@infradead.org>
Reply-To: Tom Murphy <tmurphy-nzgTgzXrdUbQT0dZR+AlfA@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190424143246.GA24079-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tom Murphy <murphyt7-/Zw1syy4LHg@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

>The two conditions can go into one if statement to make this a little
>more clear.
Ah, yeah of course

>And I'd really like to understand the unlikely - amd_iommu_np_cache
>is set based on a hardware capability, so it seems rather odd to mark
>it unlikely.  Dynamic branch prediction really should do the right thing
>here usually.

Here is the commit which added it without any explanation:
https://github.com/torvalds/linux/commit/270cab2426cdc6307725e4f1f46ecf8ab8e69193

should we remove it seen as there's no explanation given ?


On Wed, Apr 24, 2019 at 3:32 PM Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org> wrote:
>
> On Wed, Apr 24, 2019 at 03:18:59PM +0100, Tom Murphy via iommu wrote:
> > check if there is a not-present cache present and flush it if there is.
> >
> > Signed-off-by: Tom Murphy <tmurphy-nzgTgzXrdUbQT0dZR+AlfA@public.gmane.org>
> > ---
> >  drivers/iommu/amd_iommu.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> > index f7cdd2ab7f11..8ef43224aae0 100644
> > --- a/drivers/iommu/amd_iommu.c
> > +++ b/drivers/iommu/amd_iommu.c
> > @@ -1636,6 +1636,12 @@ static int iommu_map_page(struct protection_domain *dom,
> >               pte[i] = __pte;
> >
> >       update_domain(dom);
> > +     if (!dom->updated) {
> > +             if (unlikely(amd_iommu_np_cache)) {
> > +                     domain_flush_pages(dom, bus_addr, page_size);
> > +                     domain_flush_complete(dom);
> > +             }
> > +     }
>
> The two conditions can go into one if statement to make this a little
> more clear.
>
> And I'd really like to understand the unlikely - amd_iommu_np_cache
> is set based on a hardware capability, so it seems rather odd to mark
> it unlikely.  Dynamic branch prediction really should do the right thing
> here usually.
