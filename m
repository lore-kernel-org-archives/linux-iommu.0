From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v11 02/10] iommu/vt-d: Items required for kdump
Date: Wed, 13 May 2015 16:42:26 +0800
Message-ID: <20150513084226.GO4561@localhost.localdomain>
References: <1431337974-545-1-git-send-email-zhen-hual@hp.com>
	<1431337974-545-3-git-send-email-zhen-hual@hp.com>
	<20150512081723.GC4561@localhost.localdomain>
	<5552ACB9.5050309@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5552ACB9.5050309-VXdhtT5mjnY@public.gmane.org>
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

On 05/13/15 at 09:45am, Li, ZhenHua wrote:
> On 05/12/2015 04:17 PM, Dave Young wrote:
> >On 05/11/15 at 05:52pm, Li, Zhen-Hua wrote:
> >>Add context entry functions needed for kdump.
> >>+/*
> >>+ * Fix Crashdump failure caused by leftover DMA through a hardware IOMMU
> >>+ *
> >>+ * Fixes the crashdump kernel to deal with an active iommu and legacy
> >>+ * DMA from the (old) panicked kernel in a manner similar to how legacy
> >>+ * DMA is handled when no hardware iommu was in use by the old kernel --
> >>+ * allow the legacy DMA to continue into its current buffers.
> >>+ *
> >>+ * In the crashdump kernel, this code:
> >>+ * 1. skips disabling the IOMMU's translating.
> >>+ * 2. Do not re-enable IOMMU's translating.
> >>+ * 3. In kdump kernel, use the old root entry table.
> >>+ * 4. Allocate pages for new context entry, copy data from old context entries
> >>+ *    in the old kernel to the new ones.
> >>+ *
> >>+ * In other kinds of kernel, for example, a kernel started by kexec,
> >>+ * do the same thing as crashdump kernel.
> >>+ */
> >>+
> >>+
> >
> >Above comments should come along with the code changes instead of putting it
> >in this patch.
> >
> >BTW, there's one more blank line at the end..
> Code change is in 00/10, the cover letter.

I means the real code, not the changelog.

> And the blank does not matter, I checked the patch with
> scripts/checkpatch.pl,  no warnings, no errors.

Why add two line breaks if one is enough? Adding such check in checkpatch.pl
make sense to me actually.

Thanks
Dave
