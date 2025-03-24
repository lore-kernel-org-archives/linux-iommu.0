Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AFF8635C;
	Mon, 24 Mar 2025 21:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742850215; cv=none; b=A7+wZsQ/A+3doDWh1yk7Lz9lci/kN+VTMz2O0+ZOiDsbAL8YccN3J1fBOooQaf4JMsslDYuvN9/RRi6mzR1OwZgNFMzPCRhh+EL1hMoEzmEiRBX3NuFY7plkBBrvPyubBgs9MUrRm153H2ESRuW+JOt+wDFLKwrnMZWxMD70A3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742850215; c=relaxed/simple;
	bh=rOz5UsJUgCTnivXbf868dmCzc8AreZr/vIY1OjHCmzQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QFIlCqLSfZUPcBykKgYRTa6ub7grcIWbpnXZAHYfkJqzHfVqi49n9sNOvD+s3x1sDcGJ23TECAZ4T4ETKQKvPnJN5geOwACMtYSFMrUd/eAeA9MVN5jF5RqaFbdwSwewd5IYeBRsAQ5YuJatTSv2mZJiZSxyPuj0FbrQ3kF7YUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XW+Glt+F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XW+Glt+F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D147CC4CEDD;
	Mon, 24 Mar 2025 21:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742850214;
	bh=rOz5UsJUgCTnivXbf868dmCzc8AreZr/vIY1OjHCmzQ=;
	h=From:To:Cc:Subject:Date:From;
	b=XW+Glt+FwtDTQXhAHZdmqZrDLGFrj7KISZB+bGH2JcEF0D+D3Vw41eWNKAVFlJ6rK
	 qzkWKTt2jblpXh9sn9r4Fr25tgAJWrxUGTWBTPyUPtfWvkpR7PTvy6yEwsMb7ntaiB
	 FWZ3vEQgdoWdGpxh2FaEUwZduClSophZj5WDTnCZ7TsIPSknmmlPCZh+krTgmBlK2S
	 niZUcMNhDqVeUBOJ2/NtLBAE/E9TfcCTpWjOo4elKY/DeFNf13VDKOuJ8XhrwRKPbf
	 1XieG/NekRu/70dUqsaF0uzX0pnUbtBYCaUmZ1RhSMFPHuJjmzRyUwuoHpwE7/Bc0a
	 xKl0AwzXhcHTg==
From: Arnd Bergmann <arnd@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Nicolin Chen <nicolinc@nvidia.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] iommufd: import IOMMUFD_INTERNAL namespace
Date: Mon, 24 Mar 2025 22:03:22 +0100
Message-Id: <20250324210329.2809869-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Building the iommufd driver as a loadable module causes a failure now:

ERROR: modpost: module iommufd_driver uses symbol iommu_attach_handle_get from namespace IOMMUFD_INTERNAL, but does not import it.

Import the namespace as needed here.

Fixes: 916a207692ce ("iommufd: Move iommufd_sw_msi and related functions to driver.c")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/iommu/iommufd/driver.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index 352513974154..a08ff0f37fc6 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -247,4 +247,5 @@ EXPORT_SYMBOL_NS_GPL(iommufd_sw_msi, "IOMMUFD");
 #endif
 
 MODULE_DESCRIPTION("iommufd code shared with builtin modules");
+MODULE_IMPORT_NS("IOMMUFD_INTERNAL");
 MODULE_LICENSE("GPL");
-- 
2.39.5

