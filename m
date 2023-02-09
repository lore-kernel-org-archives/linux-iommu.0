Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7119A36C
	for <iommu@lists.linux.dev>; Thu,  9 Feb 2023 01:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=1Gyq1awD3AbR7Lmv5tDTtOp1bGuIK/qy5UCH4ZKCpzA=; b=1GgKQNB2tG2kDejzQFjuAu3yN5
	z8j3w1kG6dBKT1aUQuDghMF/AWfUGHK8U2OL6+Za4vKT0ixlEw9u/+D7f6hBRrzJujGurz7iEnT6V
	9PYOvG2TfVF+auVMWC37/K8SitvGzaI00PfwUzew7BOvbTk9/LrdC+HBtsYpsJkWehTOKWBRrlGkc
	EYjzqGWsmqdVINhybhqg5+izd59iHqb1Z/X+NgumiBIMxoymv1pLoHN+VPPMUeP5JFlGTgwQWp3N4
	GkHW2UwQC1Bla9wMWyTfSGV3WV5LIEkbd3kaZQBD97L19WGbRBijfIzVsvcmr21DaWmKLJGgrYWc2
	sfD6dQuA==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPvM0-00HMPI-44; Thu, 09 Feb 2023 01:04:00 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Thierry Reding <treding@nvidia.com>,
	Joerg Roedel <jroedel@suse.de>,
	Will Deacon <will@kernel.org>,
	iommu@lists.linux.dev
Subject: [PATCH] iommu/of: mark an unused function as __maybe_unused
Date: Wed,  8 Feb 2023 17:03:59 -0800
Message-Id: <20230209010359.23831-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CONFIG_OF_ADDRESS is not set, there is a build warning/error
about an unused function.
Annotate the function to quieten the warning/error.

../drivers/iommu/of_iommu.c:176:29: warning: 'iommu_resv_region_get_type' defined but not used [-Wunused-function]
  176 | static enum iommu_resv_type iommu_resv_region_get_type(struct device *dev, struct resource *phys,
      |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~

Fixes: a5bf3cfce8cb ("iommu: Implement of_iommu_get_resv_regions()")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev
---
 drivers/iommu/of_iommu.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff -- a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -173,8 +173,9 @@ const struct iommu_ops *of_iommu_configu
 	return ops;
 }
 
-static enum iommu_resv_type iommu_resv_region_get_type(struct device *dev, struct resource *phys,
-						       phys_addr_t start, size_t length)
+static enum iommu_resv_type __maybe_unused iommu_resv_region_get_type(struct device *dev,
+						struct resource *phys,
+						phys_addr_t start, size_t length)
 {
 	phys_addr_t end = start + length - 1;
 
