Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00206634
	for <iommu@lists.linux.dev>; Wed,  8 Mar 2023 03:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=cAGQQH4wQyWDGC6FY8VeQxL7CF0wk1r7pps8zKct/lQ=; b=Js7x8WulqOLxQ+pRSWSdy/vrLn
	jgRM0AK53k9TYypy3IWJokVkTZoAtqSGkqlZiQ0jRb8SbyF4heuf2bEww6xrcPa+qhI5Hg2HdLiVv
	PlR7Ig00ZehMokI161qJdrMbETaTLpCc5L2ccLRMIB+9GyvQVX2+OfqUAuDKp9I+g39NRNLHACYDJ
	DwwJFfsCuQU31sE727eMfZZdQPwTjwjD22E/+U897cV9xliJKn21KVB3vCYqlDVaBPIjZXV+B4y1B
	AsbMP4EL8UM309QHKlm1GsEO578u3FcAvGLkmYPZeNK4/YG6sj2CibT4PknoOCzxAhlN3ic5XN8pP
	Pco2HA4g==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZkjh-003MaC-AI; Wed, 08 Mar 2023 03:45:05 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	kernel test robot <lkp@intel.com>,
	Aditya Srivastava <yashsri421@gmail.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	Timur Tabi <timur@tabi.org>,
	Varun Sethi <Varun.Sethi@freescale.com>,
	Emil Medve <Emilian.Medve@Freescale.com>
Subject: [PATCH] iommu/fsl: fix all kernel-doc warnings in fsl_pamu.c
Date: Tue,  7 Mar 2023 19:45:04 -0800
Message-Id: <20230308034504.9985-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix kernel-doc warnings as reported by the kernel test robot:

fsl_pamu.c:192: warning: expecting prototype for pamu_config_paace(). Prototype was for pamu_config_ppaace() instead
fsl_pamu.c:239: warning: Function parameter or member 'omi_index' not described in 'get_ome_index'
fsl_pamu.c:239: warning: Function parameter or member 'dev' not described in 'get_ome_index'
fsl_pamu.c:332: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Setup operation mapping and stash destinations for QMAN and QMAN portal.
fsl_pamu.c:361: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Setup the operation mapping table for various devices. This is a static

Fixes: 695093e38c3e ("iommu/fsl: Freescale PAMU driver and iommu implementation.")
Fixes: cd70d4659ff3 ("iommu/fsl: Various cleanups")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Link: lore.kernel.org/r/202302281151.B1WtZvSC-lkp@intel.com
Cc: Aditya Srivastava <yashsri421@gmail.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev
Cc: Timur Tabi <timur@tabi.org>
Cc: Varun Sethi <Varun.Sethi@freescale.com>
Cc: Emil Medve <Emilian.Medve@Freescale.com>
---
 drivers/iommu/fsl_pamu.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff -- a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
--- a/drivers/iommu/fsl_pamu.c
+++ b/drivers/iommu/fsl_pamu.c
@@ -178,7 +178,7 @@ int pamu_update_paace_stash(int liodn, u
 }
 
 /**
- * pamu_config_paace() - Sets up PPAACE entry for specified liodn
+ * pamu_config_ppaace() - Sets up PPAACE entry for specified liodn
  *
  * @liodn: Logical IO device number
  * @omi: Operation mapping index -- if ~omi == 0 then omi not defined
@@ -232,7 +232,8 @@ int pamu_config_ppaace(int liodn, u32 om
 /**
  * get_ome_index() - Returns the index in the operation mapping table
  *                   for device.
- * @*omi_index: pointer for storing the index value
+ * @omi_index: pointer for storing the index value
+ * @dev: target device
  *
  */
 void get_ome_index(u32 *omi_index, struct device *dev)
@@ -328,7 +329,7 @@ found_cpu_node:
 #define QMAN_PORTAL_PAACE 2
 #define BMAN_PAACE 3
 
-/**
+/*
  * Setup operation mapping and stash destinations for QMAN and QMAN portal.
  * Memory accesses to QMAN and BMAN private memory need not be coherent, so
  * clear the PAACE entry coherency attribute for them.
@@ -357,7 +358,7 @@ static void setup_qbman_paace(struct paa
 	}
 }
 
-/**
+/*
  * Setup the operation mapping table for various devices. This is a static
  * table where each table index corresponds to a particular device. PAMU uses
  * this table to translate device transaction to appropriate corenet
