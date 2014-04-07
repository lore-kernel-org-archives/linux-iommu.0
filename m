From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] iommu-groups: Add list_head for iommu groups
Date: Mon, 07 Apr 2014 08:14:55 -0600
Message-ID: <1396880095.3215.89.camel@ul30vt.home>
References: <CAD15agaN=ymK8JTPELNygF055r3zPyqmJ7bMVabL7pM8EusHjg@mail.gmail.com>
	<1396620219.3215.46.camel@ul30vt.home>
	<CAD15agZbUwvda+XG3hELJT5PQ_0j2Bya8Y9wOZcP5qg8binUzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAD15agZbUwvda+XG3hELJT5PQ_0j2Bya8Y9wOZcP5qg8binUzg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Ritesh Harjani <ritesh.harjani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, 2014-04-07 at 15:23 +0530, Ritesh Harjani wrote:
> On Fri, Apr 4, 2014 at 7:33 PM, Alex Williamson
> <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> > On Fri, 2014-04-04 at 11:12 +0530, Ritesh Harjani wrote:
> >> Hi All,
> >>
> >> Please find the below patch and let me know your suggestions on this.
> >>
> >> With this patch iommu groups can be linked and iommu driver will
> >> get to know which all iommu groups belongs to a particular iommu device.
> >>
> >>
> >>
> >> Each iommu device might have multiple iommu groups,
> >> with each group populated with many devices. With
> >> this configuration, iommu driver may require a list
> >> of iommu groups belonging to each iommu device.
> >>
> >> Add list_head struct entry in iommu_group.
> >>
> >> Signed-off-by: Ritesh Harjani <ritesh.harjani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >> ---
> >>  drivers/iommu/iommu.c | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> >> index e5555fc..70588dc 100644
> >> --- a/drivers/iommu/iommu.c
> >> +++ b/drivers/iommu/iommu.c
> >> @@ -36,6 +36,10 @@ static struct ida iommu_group_ida;
> >>  static struct mutex iommu_group_mutex;
> >>
> >>  struct iommu_group {
> >> +       struct list_head list;  /* lower level iommu driver structure
> >> +                                * may require list of iommu groups
> >> +                                * belonging to that iommu device.
> >> +                                */
> >
> >
> > To have a list would require locking to manage that list, but you seem
> > to imply that the iommu driver would be managing this list... but there
> > might be multiple iommu drivers in a single system. Groups are
> > currently independent of each other by design, trying to manage them in
> > a list defeats that.
> 
> HOW ??
> 
> > There is also no example provided here of why we
> > would need or even want to do this.  Thanks,
> 
> Say multiple groups are linked to one iommu device. Each iommu_group maintains
> one iommu_data specific to their group. Now, if iommu driver of a
> iommu device wants
> to query all the iommu groups and thus all devices which belongs to
> this iommu hardware,
> then in that it will be nice if iommu_group struct provides a list_entry ?

iommu_data is owned by the iommu driver, so if a driver wants to create
such a list, why would it not do so there?  What's being requested here
is an extension to a private data structure with no concrete example of
why this is needed.  Current users don't seem to have any need for this.
Furthermore struct iommu_group is intentionally opaque to everything
outside of iommu.c, so without either relocating this structure to a
header or adding a list service to the iommu group interfaces, the
change is completely useless.  Thanks,

Alex
