From: 'Joerg Roedel' <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/4] iommu/exynos: enhancements of System MMU driver with
	DT
Date: Sat, 17 Nov 2012 13:49:18 +0100
Message-ID: <20121117124918.GC11220@8bytes.org>
References: <002401cdc245$32dbf3e0$9893dba0$%cho@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <002401cdc245$32dbf3e0$9893dba0$%cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: 'Kukjin Kim' <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, 'Subash Patel' <subash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Sanghyun Lee' <sanghyun75.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Nov 14, 2012 at 05:51:12PM +0900, Cho KyongHo wrote:
> This commit enhances power management of System MMU and its client
> devices with the following changes:
>  - Each System MMU device becomes the parent device of its client
>    device while probe(). Thus, exynos-iommu driver must be initialized
>    before client devices.
>  - System MMU driver does not pm_runtime_get/put() by itself and runtime
>    power gating is performed by client devices.
>  - System is safe when suspend/resume without any care by client device
>    drivers.
> 
> In addition, System MMUs can be seperate into several groups that are
> belongs to a single client device like FIMC-IS block. If such blocks are
> controlled by a single device descriptor, all System MMUs in the blocks
> must be enabled/disabled by a single device descriptor. The problem is
> that clock gating and power gating may be not the same among all System
> MMUs in the blocks. Thus, System MMUs are grouped by clock gating and
> power gating and they are chained by parent-child relationships.
> 
> exynos-iommu driver now also supports debugfs to identify the state of
> each System MMU.
> 
> The last big change is to support DT. The desription of the properties
> of DT nodes are described in the source file.
> 
> Signed-off-by: KyongHo Cho <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/iommu/Kconfig        |   17 +-
>  drivers/iommu/exynos-iommu.c | 1420 +++++++++++++++++++++++++++++++-----------
>  2 files changed, 1077 insertions(+), 360 deletions(-)

This patch does multiple things and is quite large. Please split it down
into reasonable chunks and resubmit.

Patches 1-3 look good to me and I do not mind taking them for 3.8.
Please let me know if you prefer these patches standalone in 3.8 or
together with this patch split up.


	Joerg
