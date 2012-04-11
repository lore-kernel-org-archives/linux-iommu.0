From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 0/2] Exynos: fix SYSMMU driver to work with power domains
Date: Wed, 11 Apr 2012 16:34:29 +0200
Message-ID: <1334154871-4756-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, KyongHo Cho <pullip.cho@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Hi!

These two patches fixes operation of the SYSMMU driver (v12 version [1])
with the new power domain driver based on generic power domains and
runtime pw, which has been merged to Linux kernel v3.4-rc1.

[1] https://lkml.org/lkml/2012/3/15/51

Best regards
Marek Szyprowski
Samsung Poland R&D Center


Patch summary:

Marek Szyprowski (2):
  iommu/exynos: fix runtime pm support
  ARM: Exynos4: update SYSMMU setup code for gen_pd power domain driver

 arch/arm/mach-exynos/dev-sysmmu.c |    6 +++++-
 arch/arm/mach-exynos/pm_domains.c |   13 +++++++++++++
 drivers/iommu/exynos-iommu.c      |   20 ++++++++++++++++++--
 3 files changed, 36 insertions(+), 3 deletions(-)

-- 
1.7.1.569.g6f426
