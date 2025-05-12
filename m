Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9157E2951CE
	for <iommu@lists.linux.dev>; Mon, 12 May 2025 13:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.209.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747055808; cv=none; b=WEjbCD8GJR2E9/VIF4/gJMlnmCRy1CuHKCDfBew1uyOvF3tUQqScbonRlNCo7hMcj76G4cuMwyKqgiNNR6X0xDUwBsyJ9hVk0vD4kyJuOCSe6gE3ufCJ6on68FuBIuck8chfN5epwExFR056KZkbOdvHT19LZnaaGRW6RMdKrwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747055808; c=relaxed/simple;
	bh=npsPbasiX6BxV75yq8Vwu4nA/tujBxHet+iO7F6Phbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C7MsXE2o++uU8Gt85G77UK1BByCxlB26dALHdLRtyOIiIxENIzroUzeLAdxuDELaYDRVCp2KSzZ0KdTL+UKQOah8W1K2f2tN4KIVvLGLJK9Fe7AC0twMudCqQSuyo2KqG+KW1P1zNwOV1a0ibl+LQu1e+FteZaC6yVuvrLwCcNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com; spf=pass smtp.mailfrom=emlix.com; arc=none smtp.client-ip=178.63.209.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emlix.com
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.emlix.com (Postfix) with ESMTPS id E0F615FABF;
	Mon, 12 May 2025 15:16:15 +0200 (CEST)
From: Rolf Eike Beer <eb@emlix.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Jerry Snitselaar <jsnitsel@redhat.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 3/6] iommu: make inclusion of amd directory conditional
Date: Mon, 12 May 2025 15:12:52 +0200
Message-ID: <1894970.atdPhlSkOF@devpool92.emlix.com>
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

Nothing in there is active if CONFIG_AMD_IOMMU is not enabled, so the whole
directory can depend on that switch as well.

=46ixes: cbe94c6e1a7d ("iommu/amd: Move Kconfig and Makefile bits down into=
 amd directory")
Signed-off-by: Rolf Eike Beer <eb@emlix.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
=2D--
 drivers/iommu/Makefile     | 3 ++-
 drivers/iommu/amd/Makefile | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 53f8000753985..a486032d3e079 100644
=2D-- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
=2Dobj-y +=3D amd/ arm/ iommufd/ riscv/
+obj-y +=3D arm/ iommufd/ riscv/
+obj-$(CONFIG_AMD_IOMMU) +=3D amd/
 obj-$(CONFIG_INTEL_IOMMU) +=3D intel/
 obj-$(CONFIG_IOMMU_API) +=3D iommu.o
 obj-$(CONFIG_IOMMU_SUPPORT) +=3D iommu-pages.o
diff --git a/drivers/iommu/amd/Makefile b/drivers/iommu/amd/Makefile
index 9de33b2d42f52..59c04a67f3982 100644
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


