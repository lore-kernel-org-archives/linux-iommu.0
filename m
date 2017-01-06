From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH V9 0/9] Add support for privileged mappings
Date: Fri,  6 Jan 2017 18:58:07 +0530
Message-ID: <1483709296-32761-1-git-send-email-sricharan@codeaurora.org>
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
To: jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, pdaly-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, jgebben-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pratikp-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, tzeng-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This series is a resend of the V5 that Mitch sent sometime back [2]
All the patches are the same and i have just rebased. Redid patch [3],
as it does not apply in this code base. Added a couple of more patches
[4], [5] from Robin for adding the privileged attributes to armv7s format
and arm-smmuv3 revert. Added a patch for passing in the privileged
attributes from arm32 dma-mapping apis as well.

The following patch to the ARM SMMU driver:

    commit d346180e70b91b3d5a1ae7e5603e65593d4622bc
    Author: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
    Date:   Tue Jan 26 18:06:34 2016 +0000
    
        iommu/arm-smmu: Treat all device transactions as unprivileged

started forcing all SMMU transactions to come through as "unprivileged".
The rationale given was that:

  (1) There is no way in the IOMMU API to even request privileged
      mappings.

  (2) It's difficult to implement a DMA mapper that correctly models the
      ARM VMSAv8 behavior of unprivileged-writeable =>
      privileged-execute-never.

This series rectifies (1) by introducing an IOMMU API for privileged
mappings and implements it in io-pgtable-arm.

This series rectifies (2) by introducing a new dma attribute
(DMA_ATTR_PRIVILEGED) for users of the DMA API that need privileged
mappings which are inaccessible to lesser-privileged execution levels, and
implements it in the arm64 IOMMU DMA mapper.  The one known user (pl330.c)
is converted over to the new attribute.

Jordan and Jeremy can provide more info on the use case if needed, but the
high level is that it's a security feature to prevent attacks such as [1].

Note that, i tested this on arm64 with arm-smmuv2, short descriptor changes,
tested this on arm32 platform as well and do not have an platform to test
this with arm-smmuv3.

[1] https://github.com/robclark/kilroy
[2] https://lkml.org/lkml/2016/7/27/590
[3] https://patchwork.kernel.org/patch/9250493/
[4] http://www.linux-arm.org/git?p=linux-rm.git;a=commit;h=1291bd74f05d31da1dab3df02987cba5bd25849b
[5] http://www.linux-arm.org/git?p=linux-rm.git;a=commit;h=a79c1c6333f26849dba418cd92de26b60f5954f3

Changelog:
 v8..v9
    - Added additional comment in patch 1 and added tag for patch 6.

 v7..v8
    - Added a patch for passing in the privileged attributes from arm32
      dma-mapping apis as well.

 v6..v7
    - Added couple of more patches, picked up acks, updated commit log

 v5..v6
    - Rebased all the patches and redid 6/6 as it does not apply in
      this code base. 

 v4..v5
    - Simplified patch 4/6 (suggested by Robin Murphy).

 v3..v4
    - Rebased and reworked on linux next due to the dma attrs rework going
      on over there.  Patches changed: 3/6, 4/6, and 5/6.

 v2..v3
    - Incorporated feedback from Robin:
      * Various comments and re-wordings.
      * Use existing bit definitions for IOMMU_PRIV implementation
        in io-pgtable-arm.
      * Renamed and redocumented dma_direction_to_prot.
      * Don't worry about executability in new DMA attr.

 v1..v2
    - Added a new DMA attribute to make executable privileged mappings
      work, and use that in the pl330 driver (suggested by Will).

Jeremy Gebben (1):
  iommu/io-pgtable-arm: add support for the IOMMU_PRIV flag

Mitchel Humpherys (4):
  iommu: add IOMMU_PRIV attribute
  common: DMA-mapping: add DMA_ATTR_PRIVILEGED attribute
  arm64/dma-mapping: Implement DMA_ATTR_PRIVILEGED
  dmaengine: pl330: Make sure microcode is privileged

Robin Murphy (2):
  iommu/io-pgtable-arm-v7s: Add support for the IOMMU_PRIV flag
  Revert "iommu/arm-smmu: Set PRIVCFG in stage 1 STEs"

Sricharan R (2):
  arm/dma-mapping: Implement DMA_ATTR_PRIVILEGED
  iommu/arm-smmu: Set privileged attribute to 'default' instead of
    'unprivileged'

 Documentation/DMA-attributes.txt   | 10 +++++++
 arch/arm/mm/dma-mapping.c          | 60 +++++++++++++++++++-------------------
 arch/arm64/mm/dma-mapping.c        |  6 ++--
 drivers/dma/pl330.c                |  5 ++--
 drivers/iommu/arm-smmu-v3.c        |  7 +----
 drivers/iommu/arm-smmu.c           |  2 +-
 drivers/iommu/dma-iommu.c          | 12 ++++++--
 drivers/iommu/io-pgtable-arm-v7s.c |  6 +++-
 drivers/iommu/io-pgtable-arm.c     |  5 +++-
 include/linux/dma-iommu.h          |  3 +-
 include/linux/dma-mapping.h        |  7 +++++
 include/linux/iommu.h              |  7 +++++
 12 files changed, 82 insertions(+), 48 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
