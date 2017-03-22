From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 4/4] iommu/dma: Make PCI window reservation generic
Date: Wed, 22 Mar 2017 16:19:47 +0100
Message-ID: <20170322151947.GE7315@8bytes.org>
References: <cover.1489683129.git.robin.murphy@arm.com>
	<3876a855b7b5ba4684ac3e3af632b817d224c753.1489683129.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3876a855b7b5ba4684ac3e3af632b817d224c753.1489683129.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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
Cc: gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Mar 16, 2017 at 05:00:19PM +0000, Robin Murphy wrote:
> Now that we're applying the IOMMU API reserved regions to our IOVA
> domains, we shouldn't need to privately special-case PCI windows, or
> indeed anything else which isn't specific to our iommu-dma layer.
> However, since those aren't IOMMU-specific either, rather than start
> duplicating code into IOMMU drivers let's transform the existing
> function into an iommu_get_resv_regions() helper that they can share.
> 
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
> 
> Notes:
>     v2:
>     - New
> 
>  drivers/iommu/arm-smmu-v3.c |  2 ++
>  drivers/iommu/arm-smmu.c    |  2 ++
>  drivers/iommu/dma-iommu.c   | 38 ++++++++++++++++++++++++++++----------
>  include/linux/dma-iommu.h   |  5 +++++
>  4 files changed, 37 insertions(+), 10 deletions(-)

Applied patches 2-4 to my arm/core branch, thanks.
