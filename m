From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] iommu/vt-d: Fix VM domain ID leak
Date: Wed, 22 Jul 2015 15:01:04 -0600
Message-ID: <1437598864.5211.41.camel@redhat.com>
References: <20150714204731.10189.28556.stgit@gimli.home>
	<20150716152030.GB10969@8bytes.org>
	<1437061435.1391.580.camel@redhat.com>
	<20150716170356.GC10969@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150716170356.GC10969-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, 2015-07-16 at 19:03 +0200, Joerg Roedel wrote:
> On Thu, Jul 16, 2015 at 09:43:55AM -0600, Alex Williamson wrote:
> > I was tempted to do this as well, but what about
> > domain_remove_dev_info() where we also handle vm domains specially and
> > don't do a symmetric detach in both directions?  I started down that
> > path but quickly found the code to fragile to make those kinds of
> > changes.  Thanks,
> 
> Okay, so domain_remove_dev_info() does:
> 
>                 if (domain_type_is_vm(domain)) {
>                         iommu_detach_dependent_devices(info->iommu, info->dev);
>                         domain_detach_iommu(domain, info->iommu);
>                 }
> 
> ... in a loop over all devices attached to the domain. The first
> function (iommu_detach_dependent_devices) is not special to vm-domains.
> In fact, domain_remove_one_dev_info calls it for all domain types.
> 
> And domain_detach_iommu only clears the bit in the iommu_bmp of the
> domain, which is also not special and also called for all domain types
> in domain_remove_one_dev_info.
> 
> So it looks like this special handling has no real purpose and is just
> part of the whole mess. I am currently working on the conversion of the
> Intel VT-d driver to use default-domains from the iommu-core. When this
> is done we can get rid of that mess.

In the meantime, we're still leaking domain IDs, do you see any problem
with the proposed patch for 4.2 and stable?  Thanks,

Alex
