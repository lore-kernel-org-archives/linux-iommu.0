Return-Path: <SRS0=VyMr=O3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B543AC433F5
	for <iommu@archiver.kernel.org>; Thu,  7 Oct 2021 15:10:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6066A61175
	for <iommu@archiver.kernel.org>; Thu,  7 Oct 2021 15:10:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6066A61175
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2FE4083F34;
	Thu,  7 Oct 2021 15:10:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lySTnpNAO47y; Thu,  7 Oct 2021 15:10:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0CB9083EB7;
	Thu,  7 Oct 2021 15:10:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA681C0011;
	Thu,  7 Oct 2021 15:10:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AF853C000D
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 15:10:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9168F607D7
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 15:10:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id InnF6E6o-3pk for <iommu@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 15:10:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DB3DE60754
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 15:10:23 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B0B26113E;
 Thu,  7 Oct 2021 15:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1633619423;
 bh=6XparVng5W/AReJHiKchmXlIe9lsC3Z91YzkLUlPNCg=;
 h=From:To:Cc:Subject:Date:From;
 b=uGBU3w5ZPcovOtfzM/FIsHTD7h3JxuPJygqvsc/Akx8WIgRCpgs3UgXZBZTV82I1O
 pW+TIPVurN88xf3WvDzFDkgp4KUNa7HpHH0yruRMhNm5135jx5bqq+/CKSzQGvE9Do
 ViwsXF7lFqxOsI6bHhr9Jy2jv4XcchqTsLVaQi+z5d/b1rYbgoS7hR41kw3y30v3an
 GfXh2Vp3SSFv+/Ic2Yauk4D9evUCiGVqN10/ZzGkA3ER8QQimEVtKd0+OTGa/g7KUM
 0ggiEgI2DrGim19ev5P6YtxGkOvCy0ZLC7gw6ICyGtfCMR5AINWv1keeKoUptUyCZ3
 OdUDZ2/BTlnCQ==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] firmware: include drivers/firmware/Kconfig
 unconditionally
Date: Thu,  7 Oct 2021 17:10:09 +0200
Message-Id: <20211007151010.333516-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Cc: linux-ia64@vger.kernel.org, linux-mmc@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-mips@vger.kernel.org,
 linux-riscv@lists.infradead.org, Will Deacon <will@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, ath10k@lists.infradead.org,
 linux-media@vger.kernel.org, Charles Keepax <ckeepax@opensource.cirrus.com>,
 Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
 Simon Trimmer <simont@opensource.cirrus.com>, linux-gpio@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-parisc@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 iommu@lists.linux-foundation.org, freedreno@lists.freedesktop.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Arnd Bergmann <arnd@arndb.de>

Compile-testing drivers that require access to a firmware layer
fails when that firmware symbol is unavailable. This happened
twice this week:

 - My proposed to change to rework the QCOM_SCM firmware symbol
   broke on ppc64 and others.

 - The cs_dsp firmware patch added device specific firmware loader
   into drivers/firmware, which broke on the same set of
   architectures.

We should probably do the same thing for other subsystems as well,
but fix this one first as this is a dependency for other patches
getting merged.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Acked-by: Will Deacon <will@kernel.org>
Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Simon Trimmer <simont@opensource.cirrus.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Reviewed-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
No changes in v2, but it's now queued in my asm-generic
tree for v5.15

 arch/arm/Kconfig    | 2 --
 arch/arm64/Kconfig  | 2 --
 arch/ia64/Kconfig   | 2 --
 arch/mips/Kconfig   | 2 --
 arch/parisc/Kconfig | 2 --
 arch/riscv/Kconfig  | 2 --
 arch/x86/Kconfig    | 2 --
 drivers/Kconfig     | 2 ++
 8 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index fc196421b2ce..59baf6c132a7 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1989,8 +1989,6 @@ config ARCH_HIBERNATION_POSSIBLE
 
 endmenu
 
-source "drivers/firmware/Kconfig"
-
 if CRYPTO
 source "arch/arm/crypto/Kconfig"
 endif
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 077f2ec4eeb2..407b4addea36 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1931,8 +1931,6 @@ source "drivers/cpufreq/Kconfig"
 
 endmenu
 
-source "drivers/firmware/Kconfig"
-
 source "drivers/acpi/Kconfig"
 
 source "arch/arm64/kvm/Kconfig"
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 045792cde481..1e33666fa679 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -388,8 +388,6 @@ config CRASH_DUMP
 	  help
 	    Generate crash dump after being started by kexec.
 
-source "drivers/firmware/Kconfig"
-
 endmenu
 
 menu "Power management and ACPI options"
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 771ca53af06d..6b8f591c5054 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -3316,8 +3316,6 @@ source "drivers/cpuidle/Kconfig"
 
 endmenu
 
-source "drivers/firmware/Kconfig"
-
 source "arch/mips/kvm/Kconfig"
 
 source "arch/mips/vdso/Kconfig"
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index 4742b6f169b7..27a8b49af11f 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -384,6 +384,4 @@ config KEXEC_FILE
 
 endmenu
 
-source "drivers/firmware/Kconfig"
-
 source "drivers/parisc/Kconfig"
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index c3f3fd583e04..8bc71ab143e3 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -561,5 +561,3 @@ menu "Power management options"
 source "kernel/power/Kconfig"
 
 endmenu
-
-source "drivers/firmware/Kconfig"
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4e001bbbb425..4dca39744ee9 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2828,8 +2828,6 @@ config HAVE_ATOMIC_IOMAP
 	def_bool y
 	depends on X86_32
 
-source "drivers/firmware/Kconfig"
-
 source "arch/x86/kvm/Kconfig"
 
 source "arch/x86/Kconfig.assembler"
diff --git a/drivers/Kconfig b/drivers/Kconfig
index 30d2db37cc87..0d399ddaa185 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -17,6 +17,8 @@ source "drivers/bus/Kconfig"
 
 source "drivers/connector/Kconfig"
 
+source "drivers/firmware/Kconfig"
+
 source "drivers/gnss/Kconfig"
 
 source "drivers/mtd/Kconfig"
-- 
2.29.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
