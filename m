Received: from mail.as210286.net (mail.as210286.net [152.53.173.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2F92F2918
	for <iommu@lists.linux.dev>; Mon,  2 Feb 2026 19:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.173.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770060544; cv=none; b=I7NUxuYjWu4fSqTYFJ09IoOXf+6fBielmQLF/O55TC3HTb17yOL+AB3R5Ivcyb2TiXbEkh0SHagfZhMRxZqxSc3r0jidvjbp+syF2NM96drUBO8g5V9ciVjLLr4Y5rRtkusvCcim+KIXc0A0RSXzEuKHlmXZ+R5GYFe+XANj0yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770060544; c=relaxed/simple;
	bh=D0vfME0BPNwrJHmAi3NWIJflIUvi5hpUosN/0/1hVZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o5ouPG+hL9Xl4by0hZ2xoSjXyd3UCequ3zLH8aduMM7SSX4PcowJKI/kNbJQfKfncZf2baiC1x8qiUl6UKj2pEmu6YrH5SfdBx+IFuCAtSf95/sd0MxYf6yT+b9yEO5cjFyisKhsmxUzGKtTHyEm4DNGborFBMeeb4AlDHWbV30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kleen.org; spf=pass smtp.mailfrom=bohrium.kleen.org; dkim=pass (1024-bit key) header.d=kleen.org header.i=@kleen.org header.b=ASGps35A; arc=none smtp.client-ip=152.53.173.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kleen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bohrium.kleen.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kleen.org header.i=@kleen.org header.b="ASGps35A"
Received: by mail.as210286.net (Postfix, from userid 993)
	id A62E2D40161; Mon, 02 Feb 2026 19:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kleen.org; s=mail;
	t=1770060105; bh=D0vfME0BPNwrJHmAi3NWIJflIUvi5hpUosN/0/1hVZ8=;
	h=From:To:Cc:Subject:Date;
	b=ASGps35AjKGqSRQ4CRu8FRgGG8pz/cp92uwK8Ps1Cu7iLI9cu4M4xsQpqMbyaGqPB
	 1VvNirShh6YSshwAzDeSPehTNeYlmULLuEtetkwTxl552vaTdAqgV4LO0PcFCUttkO
	 z22PRARdnM4tduOsGvb1NGSRqJ5xrIKIOYY9i/vA=
Received: by bohrium.kleen.org (Postfix, from userid 1000)
	id 951FC146B1; Mon, 02 Feb 2026 19:21:40 +0000 (UTC)
From: Viktor Kleen <viktor@kleen.org>
To: 
Cc: viktor@kleen.org,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/vt-d: Treat PAGE_SNOOP and PWSNP separately
Date: Mon,  2 Feb 2026 19:21:05 +0000
Message-ID: <20260202192109.1665799-1-viktor@kleen.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PASID_FLAG_PAGE_SNOOP and PASID_FLAG_PWSNP constants are identical.
This will cause the pasid code to always set both or neither of the
PGSNP and PWSNP bits in PASID table entries. However, PWSNP is a
reserved bit if SMPWC is not set in the IOMMU's extended capability
register, even if SC is supported.

This has resulted in DMAR errors when testing the iommufd code on an
Arrow Lake platform. With this patch, those errors disappear and the
PASID table entries look correct.

Fixes: 101a2854110fa ("iommu/vt-d: Follow PT_FEAT_DMA_INCOHERENT into the PASID entry")
Signed-off-by: Viktor Kleen <viktor@kleen.org>
---
 drivers/iommu/intel/pasid.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
index b4c85242dc79..3809793e0259 100644
--- a/drivers/iommu/intel/pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -24,7 +24,7 @@
 
 #define PASID_FLAG_NESTED		BIT(1)
 #define PASID_FLAG_PAGE_SNOOP		BIT(2)
-#define PASID_FLAG_PWSNP		BIT(2)
+#define PASID_FLAG_PWSNP		BIT(3)
 
 /*
  * The PASID_FLAG_FL5LP flag Indicates using 5-level paging for first-
-- 
2.51.0

