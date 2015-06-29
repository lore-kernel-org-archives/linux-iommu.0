From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH] iommu: Ignore -ENODEV errors from add_device call-back
 returning -ENODEV
Date: Mon, 29 Jun 2015 10:35:34 +0200
Message-ID: <20150629083534.GG18569@8bytes.org>
References: <1435237844-25004-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1435237844-25004-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, Shaik Ameer Basha <shaik.ameer@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, Inki Dae <inki.dae@samsung.com>, Javier Martinez Canillas <javier@dowhile0.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Hi Marek,

On Thu, Jun 25, 2015 at 03:10:44PM +0200, Marek Szyprowski wrote:
> +	/* skip devices which doesn't have sysmmu controller */
>  	if (!has_sysmmu(dev))
> -		return -ENODEV;
> +		return 0;

Thanks for reporting this! But I think that the -ENODEV return value
could be of use for the iommu core in the future. Can you please try the
attached patch, which just ignores -ENODEV as a return value from
add_device?

>From 3c9e7507e93ff6c6e05e6ee2cb123b5d35d8c412 Mon Sep 17 00:00:00 2001
From: Joerg Roedel <jroedel@suse.de>
Date: Mon, 29 Jun 2015 10:16:08 +0200
Subject: [PATCH] iommu: Ignore -ENODEV errors from add_device call-back

The -ENODEV error just means that the device is not
translated by an IOMMU. We shouldn't bail out of iommu
driver initialization when that happens, as this is a common
scenario on ARM.

No returning -ENODEV in the drivers would be a bad idea, as
the IOMMU core would have no indication whether a device is
translated or not. This information is not used at the
moment, but will probably be in the future.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/iommu.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 49e7542..f286090 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -847,13 +847,24 @@ static int add_iommu_group(struct device *dev, void *data)
 {
 	struct iommu_callback_data *cb = data;
 	const struct iommu_ops *ops = cb->ops;
+	int ret;
 
 	if (!ops->add_device)
 		return 0;
 
 	WARN_ON(dev->iommu_group);
 
-	return ops->add_device(dev);
+	ret = ops->add_device(dev);
+
+	/*
+	 * We ignore -ENODEV errors for now, as they just mean that the
+	 * device is not translated by an IOMMU. We still care about
+	 * other errors and fail to initialize when they happen.
+	 */
+	if (ret == -ENODEV)
+		ret = 0;
+
+	return ret;
 }
 
 static int remove_iommu_group(struct device *dev, void *data)
-- 
1.8.4.5
