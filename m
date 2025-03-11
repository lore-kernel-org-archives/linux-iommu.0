Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188393EA83
	for <iommu@lists.linux.dev>; Tue, 11 Mar 2025 10:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.209.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741688519; cv=none; b=Jc6iE7GiNFEB0nAXJriduJIxE4JYF2cEWDk9HdjCvObhY4+qkhc+yt/cpsoCAOHtW3O5c61b7HA4uQvhADrELjv9Nl4PdpyE/3W4mENmjQYxoZTMve5Ri9N8ceq5Sq6U53WxccXPDoY5wmKRlwSDjE6blPRYr7x1IHvvaRppI2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741688519; c=relaxed/simple;
	bh=ZSbAFnMZ0+Ui2fIy0XEgIhYav8KJwGrdYWtBLNCLH98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qW7xXUCCpDC1eIOXF6lDFuTbMR7fKBetgxl38gjVtARDYssZhlLgtNRtu8/OHZyMN1lNK5OcBZhHp+ha0iiAUy4iuBhdh3Vk0D3SEq7j83cNSOEIdZNyABZoTmlE8cHPvnULJqVOAzG91IyNp7Ewg8/u96V24WXu5y+YS2OjVL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com; spf=pass smtp.mailfrom=emlix.com; arc=none smtp.client-ip=178.63.209.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emlix.com
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.emlix.com (Postfix) with ESMTPS id 6DD395F909;
	Tue, 11 Mar 2025 11:15:25 +0100 (CET)
From: Rolf Eike Beer <eb@emlix.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Tomasz Jeznach <tjeznach@rivosinc.com>, Nick Kossifidis <mick@ics.forth.gr>,
 Sebastien Boeuf <seb@rivosinc.com>, Lu Baolu <baolu.lu@linux.intel.com>,
 Palmer Dabbelt <palmer@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH 4/4] iommu: make inclusion of riscv directory conditional
Date: Tue, 11 Mar 2025 11:15:12 +0100
Message-ID: <3536592.QJadu78ljV@devpool47.emlix.com>
Organization: emlix GmbH
In-Reply-To: <2301497.iZASKD2KPV@devpool47.emlix.com>
References: <2301497.iZASKD2KPV@devpool47.emlix.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Nothing in there is active if CONFIG_RISCV_IOMMU is not enabled, so the who=
le
directory can depend on that switch as well.

=46ixes: 5c0ebbd3c6c6 ("iommu/riscv: Add RISC-V IOMMU platform device drive=
r")
Signed-off-by: Rolf Eike Beer <eb@emlix.com>
=2D--
 drivers/iommu/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 41b00cdc8621..17133876f777 100644
=2D-- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -1,7 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
=2Dobj-y +=3D arm/ iommufd/ riscv/
+obj-y +=3D arm/ iommufd/
 obj-$(CONFIG_AMD_IOMMU) +=3D amd/
 obj-$(CONFIG_INTEL_IOMMU) +=3D intel/
+obj-$(CONFIG_RISCV_IOMMU) +=3D riscv/
 obj-$(CONFIG_IOMMU_API) +=3D iommu.o
 obj-$(CONFIG_IOMMU_API) +=3D iommu-traces.o
 obj-$(CONFIG_IOMMU_API) +=3D iommu-sysfs.o
=2D-=20
2.48.1


=2D-=20
Rolf Eike Beer

We are nominated for the embedded award Visit us at the embedded=20
world 2025 March 11th to 13th, 2025 | Nuremberg Find us in hall 4 at=20
booth 336

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


