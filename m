From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [RESEND PATCH] iommu: Split iommu_unmaps
Date: Thu, 20 Jun 2013 17:27:11 +0200
Message-ID: <20130620152711.GG3589@8bytes.org>
References: <20130618015642.20826.30187.stgit@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130618015642.20826.30187.stgit-xdHQ/5r00wBBDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Jun 17, 2013 at 07:57:34PM -0600, Alex Williamson wrote:
> iommu_map splits requests into pages that the iommu driver reports
> that it can handle.  The iommu_unmap path does not do the same.  This
> can cause problems not only from callers that might expect the same
> behavior as the map path, but even from the failure path of iommu_map,
> should it fail at a point where it has mapped and needs to unwind a
> set of pages that the iommu driver cannot handle directly.  amd_iommu,
> for example, will BUG_ON if asked to unmap a non power of 2 size.
> 
> Fix this by extracting and generalizing the sizing code from the
> iommu_map path and use it for both map and unmap.

Very true, thanks for fixing this.

Applied to the core branch.
