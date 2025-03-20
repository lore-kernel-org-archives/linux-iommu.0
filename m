Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A0B1F4C8F
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 09:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.209.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742463117; cv=none; b=QcjUrXxfPGDcYpXHWkgzQukViSqAm7GCn3djkQp8zqp0MsCFqFhRqFXz5jf84cTvxcNYKH3jbsfZwXSOCuf95Urz0x44xhc0tvvPP9SzLJNF4zsOi4lNlDAa/eQnynQSzlYv0RR++YProe4mfsOHaeYHffwpR9B2SqX3YTadtEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742463117; c=relaxed/simple;
	bh=nnfouBf8SON5jE63ikN+AKqAAgyEXy2rNse/yoQdkto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mly++w2+uf36tKdl8PP+6yVGBln8Ns6BnDX5VBBRlBYLNJGx/P0hvQueqWhU2pU6if+VaRIdsePPdEHdOXGMM3nECkdi97fLDT4GzXET4WoGfrnNnOEH0chs246fOLpTSa221nEByodW8oOvUc3cNoxdzRT0zf/gOQ0RelZIFrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com; spf=pass smtp.mailfrom=emlix.com; arc=none smtp.client-ip=178.63.209.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emlix.com
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.emlix.com (Postfix) with ESMTPS id 345025FDF3;
	Thu, 20 Mar 2025 10:31:12 +0100 (CET)
From: Rolf Eike Beer <eb@emlix.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Bert Karwatzki <spasswolf@web.de>, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/6] iommu: remove duplicate selection of DMAR_TABLE
Date: Thu, 20 Mar 2025 10:05:18 +0100
Message-ID: <2797918.mvXUDI8C0e@devpool47.emlix.com>
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

This is already done in intel/Kconfig.

=46ixes: 70bad345e622 ("iommu: Fix compilation without CONFIG_IOMMU_INTEL")
Signed-off-by: Rolf Eike Beer <eb@emlix.com>
=2D--
 drivers/iommu/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index ec1b5e32b972..fceea41b7f58 100644
=2D-- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -200,7 +200,6 @@ source "drivers/iommu/riscv/Kconfig"
 config IRQ_REMAP
 	bool "Support for Interrupt Remapping"
 	depends on X86_64 && X86_IO_APIC && PCI_MSI && ACPI
=2D	select DMAR_TABLE if INTEL_IOMMU
 	help
 	  Supports Interrupt remapping for IO-APIC and MSI devices.
 	  To use x2apic mode in the CPU's which support x2APIC enhancements or
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



