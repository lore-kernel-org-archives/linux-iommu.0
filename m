Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E40110A
	for <iommu@lists.linux.dev>; Wed, 22 Jun 2022 08:26:12 +0000 (UTC)
Received: from cap.home.8bytes.org (p5b006cf2.dip0.t-ipconnect.de [91.0.108.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by theia.8bytes.org (Postfix) with ESMTPSA id 45A3D7F;
	Wed, 22 Jun 2022 10:26:04 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: linux-kernel@vger.kernel.org
Cc: iommu@lists.linux-foundation.org,
	iommu@lists.linux.dev,
	Joerg Roedel <jroedel@suse.de>
Subject: [PATCH] MAINTAINERS: Add new IOMMU development mailing list
Date: Wed, 22 Jun 2022 10:26:01 +0200
Message-ID: <20220622082601.31678-1-joro@8bytes.org>
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20220622082601.HyE6A78V5PhNKi9cavW-vJX-Rd4dKqLkwDwy4jS9yBs@z>

From: Joerg Roedel <jroedel@suse.de>

The IOMMU mailing list will move from lists.linux-foundation.org to
lists.linux.dev. The hard switch of the archive will happen on July
5th, but add the new list now already so that people start using the
list when sending patches.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1fc9ead83d2a..b5bac297d63d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10354,6 +10354,7 @@ IOMMU DRIVERS
 M:	Joerg Roedel <joro@8bytes.org>
 M:	Will Deacon <will@kernel.org>
 L:	iommu@lists.linux-foundation.org
+L:	iommu@lists.linux.dev
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 F:	Documentation/devicetree/bindings/iommu/
-- 
2.36.1

