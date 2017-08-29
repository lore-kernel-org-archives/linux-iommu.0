From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: FW: [PATCH 2/3] iommu: mtk: constify iommu_ops
Date: Tue, 29 Aug 2017 13:43:33 +0800
Message-ID: <1503985413.11452.12.camel@mhfsdcap03>
References: <80e3d51296564c929a039ac83d83dd94@mtkmbs01n1.mediatek.inc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <80e3d51296564c929a039ac83d83dd94-fSWMoTp6f3O9JaaB6nfwCW/AB3i2Q03W@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Arvind Yadav <arvind.yadav.cs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

> From: Linux-mediatek [mailto:linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org] On Behalf Of Arvind Yadav
> Sent: Monday, August 28, 2017 8:12 PM
> To: m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org; joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; gerald.schaefer-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org
> Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> Subject: [PATCH 2/3] iommu: mtk: constify iommu_ops
> 
> iommu_ops are not supposed to change at runtime.
> Functions 'iommu_device_set_ops' and 'bus_set_iommu' working with
> const iommu_ops provided by <linux/iommu.h>. So mark the non-const
> structs as const.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>


Thanks.

Reviewed-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>

nit, the title should be: iommu/mediatek:xxx

Also, the file mtk_iommu.c may need rebase on[1].

[1]https://lists.linuxfoundation.org/pipermail/iommu/2017-August/023847.html
