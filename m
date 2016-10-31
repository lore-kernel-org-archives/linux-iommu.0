From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/2] swiotlb: Rate-limit printing and 64-bit memory debugging
Date: Mon, 31 Oct 2016 16:45:02 +0100
Message-ID: <1477928704-10611-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jonathan Corbet <corbet@lwn.net>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, iommu@lists.linux-foundation.org, linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: iommu@lists.linux-foundation.org

	Hi Konrad, Jon,

This patch series contains two improvements for the SWIOTLB subsystem.

The first patch adds rate-limiting to an error message, to avoid
flooding the kernel log.
The second patch adds a kernel command line option to aid debugging when
developing support for DMA to memory outside the 32-bit address space.

Thanks for your comments!

Geert Uytterhoeven (2):
  swiotlb: Rate-limit printing when running out of SW-IOMMU space
  swiotlb: Add swiotlb=nobounce debug option

 Documentation/kernel-parameters.txt |  3 ++-
 lib/swiotlb.c                       | 23 +++++++++++++++++++----
 2 files changed, 21 insertions(+), 5 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
