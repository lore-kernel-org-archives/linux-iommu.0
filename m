From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 07/20] iommu/amd: Remove special mapping code for dma_ops
	path
Date: Tue, 12 Jul 2016 13:48:06 +0200
Message-ID: <20160712114806.GC27306@suse.de>
References: <1467978311-28322-1-git-send-email-joro@8bytes.org>
	<1467978311-28322-8-git-send-email-joro@8bytes.org>
	<5784CCAB.8000007@arm.com> <20160712110839.GF12639@8bytes.org>
	<5784D7C3.4010104@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5784D7C3.4010104-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Vincent.Wan-5C7GfCeVMHo@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

On Tue, Jul 12, 2016 at 12:42:59PM +0100, Robin Murphy wrote:
> Ah, that's the angle I was missing, yes. So if, say, someone is mapping
> a page at IOVA 0x0000 while someone else is mapping a page at 0x1000,
> there could still be a race between both callers writing the non-leaf
> PTEs, but it's benign since they'd be writing identical entries anyway.
> Seems reasonable to me (I assume in a similar map vs. unmap race, the
> unmapper would just be removing the leaf entry, rather than bothering to
> check for empty tables and tear down intermediate levels, so the same
> still applies).

The non-leaf PTE setup code checks for races with cmpxchg, so we are on
the safe side there. Two threads would write different entries there,
because they are allocating differnt sub-pages, but as I said, this is
checked for using cmpxchg. On the PTE level this problem does not exist.


	Joerg
