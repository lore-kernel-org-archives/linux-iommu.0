From: Tobias Jakobi <liquid.acid@gmx.net>
Subject: Re: [PATCH v4 00/18] Exynos SYSMMU (IOMMU) integration with
 DT and DMA-mapping subsystem
Date: Thu, 22 Jan 2015 00:37:28 +0100
Message-ID: <54C03838.4080008@gmx.net>
References: <1421399592-7482-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1421399592-7482-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linaro-mm-sig@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, Joerg Roedel <joro@8bytes.org>, Thierry Reding <treding@nvidia.com>, Olof Johansson <olof@lixom.net>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, David Wodhouse <dwmw2@infradead.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Hello,

just some warnings I encountered when compiling this today:
drivers/iommu/exynos-iommu.c: In function =E2=80=98exynos_iommu_of_setu=
p=E2=80=99:
drivers/iommu/exynos-iommu.c:1177:2: warning: passing argument 2 of
=E2=80=98of_iommu_set_ops=E2=80=99 discards =E2=80=98const=E2=80=99 qua=
lifier from pointer target type
[enabled by default]
  of_iommu_set_ops(np, &exynos_iommu_ops);
  ^
In file included from drivers/iommu/exynos-iommu.c:23:0:
include/linux/of_iommu.h:34:6: note: expected =E2=80=98struct iommu_ops=
 *=E2=80=99 but
argument is of type =E2=80=98const struct iommu_ops *=E2=80=99
 void of_iommu_set_ops(struct device_node *np, struct iommu_ops *ops);
      ^


I guess the 'const' should be dropped from exynos_iommu_ops, even thoug=
h
I wonder why of_iommu_set_ops wants a non-const pointer (can/does it
modify the struct later on?).

With best wishes,
Tobias
