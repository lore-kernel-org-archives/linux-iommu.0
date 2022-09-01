Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0286980E;
	Thu,  1 Sep 2022 01:25:23 +0000 (UTC)
Received: from coburn.home.jannau.net (p54acc2ba.dip0.t-ipconnect.de [84.172.194.186])
	by soltyk.jannau.net (Postfix) with ESMTPSA id 1CBC726EF4D;
	Thu,  1 Sep 2022 03:25:22 +0200 (CEST)
From: Janne Grunau <j@jannau.net>
To: iommu@lists.linux.dev
Cc: Konrad Dybcio <konrad.dybcio@somainline.org>,
	asahi@lists.linux.dev,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Hector Martin <marcan@marcan.st>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	iommu@lists.linux-foundation.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/5] iommu/io-pgtable: Add DART subpage protection support
Date: Thu,  1 Sep 2022 03:25:17 +0200
Message-Id: <20220901012519.7167-4-j@jannau.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220901012519.7167-1-j@jannau.net>
References: <20220901012519.7167-1-j@jannau.net>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Peter <sven@svenpeter.dev>

DART allows to only expose a subpage to the device. While this is an
optional feature on the M1 DARTs the new ones present on the Pro/Max
models require this field in every PTE.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
Signed-off-by: Janne Grunau <j@jannau.net>

---

(no changes since v3)

Changes in v3:
- apply change to io-pgtable-dart.c

 drivers/iommu/io-pgtable-dart.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iommu/io-pgtable-dart.c b/drivers/iommu/io-pgtable-dart.c
index 43ef375812e6..659dd9e83d2c 100644
--- a/drivers/iommu/io-pgtable-dart.c
+++ b/drivers/iommu/io-pgtable-dart.c
@@ -14,6 +14,7 @@
 #define pr_fmt(fmt)	"dart io-pgtable: " fmt
 
 #include <linux/atomic.h>
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/io-pgtable.h>
 #include <linux/kernel.h>
@@ -40,6 +41,9 @@
 #define DART_PTES_PER_TABLE(d)					\
 	(DART_GRANULE(d) >> ilog2(sizeof(dart_iopte)))
 
+#define APPLE_DART_PTE_SUBPAGE_START   GENMASK_ULL(63, 52)
+#define APPLE_DART_PTE_SUBPAGE_END     GENMASK_ULL(51, 40)
+
 #define APPLE_DART1_PADDR_MASK	GENMASK_ULL(35, 12)
 
 /* Apple DART1 protection bits */
@@ -109,6 +113,10 @@ static int dart_init_pte(struct dart_io_pgtable *data,
 			return -EEXIST;
 		}
 
+	/* subpage protection: always allow access to the entire page */
+	pte |= FIELD_PREP(APPLE_DART_PTE_SUBPAGE_START, 0);
+	pte |= FIELD_PREP(APPLE_DART_PTE_SUBPAGE_END, 0xfff);
+
 	pte |= APPLE_DART1_PTE_PROT_SP_DIS;
 	pte |= APPLE_DART_PTE_VALID;
 
-- 
2.35.1

