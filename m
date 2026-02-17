Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08411339B1;
	Tue, 17 Feb 2026 21:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771362337; cv=none; b=fc5BPXKXv2tkG1r2phiqKWVbfBpx837RqgrK4flFQ+0yf0mEOUGm+1sVvDHd4UEgV8Jvm4bjryywFPmMCYLxc19ax22XraLB6s3CUcw+l4WCcJJ21UG3GUKgdYmtsEx0Xwep8PLVpWVVHJNY+WuGRqA+iRMRnhGZ8AwnMHQspdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771362337; c=relaxed/simple;
	bh=9PINj1pGGNrzxOCLiBtN6e0Fhf1IZ4tK8CfX06CC6vE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XDg2g+f1Bfg1ovaKB3QnxYWH6N/9ix0CEQHa4+cE5Tj4Es5y+7Z6N1vLO9AKnToPT/heZKCMAaO3N3yZgRuTvIldUYVsrreALEyEq7qzNOGvpDqrOBL4bDbUlnbY66WKxbLPdsu2y8pqaPPy4aKkssHMRbwysar9LmFKnkthA5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C9EC19421;
	Tue, 17 Feb 2026 21:05:37 +0000 (UTC)
From: Bjorn Helgaas <bhelgaas@google.com>
To: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v1 0/2] iommu/vt-d: Remove dmar_readl(), etc
Date: Tue, 17 Feb 2026 15:05:27 -0600
Message-ID: <20260217210529.3392755-1-bhelgaas@google.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove dmar_readl() and similar wrappers because they add nothing over
readl() and are used inconsistently.

dmar_writel() and dmar_writeq() swapped the order of the address and value
parameters, so I put those changes in a separate patch for ease of
reviewing.  I'm happy to squash them if desired.

Bjorn Helgaas (2):
  iommu/vt-d: Remove dmar_readl() and dmar_readq()
  iommu/vt-d: Remove dmar_writel() and dmar_writeq()

 drivers/iommu/intel/debugfs.c       | 18 +++++------
 drivers/iommu/intel/dmar.c          | 24 +++++++-------
 drivers/iommu/intel/iommu.c         | 22 ++++++-------
 drivers/iommu/intel/iommu.h         |  5 ---
 drivers/iommu/intel/irq_remapping.c |  6 ++--
 drivers/iommu/intel/perfmon.c       | 50 ++++++++++++++---------------
 drivers/iommu/intel/prq.c           | 26 +++++++--------
 7 files changed, 73 insertions(+), 78 deletions(-)

-- 
2.51.0

