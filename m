Received: from out16-31.antispamcloud.com (out16-31.antispamcloud.com [185.201.18.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F6B381EAE;
	Sun, 12 Jul 2026 22:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.201.18.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783895567; cv=none; b=Ixli2gqfQw9e23ce6YBcuWfcwKaevKRQS2sGgLEOc8YfR1Y8fFsVP8urJ6sbl/4oUX4e1EWimbCG16/SEf2fM24GLYc+VdyzdnjKldzD/rHG5iaagm+9FAVV1B/Odk1jYVICLWJqBTnOyOpTAnA65HUzOi3a0datX4dWzHfRKTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783895567; c=relaxed/simple;
	bh=b6yve9aEc+Q+0pzabuJh6fdGiA5iEnw+8+BiskybXN0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ag+ahsqtyt0ufWLwCNTU2z+JKJ0upATJSblpDhTthGzUInsHHQwWIl3J+THCjbHyXe4wPn7dhJDmzp/fWI918SSU2Lk3TZ+ZYd770EEjwZAyasTDU0Bd3aas/qU+QpwgCkc0eXiuVX+x3u/vJVf+9XtoUF+mrPGNTkESxbWyJZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reactivated.net; spf=pass smtp.mailfrom=reactivated.net; dkim=pass (2048-bit key) header.d=reactivated.net header.i=@reactivated.net header.b=jpq2/aFN; arc=none smtp.client-ip=185.201.18.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reactivated.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=reactivated.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=reactivated.net header.i=@reactivated.net header.b="jpq2/aFN"
Received: from s1041.use1.mysecurecloudhost.com ([192.250.231.249])
	by mx195.antispamcloud.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <dan@reactivated.net>)
	id 1wj1Zq-00GoJg-CM; Sun, 12 Jul 2026 23:19:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=reactivated.net; s=default; h=Cc:To:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=c2LZCTFPqGTGuPKDo/ZNl32LqOczqdxWlzYpEghp2XU=; b=jpq2/aFNzL3ShD0RFS09By1MZc
	1nDhKHtJuUeW71oU6Z6/qx0/1SAZB4SMe3i0rmvDfkPsjzS1tRWmSlbUdI2RKeLlvrZBaDW+GLqQl
	RUFlnhNZq4QjRzc6y51Y3kNrlY7xj38d45X+7oZfOCvlC5X14X3NXotWQ8wrYV09nk82PCtNZaHQI
	WuHl15W5I0U/j5Cd8S/MAinsCxDO20qr+ao1ZDQnlioDZk9rTVgDHvthme8LBDRwXHHTjSKPKGZCl
	eu1BKlbtPyUBAgbaxiFIjw8mX5SF9+Fb7nV8kPUJFgeDvcwgd6UnSZAeXSoSVl12twajXVbi8fGdd
	+3whIefg==;
Received: from [188.251.249.2] (port=43526 helo=[192.168.1.123])
	by s1041.use1.mysecurecloudhost.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <dan@reactivated.net>)
	id 1wj1Zi-0000000D6jk-0luD;
	Sun, 12 Jul 2026 21:18:58 +0000
From: Daniel Drake <dan@reactivated.net>
Subject: [PATCH 0/6] Add support for Broadcom BCM2712 IOMMU driver
 (Raspberry Pi 5)
Date: Sun, 12 Jul 2026 22:18:50 +0100
Message-Id: <20260712-bcm2712-iommu-submit-v1-0-80e10cdde2ea@reactivated.net>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WMMQ6DMAwAv4I811JiUdr0KxVDkpriIaGKoaqE+
 DuhG9PphrsVlIuwwqNZofBXVKZcxV4aiKPPb0Z5VQcy1JmbJQwx0UGZUlpQl5BkRmLj7s5xd40
 t1PRTeJDff/vsqwevjKH4HMdjdmotbNsO2FD0rocAAAA=
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
X-Spampanel-Outgoing-Evidence: SB/global_tokens (0.0036886121706)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuVv5cfN8YhlyjwLMsQQzllMEv6lei9F9Dil
 zrPpcCYURSu2SmbhJN1U9FKs8X3+Nt06bFpPrNOlRAlE9AVLwR4uGVjKNnzF3nQoDoQtBifM84JL
 M0i5ZAms0EHrvcCaVINZthhKjTv0yp3Sc+AC3FHpGnT3EFAinyrilm9zau/FuzkQt9Nb4Ml7QXdk
 EetczWCulNo0fvnzmZPW3MC2/ZtQeB7itP8hgjDRserKv4bhb3RyZlCL9i3kc+ehInPHgYZWBb39
 uS1TjWG2Inx+Ts2QrtVmombMJ4e2pn5C0yBMHZ0fE47nEjvubMSTLAkKCKefuLbx+lGq0svfyhth
 j0R6Iny++hg9dJLqN5zmWqF/oHgMZXS6X/fIHYslsKU0yPHM4JpSMI47HiFQBsGlm5AyPIv7c2tg
 uiTnO7hoWdxS2Euf+eM3l5KPnbp/eQthjVPLCh11+xKgET3fXj754wkhoRweeXUyelEFumxqJC98
 W2Chcvueb7X9IVOP0nXi5ScUGZbDvQNAWVsKTgEVkGFZkrTBb08hz2+hQWIE/jMJBRjlXAPIIi6r
 dxgy5Mnu2cDsZps7XJtkUNhIi117bsGJ7ren9RtRNyYim5e3GD8LGd17Yt5uvWRLqYZ7YcWBwuaj
 bB9FLgbTIobDkucCu6K1Qts6ESwZ+TRkjY5CmPXd4fzFwV5PA+Zo1HkEWshOrnfOczv/Rq1TfV/y
 9sPCUZ0yjBqTnQMt5W0GKvZ5TPS+0sUsSnvAz6a57TzpYAKZxAOMmYkwXP3g8rtJn6lRuSHjV8Jw
 2Fxq1Vd7xIu/TP3zxxtadaYgn3OIzsUC2wDRiPKWwieZyauFYqHkIbFa+ipFHuOywN1cBSoAw5Iq
 u8uD6H9vRamlPbOxG7rXq5Czwgf6xGEuqjPYHqCiHsRpKiyawVZCoGB4EfDx2fRuW8Y0o7OCze69
 5wqpq4Ow1lDfcfvX9sw5VBsaDF9CxNBjABkH3hTMjGc3lQAtuckU+MNQlLpWhjjykqbde3UjWoF9
 cBo9q3T2iWmfFRW/Psbz8QFVy0V5rN3M2TZ9grsaBV7hOgCSkfEzb1aIdlnbLZp4DCYOuNFQ+5eG
 III/qgXB3gv2NI/ukWuQBNrXV+EmIqM8SxKOhcObZXWnkEw+6F9CGyYC9AhR1ZLKC40YaZQ+trtn
 Eh9wUysc4uCrhmcWLql8THOdSiHAgggGfXRKw3BTrmSizxFc684o/A69h/CvHI/GeXW8oEyu47TQ
 DqTi6GKwcIp24VOsP5eu885wo+t+ynT3Y80OmAux3oN13+ztUzneZGHdcUfaxYq0ZH+Cc9iqnocR
 WxNUEo38DE53aa5lZFsy2onypIM6qetbKE/25wcByQHccqPF2ZbyJan8j4Gywd51C0ZuDFMORrKj
 fElM485r3Z1SFe+4OrB9Rro7EpOy1Um2iVRPSUxhtw3wz3yqYcOpyKA69LF1Ge2GaGfxmfp09oMS
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
 - Implement brcm,iova-window and brcm,iommu-cache as standards-compliant
   DT property names, while maintaining compatibility with existing
   shipped RPi firmware
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

---
Daniel Drake (6):
      generic_pt: allow missing sw bit in DMA_INCOHERENT case
      iommupt: allow full-table contiguous leaves in unit tests
      dt-bindings: iommu: Add Broadcom BCM2712 IOMMU
      iommu/generic_pt: Add Broadcom BCM2712 page table format
      iommu: Add Broadcom BCM2712 IOMMU driver
      arm64: dts: broadcom: bcm2712: Add GPU IOMMU and IOMMU cache nodes

 .../bindings/iommu/brcm,bcm2712-iommu.yaml         |  65 +++
 .../bindings/iommu/brcm,bcm2712-iommuc.yaml        |  35 ++
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi          |  15 +
 drivers/iommu/Kconfig                              |  15 +
 drivers/iommu/Makefile                             |   1 +
 drivers/iommu/bcm2712-iommu-cache.c                |  73 +++
 drivers/iommu/bcm2712-iommu-cache.h                |   9 +
 drivers/iommu/bcm2712-iommu.c                      | 587 +++++++++++++++++++++
 drivers/iommu/generic_pt/.kunitconfig              |   1 +
 drivers/iommu/generic_pt/Kconfig                   |  10 +
 drivers/iommu/generic_pt/fmt/Makefile              |   2 +
 drivers/iommu/generic_pt/fmt/bcm2712.h             | 259 +++++++++
 drivers/iommu/generic_pt/fmt/defs_bcm2712.h        |  18 +
 drivers/iommu/generic_pt/fmt/iommu_bcm2712.c       |  10 +
 drivers/iommu/generic_pt/kunit_generic_pt.h        |  39 +-
 drivers/iommu/generic_pt/pt_fmt_defaults.h         |  13 +
 include/linux/generic_pt/common.h                  |   7 +
 include/linux/generic_pt/iommu.h                   |  13 +
 18 files changed, 1147 insertions(+), 25 deletions(-)
---
base-commit: f4fb100039e96211609dfc44fb24b9e4a8a0f2f9
change-id: 20260712-bcm2712-iommu-submit-2e09899e65c4

Best regards,
-- 
Daniel Drake <dan@reactivated.net>

