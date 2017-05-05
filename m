From: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH] iommu: fix device remove
Date: Fri, 5 May 2017 12:58:21 -0700
Message-ID: <20170505195821.GC7351@kroah.com>
References: <20170505180837.11326-1-robdclark@gmail.com>
	<20170505182452.GA3575@kroah.com>
	<CAF6AEGsTrOJG2+a=vPc8iLDPOK5rxQujS8wuoCEmBhgT7Zpb9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAF6AEGsTrOJG2+a=vPc8iLDPOK5rxQujS8wuoCEmBhgT7Zpb9w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, May 05, 2017 at 02:56:00PM -0400, Rob Clark wrote:
> On Fri, May 5, 2017 at 2:24 PM, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org> wrote:
> > On Fri, May 05, 2017 at 02:08:37PM -0400, Rob Clark wrote:
> >> It looks like it *used* to make sense to free the device.  But now it is
> >> embedded in 'struct iommu' (which is allocated or embedded in something
> >> that the device allocated).
> >>
> >> Spotted when testing qcom_iommu with CONFIG_DEBUG_TEST_DRIVER_REMOVE.
> >>
> >> Fixes: 39ab955 ("iommu: Add sysfs bindings for struct iommu_device")
> >> Signed-off-by: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >> ---
> >>  drivers/iommu/iommu-sysfs.c | 1 -
> >>  1 file changed, 1 deletion(-)
> >>
> >> diff --git a/drivers/iommu/iommu-sysfs.c b/drivers/iommu/iommu-sysfs.c
> >> index c58351e..ad19cbb 100644
> >> --- a/drivers/iommu/iommu-sysfs.c
> >> +++ b/drivers/iommu/iommu-sysfs.c
> >> @@ -34,7 +34,6 @@ static const struct attribute_group *iommu_dev_groups[] = {
> >>
> >>  static void iommu_release_device(struct device *dev)
> >>  {
> >> -     kfree(dev);
> >>  }
> >
> > As per the documentation in the kernel tree, I now get to make fun of
> > you for doing such a crazh and foolish thing!
> >
> > Come on, don't do that, a release function _HAS_ to free the memory
> > involved.  If not, then it is really broken...
> 
> There are shenanigans going on.. so release isn't counterpoint to a
> _probe() which allocates some memory.  See iommu_device_sysfs_add().
> So I'm not the one you get to make fun of ;-)
> 
> This the correct thing to do.  Whether the way the extra fake device
> embedded in something allocated in the iommu driver's probe (and
> free'd it *it's* _release()) stuff for iommu sysfs stuff works is
> bonkers or not, I'll let someone else decide..  it was like that when
> I got here.

If you have multiple reference counts in the same structure, your code
is wrong.  That is the root issue here that needs to be resolved.  Yes,
your patch papers over that, but again, it isn't right either.

greg k-h
