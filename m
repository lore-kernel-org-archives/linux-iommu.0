From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v10 0/10] iommu/vt-d: Fix intel vt-d faults in kdump kernel
Date: Tue, 21 Apr 2015 10:53:17 +0800
Message-ID: <20150421025317.GA14720@dhcp-128-82.nay.redhat.com>
References: <1428655333-19504-1-git-send-email-zhen-hual@hp.com>
	<20150415005731.GC19051@localhost.localdomain>
	<552DFB56.1070600@hp.com>
	<20150415064803.GF19051@localhost.localdomain>
	<5535AA57.6010404@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5535AA57.6010404-VXdhtT5mjnY@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Li, ZhenHua" <zhen-hual-VXdhtT5mjnY@public.gmane.org>
Cc: bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, tom.vaden-VXdhtT5mjnY@public.gmane.org, rwright-VXdhtT5mjnY@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lisa.mitchell-VXdhtT5mjnY@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, doug.hatch-VXdhtT5mjnY@public.gmane.org, ishii.hironobu-+CUm20s59erQFUHtdCDX3A@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, billsumnerlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, li.zhang6-VXdhtT5mjnY@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

On 04/21/15 at 09:39am, Li, ZhenHua wrote:
> Hi Dave,
> I found the old mail:
> http://lkml.iu.edu/hypermail/linux/kernel/1410.2/03584.html

I know and I have read it before.

==================  quote  ===================
> > > So with this in mind I would prefer initially taking over the
> > > page-tables from the old kernel before the device drivers re-initialize
> > > the devices.
> >
> > This makes the dump kernel more dependent on data from the old kernel,
> > which we obviously want to avoid when possible.

> Sure, but this is not really possible here (unless we have a generic and
> reliable way to reset all PCI endpoint devices and cancel all in-flight
> DMA before we disable the IOMMU in the kdump kernel).
> Otherwise we always risk data corruption somewhere, in system memory or
> on disk.
=================  quote  ====================

What I understand above is it is not really possible to avoid the problem.

But IMHO we should avoid it or we will have problems in the future, if we
really cannot avoid it I would say switching to pci reset way is better.

> 
> Please check this and you will find the discussion.
> 
> Regards
> Zhenhua
> 
> On 04/15/2015 02:48 PM, Dave Young wrote:
> >On 04/15/15 at 01:47pm, Li, ZhenHua wrote:
> >>On 04/15/2015 08:57 AM, Dave Young wrote:
> >>>Again, I think it is bad to use old page table, below issues need consider:
> >>>1) make sure old page table are reliable across crash
> >>>2) do not allow writing oldmem after crash
> >>>
> >>>Please correct me if I'm wrong, or if above is not doable I think I will vote for
> >>>resetting pci bus.
> >>>
> >>>Thanks
> >>>Dave
> >>>
> >>Hi Dave,
> >>
> >>When updating the context tables, we have to write their address to root
> >>tables, this will cause writing to old mem.
> >>
> >>Resetting the pci bus has been discussed, please check this:
> >>http://lists.infradead.org/pipermail/kexec/2014-October/012752.html
> >>https://lkml.org/lkml/2014/10/21/890
> >
> >I know one reason to use old pgtable is this looks better because it fixes the
> >real problem, but it is not a good way if it introduce more problems because of
> >it have to use oldmem. I will be glad if this is not a problem but I have not
> >been convinced.
> >
> >OTOH, there's many types of iommu, intel, amd, a lot of other types. They need
> >their own fixes, so it looks not that elegant.
> >
> >For pci reset, it is not perfect, but it has another advantage, the patch is
> >simpler. The problem I see from the old discusssion is, reset bus in 2nd kernel
> >is acceptable but it does not fix things on sparc platform. AFAIK current reported
> >problems are intel and amd iommu, at least pci reset stuff does not make it worse.
> >
> >Thanks
> >Dave
> >
> 
