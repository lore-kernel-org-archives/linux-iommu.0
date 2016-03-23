From: Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [Patch V3 0/4] Code refine for Intel IOMMU
Date: Wed, 23 Mar 2016 14:15:45 +0000
Message-ID: <1458742549-28504-1-git-send-email-richard.weiyang@gmail.com>
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
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

These four patches try to refine the Intel IOMMU.                                                                                     
                                                                                                                                      
Patch 1/2 tries to make it more user friendly by add a zero-sized array in                                                            
some dmar data structure.                                                                                                             
Patch 3 move the ckeck of Register Base Address ahead to avoid cleanup when it                                                        
is NULL.                                                                                                                              
Patch 4 re-use dmar_walk_dmar_table() to make the code easy to understand.

V3:
  * change hdr to drhd from type acpi_dmar_header to acpi_dmar_hardware_unit 
  * add reason in changelog for the change in Patch 1

V2:
  * add patch 3 and 4

Wei Yang (4):
  iommu/vt-d: replace *hdr with drhd[0] in struct dmar_drhd_unit
  iommu/vt-d: use zero-sized array in DMAR related ACPI structures
  iommu/vt-d: check Register Base Address at the beginning of
    dmar_parse_one_drhd()
  iommu/vt-d: refine dmar_acpi_dev_scope_init() with
    dmar_walk_dmar_table()

 drivers/iommu/dmar.c                |  129 +++++++++++++++++------------------
 drivers/iommu/intel_irq_remapping.c |   10 ++-
 include/acpi/actbl2.h               |   31 +++++----
 include/linux/dmar.h                |    3 +-
 4 files changed, 87 insertions(+), 86 deletions(-)

-- 
1.7.9.5
