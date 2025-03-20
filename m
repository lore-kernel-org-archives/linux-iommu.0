Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7384742A93
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 09:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.209.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742463100; cv=none; b=qpHe4P36bvDo4ySbdSUgQHn5U+xxnWjuJGpqRUwXQ240Drvg/auBTdqh0u001KTpgx9evcWslC+GQfev+mKzQQcYb8lT39yGAYzWvVn0OWgIww6s0ZCvVHYr+k37SiTg5M7TSZQeu6CalnLd0fZ/2PZ9UAHWK/WAAHRsNAMVrtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742463100; c=relaxed/simple;
	bh=10Xzpfxhb3jedp2+7OzV3d9Sa+CRTIgs+auGCBtAp3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cwrn4eZzoWLS3YpIr6yCFLg10RBsDALgNPk/9yK10bHmdcCThs9CeJyL6CtJ1LI4MpbIhLFKrI31ycHhnNKd/M4jb6+4RXHPCpipipC+mzfzfobM5lekMptLbTWokclprA9C3bMaSbOR7jVTeuC2I+dLl1AK4XKEN7cbPi47wHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com; spf=pass smtp.mailfrom=emlix.com; arc=none smtp.client-ip=178.63.209.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emlix.com
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.emlix.com (Postfix) with ESMTPS id 8B3A25FC89;
	Thu, 20 Mar 2025 10:31:11 +0100 (CET)
From: Rolf Eike Beer <eb@emlix.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Jerry Snitselaar <jsnitsel@redhat.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 3/6] iommu: make inclusion of amd directory conditional
Date: Thu, 20 Mar 2025 10:14:45 +0100
Message-ID: <5895641.DvuYhMxLoT@devpool47.emlix.com>
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

Nothing in there is active if CONFIG_AMD_IOMMU is not enabled, so the whole
directory can depend on that switch as well.

=46ixes: cbe94c6e1a7d ("iommu/amd: Move Kconfig and Makefile bits down into=
 amd directory")
Signed-off-by: Rolf Eike Beer <eb@emlix.com>
=2D--
 drivers/iommu/Makefile     | 3 ++-
 drivers/iommu/amd/Makefile | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index ed673c8fd056..41b00cdc8621 100644
=2D-- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
=2Dobj-y +=3D amd/ arm/ iommufd/ riscv/
+obj-y +=3D arm/ iommufd/ riscv/
+obj-$(CONFIG_AMD_IOMMU) +=3D amd/
 obj-$(CONFIG_INTEL_IOMMU) +=3D intel/
 obj-$(CONFIG_IOMMU_API) +=3D iommu.o
 obj-$(CONFIG_IOMMU_API) +=3D iommu-traces.o
diff --git a/drivers/iommu/amd/Makefile b/drivers/iommu/amd/Makefile
index 9de33b2d42f5..59c04a67f398 100644
=2D-- a/drivers/iommu/amd/Makefile
+++ b/drivers/iommu/amd/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
=2Dobj-$(CONFIG_AMD_IOMMU) +=3D iommu.o init.o quirks.o io_pgtable.o io_pgt=
able_v2.o ppr.o pasid.o
+obj-y +=3D iommu.o init.o quirks.o io_pgtable.o io_pgtable_v2.o ppr.o pasi=
d.o
 obj-$(CONFIG_AMD_IOMMU_DEBUGFS) +=3D debugfs.o
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



