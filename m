From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v11 0/10] iommu/vt-d: Fix intel vt-d faults in kdump kernel
Date: Mon, 8 Jun 2015 17:29:58 +0200
Message-ID: <20150608152957.GW20384@8bytes.org>
References: <1431337974-545-1-git-send-email-zhen-hual@hp.com>
	<1433773583.2952.52.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1433773583.2952.52.camel-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, tom.vaden-VXdhtT5mjnY@public.gmane.org, rwright-VXdhtT5mjnY@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lisa.mitchell-VXdhtT5mjnY@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, "Li,
	Zhen-Hua" <zhen-hual-VXdhtT5mjnY@public.gmane.org>, doug.hatch-VXdhtT5mjnY@public.gmane.org, ishii.hironobu-+CUm20s59erQFUHtdCDX3A@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, billsumnerlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, li.zhang6-VXdhtT5mjnY@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Jun 08, 2015 at 03:26:23PM +0100, David Woodhouse wrote:
> There are some interesting corner cases to handle here.
> 
> Firstly, you don't seem to handle the case of extended root/context
> tables (where ecap_ecs is set). You need to preserve the DMA_RTADDR_RT
> bit in the Root Table Address register, surely?
> 
> I think we also need to cope with inheriting page tables from a kernel
> that *doesn't* use extended page tables, even on hardware that supports
> it. Which means the use of extended page tables in the new kernel would
> need to be contingent on something *other* than the pure hardware
> capabilities.

Hmm, I also limited this functionality to kdump kernels. Do we still
need to preserve these extended data structures even when there is no
upstream support for them yet?

> > 5. Keep using the old page tables before driver is loaded.
> > 6. After device driver is loaded, when it issues the first dma_map command, 
> >    free the dmar_domain structure for this device, and generate a new one, so 
> >    that the device can be assigned a new and empty page table. 
> 
> What if there were RMRRs for this device? Don't we need to ensure that
> those are present in the "new and empty page table" when we take it
> over?

That is still a problem, but not specific to this patch-set. RMRRs will
not be restored, because domains allocated out of the DMA-API path will
not get any RMRR mappings. This is also a problem with device hotplug
(unplug a device with RMRRs and replug it in and the RMRR mappings will
 be gone).

I agree that this needs to be fixed.


	Joerg
