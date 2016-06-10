From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v4 00/07] iommu/ipmmu-vmsa: IPMMU multi-arch update V4
Date: Fri, 10 Jun 2016 08:55:58 +0200
Message-ID: <CAMuHMdVuvg+hUL32SxXaqxXiPV=ZnRPuCLrm8CoW+1TZe-jT=g@mail.gmail.com>
References: <20160608071737.7560.32571.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20160608071737.7560.32571.sendpatchset@little-apple>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: iommu@lists.linux-foundation.org, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Joerg Roedel <joro@8bytes.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-renesas-soc@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>, Robin Murphy <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Hi Magnus,

On Wed, Jun 8, 2016 at 9:17 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> iommu/ipmmu-vmsa: IPMMU multi-arch update V4
>
> [PATCH v4 01/07] iommu/ipmmu-vmsa: Remove platform data handling
> [PATCH v4 02/07] iommu/ipmmu-vmsa: Rework interrupt code and use bitmap for context
> [PATCH v4 03/07] iommu/ipmmu-vmsa: Break out utlb parsing code
> [PATCH v4 04/07] iommu/ipmmu-vmsa: Break out domain allocation code
> [PATCH v4 05/07] iommu/ipmmu-vmsa: Add new IOMMU_DOMAIN_DMA ops
> [PATCH v4 06/07] iommu/ipmmu-vmsa: ARM and ARM64 archdata access
> [PATCH v4 07/07] iommu/ipmmu-vmsa: Drop LPAE Kconfig dependency
>
> These patches update the IPMMU driver with a couple of changes
> to support build on multiple architectures. In the process of
> doing so the interrupt code gets reworked and the foundation
> for supporting multiple contexts are added.

Thanks for your series!

For your convenience, I've queued it up in topic/ipmmu-multi-arch-v4 at
https://git.kernel.org/cgit/linux/kernel/git/geert/renesas-drivers.git, and
will include it in next renesas-drivers release.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
