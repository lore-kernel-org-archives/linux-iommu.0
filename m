Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D198514A8B
	for <iommu@lists.linux.dev>; Thu,  5 Dec 2024 16:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733416450; cv=none; b=hWh2p7nQst2/d/4snS1eYiN1rfePzgEjtLYNFqC6JupOVwyK5rkPk/E+/jUW4QJ5aboCmCXWAgHcz/mGo/DG+WADGJPGpxcDeeCEzY4pobPTxHJe2jwyR4XoetlwlQZDiqN0XBT0cGWGsyYFJmifXaUf1/hDfIwn06bxDWqar28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733416450; c=relaxed/simple;
	bh=8wQ2etNwmwRgo9Tzciis5jYbZOxRE9ZNX2AZcAtxUIU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=erXlPTXwdSWHYsqIHM5R45Yz2MKqP3ZoCBVvtfvSN5cN3kI1F93MaNnIXf6lCsAv5uiPI6TH4Y01qAM44bW8ISXx8BU8g3oGdewcMyIi8+a/5hJqfI4WCCB8Ur/5vIDI6qVlGml9bBwvVrjzO838XtReN9nlY2Q5cNDoKsMxgHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B857C1063;
	Thu,  5 Dec 2024 08:34:34 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C55593F5A1;
	Thu,  5 Dec 2024 08:34:05 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org,
	joro@8bytes.org
Cc: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	quic_pbrahma@quicinc.com
Subject: [PATCH v2 0/4] iommu/arm-smmu: Minor probe_device related improvements
Date: Thu,  5 Dec 2024 16:33:54 +0000
Message-Id: <cover.1733406914.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1: https://lore.kernel.org/linux-iommu/cover.1731088789.git.robin.murphy@arm.com

Hi all,

Here's what I probably should have sent instead of rushing v1 out
earlier, now rebased and polished :)

Cheers,
Robin.


Robin Murphy (4):
  iommu/arm-smmu: Make instance lookup robust
  iommu/arm-smmu: Retire probe deferral workaround
  iommu/arm-smmu-v3: Clean up more on probe failure
  iommu: Manage driver probe deferral better

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 21 +++++++----
 drivers/iommu/arm/arm-smmu/arm-smmu.c       | 42 +++++++--------------
 drivers/iommu/iommu.c                       |  2 +-
 drivers/iommu/of_iommu.c                    |  2 -
 4 files changed, 29 insertions(+), 38 deletions(-)

-- 
2.39.2.101.g768bb238c484.dirty

