From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [RFC PATCH 0/7] Introduce automatic DMA configuration for IOMMU
	masters
Date: Fri, 29 Aug 2014 16:54:23 +0100
Message-ID: <1409327670-3495-1-git-send-email-will.deacon@arm.com>
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
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi all,

This patch series is an RFC to implement IOMMU master configuration into
of_dma_configure. I haven't yet ported any IOMMU drivers to it, so it
remains untested, but I wanted to get some early feedback to ensure that
this doesn't end up going in the wrong direction.

The idea comes out of my understanding following discussions with Arnd
and David at Kernel Summit / LinuxCon in Chicago. Essentially:

  - Allow IOMMUs to be probed early and set up per-instance data on their
    of_node

  - Add a new callback to the iommu_ops structure for adding a device
    with a set of opaque IDs (e.g. Stream IDs or Requester IDs)

  - Add an of_iommu_configure function, called from of_dma_configure,
    which registers the master IDs with the correspond IOMMU before
    probing the master itself

  - Where applicable, create an IOMMU domain per device and swizzle the
    DMA ops for that device to use the IOMMU variants.

I haven't bothered doing anything clever with the DMA masks yet, so I
wouldn't be surprised if we end up chewing through tonnes of memory
allocating IOMMU domains that are far too big at the moment. Again, this
is just an RFC and I'd welcome comments on the general direction of the
series.

Cheers,

Will

--->8

Will Deacon (7):
  iommu: provide early initialisation hook for IOMMU drivers
  dma-mapping: replace set_arch_dma_coherent_ops with arch_setup_dma_ops
  iommu: add new iommu_ops callback for adding a device with a set of
    IDs
  iommu: provide helper function to configure an IOMMU for an of master
  dma-mapping: detect and configure IOMMU in of_dma_configure
  arm: call iommu_init before of_platform_populate
  arm: dma-mapping: plumb our iommu mapping ops into arch_setup_dma_ops

 arch/arm/include/asm/dma-mapping.h | 10 ++---
 arch/arm/kernel/setup.c            |  5 ++-
 arch/arm/mm/dma-mapping.c          | 77 ++++++++++++++++++++++++++++++++++----
 drivers/iommu/Kconfig              |  2 +-
 drivers/iommu/of_iommu.c           | 50 +++++++++++++++++++++++++
 drivers/of/platform.c              | 53 ++++++++++----------------
 include/asm-generic/vmlinux.lds.h  |  2 +
 include/linux/dma-mapping.h        | 10 ++---
 include/linux/iommu.h              |  2 +
 include/linux/of_iommu.h           | 27 +++++++++++++
 10 files changed, 184 insertions(+), 54 deletions(-)

-- 
2.1.0
