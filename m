From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2] iommu/ipmmu-vmsa: Use the ARM LPAE page table allocator
Date: Wed, 21 Jan 2015 14:44:20 +0000
Message-ID: <20150121144419.GJ4549@arm.com>
References: <20150119140106.GM6343@8bytes.org>
	<1421771404-22774-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1421771404-22774-1-git-send-email-laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jan 20, 2015 at 04:30:04PM +0000, Laurent Pinchart wrote:
> Replace the custom page table allocation implementation with the
> standard allocator.
> 
> The driver loses the ability to map 64kB chunkgs using the PTE
> contiguous hint, hence the removal of the SZ_64K page size from the
> IOMMU page sizes bitmap.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> ---
>  drivers/iommu/Kconfig      |   1 +
>  drivers/iommu/ipmmu-vmsa.c | 554 +++++----------------------------------------
>  2 files changed, 61 insertions(+), 494 deletions(-)
> 
> This patch depends on Will Deacon's "[PATCH v2 0/5] Generic IOMMU page table
> framework" series.
> 
> Joerg, if you want to merge Will's patches in v3.20 with one user, this is a
> good candidate.
> 
> Changes since v1:
> 
> - Rebased on top of latest page table framework and iommu next branch.

Laurent, this is really good stuff, thanks!

Shall I queue this on top of the iommu/pgtbl patches, or do you have other
ipmmu patches queued?

Will
