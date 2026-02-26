Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CA23603ED
	for <iommu@lists.linux.dev>; Thu, 26 Feb 2026 18:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772129436; cv=none; b=IpzRPFnZDMZRtMFhWdEgkD8CjSp/X+6nwArhnTrcQ74ONkUU3WirAyQlQZ9vhKc4UjpYttWCKbcYagGXOECg8wMpfWgSd2PS8ny3PwJNmAOuk2T3wqGtWHk0dUMjoepqBimzbw1tej/gMw8KLsDYOHJ5DryzW8/N4HojlCPZpZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772129436; c=relaxed/simple;
	bh=RZA0gPomzBS4DYdGYorNp8FNeSfZDKeWFy5LVpQVRec=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ui6yeU3V0zCSQdYTx30mvyG+s2oDIz8hitb3R5tcZ+cuP0QPbOWoCyDW9VIj+tlQ0VKYNJnSUgRYFuQkGG+6gEF5TGa0hcOfl3PZ9KOhGqeZ2pGBIPBtOighPu5ZS0uj6PnvSg9KMiWXVEc42fI+VH5WXRWXqCHzKvEuB/4kmFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E88861516;
	Thu, 26 Feb 2026 10:10:21 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.85])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 113413F73B;
	Thu, 26 Feb 2026 10:10:26 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org,
	catalin.marinas@arm.com,
	joro@8bytes.org
Cc: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	daizhiyuan@phytium.com.cn
Subject: [PATCH 0/3] Arm SMMU errata updates
Date: Thu, 26 Feb 2026 18:10:19 +0000
Message-Id: <cover.1772125743.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

As promised (well OK, it's not Monday...), here's a more comprehensive
SMMU errata update since I finally found time to pick through all the
latest SDENs in detail. Includes some bonus cleanup since I despair at
just adding to a messy table, but that could be split up if you have a
preference for what to base on what.

Cheers,
Robin.


Robin Murphy (3):
  arm64: errata: Reformat table for IDs
  iommu/arm-smmu-v3: Update Arm errata
  arm64: errata: Sort Arm entries

 Documentation/arch/arm64/silicon-errata.rst | 114 +++++++++++---------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  18 +++-
 2 files changed, 77 insertions(+), 55 deletions(-)

-- 
2.39.2.101.g768bb238c484.dirty

