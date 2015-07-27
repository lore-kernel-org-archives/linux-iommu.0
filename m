From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 03/18] iommu: tegra-smmu: fix iova_to_phys() method
Date: Mon, 27 Jul 2015 13:29:00 +0100
Message-ID: <E1ZJhWe-00043f-KS@rmk-PC.arm.linux.org.uk>
References: <20150727122824.GH7557@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150727122824.GH7557@n2100.arm.linux.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Cc: Alexandre Courbot <gnurou@gmail.com>, Joerg Roedel <joro@8bytes.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Hiroshi Doyu <hdoyu@nvidia.com>
List-Id: iommu@lists.linux-foundation.org

iova_to_phys() has several problems:
(a) iova_to_phys() is supposed to return 0 if there is no entry present
    for the iova.
(b) if as_get_pte() fails, we oops the kernel by dereferencing a NULL
    pointer.  Really, we should not even be trying to allocate a page
    table at all, but should only be returning the presence of the 2nd
    level page table.  This will be fixed in a subsequent patch.

Treat both of these conditions as "no mapping" conditions.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/iommu/tegra-smmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index c1f2e521dc52..083354903a1a 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -592,6 +592,9 @@ static phys_addr_t tegra_smmu_iova_to_phys(struct iommu_domain *domain,
 	u32 *pte;
 
 	pte = as_get_pte(as, iova, &page);
+	if (!pte || !*pte)
+		return 0;
+
 	pfn = *pte & as->smmu->pfn_mask;
 
 	return PFN_PHYS(pfn);
-- 
2.1.0
