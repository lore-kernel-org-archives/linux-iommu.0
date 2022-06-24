Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC82C433EF
	for <iommu@archiver.kernel.org>; Fri, 24 Jun 2022 12:51:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4A65161467;
	Fri, 24 Jun 2022 12:51:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4A65161467
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I1tkuqGTlJTN; Fri, 24 Jun 2022 12:51:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0921460A6C;
	Fri, 24 Jun 2022 12:51:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0921460A6C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3AB4C0039;
	Fri, 24 Jun 2022 12:51:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 56F14C002D
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 12:51:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 23C0341A4B
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 12:51:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 23C0341A4B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7PaL4d6XQeyE for <iommu@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 12:51:47 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9E25541A19
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9E25541A19
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 12:51:46 +0000 (UTC)
Received: from cap.home.8bytes.org (p5b006cf2.dip0.t-ipconnect.de
 [91.0.108.242])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by theia.8bytes.org (Postfix) with ESMTPSA id D6869450;
 Fri, 24 Jun 2022 14:51:42 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2] MAINTAINERS: Add new IOMMU development mailing list
Date: Fri, 24 Jun 2022 14:51:39 +0200
Message-Id: <20220624125139.412-1-joro@8bytes.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Cc: Joerg Roedel <jroedel@suse.de>, iommu@lists.linux.dev,
 stable@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 iommu@lists.linux-foundation.org
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

From: Joerg Roedel <jroedel@suse.de>

The IOMMU mailing list will move from lists.linux-foundation.org to
lists.linux.dev. The hard switch of the archive will happen on July
5th, but add the new list now already so that people start using the
list when sending patches. After July 5th the old list will disappear.

Cc: stable@vger.kernel.org
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3cf9842d9233..36d1bc999815 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -427,6 +427,7 @@ ACPI VIOT DRIVER
 M:	Jean-Philippe Brucker <jean-philippe@linaro.org>
 L:	linux-acpi@vger.kernel.org
 L:	iommu@lists.linux-foundation.org
+L:	iommu@lists.linux.dev
 S:	Maintained
 F:	drivers/acpi/viot.c
 F:	include/linux/acpi_viot.h
@@ -960,6 +961,7 @@ AMD IOMMU (AMD-VI)
 M:	Joerg Roedel <joro@8bytes.org>
 R:	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
 L:	iommu@lists.linux-foundation.org
+L:	iommu@lists.linux.dev
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 F:	drivers/iommu/amd/
@@ -5962,6 +5964,7 @@ M:	Christoph Hellwig <hch@lst.de>
 M:	Marek Szyprowski <m.szyprowski@samsung.com>
 R:	Robin Murphy <robin.murphy@arm.com>
 L:	iommu@lists.linux-foundation.org
+L:	iommu@lists.linux.dev
 S:	Supported
 W:	http://git.infradead.org/users/hch/dma-mapping.git
 T:	git git://git.infradead.org/users/hch/dma-mapping.git
@@ -5974,6 +5977,7 @@ F:	kernel/dma/
 DMA MAPPING BENCHMARK
 M:	Xiang Chen <chenxiang66@hisilicon.com>
 L:	iommu@lists.linux-foundation.org
+L:	iommu@lists.linux.dev
 F:	kernel/dma/map_benchmark.c
 F:	tools/testing/selftests/dma/
 
@@ -7558,6 +7562,7 @@ F:	drivers/gpu/drm/exynos/exynos_dp*
 EXYNOS SYSMMU (IOMMU) driver
 M:	Marek Szyprowski <m.szyprowski@samsung.com>
 L:	iommu@lists.linux-foundation.org
+L:	iommu@lists.linux.dev
 S:	Maintained
 F:	drivers/iommu/exynos-iommu.c
 
@@ -9977,6 +9982,7 @@ INTEL IOMMU (VT-d)
 M:	David Woodhouse <dwmw2@infradead.org>
 M:	Lu Baolu <baolu.lu@linux.intel.com>
 L:	iommu@lists.linux-foundation.org
+L:	iommu@lists.linux.dev
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 F:	drivers/iommu/intel/
@@ -10356,6 +10362,7 @@ IOMMU DRIVERS
 M:	Joerg Roedel <joro@8bytes.org>
 M:	Will Deacon <will@kernel.org>
 L:	iommu@lists.linux-foundation.org
+L:	iommu@lists.linux.dev
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 F:	Documentation/devicetree/bindings/iommu/
@@ -12504,6 +12511,7 @@ F:	drivers/i2c/busses/i2c-mt65xx.c
 MEDIATEK IOMMU DRIVER
 M:	Yong Wu <yong.wu@mediatek.com>
 L:	iommu@lists.linux-foundation.org
+L:	iommu@lists.linux.dev
 L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 F:	Documentation/devicetree/bindings/iommu/mediatek*
@@ -16545,6 +16553,7 @@ F:	drivers/i2c/busses/i2c-qcom-cci.c
 QUALCOMM IOMMU
 M:	Rob Clark <robdclark@gmail.com>
 L:	iommu@lists.linux-foundation.org
+L:	iommu@lists.linux.dev
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
 F:	drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -19170,6 +19179,7 @@ F:	arch/x86/boot/video*
 SWIOTLB SUBSYSTEM
 M:	Christoph Hellwig <hch@infradead.org>
 L:	iommu@lists.linux-foundation.org
+L:	iommu@lists.linux.dev
 S:	Supported
 W:	http://git.infradead.org/users/hch/dma-mapping.git
 T:	git git://git.infradead.org/users/hch/dma-mapping.git
@@ -21844,6 +21854,7 @@ M:	Juergen Gross <jgross@suse.com>
 M:	Stefano Stabellini <sstabellini@kernel.org>
 L:	xen-devel@lists.xenproject.org (moderated for non-subscribers)
 L:	iommu@lists.linux-foundation.org
+L:	iommu@lists.linux.dev
 S:	Supported
 F:	arch/x86/xen/*swiotlb*
 F:	drivers/xen/*swiotlb*
-- 
2.36.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
