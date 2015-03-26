From: Swapna Nannapaneni <sainswapna@gmail.com>
Subject: Re: [PATCH 02/16] iommu: Introduce iommu domain types
Date: Thu, 26 Mar 2015 08:52:51 -0400
Message-ID: <20150326125251.5005382.96732.4883@gmail.com>
References: <1427373799-18662-1-git-send-email-joro@8bytes.org>
 <1427373799-18662-3-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1427373799-18662-3-git-send-email-joro@8bytes.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: Will Deacon <will.deacon@arm.com>, Kukjin Kim <kgene@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Heiko Stuebner <heiko@sntech.de>, Hiroshi Doyu <hdoyu@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Yingjoe Chen <yingjoe.chen@mediatek.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, jroedel@suse.de
List-Id: iommu@lists.linux-foundation.org

X

Sent=A0from=A0my=A0BlackBerry=A010=A0smartphone=A0on=A0the=A0TELUS=A0ne=
twork.
=A0 Original Message =A0
=46rom: Joerg Roedel
Sentuv: Thursday, March 26, 2015 8:51 AM
To: iommu@lists.linux-foundation.org
Cc: Will Deacon; Kukjin Kim; David Woodhouse; Heiko Stuebner; Hiroshi D=
oyu; Stephen Warren; Thierry Reding; Alexandre Courbot; Alex Williamson=
; Arnd Bergmann; Yingjoe Chen; linux-kernel@vger.kernel.org; linux-arm-=
kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.org; linux-ro=
ckchip@lists.infradead.org; linux-tegra@vger.kernel.org; Joerg Roedel; =
jroedel@suse.de
Subject: [PATCH 02/16] iommu: Introduce iommu domain types

=46rom: Joerg Roedel <jroedel@suse.de>

This allows to handle domains differently based on their
type in the future. An IOMMU driver can implement certain
optimizations for DMA-API domains for example.

The domain types can be extended later and some of the
existing domain attributes can be migrated to become domain
flags.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
drivers/iommu/iommu.c | 5 +++--
include/linux/iommu.h | 27 ++++++++++++++++++++++++++-
2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 11de262..4920605 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -909,14 +909,15 @@ struct iommu_domain *iommu_domain_alloc(struct bu=
s_type *bus)
ops =3D bus->iommu_ops;

if (ops->domain_alloc)
-	 domain =3D ops->domain_alloc();
+	 domain =3D ops->domain_alloc(IOMMU_DOMAIN_UNMANAGED);
else
domain =3D kzalloc(sizeof(*domain), GFP_KERNEL);

if (!domain)
return NULL;

-	domain->ops =3D bus->iommu_ops;
+	domain->ops =3D bus->iommu_ops;
+	domain->type =3D IOMMU_DOMAIN_UNMANAGED;

if (ops->domain_init && domain->ops->domain_init(domain))
goto out_free;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 69d1d12..72d03fe 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -51,7 +51,32 @@ struct iommu_domain_geometry {
bool force_aperture; /* DMA only allowed in mappable range? */
};

+/* Domain feature flags */
+#define __IOMMU_DOMAIN_PAGING	(1U << 0) /* Support for iommu_map/unmap=
 */
+#define __IOMMU_DOMAIN_DMA_API	(1U << 1) /* Domain for use in DMA-API
+	 implementation */
+#define __IOMMU_DOMAIN_PT	(1U << 2) /* Domain is identity mapped */
+
+/*
+ * This are the possible domain-types
+ *
+ *	IOMMU_DOMAIN_BLOCKED	- All DMA is blocked, can be used to isolate
+ *	 devices
+ *	IOMMU_DOMAIN_IDENTITY	- DMA addresses are system physical addresses
+ *	IOMMU_DOMAIN_UNMANAGED	- DMA mappings managed by IOMMU-API user, us=
ed
+ *	 for VMs
+ *	IOMMU_DOMAIN_DMA	- Internally used for DMA-API implementations.
+ *	 This flag allows IOMMU drivers to implement
+ *	 certain optimizations for these domains
+ */
+#define IOMMU_DOMAIN_BLOCKED	(0U)
+#define IOMMU_DOMAIN_IDENTITY	(__IOMMU_DOMAIN_PT)
+#define IOMMU_DOMAIN_UNMANAGED (__IOMMU_DOMAIN_PAGING)
+#define IOMMU_DOMAIN_DMA	(__IOMMU_DOMAIN_PAGING |	\
+	 __IOMMU_DOMAIN_DMA_API)
+
struct iommu_domain {
+	unsigned type;
const struct iommu_ops *ops;
void *priv;
iommu_fault_handler_t handler;
@@ -117,7 +142,7 @@ struct iommu_ops {
void (*domain_destroy)(struct iommu_domain *domain);

/* Domain allocation and freeing by the iommu driver */
-	struct iommu_domain *(*domain_alloc)(void);
+	struct iommu_domain *(*domain_alloc)(unsigned iommu_domain_type);
void (*domain_free)(struct iommu_domain *);

int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
--=20
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-samsung=
-soc" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at http://vger.kernel.org/majordomo-info.html
