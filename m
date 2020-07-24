Return-Path: <SRS0=ASoY=BD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94434C433E4
	for <iommu@archiver.kernel.org>; Fri, 24 Jul 2020 11:51:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5988720737
	for <iommu@archiver.kernel.org>; Fri, 24 Jul 2020 11:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxuUqCVF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5988720737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3C6D98800F;
	Fri, 24 Jul 2020 11:51:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hLiwgAjKydDN; Fri, 24 Jul 2020 11:51:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 40DEA87EA8;
	Fri, 24 Jul 2020 11:51:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2DB8FC004D;
	Fri, 24 Jul 2020 11:51:16 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1205AC004C
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jul 2020 11:51:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0C3AE87DB3
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jul 2020 11:51:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VkOryBwaSfPA for <iommu@lists.linux-foundation.org>;
 Fri, 24 Jul 2020 11:51:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1B42987D75
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jul 2020 11:51:14 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C55D8206E3;
 Fri, 24 Jul 2020 11:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595591473;
 bh=Xw3x5vASXphVNgXoqOa3wbQBOjeoPPtwQp6ERGqHuM0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oxuUqCVFGn0j5YrrBYniVsa6ZhQQDLo2WITIa7vuidKb0jFz5Nflf6cz9Ru7lGoa0
 jnqHEEP8rMnnCMCz5ZuHmUyStcst5bb+InJqnhvC44JmstVHLoFLPE58Rt4LLo5IFf
 Cx6WQjMxsHT7hR6c0GuqOykpXe0PGkK25VgYXI8s=
Date: Fri, 24 Jul 2020 12:51:09 +0100
From: Will Deacon <will@kernel.org>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [GIT PULL] iommu/arm-smmu: Updates for 5.9
Message-ID: <20200724115109.GA17451@willie-the-truck>
References: <20200721080352.GA13023@willie-the-truck>
 <20200722133323.GG27672@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200722133323.GG27672@8bytes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kernel-team@android.com, iommu@lists.linux-foundation.org,
 robin.murphy@arm.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
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

Hi Joerg,

On Wed, Jul 22, 2020 at 03:33:23PM +0200, Joerg Roedel wrote:
> On Tue, Jul 21, 2020 at 09:03:53AM +0100, Will Deacon wrote:
> > Please pull these Arm SMMU driver updates for 5.9. Summary is in the tag,
> > but the main thing is support for two new SoC integrations, one of which
> > is considerably more brain-dead than the other (determining which one is
> > left as an exercise to the reader although the diffstat is fairly revealing).
> 
> :)
> 
> > The following changes since commit 9ebcfadb0610322ac537dd7aa5d9cbc2b2894c68:
> > 
> >   Linux 5.8-rc3 (2020-06-28 15:00:24 -0700)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates
> 
> Pulled, thanks. Given the number of arm-smmu* files it probably makes
> sense to create a drivers/iommu/arm-smmu/ directory and move it all
> there. If you agree feel free to send this as an additional patch on-top
> of this pull-request.

Sure, that makes sense to me: I've included a diff below in case anybody
has comments. I've tackled it slightly differently to how the intel and
amd drivers are handled, since we have a header file (arm-smmu.h) which
is shared by a couple of different drivers. I've also moved the v3 driver
under the arm/ directory as Jean Philippe plans to split out the SVA work
for 5.10.

I'll send a second pull early next week if there are no objections (or
you can pick this patch directly).

Cheers,

Will

--->8

From 0e4a152062600f7f43ea4ea47925d12ec3a477ab Mon Sep 17 00:00:00 2001
From: Will Deacon <will@kernel.org>
Date: Fri, 24 Jul 2020 12:43:20 +0100
Subject: [PATCH] iommu/arm-smmu: Move Arm SMMU drivers into their own
 subdirectory

The Arm SMMU drivers are getting fat on vendor value-add, so move them
to their own subdirectory out of the way of the other IOMMU drivers.

Suggested-by: Joerg Roedel <joro@8bytes.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 MAINTAINERS                                        | 2 +-
 drivers/iommu/Makefile                             | 5 +----
 drivers/iommu/arm/Makefile                         | 2 ++
 drivers/iommu/arm/arm-smmu-v3/Makefile             | 2 ++
 drivers/iommu/{ => arm/arm-smmu-v3}/arm-smmu-v3.c  | 0
 drivers/iommu/arm/arm-smmu/Makefile                | 4 ++++
 drivers/iommu/{ => arm/arm-smmu}/arm-smmu-impl.c   | 0
 drivers/iommu/{ => arm/arm-smmu}/arm-smmu-nvidia.c | 0
 drivers/iommu/{ => arm/arm-smmu}/arm-smmu-qcom.c   | 0
 drivers/iommu/{ => arm/arm-smmu}/arm-smmu.c        | 0
 drivers/iommu/{ => arm/arm-smmu}/arm-smmu.h        | 0
 drivers/iommu/{ => arm/arm-smmu}/qcom_iommu.c      | 0
 12 files changed, 10 insertions(+), 5 deletions(-)
 create mode 100644 drivers/iommu/arm/Makefile
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/Makefile
 rename drivers/iommu/{ => arm/arm-smmu-v3}/arm-smmu-v3.c (100%)
 create mode 100644 drivers/iommu/arm/arm-smmu/Makefile
 rename drivers/iommu/{ => arm/arm-smmu}/arm-smmu-impl.c (100%)
 rename drivers/iommu/{ => arm/arm-smmu}/arm-smmu-nvidia.c (100%)
 rename drivers/iommu/{ => arm/arm-smmu}/arm-smmu-qcom.c (100%)
 rename drivers/iommu/{ => arm/arm-smmu}/arm-smmu.c (100%)
 rename drivers/iommu/{ => arm/arm-smmu}/arm-smmu.h (100%)
 rename drivers/iommu/{ => arm/arm-smmu}/qcom_iommu.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index ee2c0ba13a0f..6383801828c7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1498,7 +1498,7 @@ R:	Robin Murphy <robin.murphy@arm.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/iommu/arm,smmu*
-F:	drivers/iommu/arm-smmu*
+F:	drivers/iommu/arm/
 F:	drivers/iommu/io-pgtable-arm-v7s.c
 F:	drivers/iommu/io-pgtable-arm.c
 
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 2b8203db73ec..d971cffc810b 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+obj-y += arm/
 obj-$(CONFIG_IOMMU_API) += iommu.o
 obj-$(CONFIG_IOMMU_API) += iommu-traces.o
 obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
@@ -14,9 +15,6 @@ obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
 obj-$(CONFIG_AMD_IOMMU) += amd/iommu.o amd/init.o amd/quirks.o
 obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += amd/debugfs.o
 obj-$(CONFIG_AMD_IOMMU_V2) += amd/iommu_v2.o
-obj-$(CONFIG_ARM_SMMU) += arm_smmu.o
-arm_smmu-objs += arm-smmu.o arm-smmu-impl.o arm-smmu-nvidia.o arm-smmu-qcom.o
-obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
 obj-$(CONFIG_DMAR_TABLE) += intel/dmar.o
 obj-$(CONFIG_INTEL_IOMMU) += intel/iommu.o intel/pasid.o
 obj-$(CONFIG_INTEL_IOMMU) += intel/trace.o
@@ -35,6 +33,5 @@ obj-$(CONFIG_TEGRA_IOMMU_SMMU) += tegra-smmu.o
 obj-$(CONFIG_EXYNOS_IOMMU) += exynos-iommu.o
 obj-$(CONFIG_FSL_PAMU) += fsl_pamu.o fsl_pamu_domain.o
 obj-$(CONFIG_S390_IOMMU) += s390-iommu.o
-obj-$(CONFIG_QCOM_IOMMU) += qcom_iommu.o
 obj-$(CONFIG_HYPERV_IOMMU) += hyperv-iommu.o
 obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
diff --git a/drivers/iommu/arm/Makefile b/drivers/iommu/arm/Makefile
new file mode 100644
index 000000000000..0f9efeab709f
--- /dev/null
+++ b/drivers/iommu/arm/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-y += arm-smmu/ arm-smmu-v3/
diff --git a/drivers/iommu/arm/arm-smmu-v3/Makefile b/drivers/iommu/arm/arm-smmu-v3/Makefile
new file mode 100644
index 000000000000..569e24e9f162
--- /dev/null
+++ b/drivers/iommu/arm/arm-smmu-v3/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
similarity index 100%
rename from drivers/iommu/arm-smmu-v3.c
rename to drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
diff --git a/drivers/iommu/arm/arm-smmu/Makefile b/drivers/iommu/arm/arm-smmu/Makefile
new file mode 100644
index 000000000000..e240a7bcf310
--- /dev/null
+++ b/drivers/iommu/arm/arm-smmu/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_QCOM_IOMMU) += qcom_iommu.o
+obj-$(CONFIG_ARM_SMMU) += arm_smmu.o
+arm_smmu-objs += arm-smmu.o arm-smmu-impl.o arm-smmu-nvidia.o arm-smmu-qcom.o
diff --git a/drivers/iommu/arm-smmu-impl.c b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
similarity index 100%
rename from drivers/iommu/arm-smmu-impl.c
rename to drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
diff --git a/drivers/iommu/arm-smmu-nvidia.c b/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
similarity index 100%
rename from drivers/iommu/arm-smmu-nvidia.c
rename to drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
diff --git a/drivers/iommu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
similarity index 100%
rename from drivers/iommu/arm-smmu-qcom.c
rename to drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
similarity index 100%
rename from drivers/iommu/arm-smmu.c
rename to drivers/iommu/arm/arm-smmu/arm-smmu.c
diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
similarity index 100%
rename from drivers/iommu/arm-smmu.h
rename to drivers/iommu/arm/arm-smmu/arm-smmu.h
diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
similarity index 100%
rename from drivers/iommu/qcom_iommu.c
rename to drivers/iommu/arm/arm-smmu/qcom_iommu.c
-- 
2.28.0.rc0.142.g3c755180ce-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
