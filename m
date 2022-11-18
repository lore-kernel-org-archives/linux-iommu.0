Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C772F2F2A
	for <iommu@lists.linux.dev>; Fri, 18 Nov 2022 10:52:51 +0000 (UTC)
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1668768172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zhq3ZPbOW/IjySbkqalqQrSgHm9uIPo6a/xa8S5bNyE=;
	b=Ht2++LndUjVOqrAQD0+1tnKkVc0lpX3HoTEFa58uWLO+SaR/r7amjxj5fYlev1agdSx5LN
	RwfAjrXH7aOkiRE3FHSxFwxWW/tnzL/GYYZbFyI4aqhhEY4B5R2vy+0fjc4p4kxMEwHTi1
	zJUmdMN7WjkNR5fza5+eRJ+gB44Kny0=
To: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	trufanov@swemel.ru,
	vfh@swemel.ru
Subject: [PATCH] iommu: amd: Added value check
Date: Fri, 18 Nov 2022 13:42:52 +0300
Message-Id: <20221118104252.122809-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Аdded a return value check for the function
mmu_notifier_register.

Return value of a function 'mmu_notifier_register'
called at iommu_v2.c:642 is not checked,
 but it is usually checked for this function

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
 drivers/iommu/amd/iommu_v2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
index 5ecc0bc608ec..88134f34589f 100644
--- a/drivers/iommu/amd/iommu_v2.c
+++ b/drivers/iommu/amd/iommu_v2.c
@@ -639,7 +639,9 @@ int amd_iommu_bind_pasid(struct pci_dev *pdev, u32 pasid,
 	if (pasid_state->mm == NULL)
 		goto out_free;
 
-	mmu_notifier_register(&pasid_state->mn, mm);
+	ret = mmu_notifier_register(&pasid_state->mn, mm);
+	if (ret)
+		goto out_free;
 
 	ret = set_pasid_state(dev_state, pasid_state, pasid);
 	if (ret)
-- 
2.25.1

