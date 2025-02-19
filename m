Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [195.130.137.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFF718DB24
	for <iommu@lists.linux.dev>; Wed, 19 Feb 2025 14:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739976515; cv=none; b=Bpc9jvDVzksGhCViZXleN5Hcj/wSpojX9I+GMGtPrQGS6uLrm3PU80YFWCP2druw/3AFKW/quNiZFEXCAhBEO3ZDU4kmqRcpIli52WPBSH4WBKjK5SIPM9ESiDBfjLy/3eTQ4w0eLqTpERVAXk7qD+O6yCkqa50soHH7hYjKxns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739976515; c=relaxed/simple;
	bh=qoCk6NYlcujso7TP2XRSRh8uOohh5dbjXEelZKk3AL8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vAzXwtu/UQgey6HWs3R1suIF0wAbSPA06iYR7tiDymYxjiWArzKTEnm8uX30TiFVruNHnp8DR6Cd83+TQb/twI/UhV54JVinvkv33kPHkDfl6QAOPFCNLKgCW6Z2OeDQq9aGE0PVCpaAJ7AZWZbZllOGr0qbz8vYIx/P2nuBw6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:47f6:a1ad:ad8e:b945])
	by laurent.telenet-ops.be with cmsmtp
	id FSoR2E00E57WCNj01SoRVC; Wed, 19 Feb 2025 15:48:25 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1tklMs-0000000B3U8-2oij;
	Wed, 19 Feb 2025 15:48:25 +0100
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1tklNB-0000000BazG-1JnU;
	Wed, 19 Feb 2025 15:48:25 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] iommu: Spelling s/KConfig/Kconfig/
Date: Wed, 19 Feb 2025 15:48:24 +0100
Message-ID: <ff5b7c88eea8b126ed76029fb57254f29542aa22.1739976486.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix two misspellings of "Kconfig".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/iommu/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 6cfd1b5b6e07f038..6c46e1d58987cd11 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -348,14 +348,14 @@ config ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT
 	  an iommu domain will report an abort back to the device and
 	  will not be allowed to pass through the SMMU.
 
-	  Any old kernels that existed before this KConfig was
+	  Any old kernels that existed before this Kconfig was
 	  introduced would default to _allowing_ bypass (AKA the
 	  equivalent of NO for this config).  However the default for
 	  this option is YES because the old behavior is insecure.
 
 	  There are few reasons to allow unmatched stream bypass, and
 	  even fewer good ones.  If saying YES here breaks your board
-	  you should work on fixing your board.  This KConfig option
+	  you should work on fixing your board.  This Kconfig option
 	  is expected to be removed in the future and we'll simply
 	  hardcode the bypass disable in the code.
 
-- 
2.43.0

