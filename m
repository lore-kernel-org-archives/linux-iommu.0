Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FB31E7675
	for <iommu@lists.linux.dev>; Thu, 24 Oct 2024 15:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729784069; cv=none; b=dCBg9sU2PrgzKMFyIVJk4TWJ1J4awRkd+4qrgPpqqfW4Og6Z+eW9HHuxSng+9JPZdGPo6V1mnR5JiB4kVDLTZjttBJ5sUUeaJyPnY06Y397KwjAAnsTdVBT+kcPHeSuMV5TS1trMirYFR29m8AUcZLXP1R0+QlIVnqWM0q265cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729784069; c=relaxed/simple;
	bh=DmaNumx1B9Ch/TRtvCjSsjZvuo2pfUkSNhQa17xSru8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W5qXPdcrMCCefFKAhnhvbqU3gt3wDklRD6V/oF2XgaUYccKav5U7/CzTMLtzBPq+4glg7FKciluXWbcBCCJWdWq4qx8OLlH1M8C47y+0Xjp0m9XJ8QlGbIY2DT7W//lPf0UK/pyggwaJ2GTSeBFixZpPHHBxp/N9zfv3V5SZakM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HBPVGDmt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HBPVGDmt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729784066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cXUUAup2BSwJWOmEG3JvcIkWwS4Ltp5hO2So1hfEC/o=;
	b=HBPVGDmt3Jo7btTPSj3M6rc2qxrTULZNSD8FiFAphvaQWdSzm4pSosuPCaVTOXlXi1tNpp
	utKZHrxkHdG6C6LPF08IJK5uyb6YRa3RGZrXODL2LSoprJiDtqYUvCkVTYVG/NMSC8uCg2
	dfJpVRumFjJJNTGVfJaMUYfEPxEUfQM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-Pkhxl-hhPlWK5XtZSJRhmA-1; Thu,
 24 Oct 2024 11:34:21 -0400
X-MC-Unique: Pkhxl-hhPlWK5XtZSJRhmA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EF16C1955D50;
	Thu, 24 Oct 2024 15:34:19 +0000 (UTC)
Received: from cantor.redhat.com (unknown [10.2.144.217])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 287D73000198;
	Thu, 24 Oct 2024 15:34:17 +0000 (UTC)
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: iommu@lists.linux.dev
Cc: Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] iommu/dma: Reserve iova ranges for reserved regions of all devices
Date: Thu, 24 Oct 2024 08:34:12 -0700
Message-ID: <20241024153412.141765-1-jsnitsel@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Only the first device that is passed when the domain is set up will
have its reserved regions reserved in the iova address space.  So if
there are other devices in the group with unique reserved regions,
those regions will not get reserved in the iova address space.  All of
the ranges do get set up in the iopagetables via calls to
iommu_create_device_direct_mappings for all devices in a group.

In the case of vt-d system this resulted in messages like the following:

[ 1632.693264] DMAR: ERROR: DMA PTE for vPFN 0xf1f7e already set (to f1f7e003 not 173025001)

To make sure iova ranges are reserved for the reserved regions all of
the devices, call iova_reserve_iommu_regions in iommu_dma_init_domain
prior to exiting in the case where the domain is already initialized.

Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Fixes: 7c1b058c8b5a ("iommu/dma: Handle IOMMU API reserved regions")
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
Robin: I wasn't positive if this is the correct solution, or if it should be
       done for the entire group at once.

 drivers/iommu/dma-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 2a9fa0c8cc00..5fd3cccbb233 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -707,7 +707,7 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, struct device *dev
 			goto done_unlock;
 		}
 
-		ret = 0;
+		ret = iova_reserve_iommu_regions(dev, domain);
 		goto done_unlock;
 	}
 
-- 
2.44.0

