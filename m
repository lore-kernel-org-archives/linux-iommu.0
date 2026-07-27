Received: from out13-173.antispamcloud.com (out13-173.antispamcloud.com [185.201.17.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9796663B9;
	Mon, 27 Jul 2026 22:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.201.17.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785192373; cv=none; b=Yo+tN+E0N8+FfD7tBC0r5qNWD1LWqI4bE7ZMshww9DuC4luuTO5+0mjuTa8UqV5BcxLDlqGa2YIr81mY6IP0+Z3ZI/eGscYeq6JLl+DancAoCRjFgWH3ahpwP3FmseiEM2tnnRkzCZtAWCH6Nap5/q+dbk6Ojk3jysiljrWYOkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785192373; c=relaxed/simple;
	bh=CicsgFggvW1eANd8ZDR3bX7ikXQsWDx/XYgM89ppqXo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Q2Dr4v03xJCvIvYbcTYW1BVf4MA/IMk14fSQnPr7r+V4wDxsKVuFAVmISPjbXB+fouh2LOq4MdcIB3GpFc5gwIsLTz2WVgu7N0GXPFyDv67Eoo1HB/ifGJ2ONDbLj3SvlrpNWvl1EGtQ27c8oXV1LUd/rofCoEZZDp5VQsIbff8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reactivated.net; spf=pass smtp.mailfrom=reactivated.net; dkim=pass (2048-bit key) header.d=reactivated.net header.i=@reactivated.net header.b=UCilzL4M; arc=none smtp.client-ip=185.201.17.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reactivated.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=reactivated.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=reactivated.net header.i=@reactivated.net header.b="UCilzL4M"
Received: from s1041.use1.mysecurecloudhost.com ([192.250.231.249])
	by mx198.antispamcloud.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <dan@reactivated.net>)
	id 1woSC0-00FDwj-1a; Mon, 27 Jul 2026 22:45:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=reactivated.net; s=default; h=Cc:To:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hyHKtkGi7woybfIrgSqWUmKJ5jpuveV8TLON1rwbb2c=; b=UCilzL4M7m0SVntEPlx3EZVZbq
	OCUFSTSBPx1w6789Pg4NrwhivmgA5C5LHWUVCFiEXSz8WVeiQdjIgicW6rFKyIVGsH2rSwuIFftGo
	keS4N6yUCiTgdyB2RMgczLEZlpR3AxHk1R0j/9bCNOtewXta8vX1/HL8VT1KDTpFFxdB+DcB09/CJ
	xhjAGSpHrt1ekxpsk5o4DvMLOKE+9ODL1CBuIg4ZoDt3gGl7iMdtj0LLLbY5lMo2/Vhh6HSUD97Kw
	btwyiO/Z/l6a0q4iXyimFbUtvXIrWbeKS6cq+usZKPSUU7+UPqEUzVLdwzgCvNNE4uWVRLId9gbt5
	UV6nXhlA==;
Received: from [188.251.249.2] (port=52006 helo=[192.168.1.123])
	by s1041.use1.mysecurecloudhost.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <dan@reactivated.net>)
	id 1woSBr-0000000AlhO-1LDa;
	Mon, 27 Jul 2026 20:44:47 +0000
From: Daniel Drake <dan@reactivated.net>
Subject: [PATCH v2 0/5] Add support for Broadcom BCM2712 IOMMU driver
 (Raspberry Pi 5)
Date: Mon, 27 Jul 2026 21:43:55 +0100
Message-Id: <20260727-bcm2712-iommu-submit-v2-0-0247b5c03de8@reactivated.net>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNTQ7CIBhEr2JYiwGitXXlPUwX/Iz2W0ANUKJpe
 nehF3A1ecnMvJUlREJit8PKIgolmkMFdTwwO+nwAidXmSmhOnGVihvrVUuavV94WoynzBXE0A8
 Duos9szp9Rzzps98+xspGJ3ATdbBTO/M6ZcRWnCjlOX53fZGt/sdUJBe8F5DCOgcFfY/QNlPRG
 e4UkNm4bdsPOm+Qq9cAAAA=
X-Change-ID: 20260712-bcm2712-iommu-submit-2e09899e65c4
To: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Daniel Drake <dan@reactivated.net>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, nick.hollinghurst@raspberrypi.com, 
 Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: b4 0.14.3
X-Get-Message-Sender-Via: s1041.use1.mysecurecloudhost.com: authenticated_id: dan@reactivated.net
X-Authenticated-Sender: s1041.use1.mysecurecloudhost.com: dan@reactivated.net
X-Spampanel-Domain: s1041.use1.mysecurecloudhost.com
X-Spampanel-Username: 192.250.231.249
Authentication-Results: antispamcloud.com; auth=pass smtp.auth=192.250.231.249@s1041.use1.mysecurecloudhost.com
X-Spampanel-Outgoing-Class: ham
X-Spampanel-Outgoing-Evidence: SB/global_tokens (0.00825616671873)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuVffZzyKMhQU0ACUwGAB5Z6/maTn/LEP0vD
 mTmuk24ExCu2SmbhJN1U9FKs8X3+Nt06bFpPrNOlRAlE9AVLwR4uGVjKNnzF3nQoDoQtBifM84JL
 M0i5ZAms0EHrvcCaVINPDEsL21EZksVf1uOFaoUYGnT3EFAinyrilm9zau/FuzkQt9Nb4Ml7QXdk
 EetczWAIN4GsiK0O3K+JEByc7IobeB7itP8hgjDRserKv4bhb/pXHHNX+LCF5x5jewa7FkNWBb39
 uS1TjWG2Inx+Ts2QrtVmombMJ4e2pn5C0yBMHZ0fE47nEjvubMSTLAkKCKefuLbx+lGq0svfyhth
 j0R6Iny++hg9dJLqN5zmWqF/oHgMZXS6X/fIHYslsKU0yPHM4JpSMI47HiFQBsGlm5AyO3cajqKP
 N2TQucmsPqkADN9YaMSDrgb8f3EnZj8JSSVcMQtcPaBj0oM3kYoQzFFh/1fSrLRlrfqhJUG8z4R9
 /uECIyfb59UKcPyKB7/seAhbEXLAIlQO41grCDpV7x4SG0sbLPkEPwaTR9JCgIIwUaKDJQlUrg+c
 sO2wlDq1j4FhXBjpwUH3T5DwogMcW3n9eq+zqef+wJHXDp70tdmxlpLzlnjbD/7Y4GiVM0Vs+iZc
 VYJfyg12CBbscT1cNN1Jsfa3HCw6gGU1+SdwTBKf9HkMLWk/C0vLNlLzxrmqyasitZFgJIlVn1LH
 h1zXo+HQWBsS3EZt9a+xyS/dOq7TUqYyGJZd46kBXaReSYigCAhlVRgJDS0AzAOltsq3PRbZ63Kg
 QzPNdZuTKxU6aj16VjYz3CPunnl+LI7l5fzInLuGrwLN0VeqvzLlcRxwGgEvNMtirEVgSD8PZy6W
 zRj7WHIZl76lsW55eQV2n2lY9hpC2YtTBQO/Nu6TVwO6CV7e9KZY7AUftyem5JXm2HSubn2WKeN5
 PBvIRkiU4E8H4e7X9sw5VBsaDF9CxNBjABkH3hTMjGc3lQAtuckU+MNQlLpWhjjykqbde3UjWoF9
 cBo9q3T2iWmfFRW/Psbz8QFVy0V5rN3M2TZ9grsaBV7hOgCSkfEzb1aIdlnbLZp4DCYOuNFQ+5eG
 III/qgXB3gv2NI/ukWuQBNrXV+EmIqM8SxKOhcObZXWnkEw+6F9CGyYC9AhR1ZLKC40YaZQ+trtn
 c3HOUHNRces2OQfEVEXjAoud+gYHJw+dy/si0pxrjF6izxFc684o/A69h/CvHI/GeXW8oEyu47TQ
 DqTi6GKwcIp24VOsP5eu885wo+t+ynT3Y80OmAux3oN13+ztUzneZGHdcUfaxYq0ZH+Cc9iqnocR
 WxNUEo38DE53aa5lZFsy2onypIM6qetbKE/25wcBuDp1Y8rQ6lypv7mCnLyLSvvyr/35XrlgUw0d
 o1iX+nVr3Z1SFe+4OrB9Rro7EpOy1Um2iVRPSUxhtw3wz3yqYcOpyKA69LF1Ge2GaGfxmfp09oMS
 l8c4ShQ//ve+MHzjs9MOb3HXByN6cty/LT6lgOv2AzRyYGlsi3xQeIJ6TM5o5F89lTjPCn99uwfA
 g5wm8t3Xj/LzZ5s/OJg1L2asZ/4te3BTDYEBZZ1yPQnIH5IVn/pKnch3lmmwSrgldH+Ps9MOb3HX
 ByN6cty/LT6lgO+c9AHZZ12442bv/l3jZJg=
X-Report-Abuse-To: spam@quarantine16.antispamcloud.com
X-Complaints-To: abuse@master.antispamcloud.com

Hi,

This series adds a driver for the Broadcom BCM2712 IOMMU found on
Raspberry Pi 5, and hooks up the display controller IOMMU for efficient
management of graphics memory. This is adapted from the downstream driver
from Raspberry Pi (original author Nick Hollinghurst), with main changes:
 - Implement the page table management using generic_pt
 - Implement brcm,iommu-cache as standards-compliant DT property, while
   maintaining compatibility with existing shipped RPi firmware
 - Drop the dma-iova-offset hack, used to work around some issue seen with
   dma-ranges. This will need to be investigated separately and solved
   properly. (It's not needed for display controller iommu support included
   here.)
 - Misc simplifications/standardisations/cleanups
 
The IOMMU works strictly with 4KB pages. This means that unfortunately
when the kernel is compiled with PAGE_SIZE=16KB (the Raspberry Pi 5
kernel default), 12KB is wasted in each page that is allocated for page
tables. I plan to address this in followup work.

It has been tested on Raspberry Pi 5 using a 3D-accelerated graphical
environment which causes plenty of IOMMU maps & unmaps.

Feedback and testing welcome!

Changes in v2:
- Use iommu_fwspec in xlate & probe_device
- Add blocked_domain support
- Simplify page size configuration between iommu driver and format
- Introduce PT_FEAT_NO_SW_BIT flag to allow formats to explicitly opt-in to
  a defensive flushing algorithm when no sw bit is available
- Implement 4MB pages at Level 1; this is more efficient and means the
  "allow full-table contiguous leaves in unit tests" commit has been
  dropped because it is no longer needed.
- Hardcode the aperture in an unused part of the address space, removing
  it from DT (it's a software-specific decision, not an attribute of the
  hardware), adding more explanatory comments
- Use pt_full_va_prefix to have the PT format operate within the aperture
  space, enabling use of IOMMU_PT_DOMAIN_OPS
- Add more dt-bindings explanation to brcm,iommu-cache and drop docs
  around the cache property used in RPi firmware (the driver still supports
  this however, for fw compat reasons)
- Correct iommu device address in bcm2712.dtsi
- Link to v1: https://lore.kernel.org/r/20260712-bcm2712-iommu-submit-v1-0-80e10cdde2ea@reactivated.net

---
Daniel Drake (5):
      generic_pt: allow missing sw bit in DMA_INCOHERENT case
      dt-bindings: iommu: Add Broadcom BCM2712 IOMMU
      iommu/generic_pt: Add Broadcom BCM2712 page table format
      iommu: Add Broadcom BCM2712 IOMMU driver
      arm64: dts: broadcom: bcm2712: Add GPU IOMMU and IOMMU cache nodes

 .../bindings/iommu/brcm,bcm2712-iommu.yaml         |  48 ++
 .../bindings/iommu/brcm,bcm2712-iommuc.yaml        |  35 ++
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi          |  14 +
 drivers/iommu/Kconfig                              |  15 +
 drivers/iommu/Makefile                             |   1 +
 drivers/iommu/bcm2712-iommu-cache.c                |  73 +++
 drivers/iommu/bcm2712-iommu.c                      | 582 +++++++++++++++++++++
 drivers/iommu/bcm2712-iommu.h                      |  26 +
 drivers/iommu/generic_pt/.kunitconfig              |   1 +
 drivers/iommu/generic_pt/Kconfig                   |  10 +
 drivers/iommu/generic_pt/fmt/Makefile              |   2 +
 drivers/iommu/generic_pt/fmt/bcm2712.h             | 283 ++++++++++
 drivers/iommu/generic_pt/fmt/defs_bcm2712.h        |  18 +
 drivers/iommu/generic_pt/fmt/iommu_bcm2712.c       |   8 +
 drivers/iommu/generic_pt/iommu_pt.h                |  13 +-
 drivers/iommu/generic_pt/pt_fmt_defaults.h         |   7 +
 include/linux/generic_pt/common.h                  |  13 +
 include/linux/generic_pt/iommu.h                   |  12 +
 18 files changed, 1156 insertions(+), 5 deletions(-)
---
base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff
change-id: 20260712-bcm2712-iommu-submit-2e09899e65c4

Best regards,
-- 
Daniel Drake <dan@reactivated.net>

