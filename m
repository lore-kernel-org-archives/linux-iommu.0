Received: from out16-54.antispamcloud.com (out16-54.antispamcloud.com [185.201.18.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77E632ABCA;
	Thu, 24 Sep 2026 22:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.201.18.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790287940; cv=none; b=bf1HVwrzFk2OK4mcxeqI8E2Eu+7EQlDDqkngFr4gw2hsVnprlA+31Lh5ENz/YWM8NozkvvsPF8mrHnaghjALH36LLlanxeWDdY1oO04vY1lQAwvWPgKsO42od3iuIuW0MDaTrFg2BIAo8r9XvPPvSgNJ2x4WGfvIsX3X9r5M/rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790287940; c=relaxed/simple;
	bh=uS05+MHjYJ2dvJ92tScboPZtJ3JbH7p0QflJG5+WTNA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hyNGuQlRS3qssV3q9muC+vcBcUOneP08dV3ezaTZXQGaGy9q+sJZ6Pcwc5O7I07aJ9Tpb/+0lqbfLk2ArtQmo2PqjvOi53Zx+rOnz3c4uKxJpdoSMW7sq8SzhQpaxfMWyXrtQpZxo7HctjL7PGXWF6LgA+xHJ0GV+EEEOSoSv4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=reactivated.net; spf=pass smtp.mailfrom=reactivated.net; dkim=pass (2048-bit key) header.d=reactivated.net header.i=@reactivated.net header.b=GAQyuGkw; arc=none smtp.client-ip=185.201.18.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=reactivated.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=reactivated.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=reactivated.net header.i=@reactivated.net header.b="GAQyuGkw"
Received: from s1041.use1.mysecurecloudhost.com ([192.250.231.249])
	by mx320.antispamcloud.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <dan@reactivated.net>)
	id 1x9qjH-004qNk-St; Thu, 24 Sep 2026 23:11:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=reactivated.net; s=default; h=Cc:To:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=InmxYi3z61zJBOZQZxhmvjPj7iLZgfevixwnQem0Olg=; b=GAQyuGkwur69cYKPKllCTDR7R2
	h0Ai21Zxne9deRhJQzXK4bdgDlNYbZD8iKkGxDN+ZX07AO4mD9usAQlJGviRzwAytcXnNIIKK+j+R
	ZxWSF1Jb1ixOE/vbxeXNljfnGXI3V5gxuyzRuJHSIDt3WjAQcABn8oMANxcWewv1Ljueihk8UIpjW
	sgzMEwOolo7XK2LU6m5T7Z7NIzJ5g4t3JhpMFXuxYa9oFbNsklePK29hlJj+cDr2YE8NnbpIWuO6K
	btMjQjU/bg4dWm/+RO12d68oD7UrReSMs+7FwXrSPoYNZrgLoGOdQ6ZUrR64Sib1vXyqej2GjoLdP
	y8mRSpAg==;
Received: from [188.251.249.2] (port=56840 helo=[192.168.1.123])
	by s1041.use1.mysecurecloudhost.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <dan@reactivated.net>)
	id 1x9qjA-00000006M7u-0S1V;
	Thu, 24 Sep 2026 21:11:36 +0000
From: Daniel Drake <dan@reactivated.net>
Subject: [PATCH v6 0/6] Add support for Broadcom BCM2712 IOMMU driver
 (Raspberry Pi 5)
Date: Thu, 24 Sep 2026 22:10:50 +0100
Message-Id: <20260924-bcm2712-iommu-submit-v6-0-7b3cace86973@reactivated.net>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XPzW7DIAwH8FepOI8NHAiw095j2oEPt/UhSQU02
 lTl3Ud6aaUl2sn6S/bP9o0VzISFvR9uLONMhaaxhf7lwOLZjyfklFpmIKAXRgIPcYC10jQMV16
 uYaDKAYWzzmGvo2Jt9JLxSN939vOr5eAL8pD9GM8rNmU60fg2+FIxr/1nKnXKP/crZrlO/bNwl
 lxwK1CKmBIC+o+MPlaafcX0OmJl69oZnigwOxQ0SoAyQUfRJbTbVPegLOgdqmuUOUrVoQHrQr9
 NqQflxN6DqlEuhdBro42NcpvSz5TboXSjQHcuagigHP6llmX5Bdmo0H4KAgAA
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
 james.quinlan@broadcom.com, Jason Gunthorpe <jgg@ziepe.ca>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Get-Message-Sender-Via: s1041.use1.mysecurecloudhost.com: authenticated_id: dan@reactivated.net
X-Authenticated-Sender: s1041.use1.mysecurecloudhost.com: dan@reactivated.net
X-Spampanel-Domain: s1041.use1.mysecurecloudhost.com
X-Spampanel-Username: 192.250.231.249
Authentication-Results: antispamcloud.com; auth=pass smtp.auth=192.250.231.249@s1041.use1.mysecurecloudhost.com
X-Spampanel-Outgoing-Class: ham
X-Spampanel-Outgoing-Evidence: SB/global_tokens (0.00184167599222)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuX1YZ/uw5VjTL72lNMxZStKXezw410P2toA
 4PNfS9Tnliu2SmbhJN1U9FKs8X3+Nt06bFpPrNOlRAlE9AVLwR4uGVjKNnzF3nQoDoQtBifM84JL
 M0i5ZAms0EHrvcCaVIOq5IDjkbuwl5HKPIlAveD6GnT3EFAinyrilm9zau/FuzkQt9Nb4Ml7QXdk
 EetczWCfZW7a9uhvfuE0J/hsBuu+eB7itP8hgjDRserKv4bhb4rodgkl+wsfxZHakHKRaVZWBb39
 uS1TjWG2Inx+Ts2QrtVmombMJ4e2pn5C0yBMHZ0fE47nEjvubMSTLAkKCKefuLbx+lGq0svfyhth
 j0R6Iny++hg9dJLqN5zmWqF/oHgMZXS6X/fIHYslsKU0yPHM4JpSMI47HiFQBsGlm5AyJ9N3+CB9
 4aFbAhtG8w3Ly5ZVKmISsN3IhGLWYd0758WcWZORtrVlxIXk5jhWVNuX2TLvWiqA6BF3jwTykadj
 Eh4GKZ8tHsR5A+L9kzDG/K7jeiyzqcpyb6SLIRHv2KIjmIf7YZpqL+v4bQH3sWKlGBPtnYg5YizU
 E/EMRWxUHUQ0hYI+2t4HN3I9ouCIE9ZpmIIT4UMJhQzp+ktYysEoXYjyOpKyQ+6FJGgfvyfesL1T
 Yi2bf0F0JzgUQ/o6tR7CeAtyzyXh0NL4l5vWK73eqiIKw1M+yw2yzZUSfFbaoySugmxqcr8pFbGy
 g9Z1tlDRifW6JNJBY9PymNpC4Wmh+9PD5zE6IfxMIfQh9R3Td3D6I4o5YsP+Lyz6c5yHWp+l1v7R
 8SyvHcEEE42QqO0qgomZEoLxZHOnsblvnV8eXYCZSCMD9D3oJHukiNphohQtuwCmDexg5czsngAO
 BFsShf+76sU8wGmOnLcaeINlh4Cn9ZhZdiagiCOBKUpU6SDcsn+BJp3CoLutPze6u4tYy64Dp2el
 LsD1cFZ5ljV0yCnPlZYJyqLj9DGvv0JxFidP9ylmMcA5Ut2aTq/fdywqeMzbg4Paoa3pNVQ0zl7t
 /+UiLekARSAxYlF7slSgzk1enTnq+eIBXmCMn/1SNcFIP2MttYo7yCqT8k88gwNJ/ZBdCKDGFJnk
 5eJFcFklVb9231/E3ahF5MMcDI7KdpjQKdEz/+/QkUVhwSqO+QS+xjCZ3JKVmi72ocgY5kMQSjs7
 CnU3Vkswnvz2sY575f5VZdC7A9EkfupFeybqiokSL/UoBa9Z74L1QD5u7fk/CB2ffOy/knOaqu9M
 jU02vQscbAwfX28GBy2wRROaWZyvU3/WDyb1UPpOcShziaQlXemU7/r7owFlFlcv7R07m0OVDRY+
 C3NKVBiu9E09fH2QcWWDSTfRyaGsL+KZNwpYGCN6yCqJqJMY7uMzxq3+Ecx6Ww+vAj0HbLbveTIz
 fDDueIdjUxTaa0dmGx2m78JeU6J5dQk8TiQJh7U9utxWE7LPn7sg/7SHllHTMyZl234M8B33894V
 7E8GzYr3X8rHgASdPAlbDjazCbhs7qBpykynMlI8ehauFjA7dVMOTKcW5c6UnY64mAykh3LBvXwi
 LIjlrjIuKSKddsFYTaIZy4Zvun7pGU7uz9Qh2BYl/pOFic8JjqapLpwrwdUQz9MPWEmV3jR5NeVa
 JQBh0uawl0Cg8hPs+cRD5TJxNzOPadp3mtqXN3cCIyIm263/n4zqghav48Y+3YiJRbPwEKhVXmMF
 SH7pGU7uz9Qh2BYl/pOFic/qXKRF3uOx1VRdI9vLlOBy9jihx+Za/cV70jOJzN2r4A==
X-Report-Abuse-To: spam@quarantine16.antispamcloud.com
X-Complaints-To: abuse@master.antispamcloud.com

Hi,

This series adds a driver for the Broadcom BCM2712 IOMMU found on
Raspberry Pi 5, and hooks up the display controller IOMMU for efficient
management of graphics memory. This is adapted from the downstream driver
from Raspberry Pi (original author Nick Hollinghurst), with main changes:
 - In page mapping mode, operate the translation aperture from address 0,
   with no bypass window. More like a IOMMU and less like a GART.
 - Implement the page table management using generic_pt
 - Support 4MB hugepage mapping in top level page table
 - Implement brcm,iommu-cache as standards-compliant DT property
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

Thanks for the review comments and discussion. Further feedback and
testing welcome!

Changes in v6:
- Add MAINTAINERS entry
- Drop unnecessary vc4 iommus property (it only needs to sit on the
  underlying hvs device)
- Add dt-bindings doc for hvs iommus property
- Link to v5: https://lore.kernel.org/r/20260909-bcm2712-iommu-submit-v5-0-2539c52b249e@reactivated.net

Changes in v5:
- Drop blocked_domain support as hardware always translates a minimum
  256MB aperture when enabled
- Restrict Kconfig dependency to ARCH_BCM2835, matching other RPi drivers
- Improved error handling in device attach
- Add missing iommu_put_pages_list() in iotlb sync
- Minor readability improvements
- Link to v4: https://lore.kernel.org/r/20260902-bcm2712-iommu-submit-v4-0-9dbb657578c1@reactivated.net

Changes in v4:
- Add Jim Quinlan and Florian Fainelli as bindings maintainers
- Replace MMU register access macros with static inline functions
- Clear illegal address register and flush caches on blocking domain attach
- Add __must_hold annotations in TLB helpers
- Use BIT() macro for MMUC_CONTROL definitions
- Link to v3: https://lore.kernel.org/r/20260825-bcm2712-iommu-submit-v3-0-7f143e7289b6@reactivated.net

Changes in v3:
- Switch from a aperture and bypass window GART-like approach
  to IOMMU-like 0-based translation
- Add 3 SW bits which seem unused (per the chipset docs); drop patch
  for NO_SW_BIT handling. This reduces the claimed address space, so I had
  to tweak a iommu_pt test accordingly.
- Disallow domain sharing across multiple hardware IOMMU instances
- Clear and flush local MMU TLB during domain attach
- Handle unattached domains safely during TLB sync
- Set cache platform driver data late during probe to prevent race condition
- Improved handling of cache flush timeouts
- Use format string for device name in iommu_device_sysfs_add()
- Use cleanup.h helpers for scope management
- Expand DT binding descriptions for IOMMU and IOMMUC
- Add iommus property to HVS display node in DT
- Drop iommuc back-compat with current RPi DT
- Link to v2: https://lore.kernel.org/r/20260727-bcm2712-iommu-submit-v2-0-0247b5c03de8@reactivated.net

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
Daniel Drake (6):
      iommu_pt: Fix test_pgsize_boundary() failure on narrow-OA formats
      dt-bindings: iommu: Add Broadcom BCM2712 IOMMU
      dt-bindings: display: brcm,bcm2835-hvs: Document iommus property
      iommu/generic_pt: Add Broadcom BCM2712 page table format
      iommu: Add Broadcom BCM2712 IOMMU driver
      arm64: dts: broadcom: bcm2712: Add GPU IOMMU and IOMMU cache nodes

 .../bindings/display/brcm,bcm2835-hvs.yaml         |   3 +
 .../bindings/iommu/brcm,bcm2712-iommu.yaml         |  54 ++
 .../bindings/iommu/brcm,bcm2712-iommuc.yaml        |  40 ++
 MAINTAINERS                                        |  12 +
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi          |  14 +
 drivers/iommu/Kconfig                              |  15 +
 drivers/iommu/Makefile                             |   1 +
 drivers/iommu/bcm2712-iommu-cache.c                |  84 ++++
 drivers/iommu/bcm2712-iommu-cache.h                |   9 +
 drivers/iommu/bcm2712-iommu.c                      | 550 +++++++++++++++++++++
 drivers/iommu/generic_pt/.kunitconfig              |   1 +
 drivers/iommu/generic_pt/Kconfig                   |  10 +
 drivers/iommu/generic_pt/fmt/Makefile              |   2 +
 drivers/iommu/generic_pt/fmt/bcm2712.h             | 288 +++++++++++
 drivers/iommu/generic_pt/fmt/defs_bcm2712.h        |  18 +
 drivers/iommu/generic_pt/fmt/iommu_bcm2712.c       |   6 +
 drivers/iommu/generic_pt/kunit_iommu_pt.h          |   2 +-
 include/linux/generic_pt/common.h                  |   6 +
 include/linux/generic_pt/iommu.h                   |  12 +
 19 files changed, 1126 insertions(+), 1 deletion(-)
---
base-commit: 28924df2a08f440c73991b83028032c901de2ae4
change-id: 20260712-bcm2712-iommu-submit-2e09899e65c4

Best regards,
-- 
Daniel Drake <dan@reactivated.net>

