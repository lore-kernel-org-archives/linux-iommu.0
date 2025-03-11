Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC5C22D7BE
	for <iommu@lists.linux.dev>; Tue, 11 Mar 2025 10:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.209.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741688141; cv=none; b=MyDubTt65d+soI0hN4wXpob7wrDAeL5AQ5IQGUKL7JrtsCaZS+sE0k+r4CTWU/MuiduOdnXqwD6mrgvbUulvi2eE4bWIlLRDqRapHLvGWvQnwXIlUisxk+MHxgETDFS4yKoLdRfmyv4kly6nYxpGwI7nfFAU5kQvR4O0oCLrqzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741688141; c=relaxed/simple;
	bh=KrTHk7G1jAf3iel+oX8YasSxz1Z8g51fCS0gDqSk1qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FWUJQy4EbeYwvxg0w1k/AlL6R2HTtLlwRmIXgd9bl716/6rhBGD7eAWjijnrYOrcragy4XaBKq1VBTY0ys6R2vzrSBVDeL39HQEbM96lOB7uYuCZyji+bqHVSNNqTpNDcn25s9K15WHeQ/Fv0XF30WJo93JpAX7EiS/RcRtGZfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com; spf=pass smtp.mailfrom=emlix.com; arc=none smtp.client-ip=178.63.209.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emlix.com
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.emlix.com (Postfix) with ESMTPS id C28D25FC0B;
	Tue, 11 Mar 2025 11:15:25 +0100 (CET)
From: Rolf Eike Beer <eb@emlix.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Jerry Snitselaar <jsnitsel@redhat.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 3/4] iommu: make inclusion of amd directory conditional
Date: Tue, 11 Mar 2025 11:12:35 +0100
Message-ID: <1819907.VLH7GnMWUR@devpool47.emlix.com>
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

Nothing in there is active if CONFIG_AMD_IOMMU is not enabled, so the whole
directory can depend on that switch as well.

=46ixes: cbe94c6e1a7d ("iommu/amd: Move Kconfig and Makefile bits down into=
 amd directory")
Signed-off-by: Rolf Eike Beer <eb@emlix.com>
=2D--
 drivers/iommu/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

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


