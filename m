Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA7625E81B
	for <iommu@lists.linux.dev>; Tue, 11 Mar 2025 15:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741706375; cv=none; b=lTDkeG4Ob5Ae82F5OgJg1W5XL++IabBIIgIekFULq6uBd8XowJWFkRPEu7jCqe+j/8GGbdnApZ7nC8j3Tt7ni1ZAGwxU/sb5V8fxyjHMY7eZyxhStZ7M3ZlBY5Jc6QGCN2ZliieF7HiE9ZJuW9VE3bsAeKOC/mfjtU+NP4jY3Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741706375; c=relaxed/simple;
	bh=gJWQfmISO6ERM+tVeKhihrJylxXq8bhx0BWJ8FnYsqg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RS+uflEqGx29gK+SQIAxL9/S+OJH9KKY0J6hh9e8/70LWdiwx+rNgyPPNvjSKhcYua1ePRLFqLpU0j/UmjckKy3aJaGcb8Y/cnv1TicPyGXX4FZMQ2iPnWQU5Q/+kCJs0pQaB2F2ovFJJ3MbPBYn3nRfpBhqMlARQJsYREiKR1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D4CE152B;
	Tue, 11 Mar 2025 08:19:43 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 49C043F694;
	Tue, 11 Mar 2025 08:19:31 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH] iommu: Avoid introducing more races
Date: Tue, 11 Mar 2025 15:19:25 +0000
Message-Id: <09d901ad11b3a410fbb6e27f7d04ad4609c3fe4a.1741706365.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Although the lock-juggling is only a temporary workaround, we don't want
it to make things avoidably worse. Jason was right to be nervous, since
bus_iommu_probe() doesn't care *which* IOMMU instance it's probing for,
so it probably is possible for one walk to finish a probe which a
different walk started, thus we do want to check for that.

Also there's no need to drop the lock just to have of_iommu_configure()
do nothing when a fwspec already exists; check that directly and avoid
opening a window at all in that (still somewhat likely) case.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
I was rather expecting to send a v3 of "iommu: Get DT/ACPI parsing into
the proper probe path", so I'm grateful that v2 was picked up, thanks!
This is the difference as a fix/squash commit instead.
---
 drivers/iommu/iommu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d824fa5166e3..c6d40abe577e 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -415,13 +415,15 @@ static int iommu_init_device(struct device *dev)
 	 * is buried in the bus dma_configure path. Properly unpicking that is
 	 * still a big job, so for now just invoke the whole thing. The device
 	 * already having a driver bound means dma_configure has already run and
-	 * either found no IOMMU to wait for, or we're in its replay call right
-	 * now, so either way there's no point calling it again.
+	 * found no IOMMU to wait for, so there's no point calling it again.
 	 */
-	if (!dev->driver && dev->bus->dma_configure) {
+	if (!dev->iommu->fwspec && !dev->driver && dev->bus->dma_configure) {
 		mutex_unlock(&iommu_probe_device_lock);
 		dev->bus->dma_configure(dev);
 		mutex_lock(&iommu_probe_device_lock);
+		/* If another instance finished the job for us, skip it */
+		if (!dev->iommu || dev->iommu_group)
+			return -ENODEV;
 	}
 	/*
 	 * At this point, relevant devices either now have a fwspec which will
-- 
2.39.2.101.g768bb238c484.dirty

