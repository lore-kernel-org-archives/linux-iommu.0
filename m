Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id DF02F814
	for <iommu@lists.linux.dev>; Tue,  6 Jun 2023 07:10:58 +0000 (UTC)
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 24052180120BD8;
	Tue,  6 Jun 2023 15:07:45 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: jgg@ziepe.ca,
	kevin.tian@intel.com,
	vasant.hegde@amd.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Su Hui <suhui@nfschina.com>
Subject: [PATCH] iommu/amd: Fix possible memory leak of 'domain'
Date: Tue,  6 Jun 2023 15:07:42 +0800
Message-Id: <20230606070742.139575-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

free memory of domain before return NULL.

Fixes: 29f54745f245 ("iommu/amd: Add missing domain type checks")
Signed-off-by: Su Hui <suhui@nfschina.com>
---
 drivers/iommu/amd/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index dc1ec6849775..f08e65629c74 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2094,7 +2094,7 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
 	} else if (type == IOMMU_DOMAIN_DMA || type == IOMMU_DOMAIN_DMA_FQ) {
 		pgtable = amd_iommu_pgtable;
 	} else {
-		return NULL;
+		goto out_err;
 	}
 
 	switch (pgtable) {
-- 
2.30.2

