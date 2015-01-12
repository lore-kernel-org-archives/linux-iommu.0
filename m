From: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v8 02/10] iommu/vt-d: Items required for kdump
Date: Mon, 12 Jan 2015 10:29:19 -0500
Message-ID: <20150112152919.GA16162@redhat.com>
References: <1421046388-27925-1-git-send-email-zhen-hual@hp.com>
	<1421046388-27925-3-git-send-email-zhen-hual@hp.com>
	<20150112152207.GC6343@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150112152207.GC6343-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, tom.vaden-VXdhtT5mjnY@public.gmane.org, rwright-VXdhtT5mjnY@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lisa.mitchell-VXdhtT5mjnY@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, "Li,
	Zhen-Hua" <zhen-hual-VXdhtT5mjnY@public.gmane.org>, doug.hatch-VXdhtT5mjnY@public.gmane.org, ishii.hironobu-+CUm20s59erQFUHtdCDX3A@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, billsumnerlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, li.zhang6-VXdhtT5mjnY@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Jan 12, 2015 at 04:22:08PM +0100, Joerg Roedel wrote:
> On Mon, Jan 12, 2015 at 03:06:20PM +0800, Li, Zhen-Hua wrote:
> > +
> > +#ifdef CONFIG_CRASH_DUMP
> > +
> > +/*
> > + * Fix Crashdump failure caused by leftover DMA through a hardware IOMMU
> > + *
> > + * Fixes the crashdump kernel to deal with an active iommu and legacy
> > + * DMA from the (old) panicked kernel in a manner similar to how legacy
> > + * DMA is handled when no hardware iommu was in use by the old kernel --
> > + * allow the legacy DMA to continue into its current buffers.
> > + *
> > + * In the crashdump kernel, this code:
> > + * 1. skips disabling the IOMMU's translating of IO Virtual Addresses (IOVA).
> > + * 2. Do not re-enable IOMMU's translating.
> > + * 3. In kdump kernel, use the old root entry table.
> > + * 4. Leaves the current translations in-place so that legacy DMA will
> > + *    continue to use its current buffers.
> > + * 5. Allocates to the device drivers in the crashdump kernel
> > + *    portions of the iova address ranges that are different
> > + *    from the iova address ranges that were being used by the old kernel
> > + *    at the time of the panic.
> > + *
> > + */
> 
> It looks like you are still copying the io-page-tables from the old
> kernel into the kdump kernel, is that right? With the approach that was
> proposed you only need to copy over the context entries 1-1. They are
> still pointing to the page-tables in the old kernels memory (which is
> just fine).

Kdump has the notion of backup region. Where certain parts of old kernels
memory can be moved to a different location (first 640K on x86 as of now)
and new kernel can make use of this memory now.

So we will have to just make sure that no parts of this old page table
fall into backup region.

Thanks
Vivek
