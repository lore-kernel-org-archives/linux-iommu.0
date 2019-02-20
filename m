From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/7] iommu/ipmmu-vmsa: Suspend/resume support and assorted cleanups
Date: Wed, 20 Feb 2019 16:05:24 +0100
Message-ID: <20190220150531.2462-1-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Magnus Damm <damm+renesas@opensource.se>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, iommu@lists.linux-foundation.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: iommu@lists.linux-foundation.org

	Hi Jörg, Magnus,

On R-Car Gen3 systems with PSCI, PSCI may power down the SoC during
system suspend, thus losing all IOMMU state.  Hence after s2ram, devices
behind an IPMMU (e.g. SATA), and configured to use it, will fail to
complete their I/O operations.

This patch series adds suspend/resume support to the Renesas IPMMU-VMSA
IOMMU driver, and performs some smaller cleanups and fixes during the
process.  Most patches are fairly independent, except for patch 7/7,
which depends on patches 5/7 and 6/7.

This has been tested on Salvator-XS with R-Car H3 ES2.0, with IPMMU
suport for SATA enabled.  To play safe, the resume operation has also
been tested on R-Car M2-W, where it is currently not enabled due to the
absence of PSCI in the firmware.

Thanks for your comments!

Geert Uytterhoeven (7):
  iommu/ipmmu-vmsa: Link IOMMUs and devices in sysfs
  iommu/ipmmu-vmsa: Call ipmmu_ctx_write_root() instead of open coding
  iommu/ipmmu-vmsa: Prepare to handle 40-bit error addresses
  iommu/ipmmu-vmsa: Make IPMMU_CTX_MAX unsigned
  iommu/ipmmu-vmsa: Move num_utlbs to SoC-specific features
  iommu/ipmmu-vmsa: Extract hardware context initialization
  iommu/ipmmu-vmsa: Add suspend/resume support

 drivers/iommu/ipmmu-vmsa.c | 194 +++++++++++++++++++++++++------------
 1 file changed, 131 insertions(+), 63 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
