From: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: [RFC/PATCH 0/9] IOMMU probe deferral support
Date: Fri, 15 May 2015 02:00:01 +0300
Message-ID: <1431644410-2997-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
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
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Laura Abbott <lauraa-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hello,

This patch series attempts to implement support for deferring probe of both
IOMMU drivers and bus master drivers.

The relationship between bus masters and IOMMUs creates a strong ordering
during initialization of devices. As in the general case IOMMUs are hidden
behind the DMA mapping API, IOMMU support relies on the automatic setup of DMA
operations without any direct intervention of bus master drivers.

DMA operations are set up when platform devices are added to the system. This
requires IOMMUs to be available at that time. On systems where ordering of
device add and probe can't be guaranteed (such as, but not limited to,
DT-based systems) this caused incorrect DMA operation setup. This has been
addressed by a patches series [1] that introduced a DT-based early
registration mechanism for IOMMUs.

However, that mechanism fails to address all issues. Various dependencies
exist between IOMMU devices and other devices, in particular on clocks and on
power domains (as mentioned by Marek in [2]). While there are mechanisms to
handle some of them without probe deferral (for instance by using the
OF_DECLARE macros to register clock drivers), generalizing those mechanisms
would essentially recreate a probe ordering mechanism similar to link order
probe ordering and couldn't really scale.

Additionally, IOMMUs could also be present hot-pluggable devices and depend on 
resources that are thus hot-plugged. OF_DECLARE wouldn't help in that case. 
For all those reasons probe deferral for IOMMUs has been considered as desired
if it can be implemented cleanly. For more in-depth information see [3].

This RFC series is a first attempt at implementing IOMMU probe deferral
support cleanly.

The core idea is to move setup of DMA operations from device add time to
device probe time, implemented in patch 6/9. It could be possible to move
setup of other DMA parameters (namely masks and offset) to probe time as well,
but that change would be more intrusive and has a higher risk of introducing
regressions. For that reason I've decided to keep DMA masks and offset setup
at device add time and thus split DMA configuration in masks and operations
(patch 5/9). This can be revisited if we decide that the DMA mapping API
shouldn't require masks and offset to be set before probe time.

Patch 8/9 then defers probe of bus master drivers when required IOMMUs are not
available yet. This requires knowing when a failed IOMMU lookup should be
considered as permanent or temporary. I've reused the OF_DECLARE_IOMMU for
this purpose, considering that the presence of a driver compatible with the
IOMMU DT node indicates that the failure is temporary and probing of the bus
master device should be deferred.

Note that only IOMMU drivers using the recent .of_xlate() mechanism for
DT-based IOMMU reference can cause probe deferral of bus master devices. The
.add_device() mechanism isn't supported in this case.

As an example I've converted the ipmmu-vmsa driver to the new API in patch 9/9.

At this point many enhancements are possible, but I'd like to receive feedback
on the proposed approach before basing more patches on this series. One
particular point I would like to address (or see being addressed) in the
future is the use of struct iommu_ops with of_iommu_get_ops() and
of_iommu_set_ops(). I believe we should introduct a struct iommu and register
IOMMU instances instead of IOMMU operations. That should bring us one step
closer to removing bus_set_iommu().

[1] http://www.spinics.net/lists/arm-kernel/msg382787.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-February/323238.html
[3] https://lkml.org/lkml/2015/2/16/345

Laurent Pinchart (9):
  arm: dma-mapping: Don't override dma_ops in arch_setup_dma_ops()
  arm: dma-mapping: Support IOMMU mappings spanning the full 32 bits
    range
  of: dma: Move range size workaround to of_dma_get_range()
  of: dma: Make of_dma_deconfigure() public
  of: dma: Split of_configure_dma() into mask and ops configuration
  drivers: platform: Configure dma operations at probe time
  iommu: of: Document the of_iommu_configure() function
  iommu: of: Handle IOMMU lookup failure with deferred probing or error
  iommu/ipmmu-vmsa: Use DT-based instantiation

 arch/arm/include/asm/dma-iommu.h |   2 +-
 arch/arm/mm/dma-mapping.c        |  21 +++--
 drivers/base/platform.c          |   9 ++
 drivers/iommu/ipmmu-vmsa.c       | 189 +++++++++++++--------------------------
 drivers/iommu/of_iommu.c         |  29 +++++-
 drivers/of/address.c             |  20 ++++-
 drivers/of/device.c              |  77 ++++++++++------
 drivers/of/of_pci.c              |   3 +-
 drivers/of/platform.c            |  16 ++--
 include/linux/of_device.h        |  14 ++-
 10 files changed, 195 insertions(+), 185 deletions(-)

-- 
Regards,

Laurent Pinchart
