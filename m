From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v8 02/10] iommu/vt-d: Items required for kdump
Date: Tue, 13 Jan 2015 12:52:53 +0100
Message-ID: <20150113115252.GH6343@8bytes.org>
References: <1421046388-27925-1-git-send-email-zhen-hual@hp.com>
	<1421046388-27925-3-git-send-email-zhen-hual@hp.com>
	<20150112152207.GC6343@8bytes.org> <54B4D36D.8030204@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54B4D36D.8030204-VXdhtT5mjnY@public.gmane.org>
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
Cc: bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, tom.vaden-VXdhtT5mjnY@public.gmane.org, rwright-VXdhtT5mjnY@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lisa.mitchell-VXdhtT5mjnY@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, doug.hatch-VXdhtT5mjnY@public.gmane.org, ishii.hironobu-+CUm20s59erQFUHtdCDX3A@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, billsumnerlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, li.zhang6-VXdhtT5mjnY@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Jan 13, 2015 at 04:12:29PM +0800, Li, ZhenHua wrote:

> Current status:
> 1. Use old root entry table,
> 2. Copy old context entry tables.
> 3. Copy old page tables.
> 4. Allocate new page table when device driver is loading.
> 
> I remember the progress we discussed was this. Checking the old mails,
> founding we did not clearly discuss about the old page tables, only
> agrred with allocating new page tables when device driver is loading.
> 
> To me, both of these two options are fine, copying old page tables, or
> re-use the old ones. My debugging shows both of them works fine.
> 
> If we use the old page tables, the patchset will use less code.
> Functions copy_page_addr, copy_page_table are no longer needed, and
> functions copy_context_entry and copy_context_entry_table will be
> reduced to several lines. The patchset will be much simpler.

Yes, please do it this way. There is no point in copying the old
page-tables. We never make changes to them, so they can stay where they
are.

The problem with the backup region still exists, but it is not
specific to IOMMUs. This problem and should be addressed seperatly.


	Joerg
