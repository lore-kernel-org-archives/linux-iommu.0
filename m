From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] iommu/rockchip: make clock handling optional
Date: Thu, 3 May 2018 14:59:31 +0200
Message-ID: <20180503125931.mffsj32oy62kqhu5@8bytes.org>
References: <20180417120915.31535-1-heiko@sntech.de> <1951663.B4MoXU0Rz2@phil>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1951663.B4MoXU0Rz2@phil>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Cc: jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org, vicencb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org, tomeu-XCtybt49RKsYaV1qd6yewg@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, May 01, 2018 at 11:57:29AM +0200, Heiko Stuebner wrote:
> Ho Joerg,
> 
> Am Dienstag, 17. April 2018, 14:09:15 CEST schrieb Heiko Stuebner:
> > iommu clocks are optional, so the driver should not fail if they are not
> > present. Instead just set the number of clocks to 0, which the clk-blk APIs
> > can handle just fine.
> > 
> > Fixes: f2e3a5f557ad ("iommu/rockchip: Control clocks needed to access the IOMMU")
> > Signed-off-by: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
> > Reviewed-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> 
> could you pick up this patch as fix for 4.17 please?
> As without it, we loose display output with old devicetrees.

Applied to the iommu/fixes branch, thanks.
