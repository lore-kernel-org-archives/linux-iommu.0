Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.13.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D2B4A4857
	for <iommu@lists.linux.dev>; Thu, 10 Sep 2026 15:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.13.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789052738; cv=none; b=W9ThqMle9bkmQmnR3bHeqeUBUaxY8jtx7b9SfNfI0yRTWJXrJLtu10LuGJJs0LYCglhkgTFB4R7Y30ddu1Sm6Ke1RH/7x5GpY1ILc/p/ggOhhYXzZcL0LDhnMUDwTVTBixG8g4n5TvgfqXeWo/fDLrqNCCsjBQo92ESiGd9nOdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789052738; c=relaxed/simple;
	bh=d2VACGD2Y+Pcowukn+YH9kJBcwGZQz4IndLM4cjc8qw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dopwJQgWz429tCLog5oR4/ybGOhI569XHVWGMgg4Wmj8PmGm4M45wNQpEduudXCSo61PODM74+34tLco/oUgqxezpJtujPc3Rzyd7ifurxxHy2B26w7InvmztA42SrdfFJRyAT0pOVyeb37+i5hnuT/PMlSNEty85E9oamileAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=iyFddndi; arc=none smtp.client-ip=52.13.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="iyFddndi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1789052733; x=1820588733;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yQBhl1VDWRy2DT2o61x3397a3YMvKwrUwztfIj/WO08=;
  b=iyFddndik78K7klUmWRMg4w2bL7jnjOVpp0PhKT6DDq63C1Q+h/vB3eY
   01sopCqPU893SX9ksvAzbazobJOfcYbGPeMwZMuh65iWJd6sPSUHqMtCF
   xtjqRl2Axn+XZFC4GG/vRaOeMWFSfChqTyre9TXetrxmmMjHBxEOXE4/W
   LNyIjjujEvnBmc8u4v7fiR1nZmIKWRMqBCdW3OKCcAGe8NFzLXDs9npuz
   /VXyhAgJOycTXmc/iykRtSU8LSc1kUFj3xFswaeI1Vf1d0E3PxHIFdXB9
   WR+PPn2fHjn/aGEpyqSSoBJACJOBWXhckYfmWPJb4X8Ka8ihjX9G3O8SO
   A==;
X-CSE-ConnectionGUID: QaaPeaiXRrq5Rc1ecG+pjg==
X-CSE-MsgGUID: ewR6b+nxTQqWR4lFlPzxfQ==
X-IronPort-AV: E=Sophos;i="6.27,95,1787011200"; 
   d="scan'208";a="28310213"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 15:05:28 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:29016]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.159:2525] with esmtp (Farcaster)
 id e28b0798-0ce6-4826-aa25-e422267bb4b0; Thu, 10 Sep 2026 15:05:28 +0000 (UTC)
X-Farcaster-Flow-ID: e28b0798-0ce6-4826-aa25-e422267bb4b0
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Thu, 10 Sep 2026 15:05:28 +0000
Received: from dev-dsk-fparola-1b-85ea2014.eu-west-1.amazon.com
 (10.13.236.104) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46; Thu, 10 Sep 2026
 15:05:26 +0000
From: Federico Parola <fparola@amazon.de>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: <nh-open-source@amazon.com>
Subject: [PATCH v2] iommu: Finalize deferred attachments when mapping MSI pages
Date: Thu, 10 Sep 2026 15:04:47 +0000
Message-ID: <20260910150517.95239-1-fparola@amazon.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB001.ant.amazon.com (10.13.138.119) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

When a device's attachment to its default domain is deferred, the IOMMU
is still translating the device with the tables inherited from the
previous kernel. Any mapping installed in that domain does not take
effect until the deferred attachment is finalized.

iommu_deferred_attach() covers the DMA mapping paths, but nothing covers
iommu_dma_prepare_msi(): programming an MSI installs the MSI page in
group->domain and hands the resulting IOVA to the irqchip, so an MSI
programmed before the first DMA map is written using an IOVA that the
hardware does not yet translate.

This issue is currently not triggerable as the two IOMMU implementations
supporting deferred attachments, Intel and AMD, do not rely on DMA
translations for MSI transactions. However, the Arm implementation being
introduced in [1] will be subject to it.

Finalize the deferred attachment from iommu_dma_prepare_msi() too,
before the MSI page is mapped. Do it outside group->mutex, as
iommu_deferred_attach() takes the mutex itself and the two operations do
not need to be atomic with respect to each other: if an attach replaces
group->domain in between, the MSI page is mapped into whatever
group->domain holds once the mutex is taken.

iommu_get_domain_for_dev() cannot return NULL here: MSI setup only runs
for a device whose driver is bound, and of_iommu_configure() and
acpi_iommu_configure_id() hold the bind off until the IOMMU is
registered, hence until iommu_device_register() has set up the group's
default domain. group->domain then stays non-NULL until
iommu_deinit_device() clears it once the group is empty.
dma_iova_try_alloc() already relies on the same guarantee.

The static key gating the iommu_deferred_attach() calls in dma-iommu.c
is private to that file, and replicating it here is not worthwhile since
MSI page mapping is not a fast path.

The behaviour of a rejected attach changes slightly: an attach refused
because the device is being reset (-EBUSY) now fails MSI setup rather
than only the first DMA map.

Link: https://lore.kernel.org/linux-iommu/cover.1788130528.git.nicolinc@nvidia.com/ [1]
Assisted-by: Claude:claude-opus-5
Signed-off-by: Federico Parola <fparola@amazon.de>
---
Changes in v2:
- Moved up iommu_deferred_attach() from iommu_dma_sw_msi() to
  iommu_dma_prepare_msi() and removed unlocked variant of the function.
- Link to v1: https://lore.kernel.org/linux-iommu/20260910115152.54108-1-fparola@amazon.de
---
 drivers/iommu/iommu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index cd1bca7ede9a..b486b8bbd1fc 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -4243,6 +4243,10 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
 	if (!group)
 		return 0;
 
+	ret = iommu_deferred_attach(dev, iommu_get_domain_for_dev(dev));
+	if (ret)
+		return ret;
+
 	mutex_lock(&group->mutex);
 	/* An IDENTITY domain must pass through */
 	if (group->domain && group->domain->type != IOMMU_DOMAIN_IDENTITY) {
-- 
2.47.3

