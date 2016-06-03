From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 00/06] iommu/ipmmu-vmsa: IPMMU multi-arch update V3
Date: Fri, 3 Jun 2016 11:04:03 +0200
Message-ID: <CAMuHMdWO4VVXPJTSyzukHeJNdm_JNsdDmRqjCBcTuB3bYb=XJA@mail.gmail.com>
References: <20160602155519.31018.59925.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160602155519.31018.59925.sendpatchset@little-apple>
Sender: linux-kernel-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: iommu@lists.linux-foundation.org, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Joerg Roedel <joro@8bytes.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-renesas-soc@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>, Robin Murphy <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Hi Magnus,

On Thu, Jun 2, 2016 at 5:55 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> iommu/ipmmu-vmsa: IPMMU multi-arch update V3
>
> [PATCH v3 01/06] iommu/ipmmu-vmsa: Remove platform data handling
> [PATCH v3 02/06] iommu/ipmmu-vmsa: Rework interrupt code and use bitmap for context
> [PATCH v3 03/06] iommu/ipmmu-vmsa: Break out utlb parsing code
> [PATCH v3 04/06] iommu/ipmmu-vmsa: Break out domain allocation code
> [PATCH v3 05/06] iommu/ipmmu-vmsa: Add new IOMMU_DOMAIN_DMA ops
> [PATCH v3 06/06] iommu/ipmmu-vmsa: Drop LPAE Kconfig dependency
>
> These patches update the IPMMU driver with a couple of changes
> to support build on multiple architectures. In the process of
> doing so the interrupt code gets reworked and the foundation
> for supporting multiple contexts are added.
>
> In this version of the series the patch order has been reworked
> to make simplify review. Thanks to Laurent for his suggestions!
>
> The 32-bit ARM logic has intentionally been changed as little as possible
> to avoid breakage. Once CONFIG_IOMMU_DMA can be used it may be good time
> to revisit the init ordering for the 32-bit SoCs. There is room for
> improvement for sure like Robin Murphy kindly pointed out.
>
> Changes since V2:
>  - Got rid of patch 3 from the V2 however patch 1, 2 and 4 are kept.
>  - V3 patch 3, 4 and 5 come from
>    [PATCH 00/04] iommu/ipmmu-vmsa: IPMMU CONFIG_IOMMU_DMA update
>  - Patch 5 has been reworked to include patch 3 of the V1 of this series
>
> Changes since V1:
>  - Got rid of patch 2 and 3 from initial series
>  - Updated bitmap code locking and also used lighter bitop functions
>  - Updated the Kconfig bits to apply on top of ARCH_RENESAS
>
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>

Thanks for your series!

For your convenience, I've queued it up in topic/ipmmu-multi-arch-v3 at
https://git.kernel.org/cgit/linux/kernel/git/geert/renesas-drivers.git, and
will include it in next renesas-drivers release.

Gr{oetje,eeting}s,

                        Geert
