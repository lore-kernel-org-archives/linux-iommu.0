From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC] Independent use of IOMMU groups
Date: Wed, 02 Dec 2015 08:58:16 -0700
Message-ID: <1449071896.15753.50.camel@redhat.com>
References: <1446746079.8831.82.camel@redhat.com>
	<20151106122939.GA13027@8bytes.org>
	<1446824140.8831.168.camel@redhat.com>
	<20151127153910.GL2064@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20151127153910.GL2064-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, 2015-11-27 at 16:39 +0100, Joerg Roedel wrote:
> Hi Alex,
> 
> On Fri, Nov 06, 2015 at 08:35:40AM -0700, Alex Williamson wrote:
> > VFIO is really built on iommu groups, so making a vfio group independent
> > of iommu groups is a difficult proposition.
> 
> I have been thinking about the relation between vfio device groups and
> iommu-groups lately, because at least for PCI the iommu-grouping is too
> coarse grained. I ran into this with the default-domain approach I am
> working on.
> 
> Grouping devices together that have different request-ids (multifunction
> and acs based grouping) only makes sense when the device is controlled
> by an untrusted piece of software, in our case userspace or a KVM guest.
> The device drivers in Linux are trusted, and this coarse grained
> grouping becomes problematic, because it forces more devices into a
> single domain, which can become a bottleneck for DMA-API allocations.
> 
> I have been thinking about moving the multi-function and acs grouping
> into vfio code, meaning that a vfio-group contains more than one
> iommu-group. The problem with this is that iommu-groups are exposed
> in sysfs and thus became a userspace ABI.
> 
> So the vfio-group code might need changes anyway which could solve the
> above problem too, no? I am just not sure yet what the best way is to
> solve it.

Hi Joerg,

That's a hard one.  As you say, iommu groups are really a userspace ABI
and tightly integrated into the mapping of vfio groups, so I don't
really think we have much flexibility in re-defining an iommu group.
The original intent with putting the grouping logic in the iommu drivers
and core code was that vfio isn't smart enough to be able to determine
both the iommu visibility and topology based isolation for any given
architecture.  I think that's still true.  We don't really want to
enable vfio on platforms that haven't given the issue sufficient
consideration to enable the iommu API for devices.

On the other hand, it doesn't make a whole lot of sense for native
kernel drivers to care about topology based isolation.  It would be
preferable to fully isolate a device, but we do manage the IOVA address
space for native drivers, so unintentional peer-to-peer shouldn't really
be a possibility.

It makes sense to me to think about an iommu group as a set of one or
more iommu granules, where each granule is the granularity of the iommu
visibility.  A granule probably also has a relation to DMA aliases.  So
perhaps the granule encompasses all DMA related visibility issues and
the group is an overlay which takes topology into account when the IOVA
space is defined by the user (and malicious DMA needs to be considered
as well).

So maybe the first step is to create that dividing line and figure out
what granules look like and how we can more explicitly expose groups on
top of them.  Easier said than done, I'm sure.  Thanks,

Alex

PS - sorry for the delay, was off on holiday.
