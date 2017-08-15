From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH v10 00/12] Fix the on-flight DMA issue on system with amd
	iommu
Date: Tue, 15 Aug 2017 18:18:10 +0200
Message-ID: <20170815161810.GI2853@suse.de>
References: <1502267624-7066-1-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1502267624-7066-1-git-send-email-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Aug 09, 2017 at 04:33:32PM +0800, Baoquan He wrote:
> Baoquan He (12):
>   iommu/amd: Detect pre enabled translation
>   iommu/amd: add several helper functions
>   Revert "iommu/amd: Suppress IO_PAGE_FAULTs in kdump kernel"
>   iommu/amd: Define bit fields for DTE particularly
>   iommu/amd: Add function copy_dev_tables()
>   iommu/amd: copy old trans table from old kernel
>   iommu/amd: Do sanity check for address translation and irq remap of
>     old dev table entry
>   iommu: Add is_attach_deferred call-back to iommu-ops
>   iommu/amd: Use is_attach_deferred call-back
>   iommu/amd: Allocate memory below 4G for dev table if translation
>     pre-enabled
>   iommu/amd: Don't copy GCR3 table root pointer
>   iommu/amd: Disable iommu only if amd_iommu=off is specified

Applied all of them, thanks a lot for your continued effort, Baoquan!
