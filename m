From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 0/9] AMD IOMMU cleanups, fixes and IVRS bug workarounds
Date: Tue,  9 Apr 2013 22:12:55 +0200
Message-ID: <1365538384-12426-1-git-send-email-joro@8bytes.org>
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

Hi,

this patch-set contains some cleanups and patches for the
AMD IOMM driver. The most important part is a workaround
that can be used to get interrupt remapping working even the
the IVRS table provided by the BIOS is broken.


	Joerg

Joerg Roedel (9):
  iommu/amd: Remove map_sg_no_iommu()
  iommu/amd: Use AMD specific data structure for irq remapping
  iommu/amd: Properly initialize irq-table lock
  iommu/amd: Move add_special_device() to __init
  iommu/amd: Extend IVRS special device data structure
  iommu/amd: Add early maps for ioapic and hpet
  iommu/amd: Add ioapic and hpet ivrs override
  iommu/amd: Don't report firmware bugs with cmd-line ivrs overrides
  iommu/amd: Document ivrs_ioapic and ivrs_hpet parameters

 Documentation/kernel-parameters.txt |   14 ++++
 drivers/iommu/amd_iommu.c           |   79 +++++++-----------
 drivers/iommu/amd_iommu_init.c      |  151 +++++++++++++++++++++++++++++++----
 drivers/iommu/amd_iommu_types.h     |    1 +
 4 files changed, 182 insertions(+), 63 deletions(-)

-- 
1.7.9.5
