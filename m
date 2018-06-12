From: Gary R Hook <gary.hook@amd.com>
Subject: [PATCH v9 0/2] Base enablement of IOMMU debugfs support
Date: Tue, 12 Jun 2018 16:41:12 -0500
Message-ID: <152883965482.1936.13657625103232933481.stgit@taos>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

These patches create a top-level function, called at IOMMU
initialization, to create a debugfs directory for the IOMMU.
Under this directory drivers may create and populate
vendor-specific directories for their device internals.

Patch 1: general IOMMU enablement
Patch 2: basic AMD enablement to demonstrate linkage with patch 1

Introduce a new Kconfig parameter IOMMU_DEBUGFS to globally allow/disallow debugfs code to be built.

The Makefile structure is intended to allow the use of a single switch for turning on DebugFS.

Changes since v8:
 - Change Kconfig to use both an IOMMU boolean and a vendor-specific
   boolean; ensure big warning messages
 - Make the function that creates a vendor directory more concise

Changes since v7:
 - Change the Kconfig approach to use a hidden boolean for a
   specific device
 - Change some #ifdefs to reference the new boolean

Changes since v6:
 - Rely on default Kconfig value for a bool
 - comment/doc fixes
 - use const where appropriate
 - fix inline declaration

Changes since v5:
 - Added parameters names in declarations/definitions
 - Reformatted an inline definition

Changes since v4:
 - Guard vendor-specific debugfs files in the Makefile
 - Call top-level routine from iommu_init()
 - Add function for instantiating a driver-specific directory
 - Change AMD driver code to use this new format

Changes since v3:
 - Remove superfluous calls to debugfs_initialized()
 - Emit a warning exactly one time
 - Change the Kconfig name to IOMMU_DEBUGFS
 - Change the way debugfs modules are made

Changes since v2:
 - Move a declaration to outside an ifdef
 - Remove a spurious blank line

Changes since v1:
 - Remove debug cruft
 - Remove cruft produced by design change
 - Change the lock to a mutex
 - Coding style fixes
 - Add a comment to document the framework

---

Gary R Hook (2):
      iommu - Enable debugfs exposure of IOMMU driver internals
      iommu/amd: Add basic debugfs infrastructure for AMD IOMMU


 drivers/iommu/Kconfig             |   22 ++++++++++++
 drivers/iommu/Makefile            |    2 +
 drivers/iommu/amd_iommu_debugfs.c |   33 +++++++++++++++++++
 drivers/iommu/amd_iommu_init.c    |    6 ++-
 drivers/iommu/amd_iommu_proto.h   |    6 +++
 drivers/iommu/amd_iommu_types.h   |    5 +++
 drivers/iommu/iommu-debugfs.c     |   66 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/iommu.c             |    2 +
 include/linux/iommu.h             |    7 ++++
 9 files changed, 147 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iommu/amd_iommu_debugfs.c
 create mode 100644 drivers/iommu/iommu-debugfs.c

--
