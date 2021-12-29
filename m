Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BFACC433F5
	for <iommu@archiver.kernel.org>; Wed, 29 Dec 2021 01:34:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3C3A881A58;
	Wed, 29 Dec 2021 01:34:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SLgw9STfxNTA; Wed, 29 Dec 2021 01:34:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 24C818188A;
	Wed, 29 Dec 2021 01:34:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 01EB4C001E;
	Wed, 29 Dec 2021 01:34:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D3DCC0012
 for <iommu@lists.linux-foundation.org>; Wed, 29 Dec 2021 01:34:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5E4D7605A4
 for <iommu@lists.linux-foundation.org>; Wed, 29 Dec 2021 01:34:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9TpcWY2-5FTm for <iommu@lists.linux-foundation.org>;
 Wed, 29 Dec 2021 01:34:36 +0000 (UTC)
X-Greylist: delayed 00:05:12 by SQLgrey-1.8.0
Received: from njjs-sys-mailin07.njjs.baidu.com (mx311.baidu.com
 [180.101.52.76])
 by smtp3.osuosl.org (Postfix) with ESMTP id EB0786006A
 for <iommu@lists.linux-foundation.org>; Wed, 29 Dec 2021 01:34:35 +0000 (UTC)
Received: from bjhw-sys-rpm015653cc5.bjhw.baidu.com
 (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
 by njjs-sys-mailin07.njjs.baidu.com (Postfix) with ESMTP id 0A31E19480056
 for <iommu@lists.linux-foundation.org>; Wed, 29 Dec 2021 09:29:20 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
 by bjhw-sys-rpm015653cc5.bjhw.baidu.com (Postfix) with ESMTP id E4994D9932
 for <iommu@lists.linux-foundation.org>; Wed, 29 Dec 2021 09:29:19 +0800 (CST)
From: Li RongQing <lirongqing@baidu.com>
To: iommu@lists.linux-foundation.org
Subject: [PATCH][RFC] iommu/amd: Add config option to set amd iommu off as
 default
Date: Wed, 29 Dec 2021 09:29:19 +0800
Message-Id: <1640741359-42539-1-git-send-email-lirongqing@baidu.com>
X-Mailer: git-send-email 1.7.1
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

AMD iommu is not needed by most users, but enabled by default, and
causes performance issue for some device like NICs, so add config
option to set amd iommu off as default as Intel

if AMD iommu is needed, it can be enabled by passing amd_iommu=on

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 1 +
 arch/x86/configs/x86_64_defconfig               | 1 +
 drivers/iommu/amd/Kconfig                       | 8 ++++++++
 drivers/iommu/amd/init.c                        | 4 +++-
 4 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9725c54..0c754c8 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -304,6 +304,7 @@
 			fullflush - Deprecated, equivalent to iommu.strict=1
 			off	  - do not initialize any AMD IOMMU found in
 				    the system
+			on	  - initialize any AMD IOMMU found in the system
 			force_isolation - Force device isolation for all
 					  devices. The IOMMU driver is not
 					  allowed anymore to lift isolation
diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defconfig
index e8a7a0a..0693b62 100644
--- a/arch/x86/configs/x86_64_defconfig
+++ b/arch/x86/configs/x86_64_defconfig
@@ -218,6 +218,7 @@ CONFIG_EEEPC_LAPTOP=y
 CONFIG_AMD_IOMMU=y
 CONFIG_INTEL_IOMMU=y
 # CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
+# CONFIG_AMD_IOMMU_DEFAULT_ON is not set
 CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
 CONFIG_EXT4_FS_SECURITY=y
diff --git a/drivers/iommu/amd/Kconfig b/drivers/iommu/amd/Kconfig
index a3cbafb..7962c46 100644
--- a/drivers/iommu/amd/Kconfig
+++ b/drivers/iommu/amd/Kconfig
@@ -32,6 +32,14 @@ config AMD_IOMMU_V2
 	  hardware. Select this option if you want to use devices that support
 	  the PCI PRI and PASID interface.
 
+config AMD_IOMMU_DEFAULT_ON
+	bool "Enable AMD IOMMU by default"
+	default n
+	help
+	  Selecting this option will enable a AMD IOMMU at boot time if
+	  one is found. If this option is not selected, AMD IOMMU support can
+	  be enabled by passing amd_iommu=on to the kernel.
+
 config AMD_IOMMU_DEBUGFS
 	bool "Enable AMD IOMMU internals in DebugFS"
 	depends on AMD_IOMMU && IOMMU_DEBUGFS
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 1eacd43..dcf24cb 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -155,7 +155,7 @@ int amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_VAPIC;
 static int amd_iommu_xt_mode = IRQ_REMAP_XAPIC_MODE;
 
 static bool amd_iommu_detected;
-static bool amd_iommu_disabled __initdata;
+static bool amd_iommu_disabled __initdata = !IS_ENABLED(CONFIG_AMD_IOMMU_DEFAULT_ON);
 static bool amd_iommu_force_enable __initdata;
 static int amd_iommu_target_ivhd_type;
 
@@ -3120,6 +3120,8 @@ static int __init parse_amd_iommu_options(char *str)
 			amd_iommu_force_enable = true;
 		if (strncmp(str, "off", 3) == 0)
 			amd_iommu_disabled = true;
+		if (strncmp(str, "on", 2) == 0)
+			amd_iommu_disabled = false;
 		if (strncmp(str, "force_isolation", 15) == 0)
 			amd_iommu_force_isolation = true;
 	}
-- 
2.9.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
