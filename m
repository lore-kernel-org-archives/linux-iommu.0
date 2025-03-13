Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AF4AD5E
	for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 17:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741887076; cv=none; b=L0Q0M86shJKaWgzgF374748IXa+Hfef7eVMVgexPEASr7YWa1yuyvPwuXtaITRl9J0Bwswq6EfFYBR+tvGkEwLQwmuxzbSifmKYeNE6jRheYeWSVjzp4PBp64dXOchh+frCzBreMy6ERobWB94mrAWf51x7CNXN+YVrtZPI4pO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741887076; c=relaxed/simple;
	bh=OsMjuJB+M4eDxU+SqiVQNfp+RGp2KXHsthirj6b1ipI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TxvhfNxSFWrGQ7MdVjkcLExi4BgyLJonL6hqy06kMJv4iZPsWaaTcJ5zMAGESXcdZ0bZPKevfeuoaCArTKDqKxSLtrzdr97ZkyAzRMsplLP6IPg54aYFdvuK8EgXPK3lttqTMvnJolrGUed98e16yaII8l5gnJ5EvSb3E+E3jNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F37021477;
	Thu, 13 Mar 2025 10:31:22 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A3F973F673;
	Thu, 13 Mar 2025 10:31:11 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Cc: iommu@lists.linux.dev,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	heiko@sntech.de
Subject: [PATCH 0/3] Rockchip IOMMU fixes
Date: Thu, 13 Mar 2025 17:31:03 +0000
Message-Id: <cover.1741886382.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

I was expecting my DT probing change to flush out issues, and it seems
some weaknesses in rockchip-iommu were the first to show. The first two
patches here get things working again for me on my RK3399 NanoPC-T4
(with a console on HDMI exercising the VOP MMU), the 3rd patch just
finishes the cleanup since I was there and could test it.

Thanks,
Robin.

Robin Murphy (3):
  iommu/rockchip: Allocate per-device data sensibly
  iommu/rockchip: Register in a sensible order
  iommu/rockchip: Retire global dma_dev workaround

 drivers/iommu/rockchip-iommu.c | 61 +++++++++++++++-------------------
 1 file changed, 26 insertions(+), 35 deletions(-)

-- 
2.39.2.101.g768bb238c484.dirty

