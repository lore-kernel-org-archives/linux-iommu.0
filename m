From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC] Independent use of IOMMU groups
Date: Fri, 27 Nov 2015 16:39:10 +0100
Message-ID: <20151127153910.GL2064@8bytes.org>
References: <1446746079.8831.82.camel@redhat.com>
	<20151106122939.GA13027@8bytes.org>
	<1446824140.8831.168.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1446824140.8831.168.camel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Alex,

On Fri, Nov 06, 2015 at 08:35:40AM -0700, Alex Williamson wrote:
> VFIO is really built on iommu groups, so making a vfio group independent
> of iommu groups is a difficult proposition.

I have been thinking about the relation between vfio device groups and
iommu-groups lately, because at least for PCI the iommu-grouping is too
coarse grained. I ran into this with the default-domain approach I am
working on.

Grouping devices together that have different request-ids (multifunction
and acs based grouping) only makes sense when the device is controlled
by an untrusted piece of software, in our case userspace or a KVM guest.
The device drivers in Linux are trusted, and this coarse grained
grouping becomes problematic, because it forces more devices into a
single domain, which can become a bottleneck for DMA-API allocations.

I have been thinking about moving the multi-function and acs grouping
into vfio code, meaning that a vfio-group contains more than one
iommu-group. The problem with this is that iommu-groups are exposed
in sysfs and thus became a userspace ABI.

So the vfio-group code might need changes anyway which could solve the
above problem too, no? I am just not sure yet what the best way is to
solve it.


	Joerg
