Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BB62F25F2;
	Tue, 17 Feb 2026 21:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771364683; cv=none; b=vEev8VmkBOchQUPI4o2FPuyQ6WEoRceZfeKRN1u1fgIWwZZO/FwqBdQrBUNJC/OlJX4WpIzzwGRKHl02M8Fqe1CVqFvbI+F049oNtRlxTg/02Et1GKdwpkWZ6MFiNFh/m5WNmXlukUZqlqL+sDhkbb0buYf92hcSqHlyAZy36Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771364683; c=relaxed/simple;
	bh=9PINj1pGGNrzxOCLiBtN6e0Fhf1IZ4tK8CfX06CC6vE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=idUcJH8hZlcNOqF2bMmDCflX68PV6h8O+uNYShxmMh8tDH8xw5Q6/WgZGZ4KHqF7NqRyrRbLw0Lt00LKd6xW8yo8+orLac8B3zhyqpcBHbJi1lhw0pGhgp+wPdXYbpGRniElCOAZqb504IvsQY2MSI0G1F/bQWZZ4gJ4E5piClc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Id9T5hY7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Id9T5hY7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08787C4CEF7;
	Tue, 17 Feb 2026 21:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771364683;
	bh=9PINj1pGGNrzxOCLiBtN6e0Fhf1IZ4tK8CfX06CC6vE=;
	h=From:To:Cc:Subject:Date:From;
	b=Id9T5hY7IivFAoQh6ePQjk9GfrNmgKN5C8BjqfPP7GeFHa+U3eKH9V08o0U2ZlNlN
	 I34yiIUBlOo6gVDNEG0MxtLce/w7/GnwTezUR1EUs9GLeD7UYHGt0WN8kZfwARGgw1
	 cisi4j5/yRvZqut11H78anH2/PrQN+MCz+hSVzk3LqSi/s3U+S6Pj4IWKr33coVe9T
	 OxI/vwWdIsqFHy9EcjxxYaIOo8/gltov8H5b6UI/PhPgMvj90RNg6MYUjR5WJVEvDa
	 mzlblwewl/iQokxN22OpJUj0oakab5p9RiHsFGrQHdByAbHfUyNJLGSXi8ajRYOgvJ
	 RoMiTFqi3xbFg==
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v1 0/2] iommu/vt-d: Remove dmar_readl(), etc
Date: Tue, 17 Feb 2026 15:44:36 -0600
Message-ID: <20260217214438.3395039-1-bhelgaas@google.com>
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

