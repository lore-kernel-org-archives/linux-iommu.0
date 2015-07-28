From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH v2 01/11] iommu/vt-d: Cache PCI ATS state and Invalidate
	Queue Depth
Date: Tue, 28 Jul 2015 09:14:18 +0200
Message-ID: <20150728071417.GK27614@suse.de>
References: <20150721001243.28145.81610.stgit@bhelgaas-glaptop2.roam.corp.google.com>
	<20150721001357.28145.83631.stgit@bhelgaas-glaptop2.roam.corp.google.com>
	<20150727130810.GG27614@suse.de>
	<20150727225453.GB24401@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150727225453.GB24401-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Gregor Dick <gdick-s/n/eUQHGBpZroRs9YW3xA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Bjorn,

On Mon, Jul 27, 2015 at 05:54:53PM -0500, Bjorn Helgaas wrote:
> > Hmm, this is a place where the relaxed error handling in
> > pci_enable_ats() can get problematic. 
> 
> By "relaxed error handling," do you mean the fact that in v4.1,
> pci_enable_ats() has a BUG_ON(is_enabled), while now it merely
> returns -EINVAL?
> 
> (BTW, I did change it to add a WARN_ON and return -EBUSY as you suggested.)

Okay, great.

> > If ATS is (by accident or a bug
> > elsewhere) already enabled an the function returns -EINVAL, the IOMMU
> > driver considers ATS disabled and doesn't flush the IO/TLBs of the
> > device. This can cause data corruption later on, so we should make sure
> > that info->ats.enabled is consistent with pdev->ats_enabled.
> 
> I'm not quite sure I understand this.  In the patch above, we only set
> "info->ats.enabled = 1" if pci_enable_ats() has succeeded.  The amd_iommu.c
> code is similar.
> 
> Are you concerned about the case where future code enables ATS before
> intel-iommu, the pci_enable_ats() in intel-iommu fails, intel-iommu
> believes ATS is disabled, intel-iommu calls iommu_flush_dev_iotlb(), but it
> doesn't flush the IOTLB?
> 
> I guess I could make intel-iommu handle -EBUSY differently from -EINVAL.
> Would that help?  It seems sort of clumsy, but ...?

I was concerned that it was harder now to spot bugs in ATS
enabling/disabling, when pci_enable_ats just returns -EINVAL when ATS is
already enabled.

But with the WARN_ON now we will notice these bugs early again, thanks
for adding it.



	Joerg
