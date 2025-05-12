Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09E0295537
	for <iommu@lists.linux.dev>; Mon, 12 May 2025 13:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.209.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747055824; cv=none; b=I5ujqRuXgnPYs/hM2hVIYsXoGqS07CCL5FqpNcTG+Ao1Zur6T3YkzIf4heSoXH5faAg4POZdt7alca0Orwy+l63kirtGDPeDNgrCxBtL0t+iL76G4k4G8MC4Fdzhs4svXA1XbjxRrUMdYAVeXaRiXdtbcSWK/EBcWFnemI8Hr88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747055824; c=relaxed/simple;
	bh=Hvt4LIsPRWUkWnykT0SGqC7UBpw06qfOjTL5avE3m8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nHwqs4hZ6+V2fRQCNWBBfKYzn2zGEiyIE8Gp6AZo1bR8o6LLrUf86bURbGTHkYdBAnT14ctd4PNcc4LN/peIil86gNn9cXwOinhBUYHhAuDm4QapBi/QwBRmdURslj3mjVJV30HwlsThGB6ZlLfzJdt8BCM/6ohwrI//5YZyBLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com; spf=pass smtp.mailfrom=emlix.com; arc=none smtp.client-ip=178.63.209.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emlix.com
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.emlix.com (Postfix) with ESMTPS id 832555FDEF;
	Mon, 12 May 2025 15:16:16 +0200 (CEST)
From: Rolf Eike Beer <eb@emlix.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Bert Karwatzki <spasswolf@web.de>, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/6] iommu: remove duplicate selection of DMAR_TABLE
Date: Mon, 12 May 2025 15:10:44 +0200
Message-ID: <2232605.Mh6RI2rZIc@devpool92.emlix.com>
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

This is already done in intel/Kconfig.

=46ixes: 70bad345e622 ("iommu: Fix compilation without CONFIG_IOMMU_INTEL")
Signed-off-by: Rolf Eike Beer <eb@emlix.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
=2D--
 drivers/iommu/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 9c3c210c82a2d..0a33d995d15dd 100644
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


