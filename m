Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F171E835B
	for <iommu@lists.linux.dev>; Mon, 21 Jul 2025 06:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753078808; cv=none; b=S7sHsfMKAVs5wZtRmRQMbrOVndJnF0LFw0orhNO3TqCgEts0pulaFauD8JuhJ1ZDywuSSrBz2PuL6OP8QQoawUkMI8vYYBhPCJzlvMLJ0T5+gp6VJVJuDYvpleic4iODmWK/bu4q1ABw1w/rTs4kgPCpPeVDoeJjyyYsyIvlTuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753078808; c=relaxed/simple;
	bh=krLYMUYe8Hhdu5rCRJE52cUC5RGCXeO2JXlGR96hGK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NuD9G3FZl6HUn5ThC1QjolQuDH5Q6Py8trm17dYlog7MfCHBRZdq0bmHw4LvREigBxi6aVS/7lODnclkHRhzaciW0aUrR0CS9sbyybp8KzCL0SE5IRoG5j6aWDEU9jrlbi/OJKiK5kjvN12YmxIWT3BjHbODZcLDnjkIlDMFStc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2AKl+ia; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2AKl+ia"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D52C4CEED;
	Mon, 21 Jul 2025 06:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753078807;
	bh=krLYMUYe8Hhdu5rCRJE52cUC5RGCXeO2JXlGR96hGK4=;
	h=From:To:Cc:Subject:Date:From;
	b=A2AKl+ia2OJaXPv57/Q7VIeVJNDsQyYo5C1C7G89qFe/OPMYT36Pv3xxmAuf7S2ps
	 uEv8NB6J5xOGgQL9vMTs7qp3Awq1ivhXSW1gzeQTSLl5oFRxPEHSpYPZiaabKPI7cW
	 vy42/PdY1D6sanW5JuE9oXdp2mTmXDDyfata75RXl3G3xHQ3zsy3sN548XFMk3MlVQ
	 rJb9c6PEMN6l/BUTJ8iOrkG6i6YG/UkNb+YUnL0X0oto6EhJf03xTvv13DTDZEqNCM
	 5Hg+PLOGMxc0dP2TlKkt3SqjBrTYADurfJ84gJMfvkRkIRzptget7UyeZPW57kOveh
	 0byf0+9aDZBTg==
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux.dev
Subject: [PATCH v2 0/2] Preparation to .map_page and .unmap_page removal
Date: Mon, 21 Jul 2025 09:19:44 +0300
Message-ID: <cover.1753078569.git.leon@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changelog:
v2:
 * Added default "else" section without map_phys and map_page
   callbacks (impossible).
v1: https://lore.kernel.org/all/cover.1753003879.git.leon@kernel.org
 * Changed "else if" instead of "if".
v0: https://lore.kernel.org/all/cover.1752734252.git.leon@kernel.org
---------------------------------------------------------------------

This is followup to "dma-mapping: migrate to physical address-based API"
series https://lore.kernel.org/all/cover.1750854543.git.leon@kernel.org/

These preparation changes are limited to DMA subsystem to avoid possible
complications with submission to multiple trees.

Thanks

Leon Romanovsky (2):
  dma-mapping: prepare dma_map_ops to conversion to physical address
  dma-mapping: convert dummy ops to physical address mapping

 include/linux/dma-map-ops.h |  6 ++++++
 kernel/dma/dummy.c          | 13 ++++++-------
 kernel/dma/mapping.c        | 26 ++++++++++++++++++++++----
 kernel/dma/ops_helpers.c    | 17 ++++++++++++++---
 4 files changed, 48 insertions(+), 14 deletions(-)

-- 
2.50.1

