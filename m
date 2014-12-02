From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] iommu: Decouple iommu_map_sg from CPU page size
Date: Tue, 2 Dec 2014 13:05:39 +0100
Message-ID: <20141202120539.GB32294@8bytes.org>
References: <2d38d270a532b52f73a720572f8f085dfa08321e.1416936761.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2d38d270a532b52f73a720572f8f085dfa08321e.1416936761.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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

On Tue, Nov 25, 2014 at 05:50:55PM +0000, Robin Murphy wrote:
> If the IOMMU supports pages smaller than the CPU page size, segments
> which lie at offsets within the CPU page may be mapped based on the
> finer-grained IOMMU page boundaries. This minimises the amount of
> non-buffer memory between the CPU page boundary and the start of the
> segment which must be mapped and therefore exposed to the device, and
> brings the default iommu_map_sg implementation in line with
> iommu_map/unmap with respect to alignment.
> 
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
> 
> Hi Joerg,
> 
> I noticed this whilst wiring up DMA mapping to this new API - on arm64
> we anticipate running 4k IOMMU pages with 64k CPU pages, in which case
> the alignment check ends up being unnecessarily strict.

Applied to the core branch, thanks.


	Joerg
