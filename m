Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713227B
	for <iommu@lists.linux.dev>; Sat,  9 Jul 2022 08:30:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE760C3411C;
	Sat,  9 Jul 2022 08:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1657355434;
	bh=n3sOzYysVnmVB5AZFY0EVa9mIiJAanqfVEZ/sLo/n0c=;
	h=Subject:To:Cc:From:Date:From;
	b=BLK9n9uEH7FPwfULPYQx/u3dbDXbBJw9yxLvcJCZQ6BRQgvAoE8cqwUIdCaJIOJi1
	 k651K3CfvqcGMpoGf9zTlgthrRD3oWP4OasmcER7Ebo4kQ2+JUh4oX0iVDAh7bHrb7
	 B1YmIXKuIhVv/bO3RkY9hQIx72ASURbu9VkfMZbk=
Subject: Patch "MAINTAINERS: Remove iommu@lists.linux-foundation.org" has been added to the 5.18-stable tree
To: gregkh@linuxfoundation.org,iommu@lists.linux-foundation.org,iommu@lists.linux.dev,jroedel@suse.de
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 09 Jul 2022 10:29:32 +0200
Message-ID: <16573553724258@kroah.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 


This is a note to let you know that I've just added the patch titled

    MAINTAINERS: Remove iommu@lists.linux-foundation.org

to the 5.18-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     maintainers-remove-iommu-lists.linux-foundation.org.patch
and it can be found in the queue-5.18 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From c51b8f85c4157eb91c2f4ab34b0c52fea642e77c Mon Sep 17 00:00:00 2001
From: Joerg Roedel <jroedel@suse.de>
Date: Wed, 6 Jul 2022 12:33:31 +0200
Subject: MAINTAINERS: Remove iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

commit c51b8f85c4157eb91c2f4ab34b0c52fea642e77c upstream.

The IOMMU mailing list has moved to iommu@lists.linux.dev
and the old list should bounce by now. Remove it from the
MAINTAINERS file.

Cc: stable@vger.kernel.org
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Link: https://lore.kernel.org/r/20220706103331.10215-1-joro@8bytes.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 MAINTAINERS |   11 -----------
 1 file changed, 11 deletions(-)

--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -426,7 +426,6 @@ F:	drivers/acpi/*thermal*
 ACPI VIOT DRIVER
 M:	Jean-Philippe Brucker <jean-philippe@linaro.org>
 L:	linux-acpi@vger.kernel.org
-L:	iommu@lists.linux-foundation.org
 L:	iommu@lists.linux.dev
 S:	Maintained
 F:	drivers/acpi/viot.c
@@ -960,7 +959,6 @@ F:	drivers/video/fbdev/geode/
 AMD IOMMU (AMD-VI)
 M:	Joerg Roedel <joro@8bytes.org>
 R:	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
-L:	iommu@lists.linux-foundation.org
 L:	iommu@lists.linux.dev
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
@@ -5899,7 +5897,6 @@ DMA MAPPING HELPERS
 M:	Christoph Hellwig <hch@lst.de>
 M:	Marek Szyprowski <m.szyprowski@samsung.com>
 R:	Robin Murphy <robin.murphy@arm.com>
-L:	iommu@lists.linux-foundation.org
 L:	iommu@lists.linux.dev
 S:	Supported
 W:	http://git.infradead.org/users/hch/dma-mapping.git
@@ -5912,7 +5909,6 @@ F:	kernel/dma/
 
 DMA MAPPING BENCHMARK
 M:	Xiang Chen <chenxiang66@hisilicon.com>
-L:	iommu@lists.linux-foundation.org
 L:	iommu@lists.linux.dev
 F:	kernel/dma/map_benchmark.c
 F:	tools/testing/selftests/dma/
@@ -7479,7 +7475,6 @@ F:	drivers/gpu/drm/exynos/exynos_dp*
 
 EXYNOS SYSMMU (IOMMU) driver
 M:	Marek Szyprowski <m.szyprowski@samsung.com>
-L:	iommu@lists.linux-foundation.org
 L:	iommu@lists.linux.dev
 S:	Maintained
 F:	drivers/iommu/exynos-iommu.c
@@ -9879,7 +9874,6 @@ F:	drivers/hid/intel-ish-hid/
 INTEL IOMMU (VT-d)
 M:	David Woodhouse <dwmw2@infradead.org>
 M:	Lu Baolu <baolu.lu@linux.intel.com>
-L:	iommu@lists.linux-foundation.org
 L:	iommu@lists.linux.dev
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
@@ -10258,7 +10252,6 @@ F:	include/linux/iomap.h
 IOMMU DRIVERS
 M:	Joerg Roedel <joro@8bytes.org>
 M:	Will Deacon <will@kernel.org>
-L:	iommu@lists.linux-foundation.org
 L:	iommu@lists.linux.dev
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
@@ -12375,7 +12368,6 @@ F:	drivers/i2c/busses/i2c-mt65xx.c
 
 MEDIATEK IOMMU DRIVER
 M:	Yong Wu <yong.wu@mediatek.com>
-L:	iommu@lists.linux-foundation.org
 L:	iommu@lists.linux.dev
 L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
@@ -16361,7 +16353,6 @@ F:	drivers/i2c/busses/i2c-qcom-cci.c
 
 QUALCOMM IOMMU
 M:	Rob Clark <robdclark@gmail.com>
-L:	iommu@lists.linux-foundation.org
 L:	iommu@lists.linux.dev
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
@@ -18947,7 +18938,6 @@ F:	arch/x86/boot/video*
 
 SWIOTLB SUBSYSTEM
 M:	Christoph Hellwig <hch@infradead.org>
-L:	iommu@lists.linux-foundation.org
 L:	iommu@lists.linux.dev
 S:	Supported
 W:	http://git.infradead.org/users/hch/dma-mapping.git
@@ -21618,7 +21608,6 @@ XEN SWIOTLB SUBSYSTEM
 M:	Juergen Gross <jgross@suse.com>
 M:	Stefano Stabellini <sstabellini@kernel.org>
 L:	xen-devel@lists.xenproject.org (moderated for non-subscribers)
-L:	iommu@lists.linux-foundation.org
 L:	iommu@lists.linux.dev
 S:	Supported
 F:	arch/x86/xen/*swiotlb*


Patches currently in stable-queue which might be from jroedel@suse.de are

queue-5.18/iommu-vt-d-fix-rid2pasid-setup-teardown-failure.patch
queue-5.18/iommu-vt-d-fix-pci-bus-rescan-device-hot-add.patch
queue-5.18/maintainers-remove-iommu-lists.linux-foundation.org.patch
