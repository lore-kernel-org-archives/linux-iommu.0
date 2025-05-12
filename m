Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2890025B666
	for <iommu@lists.linux.dev>; Mon, 12 May 2025 13:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.209.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747056134; cv=none; b=cVwKTjuEq/453gsWE3Bzm2KuvH2C/CnUCwVNthgq35+BujUQlpDo1/t5iqoXPeTtBQZCpXu/enIvRcdjKRJP617EHM1YObSWONqtgI1UxHvyOTrXOLToL7FBMYZcFM4eBmA+wrtwvSCZBd5u4i6RnitYSpmGVziwOuKik5nOHU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747056134; c=relaxed/simple;
	bh=htb/hrDPb1CGRtd9p+vyz/ZKL8zvQllVbEP5Vnuk39Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sfibgJnjzNKqy4TtarGJQ3IbH4HRVXHkx46u4ROJQy2EHjNkJqqh3Co9i/hwyOSfKVWmVSOM81++EPtnDY3MkzPgXRko9NPX910spvjQMEBNYtiZjIW7V4q30FYzCF04lIS4AQrfxrTZSH50NhOq3z1vRlb4pwr3L8R8EaArIGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com; spf=pass smtp.mailfrom=emlix.com; arc=none smtp.client-ip=178.63.209.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emlix.com
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.emlix.com (Postfix) with ESMTPS id 0C1BA5F739;
	Mon, 12 May 2025 15:16:15 +0200 (CEST)
From: Rolf Eike Beer <eb@emlix.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH 6/6] iommu: make inclusion of iommufd directory conditional
Date: Mon, 12 May 2025 15:15:52 +0200
Message-ID: <5568089.Sb9uPGUboI@devpool92.emlix.com>
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

Nothing in there is active if CONFIG_IOMMUFD is not enabled, so the whole
directory can depend on that switch as well.

=46ixes: 2ff4bed7fee7 ("iommufd: File descriptor, context, kconfig and make=
files")
Signed-off-by: Rolf Eike Beer <eb@emlix.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
=2D--
 drivers/iommu/Makefile         | 3 ++-
 drivers/iommu/iommufd/Makefile | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 355294fa9033f..d0a42da2dfa5b 100644
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
 obj-$(CONFIG_IOMMU_SUPPORT) +=3D iommu-pages.o
 obj-$(CONFIG_IOMMU_API) +=3D iommu-traces.o
diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
index 71d692c9a8f49..21fa1775eae3f 100644
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


