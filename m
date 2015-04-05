From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v9 0/10] iommu/vt-d: Fix intel vt-d faults in kdump kernel
Date: Sun, 5 Apr 2015 09:54:53 +0800
Message-ID: <20150405015453.GB1562@dhcp-17-102.nay.redhat.com>
References: <1426743388-26908-1-git-send-email-zhen-hual@hp.com>
	<20150403084031.GF22579@dhcp-128-53.nay.redhat.com>
	<551E56F6.60503@hp.com>
	<20150403092111.GG22579@dhcp-128-53.nay.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150403092111.GG22579-0VdLhd/A9PldIt/LePPtNh/sF2h8X+2i0E9HWUfgJXw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: tom.vaden-VXdhtT5mjnY@public.gmane.org, rwright-VXdhtT5mjnY@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lisa.mitchell-VXdhtT5mjnY@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, "Li,
	ZhenHua" <zhen-hual-VXdhtT5mjnY@public.gmane.org>, doug.hatch-VXdhtT5mjnY@public.gmane.org, ishii.hironobu-+CUm20s59erQFUHtdCDX3A@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, billsumnerlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, li.zhang6-VXdhtT5mjnY@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 04/03/15 at 05:21pm, Dave Young wrote:
> On 04/03/15 at 05:01pm, Li, ZhenHua wrote:
> > Hi Dave,
> > 
> > There may be some possibilities that the old iommu data is corrupted by
> > some other modules. Currently we do not have a better solution for the
> > dmar faults.
> > 
> > But I think when this happens, we need to fix the module that corrupted
> > the old iommu data. I once met a similar problem in normal kernel, the
> > queue used by the qi_* functions was written again by another module.
> > The fix was in that module, not in iommu module.
> 
> It is too late, there will be no chance to save vmcore then.
> 
> Also if it is possible to continue corrupt other area of oldmem because
> of using old iommu tables then it will cause more problems.
> 
> So I think the tables at least need some verifycation before being used.
> 

Yes, it's a good thinking anout this and verification is also an
interesting idea. kexec/kdump do a sha256 calculation on loaded kernel
and then verify this again when panic happens in purgatory. This checks
whether any code stomps into region reserved for kexec/kernel and corrupt
the loaded kernel.

If this is decided to do it should be an enhancement to current
patchset but not a approach change. Since this patchset is going very
close to point as maintainers expected maybe this can be merged firstly,
then think about enhancement. After all without this patchset vt-d often
raised error message, hung.

By the way I tested this patchset it works very well on my HP z420 work
station.

Thanks
Baoquan
