From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/2] iommu/ipmmu-vmsa: Hook up r8a779(70|95) DT matching code
Date: Tue, 7 Nov 2017 09:31:15 +0100
Message-ID: <CAMuHMdWpSTh=dsVjUPdVsiKTPytb0HHjh_zCDSRjk+1t4uG4dA@mail.gmail.com>
References: <20171101103423.7334-1-horms+renesas@verge.net.au> <20171101103423.7334-3-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20171101103423.7334-3-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Joerg Roedel <joro@8bytes.org>, Magnus Damm <magnus.damm@gmail.com>, iommu@lists.linux-foundation.org, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Nov 1, 2017 at 11:34 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Support the r8a77970 (R-Car V3M) and r8a77995 (R-Car D3) IPMMUs by sharing
> feature flags with r8a7795 (R-Car H3) and r8a7796 (R-Car M3-W). Also update
> IOMMU_OF_DECLARE to hook up the compat strings.
>
> Based on work for the r8a7796 by Magnus Damm
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
