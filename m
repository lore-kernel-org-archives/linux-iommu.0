From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu: Drop the of_iommu_{set/get}_ops() interface
Date: Wed, 4 Jan 2017 15:19:39 +0000
Message-ID: <20170104151939.GK18193@arm.com>
References: <20170103173456.18154-1-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170103173456.18154-1-lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Jan 03, 2017 at 05:34:56PM +0000, Lorenzo Pieralisi wrote:
> With the introduction of the new iommu_{register/get}_instance()
> interface in commit e4f10ffe4c9b ("iommu: Make of_iommu_set/get_ops() DT
> agnostic") (based on struct fwnode_handle as look-up token, so firmware
> agnostic) to register IOMMU instances with the core IOMMU layer there is
> no reason to keep the old OF based interface around any longer.
> 
> Convert all the IOMMU drivers (and OF IOMMU core code) that rely on the
> of_iommu_{set/get}_ops() to the new kernel interface to register/retrieve
> IOMMU instances and remove the of_iommu_{set/get}_ops() remaining glue
> code in order to complete the interface rework.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
> Cc: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> Cc: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
> Cc: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
> Exynos, msm and mtk code compile tested only owing to lack of
> test platforms, I would appreciate some help in testing this
> patch on those platforms before merging it even if it is just
> a simple interface conversion.
> 
> Thanks,
> Lorenzo
> 
>  drivers/iommu/exynos-iommu.c |  2 +-
>  drivers/iommu/msm_iommu.c    |  2 +-
>  drivers/iommu/mtk_iommu.c    |  2 +-
>  drivers/iommu/of_iommu.c     |  4 ++--
>  include/linux/of_iommu.h     | 11 -----------
>  5 files changed, 5 insertions(+), 16 deletions(-)

Thanks for following up with this cleanup, Lorenzo. I'll queue it locally,
and send it to Joerg for 4.11 if he doesn't apply it manually before then.

Will
