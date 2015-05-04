From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 01/25] arm: dma-mapping: add support for creating
 reserved mappings in iova space
Date: Mon, 4 May 2015 17:12:00 -0500
Message-ID: <CAL_JsqKB4F8tspydBFrL-PH3gXcyu-pwQwBETMizJzTpAF3yzg@mail.gmail.com>
References: <1430727380-10912-1-git-send-email-m.szyprowski@samsung.com> <1430727380-10912-2-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1430727380-10912-2-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Linux IOMMU <iommu@lists.linux-foundation.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linaro-mm-sig@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, Joerg Roedel <joro@8bytes.org>, Thierry Reding <treding@nvidia.com>, Olof Johansson <olof@lixom.net>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Will Deacon <will.deacon@arm.com>, David Wodhouse <dwmw2@infradead.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, Javier Martinez Canillas <javier@dowhile0.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, May 4, 2015 at 3:15 AM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> Some devices (like frame buffers) are enabled by bootloader and configured
> to perform DMA operations automatically (like displaying boot logo or splash
> screen). Such devices operate and perform DMA operation usually until the
> proper driver for them is loaded and probed. However before that happens,
> system usually loads IOMMU drivers and configures dma parameters for each
> device. When such initial configuration is created and enabled, it usually
> contains empty translation rules betweem IO address space and physical
> memory, because no buffers nor memory regions have been requested by the
> respective driver.
>
> This patch adds support for "iommu-reserved-mapping", which can be used
> to provide definitions for mappings that need to be created on system
> boot to let such devices (enabled by bootloader) to operate properly
> until respective driver is probed.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  Documentation/devicetree/bindings/iommu/iommu.txt |  44 +++++++++
>  arch/arm/mm/dma-mapping.c                         | 112 ++++++++++++++++++++++
>  2 files changed, 156 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/iommu/iommu.txt b/Documentation/devicetree/bindings/iommu/iommu.txt
> index 5a8b4624defc..fd54e6b597f0 100644
> --- a/Documentation/devicetree/bindings/iommu/iommu.txt
> +++ b/Documentation/devicetree/bindings/iommu/iommu.txt
> @@ -86,6 +86,35 @@ have a means to turn off translation. But it is invalid in such cases to
>  disable the IOMMU's device tree node in the first place because it would
>  prevent any driver from properly setting up the translations.
>
> +Optional properties:
> +--------------------
> +- iommu-reserved-mapping: A list of entries describing additional
> +  reserved mapping, that will be inserted to the default IO address space
> +  created for given master device. Each entry consist of IO address,
> +  physical memory address and size of the region.
> +
> +Some devices (like frame buffers) are enabled by bootloader and configured
> +to perform DMA operations automatically (like displaying boot logo or splash
> +screen). Such devices operate and perform DMA operation usually until the
> +proper driver for them is loaded and probed. However before that happens,
> +system usually loads IOMMU drivers and configures dma parameters for each

s/dma/DMA/

> +device. When such initial configuration is created and enabled, it usually
> +contains empty translation rules betweem IO address space and physical

s/betweem/between/

> +memory, because no buffers nor memory regions have been requested by the
> +respective driver.
> +
> +To avoid IOMMU page fault, one can provide "iommu-reserved-mapping"
> +property, which defines all memory regions which must be mapped to IO
> +address space to boot properly when device has been enabled by the
> +bootloader. More than one region can be defined for given master device.
> +Each region is defined by the following triplet: first entry is IO
> +address (encoded in "address" cells), second is base physical memory
> +address for this regions (also encoded in "address" cells) and the last
> +is size of the region (encoded in "size" cells). To ensure that that
> +given master device will not trigger page fault after enabling IOMMU,
> +one should define identity mapping between physical memory and IO
> +address space for the range of addresses accessed by the device.
> +
>
>  Notes:
>  ======
> @@ -113,6 +142,21 @@ Single-master IOMMU:
>                 iommus = <&{/iommu}>;
>         };
>
> +
> +Single-master IOMMU, which has been left enabled by bootloader:
> +---------------------------------------------------------------
> +
> +       iommu {
> +               #iommu-cells = <0>;
> +       };
> +
> +       master {
> +               iommus = <&{/iommu}>;
> +               /* bootloader configures framebuffer at 0x40000000 (32MiB)
> +               iommu-reserved-mapping = <0x40000000 0x40000000 0x2000000>;

Is there not an ordering problem if kernel initializes the IOMMU
before parsing this for each master? I would think the IOMMU driver
needs to find all of these mappings and cleanly switch the page tables
with the new reserved mapping.

Rob
