Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81E0222576
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 09:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.209.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742463109; cv=none; b=ONhNDFFfBPSgE8OrbeHusfLGNHkqKkWqugHSFaklMpwl6EMVecdBHLeoEI56h+0zhixdyoB7dK6OyUbZjMmffxsogyU6DVDt+33SuINvb1JTs6GEygOKmFyumohytEOAGDXMDiNrzrDWOc3tb3Oj0MqldKNUu/R7g680IzZ2vy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742463109; c=relaxed/simple;
	bh=d9OiXxFIdwYuFKxylfqHhftafUoXpw+nM0NbjZ9d0ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ucIMEu7t8nj1QQyxnCA0JGiASta1msLow0Jkm7qt43Tamvxc155jhRbRkW8c37SVy08E99Pxxkb1Wp5LjHrPB5CB9TlLNmiyYSNlCbL2huKLrPG0RuFgXwmDfvv+tyifsKW+xT5QHNMZ9c6Poa4TIM5dwUyqsZ0sp1v3twdE4aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com; spf=pass smtp.mailfrom=emlix.com; arc=none smtp.client-ip=178.63.209.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emlix.com
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.emlix.com (Postfix) with ESMTPS id D8AEC5FCE8;
	Thu, 20 Mar 2025 10:31:11 +0100 (CET)
From: Rolf Eike Beer <eb@emlix.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Jerry Snitselaar <jsnitsel@redhat.com>
Subject: [PATCH 2/6] iommu: make inclusion of intel directory conditional
Date: Thu, 20 Mar 2025 10:07:58 +0100
Message-ID: <12654723.O9o76ZdvQC@devpool47.emlix.com>
Organization: emlix GmbH
In-Reply-To: <12652899.O9o76ZdvQC@devpool47.emlix.com>
References: <12652899.O9o76ZdvQC@devpool47.emlix.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Nothing in there is active if CONFIG_INTEL_IOMMU is not enabled, so the who=
le
directory can depend on that switch as well.

=46ixes: ab65ba57e3ac ("iommu/vt-d: Move Kconfig and Makefile bits down int=
o intel directory")
Signed-off-by: Rolf Eike Beer <eb@emlix.com>
=2D--
 drivers/iommu/Makefile       | 3 ++-
 drivers/iommu/intel/Makefile | 7 ++-----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 5e5a83c6c2aa..ed673c8fd056 100644
=2D-- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
=2Dobj-y +=3D amd/ intel/ arm/ iommufd/ riscv/
+obj-y +=3D amd/ arm/ iommufd/ riscv/
+obj-$(CONFIG_INTEL_IOMMU) +=3D intel/
 obj-$(CONFIG_IOMMU_API) +=3D iommu.o
 obj-$(CONFIG_IOMMU_API) +=3D iommu-traces.o
 obj-$(CONFIG_IOMMU_API) +=3D iommu-sysfs.o
diff --git a/drivers/iommu/intel/Makefile b/drivers/iommu/intel/Makefile
index 6c7528130cf9..ada651c4a01b 100644
=2D-- a/drivers/iommu/intel/Makefile
+++ b/drivers/iommu/intel/Makefile
@@ -1,11 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
=2Dobj-$(CONFIG_DMAR_TABLE) +=3D dmar.o
=2Dobj-$(CONFIG_INTEL_IOMMU) +=3D iommu.o pasid.o nested.o cache.o prq.o
=2Dobj-$(CONFIG_DMAR_TABLE) +=3D trace.o
+obj-y +=3D iommu.o pasid.o nested.o cache.o prq.o
+obj-$(CONFIG_DMAR_TABLE) +=3D dmar.o trace.o
 obj-$(CONFIG_DMAR_PERF) +=3D perf.o
 obj-$(CONFIG_INTEL_IOMMU_DEBUGFS) +=3D debugfs.o
 obj-$(CONFIG_INTEL_IOMMU_SVM) +=3D svm.o
=2Difdef CONFIG_INTEL_IOMMU
 obj-$(CONFIG_IRQ_REMAP) +=3D irq_remapping.o
=2Dendif
 obj-$(CONFIG_INTEL_IOMMU_PERF_EVENTS) +=3D perfmon.o
=2D-=20
2.49.0

=2D-=20
Rolf Eike Beer

emlix GmbH
Headquarters: Berliner Str. 12, 37073 G=C3=B6ttingen, Germany
Phone +49 (0)551 30664-0, e-mail info@emlix.com
District Court of G=C3=B6ttingen, Registry Number HR B 3160
Managing Directors: Heike Jordan, Dr. Uwe Kracke
VAT ID No. DE 205 198 055
Office Berlin: Panoramastr. 1, 10178 Berlin, Germany
Office Bonn: Bachstr. 6, 53115 Bonn, Germany
http://www.emlix.com

emlix - your embedded Linux partner



