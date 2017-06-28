From: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 5/9] iommu: Introduce fault notifier API
Date: Wed, 28 Jun 2017 09:16:34 -0700
Message-ID: <20170628091634.0e329803@jacob-builder>
References: <1498592883-56224-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1498592883-56224-6-git-send-email-jacob.jun.pan@linux.intel.com>
	<20170628101603.GH14532@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170628101603.GH14532-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, 28 Jun 2017 12:16:03 +0200
Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:

> On Tue, Jun 27, 2017 at 12:47:59PM -0700, Jacob Pan wrote:
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index d973555..07cfd92 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -48,6 +48,7 @@ struct iommu_group {
> >  	struct list_head devices;
> >  	struct mutex mutex;
> >  	struct blocking_notifier_head notifier;
> > +	struct blocking_notifier_head fault_notifier;  
> 
> Do you really need a notifier chain here? Will there ever be more than
> one callback registered to it?
> 
yes, this notifier chain is shared by all devices under a group. the
event contains device info which notifier callbacks can filter.
> > +struct iommu_fault_event {
> > +	struct device *dev;  
> 
> Putting a 'struct device *' member in a uapi struct looks
> fundamentally wrong.
> 
> 
my mistake, it was originally (RFC) not in uapi but with the
consideration of using vfio to expose it to user space I have moved it
to uapi. But you are right, it should be some other forms of device
representation used by vfio. VFIO layer has to do the translation and
inject that into the guest. In kernel driver users can use struct
device to identify the faulting device.

> 
> 	Joerg
> 

[Jacob Pan]
