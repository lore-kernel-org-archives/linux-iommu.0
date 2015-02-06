From: Laura Abbott <lauraa-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH/RFC 0/4] Probe deferral for IOMMU DT integration
Date: Thu,  5 Feb 2015 16:31:58 -0800
Message-ID: <1423182722-16646-1-git-send-email-lauraa@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

On the heels of Exynos integrating SMMU in to the DT for probing,
this series attempts to add support to make SMMU drivers work with
deferred probing. This has been referenced before[1] but this is
some actual code to use as a starting point for discussion.

The requirement for this is based on a previous patch to add clock
support to the ARM SMMU driver[2]. Once we have clock support, it's
possible that the driver itself may need to be defered which breaks
a bunch of assumptions about how SMMU probing is supposed to work.
The concept here is to have the driver call of_dma_configure which
may return -EPROBE_DEFER. of_dma_configure could possibly be moved
up to probe level. The existing method of initialization still needs
to be done as well which might mean we have the worst of both worlds.

Open questions:
- This still doesn't really address Arnd's concerns[3] about disabling
IOMMUs
- Currently tested where we knew the driver was going to be deferring.
Probably need some logic for calling of_dma_configure again.

This is based on Robin Murphy's work for dma mapping[4] and a few
patches from Murali Kaicheri[5] for of_dma_configure.


[1] http://lists.linuxfoundation.org/pipermail/iommu/2015-January/011764.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-August/279036.html
[3] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/311579.html
[4] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/315459.html
[5] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/319390.html

Laura Abbott (3):
  dma-mapping: Make arch_setup_dma_ops return an error code
  of: Return error codes from of_dma_configure
  iommu/arm-smmu: Support deferred probing

Mitchel Humpherys (1):
  iommu/arm-smmu: add support for specifying clocks

 arch/arm/include/asm/dma-mapping.h   |   2 +-
 arch/arm/mm/dma-mapping.c            |   4 +-
 arch/arm64/include/asm/dma-mapping.h |   2 +-
 arch/arm64/mm/dma-mapping.c          |  16 +--
 drivers/iommu/arm-smmu.c             | 186 +++++++++++++++++++++++++++++++++--
 drivers/iommu/iommu.c                |  49 ++++++++-
 drivers/iommu/of_iommu.c             |  14 ++-
 drivers/of/device.c                  |   9 +-
 include/linux/dma-mapping.h          |   7 +-
 include/linux/iommu.h                |   2 +
 include/linux/of_device.h            |   4 +-
 11 files changed, 268 insertions(+), 27 deletions(-)

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
