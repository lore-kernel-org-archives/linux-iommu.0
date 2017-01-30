From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/2] iommu/dma: Stop getting dma_32bit_pfn wrong
Date: Mon, 30 Jan 2017 16:16:35 +0100
Message-ID: <20170130151635.GE28129@8bytes.org>
References: <d899aa686e7c8cb45142fa6785aa539ef3b88dec.1484572209.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <d899aa686e7c8cb45142fa6785aa539ef3b88dec.1484572209.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Jan 16, 2017 at 01:24:54PM +0000, Robin Murphy wrote:
> iommu_dma_init_domain() was originally written under the misconception
> that dma_32bit_pfn represented some sort of size limit for IOVA domains.
> Since the truth is almost the exact opposite of that, rework the logic
> and comments to reflect its real purpose of optimising lookups when
> allocating from a subset of the available 64-bit space.
> 
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
> 
> Sending this as a v2 since both patches have been seen before, and #1 is
> ever so slightly tweaked. #2 applies on top of Eric's MSI series, since
> that seems ready to go now - there is a trivial merge conflict otherwise
> around the extra argument in the __alloc_iova() call.
> 
> Robin.
> 
>  drivers/iommu/dma-iommu.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)

Applied both, thanks.
