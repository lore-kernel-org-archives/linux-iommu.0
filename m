From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH 03/22] iommu: Propagate error in add_iommu_group
Date: Mon, 29 Jun 2015 11:28:40 +0200
Message-ID: <7180470.n5cCZefX9d@diego>
References: <1432831305-11126-1-git-send-email-joro@8bytes.org>
	<1432831305-11126-4-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1432831305-11126-4-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,


Am Donnerstag, 28. Mai 2015, 18:41:26 schrieb Joerg Roedel:
> From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> 
> Make sure any errors reported from the IOMMU drivers get
> progapated back to the IOMMU core.
> 
> Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

sorry that this series slipped through my inbox without testing somehow. 
Anyway, it seems to have now made its way in the merge-window and everything 
on the Rockchip side still works - except this patch.

> ---
>  drivers/iommu/iommu.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 755e488..9c9336a 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -750,9 +750,7 @@ static int add_iommu_group(struct device *dev, void
> *data)
> 
>  	WARN_ON(dev->iommu_group);
> 
> -	ops->add_device(dev);
> -
> -	return 0;
> +	return ops->add_device(dev);
>  }
> 
>  static int iommu_bus_notifier(struct notifier_block *nb,

The Rockchip iommu uses bus_set_ops to set its iommu-ops for the platform
bus and currently returns -ENODEV if it encounters a platform_devices that
does not have an iommu. As add_iommu_group ignored these returns
till now this worked, but of course starts to fail now.

All two invocations of the add_device callback ignored (or still ignore) the
return value so I've come with the following small patch to fix the breakage
that now exists in the 4.2 tree.

There is probably a better solution possible in the longer term, likely
similar to what Samsung does, but I'm not sure yet how this would work
with our drm device that needs an iommu mapping without having an
iommu (the iommus being attached to the crtc-components).


Heiko


------------- 8< ------------------
From: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Date: Sun, 28 Jun 2015 12:50:01 +0200
Subject: [PATCH] iommu/rockchip: ignore non-master devices in rk_iommu_add_device

During init we set the rockchip iommu ops as bus_ops for the platform bus.
While all Rockchip devices implementing an iommu use these same ops, there
are also platform devices without iommu. Until recently bus_set_iommu
ignored errors from the add_device callback and we simply returned -ENODEV
for devices without iommu. But we can also simply ignore devices without
iommu which simply ends up doing the same as before the iommu change that
began checking add_device return values.

Signed-off-by: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Fixes: 19762d7095e6 ("iommu: Propagate error in add_iommu_group")
---
 drivers/iommu/rockchip-iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index ebf0adb..63bcf48 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -931,8 +931,9 @@ static int rk_iommu_add_device(struct device *dev)
 	struct iommu_group *group;
 	int ret;
 
+	/* nothing to do if device does not have an iommu */
 	if (!rk_iommu_is_dev_iommu_master(dev))
-		return -ENODEV;
+		return 0;
 
 	group = iommu_group_get(dev);
 	if (!group) {
-- 
2.1.4
