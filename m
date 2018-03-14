From: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v3 0/5] Add debugfs info for the AMD IOMMU
Date: Wed, 14 Mar 2018 18:04:44 -0500
Message-ID: <152106836233.67212.15861879210675477690.stgit@sosxen2.amd.com>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The following series creates a debugfs directory for AMD IOMMUs,
constructs a framework for additional entries, an online README,
and a method for dumping device table entries. Data is reported
in a default concise mode, but a verbose mode is enabled via a
filesystem entry.

This is the first of three patch series that will expose a number
of IOMMU registers.

Changes since v2:
- Change lock type to a mutex
- Convert a #define to an inline
- Alphabetize #include files
- Remove unnecessary checks for pointers
- Use kstrtoint() instead of sscanf()
- Added comments
- Minor style fixes

Changes since v1:
- Correctly use CONFIG_AMD_IOMMU_DEBUG in Makefile and header file

---

Gary R Hook (5):
      iommu/amd - Add debugfs support
      iommu/amd - Add a 'verbose' switch for IOMMU debugfs
      iommu/amd - Add a README variable for the IOMMU debugfs
      iommu/amd - Expose the active IOMMU device table entries
      iommu/amd - Add a debugfs entry to specify a IOMMU device table entry


 drivers/iommu/Kconfig             |    7 +
 drivers/iommu/Makefile            |    1 
 drivers/iommu/amd_iommu_debugfs.c |  316 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/amd_iommu_init.c    |    6 -
 drivers/iommu/amd_iommu_proto.h   |    7 +
 drivers/iommu/amd_iommu_types.h   |    3 
 6 files changed, 338 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iommu/amd_iommu_debugfs.c

--
