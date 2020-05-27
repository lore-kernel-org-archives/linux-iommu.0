Return-Path: <SRS0=MQAj=7J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B7EC433E5
	for <iommu@archiver.kernel.org>; Wed, 27 May 2020 11:53:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01732208DB
	for <iommu@archiver.kernel.org>; Wed, 27 May 2020 11:53:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01732208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 75E2E8878B;
	Wed, 27 May 2020 11:53:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4nPKkPSyTkY0; Wed, 27 May 2020 11:53:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D5FCB88738;
	Wed, 27 May 2020 11:53:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B5FBCC0891;
	Wed, 27 May 2020 11:53:31 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EBAACC016F
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 11:53:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A3A802322B
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 11:53:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kP+p1RK1YpFr for <iommu@lists.linux-foundation.org>;
 Wed, 27 May 2020 11:53:27 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by silver.osuosl.org (Postfix) with ESMTPS id 9F8232045E
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 11:53:27 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 5564145; Wed, 27 May 2020 13:53:23 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 01/10] iommu/amd: Move AMD IOMMU driver to a subdirectory
Date: Wed, 27 May 2020 13:53:04 +0200
Message-Id: <20200527115313.7426-2-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200527115313.7426-1-joro@8bytes.org>
References: <20200527115313.7426-1-joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, jroedel@suse.de,
 linux-kernel@vger.kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Joerg Roedel <jroedel@suse.de>

The driver consists of five C files and three header files by now.
Move them to their own subdirectory to not clutter to iommu top-level
directory with them.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 MAINTAINERS                                          | 2 +-
 drivers/iommu/Makefile                               | 6 +++---
 drivers/iommu/{ => amd}/amd_iommu.h                  | 0
 drivers/iommu/{ => amd}/amd_iommu_proto.h            | 0
 drivers/iommu/{ => amd}/amd_iommu_types.h            | 0
 drivers/iommu/{amd_iommu_debugfs.c => amd/debugfs.c} | 0
 drivers/iommu/{amd_iommu_init.c => amd/init.c}       | 2 +-
 drivers/iommu/{amd_iommu.c => amd/iommu.c}           | 2 +-
 drivers/iommu/{amd_iommu_v2.c => amd/iommu_v2.c}     | 0
 drivers/iommu/{amd_iommu_quirks.c => amd/quirks.c}   | 0
 10 files changed, 6 insertions(+), 6 deletions(-)
 rename drivers/iommu/{ => amd}/amd_iommu.h (100%)
 rename drivers/iommu/{ => amd}/amd_iommu_proto.h (100%)
 rename drivers/iommu/{ => amd}/amd_iommu_types.h (100%)
 rename drivers/iommu/{amd_iommu_debugfs.c => amd/debugfs.c} (100%)
 rename drivers/iommu/{amd_iommu_init.c => amd/init.c} (99%)
 rename drivers/iommu/{amd_iommu.c => amd/iommu.c} (99%)
 rename drivers/iommu/{amd_iommu_v2.c => amd/iommu_v2.c} (100%)
 rename drivers/iommu/{amd_iommu_quirks.c => amd/quirks.c} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 50659d76976b..dd59ec6676d9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -876,7 +876,7 @@ M:	Joerg Roedel <joro@8bytes.org>
 L:	iommu@lists.linux-foundation.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
-F:	drivers/iommu/amd_iommu*.[ch]
+F:	drivers/iommu/amd/
 F:	include/linux/amd-iommu.h
 
 AMD KFD
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 57cf4ba5e27c..3af7e374b0cb 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -11,9 +11,9 @@ obj-$(CONFIG_IOASID) += ioasid.o
 obj-$(CONFIG_IOMMU_IOVA) += iova.o
 obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
 obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
-obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o amd_iommu_init.o amd_iommu_quirks.o
-obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += amd_iommu_debugfs.o
-obj-$(CONFIG_AMD_IOMMU_V2) += amd_iommu_v2.o
+obj-$(CONFIG_AMD_IOMMU) += amd/iommu.o amd/init.o amd/quirks.o
+obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += amd/debugfs.o
+obj-$(CONFIG_AMD_IOMMU_V2) += amd/iommu_v2.o
 obj-$(CONFIG_ARM_SMMU) += arm_smmu.o
 arm_smmu-objs += arm-smmu.o arm-smmu-impl.o arm-smmu-qcom.o
 obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
diff --git a/drivers/iommu/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
similarity index 100%
rename from drivers/iommu/amd_iommu.h
rename to drivers/iommu/amd/amd_iommu.h
diff --git a/drivers/iommu/amd_iommu_proto.h b/drivers/iommu/amd/amd_iommu_proto.h
similarity index 100%
rename from drivers/iommu/amd_iommu_proto.h
rename to drivers/iommu/amd/amd_iommu_proto.h
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
similarity index 100%
rename from drivers/iommu/amd_iommu_types.h
rename to drivers/iommu/amd/amd_iommu_types.h
diff --git a/drivers/iommu/amd_iommu_debugfs.c b/drivers/iommu/amd/debugfs.c
similarity index 100%
rename from drivers/iommu/amd_iommu_debugfs.c
rename to drivers/iommu/amd/debugfs.c
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd/init.c
similarity index 99%
rename from drivers/iommu/amd_iommu_init.c
rename to drivers/iommu/amd/init.c
index 5b81fd16f5fa..fda80fd1d9a6 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd/init.c
@@ -35,7 +35,7 @@
 #include "amd_iommu.h"
 #include "amd_iommu_proto.h"
 #include "amd_iommu_types.h"
-#include "irq_remapping.h"
+#include "../irq_remapping.h"
 
 /*
  * definitions for the ACPI scanning code
diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd/iommu.c
similarity index 99%
rename from drivers/iommu/amd_iommu.c
rename to drivers/iommu/amd/iommu.c
index 1b36c40d0712..39155f550f18 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -45,7 +45,7 @@
 
 #include "amd_iommu_proto.h"
 #include "amd_iommu_types.h"
-#include "irq_remapping.h"
+#include "../irq_remapping.h"
 
 #define CMD_SET_TYPE(cmd, t) ((cmd)->data[1] |= ((t) << 28))
 
diff --git a/drivers/iommu/amd_iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
similarity index 100%
rename from drivers/iommu/amd_iommu_v2.c
rename to drivers/iommu/amd/iommu_v2.c
diff --git a/drivers/iommu/amd_iommu_quirks.c b/drivers/iommu/amd/quirks.c
similarity index 100%
rename from drivers/iommu/amd_iommu_quirks.c
rename to drivers/iommu/amd/quirks.c
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
