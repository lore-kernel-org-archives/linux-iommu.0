Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D4E266B5F
	for <iommu@lists.linux.dev>; Mon, 24 Feb 2025 18:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740420210; cv=none; b=t+veITmmaQM+gKuk4Z2uoSB4XLUtjtWhWTDaekxIksxSTSt+LRIMEu+2qCSKxNcer1w5zcEBE3xKaddBEAlu3iT7lS1x6O7OGtkTT0hj1mMLaaJt+BlyqxqCojM14Iv5DRvR4V9I5DKybLHy9n1dzT1zcyzPTLAPeXY+UiiczLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740420210; c=relaxed/simple;
	bh=NI1xjoVbtgHgczdhbNULpZRkuzmAV2dauxiN8EyjFNU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pdVoC9H/7/bEKRMudVSsRUmPT0eoWFyNzUa2Ns1PNVLV31vxHNrv8jeKnEANu16O1hzxQ7E02oyn7AcimjrEd7hoohfLRmbexq6vVUM7h+m/gwjZQvcFsV2tH2hOijUVzaFfv4SrqaKCOuvB6lyr1lw2AoVlK3akJF6wGj8boSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AMGn7eOQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AMGn7eOQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740420208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qsdz9u3pB5RtoviLF7GIZI2GctjAOYF/Iu7Vpi9c6vo=;
	b=AMGn7eOQBkiEaBbnsWjw3uQzZkdgzeKN5AExxb9m0sQUE4Q8rhD/QfdTCHUbic2i5soj3F
	V2ylzn/LKLya1Q3dmpS+uk1fxBiWnzzLMF3djPPNmDJTfrgJ12Pj9xGIIcXK8XYGfi3Nbn
	qhlDMJF9YFxOqIZRovjmQZiOa2RD3xQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-ywjyD_HXO8KT7Z8pH3FeTg-1; Mon,
 24 Feb 2025 13:03:22 -0500
X-MC-Unique: ywjyD_HXO8KT7Z8pH3FeTg-1
X-Mimecast-MFC-AGG-ID: ywjyD_HXO8KT7Z8pH3FeTg_1740420201
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B2AED18EB2D3;
	Mon, 24 Feb 2025 18:03:20 +0000 (UTC)
Received: from cantor.redhat.com (unknown [10.2.16.143])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F0A7A180035E;
	Mon, 24 Feb 2025 18:03:18 +0000 (UTC)
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: iommu@lists.linux.dev
Cc: Joerg Roedel <joro@8bytes.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/vt-d: Remove device comparison in context_setup_pass_through_cb
Date: Mon, 24 Feb 2025 11:03:16 -0700
Message-ID: <20250224180316.140123-1-jsnitsel@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Remove the device comparison check in context_setup_pass_through_cb.
pci_for_each_dma_alias already makes a decision on whether the
callback function should be called for a device. With the check
in place it will fail to create context entries for aliases as
it walks up to the root bus.

Fixes: 2031c469f816 ("iommu/vt-d: Add support for static identity domain")
Closes: https://lore.kernel.org/linux-iommu/82499eb6-00b7-4f83-879a-e97b4144f576@linux.intel.com/
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
 drivers/iommu/intel/iommu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index cc46098f875b..4d8d4593c9c8 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4378,9 +4378,6 @@ static int context_setup_pass_through_cb(struct pci_dev *pdev, u16 alias, void *
 {
 	struct device *dev = data;
 
-	if (dev != &pdev->dev)
-		return 0;
-
 	return context_setup_pass_through(dev, PCI_BUS_NUM(alias), alias & 0xff);
 }
 
-- 
2.44.0

