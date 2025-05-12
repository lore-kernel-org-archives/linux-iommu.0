Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B22313AA2A
	for <iommu@lists.linux.dev>; Mon, 12 May 2025 13:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.209.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747055791; cv=none; b=S6MrI56keXF0fg8n1SEepebs2Jnqr7+SsObCjygHbxxAHvQ+mQ/LN9LbEiX27Vk2z9SIwxpJrzWC7b/1NRyGyKeUOfHcjLi/jsCINjbBMJWkdGXrITGTe5Qa0ZzRRylu45RNoxiOFyAxMbSPQ9WSlPxm4mkPDcUhNF30OdYhowQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747055791; c=relaxed/simple;
	bh=H73+3tsW2SPGZWXR5ryEIfSuDzJ2VrxopNCAsq+8JuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ksnhF84ZX2GefKlrI3QM+yMGmwvaYWqZnD5gvNKRA2qCnDsXJ5sRgTtPdAmTOQ7r8VnxgNCBPJfT7ES8varflQUUdbUzy39Gef+c+eOH8IG+iE787/5/uYFXp4AMB1lpks7MQAgtI+4wRtbbvwujmFf/ewbzpFbtD09lq2fs9TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com; spf=pass smtp.mailfrom=emlix.com; arc=none smtp.client-ip=178.63.209.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emlix.com
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.emlix.com (Postfix) with ESMTPS id 54AF75F954;
	Mon, 12 May 2025 15:16:15 +0200 (CEST)
From: Rolf Eike Beer <eb@emlix.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
Subject:
 [PATCH 5/6] iommu: make inclusion of arm/arm-smmu-v3 directory conditional
Date: Mon, 12 May 2025 15:14:46 +0200
Message-ID: <2434059.NG923GbCHz@devpool92.emlix.com>
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

Nothing in there is active if CONFIG_ARM_SMMU_V3 is not enabled, so the who=
le
directory can depend on that switch as well.

=46ixes: e86d1aa8b60f ("iommu/arm-smmu: Move Arm SMMU drivers into their ow=
n subdirectory")
Signed-off-by: Rolf Eike Beer <eb@emlix.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
=2D--
 drivers/iommu/arm/Makefile             | 3 ++-
 drivers/iommu/arm/arm-smmu-v3/Makefile | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/Makefile b/drivers/iommu/arm/Makefile
index 0f9efeab709ff..35a7e13eef344 100644
=2D-- a/drivers/iommu/arm/Makefile
+++ b/drivers/iommu/arm/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
=2Dobj-y +=3D arm-smmu/ arm-smmu-v3/
+obj-y +=3D arm-smmu/
+obj-$(CONFIG_ARM_SMMU_V3) +=3D arm-smmu-v3/
diff --git a/drivers/iommu/arm/arm-smmu-v3/Makefile b/drivers/iommu/arm/arm=
=2Dsmmu-v3/Makefile
index 493a659cc66bb..6cc7c8557b9ea 100644
=2D-- a/drivers/iommu/arm/arm-smmu-v3/Makefile
+++ b/drivers/iommu/arm/arm-smmu-v3/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
=2Dobj-$(CONFIG_ARM_SMMU_V3) +=3D arm_smmu_v3.o
+obj-y +=3D arm_smmu_v3.o
 arm_smmu_v3-y :=3D arm-smmu-v3.o
 arm_smmu_v3-$(CONFIG_ARM_SMMU_V3_IOMMUFD) +=3D arm-smmu-v3-iommufd.o
 arm_smmu_v3-$(CONFIG_ARM_SMMU_V3_SVA) +=3D arm-smmu-v3-sva.o
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


