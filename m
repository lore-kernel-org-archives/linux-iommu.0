From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 3/3] iommu/io-pgtable: Avoid redundant TLB syncs
Date: Tue, 12 Jan 2016 18:27:55 +0000
Message-ID: <20160112182754.GC22186@arm.com>
References: <cover.1450383740.git.robin.murphy@arm.com>
	<eb7458ed51b800f035976e879530ab1e90d02858.1450383740.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <eb7458ed51b800f035976e879530ab1e90d02858.1450383740.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Dec 17, 2015 at 08:50:59PM +0000, Robin Murphy wrote:
> In certain unmapping situations it is quite possible to end up issuing
> back-to-back TLB synchronisations, which at best is a waste of time and
> effort, and at worst causes some hardware to get rather confused. Whilst
> the pagetable implementations, or the IOMMU drivers, or both, could keep
> track of things to avoid this happening, it seems to make the most sense
> to prevent code duplication and add some simple state tracking in the
> common interface between the two.
> 
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/iommu/io-pgtable.h | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
> index 95c5565..d06219b 100644
> --- a/drivers/iommu/io-pgtable.h
> +++ b/drivers/iommu/io-pgtable.h
> @@ -132,12 +132,14 @@ void free_io_pgtable_ops(struct io_pgtable_ops *ops);
>   * @fmt:    The page table format.
>   * @cookie: An opaque token provided by the IOMMU driver and passed back to
>   *          any callback routines.
> + * @sync_flag: Private flag for optimising out redundant syncs.

It makes sense to factor this out like you're proposing, but maybe we
can think of a better name? How about "tlb_sync_pending", to follow
"tlb_flush_pending" in the core code?

Will
