From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH v6 00/25] Exynos SYSMMU (IOMMU) integration with DT and
 DMA-mapping subsystem
Date: Mon, 11 May 2015 18:00:54 +0200
Message-ID: <CABxcv=mpCQKyuJOFsUgMdhD50yYdH+WwnEbYUNXByErMHpUuYA@mail.gmail.com>
References: <1430727380-10912-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1430727380-10912-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linaro-mm-sig@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, Joerg Roedel <joro@8bytes.org>, Thierry Reding <treding@nvidia.com>, Olof Johansson <olof@lixom.net>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, David Wodhouse <dwmw2@infradead.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Hello Marek,

On Mon, May 4, 2015 at 10:15 AM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> Hello Everyone,
>
> This is yet another attempt to get Exynos SYSMMU driver with integrated
> with IOMMU & DMA-mapping subsystems. The main change from previous
> version is addition of the patches to define iommu-mapping, which need
> to be created during system boot to avoid IOMMU fault by devices, which
> has been left enabled by bootloader (i.e. framebuffer displaying slash
> screen).
>
> Patches has been also rebased onto v4.1-rc2 with 'arm: dma-mapping: fix
> off-by-one check in arm_setup_iommu_dma_ops' patch applied (see commit
> 1424532b2163bf1580f4b1091a5801e12310fac5 on fixes branch in
> git://ftp.arm.linux.org.uk/pub/linux/arm/kernel/git-cur/linux-arm.git,
> more information:
> http://www.spinics.net/lists/arm-kernel/msg414722.html).
>
> All patches are also available in the following git repository:
> https://git.linaro.org/people/marek.szyprowski/linux-srpol.git
> branch v4.1-exynos-iommu.
>

Thanks for the new series, this time I didn't get a system hang when I
enabled both CONFIG_DRM_EXYNOS_FIMD and CONFIG_DRM_EXYNOS_DP on my
Exynos5420 Peach Pit Chromebook.

The system finished booting and I have both a console on the HDMI and
eDP/LVDS displays. But if I try to start X or weston, I again have a
completele system hang with no output on the serial console. This
works correctly without your IOMMU series.

And again disabling CONFIG_DRM_EXYNOS_DP or CONFIG_DRM_EXYNOS_FIMD
avoids the system to hang. If I only have CONFIG_DRM_EXYNOS_HDMI
enabled, then I can start X with out issues and is displayed correctly
in the HDMI output.

So it seems your workaround for the boot-loader leaving the FIMD dma
engine enabled is not enough? I'm not a graphics person so I can think
of the top of my head what could trigger the system hang when X or
weston are executed so I wondered if you have any ideas.

> Best regards
> Marek Szyprowski
> Samsung R&D Institute Poland
>

Best regards,
Javier
