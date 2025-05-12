Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C318293B6C
	for <iommu@lists.linux.dev>; Mon, 12 May 2025 13:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.209.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747055816; cv=none; b=URpwqYh4PjJipJkyYTe676PFEdMKX9VMxt61oEKpjslhMsSQoVi/AZiXylOcx37u4DXlP7+/ioy/GbVf2pzKI6hh1FSQCTnLqJaU5R900qu8USnGXBKgjNPAQD+Z3hYg0KQ6w0kide33JG2upCtviS7EH3PizHGHuLD7tSdbOY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747055816; c=relaxed/simple;
	bh=MYbPtDblzJC/s5G3ktAfGJUokPDmzrPKFuBcbmY/dY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DRtvzryd6X6EDugPBTIhvjVOV5f/Pi15Odj26um7HJJeyJGPB7Mn4DKKfk8g3oFh+po6RHjIOUpp/GJME6vb1TKGPAVQ8pB7cXfwIaFijG8ea3IsKsSK7oAoXExFc+rxGXn3J31uZHuNNWpN65kTOnGja/etPaiMHCjERKBrhB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com; spf=pass smtp.mailfrom=emlix.com; arc=none smtp.client-ip=178.63.209.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emlix.com
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.emlix.com (Postfix) with ESMTPS id 38DCE5FAFA;
	Mon, 12 May 2025 15:16:16 +0200 (CEST)
From: Rolf Eike Beer <eb@emlix.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Jerry Snitselaar <jsnitsel@redhat.com>
Subject: [PATCH 2/6] iommu: make inclusion of intel directory conditional
Date: Mon, 12 May 2025 15:11:51 +0200
Message-ID: <3818749.MHq7AAxBmi@devpool92.emlix.com>
Organization: emlix GmbH
In-Reply-To: <1926170.CQOukoFCf9@devpool92.emlix.com>
References: <1926170.CQOukoFCf9@devpool92.emlix.com>
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
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
=2D--
 drivers/iommu/Makefile       | 3 ++-
 drivers/iommu/intel/Makefile | 7 ++-----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index fe91d770abe16..53f8000753985 100644
=2D-- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
=2Dobj-y +=3D amd/ intel/ arm/ iommufd/ riscv/
+obj-y +=3D amd/ arm/ iommufd/ riscv/
+obj-$(CONFIG_INTEL_IOMMU) +=3D intel/
 obj-$(CONFIG_IOMMU_API) +=3D iommu.o
 obj-$(CONFIG_IOMMU_SUPPORT) +=3D iommu-pages.o
 obj-$(CONFIG_IOMMU_API) +=3D iommu-traces.o
diff --git a/drivers/iommu/intel/Makefile b/drivers/iommu/intel/Makefile
index 6c7528130cf9d..ada651c4a01b2 100644
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


