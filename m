Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E26A1DE4C4
	for <iommu@lists.linux.dev>; Thu, 16 Jan 2025 12:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737029439; cv=none; b=EFrBaGEkyiKBOl4TLFsNW7XDcef4f4gHO3OovIqupkYVaz6SMnwThU0CizUNQgulN78qXOIB2LUQlK+epZR3SN2KDzDvFVTTOVXSgxoAHDd8bby/ZiJ/iVELMXMvLueYUR0dK6JpdNUZzr79Zb3YkOt5y0PvnySOWjZYAOKk6SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737029439; c=relaxed/simple;
	bh=2c8yFcJ2945jsqZAOuS5Vel5mEF7uycmdZ3MUexcKTA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bIc9BuQoQR4aNz+8YovReWPAjkjORZi2Ewxktw/o+gLasvqhRDT/orLeZbDPi/r2WKNPKatfADHtcORr+2cCoAZ5NQH242Uo+fGdbmT1819dS20J9jmKRxVZpl07Qbp635hn1eqWbnWPynFDOIZVwyxME1UOnC8r3KbgPNewuRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MmbHzs9U; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MmbHzs9U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1737029429;
	bh=2c8yFcJ2945jsqZAOuS5Vel5mEF7uycmdZ3MUexcKTA=;
	h=From:To:Cc:Subject:Date:From;
	b=MmbHzs9Uzn6x1yTitYWT6OjUu+fMkQEHv1S4BsQBDTzKowMK45iF2mwV5ukHuG7vC
	 MKdikE4/VzCDABCdyC+hxLRCmNYrF2SPdReDQX1i7rfZBtfrK7Ga9dCIhm15ExILpT
	 XBqttOnKgQDwav5Aq/JF9mTizQBN7wxvVCLoBsU+6SiAOaOjkFZ2FDojZT5CgZPAGV
	 r2XeIgAviXoRSbXISXVBkmBBVl1jBid9LaK9H5Xu/vex0w0qlnIzgg75DmOopySG12
	 Wgc4WxAAVgKTSlFbFkaEmk3UzPiXGGriBgHlPzDSN61OI7F0+qlnlnmEPYwhycajEj
	 hJKIv2k3WoO1w==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id EBEE217E0391;
	Thu, 16 Jan 2025 13:10:28 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: will@kernel.org
Cc: robin.murphy@arm.com,
	joro@8bytes.org,
	jgg@ziepe.ca,
	nicolinc@nvidia.com,
	mshavit@google.com,
	smostafa@google.com,
	praan@google.com,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [PATCH] iommu/arm-smmu-v3: Include string_choices.h header for str_read_write
Date: Thu, 16 Jan 2025 13:10:25 +0100
Message-ID: <20250116121025.118464-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The str_read_write() helper function is defined in the missing
string_choices.h header: include it to resolve build failures.

Fixes: f2c77f6e41e6 ("iommu/arm-smmu-v3: Use str_read_write helper w/ logs")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 0e4cbb2c64d7..a0e395da8a88 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -26,6 +26,7 @@
 #include <linux/pci.h>
 #include <linux/pci-ats.h>
 #include <linux/platform_device.h>
+#include <linux/string_choices.h>
 #include <kunit/visibility.h>
 #include <uapi/linux/iommufd.h>
 
-- 
2.47.0

