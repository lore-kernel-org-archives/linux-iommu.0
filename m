From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC PATCH v3 1/7] iommu: provide early initialisation hook for
 IOMMU drivers
Date: Thu, 18 Sep 2014 15:31:54 +0100
Message-ID: <541AECDA.1000805@arm.com>
References: <1410539695-29128-1-git-send-email-will.deacon@arm.com>
 <1410539695-29128-2-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1410539695-29128-2-git-send-email-will.deacon@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Will Deacon <will.deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Cc: "jroedel@suse.de" <jroedel@suse.de>, "arnd@arndb.de" <arnd@arndb.de>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>, "Varun.Sethi@freescale.com" <Varun.Sethi@freescale.com>, "hdoyu@nvidia.com" <hdoyu@nvidia.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Hi Will,

After some fun times wondering why on Earth of_iommu_init was trying to 
instantiate a GIC, I think we may need one of these as part of this 
patch, too ;)

Robin.

--->8---

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 8656b63..1927691 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -24,6 +24,9 @@
  #include <linux/of_iommu.h>
  #include <linux/slab.h>

+static const struct of_device_id __iommu_of_table_sentinel
+       __used __section(__iommu_of_table_end);
+
  /**
   * of_get_dma_window - Parse *dma-window property and returns 0 if found.
   *
