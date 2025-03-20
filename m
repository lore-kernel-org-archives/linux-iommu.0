Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A2D1A5BBA
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 09:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.209.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742463075; cv=none; b=A8Eia+KIh9Lv+k+6d4/anfno5wG0u9lTSUbYzyqae/LpNDv9pq+GGyRioiKOr19J+dd06lFJ+aGwxiMKj7gMvOnxHykBv8XzNCdAZzk3U+rJbOJdV3redMVcCR8ak1CnaKZHcU8xXoNX/WiKEVB5cVoNfgPlvjXTwsImwj2OjvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742463075; c=relaxed/simple;
	bh=Y66KsA3GQgAvbU1qFYkPKPeelZgF94pVlJgOrb4lujQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZNyNDcUHTqgqi5tQn2OxiwiqTkSD+TDrNQJrNu1khdqdThSU1Q0/SfcvUihgyaic0eAlGf3fI3k/4Qfq+9Gx+KuVtmuwAMYOyQVYlaZmRZoOb/WC2sRTHMcownQlPryswL0G/bwEhcZWKERGf/Tksto/6sahC+6lhE/zuwXAvrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com; spf=pass smtp.mailfrom=emlix.com; arc=none smtp.client-ip=178.63.209.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emlix.com
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.emlix.com (Postfix) with ESMTPS id 6DCF05F8E7;
	Thu, 20 Mar 2025 10:31:10 +0100 (CET)
From: Rolf Eike Beer <eb@emlix.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>
Subject: [PATCH 6/6] iommu: make inclusion of iommufd directory conditional
Date: Thu, 20 Mar 2025 10:22:37 +0100
Message-ID: <2243601.irdbgypaU6@devpool47.emlix.com>
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

Nothing in there is active if CONFIG_IOMMUFD is not enabled, so the whole
directory can depend on that switch as well.

=46ixes: 2ff4bed7fee7 ("iommufd: File descriptor, context, kconfig and make=
files")
Signed-off-by: Rolf Eike Beer <eb@emlix.com>
=2D--
 drivers/iommu/Makefile         | 3 ++-
 drivers/iommu/iommufd/Makefile | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 17133876f777..38ee96607acf 100644
=2D-- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -1,8 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
=2Dobj-y +=3D arm/ iommufd/
+obj-y +=3D arm/
 obj-$(CONFIG_AMD_IOMMU) +=3D amd/
 obj-$(CONFIG_INTEL_IOMMU) +=3D intel/
 obj-$(CONFIG_RISCV_IOMMU) +=3D riscv/
+obj-$(CONFIG_IOMMUFD) +=3D iommufd/
 obj-$(CONFIG_IOMMU_API) +=3D iommu.o
 obj-$(CONFIG_IOMMU_API) +=3D iommu-traces.o
 obj-$(CONFIG_IOMMU_API) +=3D iommu-sysfs.o
diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
index cb784da6cddc..071f2a504167 100644
=2D-- a/drivers/iommu/iommufd/Makefile
+++ b/drivers/iommu/iommufd/Makefile
@@ -12,7 +12,7 @@ iommufd-y :=3D \
=20
 iommufd-$(CONFIG_IOMMUFD_TEST) +=3D selftest.o
=20
=2Dobj-$(CONFIG_IOMMUFD) +=3D iommufd.o
+obj-y +=3D iommufd.o
 obj-$(CONFIG_IOMMUFD_DRIVER) +=3D iova_bitmap.o
=20
 iommufd_driver-y :=3D driver.o
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


