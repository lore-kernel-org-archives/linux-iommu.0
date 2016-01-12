From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 2/3] iommu/io-pgtable: Add helper functions for TLB ops
Date: Tue, 12 Jan 2016 18:28:58 +0000
Message-ID: <20160112182857.GD22186@arm.com>
References: <cover.1450383740.git.robin.murphy@arm.com>
	<a2a13711c528af068e932ce6af4c3be50bef5812.1450383740.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <a2a13711c528af068e932ce6af4c3be50bef5812.1450383740.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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

On Thu, Dec 17, 2015 at 08:50:58PM +0000, Robin Murphy wrote:
> Add some simple wrappers to avoid having the guts of the TLB operations
> spilled all over the page table implementations, and to provide a point
> to implement extra common functionality.
> 
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/iommu/io-pgtable-arm-v7s.c | 48 ++++++++++++++++----------------------
>  drivers/iommu/io-pgtable-arm.c     | 21 +++++++----------
>  drivers/iommu/io-pgtable.c         |  2 +-
>  drivers/iommu/io-pgtable.h         | 16 +++++++++++++
>  4 files changed, 46 insertions(+), 41 deletions(-)

Looks sensible to me:

  Acked-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>

I'd like to see a review from Yong Wu on the short descriptor stuff
before I queue any of this, though.

Will
