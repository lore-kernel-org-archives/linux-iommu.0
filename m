Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id EBC0E7F6
	for <iommu@lists.linux.dev>; Thu,  8 Jun 2023 02:22:58 +0000 (UTC)
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id E2E3E1801128CB;
	Thu,  8 Jun 2023 10:20:42 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: kevin.tian@intel.com,
	vasant.hegde@amd.com,
	jgg@ziepe.ca,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Su Hui <suhui@nfschina.com>
Subject: [PATCH v2] iommu/amd: Fix possible memory leak of 'domain'
Date: Thu,  8 Jun 2023 10:19:34 +0800
Message-Id: <20230608021933.856045-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move allocation code down to avoid memory leak.

Fixes: 29f54745f245 ("iommu/amd: Add missing domain type checks")
Signed-off-by: Su Hui <suhui@nfschina.com>
---
Changes in v2:
	change code order is better and more consistent with other
drivers. 
 drivers/iommu/amd/iommu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index dc1ec6849775..e8a2e5984acb 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2078,10 +2078,6 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
 	int mode = DEFAULT_PGTABLE_LEVEL;
 	int ret;
 
-	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
-	if (!domain)
-		return NULL;
-
 	/*
 	 * Force IOMMU v1 page table when iommu=pt and
 	 * when allocating domain for pass-through devices.
@@ -2097,6 +2093,10 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
 		return NULL;
 	}
 
+	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
+	if (!domain)
+		return NULL;
+
 	switch (pgtable) {
 	case AMD_IOMMU_V1:
 		ret = protection_domain_init_v1(domain, mode);
-- 
2.30.2

