From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v7 21/24] iommu/tegra: gart: Prepend error/debug messages with "gart:"
Date: Wed, 12 Dec 2018 23:39:04 +0300
Message-ID: <20181212203907.23461-22-digetx@gmail.com>
References: <20181212203907.23461-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181212203907.23461-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

GART became a part of Memory Controller, hence now the drivers device
is Memory Controller and not GART. As a result all printed messages are
prepended with the "tegra-mc 7000f000.memory-controller:", so let's
prepend GART's messages with "gart:" in order to differentiate them
from the MC.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/tegra-gart.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 2e0e6aff8f70..a3ce6918577d 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -19,6 +19,8 @@
  * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
+#define dev_fmt(fmt)	"gart: " fmt
+
 #include <linux/io.h>
 #include <linux/iommu.h>
 #include <linux/list.h>
-- 
2.20.0
