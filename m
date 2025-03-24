Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96AF13633F;
	Mon, 24 Mar 2025 21:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742850220; cv=none; b=d98dk1WORsVuW4roS1exmbsz3mf2sf0NzHQx44ijmW7bUdOlf7eLWzUvvAobanZMpX8T/TSozrWDJ3VdFtebnfSeRZa/mbW3M+F+4UeZkh+ZSO89q08OjEc4Ppd14r2c6Ljh2CMym0ekejEjS6R9pm/YMrnOIN3f012yF6M3H9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742850220; c=relaxed/simple;
	bh=mIpJ6gMT+yAKUPwrQwzMR5CGtCCEeyIIeIxEY+/v2zw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DPbA5DRAYPyBBmzFPOtx7CBe0Nxq4OJndIunuwrh9zOghnu1/zvmOxSPkG52rMAxAnhELCg7Vqt97NhysFAUOURGueGpIwgAhp4f71hQnwxEcEOwLh/XgDQCYqqMMsA6SqDqOiY2kUgM4DStM5qmCSMCKlWv8NQyVeNAlbuZTxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MikyyTjj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MikyyTjj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DBACC4CEDD;
	Mon, 24 Mar 2025 21:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742850220;
	bh=mIpJ6gMT+yAKUPwrQwzMR5CGtCCEeyIIeIxEY+/v2zw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MikyyTjjsVGSWL/Wso1b/qhzlPQAZSOaWS2KzXM39vwQtwLLSiONl30YmPzqxKIan
	 xVexPMxOPgcnVv01EVuG5Zcwue0K5xVLxhT/HUYpueH/RxEmDjCHjrRG5/Ernsj2ba
	 vL8Ew403g09Er9hTSoETnPy3ldp0wM3eZW+fyoL6KPWNkA9b8XSKo6CWj97+3GKJvY
	 Mc7lHyceaNo3MkmM/sQzOtvQUy+19pvVFp1vglL9r+nKIAs732i7uxOM6qp/FeDmLO
	 vzJmoUsOUQTEeUCiWIxnUzzZVpLFeMMfFpVz9oYNCV2TTG/SIVDEuqtle02ipAKcmN
	 HOeAyQbMioFDQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iommufd_driver: make IOMMUFD_DRIVER_CORE a 'bool' symbol
Date: Mon, 24 Mar 2025 22:03:23 +0100
Message-Id: <20250324210329.2809869-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250324210329.2809869-1-arnd@kernel.org>
References: <20250324210329.2809869-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Calling iommufd_sw_msi() from iommu_dma_prepare_msi() in the iommu core
code is no longer possible if the driver core is in a loadable module
because it is now a direct call rather than a function pointer:

arm-linux-gnueabi-ld: drivers/iommu/iommu.o: in function `iommu_dma_prepare_msi':
iommu.c:(.text+0x4fb4): undefined reference to `iommufd_sw_msi'

This effectively makes the iommu driver core part of the iommu subsystem
itself, so disallow building it as a loadable module.

Fixes: e009e088d88e ("iommu: Drop sw_msi from iommu_domain")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/iommu/iommufd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/Kconfig b/drivers/iommu/iommufd/Kconfig
index 0a07f9449fd9..2beeb4f60ee5 100644
--- a/drivers/iommu/iommufd/Kconfig
+++ b/drivers/iommu/iommufd/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config IOMMUFD_DRIVER_CORE
-	tristate
+	bool
 	default (IOMMUFD_DRIVER || IOMMUFD) if IOMMUFD!=n
 
 config IOMMUFD
-- 
2.39.5

