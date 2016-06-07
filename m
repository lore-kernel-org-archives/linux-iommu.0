From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 0/3] iommu/ipmmu-vmsa: Initial r8a7796 support
Date: Tue, 7 Jun 2016 09:31:40 +0200
Message-ID: <CAMuHMdVa4S++nY+e6Z=wir28zjjUv-201mLO=gxbWMxurcF3ZA@mail.gmail.com>
References: <20160607033918.28687.98260.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20160607033918.28687.98260.sendpatchset@little-apple>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: iommu@lists.linux-foundation.org, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Joerg Roedel <joro@8bytes.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-renesas-soc@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>
List-Id: iommu@lists.linux-foundation.org

Hi Magnus,

On Tue, Jun 7, 2016 at 5:39 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> iommu/ipmmu-vmsa: Initial r8a7796 support
>
> [PATCH 1/3] iommu/ipmmu-vmsa: Add r8a7796 DT binding
> [PATCH 2/3] iommu/ipmmu-vmsa: Increase maximum micro-TLBS to 48
> [PATCH 3/3] iommu/ipmmu-vmsa: Hook up r8a7796 DT matching code
>
> This series adds r8a7796 support to the IPMMU driver. The DT binding
> gets updated, maximum number of micro-TLBs are increased and the
> driver is adjusted to match on the new DT binding.

Thanks for your series!

For your convenience, I've queued it up in topic/r8a7796-ipmmu-v1 at
https://git.kernel.org/cgit/linux/kernel/git/geert/renesas-drivers.git, and
will include it in next renesas-drivers release.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
