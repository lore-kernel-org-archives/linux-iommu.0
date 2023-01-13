Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A182115
	for <iommu@lists.linux.dev>; Fri, 13 Jan 2023 19:15:41 +0000 (UTC)
Received: from lemmy.home.8bytes.org (p549ad69d.dip0.t-ipconnect.de [84.154.214.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id DA736262301;
	Fri, 13 Jan 2023 20:15:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1673637341;
	bh=x52iDVgcpj5R7lCUrrVwkkAIEqksQFPgjJqv/pTpmHs=;
	h=From:To:Cc:Subject:Date:From;
	b=5SfsMmsCybtLyhG3gAxXl8dKCLbIjE0qVUAE6Fgeaoq23s8XjQ9ilicUCjdAI90z/
	 Nxbc45Ze+U+RfMEWC4rLc9c6I/ebovQ0W4KrC0oj6SZO377uoSha3ydxKlTq6GO60+
	 8kw3r7ixSrciIHYN0fH6Sc8rrM5oBCCJWl/Hl4AjJlfRWFsW2PYuzwAzbvCkMEXztO
	 GpVwzW4U3MbMcBNbvGlwEfdL1oP3tspmhlsdLg40+t7Ck6mpSwGRmFOWbNuCNoFJZD
	 5qjxtkbF71L4xR8pwmI4Jyvn+CpCPv2vlG8dlQrySCXrM9WKidoohQ3Rrh30vECRO9
	 Uy9AP2NdPjSjg==
From: Joerg Roedel <joro@8bytes.org>
To: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Joerg Roedel <jroedel@suse.de>
Subject: [PATCH] iommu/fsl_pamu: Fix compile error after adding set_platform_dma_ops
Date: Fri, 13 Jan 2023 20:15:28 +0100
Message-Id: <20230113191528.23638-1-joro@8bytes.org>
X-Mailer: git-send-email 2.39.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joerg Roedel <jroedel@suse.de>

The struct initializer for set_platform_dma_ops uses a semicolon as
separator where a comma is required. Fix the compile error by using the
correct separator.

Fixes: c1fe9119ee70 ("iommu: Add set_platform_dma_ops callbacks")
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/fsl_pamu_domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index e123161c211a..bce372297099 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -452,7 +452,7 @@ static const struct iommu_ops fsl_pamu_ops = {
 	.domain_alloc	= fsl_pamu_domain_alloc,
 	.probe_device	= fsl_pamu_probe_device,
 	.device_group   = fsl_pamu_device_group,
-	.set_platform_dma_ops = fsl_pamu_set_platform_dma;
+	.set_platform_dma_ops = fsl_pamu_set_platform_dma,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= fsl_pamu_attach_device,
 		.iova_to_phys	= fsl_pamu_iova_to_phys,
-- 
2.39.0

