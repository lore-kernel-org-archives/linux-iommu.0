From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: kernel BUG at drivers/iommu/intel-iommu.c:608
Date: Mon, 8 Apr 2019 09:23:45 -0600
Message-ID: <20190408092345.01751472@x1.home>
References: <a523ea10-3dab-fa2c-1ecf-5cf32077565f@acm.org>
	<20190407150650.060cc508@x1.home>
	<8d876549-21da-e027-0157-8737b10e26f8@acm.org>
	<20190407173132.24032810@x1.home>
	<1554736414.118779.265.camel@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1554736414.118779.265.camel-HInyCGIudOg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Bart Van Assche <bvanassche-HInyCGIudOg@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, James Smart <jsmart2021-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, 08 Apr 2019 08:13:34 -0700
Bart Van Assche <bvanassche-HInyCGIudOg@public.gmane.org> wrote:

> On Sun, 2019-04-07 at 17:31 -0600, Alex Williamson wrote:
> > It's not possible to do what you want with this configuration.  An IOMMU
> > group represents the smallest set of devices that are isolated from
> > other sets of devices and is also therefore the minimum granularity we
> > can assign devices to userspace (ex. QEMU).  The kernel reacts to
> > breaking the isolation of the group with a BUG_ON.  If you managed not
> > to hit the BUG_ON here, you'd hit the BUG_ON in vfio code when the loss
> > of isolation is detected there. IOMMU groups are formed at the highest
> > point in the topology which guarantees isolation.  This can be
> > indicated either via native PCIe ACS support or ACS-equivalent quirks
> > in the code.  If the root port provides neither of these, then all
> > devices downstream are grouped together as well as all peer root ports
> > in the same PCI slot and all devices downstream of those.  If a
> > multifunction endpoint does not provide ACS or equivalent quirks, the
> > functions will be grouped together. Not all endpoint devices or systems
> > are designed for minimum possible granularity.  You can learn more
> > here[1].  Thanks,
> > 
> > Alex
> > 
> > [1] http://vfio.blogspot.com/2014/08/iommu-groups-inside-and-out.html  
> 
> Hi Alex,
> 
> Thank you for the detailed reply. The background information you provided
> makes it very clear why the devices I mentioned in my e-mail ended up in the
> same IOMMU group.
> 
> But it seems that I was not clear enough in my original e-mail. My concern is
> that a user space action (modprobe) should never trigger a kernel BUG(). Is
> there any way to make sure that the sequence of actions I performed causes
> modprobe to fail with an error code instead of triggering a kernel BUG()?

Loading modules is privileged:

$ modprobe vfio-pci
modprobe: ERROR: could not insert 'vfio_pci': Operation not permitted

Granting a device to a user for device assignment purposes is also a
privileged operation.  Can you describe a scenario where this is
reachable without elevated privileges?  The driver core maintainer has
indicated previously that manipulation of driver binding is effectively
at your own risk.  It's entirely possible to bind devices to the wrong
driver creating all sorts of bad behavior.  In this case, it appears
that the system has been improperly configured if devices from a user
owned group can accidentally be bound to host drivers.  Thanks,

Alex
