Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAF818A948
	for <iommu@lists.linux.dev>; Mon, 30 Sep 2024 11:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727695302; cv=none; b=ANOS6tDr0gWwSSmi1TzzLRkxhrUGEsh9yBDGz4Yb72ZckwZQi13PYwEmr0dHb1Qr+1D6S1mfRAVsjVATiKv6ICOU78bycziFPC9spYa/Wz2Rbwn+LelZ4bo8NuhP7twyzJnA/2KhgKHt4y6qiATeoqWf/4QYu7B1YCSFm58Fq1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727695302; c=relaxed/simple;
	bh=bZliJJbFo2IN3n4dVutGITp1Mh2I//yTpJhop+j2CoM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TIRnawrd2pAWeR1tAhQelN6E1qRk/bD0SOlugZG6IHGx2mw5TW/jc6S+Mr4Bk0l+QVZLDl5U+h0u1e5TrRSK9pZD6e3y5kvmcMXG4WeDKKpnjOTFDDEEpSI6NJPLLlT7dewGwS+GAUFrJxxPrOK+kjvGjoTRQknkqEcMz+Y4cxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=ieMF5X63; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="ieMF5X63"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DpNHPysHFcdW+st1pCs6FRvPCloR1wCmvNrlpVL8YWk=;
  b=ieMF5X63x8wsel579EOpHZ4yMnFPF3OvgQ9rchZqSwalbrFvl3BnW2+1
   o4B5hYIY4bSL4qkSUqtMw2XzU+t5/M3oVFfflkTN8YYSjOLBCssD1eHKW
   NUpoh8Uq2fATv1f0ueRDKyOIurGLZos8szpsZHX5ABnyztNUSOo9652JJ
   I=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.11,165,1725314400"; 
   d="scan'208";a="185956890"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 13:21:27 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Joerg Roedel <joro@8bytes.org>
Cc: kernel-janitors@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 19/35] iommu: Reorganize kerneldoc parameter names
Date: Mon, 30 Sep 2024 13:21:05 +0200
Message-Id: <20240930112121.95324-20-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240930112121.95324-1-Julia.Lawall@inria.fr>
References: <20240930112121.95324-1-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reorganize kerneldoc parameter names to match the parameter
order in the function header.

Problems identified using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/iommu/iommu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 83c8e617a2c5..ce72edd34f07 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2216,8 +2216,8 @@ EXPORT_SYMBOL_GPL(iommu_attach_group);
 
 /**
  * iommu_group_replace_domain - replace the domain that a group is attached to
- * @new_domain: new IOMMU domain to replace with
  * @group: IOMMU group that will be attached to the new domain
+ * @new_domain: new IOMMU domain to replace with
  *
  * This API allows the group to switch domains without being forced to go to
  * the blocking domain in-between.

