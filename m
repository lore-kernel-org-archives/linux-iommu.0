From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2] iommu/vt-d: Only remove domain when device is removed
Date: Thu, 06 Nov 2014 09:43:14 -0700
Message-ID: <1415292194.16601.96.camel@ul30vt.home>
References: <1412074923-6342-1-git-send-email-joro@8bytes.org>
	<1412074923-6342-3-git-send-email-joro@8bytes.org>
	<1415117537.27420.428.camel@ul30vt.home>
	<20141106125405.GI8354@suse.de>
	<1415290565.16601.92.camel@ul30vt.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1415290565.16601.92.camel-85EaTFmN5p//9pzu0YdTqQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Myron Stowe <mstowe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, 2014-11-06 at 09:16 -0700, Alex Williamson wrote:
> On Thu, 2014-11-06 at 13:54 +0100, Joerg Roedel wrote:
> > Hi Alex,
> > 
> > On Tue, Nov 04, 2014 at 09:12:17AM -0700, Alex Williamson wrote:
> > > I haven't tested it, but I'm concerned whether this has introduced a
> > > domain leak.  If we think about the case of unbinding a device from a
> > > host driver and attaching it to a domain through the IOMMU API, I think
> > > we used to count on this path to call domain_exit(), which made the
> > > domain_context_mapped() in intel_iommu_attach_device() "unlikely".  With
> > > this change, isn't the test in intel_iommu_attach_device() now neither
> > > likely nor unlikely and we're only removing the dev_info from the domain
> > > and not destroying the domain itself?  Thanks,
> > 
> > As I see it, there is no leak. The DMA-API domains are kept in the
> > device_domain_list and re-used when the device driver re-attaches. But
> > your are right that the unlikely in intel_iommu_attach_device() isn't
> > true anymore. We could probably remove it.
> 
> But the domains are unlinked from device_domain_list using
> unlink_domain_info() which is called from both domain_remove_dev_info()
> and domain_remove_one_dev_info() which are both part of that more
> likely, unlikely branch in intel_iommu_attach_device().  So it seems
> like any time we switch a device from the DMA-API to the IOMMU-API, we
> lose the reference to the domain.  Is that incorrect?  I'll try to test.

Trying the simple approach, a printk in each of alloc_domain() and
free_domain_mem(), this is what I see when I start and stop a VM with an
assigned device:

alloc_domain(): ffff8801e22ac000
free_domain_mem(ffff8801e22ac000)
alloc_domain(): ffff8801e3425c80

The IOMMU API domain is alloc'd and free'd, then a new DMA-API domain is
alloc'd.  There are no frees of the DMA-API domain.  Thanks,

Alex
