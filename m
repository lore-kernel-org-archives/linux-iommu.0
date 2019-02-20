From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/3] iommu: Kerneldoc improvements
Date: Wed, 20 Feb 2019 14:00:50 +0100
Message-ID: <20190220130053.784-1-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Dmitry Osipenko <digetx@gmail.com>, Baoquan He <bhe@redhat.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: iommu@lists.linux-foundation.org

	Hi Jörg,

This series contains a fix for an incorrect kerneldoc parameter, and
adds the missing kerneldoc for two recently added IOMMU methods.

Thanks!

Geert Uytterhoeven (3):
  iommu: Fix kerneldoc for iommu_ops.flush_iotlb_all()
  iommu: Document iommu_ops.iotlb_sync_map()
  iommu: Document iommu_ops.is_attach_deferred()

 include/linux/iommu.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
