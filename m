From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 3/7] iommu/arm-smmu: Work around MMU-500 prefetch errata
Date: Thu, 21 Apr 2016 17:15:53 +0100
Message-ID: <20160421161552.GI929@arm.com>
References: <cover.1460391217.git.robin.murphy@arm.com>
	<0484444b6257bfb6adb68405a72c64fc4fc98142.1460391217.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <0484444b6257bfb6adb68405a72c64fc4fc98142.1460391217.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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
Cc: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, brian.starkey-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 13, 2016 at 06:12:59PM +0100, Robin Murphy wrote:
> MMU-500 erratum #841119 is tickled by a particular set of circumstances
> interacting with the next-page prefetcher. Since said prefetcher is
> quite dumb and actually detrimental to performance in some cases (by
> causing unwanted TLB evictions for non-sequential access patterns), we
> lose very little by turning it off, and what we gain is a guarantee that
> the erratum is never hit.
> 
> As a bonus, the same workaround will also prevent erratum #826419 once
> v7 short descriptor support is implemented.
> 
> CC: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
> CC: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
>  Documentation/arm64/silicon-errata.txt |  1 +
>  drivers/iommu/arm-smmu.c               | 16 +++++++++++++++-
>  2 files changed, 16 insertions(+), 1 deletion(-)

Looks fine, but can you update silicon-errata.txt too, please? It's a
handy reference for "what is Linux actively working around" and this
one is somewhat hidden away.

Will
