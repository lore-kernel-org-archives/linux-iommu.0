From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 00/11] iommu/ipmmu-vmsa: r8a7795 support V2
Date: Mon, 6 Jun 2016 09:05:32 +0200
Message-ID: <CAMuHMdV7KbgO9Q8JUZotgqFAehZHMxxi9OVbJGavfrdeSWC9xg@mail.gmail.com>
References: <20160606035723.31763.66500.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20160606035723.31763.66500.sendpatchset@little-apple>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: iommu@lists.linux-foundation.org, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Joerg Roedel <joro@8bytes.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-renesas-soc@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>
List-Id: iommu@lists.linux-foundation.org

Hi Magnus,

On Mon, Jun 6, 2016 at 5:57 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> iommu/ipmmu-vmsa: r8a7795 support V2
>
> [PATCH v2 01/11] iommu/ipmmu-vmsa: Introduce features, break out alias
> [PATCH v2 02/11] iommu/ipmmu-vmsa: Add optional root device feature
> [PATCH v2 03/11] iommu/ipmmu-vmsa: Enable multi context support
> [PATCH v2 04/11] iommu/ipmmu-vmsa: Reuse iommu groups
> [PATCH v2 05/11] iommu/ipmmu-vmsa: Make use of IOMMU_OF_DECLARE()
> [PATCH v2 06/11] iommu/ipmmu-vmsa: Teach xlate() to skip disabled iommus
> [PATCH v2 07/11] iommu/ipmmu-vmsa: IPMMU device is 64-bit bus master
> [PATCH v2 08/11] iommu/ipmmu-vmsa: Write IMCTR twice
> [PATCH v2 09/11] iommu/ipmmu-vmsa: Make IMBUSCTR setup optional
> [PATCH v2 10/11] iommu/ipmmu-vmsa: Allow two bit SL0
> [PATCH v2 11/11] iommu/ipmmu-vmsa: Hook up r8a7795 DT matching code

Thanks for your series!

For your convenience, I've queued it up in topic/r8a7795-ipmmu-v2 at
https://git.kernel.org/cgit/linux/kernel/git/geert/renesas-drivers.git, and
will include it in next renesas-drivers release.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
