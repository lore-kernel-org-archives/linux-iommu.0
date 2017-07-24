From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 3/5] iommu/arm-smmu-v3: add IOMMU_CAP_BYPASS to the ARM
	SMMUv3 driver
Date: Mon, 24 Jul 2017 13:06:56 -0600
Message-ID: <20170724130656.5240ae0d@w520.home>
References: <1500456838-18405-1-git-send-email-anup.patel@broadcom.com>
	<1500456838-18405-4-git-send-email-anup.patel@broadcom.com>
	<ace28bd1-2dd3-482c-d11b-539c055ee9b7@arm.com>
	<CAALAos8y0kLGrbwgz3u=ZVyteSicuPyQZ3Yp=LPZohXzVaE5NQ@mail.gmail.com>
	<20170719112524.GF13642@arm.com>
	<CAALAos_xGCt7U1Oz5uCf9Q4hP6fdn4fcymFNQP5xO_UBduSY3g@mail.gmail.com>
	<20170719113325.GI13642@arm.com>
	<CAALAos99HWLoW=0P-dvFA+oNsF03TRNzNbfppyQNtqmcRELXXQ@mail.gmail.com>
	<20170719115333.GJ13642@arm.com>
	<CAALAos-YbVbgvPmDYXeWaF4y8MQ9i7CG3tgGuf-QLR6hmXo18Q@mail.gmail.com>
	<20170720091003.GA17837@arm.com>
	<8e82d8f5-e5e2-dd09-c774-29f9eda2ecdd@arm.com>
	<20170724111621.7f1c3a85@w520.home>
	<6468f359-1682-b9b0-5a4d-72738939cb84@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <6468f359-1682-b9b0-5a4d-72738939cb84-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, BCM Kernel Feedback <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux ARM Kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, 24 Jul 2017 18:23:20 +0100
Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:

> On 24/07/17 18:16, Alex Williamson wrote:
> > On Thu, 20 Jul 2017 12:17:12 +0100
> > Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
> >   
> >> On 20/07/17 10:10, Will Deacon wrote:  
> >>> On Thu, Jul 20, 2017 at 09:32:00AM +0530, Anup Patel wrote:    
> >>>> On Wed, Jul 19, 2017 at 5:23 PM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:    
> >>>>> There are two things here:
> >>>>>
> >>>>>   1. iommu_present() is pretty useless, because it applies to a "bus" which
> >>>>>      doesn't actually tell you what you need to know for things like the
> >>>>>      platform_bus, where some masters might be upstream of an SMMU and
> >>>>>      others might not be.    
> >>>>
> >>>> I agree with you. The iommu_present() check in vfio_iommu_group_get()
> >>>> is not much useful. We only reach line which checks iommu_present()
> >>>> when iommu_group_get() returns NULL for given "struct device *". If there
> >>>> is no IOMMU group for a "struct device *" then it means there is no IOMMU
> >>>> HW doing translations for such device.
> >>>>
> >>>> If we drop the iommu_present() check (due to above reasons) in
> >>>> vfio_iommu_group_get() then we don't require the IOMMU_CAP_BYPASS
> >>>> and we can happily drop PATCH1, PATCH2, and PATCH3.
> >>>>
> >>>> I will remove the iommu_present() check in vfio_iommu_group_get()
> >>>> because it is only comes into actions when VFIO_NOIOMMU is
> >>>> enabled. This will also help us drop PATCH1-to-PATCH3.    
> >>>
> >>> I don't think that's the right answer. Whilst iommu_present has obvious
> >>> shortcomings, its intention is clear: it should tell you whether a given
> >>> *device* is upstream of an IOMMU. So the right fix is to make this
> >>> per-device, instead of per-bus. Removing it altogether is worse than leaving
> >>> it like it is.    
> >>
> >> Not really - if there is an IOMMU up and running to the point of setting
> >> bus ops, every device it cares about can be expected to have a group
> >> already (there are only a couple of drivers left that don't use groups,
> >> and they're hardly relevant to VFIO). Thus iommu_group_get() already is
> >> the de-facto per-device IOMMU check.
> >>
> >> And having looked into it, I'm now spinning a couple of patches to
> >> finish off making groups truly mandatory so that that can be less
> >> de-facto ;)  
> > 
> > No, look at vfio-noiommu and even vfio-mdev devices for devices which
> > have an iommu group but there is no physical iommu supporting them.
> > iommu_present() is how we can distinguish these groups and therefore
> > not generate a segfault in trying to use the full IOMMU API on them.  
> 
> OK, so that means that the combination of vfio-noiommu and vfio-platform
> is simply unusable, because iommu_present(&platform_bus_type) can give
> such dangerous false positives too.

Yep, this kinda falls apart since platform_bus_type doesn't really map
to a physical bus, nor does the presence of a group canonically
demonstrate that an iommu is present since anyone can create a group
for a device.  We really do need to migrate to per-device iommu_ops.
Thanks,

Alex
