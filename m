From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH] MAINTAINERS: add overall IOMMU section
Date: Fri, 13 Sep 2013 13:10:27 -0600
Message-ID: <1379099427-29362-1-git-send-email-swarren@wwwdotorg.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, Stephen Warren <swarren@nvidia.com>
List-Id: iommu@lists.linux-foundation.org

From: Stephen Warren <swarren@nvidia.com>

I believe that Joerg Roedel is at least the path through which
drivers/iommu changes should be merged. Add a MAINTAINERS entry to
make this clear, so that he's Cd'd on all relevant patches. This is
relevant for non-AMD/Intel IOMMUs, where get_maintainers.pl doesn't
currently remind anyone to Cc Joerg on patches.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6d0dabe..81415f6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4457,6 +4457,13 @@ L:	linux-serial@vger.kernel.org
 S:	Maintained
 F:	drivers/tty/serial/ioc3_serial.c
 
+IOMMU DRIVERS
+M:	Joerg Roedel <joro@8bytes.org>
+L:	iommu@lists.linux-foundation.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
+S:	Maintained
+F:	drivers/iommu/
+
 IP MASQUERADING
 M:	Juanjo Ciarlante <jjciarla@raiz.uncu.edu.ar>
 S:	Maintained
-- 
1.8.1.5
